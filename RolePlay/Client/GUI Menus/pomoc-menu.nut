// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

//////// Menu samo w sobie!

local window = Gui.Manager();
local txt = window.node(Gui.Texture(2655,3016,2850,2050, "MENU_INGAME.TGA"));
local title = Gui.Draw(3185,2640, getHostname() + " Pomoc");
title.font = "FONT_OLD_20_WHITE_HI.TGA";
title.setPosition(2655 + 2850/2 - title.width/2, 2840);
window.element(title);

////// Te Napisy co mo¿esz zmieniæ!

window.element(Gui.Draw(2785,3150, "Pomoc do uzupelnienia!"));
window.element(Gui.Draw(2785,3350, "Pomoc do uzupelnienia!"));
window.element(Gui.Draw(2785,3550, "Pomoc do uzupelnienia!"));
window.element(Gui.Draw(2785,3750, "Pomoc do uzupelnienia!"));
window.element(Gui.Draw(2785,3950, "Pomoc do uzupelnienia!"));
window.element(Gui.Draw(2785,4150, "Pomoc do uzupelnienia!"));
window.element(Gui.Draw(2785,4350, "Pomoc do uzupelnienia!"));

//// Button do zamykanie GUI

local btn1 = window.element(Gui.Button(3135,4600,1900,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Powrót do Gry"));btn1.active = true;

///// Funkcje do zamykania, otwierania GUI pomocy!

function showHelpMenu()
{
    showGUIManager(window);	
}

local function btnHandler(button, btn, btnStatus)
{
    if(btnStatus == MOUSE_BOTTOM)
    {
        switch(button)
        {
            case btn1:
                    hideGUIManager(window);	
                break;
        }
    }
}
addEventHandler("onButtonClick", btnHandler);

/////// Dodajemy funkcje hover z GUI tomiego do renderu

local function renderLimitHandler()
{
    btn1.hover("MENU_INGAME.TGA");
}
addEventHandler("onFPSLimit", renderLimitHandler)
