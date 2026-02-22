---Splits window using tmux
---@param is_vert boolean
local function split_window(is_vert)
	local buf = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)

	if file == "" then
		return
	end

	if is_vert then
		vim.fn.system(
			string.format("tmux split-window -h -c '#{pane_current_path}' 'nvim %s'", vim.fn.shellescape(file))
		)
	else
		vim.fn.system(
			string.format("tmux split-window -v -c '#{pane_current_path}' 'nvim %s'", vim.fn.shellescape(file))
		)
	end
end

---Kills the current pane in tmux
local function close_window()
	local num = vim.fn.system("tmux list-panes | wc -l")
	if tonumber(num) > 1 then
		vim.fn.system("tmux kill-pane")
	else
		print("Only one pane active")
	end
end

vim.api.nvim_create_user_command("SplitWindowH", function()
	split_window(true)
end, {})
vim.api.nvim_create_user_command("SplitWindowV", function()
	split_window(false)
end, {})
vim.api.nvim_create_user_command("KillPane", close_window, {})
