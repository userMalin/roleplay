
class Gui.Texture extends Texture
{
    constructor(_x, _y, _w, _h, _texture)
    {
        base.constructor(_x, _y, _w, _h, _texture);
        active = false;
        isVisible = false;

        local _this = this;
        addEventHandler("onClick", function(btn, type){ _this.mouseClick(btn, type) });
    }
/*
    function setPositionPx(x, y)
    {
        txt.setPositionPx(x, y);     
    }

    function setPosition(x, y)
    {
        txt.setPosition(x, y);  
    }

    function setSizePx(x, y)
    {
        txt.setSizePx(x, y);     
    }

    function setSize(x, y)
    {
        txt.setSize(x, y);  
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

    function setTexture(_file)
    {
        txt.file = _file;
    }
*/
    function setVisible(bool)
    {
        isVisible = bool;
        visible = bool;
    }

    function mouseClick(btn, type)
    {
        if(active && isVisible)
        {
            if(isMouseInPositionTexture(this))
                callEvent("onTextureClick", this, btn, type);
        }
    }


    txt = null;
    active = false;
    isVisible = false;
}