//OLD(improve)


class Gui.ScrollBar
{
    constructor(_x, _y, _w, _h, _textureBg, _texturePointer, _textureAdd, _textureMinus, _type, maxVal)
    {
        scroll = {};
        isVisible = false;
        isActive = false;
        active = false;

        dimension = {
            type = _type,
            distance = 0,
            
            list = 0,
            maxList = maxVal-1,
        };

        _x = nax(_x);
        _y = nay(_y); 
        _w = nax(_w); 
        _h = nay(_h);

        switch(_type)
        {
            case SCROLL.HORIZONTAL:
                _w -= 70;
                scroll.bg <- Texture(anx(_x + 35), any(_y), anx(_w), any(_h), _textureBg);
                scroll.pointer <- Texture(anx(_x + 35), any(_y-2), anx(20), any(_h+4), _texturePointer);
                scroll.up <- Texture(anx(_x), any(_y), anx(30), any(_h), _textureAdd);
                scroll.down <- Texture(anx(_x + 35 + _w + 5), any(_y), anx(30), any(_h), _textureMinus);
                break;
            case SCROLL.VERTICAL:
                _h -= 70;
                scroll.bg <- Texture(anx(_x), any(_y + 35), anx(_w), any(_h), _textureBg);
                scroll.pointer <- Texture(anx(_x-2), any(_y + 35 - 2), anx(_w+4), any(20), _texturePointer);
                scroll.up <- Texture(anx(_x), any(_y), anx(_w), any(30), _textureAdd);
                scroll.down <- Texture(anx(_x), any(_y + 35 + _h + 5), anx(_w), any(30), _textureMinus);
                break;
        }

        local _this = this;
        addEventHandler("onMouseClick", function(btn){ _this.mouseClick(btn) });
        addEventHandler("onMouseRelease", function(btn){ _this.mouseRelease(btn) });
        addEventHandler("onMouseWheel", function(val){ _this.mouseWheel(val) });
        addEventHandler("onRender", function(){ _this.movePointer() });
    }

    function calculate(page)
    {
        switch(dimension.type)
        {
            case SCROLL.HORIZONTAL:
                if(page == 0)
                {
                    if(dimension.list > 0)
                    {
                        --dimension.list   

                        if(dimension.list == 0)
                            scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x, scroll.bg.getPositionPx().y - 2)
                        else
                        {
                            local calc = scroll.bg.getSizePx().width.tofloat()/dimension.maxList.tofloat();
                            scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x + floor(calc*dimension.list) - 10, scroll.bg.getPositionPx().y - 2)                    
                        }

                        callEvent("onScrollBar", this, dimension.list)
                    }          
                }
                else if(page == 1)
                {
                    if(dimension.list < dimension.maxList)
                    {
                        ++dimension.list   

                        if(dimension.list == dimension.maxList)
                            scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x + scroll.bg.getSizePx().width - 20, scroll.bg.getPositionPx().y - 2)
                        else
                        {
                            local calc = scroll.bg.getSizePx().width.tofloat()/dimension.maxList.tofloat();
                            scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x + floor(calc*dimension.list) - 10, scroll.bg.getPositionPx().y - 2)                    
                        }
                            
                        callEvent("onScrollBar", this, dimension.list)
                    }   
                }
                dimension.distance = scroll.pointer.getPositionPx().x - scroll.bg.getPositionPx().x; 
                break;
            case SCROLL.VERTICAL:
                if(page == 0)
                {
                    if(dimension.list > 0)
                    {
                        --dimension.list   

                        if(dimension.list == 0)
                            scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x - 2, scroll.bg.getPositionPx().y)
                        else
                        {
                            local calc = scroll.bg.getSizePx().height.tofloat()/dimension.maxList.tofloat();
                            scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x - 2, scroll.bg.getPositionPx().y + floor(calc*dimension.list) - 10)                    
                        }

                        callEvent("onScrollBar", this, dimension.list)
                    }          
                }
                else if(page == 1)
                {
                    if(dimension.list < dimension.maxList)
                    {
                        ++dimension.list   

                        if(dimension.list == dimension.maxList)
                            scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x - 2, scroll.bg.getPositionPx().y + scroll.bg.getSizePx().height - 20)
                        else
                        {
                            local calc = scroll.bg.getSizePx().height.tofloat()/dimension.maxList.tofloat();
                            scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x - 2, scroll.bg.getPositionPx().y + floor(calc*dimension.list) - 10)                    
                        }
                            
                        callEvent("onScrollBar", this, dimension.list)
                    }   
                }
                dimension.distance = scroll.pointer.getPositionPx().y - scroll.bg.getPositionPx().y;                     
                break;
            }
    }       

    function mouseClick(btn)
    {
        if(isVisible && active)
        {
            if(isMouseInPositionTexture(scroll.pointer))
                isActive = true;

            if(isMouseInPositionTexture(scroll.up))
                this.calculate(0);
            else if(isMouseInPositionTexture(scroll.down))
                this.calculate(1);
        }
    };

    function mouseRelease(btn)
    {
        if(isActive)
            isActive = false;
    };

    function movePointer()
    {
        if(isVisible && active && isActive)
        {
            if(isMouseInPositionTexture(scroll.bg))
            {  
                local cur = getCursorPositionPx();
                local pos = scroll.bg.getPositionPx();
                local size = scroll.bg.getSizePx();

                switch(dimension.type)
                {
                    case SCROLL.HORIZONTAL:
                        if(cur.x >= pos.x + 10 && cur.x <= pos.x + size.width - 10)    
                        {
                            switch(dimension.type)
                            {
                                case SCROLL.HORIZONTAL:
                                    scroll.pointer.setPositionPx(cur.x-10, scroll.pointer.getPositionPx().y);
                                    break;
                                case SCROLL.VERTICAL:
                                    scroll.pointer.setPositionPx(scroll.pointer.getPositionPx().x, cur.y-10);
                                    break;
                            }
                            local calc =  scroll.pointer.getPositionPx().x - pos.x + 10
                            calc = calc.tofloat()/size.width.tofloat() * 100.0;
                            local width = dimension.maxList + 1;
                            calc = floor((calc.tofloat()/100.0) * width.tofloat());
        
                            if(calc != dimension.list)
                            {
                                dimension.list = calc;
                                callEvent("onScrollBar", this, dimension.list)
                            }
                
                            dimension.distance = scroll.pointer.getPositionPx().x - pos.x; 
                        }
                        break;
                    case SCROLL.VERTICAL:
                        if(cur.y >= pos.y + 10 && cur.y <= pos.y + size.height - 10)    
                        {
                            switch(dimension.type)
                            {
                                case SCROLL.HORIZONTAL:
                                    scroll.pointer.setPositionPx(cur.x-10, scroll.pointer.getPositionPx().y);
                                    break;
                                case SCROLL.VERTICAL:
                                    scroll.pointer.setPositionPx(scroll.pointer.getPositionPx().x, cur.y-10);
                                    break;
                            }
                            local calc =  scroll.pointer.getPositionPx().y - pos.y + 10
                            calc = calc.tofloat()/size.height.tofloat() * 100.0;
                            local width = dimension.maxList + 1;
                            calc = floor((calc.tofloat()/100.0) * width.tofloat());
        
                            if(calc != dimension.list)
                            {
                                dimension.list = calc;
                                callEvent("onScrollBar", this, dimension.list)
                            }
                
                            dimension.distance = scroll.pointer.getPositionPx().y - pos.y; 
                        }
                        break;
                }
            }
        }
    }

    function mouseWheel(val)
    {
        if(isVisible && active)
        { 
            switch(val)
            {
                case 1:
                    switch(dimension.type)
                    {
                        case SCROLL.HORIZONTAL: this.calculate(1);  break;
                        case SCROLL.VERTICAL:   this.calculate(0);  break;
                    }
                    break;
                case -1:
                    switch(dimension.type)
                    {
                        case SCROLL.HORIZONTAL: this.calculate(0);  break;
                        case SCROLL.VERTICAL:   this.calculate(1);  break;
                    }
                    break;
            }
        }
    }
    
    function setVisible(bool)
    {
        isVisible = bool;
        foreach (_scroll in scroll) 
        {
            _scroll.visible = bool;
        }
    }
    
    function setAlpha(alpha)
    {
        foreach (_scroll in scroll) 
        {
            _scroll.setAlpha(alpha);
        }
    }

    function setPositionPx(x, y)
    {
        switch(dimension.type)
        {
            case SCROLL.HORIZONTAL:
                scroll.bg.setPositionPx(x + 35, y);
                scroll.pointer.setPositionPx(x + 35 + dimension.distance, y - 2);
                scroll.up.setPositionPx(x, y);
                scroll.down.setPositionPx(x + scroll.bg.getSizePx().width + 35 + 5, y);     
                break;
            case SCROLL.VERTICAL:
                scroll.bg.setPositionPx(x, y + 35);
                scroll.pointer.setPositionPx(x -2, y + 35 + dimension.distance);
                scroll.up.setPositionPx(x, y);
                scroll.down.setPositionPx(x, y + 35 + scroll.bg.getSizePx().height + 5);     
                break;
        }  
    }

    function setPosition(x, y)
    {
        this.setPositionPx(nax(x), nay(y));
    }

    function getPositionPx()
    {
        return scroll.up.getPositionPx();
    }

    function getPosition()
    {
        return scroll.up.getPosition();
    }

    function setIndicator(position)
    {  
        switch(dimension.type)
        {
            case SCROLL.HORIZONTAL:
                if(position == 0)
                    scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x, scroll.bg.getPositionPx().y - 2)
                else{
                    local calc = scroll.bg.getSizePx().width.tofloat()/dimension.maxList.tofloat();
                    scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x + floor(calc*position) - 10, scroll.bg.getPositionPx().y - 2)    
                }
                dimension.distance = scroll.pointer.getPositionPx().x - scroll.bg.getPositionPx().x;  
                break;
            case SCROLL.VERTICAL:
                local calc = scroll.bg.getSizePx().height.tofloat()/dimension.maxList.tofloat();
                scroll.pointer.setPositionPx(scroll.bg.getPositionPx().x - 2, scroll.bg.getPositionPx().y + floor(calc*position) - 10)   
                dimension.distance = scroll.pointer.getPositionPx().y - scroll.bg.getPositionPx().y;     
                break;
        }  
        dimension.list = position;
    }

    function changeMaxValue(val)
    {
        dimension.maxList = val;
    }

    function top()
    {  
        scroll.bg.top();
        scroll.pointer.top();
        scroll.up.top();
        scroll.down.top();     
    }

    dimension = null;
    scroll = null;
    isActive = false;

    isVisible = false;
    wheelActive = false;
    active = false;
}
