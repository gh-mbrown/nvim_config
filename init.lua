vim.g.mapleader = " "
if vim.g.vscode then
	require("vsc")
else
	require("config")
	require("core")
	require("languages")
end
