vim.pack.add({
    GIT_ROOT .. "catppuccin/nvim"
})
require("catppuccin").setup({
    transparent_background = vim.fn.has("win32") == 1 and false or true,
    auto_integrations = true,
    custom_highlights = function(colors)
        return {
            CursorLine = { bg = "none" },
            MiniPickPreviewLine = { bg = "#2a2b3c" },
            MiniPickMatchCurrent = { bg = "#2a2b3c" },
        }
    end
})
vim.cmd.Catppuccin("mocha")
