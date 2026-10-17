---
name: 05-advanced-robustness
description: Run advanced robustness and sensitivity analyses after a baseline exists. Use the single stage-owned code library, display only checks applicable to the current design, preserve the full specification universe, and report sensitivity limits and failures.
---

# 05 高级稳健性与敏感性

本阶段只运行针对明确风险的高级检验。全部正式代码在 `05-高级稳健性代码.md`，不按研究方法复制目录。

## 一、开始前

完整读取项目三个 Inf 文件、02–04 的 Plan、代码和结果；读取能力包根目录 00A，并完整读取 00B。向用户说明每项检验针对的风险、依赖、超时档位和输出。确认后写入 `AI-Work/Plan/NN-05-高级稳健性与敏感性-方案.md`，使用 `AI-Work/Temp/05-高级稳健性与敏感性`，创建或恢复该目录的 `00-执行状态.md`。代码包含 Stata 时完整读取根目录 `00C-Stata调用方法.md`；包含 Python 或 R 时完整读取 `00C-Python与R调用方法.md`；同时包含时两份都读。

## 二、代码菜单

完整读取当前 Skill 同目录的 `05-高级稳健性代码.md`。代码文件逐项提供：Oster、partial R²/sensemakr、E-value、Rosenbaum、Manski bounds、规格曲线、多重检验、placebo/subsample/bootstrap、wild cluster、HonestDiD、RDD 敏感性、SCM 敏感性、时间序列敏感性、空间 W/Conley、结构估计数值敏感性、生存模型敏感性、DML、固定效应残差化和空间溢出排除。

只显示适用项。规格曲线必须先确认规格宇宙，所有失败、不显著和方向不符结果都进入台账。长任务记录计时，不无限重跑。依赖缺失不自动安装。

## 三、汇报与收尾

每完成一个检验或批次按 00B 写检查点。生成 `AI-Work/Temp/05-高级稳健性与敏感性/05结果汇报.md`，报告基准、扰动设定、全部结果、敏感性界限、失败和四种状态。用户采纳后才进入 Reg/Result。最后完整读取并更新 `AI-Work/Inf/00-项目总说明.md`，保存后再次完整读取确认，再显示剩余阶段。
