function getTableLength(tbl)
    local length = 0
    for n in pairs(tbl) do 
      length = length + 1 
    end
    return length
end

return getTableLength