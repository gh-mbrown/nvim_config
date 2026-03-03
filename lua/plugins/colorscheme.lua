return {
	"Mofiqul/vscode.nvim",
	config = function()
		vim.o.background = "dark"
		require("vscode").setup({
			color_overrides = {
				vscBack = "none",
				vscPopupBack = "none",
			},
		})

		vim.cmd.colorscheme("vscode")
	end,
}
