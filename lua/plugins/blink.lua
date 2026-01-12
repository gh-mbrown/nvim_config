return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets"
    },
    version = "1.*",
    opts = {
        keymap = {
            ["<C-j>"] = {
                "select_next",
                "fallback_to_mappings"
            },
            ["<C-k>"] = {
                "select_prev",
                "fallback_to_mappings"
            },
            ["<CR>"] = {
                "select_and_accept",
                "fallback"
            },
            ["<C-;>"] = {
                "hide",
                "fallback"
            }
        },
        appearance = {
            nerd_font_variant = "normal"
        },
        completion = {
            documentation = {
                auto_show = true
            }
        },
        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
            }
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning"
        },
    },
    opts_extend = {
        "sources.default"
    },
}
