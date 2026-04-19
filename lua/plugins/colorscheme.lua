return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			styles = {
				transparency = true,
			},
			highlight_groups = {
				CursorLine = {
					bg = "none",
				},
				StatusLine = { fg = "gold", bg = "gold", blend = 10 },
				StatusLineNC = { fg = "subtle", bg = "surface" },
				HopNextKey = {
					bg = "none",
					blend = 0,
				},
				HopNextKey1 = {
					bg = "none",
					blend = 0,
				},
				HopNextKey2 = {
					bg = "none",
					blend = 0,
				},
			},
		})

		vim.cmd("colorscheme rose-pine")
	end,
}
