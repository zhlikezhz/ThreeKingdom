local CCBView = class("CCBView", cc.Node)

-- local CCBViewData = {
--     data = {
--         id = "",
--         name = "",
--         model = "",
--         imageBg = "",
--         callback = "",
--         ccbi = "",
--     },
--     event = {
--         [1] =   {
--             id = "",
--             name = "",
--             callback = "",
--         },
--     },
-- }

function CCBView:create(ccbiName)
	local view = CCBView.new()
	view:initWithCCB(ccbiName)
	return view
end

function CCBView:initWithCCB(ccbiName)
	self.ccbiName = ccbiName

	self.ccbiTable = {}
	ccb["ccbiTable"] = self.ccbiTable
	local proxy = cc.CCBProxy:create()
    local ccbiRootNode  = CCBReaderLoad(ccbiName, proxy, self.ccbiTable)
    self:addChild(ccbiRootNode)
end

function CCBView:setData(data)
	self.data = data
	if self.data.refreshView then
		self.data.refreshView(self.ccbiTable)
	else
		self:refreshView()
	end
end

function CCBView:setEvent(events)
	for i, v in pairs(events) do
		registerEvent()
	end
	self.eventArray = events
end

function CCBView:handleEvent(evtName)
	for _, event in pairs(self.eventArray) do
		if(event.name == evtName)  then
			event.callback(self.data)
		end
	end
end

--refreshview由自己定义，自由度更大。
--refreshView采用默认的方式，需要将data中的数据映射到cocos2dx的空间中去
function CCBView:refreshView()

end

return CCBView