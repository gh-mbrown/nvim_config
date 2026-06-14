vim.pack.add({
    Git_root .. "neovim/nvim-lspconfig"
})

vim.lsp.enable({
    "lua_ls",
    "ocamllsp",
    "fish_lsp",
    "roslyn_ls",
    "html",
    "zls",
    "pyright",
    "clangd"
})
