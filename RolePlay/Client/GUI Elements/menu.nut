
class Gui.Menu
{
    constructor(params)
    {
        dimension = {
            x = nax(params.x),
            y = nay(params.y),
            width = nax(params.width),
            height = nay(params.height),
            margin = nay(params.margin),
            hoverColor = params.hoverColor,
            hoverTxt = params.hoverTxt,
            distance = 0,
        };

        menu = [];
        isVisible = false;
        active = true;

        local _this = this;
        addEventHandler("onFPSLimit", function(){ _this.renderLimit() });
        addEventHandler("onButtonClick", function(instance, btn, status){ _this.click(instance, btn, status) });
    }

    function renderLimit()
    {
        if(isVisible && active)
        {
            foreach(_menu in menu)
                _menu.btn.hover(_menu.texture, _menu.color[0], _menu.color[1], _menu.color[2]);
        }
    }

    function click(instance, btn, status)
    {
        if(isVisible && active)
        {
            foreach(i, _menu in menu)
            {
                if(instance == _menu.btn)
                {
                    callEvent("onMenu", this, btn, status, i);
                    return 0;
                }
            }
        }
    }

    function addOption(name, txt, r, g, b, hoverTxt, _rHover, _gHover, _bHover)
    {
        local _draw = Gui.Button(anx(dimension.x), any(dimension.y + dimension.distance), anx(dimension.width), any(dimension.height), txt, "FONT_OLD_10_WHITE_HI.TGA", name)
        menu.append({btn = _draw, color = [_rHover, _gHover, _bHover], texture = hoverTxt});

        menu[menu.len()-1].btn.setColor(r, g, b)
        dimension.distance += dimension.margin + dimension.height;

        return menu.len()-1;
    }

    function setText(idOption, text)
    {
        menu[idOption].btn.changeText(text);
    }

    function setVisible(bool)
    {
        isVisible = bool;
        foreach(_menu in menu)
            _menu.btn.setVisible(bool);
    }

    function top()
    {
        foreach(_menu in menu)
            _menu.btn.top();
    }

    function setPositionPx(_x, _y)
    {
        dimension.distance = 0;
        dimension.x = _x;
        dimension.y = _y;

        foreach(i, _menu in menu)
        {  
            _menu.btn.setPositionPx(dimension.x, dimension.y + dimension.distance);
            dimension.distance += dimension.margin + dimension.height;
        }
    }

    function setPosition(_x, _y)
    {
        this.setPositionPx(nax(_x), nay(_y));
    }

    function getSizePx()
    {
        return {width = dimension.width, height = dimension.distance};
    }

    function getSize()
    {
        return {width = anx(dimension.width), height = any(dimension.distance)};
    }

    function getPositionPx()
    {
        return {x = dimension.x, y = dimension.y};
    }

    function getPosition()
    {
        return {x = anx(dimension.x), y = any(dimension.y)};
    }

    function setAlpha(_alpha)
    {
        foreach(_menu in menu)
            _menu.btn.setAlpha(_alpha);
    }

    menu = null;
    active = true;
    dimension = null;
    isVisible = false;
}