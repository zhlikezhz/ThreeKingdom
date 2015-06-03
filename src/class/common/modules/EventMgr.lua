local EventMgr = {}

function EventMgr:init()
	self.registerMap = {}
	local eventEnum = require("common/enums/EventEnum")
	for key, val in pairs(eventEnum) do
		self.registerMap[val] = {}
	end
end

function EventMgr:registerEvent(eventID, callfunc)
	assert(type(eventID) == "string" and self.registerMap[eventID] ~= nil,
		string.format("EventMgr: eventID(%s) not exist!", eventID))

	local registerID = {}
	registerID.eventID = eventID
	table.insert(self.registerMap[eventID], {callfunc})
	registerID.idx = #self.registerMap[eventID]
	return registerID
end

function EventMgr:unregisterEvent(registerID)
	assert(type(registerID) == "table" and registerID.idx > 0, 
		"EventMgr: registerID not exist!")

	self.registerMap[registerID.eventID][registerID.idx] = nil
end

function EventMgr:sendEvent(eventID, ...)
	assert(type(eventID) == "string" and self.registerMap[eventID] ~= nil,
		string.format("EventMgr: eventID(%s) not exist!", eventID))

	for i, v in pairs(self.registerMap[eventID]) do
		v[1](...)
	end
end

EventMgr:init()

return EventMgr


























