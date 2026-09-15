#!/usr/bin/env bash
# miv bootstrap: symlink dotfiles and install plugins.
# Idempotent — safe to re-run. Existing files are backed up, never overwritten.
set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m ->\033[0m %s\n' "$*"; }

# link <source> <target>: symlink target -> source, backing up any real file
# or foreign symlink that is in the way.
link() {
    local src="$1" dst="$2"

    mkdir -p "$(dirname "$dst")"

    # Already ours — nothing to do.
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        ok "$(printf '%s already linked' "${dst/#$HOME/\~}")"
        return
    fi

    # Back up whatever is in the way (keeps a timestamped copy).
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        local backup="${dst}.backup-$(date +%Y%m%d%H%M%S)"
        mv "$dst" "$backup"
        info "Backed up ${dst/#$HOME/\~} -> ${backup/#$HOME/\~}"
    fi

    ln -s "$src" "$dst"
    ok "$(printf '%s -> %s' "${dst/#$HOME/\~}" "${src/#$DOTFILES_ROOT/\~}")"
}

EDITOR_BIN="$(command -v nvim || command -v vim || true)"
if [ -z "$EDITOR_BIN" ]; then
    echo "error: neither nvim nor vim found in PATH" >&2
    exit 1
fi

info "Installing miv from ${DOTFILES_ROOT}"

link "${DOTFILES_ROOT}/.vimrc" "${HOME}/.vimrc"
link "${DOTFILES_ROOT}/.vim"   "${HOME}/.vim"
link "${DOTFILES_ROOT}/.config/nvim" "${HOME}/.config/nvim"

info "Installing plugins with $(basename "$EDITOR_BIN") (first run may take a while)"
"$EDITOR_BIN" -T dumb --not-a-term +PlugInstall +qa >/dev/null

info "Done! Open $(basename "$EDITOR_BIN") and run :PlugStatus to verify."
