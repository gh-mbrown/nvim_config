require("lazy_load").on_vim_enter(function ()
    if vim.fn.has("linux") == 1 then
        vim.pack.add({
            GIT_ROOT .. "christoomey/vim-tmux-navigator"
        })
    end
end)
