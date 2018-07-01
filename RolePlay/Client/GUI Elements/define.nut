/*
//////////////////////////////////////////
        Author: Tommy 
        Last Update: 16.05.2018
        Version: 1.3.0
//////////////////////////////////////////
*/

Gui <- {};//namespace

const MOUSE_BOTTOM = 0;
const MOUSE_TOP = 1;

local limit = 0;
local waitFPS = 0;
local frame = 0;

//------------------------------------------

function isMouseInPositionDraw(draw)
{
    local cur = getCursorPositionPx();
    local pos = draw.getPositionPx();
    if(cur.x >= pos.x && cur.x <= pos.x + draw.widthPx && cur.y >= pos.y && cur.y <= pos.y + draw.heightPx)
        return true;

    return false;
}

function isMouseInPositionTexture(texture)
{
    local cur = getCursorPositionPx();
    local pos = texture.getPositionPx();
    local size = texture.getSizePx();
    if(cur.x >= pos.x && cur.x <= pos.x + size.width && cur.y >= pos.y && cur.y <= pos.y + size.height)
        return true;
        
    return false;
}

function drawHeight(_font)
{
    local size = Draw(0,0, "Hello World")
    size.font = _font;
    return size.height;
}

function drawHeightPx(_font)
{
    local size = Draw(0,0, "Hello World")
    size.font = _font;
    return size.heightPx;
}

function centerDraw(draw)
{
    local res = getResolution();
    draw.setPositionPx(res.x/2 - draw.widthPx/2, res.y/2 - drawHeightPx(draw.font)/2);
}

function centerTexture(texture)
{
    local res = getResolution();
    local size = texture.getSizePx();
    texture.setPositionPx(res.x/2 - size.width/2, res.y/2 - size.height/2);
}

function stringToArray(text)
{
	local array = [];

	for(local i = 0; i < text.len(); i++)
	{
		array.append(text.slice(i, i+1))
	}

	return array;
}

function cutString(text, width)
{
    textSetFont("FONT_OLD_10_WHITE_HI.TGA");
    local array = stringToArray(text);

    local endText = "";

    foreach(char in array)
    {
        if(textWidthPx(endText+char) < width)
        {
            endText += char;
        }else
            return endText;
    }

    return endText;
}

function cutStringRight(text, width)
{
    textSetFont("FONT_OLD_10_WHITE_HI.TGA");
    local array = stringToArray(text);

    local endText = "";

    for(local i = array.len()-1; i > -1; i--)
    {
        if(textWidthPx(endText+array[i]) < width)
        {
            endText = array[i] + endText;
        }else
            return endText;
    }

    return endText;
}

function splitInToSize(text, width)
{
    textSetFont("FONT_OLD_10_WHITE_HI.TGA");
    local arrayText = [];

    local structText = "";

    foreach(char in stringToArray(text))
    {
        if(textWidthPx(structText+char) < width)
            structText += char;
        else
        {
            arrayText.append(structText)
            structText =  "";
        }
    }

    arrayText.append(structText);
    return arrayText;

}

function putSign(char, quantity)
{
    local text = "";
    for(local i = 0; i < quantity; i++)
    {
        text += char;
    }
    return text;
}

function wordWrap(text, font, size)
{
    local words = [];
    local mText = text;

    for(local i = 0; i < text.len(); i++)
    {
        if(mText.find(" ") != null)
        {
            words.append(mText.slice(0, mText.find(" ")+1));
            mText = mText.slice(mText.find(" ")+1);
        }
        else
        {
            words.append(mText.slice(0, mText.len()));
            break;
        }
    }

    local temprText = "";
    local endText = "";

    textSetFont(font);

    foreach(_word in words)
    {
        if(textWidthPx(temprText + _word) <= size)
        {
            temprText += _word;
        }
        else
        {
            endText += temprText+"~n";
            temprText = "";
        }
    }

    if(temprText != "")
    {
        endText += temprText+"~n";
        temprText = "";        
    }
    
    return endText;
}

//------------------------------------------

local function clickMouse(btn)
{
    callEvent("onClick", btn, MOUSE_BOTTOM);
}
addEventHandler("onMouseClick", clickMouse);

local function clickRelease(btn)
{
    callEvent("onClick", btn, MOUSE_TOP);
}
addEventHandler("onMouseRelease",clickRelease);

local function render()
{
    waitFPS = getFpsRate().tofloat()/28.0;
    if(frame > limit)
    {
        limit = frame + waitFPS;
        callEvent("onFPSLimit");
    }
    ++frame;    
}
addEventHandler("onRender", render);

print("Gui System by Tommy 1.3.0");
