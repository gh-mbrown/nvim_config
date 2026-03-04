return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = function()
		require("go").setup({
			lsp_inlay_hints = {
				enable = false,
			},
		})
		local format = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
				require("go.format").gofmt()
			end,
			group = format,
		})
		return {}
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ":lua require('go.install').update_all_sync()",
}
