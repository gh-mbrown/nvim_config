local pick = require("mini.pick")

local M = {}
M.__index = M

local function create_picker(name, list, func)
    pick.start({
        source = {
            items = list,
            name = name,
            choose = func
        }
    })
end

local function get_diff_files(staged)
    return vim.fn.systemlist("git diff --name-only " .. (staged and "--staged" or "") .. "| awk '{ print $1 }'")
end

M.restore_file = function()
    local list = get_diff_files(false)
    create_picker("Restore File", list, function(selection)
        vim.cmd.Git("restore " .. selection)
    end)
end

M.stash_changes = function()
    local list = get_diff_files(false)
    create_picker("Stash File", list, function(selection)
        local message = vim.fn.input("Stash Message: ")
        vim.cmd.Git("stash push --message '" .. message .. "' " .. selection)
    end)
end

M.update_submodules = function()
    local list = vim.fn.systemlist("git config --file .gitmodules --get-regexp path | awk '{ print $2 }'")
    create_picker("Update Submodule", list, function(sel)
        vim.cmd.Git("submodule update --remote " .. sel)
    end)
end

M.git_branches = function()
    pick.builtin.cli({
            command = { "git", "branch", "--all", "--format", "'%(refname:short)'" }
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
            command = { "git", "branch", "--all", "--format", "'%(refname:short)'" }
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
