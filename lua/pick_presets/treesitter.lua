local function execute_treesitter_query(opts)
    if not opts.query then
        vim.notify(" Must specify query", vim.log.levels.ERROR)
        return nil
    end
    local query_type = opts.query

    local bufnr = vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(bufnr)
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if not lang then
        vim.notify("No Treesitter lang for filetype: " .. (vim.bo.filetype or "unknown"), vim.log.levels.ERROR)
        return nil
    end
    local parser = vim.treesitter.get_parser(bufnr, lang)
    if not parser then
        vim.notify("No treesitter parser found for: " .. (lang or "unknown"), vim.log.levels.ERROR)
        return nil
    end
    local tree = parser:parse()[1]
    local root = tree:root()

    local query = vim.treesitter.query.get(lang, query_type)
    if not query then
       vim.notify("No treesitter query '" .. query_type .. "' for " .. lang, vim.log.levels.ERROR)
       return nil
    end

    local items = {}
    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        local cap = query.captures[id]
        if cap then
            local row, col = node:start()
            local result = vim.treesitter.get_node_text(node, bufnr)
            table.insert(items, {
                text = string.format("%s", result),
                path = path,
                lnum = row + 1,
                col = col + 1
            })
        end
    end

    if #items == 0 then
        vim.notify("No " .. query_type .. " found")
    end
    return items
end

local function apply_choice_buffer(choice)
    if not choice then return end
    vim.api.nvim_win_set_cursor(0, {choice.lnum, choice.col - 1})
end

return {
    buffer_var_query = {
        items = function()
            return execute_treesitter_query({ query = "var" })
        end,
        name = "Treesitter Vars",
        choose_marked = apply_choice_buffer
    },
    buffer_func_query = {
        items = function ()
            return execute_treesitter_query({query = "func"})
        end,
        name = "Treesitter Funcs",
        choose_marked = apply_choice_buffer
    },
    buffer_field_query = {
        items = function ()
            return execute_treesitter_query({query = "field"})
        end,
        name = "Treesitter Fields",
        choose_marked = apply_choice_buffer
    }
}
