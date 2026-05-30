return {
    "nanotech/jellybeans.vim",
    config = function ()
        vim.g.jellybeans_overrides = {
            background = {
                guibg = "none"
            },
            CursorLine = {
                guibg = "none"
            },
            SignColumn = {
                guibg = "none"
            }
        }
        vim.cmd.colorscheme("jellybeans")
    end
}
