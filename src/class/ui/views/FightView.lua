local FightView = class("FightView", require("class.ui.views.BaseView"))

function FightView:ctor()
	self:_init()
end

function FightView:_init()
	local ccsMapName = {
		jumpDownBtn		=		"left_down.Button_1", -- 先下跳按钮
		jumpUpBtn		=		"right_down.Button_2", -- 向上跳按钮
		pauseBtn		=		"right_up.Button_3", -- 暂停按钮
	}
	local ccsFileName = "res/images/views/FightLayer/FightLayer.csb"
	local view = commfunc.loadCCSFile(ccsFileName, ccsMapName)
	view.pauseBtn:setClickedFunc(handler(self, self._onPause))
	view.jumpUpBtn:setClickedFunc(handler(self, self._onJumpUp))
	view.jumpDownBtn:setClickedFunc(handler(self, self._onJumpDown))
	self:addChild(view.panel)
end

function FightView:_onPause()

end

function FightView:_onJumpUp()
	
end

function FightView:_onJumpDown()

end


return FightView