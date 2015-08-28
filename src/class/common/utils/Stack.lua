local Stack = class("Stack")

function Stack:ctor()
	self.stack = {}
	self.stackTopIndex = 0
end

function Stack:push(data)
	table.insert(self.stack, data)
	self.stackTopIndex = self.stackTopIndex + 1
end

function Stack:pop()
	if(self.stackTopIndex > 0) then
		table.remove(self.stack, self.stackTopIndex)
		self.stackTopIndex = self.stackTopIndex - 1
	end
end

function Stack:top()
	local bRet = nil
	if(self.stackTopIndex > 0) then
		bRet = self.stack[self.stackTopIndex]
	end
	return bRet
end

function Stack:empty()
	local bRet = false
	if(self.stackTopIndex == 0) then
		bRet = true
	end
	return bRet
end

function Stack:iterator()
	return ipairs(self.stack)
end

function Stack:size()
	return self.stackTopIndex
end

function Stack:clear()
	self.stack = {}
end

return Stack