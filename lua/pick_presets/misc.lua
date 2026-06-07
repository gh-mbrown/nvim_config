local function get_lsp_items(item)
    local params = vim.lsp.util.make_position_params(0, "utf-8")
    params.context = {
        includeDeclaration = true
    }

    local results = vim.lsp.buf_request_sync(0, "textDocument/" .. item, params, 3000)
    if not results then return end

    local items = {}
    for _, response in ipairs(results) do
        local result = response.result
        if result then
            if result.uri then
                result = { result }
            end
            for _, ref in ipairs(result) do
                local file_path = vim.uri_to_fname(ref.uri or ref.targetUri)
                local range = ref.range or ref.targetSelectionRange
                local line = range.start.line + 1
                local col = range.start.character + 1
                local ok, lines = pcall(vim.fn.readfile, file_path)
                local line_text = ok and lines[line] and lines[line]:gsub("^%s+", "") or ""

                table.insert(items, {
                    text = string.format("%s:%d:%d  %s", vim.fn.fnamemodify(file_path, ":~:."), line, col, line_text),
                    path = file_path,
                    lnum = line,
                    col = col
                })
            end
        end
    end
    return items
end

return {
    dirs = {
        items = function()
            local dirs = {}
            local function get_dirs(path)
                local content = vim.split(vim.fn.glob(path .. "/*"), "\n", { trimempty = true })
                for _, d in pairs(content) do
                    if vim.fn.isdirectory(d) == 1 then
                        table.insert(dirs, d)
                        get_dirs(d)
                    end
                end
            end
            get_dirs(".")
            return dirs
        end,
        name = "Directories",
        choose_marked = function(choice)
            if not choice then return end
            vim.cmd.edit(choice)
        end
    },
    reference = {
        items = function()
            local items = get_lsp_items("references") or {}

            if #items == 0 then
                vim.notify("No references found")
                return
            end

            if #items == 1 then
                vim.cmd.edit(items[1].path)
                vim.api.nvim_win_set_cursor(0, { items[1].lnum, items[1].col - 1 })
                return
            end

            return items
        end,
        name = "LSP References",
        choose_marked = function(choice)
            vim.cmd.edit(choice.path)
            vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
        end
    },
    definition = {
        items = function()
            local items = get_lsp_items("definition") or {}

            if #items == 0 then
                vim.notify("No definition found")
                return
            end

            if #items == 1 then
                vim.cmd.edit(items[1].path)
                vim.api.nvim_win_set_cursor(0, { items[1].lnum, items[1].col - 1 })
                return
            end
            return items
        end,
        name = "LSP Definitions",
        choose_marked = function(choice)
            vim.cmd.edit(choice.path)
            vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
        end
    },
    implementation = {
        items = function()
            local items = get_lsp_items("implementation") or {}

            if #items == 0 then
                vim.notify("No implementation found")
            end

            if #items == 1 then
                vim.cmd.edit(items[1].path)
                vim.api.nvim_win_set_cursor(0, { items[1].lnum, items[1].col - 1 })
                return
            end
            return items
        end,
        name = "LSP Implementations",
        choose_marked = function(choice)
            vim.cmd.edit(choice.path)
            vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
        end
    }
}
