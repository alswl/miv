-- Convert theme italics to bold before the legacy colorscheme loads.
require("config.theme").setup()

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
        preview = {
            -- Obsidian-like trial: whole file used to revert in insert because
            -- ModeChanged clears the buffer whenever the current mode is not in
            -- `preview.modes`. Include insert in `modes` and route it through hybrid so
            -- only the node under the cursor (a list item / quote / heading / table) falls
            -- back to source while the rest stays rendered — Obsidian's block-level feel.
            enable = true,
            enable_hybrid_mode = true,
            modes = { "n", "no", "c", "i", "ic" },
            hybrid_modes = { "i", "ic" },
            linewise_hybrid_mode = false, -- false = node-based; true = single line
        },
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

    vim.keymap.set("n", "<leader>mv", "<Cmd>Markview<CR>", { silent = true, desc = "Toggle Markview render" })
end

local markdown_plus = require_plugin("markdown-plus")
if markdown_plus then
    markdown_plus.setup({ features = { links = false } }) -- lists continue on <CR>; quotes go via formatoptions+=ro in vimrc; markdown only
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

local img_clip = require_plugin("config.img_clip")
if img_clip and require_plugin("img-clip") then
    img_clip.setup()
end

local neo_tree = require_plugin("config.neo_tree")
if neo_tree then
    neo_tree.setup()
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

-- Re-apply italic→bold after plugins configured their highlights.
require("config.theme").italic_to_bold()
