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
	self.refreshView()
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
			self.refreshView()
		end
	end
end

function CCBView:refreshView()

end

return CCBView