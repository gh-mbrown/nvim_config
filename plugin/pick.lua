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
        config = function()
            local height = math.floor(0.618 * vim.o.lines)
            local width = math.floor(0.618 * vim.o.columns)
            return {
                anchor = "NW",
                height = height,
                width = width,
                row = math.floor(0.5 * (vim.o.lines - height)),
                col = math.floor(0.5 * (vim.o.columns - width))
            }
        end
    }
})

vim.ui.select = function(items, opts, func, lopts)
    return pick.ui_select(items, opts, func, lopts)
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

local function get_treesitter_query(file)
    file = file or "highlights"
    local bufnr = vim.api.nvim_get_current_buf()
    local lang = vim.bo[bufnr].filetype
    local parser = vim.treesitter.get_parser(bufnr, lang)
    local tree = parser:parse()[1]
    return vim.treesitter.query.get(lang, file), tree:root(), bufnr
end

local function get_treesitter_list(opts)
    local pick_name = opts.pick_name or "Treesitter"
    local query_type = opts.query_type or "function"

    local query, root, bufnr = get_treesitter_query("highlights")
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

vim.keymap.set("n", "<leader>pf", function()
    pick.builtin.files({
        tool = "git"
    })
end)
vim.keymap.set("n", "<leader>pr", function()
    pick.builtin.files({
        tool = "rg"
    })
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
            require("utils.functions").list_to_buffer(vim.fn.systemlist({ "tldr", selection }))
        end
    })
end)

-- Git Keys
vim.keymap.set("n", "<leader>gb", function()
    cli_pick({
        command = { "git", "branch", "--all", "--format", "%(refname:short)" },
        post_process = function(list)
            return vim.iter(list)
                :filter(function(x)
                    return not str.starts_with(x, "origin")
                end)
                :totable()
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
            return vim.iter(list)
                :map(function(x)
                    return string.match(x, "%S+$")
                end)
                :totable()
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
