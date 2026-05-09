return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			custom_highlights = {
				CursorLine = {
					bg = "none",
				},
			},
			integrations = {
				hop = true,
				which_key = true,
				mason = true,
				harpoon = true,
			},
		})
		vim.cmd.colorscheme("catppuccin-nvim")
	end,
}
