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
    csbCacheFlag = csbCacheFlag or false
    local filetype = commfunc.splitString(filename, "%.")

    if(filetype[2] == "csb")then
        if csbCacheFlag then
            node = CCSTemplateCache:getInstance():create(filename)
        else
            node = cc.CSLoader:createNode(filename)
        end
    elseif(filetype[2] == "json") then
        node = ccs.GUIReader:getInstance():widgetFromJsonFile(filename)
    else
        printLog(string.format("[error] : read ccs file [%s]", filename))
        error(string.format("[error] : read ccs file [%s]", filename))
    end

    return node
end

commfunc.loadCCSFile = function(filename, nodeMapList)
    local view = {}
    view.panel = commfunc.readCCSFile(filename)
    commfunc.panelAdapter(view.panel)
    for key, val in pairs(nodeMapList) do
        local node = view.panel
        local nodeNameList = commfunc.splitString(val, "%.")
        for i, name in ipairs(nodeNameList) do
            node = node:getChildByName(name)
            assert(node ~= nil, string.format("error : ccs map name %s", name))
        end
        -- commfunc.uiExtend(node)
        view[key] = node
    end
    return view
end

commfunc.uiExtend = function(widget)
    local desc = widget:getDescription()
    local WidgetEx = require("extend.ui.WidgetEx")

    if(desc == "Widget")then
        for i,v in pairs(WidgetEx) do
            widget[i] = v
        end
    elseif(desc == "Button")then
        for i,v in pairs(WidgetEx) do
            widget[i] = v
        end
    elseif(desc == "ImageView")then
        for i,v in pairs(WidgetEx) do
            widget[i] = v
        end
    elseif(desc == "Layout")then
        for i,v in pairs(WidgetEx) do
            widget[i] = v
        end
    elseif(desc == "Label" or desc == "Text")then
        for i,v in pairs(WidgetEx) do
            widget[i] = v
        end
    elseif(desc == "ScrollView")then
        for i,v in pairs(WidgetEx) do
            widget[i] = v
        end
    end
end

commfunc.panelAdapter = function(panel)
    local winSize = cc.Director:getInstance():getWinSize()
    -- local platform_scale = getPlatformScale()
    local platform_scale = 1.0

    local panel = panel or ccs.GUIReader:getInstance():widgetFromJsonFile(panel)
    panel:setTag(1)

    local downPanel = panel:getChildByName("down")
    if(downPanel) then 
        downPanel:setAnchorPoint(cc.p(0.5, 0))
        downPanel:setScale(platform_scale)
        downPanel:setPosition(cc.p(winSize.width / 2, 0)) 
    end

    local upPanel = panel:getChildByName("up")
    if(upPanel) then 
        upPanel:setAnchorPoint(cc.p(0.5, 1))
        upPanel:setScale(platform_scale)
        upPanel:setPosition(cc.p(winSize.width/2, winSize.height)) 
    end

    local leftPanel = panel:getChildByName("left")        
    if(leftPanel) then 
        leftPanel:setAnchorPoint(cc.p(0,0.5))
        leftPanel:setScale(platform_scale)
        leftPanel:setPosition(cc.p(0,winSize.height/2)) 
    end

    local rightPanel = panel:getChildByName("right")
    if(rightPanel) then 
        rightPanel:setAnchorPoint(cc.p(1,0.5))
        rightPanel:setScale(platform_scale)
        rightPanel:setPosition(cc.p(winSize.width ,winSize.height/2 )) 
    end

    local centerPanel = panel:getChildByName("center")
    if(centerPanel) then 
        centerPanel:setAnchorPoint(cc.p(0.5,0.5))
        centerPanel:setScale(platform_scale)
        centerPanel:setPosition(cc.p(winSize.width/2,winSize.height/2)) 
    end

    local left_down_panel = panel:getChildByName("left_down")
    if(left_down_panel) then 
        left_down_panel:setAnchorPoint(cc.p(0,0))
        left_down_panel:setScale(platform_scale)
        left_down_panel:setPosition(cc.p(0,0)) 
    end

    local right_down_panel = panel:getChildByName("right_down")
    if(right_down_panel) then 
        right_down_panel:setAnchorPoint(cc.p(1,0))
        right_down_panel:setScale(platform_scale)
        right_down_panel:setPosition(cc.p(winSize.width,0)) 
    end

    local left_up_panel = panel:getChildByName("left_up")
    if(left_up_panel) then 
        left_up_panel:setAnchorPoint(cc.p(0,1))
        left_up_panel:setScale(platform_scale)
        left_up_panel:setPosition(cc.p(0,winSize.height)) 
    end

    local right_up_panel = panel:getChildByName("right_up")
    if(right_up_panel) then 
        right_up_panel:setAnchorPoint(cc.p(1,1))
        right_up_panel:setScale(platform_scale)
        right_up_panel:setPosition(cc.p(winSize.width,winSize.height)) 
    end
end

return CommonFunction