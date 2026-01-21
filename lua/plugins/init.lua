local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(path) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		repo,
		path,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{
				"Failed to clone lazy.nvim:\n",
				"ErrorMsg",
			},
			{
				out,
				"WarningMsg",
			},
			{
				"\nPress any key to exit...",
			},
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(path)

local plugins = {}

local cwDir = vim.fn.stdpath("config")
local files = vim.split(vim.fn.glob(cwDir .. "/lua/plugins/*"), "\n", { trimempty = true })

for _, f in pairs(files) do
	local file = vim.fn.fnamemodify(f, ":t")
	local plugin = vim.fn.fnamemodify(file, ":r")

	if plugin == "init" then
		goto continue
	end

	vim.list_extend(plugins, { require("plugins." .. plugin) })

	::continue::
end

require("lazy").setup({
	spec = plugins,
	checker = {
		enabled = true,
	},
	ui = {
		border = "single",
	},
})
