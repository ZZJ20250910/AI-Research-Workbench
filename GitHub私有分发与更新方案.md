# AI Workbench：GitHub 私有分发与更新方案

## 一、目标

将整个 `AI Workbench` 保存到 GitHub 私有仓库，同时满足：

- 仓库日常保持私密；
- 不把使用者添加为仓库协作者；
- 只有获得授权的人能够下载和更新；
- 维护者推送新版本后，使用者可以直接拉取最新版；
- 可以单独撤销某个使用者的后续访问权限。

采用方案：**Private Repository + 每位使用者独立的只读 Deploy Key**。

## 二、工作结构

```text
维护者本地 AI Workbench
        ↓ git push
GitHub Private Repository
        ↓ 每人独立的只读 Deploy Key
使用者本地 AI Workbench
        ↓ git pull
取得最新版本
```

Deploy Key 是直接绑定到单个仓库的 SSH 密钥。默认只读；添加时不得勾选 `Allow write access`。

## 三、维护者首次建立仓库

1. 在 GitHub 新建 Private Repository。
2. 将整个 `AI Workbench` 上传到该仓库。
3. 提交前检查并排除：
   - `Temp` 中的运行草稿和测试产物；
   - 具体科研项目的数据、日志和结果；
   - 密码、Token、SSH 私钥和其他凭据；
   - 仅适用于维护者电脑且不应公开的个人信息。
4. 保留通用 Skill、代码模板、安装说明和本机适配逻辑。

建议在 `.gitignore` 中固定排除临时文件和本机运行产物，避免后续误上传。

## 四、授权一位新使用者

### 1. 使用者生成独立密钥

使用者在自己的电脑生成一对专用于本仓库的 SSH 密钥：

```powershell
ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\ai_workbench_readonly" -C "AI Workbench read-only"
```

生成：

- `ai_workbench_readonly`：私钥，只能保存在使用者电脑，不得发送；
- `ai_workbench_readonly.pub`：公钥，发送给维护者。

### 2. 维护者添加只读 Deploy Key

进入 GitHub 私有仓库：

```text
Settings → Deploy keys → Add deploy key
```

填写：

- Title：能够识别使用者或设备的名称；
- Key：粘贴对方提供的 `.pub` 公钥；
- `Allow write access`：**不得勾选**。

每位使用者、每台需要单独撤销权限的设备都使用不同密钥。不得多人共用同一私钥。

### 3. 使用者首次下载

在 SSH 配置中为该密钥建立专用别名：

```text
Host github-ai-workbench
    HostName github.com
    User git
    IdentityFile ~/.ssh/ai_workbench_readonly
    IdentitiesOnly yes
```

随后克隆：

```powershell
git clone git@github-ai-workbench:仓库所有者/仓库名称.git "本地安装位置"
```

克隆完成后，按根目录 `README FOR AI.md` 执行安装，并由 `01-Empirical Regression/00D-静默安装与本机适配.md` 完成本机适配。

## 五、日常更新

维护者更新能力包后执行：

```powershell
git add .
git commit -m "说明本次修改"
git push
```

使用者在本地仓库执行：

```powershell
git pull --ff-only
```

更新后，如果本次变更涉及本机路径、Stata、Python、R或Skill注册方式，应重新读取 `README FOR AI.md`，并按其中要求运行本机适配。

`git pull --ff-only` 遇到本地修改冲突时会停止，不会自动覆盖使用者的改动。此时应先备份本地修改，再决定保留、提交或放弃哪些内容。

## 六、撤销访问

进入：

```text
Settings → Deploy keys
```

删除对应使用者或设备的 Deploy Key。删除后，该密钥不能继续 clone 或 pull。

撤销只影响后续访问，无法删除对方此前已经下载到本地的副本。因此只应向可信对象授权，不应把仓库内容视为能够远程收回的材料。

## 七、权限和安全边界

- 使用者不能通过只读 Deploy Key 向仓库 push；
- 使用者通常不能在 GitHub 网页中浏览该私有仓库，只能通过 Git/SSH 下载和更新；
- Deploy Key 默认不设到期时间，维护者应定期检查并删除不再使用的密钥；
- 私钥泄露等同于该仓库的只读访问权泄露，应立即删除相应 Deploy Key 并重新生成；
- 不得把维护者的 GitHub Token、账户密码或个人 SSH 私钥交给使用者；
- 不建议临时将私有仓库改为公开，因为公开期间的下载和 Fork 无法真正收回。

## 八、后续自动化方向

可以在根目录增加两个脚本：

- `install.ps1`：检查 Git、SSH 和目录，完成首次克隆并调用本机适配；
- `update.ps1`：执行 `git pull --ff-only`，显示版本变化，并在需要时调用本机适配。

脚本不得在仓库中保存任何私钥、密码或访问 Token。私钥始终由使用者本人保存在自己的电脑。
