require("lazy_load").on_vim_enter(function ()
    vim.pack.add({
        GIT_ROOT .. "windwp/nvim-autopairs"
    })

    require("nvim-autopairs").setup({})
end)
