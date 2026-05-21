return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = "main",
			styles = {
				transparency = true,
			},
			highlight_groups = {
				CursorLine = { bg = "none" },
			},
		})
		vim.cmd.colorscheme("rose-pine")
	end,
}
