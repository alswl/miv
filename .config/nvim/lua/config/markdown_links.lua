local M = {}

local markdown_filetypes = {
    markdown = true,
    ["markdown.gfm"] = true,
    ["markdown.github"] = true,
    ["markdown.pandoc"] = true,
}

local function url_at_cursor()
    local line = vim.api.nvim_get_current_line()
    local column = vim.api.nvim_win_get_cursor(0)[2] + 1 -- Lua strings are 1-indexed.

    -- An inline Markdown link is actionable from either its label or target.
    for start_pos, link, target in line:gmatch("()(!?%b[]%(([^%s)]+)%))") do
        local finish = start_pos + #link - 1
        if column >= start_pos and column <= finish then
            return target
        end
    end

    -- Bare links and autolinks remain useful even while Markview is disabled.
    for start_pos, target in line:gmatch("()(https?://[^%s<>]+)") do
        local finish = start_pos + #target - 1
        if column >= start_pos and column <= finish then
            return target:gsub("[.,;:!?]+$", "")
        end
    end
end

local function open_url(url)
    if not url then
        vim.notify("No URL under cursor", vim.log.levels.INFO)
        return
    end

    if vim.ui.open then
        local ok, err = pcall(vim.ui.open, url)
        if ok then
            return
        end
        vim.notify("Could not open URL: " .. tostring(err), vim.log.levels.ERROR)
        return
    end

    local opener = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.jobstart({ opener, url }, { detach = true })
end

local function open_link_at_cursor()
    open_url(url_at_cursor())
end

local function open_link_at_mouse()
    local mouse = vim.fn.getmousepos()
    if mouse.winid ~= 0 and vim.api.nvim_win_is_valid(mouse.winid) then
        vim.api.nvim_set_current_win(mouse.winid)
        vim.api.nvim_win_set_cursor(mouse.winid, { mouse.line, math.max(mouse.column - 1, 0) })
    end
    open_link_at_cursor()
end

function M.setup()
    local group = vim.api.nvim_create_augroup("MarkdownLinkOpener", { clear = true })
    -- Markview attaches on BufEnter and installs its own `gx` mapping. Register
    -- this later BufEnter handler so the Markdown-specific opener consistently
    -- wins, whether or not rendering is currently enabled.
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        group = group,
        callback = function(args)
            if not markdown_filetypes[vim.bo[args.buf].filetype] then
                return
            end

            vim.keymap.set("n", "gx", open_link_at_cursor, {
                buffer = args.buf,
                silent = true,
                desc = "Open Markdown link under cursor",
            })
            -- Ctrl-click works everywhere; Command-click is convenient in Neovide on macOS.
            for _, key in ipairs({ "<C-LeftMouse>", "<D-LeftMouse>" }) do
                vim.keymap.set("n", key, open_link_at_mouse, {
                    buffer = args.buf,
                    silent = true,
                    desc = "Open Markdown link under mouse",
                })
            end
        end,
    })
end

return M
