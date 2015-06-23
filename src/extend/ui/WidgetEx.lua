local WidgetEx = ccui.Widget
WidgetEx._clickEventCallback = function() end
WidgetEx._pressEventCallback = function() end
WidgetEx._releaseEventCallback = function() end
WidgetEx._stateChangeEventCallback = function() end

function WidgetEx:setClickedFunc(callback)
    if(callback ~= nil and type(callback) == "function") then
        self._clickEventCallback = callback
        self:updateClickedEventListener()
    end
end

function WidgetEx:setPressedFunc(callback)
    if(callback ~= nil and type(callback) == "function") then
        self._pressEventCallback = callback
        self:updateClickedEventListener()
    end
end

function WidgetEx:setReleaseFunc(callback)
    if(callback ~= nil and type(callback) == "function") then
        self._releaseEventCallback = callback
        self:updateClickedEventListener()
    end
end

function WidgetEx:setStateChangedFunc(callback)
    if(callback ~= nil and type(callback) == "function") then
        self._stateChangeEventCallback = callback
        self:updateClickedEventListener()
    end
end

function WidgetEx:updateClickedEventListener()
    self:addTouchEventListener(function(sender, type)
        if(type == TOUCH_EVENT_BEGAN) then
            self:_clickEventCallback(sender)
        elseif(type == TOUCH_EVENT_MOVED) then
            self:_pressEventCallback(sender)
        elseif(type == TOUCH_EVENT_ENDED) then
            self:_releaseEventCallback(sender)
        elseif(type == TOUCH_EVENT_CANCELED) then
            self:_stateChangeEventCallback(sender)
        end
    end)
end

return WidgetEx