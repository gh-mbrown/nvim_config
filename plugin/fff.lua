vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "fff.nvim" and (kind == "install" or kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("fff.nvim")
            end
            require("fff.download").download_or_build_binary()
        end
    end
})

vim.pack.add({
    Git_root .. "dmtrKovalenko/fff.nvim",
})

vim.g.fff = {
    lazy_sync = true,
    debug = {
        enabled = true,
        show_scores = true,
        show_file_info = {
            score_breakdown = false,
        }
    },
    layout = {
        show_scrollbar = false,
        prompt_position = "top",
        anchor = "bottom",
        height = 0.5,
        width = 1,
    },
    git = {
        status_text_color = true,
    },
}

local fff = require("fff")
vim.keymap.set("n", "<leader>ff", function() fff.find_files() end)
vim.keymap.set("n", "<leader>/", function() fff.live_grep() end)
vim.keymap.set("n", '<leader>fc', function() fff.live_grep({ query = vim.fn.expand('<cword>') }) end)
