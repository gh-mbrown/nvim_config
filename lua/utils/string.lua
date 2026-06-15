local M = {}

M.starts_with = function(str, sub)
    return string.sub(str, 1, string.len(sub)) == sub
end

M.split_on = function (str, sep)
    sep = sep or "%s"
    local result = {}

    for s in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(result, s)
    end

    return result
end

return M
