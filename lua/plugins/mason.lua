return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {},
			config = function()
				require("mason").setup({
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				})
			end,
		},
		"neovim/nvim-lspconfig",
	},
	opts = {
		ensure_installed = {
			"gopls",
			"lua_ls",
			"bashls",
			"jsonls",
			"stylua",
			"pyright",
			"rust_analyzer",
			"zls",
			"clangd",
			-- "codelldb",
			"fsautocomplete",
			"neocmake",
			"ruff",
		},
	},
	highlight = {
		enable = true,
	},
}
