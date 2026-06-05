local pick = require("mini.pick")
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
            width = vim.o.columns,
            height = math.floor(vim.o.lines * 0.4)
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
