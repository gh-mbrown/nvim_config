vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.cshtml", "*.razor" },
	callback = function()
		vim.bo.filetype = "html.cshtml.razor"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- Disables inlay hints
vim.api.nvim_create_autocmd({ "BufWritePost", "LspAttach", "BufEnter" }, {
	callback = function(args)
		local bufnr = args.buf or 0
		vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Start and exit tmux on vim enter and leave
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.fn.system("tmux split-window -h -p 30 -c '#{pane_current_path}'")
		vim.fn.system("tmux select-pane -t 1")
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.fn.system("tmux kill-pane -a")
	end,
})
