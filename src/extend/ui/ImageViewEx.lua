local WidgetEx = require "ui_extend.WidgetEx"

local ImageViewEx = clone(WidgetEx)

-- --设置卡牌方框小头�?

local function setHeadIcon(self,types,cardID,scale,icolor,isShowLevel,isShowStar)
    cclog("--------------cardID-------------",cardID)

    self:removeAllChildren(true)
    self:loadTexture("images/HeadIcon/ui_head_cover.png")
    self:setCascadeOpacityEnabled(true)

    scale = scale or 1
    self:setScale(scale)

    local color = 1
    local star = 1
    local level = 1
    local GameItem = require "ppdata.GameItem"
    local file = GameItem.getIcon(types, cardID)
    local data = GameItem.getData(types, cardID)
    if(types == 2) then
        color = data.color
        --file = string.format("hero/%s.png", data.icon)
    elseif(types == 3) then
        color = data.color
        --file = string.format("hero/%s.png", data.icon)
    elseif(types == 4) then
        color = data.color
        --file = string.format("hero/%s.png", data.icon)
    elseif(types == 5 or types == 6) then
        local starData = card_xml_data(cardID, "star")
        if  ppdata.Heros:isHeroExist(cardID) == false then
            color = data.init_color
            star = data.init_star
            level = data.init_level
        else
            color = ppdata.Heros:getHero(cardID):getColor()
            star = ppdata.Heros:getHero(cardID):getStar()
            level = ppdata.Heros:getHero(cardID):getLevel()
        end
        file = string.format("images/HeroFace/face_%s_%02d.png",
            data.card_res, starData[star].bone_style_number)
    elseif(types == 7) then
        local _,lead_id = ppdata.Heros:getLeadHero()
        local starData = card_xml_data(lead_id, "star")
        color = ppdata.Heros:getHero(lead_id):getColor()
        star = ppdata.Heros:getHero(lead_id):getStar()
        level = ppdata.Heros:getHero(lead_id):getLevel()
        file = string.format("hero/HeroFace/face_%s_%02d.png",
            data.card_res, starData[star].bone_style_number)
    elseif((types >= 8 and types <= 16) or types == 20) then
        --file = string.format("hero/%s.png", data.icon)
    end

    icolor = icolor or color
    local kuangIcon = card_frame_xml_data(icolor).face_frame
    local kuang = ccui.ImageView:create()
    local kuangFile = string.format("images/HeadIcon/%s.png",kuangIcon)
    if(types == 6 or types == 7)then kuangFile = "images/HeadIcon/common_item_22.png" end
    kuang:loadTexture(kuangFile)
    self:addChild(kuang)

    local head = ccui.ImageView:create()
    head:loadTexture(file)
    self:addChild(head)

    local size = self:getContentSize()
    head:setPosition(size.width/2, size.height/2)
    kuang:setPosition(size.width/2, size.height/2)

    if(isShowLevel)then
        local levelTip = ccui.TextAtlas:create("" .. level,"ui_main/fonts_number_1.png",16,25,".")
        levelTip:setAnchorPoint(cc.p(1,1))
        levelTip:setPosition(cc.p(self:getContentSize().width - 5,self:getContentSize().height - 5))
        self:addChild(levelTip,10)
    end

    if(isShowStar)then
        for j = 1,star do
            local sp = extend(ccui.ImageView:create())
            sp:setImage("ui_main/team_17.png")
            sp:setScale(1/scale)
            sp:setPosition(cc.p(j * 24 - 17,4))
            self:addChild(sp)
        end
    end
end

local function setMonsterIcon(self,info,scale)
    self:removeAllChildren(true)
    self:loadTexture("images/HeadIcon/ui_head_cover.png")

    scale = scale or 1

    local file = nil
    local is_boss = info[2]
    if is_boss then
        file = boss_xml_data(info[1], "image")
        scale = scale * 1.2

        local sp = ccui.ImageView:create()
        sp:loadTexture("ui_main/chapter_2.png")
        sp:setScale(1/scale)
        sp:setPosition(cc.p(36,100))
        self:addChild(sp,1)
    else
        file = monster_xml_data(info[1], "image")
    end
    file = string.format("images/ChapterIcon/%s.png", file)

    self:setScale(scale)

    local color = info[5]
    color = color or 1
    local kuangIcon = card_frame_xml_data(color).face_frame
    local kuang = ccui.ImageView:create()
    kuang:loadTexture(string.format("images/HeadIcon/%s.png",kuangIcon))
    self:addChild(kuang)

    local head = ccui.ImageView:create()
    head:loadTexture(file)
    self:addChild(head)

    local size = self:getContentSize()
    head:setPosition(size.width/2, size.height/2)
    kuang:setPosition(size.width/2, size.height/2)
end

function ImageViewEx:setHeadIconWithClickTip(types,cardID,scale,icolor,isShowLevel,isShowStar)
    setHeadIcon(self,types,cardID,scale,icolor,isShowLevel,isShowStar)

    local function func(sender,type)
        if(type == ccui.TouchEventType.ended) then
            local CardInfoTip = require "game.CardInfoTip"
            if(types == 5)then
                CardInfoTip:showHero(cardID,"click")
            else
                CardInfoTip:showItem(types,cardID,"click")
            end
        end
    end
    self:setTouchEnabled(true)
    self:addTouchEventListener(func)
end

function ImageViewEx:setHeadIconWithTip(types,cardID,scale,icolor,isShowLevel,isShowStar)
    setHeadIcon(self,types,cardID,scale,icolor,isShowLevel,isShowStar)

    local function func(sender,type)
        local CardInfoTip = require "game.CardInfoTip"
        if(type == ccui.TouchEventType.ended or type == ccui.TouchEventType.canceled) then
            CardInfoTip.close()
        elseif(type == ccui.TouchEventType.began)then
            local x,y = self:getPosition()
            local size = self:getContentSize()
            local button_center_pos = self:convertToWorldSpace({x = 0.5 * size.width, y = 0.5 * size.height})
            if(types == 5)then
                CardInfoTip:showHero(cardID,"press",button_center_pos)
            else
                CardInfoTip:showItem(types,cardID,"press",button_center_pos)
            end
        end
    end
    self:setTouchEnabled(true)
    self:addTouchEventListener(func)
end

function ImageViewEx:setHeadIcon(types,cardID,scale,icolor,isShowLevel,isShowStar)
    setHeadIcon(self,types,cardID,scale,icolor,isShowLevel,isShowStar)
end


function ImageViewEx:setSkillIcon(skillID,scale,isGray)
    local skillData = skill_xml_data(skillID)

    self:removeAllChildren(true)
    self:loadTexture("ui_main/ui_skill_cover2.png")

    scale = scale or 1
    self:setScale(scale)

    local cover = ccui.ImageView:create()

    cover:loadTexture("ui_main/ui_skill_cover.png")
    cover:setPosition(cc.p(1,-3))
    cover:setScale(0.65)
    self:addChild(cover)


    local skillSprite = MyCCGraySprite:create(string.format("images/skill/%s.png", skillData.skill_image))
    local skill = tolua.cast(skillSprite,"cc.Sprite")
    skill:setPosition(cc.p(6,-2))
    skill:setScale(0.75)
    self:addChild(skill,1)
    if(isGray)then
        skillSprite:setGray(true)
    end

    local skillKuangSprite = MyCCGraySprite:create("ui_main/hero_50.png")
    local skillKuang = tolua.cast(skillKuangSprite,"cc.Sprite")
    skillKuang:setAnchorPoint(cc.p(0.0, 0.0))
    skillKuang:setPosition(cc.p(6, -5))
    skillKuang:setScale(1.3)
    self:addChild(skillKuang,1)
    if(isGray)then
        skillKuangSprite:setGray(true)
    end

    local size = self:getContentSize()
    cover:setPosition(size.width/2 + 1, size.height/2 - 3)
    skill:setPosition(size.width/2 + 6, size.height/2 - 2)
end

function ImageViewEx:setSkillIcon2(skillID,scale,isGray)
    local skillData = skill_xml_data(skillID)

    self:removeAllChildren(true)
    self:loadTexture("ui_main/ui_skill_cover2.png")

    scale = scale or 1
    self:setScale(scale)

    local cover = ccui.ImageView:create()
    cover:loadTexture("ui_main/ui_skill_cover.png")
    cover:setPosition(cc.p(1,-3))
    cover:setScale(0.65)
    self:addChild(cover)

    local skillSprite = MyCCGraySprite:create(string.format("images/skill/%s.png", skillData.skill_image))
    local skill = tolua.cast(skillSprite,"cc.Sprite")
    skill:setPosition(cc.p(6,-2))
    skill:setScale(0.75)
    self:addChild(skill,1)
    if(isGray)then
        skillSprite:setGray(true)
    end

    local skillKuangSprite = MyCCGraySprite:create("ui_main/hero_50.png")
    local skillKuang = tolua.cast(skillKuangSprite,"cc.Sprite")
    skillKuang:setAnchorPoint(cc.p(0.0, 0.0))
    skillKuang:setPosition(cc.p(6, -5))
    skillKuang:setScale(1.3)
    self:addChild(skillKuang,1)
    if(isGray)then
        skillKuangSprite:setGray(true)
    end

    local size = self:getContentSize()
    cover:setPosition(size.width/2 - 11, size.height/2 - 22)
    skill:setPosition(size.width/2 - 9, size.height/2 - 22)
end

function ImageViewEx:setMonsterIcon(info,scale)
    setMonsterIcon(self,info,scale)
end

function ImageViewEx:setMonsterIconWithTip(info,scale)
    setMonsterIcon(self,info,scale)

    local function func(sender,type)
        local CardInfoTip = require "game.CardInfoTip"
        if(type == ccui.TouchEventType.ended or type == ccui.TouchEventType.canceled) then
            CardInfoTip.close()
        elseif(type == ccui.TouchEventType.began)then
            local x,y = self:getPosition()
            local size = self:getContentSize()
            local button_center_pos = self:convertToWorldSpace({x = 0.5 * size.width, y = 0.5 * size.height})
            CardInfoTip:showMonster(info,"press",button_center_pos)
        end
    end
    self:setTouchEnabled(true)
    self:addTouchEventListener(func)
end

function ImageViewEx:setHorseIcon()
    self:removeAllChildren(true)
    self:loadTexture("images/HeadIcon/ui_head_cover.png")

    self:setScale(0.7)

    local kuangIcon = card_frame_xml_data(1).face_frame
    local kuang = ccui.ImageView:create()
    kuang:loadTexture(string.format("images/HeadIcon/%s.png",kuangIcon))
    self:addChild(kuang)

    local head = ccui.ImageView:create()
    head:loadTexture("ui_main/chapter_enemy_15.png")
    self:addChild(head)

    local size = self:getContentSize()
    head:setPosition(size.width/2, size.height/2)
    kuang:setPosition(size.width/2, size.height/2)

    local function func(sender,type)
        local CardInfoTip = require "game.CardInfoTip"
        if(type == ccui.TouchEventType.ended or type == ccui.TouchEventType.canceled) then
            CardInfoTip.close()
        elseif(type == ccui.TouchEventType.began)then
            local x,y = self:getPosition()
            local size = self:getContentSize()
            local button_center_pos = self:convertToWorldSpace({x = 0.5 * size.width, y = 0.5 * size.height})
            CardInfoTip:showHorse(button_center_pos)
        end
    end
    self:setTouchEnabled(true)
    self:addTouchEventListener(func)
end

--设置卡牌方框小头�?
function ImageViewEx:setEmenyIcon(cardID,scale)
    cclog("--------------cardID-------------",cardID)

    self:removeAllChildren(true)
    self:loadTexture("images/HeadIcon/ui_head_cover.png")

    scale = scale or 1
    self:setScale(scale)

    local mainData = card_xml_data(cardID,"main")
    local starData = card_xml_data(cardID,"star")
    local file = string.format("hero/face_%s_%02d.png",mainData.card_res,starData[1].bone_style_number)
    local color = 1

    local kuangIcon = card_frame_xml_data(color).face_frame
    local kuang = ccui.ImageView:create()
    kuang:loadTexture(string.format("images/HeadIcon/%s.png",kuangIcon))
    self:addChild(kuang)

    local head = ccui.ImageView:create()
    head:loadTexture(file)
    self:addChild(head)

    local size = self:getContentSize()
    head:setPosition(size.width/2, size.height/2)
    kuang:setPosition(size.width/2, size.height/2)
end

--设置卡牌全身�?
function ImageViewEx:setBodyIcon(cardID,scale,types)
    local serverData = {}
    if(types == "init") then
        local info = card_xml_data(cardID)
        serverData.m_iColor = info.init_color
        serverData.m_iStar = info.init_star
        serverData.m_iLevel = info.init_level
    else
        serverData = ppdata.Heros:getHero(cardID)
    end
    local mainData = card_xml_data(cardID,"main")
    local starData = card_xml_data(cardID,"star")
    local icon = card_frame_xml_data(serverData.m_iColor).card_frame

    self:removeAllChildren(true)
    self:loadTexture(string.format("ui_main/%s.png", icon))

    scale = scale or 1
    self:setScale(scale)

    local head = ccui.ImageView:create()
    head:loadTexture(string.format("hero/card_%s_%02d.png",mainData.card_res,starData[serverData.m_iStar].bone_style_number))

    head:setPosition(cc.p(self:getContentSize().width/2,self:getContentSize().height/2))
    self:addChild(head)

    local job = ccui.ImageView:create()
    local jobFile = string.format("ui_main/ui-card-0%s.png",mainData.card_job)
    job:loadTexture(jobFile)
    job:setPosition(cc.p(290,366))
    self:addChild(job,1)

    local levelAtlas = ccui.TextAtlas:create()
    levelAtlas:setProperty("" .. serverData.m_iLevel,"ui_main/main_number_card.png", 26, 32, "0")
    levelAtlas:setPosition(cc.p(48,45))
    self:addChild(levelAtlas,1)
end

--设置图片�?
function ImageViewEx:setImage(fileName)
    self:loadTexture(fileName)
end


return ImageViewEx