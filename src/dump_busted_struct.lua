local M = {}

local function handle_table(t, currentIndent)
    local result = {}
    for k, v in pairs(t) do
        local key = type(k) ~= 'number' and ('[' .. M.dump(k, currentIndent) .. ']') or ''
        local value = type(v) == 'table' and handle_table(v, currentIndent + 1) or M.dump(v, currentIndent + 1)
        table.insert(result, string.rep('  ', currentIndent) .. key .. (key ~= '' and ' = ' or '') .. value)
    end
    return '{\n' .. table.concat(result, ',\n') .. '\n' .. string.rep('  ', currentIndent - 1) .. '}'
end

function M.dump(o, indent)
    indent = indent or 0

    if type(o) == 'table' then
        return handle_table(o, indent + 1)
    else
        return tostring(o)
    end
end

return M