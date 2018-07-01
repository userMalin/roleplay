
class Gui.TabPanel
{
    constructor(_x, _y, _w, _h)
    {
        tab = [];
        dimensions = {
            x = _x,
            y = _y,
            w = _w,
            h = _h,
            length = 0,
        };
        isVisible = false;
        active = false;

        local _this = this;
        addEventHandler("onMouseClick", function(btn){ _this.mouseClick(btn) });
    }

    function addTab(texture, name)
    {
        local x = dimensions.x + dimensions.length;
        local button = Gui.Button(x, dimensions.y, dimensions.w, dimensions.h, texture, "FONT_OLD_10_WHITE_HI.TGA", name);
        dimensions.length += dimensions.w + anx(20);

        tab.append({option = button, element = []});   
        return tab.len()-1;
    }

    function addElement(id, _element)
    {
        tab[id].element.append(_element)
    } 

    function setColor(id, r, g, b)
    {
        tab[id].option.setColor(r, g, b)
    }

    function hover(_texture)
    {
        if(isVisible && active)
        {
            foreach (_tab in tab) 
                _tab.option.hover(_texture); 
        }
    }

    function setAlpha(alpha)
    {
        foreach (_tab in tab) 
            _tab.option.setAlpha(alpha);
    }

    function setPosition(_x, _y)
    {
        dimensions.x = _x;
        dimensions.y = _y;
        dimensions.length = 0;
        foreach (_tab in tab) 
        {
            local x = dimensions.x + dimensions.length;
            _tab.option.setPosition(x, _y); 
            dimensions.length += dimensions.w + anx(20);
        }
    }

    function setPositionPx(_x, _y)
    {
        dimensions.x = anx(_x);
        dimensions.y = any(_y);
        dimensions.length = 0;
        foreach (_tab in tab) 
        {
            local x = dimensions.x + dimensions.length;
            _tab.option.setPositionPx(nax(x), _y); 
            dimensions.length += dimensions.w + anx(20);
        }
    }

    function getPosition()
    {
        return {x = dimensions.x, y = dimensions.y};
    }

    function getPositionPx()
    {
        return {x = nax(dimensions.x), y = nay(dimensions.y)};
    }

    function getWidth()
    {
        return dimensions.length-anx(20);  
    }

    function getWidthPx()
    {
        return nax(dimensions.length)-20;  
    }

    function changeTabName(id, text)
    {
        tab[id].option.changeText(text) 
    }

    function setVisible(bool)
    {
        isVisible = bool;
        active = bool;
        foreach (_tab in tab) 
        {
            _tab.option.setVisible(bool);  
            _tab.option.active = bool;  
        }
    }

    function top()
    {
        foreach (_tab in tab) 
            _tab.option.top();  
    }

    function tabVisible(id, bool)
    {
        foreach(i, _tab in tab)
        {
            foreach(_element in tab[i].element)
            {
                if(i == id)
                    _element.setVisible(bool);
                else
                    _element.setVisible(false);
            }
        }
    }  

    function mouseClick(btn)
    {
        if(isVisible && active)
        {
            foreach(i, _tab in tab)
            {
                if(isMouseInPositionTexture(_tab.option))
                {
                    callEvent("onTabPanel", this, btn, i);
                    this.tabVisible(i, true);
                }
            }   
        }     
    }

    tab = null;
    isVisible = false;
    dimensions = null;
    active = false;
}