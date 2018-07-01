class Gui.Bar
{
    constructor(_x, _y, _w, _h, _marginX, _marginY, _border, _bg)
    {
        dimension = {
            x = _x,
            y = _y,
            w = _w,
            h = _h,
            marginX = _marginX,
            marginY = _marginY,
        };
        bar = {};
        isVisible = false;
        active = false;
        bar.border <- Texture(_x, _y, _w, _h, _border);
        bar.bg <- Texture(_x+_marginX, _y+_marginY, 0, _h - _marginY*2, _bg);
    }

    function setPercent(_percent)
    {
        if(_percent > 100)
            _percent = 100;
        else if(_percent < 0)
            _percent = 0;

        local width = dimension.w - dimension.marginX*2;
        bar.bg.setSize(floor((_percent/100.0) * width.tofloat()), bar.bg.getSize().height);
    }

    function setPosition(_x, _y)
    {
        dimension.x = _x;
        dimension.y = _y;
        bar.border.setPosition(_x, _y);
        bar.bg.setPosition(_x + dimension.marginX, _y + dimension.marginY);
    }

    function setPositionPx(_x, _y)
    {
        dimension.x = anx(_x);
        dimension.y = any(_y);
        bar.border.setPositionPx(_x, _y);
        bar.bg.setPositionPx(_x + nax(dimension.marginX), _y + nay(dimension.marginY));
    }

    function getPosition()
    {
        return bar.border.getPosition();
    }

    function getPositionPx()
    {
        return bar.border.getPositionPx();
    }

    function getSize()
    {
        return bar.border.getSize();
    }

    function getSizePx()
    {
        return bar.border.getSizePx();
    }

    function setAlpha(alpha)
    {
        bar.border.setAlpha(alpha);
        bar.bg.setAlpha(alpha);
    }

    function setVisible(bool)
    {
        isVisible = bool;
        bar.border.visible = bool;
        bar.bg.visible = bool;
    }

    function top()
    {
        bar.border.top();
        bar.bg.top();
    }

    isVisible = false;
    active = false;
    dimension = null;
    bar = null;
}
