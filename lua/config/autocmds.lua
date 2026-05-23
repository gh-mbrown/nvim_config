-- Set Razor files as html
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.cshtml", "*.razor" },
	callback = function()
		vim.bo.filetype = "html.cshtml.razor"
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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		if vim.bo[args.buf].buftype == "" then
			pcall(vim.treesitter.start)
		end
	end,
})
