local M = {}

function M.setup()
	local ok, mini_snippets = pcall(require, "mini.snippets")
	if not ok then
		return
	end

	local gen_loader = mini_snippets.gen_loader
	mini_snippets.setup({
		-- Custom snippets live in <config>/snippets/<ft>.lua (hand-maintained);
		-- friendly-snippets JSON is read from runtimepath by the same loader.
		snippets = { gen_loader.from_lang() },
		-- blink.cmp (super-tab) drives expansion and placeholder jumping;
		-- keep only the stop mapping from mini.snippets itself.
		mappings = { expand = "", jump_next = "", jump_prev = "" },
	})
end

return M
