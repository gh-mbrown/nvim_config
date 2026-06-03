require("mini.pick").setup({
    source = {
        show = require("mini.pick").default_show
    },
    window = {
        config = {
            width = vim.o.columns,
            height = vim.o.lines * 0.5
        },
        prompt_caret = "<|",
        prompt_prefix = "|>"
    }
})
