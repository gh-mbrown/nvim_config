function string.starts(str, sub)
    return string.sub(str, 1, string.len(sub)) == sub
end
