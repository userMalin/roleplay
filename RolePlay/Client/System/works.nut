// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

local renderTime = getTickCount() + 1000;
local isAlredyInWater = false;

addEventHandler("onKey", function(key)
{
    if(key == KEY_P)
	{ 
	    if(active_GUI == false && isAlredyInWater)
		{
		    playAniRepeat(heroId,"T_PLUNDER",5000);
            showGUIManager();
			
			local timeToWork = 60;
			
			if(getProfession(PROFESSION.RYBAK) >= 0 && getProfession(PROFESSION.RYBAK) < 30)
			{ 
			    timeToWork = 60;
			}else if(getProfession(PROFESSION.RYBAK) >= 30 && getProfession(PROFESSION.RYBAK) < 60)
			{ 
			    timeToWork = 45;
			}else if(getProfession(PROFESSION.RYBAK) >= 60 && getProfession(PROFESSION.RYBAK) < 90)
			{ 
			    timeToWork = 30;
			}else if(getProfession(PROFESSION.RYBAK) >= 90)
			{ 
			    timeToWork = 15;
			}     
			
			startEggTimer("Lowienie Ryb", timeToWork);
		}
	}
});


addEventHandler("onEggTimerEnd", function(name, sec)
{
    if(name== "Lowienie Ryb")
	{
	    hideGUIManager();
		giveItem(heroId, "ITFO_FISH", 1);
		stopAniRepeat();
		
		if(getProfession(PROFESSION.RYBAK) < 100){
		    setProfession(PROFESSION.RYBAK, getProfession(PROFESSION.RYBAK) + 1);}
    }
});


addEventHandler("onRender", function()
{
	if (renderTime < getTickCount())
	{
        if(isInWater())
	    {
	        if(!isAlredyInWater)
			{
			    isAlredyInWater = true;
				showNotification("Aby ³owiæ ryby naciœnij klawisz P!");
			}
	    }
		else
		{
	        if(isAlredyInWater)
			{
			    isAlredyInWater = false;
			}		
		}
		
	renderTime = getTickCount() + 1000;
	}
});