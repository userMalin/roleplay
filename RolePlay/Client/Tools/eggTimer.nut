// By Quarchodron / CC(2018) / Made for RolePlay v.0.2

/// Zmienne graficzne

local texture1 = Texture(2944,6312,2200,500, "Menu_Choice_Back.TGA");
local texture2 = Texture(2961,6352,2150,400, "Bar_Health.TGA");
local texture3 = Texture(2944,6904,2200,500, "Menu_Choice_Back.TGA");
local draw1 = Draw(3116,7032,""); draw1.font = "FONT_OLD_20_WHITE.TGA";

//// Zmienna przechowująca szerokość dodawaną co sekunde!

local plusSizeX = 0;
local secondsCount = 0;
local secondsRequiredCount = 0;

function startEggTimer(name, seconds)
{
    //// Włączmy ten egg Timer : 
    
	texture1.visible = true;
	texture2.visible = true;texture2.setSize(0, 400);
	texture3.visible = true;
	draw1.visible = true; draw1.text = name;
	
	/// Obliczenia
	
	plusSizeX = 2150/seconds;
	plusSizeX = plusSizeX.tointeger();
	secondsCount = 0;
	secondsRequiredCount = seconds;
	
	/// Timer
    
	setTimer(changeEggTimer, 1000, seconds);
}

function changeEggTimer()
{
    secondsCount = secondsCount + 1;
	texture2.setSize(texture2.getSize().width + plusSizeX, 400);
	
	if(secondsCount == secondsRequiredCount)
	{
	    callEvent("onEggTimerEnd", draw1.text, secondsRequiredCount);
	    texture1.visible = false;
	    texture2.visible = false;
	    texture3.visible = false;
	    draw1.visible = false;	
	}
}