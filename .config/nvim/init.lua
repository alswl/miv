-- legacy
local vimrc = vim.fn.stdpath("config") .. "/legacy.vim"
vim.cmd.source(vimrc)

vim.g.neovide_input_ime = true

require("markview").setup({
    markdown = {
        headings = {
            heading_1 = { sign = "" },
            heading_2 = { sign = "" },
            heading_3 = { sign = "" },
            heading_4 = { sign = "" },
            heading_5 = { sign = "" },
            heading_6 = { sign = "" },
        },
        code_blocks = {
            sign = false
        }
    },
})
