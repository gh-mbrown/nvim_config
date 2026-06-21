vim.pack.add({
    Git_root .. "rebelot/kanagawa.nvim"
})
require("kanagawa").setup({
    transparent = true,
    colors = {
        theme = {
            wave = {
                ui = {
                    bg_gutter = "none"
                }
            }
        }
    },
    overrides = function(colors)
        local theme = colors.theme
        return {
            CursorLine = { bg = "none" },
            MiniPickMatchCurrent = { bg = "#363646" },
            MiniPickPreviewLine = { bg = "#363646" }
        }
    end
})
vim.opt.background = "dark"
vim.cmd.colorscheme("kanagawa-wave")
