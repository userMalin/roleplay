
class Gui.Draw extends Draw
{
    constructor(_x, _y, _text)
    {
        base.constructor(_x, _y, _text);
        active = false;
        isVisible = false;

        local _this = this;
        addEventHandler("onClick", function(btn, type){ _this.mouseClick(btn, type) });
    }

    function setVisible(bool)
    {
        isVisible = bool;
        visible = bool;
    }

    function mouseClick(btn, type)
    {
        if(active && isVisible)
        {
            if(isMouseInPositionDraw(this))
                callEvent("onDrawClick", this, btn, type);
        }
    }

    function getSizePx()
    {
        return {width = widthPx, height = heightPx};
    }

    function getSize()
    {
        return {width = width, height = height};
    }

    texture = null;
    active = false;
    isVisible = false;
}