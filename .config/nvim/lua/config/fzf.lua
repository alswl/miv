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

    local function project_root()
        return vim.fs.root(0, ".git") or vim.fn.getcwd()
    end

    local function buffer_dir()
        local bufname = vim.api.nvim_buf_get_name(0)
        return bufname ~= "" and vim.fn.fnamemodify(bufname, ":p:h") or vim.fn.getcwd()
    end

    vim.keymap.set("n", "<C-p>", function()
        fzf.global({ cwd = buffer_dir() })
    end, {
        silent = true,
        desc = "Find files / mru",
    })

    vim.keymap.set("n", "<leader>ff", function()
        fzf.files({ cwd = project_root() })
    end, {
        silent = true,
        desc = "Find files (project)",
    })

    vim.keymap.set("n", "<leader>fF", function()
        fzf.files({ cwd = buffer_dir() })
    end, {
        silent = true,
        desc = "Find files (current buffer dir)",
    })
end

return M
