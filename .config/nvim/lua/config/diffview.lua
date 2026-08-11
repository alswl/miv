local M = {}

local function default_branch()
    for _, branch in ipairs({ "origin/main", "origin/master" }) do
        if vim.fn.system({ "git", "rev-parse", "--verify", "--quiet", branch }) ~= "" then
            return branch
        end
    end

    vim.notify("Neither origin/main nor origin/master exists", vim.log.levels.WARN)
end

local function compare_with_default_branch()
    local branch = default_branch()
    if branch then
        vim.cmd("DiffviewOpen " .. branch .. "...HEAD")
    end
end

function M.setup()
    vim.keymap.set("n", "<leader>dd", "<Cmd>DiffviewOpen<CR>", {
        silent = true,
        desc = "Open Git diff",
    })
    vim.keymap.set("n", "<leader>du", compare_with_default_branch, {
        silent = true,
        desc = "Compare with origin/main or origin/master",
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
