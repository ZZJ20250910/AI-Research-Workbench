---
name: study-paper
description: Create a faithful paragraph-by-paragraph Markdown map of an academic paper after the user selects 07-Study Paper in AI Research Workbench. Use when the user supplies or identifies a PDF, DOCX, HTML, Markdown, text paper, or an entry in a local paper index and wants every prose paragraph numbered, locally traceable, and compressed in the paper's own language into no more than three plain, faithful sentences. This package is entered through /ai-research and is not registered as a separate slash command.
---

# Study Paper

Create a navigable paragraph map that lets the user follow a paper's structure and lets a later AI locate the corresponding source passage quickly. Do not turn the map into a review, interpretation, teaching note, or Data Paper-style empirical handover.

## Resolve the source and destination

1. Use a directly supplied paper when available. If the user identifies an entry such as `RS-01` in a local paper index, read the index, resolve that entry to the paper file, and record both the index entry and resolved file.
2. Treat the directory containing the user-specified output file or paper index as the output root unless the user names another destination.
3. Create or reuse `Temp` directly under the output root. Put every newly generated intermediate artifact there: extracted text, rendered pages, OCR output, conversion files, draft maps, notes, helper scripts, and logs.
4. Save only the completed Markdown map outside `Temp`. Never modify, rename, move, or overwrite the source paper or index.
5. When the user specifies only an output directory, use a stable source identifier in the filename, such as `RS-01-段落索引.md`; otherwise use a concise paper-title-based name. Do not overwrite an existing final map without explicit authorization.

## Read and reconstruct the paper

1. Inventory the identified paper and any files required to read it, but do not expand the task to unrelated materials.
2. Use the applicable PDF or document skill for the source format. For PDFs, perform one primary embedded-text extraction. Do not routinely create parallel raw, layout, block-inventory, HTML, JSON, and OCR copies of the same paper.
3. Reconstruct reading order carefully for multi-column pages, page breaks, hyphenation, headers, footers, and text interrupted by figures, tables, or displayed equations. A visual paragraph that continues across a page, column, extraction block, or displayed equation remains one paragraph. Never treat a lowercase continuation after a displayed equation as a new paragraph merely because the PDF extractor emitted a new block.
4. Follow the paper from beginning to end. Cover the abstract, main prose, acknowledgements when present, substantive footnotes or endnotes, and narrative appendix text. Preserve displayed headings, but do not treat a heading alone as a prose paragraph.
5. Do not turn standalone equations, table cells, bibliographic entries, page headers, or page footers into `P-XX` paragraphs. Include a figure or table caption/note only when it contains substantive prose; label its source type in the locator. Treat a genuine list as one paragraph when it expresses one continuous unit, or as separate paragraphs when its items are independently substantive.
6. Detect suspicious locations mechanically before visual inspection: private-use or replacement glyphs, broken reading order, lowercase sentence fragments, implausibly short prose blocks, duplicate headers, and paragraphs split around equations. Render and inspect only those pages plus a small structural sample; do not render the whole paper by default.
7. If a passage is unreadable, preserve its position with the next paragraph number and mark the precise limitation. Never silently omit it or infer missing content.
8. Create and retain one canonical UTF-8 source map under `Temp`, named with the stable paper identifier, for example `Temp/RS-01-source-map.md`. Normalize it into the paper's true reading order and store every original prose paragraph under the same unique `P-XX` label used by the final summary map. Include its section and source-page metadata. This file is a durable navigation aid for later AI use, not a disposable draft; do not delete or casually regenerate it after delivery.

Use this source-map pattern:

```markdown
## P-37

**Source:** PDF p. 12 · Section 3.2

<verbatim original paragraph in normalized reading order>
```

## Number and locate every paragraph

1. Number prose paragraphs continuously from the beginning to the end of the paper as `P-1`, `P-2`, and so on. Never restart numbering at a new section.
2. Reproduce the paper's own section and subsection hierarchy with Markdown headings. Keep the paper's displayed numbering and heading language. Do not invent a new topical outline.
3. Put every locator in a single Markdown blockquote immediately below the `P-XX` heading so it remains visually secondary and consumes minimal space. Give it:
   - its unique `P-XX` anchor in the canonical source map;
   - PDF page number or the equivalent source location as a secondary check;
   - current section or source type, such as footnote, figure note, or appendix;
   - a short exact opening-text anchor from the source, normally 6–15 words.
4. Treat the retained source map as the primary navigation surface. A later AI should be able to open the path recorded at the beginning of the final map, search for the exact `P-XX` heading, and read the original paragraph immediately without scanning from the beginning or relying on unstable extracted-text line numbers.
5. Use the exact opening anchor and PDF page to verify the source-map match or recover from a moved file. Preserve original capitalization and wording in the anchor, using an ellipsis only to show truncation. When one paragraph spans multiple pages, show the page range. When several paragraphs begin with the same words, lengthen the anchor enough to distinguish them.

Use this pattern:

```markdown
### P-37

> *Source:* source map `P-37` · PDF p. 12 · Section 3.2 · “We next examine whether...”

The authors find that the baseline estimate remains similar after adding the full set of controls, although its precision declines in the smaller sample.
```

## Compress faithfully

For every `P-XX`:

1. Summarize only what the source paragraph says. Do not add its supposed argumentative function, authorial intention, criticism, implications, background knowledge, or facts from elsewhere in the paper.
2. Prefer one sentence. Use two or three sentences only when one sentence would lose important content or qualifications. Never exceed three sentences.
3. Write an English summary for an English source paragraph and a Chinese summary for a Chinese source paragraph. For a multilingual paper, follow the language of each paragraph unless the user requests one output language.
4. Make the compression as plain and easy to understand as accuracy permits. Preserve the paper's key terms, variable names, theory names, institutional labels, and other terminology rather than replacing them with loose synonyms.
5. Preserve material qualifications: attribution, comparison group, direction, magnitude, uncertainty, scope, exceptions, contrast, and causal or non-causal wording when they matter to the paragraph's meaning.
6. Do not strengthen a claim, resolve ambiguity, merge information from neighboring paragraphs, or mechanically copy the paragraph. Do not produce keywords or fragments in place of a summary.
7. When a paragraph is purely transitional, procedural, or organizational, compress that literal content without inventing substantive findings.
8. Never copy corrupt PDF glyphs or malformed extracted mathematics into the final summary. For a formula-bearing paragraph, state faithfully in plain language what the paragraph defines or says. Preserve a short formula only when it is essential, can be verified visually, and can be written as valid Markdown math; otherwise leave the formula in the source map or original PDF.

## Keep the workflow lean

1. Extract and segment once, then use the canonical source map as the sole working text for summarization.
2. Summarize in sequential batches without repeatedly rereading earlier batches or the full PDF. Write completed batches incrementally to one draft under `Temp`.
3. Use deterministic checks for numbering, sentence-count limits, missing summaries, broken glyphs, and source-map alignment. Spend model reading and visual inspection only on flagged passages.
4. Reuse valid existing extraction and source-map artifacts when revising a prior run. Do not restart from the PDF unless the existing artifact is incomplete or demonstrably wrong.
5. Keep only the canonical source map, one working draft when needed, targeted page renders, and minimal logs. Do not create redundant representations merely for reassurance.

## Build the final Markdown

Use this structure:

```markdown
# <paper identifier or title> — Paragraph Map

## Source

- **Paper:** <title>
- **Local file:** `<absolute path>`
- **AI source map:** `<absolute path to Temp/<identifier>-source-map.md>`
- **Index entry:** <identifier and index path, when applicable>
- **Source language:** <language>
- **Paragraph count:** <final count>

## <first displayed section>

### P-1

> *Source:* <stable locator>

<one-to-three-sentence faithful compression>
```

Keep front matter concise. Do not add a separate overall summary, evaluation, glossary, question set, citation analysis, or method critique unless the user explicitly requests it as a separate task.

## Verify before delivery

1. Compare all mechanically flagged passages against the paper and spot-check the beginning, middle, end, and section transitions. Perform a full page-by-page visual comparison only when extraction quality is broadly unreliable.
2. Confirm that paragraph numbering is consecutive, unique, and complete and that the reported paragraph count matches the final `P-XX`.
3. Spot-check every source-map `P-XX` anchor and all duplicated opening phrases; confirm that a later AI can open the recorded source-map path, search the paragraph label, and reach the intended original paragraph directly without scanning from the beginning.
4. Confirm that every summary stays within one to three sentences, matches the source paragraph's language, preserves important qualifications and terminology, contains no added analysis, and contains no corrupt private-use or replacement glyphs.
5. Confirm that all intermediate artifacts are under the output root's `Temp` directory, the canonical source map remains available at the exact path recorded in the final map, and the source files remain unchanged.
6. Save the completed map at the requested location and report its exact path and any precisely bounded unreadable passages.
