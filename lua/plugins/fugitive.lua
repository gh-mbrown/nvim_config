return {
	"tpope/vim-fugitive",
	config = function()
		vim.opt.diffopt:append("algorithm:patience")
		vim.opt.diffopt:append("indent-heuristic")
	end,
}
