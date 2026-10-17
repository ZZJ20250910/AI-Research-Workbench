# Output template

Adapt headings to the paper, but preserve this information architecture and level of completeness.

## Title and orientation

```markdown
# 论文完整导读 · 给接手研究的合作者

> 日期 | 你没看过原文，这篇文档替你看。按论文顺序从头讲到尾：这是什么、怎么做、结果什么意思。
```

When reviewer reports exist, make that explicit in the title or subtitle.

## Paper guide required in all cases

1. **这篇论文要干什么**
   - one-paragraph plain-language answer;
   - sample, treatment/exposure, outcome, headline magnitude, and claimed contribution.
2. **背景与制度/行业语境**
   - only the background needed to understand the empirical logic;
   - distinguish documented history from the manuscript’s characterization.
3. **理论框架与假设**
   - explain each link separately;
   - list formal hypotheses and observable implications.
4. **数据长什么样**
   - explain this paper's actual datasets, observation unit, coverage, and sample formation without forcing irrelevant standard fields;
   - reconstruct every important variable from its original source to its regression-ready form by combining definitions scattered across the text, equations, notes, and appendices;
   - for the outcome, treatment/core regressor, instruments, mechanisms, and heterogeneity variables, give the actual construction sequence, formula and components, timing, unit, transformations, and substantive meaning wherever reported;
   - group ordinary controls concisely when appropriate, but fully explain nonstandard or identification-relevant controls;
   - explain only the merges, cleaning, missing/outlier rules, and sample losses that actually arise in the paper and affect the analysis;
   - state precise, consequential construction gaps under `复现仍缺的信息`; never substitute a generic checklist or guess at standard practice;
   - choose prose, equations, or tables based on what best explains the paper. Do not emit empty construction cards or “not applicable” fields.
5. **实证一步一步来**
   - follow the manuscript’s actual order;
   - write the baseline equation and translate it into an executable specification;
   - for every table and every column: why it is run, sample, variables, fixed effects, clustering/weights, what changes from the prior column, exact result, author interpretation, and evidentiary boundary;
   - cover baseline, identification/endogeneity, robustness, mechanisms, heterogeneity, policy analysis, appendix evidence, and null results when present.
6. **关键数据卡片**
   - compact table of analysis unit, period, final N, main estimate, fixed effects, clustering, weights, first-stage statistic or identifying test, and table count as applicable.
7. **结论与证据边界**
   - what is established;
   - what remains conditional on assumptions;
   - what the design cannot distinguish.
8. **接手实证清单**
   - available and unavailable data/code inputs;
   - ordered dataset-build and merge workflow;
   - ordered variable-construction workflow;
   - ordered table/figure reproduction workflow;
   - unresolved definitions and decisions requiring author clarification;
   - first diagnostics and consistency checks the incoming researcher should run.

## Inline review treatment when reviews exist

After the relevant result, add a concise paragraph such as:

```markdown
**作者怎么解释**：……

**审稿人怎么反驳**：Reviewer #2 认为……，因为……；这直接影响 Table 3 的……假设。
```

Do not postpone all criticism to the end. The inline layer explains the conflict; the later audit guarantees completeness.

## Review audit required only when reviews exist

9. **审稿意见完整罗列**
   - one subsection per reviewer/editor;
   - overall stance;
   - every major comment;
   - every minor comment;
   - final recommendation if stated.
10. **审稿意见总览**
   - critical identification threats;
   - substantial but reparable issues;
   - quick reporting or wording fixes;
   - map comment IDs to tables/sections.
11. **审稿人明确给出的方向**
    - preserve what was actually suggested;
    - do not relabel your own idea as a reviewer request.
12. **完整修改方案**
    - narrative/claim changes;
    - data additions;
    - identification redesign;
    - mechanisms and heterogeneity redesign;
    - reporting fixes;
    - alternative routes with requirements, benefits, risks, and failure conditions.
13. **修改后的论文结构**
    - crosswalk from old sections/tables to the proposed version.
14. **实操路线图**
    - ordered tasks;
    - decision branches based on data availability, sample size, balance/continuity tests, first-stage strength, or other diagnostics;
    - stop/reframe conditions when the preferred claim is not supported.

## Style model

- Prefer direct explanation: “简单说”“为什么要做”“怎么解读”.
- Use bold text for the finding or conceptual pivot, not for decoration.
- Use tables when several models, variables, comments, or options share the same schema.
- Keep equations short and immediately translate them into plain language.
- Report uncomfortable evidence with the same prominence as supportive evidence.
- Avoid generic praise, paper-like abstract prose, and vague statements such as “results are robust” without naming the tests and estimates.
