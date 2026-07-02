require("lazy_load").on_vim_enter(function ()
    vim.pack.add({
        GIT_ROOT .. "smoka7/hop.nvim"
    })
    local hop = require("hop")
    local hint = require("hop.hint")
    hop.setup({})
    vim.keymap.set("n", "<leader>hw", hop.hint_words)
    vim.keymap.set("n", "<leader>he", function ()
        hop.hint_words({
            hint_position = hint.HintPosition.END
        })
    end)
    vim.keymap.set("n", "<leader>hp", hop.hint_patterns)
end)
