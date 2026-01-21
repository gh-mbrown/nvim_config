return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {},
            config = function ()
                require("mason").setup({
                    registries = {
                        "github:mason-org/mason-registry",
                        "github:Crashdummyy/mason-registry",
                    }
                })
            end
        },
        "neovim/nvim-lspconfig",
        -- "mason-org/mason-registry",
    },
    opts = {
        ensure_installed = {
            "gopls",
            "lua_ls",
            "bashls",
            "bicep",
            -- "csharpier",
            -- "goimports",
            "html",
            "jsonls",
            "powershell_es",
            -- "prettier",
            -- "roslyn",
            "stylua",
            "yamlls",
            "pyright",
            "rust_analyzer",
            "zls"
        }
    },
    highlight = {
        enable = true
    },
}
