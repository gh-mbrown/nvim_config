vim.pack.add({
    Git_root .. "ayu-theme/ayu-vim"
})
vim.opt.background = "dark"
vim.cmd.colorscheme("ayu")
if vim.g.neovide then
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#f29718" })
    vim.api.nvim_set_hl(0, "MiniPickPreviewLine", { bg = "#151a1e" })
    vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = "#151a1e" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end
