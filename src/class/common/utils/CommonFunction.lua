local CommonFunction = {}
local commfunc = CommonFunction

-- 根据splitSymbol来分割splitString
-- 例如：splitString("aa.bb.cc", ".")
-- 返回：{[1] = "aa", [2] = "bb", [3] = "cc"}
commfunc.splitString = function(splitString, splitSymbol)
    local splitTable = {}
    splitSymbol = splitSymbol or ","
    
    while (true) do
        local pos = string.find(splitString, splitSymbol)
        if (not pos) then
            splitTable[#splitTable + 1] = splitString
            break
        end
        splitTable[#splitTable + 1] = string.sub(splitString, 1, pos - 1)
        splitString = string.sub(splitString, pos + 1, #splitString)
    end

    return splitTable 
end

-- 读取*.csb或.json后缀的ccs文件
commfunc.readCCSFile = function(filename, csbCacheFlag)
    local node = nil
    local filetype = commfunc.splitString(filename, "%.")

    if(filetype[2] == "csb")then
        if csbCacheFlag then
            node = CCSTemplateCache:getInstance():create(name)
        else
            node = cc.CSLoader:createNode(name)
        end
    elseif(filetype[2] == "json")
        node = ccs.GUIReader:getInstance():widgetFromJsonFile(name)
    else
        printLog(string.format("[error] : read ccs file [%s]", filename))
        error(string.format("[error] : read ccs file [%s]", filename))
    end

    return node
end

commfunc.loadCCSFile = function(filename, nodeMapList)
    local view = {}
    local view.panel = commfunc.readCCSFile(filename)
    for key, val in pairs(nodeMapList) do
        local node = view.panel
        local nodeNameList = commfunc.splitString(val, "%.")
        for i, name in ipairs(nodeNameList) do
            node = node:getChildByName(name)
            assert(node ~= nil, string.format("error : ccs map name %s", name))
        end
        view[key] = node
    end
    return view
end

return CommonFunction