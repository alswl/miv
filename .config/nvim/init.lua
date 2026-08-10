-- Legacy Vim configuration
vim.cmd.source(vim.fn.stdpath("config") .. "/legacy.vim")

-- Editor options
vim.g.neovide_input_ime = true

-- Plugin loader
local function require_plugin(name)
    local ok, module = pcall(require, name)
    return ok and module or nil
end

-- Plugin configuration
local markview = require_plugin("markview")
if markview then
    markview.setup({
        markdown = {
            headings = {
                heading_1 = { sign = "" },
                heading_2 = { sign = "" },
                heading_3 = { sign = "" },
                heading_4 = { sign = "" },
                heading_5 = { sign = "" },
                heading_6 = { sign = "" },
            },
            code_blocks = { sign = false },
        },
    })
end

local fzf = require_plugin("fzf-lua")
if fzf then
    fzf.setup({
        "fzf-vim",
        global = { pickers = { { "files" }, { "buffers", prefix = "$" }, { "oldfiles", prefix = "#" } } },
    })
    vim.keymap.set("n", "<C-p>", fzf.global, { silent = true, desc = "Find files / mru" })
end

local conform = require_plugin("conform")
if conform then
    conform.setup({
        formatters_by_ft = {
            css = { "prettier" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "ruff_format", "ruff_organize_imports" },
            sh = { "shfmt" },
            typescript = { "prettier" },
            yaml = { "prettier" },
        },
    })
end

local oil = require_plugin("oil")
if oil then
    oil.setup({
        columns = { "icon", "permissions", "size", "mtime" },
        view_options = { show_hidden = true },
    })
end

local aerial = require_plugin("aerial")
if aerial then
    aerial.setup({})
end

-- Keymaps
if conform then
    vim.keymap.set("n", "<leader>F", function()
        conform.format({ async = true, lsp_format = "fallback" })
    end, { silent = true, desc = "Format buffer" })
end

if oil then
    -- Toggle oil in a vertical split: close any visible oil window, or open one
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
            vim.cmd("vertical Oil")
        end
    end
    vim.keymap.set("n", "<F1>", toggle_oil, { silent = true, desc = "Toggle file explorer (vsplit)" })
    vim.keymap.set("i", "<F1>", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        vim.defer_fn(toggle_oil, 0)
    end, { silent = true, desc = "Toggle file explorer (vsplit)" })
    vim.keymap.set("n", "<leader>f", "<Cmd>Oil<CR>", { silent = true, desc = "Open file explorer" })
end

if aerial then
    vim.keymap.set("n", "<F2>", "<Cmd>AerialToggle<CR>", { silent = true, desc = "Toggle symbols" })
    vim.keymap.set("i", "<F2>", "<Esc><Cmd>AerialToggle<CR>", { silent = true, desc = "Toggle symbols" })
end
