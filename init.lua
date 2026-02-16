vim.g.mapleader = " "
require("plugins")
require("config")
require("core.lsp").setup()
require("core.diagnostics")
require("languages")

vim.api.nvim_set_hl(0, "HopNextKey", {
	bg = "NONE",
	fg = "#ff007c",
	bold = true,
})

vim.api.nvim_set_hl(0, "HopNextKey1", {
	bg = "NONE",
	fg = "#00dfff",
	bold = true,
})
vim.api.nvim_set_hl(0, "HopNextKey2", {
	bg = "NONE",
	fg = "#2b8db3",
	bold = true,
})

vim.api.nvim_set_hl(0, "LineNr", {
	fg = "#ebbcba",
})
vim.api.nvim_set_hl(0, "LineNrBelow", {
	fg = "#6e6a86",
})
vim.api.nvim_set_hl(0, "LineNrAbove", {
	fg = "#6e6a86",
})
