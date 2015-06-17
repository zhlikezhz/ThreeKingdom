local LoginView = class("LoginView", function()
	return require("class.ui.views.BaseView").new()
end)

function LoginView:ctor()
	self:_init()
end

function LoginView:_init()
	
end

return LoginView
