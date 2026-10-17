---
name: 04-method-specific
description: Run identification diagnostics specific to the empirical design selected in 00A. Each displayed diagnostic has executable code in the single stage-owned 04-方法专属识别检验代码.md; confirm the tests, run them against the baseline design, and distinguish identification diagnostics from target significance.
---

# 04 方法专属识别检验

本阶段保存不能由所有方法共用的识别检验。代码按“检验”组织在 `04-方法专属识别检验代码.md`，不建立 OLS、DID、IV 等平行文件夹。

## 一、开始前

1. 读取 Inf、02 基准代码/结果和已完成的 03 结果。
2. 从能力包根目录 00A 核实当前方法，只显示下列对应检验；没有代码的检验不得显示。
3. 完整读取能力包根目录 00B，确认检验、变量、窗口、阈值、推断、诊断标准和尝试范围。
4. 写入 `AI-Work/Plan/NN-04-方法专属识别检验-方案.md`，使用 `AI-Work/Temp/04-方法专属识别检验`，创建或恢复该目录的 `00-执行状态.md`。
5. 代码包含 Stata 时完整读取能力包根目录 `00C-Stata调用方法.md`；包含 Python 或 R 时完整读取 `00C-Python与R调用方法.md`；同时包含时两份都读。不得用“相应 00C”自行猜测。

## 二、菜单

- 面板：FE/RE/CRE、动态面板诊断；
- DID：事件研究、事前联合检验、现代分期 DID、TWFE 权重、安慰剂、同期政策、PSM-DID；
- IV：第一阶段/约化式、欠识别、弱识别、弱 IV 稳健推断、过度识别；
- RDD：密度、协变量平衡、带宽/阶数/donut、伪阈值、fuzzy first stage；
- SCM/SDID：处理前拟合、单位/时间安慰剂、RMSPE、leave-one-donor-out；
- 匹配/重加权：overlap、SMD、权重尾部、ESS；
- RCT：分配平衡、随机化推断、流失、不依从；
- 因果 ML：cross-fitting、overlap、out-of-sample CATE 验证；
- 时间序列：平稳性、协整、稳定性、残差诊断；
- 空间：W 核验、Moran、直接/间接/总效应；
- 结构估计：多起点、收敛、梯度、数值精度；
- 生存/流行病学：PH、删失、竞争风险和模型区分。

## 三、执行与汇报

完整读取当前 Skill 同目录的 `04-方法专属识别检验代码.md`，只复制当前方法和 Plan 选中的段落。每完成一项检验或批次按 00B 写检查点。每项记录目的、原假设、统计量、p/临界值、适用条件和结论；目标结果显著性与方法诊断分别判断。

生成 `AI-Work/Temp/04-方法专属识别检验/04结果汇报.md` 和必要图形。用户采纳后才进入 Reg/Result。最后完整读取并更新 `AI-Work/Inf/00-项目总说明.md`，保存后再次完整读取确认，再显示剩余阶段。
