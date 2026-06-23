vim.pack.add({
    GIT_ROOT .. "ayu-theme/ayu-vim"
})
vim.opt.background = "dark"
vim.cmd.colorscheme("ayu")
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#f29718" })
vim.api.nvim_set_hl(0, "MiniPickPreviewLine", { bg = "#151a1e" })
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = "#151a1e" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
if not vim.g.neovide then
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end
