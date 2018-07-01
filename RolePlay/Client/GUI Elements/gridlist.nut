
class Gui.GridList
{
    constructor(_x , _y, _w, _h, _bgTexture, _hoverTexture, _textureScrollBg, _textureScrollPointer, _textureScrollAdd, _textureScrollMinus)
    {
        gui = {};
        list = [];
        _w -= anx(40);
        isVisible = false;
        gui.bg <- Texture(_x , _y, _w, _h, _bgTexture);
        gui.hover <- Texture(_x , _y, _w-30, drawHeight("FONT_OLD_10_WHITE_HI.TGA")+anx(4), _hoverTexture);

        scroll = Gui.ScrollBar(_x + _w + anx(5), _y, anx(35), _h, _textureScrollBg, _textureScrollPointer, _textureScrollAdd, _textureScrollMinus, SCROLL.VERTICAL, 1)
        
        local _this = this;
        addEventHandler("onScrollBar", function(instance, val){ _this.scrollBar(instance, val) });
        addEventHandler("onMouseClick", function(btn){ _this.clickMouse(btn) });
    }

    function addColumn(name, size)
    {
        local pos = gui.bg.getPosition();
        local width = 0;
        foreach(_list in list)
            width += _list.width;

        local draw = Draw(pos.x + anx(4+width), pos.y+ any(4), name);
        list.append({column = draw, width = size, subList = [], row = [], identify = 0}); 

        return list.len()-1;
    }

    function addRow(id, text)
    {
        local posX;
        local posY = list[id].column.getPositionPx().y + drawHeightPx("FONT_OLD_10_WHITE_HI.TGA") + 8;

        local len = list[id].subList.len();
        if(len > 0)
            posY = list[id].subList[len-1].getPositionPx().y + drawHeightPx("FONT_OLD_10_WHITE_HI.TGA") + 4;

        if(posY + drawHeightPx("FONT_OLD_10_WHITE_HI.TGA") + 4 < gui.bg.getPositionPx().y + gui.bg.getSizePx().height)
        {
            posX = list[id].column.getPositionPx().x;

            local _draw = Draw(anx(posX), any(posY), cutString(text, list[id].width)); 
            list[id].subList.append(_draw);

            if(isVisible)
                list[id].subList[len].visible = true;
        }
        else
        {
            if(id == 0)
                scroll.changeMaxValue(scroll.dimension.maxList + 1);
        }
        
        local idRow = list[id].row.len();
        list[id].row.append({name = cutString(text, list[id].width), uid = list[id].identify});//, uid = list[id].row.len()-1}
        list[id].identify += 1;

        return list[id].identify-1;//wrong
    
        /*
            foreach(v, _row in list)
            {
                foreach(_list in list[v].row)
                    print(_list.name);
            }
        */
    }

    function renameRow(columnId, uidRow, text)
    {
        foreach(i, _list in list[columnId].row)
        {
            if(_list.uid == uidRow)
            {
                _list.name = text;
                list[columnId].subList[i].text = text;  
            }
        }  
    }

    function removeRow(columnId, uidRow)
    {
        foreach(i, _row in list[columnId].row)
        {
            if(_row.uid == uidRow)
                list[columnId].row.remove(i);
        }

        if(columnId == 0)
        {
            if(scroll.dimension.maxList > 0) 
                --scroll.dimension.maxList;
            if(scroll.dimension.list > scroll.dimension.maxList) 
                scroll.dimension.list = scroll.dimension.maxList;
        }

        local posY = list[columnId].column.getPositionPx().y + drawHeightPx("FONT_OLD_10_WHITE_HI.TGA") + 8;

        foreach(i, _row in list[columnId].subList)
        {
            if(i + scroll.dimension.list < list[columnId].row.len())
            {
                _row.text = list[columnId].row[i + scroll.dimension.list].name;
                _row.setPositionPx(list[columnId].column.getPositionPx().x, posY);

                posY += drawHeightPx("FONT_OLD_10_WHITE_HI.TGA") + 4;
            }else
            {
                list[columnId].subList.remove(i);
            }
        }    
    }

    function removeAllRow()
    {
        //list = null;        
        foreach(i, _list in list)
        {
            list[i].row = [];
            list[i].subList = [];
            list[i].identify = 0;
        }

        scroll.dimension.list = 0;
        scroll.dimension.maxList = 0;
    }

    function setPositionPx(x, y)
    {
        gui.bg.setPositionPx(x, y);
        scroll.setPositionPx(x+ gui.bg.getSizePx().width+5,  y)     
        
        local width = 0;
        foreach(id, _list in list)
        {
            _list.column.setPositionPx(gui.bg.getPositionPx().x + width + 4, gui.bg.getPositionPx().y + 4)
            local posX = _list.column.getPositionPx().x;
            local posY = _list.column.getPositionPx().y + drawHeightPx("FONT_OLD_10_WHITE_HI.TGA") + 8;
            width += _list.width;

            foreach(i, _row in list[id].subList)
            {
                _row.setPositionPx(posX, posY);
                 local len = list[id].subList.len()
                posY = list[id].subList[i].getPositionPx().y + drawHeightPx("FONT_OLD_10_WHITE_HI.TGA") + 4;
            }
        } 
    }

    function setPosition(x, y)
    {
        this.setPositionPx(nax(x), nay(y));
    }

    function getPositionPx()
    {
        return gui.bg.getPositionPx();
    }

    function getPosition()
    {
        return gui.bg.getPosition();
    }

    function getSizePx()
    {
        local size = scroll.bg.getSizePx();
        return {width = size.width+40, height = size.height};
    }

    function getSize()
    {
        local size = scroll.bg.getSize();
        return {width = size.width+anx(40), height = size.height};
    }

    function hover()
    {
        if(isVisible && active)
        {

            local pos = gui.bg.getPositionPx();
            local size = gui.bg.getSizePx(); 
            local cur = getCursorPositionPx();
            if(cur.x >= pos.x && cur.x <= pos.x + size.width && cur.y >= pos.y && cur.y <= pos.y + size.height)
            {
                foreach(id, _row in list[0].subList)
                {
                    local drawPos = _row.getPositionPx();
                    if(cur.x >= pos.x && cur.x <= pos.x + size.width && cur.y >= drawPos.y-2 && cur.y <= drawPos.y + _row.heightPx + 2)
                    {
                        gui.hover.setPositionPx(pos.x, drawPos.y);
                        gui.hover.setSizePx(size.width, drawHeightPx("FONT_OLD_10_WHITE_HI.TGA")+4);
                        gui.hover.visible = isVisible;
                        break;
                    }
                }
            }else
                gui.hover.visible = false;
        }
    }

    function setVisible(bool)
    {
        isVisible = bool;
        //foreach(_gui in gui)
        gui.hover.visible = false;
        gui.bg.visible = bool;

        foreach(i, _list in list)
        {
            _list.column.visible = bool;

            foreach(_row in list[i].subList)
                _row.visible = bool;
        }

        scroll.setVisible(bool);
        scroll.active = bool;
        scroll.wheelActive = bool
    }

    function top()
    {
        gui.bg.visible = bool;

        foreach(i, _list in list)
        {
            _list.column.top();

            foreach(_row in list[i].subList)
                _row.top();
        }

        gui.hover.top();
        scroll.top();
    }

    function scrollBar(instance, val)
    {
        if(isVisible && active)
        {
            if(instance == scroll && active)
            {
                foreach(i, _list in list)
                {
                    foreach(id, _row in list[i].subList)
                    {
                        if(id + val < list[i].row.len())
                            _row.text = list[i].row[id+val].name;
                    }
                }
            }
        }
    }

    function clickMouse(btn)
    {
        if(isVisible && active && list.len() > 0)
        {
            foreach(id, _row in list[0].subList)
            {
                local cur = getCursorPositionPx();
                local drawPos = _row.getPositionPx();
                local pos = gui.bg.getPositionPx();
                local size = gui.bg.getSizePx();
                if(cur.x >= pos.x && cur.x <= pos.x + size.width && cur.y >= drawPos.y-2 && cur.y <= drawPos.y + _row.heightPx + 2)
                {
                    callEvent("onGridList", this, list[0].row[id+scroll.dimension.list].uid);
                }
            }
        }
    }

    gui = null;
    scroll = null;
    list = null;
    
    active = false;
    isVisible = false;
}

/*
local selectlist = Gui.GridList(anx(600) , any(100), anx(640) , any(600), "DLG_CONVERSATION.TGA", "DLG_CONVERSATION.TGA", "DLG_CONVERSATION.TGA", "BAR_HEALTH.TGA", "O.TGA", "U.TGA")
selectlist.active = true;
local name = selectlist.addColumn("Name", 180)
local status = selectlist.addColumn("Status", 200)
local x = selectlist.addColumn("X", 50)
local y = selectlist.addColumn("Y", 50)
local z = selectlist.addColumn("Z", 50)
local angle = selectlist.addColumn("Angle", 70)


for(local i = 0; i < 70; i++)
{
	selectlist.addRow(name, i+"row")
	selectlist.addRow(status, "-")
	selectlist.addRow(x, "-")
	selectlist.addRow(y, "-")
	selectlist.addRow(z, "-")
	selectlist.addRow(angle, "-")
}

selectlist.setPositionPx(833, 300)


addEventHandler("onInit", function()
{
    selectlist.setVisible(true);
});

addEventHandler("onRender", function()
{
    selectlist.hover();
});

addEventHandler("onCommand", function(cmd, params)
{
    if(cmd == "add")
    {
		selectlist.addRow(name, "name")
		selectlist.addRow(status, "-")
		selectlist.addRow(x, "-")
		selectlist.addRow(y, "-")
		selectlist.addRow(z, "-")
		selectlist.addRow(angle, "-")     
    }
});

addEventHandler("onGridList", function(instance, val)
{
    if(instance == selectlist)
    {
        Chat.print(255, 0, 255, "ID Grid: "+val)
        selectlist.removeRow(name, val)
		selectlist.removeRow(status, val)
		selectlist.removeRow(x, val)
		selectlist.removeRow(y, val)
		selectlist.removeRow(z, val)
		selectlist.removeRow(angle, val)
    }
});
onGridList(instance, rowUID)//check column about '0' id
//

Gui.GridList(_x , _y, _w(final width _w -40px(scroll)), _h, _bgTexture, _hoverTexture, _textureScrollBg, _textureScrollPointer, _textureScrollAdd, _textureScrollMinus)
local column1 = Gui.GridList.addColumn(string title, int width(px))
local rowUid = Gui.GridList.addRow(column1, text)
Gui.GridList.renameRow(column1, rowUid, text)
Gui.GridList.removeRow(column1, rowUid)
Gui.GridList.getSizePx()
Gui.GridList.getSize()
Gui.GridList.setPositionPx(x, y)
Gui.GridList.setPosition(x, y)
Gui.GridList.getPogitionPx()
Gui.GridList.getPosition()
Gui.GridList.setVisible(bool)
Gui.GridList.active = bool;
*/