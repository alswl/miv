local M = {}

local function image_dir_for_current_markdown()
    local lines = vim.api.nvim_buf_get_lines(0, 0, math.min(vim.api.nvim_buf_line_count(0), 200), false)
    if not lines[1] or not lines[1]:match("^%-%-%-%s*$") then
        return vim.fn.expand("%:t:r") .. ".assets"
    end

    for index = 2, #lines do
        local line = lines[index]
        if line:match("^%-%-%-%s*$") or line:match("^%.%.%.%s*$") then
            break
        end

        local path = line:match("^%s*typora%-copy%-images%-to%s*:%s*(.-)%s*$")
        if path and path ~= "" then
            local quote = path:sub(1, 1)
            if (quote == '"' or quote == "'") and path:sub(-1) == quote then
                path = path:sub(2, -2)
            end
            return path
        end
    end

    return vim.fn.expand("%:t:r") .. ".assets"
end

function M.setup()
    require("img-clip").setup({
        default = {
            -- Respect Typora's per-document image directory when present.
            dir_path = image_dir_for_current_markdown,
            relative_to_current_file = true,
            use_absolute_path = false,
            file_name = "paste-%Y%m%d-%H%M%S",
            prompt_for_file_name = false,
            -- pngpaste can mark otherwise sRGB clipboard PNGs as gAMA=2.2.
            -- Browsers honour that chunk and render them much too dark.
            process_cmd = "python3 "
                .. vim.fn.shellescape(vim.fn.stdpath("config") .. "/bin/normalize-png-gamma.py"),
        },
        filetypes = {
            markdown = {
                template = "![$CURSOR]($FILE_PATH)",
            },
        },
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
            vim.keymap.set("n", "<leader>p", "<Cmd>PasteImage<CR>", {
                buffer = event.buf,
                silent = true,
                desc = "Paste clipboard image",
            })
        end,
    })
end

return M
