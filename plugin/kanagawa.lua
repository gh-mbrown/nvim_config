vim.pack.add({
    Git_root .. "rebelot/kanagawa.nvim"
})
require("kanagawa").setup({
    compile = true,
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
            MiniPickMatchCurrent = { bg = "#ffffff" }
        }
    end
})
vim.opt.background = "dark"
vim.keymap.set("n", "<leader>kc", function()
    vim.cmd("KanagawaCompile")
end)
vim.cmd.colorscheme("kanagawa-wave")
