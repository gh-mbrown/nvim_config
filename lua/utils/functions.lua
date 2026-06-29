local M = {}
M.__index = M

local buf_access_time = {}

function M.get_buf_access_time() return buf_access_time end
function M.set_buf_access_time(opts) buf_access_time = opts end

function M.bufs_by_last_access()
    local bufs = vim.iter(vim.api.nvim_list_bufs())
        :filter(function(b)
            return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
        end)
        :totable()
    table.sort(bufs, function(x, y)
        return (buf_access_time[x] or 0) > (buf_access_time[y] or 0)
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

return M
