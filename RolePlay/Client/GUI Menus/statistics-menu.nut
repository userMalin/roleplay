
// By Quarchodron / CC(2018) / Made for RolePlay v.0.3

local activeMenu = false;

//////////////////////////////

local window = Gui.Manager();
window.node(Gui.Texture(2040,1976,4000,4450, "MENU_INGAME.TGA"));

//////////////////////////////

window.element(Gui.Texture(2251,2640,1650,1490, "MENU_INGAME.TGA"));
window.element(Gui.Texture(4127,2640,1660,1490, "MENU_INGAME.TGA"));
window.element(Gui.Texture(2251,4728,3580,1460, "MENU_INGAME.TGA"));

window.element(Gui.Button(2277,2360,1600,250, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Statystyki Podstawowe"));
window.element(Gui.Button(4146,2360,1600,250, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Umiejêtnoœci Walki"));
window.element(Gui.Button(2277,4424,3500,250, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Umiejêtnoœci Dodatkowe"));

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

local Basic_Statistics = [
window.element(Gui.Draw(2373,2744, "Si³a : ")),
window.element(Gui.Draw(2373,2944, "Zrêcznoœæ : ")),
window.element(Gui.Draw(2373,3144, "Punkty Trafieñ : ")),
window.element(Gui.Draw(2373,3344, "Level : ")),
window.element(Gui.Draw(2373,3544, "Doœwiadczenie : ")),
];

//////////////////////////////

local Fight_Statistics = [
window.element(Gui.Draw(4223,2744, "Walka 1H : ")),
window.element(Gui.Draw(4223,2944, "Walka 2H : ")),
window.element(Gui.Draw(4223,3144, "Walka £ukiem : ")),
window.element(Gui.Draw(4223,3344, "Walka Kusz¹ : ")),
];

//////////////////////////////

local Profession_Statistics = [
window.element(Gui.Draw(2373,4780, "Walka 1H : ")),
window.element(Gui.Draw(2373,4980, "Walka 2H : ")),
window.element(Gui.Draw(2373,5180, "Walka £ukiem : ")),
window.element(Gui.Draw(2373,5380, "Walka Kusz¹ : ")),
window.element(Gui.Draw(4223,4780, "Walka 1H : ")),
window.element(Gui.Draw(4223,4980, "Walka 2H : ")),
window.element(Gui.Draw(4223,5180, "Walka £ukiem : ")),
window.element(Gui.Draw(4223,5380, "Walka Kusz¹ : ")),
];

//////////////////////////////

local function keyHandler(key)
{
    if(key == KEY_B)
	{
	    if(active_GUI == false)
		{
            showGUIManager(window);
			activeMenu = true;
			updateStatistics();
		}else if(active_GUI == true)
		{
		    if(activeMenu == true)
			{
			    activeMenu = false;
                hideGUIManager(window);	
			}
		}
	}
	
	if(key == KEY_ESCAPE)
	{
	    if(activeMenu)
		{
		    activeMenu = false;
            hideGUIManager(window);				
		}
	}
}

addEventHandler("onKey", keyHandler);

//////////////////////////////

function updateStatistics()
{
    Basic_Statistics[0].text = "Si³a : "+getPlayerStrength(heroId);
    Basic_Statistics[1].text = "Zrêcznoœæ : "+getPlayerDexterity(heroId);
    Basic_Statistics[2].text = "¯ycie : "+getPlayerHealth(heroId) + " / " + getPlayerMaxHealth(heroId);
    Basic_Statistics[3].text = "Poziom Postaci : "+getLevel();
    Basic_Statistics[4].text = "Exp : "+getExp()+"/"+getNextLevelExp();
    Fight_Statistics[0].text = "Walka 1H : "+getPlayerSkillWeapon(heroId,0);
    Fight_Statistics[1].text = "Walka 2H : "+getPlayerSkillWeapon(heroId,1);
    Fight_Statistics[2].text = "Walka £ukiem : "+getPlayerSkillWeapon(heroId,2);
    Fight_Statistics[3].text = "Walka Kusz¹ : "+getPlayerSkillWeapon(heroId,3);
    Profession_Statistics[0].text = "Kowal : "+getProfession(PROFESSION.KOWAL);
    Profession_Statistics[1].text = "Alchemik : "+getProfession(PROFESSION.ALCHEMIK);
    Profession_Statistics[2].text = "Kucharz : "+getProfession(PROFESSION.KUCHARZ);
    Profession_Statistics[3].text = "Drwal : "+getProfession(PROFESSION.DRWAL);
    Profession_Statistics[4].text = "Myœliwy : "+getProfession(PROFESSION.MYSLIWY);
    Profession_Statistics[5].text = "Rybak : "+getProfession(PROFESSION.RYBAK);
    Profession_Statistics[6].text = "Z³odziej : "+getProfession(PROFESSION.ZLODZIEJ);
    Profession_Statistics[7].text = "Bimbrownik : "+getProfession(PROFESSION.BIMBROWNIK);
}	