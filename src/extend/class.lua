function setmetaclass(t, index)
    if type(t) == "userdata" then
        local peer = tolua.getpeer(t)
        if not peer then
            peer = {}
            tolua.setpeer(t, peer)
        end
        setmetaclass(peer, index)
    else
        local mt = getmetatable(t)
        if not mt then mt = {} end
        if not mt.__index then
            mt.__index = index
            setmetatable(t, mt)
        elseif mt.__index ~= index then
            local oldIndex = mt.__index
            mt.__index = index
            setmetatable(index, { __index = oldIndex})
            setmetatable(t, mt)
        end
    end
end

function class(name, super)
	local class_type = {}
	class_type.__super = super
	class_type.__cname = name
	class_type.__ctype = 2
	class_type.ctor = false
	class_type.new = function(...)
		local obj = {}
		printLog(self)
		
		do
			local create
			create = function(c, ...)
				if c.__super then
					create(c.__super, ...)
				end

				if c[".isclass"] then
					obj = c:create()
				elseif c.ctor then
					setmetaclass(obj, c)
					c.ctor(obj, ...)
				end
			end

			create(class_type, ...)
		end

		setmetaclass(obj, class_type)
		return obj
	end
	return class_type
end
