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

		vim.api.nvim_create_user_command("ToggleOilCurrent", function()
			local dir = oil.get_current_dir(vim.api.nvim_get_current_buf())
			oil.toggle_float(dir, {}, nil)
		end, {})
		vim.api.nvim_create_user_command("ToggleOilRoot", function()
			local dir = vim.fn.getcwd()
			oil.toggle_float(dir, {}, nil)
		end, {})
		vim.api.nvim_create_user_command("PreviewOil", function()
			oil.open_preview({}, nil)
		end, {})
		vim.api.nvim_create_user_command("CloseOil", function()
			oil.close({})
		end, {})
		vim.api.nvim_create_user_command("SaveOil", function()
			oil.save({}, nil)
		end, {})
		vim.api.nvim_create_user_command("DiscardOil", function()
			oil.discard_all_changes()
		end, {})

		oil.setup({
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
