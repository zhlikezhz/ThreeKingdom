function printUntable(...)
    local str = ""
    local args = {...}
    for _,value in pairs(args) do
        str = str .. "|" .. tostring(value)
    end
    
    print(str)
end

function printTable( t, indent )
    local print = printUntable
    indent = indent or 1
    local pre = string.rep("\t", indent)
    for k,v in pairs(t) do
        if type(v) == "table" then
            if type(k) == "number" then
                print(pre .. "[" .. k .. "]" .. " = {")
                printTable(v, indent + 1)
                print(pre .. "},")
            elseif type(k) == "string" then
                if tonumber(k) then
                    print(pre .. "[\"" .. k .. "\"] = {")
                elseif (tonumber(string.sub(k, 1, 1))) then
                    print(pre .. "[\"" .. k .. "\"] = {")
                else
                    print(pre .. k .. " = {")
                end
                printTable(v, indent + 1)
                print(pre .. "},")
            end
        elseif type(v) == "number" then
            if type(k) == "number" then
                print(pre .. "[" .. k .. "]" .. " = " .. v .. ",")
            elseif type(k) == "string" then
                if tonumber(k) then
                    print(pre .. "[\"" .. k .. "\"] = " .. v .. ",")
                elseif (tonumber(string.sub(k, 1, 1))) then
                    print(pre .. "[\"" .. k .. "\"] = " .. v .. ",")
                else
                    print(pre .. k .. " = " .. v .. ",")
                end
            end
        elseif type(v) == "string" then
            local text = string.gsub(v, "[\n]", "")
            text = string.gsub(text, "\"", "\\\"")
            if type(k) == "number" then
                print(pre .. "[" .. k .. "]" .. " = \"" .. text .. "\",")
            elseif type(k) == "string" then
                if tonumber(k) then
                    print(pre .. "[\"" .. k .. "\"] = \"" .. text .. "\",")
                elseif (tonumber(string.sub(k, 1, 1))) then
                    print(pre .. "[\"" .. k .. "\"] = \"" .. text .. "\",")
                else
                    print(pre .. k .. " = \"" .. text .. "\",")
                end
            end
        elseif type(v) == "boolean" then
            local text = "false"
            if(v)then text = "true" end
            if type(k) == "number" then
                print(pre .. "[" .. k .. "]" .. " = " .. text .. ",")
            elseif type(k) == "string" then
                if tonumber(k) then
                    print(pre .. "[\"" .. k .. "\"] = " .. text .. ",")
                elseif (tonumber(string.sub(k, 1, 1))) then
                    print(pre .. "[\"" .. k .. "\"] = " .. text .. ",")
                else
                    print(pre .. k .. " = " .. text .. ",")
                end
            end
        end
    end
end

function logging(...)
    local args = {...}

    if(type(args[1]) == "table")then
       printTable(args[1])
    else
       printUntable(...)
    end
end
