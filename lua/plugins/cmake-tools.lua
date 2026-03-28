return {
	"Civitasv/cmake-tools.nvim",
	lazy = true,
	init = function()
		require("cmake-tools").setup({})
	end,
	opts = {},
}
