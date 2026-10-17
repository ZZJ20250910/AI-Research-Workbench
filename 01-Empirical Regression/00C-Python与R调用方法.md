# 00C Python 与 R 调用方法

仅在用户选中的代码段包含 Python 或 R 时读取。所有脚本、日志、环境信息和输出都写入当前阶段 Temp，并遵守 `00B-正式运行前确认.md` 的依赖预检、占位符门禁、`00-执行状态.md` 检查点和中断恢复规则。

## 一、Python

### 解释器和依赖预检

按顺序选择第一个能正常返回版本的解释器：当前项目已经登记的解释器、`py -3`、`python`。在 Plan 写入最终解释器绝对路径和 `python --version`。对选中代码的每个 import 单独运行：

```powershell
& $pythonExe -c "import 包名; print(getattr(包名, '__version__', 'version-unavailable'))"
```

任何 import 失败都在确认卡中列明；未获得用户安装授权时不执行 `pip`、`conda` 或环境修改。

### 脚本要求

脚本末尾必须写：

```python
print("CODEX_PYTHON_COMPLETE=1", flush=True)
```

固定随机种子，并把数据划分、fold、线程数、包版本和输出路径写入脚本或环境记录。输入文件只读，所有写出路径明确指向当前阶段 Temp。

### Windows 非交互调用

```powershell
$script = '当前阶段Temp绝对路径\脚本名.py'
$timeoutSeconds = 7200
$resolvedScript = (Resolve-Path -LiteralPath $script).Path
$workDir = [IO.Path]::GetDirectoryName($resolvedScript)
$stdout = Join-Path $workDir 'python-stdout.log'
$stderr = Join-Path $workDir 'python-stderr.log'

$process = Start-Process -FilePath $pythonExe `
    -ArgumentList @($resolvedScript) `
    -WorkingDirectory $workDir `
    -WindowStyle Hidden -PassThru `
    -RedirectStandardOutput $stdout -RedirectStandardError $stderr

$timedOut = -not $process.WaitForExit($timeoutSeconds * 1000)
if ($timedOut) { $process.Kill(); $process.WaitForExit() }
$exitCode = $process.ExitCode
$stdoutText = if (Test-Path -LiteralPath $stdout) { Get-Content -LiteralPath $stdout -Raw } else { '' }
$stderrText = if (Test-Path -LiteralPath $stderr) { Get-Content -LiteralPath $stderr -Raw } else { '' }
$complete = $stdoutText.Contains('CODEX_PYTHON_COMPLETE=1')

if ($timedOut -or $exitCode -ne 0 -or -not $complete) {
    throw "Python运行失败：timeout=$timedOut exit=$exitCode complete=$complete"
}
```

抛错前已经读取 stdout/stderr；随后把错误和最后检查点写入 `00-执行状态.md`。

## 二、R

### 解释器和依赖预检

用 `Get-Command Rscript` 或 00D 已登记路径定位 `Rscript`，记录绝对路径和 `Rscript --version`。每个包运行：

```powershell
& $rscriptExe -e "if (!requireNamespace('包名', quietly=TRUE)) quit(status=2); cat(as.character(packageVersion('包名')))"
```

缺包时按 00B 让用户选择安装、跳过或替代；不得静默安装 CRAN/GitHub 包。

### 脚本要求与调用

脚本末尾必须写：

```r
writeLines(capture.output(sessionInfo()), "R-session-info.txt")
cat("CODEX_R_COMPLETE=1\n")
```

Windows 调用：

```powershell
$script = '当前阶段Temp绝对路径\脚本名.R'
$timeoutSeconds = 7200
$resolvedScript = (Resolve-Path -LiteralPath $script).Path
$workDir = [IO.Path]::GetDirectoryName($resolvedScript)
$stdout = Join-Path $workDir 'R-stdout.log'
$stderr = Join-Path $workDir 'R-stderr.log'

$process = Start-Process -FilePath $rscriptExe `
    -ArgumentList @($resolvedScript) -WorkingDirectory $workDir `
    -WindowStyle Hidden -PassThru `
    -RedirectStandardOutput $stdout -RedirectStandardError $stderr
$timedOut = -not $process.WaitForExit($timeoutSeconds * 1000)
if ($timedOut) { $process.Kill(); $process.WaitForExit() }
$exitCode = $process.ExitCode
$stdoutText = if (Test-Path -LiteralPath $stdout) { Get-Content -LiteralPath $stdout -Raw } else { '' }
$stderrText = if (Test-Path -LiteralPath $stderr) { Get-Content -LiteralPath $stderr -Raw } else { '' }
$complete = $stdoutText.Contains('CODEX_R_COMPLETE=1')
if ($timedOut -or $exitCode -ne 0 -or -not $complete) {
    throw "R运行失败：timeout=$timedOut exit=$exitCode complete=$complete"
}
```

## 三、采用与恢复

每完成一个 Python/R 脚本，立即更新 `00-执行状态.md` 和项目进度锚点。中断恢复时先读取 stdout、stderr、session/environment 记录和输出清单；完成标记、退出码和输出三者同时有效才记为成功。用户确认采用后按 00B 的版本化命名复制到 Reg/Result，Temp 历史不删除。

