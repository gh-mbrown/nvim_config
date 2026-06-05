local M = {}
M.__index = M

M.print_conflicts = function()
	local conflict_pattern = "^<<<<<<< "
	local conflicts = vim.fn.search(conflict_pattern, "n")
	print("Remaining Conflicts: " .. conflicts)
end

M.close_buffer = function()
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

M.read_cmd = function(cmd)
	if cmd == "" then
		return
	end
	local shell = (vim.fn.has("win32") == 1 and "pwsh" or os.getenv("SHELL"))
	vim.cmd("botright new | term " .. shell .. " -i -c '" .. cmd .. "'")
end

M.list_to_read_bufnr = function()
    local ts = require("nvim-treesitter")
	local installed = ts.get_installed()
	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, installed)
	vim.bo[bufnr].buftype = "nofile"
	vim.bo[bufnr].bufhidden = "wipe"
	vim.bo[bufnr].modifiable = false
	vim.bo[bufnr].readonly = true
	vim.api.nvim_open_win(bufnr, true, { split = "below", win = 0 })
end

M.auto_install_tree_sitter = function()
    local ts = require("nvim-treesitter")
	local ft = vim.bo.filetype
    local remap = {
        cs = "c_sharp",
        jsonc = "json"
    }
    local rft = remap[ft] or ft
	local installed = ts.get_installed()
	if not vim.tbl_contains(installed, rft) then
		local avail = ts.get_available()
		if vim.tbl_contains(avail, rft) then
			ts.install({rft})
		end
	end
end

return M
