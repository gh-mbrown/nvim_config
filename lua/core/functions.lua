local M = {}
M.__index = M

local function create_picker(name, list, func)
    local config = require("telescope.config").values
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local themes = require("telescope.themes")
	local opts = {
		prompt_title = name,
		finder = finders.new_table({
			results = list,
		}),
		previewer = config.file_previewer({}),
		sorter = config.generic_sorter({}),
	}

	if func then
		opts.attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				func(selection[1])
			end)
			return true
		end
	end
	pickers.new(themes.get_ivy({}), opts):find()
end

local function get_diff_files(staged)
	return vim.fn.systemlist("git diff --name-only " .. (staged and "--staged" or "") .. "| awk '{ print $1 }'")
end

local function get_all_dirs(path, dirs)
	local content = vim.split(vim.fn.glob(path .. "/*"), "\n", { trimempty = true })
	for _, f in pairs(content) do
		if vim.fn.isdirectory(f) == 1 then
			vim.list_extend(dirs, { f })
			dirs = get_all_dirs(f, dirs)
		end
	end
	return dirs
end

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

M.create_branch = function()
	local branch = vim.fn.input("Branch name: ")
	if branch ~= "" then
		vim.cmd.Git("checkout -b " .. branch)
		vim.cmd.Git("push -u origin " .. branch)
	end
end

M.restore_file = function()
	local list = get_diff_files(false)
	create_picker("Restore File", list, function(sel)
		vim.cmd.Git("restore " .. sel)
	end)
end

M.restore_all_files = function()
	local confirm = vim.fn.input("Do you want to restore ALL files(yes/no): ")
	if confirm == "yes" then
		vim.cmd.Git("restore :/")
	end
end

M.stash_changes = function()
	local list = get_diff_files(false)
	create_picker("Stash File", list, function(sel)
		local message = vim.fn.input("Stash Message: ")
		vim.cmd.Git("stash push --message '" .. message .. "' " .. sel)
	end)
end

M.update_submodules = function()
	local list = vim.fn.systemlist("git config --file .gitmodules --get-regexp path | awk '{ print $2 }'")
	create_picker("Update Submodule", list, function(sel)
		vim.cmd.Git("submodule update --remote " .. sel)
	end)
end

M.rebase_branch = function()
	local list = vim.fn.systemlist("git branch | awk '{ print $2 }'")
	create_picker("Rebase Branch", list, function(sel)
		vim.cmd.Git("rebase " .. sel)
	end)
end

M.git_add = function()
	local list = get_diff_files(false)
	create_picker("Add File", list, function(sel)
		vim.cmd.Git("add " .. sel)
	end)
end

M.git_unstage = function()
	local list = get_diff_files(true)
	create_picker("Unstage File", list, function(sel)
		vim.cmd.Git("restore --staged " .. sel)
	end)
end

M.create_file = function()
	local dirs = get_all_dirs(".", {})
	create_picker("Create File", dirs, function(sel)
		local file = vim.fn.input("File name: ")
		local path = vim.fs.joinpath(sel, file)
		vim.cmd.edit(path)
	end)
end

M.create_dir = function()
	local dirs = get_all_dirs(".", {})
	create_picker("Create Dir", dirs, function(sel)
		local dir = vim.fn.input("Dir name: ")
		local path = vim.fs.joinpath(sel, dir)
		vim.fn.mkdir(path)
	end)
end

M.open_dir = function()
	local dirs = get_all_dirs(".", {})
	create_picker("Open Dir", dirs, function(sel)
		vim.cmd.edit(sel)
	end)
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
	local installed = ts.get_installed()
	if not vim.tbl_contains(installed, ft) then
		local avail = ts.get_available()
		if vim.tbl_contains(avail, ft) then
			ts.install(ft)
		end
	end
end

return M
