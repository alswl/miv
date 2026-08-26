-- CJK glyphs render poorly in italics (no proper oblique glyphs), so convert
-- every italic highlight group to bold instead.

local M = {}

function M.italic_to_bold()
    for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
        if hl.italic then
            hl.bold = true
            hl.italic = false
            vim.api.nvim_set_hl(0, name, hl)
        end
    end
end

---Apply italic→bold on every colorscheme switch (initial load, :ToggleTheme,
---manual) and on syntax load (html etc. define italic groups at filetype time).
---
---The named augroup survives `syntax enable`, which runs `autocmd! Syntax` on
---the default group and would otherwise wipe the Syntax callback.
function M.setup()
    local group = vim.api.nvim_create_augroup("ThemeItalicToBold", { clear = false })
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = M.italic_to_bold,
    })
    vim.api.nvim_create_autocmd("Syntax", {
        group = group,
        callback = M.italic_to_bold,
    })
end

return M
