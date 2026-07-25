# miv

Personal Vim / NeoVim configuration (**m**y v**i**m). A single configuration
serves both Vim and NeoVim, with plugins managed by
[vim-plug](https://github.com/junegunn/vim-plug).

## Features

- **One config, two editors** — Vim reads `.vimrc`; NeoVim goes through
  `init.lua` → `legacy.vim` → `.vimrc` to reuse the same setup.
- Syntax highlighting, indentation, and folding for many languages.
- File tree (NERDTree), outline (Tagbar), fuzzy finding (CtrlP + fzf).
- Markdown / PlantUML authoring and preview, table alignment, multiple
  cursors, and Emacs-style insert-mode keys.
- NeoVim additionally enables
  [markview.nvim](https://github.com/OXY2DEV/markview.nvim) and treesitter.

## Requirements

- [Vim](https://www.vim.org/) or [NeoVim](https://neovim.io/)
- Git

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
| `.config/nvim/init.lua` | NeoVim entry point; loads legacy config and sets up markview |
| `.config/nvim/legacy.vim` | Sets `runtimepath` and sources `~/.vimrc` |

## Key Bindings

`<leader>` is the default `\`.

### Interface & Navigation

| Key | Action |
|-----|--------|
| `F1` / `<leader>f` | Toggle NERDTree file tree |
| `F2` | Toggle Tagbar outline |
| `F3` / `F4` | Open all folds `zR` / close all folds `zM` |
| `Space` | Toggle fold on the current line |
| `Ctrl+J/K` | Move to window below / above |
| `F7` / `Ctrl+H` | Previous tab |
| `F8` / `Ctrl+L` | Next tab |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next / previous tab |
| `←` / `→` | Previous / next buffer |
| `Ctrl+P` | CtrlP file search (current dir; disabled under `$HOME`) |
| `<leader>b` | CtrlP most-recently-used files |
| `<leader>t` | Open current file in a new tab |
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

### Markdown / PlantUML (macOS)

| Key | Action |
|-----|--------|
| `<leader>N` | Open preview in MacDown |
| `<leader>M` | Render HTML via pandoc and open |
| `<leader>u` / `<leader>U` | Render PlantUML to PNG / SVG and open |
| `<leader>p` / `<leader>P` | Save clipboard / path image into assets and insert a Markdown link |

### Custom Commands

| Command | Action |
|---------|--------|
| `:TrimR` | Strip trailing whitespace |
| `:RemoveBlankLines` | Collapse extra blank lines |
| `:DiffOrig` | Diff against the file on disk |
| `:DrawIt` | Enter ASCII drawing mode |

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
