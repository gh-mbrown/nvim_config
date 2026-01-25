return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)
		-- for windows
        if (vim.fn.has("win32")) then
            vim.g.undotree_DiffCommand = "FC"
        end
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.opt.undofile = true
		vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
	end,
}
