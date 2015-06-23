local LoginView = class("LoginView", require("class.ui.views.BaseView"))

function LoginView:ctor()
	self:_init()
end

function LoginView:_init()
	local ccsMapName = {
		enterGameBtn	=	"Button_1", -- 进入游戏按钮
	}
	local ccsFileName = "res/images/views/LoginLayer/LoginLayer.csb"
	local view = commfunc.loadCCSFile(ccsFileName, ccsMapName)
	view.enterGameBtn:setClickedFunc(handler(self, self._onLoginBtn))
	self:addChild(view.panel)
end

function LoginView:_onLoginBtn()
	UserData.init()
	MajorCityLayer.init()
	MajorCityLayer.enter()
end

return LoginView
