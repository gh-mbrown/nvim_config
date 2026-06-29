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

vim.api.nvim_create_autocmd({"TermOpen", "BufEnter"}, {
    pattern = "term://*",
    callback = function ()
        vim.cmd("startinsert")
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(ev)
        local funcs = require("utils.functions")
        local buf_access_time = funcs.get_buf_access_time()
        buf_access_time[ev.buf] = vim.uv.hrtime()
        funcs.set_buf_access_time(buf_access_time)
    end
})
