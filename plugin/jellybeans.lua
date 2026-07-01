vim.pack.add({
    GIT_ROOT .. "nanotech/jellybeans.vim"
})

local overrides = {
    CursorLine = {
        guibg = "none"
    },
    SignColumn = {
        guibg = "none"
    },
}

if not vim.g.neovide then overrides["background"] = { guibg = "none" } end
vim.g.jellybeans_overrides = overrides

vim.cmd.colorscheme("jellybeans")
vim.api.nvim_set_hl(0, "TelescopeNormal", {
    bg = "#151515",
})
