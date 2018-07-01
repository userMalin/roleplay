
// By Quarchodron / CC(2018) / Made for RolePlay v.0.3

///////////////////////////////////////////////////////////
local operationOnDialog = null;
local tableToDialog = null;
local idToDialogSystem = -1;
local startAnimateTexture = false;
local startAnimateDraw = false;
local isInDialog = false;
///////////////////////////////////////////////////////////
local dialogMenuTxt = Texture(0,0,0,0,"MENU_INGAME");
///////////////////////////////////////////////////////////
local drawsDialog = [];
local openedIdDialog = -1;
///////////////////////////////////////////////////////////

////// Start Animate and Read The Text Table!

function showAnimatedDialog(oparatedDialog, tableDialog, idDialogSystem)
{
    operationOnDialog = oparatedDialog;
	tableToDialog = tableDialog;
	idToDialogSystem = idDialogSystem;
	
	startAnimateTexture = true;
	dialogMenuTxt.setPosition(4000,1000);
	dialogMenuTxt.setSize(0,0);
	dialogMenuTxt.visible = true;
	isInDialog = true;

	drawsDialog.clear();
	
	openedIdDialog = 0;
    createDrawsToAnimatedDialog(tableToDialog[openedIdDialog]);
}

////// Create Draws To Animated Dialog!

function createDrawsToAnimatedDialog(stringDialog)
{
    local yPos = 600;
    if(stringDialog.find("&") != null)
	{
        foreach(v,k in split(stringDialog, "&"))
	    {
		    local drawEk = Draw(2250, yPos + v * 150, k);
			drawEk.visible = true;
		    drawEk.setAlpha(0);
    	    drawsDialog.append(drawEk);
	    }
	}else{
		local drawEk = Draw(2250, 600, stringDialog);
		drawEk.visible = true;
		drawEk.setAlpha(0);
		drawsDialog.append(drawEk);
	}
}

////// Render too animate the draws and texture!

local function renderHandler()
{
    if(startAnimateTexture == true)
	{
	/// Texture Animation to make bigger the texture!
        local sizT = dialogMenuTxt.getSize();
		local posT = dialogMenuTxt.getPosition();
		
		dialogMenuTxt.setPosition(posT.x - 35, posT.y - 10);
		dialogMenuTxt.setSize(sizT.width + 70, sizT.height + 20);
		
		if(sizT.width > 3500)
		{
		    dialogMenuTxt.setSize(3500, 1000);
			startAnimateTexture = false;
			startAnimateDraw = true;
		}
	/// Animation to draws just alpha + 5 by render tick!
	}else if(startAnimateDraw == true)
	{
	    foreach(v,k in drawsDialog)
		{
		    k.setAlpha(k.getAlpha() + 5);
			if(k.getAlpha() > 240)
			{
			    startAnimateDraw = false;
			    k.setAlpha(255);
			}
		}
	}
}

addEventHandler("onRender", renderHandler);

/////// Move forward in dialog by space key using onkey handler!

local function keyHandler(key)
{ 
    if(isInDialog)
	{
	//// We check if player press space then dialog will move on!
    if(key == KEY_SPACE)
    {
        openedIdDialog = openedIdDialog + 1;
		//// System check if its maybe last dialog this option.
		if(openedIdDialog >= tableToDialog.len())
		{
		    operationOnDialog.hideDialogAnimation(idToDialogSystem);
		    openedIdDialog = -1;
		    startAnimateDraw = false;
			startAnimateTexture = false;
	        dialogMenuTxt.visible = false;
			operationOnDialog = null;
			tableToDialog = null;
			idToDialogSystem = -1;
	        drawsDialog.clear();		
            isInDialog = false;			
		}
		else
		{
		//// Or no and then just move on.
		    drawsDialog.clear();
		    createDrawsToAnimatedDialog(tableToDialog[openedIdDialog]);	
			startAnimateDraw = true;
		}
    }
	/////////////////////////////////////////////////////////////
	}
}

addEventHandler("onKey", keyHandler);