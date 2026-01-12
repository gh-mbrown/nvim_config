return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
            include = {
                node_type = {
                    ["*"] = {
                        "*"
                    }
                }
            },
        }
    },
    config = function (_, opts)
        -- vim.api.nvim_set_hl(0, "IblScope", {fg = "#ffffff"})
        require("ibl").setup(opts)
    end
}
