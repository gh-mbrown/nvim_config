local pick = require("mini.pick")

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
            choose = function (selection)
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
            choose = function (selection)
                vim.cmd.Git("stash " .. selection)
            end
        }
    })
end

M.git_stash_list = function ()
    pick.builtin.cli({
        command = {"git", "stash", "list"},
    },
    {
        source = {
            name = "Git Stash List",
            choose = function (selection)
                local stash_name = string.match(selection, "%a+")
                vim.print(stash_name)
                vim.cmd.Git("stash pop " .. stash_name)
            end
        }
    })
end

M.git_update_submodules = function()
    pick.builtin.cli({
        command = {"git", "config", "--file", ".gitmodules", "--get-regexp", "path"},
        postprocess = function (list)
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
            choose = function (selection)
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

return M
