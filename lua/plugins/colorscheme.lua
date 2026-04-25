return {
	"ayu-theme/ayu-vim",
	config = function()
		vim.g.ayucolor = "dark"
		vim.cmd.colorscheme("ayu")

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#f29718" })
		vim.api.nvim_set_hl(0, "HopNextKey", { cterm = { bold = true }, ctermfg = 198, bold = true, fg = "#ff7733" })
	end,
}
