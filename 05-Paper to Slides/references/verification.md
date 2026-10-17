# Verification and delivery

## Output directory

```text
paper-talk/
  main.tex
  config.tex
  paper-slides.sty
  figures/                 # Create when needed.
  strings.bib              # Keep when references use string definitions.
  refs.bib
  main.pdf
  speaker-script.md
  sources.md
  BUILD.md
  build-report.json
```

Deliver only the files the presentation needs. Keep the source, styles, figures, data, and bibliography local. Do not reference `../original-paper` or the skill's installation directory. Document custom fonts, packages, and redistribution restrictions; do not bundle commercial fonts by default. Generate auxiliary files through compilation rather than editing them manually.

## Automated build

```bash
python /path/to/skill/scripts/build_slides.py /path/to/paper-talk/main.tex --engine pdflatex --strict
# Slides containing Chinese:
python /path/to/skill/scripts/build_slides.py /path/to/paper-talk/main.tex --engine xelatex --strict
```

The helper runs latexmk in the main file's directory, including BibTeX and the compilation passes needed to resolve references. It disables shell escape, ignores user and project latexmkrc files, and uses one engine consistently. The JSON summary lists errors, missing glyphs, unresolved references, overflows, and other warnings. Strict mode returns a nonzero exit code for the first four categories. Full command output is saved as `main.build-output.txt`; the original `.log` is retained.

The default report is `build-report.json` beside the main file. Use `--report` to separate reports for multiple entry points in the same directory. When changing engines, remove the entry point's generated auxiliary files in the output copy or use a fresh directory. `--timeout` sets the build timeout.

The output must also compile without the helper. For English slides:

```bash
latexmk -norc -pdf -interaction=nonstopmode -halt-on-error -file-line-error -pdflatex="pdflatex -no-shell-escape %O %S" main.tex
```

For Chinese slides, replace the engine options with `-xelatex -xelatex="xelatex -no-shell-escape %O %S"`. Put the actual engine, dependencies, and command in `BUILD.md`.

## Acceptance checks

1. **Fidelity and facts:** Verify that the talk preserves the paper's research question, argument, evidence hierarchy, findings, and conclusion. Check key numbers, units, differences, provenance, comparison conditions, ties, and declines. Distinguish paper conclusions from presenter analysis, with source locations in comments.
2. **Formula coverage and notation:** Compare the formula inventory with the final deck. Confirm that every equation or construction defining a central object, theoretical prediction, estimand, identification strategy, or nonstandard mechanism variable is either shown or has a substantive recorded reason for omission. Verify every displayed symbol, denominator, threshold, reference set, aggregation level, lag, window, baseline year, and leave-one-out rule against the source. Check that notation is consistent across slides and that presenter reformulations are labeled in `sources.md`.
3. **Complete figure coverage:** Reconcile the paper's numbered figures with the complete inventory and final deck. Confirm a disposition for every main-text, appendix, and supplied-supplement figure: complete original, faithful crop, overview plus zoom, faithful redraw, combined view, or substantive omission. Check visible attribution, transformation records, and script pointing cues. Confirm essential text is readable at final slide size; crops and redraws preserve axes, units, legends, reference periods, panel labels, uncertainty, sample distinctions, and context without changing meaning. Verify that local conflicts are disclosed rather than silently repaired. A paper with no numbered figures passes without forced imagery.
4. **Empirical tables:** For every compact table, selected-column view, result card, or coefficient plot, compare the displayed values and uncertainty with the original table and columns. Verify units, samples, specification changes, significance or intervals, and any presenter calculation. Confirm omitted detail is not necessary to understand the stated result and place useful full tables in backup.
5. **Narrative economy and carrier separation:** Check whether repeated statements of the same story or coefficient occupy space needed to explain theory, variable construction, estimands, or identification. Check title versus takeaway, takeaway versus body, prose versus figure, prose versus equation, adjacent slides, and conclusion versus earlier claims. When a figure, formula, or table carries a point, remove its full verbal duplicate and place only necessary interpretation in the script. Preserve purposeful reminders, but require every repeated appearance to add evidence, qualification, mechanism, or implication.
6. **Compilation:** Confirm the current PDF builds without errors, missing glyphs, unresolved references, or overflows. Review other warnings, including font substitutions, individually.
7. **Every page:** Render and inspect all PDF pages. Enlarge dense figures and tables at higher resolution. Do not inspect only the first page or assume a contact sheet proves all small labels are readable.
8. **Script:** Match entries to actual PDF pages. Recalculate cumulative time and the approximately 10% buffer. Exclude backup slides from the main-talk budget. Confirm the script carries necessary interpretation removed from crowded slides without duplicating visible wording. For equation slides, explain economic role and construction rather than reading symbols line by line. For figure slides, provide a specific pointing order using actual axes, panels, lines, or regions.
9. **Portability:** Copy source, figures, styles, and bibliography to another directory without previous `.aux`, `.bbl`, `.log`, `.fls`, `.fdb_latexmk`, generated PDF, or other build artifacts. Compile from scratch. Check `\input`, figure paths, and `.fls` entries for dependencies on the original project.
10. **Delivery:** Include source, resources, PDF, script, build instructions, and provenance. State the actual verification scope and any failures.

## Checks for skill maintenance

For changes affecting generation or tooling, check the reusable theme and numeric provenance; multi-file LaTeX; local PDF; a real accessible paper link, recording any source-to-PDF fallback; absence of example-specific content or affiliations in a new deck; all-Chinese slides; English slides with a Chinese script; long titles and affiliations; and recompilation after moving the output directory. Choose checks relevant to the change and create temporary fixtures when needed.

The [Transformer oral example](../examples/attention-oral-10min-original-figures/BUILD.md) is a generated output sample, not a comprehensive test suite. Its [verification record](../examples/attention-oral-10min-original-figures/verification.md) describes that particular deck. Run maintenance checks in an isolated temporary directory and keep historical checks distinct from the current run.

When maintaining the original-figure workflow, generate isolated method/architecture specimens with main-talk full views, necessary zooms, provenance, and pointing cues. RRSI Figure 2 exercises a local figure/prose conflict; Transformer Figure 1 exercises a tall architecture and connected detail. Preserve existing accepted presentations. Use the gallery's synthetic asset for reusable layouts, keeping third-party test figures out of the template.

Include a theoretical or survey example to check that the narrative does not force every paper into an experimental structure or force in figures when none are useful. Use explicit ties, percentage-point differences, and relative changes to exercise the numeric guidance. Execute new or changed PDF and build helpers, including useful diagnostics for unreadable files and missing dependencies. Run the official `skill-creator/scripts/quick_validate.py` after changing the skill. Its format checks do not replace content, behavioral, or visual verification.

For documentation or packaging changes, check skill format, UI metadata, local links, language consistency, and preservation of workflow requirements. Rebuild a moved example from a clean source copy to check portability. If the official `skill-creator/scripts/quick_validate.py` is available in the development environment, run it; it is not a runtime dependency of this repository. Broaden build or script checks when source, styles, scripts, or unresolved concerns justify it.
