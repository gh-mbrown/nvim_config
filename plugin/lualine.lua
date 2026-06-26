vim.pack.add({
    { src = GIT_ROOT .. "nvim-tree/nvim-web-devicons" },
    { src = GIT_ROOT .. "nvim-lualine/lualine.nvim" }
})
require("lualine").setup({
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { function()
            return vim.fn.bufname(vim.api.nvim_get_current_buf())
        end },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    winbar = {
        lualine_b = { "lsp_status" },
        lualine_c = { "hostname" },
    },
    inactive_winbar = {
        lualine_b = { "lsp_status" },
        lualine_c = { "hostname" },
    }
})
