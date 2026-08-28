local M = {}

function M.setup()
    local ok, neo_tree = pcall(require, "neo-tree")
    if not ok then
        return
    end

    neo_tree.setup({
        close_if_last_window = false,
        window = {
            position = "left",
            width = 32,
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = false,
            },
            follow_current_file = {
                enabled = true,
            },
            use_libuv_file_watcher = true,
        },
    })

    local function toggle_file_explorer()
        vim.cmd("Neotree toggle filesystem reveal left")
    end

    vim.keymap.set("n", "<F1>", toggle_file_explorer, { silent = true, desc = "Toggle file explorer" })
    vim.keymap.set("i", "<F1>", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        vim.defer_fn(toggle_file_explorer, 0)
    end, { silent = true, desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>f", toggle_file_explorer, { silent = true, desc = "Toggle file explorer" })
end

return M
