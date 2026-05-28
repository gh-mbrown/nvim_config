return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			transparent = true,
			theme = "wave",
			overrides = function(colors)
				local theme = colors.theme
				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
					CursorLine = { bg = "none" },
					SignColumn = { bg = "none" },
					LineNr = { bg = "none", fg = "#54546d" },
					CursorLineNr = { bg = "none", fg = "#ff9e3b" },
					BlinkCmpMenu = { bg = "none" },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
