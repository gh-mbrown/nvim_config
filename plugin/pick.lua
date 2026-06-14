require("utils.string")

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
        }
    }
})

vim.ui.select = function(items, opts, func, l_opts)
    return pick.ui_select(items, opts, func, l_opts)
end

local function cli_pick(opts)
    local command = opts.command or nil
    local post_process = opts.post_process or nil
    local name = opts.name or nil
    local choose = opts.choose or nil
    local choose_marked = opts.choose_marked or nil

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

-- Picker keys
vim.keymap.set("n", "<leader>pf", function() pick.builtin.files({ tool = "git" }) end)
vim.keymap.set("n", "<leader>pg", function()
    pick.builtin.grep_live()
end)
vim.keymap.set("n", "<leader>ph", function()
    pick.builtin.help()
end)
vim.keymap.set("n", "<leader>pb", function()
    pick.builtin.buffers({
        include_current = false,
    })
end)

-- Git Keys
vim.keymap.set("n", "<leader>gb", function()
    cli_pick({
        command = { "git", "branch", "--all", "--format", "%(refname:short)" },
        post_process = function(list)
            local result = {}
            for _, l in pairs(list) do
                if not string.starts(l, "origin") then
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
