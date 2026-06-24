local buf_access_time = {}

local function bufs_by_last_access()
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

local function open_previous_buffer()
    vim.cmd.buffer(vim.iter(bufs_by_last_access())
        :filter(function(x)
            return x ~= vim.api.nvim_get_current_buf()
        end)
        :nth(1))
end

local function close_buffer()
    local buf = vim.fn.bufnr("%")

    local buffers = vim.iter(vim.api.nvim_list_bufs())
        :filter(function(b)
            return vim.fn.buflisted(b) == 1 and b ~= buf
        end)
        :totable()

    if #buffers > 0 then
        vim.cmd("OpenPreviousBuffer")
        vim.api.nvim_buf_delete(buf, { force = true })
    else
        vim.cmd("quit")
    end
end

local function update_plugins()
    vim.iter(vim.pack.get())
        :filter(function(p)
            return p.active
        end)
        :map(function(p)
            return p.spec.name
        end)
        :each(function(p)
            vim.pack.update({ p }, { target = "version" })
        end)
end

local function clean_plugins()
    vim.pack.del(
        vim.iter(vim.pack.get())
        :filter(function(p)
            return not p.active
        end)
        :map(function(p)
            return p.spec.name
        end)
        :totable()
    )
end

local function toggle_term(direction)
    local terms = vim.iter(vim.api.nvim_list_bufs())
        :map(function (b)
            return vim.fn.bufname(b)
        end)
        :filter(function(b)
            return string.match(b, "term://")
        end)
        :totable()

    local function apply_term(term)
        if term then
            if direction == "right" then
                vim.cmd("vsplit " .. term)
            elseif direction == "left" then
                vim.cmd("leftabove vsplit " .. term)
            elseif direction == "above" then
                vim.cmd("leftabove split " .. term)
            elseif direction == "below" then
                vim.cmd("split " .. term)
            elseif direction == "full" then
                vim.cmd("edit " .. term)
            end
        else
            if direction == "right" then
                vim.cmd("vert term")
            elseif direction == "left" then
                vim.cmd("leftabove vert term")
            elseif direction == "above" then
                vim.cmd("leftabove hor term")
            elseif direction == "below" then
                vim.cmd("hor term")
            elseif direction == "full" then
                vim.cmd("term")
            end
        end
    end

    if #terms > 1 then
        vim.ui.select(terms, {
            preview_item = function (item)
                return vim.api.nvim_buf_get_lines(vim.fn.bufnr(item), 0, -1, false)
            end
        }, function(choice)
            if not choice then return else apply_term(choice) end
        end, {})
    elseif #terms == 1 then
        apply_term(terms[1])
    else
        apply_term(nil)
    end
end

vim.api.nvim_create_user_command("OpenPreviousBuffer", open_previous_buffer, {})
vim.api.nvim_create_user_command("CloseBuffer", close_buffer, {})
vim.api.nvim_create_user_command("UpdatePlugins", update_plugins, {})
vim.api.nvim_create_user_command("CleanPlugins", clean_plugins, {})
vim.api.nvim_create_user_command("ToggleTerm", function(opts)
    toggle_term(opts.args == "" and "full" or opts.args)
end, {
    nargs = "?",
    complete = function(lead)
        return vim.iter({ "full", "right", "left", "above", "below" })
            :filter(function(x)
                return x:find("^" .. lead)
            end)
            :totable()
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(ev)
        buf_access_time[ev.buf] = vim.uv.hrtime()
    end
})
