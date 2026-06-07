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
    vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
end

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
    treesitter = {
        buffer_var_query = {
            items = function()
                return execute_treesitter_query({ query = "var" })
            end,
            name = "Treesitter Vars",
            choose_marked = apply_choice_buffer
        },
        buffer_func_query = {
            items = function()
                return execute_treesitter_query({ query = "func" })
            end,
            name = "Treesitter Funcs",
            choose_marked = apply_choice_buffer
        },
        buffer_field_query = {
            items = function()
                return execute_treesitter_query({ query = "field" })
            end,
            name = "Treesitter Fields",
            choose_marked = apply_choice_buffer
        }
    },
    git = {
        restore = {
            command = { "git", "status", "--short" },
            postprocess = function(list)
                local result = {}
                for _, l in pairs(list) do
                    local v = string.sub(l, 4, string.len(l))
                    if vim.list_contains(result, v) then
                    else
                        table.insert(result, v)
                    end
                end
                return result
            end,
            name = "Git Restore",
            choose = function(selection)
                vim.cmd.Git("restore " .. selection)
            end,
        },
        stash = {
            command = { "git", "status", "--short" },
            postprocess = function(list)
                local result = {}
                for _, l in pairs(list) do
                    table.insert(result, string.sub(l, 4, string.len(l)))
                end
                return result
            end,
            name = "Git Stash",
            choose = function(selection)
                vim.cmd.Git("stash " .. selection)
            end
        },
        stash_pop = {
            command = { "git", "stash", "list" },
            name = "Git Stash List",
            choose = function(selection)
                local stash_name = string.match(selection, "%a+")
                vim.print(stash_name)
                vim.cmd.Git("stash pop " .. stash_name)
            end
        },
        update_submodules = {
            command = { "git", "config", "--file", ".gitmodules", "--get-regexp", "path" },
            postprocess = function(list)
                local results = {}
                for _, l in pairs(list) do
                    local r = string.match(l, "%S+$")
                    table.insert(results, r)
                end
                return results
            end,
            name = "Git Submodules",
            choose = function(selection)
                vim.print(selection)
                vim.cmd.Git("submodule update --remote " .. selection)
            end
        },
        branches = {
            command = { "git", "branch", "--all", "--format", "%(refname:short)" },
            postprocess = function(list)
                local result = {}
                for _, l in pairs(list) do
                    if l ~= "origin" then
                        local r, _ = string.gsub(l, "origin/", "", 1)
                        vim.print(r)
                        table.insert(result, r)
                    end
                end
                return result
            end,
            name = "Git Branches",
            choose = function(selection)
                vim.cmd.Git("checkout " .. selection)
            end
        },
        rebase = {
            command = { "git", "branch", "--all", "--format", "%(refname:short)" },
            postprocess = function(list)
                local result = {}
                for _, l in pairs(list) do
                    if l ~= "origin" then
                        local r, _ = string.gsub(l, "origin/", "", 1)
                        vim.print(r)
                        table.insert(result, r)
                    end
                end
                return result
            end,
            name = "Git Rebase",
            choose = function(selection)
                vim.cmd.Git("rebase " .. selection)
            end
        },
        add = {
            command = { "git", "status", "--short" },
            post_process = function(list)
                local result = {}
                for _, l in pairs(list) do
                    table.insert(result, string.sub(l, 4, string.len(l)))
                end
                return result
            end,
            name = "Git Add",
            choose = function(selection)
                vim.cmd.Git("add " .. selection)
            end
        },
        unstage = {
            command = { "git", "diff", "--cached", "--name-only" },
            name = "Git Unstage",
            choose = function(selection)
                vim.cmd.Git("restore --staged " .. selection)
            end
        },
    },
    misc = {
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
    },
    misc_cli = {
        tldr = {
            command = { "tldr", "--list" },
            name = "tldr",
            choose = function(selection)
                vim.cmd.ReadCmd('tldr "' .. selection .. '"')
            end
        }
    }
}
