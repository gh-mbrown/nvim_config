return {
    cmd = {
        "roslyn",
        "--stdio",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fn.expand((os.getenv("HOME") or "/home/mbrown") .. "/.cache/nvim/roslyn-logs")
    },
    filetypes = {
        "cs",
        "cshtml",
        "razor"
    },
    root_markers = {
        "*.sln",
        "*.csproj",
        ".git"
    },
    handlers = {
        ["window/showMessage"] = function (err, result, ctx, config)
            if result and result.message and result.message:find("same key") then
                return
            end
            vim.lsp.handlers["window/showMessage"](err, result, ctx, config)
        end
    }
}
