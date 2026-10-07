local M = {}

function M.setup()
	local ok, blink = pcall(require, "blink.cmp")
	if not ok then
		return
	end

	blink.setup({
		-- super-tab: <Tab> accepts the selection or jumps snippet placeholders, and
		-- falls back to the original Tab behavior otherwise; <S-Tab> jumps backward.
		keymap = { preset = "super-tab" },
		-- Snippets expand via mini.snippets: hand-maintained Lua files in
		-- .config/nvim/snippets plus friendly-snippets JSON from runtimepath
		-- (see config/mini_snippets.lua).
		snippets = { preset = "mini_snippets" },
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		completion = { documentation = { auto_show = true } },
	})
end

return M
