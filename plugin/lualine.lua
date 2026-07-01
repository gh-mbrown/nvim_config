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
                {
                    "diagnostics",
                    always_visible = true
                },
            },
            lualine_c = {
                {
                    "filename",
                    file_status = true,
                    newfile_status = true,
                    path = 1,
                },
            },
            lualine_x = {},
            lualine_y = { "progress" },
            lualine_z = { "location" }
        },
        winbar = {
            lualine_b = {
                {
                    "filetype",
                    icon_only = true,
                },
                "buffers"
            },
            lualine_x = { "hostname" },
            lualine_z = { "lsp_status" }
        },
        inactive_winbar = {
            lualine_b = {
                {
                    "filetype",
                    icon_only = true,
                }
            },
            lualine_x = { "hostname" },
            lualine_z = { "lsp_status" }
        },
        extensions = {
            pcall(require, "oil") and "oil",
            pcall(require, "toggleterm") and "toggleterm"
        }
    })

    vim.keymap.set("n", "<leader>lh", lualine.hide)
    vim.keymap.set("n", "<leader>lr", lualine.refresh)
    vim.keymap.set("n", "<leader>ls", function()
        lualine.hide({
            unhide = true
        })
    end)
    vim.keymap.set("n", "<leader>b1", function() vim.cmd("LualineBuffersJump! 1") end)
    vim.keymap.set("n", "<leader>b2", function() vim.cmd("LualineBuffersJump! 2") end)
    vim.keymap.set("n", "<leader>b3", function() vim.cmd("LualineBuffersJump! 3") end)
    vim.keymap.set("n", "<leader>b4", function() vim.cmd("LualineBuffersJump! 4") end)
    vim.keymap.set("n", "<leader>b5", function() vim.cmd("LualineBuffersJump! 5") end)
    vim.keymap.set("n", "<leader>b6", function() vim.cmd("LualineBuffersJump! 6") end)
    vim.keymap.set("n", "<leader>b7", function() vim.cmd("LualineBuffersJump! 7") end)
    vim.keymap.set("n", "<leader>b8", function() vim.cmd("LualineBuffersJump! 8") end)
    vim.keymap.set("n", "<leader>b9", function() vim.cmd("LualineBuffersJump! 9") end)
end)
