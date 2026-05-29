local function close_buffer()
	local buf = vim.fn.bufnr("%")

	local buffers = vim.tbl_filter(function(b)
		return vim.fn.buflisted(b) == 1 and b ~= buf
	end, vim.api.nvim_list_bufs())

	if #buffers > 0 then
		vim.cmd("buffer " .. buffers[#buffers])
		vim.api.nvim_buf_delete(buf, { force = false })
	else
		vim.cmd("quit")
	end
end
local function checkout_branch()
	local branch = vim.fn.input("Branch name: ")
	if branch ~= "" then
		vim.cmd.Git("checkout -b " .. branch)
		vim.cmd.Git("push -u origin " .. branch)
	end
end
local function restore_file()
	local file = vim.fn.expand("%")
	local confirm = vim.fn.input("Do you want to restore this file(yes/no): ")
	if confirm == "yes" then
		vim.cmd.Git("restore " .. file)
	end
end
local function restore_all_files()
	local confirm = vim.fn.input("Do you want to restore ALL files(yes/no): ")
	if confirm == "yes" then
		vim.cmd.Git("restore :/")
	end
end
local function rebase_branch()
	local branch = vim.fn.input("Branch to rebase on: ")
	if branch ~= "" then
		vim.cmd.Git("rebase " .. branch)
	end
end
local function print_conflicts()
	local conflict_pattern = "^<<<<<<< "
	local conflicts = vim.fn.search(conflict_pattern, "n")
	print("Remaining Conflicts: " .. conflicts)
end
local function stash_changes()
	local message = vim.fn.input("Stash Message: ")
	local file = vim.fn.expand("%")
	vim.cmd.Git("stash push --message '" .. message .. "' " .. file)
end
local function read_cmd(cmd)
	vim.cmd("botright new | term " .. cmd)
end

vim.api.nvim_create_user_command("CheckoutBranch", function()
	checkout_branch()
end, {})
vim.api.nvim_create_user_command("RestoreFile", function()
	restore_file()
end, {})
vim.api.nvim_create_user_command("RestoreAllFiles", function()
	restore_all_files()
end, {})
vim.api.nvim_create_user_command("RebaseBranch", function()
	rebase_branch()
end, {})
vim.api.nvim_create_user_command("PrintConflicts", function()
	print_conflicts()
end, {})
vim.api.nvim_create_user_command("StashChanges", function()
	stash_changes()
end, {})
vim.api.nvim_create_user_command("ReadCmd", function(opts)
	read_cmd(opts.args ~= "" and opts.args or vim.fn.input(""))
end, { nargs = "?" })
vim.api.nvim_create_user_command("CloseBuffer", function()
	close_buffer()
end, {})
