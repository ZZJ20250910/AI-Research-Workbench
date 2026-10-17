# Visual design and templates

The template is in `assets/template/`. `main.tex` is a compilable gallery with a title page, contents page, five part dividers, and eleven synthetic content layouts; `config.tex` contains metadata, colors, progress labels, and font options; `paper-slides.sty` implements the reusable theme. Copy the whole directory and replace the examples with the paper's content. The template has no real affiliation, contact information, or external logo by default.

## Configuration

- Edit `\title[Short title]{Full title}`, `\subtitle`, `\author{Anonymous Authors}`, `\Presenter`, `\institute`, `\Contact`, `\TalkType`, and `\date` in `config.tex`. Keep event and institution names on the title slide; do not repeat a right-aligned event label in every frame header.
- `SlideBlue` controls headings and rules; `SlideGray` controls takeaways and the footer; `SlideRed` and `SlideGreen` provide emphasis; `SlideLight` supplies pale blue backgrounds; `SlideInk` is the body-text color. Pair color with text, symbols, or shapes instead of relying on red/green distinctions alone.
- English slides default to XeLaTeX. `\LatinFontName` defaults to Constantia for titles, prose, tables, and Latin letters; `\DigitFontName` defaults to TeX Gyre Heros for every Arabic digit. Both fonts must be installed. The theme does not silently substitute fonts; if Constantia is unavailable, report that dependency before selecting another face.
- For Chinese slides, use XeLaTeX and set `\ChineseSlidestrue`. The default ctex font set is `fandol`, with FandolHei for Chinese sans-serif text; these fonts ship with TeX distributions. Change `\CJKFontSet` only to an available ctex font set. Avoid dependencies on platform-specific commercial fonts. A Chinese script accompanying English slides does not require an engine change.
- Use `\cite` for references. Add a reference slide when needed, with `\bibliographystyle{plain}` and `\bibliography{strings,refs}`, or another available BibTeX style. Replace synthetic bibliography entries with real sources from the paper.

## Choose layouts to fit the content

The gallery includes title, two-column explanation, method overview, equation or algorithm, results table, figure analysis, summary, closing, original-figure overview, and detail-with-explanation layouts. Select and combine them as appropriate; do not require all ten. Usually give each slide one main claim and write its takeaway as a short, verifiable sentence.

- Start with `\normalsize` in the 10pt Beamer template. Remove content or split slides before reducing type size. Do not shrink a whole slide with `\tiny` or `shrink` to make it fit.
- Use Constantia for titles, body text, tables, and Latin variable letters. Use TeX Gyre Heros for all Arabic digits in ordinary text and mathematics. The theme assigns ASCII `0`--`9` to the digit face explicitly because loading a font alone does not prove that text digits use it. Keep mathematical symbols in math mode, but set descriptive multi-letter variable names with `\varname{}`. Define equations compactly and explain long constructions below them instead of placing prose-length sentences inside a fraction.
- Let the title block determine its own height. Place the blue rule immediately below the last rendered title line; never reserve two-line height for a one-line title.
- Keep the top progress navigator visible on every frame. Use five short part labels and place each section's page circles directly below its label. Make section widths roughly proportional to their page counts so the labels and markers describe the same structure. Use one circle per PDF page: blue filled circles for completed pages, a visibly larger red filled circle for the current page, and white-centered gray outlined circles for future pages. The outline and center must remain distinguishable at normal presentation scale. Update the configured inclusive page ranges whenever the slide order changes.
- Reserve about one line of clear space between the navigator and the frame canvas. Apply it globally so frame titles, rules, subtitles, section pages, and ordinary content share the same lower starting position while the footer remains fixed.
- Order title-page identity lines as presenter, full institution, then email. Put each on its own line and encode the email as a `mailto:` hyperlink rather than plain text. Keep these fields empty when the talk is anonymous or the user has not supplied them.
- Keep only table rows and columns needed to support the claim, along with units and evaluation conditions. Put complete results in backup slides. Avoid scaling a long table until it becomes unreadable.
- Prefer vector PDFs, followed by original high-resolution raster images. Use `\includegraphics[width=...,height=...,keepaspectratio]` to avoid distortion and relative paths under `figures/`.
- Use the original-figure overview and detail-with-explanation layouts for core paper figures. The synthetic vector asset under `figures/` includes editable LaTeX source and compiles without the paper repository.
- Introduce equation symbols and conditions before emphasizing the main relationship. Break long equations across lines. In algorithm slides, retain the control flow needed for understanding.
- Allow long titles to wrap naturally. The heading, takeaway, footer, and body share limited vertical space. Shorten slide titles or header affiliations, or split the slide when crowded; do not let headings cover the body.

## Preserve and explain original figures

Give a core original enough space to lead the slide. Use the supplied original asset unchanged by default, even when its labels differ from the slide language. Do not replace it with text blocks or a simpler redraw for layout convenience, and do not place it only in backup when it explains the main contribution. Prefer the standalone source asset, then a vector-preserving crop from the paper PDF. Use original high-resolution raster content when that is the available source; vector cropping cannot recover absent detail. Add translated context outside the figure when needed; redraw only when the original is unavailable, unreadable after reasonable enlargement or cropping, materially misleading, or the user explicitly requests it.

Keep the original layout, palette, arrows, symbols, and panel order. Apply the slide theme to surrounding titles, captions, and annotations without requiring the figure to be recolored. Boxes, numbered markers, and side notes can guide attention if they do not obscure labels or evidence. Attribute the original visibly and record crops and added annotations separately in `sources.md` and nearby `.tex` comments. Label redraws as presenter illustrations and use them to supplement the original by default. If replacement is necessary, document the specific availability, quality, or unresolved communication problem.

For a complex figure, use **complete overview plus necessary detail views**. The overview establishes spatial and structural relationships; zoom pages explain the required details. Keep legends, axis units, panel identifiers, and enough boundary context to interpret the crop. Show or name the zoom's location in the overview; include incoming connections when they are essential to the explanation. Essential small labels need readable enlargements or faithful nearby transcription, not a claim that a high-resolution render alone makes them legible on a projected slide.

The gallery's last two layouts demonstrate this with the same self-created synthetic figure: an unchanged full view, then a crop of panel (b) with its incoming edge and an explanation outside the image. Its purple/orange palette intentionally differs from the blue slide theme. `figures/synthetic-method.tex` is the editable standalone source, and the bundled PDF lets the gallery compile immediately. See [the template build notes](../assets/template/BUILD.md) for regenerating that asset. These are layout examples, not real paper evidence.

Keep a useful figure with an explicit discrepancy note when the issue is local. For RRSI Figure 2, explain the regularization-label conflict documented in [Paper reading and provenance](paper-reading.md); do not silently relabel the original or drop the entire method figure.

## Present empirical tables

Treat evidence-bearing tables as first-class visuals. For empirical economics and related work, a compact transcription or coefficient plot is often more faithful to the oral task than an unreadable full-table screenshot. Follow `economics-presentations.md`: preserve exact estimates and uncertainty, label samples and specifications, cite original columns, and move useful full tables to backup. Do not use visual simplification to hide null, adverse, or specification-sensitive results.

## Visual inspection

Render every page to assess composition, whitespace, and pacing. Enlarge dense tables, equations, headers, and figure labels. Check whether the takeaway wraps too far below the blue rule, whether the footer collides with a figure, and whether a long affiliation overlaps the title. Inspect PDF metadata and the cover for compliance with anonymity requirements.

Build logs catch only some overflows. A warning-free build can still contain unreadable type, clipped labels inside images, or overlapping TikZ nodes. After a local edit, rerender affected pages. After changing the theme or global fonts, inspect every page again.
