# miv

**miv** — a personal Vim / NeoVim configuration.

[English](README.md) | [简体中文](README.zh-CN.md)

One config, two editors: Vim reads `.vimrc`; NeoVim boots through `init.lua`
→ `legacy.vim` → `.vimrc` to reuse the same setup, then layers Lua plugins on
top. Plugins are managed by [vim-plug](https://github.com/junegunn/vim-plug),
which is vendored in the repo — nothing extra to install.

![Vim](https://img.shields.io/badge/editor-Vim-green) ![NeoVim](https://img.shields.io/badge/editor-NeoVim-57a143) ![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue)

## Highlights

- **Batteries-included editing** — syntax, indentation and folding for many
  languages, multiple cursors, UltiSnips, table editing & alignment, and
  Emacs-style insert-mode keys.
- **NeoVim modern layer**:
  - [fzf-lua](https://github.com/ibhagwan/fzf-lua) fuzzy finding with
    Git-aware pickers (branch changes, uncommitted status, MRU).
  - [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) file
    explorer and [aerial.nvim](https://github.com/stevearc/aerial.nvim)
    symbol outline.
  - Git toolkit: [fugitive](https://github.com/tpope/vim-fugitive),
    [diffview.nvim](https://github.com/sindrets/diffview.nvim), and
    [git-worktree.nvim](https://github.com/polarmutex/git-worktree.nvim) with
    a branch/worktree statusline indicator.
  - [conform.nvim](https://github.com/stevearc/conform.nvim) format-on-demand
    (prettier, stylua, ruff, shfmt…).
  - Markdown authoring kit: in-buffer rendering
    ([markview.nvim](https://github.com/OXY2DEV/markview.nvim), Obsidian-like),
    list continuation ([markdown-plus.nvim](https://github.com/YousefHadder/markdown-plus.nvim)),
    clipboard image pasting ([img-clip.nvim](https://github.com/HakonHarnes/img-clip.nvim)),
    and [live-preview.nvim](https://github.com/brianhuster/live-preview.nvim)
    with local PlantUML/D2 diagram rendering.
  - Themes: [jb.nvim](https://github.com/nickkadutskyi/jb.nvim) by default
    (dark/light via `ToggleTheme`), with
    [Everforest](https://github.com/sainnhe/everforest) and
    [Nordfox](https://github.com/EdenEast/nightfox.nvim) as alternates.

> [!TIP]
> NeoVim-only keymaps override the shared Vim defaults, so the tables below
> note which editor each binding belongs to.

## Installation

One command does everything — symlink the dotfiles, back up anything in the
way, and install plugins:

```bash
git clone https://github.com/alswl/miv.git
cd miv
./install.sh
```

> [!NOTE]
> The script is idempotent and never overwrites: an existing `~/.vimrc`,
> `~/.vim`, or `~/.config/nvim` is moved aside to
> `<name>.backup-<timestamp>` before linking.

Prefer to do it manually?

```bash
# Symlink (-n replaces an existing dir link instead of nesting into it)
ln -sfn "$(pwd)/.vim"   "$HOME/.vim"
ln -sf  "$(pwd)/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.config"
ln -sfn "$(pwd)/.config/nvim" "$HOME/.config/nvim"

# Install plugins (either editor; plug.vim is already bundled)
vim  +PlugInstall +qa
nvim +PlugInstall +qa
```

Requirements: [Vim](https://www.vim.org/) or
[NeoVim](https://neovim.io/), and Git. Optional on macOS:
[`pngpaste`](https://github.com/jcsalterego/pngpaste) for clipboard images
(`brew install pngpaste`).

## Layout

| Path | Description |
|------|-------------|
| `.vimrc` | Main config: plugin list, key maps, general and filetype settings |
| `.vim/` | UltiSnips snippets, autoload, ftplugin, syntax, templates |
| `.config/nvim/init.lua` | NeoVim entry point: legacy config, then Lua plugins and keymaps |
| `.config/nvim/legacy.vim` | Sets `runtimepath` and sources `~/.vimrc` |
| `.config/nvim/lua/config/` | Per-plugin Lua config: `neo_tree`, `fzf`, `git_worktree`, `diffview`, `img_clip`, `live_preview`, `theme` |

## Key Bindings

`<leader>` is the default `\`.

### Interface & Navigation

| Key | Action |
|-----|--------|
| `F1` / `<leader>f` | Toggle file explorer — neo-tree.nvim (NeoVim) / NERDTree (Vim) |
| `O` / `gO` *(in explorer)* | Open entry with the system opener / reveal in file manager (neo-tree) |
| `F2` | Toggle symbol outline — aerial.nvim (NeoVim) / Tagbar (Vim) |
| `F3` / `F4` | Open all folds (`zR`) / close all folds (`zM`) |
| `Space` | Toggle fold on the current line |
| `Ctrl+J` / `Ctrl+K` | Move to window below / above |
| `F7` / `F8`, `Ctrl+H` / `Ctrl+L` | Previous / next tab |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next / previous tab |
| `←` / `→` | Previous / next buffer |
| `Ctrl+P` | Find files from the Git root (NeoVim): type `$` for buffers, `#` for recent files, `space` + text to grep. CtrlP in Vim (Git repos only) |
| `<leader>ff` / `<leader>fF` | Find files in project / current directory (NeoVim, fzf-lua) |
| `<leader>b` | Most-recently-used files (CtrlP in Vim; NeoVim also has `:MRU` via fzf-lua) |
| `<leader>t` | Open current file in a new tab |
| `<leader>w` / `<leader>q` / `Q` | Save / quit / quit |
| `<leader>ct` | Toggle dark/light theme (NeoVim; Vim stays on `desert`) |
| `gx` | Open URL or Markdown link under cursor; in Markdown, Ctrl-click or Command-click opens the link under the pointer (macOS) |

### Marks & Search

[vim-mark](https://github.com/inkarkat/vim-mark) highlights several words in
different colors simultaneously — like a multi-term `*`. Marks persist across
sessions.

| Key | Action |
|-----|--------|
| `<leader>m` | Highlight word under cursor (toggle off if already marked) |
| `{Visual}<leader>m` | Highlight the visual selection |
| `{N}<leader>m` | Highlight with color group `{N}` (6 groups) |
| `<leader>n` | Clear mark under cursor; elsewhere disable all marks (like `:nohlsearch`) |
| `<leader>r` | Highlight a regular expression |
| `<leader>*` / `<leader>#` | Jump to next / previous occurrence of the current mark |
| `<leader>/` / `<leader>?` | Jump to next / previous occurrence of any mark |
| `:Marks` / `:Mark` / `:MarkClear` | List marks / disable all / clear all (irreversible) |
| `<leader>dc` | Jump to diff separator line |
| Visual `*` / `#` | Search forward / backward for the selection |

### Git

| Key | Editor | Action |
|-----|--------|--------|
| `<leader>gw` / `<leader>gW` | NeoVim | Switch / create Git worktree |
| `<leader>gw` | Vim | Pick and switch to a worktree in the current tab (`:GitWorktree`) |
| `<leader>gc` | NeoVim | Files changed on this branch (working tree vs merge base with `origin/HEAD` → `origin/master` → `origin/main` → `master` → `main`) |
| `<leader>gs` | NeoVim | Uncommitted changes (`git status`, staged & untracked included) |
| `<leader>dd` / `<leader>dq` | NeoVim | Open / close Git diff (diffview.nvim) |
| `<leader>du` | NeoVim | Diff against `origin/main` / `origin/master` |
| `<leader>dh` / `<leader>dH` | NeoVim | File / repository history |

### Editing & Formatting

| Key | Action |
|-----|--------|
| `<leader>F` | Format buffer (conform.nvim, NeoVim) |
| `<leader>tm` | Table Mode |
| `<leader>nr` / `:NR` / `:NRV` / `:NW` | NrrwRgn narrowed-region editing |
| `gaip=` / `vipga=` | EasyAlign on `=` |
| `\sf` | FilePathConvert path-format conversion |
| `Tab` | Expand UltiSnips snippet |
| `Ctrl+A/E/B/F` … | Emacs-style motion / deletion in insert & command mode |

### Markdown / Diagrams

| Key | Action |
|-----|--------|
| `<leader>mv` | Toggle in-buffer Markdown rendering (markview.nvim, Obsidian-like — NeoVim) |
| `<leader>mp` | Live-preview Markdown in the browser, with local PlantUML/D2 rendering (NeoVim) |
| `<leader>p` | Paste clipboard image (NeoVim, img-clip.nvim): saved to the front-matter `typora-copy-images-to` path or `document.assets/`, then linked at the cursor. Vim uses its legacy helper |
| `<leader>P` | Save an image from a clipboard path into assets (legacy helper) |
| `<leader>N` | Open preview in MacDown (macOS) |
| `<leader>M` | Render HTML via pandoc and open |
| `<leader>u` / `<leader>U` | Render PlantUML to PNG / SVG and open |

In NeoVim Markdown buffers, `<CR>` auto-continues lists and `>` blockquotes,
and the current list item / quote / heading / table stays rendered in insert
mode.

### Custom Commands

| Command | Action |
|---------|--------|
| `:MRU` | Fuzzy find recently opened files across all projects (NeoVim) |
| `:TrimR` | Strip trailing whitespace |
| `:RemoveBlankLines` | Collapse extra blank lines |
| `:DiffOrig` | Diff buffer against the file on disk |
| `:DrawIt` | ASCII drawing mode |
| `:PasteImage` | Paste a clipboard image (NeoVim, img-clip.nvim) |

### ctags

```bash
# Generate tags, skipping Python imports
ctags -R --python-kinds=-i
```

## Migrating from Vim to NeoVim

Symlink `~/.config/nvim` as shown in [Installation](#installation) — no need
to hand-write `init.vim`. See `:help nvim-from-vim`.

## Related

- [alswl/.oOo.](https://github.com/alswl/.oOo.) — other dotfiles
