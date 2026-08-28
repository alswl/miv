local M = {}

function M.setup()
    local ok, neo_tree = pcall(require, "neo-tree")
    if not ok then
        return
    end

    -- Hand the path to the desktop instead of opening it in a buffer.
    local function open_externally(path, reveal)
        if not path or path == "" then
            vim.notify("No file or directory under the cursor", vim.log.levels.WARN)
            return
        end

        local cmd
        if vim.fn.has("mac") == 1 then
            cmd = reveal and { "open", "-R", path } or { "open", path }
        elseif vim.fn.executable("xdg-open") == 1 then
            cmd = { "xdg-open", reveal and vim.fs.dirname(path) or path }
        else
            vim.notify("No system opener available", vim.log.levels.WARN)
            return
        end
        vim.fn.jobstart(cmd, { detach = true })
    end

    neo_tree.setup({
        close_if_last_window = false,
        commands = {
            system_open = function(state)
                local node = state.tree:get_node()
                open_externally(node and node.path, false)
            end,
            system_reveal = function(state)
                local node = state.tree:get_node()
                open_externally(node and node.path, true)
            end,
        },
        window = {
            position = "left",
            width = 32,
            mappings = {
                ["O"] = "system_open",
                ["gO"] = "system_reveal",
            },
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
