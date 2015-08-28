local CCBTest = class("CCBTest", cc.Layer)

function CCBTest:ctor(filename)
	self:initWithFile(filename)
end

function CCBTest:create()
	return CCBTest.new()
end

function CCBTest:initWithFile(filename)
	local GuildChatCell = {}
	ccb["GuildChatCell"] = GuildChatCell

	local proxy = cc.CCBProxy:create()
    local node  = CCBReaderLoad(filename, proxy, GuildChatCell)
    self:addChild(node)

    node.m_pName = GuildChatCell.m_pName
    node.m_pText = GuildChatCell.m_pText
    node.m_pEmotion = GuildChatCell.m_pEmotion
    node.m_pTimeBg = GuildChatCell.m_pTimeBg
    node.m_pTimeLabel = GuildChatCell.m_pTimeLabel
    node.m_pRewardsDivider = GuildChatCell.m_pRewardsDivider

    node.m_pName:setVisible(false)
    node.m_pText:setVisible(false)
    node.m_pEmotion:setVisible(false)
    node.m_pTimeBg:setVisible(false)
    node.m_pRewardsDivider:setVisible(false)

    -- local sprite = cc.Sprite:create("i6/ui/common/divider.png")
    -- node:addChild(sprite, 100)

  
end

return CCBTest
