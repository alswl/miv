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

    -- Default branch of the repository, preferring what the remote points at.
    local function base_branch(root)
        local head = vim.fn.systemlist({ "git", "-C", root, "symbolic-ref", "--quiet", "--short", "refs/remotes/origin/HEAD" })
        if vim.v.shell_error == 0 and head[1] and head[1] ~= "" then
            return head[1]
        end

        for _, ref in ipairs({ "origin/master", "origin/main", "master", "main" }) do
            vim.fn.systemlist({ "git", "-C", root, "rev-parse", "--verify", "--quiet", ref })
            if vim.v.shell_error == 0 then
                return ref
            end
        end
    end

    local function git_root_or_warn()
        local root = git_root()
        if not root then
            vim.notify("Not inside a Git repository", vim.log.levels.WARN)
        end
        return root
    end

    -- Where this branch forked off, so later commits on the base branch stay out of the diff.
    local function branch_point(root)
        local base = base_branch(root)
        if not base then
            return nil, "No default branch found (tried origin/HEAD, origin/master, origin/main, master, main)"
        end

        local merge_base = vim.fn.systemlist({ "git", "-C", root, "merge-base", "HEAD", base })
        if vim.v.shell_error ~= 0 or not merge_base[1] then
            return nil, "No common ancestor with " .. base
        end

        return merge_base[1], base
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

    vim.keymap.set("n", "<leader>gc", function()
        local root = git_root_or_warn()
        if not root then
            return
        end

        local ref, base = branch_point(root)
        if not ref then
            vim.notify(base, vim.log.levels.WARN)
            return
        end

        -- Working tree against the branch point: this branch's commits plus uncommitted edits.
        fzf.git_diff({ cwd = root, ref = ref, prompt = "Branch changes (" .. base .. ")> " })
    end, {
        silent = true,
        desc = "Fuzzy find files changed on this branch",
    })

    vim.keymap.set("n", "<leader>gs", function()
        local root = git_root_or_warn()
        if not root then
            return
        end

        fzf.git_status({ cwd = root })
    end, {
        silent = true,
        desc = "Fuzzy find uncommitted Git changes",
    })
end

return M
