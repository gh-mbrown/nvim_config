vim.pack.add({
    GIT_ROOT .. "catppuccin/nvim"
})
local cat = require("catppuccin")
cat.setup({
    transparent_background = not vim.g.neovide,
    auto_integrations = true,
    custom_highlights = function (colors)
        return {
            CursorLine = { bg = "none" }
        }
    end,
})
vim.cmd.Catppuccin("mocha")
