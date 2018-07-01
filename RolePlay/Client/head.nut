//cc(2018); By Quarchodron

/*
    Author : Quarchodron
	Version : 0.4
	Name : RolePlay
	CC(2018)
*/

///////////////////////////////////////////////////////////////
active_GUI                 <- false; // Zmienna zmieniaj¹ca stan po w³¹czeniu jakiegoœ GUI!
FocusId                    <- -1;  // Przechowuje id gracza na którego patrzymy
NPCFocusId                 <- -1;  // Przechowuje id npc na którego patrzymy
Player_Sprint              <- 1000; // Przechowuje wartoœæ sprintu gracza.
///////////////////////////////////////////////////////////////

local function initGamemode()
{
    enableEvent_Render(true);
	enableEvent_RenderFocus(true);
	enable_NicknameId(true);
	setPingLimit(750);
	
	setKeyLayout(1);
	enableHud(HUD_ALL,false);
	
	setFreeze(true);
	setCursorVisible(true);
	clearMultiplayerMessages();
	disableAllKeys();
	active_GUI = true;
}

addEventHandler("onInit", initGamemode);


/*
===============================================
       Callbacksy i inne takie :).
===============================================
*/

addEventHandler("onUseItem", function(instance, amount, hand)
{
	if(instance.find("ITPO_") != null)
		callServerFunc("itemHasBeenUsed", heroId, instance, amount);
	if(instance.find("ITFO_") != null)
		callServerFunc("itemHasBeenUsed", heroId, instance, amount);
	if(instance.find("ITPL_") != null)
		callServerFunc("itemHasBeenUsed", heroId, instance, amount);
	if(instance == "ITFOMUTTONRAW" || instance == "ITFOMUTTON")
		callServerFunc("itemHasBeenUsed", heroId, instance, amount);
});

addEventHandler("onFocus", function(foc,oldfoc){
    if(foc != -1)
	{
        if(!isNpc(foc))
	    {
            FocusId = foc;
        }else{
		    NPCFocusId = foc;
            showFocusDrawsTextures();
	    }	    
	}
	else
	{
	    FocusId = -1;
		NPCFocusId = -1;
	    hideFocusDrawsTextures();    
	}
});


/*
===============================================
     Funkcje uzupe³niaj¹ce do ca³ego gm.
===============================================
*/

function giveItem(pid, item, amount)
{
    callServerFunc("giveItem", pid, item, amount);
}

function removeItem(pid, item, amount)
{
    callServerFunc("removeItem", pid, item, amount);
}

function isNpc(id)
{
    if(id >= getMaxSlots() && getPlayerInstance(id) == "PC_HERO")
	{
	    return true;
	}
	return false;
}

function setStringOnMaxChar(string,maxchar)
{
    if(string.len() > maxchar)
	{
	    string = string.slice(0, maxchar);
	}
    return string;
}

local timerRepeating;

function playAniRepeat(pid, name, repat)
{
    playAni(pid, name);
	
	timerRepeating = setTimer(function()
	{
		playAni(pid, name);
	}, repat, 0);
}

function stopAniRepeat()
{
    killTimer(timerRepeating);
}