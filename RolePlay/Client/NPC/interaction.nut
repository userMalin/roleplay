
// By Quarchodron / CC(2018) / Made for RolePlay v.0.3

local interactionsTable = [];

local focusTexture = Texture(3000,6824,2250,300, "MENU_CHOICE_BACK.TGA");
local focusDraw = Draw(3134,6904"LCTRL aby porozmawiac"); 

/////////////////////////////////////////////////

function addInteractionNPC(name, func)
{
    interactionsTable.append({name = name, func = func});
}

function callInteractionNPC(name)
{
    foreach(v,k in interactionsTable)
	{
	    if(k.name == name)
		{
		    k.func();
		    break;
		}
	}
}

///////////////////////////////////////////////////

local function keyHandler(key)
{
    if(key == KEY_LCONTROL)
	{
	    if(NPCFocusId != -1 && active_GUI == false)
		{
            callInteractionNPC(getPlayerName(NPCFocusId))
			showDialogInteraction();
		}
	}
}

addEventHandler("onKey", keyHandler);

///////////////////////////////////////////////////

function showDialogInteraction()
{
	enableHud(HUD_HEALTH_BAR,false);
	setFreeze(true);
	setCursorVisible(true);
	freezeCam();
	active_GUI = true;
	Chat.hide();
	hideFocusDrawsTextures();
	hideClockDraw();
	disableAllKeys();
}

function hideDialogInteraction()
{
    setFreeze(false);
    setCursorVisible(false);
    enableHud(HUD_HEALTH_BAR,true);
    setDefaultCamera();
    Chat.show();
    active_GUI = false;		
	showFocusDrawsTextures();
	showClockDraw();
	enableAllKeys();
}

/////////////////////////////////////////////////

function hideFocusDrawsTextures()
{
	focusTexture.visible = false;
	focusDraw.visible = false;	
}

function showFocusDrawsTextures()
{
	focusTexture.visible = true;
	focusDraw.visible = true;	
}

