# 00C Stata 统一执行方式

本文件适用于 `01-Empirical Regression` 的全部 Stata 任务，包括标准实证流程01—08和直接执行模式。任何 `.do` 文件都只能通过能力包根目录 `scripts/run-stata.ps1` 运行；不得自行另写启动、轮询、等待或日志读取逻辑。

## 一、核心原则

1. AI负责写好do-file并发起一次执行；PowerShell执行器负责启动Stata、等待进程结束、处理超时、核验完成标记和生成精简摘要。
2. Stata运行期间不读取log、不查询PID、不执行`Get-Process`、不启动第二个监听器，也不要求用户提醒。
3. 如果工具返回“仍在运行”或运行单元ID，只继续等待同一个运行单元；不得新建命令检查Stata是否结束。
4. Stata结束后先读取精简摘要和用户需要的结构化结果。成功时不把完整log读入上下文；失败时先读错误摘录，仍无法定位时才读取完整log。
5. 不使用全局`taskkill`，不影响用户打开的其他Stata。超时只结束本次执行器启动的进程。
6. 同一任务的多个规格尽量放在一个do-file中一次运行、一次读取数据；不得为每个规格分别启动Stata。

## 二、唯一执行器

固定位置：

```text
能力包根目录/scripts/run-stata.ps1
```

执行器接收：

- `DoFile`：待运行do-file的绝对路径；
- `TimeoutSeconds`：本次超时秒数；
- `StataExe`：可选，本机Stata可执行文件；不提供时由脚本自动查找；
- `SummaryFile`：可选，运行摘要路径；默认与do-file同目录、同名加`.run-summary.json`。

标准调用（当前PowerShell会话直接调用，不再启动第二层PowerShell）：

```powershell
$runner = '能力包根目录\scripts\run-stata.ps1'
$doFile = '项目Temp目录\本轮代码.do'
& $runner -DoFile $doFile -TimeoutSeconds 600
```

只有本机执行策略阻止直接调用脚本时，才使用`powershell -NoProfile -ExecutionPolicy Bypass -File ...`作为兼容后备；不得默认多启动一层PowerShell。

执行器在任务结束前不输出过程日志。最终只返回一行：

```text
STATA_DONE status=success elapsed_seconds=... timed_out=False exit_code=0 completion_marker=True errors=0 warnings=... summary=... excerpt=none
```

或：

```text
STATA_DONE status=failed elapsed_seconds=... timed_out=... exit_code=... completion_marker=... errors=... warnings=... summary=... excerpt=...error-excerpt.txt
```

禁止绕过执行器直接使用`Start-Process`、CMD `start /wait`、后台任务或手写PID轮询。

## 三、运行前准备

1. 所有试跑、修改版代码和输出必须位于用户指定的工作目录或标准流程的当前阶段Temp；不得修改原始do-file或把输出写回能力包源目录。
2. do-file开头固定写：

```stata
version 17.0
clear all
set more off
```

项目依赖其他版本时按真实版本调整。

3. 对外部命令先执行依赖预检；没有安装授权时不得安装。关键外部命令不能只运行`which`：正式批次前还要用本轮真实数据、真实选项和最小规格验证目标语法。预检结果区分命令缺失、版本/选项不兼容和数据结构不满足；最小规格通过后才进入批量运行。
4. 确认输入文件存在、实际变量存在、模板占位符已经全部替换。
5. do-file末尾固定写：

```stata
display "CODEX_STATA_COMPLETE=1"
exit, clear
```

6. 同名旧do-file、log和结果不得被无提示覆盖。修改或重跑时使用新文件名或版本号。
7. do-file不得包含`log using`、`log close`或其他自行开关日志的命令。日志由统一执行器独占管理；执行器在启动Stata前拦截冲突代码。
8. 中文路径或中文代码无需人工复制。执行器在原目录内建立一次性ASCII文件名、本机代码页编码的兼容副本，完成后把日志归回原do-file对应位置并清理副本；项目结果仍直接保存在用户指定Temp。本机Stata 17实测不能使用UTF-8 BOM，因此不得擅自改回BOM方案。
9. Stata 17在本机实测仍不能可靠创建中文文件名。数据和Temp目录可以是中文路径，但do-file直接生成的CSV、DTA、图形和其他产物统一使用ASCII文件名；面向用户的中文名称写入结果表标签或汇报Markdown，不写进Stata产物文件名。

## 四、超时

- 普通检查或单次估计：600秒；
- 每批不超过100个规格、Bootstrap、安慰剂、permutation：3600秒；
- 机器学习、结构估计、大型空间模型、SCM/SDID：7200秒；
- 更长任务：使用用户要求或Plan明确记录的新秒数。

超时不是无限等待授权。执行器超时后只终止本次进程，保留do-file、log和已生成结果。

## 五、等待规则

调用执行器时，给承载它的工具设置足以覆盖本轮超时的运行时间。若工具把长命令转为持续运行单元：

1. 保存该运行单元ID；
2. 使用同一运行单元的等待功能继续等待；
3. 等待期间不读取任何文件，不发起新的shell命令；
4. 等待返回最终结果后再继续；
5. 用户中途发送消息不会构成重新启动Stata的理由。

底层工具若要求分段等待，可以重复等待同一运行单元，但每次不得产生Stata日志内容。这是工具等待，不是AI轮询Stata。

## 六、结果输出

do-file应尽可能把用户真正需要的结果写入小型结构化文件，例如：

- 均值核验：`mean_check.csv`；
- 回归系数：`regression_results.csv`或`.dta`；
- 分组差异：`group_difference.csv`；
- 批量规格：`specification_results.csv`或`.dta`；
- 必要表格和图形。

结构化结果至少包含识别该规格所需的变量/分组、系数、标准误、p值、N、运行状态和用户要求的诊断量。不要把长log作为主要结果传输方式。

### 返回值优先

1. 命令只要提供`r()`、`e()`、矩阵或其他可导出结果，就必须直接写入CSV或DTA；不得把搜索log作为常规结果提取方式。
2. `r()`和`e()`可能被下一条命令覆盖。目标命令结束后，必须在运行任何其他命令前立即把所需值保存到`scalar`、`local`或`postfile`。
3. 命令确实没有结构化返回值时，do-file才可主动输出唯一、精确的机器可读标记；AI仍不得为提取结果读取整份log。
4. 执行成功且结构化结果完整时，即使最终摘要中的`warnings`很多，也不自动读取log。只有用户要求，或预先定义的关键警告可能改变结论时，才读取对应片段。

## 七、运行结束后的读取顺序

### 成功

1. 直接核对执行器最终一行中的`status=success`、`timed_out=False`、`exit_code=0`和`completion_marker=True`；
2. 读取用户需要的结构化结果、表格或图形；
3. `.run-summary.json`只留在磁盘供审计，成功时默认不读取；
4. 只在结果异常、用户要求或预先定义的关键警告可能改变结论时读取相关log片段；警告数量本身不触发读取；
5. 默认不读取完整log。

### 失败

1. 读取`.run-summary.json`；
2. 读取摘要指向的`.error-excerpt.txt`；
3. 检查对应代码区段；
4. 只有错误摘录不足以定位时才读取完整log；
5. 修复时建立新版本do-file，不覆盖失败版本，不无限重跑。

## 八、批量任务

1. 同一数据、同一任务的规格写入一个do-file；数据只读取一次。
2. 每个规格设唯一编号，使用`capture quietly`独立运行，并立即保存`_rc`；只有定位错误确需过程输出时才把该规格临时改为`capture noisily`。
3. 成功时立即保存所需`r()`或`e()`返回值；失败时将估计字段记为缺失。无论成功失败，每个规格都必须在结构化结果中保留一行及其`run_status`/`_rc`。
4. 一个规格失败不得中断同批后续规格。会改变样本、排序、变量或数据状态的规格必须置于`preserve`/`restore`之间，防止相互污染。
5. 批次结束前统计失败规格数并输出唯一标记`CODEX_PARTIAL_FAILURES=N`。执行器整体仍可为`status=success`，但最终摘要必须显示`partial_failures=N`；N大于0时读取小型结构化失败表，不读取整份log。
6. 单批最多100个规格；超过时按100个一批拆分。
7. 每批只启动一次Stata。前一批完成并落盘后再启动下一批。
8. 标准实证流程按00B更新状态文件和项目总说明；直接执行模式只按用户指定位置保存结果。

## 九、Bootstrap面板预检

整群Bootstrap前先检查现有`xtset/tsset`声明。估计程序不使用时间序列算子时，在`preserve`后执行`xtset, clear`，避免重抽样产生重复面板—时间标识。使用`cluster()`重抽样时同步设置`idcluster()`，并在内部估计确需聚类标识时使用新生成的编号。`r(451)`优先诊断为重抽样后的面板标识冲突，不得盲目重复运行。

## 十、运行状态判断

只有同时满足以下条件才算成功：

- 本次进程未超时；
- 进程退出码为0；
- 本次生成的log存在；
- log属于本次运行；
- log中存在`CODEX_STATA_COMPLETE=1`。

日志文件出现、Stata窗口消失、运行时间很长或结果文件部分生成，都不能单独证明成功。

do-file完整结束只表示执行成功，不表示全部规格成功、诊断通过或研究任务已解决。批量结果还必须核对`partial_failures`和结构化结果中的`run_status`。

## 十一、本机配置

执行器先检查PATH，再检查已配置候选路径。当前电脑已验证：

```text
E:\Program Files\Stata17\StataMP-64.exe
```

复制到其他电脑后由`00D-静默安装与本机适配.md`探测路径并更新执行器。当前电脑实测默认参数为`/q /e do`；同一轮多个规格采用一个do-file、一次启动、一次读取数据。
