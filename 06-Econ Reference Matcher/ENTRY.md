# Econ Reference Matcher：入口

本能力包只有一个工作流，不设置第二层编号菜单。

1. 用户在 AI Research Workbench 中选择 `06-Econ Reference Matcher` 后，完整读取 `skills/econ-reference-matcher/SKILL.md`。
2. 如果用户已经提供论文、章节、上下文或需要匹配引用的具体文段，直接按照该 Skill 执行，不重复询问已提供的信息。
3. 如果尚未提供目标文段，只询问需要寻找或核验引用的准确句子、段落或文件位置；论文上下文、期刊筛选和用途等信息仅在会实质影响结果时补充询问。
4. 按 Skill 的明确路由读取 `skills/econ-reference-matcher/references/`，并仅在有助于当前任务时使用其辅助脚本。不得用词语重合度代替文献证据判断。
5. 检索依赖当前宿主可访问的网页、数据库、用户提供的全文和合法期刊清单。不得声称搜索了实际无法访问的 EconLit、Web of Science、JCR 或其他专有来源。
6. 最终成果写入用户指定的论文或项目目录；未指定输出目录时，先在对话中报告结果，不修改原稿，也不把私人稿件、付费全文或专有数据库导出写入 Workbench。
7. 不读取其他 Workbench 能力包。除非用户另行明确要求，不把引用匹配扩展为整篇论文导读、全文修订或新研究设计。

