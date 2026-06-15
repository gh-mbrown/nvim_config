vim.pack.add({
    Git_root .. "nyoom-engineering/oxocarbon.nvim"
})
vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = "#525252" })
vim.api.nvim_set_hl(0, "MiniPickPreviewLine", { bg = "#262626" })
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = "#262626" })
vim.api.nvim_set_hl(0, "MiniPickPrompt", {link = "NormalFloat"})
vim.api.nvim_set_hl(0, "MiniPickPromptCaret", {fg = "#78a9ff"})
vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", {bg = "#131313", fg = "#78a9ff"})
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
