-- actual functions
local function close_buffer()
    local buf = vim.fn.bufnr("%")

    local buffers = vim.tbl_filter(function(b)
        return vim.fn.buflisted(b) == 1 and b ~= buf
    end, vim.api.nvim_list_bufs())

    if #buffers > 0 then
        vim.cmd("b#")
        vim.api.nvim_buf_delete(buf, { force = true })
    else
        vim.cmd("quit")
    end
end

local function update_plugins()
    local plugins = vim.pack.get()

    local to_update = {}
    for _, p in pairs(plugins) do
        if p.active then
            table.insert(to_update, p.spec.name)
        end
    end
    vim.pack.update(to_update, {
        target = "version"
    })
end

local function clean_plugins()
    local plugins = vim.pack.get()
    for _, p in pairs(plugins) do
        if not p.active then
            vim.pack.del({p.spec.name})
        end
    end
end

local function get_term()
    local bufs = vim.api.nvim_list_bufs()
    local match = nil
    for _, b in pairs(bufs) do
        local name = vim.fn.bufname(b)
        match = string.match(name, "term://")
        if match then return name end
    end

    return nil
end

local function toggle_term(direction)
    direction = direction or "full"

    local term = get_term()
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

-- user commands to access from cmdline
vim.api.nvim_create_user_command("CloseBuffer", function()
    close_buffer()
end, {})

vim.api.nvim_create_user_command("UpdatePlugins", function()
    update_plugins()
end, {})

vim.api.nvim_create_user_command("CleanPlugins", function ()
    clean_plugins()
end, {})
vim.api.nvim_create_user_command("ToggleTerm", function (opts)
    toggle_term(opts.args)
end, {nargs = 1})
