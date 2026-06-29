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
        vim.notify("Last buffer", vim.log.levels.INFO)
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

local term_options = {
    right = { open = "vsplit %s", new = "vert term" },
    left = { open = "leftabove vsplit %s", new = "leftabove vert term" },
    above = { open = "leftabove split %s", new = "leftabove hor term" },
    below = { open = "split %s", new = "hor term" },
    full = { open = "edit %s", new = "term" },
}

local function toggle_term(direction)
    local function apply_term(term)
        local c = term_options[direction]
        vim.cmd(term and c.open:format(term) or c.new)
    end

    local terms = vim.iter(vim.api.nvim_list_bufs())
        :map(function(b)
            return vim.fn.bufname(b)
        end)
        :filter(function(b)
            return string.match(b, "term://")
        end)
        :totable()

    local call = function()
        vim.ui.select(terms, {}, function(choice)
            if not choice then return else apply_term(choice) end
        end)
    end

    if #terms > 1 then
        call()
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
        return vim.iter(vim.tbl_keys(term_options))
            :filter(function(x)
                return x:find("^" .. lead)
            end)
            :totable()
    end
})

vim.keymap.set("n", "<leader>tt", vim.cmd.ToggleTerm)
