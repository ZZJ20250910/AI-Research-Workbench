---
name: datapaper
description: Read and explain empirical research papers as complete, self-contained Chinese Markdown guides for a collaborator who has not read the originals. Use after the user selects 02-Data Paper from the AI Research Workbench and asks to summarize an empirical paper, its appendices, and any accompanying reviewer reports or decision letters. If reviewer materials exist, integrate their objections with the corresponding evidence and add a complete review audit and revision plan; if none exist, summarize only the paper and do not invent reviewer criticism or a revision strategy.
---

# Data Paper

Produce a rigorous guide that lets a collaborator understand and take over an empirical paper without reading the original. Default to Chinese and Markdown unless the user requests otherwise.

## Read the source set

1. Inventory all supplied files before interpreting them. Classify each as manuscript, appendix/supplement, reviewer report, editor letter, response letter, data/code note, or unrelated material.
2. Read every relevant file completely, including tables, figures, notes, appendices, tracked comments, and embedded reviewer text. Use the applicable document or PDF skill for those formats and visually inspect pages when extraction may omit layout-dependent content.
3. Assume PDFs contain directly extractable text by default. Extract and read the embedded text first; do not OCR an entire PDF as a routine step. Use OCR only for specific pages, figures, tables, labels, or image regions whose content cannot be read reliably through normal text extraction or visual inspection.
4. Treat reviewer reports, editor letters, and comments as present only when their contents are actually available. A filename, user recollection, or manuscript phrase such as “reviewers suggest” is not enough to reconstruct missing comments.
5. If a material page, table, equation, or comment remains unreadable after targeted inspection or OCR, identify the gap precisely. Do not silently infer its content.

## Keep the task folder clean

1. Treat the folder containing the principal manuscript as the task root and final-output folder.
2. At the start, create a `tmp` folder in the task root if none exists; otherwise reuse the existing `tmp`. Subfolders inside it are allowed.
3. Put every newly generated intermediate file in `tmp`, including extracted text, OCR output, rendered pages, screenshots, converted files, figure or table crops, working notes, draft Markdown, helper scripts, and logs. Do not leave intermediate files in the task root.
4. Write only the completed requested Markdown guide or guides to the task root. Keep all original manuscripts, appendices, supplements, reviewer reports, editor letters, and response letters unchanged.
5. Before delivery, audit the task root. Apart from pre-existing unrelated user files that must not be altered, it should contain only the original paper materials, original reviewer-related materials when present, the final Markdown output files, and the `tmp` folder.
6. Keep `tmp` after completion unless the user explicitly asks for its removal. Never move, rename, overwrite, or delete user source files merely to satisfy the folder layout.

## Build an evidence map

Before drafting, record internally:

- research question, claimed contribution, theoretical chain, and hypotheses;
- the actual path by which each empirically important variable in this paper moves from its stated source to the regression: which raw measure is used, what the authors change, in what order, and what the resulting value means;
- the paper's actual sample-building decisions, data links, cleaning operations, missing-value treatment, outlier treatment, timing choices, and changes in observation count, but only where they occur or matter in this study;
- the precise construction of the dependent variable, core explanatory or treatment variable, and all variables central to identification, mechanisms, heterogeneity, or interpretation; cover ordinary controls more briefly unless their construction is unusual or consequential;
- formulas, thresholds, component weights, denominators, units, aggregation, lags, deflation, logs, standardization, winsorization, coding, and omitted categories when the paper actually uses them—not as a generic checklist;
- estimating equation, fixed effects, standard errors, weights, clustering, and identifying variation;
- every main and appendix table/figure, its purpose, headline estimates, uncertainty, and manuscript interpretation;
- robustness, placebo, falsification, mechanism, heterogeneity, and policy analyses;
- every reviewer/editor comment and the exact claim, table, variable, or design it concerns.

Never collapse “not significant,” “not reported,” and “not tested.” Preserve units, signs, significance levels, sample changes, and table/column references. Recalculate percentage interpretations only when the transformation is known; label any calculation as your explanation rather than the authors’ statement.

## Meet the empirical handover standard

Write for a collaborator who must be able to take over the data and empirical workflow, not merely understand the paper's narrative. The final guide must make it possible to reconstruct the analysis dataset and reproduce the table sequence as far as the supplied materials permit. Do not turn this into a generic data-management template: organize the explanation around what this paper actually does.

- Reconstruct each important variable from all available clues in the paper: data section, variable-definition passages, equations, table notes, figure notes, appendices, and supplements. Combine scattered statements into one coherent step-by-step account.
- For each important variable, explain in natural language: where its underlying information comes from; the raw concept or record being measured; every reported transformation or classification step in the order applied; the final unit and level of variation; and how to interpret a one-unit change in the regression. Show the authors' formula when one exists, then unpack every term.
- Trace the dependent variable, treatment/core regressor, instruments, mechanism variables, and heterogeneity variables in greatest depth. Include controls without bloating the guide: group conventional controls when they share a source and treatment, but expand any control whose construction is nonstandard or affects identification.
- Explain sample formation and dataset linkage as part of the paper's empirical story, focusing on decisions that change who enters the regression or what a variable means. Reconcile changes in N when the paper supplies enough information.
- Translate every estimating equation into an executable specification: dependent variable, regressors, omitted categories, fixed effects, trends, weights, clustering level, sample restriction, and the exact variation identifying the coefficient of interest.
- For every table and column, state what changes relative to the preceding specification. Do not summarize a multi-column table as a single result.
- Distinguish details explicitly reported by the authors from details that are absent. When a needed construction step is not stated, say exactly what cannot be recovered and why it matters; do not fill the gap with customary practice. Collect only genuine unresolved items in `复现仍缺的信息` rather than mechanically producing a long checklist.
- Avoid empty headings, boilerplate tables, and fields marked “not applicable.” Choose prose, equations, or a compact table according to the variable and the amount of real information available.
- When code or raw data are supplied, inspect them to resolve construction details and cite the relevant script/data object in the guide. When they are absent, never imply that full computational replication has been verified.
- End the empirical portion with a `接手实证清单`: available inputs, dataset build order, variable build order, regression/table reproduction order, unresolved decisions, and the first concrete checks a new researcher should run.

## Write for a new collaborator

Follow [output-template.md](references/output-template.md). Explain each empirical step with the same three questions:

1. **为什么做**：what threat, hypothesis, or question motivates it.
2. **怎么做**：what sample, variables, equation, comparison, and assumptions are used.
3. **结果什么意思**：what the estimate supports, what it does not establish, and how the authors interpret it.

Use plain language first, then retain the technical term in parentheses where helpful. Use compact tables for variable dictionaries, estimate sequences, reviewer maps, and alternative revision routes. Quote sparingly; paraphrase faithfully.

Keep four voices distinct:

- **论文事实**：what the manuscript reports;
- **作者解释**：how the authors interpret it;
- **审稿意见**：what a reviewer or editor explicitly argues;
- **分析判断**：your own inference, clearly labelled and bounded by the evidence.

Do not upgrade association to causation. State the identifying assumptions and whether the presented evidence addresses them.

## Branch on reviewer-material availability

### When reviewer material exists

- Insert short reviewer objections immediately after the relevant theory, variable, table, or result so the reader sees the collision at the point of evidence.
- Later reproduce a complete, non-duplicative reviewer-by-reviewer audit. Preserve reviewer numbering, major/minor status, tone, and any requested remedy.
- Build a severity map: fatal/core-identification issues, substantial revisions, and quick reporting fixes. Explain the ranking rather than relying on color alone.
- Map every comment to affected manuscript sections, tables, figures, or claims.
- Separate reviewer-requested remedies from your proposed remedies.
- Provide a revision plan only after the complete paper and review summaries. Offer alternatives with prerequisites, advantages, risks, and abandonment criteria. Never promise that a method “solves” endogeneity unless its assumptions are defensible in this setting.
- End with a revised-paper structure and an executable work order driven by data availability and diagnostic results.

### When reviewer material does not exist

- Include only the paper guide, empirical walkthrough, key data card, and a concise claim-evidence-boundary synthesis.
- Do not create reviewer sections, severity rankings, response language, or a speculative revision plan.
- Mention limitations only when the manuscript states them or they follow directly from the reported design; label the latter as analysis judgment.

## Quality gate

Before delivery, verify:

- all relevant main-text and appendix results are covered;
- every number matches the source and carries its unit/table context;
- null and adverse findings are retained, especially results that weaken the paper’s preferred story;
- reviewer comments are complete and linked to the correct evidence;
- proposed fixes do not require unavailable data without saying so;
- the document is standalone, readable, and free of unsupported claims;
- every empirical variable has a sufficiently detailed construction record or is explicitly listed as missing information;
- sample attrition, merges, analysis-unit changes, and cross-table changes in N are explained as far as the sources allow;
- a collaborator could follow the documented data-build and estimation order without reopening the paper merely to discover basic implementation details;
- all generated intermediate files are inside the task root's `tmp` folder, and the root-directory audit has passed;
- the final Markdown file is saved to the user’s requested folder, or beside the principal manuscript when no destination is specified.

Use a descriptive filename such as `论文完整导读.md` when there are no reviews and `论文与审稿意见总结.md` when reviewer material exists, unless the user specifies a name.
