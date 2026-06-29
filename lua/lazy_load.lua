local M = {}

local vim_enter_queue = {}
local override_queue = {}

local function drain(queue)
    vim.iter(queue)
        :each(function(x)
            if x.sync then
                x.fn()
            else
                vim.schedule(x.fn)
            end
        end)
end

local function drain_override()
    if not override_queue then return end
    vim.iter(override_queue)
        :each(function()
            vim.schedule(function(x)
                local ok, err = pcall(x.fn)
                if not ok then
                    vim.notify((".nvim.lua override error:\n%s"):format(err), vim.log.levels.ERROR)
                end
            end)
        end)
    override_queue = nil
end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        drain(vim_enter_queue)
        vim_enter_queue = nil
        drain_override()
    end
})

function M.on_vim_enter(fn, opts)
    local sync = opts and opts.sync or false
    if vim_enter_queue then
        table.insert(vim_enter_queue, { fn = fn, sync = sync })
    elseif sync then
        fn()
    else
        vim.schedule(fn)
    end
end

function M.on_override(fn)
    if override_queue then
        table.insert(override_queue, { fn = fn })
    else
        vim.schedule(fn)
    end
end

return M
