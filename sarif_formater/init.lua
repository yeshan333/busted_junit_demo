local stages = require "luacheck.stages"
local json = require "dkjson"

local function get_message_format(warning)
    local message_format = assert(stages.warnings[warning.code], "Unknown warning code " .. warning.code).message_format

    if type(message_format) == "function" then
        return message_format(warning)
    else
        return message_format
    end
end

local color_codes = {
    reset = 0,
    bright = 1,
    red = 31,
    green = 32
}

local function encode_color(c)
    return "\27[" .. tostring(color_codes[c]) .. "m"
end

local function colorize(str, ...)
    str = str .. encode_color("reset")

    for _, color in ipairs({ ... }) do
        str = encode_color(color) .. str
    end

    return encode_color("reset") .. str
end

local function substitute(string_format, values, color)
    return (string_format:gsub("{([_a-zA-Z0-9]+)(!?)}", function(field_name, highlight)
        local value = tostring(assert(values[field_name], "No field " .. field_name))

        if highlight == "!" then
            if color then
                return colorize(value, "bright")
            else
                return "'" .. value .. "'"
            end
        else
            return value
        end
    end))
end

local function format_message(event, color)
    return substitute(get_message_format(event), event, color)
end

local function format_location(file, location, opts)
    local res = ("%s:%d:%d"):format(file, location.line, location.column)

    if opts.ranges then
        res = ("%s-%d"):format(res, location.end_column)
    end

    return res
end

local function event_code(event)
    return (event.code:sub(1, 1) == "0" and "E" or "W") .. event.code
end

local function format_event(file_name, event, opts)
    local message = format_message(event, opts.color)

    if opts.codes then
        message = ("(%s) %s"):format(event_code(event), message)
    end

    return format_location(file_name, event, opts) .. ": " .. message
end

-- luacheck: ignore 212
return function(report, file_names, options)
    local opts = {}
    local get_level = function(event)
        return event.code:sub(1, 1) == "0" and "error" or "warning"
    end

    -- 这里将输入数据转换为符合 SARIF 格式的 JSON 字符串
    local sarif_output = {
        version = "2.1.0",
        runs = {
            {
                tool = {
                    driver = {
                        name = "luacheck",
                        version = "1.0.0"
                    }
                },
                results = {}
            }
        }
    }

    -- 假设 data 是一个表，包含多个结果
    for file_i, file_report in ipairs(report) do
        for _, event in ipairs(file_report) do
            table.insert(sarif_output.runs[1].results, {
                level = get_level(event),
                ruleId = event_code(event),
                message = {
                    text = format_event(file_names[file_i], event, opts)
                },
                locations = {
                    {
                        physicalLocation = {
                            artifactLocation = {
                                uri = file_names[file_i]
                            },
                            region = {
                                startLine = event.line,
                                startColumn = event.column
                            }
                        }
                    }
                }
            })
        end
    end

    --     return ([[
    --  Files: %d
    --  Formatter: %s
    --  Quiet: %d
    --  Color: %s
    --  Codes: %s]]):format(#file_names, options.formatter, options.quiet,
    --     tostring(options.color), tostring(options.codes))
    return json.encode(sarif_output)
end
