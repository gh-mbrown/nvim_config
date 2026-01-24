vim.g.mapleader = " "
require("plugins")
require("config")
require("core.lsp").setup()
require("core.diagnostics")
require("languages")

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "grey" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "orange", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "grey" })
--test
