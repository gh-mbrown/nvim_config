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
    local lualine = require("lualine")
    lualine.setup({
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                {
                    "filename",
                    file_status = true,
                    newfile_status = true,
                    path = 1,
                },
            },
            lualine_x = {
                {
                    "filetype",
                    icon_only = true,
                }
            },
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
        },
        extensions = {
            pcall(require, "oil") and "oil"
        }
    })

    vim.keymap.set("n", "<leader>lh", lualine.hide)
    vim.keymap.set("n", "<leader>lr", lualine.refresh)
    vim.keymap.set("n", "<leader>ls", function()
        lualine.hide({
            unhide = true
        })
    end)
    vim.api.nvim_set_hl(0, "lualine_c_normal", {
        nocombine = true,
        bg = "#181825",
        fg = "#cdd6f4",
    })
    vim.api.nvim_set_hl(0, "lualine_c_inactive", {
        nocombine = true,
        bg = "#181825",
        fg = "#6c7086",
    })
end)
