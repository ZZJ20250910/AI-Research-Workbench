---
name: 07-mechanism-dynamics
description: Run theory-specified mechanism, mediation, moderation, dynamic-response, or structural-counterfactual extensions. Every displayed analysis has executable code in the single stage-owned 07-机制动态代码.md; distinguish channel-consistent evidence from causal mediation.
---

# 07 机制、动态与结构扩展

只分析用户研究框架中已有的渠道或扩展，不从变量库遍历显著机制。全部代码保存在 `07-机制动态代码.md`。

## 一、开始前

完整读取项目三个 Inf 文件、基准和已有扩展；读取能力包根目录 00A，并完整读取 00B。确认理论链条、M/动态结果/反事实、时间顺序、预期方向、样本和搜索范围。写入 `AI-Work/Plan/NN-07-机制动态与结构扩展-方案.md`，使用 `AI-Work/Temp/07-机制动态与结构扩展`，创建或恢复该目录的 `00-执行状态.md`。代码包含 Stata 时完整读取根目录 `00C-Stata调用方法.md`；包含 Python 或 R 时完整读取 `00C-Python与R调用方法.md`；同时包含时两份都读。

## 二、带代码的分析

完整读取当前 Skill 同目录的 `07-机制动态代码.md`。代码分支为：1. 渠道结果回归；2. 保留 X/T 的两步渠道回归；3. 滞后机制；4. 统计中介和间接效应；5. 因果中介；6. 排除替代渠道/负向结果；7. 调节效应；8. distributed lag；9. local projections；10. 事件动态路径；11. 结构反事实。

两步显著最多写成“与渠道一致”；因果中介需要额外假设。处理后的 bad control、时间顺序错误或观察层级不一致时停止。

## 三、汇报与收尾

每完成一个检验或批次按 00B 写检查点。生成 `AI-Work/Temp/07-机制动态与结构扩展/07结果汇报.md`，逐条写明理论、证据类型、时间顺序、样本、结果、诊断和限制。用户采纳后才进入 Reg/Result。最后完整读取并更新 `AI-Work/Inf/00-项目总说明.md`，保存后再次完整读取确认，再显示剩余阶段。
