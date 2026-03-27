return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			float = {
				solid = true,
			},
			term_colors = false,
			integrations = {
				blink_cmp = {
					style = "bordered",
				},
				harpoon = true,
				hop = true,
				mason = true,
				telescope = {
					enabled = true,
				},
				which_key = true,
				lualine = {
					normal = {
						a = { bg = mocha.blue, fg = mocha.mantle, gui = "bold" },
						b = { bg = mocha.surface0, fg = mocha.blue },
						c = { bg = "none", fg = mocha.text },
					},

					insert = {
						a = { bg = mocha.green, fg = mocha.base, gui = "bold" },
						b = { bg = mocha.surface0, fg = mocha.green },
					},

					terminal = {
						a = { bg = mocha.green, fg = mocha.base, gui = "bold" },
						b = { bg = mocha.surface0, fg = mocha.green },
					},

					command = {
						a = { bg = mocha.peach, fg = mocha.base, gui = "bold" },
						b = { bg = mocha.surface0, fg = mocha.peach },
					},
					visual = {
						a = { bg = mocha.mauve, fg = mocha.base, gui = "bold" },
						b = { bg = mocha.surface0, fg = mocha.mauve },
					},
					replace = {
						a = { bg = mocha.red, fg = mocha.base, gui = "bold" },
						b = { bg = mocha.surface0, fg = mocha.red },
					},
					inactive = {
						a = { bg = "none", fg = mocha.blue },
						b = { bg = "none", fg = mocha.surface1, gui = "bold" },
						c = { bg = "none", fg = mocha.overlay0 },
					},
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-nvim")
	end,
}
