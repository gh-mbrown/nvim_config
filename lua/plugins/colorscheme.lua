return {
	"Shatur/neovim-ayu",
	config = function()
		require("ayu").setup({
			mirage = false,
			overrides = {
				Normal = {
					bg = "None",
				},
				NormalFloat = {
					bg = "None",
				},
				ColorColumn = {
					bg = "None",
				},
				SignColumn = {
					bg = "None",
				},
				Folded = {
					bg = "None",
				},
				FoldedColumn = {
					bg = "None",
				},
				CursorLine = {
					bg = "None",
				},
				CursorColumn = {
					bg = "None",
				},
				VertSplit = {
					bg = "None",
				},
				LineNr = {
					fg = "#ffffff",
				},
				CursorLineNr = {
					bg = "None",
				},
			},
		})

		vim.cmd.colorscheme("ayu")
	end,
}
