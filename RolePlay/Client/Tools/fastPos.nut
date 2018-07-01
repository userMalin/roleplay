
/// Do szybkiego posów rozstawiania!

/*
local name = "Brak";

function setPosName(params)
{
name = params;
addMessage(255,255,255, name);
}

local function keyHandler(key)
{
    if(key == KEY_P)
	{
	    local getpos = getPlayerPosition(heroId);
	    callServerFunc("saveLog", "pos.txt", "Pos "+name+" w pozycji : "+getpos.x+","+getpos.y+","+getpos.z+" "+0);
		print("zapisano");
	}
}

addEventHandler("onKey", keyHandler);

addCommand("namepos", setPosName);
*/