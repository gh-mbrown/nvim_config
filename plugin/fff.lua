vim.pack.add({
     Git_root .. "dmtrKovalenko/fff.nvim" ,
})

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function (ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if not ev.data.active then
            vim.cmd.packadd("fff.nvim")
        end
        if name == "fff.nvim" and (kind == "install" or kind == "update") then
            require("fff.download").download_or_build_binary()
        end
    end
})

local fff = require("fff")
vim.keymap.set("n", "<leader>ff", function ()
    fff.find_files()
end)
