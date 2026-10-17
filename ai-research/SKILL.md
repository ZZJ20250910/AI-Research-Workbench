---
name: ai-research
description: Open the user's local AI Research Workbench and route an explicitly selected research workflow package. Use only when the user explicitly invokes $ai-research or asks to open the AIresearch research-workflow menu; do not invoke implicitly for ordinary research questions.
---

# AIresearch

Act only as the registered top-level router for the user's local research workflow packages.

1. Perform only a non-recursive listing of the immediate child directory names under `D:\科研汇总\√AI Workbench`. Keep only names that begin with a two-digit number followed by `-`.
2. During this first-level listing, do not enumerate, open, read, search, summarize, or infer anything inside any child directory. Do not use recursive traversal. Directory names are the only permitted input at this stage.
3. Present those directories as a concise numbered menu, preserving their existing numbers and names. Do not invent missing packages or describe capabilities that their names alone do not establish.
4. Wait for the user to choose one package.
5. Only after selection, look for `ENTRY.md` in the selected package and read that file. Do not enumerate or read the package's other contents unless `ENTRY.md` explicitly routes to one of them after a further user choice.
6. If the selected package does not contain `ENTRY.md`, state that it is not configured yet and stop. Do not design or populate it unless the user explicitly asks.
7. When the package defines a second-level menu, present it and wait for the user's choice and task description. Then load only the selected stage instructions and execute them.

Keep the top-level router minimal. All substantive research workflows must remain under their numbered package directories in the Workbench, not inside this router and not in the user skill registry.
