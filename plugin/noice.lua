vim.pack.add({
    { src = GIT_ROOT .. "folke/noice.nvim" },
    { src = GIT_ROOT .. "MunifTanjim/nui.nvim" },
    { src = GIT_ROOT .. "rcarriga/nvim-notify" },
})

require("notify").setup({
    background_colour = "NotifyBackground",
    stages = "static",
    render = "minimal",
    timeout = 3000,
})
if not vim.g.neovide then
    vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "none" })
end
require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
    },
})
