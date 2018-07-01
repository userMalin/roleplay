// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

//// VOB który obserwuje otoczenie!?

local vobCamera = Vob("ENGINEQUARCHODRONA.3DS");
vobCamera.setPosition(-14096.3,2758.05,-30978.6);
vobCamera.setRotation(0, 64, 0);

//////// Menu samo w sobie!

local window = Gui.Manager();
local txt = window.node(Gui.Texture(2655,3016,2850,2050, "MENU_INGAME.TGA"));
local btn3 = window.element(Gui.Input(3135,3150,1900,350, "Menu_Choice_Back.TGA", 15, INPUT.TEXT, ALIGN_CENTER, "Nickname", 5));
local btn4 = window.element(Gui.Input(3135,3600,1900,350, "Menu_Choice_Back.TGA", 15, INPUT.PASSWORD, ALIGN_CENTER, "Has³o", 5));
local title = Gui.Draw(3185,2640, getHostname());
title.font = "FONT_OLD_20_WHITE_HI.TGA";
title.setPosition(2655 + 2850/2 - title.width/2, 2840);
window.element(title);

//////// Dodajemy te buttony do menu start!

local btn1 = window.element(Gui.Button(3135,4050,1900,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Logowanie"));
local btn2 = window.element(Gui.Button(3135,4500,1900,350, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "WyjdŸ z Gry"));
btn1.active = true;
btn2.active = true;

//////// Na wypadek b³êdu!

local textMessage = Texture(3135,5000,1900,350,"Menu_Choice_Back.TGA");
local drawMessage = Draw(3250, 5150, "");

//////// Funkcja do wyœwietlania tego szajsu!

local function startMenuGame()
{
	Camera.setTargetVob(vobCamera);
    freezeCam();
	window.visible(true);
	Chat.hide();
}

addEventHandler("onInit",startMenuGame);

//////// Tu spróbujemy siê zalogowaæ!

function tryToLoggIn()
{
    if(btn3.input.text.len() > 2)
	{
	    if(btn4.input.text.len() > 2)
	    {
		    if(btn3.input.text.find("NPC") == null)
			{
		    callServerFunc("tryToLoggMeIn", heroId, btn3.input.text, btn4.input.text);
			}
			else
		    {
			    showErrMessage(4);
			}
	    }
		else
	    {
	        showErrMessage(2);
	    }
	}else
	{
	    showErrMessage(1);
	}
}

//////// Zamyka logowanie GUI.

function hideLoggIn()
{
	window.visible(false);
	setFreeze(false);
	enableHud(HUD_ALL,true);
	setCursorVisible(false);
    textMessage.visible = false;
	drawMessage.visible = false;
	setVisibleGothicBar(true);
	setDefaultCamera();
	enableAllKeys()
	Chat.show();
	active_GUI = false;
}

///////// Co sie stanie jak naciœniemy button :

local function btnHandler(button, btn, btnStatus)
{
    if(btnStatus == MOUSE_BOTTOM)
    {
        switch(button)
        {
            case btn1:
                    tryToLoggIn();
                break;
            case btn2:
                    exitGame();
                break;
        }
    }
}
addEventHandler("onButtonClick", btnHandler)

/////// Dodajemy funkcje hover z GUI tomiego do renderu

local function renderLimitHandler()
{
    btn1.hover("MENU_INGAME.TGA");
    btn2.hover("MENU_INGAME.TGA");
    btn3.hover("MENU_INGAME.TGA");
    btn4.hover("MENU_INGAME.TGA");
}
addEventHandler("onFPSLimit", renderLimitHandler)

/////// Na wypadek b³êdu funkcja wyœwietlaj¹ca b³¹d.

function showErrMessage(arg)
{
    textMessage.visible = true;
	drawMessage.visible = true;
	
    switch(arg)
	{
	    case 1:
		    drawMessage.text = "Zbyt krótki nickname!";
		break;
		
		case 2:
		    drawMessage.text = "Zbyt krótkie has³o!";		
		break;
		
		case 3:
		    drawMessage.text = "Z³e has³o!";		
		break;
		
		case 4:
		    drawMessage.text = "Usun 'NPC' z nicku";		
		break;
	}
}