-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Disable inlay hints
vim.api.nvim_create_autocmd("lspattach", {
    callback = function(args)
        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
    end,
})

-- Enter terminal in insert mode
vim.api.nvim_create_autocmd({"TermOpen", "BufEnter"}, {
    pattern = "term://*",
    callback = function ()
        vim.cmd("startinsert")
    end
})
