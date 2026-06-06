-- Disable inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
    end,
})
