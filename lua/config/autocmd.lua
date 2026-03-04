-- Set Razor files as html
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.cshtml", "*.razor" },
	callback = function()
		vim.bo.filetype = "html.cshtml.razor"
	end,
})

-- Start Treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Disable inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
	end,
})
