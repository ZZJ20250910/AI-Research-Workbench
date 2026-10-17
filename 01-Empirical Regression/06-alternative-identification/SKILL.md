---
name: 06-alternative-identification
description: Run an explicitly authorized alternative identification or endogeneity correction after the user supplies its variables and assumptions. Every displayed branch has executable code in the single stage-owned 06-替代识别代码.md; never invent an instrument or design.
---

# 06 替代识别与内生性处理

本阶段不是“所有项目都做 IV”。只有用户已经给出可信替代设计、变量和假设时才运行。全部代码保存在 `06-替代识别代码.md`。

## 一、开始前

完整读取项目三个 Inf 文件、基准和诊断结果；读取能力包根目录 00A，并完整读取 00B。确认新 estimand、Y、内生变量、识别变量/修正方法、controls、样本、推断和假设；写入 `AI-Work/Plan/NN-06-替代识别与内生性处理-方案.md`，使用 `AI-Work/Temp/06-替代识别与内生性处理`，创建或恢复该目录的 `00-执行状态.md`。代码包含 Stata 时完整读取根目录 `00C-Stata调用方法.md`；包含 Python 或 R 时完整读取 `00C-Python与R调用方法.md`；同时包含时两份都读。

## 二、带代码的分支

完整读取当前 Skill 同目录的 `06-替代识别代码.md`。代码分支为：1. IV/2SLS；2. 控制函数；3. Heckman selection；4. 动态面板；5. DDD；6. SCM/SDID 或交互固定效应；7. AIPW/IPWRA；8. RCT assignment IV；9. spatial IV/GMM；10. frailty/IPCW。

没有用户提供的识别变量或设计时不显示该分支。Fuzzy RDD 留在 04。每个替代设计必须说明 estimand、样本和假设如何变化。

## 三、汇报与收尾

每完成一个检验或批次按 00B 写检查点。生成 `AI-Work/Temp/06-替代识别与内生性处理/06结果汇报.md`，完整报告设计、假设、诊断、与基准差异和四种状态。用户采纳后才进入 Reg/Result。最后完整读取并更新 `AI-Work/Inf/00-项目总说明.md`，保存后再次完整读取确认，再显示剩余阶段。
