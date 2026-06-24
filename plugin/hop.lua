vim.pack.add({
    GIT_ROOT .. "smoka7/hop.nvim"
})

local hop = require("hop")
hop.setup({})

vim.keymap.set("n", "hw", vim.cmd.HopWord)
vim.keymap.set("n", "hp", vim.cmd.HopPattern)
