return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "1.*",
	opts = {
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
			implementation = "prefer_rust_with_warning",
		},
	},
	opts_extend = {
		"sources.default",
	},
}
