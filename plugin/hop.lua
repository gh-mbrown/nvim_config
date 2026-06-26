vim.pack.add({
    GIT_ROOT .. "smoka7/hop.nvim"
})
require("hop").setup({})
vim.keymap.set("n", "<leader>hw", vim.cmd.HopWord)
vim.keymap.set("n", "<leader>hp", vim.cmd.HopPattern)
