local TableViewTest = class("TableViewTest", cc.Node)


function TableViewTest:ctor()
	self:init()
end


function TableViewTest:init()

	-- local listView = ccui.ListView:create()
	local listView = ccui.ScrollView:create()
    listView:setDirection(ccui.ScrollViewDir.vertical)
    listView:setBounceEnabled(true)
	listView:setPosition(cc.p(300, 100))
    listView:setContentSize(cc.size(400, 300))
    listView:setBounceEnabled(true)
    self:addChild(listView)

    for i = 1, 15 do
    	local image = ccui.ImageView:create()
    	image:loadTexture("i6/ui/common/divider.png")
    	image:setPosition(cc.p(0, i * 30))
        image:setScaleX(4)

        local texture = image:getVirtualRenderer():getSprite():getTexture()
        texture:setAliasTexParameters()

    	listView:addChild(image)
    end
    listView:setInnerContainerSize(cc.size(400, 500))                
    listView:jumpToTop()



	-- local tableView = cc.TableView:create(cc.size(500, 700))
	-- tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	-- tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	-- tableView:setPosition(cc.p(450, 0))
	-- tableView:setDelegate()

	-- tableView:registerScriptHandler(TableViewTest.numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
 --    -- tableView:registerScriptHandler(TableViewTest.scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
 --    -- tableView:registerScriptHandler(TableViewTest.scrollViewDidZoom, cc.SCROLLVIEW_SCRIPT_ZOOM)
 --    -- tableView:registerScriptHandler(TableViewTest.tableCellTouched, cc.TABLECELL_TOUCHED)
 --    tableView:registerScriptHandler(TableViewTest.cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
 --    tableView:registerScriptHandler(TableViewTest.tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
 --    tableView:reloadData()

	-- self:addChild(tableView)

end

function TableViewTest.cellSizeForTable(table, idx) 
    return 60, 60
end

function TableViewTest.numberOfCellsInTableView(table)
	return 25
end

function TableViewTest.tableCellAtIndex(table, idx)
	local strValue = string.format("%d", idx)
    local cell = table:dequeueCell()
    if nil == cell then
    	cell = cc.TableViewCell:new()
    	-- local image = ccui.ImageView:create()
     --    image:loadTexture("i6/ui/common/divider.png")
    	-- image:setPosition(cc.p(450, 100 + i * 30))
    	local sprite = cc.Sprite:create("i6/ui/common/divider.png")
    	sprite:setScaleY(0.3)
    	sprite:setScaleX(4)
        cell:addChild(sprite)
    end
    return cell
end


return TableViewTest