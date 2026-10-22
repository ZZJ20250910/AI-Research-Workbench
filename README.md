# AI Research Workbench

自用科研 AI Skill 存档，集中保存日常使用、持续适配和改进的科研工作流。当前通过统一入口 `/ai-research` 按需进入实证回归、论文阅读、写作风格蒸馏、防御性写作修订、论文演示、经管文献匹配和逐段论文学习等能力包。

本仓库首先服务于个人工作流，不保证对所有电脑、软件版本或研究任务开箱即用。安装、迁移或修改前请先阅读：

- [README FOR HUMAN.md](README%20FOR%20HUMAN.md)：能力包、使用方法和设计原则；
- [README FOR AI.md](README%20FOR%20AI.md)：交给AI执行的整包安装入口；
- [GitHub私有分发与更新方案.md](GitHub私有分发与更新方案.md)：私有仓库和只读Deploy Key方案的历史说明。

## 当前能力包

1. `01-Empirical Regression`：实证回归、识别检验、稳健性、机制和异质性工作流；
2. `02-Data Paper`：实证论文及附录的结构化导读；
3. `03-Writing DNA`：从完整文章语料中蒸馏可复用写作风格；
4. `04-Defensive Writing Revision`：受证据约束的防御性写作诊断与修订；
5. `05-Paper to Slides`：论文转LaTeX Beamer演示、讲稿和证据记录；
6. `06-Econ Reference Matcher`：经管论文引用匹配与证据核验；
7. `07-Study Paper`：论文逐段定位、压缩和回查。

## 参考与改进来源

部分流程参考或改编自公开项目。本仓库保留对应作者、来源和子目录许可证，不主张这些项目的原创权：

- 实证研究框架参考：[Auto-Empirical-Research-Skills](https://github.com/brycewang-stanford/Auto-Empirical-Research-Skills)、[StatsPAI](https://github.com/brycewang-stanford/StatsPAI)、[Awesome-Journal-Skills](https://github.com/brycewang-stanford/Awesome-Journal-Skills)、[AER-Skills](https://github.com/brycewang-stanford/AER-Skills)、[Auto-Research-Skills](https://github.com/brycewang-stanford/Auto-Research-Skills)；
- `05-Paper to Slides` 改编自 [yigengjiang/paper-to-slides](https://github.com/yigengjiang/paper-to-slides)；
- `06-Econ Reference Matcher` 改编自 [mimaowang/econ-reference-matcher](https://github.com/mimaowang/econ-reference-matcher)；
- `04-Defensive Writing Revision` 的原作者、共创者和MIT许可证保留在该目录的 [README](04-Defensive%20Writing%20Revision/README.md) 与 [LICENSE](04-Defensive%20Writing%20Revision/LICENSE) 中。

各子目录可能采用不同许可证。根目录未单独声明许可证的内容不因公开可见而自动获得开源许可，使用或再分发前请分别检查相应目录。
