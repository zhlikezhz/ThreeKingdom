local commfunc = require("class.common.utils.CommonFunction")

local LoginView = class("LoginView", function()
	return require("class.ui.views.BaseView").new()
end)

function LoginView:ctor()
	self:_init()
end

function LoginView:_init()
	local ccsMapName = {
		enterGameBtn	=	"Button_1", -- 进入游戏按钮
	}
	local ccsFileName = "res/images/views/LoginLayer/LoginLayer.csb"
	local view = commfunc.loadCCSFile(ccsFileName, ccsMapName)
	self:addChild(view.panel)
end


return LoginView
