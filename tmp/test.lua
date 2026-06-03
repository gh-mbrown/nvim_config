local bufnr = vim.api.nvim_get_current_buf()
local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
local parser = vim.treesitter.get_parser(bufnr, lang)
local tree = parser:parse()[1]
local root = tree:root()
local function inspectTS(node, indent)
    local type = node:type()
    local name = vim.treesitter.get_node_text(node, bufnr)
    vim.print(indent .. type .. ": " .. name)
    -- if type == "function_declaration" or type == "variable_declaration" then
    -- end
    for child in node:iter_children() do
        inspectTS(child, indent .. " ")
    end
end
inspectTS(root, "")
