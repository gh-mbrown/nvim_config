return {
	"stevearc/oil.nvim",
	---@module "oil"
	---@type oil.SetupOpts
	opts = {},
	dependencies = {
		{ "nvim-mini/mini.icons", opts = {} },
	},
	lazy = false,
	config = function()
		local oil = require("oil")
		oil.setup({
			view_options = {
				show_hidden = true,
			},
		})

		vim.api.nvim_create_user_command("ToggleFloatOil", function()
			oil.toggle_float(nil, nil, nil)
		end, {})
		vim.api.nvim_create_user_command("ToggleHiddenOil", function()
			oil.toggle_hidden()
		end, {})
		vim.api.nvim_create_user_command("OpenOil", function()
			oil.open(nil, nil, nil)
		end, {})
		vim.api.nvim_create_user_command("CloseOil", function()
			oil.close(nil)
		end, {})
		vim.api.nvim_create_user_command("PreviewOil", function()
			oil.open_preview(nil, nil)
		end, {})
	end,
}
