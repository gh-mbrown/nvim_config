local root = "https://github.com/"
vim.pack.add({
    { src = root .. "nvim-lua/plenary.nvim" },
    { src = root .. "rafamadriz/friendly-snippets" },
    { src = root .. "saghen/blink.cmp",                        version = "v1.10.2" },
    { src = root .. "sainnhe/everforest" },
    { src = root .. "folke/ts-comments.nvim" },
    { src = root .. "tpope/vim-fugitive" },
    { src = root .. "ThePrimeagen/harpoon",                    version = "harpoon2" },
    { src = root .. "nvim-telescope/telescope-fzf-native.nvim" },
    { src = root .. "nvim-telescope/telescope.nvim" },
    { src = root .. "christoomey/vim-tmux-navigator" },
    { src = root .. "nvim-treesitter/nvim-treesitter" },
    { src = root .. "mbbill/undotree" },
    { src = root .. "neovim/nvim-lspconfig" },
    { src = root .. "windwp/nvim-autopairs" },
})

-- Load Plugins
for name, _ in vim.fs.dir(vim.fn.stdpath("config") .. "/lua/plugins") do
    require("plugins." .. name:gsub("%.lua$", ""))
end
