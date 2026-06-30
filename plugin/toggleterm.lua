if vim.g.neovide then
    require("lazy_load").on_vim_enter(function ()
        vim.pack.add({
            GIT_ROOT .. "akinsho/toggleterm.nvim"
        })

        local toggleterm = require("toggleterm")
        toggleterm.setup({
            open_mapping = "<C-`>",
            direction = "float",
            float_opts = {
                border = "curved",
                title_pos = "center",
            },
        })

        vim.keymap.set("n", "<leader>tn", vim.cmd.TermNew)
        vim.keymap.set("n", "<leader>tt", vim.cmd.TermSelect)
        vim.keymap.set("n", "<leader>ts", vim.cmd.ToggleTermSendCurrentLine)
        vim.keymap.set("v", "<leader>ts", vim.cmd.ToggleTermSendVisualSelection)
        vim.keymap.set("n", "<leader>to", vim.cmd.ToggleTermSetName)
    end)
end
