require("lazy_load").on_vim_enter(function()
    vim.pack.add({
        GIT_ROOT .. "tpope/vim-fugitive"
    })

    vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
    vim.keymap.set("n", "<leader>gw", function()
        vim.cmd.Git("blame")
    end)
    vim.keymap.set("n", "<leader>gl", function()
        vim.cmd.Git("--paginate log")
    end)
    vim.keymap.set("n", "<leader>gd", function()
        vim.cmd.Git("--paginate diff")
    end)
    vim.keymap.set("n", "<leader>gD", vim.cmd.Gvdiffsplit)
    vim.keymap.set("n", "<leader>gm", function()
        vim.cmd.Git("mergetool")
    end)
    vim.keymap.set("n", "<leader>gt", function()
        vim.cmd.Git("difftool")
    end)
    vim.keymap.set("n", "<leader>gp", function()
        vim.cmd.Git("pull --rebase")
    end)
    vim.keymap.set("n", "<leader>gP", function()
        vim.cmd.Git("push")
    end)
    vim.keymap.set("n", "<leader>gc", function ()
        local branch = vim.fn.input("Branch Name: ")
        if not branch or branch == "" then return end
        vim.cmd.Git("checkout -b " .. branch)
        vim.cmd.Git("push -u origin " .. branch)
    end)
    vim.keymap.set("n", "<leader>gi", function ()
        vim.cmd.Git("init")
    end)

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "gitcommit",
        callback = function()
            vim.cmd.startinsert()
        end
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "gitcommit",
        callback = function(args)
            vim.keymap.set("i", "<C-c><C-c>", vim.cmd.wq, { buffer = args.buf })
        end
    })
end)
