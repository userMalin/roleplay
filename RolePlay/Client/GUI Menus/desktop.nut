
// By Quarchodron / CC(2018) / Made for RolePlay v.0.2


local testDrawCzas = Draw(7600, 7900, "Czas");

local textSprint = Texture(114,7550,1050,200, "BAR_BACK.TGA");
local textNakladka = Texture(165,7600,950,100, "BAR_HEALTH.TGA");

textNakladka.setColor(0, 200, 100);

//// Zainicjujemy dzialanie zegara w czasie zmiany GUI

local function testHandler(state)
{
    if(state == true)
	{ 
	    testDrawCzas.visible = false;
	    return;
	}
	
	testDrawCzas.visible = true;
}

addEventHandler("changeStateMenu", testHandler);


/// Functions add in version 0.3!

function hideClockDraw()
{
    testDrawCzas.visible = false;
}

function showClockDraw()
{
    testDrawCzas.visible = true;
}


/// Render to our Time

local function renderHandler()
{
    testDrawCzas.text = "Czas "+getTime().hour+":"+getTime().min;
}

addEventHandler("onRender", renderHandler);

/// Bar System added in 0.4

function setVisibleGothicBar(val)
{
enableHud(HUD_HEALTH_BAR,val);
enableHud(HUD_MANA_BAR,val);

textSprint.visible = val;
textNakladka.visible = val;
textNakladka.top();

setBarSize(HUD_HEALTH_BAR,1050,200);
setBarSize(HUD_MANA_BAR,1050,200);

setBarPosition(HUD_HEALTH_BAR,114,7800);
setBarPosition(HUD_MANA_BAR,114,7300);
};

function setSprintBarSize(width, height=100)
{
textNakladka.setSize(width, height);
}
