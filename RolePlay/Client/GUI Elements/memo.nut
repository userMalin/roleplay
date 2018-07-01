
class Gui.Memo
{
    constructor(_x, _y, _w, _h, _texture, _r = 255, _g = 255, _b = 255)
    {
        dimension = {
            x = nax(_x),
            y = nay(_y),  
            w = nax(_w),
            h = nay(_h),
            line = nay(_y+5), 
        };

        memo = {
            text = "",
            isOpen = false,
            pointerLine = 0,
            color = [_r, _g, _b],
            alpha = 255,
        };

        active = true;
        text = "";
        isVisible = false;
        line = [];

        txt = Texture(_x, _y, _w, _h, _texture)

        local _this = this;
        addEventHandler("onKey", function(key){ _this.keyEvent(key) });
        addEventHandler("onClick", function(btn, status){ _this.clickEvent(btn, status) });
    }

    function calc(_text)
    {
        text = "";
        line = [];
        local wrapp = splitInToSize(_text, dimension.w-10);
        local height = 5;

        foreach(i, _line in wrapp)
        {
            if(height + drawHeightPx("FONT_OLD_10_WHITE_HI.TGA") <= dimension.h-5)
            {
                text += _line;
                line.append(Draw(anx(dimension.x + 5), any(dimension.y + height), _line))
                memo.pointerLine = i;
                height += drawHeightPx("FONT_OLD_10_WHITE_HI.TGA");
                line[i].setColor(memo.color[0], memo.color[1], memo.color[2]);
                line[i].setAlpha(memo.alpha);
                if(isVisible)
                    line[i].visible = true;
            }else
                break;
        }

        Chat.print(255,0,0, text);

        if(memo.isOpen)
            line[memo.pointerLine].text = line[memo.pointerLine].text + "|";
    }

    function setText(_text)
    {
        memo.text = _text;
        this.calc(memo.text);  
    }

    function keyEvent(key)
    {
        if(memo.isOpen && isVisible && active)
        {
            local letter = getKeyLetter(key);
            if(letter != null)
            {
                memo.text += letter;
                this.calc(memo.text)      
            } 

            if(key == KEY_BACK && memo.text.len() > 0)       
            {
                memo.text = memo.text.slice(0, memo.text.len()-1);
                this.calc(memo.text);     
            }

        }
    }

    function clickEvent(btn, status)
    {
        if(btn == MOUSE_LMB && status == MOUSE_BOTTOM && isVisible && active)
        {
            if(isMouseInPositionTexture(txt))
            {
                memo.isOpen = true;
                callEvent("onMemoOpen", this);
            }
            else if(memo.isOpen)
            {
                memo.isOpen = false;
                callEvent("onMemoHide", this);
            }
            this.calc(memo.text);
            //memo.isOpen ? callEvent("onMemoOpen", this) : callEvent("onMemoHide", this);
        }
    }

    function setVisible(bool)
    {
        isVisible = bool;
        txt.visible = bool;
        foreach (_line in line) 
            _line.visible = bool;
    }

    function setAlpha(_alpha)
    {
        memo.alpha = _alpha;

        txt.setAlpha(_alpha);

        foreach (_line in line) 
            _line.setAlpha(_alpha);
    }

    function top()
    {
        txt.top();

        foreach (_line in line) 
            _line.top();
    }

    function setColor(r, g, b)
    {
        memo.color = [r, g, b];

        foreach (_line in line) 
            _line.setColor(r, g, b);
    }

    function getColor()
    {
        local c = memo.color;
        return {r = c[0], g = c[1], b = c[2]}
    }

    function setPositionPx(_x, _y)
    {
        txt.setPositionPx(_x, _y);

        dimension.x = _x;
        dimension.y = _y;

        local distance = _y + 5;

        foreach(_line in line)
        {
            _line.setPositionPx(_x + 5, distance);
            distance += drawHeightPx("FONT_OLD_10_WHITE_HI.TGA");
        }
    }

    function setPosition(_x, _y)
    {
        this.setPositionPx(nax(_x), nay(_y));
    }

    function getPositionPx()
    {
        return txt.getPositionPx();
    }

    function getPosition()
    {
        return txt.getPosition();
    }

    function getSize()
    {
        return txt.getSize();
    }

    function getSizePx()
    {
        return txt.getSizePx();
    }



    line = null;
    txt = null;
   
    isVisible = false;
    dimension = null;
    memo = null;
    text = "";
    active = true;
}