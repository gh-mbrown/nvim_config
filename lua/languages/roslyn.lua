vim.lsp.config("roslyn_ls", {
	filetypes = {
		"cs",
		"cshtml",
		"razor",
	},
	root_markers = {
		"*.sln",
		"*.csproj",
		".git",
	},
	cmd = {
		vim.fn.expand("~/.local/share/nvim/mason/bin/roslyn"),
		"--stdio",
		"--logLevel=Information",
		"--extensionLogDirectory=" .. vim.fn.expand("~/.cache/nvim/roslyn-logs"),
	},
	handlers = {
		["window/showMessage"] = function(err, result, ctx, config)
			if result and result.message and result.message:find("same key") then
				return
			end
			vim.lsp.handlers["window/showMessage"](err, result, ctx, config)
		end,
	},
})
vim.lsp.enable("roslyn_ls")
