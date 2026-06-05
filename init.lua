vim.g.mapleader = " "
require("config")
require("core")

vim.lsp.enable({
    "lua_ls",
    "ocamllsp",
    "fish_lsp",
    "roslyn_ls",
    "html",
    "zls",
    "pyright"
})
