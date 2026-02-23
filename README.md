# miv

vim(nvim) configuration —— 适用于 Vim 与 NeoVim 的配置仓库。

## 简介

miv 是一套统一的 Vim/NeoVim 配置，基于 [vim-plug](https://github.com/junegunn/vim-plug) 管理插件，支持多语言语法高亮、文件树、标签栏、模糊搜索、Markdown/PlantUML 等常用场景。

- **Vim**：直接使用 `.vimrc` 与 `.vim` 目录
- **NeoVim**：通过 `~/.config/nvim/init.lua` 加载，并复用 `.vim` 与 `.vimrc` 配置

## 前置要求

- [Vim](https://www.vim.org/) 或 [NeoVim](https://neovim.io/)
- [vim-plug](https://github.com/junegunn/vim-plug)
- Git（含 `--recursive` 以拉取子模块）

## 安装

```bash
# 克隆仓库（含子模块）
git clone --recursive https://github.com/alswl/miv.git
cd miv

# 创建符号链接
ln -sf "$(pwd)/.vim" "$HOME/.vim"
ln -sf "$(pwd)/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.config"
ln -sf "$(pwd)/.config/nvim" "$HOME/.config/nvim"

# 安装插件（Vim 或 NeoVim 二选一）
vim +PlugInstall +qa
# 或
nvim +PlugInstall +qa
```

安装完成后，使用 `vim` 或 `nvim` 即可加载本配置。

## 配置结构

| 路径 | 说明 |
|------|------|
| `.vimrc` | 主配置（插件、键位、通用设置） |
| `.vim/` | 插件目录、UltiSnips 片段等 |
| `.config/nvim/init.lua` | NeoVim 入口，加载 legacy 配置 |
| `.config/nvim/legacy.vim` | 设置 runtimepath 并 `source ~/.vimrc` |

## 快捷键速查

### 通用

| 按键 | 功能 |
|------|------|
| `F1` | NERDTree 开关 |
| `F2` | Tagbar 目录/大纲 |
| `F3` | 展开所有折叠 `zR` |
| `F4` | 折叠所有 `zM` |
| `F7` / `Ctrl+H` | 上一个标签 |
| `F8` / `Ctrl+L` | 下一个标签 |
| `Space` | 切换当前行折叠 |
| `<leader>f` | NERDTree 开关 |
| `<leader>b` | CtrlP 最近文件 |
| `<leader>q` | 退出 |
| `<leader>w` | 保存 |
| `<leader>t` | 新标签页打开当前文件 |

### 窗口与缓冲

| 按键 | 功能 |
|------|------|
| `Ctrl+J/K/H/L` | 下/上/左/右窗口 |
| `←` / `→` | 上一个/下一个缓冲区 |

### 标记与搜索

| 按键 | 功能 |
|------|------|
| `<leader>m` | 高亮标记 |
| `<leader>n` | 清除高亮标记 |
| `<leader>r` | 正则标记 |
| `g Ctrl+]` | 打开 ctags 列表 |
| `<leader>d` | 跳转到 diff 分隔行 |

### 编辑与对齐

| 按键 | 功能 |
|------|------|
| `<leader>tm` | Table Mode 表格模式 |
| `<leader>nr` | 对选中区域进行 NrrwRgn 编辑 |
| `:NR` | 对选中行进行窄区编辑 |
| `:NRV` | 对选中区域进行窄区编辑 |
| `:NW` | 对当前窗口区域编辑 |
| `vipga=` | 按 `=` 对齐段落 |
| `gaip=` | 按 `=` 对齐段落（操作符） |
| `vipga➡️=` | 按 `=` 右对齐段落 |
| 可视模式 `ga:` | 按 `:` 右对齐块 |
| `\sf` | 文件路径格式转换 |

### 其他

| 按键 | 功能 |
|------|------|
| `:DrawIt` | 进入 DrawIt 绘图模式 |
| `Ctrl+P` | CtrlP 文件搜索（当前目录，非 HOME） |

### ctags

跳过 Python import 的推荐用法：

```bash
ctags -R --python-kinds=-i
```

## 从 Vim 迁移到 NeoVim

若已在使用 Vim，可参考 NeoVim 内置说明：

```
:help nvim-from-vim
```

本仓库已包含 NeoVim 配置（`init.lua` + `legacy.vim`），按上述「安装」步骤链接 `~/.config/nvim` 即可，无需再手写 `init.vim`。

## 相关链接

- [alswl/.oOo.](https://github.com/alswl/.oOo.) —— 其他 dotfiles 仓库
