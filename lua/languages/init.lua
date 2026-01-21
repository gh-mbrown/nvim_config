local lsp_utils = require("core.lsp")

vim.lsp.config("*", { 
    capabilities = lsp_utils.capabilities(),
})

local cwDir = vim.fn.stdpath("config")
local files = vim.split(vim.fn.glob(cwDir .. "/lua/languages/*"), '\n', {trimempty=true})

for _, f in pairs(files) do
    local file = vim.fn.fnamemodify(f, ":t")
    local language = vim.fn.fnamemodify(file, ":r")

    if language == "init" then
        goto continue
    end

    require("languages."..language)

    ::continue::
end
