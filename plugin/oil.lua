vim.pack.add({
    { src = GIT_ROOT .. "nvim-tree/nvim-web-devicons" },
    { src = GIT_ROOT .. "stevearc/oil.nvim" },
})
local oil = require("oil")
oil.setup({
    view_options = {
        show_hidden = true,
    },
})

local function apply_oil_func(con, mes, func)
    if con == (vim.bo[vim.api.nvim_get_current_buf()].filetype == "oil") then func() else vim.notify(mes) end
end

vim.keymap.set("n", "<leader>oo", function()
    apply_oil_func(false, "Already in Oil", oil.open)
end)
vim.keymap.set("n", "<leader>oc", function()
    apply_oil_func(true, "Not in Oil", oil.close)
end)
vim.keymap.set("n", "<leader>ot", oil.toggle_float)
vim.keymap.set("n", "<leader>oh", function()
    apply_oil_func(true, "Not in Oil", oil.toggle_hidden)
end)
vim.keymap.set("n", "<leader>op", function()
    apply_oil_func(true, "Not in Oil", oil.open_preview)
end)
