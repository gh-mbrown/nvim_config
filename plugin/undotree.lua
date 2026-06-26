vim.pack.add({
    GIT_ROOT .. "mbbill/undotree"
})
if vim.fn.has("win32") == 1 then
    vim.g.undotree_DiffCommand = "FC"
end
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)
