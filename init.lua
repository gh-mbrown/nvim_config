vim.g.mapleader = " "
require("config")
require("core")

vim.lsp.enable("lua_ls")
vim.lsp.enable("fish_lsp")
vim.lsp.enable("ocamllsp")
vim.lsp.enable("roslyn_ls")
vim.lsp.enable("html")
