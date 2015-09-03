local Map = class("Map")

function Map:ctor()
	self.mRootNode = cc.Node:create()
end

function Map:getRootNode()
	return self.mRootNode
end

function Map:getScreenOnMapPos()
	local pos = {}
	pos.x = self.mRootNode:getPositionX()
	pos.y = self.mRootNode:getPositionY()
	return pos
end

function Map:create()

end

function Map:destroy()

end

function Map:update(df)

end

function Map:pause()

end

function Map:restart()

end

function Map:enter()

end

function Map:exit()

end

return Map