local M = {}

function M.setup()
    local ok, blink = pcall(require, "blink.cmp")
    if not ok then
        return
    end

    blink.setup({
        -- <Tab>/<S-Tab> stay with UltiSnips, so accept with <C-y> (default preset).
        keymap = { preset = "default" },
        -- vim-snippets/UltiSnips are handled by UltiSnips; skip the built-in snippet source.
        sources = { default = { "lsp", "path", "buffer" } },
        completion = { documentation = { auto_show = true } },
    })
end

return M
