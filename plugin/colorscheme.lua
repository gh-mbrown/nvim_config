vim.pack.add({
    Git_root .. "folke/tokyonight.nvim",
})

require("tokyonight").setup({
    style = "night",
    transparent = true,
    on_highlights = function (hl, c)
        hl.CursorLine = {
            bg = "none"
        }
        hl.MiniPickMatchCurrent = {
            bg = "#292e42"
        }
        hl.MiniPickPreviewLine = {
            bg = "#292e42"
        }
    end,
})
vim.cmd.colorscheme("tokyonight")
