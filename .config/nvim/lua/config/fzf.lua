local M = {}

function M.setup()
    local ok, fzf = pcall(require, "fzf-lua")
    if not ok then
        return
    end

    fzf.setup({
        "fzf-vim",
        global = { pickers = { { "files" }, { "buffers", prefix = "$" }, { "oldfiles", prefix = "#" } } },
    })

    vim.keymap.set("n", "<C-p>", fzf.global, {
        silent = true,
        desc = "Find files / mru",
    })
end

return M
