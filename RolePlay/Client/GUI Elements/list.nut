
class Gui.List
{
    constructor(_x, _y, _font, ...)
    {
        list = [];
        active = true;
        isVisible = false;
        local sizeFont = drawHeight(_font);
        foreach(i, _item in vargv)
        {
            list.append({id = _item.id, draw = Draw(_x, _y, _item.name), color = [255, 255, 255]})
            list[i].draw.font = _font;
            _y += sizeFont + any(3);
        }

        local _this = this;
        addEventHandler("onClick", function(btn, type){ _this.mouseClick(btn, type) });
    }

    function getPosition()
    {
        return list[0].draw.getPosition();
    }

    function getPositionPx()
    {
        return list[0].draw.getPositionPx();
    }

    function setPosition(_x, _y)
    {
        local sizeFont = drawHeight(list[0].draw.font);
        foreach(i, _list in list)
        {
            _list.draw.setPosition(_x, _y);
            _y += sizeFont + any(3);
        }      
    } 

    function setPositionPx(_x, _y)
    {
        local sizeFont = drawHeightPx(list[0].draw.font);
        foreach(i, _list in list)
        {
            _list.draw.setPositionPx(_x, _y);
            _y += sizeFont + 3;
        }      
    }

    function getSize()
    {
        return list.len()*(drawHeight(list[0].draw.font)+3);
    }  

    function getSizePx()
    {
        return list.len()*(drawHeightPx(list[0].draw.font)+3);
    }    

    function setText(id, text)
    {
        foreach(i, _list in list)
        {
            if(_list.id == id)
            {
                list[i].draw.text = text;
            }
        }
    }

    function setColor(id, r, g, b)
    {
        foreach(i, _list in list)
        {
            if(_list.id == id)
            {
                list[i].draw.setColor(r,g,b);
            }
        }     
    }

    function setAlpha(id, alpha)
    {
        foreach(i, _list in list)
        {
            if(_list.id == id)
            {
                list[i].draw.setAlpha(alpha);
            }
        }     
    }

    function setVisible(bool)
    {
        isVisible = bool;
        foreach(_list in list)
            _list.draw.visible = bool;
    }

    function top()
    {
        foreach(_list in list)
            _list.draw.top();
    }

    function mouseClick(btn, type)
    {
        if(active && isVisible)
        {
            foreach(i, _list in list)
            {
                if(isMouseInPositionDraw(_list.draw))
                    callEvent("onListSwitch", this, btn, type, _list.id)
            }
        }
    }

    active = false;
    isVisible = false;
    list = null;
}

/*
Gui.List(x, y, font, {id = 0, name = "Name"})
Gui.List.setVisible(bool)
Gui.List.setText(id, text)
Gui.List.setColor(id, r, g, b)
Gui.List.setPosition(x, y)
Gui.List.setPositionPx(x, y)
Gui.List.getPosition()
Gui.List.getPositionPx()
Gui.List.getSize()
Gui.List.getSizePx()
*/
/*
local list = Gui.List(2200, 200, "FONT_OLD_10_WHITE_HI.TGA",
    {id = 0, name = "Option 1"},
    {id = 1, name = "Option 2"},
    {id = 2, name = "Option 3"},
    {id = "test", name = "Option 4"},
    {id = 4, name = "Option 5"},
    {id = 5, name = "Option 6"}
)

list.setColor("test", 255, 0, 0);
list.setPositionPx(800, 600)

addEventHandler("onInit", function(){

    list.setVisible(true)
});

addEventHandler("onListSwitch", function(instance, btn, type, id)
{
    if(instance == list && btn == MOUSE_LMB && type == MOUSE_BOTTOM)
    {
        print("List: "+id);
    }
});
*/
