vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.cshtml", "*.razor"},
    callback = function ()
        vim.bo.filetype = "html.cshtml.razor"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "<filetype>" },
    callback = function ()
        vim.treesitter.start()
    end
})

vim.api.nvim_create_autocmd({"BufWritePost", "LspAttach", "BufEnter"}, {
    callback = function (args)
        local bufnr = args.buf or 0
        vim.lsp.inlay_hint.enable(false, {bufnr = bufnr})
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
