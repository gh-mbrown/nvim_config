return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		vim.api.nvim_create_user_command("HarpoonToggle", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, {})
		vim.api.nvim_create_user_command("HarpoonAdd", function()
			harpoon:list():add()
		end, {})
		vim.api.nvim_create_user_command("SelectOne", function()
			harpoon:list():select(1)
		end, {})
		vim.api.nvim_create_user_command("SelectTwo", function()
			harpoon:list():select(2)
		end, {})
		vim.api.nvim_create_user_command("SelectThree", function()
			harpoon:list():select(3)
		end, {})
		vim.api.nvim_create_user_command("SelectFour", function()
			harpoon:list():select(4)
		end, {})
		vim.api.nvim_create_user_command("SelectFive", function()
			harpoon:list():select(5)
		end, {})
		vim.api.nvim_create_user_command("SelectSix", function()
			harpoon:list():select(6)
		end, {})
		vim.api.nvim_create_user_command("SelectSeven", function()
			harpoon:list():select(7)
		end, {})
		vim.api.nvim_create_user_command("SelectEight", function()
			harpoon:list():select(8)
		end, {})
		vim.api.nvim_create_user_command("SelectNine", function()
			harpoon:list():select(9)
		end, {})
	end,
}
