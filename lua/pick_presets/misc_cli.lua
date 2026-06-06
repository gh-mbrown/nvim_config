return {
    tldr = {
        command = { "tldr", "--list" },
        name = "tldr",
        choose = function(selection)
            vim.cmd.ReadCmd('tldr "' .. selection .. '"')
        end
    }
}
