return {
	"mbbill/undotree",
	config = function()
		-- for windows
		if vim.fn.has("win32") == 1 then
			vim.g.undotree_DiffCommand = "FC"
		end
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.opt.undofile = true
		vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
	end,
}
