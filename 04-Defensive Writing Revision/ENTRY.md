# Defensive Writing Revision：入口

本能力包只有一个工作流，不设置第二层编号菜单。

1. 用户在 AI Research Workbench 中选择 `04-Defensive Writing Revision` 后，完整读取同目录下的 `SKILL.md`。
2. 如果用户已经给出论文或材料位置，并说明要进行诊断还是修改，直接按照 `SKILL.md` 执行，不重复询问已提供的信息。
3. 如果材料位置或任务类型尚未明确，只询问缺少的必要信息。只要求诊断时保持只读；只有用户明确授权修改时，才进入修改阶段。
4. 按 `SKILL.md` 的明确要求读取 `references/`、`scripts/` 和 `assets/` 中的对应文件；不要在入口阶段预先遍历整个能力包。项目专用规则只在目标项目符合条件时读取。
5. 不读取其他 Workbench 能力包；不得把诊断授权扩大为修改、投稿、新研究或证据补充。
