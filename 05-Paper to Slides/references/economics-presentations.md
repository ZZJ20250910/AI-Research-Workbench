# Economics paper presentations

Use this reference for empirical economics and closely related quantitative social-science papers. The objective is faithful oral explanation, not a referee report.

## Governing principle

Reconstruct the paper before compressing it. Preserve the authors' research question, conceptual hierarchy, empirical sequence, preferred results, qualifications, and conclusion. Explain identification and robustness because they are part of the paper's evidence, not because every presentation must become a methodological interrogation.

Do not impose one econometric template on every paper. A descriptive paper, measurement paper, structural paper, randomized experiment, quasi-experimental paper, macro paper, and theory paper require different balances.

## Build the paper map

Record internally:

- the research question and motivating economic tension;
- the paper's claimed contribution;
- the economic mechanism, hypotheses, or conceptual framework;
- institutional setting when it is necessary to understand treatment, behavior, or measurement;
- unit of observation, sample, period, and main data sources;
- central variables and how nonstandard measures are constructed;
- empirical method and the comparison or variation used by the authors;
- the sequence of main results, mechanisms, heterogeneity, welfare or policy analysis, and robustness;
- the conclusion and the limits stated or implied by the reported design.

Use this map to understand the paper, not as a mandatory slide checklist.

## Connect the story to the necessary formulas

The paper's argument determines what the talk explains. The formula inventory checks whether the mathematical and empirical support for that argument survives compression. Do not organize a talk around equation order, and do not remove a necessary construction merely because a verbal summary sounds smoother.

For each major claim in the narrative, ask what the audience must understand for that claim to be meaningful. Preserve the relevant formula or construction when it defines the object, produces the prediction, specifies the estimand, or supplies the identifying variation. Prefer deleting a repeated statement of the headline or a repeated coefficient display before deleting this support.

### Theoretical formula chain

When a theoretical model materially supports the paper's story, inventory the complete model and show the shortest faithful chain that connects:

1. economic actors, choices, primitives, and constraints;
2. the location of the proposed mechanism in the model;
3. the decisive first-order condition, equilibrium condition, proposition, or comparative static;
4. the empirical prediction or hypothesis used later.

Routine algebra and proof steps may be omitted. A theoretical or structural paper may require more of the derivation; an empirical paper with a short motivating model usually requires only the equations that generate the testable prediction. Never show only a final derivative or proposition when the audience cannot identify the object being optimized or the mechanism that changes it.

### Empirical construction chain

For a conventional empirical paper, the main-talk explanation should allow the audience to follow:

`raw data -> outcome Y -> treatment or explanatory variable X -> estimating equation -> identifying variation -> principal result`.

This is a comprehension test, not a demand for six separate slides. Combine steps when they remain legible. For every central nonstandard variable, state the economic concept, raw input, construction or classification rule, aggregation, regression level, timing, and interpretation. If a patent-level, transaction-level, text-level, or standard-level score becomes a firm-year or industry-year regression variable, show that aggregation explicitly.

For an IV or shift-share design, show the instrument's construction formula and define its summation dimension, baseline share, shift, baseline years, timing, and any leave-one-out operation before presenting first-stage diagnostics. When useful, show compact first- and second-stage equations. Diagnostics alone do not explain an instrument.

For a nonstandard mechanism variable, show `concept -> proxy -> construction -> level and timing`. Use a formula when the paper uses or clearly implies one; use an algorithmic or stepwise definition for classifications, LLM scores, or procedures that are not naturally represented by a single equation. Do not invent mathematical precision that the paper does not provide.

### Formula selection

- **Main talk by default:** definitions of central outcomes and treatments, aggregation into regression variables, baseline specification, nonstandard identification construction, decisive theoretical conditions or propositions, and unusual mechanism measures needed for the headline.
- **Conditional:** intermediate equilibrium conditions, alternative measures, heterogeneity specifications, decompositions, and robustness models when they add distinct economic meaning.
- **Usually omit or move to backup:** routine identities, repeated threshold variants, standard ratios, algebraic rearrangements, and proof details that do not change interpretation.

## Default narrative

For a conventional empirical paper, prefer this adaptable sequence:

1. question and why it matters;
2. paper's answer and contribution;
3. economic intuition or theoretical framework;
4. setting, data, and essential measurement;
5. baseline specification and complete variable definitions at the level needed to understand the evidence;
6. main result and magnitude;
7. the paper's principal supporting evidence;
8. mechanisms, heterogeneity, or extensions that matter to the main claim;
9. conclusion and evidence boundary.

Combine or omit elements when the paper does. Do not force a separate identification slide, mechanism slide, or robustness slide when those are not central to the paper.

For a full empirical talk, expose this logic as five navigable parts when the content supports it:

1. research question and argument;
2. data, measurement, and empirical design;
3. the first principal result and its supporting evidence;
4. the second principal result, main extension, or countervailing effect;
5. contributions and conclusion.

Put a table of contents after the title and a short divider before each part. Do not add detached backup pages by default. Integrate validation, identification diagnostics, robustness, heterogeneity, and coefficient summaries immediately after the claim or measure they support.

## Explain methods proportionately

Explain what comparison, variation, model, or assumptions allow the authors to interpret the result. Keep notation only when it improves understanding. A main specification slide should normally show the estimating equation and make clear:

- outcome and main explanatory or treatment variable;
- relevant sample and unit of observation;
- key fixed effects, controls, weights, or clustering when material;
- coefficient or estimand being interpreted;
- the paper's stated identifying logic or model interpretation.

List the actual controls used by the preferred specification rather than writing only “firm controls” or “industry controls.” If the list cannot remain legible, keep the complete variable dictionary on an adjacent main slide or a clearly signposted backup, but do not omit it from the deck. Put a distinct identification strategy on the next slide when combining it with the baseline model would make either explanation unclear.

Write the displayed model with compact symbols, for example $Y_{it}=\beta SI_{j,t-1}+\gamma'X_{it}+\delta'Z_{jt}+\mu_i+\lambda_t+\varepsilon_{it}$. Define the full variable names and contents beside or below it. Avoid long English identifiers inside mathematical expressions.

Reserve $X$ for the main explanatory variable only when that convention is used consistently. Otherwise give the treatment a meaningful short symbol and use $C_{it}$ and $W_{jt}$ for firm- and industry-level control vectors. Never call the treatment "X" orally while the displayed equation uses $X_{it}$ for controls.

Do not add an adversarial validity audit unless requested. Do not strengthen causal language beyond the paper and design. When the paper itself treats an assumption, diagnostic, first stage, balance test, pre-trend, model fit, or validation exercise as central, explain it faithfully.

## Present variables and measurement

Spend main-talk time on measures that are novel, nonstandard, necessary for interpretation, or part of the contribution. Use a simple construction diagram or compact example when it explains the measure better than prose. Move routine controls and full variable dictionaries to backup.

Preserve denominators, units, timing, transformations, reference groups, thresholds, and aggregation levels. Do not imply that a proxy directly observes the underlying concept when the paper does not. For every nonstandard construct used in the main argument or a mechanism test, state the economic concept, empirical proxy, construction, unit or aggregation level, and source. Never name a mechanism without explaining how the paper measures it.

## Color regression evidence consistently

- Green: statistically significant positive or supporting effects.
- Red: statistically significant negative or adverse effects.
- Black: statistically insignificant estimates, regardless of sign.
- Blue: neutral diagnostics and quantities without a positive/negative interpretation, including first-stage statistics, sample size, and economic-magnitude calculations.

Use the same treatment for the same estimate throughout the deck. Preserve the manuscript's stars or confidence intervals. Do not color a value red merely because it is important.

## Transform regression tables for projection

The objective is legibility without changing the evidence.

Allowed main-talk treatments include:

- a compact table containing only the columns and rows being discussed;
- a progressive table that reveals specifications in the paper's sequence;
- a coefficient plot transcribed from reported coefficients and uncertainty;
- a result card containing estimate, uncertainty, outcome, sample, and specification;
- an original table crop when it remains readable and its structure matters.

For every transformation:

1. preserve the exact reported estimate and uncertainty measure;
2. preserve signs, units, stars or confidence intervals, sample differences, and specification meaning;
3. state what changes across columns;
4. cite the original table and columns in `sources.md` and `.tex` comments;
5. label any recalculation, rescaling, standard-deviation interpretation, or percentage-point conversion;
6. place the full table in backup when omitted detail may matter in discussion.

Never infer a between-group difference solely because one estimate is significant and another is not. Never describe an insignificant estimate as zero. Do not hide null, sign-reversing, or specification-sensitive results that materially constrain the paper's conclusion.

## Choose supporting evidence

The main talk does not need every robustness table. Select analyses according to the role the paper gives them:

- evidence required to understand the main claim belongs in the main talk;
- decisive validation or identification evidence may belong in the main talk;
- repetitive robustness checks usually belong in backup and can be summarized faithfully;
- mechanisms and heterogeneity belong in the main talk when they are part of the contribution, not merely because they exist;
- full alternative specifications, variable definitions, and secondary outcomes normally belong in backup.

Do not reorder a secondary result into the headline simply because it is visually striking or statistically stronger.

## Interpret results faithfully

For a result discussed aloud, retain the relevant:

- direction and magnitude;
- uncertainty or significance;
- outcome unit and explanatory-variable scale;
- sample and specification;
- comparison group or omitted category;
- conditions needed for the paper's interpretation.

Use economic magnitude when the paper reports it or when it can be transparently derived from reported quantities. Label presenter calculations. Do not turn a coefficient into a percentage effect without a valid denominator or transformation.

Keep evidence levels distinct: descriptive pattern, conditional association, experimental estimate, quasi-experimental estimate, structural parameter, calibration, decomposition, mechanism-consistent result, and welfare or counterfactual calculation are not interchangeable.

## Visual priorities

Prefer visuals that clarify the paper's own logic:

- one conceptual diagram for the mechanism or competing forces when useful;
- a timeline or institutional diagram when timing defines the design;
- a measurement diagram for a novel constructed variable;
- readable event-study, distribution, coefficient, or counterfactual figures;
- compact result tables or coefficient plots for central estimates.

Do not add decorative stock imagery. Evidence-bearing tables are first-class visuals in economics presentations.

Use the complete figure inventory rather than selecting figures only after a text outline exists. The paper's story determines placement, but every numbered figure must be reconciled with the final deck. Use the supplied original figure by default, even when its labels differ from the slide language; surround it with an English title, reading cue, or translation note rather than redrawing it. Theory figures should replace repeated mechanism prose; descriptive figures should carry background trends without a paragraph narrating every year; event-study and pre-trend figures must retain event time, omitted period, uncertainty, and reference lines; mechanism figures must connect to the stated proxy; result figures must preserve the sample and comparison represented. Redraw only under the explicit exceptions in `SKILL.md`, and document the transformation.

Assign one primary carrier to each point. A figure shows the pattern, an equation shows the construction or estimand, a table shows the estimates, and the script supplies interpretation. Do not place a full verbal paraphrase beside a visual that already communicates the same relationship. On formula slides, keep only symbol definitions and conditions needed to read the equation. On figure slides, keep only a reading cue, essential qualification, and source. On result slides, show only the rows and columns being discussed.

During the compression pass, remove in this order: repeated headline claims; prose that restates a figure or equation; catalogue-like robustness lists; full sentences that can become labels; and source detail better handled by a footnote or script. Do not remove variable construction, identifying variation, estimand, units, reference groups, uncertainty, or evidentiary qualifications merely to reduce word count.

## Speaker script

For each result slide, make the spoken explanation answer:

1. what question this analysis addresses;
2. what the authors compare or estimate;
3. what the result is;
4. how the authors interpret it;
5. what qualification is needed to state it accurately.

Do not recite every coefficient or control. Guide attention to the exact row, column, line, or point being discussed.

## Final fidelity check

Before delivery, verify:

- the presentation's headline matches the paper's headline;
- the theoretical and empirical sections use the paper's terminology consistently;
- the main estimates match the source tables and units;
- the talk does not upgrade association, mechanism evidence, heterogeneity, or robustness into a stronger claim;
- table transformations preserve the specification and sample distinctions;
- the conclusion reflects the paper rather than an unsolicited critique or redesign;
- backup slides contain the detail most likely to be useful without crowding the main story.
