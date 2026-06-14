vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end
})

vim.pack.add({
    { src = Git_root .. "nvim-treesitter/nvim-treesitter", verison = "main", }
})

local ts = require("nvim-treesitter")
ts.setup({})

local function auto_install_tree_sitter()
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

local function list_to_read_bufnr()
    local installed = ts.get_installed()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, installed)
    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].bufhidden = "wipe"
    vim.bo[bufnr].modifiable = false
    vim.bo[bufnr].readonly = true
    vim.api.nvim_open_win(bufnr, true, { split = "below", win = 0 })
end

vim.api.nvim_create_user_command("TSInstalled", function()
    list_to_read_bufnr()
end, {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        auto_install_tree_sitter()
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        if vim.bo[args.buf].buftype == "" then
            pcall(vim.treesitter.start)
        end
    end,
})

vim.keymap.set("n", "<leader>tt", vim.cmd.InspectTree)
vim.keymap.set("n", "<leader>te", vim.cmd.EditQuery)
vim.keymap.set("n", "<leader>ti", vim.cmd.TSInstalled)
