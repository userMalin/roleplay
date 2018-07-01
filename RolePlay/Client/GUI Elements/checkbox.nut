
class Gui.CheckBox extends Texture
{
    constructor(_x, _y, _w, _h, _texture, _activeTexture)
    {
        base.constructor(_x, _y, _w, _h, _texture);
        active = false;
        isVisible = false;
        checkBox = false;

        activeTexture = _texture;
        inactiveTexture = _activeTexture;

        local _this = this;
        addEventHandler("onClick", function(btn, type){ _this.mouseClick(btn, type) });
    }

    function setVisible(bool)
    {
        isVisible = bool;
        visible = bool;
    }

    function enable(bool)
    {
        checkBox = bool 
        checkBox ? this.file = inactiveTexture : this.file = activeTexture;
    }

    function mouseClick(btn, type)
    {
        if(active && isVisible && type == MOUSE_BOTTOM)
        {
            if(isMouseInPositionTexture(this))
            {
                if(checkBox)
                    callEvent("onCheckBox", this, false);
                else
                    callEvent("onCheckBox", this, true);
                
                checkBox = !checkBox;

                checkBox ? this.file = inactiveTexture : this.file = activeTexture;
            }
        }
    }

    activeTexture = "";
    inactiveTexture = "";
    active = false;
    checkBox = false;
    isVisible = false;
}