local pick = require("mini.pick")
local ts_queries = require("core.treesitter_queries")

local M = {}
M.__index = M

M.git_restore = function()
    pick.builtin.cli({
            command = { "git", "status", "--short" },
            postprocess = function(list)
                local result = {}
                for _, l in pairs(list) do
                    table.insert(result, string.sub(l, 4, string.len(l)))
                end
                return result
            end
        },
        {
            source = {
                name = "Git Restore",
                choose = function(selection)
                    vim.cmd.Git("restore " .. selection)
                end
            }
        })
end

M.git_stash = function()
    pick.builtin.cli({
            command = { "git", "status", "--short" },
            postprocess = function(list)
                local result = {}
                for _, l in pairs(list) do
                    table.insert(result, string.sub(l, 4, string.len(l)))
                end
                return result
            end
        },
        {
            source = {
                name = "Git Stash",
                choose = function(selection)
                    vim.cmd.Git("stash " .. selection)
                end
            }
        })
end

M.git_stash_list = function()
    pick.builtin.cli({
            command = { "git", "stash", "list" },
        },
        {
            source = {
                name = "Git Stash List",
                choose = function(selection)
                    local stash_name = string.match(selection, "%a+")
                    vim.print(stash_name)
                    vim.cmd.Git("stash pop " .. stash_name)
                end
            }
        })
end

M.git_update_submodules = function()
    pick.builtin.cli({
            command = { "git", "config", "--file", ".gitmodules", "--get-regexp", "path" },
            postprocess = function(list)
                local results = {}
                for _, l in pairs(list) do
                    local r = string.match(l, "%S+$")
                    table.insert(results, r)
                end
                return results
            end
        },
        {
            source = {
                name = "Git Submodules",
                choose = function(selection)
                    vim.print(selection)
                    vim.cmd.Git("submodule update --remote " .. selection)
                end
            }
        })
end

M.git_branches = function()
    pick.builtin.cli({
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
            end
        },
        {
            source = {
                name = "Git Branches",
                choose = function(selection)
                    vim.cmd.Git("checkout " .. selection)
                end
            }
        })
end

M.git_rebase = function()
    pick.builtin.cli({
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
            end
        },
        {
            source = {
                name = "Git Rebase",
                choose = function(selection)
                    vim.cmd.Git("rebase " .. selection)
                end
            }
        })
end

M.git_add = function()
    pick.builtin.cli({
            command = { "git", "status", "--short" },
            postprocess = function(list)
                local result = {}
                for _, l in pairs(list) do
                    table.insert(result, string.sub(l, 4, string.len(l)))
                end
                return result
            end
        },
        {
            source = {
                name = "Git Add",
                choose = function(selection)
                    vim.cmd.Git("add " .. selection)
                end
            }
        })
end

M.git_unstage = function()
    pick.builtin.cli({
            command = { "git", "diff", "--cached", "--name-only" },
        },
        {
            source = {
                name = "Git Unstage",
                choose = function(selection)
                    vim.cmd.Git("restore --staged " .. selection)
                end
            }
        })
end

M.git_files = function()
    pick.builtin.files({ tool = "git" })
end

M.search_tldr = function()
    pick.builtin.cli({
            command = { "tldr", "--list" }
        },
        {
            source = {
                name = "tldr",
                choose = function(selection)
                    require("core.functions").read_cmd('tldr "' .. selection .. '"')
                end
            }

        })
end

M.spell_suggest = function()
    local word = vim.fn.expand("<cword>")
    local sug = vim.fn.spellsuggest(word)
    vim.ui.select(sug, {}, "Spell Suggestions", function(choice)
        if choice then
            vim.api.nvim_command("normal! ciw" .. choice)
        else
            return
        end
    end)
end

M.treesitter_search = function ()
    local bufnr = vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(bufnr)
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    local parser = vim.treesitter.get_parser(bufnr, lang)
    local tree = parser:parse()[1]
    local root = tree:root()

    local query = ts_queries[vim.bo.filetype]

    local items = {}
    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        if query.captures[id] == "name" then
            local row, col = node:start()
            local name = vim.treesitter.get_node_text(node, bufnr)
            table.insert(items, {
                text = string.format("%s %s line %d", "var", name, row + 1),
                path = path,
                lnum = row + 1,
                col = col + 1
            })
        end
    end

    pick.start({
        source = {
            items = items,
            name = "tree",
            choose_marked = function (choice)
                vim.api.nvim_win_set_cursor(0, {choice.lnum, choice.col - 1})
            end
        }
    })
end

return M
