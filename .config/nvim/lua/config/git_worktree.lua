local M = {}

local statusline_item = "%{v:lua.MivGitWorktreeStatusline()}"

local function refresh_statusline()
    local bufnr = vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" then
        vim.b[bufnr].miv_git_worktree_statusline = ""
        return
    end

    local directory = vim.fs.dirname(path)
    local root = vim.fn.systemlist({ "git", "-C", directory, "rev-parse", "--show-toplevel" })[1]
    if vim.v.shell_error ~= 0 or not root then
        vim.b[bufnr].miv_git_worktree_statusline = ""
        return
    end

    local branch = vim.fn.systemlist({ "git", "-C", root, "symbolic-ref", "--quiet", "--short", "HEAD" })[1]
    if vim.v.shell_error ~= 0 or not branch then
        branch = vim.fn.systemlist({ "git", "-C", root, "rev-parse", "--short", "HEAD" })[1]
    end

    local worktree = vim.fn.fnamemodify(root, ":t")
    vim.b[bufnr].miv_git_worktree_statusline = branch and ("  " .. branch .. " · " .. worktree) or (" " .. worktree)
end

_G.MivGitWorktreeStatusline = function()
    return vim.b.miv_git_worktree_statusline or ""
end

function M.setup()
    -- Keep a switch local to its tab, so other open worktrees remain intact.
    vim.g.git_worktree = {
        change_directory_command = "tcd",
        update_on_change = true,
        update_on_change_command = "e .",
        clearjumps_on_change = true,
        confirm_telescope_deletions = true,
        autopush = false,
    }

    local telescope_ok, telescope = pcall(require, "telescope")
    if telescope_ok and pcall(telescope.load_extension, "git_worktree") then
        local picker = telescope.extensions.git_worktree
        vim.keymap.set("n", "<leader>tw", picker.git_worktree, {
            silent = true,
            desc = "Switch Git worktree",
        })
        vim.keymap.set("n", "<leader>tc", picker.create_git_worktree, {
            silent = true,
            desc = "Create Git worktree",
        })
    end

    local hooks_ok, hooks = pcall(require, "git-worktree.hooks")
    if hooks_ok then
        hooks.register(hooks.type.SWITCH, function(path, previous_path)
            hooks.builtins.update_current_buffer_on_switch(path, previous_path)
            vim.schedule(refresh_statusline)
        end)
    end

    local fzf_ok, fzf = pcall(require, "fzf-lua")
    if fzf_ok then
        vim.keymap.set("n", "<leader>gs", fzf.git_status, {
            silent = true,
            desc = "Fuzzy find changed Git files",
        })
    end

    if not vim.o.statusline:find(statusline_item, 1, true) then
        vim.o.statusline = vim.o.statusline .. "%=" .. statusline_item
    end
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "DirChanged", "FocusGained" }, {
        group = vim.api.nvim_create_augroup("MivGitWorktreeStatusline", { clear = true }),
        callback = refresh_statusline,
        desc = "Refresh Git branch and worktree in the statusline",
    })
    refresh_statusline()
end

return M
