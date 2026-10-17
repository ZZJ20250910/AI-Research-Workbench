[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$DoFile,

    [ValidateRange(1, 2147483)]
    [int]$TimeoutSeconds = 600,

    [string]$StataExe = '',
    [string]$SummaryFile = '',
    [string]$ErrorExcerptFile = ''
)

$ErrorActionPreference = 'Stop'

$resolvedDo = (Resolve-Path -LiteralPath $DoFile).Path
$workingDirectory = [IO.Path]::GetDirectoryName($resolvedDo)
$fileName = [IO.Path]::GetFileName($resolvedDo)
$logFile = [IO.Path]::ChangeExtension($resolvedDo, '.log')
$doText = [IO.File]::ReadAllText($resolvedDo)

$activeLines = @(
    $doText -split "`r?`n" |
        Where-Object {
            $line = $_.Trim()
            $line -and -not $line.StartsWith('*') -and -not $line.StartsWith('//')
        }
)
$logConflict = $activeLines | Where-Object {
    $_ -match '(?i)(^|\s)(capture\s+)?log\s+(using|close)(\s|,|$)'
} | Select-Object -First 1
if ($logConflict) {
    throw 'The do-file contains log using/log close. Logs are managed exclusively by run-stata.ps1; remove those commands before running.'
}

# Stata 17 on this Windows host expects the active ANSI code page for Chinese text
# and can misdecode both UTF-8 (with or without BOM) and non-ASCII do-file names.
# Keep the original working directory so relative project paths remain unchanged.
$compatibilityMode = ($resolvedDo -match '[^\x00-\x7F]') -or ($doText -match '[^\x00-\x7F]')
$executionDo = $resolvedDo
$executionLog = $logFile
if ($compatibilityMode) {
    $compatBase = 'codexstata_' + [Guid]::NewGuid().ToString('N')
    $executionDo = [IO.Path]::Combine($workingDirectory, $compatBase + '.do')
    $executionLog = [IO.Path]::ChangeExtension($executionDo, '.log')
    [IO.File]::WriteAllText($executionDo, $doText, [Text.Encoding]::Default)
    $fileName = [IO.Path]::GetFileName($executionDo)
}

if (-not $SummaryFile) {
    $SummaryFile = [IO.Path]::Combine(
        $workingDirectory,
        ([IO.Path]::GetFileNameWithoutExtension($resolvedDo) + '.run-summary.json')
    )
}
if (-not $ErrorExcerptFile) {
    $ErrorExcerptFile = [IO.Path]::Combine(
        $workingDirectory,
        ([IO.Path]::GetFileNameWithoutExtension($resolvedDo) + '.error-excerpt.txt')
    )
}

if (-not $StataExe) {
    $pathCandidates = @(
        'StataMP-64.exe', 'StataSE-64.exe', 'StataBE-64.exe',
        'StataMP.exe', 'StataSE.exe', 'StataBE.exe', 'stata.exe'
    )
    foreach ($candidate in $pathCandidates) {
        $command = Get-Command $candidate -ErrorAction SilentlyContinue
        if ($command) {
            $StataExe = $command.Source
            break
        }
    }
}

if (-not $StataExe) {
    $fileCandidates = @(
        'E:\Program Files\Stata17\StataMP-64.exe',
        'C:\Program Files\Stata19\StataMP-64.exe',
        'C:\Program Files\Stata18\StataMP-64.exe',
        'C:\Program Files\Stata17\StataMP-64.exe',
        'C:\Program Files\Stata18\StataSE-64.exe',
        'C:\Program Files\Stata17\StataSE-64.exe'
    )
    $StataExe = $fileCandidates |
        Where-Object { Test-Path -LiteralPath $_ } |
        Select-Object -First 1
}

if (-not $StataExe -or -not (Test-Path -LiteralPath $StataExe -PathType Leaf)) {
    throw 'No Stata executable was found.'
}

$startedAt = Get-Date
$stopwatch = [Diagnostics.Stopwatch]::StartNew()
$process = Start-Process `
    -FilePath $StataExe `
    -ArgumentList @('/q', '/e', 'do', ('"{0}"' -f $fileName)) `
    -WorkingDirectory $workingDirectory `
    -WindowStyle Hidden `
    -PassThru

$timedOut = -not $process.WaitForExit($TimeoutSeconds * 1000)
if ($timedOut) {
    $process.Kill()
    $process.WaitForExit()
}
$stopwatch.Stop()

if ($compatibilityMode -and (Test-Path -LiteralPath $executionLog -PathType Leaf)) {
    Move-Item -LiteralPath $executionLog -Destination $logFile -Force
}
if ($compatibilityMode -and (Test-Path -LiteralPath $executionDo -PathType Leaf)) {
    Remove-Item -LiteralPath $executionDo -Force
}

$exitCode = $process.ExitCode
$logExists = Test-Path -LiteralPath $logFile -PathType Leaf
$logIsCurrent = $false
$logText = ''
if ($logExists) {
    $logItem = Get-Item -LiteralPath $logFile
    $logIsCurrent = $logItem.LastWriteTime -ge $startedAt.AddSeconds(-2)
    $logText = Get-Content -LiteralPath $logFile -Raw
}

$complete = $logIsCurrent -and $logText.Contains('CODEX_STATA_COMPLETE=1')
$partialFailures = $null
if ($logText) {
    $partialMatches = [regex]::Matches($logText, '(?im)CODEX_PARTIAL_FAILURES\s*=\s*(\d+)')
    if ($partialMatches.Count -gt 0) {
        $partialFailures = [int]$partialMatches[$partialMatches.Count - 1].Groups[1].Value
    }
}
$errorMatches = @()
$warningMatches = @()
if ($logText) {
    $errorMatches = @([regex]::Matches(
        $logText,
        '(?im)^\s*r\((\d+)\);\s*$|variable .+ not found|no observations|insufficient observations|convergence not achieved'
    ))
    $warningMatches = @([regex]::Matches(
        $logText,
        '(?im)note:.+(omitted|collinear)|warning:|convergence not achieved|variance matrix is nonsymmetric or highly singular'
    ))
}

$status = if (-not $timedOut -and $exitCode -eq 0 -and $complete) { 'success' } else { 'failed' }

if ($status -eq 'failed') {
    $lines = @($logText -split "`r?`n")
    $selected = New-Object System.Collections.Generic.List[string]
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '(?i)^\s*r\(\d+\);\s*$|variable .+ not found|no observations|insufficient observations|convergence not achieved') {
            $from = [Math]::Max(0, $i - 3)
            $to = [Math]::Min($lines.Count - 1, $i + 3)
            for ($j = $from; $j -le $to; $j++) {
                if (-not $selected.Contains($lines[$j])) { $selected.Add($lines[$j]) }
            }
        }
    }
    if ($selected.Count -eq 0 -and $lines.Count -gt 0) {
        $from = [Math]::Max(0, $lines.Count - 80)
        for ($j = $from; $j -lt $lines.Count; $j++) { $selected.Add($lines[$j]) }
    }
    $selected | Select-Object -First 80 | Set-Content -LiteralPath $ErrorExcerptFile -Encoding UTF8
}
elseif (Test-Path -LiteralPath $ErrorExcerptFile) {
    Remove-Item -LiteralPath $ErrorExcerptFile -Force
}

$errorCodes = @()
if ($logText) {
    $errorCodes = @(
        [regex]::Matches($logText, '(?im)^\s*r\((\d+)\);\s*$') |
            ForEach-Object { $_.Groups[1].Value } |
            Select-Object -Unique
    )
}

$summary = [ordered]@{
    status = $status
    do_file = $resolvedDo
    compatibility_mode = $compatibilityMode
    compatibility_strategy = if ($compatibilityMode) { 'ascii-name-system-codepage-copy-in-original-directory' } else { 'none' }
    stata_exe = $StataExe
    process_id = $process.Id
    started_at = $startedAt.ToString('o')
    ended_at = (Get-Date).ToString('o')
    elapsed_seconds = [Math]::Round($stopwatch.Elapsed.TotalSeconds, 3)
    timeout_seconds = $TimeoutSeconds
    timed_out = $timedOut
    exit_code = $exitCode
    log_file = $logFile
    log_exists = $logExists
    log_is_current = $logIsCurrent
    completion_marker = $complete
    error_count = $errorMatches.Count
    warning_count = $warningMatches.Count
    partial_failures = $partialFailures
    error_codes = $errorCodes
    error_excerpt_file = if ($status -eq 'failed') { $ErrorExcerptFile } else { $null }
}

$summary | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $SummaryFile -Encoding UTF8
$excerptValue = if ($status -eq 'failed') { $ErrorExcerptFile } else { 'none' }
$partialValue = if ($null -eq $partialFailures) { 'unknown' } else { $partialFailures }
Write-Output ("STATA_DONE status={0} elapsed_seconds={1} timed_out={2} exit_code={3} completion_marker={4} errors={5} warnings={6} partial_failures={7} summary={8} excerpt={9}" -f `
    $status, $summary.elapsed_seconds, $timedOut, $exitCode, $complete, $errorMatches.Count, $warningMatches.Count, $partialValue, $SummaryFile, $excerptValue)

if ($status -ne 'success') { exit 1 }
