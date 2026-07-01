require("lazy_load").on_vim_enter(function()
    vim.pack.add({
        GIT_ROOT .. "mbbill/undotree"
    })
    vim.g.undotree_DiffCommand = vim.fn.has("win32") == 1 and "FC" or "diff"
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_WindowLayout = 2
    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
    vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)
end)
