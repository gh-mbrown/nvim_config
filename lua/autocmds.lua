-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Disable inlay hints
vim.api.nvim_create_autocmd("lspattach", {
    callback = function(args)
        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
    end,
})
