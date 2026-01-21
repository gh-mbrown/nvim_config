local cwDir = vim.fn.stdpath("config")
local files = vim.split(vim.fn.glob(cwDir .. "/lua/config/*"), '\n', {trimempty=true})

for _, f in pairs(files) do
    local file = vim.fn.fnamemodify(f, ":t")
    local config = vim.fn.fnamemodify(file, ":r")

    if config == "init" then
       goto continue
    elseif config == "neovide" then
        if vim.g.neovide then
            require("config."..config)
        end
    end

    require("config."..config)

    ::continue::
end
