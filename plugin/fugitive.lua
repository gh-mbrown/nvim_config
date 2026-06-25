vim.pack.add({
    GIT_ROOT .. "tpope/vim-fugitive"
})
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.winbar = "%<%f %h%m%r%{FugitiveStatusline()}"

vim.keymap.set("n", "<leader>gC", function()
    local branch = vim.fn.input("Branch name: ")
    if branch ~= "" then
        vim.cmd.Git("checkout -b " .. branch)
        vim.cmd.Git("push -u origin " .. branch)
    end
end)
vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
vim.keymap.set("n", "<leader>gD", vim.cmd.Gdiffsplit)
vim.keymap.set("n", "<leader>gA", function() vim.cmd.Git("add --all") end)
vim.keymap.set("n", "<leader>gc", function() vim.cmd.Git("commit") end)
vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git("push") end)
vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git("pull --rebase") end)
vim.keymap.set("n", "<leader>gB", function() vim.cmd.Git("blame") end)
vim.keymap.set("n", "<leader>gM", function() vim.cmd.Git("mergetool") end)
vim.keymap.set("n", "<leader>gd", function() vim.cmd.Git("diff") end)
vim.keymap.set("n", "<leader>gl", function() vim.cmd.Git("log") end)
vim.keymap.set("n", "<leader>gf", function() vim.cmd.Git("fetch") end)
vim.keymap.set("n", "<leader>gj", function() vim.cmd("diffget //2<CR>") end)
vim.keymap.set("n", "<leader>gf", function() vim.cmd("diffget //3<CR>") end)
vim.keymap.set("n", "<leader>gss", function() vim.cmd.Git("stash") end)
vim.keymap.set("n", "<leader>gsc", function() vim.cmd.Git("stash clear") end)
