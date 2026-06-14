vim.pack.add({
    Git_root .. "nvim-mini/mini.pick"
})

local height = math.floor(0.45 * vim.o.lines)
local width = math.floor(1 * vim.o.columns)

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
            height = height,
            width = width,
            row = math.floor(1 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width))
        }
    }
})

vim.keymap.set("n", "<leader>pf", function() pick.builtin.files({ tool = "git" }) end)
vim.keymap.set("n", "<leader>pg", function ()
    pick.builtin.grep_live()
end)
vim.keymap.set("n", "<leader>ph", function ()
    pick.builtin.help()
end)
vim.keymap.set("n", "<leader>pb", function ()
    pick.builtin.buffers({
        include_current = false,
    })
end)
