vim.pack.add({
    GIT_ROOT .. "neovim/nvim-lspconfig"
})

vim.lsp.enable({
    "lua_ls",
    "ocamllsp",
    "fish_lsp",
    "roslyn_ls",
    "html",
    "zls",
    "pyright",
    "clangd",
    "fsautocomplete",
    "powershell_es"
})
