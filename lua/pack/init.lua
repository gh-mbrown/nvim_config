local root = "https://github.com/"
vim.pack.add({
    { src = root .. "saghen/blink.cmp",                version = "v1.10.2" },
    { src = root .. "folke/tokyonight.nvim"},
    { src = root .. "nvim-mini/mini.pick"},
    { src = root .. "folke/ts-comments.nvim" },
    { src = root .. "tpope/vim-fugitive" },
    { src = root .. "christoomey/vim-tmux-navigator" },
    { src = root .. "nvim-treesitter/nvim-treesitter", version = "main" },
    { src = root .. "mbbill/undotree" },
    { src = root .. "neovim/nvim-lspconfig" },
    { src = root .. "windwp/nvim-autopairs" },
})

-- Load Plugins
for name, _ in vim.fs.dir(vim.fn.stdpath("config") .. "/lua/plugins") do
    require("plugins." .. name:gsub("%.lua$", ""))
end
