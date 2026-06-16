local str = require("utils.string")

vim.pack.add({
    Git_root .. "nvim-mini/mini.pick"
})

local pick = require("mini.pick")
pick.setup({
    source = {
        show = pick.default_show
    },
    mappings = {
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
        delete_left = "<C-f>"
    },
    window = {
        config = {
            anchor = "NW",
            height = math.floor(vim.o.lines * 0.45),
            width = vim.o.columns,
        },
    }
})

vim.ui.select = function(items, opts, func, l_opts)
    return pick.ui_select(items, opts, func, l_opts)
end

---@class CliPickOptions
---@field command table
---@field post_process? function
---@field name? string
---@field choose? function
---@field choose_marked? function

---@param opts CliPickOptions
---@return nil
local function cli_pick(opts)
    local command = opts.command
    local post_process = opts.post_process
    local name = opts.name or "CLI Pick"
    local choose = opts.choose
    local choose_marked = opts.choose_marked

    pick.builtin.cli({
        command = command,
        postprocess = post_process
    }, {
        source = {
            name = name,
            choose = choose,
            choose_marked = choose_marked,
        }
    })
end

---@class StartPickOptions<T>
---@field items? T[]
---@field name? string
---@field choose? fun(choice: T): nil
---@field choose_marked? fun(choice: T): nil

---@generic T
---@param opts StartPickOptions<T>
---@return nil
local function start_pick(opts)
    if not opts.items then return end
    local items = opts.items

    local name = opts.name or "Pick"
    local choose = opts.choose
    local choose_marked = opts.choose_marked

    pick.start({
        source = {
            items = items,
            name = name,
            choose = choose,
            choose_marked = choose_marked,
        }
    })
end

---@param choice PickBuffer
---@return nil
local apply_marked_ts = function(choice)
    if not choice then return end
    vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
end


-- Picker keys
vim.keymap.set("n", "<leader>pf", function()
    pick.builtin.files({ tool = "git" })
end)
vim.keymap.set("n", "<leader>pr", function()
    pick.builtin.files({ tool = "rg" })
end)
vim.keymap.set("n", "<leader>pg", pick.builtin.grep_live)
vim.keymap.set("n", "<leader>ph", pick.builtin.help)
vim.keymap.set("n", "<leader>pb", function()
    pick.builtin.buffers({
        include_current = false,
    })
end)
vim.keymap.set("n", "<leader>pt", function()
    cli_pick({
        command = { "tldr", "--list" },
        name = "TLDR",
        choose = function(selection)
            local page = vim.fn.systemlist({ "tldr", selection })
            local bufnr = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, page)
            vim.bo[bufnr].buftype = "nofile"
            vim.bo[bufnr].bufhidden = "wipe"
            vim.bo[bufnr].modifiable = false
            vim.bo[bufnr].readonly = true

            vim.api.nvim_open_win(bufnr, true, { split = "below" })
        end
    })
end)

-- Git Keys
vim.keymap.set("n", "<leader>gb", function()
    cli_pick({
        command = { "git", "branch", "--all", "--format", "%(refname:short)" },
        post_process = function(list)
            local result = {}
            for _, l in pairs(list) do
                if not str.starts_with(l, "origin") then
                    table.insert(result, l)
                end
            end

            return result
        end,
        name = "Git Branches",
        choose = function(selection)
            vim.cmd.Git("checkout " .. selection)
        end
    })
end)
vim.keymap.set("n", "<leader>gsp", function()
    cli_pick({
        command = { "git", "stash", "list" },
        name = "Git Stash Pop",
        choose = function(selection)
            local stash_name = string.match(selection, "%a+")
            vim.cmd.Git("stash pop " .. stash_name)
        end
    })
end)
vim.keymap.set("n", "<leader>gsm", function()
    cli_pick({
        command = { "git", "config", "--file", ".gitmodules", "--get-regexp", "path" },
        post_process = function(list)
            local results = {}
            for _, l in pairs(list) do
                local r = string.match(l, "%S+$")
                table.insert(results, r)
            end
            return results
        end,
        name = "Git Submodules",
        choose = function(selection)
            vim.cmd.Git("submodule update --remote " .. selection)
        end
    })
end)

-- Treesitter Keys
vim.keymap.set("n", "<leader>tv", function()
    start_pick({
        items = Execute_ts_query({
            query_type = "var"
        }),
        name = "TS Var",
        choose_marked = apply_marked_ts
    })
end)
vim.keymap.set("n", "<leader>tf", function()
    start_pick({
        items = Execute_ts_query({
            query_type = "func"
        }),
        name = "TS Var",
        choose_marked = apply_marked_ts
    })
end)
vim.keymap.set("n", "<leader>tF", function()
    start_pick({
        items = Execute_ts_query({
            query_type = "field"
        }),
        name = "TS Var",
        choose_marked = apply_marked_ts
    })
end)
