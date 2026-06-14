-- actual functions
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

    local to_clean = {}
    for _, p in pairs(plugins) do
        if not p.active then
            table.insert(to_clean, p.spec.name)
        end
    end
    vim.pack.del(to_clean)
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
