return {
	"stevearc/oil.nvim",
	---@module "oil"
	---@type oil.SetupOpts
	opts = {},
	dependencies = {
		{
			"nvim-mini/mini.icons",
			opts = {},
		},
	},
	lazy = false,
	config = function()
		local oil = require("oil")
		vim.api.nvim_create_user_command("OilToggleFloat", function()
			oil.toggle_float()
		end, {})
		vim.api.nvim_create_user_command("OilToggleHidden", function()
			oil.toggle_hidden()
		end, {})
		vim.api.nvim_create_user_command("OilClose", function()
			oil.close()
		end, {})
		vim.api.nvim_create_user_command("OilPreview", function()
			oil.open_preview()
		end, {})
		vim.api.nvim_create_user_command("OilOpen", function()
			oil.open()
		end, {})
		oil.setup({
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
