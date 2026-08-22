# miv

Personal Vim / NeoVim configuration (**m**y v**i**m). A single configuration
serves both Vim and NeoVim, with plugins managed by
[vim-plug](https://github.com/junegunn/vim-plug).

## Features

- **One config, two editors** — Vim reads `.vimrc`; NeoVim goes through
  `init.lua` → `legacy.vim` → `.vimrc` to reuse the same setup, then layers
  Lua plugins on top (NeoVim-only keymaps override the Vim defaults below).
- Syntax highlighting, indentation, and folding for many languages.
- Markdown / PlantUML authoring, table alignment, multiple cursors, and
  Emacs-style insert-mode keys.
- NeoVim additionally enables:
  - [markview.nvim](https://github.com/OXY2DEV/markview.nvim) and the
    prose-oriented [Everforest theme](https://github.com/sainnhe/everforest)
    for in-buffer Markdown authoring and reading.
  - [oil.nvim](https://github.com/stevearc/oil.nvim) as the file explorer
    (replaces NERDTree) and [aerial.nvim](https://github.com/stevearc/aerial.nvim)
    as the symbol outline (replaces Tagbar).
  - [fzf-lua](https://github.com/ibhagwan/fzf-lua) as the fuzzy finder
    (replaces CtrlP).
  - [git-worktree.nvim](https://github.com/polarmutex/git-worktree.nvim) +
    [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for
    switching/creating worktrees, plus [vim-fugitive](https://github.com/tpope/vim-fugitive)
    and a branch/worktree indicator in the statusline.
  - [diffview.nvim](https://github.com/sindrets/diffview.nvim) for Git diffs
    and file history.
  - [conform.nvim](https://github.com/stevearc/conform.nvim) for
    format-on-demand across common languages.
  - [live-preview.nvim](https://github.com/brianhuster/live-preview.nvim) for
    live Markdown preview in the browser, with local PlantUML and D2 diagram
    rendering.

## Requirements

- [Vim](https://www.vim.org/) or [NeoVim](https://neovim.io/)
- Git
- For NeoVim clipboard-image pasting on macOS: [`pngpaste`](https://github.com/jcsalterego/pngpaste) (`brew install pngpaste`)

[vim-plug](https://github.com/junegunn/vim-plug) is vendored in
`.vim/autoload/plug.vim`, so there is nothing extra to install.

## Installation

```bash
git clone https://github.com/alswl/miv.git
cd miv

# Create symlinks (-n replaces existing dir links instead of nesting into them)
ln -sfn "$(pwd)/.vim"   "$HOME/.vim"
ln -sf  "$(pwd)/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.config"
ln -sfn "$(pwd)/.config/nvim" "$HOME/.config/nvim"

# Install plugins (run either one; plug.vim is already bundled)
vim  +PlugInstall +qa
nvim +PlugInstall +qa
```

## Layout

| Path | Description |
|------|-------------|
| `.vimrc` | Main config: plugin list, key maps, general and filetype settings |
| `.vim/` | UltiSnips snippets, autoload, ftplugin, syntax, etc. |
| `.config/nvim/init.lua` | NeoVim entry point; loads legacy config, then Lua plugins and keymaps |
| `.config/nvim/legacy.vim` | Sets `runtimepath` and sources `~/.vimrc` |
| `.config/nvim/lua/config/oil.lua` | File explorer (`F1`) |
| `.config/nvim/lua/config/fzf.lua` | Fuzzy finder (`Ctrl+P`) |
| `.config/nvim/lua/config/git_worktree.lua` | Worktree switching/creation, statusline branch indicator |
| `.config/nvim/lua/config/diffview.lua` | Git diff and file-history keymaps |
| `.config/nvim/lua/config/live_preview.lua` | Markdown live preview with PlantUML/D2 rendering |

## Key Bindings

`<leader>` is the default `\`.

### Interface & Navigation

| Key | Action |
|-----|--------|
| `F1` / `<leader>f` | Toggle file explorer — oil.nvim in NeoVim, NERDTree in Vim |
| `F2` | Toggle symbol outline — aerial.nvim in NeoVim, Tagbar in Vim |
| `F3` / `F4` | Open all folds `zR` / close all folds `zM` |
| `Space` | Toggle fold on the current line |
| `Ctrl+J/K` | Move to window below / above |
| `F7` / `Ctrl+H` | Previous tab |
| `F8` / `Ctrl+L` | Next tab |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next / previous tab |
| `←` / `→` | Previous / next buffer |
| `Ctrl+P` | Fuzzy find files/buffers/MRU — fzf-lua in NeoVim, CtrlP in Vim (Git repositories only; searches from the repository root) |
| `<leader>b` | CtrlP most-recently-used files (Vim) |
| `<leader>t` | Open current file in a new tab |
| `<leader>ct` | Switch between Everforest (prose) and Nordfox (code) themes (NeoVim) |
| `<leader>w` / `<leader>q` | Save / quit |
| `Q` | Quit |
| `gx` | Open URL under cursor (macOS) |

### Marks & Search

| Key | Action |
|-----|--------|
| `<leader>m` | vim-mark highlight mark |
| `<leader>n` | Clear highlight marks |
| `<leader>r` | Regex mark |
| `<leader>d` | Jump to diff separator line |
| Visual `*` / `#` | Search forward / backward for the selection |

### Editing & Alignment

| Key | Action |
|-----|--------|
| `<leader>tm` | Table Mode |
| `<leader>nr` / `:NR` / `:NRV` / `:NW` | NrrwRgn narrowed-region editing |
| `gaip=` / `vipga=` | EasyAlign on `=` |
| `\sf` | FilePathConvert path-format conversion |
| `Tab` | Expand UltiSnips snippet |
| `Ctrl+A/E/B/F`, etc. | Emacs-style motion / deletion in insert & command mode |

### Git (NeoVim)

| Key | Action |
|-----|--------|
| `<leader>tw` | Switch Git worktree |
| `<leader>tc` | Create Git worktree |
| `<leader>gs` | Fuzzy find changed Git files |
| `<leader>dd` | Open Git diff |
| `<leader>du` | Compare with `origin/main` or `origin/master` |
| `<leader>dq` | Close Git diff |
| `<leader>dh` / `<leader>dH` | Current file / repository Git history |

### Formatting (NeoVim)

| Key | Action |
|-----|--------|
| `<leader>F` | Format buffer (conform.nvim) |

### Markdown / PlantUML (macOS)

| Key | Action |
|-----|--------|
| `<leader>N` | Open preview in MacDown |
| `<leader>M` | Render HTML via pandoc and open |
| `<leader>u` / `<leader>U` | Render PlantUML to PNG / SVG and open |
| `<leader>p` | In a NeoVim Markdown buffer, paste an image with img-clip.nvim: it is saved to the relative path in front matter's `typora-copy-images-to`, or to `document.assets/` when unset, then linked at the cursor. Vim retains its legacy clipboard helper. |
| `<leader>P` | Save a clipboard path image into assets with the legacy helper |
| `<leader>mp` | Live-preview Markdown in the browser, with local PlantUML/D2 rendering (NeoVim) |

### Custom Commands

| Command | Action |
|---------|--------|
| `:TrimR` | Strip trailing whitespace |
| `:RemoveBlankLines` | Collapse extra blank lines |
| `:DiffOrig` | Diff against the file on disk |
| `:DrawIt` | Enter ASCII drawing mode |
| `:PasteImage` | Paste a system clipboard image using img-clip.nvim (NeoVim) |

### ctags

```bash
# Generate tags, skipping Python imports
ctags -R --python-kinds=-i
```

## Migrating from Vim to NeoVim

This repo ships NeoVim config (`init.lua` + `legacy.vim`). Symlink
`~/.config/nvim` as shown in [Installation](#installation) — no need to write
`init.vim` by hand. See `:help nvim-from-vim`.

## Related

- [alswl/.oOo.](https://github.com/alswl/.oOo.) — other dotfiles repo
