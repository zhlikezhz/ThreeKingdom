cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "init"

local function main()
	local scene = cc.Scene:create()
	cc.Director:getInstance():runWithScene(scene)

	-- local layer = require("class.ui.views.LoginView").new()
	local commfunc = require("class.common.utils.CommonFunction")
	local node = commfunc.readCCSFile("res/images/views/LoginLayer/LoginLayer.csb")
	scene:addChild(node, 10)
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
