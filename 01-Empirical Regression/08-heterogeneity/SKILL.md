---
name: 08-heterogeneity
description: Run pre-specified or explicitly exploratory heterogeneity and distributional-effect analyses. Every displayed analysis has executable code in the single stage-owned 08-异质性代码.md; use formal difference tests and validated CATE workflows.
---

# 08 异质性与分布效应

检验用户预先提出的异质性维度，或把新增维度明确标记为探索性。全部代码保存在 `08-异质性代码.md`。

## 一、开始前

完整读取项目三个 Inf 文件、基准和已有异质性结果；读取能力包根目录 00A，并完整读取 00B。确认 Z/分组变量、构造时点、阈值、缺失、每组支持、预设或探索性、显著性底线和搜索范围。写入 `AI-Work/Plan/NN-08-异质性与分布效应-方案.md`，使用 `AI-Work/Temp/08-异质性与分布效应`，创建或恢复该目录的 `00-执行状态.md`。代码包含 Stata 时完整读取根目录 `00C-Stata调用方法.md`；包含 Python 或 R 时完整读取 `00C-Python与R调用方法.md`；同时包含时两份都读。

## 二、带代码的分析

完整读取当前 Skill 同目录的 `08-异质性代码.md`。代码分支为：1. 分类交互与正式差异检验；2. 分组回归与 bootstrap 差异；3. 连续调节变量与边际效应；4. subgroup event study；5. 条件分位数回归；6. 无条件分位数/RIF；7. 多重检验；8. honest CATE 与验证。

不得用“一组显著、另一组不显著”推断组间差异。分组阈值优先使用处理前或预定口径；遍历变量后只汇报显著结果禁止。

分组变量必须从本轮实际依据变量重新生成：先`capture drop`旧变量，再以短英文临时变量名`gen byte`，源变量缺失的观察必须保持组别缺失。不得在已有分组变量上连续`replace`。`bdiff`前必须确认组别仅为0/1/缺失、剔除缺失且两组均存在；结束后立即保存`r(bdiff)`和`r(p)`到结构化结果，不得从log提取。批量维度按00C逐项隔离失败，单项报错不得阻断后续维度。

## 三、汇报与收尾

每完成一个检验或批次按 00B 写检查点。生成 `AI-Work/Temp/08-异质性与分布效应/08结果汇报.md`，记录维度是否预设、阈值时点、每组 N/处理支持、正式差异检验、多重校正和四种状态。用户采纳后才进入 Reg/Result。最后完整读取并更新 `AI-Work/Inf/00-项目总说明.md`，保存后再次完整读取确认，再显示剩余阶段。
