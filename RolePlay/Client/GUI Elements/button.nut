
class Gui.Button
{
    constructor(_x, _y, _w, _h, _texture, _font, _text)
    {
        active = true;
        inactiveTexture = _texture;
        color = {r = 255, g = 255, b = 255};
        txt = Gui.Texture(_x, _y, _w, _h, _texture);
        draw = Draw(0, 0, _text);
        draw.font = _font;
        draw.setPositionPx(nax(_x + _w/2) - draw.widthPx/2, nay(_y + _h/2) - draw.heightPx/2);

        local _this = this;
        addEventHandler("onClick", function(btn, type){ _this.mouseClick(btn, type) });
    }

    function changeText(text)
    {
        draw.text = text;
        local pos = txt.getPositionPx();
        local size = txt.getSizePx();
        draw.setPositionPx(pos.x + size.width/2 - draw.widthPx/2, pos.y + size.height/2 - draw.heightPx/2);
    }

    function hover(_texture, r = null, g = null, b = null)
    {
        if(active && isVisible)
        {
            if(isMouseInPositionTexture(txt))   
            {
                txt.file = _texture;
                if(r != null)
                    draw.setColor(r, g, b);
            }
            else
            {
                txt.file = inactiveTexture;
                if(r != null)
                    draw.setColor(color.r, color.g, color.b);
            }
        }     
    }

    function setAlpha(alpha)
    {
        txt.setAlpha(alpha);
        draw.setAlpha(alpha);
    }

    function getAlpha()
    {
        return draw.getAlpha();
    }

    function top()
    {
        txt.top();
        draw.top();
    }

    function setColor(_r, _g, _b)
    {
        draw.setColor(_r, _g, _b);
        color = {r = _r, g = _g, b = _b};
    }

    function getColor()
    {
        return draw.getColor();
    }

    function setPositionPx(x, y)
    {
        txt.setPositionPx(x, y);  
        local size = txt.getSizePx();
        draw.setPositionPx(x + size.width/2 - draw.widthPx/2, y + size.height/2 - draw.heightPx/2);     
    }

    function setPosition(x, y)
    {
        txt.setPosition(x, y);  
        local size = txt.getSize();
        draw.setPosition(x + size.width/2 - draw.width/2, y + size.height/2 - draw.height/2); 
    }

    function getPositionPx()
    {
        return txt.getPositionPx();
    }

    function getPosition()
    {
        return txt.getPosition();
    }

    function getSizePx()
    {
        return txt.getSizePx();
    }

    function getSize()
    {
        return txt.getSize();
    }

    function setVisible(bool)
    {
        isVisible = bool;
        txt.setVisible(bool);
        draw.visible = bool;
    }

    function mouseClick(btn, type)
    {
        if(active && isVisible)// && type == MOUSE_BOTTOM
        {
            if(isMouseInPositionTexture(txt))
                callEvent("onButtonClick", this, btn, type);
        }
    }

    txt = null;
    draw = null;
    inactiveTexture = "";
    color = null;
    active = false;
    isVisible = false;

}