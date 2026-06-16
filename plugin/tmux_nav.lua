if vim.fn.has("win32") == 0 then
    vim.pack.add({
        Git_root .. "christoomey/vim-tmux-navigator"
    })
end
