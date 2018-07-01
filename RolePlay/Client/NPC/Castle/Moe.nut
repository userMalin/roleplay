
// By Quarchodron / CC(2018) / Made for RolePlay v.0.3

/// Dialog Manager With Moee

local dialogWithMoe = [
{name = "Can we trade", option = ["Choose something!"]},
{name = "U look preety strange..", option = ["Well that becouse i have lots of problems with rats. &They are everywhere.","They eating my snacks and fk piss me off!"]},
{name = "Goodbye Moe!", option = ["Bye stranger!"]}
];

local dialogMoe = createDialog(dialogWithMoe);

/// Trade With Moe!
local moelist = Gui.GridList(anx(410) , any(240), anx(540) , any(500), "MENU_INGAME.TGA", "Menu_Choice_Back.TGA", "MENU_INGAME.TGA", "BAR_HEALTH.TGA", "O.TGA", "U.TGA");
moelist.active = true;

local btn1 = Gui.Button(3135,5900,1900,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Zamknij");btn1.active = true;

local name = moelist.addColumn("Nazwa Przedmiotu", 400)
local price = moelist.addColumn("Cena", 100)

local moeTrade = [
    {instance = "ITMW_SHORTSWORD3", nazwa = "Short Sword", cena = 40},
    {instance = "ITAR_LEATHER_L", nazwa = "Leather Armor", cena = 100},
    {instance = "ITAR_MIL_L", nazwa = "Guard Light Armor", cena = 200},
    {instance = "ITAR_MIL_H", nazwa = "Guard Armor", cena = 350},
    {instance = "ITAR_PAL_M", nazwa = "Paladin Armor", cena = 1000},
    {instance = "ITMISWORDRAW", nazwa = "Steel", cena = 10}
];

foreach(v,k in moeTrade)
{
    moelist.addRow(name, k.nazwa);
    moelist.addRow(price, k.cena.tostring());
}



/// Moe Dialog Functions 

function showDialogMoe()
{
    dialogMoe.showDialog();
}

local function endDialogHandler(id, name)
{
    switch(name)
	{
	    case "Goodbye Moe!":
		    dialogMoe.hideDialog();
		    hideDialogInteraction();
		break;
	    case "Can we trade":
		    dialogMoe.hideDialog();
		    moelist.setVisible(true);
			btn1.setVisible(true);
		break;
	}
}

addEventHandler("onEndDialogOption" endDialogHandler)

local function btnHandler(button, btn, btnStatus)
{
    if(btnStatus == MOUSE_BOTTOM)
    {
        switch(button)
        {
            case btn1:
			    hideDialogInteraction();
		        moelist.setVisible(false);
			    btn1.setVisible(false);
            break;
        }
    }
}
addEventHandler("onButtonClick", btnHandler);

/// Sample trade With NPC (BUT IN 0.4 IT WILL BE MUCH MORE (for sure not in client))!

local function gridListHandler(gridId, val)
{
    if(gridId == moelist)
    {
        local goldzik = hasItem("ITMI_GOLD");
		if(goldzik >= moeTrade[val].cena)
		{
		    removeItem(heroId, "ITMI_GOLD", moeTrade[val].cena);
			giveItem(heroId, moeTrade[val].instance, 1);
		}
    }
}

addEventHandler("onGridList", gridListHandler)

/////////////////////////////////////////

local function renderLimitHandler()
{
    moelist.hover();
}
addEventHandler("onFPSLimit", renderLimitHandler)


//// We add interaction to NPC Moe!
addInteractionNPC("Moe NPC", showDialogMoe);