return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function()
		local hop = require("hop")
		local hint = require("hop.hint")

		vim.api.nvim_create_user_command("HopWordEnd", function()
			hop.hint_words({
				hint_position = hint.HintPosition.END,
			})
		end, {})

		hop.setup({})
	end,
}
