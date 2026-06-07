local pick = require("mini.pick")
local presets = require("config.presets")

pick.setup({
    mappings = {
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
        delete_left = "<C-b>",
    },
    source = {
        show = pick.default_show
    },
    window = {
        config = {
            anchor = "NW",
            width = vim.o.columns,
            height = math.floor(vim.o.lines * 0.4)
        },
        prompt_caret = "<|",
        prompt_prefix = "|>"
    }
})

vim.ui.select = function(items, opts, l_opts, func)
    return pick.ui_select(items, opts, func, l_opts)
end

local function start_pick(opts)
    if not opts.items then return end
    local items
    if type(opts.items) == "function" then
        items = opts.items()
    else
        items = opts.items
    end
    if not items or #items == 0 then return end
    local name = opts.name or nil
    local choose = opts.choose or nil
    local choose_marked = opts.choose_marked or nil

    pick.start({
        source = {
            items = items,
            name = name,
            choose = choose,
            choose_marked = choose_marked
        },
    })
end

local function cli_pick(opts)
    local command = opts.command or nil
    local post_process = opts.post_process or nil
    local name = opts.name or nil
    local choose = opts.choose or nil
    local choose_marked = opts.choose_marked or nil

    pick.builtin.cli({
            command = command,
            postprocess = post_process,
        },
        {
            source = {
                name = name,
                choose = choose,
                choose_marked = choose_marked,
            }
        })
end

vim.api.nvim_create_user_command("GitFilesPick", function()
    pick.builtin.files({ tool = "git" })
end, {})

vim.api.nvim_create_user_command("GitPick", function(opts)
    local preset = presets.git[opts.args]
    if not preset then
        vim.notify("GitPick: unkown preset '" .. opts.args .. "'", vim.log.levels.ERROR)
        return
    end
    cli_pick(preset)
end, {
    nargs = 1,
    complete = function()
        return vim.tbl_keys(presets.git)
    end
})

vim.api.nvim_create_user_command("TreesitterPick", function(opts)
    local preset = presets.treesitter[opts.args]
    if not preset then
        vim.notify("TressitterPick: unkown preset '" .. opts.args .. "'", vim.log.levels.ERROR)
        return
    end
    start_pick(preset)
end, {
    nargs = 1,
    complete = function()
        return vim.tbl_keys(presets.treesitter)
    end
})

vim.api.nvim_create_user_command("MiscPick", function(opts)
    local preset = presets.misc[opts.args]
    if not preset then
        vim.notify("MiscPick: unkown preset '" .. opts.args .. "'", vim.log.levels.ERROR)
        return
    end
    start_pick(preset)
end, {
    nargs = 1,
    complete = function()
        return vim.tbl_keys(presets.misc)
    end
})

vim.api.nvim_create_user_command("MiscCliPick", function(opts)
    local preset = presets.misc_cli[opts.args]
    if not preset then
        vim.notify("MiscCliPick: unkown preset '" .. opts.args .. "'", vim.log.levels.ERROR)
        return
    end
    cli_pick(preset)
end, {
    nargs = 1,
    complete = function()
        return vim.tbl_keys(presets.misc_cli)
    end
})
