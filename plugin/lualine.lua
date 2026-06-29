require("lazy_load").on_vim_enter(function()
    vim.pack.add({
        { src = GIT_ROOT .. "nvim-tree/nvim-web-devicons" },
        { src = GIT_ROOT .. "nvim-lualine/lualine.nvim" }
    })
    require("lualine").setup({
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "diff", "diagnostics" },
            lualine_c = { function()
                return vim.fn.bufname(vim.api.nvim_get_current_buf())
            end },
            lualine_x = { "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" }
        },
        winbar = {
            lualine_a = { "lsp_status" },
            lualine_b = { "branch" },
            lualine_c = { "hostname" },
            lualine_x = { "filesize" },
            lualine_y = { "tabs" },
            lualine_z = { "fileformat" }
        },
        inactive_winbar = {
            lualine_a = { "lsp_status" },
            lualine_b = { "branch" },
            lualine_c = { "hostname" },
        }
    })
end)
