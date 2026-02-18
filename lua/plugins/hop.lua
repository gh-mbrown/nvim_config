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
		vim.keymap.set("n", "<leader>ef", function()
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

		-- changes the color of the characters when hopping
		vim.api.nvim_set_hl(0, "HopNextKey", {
			bg = "NONE",
			fg = "#ff007c",
			bold = true,
		})

		vim.api.nvim_set_hl(0, "HopNextKey1", {
			bg = "NONE",
			fg = "#00dfff",
			bold = true,
		})
		vim.api.nvim_set_hl(0, "HopNextKey2", {
			bg = "NONE",
			fg = "#2b8db3",
			bold = true,
		})

		vim.api.nvim_set_hl(0, "LineNr", {
			fg = "#ebbcba",
		})
		vim.api.nvim_set_hl(0, "LineNrBelow", {
			fg = "#6e6a86",
		})
		vim.api.nvim_set_hl(0, "LineNrAbove", {
			fg = "#6e6a86",
		})
	end,
}
