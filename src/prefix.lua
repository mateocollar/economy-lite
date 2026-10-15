local M={}
function M.colorize(text)
return (text:gsub("&","§"))
end
function M.prefix (text)
return M.colorize("&e[Economía] " .. text)
end
return M
