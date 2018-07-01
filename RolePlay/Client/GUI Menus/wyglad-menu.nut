// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

//////// Menu samo w sobie!

////// Zmienne do zmiany wygl¹du : 
local headmodel = ["Hum_Head_FatBald","Hum_Head_Fighter","Hum_Head_Pony","Hum_Head_Bald","Hum_Head_Thief","Hum_Head_Psionic","Hum_Head_Babe"];
local bodymodel = ["Hum_Body_Naked0","Hum_Body_Babe0"];

local bodyTexture = 0;
local headTexture = 0;

/////// GUI od tomiego :

local window = Gui.Manager();
local txt = window.node(Gui.Texture(191,4264,1750,2350, "MENU_INGAME.TGA"));

local btn1 = window.element(Gui.Button(568,4470,1000,300, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "G³owa"));
local btn2 = window.element(Gui.Button(568,4870,1000,300, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Twarz"));
local btn3 = window.element(Gui.Button(568,5270,1000,300, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Cia³o"));
local btn4 = window.element(Gui.Button(568,5670,1000,300, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "Skóra"));
local btn5 = window.element(Gui.Button(568,6170,1000,300, "Menu_Choice_Back.TGA", "FONT_OLD_10_WHITE_HI.TGA", "WyjdŸ"));

local btn1left = window.element(Gui.Button(293,4512,200,150, "L.TGA", "FONT_OLD_10_WHITE_HI.TGA", ""));
local btn2left = window.element(Gui.Button(293,4912,200,150, "L.TGA", "FONT_OLD_10_WHITE_HI.TGA", ""));
local btn3left = window.element(Gui.Button(293,5312,200,150, "L.TGA", "FONT_OLD_10_WHITE_HI.TGA", ""));
local btn4left = window.element(Gui.Button(293,5712,200,150, "L.TGA", "FONT_OLD_10_WHITE_HI.TGA", ""));

local btn1right = window.element(Gui.Button(1631,4512,200,150, "R.TGA", "FONT_OLD_10_WHITE_HI.TGA", ""));
local btn2right = window.element(Gui.Button(1631,4912,200,150, "R.TGA", "FONT_OLD_10_WHITE_HI.TGA", ""));
local btn3right = window.element(Gui.Button(1631,5312,200,150, "R.TGA", "FONT_OLD_10_WHITE_HI.TGA", ""));
local btn4right = window.element(Gui.Button(1631,5712,200,150, "R.TGA", "FONT_OLD_10_WHITE_HI.TGA", ""));

/////// Aktywujemy te wszystkie buttony : 

btn5.active = true;
btn1left.active = true;
btn2left.active = true;
btn3left.active = true;
btn4left.active = true;
btn1right.active = true;
btn2right.active = true;
btn3right.active = true;
btn4right.active = true;


////// Funkcja do pokazania tej zmiany wygl¹du.

function showWygladChange()
{
	setCameraBeforePlayer();
    showGUIManager(window);
}

/////// Co sie stanie jak naciœniemy dany przycisk : 

local function btnHandler(button, btn, btnStatus)
{
    if(btnStatus == MOUSE_BOTTOM)
    {
	local wyglad = getPlayerVisual(heroId);
        switch(button)
        {
            case btn1left:
			        if(bodyTexture > 0)
					    bodyTexture = bodyTexture - 1;
						
                    setPlayerVisual(heroId, wyglad.bodyModel, wyglad.bodyTxt, headmodel[bodyTexture], wyglad.headTxt);
                break;
            case btn1right:
					if(bodyTexture < 7)
					    bodyTexture = bodyTexture + 1;
						
                    setPlayerVisual(heroId, wyglad.bodyModel, wyglad.bodyTxt, headmodel[bodyTexture], wyglad.headTxt);
                break;
            case btn2left:
			        if(wyglad.headTxt > 0)
					    wyglad.headTxt = wyglad.headTxt - 1;
						
                    setPlayerVisual(heroId, wyglad.bodyModel, wyglad.bodyTxt, wyglad.headModel, wyglad.headTxt);
                break;
            case btn2right:
					if(wyglad.headTxt < 160)
					    wyglad.headTxt = wyglad.headTxt + 1;
						
                    setPlayerVisual(heroId, wyglad.bodyModel, wyglad.bodyTxt, wyglad.headModel, wyglad.headTxt);
                break;
            case btn3left:
			        headTexture = 0;
                    setPlayerVisual(heroId, bodymodel[0], wyglad.bodyTxt, wyglad.headModel, wyglad.headTxt);
                break;
            case btn3right:	
                    headTexture = 1;			
                    setPlayerVisual(heroId, bodymodel[1], wyglad.bodyTxt, wyglad.headModel, wyglad.headTxt);
                break;
            case btn4left:
			        if(wyglad.bodyTxt > 0)
					    wyglad.bodyTxt = wyglad.bodyTxt - 1;
						
                    setPlayerVisual(heroId, wyglad.bodyModel, wyglad.bodyTxt, wyglad.headModel, wyglad.headTxt);
                break;
            case btn4right:
					if(wyglad.bodyTxt < 12)
					    wyglad.bodyTxt = wyglad.bodyTxt + 1;
						
                    setPlayerVisual(heroId, wyglad.bodyModel, wyglad.bodyTxt, wyglad.headModel, wyglad.headTxt);
                break;
            case btn5:
                    hideGUIManager(window);
					callServerFunc("setPlayerVisual", heroId, headTexture, wyglad.bodyTxt, bodyTexture, wyglad.headTxt);
                break;
        }
    }
}
addEventHandler("onButtonClick", btnHandler)