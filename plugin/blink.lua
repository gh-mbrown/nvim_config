vim.pack.add({
    { src = GIT_ROOT .. "saghen/blink.cmp", version = "v1" },
})

require("blink.cmp").setup({
    keymap = {
        ["<C-n>"] = {
            "select_next",
            "fallback_to_mappings",
        },
        ["<C-p>"] = {
            "select_prev",
            "fallback_to_mappings",
        },
        ["<C-y>"] = {
            "select_and_accept",
            "fallback",
        },
        ["<C-e>"] = {
            "hide",
            "fallback",
        },
    },
    appearance = {
        nerd_font_variant = "normal",
    },
    completion = {
        documentation = {
            auto_show = true,
        },
    },
    sources = {
        default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
        },
    },
    fuzzy = {
        implementation = vim.fn.has("win32") == 0 and "prefer_rust_with_warning" or "lua",
    },
})
