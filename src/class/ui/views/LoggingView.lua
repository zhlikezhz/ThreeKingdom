local LoggingView = class("LoggingView", function()
	return require("class.ui.views.BaseView").new()
end)

function LoggingView:ctor()
	self:_init()
end

function LoggingView:_init()

end

return LoggingView
