return {
    dirs = {
        items = function ()
            local dirs = {}
            local function get_dirs(path)
                local content = vim.split(vim.fn.glob(path .. "/*"), "\n", { trimempty = true })
                for _, d in pairs(content) do
                    if vim.fn.isdirectory(d) == 1 then
                        table.insert(dirs, d)
                        get_dirs(d)
                    end
                end
            end
            get_dirs(".")
            return dirs
        end,
        name = "Directories",
        choose_marked = function (choice)
            if not choice then return end
            vim.cmd.edit(choice)
        end
    }
}
