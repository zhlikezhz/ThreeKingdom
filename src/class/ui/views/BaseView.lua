local BaseView = class("BaseView", function()
	return ccui.Widget:create()
end)

function BaseView:ctor()
	self:registerScriptHandler(function(state)
		if state == "enter" then
			self:onEnter()
		elseif state == "exit" then
			self:onExit()
		end
	end)
end

function BaseView:onEnter()
	printLog(string.format("Enter %s!!!", self.__cname))
end

function BaseView:onExit()
	printLog(string.format("Exit %s!!!!", self.__cname))
	if(app.getDebugFlag()) then
		package.loaded[self.__cname] = nil
	end
end

function BaseView:close()
	self:removeFromParent()
end

return BaseView