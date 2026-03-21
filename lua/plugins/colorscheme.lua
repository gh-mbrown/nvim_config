return {
	"morhetz/gruvbox",
	config = function()
		vim.g.gruvbox_transparent_bg = 1
		vim.cmd.colorscheme("gruvbox")
		vim.api.nvim_set_hl(0, "Normal", {
			bg = "none",
		})
		vim.api.nvim_set_hl(0, "NormalFloat", {
			bg = "none",
		})
		vim.api.nvim_set_hl(0, "SignColumn", {
			bg = "none",
		})
		vim.api.nvim_set_hl(0, "StatusLine", {
			bg = "#000000",
		})
		vim.api.nvim_set_hl(0, "StatusLineNC", {
			bg = "none",
		})
	end,
}
