return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		vim.api.nvim_create_user_command("TSInstalled", function()
			local installed = vim.api.nvim_get_runtime_file("parser/*", true)
			for _, v in pairs(installed) do
				print(v)
			end
		end, {})
		ts.install({
			"lua",
			"markdown",
			"markdown_inline",
			"zig",
			"go",
			"c_sharp",
			"powershell",
			"html",
			"razor",
			"rust",
			"fsharp",
			"ocaml",
		})
		ts.setup({
			install_dir = vim.fn.stdpath("data") .. "/site/parser",
		})
	end,
}
