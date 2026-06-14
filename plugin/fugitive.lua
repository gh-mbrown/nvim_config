vim.pack.add({
    Git_root .. "tpope/vim-fugitive"
})
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")
