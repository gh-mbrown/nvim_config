require("lazy_load").on_vim_enter(function()
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(ev)
            local name, kind = ev.data.spec.name, ev.data.kind
            if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
                if not ev.data.active then
                    vim.cmd.packadd("nvim-treesitter")
                end
                vim.cmd("TSUpdate")
            end
        end
    })

    vim.pack.add({
        { src = GIT_ROOT .. "nvim-treesitter/nvim-treesitter", verison = "main", },
    })

    local ts = require("nvim-treesitter")
    local funcs = require("utils.functions")
    ts.setup({})

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
            local ft = vim.bo.filetype
            local remap = {
                cs = "c_sharp",
                jsonc = "json"
            }
            local rft = remap[ft] or ft
            if not vim.tbl_contains(ts.get_installed(), rft) and vim.tbl_contains(ts.get_available(), rft) then
                ts.install({ rft })
            end
        end
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
            if vim.bo[args.buf].buftype == "" then
                pcall(vim.treesitter.start)
            end
        end,
    })

    vim.keymap.set("n", "<leader>ti", vim.cmd.InspectTree)
    vim.keymap.set("n", "<leader>te", vim.cmd.EditQuery)
    vim.keymap.set("n", "<leader>tl", function()
        funcs.list_to_buffer(ts.get_installed())
    end)
    vim.keymap.set("n", "<leader>tu", vim.cmd.TSUpdate)
end)
