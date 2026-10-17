---
name: 03-basic-robustness
description: Run shared diagnostics and basic robustness checks without changing the project's core identification design. Every displayed check has stage-owned code in 03-基础稳健性代码.md; confirm the selected checks, save the plan, run all authorized specifications, and report all outcomes.
---

# 03 通用诊断与基础稳健性

本阶段保存不同研究方法能够重复使用的基础检验。不存在按 OLS、DID、IV 复制的模板；同一检验只保存一份代码。

## 一、开始前

1. 读取三个 Inf 文件、基准 Plan、基准代码和 `02结果汇报.md`。
2. 读取能力包根目录 00A 核实当前方法；完整读取能力包根目录 00B 后向用户显示适用检验。
3. 确认检验、变量、样本、底线和尝试范围，写入 `Plan/NN-03-通用诊断与基础稳健性-方案.md`。
4. 使用 `AI-Work/Temp/03-通用诊断与基础稳健性`；创建或恢复该目录的 `00-执行状态.md`。使用 Stata 时完整读取能力包根目录 `00C-Stata调用方法.md`；使用 Python 或 R 时完整读取 `00C-Python与R调用方法.md`；同时使用时两份都读。

## 二、可选检验及代码

完整读取当前 Skill 同目录的 `03-基础稳健性代码.md`。只显示适用于当前数据和模型的项目：

1. 替代 Y、替代 X/T/D；
2. 控制变量递进与替换；
3. 固定效应、趋势与聚类层级；聚类层级必须由抽样/处理分配层级、误差相关结构或用户已确认的研究设计依据确定，并写入 Plan，不得以显著性高低选择；
4. 样本期、特殊年份、地区、行业和预设样本限制；
5. 缩尾、变量变换和有依据的插值；
6. 因变量性质对应的替代估计量；
7. 缺失、样本流失、异常值、leverage 和 Cook 距离；
8. 异方差、序列相关、横截面相关和少量聚类推断；
9. leave-one-cluster-out；
10. 基准样本一致性。

上述每项均在代码文件中有对应代码。改变 estimand 或识别设计的内容不得放入本阶段。删除固定效应不能作为显著性按钮；插值不得覆盖原变量。

## 三、执行与汇报

Stata 代码复制为 `AI-Work/Temp/03-通用诊断与基础稳健性/03try.do`；Python 代码复制为同目录 `03try.py`；R 代码复制为同目录 `03try.R`。同一种语言的多规格在数据和内存允许时合并为一个脚本、一次读取数据、一次启动引擎；任何单批最多 100 个规格，超过即按 100 个一批拆分。广泛尝试保留全部结果和失败。每完成一个检验或批次按 00B 写检查点。生成 `AI-Work/Temp/03-通用诊断与基础稳健性/03结果汇报.md`，逐项与基准比较样本、估计、SE/CI/p、诊断、警告和四种状态。

用户确认后才复制到 Reg/Result。最后完整读取并更新 `AI-Work/Inf/00-项目总说明.md`，保存后复读确认，再列出剩余阶段。
