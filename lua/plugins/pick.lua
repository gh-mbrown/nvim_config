require("mini.pick").setup({
    source = {
        show = require("mini.pick").default_show
    },
    window = {
        config = {
            width = vim.o.columns,
            height = math.ceil(vim.o.lines * 0.2)
        },
        prompt_caret = "<|",
        prompt_prefix = "|>"
    }
})
