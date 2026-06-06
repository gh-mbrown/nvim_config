local function print_conflicts()
    local conflict_pattern = "^<<<<<<< "
    local conflicts = vim.fn.search(conflict_pattern, "n")
    print("Remaining Conflicts: " .. conflicts)
end

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

local function read_cmd(cmd)
    if cmd == "" then
        return
    end
    local shell = (vim.fn.has("win32") == 1 and "pwsh" or os.getenv("SHELL"))
    vim.cmd("botright new | term " .. shell .. " -i -c '" .. cmd .. "'")
end

local function list_to_read_bufnr()
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

local function auto_install_tree_sitter()
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
            ts.install({ rft })
        end
    end
end

vim.api.nvim_create_user_command("PrintConflicts", function()
    print_conflicts()
end, {})

vim.api.nvim_create_user_command("ReadCmd", function(opts)
    read_cmd(opts.args ~= "" and opts.args or vim.fn.input(""))
end, { nargs = "?" })

vim.api.nvim_create_user_command("CloseBuffer", function()
    close_buffer()
end, {})

vim.api.nvim_create_user_command("TSInstalled", function()
    list_to_read_bufnr()
end, {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        auto_install_tree_sitter()
    end
})
