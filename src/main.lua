cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
cc.FileUtils:getInstance():addSearchPath("res/images/views")


local function main()
	local scene = cc.Scene:create()
	cc.Director:getInstance():runWithScene(scene)
end

local function __G__TRACKBACK__(msg)
	local detailMsg = "---------------------------------------\n"
    detailMsg = detailMsg .. "LUA ERROR: " .. tostring(msg) .. "\n"
    detailMsg = detailMsg .. debug.traceback() .. "\n"
    detailMsg = detailMsg .. "---------------------------------------"
    print(detailMsg)
    return msg
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then print(msg) end
