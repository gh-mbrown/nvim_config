vim.pack.add({
    GIT_ROOT .. "jiaoshijie/undotree"
})

local ut = require("undotree")
ut.setup({})
vim.keymap.set("n", "<leader>ut", ut.toggle)
