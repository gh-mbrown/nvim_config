vim.g.mapleader = " "
require("plugins")
require("config")
require("core.lsp").setup()
require("core.diagnostics")
require("languages")

vim.api.nvim_set_hl(0, "BlinkCmpDoc", {
	bg = "none",
})
vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", {
	bg = "none",
})
vim.api.nvim_set_hl(0, "Cursorline", {
	bg = "none",
})
