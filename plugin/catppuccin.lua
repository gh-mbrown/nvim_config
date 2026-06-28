vim.pack.add({
    GIT_ROOT .. "catppuccin/nvim"
})
local cat = require("catppuccin")
cat.setup({
    transparent_background = vim.g.neovide and false or true,
    auto_integrations = true,
})
vim.cmd.Catppuccin("mocha")
