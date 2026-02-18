vim.g.mapleader = " "
require("plugins")
require("config")
require("core.lsp").setup()
require("core.diagnostics")
require("languages")
