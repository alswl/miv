local M = {}

function M.setup()
    vim.keymap.set("n", "<leader>dd", "<Cmd>DiffviewOpen<CR>", {
        silent = true,
        desc = "Open Git diff",
    })
    vim.keymap.set("n", "<leader>du", "<Cmd>DiffviewOpen @{upstream}...HEAD<CR>", {
        silent = true,
        desc = "Compare with upstream",
    })
    vim.keymap.set("n", "<leader>dq", "<Cmd>DiffviewClose<CR>", {
        silent = true,
        desc = "Close Git diff",
    })
    vim.keymap.set("n", "<leader>dh", "<Cmd>DiffviewFileHistory %<CR>", {
        silent = true,
        desc = "Current file Git history",
    })
    vim.keymap.set("n", "<leader>dH", "<Cmd>DiffviewFileHistory<CR>", {
        silent = true,
        desc = "Repository Git history",
    })
end

return M
