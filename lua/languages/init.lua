local lsp_utils = require("core.lsp")

vim.lsp.config("*", { 
    capabilities = lsp_utils.capabilities(),
})

require("languages.roslyn")
require("languages.html")
require("languages.bash")
require("languages.ocaml")
