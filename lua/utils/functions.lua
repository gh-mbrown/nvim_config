local M = {}
M.__index = M

M.buf_access_time = {}

function M.bufs_by_last_access()
    local bufs = vim.iter(vim.api.nvim_list_bufs())
        :filter(function(b)
            return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
        end)
        :totable()
    table.sort(bufs, function(x, y)
        return (M.buf_access_time[x] or 0) > (M.buf_access_time[y] or 0)
    end)
    return bufs
end

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

return M
