require("catppuccin").setup({
    transparent_background = true,
    float = {
        transparent = false,
        soldi = true,
    },
    term_colors = true,
    custom_highlights = function(colors)
        return {
            CursorLine = { bg = "none" },
        }
    end,
})
vim.cmd.colorscheme("catppuccin")
