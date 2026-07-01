vim.pack.add({
    GIT_ROOT .. "nanotech/jellybeans.vim"
})

vim.g.jellybeans_overrides = not vim.g.neovide and {
    background = {
        guibg = "none"
    },
    CursorLine = {
        guibg = "none"
    },
    SignColumn = {
        guibg = "none"
    },
} or {
    CursorLine = {
        guibg = "none"
    },
    SignColumn = {
        guibg = "none"
    },
}

vim.cmd.colorscheme("jellybeans")
