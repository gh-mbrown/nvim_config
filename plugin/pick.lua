local str = require("utils.string")

vim.pack.add({
    GIT_ROOT .. "nvim-mini/mini.pick"
})

local pick = require("mini.pick")
pick.setup({
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

local apply_marked_ts = function(choice)
    if not choice then return end
    vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
end

local function get_treesitter_query()
    local bufnr = vim.api.nvim_get_current_buf()
    local lang = vim.bo[bufnr].filetype
    local parser = vim.treesitter.get_parser(bufnr, lang)
    local tree = parser:parse()[1]
    return vim.treesitter.query.get(lang, "highlights"), tree:root(), bufnr
end

local function get_treesitter_list(opts)
    local pick_name = opts.pick_name or "Treesitter"
    local query_type = opts.query_type or "function"

    local query, root, bufnr = get_treesitter_query()
    local items = {}
    for id, node in query:iter_captures(root, bufnr) do
        local capture_name = query.captures[id]
        if capture_name == query_type then
            local row, col = node:start()
            table.insert(items, {
                text = vim.treesitter.get_node_text(node, bufnr),
                path = vim.api.nvim_buf_get_name(bufnr),
                lnum = row + 1,
                col = col + 1,
            })
        end
    end

    start_pick({
        items = items,
        name = pick_name,
        choose_marked = apply_marked_ts,
    })
end

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
            vim.api.nvim_open_win(bufnr, true, { split = "below", win = 0 })
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
vim.keymap.set("n", "<leader>gmu", function()
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
    get_treesitter_list({
        pick_name = "Variables",
        query_type = "variable.local"
    })
end)
vim.keymap.set("n", "<leader>tf", function()
    get_treesitter_list({
        pick_name = "Functions",
        query_type = "function"
    })
end)
