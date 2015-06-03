require("common.utils.Logging")

function callback(str)
	print(str)
end

function main()
	local eventMgr = require("common/modules/EventMgr")
	local eventEnum = require("common/enums/EventEnum")
	local registerID = eventMgr:registerEvent(eventEnum[1], callback)
	logging(registerID)
	registerID = eventMgr:registerEvent(eventEnum[1], callback)
	logging(registerID)
	registerID = eventMgr:registerEvent(eventEnum[1], callback)
	logging(registerID)
	eventMgr:registerEvent(eventEnum[1], callback)

	eventMgr:sendEvent(eventEnum[1], "fsdfsd")
	eventMgr:unregisterEvent(registerID)
	eventMgr:sendEvent(eventEnum[1], "fdsfdfs")
	registerID = eventMgr:registerEvent(eventEnum[1], callback)
	logging(registerID)
end

main()
