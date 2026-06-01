local harpoon = require("harpoon")
local ext = require("harpoon.extensions")
harpoon:extend(ext.builtins.highlight_current_file())
harpoon:setup({
    settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
    },
})
