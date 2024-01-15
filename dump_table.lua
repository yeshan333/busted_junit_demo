local function dump(o, indent)
   indent = indent or 0

   local function handle_table(t, currentIndent)
       local result = {}
       for k, v in pairs(t) do
           local key = type(k) ~= 'number' and ('[' .. dump(k, currentIndent + 1) .. ']') or ''
           local value = type(v) == 'table' and handle_table(v, currentIndent + 1) or dump(v, currentIndent + 1)
           table.insert(result, key .. (key ~= '' and ' = ' or '') .. value)
       end
       return '{\n' .. table.concat(result, ',\n') .. '\n' .. string.rep('  ', currentIndent) .. '}'
   end

   if type(o) == 'table' then
       return handle_table(o, indent)
   else
       return tostring(o)
   end
end

local t = {
    ["abe"] = {1,2,3,4,5},
    "string1",
    50,
    ["depth1"] = { ["depth2"] = { ["depth3"] = { ["depth4"] = { ["depth5"] = { ["depth6"] = { ["depth7"]= { ["depth8"] = { ["depth9"] = { ["depth10"] = {1000}, 900}, 800},700},600},500}, 400 }, 300}, 200}, 100},
    ["ted"] = {true,false,"some text"},
    "string2",
    [function() return end] = function() return end,
    75
}

print(dump(t))

--[[
{
string1,
50,
string2,
75,
[depth1] = {
100,
[depth2] = {
200,
[depth3] = {
300,
[depth4] = {
400,
[depth5] = {
500,
[depth6] = {
600,
[depth7] = {
700,
[depth8] = {
800,
[depth9] = {
900,
[depth10] = {
1000
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  },
[ted] = {
true,
false,
some text
  },
[function: 0x7f06ea5ef690] = function: 0x7f06ea5ef6c0,
[abe] = {
1,
2,
3,
4,
5
  }
}
]]
