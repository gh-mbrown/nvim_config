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

---@class ExecuteTSQueryOptions
---@field query_type? string

---@class PickBuffer
---@field text string
---@field path string
---@field lnum integer
---@field col integer

---@param opts ExecuteTSQueryOptions
---@return PickBuffer[]?
function Execute_ts_query(opts)
    local query_type = opts.query_type or "var"

    local bufnr = vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(bufnr)
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)

    if not lang then
        vim.notify("No treesitter query for filetype:" .. (vim.bo.filetype or "unkown"), vim.log.levels.ERROR)
        return nil
    end

    local parser = vim.treesitter.get_parser(bufnr, lang)
    if not parser then
        vim.notify("No treesitter parser for lang: " .. (lang or "unkown"), vim.log.levels.ERROR)
        return nil
    end

    local tree = parser:parse()[1]
    local root = tree:root()

    local query = vim.treesitter.query.get(lang, query_type)
    if not query then
        vim.notify("No treesitter query " .. query_type .. " for " .. lang, vim.log.levels.ERROR)
    end

    ---@type PickBuffer[]
    local items = {}
    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        local cap = query.captures[id]
        if cap then
            local row, col = node:start()
            local result = vim.treesitter.get_node_text(node, bufnr)

            ---@type PickBuffer
            local record = {
                text = result,
                path = path,
                lnum = row + 1,
                col = col + 1,
            }
            table.insert(items, record)
        end
    end

    if #items == 0 then
        vim.notify("No " .. query_type .. " found")
    end

    return items
end

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
vim.keymap.set("n", "<leader>ti", list_to_read_bufnr)
vim.keymap.set("n", "<leader>tu", vim.cmd.TSUpdate)
