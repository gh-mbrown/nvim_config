return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function()
		local hop = require("hop")

		vim.keymap.set("n", "<leader>ew", function()
			vim.cmd.HopWord()
		end)
		vim.keymap.set("n", "<leader>ec", function()
			vim.cmd.HopCamelCase()
		end)
		vim.keymap.set("n", "<leader>ep", function()
			vim.cmd.HopPattern()
		end)
		vim.keymap.set("n", "<leader>e2", function()
			vim.cmd.HopChar2()
		end)
		vim.keymap.set("n", "<leader>ea", function()
			vim.cmd.HopAnywhere()
		end)

		hop.setup({})
	end,
}
