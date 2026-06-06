require("nvim-treesitter").setup({})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        if vim.bo[args.buf].buftype == "" then
            pcall(vim.treesitter.start)
        end
    end,
})
