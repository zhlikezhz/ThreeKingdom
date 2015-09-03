local mapCommFunc = require("class.map.mapCommFunction")
local TmxMap = class("TmxMap", require("class.map.Map"))
local TmxMapStateEnum = {"init", "pause", "run",}


function TmxMap:ctor(tmxMapFile)
	self.mTmxMapFile = tmxMapFile
	self:_init()
end

function TmxMap:_init()
	self.mTmxIndex = 1
	self.mTmxGroupIndex = 1
	self.mTmxTotalLength = 0
	self.mIsJumpOutCurrTmxGroup = false
	self.mState = TmxMapStateEnum[1]
	self.mTmxGroupList = mapCommFunc.loadLevelFile(self.mTmxMapFile)
end

function TmxMap:create()
	return TmxMap.new()
end

function TmxMap:destory()
	
end

function TmxMap:update(df)
	-- init
	if(self.mState == TmxMapStateEnum[1]) then

	-- pause
	elseif(self.mState == TmxMapStateEnum[2]) then

	-- run
	elseif(self.mState == TmxMapStateEnum[3]) then
		self:_scrollTmx()
		self:_updateTmx()
		self:_createEnemy()
	end
end

function TmxMap:pause()
	self.mState = TmxMapStateEnum[2]
end

function TmxMap:restart()
	self.mState = TmxMapStateEnum[3]
end

function TmxMap:enter()
	self.mState = TmxMapStateEnum[3]
	for i, tmxGroup in pairs(self.mTmxGroupList) do
		for i, tmxUnit in pairs(tmxGroup) do
			-- tmxUnit.mTmx = mapCommFunc.loadTmxMap(tmxUnit.mFile)
			-- tmxUnit.mTmx.retain()
		end
	end

	self.mFirstTmxOnScreen = self:_getNextTmx()
	self.mSecondTmxOnScreen = self:_getNextTmx()
	self:_addTmx2Screen(self.mFirstTmxOnScreen)
	self:_addTmx2Screen(self.mSecondTmxOnScreen)
	self.mRootNode:scheduleUpdate(handler(self, self.update))
end

function TmxMap:exit()
	-- for i, tmxGroup in pairs(self.mTmxGroupList) do
	-- 	for i, tmxUnit in pairs(tmxGroup) do
			-- tmxUnit.mTmx.release()
	-- 	end
	-- end
end

function TmxMap:_scrollTmx()
	local pos = self:getScreenOnMapPos()
	self.mRootNode:setPosition(pos.x - 10, pos.y)
end

function TmxMap:_updateTmx()
	local off = {x = 100, y = 0}
	local screenSize = {width = 960, height = 640}
	local screenOnMapPos = self:getScreenOnMapPos()
	if(-screenOnMapPos.x + screenSize.width + off.x > self.mTmxTotalLength) then
		if(self.mFirstTmxOnScreen ~= nil) then
			self.mRootNode:removeChild(self.mFirstTmxOnScreen.mTmx)
			self.mFirstTmxOnScreen = self.mSecondTmxOnScreen
			self.mSecondTmxOnScreen = self:_getNextTmx()
			self:_addTmx2Screen(self.mSecondTmxOnScreen)
		end
	end

	if(screenOnMapPos.x + screenSize.width + off.x > self.mTmxTotalLength) then
		pringLog("Tmx map run finish!!!")
		EventMgr:sendEvent(EventMgr[1])
	end
end

function TmxMap:_getNextTmx()
	local tmxGroupSize = #(self.mTmxGroupList)
	if(self.mTmxGroupIndex > tmxGroupSize) then
		return nil
	end

	local tmxSize = #(self.mTmxGroupList[self.mTmxGroupIndex])
	if(self.mTmxIndex > tmxSize) then
		self.mTmxIndex = 1
		self.mTmxGroupIndex = self.mTmxGroupIndex + 1
		return self:_getNextTmx()
	end

	self.mTmxIndex = self.mTmxIndex + 1
	return self.mTmxGroupList[self.mTmxGroupIndex][self.mTmxIndex - 1]
end

function TmxMap:_addTmx2Screen(tmxUnit)
	if(tmxUnit == nil) then 
		printLog("tmxUnit is nil!!!!")
		return 
	end

	tmxUnit.mTmx = mapCommFunc.loadTmxMap(tmxUnit.mFile)
	self.mRootNode:addChild(tmxUnit.mTmx)
	tmxUnit.mTmx:setPosition(cc.p(self.mTmxTotalLength, 0))
	self.mTmxTotalLength = self.mTmxTotalLength + tmxUnit.mLength
end

function TmxMap:_createEnemy()

end

return TmxMap