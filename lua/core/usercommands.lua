local funcs = require("core.functions")

vim.api.nvim_create_user_command("PrintConflicts", function()
    funcs.print_conflicts()
end, {})

vim.api.nvim_create_user_command("ReadCmd", function(opts)
    funcs.read_cmd(opts.args ~= "" and opts.args or vim.fn.input(""))
end, { nargs = "?" })

vim.api.nvim_create_user_command("CloseBuffer", function()
    funcs.close_buffer()
end, {})

vim.api.nvim_create_user_command("TSInstalled", function()
    funcs.list_to_read_bufnr()
end, {})
