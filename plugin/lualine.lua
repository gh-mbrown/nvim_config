require("lazy_load").on_vim_enter(function()
    vim.pack.add({
        { src = GIT_ROOT .. "nvim-tree/nvim-web-devicons" },
        { src = GIT_ROOT .. "nvim-lualine/lualine.nvim" }
    })
    local function get_project_name()
        local ok, project = pcall(require, "project_nvim.project")
        if not ok then return "" end
        if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            local root = project.get_project_root()
            if root then
                return vim.fn.fnamemodify(root, ":t")
            end
        end
        return ""
    end
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
            lualine_a = { "lsp_status" },
            lualine_b = { get_project_name },
            lualine_c = { "hostname" },
            lualine_x = { "filesize" },
            lualine_z = { "fileformat" }
        },
        inactive_winbar = {
            lualine_a = { "lsp_status" },
            lualine_b = { get_project_name },
            lualine_c = { "hostname" },
        }
    })
end)
