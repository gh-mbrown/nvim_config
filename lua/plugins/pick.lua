local pick = require("mini.pick")
local height = math.floor(0.618 * vim.o.lines)
local width = math.floor(0.618 * vim.o.columns)
pick.setup({
    mappings = {
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
        delete_left = "<C-b>",
        toggle_preview = "<C-z>"
    },
    source = {
        show = require("mini.pick").default_show
    },
    window = {
        config = {
            anchor = "NW",
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
            width = width,
            height = height
        },
        prompt_caret = "<|",
        prompt_prefix = "|>"
    }
})

vim.ui.select = function(items, opts, name, func)
    local l_opts = {
        source = {
            name = name,
        }
    }
    return pick.ui_select(items, opts, func, l_opts)
end
