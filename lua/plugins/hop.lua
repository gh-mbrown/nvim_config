return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function()
		local hop = require("hop")
		local hint = require("hop.hint")

		local function hop_word_end()
			hop.hint_words({
				hint_position = hint.HintPosition.END,
			})
		end

		vim.api.nvim_create_user_command("HopWordEnd", hop_word_end, {})

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
		vim.keymap.set("n", "<leader>ee", function()
			vim.cmd.HopWordEnd()
		end)

		hop.setup({})
	end,
}
