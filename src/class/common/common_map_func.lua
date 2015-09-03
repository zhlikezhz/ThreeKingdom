local MapCommFunction = {}

MapCommFunction.loadLevelFile = function(filename)
	-- local levelInfo = require(filename)
	printLog(string.format("load level %s", filename))
	local levelInfo = require("class.map.level_001")

	local land_list = levelInfo.map_config.land_list.land
	local prop_list = levelInfo.map_config.prop_list.prop
	local boss_list = levelInfo.map_config.boss_list.boss
	local monster_list = levelInfo.map_config.monster_list.enemy
	local combo_list = levelInfo.map_config.combos.combo
	local land_cfgs = levelInfo.map_config.land_cfgs.land

	local prevType = 0
	local tmxGroupList = {}
	for key, val in ipairs(land_cfgs) do
		if not (prevType == 1 and val.attr.type == 1) then
			table.insert(tmxGroupList, {})
		end
		local tmxMapUnit = {}
		local combo = combo_list[val.combo.attr.index]
		tmxMapUnit.mRate = val.combo.attr.rate
		tmxMapUnit.mFile = land_list[combo.attr.tmx].attr.name
		tmxMapUnit.mLength = combo.attr.length * 64

		tmxMapUnit.mBossList = {}
		if(combo.boss) then
			for idx, cfg in ipairs(combo.boss) do
				local info = {}
				info.mPosx = cfg.attr.posx
				info.mPosy = cfg.attr.posy
				info.mName = boss_list[cfg.attr.id]
				table.insert(tmxMapUnit.mBossList, info)
			end
		end

		tmxMapUnit.mPropList = {}
		if(combo.prop) then
			for idx, cfg in ipairs(combo.prop) do
				local info = {}
				info.mPosx = cfg.attr.posx
				info.mPosy = cfg.attr.posy
				info.mName = prop_list[cfg.attr.id]
				table.insert(tmxMapUnit.mPropList, info)
			end
		end

		tmxMapUnit.mMonsterList = {}
		if(combo.enemy) then
			for idx, cfg in ipairs(combo.enemy) do
				local info = {}
				info.mPosx = cfg.attr.posx
				info.mPosy = cfg.attr.posy
				info.mName = monster_list[cfg.attr.id]
				table.insert(tmxMapUnit.mMonsterList, info)
			end
		end

		local function compFunc(a, b)
			if(a.mPosx == b.mPosx) then 
				return a.mPosy < b.mPosy
			end
			return a.mPosx < b.mPosx
		end
		table.sort(tmxMapUnit.mBossList, compFunc)
		table.sort(tmxMapUnit.mPropList, compFunc)
		table.sort(tmxMapUnit.mMonsterList, compFunc)
		table.insert(tmxGroupList[#tmxGroupList], tmxMapUnit)
		prevType = val.attr.type
	end

	return tmxGroupList 
end

MapCommFunction.loadTmxMap = function(filename)
	printLog(string.format("load tmx %s", filename))
	return ccexp.TMXTiledMap:create(filename)
end


return MapCommFunction