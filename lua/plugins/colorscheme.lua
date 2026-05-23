return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.grubbox_material_enable_italic = true
		vim.g.gruvbox_material_background = "soft"
		vim.g.gruvbox_material_better_performance = 1
		vim.g.gruvbox_material_transparent_background = 1
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
