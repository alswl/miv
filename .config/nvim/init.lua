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

local fzf = require_plugin("config.fzf")
if fzf then
    fzf.setup()
end

local git_worktree = require_plugin("config.git_worktree")
if git_worktree then
    git_worktree.setup()
end

local diffview = require_plugin("config.diffview")
if diffview then
    diffview.setup()
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

local oil = require_plugin("config.oil")
if oil then
    oil.setup()
end

local aerial = require_plugin("aerial")
if aerial then
    aerial.setup({})
end

-- Markdown preview
local livepreview = require_plugin("config.live_preview")
if livepreview then
    livepreview.setup()
end

-- Keymaps

if conform then
    vim.keymap.set("n", "<leader>F", function()
        conform.format({ async = true, lsp_format = "fallback" })
    end, { silent = true, desc = "Format buffer" })
end

if livepreview and livepreview.enabled then
    vim.keymap.set("n", "<leader>mp", livepreview.start, {
        silent = true,
        desc = "Preview Markdown in browser",
    })
end

if aerial then
    vim.keymap.set("n", "<F2>", "<Cmd>AerialToggle<CR>", { silent = true, desc = "Toggle symbols" })
    vim.keymap.set("i", "<F2>", "<Esc><Cmd>AerialToggle<CR>", { silent = true, desc = "Toggle symbols" })
end
