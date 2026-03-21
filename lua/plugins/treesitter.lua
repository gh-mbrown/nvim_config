return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		local utils = require("nvim-treesitter.ts_utils")
		config.setup({
			ensure_installed = {
				"lua",
				"markdown",
				"markdown_inline",
				"zig",
				"go",
				"c_sharp",
				"powershell",
				"html",
				"razor",
			},
			auto_install = true,
			sync_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-s>",
					node_incremental = "<C-s>",
					scope_incremental = false,
					node_decremental = "<C-bs>",
				},
			},
		})

		vim.api.nvim_create_user_command("TSNode", function()
			local node = utils.get_node_at_cursor(0)

			if node ~= nil then
				print("Node type: " .. node:type())
			else
				print("No node found")
			end
		end, {})
	end,
}
