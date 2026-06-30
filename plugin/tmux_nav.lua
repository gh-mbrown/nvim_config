require("lazy_load").on_vim_enter(function ()
    if not vim.g.neovide then
        vim.pack.add({
            GIT_ROOT .. "christoomey/vim-tmux-navigator"
        })
    end
end)
