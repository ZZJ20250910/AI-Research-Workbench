---
name: 02-baseline
description: Confirm and run the baseline estimation for an initialized empirical project. Use the single stage-owned code library, select only the estimator matching the method chosen in 00A, save the confirmed plan, run in Temp, and report all results before promotion.
---

# 02 基准估计

本阶段建立主估计，不从包级共享模板取代码。本阶段所有可执行代码唯一保存在 `02-baseline/02-基准估计代码.md`。

## 一、开始前

1. 完整读取 `AI-Work/Inf/00-项目总说明.md`、`01项目信息.md`、`02数据索引.md`及已有 Reg/Result。
2. 读取能力包根目录 `00A-方法选择.md`，核实当前方法。
3. 完整读取能力包根目录 `00B-正式运行前确认.md`，向用户确认 estimand、Y、X/T/D、Controls、IV、M、Z、样本、FE、cluster、显著性底线和未达底线时的授权范围。
4. 用户确认后写入 `AI-Work/Plan/NN-02-基准估计-方案.md`。
5. 创建并使用 `AI-Work/Temp/02-基准估计`，不清空历史；按 00B 创建或恢复 `AI-Work/Temp/02-基准估计/00-执行状态.md`。
6. 使用 Stata 时读取能力包根目录 `00C-Stata调用方法.md`；使用 Python/R 时读取能力包根目录 `00C-Python与R调用方法.md`。

## 二、代码选择

完整读取当前 Skill 同目录的 `02-基准估计代码.md`，只复制与当前方法和用户方案相符的代码块到 Temp：

- 常规回归、面板、同步 DID 或 TWFE：A；
- 分期 DID：B；
- IV：C；RDD：D；SCM/SDID：E；匹配/重加权：F；RCT：G；
- 因果机器学习：H；时间序列：I；空间计量：J；结构估计：K；生存/流行病学：L。

不得把代码库中其他模型顺手加入本轮。占位符必须全部替换。Stata 外部命令用 `which 命令名` 和 `help 命令名` 核实；Python 包用 `python -c "import 包名; print(包名.__version__)"` 核实；R 包用 `Rscript -e "packageVersion('包名')"` 核实。任何预检失败均按 00B 记录为受阻，禁止直接运行对应段落。

## 三、运行与汇报

先运行用户确认的主方案；只有用户授权广泛尝试时才运行组合。完整读取日志，核对退出码、完成标记、警告、样本损失、共线性和收敛。

每完成一个代码段或批次，按 00B 更新状态文件和进度锚点。生成 `AI-Work/Temp/02-基准估计/02结果汇报.md`，至少记录：Plan、代码、数据、引擎版本、估计对象、实际变量、样本、模型、FE/cluster、核心估计、SE、CI、p、N、必要诊断、警告，以及运行/诊断/目标结果/采纳四种状态。

用户确认采纳后才把整理代码复制到 Reg、表图和结果说明复制到 Result；Temp 不删除。

## 四、收尾

完整读取并更新 `AI-Work/Inf/00-项目总说明.md`，保存后再次完整读取确认；记录 `02 基准估计`、Plan、Temp 汇报和已采纳路径。最后读取 00A，显示当前方法剩余阶段并等待用户选择。
