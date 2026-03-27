local function close_buffer()
	local buf = vim.fn.bufnr("%")
	local wins = vim.fn.win_findbuf(buf)

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

vim.api.nvim_create_user_command("CloseBuffer", function()
	close_buffer()
end, {})
