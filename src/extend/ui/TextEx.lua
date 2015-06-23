local WidgetEx = require "ui_extend.WidgetEx"

local TextEx = clone(WidgetEx)

--设置文字，用跑跑language里的key作为参数
function TextEx:setKey(key,...)
    local string = textByKey(key,...)
    self:setString(string)
end

return TextEx