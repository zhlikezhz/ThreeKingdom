local BaseView = class("BaseView", function()
	return ccui.Widget:create()
end)

function BaseView:ctor()

end

function BaseView:_init()

end

function BaseView:onEnter()
	printLog("Enter %s!!!", self.__cname)
end

function BaseView:onExit()
	printLog("Exit %s!!!!", self.__cname)
	package.loaded[self.__cname] = nil
end

return BaseView