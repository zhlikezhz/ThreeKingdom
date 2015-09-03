local Vector = class("Vector")

function Vector:ctor()
	self.size = 0
	self.data = {}
end

function Vector:insert(idx, data)
	if(0 < idx and idx <= self.size + 1) then 
		table.insert(self.data, idx, data)
		self.size = self.size + 1
	end
end

function Vector:pushBack(data)
	table.insert(self.data, data)
	self.size = self.size + 1
end

function Vector:popBack()
	if(0 < idx and idx <= self.size) then 
		table.remove(self.data, self.size)
		self.size = self.size - 1
	end
end

function Vector:erase(idx)
	if(0 < idx and idx <= self.size) then 
		table.remove(self.data, idx)
		self.size = self.size - 1
	end
end

function Vector:clear()
	self.data = {}
end

function Vector:size()
	return self.size
end

function Vector:iterator()
	return ipairs(self.data)
end

function Vector:find(data)
	local bRet = 0
	for idx, val in self:iterator() do
		if(val == data) then
			bRet = idx
			break
		end
	end
	return bRet
end

function Vector:sort(sortFunc)
	if type(sortFunc) == "function" do
		table.sort(self.data, sortFunc)
	end
end

return Vector