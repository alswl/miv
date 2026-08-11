local M = {}

function M.setup()
    local ok, oil = pcall(require, "oil")
    if not ok then
        return
    end

    local function select_in_main_window()
        local entry = oil.get_cursor_entry()
        if not entry or require("oil.util").is_directory(entry) then
            oil.select()
            return
        end

        local target_win = vim.w.oil_target_win
        if not target_win
            or not vim.api.nvim_win_is_valid(target_win)
            or vim.api.nvim_win_get_tabpage(target_win) ~= vim.api.nvim_get_current_tabpage()
        then
            oil.select()
            return
        end

        oil.select({
            handle_buffer_callback = function(bufnr)
                vim.api.nvim_win_call(target_win, function()
                    vim.cmd({ cmd = "buffer", args = { bufnr } })
                end)
            end,
        })
    end

    oil.setup({
        columns = { "icon" },
        keymaps = {
            ["<CR>"] = { callback = select_in_main_window, desc = "Open in main editor" },
        },
        view_options = { show_hidden = true },
    })

    local function toggle_oil()
        local oil_wins = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "oil" then
                table.insert(oil_wins, win)
            end
        end
        if #oil_wins > 0 then
            for _, win in ipairs(oil_wins) do
                pcall(vim.api.nvim_win_close, win, true)
            end
        else
            local target_win = vim.api.nvim_get_current_win()
            vim.cmd("topleft vertical 32split")
            vim.cmd("Oil")
            vim.w.oil_target_win = target_win
            vim.wo.winfixwidth = true
        end
    end

    vim.keymap.set("n", "<F1>", toggle_oil, { silent = true, desc = "Toggle file explorer" })
    vim.keymap.set("i", "<F1>", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        vim.defer_fn(toggle_oil, 0)
    end, { silent = true, desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>f", "<Cmd>Oil<CR>", { silent = true, desc = "Open file explorer" })
end

return M
