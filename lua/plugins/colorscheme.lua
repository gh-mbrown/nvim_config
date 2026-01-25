return {
	"nanotech/jellybeans.vim",
	config = function()
		vim.g.jellybeans_overrides = {
			background = {
				guibg = "none",
			},
			gutter = {
				guibg = "none",
			},
			signcolumn = {
				guibg = "none",
			},
		}
		vim.cmd.background = "dark"
		vim.cmd.colorscheme("jellybeans")
	end,
}
