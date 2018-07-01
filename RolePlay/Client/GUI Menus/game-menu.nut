// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

//////// Menu samo w sobie!

local window = Gui.Manager();
local txt = window.node(Gui.Texture(2655,3016,2850,2050, "MENU_INGAME.TGA"));
local title = Gui.Draw(3185,2640, getHostname());
title.font = "FONT_OLD_20_WHITE_HI.TGA";
title.setPosition(2655 + 2850/2 - title.width/2, 2840);
window.element(title);

//////// Dodajemy te buttony do menu Gry!

local btn1 = window.element(Gui.Button(3135,3150,1900,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Wróæ do Gry"));btn1.active = true;
local btn2 = window.element(Gui.Button(3135,3600,1900,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Wygl¹d"));btn2.active = true;
local btn3 = window.element(Gui.Button(3135,4050,1900,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Pomoc"));btn3.active = true;
local btn4 = window.element(Gui.Button(3135,4500,1900,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "WyjdŸ z Gry"));btn4.active = true;

//////// Co sie stanie jak naciœniemy dany button :

local function btnHandler(button, btn, btnStatus)
{
    if(btnStatus == MOUSE_BOTTOM)
    {
        switch(button)
        {
            case btn1:
                    hideGUIManager(window);
                break;
            case btn2:
                    hideGUIManager(window);
					showWygladChange();
                break;
            case btn3:
                    hideGUIManager(window);
					showHelpMenu();
                break;
            case btn4:
                    exitGame();
                break;
        }
    }
}
addEventHandler("onButtonClick", btnHandler);

/////// Przywo³anie menu z Escape

local function keyHandler(key)
{
    if(key == KEY_ESCAPE)
	{
	    if(active_GUI == false)
		{
            showGUIManager(window);
		}
	}
}

addEventHandler("onKey", keyHandler)

/////// Dodajemy funkcje hover z GUI tomiego do renderu

local function renderLimitHandler()
{
    btn1.hover("MENU_INGAME.TGA");
    btn2.hover("MENU_INGAME.TGA");
    btn3.hover("MENU_INGAME.TGA");
    btn4.hover("MENU_INGAME.TGA");
}
addEventHandler("onFPSLimit", renderLimitHandler)
