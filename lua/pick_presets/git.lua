return {
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
}
