vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.go",
    callback = function()
        vim.api.nvim_create_autocmd("PackChanged", {
            callback = function(ev)
                local name, kind = ev.data.spec.name, ev.data.kind
                if name == "go.nvim" and (kind == "update" or kind == "install") then
                    if not ev.data.active then vim.cmd.packadd("go.nvim") end
                    require("go.install").update_all_sync()
                end
            end
        })

        vim.pack.add({
            { src = GIT_ROOT .. "ray-x/go.nvim" },
            { src = GIT_ROOT .. "ray-x/guihua.lua" },
            { src = GIT_ROOT .. "neovim/nvim-lspconfig" },
        })

        local go = require("go")
        local format = require("go.format")
        go.setup()
        local format_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                format.goimports()
            end,
            group = format_grp
        })
    end,
    once = true,
})
