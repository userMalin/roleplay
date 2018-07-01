// By Quarchodron / CC(2018) / Made for RolePlay v.0.2

/// Interakcja z mobami.

local function interactMob(pointer, start, end)
{
	local mob = MobInter("NULL");
	mob.ptr = pointer;
    print(mob.getVisual())
    if(end == 1)
	{
		switch(mob.getVisual())
		{
	   		case "OC_MOB_PAN":
                showGUIManager();
				startEggTimer("Pieczesz Miêso", 30);
			break;
	   		case "BSFIRE_OC":
                showGUIManager();
				startEggTimer("Rozgrzewasz Stal", 10);
			break;
	   		case "OC_MOB_CAULDRON":
                showGUIManager();
				showCraftKucharz();
			break;
	   		case "BS_ANVIL":
                showGUIManager();
				showCraftKowal();
			break;
		}
	}
	
	if(start == 1)
	{
		switch(mob.getVisual())
		{
	   		case "BS_ANVIL":
                callServerFunc("regiveHotSteal",heroId);
			break;
		}	
	}
}

addEventHandler("onMobInteract", interactMob);

/// Jak konczy sie timer np. dla kuchcenia.

local function endEggTimerHandler(name, sec)
{
    if(name== "Pieczesz Miêso")
	{
        hideGUIManager();
		callServerFunc("playerCookMeal", heroId);
    }else if(name== "Rozgrzewasz Stal")
	{
        hideGUIManager();   
		callServerFunc("playerUseSwordRaw", heroId);
	}
}

addEventHandler("onEggTimerEnd", endEggTimerHandler);