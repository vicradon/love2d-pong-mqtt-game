function readFile(path)
    local file = io.open(path, "rb") 
    if not file then return {} end
    
    local lines = {}
    
    for line in io.lines(path) do  
      table.insert(lines, line)
    end
    
    file:close()
    return lines;
end

return readFile