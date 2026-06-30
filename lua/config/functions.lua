local function open_previous_buffer()
    vim.cmd.buffer(vim.iter(require("utils.functions").bufs_by_last_access())
        :find(function(x)
            return x ~= vim.api.nvim_get_current_buf()
        end))
end

local function close_buffer()
    local buf = vim.fn.bufnr("%")

    local buffers = vim.iter(vim.api.nvim_list_bufs())
        :filter(function(b)
            return vim.fn.buflisted(b) == 1 and b ~= buf
        end)
        :totable()

    if #buffers > 0 then
        open_previous_buffer()
        vim.api.nvim_buf_delete(buf, { force = true })
    else
        local ok, oil = pcall(require, "oil")
        if ok then
            oil.open()
            vim.api.nvim_buf_delete(buf, { force = true })
        else
            vim.notify("Last buffer", vim.log.levels.INFO)
        end
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
local function show_plugins()
    require("utils.functions").list_to_buffer(vim.iter(vim.pack.get())
        :filter(function (p)
            return p.active
        end)
        :map(function (p)
            local sub = string.gsub(p.spec.src, "%" .. GIT_ROOT, "")
            return sub
        end)
        :totable())
end

vim.api.nvim_create_user_command("OpenPreviousBuffer", open_previous_buffer, {})
vim.api.nvim_create_user_command("CloseBuffer", close_buffer, {})
vim.api.nvim_create_user_command("UpdatePlugins", update_plugins, {})
vim.api.nvim_create_user_command("CleanPlugins", clean_plugins, {})
vim.api.nvim_create_user_command("ShowPlugins", show_plugins, {})
