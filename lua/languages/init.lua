local lsp_utils = require("core.lsp")
vim.lsp.config("*", {
	capabilities = lsp_utils.capabilities(),
})
require("languages.bash")
require("languages.html")
require("languages.ocaml")
require("languages.roslyn")