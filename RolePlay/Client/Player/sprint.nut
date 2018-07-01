// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

local sprintEnabled = false;
local renderTime = 0;
local renderTimeRegeneration = getTickCount() + 10000;
local bonusFromHouse = false;

/// Handler do włączania sprintu.

addEventHandler("onKey",function(key)
{
    if (key == KEY_Z && active_GUI == false && sprintEnabled == false && Player_Sprint > 20)
    {
        sprintEnabled = true;
		sprintEnabled = getTickCount() + 50;
		callServerFunc("setSprintTest", heroId, true);
    }
})


/// Render do stopowoania i kontynuowania skryptu sprintu.

addEventHandler("onRender", function()
{
	if (renderTime < getTickCount())
	{
        if(sprintEnabled)
	    {
            if (!isKeyPressed(KEY_Z)) 
		    {
			    sprintEnabled = false;
			    stopSprintSystem();
			    return;
		    }
			
            if (Player_Sprint < 20) 
		    {
                sprintEnabled = false;
			    stopSprintSystem();
			    return;
		    }
			
		    Player_Sprint = Player_Sprint - 5;
			
		    renderTime = getTickCount() + 50;	
		    scaleBarToSprint();
		}
    }
});


/// Funkcje do sprintu.

function setSprintPlayer(val)
{
    Player_Sprint = val;
	scaleBarToSprint();
}

function scaleBarToSprint()
{
    local math1 = (Player_Sprint*950)/1000;
	setSprintBarSize(math1);
}

function stopSprintSystem()
{
    callServerFunc("setPlayerSprint", heroId, Player_Sprint);
	callServerFunc("setSprintTest", heroId, false);
}


/// Render do regeneracji sił witalnych!

addEventHandler("onRender", function()
{
	if (renderTimeRegeneration < getTickCount())
	{
        if (!sprintEnabled && Player_Sprint < 1000) 
		{			
		Player_Sprint = Player_Sprint + 10;		
        if(bonusFromHouse == true)
        {
            Player_Sprint = Player_Sprint + 10;	
        }			
		renderTimeRegeneration = getTickCount() + 10000;	
		scaleBarToSprint();
		callServerFunc("setPlayerSprint", heroId, Player_Sprint);
		}
    }
});


/// Callbacki do bonusu dla sprintu od bycia w domu!

addEventHandler("onPlayerEnterHouse", function(id, owner)
{
    if(owner == getPlayerName(heroId))
	{
	    bonusFromHouse = true;
	}
})

addEventHandler("onPlayerLeaveHouse", function(id, owner)
{
    if(bonusFromHouse)
	{
	    bonusFromHouse = false;
	}
})