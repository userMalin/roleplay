// By Quarchodron / CC(2018) / Made for RolePlay v.0.2

local window = Gui.Manager();
local txt = window.node(Gui.Texture(2252,6576,3450,1500, "MENU_INGAME.TGA"));
local txt2 = window.element(Gui.Texture(2935,5960,2200,500, "Menu_Choice_Back.TGA"));
local btndo = window.element(Gui.Button(2418,7664,900,300, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Wykonaj"));btndo.active = true;
local btnexit = window.element(Gui.Button(4625,7664,900,300, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Zakoñcz"));btnexit.active = true;

//// Ta lista z craftem sie tu wyœwietla :

local kraftowa_lista = null;
local drawlist = {};
local openedIdKraft = 0;

local ProfesjaDr = "Kowal";
local ProfesjaOnFile = PROFESSION.KOWAL;

////////////////////////////////////////////

drawlist[0] <- window.element(Gui.Draw(2443,6800, ""));
drawlist[1] <- window.element(Gui.Draw(2443,6950, ""));
drawlist[2] <- window.element(Gui.Draw(2443,7100, ""));
drawlist[3] <- window.element(Gui.Draw(2443,7350, ""));
drawlist[4] <- window.element(Gui.Draw(2443,7500, ""));
drawlist[5] <- window.element(Gui.Draw(2443,7650, ""));

//// Napis przedmiotu : 

local drawNapis = window.element(Gui.Draw(3166,6080, ""));
drawNapis.font = "FONT_OLD_20_WHITE.TGA";

//// Samo menu z craftem!

local gridlist = window.element(Gui.GridList(2225,2680,3450,3150, "MENU_INGAME.TGA", "MENU_INGAME.TGA", "DLG_CONVERSATION.TGA", "BAR_HEALTH.TGA", "O.TGA", "U.TGA"));
gridlist.active = true;

local lvl = gridlist.addColumn("Poziom", 100)
local kraftnazwa = gridlist.addColumn("Przedmiot", 450)

window.move = false;


addEventHandler("onInit", function()
{

////////////////////////////////////////////////////////////

/// Lista kraftowa!

////////////////////////////////////////////////////////////

    kraftowa_lista = [
        {level =  0, nazwa = "Strza³y x 5", czas = 60, craft = addCraft([ ["ITMISWORDRAWHOT",1], ["ITMW_1H_BAU_MACE", 1] ],[ ["ITRW_ARROW",5] ])},
        {level =  0, nazwa = "Be³ty x 5", czas = 60, craft = addCraft([ ["ITMISWORDRAWHOT",1],["ITMW_1H_BAU_MACE", 1] ],[ ["ITRW_BOLT",1] ])},
        {level =  0, nazwa = "Krótki Miecz", czas = 60, craft = addCraft([ ["ITMISWORDRAWHOT",1],["ITMW_1H_BAU_MACE", 1],["ITMI_COAL", 1],["ITMI_ROCKCRYSTAL", 1] ],[ ["ITMW_SHORTSWORD3",1] ])},
    ];

////////////////////////////////////////////////////////////

/// Lista kraftowa!

////////////////////////////////////////////////////////////

//// Dodajemy do listy pola

    foreach(i, k in kraftowa_lista)
    {
        gridlist.addRow(lvl, k.level.tostring())
        gridlist.addRow(kraftnazwa, k.nazwa)
    }

});

function showCraftKowal()
{
    window.visible(true);
    foreach(v in drawlist)
    {
	    v.text = "";
		v.setColor(255,255,255);
    }
		
    drawNapis.text = kraftowa_lista[0].nazwa; 
        
    local id = 0;
    foreach(item, amount in kraftowa_lista[0].craft.getSource())
    {
	    drawlist[id].text = getItemName(item) + " w ilosci "+amount;
	    id = id + 1;
    }
	openedIdKraft = 0;
}

/////////////////////////////////////////////////

////// Callbacksy

local function renderLimitHandler()
{
    btndo.hover("MENU_INGAME.TGA");
	btnexit.hover("MENU_INGAME.TGA");
	gridlist.hover();
}

//// Po naciœniêciu buttona

addEventHandler("onFPSLimit", renderLimitHandler)

local function btnHandler(button, btn, btnStatus)
{
    if(btnStatus == MOUSE_BOTTOM)
    {
        switch(button)
        {
            case btnexit:
                hideGUIManager(window);	
            break;
            case btndo:
			    if((getProfession(ProfesjaOnFile)) >= kraftowa_lista[openedIdKraft].level)
				{
				    if(Player_Sprint > 100)
					{
                        kraftowa_lista[openedIdKraft].craft.execute();
					}else{
					    showNotification("Jesteœ zbyt zmêczony!");
					}
				}else{
				    showNotification("Wymagany poziom umiejêtnoœci : "+kraftowa_lista[openedIdKraft].level);
				}
            break;
        }
    }
}
addEventHandler("onButtonClick", btnHandler);

/// Próbujemy wycraftowaæ dany przedmiot

local function callCraftHandler(instance, udane)
{
    foreach(v,k in kraftowa_lista)
	{
	    if(k.craft == instance)
		{
		    if(udane == false)
            {
                local id = 0;
                foreach(item, amount in k.craft.getSource())
                {
                    local hasthisitem = hasItem(item)
					if(hasthisitem >= amount)
					{
					    drawlist[id].setColor(0,200,0);
					}else{
					    drawlist[id].setColor(200,0,0);
					}
                    id = id + 1;
                }		    
            }else if(udane == true)
            {
                window.visible(false);
				startEggTimer("Kujesz Broñ", k.czas);
				
				// Nadajemy na plus profesjê je¿eli jest w zakresie naszych umiejêtnoœci.
			    if((getProfession(ProfesjaOnFile) - 30) <= k.level)
		        {
				    setProfession(ProfesjaOnFile, getProfession(ProfesjaOnFile) + 1)
				}
            }

            break;			
		}
	}
}

addEventHandler("onCallCraft", callCraftHandler);

//// Nacisniêcie na przycisk w liœcie powoduje :

local function gridListHandler(gridId, val)
{
    if(gridId == gridlist)
    {
	    foreach(v in drawlist)
		{
		    v.text = "";
			v.setColor(255,255,255);
		}
		
		openedIdKraft = val;
		drawNapis.text = kraftowa_lista[val].nazwa; 
        
		local id = 0;
        foreach(item, amount in kraftowa_lista[val].craft.getSource())
		{
			drawlist[id].text = getItemName(item) + " w ilosci "+amount;
		    id = id + 1;
		}
    }
}

addEventHandler("onGridList", gridListHandler)

//// Jak siê koñczy oczekiwanie!

local function endEggTimerHandler(name, sec)
{
    if(name== "Kujesz Broñ")
	{
        hideGUIManager();
	    Player_Sprint = Player_Sprint - 100;
		    if(Player_Sprint < 0) { Player_Sprint = 0;};
		
		scaleBarToSprint();
		callServerFunc("setPlayerSprint", heroId, Player_Sprint);		
	}
}

addEventHandler("onEggTimerEnd", endEggTimerHandler);