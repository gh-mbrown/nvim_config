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
		ensure_installed = {},
	},
}
