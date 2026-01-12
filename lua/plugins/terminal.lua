return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function ()
        require("toggleterm").setup({
            size = 40,
            direction = "float",
            open_mapping = "<C-`>",
            float_opts = {
                border = "single",
                title_pos = "left"
            }
        })
        local Terminal = require("toggleterm.terminal").Terminal

        vim.keymap.set("n", "<leader>tn", function() Terminal:new():toggle() end)
        vim.keymap.set("n", "<leader>ts", vim.cmd.TermSelect)
        vim.keymap.set("t", "<C-x>", "exit<CR>")
        vim.keymap.set("t", "<C-n>", function() Terminal:new():toggle() end)
        vim.keymap.set("t", "<C-s>", vim.cmd.TermSelect)
    end
}
