local function getMultipleLine(_text)
{
	local arrayText = [];
	local char = null;

	do{
		local _find = _text.find("~n");
		char = _find;
		//print(_find)

		if(_find == null)
			_find = _text.len();

		if(_find > 0)
			arrayText.append(_text.slice(0, _find));	

		if(_find < _text.len()-2)
			_text = _text.slice(_find+2);
		else
			_text = "";

	}while(char != null);

	return arrayText;
}

local function getMultipleColor(_text, _r, _g, _b)
{
	local arrayColor = [];
	local defaultColor = {r = _r, g = _g, b = _b};
	local splitText = split(_text, "{")

	foreach(_chunk in splitText)
	{
		if(_chunk.find("}") != null)
		{
			defaultColor = hexToRgb(_chunk.slice(1, _chunk.find("}")));
			_chunk = _chunk.slice(_chunk.find("}")+1);
		}

		arrayColor.append({color = {r = defaultColor.r, g = defaultColor.g, b = defaultColor.b}, text = _chunk})
	}

	return arrayColor;//{color, text}
}

class Gui.DrawMultiple
{
    constructor(_x, _y, _text, _font, _r = 255, _g = 255, _b = 255)
    {
        _x = nax(_x);
        _y = nay(_y);

        isVisible = false;
        //active = false;
        draws = [];
        dimension = {
            x = _x,
            y = _y,
            width = 0,
            height = 0,
            font = _font,
            color = {r = _r, g = _g, b = _b},
            line = 0,
        };

        this.setText(_text);
    }

    function setText(_text)
    {
        draws = [];
        textSetFont(dimension.font);

        foreach (i, _line in getMultipleLine(_text)) 
        {
            local margin_y = i*drawHeightPx(dimension.font);
            local margin_x = 0;

            foreach (_scrap in getMultipleColor(_line, dimension.color.r, dimension.color.g, dimension.color.b)) 
            {
                draws.append({object = Draw(anx(margin_x + dimension.x), any(margin_y + dimension.y), _scrap.text), margin = {x = margin_x, y = margin_y}});
                draws[draws.len()-1].object.font = dimension.font;
                draws[draws.len()-1].object.setColor(_scrap.color.r, _scrap.color.g, _scrap.color.b);
                dimension.color = {r = _scrap.color.r, g = _scrap.color.g, b = _scrap.color.b};
                
                if(isVisible)
                    draws[draws.len()-1].object.visible = true;

                margin_x += textWidthPx(_scrap.text);
            }
            
            if(margin_x > dimension.width)
                dimension.width = margin_x;

            dimension.height += drawHeightPx(dimension.font);
            ++dimension.line;
        }
    }

    function getPositionPx()
    {
        return {x = dimension.x, y = dimension.y};
    }
    function getPosition()
    {
        return {x = anx(dimension.x), y = any(dimension.y)};
    }

    function setPositionPx(_x, _y)
    {
        dimension.x = _x;
        dimension.y = _y;
        foreach (_draw in draws) 
            _draw.object.setPositionPx(_x + _draw.margin.x, _y + _draw.margin.y);
    }

    function setPosition(_x, _y)
    {
        this.setPositionPx(nax(_x), nay(_y));
    }

    function getSizePx()
    {
        return {width = dimension.width, height = dimension.height};
    }

    function getSize()
    {
        return {width = anx(dimension.width), height = any(dimension.height)};
    }

    function top()
    {
        foreach (_draw in draws) 
            _draw.object.top(); 
    }
    function setAlpha(alpha)
    {
        foreach (_draw in draws) 
            _draw.object.setAlpha(alpha); 
    }

    function setVisible(bool)
    {
        isVisible = bool;
        foreach (_draw in draws) 
            _draw.object.visible = bool;
    }

    draws = null;
    dimension = null;
    isVisible = false;
    active = false;
}