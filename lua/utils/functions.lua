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

M.preview_terminal = function(buf_id, term_buf)
    local pick = require("mini.pick")
    local state = pick.get_picker_state()
    local preview_win = state.windows and state.windows.target

    if not preview_win or vim.api.nvim_win_get_buf(preview_win) ~= buf_id then
        preview_win = vim.iter(vim.api.nvim_list_wins())
            :filter(function(w)
                return vim.api.nvim_win_get_buf(w) == buf_id
            end)
            :nth(1)
    end

    if preview_win then
        vim.api.nvim_win_set_buf(preview_win, term_buf)
        local line_count = vim.api.nvim_buf_line_count(term_buf)
        pcall(vim.api.nvim_win_set_cursor, preview_win, { line_count, 0 })
    end
end

return M
