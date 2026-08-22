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

    local function git_root()
        local start = vim.api.nvim_buf_get_name(0)
        start = start ~= "" and vim.fn.fnamemodify(start, ":p:h") or vim.fn.getcwd()
        local output = vim.fn.systemlist({ "git", "-C", start, "rev-parse", "--show-toplevel" })
        return vim.v.shell_error == 0 and output[1] or nil
    end

    local function buffer_dir()
        local bufname = vim.api.nvim_buf_get_name(0)
        return bufname ~= "" and vim.fn.fnamemodify(bufname, ":p:h") or vim.fn.getcwd()
    end

    vim.keymap.set("n", "<C-p>", function()
        local root = git_root()
        if not root then
            vim.notify("<C-p> is only available inside a Git repository", vim.log.levels.WARN)
            return
        end
        fzf.global({ cwd = root })
    end, {
        silent = true,
        desc = "Find files / mru",
    })

    vim.keymap.set("n", "<leader>ff", function()
        fzf.files({ cwd = git_root() or vim.fn.getcwd() })
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
