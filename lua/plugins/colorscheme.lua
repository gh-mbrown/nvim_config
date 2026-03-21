return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			on_highlights = function(hl, _)
				hl.Normal = {
					bg = "none",
				}
				hl.NormalNC = {
					bg = "none",
				}
				hl.TelescopeNormal = {
					bg = "none",
				}
				hl.TelescopeBorder = {
					bg = "none",
				}
				hl.TelescopePromptTitle = {
					bg = "none",
				}
				hl.TelescopePromptBorder = {
					bg = "none",
				}
				hl.SignColumn = {
					bg = "none",
				}
				hl.CursorLineNr = {
					fg = "#ff9e64",
				}
				hl.LineNrAbove = {
					fg = "#7aa2f7",
				}
				hl.LineNrBelow = {
					fg = "#7aa2f7",
				}
				hl.CursorLine = {
					bg = "none",
				}
			end,
		})

		vim.cmd.colorscheme("tokyonight-night")
	end,
}
