local funcs = require("core.functions")

vim.api.nvim_create_user_command("CreateBranch", function()
	funcs.create_branch()
end, {})

vim.api.nvim_create_user_command("RestoreFile", function()
	funcs.restore_file()
end, {})

vim.api.nvim_create_user_command("RestoreAllFiles", function()
	funcs.restore_all_files()
end, {})

vim.api.nvim_create_user_command("RebaseBranch", function()
	funcs.rebase_branch()
end, {})

vim.api.nvim_create_user_command("PrintConflicts", function()
	funcs.print_conflicts()
end, {})

vim.api.nvim_create_user_command("StashChanges", function()
	funcs.stash_changes()
end, {})

vim.api.nvim_create_user_command("ReadCmd", function(opts)
	funcs.read_cmd(opts.args ~= "" and opts.args or vim.fn.input(""))
end, { nargs = "?" })

vim.api.nvim_create_user_command("UpdateSubmodule", function()
	funcs.update_submodules()
end, {})

vim.api.nvim_create_user_command("GitAdd", function()
	funcs.git_add()
end, {})

vim.api.nvim_create_user_command("GitUnstage", function ()
    funcs.git_unstage()
end, {})

vim.api.nvim_create_user_command("CloseBuffer", function()
	funcs.close_buffer()
end, {})

vim.api.nvim_create_user_command("CreateFile", function()
	funcs.create_file()
end, {})

vim.api.nvim_create_user_command("CreateDir", function ()
    funcs.create_dir()
end, {})

vim.api.nvim_create_user_command("OpenDir", function ()
    funcs.open_dir()
end, {})

vim.api.nvim_create_user_command("TSInstalled", function ()
    funcs.list_to_read_bufnr()
end, {})
