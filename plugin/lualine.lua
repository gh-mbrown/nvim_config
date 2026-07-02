require("lazy_load").on_vim_enter(function()
    vim.pack.add({
        { src = GIT_ROOT .. "nvim-tree/nvim-web-devicons" },
        { src = GIT_ROOT .. "nvim-lualine/lualine.nvim" }
    })
    local lualine = require("lualine")
    lualine.setup({
        theme = "jellybeans",
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
                "diagnostics",
            },
            lualine_c = {
                {
                    "filename",
                    file_status = true,
                    newfile_status = true,
                    path = 1,
                },
            },
            lualine_x = {
                "filetype",
            },
            lualine_y = { "progress" },
            lualine_z = { "location" }
        },
        winbar = {
            lualine_a = { "lsp_status" },
            lualine_x = { "hostname" },
            lualine_z = { "fileformat" }
        },
        inactive_winbar = {
            lualine_a = { "lsp_status" },
            lualine_x = { "hostname" },
            lualine_z = { "fileformat" }
        },
        extensions = {
            "oil",
            "fugitive"
        }
    })

    vim.keymap.set("n", "<leader>lh", lualine.hide)
    vim.keymap.set("n", "<leader>lr", lualine.refresh)
    vim.keymap.set("n", "<leader>ls", function()
        lualine.hide({
            unhide = true
        })
    end)
end)
