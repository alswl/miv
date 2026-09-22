# miv

**miv** —— 个人 Vim / NeoVim 配置。

[English](README.md) | [简体中文](README.zh-CN.md)

一份配置，两个编辑器：Vim 直接读取 `.vimrc`；NeoVim 通过 `init.lua`
→ `legacy.vim` → `.vimrc` 复用同一套配置，再叠加 Lua 插件层。插件由
[vim-plug](https://github.com/junegunn/vim-plug) 管理，且已内置于仓库中，
无需额外安装。

![Vim](https://img.shields.io/badge/editor-Vim-green) ![NeoVim](https://img.shields.io/badge/editor-NeoVim-57a143) ![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue)

## 亮点

- **开箱即用** —— 多语言语法高亮、缩进与折叠，多光标、UltiSnips 代码片段、
  表格编辑与对齐，以及 insert/command 模式下的 Emacs 风格按键。
- **NeoVim 现代化层**：
  - [fzf-lua](https://github.com/ibhagwan/fzf-lua) 模糊查找，附带
    Git 感知的 picker（分支改动、未提交状态、最近文件）。
  - [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) 文件树
    与 [aerial.nvim](https://github.com/stevearc/aerial.nvim) 符号大纲。
  - Git 工具箱：[fugitive](https://github.com/tpope/vim-fugitive)、
    [diffview.nvim](https://github.com/sindrets/diffview.nvim)、
    [git-worktree.nvim](https://github.com/polarmutex/git-worktree.nvim)
    （状态栏显示分支 / worktree）。
  - [conform.nvim](https://github.com/stevearc/conform.nvim) 按需格式化
    （prettier、stylua、ruff、shfmt…）。
  - Markdown 写作套件：缓冲区内渲染
    （[markview.nvim](https://github.com/OXY2DEV/markview.nvim)，Obsidian 风格）、
    列表自动续写（[markdown-plus.nvim](https://github.com/yousefhadder/markdown-plus.nvim)）、
    剪贴板图片粘贴（[img-clip.nvim](https://github.com/HakonHarnes/img-clip.nvim)）、
    [live-preview.nvim](https://github.com/brianhuster/live-preview.nvim)
    浏览器实时预览，支持本地 PlantUML/D2 图表渲染。
  - 主题：默认 [jb.nvim](https://github.com/nickkadutskyi/jb.nvim)
    （`ToggleTheme` 切换深浅色），备选
    [Everforest](https://github.com/sainnhe/everforest) 与
    [Nordfox](https://github.com/EdenEast/nightfox.nvim)。

> [!TIP]
> NeoVim 的键位会覆盖共用的 Vim 默认值，因此下文表格中会标注各按键
> 所属的编辑器。

## 安装

一条命令完成全部初始化 —— 创建符号链接、自动备份已有文件、安装插件：

```bash
git clone https://github.com/alswl/miv.git
cd miv
./install.sh
```

> [!NOTE]
> 脚本可重复执行且绝不覆盖：已存在的 `~/.vimrc`、`~/.vim` 或
> `~/.config/nvim` 会先被移到 `<名称>.backup-<时间戳>` 再创建链接。

习惯手动操作？

```bash
# 创建符号链接（-n 会替换已有的目录链接，而不是嵌套进去）
ln -sfn "$(pwd)/.vim"   "$HOME/.vim"
ln -sf  "$(pwd)/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.config"
ln -sfn "$(pwd)/.config/nvim" "$HOME/.config/nvim"

# 安装插件（任选一个编辑器；plug.vim 已内置）
vim  +PlugInstall +qa
nvim +PlugInstall +qa
```

依赖：[Vim](https://www.vim.org/) 或
[NeoVim](https://neovim.io/)，以及 Git。macOS 可选：
[`pngpaste`](https://github.com/jcsalterego/pngpaste)，用于剪贴板图片粘贴
（`brew install pngpaste`）。

## 目录结构

| 路径 | 说明 |
|------|------|
| `.vimrc` | 主配置：插件列表、键位映射、常规与文件类型设置 |
| `.vim/` | UltiSnips 代码片段、autoload、ftplugin、syntax、templates |
| `.config/nvim/init.lua` | NeoVim 入口：加载旧版配置，再加载 Lua 插件与键位 |
| `.config/nvim/legacy.vim` | 设置 `runtimepath` 并 source `~/.vimrc` |
| `.config/nvim/lua/config/` | 各插件的 Lua 配置：`neo_tree`、`fzf`、`git_worktree`、`diffview`、`img_clip`、`live_preview`、`theme` |

## 键位

`<leader>` 即默认的 `\`。

### 界面与导航

| 按键 | 功能 |
|------|------|
| `F1` / `<leader>f` | 开关文件树 —— neo-tree.nvim（NeoVim）/ NERDTree（Vim） |
| `O` / `gO` *（文件树内）* | 用系统默认程序打开条目 / 在文件管理器中显示（neo-tree） |
| `F2` | 开关符号大纲 —— aerial.nvim（NeoVim）/ Tagbar（Vim） |
| `F3` / `F4` | 打开全部折叠（`zR`）/ 关闭全部折叠（`zM`） |
| `Space` | 折叠/展开当前行 |
| `Ctrl+J` / `Ctrl+K` | 跳到下方 / 上方窗口 |
| `F7` / `F8`，`Ctrl+H` / `Ctrl+L` | 上一个 / 下一个标签页 |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | 下一个 / 上一个标签页 |
| `←` / `→` | 上一个 / 下一个 buffer |
| `Ctrl+P` | 从 Git 根目录查找文件（NeoVim）：输入 `$` 列 buffer、`#` 列最近文件、`space` + 文本全文搜索。Vim 中为 CtrlP（仅 Git 仓库） |
| `<leader>ff` / `<leader>fF` | 项目内 / 当前目录查找文件（NeoVim，fzf-lua） |
| `<leader>b` | 最近打开的文件（Vim 用 CtrlP；NeoVim 另有 fzf-lua 的 `:MRU`） |
| `<leader>t` | 在新标签页打开当前文件 |
| `<leader>w` / `<leader>q` / `Q` | 保存 / 退出 / 退出 |
| `<leader>ct` | 切换深浅色主题（NeoVim；Vim 固定 `desert`） |
| `gx` | 打开光标下的 URL 或 Markdown 链接；Markdown 中也可 Ctrl 点击或 Command 点击链接打开（macOS） |

### 标记与搜索

[vim-mark](https://github.com/inkarkat/vim-mark) 可同时以不同颜色高亮多个
单词 —— 相当于多关键词版 `*`。标记跨会话持久保存。

| 按键 | 功能 |
|------|------|
| `<leader>m` | 高亮光标下的单词（已标记则取消） |
| `{Visual}<leader>m` | 高亮选中文本 |
| `{N}<leader>m` | 以第 `{N}` 组颜色高亮（共 6 组） |
| `<leader>n` | 清除光标下的标记；无标记时禁用全部标记（类似 `:nohlsearch`） |
| `<leader>r` | 高亮输入的正则表达式 |
| `<leader>*` / `<leader>#` | 跳到当前标记的下 / 上一次出现 |
| `<leader>/` / `<leader>?` | 跳到任意标记的下 / 上一次出现 |
| `:Marks` / `:Mark` / `:MarkClear` | 列出标记 / 禁用全部 / 清空全部（不可恢复） |
| `<leader>dc` | 跳到 diff 分隔行 |
| Visual `*` / `#` | 向前 / 向后搜索选中内容 |

### Git

| 按键 | 编辑器 | 功能 |
|------|--------|------|
| `<leader>gw` / `<leader>gW` | NeoVim | 切换 / 创建 Git worktree |
| `<leader>gw` | Vim | 在当前标签页选择并切换 worktree（`:GitWorktree`） |
| `<leader>gc` | NeoVim | 查找本分支改动的文件（工作区 vs 与默认分支的 merge base，默认分支依次尝试 `origin/HEAD` → `origin/master` → `origin/main` → `master` → `main`） |
| `<leader>gs` | NeoVim | 查找未提交的改动（`git status`，含已暂存与未跟踪） |
| `<leader>dd` / `<leader>dq` | NeoVim | 打开 / 关闭 Git diff（diffview.nvim） |
| `<leader>du` | NeoVim | 与 `origin/main` / `origin/master` 对比 |
| `<leader>dh` / `<leader>dH` | NeoVim | 当前文件 / 仓库历史 |

### 编辑与格式化

| 按键 | 功能 |
|------|------|
| `<leader>F` | 格式化当前 buffer（conform.nvim，NeoVim） |
| `<leader>tm` | Table Mode 表格模式 |
| `<leader>nr` / `:NR` / `:NRV` / `:NW` | NrrwRgn 局部区域编辑 |
| `gaip=` / `vipga=` | EasyAlign 按 `=` 对齐 |
| `\sf` | FilePathConvert 路径格式转换 |
| `Tab` | 展开 UltiSnips 代码片段 |
| `Ctrl+A/E/B/F` 等 | insert/command 模式下的 Emacs 风格移动 / 删除 |

### Markdown / 图表

| 按键 | 功能 |
|------|------|
| `<leader>mv` | 缓冲区内渲染 Markdown（markview.nvim，Obsidian 风格 —— NeoVim） |
| `<leader>mp` | 浏览器实时预览 Markdown，支持本地渲染 PlantUML/D2（NeoVim） |
| `<leader>p` | 粘贴剪贴板图片（NeoVim，img-clip.nvim）：按 front matter 中 `typora-copy-images-to` 指定的相对路径保存，未设置则存到 `document.assets/`，并在光标处插入链接。Vim 使用旧版辅助脚本 |
| `<leader>P` | 将剪贴板中的图片路径存入 assets（旧版辅助脚本） |
| `<leader>N` | 用 MacDown 打开预览（macOS） |
| `<leader>M` | 用 pandoc 渲染 HTML 并打开 |
| `<leader>u` / `<leader>U` | 渲染 PlantUML 为 PNG / SVG 并打开 |

NeoVim 的 Markdown buffer 中，`<CR>` 会自动续写列表与 `>` 引用块，插入
模式下当前行的列表项 / 引用 / 标题 / 表格保持渲染。

### 自定义命令

| 命令 | 功能 |
|------|------|
| `:MRU` | 跨项目模糊查找最近打开的文件（NeoVim） |
| `:TrimR` | 去除行尾空白 |
| `:RemoveBlankLines` | 合并多余空行 |
| `:DiffOrig` | 与磁盘上的文件做 diff |
| `:DrawIt` | ASCII 绘图模式 |
| `:PasteImage` | 粘贴剪贴板图片（NeoVim，img-clip.nvim） |

### ctags

```bash
# 生成 tags，跳过 Python import
ctags -R --python-kinds=-i
```

## 从 Vim 迁移到 NeoVim

按 [安装](#安装) 一节 symlink `~/.config/nvim` 即可，无需手写
`init.vim`。参见 `:help nvim-from-vim`。

## 相关项目

- [alswl/.oOo.](https://github.com/alswl/.oOo.) —— 其他 dotfiles
