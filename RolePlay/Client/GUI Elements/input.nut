
class Gui.Input
{
    constructor(_x, _y, _w, _h, _texture, _maxChar = 150, _type = INPUT.TEXT, _align = ALIGN_LEFT, _description = "", _margin = 2)
    {
        txt = Texture(_x, _y, _w, _h, _texture);

        input = {
            x = nax(_x),
            y = nay(_y),
            w = nax(_w),
            h = nay(_h),
            size = _maxChar,
            type = _type,
            align = _align,
            margin = _margin,
            //
            isOpen = false,
            text = "",
        };

		textureTxt = _texture;
        isVisible = false;
        active = true;

        switch(_align)
        {
            case ALIGN_LEFT:
                input.draw <- Draw(anx(input.x + input.margin), any(input.y + input.h/2 - drawHeightPx("FONT_OLD_10_WHITE_HI.TGA")/2), _description);
                break;
            case ALIGN_RIGHT:
                textSetFont("FONT_OLD_10_WHITE_HI.TGA");
                input.draw <- Draw(anx(input.x + input.w - (textWidthPx(_description) + input.margin)), any(input.y + input.h/2 - drawHeightPx("FONT_OLD_10_WHITE_HI.TGA")/2), _description);
                break;
            case ALIGN_CENTER:
                textSetFont("FONT_OLD_10_WHITE_HI.TGA");
                input.draw <- Draw(anx(input.x + input.w/2 - textWidthPx(_description)/2), any(input.y + input.h/2 - drawHeightPx("FONT_OLD_10_WHITE_HI.TGA")/2), _description);
                break;
        }

        local _this = this;
        addEventHandler("onKey", function(key){ _this.keyEvent(key) });
        addEventHandler("onClick", function(btn, status){ _this.clickEvent(btn, status) });
    }

    function alignText()//calculate
    {
        switch(input.align)
        {
            case ALIGN_LEFT:
                input.draw.setPositionPx(input.x + input.margin, input.y + input.h/2 - drawHeightPx("FONT_OLD_10_WHITE_HI.TGA")/2);
                break;
            case ALIGN_RIGHT:
                input.draw.setPositionPx(input.x + input.w - (input.draw.widthPx + input.margin), input.y + input.h/2 - drawHeightPx("FONT_OLD_10_WHITE_HI.TGA")/2);
                break;
            case ALIGN_CENTER:
                input.draw.setPositionPx(input.x + input.w/2 - input.draw.widthPx/2, input.y + input.h/2 - drawHeightPx("FONT_OLD_10_WHITE_HI.TGA")/2);
                break;
        }     
    }

    function keyEvent(key)
    {
        if(isVisible && input.isOpen && active)
        {
            local letter = getKeyLetter(key);
            if(letter != null && input.text.len() < input.size)
            {
                switch(input.type)
                {
                    case INPUT.TEXT:
                        input.text += letter;
                        input.draw.text = cutStringRight(input.text + "|", input.w - input.margin*2);
                        callEvent("onFieldChangeText", this, input.text);
                        break;
                    case INPUT.PASSWORD:
                        input.text += letter;
                        input.draw.text = cutStringRight(putSign("#", input.text.len()) + "|", input.w - input.margin*2);
                        callEvent("onFieldChangeText", this, input.text);
                        break;
                    case INPUT.NUMBERS:
                        if(letter == "0" || letter == "1" || letter == "2" || letter == "3" || letter == "4" || letter == "5" || letter == "6" || letter == "7" || letter == "8" || letter == "9" || letter == "0")
                        {
                            input.text += letter;
                            input.draw.text = cutStringRight(input.text + "|", input.w - input.margin*2);
                            callEvent("onFieldChangeText", this, input.text);
                        }
                        break;
                }             
            }

            if(key == KEY_BACK && input.text.len() > 0)
            {
                input.text = input.text.slice(0, input.text.len()-1);
                callEvent("onFieldChangeText", this, input.text);
                switch(input.type)
                {
                    case INPUT.TEXT:
                    case INPUT.NUMBERS:
                        input.draw.text = cutStringRight(input.text + "|", input.w - input.margin*2);
                        break;
                    case INPUT.PASSWORD:
                        input.draw.text = cutStringRight(putSign("#", input.text.len()) + "|", input.w - input.margin*2);
                        break;
                }                  
            }

            // placing
            this.alignText();               
        }
    }

    function clickEvent(btn, status)
    {
        if(btn == MOUSE_LMB && isVisible && active)
        {
            if(isMouseInPositionTexture(txt))
            {
                if(!input.isOpen)
                {
                    if(input.type == INPUT.PASSWORD)
                        input.draw.text = cutStringRight(putSign("#", input.text.len()) + "|", input.w - input.margin*2);
                    else
                    {
                        input.draw.text = cutStringRight(input.text + "|", input.w - input.margin*2);
                    }
                    input.isOpen = true;
                    callEvent("onFieldOpen", this);
                }
            }
            else
            {
                if(input.isOpen)
                {
                    if(input.type == INPUT.PASSWORD)
                        input.draw.text = cutStringRight(putSign("#", input.text.len()), input.w - input.margin*2);
                    else
                    {
                        input.draw.text = cutStringRight(input.text, input.w - input.margin*2);
                    }
                    input.isOpen = false;   
                    callEvent("onFieldClose", this);                 
                }
            }
            this.alignText(); 
        }
    }

    function setText(_text)
    {
        input.text = _text;
        input.draw.text = cutStringRight(_text, input.w - input.margin*2);
    }

    function setVisible(bool)
    {
        enableKeys(!bool);

        isVisible = bool;
        txt.visible = bool;
        input.draw.visible = bool;
    }

    function setPositionPx(_x, _y)
    {
        input.x = _x;
        input.y = _y;
        txt.setPositionPx(_x, _y);

        this.alignText();         
    }

    function setPosition(_x, _y)
    {
        this.setPositionPx(nax(_x), nay(_y));
    }

    function getPosition()
    {
        return txt.getPosition();
    }


    function getPositionPx()
    {
        return txt.getPositionPx();
    }

    function getSize()
    {
        return txt.getSize();
    }

    function getSizePx()
    {
        return txt.getSizePx();
    }

    function top()
    {
        txt.top();
        input.draw.top();
    }

    function setAlpha(alpha)
    {
        txt.setAlpha(alpha);
        input.draw.setAlpha(alpha);
    }

    function setColor(r, g, b)
    {
        input.draw.setColor(r, g, b);
    }
	
	function hover(_texture)
    {
        if(isVisible)
        {
            if(isMouseInPositionTexture(txt))   
                txt.file = _texture;
            else
                txt.file = textureTxt;
        }     
    }

    txt = null;
    input = null;
	
    textureTxt = null;
    isVisible = false;
    active = false;

}