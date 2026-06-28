local M = {}
M.__index = M

M.list_to_buffer = function(list)
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, list)
    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].bufhidden = "wipe"
    vim.bo[bufnr].modifiable = false
    vim.bo[bufnr].readonly = true
    vim.api.nvim_open_win(bufnr, true, { split = "below", win = 0 })
end

M.preview_terminal = function(buf_id, item)
    local pick = require("mini.pick")
    local state = pick.get_picker_state()
    local preview_win = state.windows and state.windows.target

    if not preview_win or vim.api.nvim_win_get_buf(preview_win) ~= buf_id then
        preview_win = vim.iter(vim.api.nvim_list_wins())
            :find(function(w)
                return vim.api.nvim_win_get_buf(w) == buf_id
            end)
    end

    local old_ei = vim.o.eventignore
    vim.o.eventignore = "TermOpen,BufEnter"

    local ok, err = pcall(function()
        if preview_win then
            vim.api.nvim_win_set_buf(preview_win, item.bufnr)
            local line_count = vim.api.nvim_buf_line_count(item.bufnr)
            pcall(vim.api.nvim_win_set_cursor, preview_win, { line_count, 0 })
        end
    end)

    vim.o.eventignore = old_ei

    if not ok then error(err) end
end

M.get_cwd_items = function(opts)
    return vim.iter(vim.fs.dir(opts.path and opts.path or vim.fn.getcwd(),
            { depth = (opts.depth and opts.depth or math.huge) }))
        :filter(function(_, type) return vim.tbl_contains((opts.types and opts.types or { "directory" }), type) end)
        :map(function(name, _) return name end)
        :totable()
end

M.get_treesitter_list = function(opts)
    local file = opts.file or "highlights"

    local bufnr = vim.api.nvim_get_current_buf()
    local lang = vim.bo[bufnr].filetype
    local parser = vim.treesitter.get_parser(bufnr, lang)
    local tree = parser:parse()[1]
    local query = vim.treesitter.query.get(lang, file)
    local root = tree:root()
    local results = {}

    for id, node in query:iter_captures(root, bufnr) do
        local capture_name = query.captures[id]
        if opts.filter and not vim.tbl_contains(opts.filter, capture_name) then goto continue end
        local text = vim.treesitter.get_node_text(node, bufnr)
        local path = vim.api.nvim_buf_get_name(bufnr)
        local row, col = node:start()
        local value = {
            text = text,
            path = path,
            lnum = row + 1,
            col = col + 1
        }
        if results[capture_name] then table.insert(results[capture_name], value) else results[capture_name] = { value } end

        ::continue::
    end

    return results
end

local icon_hl_cache = {}
local function get_icon_hl(path)
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok then return end

    local icon, color = icons.get_icon(vim.fn.fnamemodify(path, ":t"), vim.fn.fnamemodify(path, ":e"),
        { default = true })
    local hl_group = color and "FileIcon_" .. color:sub(2) or "nil"
    if not icon_hl_cache[hl_group] then
        vim.api.nvim_set_hl(0, hl_group, { fg = color })
        icon_hl_cache[hl_group] = true
    end

    return icon, hl_group
end

M.get_diagnostics = function(opts)
    return vim.iter(vim.diagnostic.get(nil, {
            severity = opts.severity and opts.severity or {
                vim.diagnostic.severity.ERROR,
                vim.diagnostic.severity.WARN,
            }
        }))
        :map(function(x)
            local file_path = vim.fn.bufname(x.bufnr)
            local line = x.end_lnum + 1
            local col = x.col + 1
            local text = string.format("%s %s:%d:%d %s", vim.diagnostic.severity[x.severity],
                vim.fn.fnamemodify(file_path, ":~:."), line, col, x.message)
            -- local icon, hl_group = get_icon_hl(file_path)
            -- vim.api.nvim_buf_add_highlight(0, 0, hl_group, i - 1, 0, #icon)
            return {
                text = text,
                path = file_path,
                lnum = line,
                col = col
            }
        end)
        :totable()
end

return M
