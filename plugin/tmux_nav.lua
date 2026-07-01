require("lazy_load").on_vim_enter(not vim.g.neovide and function()
    if not vim.g.neovide then
        vim.pack.add({
            GIT_ROOT .. "christoomey/vim-tmux-navigator"
        })
    end
end or function()
    vim.notify("Not in the terminal skip loading vim-tmux-navigator")
end)
