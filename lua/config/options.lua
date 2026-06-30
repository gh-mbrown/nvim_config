vim.opt.mouse = "a"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.cinoptions = {
    "g0",
    "N-s",
    "t0",
    "(0",
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.showmode = true
vim.opt.splitright = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backup = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.o.winborder = "rounded"
vim.opt.wrap = true
vim.o.laststatus = 2
vim.opt.guicursor = "n-v-c-i:block"
vim.g.netrw_cursor = 1
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.INFO] = "⚠",
            [vim.diagnostic.severity.HINT] = "⚡",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

if vim.fn.has("win32") == 1 then
    vim.opt.shell = "pwsh -NoLogo"
    vim.opt.shellcmdflag = "-ExecutionPolicy RemoteSigned -Command"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

if vim.g.neovide then
    vim.o.guifont = "CaskaydiaCove Nerd Font Mono"
    vim.opt.linespace = 0
    vim.g.neovide_scale_factor = 0.85
    vim.g.neovide_cursor_animation_length = 0
    vim.opt.belloff = "all"
    vim.opt.visualbell = false
    vim.opt.errorbells = false
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_padding_left = 8
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_position_animation_length = 0
end
