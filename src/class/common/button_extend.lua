local WidgetEx = require "ui_extend.WidgetEx"

local ButtonEx = clone(WidgetEx)


--设置第一张图片名
function ButtonEx:setImage1(fileName)
    self:loadTextureNormal(fileName)

    self.images = self.images or {}
    self.images[1] = fileName
end

--设置第二张图片名
function ButtonEx:setImage2(fileName)
    self:loadTexturePressed(fileName)

    self.images = self.images or {}
    self.images[2] = fileName
end

--设置第三张图片名
function ButtonEx:setImage3(fileName)
    self:loadTextureDisabled(fileName)

    self.images = self.images or {}
    self.images[3] = fileName
end


function ButtonEx:setImages(file1,file2,file3)
    self:loadTextureNormal(file1)
    self:loadTexturePressed(file2)
    self:loadTextureDisabled(file3)

    self.images = self.images or {}
    self.images[1] = file1
    self.images[2] = file2
    self.images[3] = file3

end

function ButtonEx:setLight(b)
    if(b)then
        self.isLight = true
        self:loadTextureNormal(self.images[2])
        self:setTouchEnabled(false)
    else
        self.isLight = false
        self:loadTextureNormal(self.images[1])
        self:setTouchEnabled(true)
    end
end

function ButtonEx:isLight()
    if(self.isLight == nil)then
        self.isLight = false
    end
    return self.isLight
end

--设置文字
function ButtonEx:setString(str)
    self:setTitleText(str)
end

--设置文字
function ButtonEx:setKey(key,...)
    local string = textByKey(key,...)
    self:setTitleText(string)
end

function ButtonEx:addFollowChild(widget,offset)
    local renderer1 = self:getVirtualRenderer()
    self:setBrightStyle(1)
    local renderer2 = self:getVirtualRenderer()
    self:setBrightStyle(0)

    offset = offset or cc.p(0,0)
    renderer1:addChild(widget)
    widget:setPosition(cc.p(renderer1:getContentSize().width/2 + offset.x,renderer1:getContentSize().height/2 + offset.y))

    local widget2 = widget:clone()
    renderer2:addChild(widget2)
    widget2:setPosition(cc.p(renderer2:getContentSize().width/2 + offset.x,renderer2:getContentSize().height/2 + offset.y))
end

return ButtonEx