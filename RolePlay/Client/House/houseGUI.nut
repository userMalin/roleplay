
// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

local canHeUseHouse = false;
local inSpecificHouse = -1;
local workingOnSlot = -1;
local workingOnSide = -1;

/// Menu obs³ugi domu!

local window = Gui.Manager();
local txt = window.node(Gui.Texture(2686,5750,2850,1700, "MENU_INGAME.TGA"));

local btn1 = window.element(Gui.Button(2891,6000,2400,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Otwórz Magazyn"));btn1.active = true;
local btn2 = window.element(Gui.Button(2891,6400,2400,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Odpocznij"));btn2.active = true;
local btn3 = window.element(Gui.Button(2891,6800,2400,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Powrót do Gry"));btn3.active = true;

/// Wyœwietlanie listy przedmiotów!

/// Moja lista Przedmiotów!

local mytradeList = Gui.GridList(184,1388,2750,4850, "MENU_INGAME.TGA", "Menu_Choice_Back.TGA", "MENU_INGAME.TGA", "BAR_HEALTH.TGA", "O.TGA", "U.TGA");
mytradeList.active = true;

local textNameMyList = Texture(184,1012,2750,350, "Menu_Choice_Back.TGA");
local drawNameMyList = Draw(722,1108,"Moje Przedmioty");

local name = mytradeList.addColumn("Nazwa Przedmiotu", 300);
local price = mytradeList.addColumn("Iloœæ", 100);


/// Lista Przedmiotów Magazynu!

local houseTList = Gui.GridList(5184,1388,2750,4850, "MENU_INGAME.TGA", "Menu_Choice_Back.TGA", "MENU_INGAME.TGA", "BAR_HEALTH.TGA", "O.TGA", "U.TGA");
houseTList.active = true;

local textNameHouseList = Texture(5184,1012,2750,350, "Menu_Choice_Back.TGA");
local drawNameHouseList = Draw(5722,1108,"Przedmioty w Domu");

local name2 = houseTList.addColumn("Nazwa Przedmiotu", 300);
local price2 = houseTList.addColumn("Iloœæ", 100);

/// Przyciski!

local podkladkaPodMenu = Gui.Texture(2686,6250,2850,1700, "MENU_INGAME.TGA");

local btnPrzeslij = Gui.Button(2891,6900,2400,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Przerzuæ");btnPrzeslij.active = true;
local btnZamknij = Gui.Button(2891,7300,2400,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Powrót do Gry");btnZamknij.active = true;
local inptIlosc = Gui.Input(2891,6500,2400,350, "Menu_Choice_Back.TGA", 15, INPUT.NUMBERS, ALIGN_CENTER, ".. iloœæ ", 5);

// Pokazywanie i zamyaknie GUI menu!

function openGUIHouse()
{
    showGUIManager(window);	
}

function closeGUIHouse()
{
    hideGUIManager(window);	
}


// Menu Magazyna!

function showMagazynMenu()
{
	local items = getEq();
	if(items.len() > 0)
	{
		foreach(item in items)
		{
            mytradeList.addRow(name, getItemName(item.instance));
            mytradeList.addRow(price, item.amount.tostring());
		}
	}
	
	/// Wyœwietla listê moich itemów!
	
	textNameMyList.visible = true;
	drawNameMyList.visible = true;drawNameMyList.top();
	
    mytradeList.setVisible(true);
	
	callServerFunc("sendRequestToSendMeItemsHouse", heroId, inSpecificHouse);
	
	/// Wyœwietla listê itemów domu!
	
	textNameHouseList.visible = true;
	drawNameHouseList.visible = true;drawNameHouseList.top();
	
    houseTList.setVisible(true);
	
	/// Wyœwietla buttony!
	
	podkladkaPodMenu.visible = true;

    btnPrzeslij.setVisible(true);	
    btnZamknij.setVisible(true);	
	inptIlosc.setVisible(true);
}

function hideMagazynMenu()
{
    mytradeList.removeAllRow();
    houseTList.removeAllRow();
	
	/// Wyœwietla listê moich itemów!
	
	textNameMyList.visible = false;
	drawNameMyList.visible = false;
	
    mytradeList.setVisible(false);
	
	/// Wyœwietla listê itemów domu!
	
	textNameHouseList.visible = false;
	drawNameHouseList.visible = false;
	
    houseTList.setVisible(false);
	
	/// Wyœwietla buttony!
	
	podkladkaPodMenu.visible = false;

    btnPrzeslij.setVisible(false);	
    btnZamknij.setVisible(false);	
	inptIlosc.setVisible(false);
}

// Dodawanie listy domu!

function addRowToGUIHouse(id, v)
{
    houseTList.addRow(name2, getItemName(id));
    houseTList.addRow(price2, v.tostring());   
}

// Pojawianie siê gui i jego znikanie zale¿nie od momentu!

local thenTimer = null;
local everythingReady = true;

function resetAllGrdListGUIHouse()
{
    mytradeList.removeAllRow();
    houseTList.removeAllRow();
	
	everythingReady = false;
	
	if(thenTimer != null)
	{
	    killTimer(thenTimer);
		thenTimer = null;
	}
	
	thenTimer = setTimer(addMyListAfterTime, 1000, 1);
	callServerFunc("sendRequestToSendMeItemsHouse", heroId, inSpecificHouse);
}

function addMyListAfterTime()
{
	local items = getEq();
	if(items.len() > 0)
	{
		foreach(item in items)
		{
            mytradeList.addRow(name, getItemName(item.instance));
            mytradeList.addRow(price, item.amount.tostring());
		}
	}	
	thenTimer = null;
	everythingReady = true;
}

// Callbacks!

addEventHandler("onPlayerEnterHouse", function(id, owner)
{
	if(owner == getPlayerName(heroId))
	{
	    canHeUseHouse = true;
		inSpecificHouse = id;
	}
})

addEventHandler("onPlayerLeaveHouse", function(id, owner)
{
	canHeUseHouse = false;
	inSpecificHouse = -1;
})

addEventHandler("onKey", function(key)
{
    if(key == KEY_P)
	{
		if(active_GUI == false && canHeUseHouse)
		{
	    	openGUIHouse();
		}
	}
})

addEventHandler("onButtonClick", function(button, btn, btnStatus)
{
    if(btnStatus == MOUSE_BOTTOM)
    {
        switch(button)
        {
            case btn1:
                window.visible(false);
				showMagazynMenu();
            break;
            case btn2:
			    playAni(heroId,"S_HGUARD");
                window.visible(false);
				startEggTimer("Wypoczywasz", 180);
            break;
            case btn3:
                hideGUIManager(window);	
            break;
			case btnZamknij:
			    hideMagazynMenu();
				hideGUIManager();	
			break;
			case btnPrzeslij:
			    local iloscDoPrzerzutu = inptIlosc.input.text.tointeger();
			    if(iloscDoPrzerzutu > 0 && everythingReady)
				{
			        if(workingOnSide == 1)
				    {
				        local slot = 0;
				        foreach(item in getEq())
		                {
		                    if(workingOnSlot == slot)
			                {
					            if(item.amount >= iloscDoPrzerzutu)
								{
								    removeItem(heroId,item.instance,iloscDoPrzerzutu);
									callServerFunc("addItemToHouse", inSpecificHouse, item.instance, iloscDoPrzerzutu, true);
									resetAllGrdListGUIHouse();
								}
				            }
							slot = slot + 1;
					    }
				    }
			        else if(workingOnSide == 2)
				    {
					    callServerFunc("tryToResendFromHousePlayer", heroId, inSpecificHouse, workingOnSlot, iloscDoPrzerzutu);
				    }
				}
			break;
        }
    }
});


addEventHandler("onEggTimerEnd", function(name, sec)
{
    if(name== "Wypoczywasz")
	{
        hideGUIManager();	 
		
	    Player_Sprint = Player_Sprint + 150;
		    if(Player_Sprint > 1000) { Player_Sprint = 1000;};
		
		scaleBarToSprint();
		callServerFunc("setPlayerSprint", heroId, Player_Sprint);
	}
});

addEventHandler("onGridList",function(gridId, val)
{
    if(gridId == mytradeList)
    {
		local slot = 0;
		foreach(item in getEq())
		{
		    if(val == slot)
			{
			    inptIlosc.setText(item.amount.tostring());
				workingOnSlot = slot;
				workingOnSide = 1;
			}
			slot = slot + 1;
		}
    }
    else if(gridId == houseTList)
    {
	    inptIlosc.setText("1");
        workingOnSlot = val;
		workingOnSide = 2;
    }
})
