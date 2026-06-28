vim.pack.add({
    GIT_ROOT .. "catppuccin/nvim"
})
local cat = require("catppuccin")
cat.setup({
    transparent_background = vim.fn.has("win32") == 1 and false or true,
    auto_integrations = true,
})
vim.cmd.Catppuccin("mocha")
