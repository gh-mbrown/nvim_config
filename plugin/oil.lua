vim.pack.add({
    { src = GIT_ROOT .. "nvim-tree/nvim-web-devicons" },
    { src = GIT_ROOT .. "stevearc/oil.nvim" },
})
local oil = require("oil")
oil.setup({
    view_options = {
        show_hidden = true,
    },
    use_default_keymaps = true,
    keymaps = {
        ["<leader>oc"] = oil.close,
        ["<leader>oh"] = oil.toggle_hidden,
        ["<leader>op"] = oil.open_preview,
        ["<C-l>"] = function()
            vim.cmd.wincmd("l")
        end,
        ["<C-h>"] = function()
            vim.cmd.wincmd("h")
        end,
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
    }
})

vim.keymap.set("n", "<leader>oo", function()
    if vim.bo[vim.api.nvim_get_current_buf()].filetype ~= "oil" then
        oil.open()
    else
        vim.notify("Already in Oil", vim.log.levels.INFO)
    end
end)
vim.keymap.set("n", "<leader>ot", oil.toggle_float)
