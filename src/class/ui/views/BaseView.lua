local BaseView = class("BaseView", function()
	return ccui.Widget:create()
end)

function BaseView:ctor()

end

function BaseView:onEnter()
	printLog("Enter %s!!!", self.__cname)
end

function BaseView:onExit()
	printLog("Exit %s!!!!", self.__cname)
	if(app.getDebugFlag()) then
		package.loaded[self.__cname] = nil
	end
end

return BaseView