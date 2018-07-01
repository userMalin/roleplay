
// By Quarchodron / CC(2018) / Made for RolePlay v.0.2

///// Najwazniejsze!

local hasloDoWB = "test";

///// Ta czêœæ z GUI i innymi pierdo³ami!

local window = Gui.Manager();
window.node(Gui.Texture(287,6552,2050,1200, "MENU_INGAME.TGA"));
window.element(Gui.Texture(434,6656,1750,250,"Menu_Choice_Back.TGA"));
local zmienkolizje = window.element(Gui.CheckBox(1163,7320,200,200, "Menu_Slider_Pos.TGA", "Menu_Slider_Pos.TGA"));zmienkolizje.active = true;
local zmienpomoc = window.element(Gui.CheckBox(1911,7304,240,160, "O.TGA", "U.TGA"));zmienpomoc.active = true;
local pomocDraw = Draw(100, 7850, "Pomoc : home - zapisz i wyjdz. end - wyjdz. W/S/A/D - poruszanie. Lewy/prawy - zmiana voba. Q/E - góra/dó³. Enter - rozstawienie voba!");
local pomocDraw2 = Draw(100, 8000, "Numprady 4,6,2,8,7,1 - rotacja. K/L - zmiana prêdkoœci poruszania. Delete usuwa voba ostatniego.");
local nazwavobDraw = window.element(Gui.Draw(479, 6712, ""));
local pozycjaDraw = window.element(Gui.Draw(383,7000, ""));
local rotacjaDraw = window.element(Gui.Draw(383, 7176, ""));
local kolizjaDraw = window.element(Gui.Draw(383, 7352, "Kolizja : Nie"));
local predkoscDraw = window.element(Gui.Draw(383, 7552, "Predkosc : Nie"));

local kolizjaTryb = 0;

///// Ta czêœæ z world builderem w koncu!

worldBuilder <- {
    actualID = -1,
	vobTable = [],
	speedMoving = 10,
	operationVob = null,
	onWB = false
}

function worldBuilder::start()
{
    ///// W³¹czamy ten cholerny world builder!

    actualID = 0;
	speedMoving = 10;
	vobTable.clear();
	operationVob = Vob(vobInstance[actualID]);
	local pos = getPlayerPosition(heroId);
	operationVob.setPosition(pos.x, pos.y, pos.z + 150);
	onWB = true;
	operationVob.collision = false;
	
	///// Pokazujemy GUI tego voba.
	
	window.visible(true);
	updateGUIDraws();
	
	///// Reszta krapu który wy³¹czamy przy ka¿dym menu!
	Camera.setTargetVob(operationVob);
    enableHud(HUD_HEALTH_BAR,false);
    setFreeze(true);
    setCursorVisible(true);
    active_GUI = true;
	Chat.hide();
}

function worldBuilder::close()
{
    ////// Wylaczamy WB i kasujemy voby!
 
    actualID = 0;
	vobTable.clear();
	operationVob = null;
	onWB = false;
	
	///// Wylaczamy GUI
	
    pomocDraw.visible = false;
    pomocDraw2.visible = false;
	window.visible(false);
	
	///// Reszta krapu który wlaczamy po zakonczeniu prac z kazdym menu!
	
	setDefaultCamera();
    enableHud(HUD_HEALTH_BAR,true);
    setFreeze(false);
    setCursorVisible(false);
    active_GUI = false;
	Chat.show();
}

////// Funkcje uzupelniajace GUI

function worldBuilder::updateGUIDraws()
{
    kolizjaDraw.text = "Kolizja : Nie";
	nazwavobDraw.text = setStringOnMaxChar(vobInstance[actualID], 22);
	predkoscDraw.text = "Prêdkoœæ : "+speedMoving;
	pozycjaDraw.text = "Pozycja : "+ operationVob.getPosition().x + "," + operationVob.getPosition().y + "," + operationVob.getPosition().z;
	rotacjaDraw.text = "Rotacja : "+ operationVob.getRotation().x + "," + operationVob.getRotation().y + "," + operationVob.getRotation().z;
    
    if(kolizjaTryb == 0)
    {
        kolizjaDraw.text = "Kolizja : Nie";
    }
    else if(kolizjaTryb == 1)
    {
        kolizjaDraw.text = "Kolizja : Tak";
    }	
    else if(kolizjaTryb == 2)
    {
        kolizjaDraw.text = "Kolizja : Budownicza";
    }	
}

////// Sterowanie 

function worldBuilder::keyHandler(key)
{
	local position = operationVob.getPosition();
	local rotation = operationVob.getRotation();
	
    switch(key)
	{
		case KEY_J:    // Change speedMoving!
	        speedMoving = speedMoving + 3; if(speedMoving > 100) {speedMoving = 100}						
		break;
		case KEY_K:    // Slow down cowboy!
	        speedMoving = speedMoving - 3; if(speedMoving < 0) {speedMoving = 1}					
		break;
		case KEY_W: // Move forward vob using rotation
	        position.x = position.x - (sin(rotation.y * 3.14 / 180.0) * speedMoving);
	        position.z = position.z - (cos(rotation.y * 3.14 / 180.0) * speedMoving);					
	    break;
	    case KEY_S: // Move back vob using rotation
	        position.x = position.x + (sin(rotation.y * 3.14 / 180.0) * speedMoving);
	        position.z = position.z + (cos(rotation.y * 3.14 / 180.0) * speedMoving);				
	    break;
	    case KEY_A: // Move left vob using rotation
	        position.x = position.x + (sin(((rotation.y - 90) - floor(rotation.y / 360) * 360) * 3.14 / 180.0) * speedMoving);
	        position.z = position.z + (cos(((rotation.y - 90) - floor(rotation.y / 360) * 360) * 3.14 / 180.0) * speedMoving);			
	    break;
	    case KEY_D: // Move right vob using rotation
	        position.x = position.x + (sin(((rotation.y + 90) - floor(rotation.y / 360) * 360) * 3.14 / 180.0) * speedMoving);
	        position.z = position.z + (cos(((rotation.y + 90) - floor(rotation.y / 360) * 360) * 3.14 / 180.0) * speedMoving);				
	    break;
	    case KEY_Q: // Move up vob
	        position.y = position.y + speedMoving;		
	    break;
	    case KEY_E: // Move down vob
	        position.y = position.y - speedMoving;		
	    break;
	    case KEY_NUMPAD7: // Change rotation
            rotation.y = rotation.y + speedMoving;			
	    break;
	    case KEY_NUMPAD1: // Change rotation
            rotation.y = rotation.y - speedMoving;				
	    break;
	    case KEY_NUMPAD4: // Change rotation
            rotation.z = rotation.z + speedMoving;					
	    break;
	    case KEY_NUMPAD6: // Change rotation
            rotation.z = rotation.z - speedMoving;				
	    break;	
	    case KEY_NUMPAD8: // Change rotation
            rotation.x = rotation.x + speedMoving;					
	    break;
	    case KEY_NUMPAD2: // Change rotation
            rotation.x = rotation.x - speedMoving;			
	    break;
	    case KEY_RIGHT: // Change vob + 1
            actualID = actualID + 1; if(actualID > vobInstance.len()) { actualID = 0 }
	        operationVob.setVisual(vobInstance[actualID]);		
            Camera.setTargetVob(operationVob);			
	    break;
	    case KEY_LEFT: // Change vob - 1
            actualID = actualID - 1; if(actualID < 0) {actualID = vobInstance.len() - 2;}
	        operationVob.setVisual(vobInstance[actualID]);	
            Camera.setTargetVob(operationVob);			
	    break;
	    case KEY_END: // Exit World Builder
            close();
            return;			
	    break;
	    case KEY_RETURN: // Place Vob
            placeVob();
            return;			
	    break;
	    case KEY_DELETE: // Remove Last Vob
            deleteVob();
            return;			
	    break;
	    case KEY_HOME: // save and excit
		    foreach(v,k in vobTable)
			{
				local pos = k.vob.getPosition();
				local rot = k.vob.getRotation();
				local kolizja = 1;	
			    if(kolizjaTryb == 0)
				{
			    	local kolizja = 0;
                }					
			    callServerFunc("addThisVobToMap",pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, kolizja, k.nazwa, getPlayerName(heroId))
			}
			callServerFunc("saveWBMap")
            close();
            return;			
	    break;
	}
	
	operationVob.setPosition(position.x, position.y, position.z);
	operationVob.setRotation(rotation.x, rotation.y, rotation.z);
	
	updateGUIDraws();
}

////// Stawianie usuwanie vobów!

function worldBuilder::placeVob()
{
	local pos = operationVob.getPosition();
	local rotation = operationVob.getRotation();
	local col = operationVob.collision;	
	local nazwa = vobInstance[actualID];
	
	if(kolizjaTryb == 2)
	{
	    col = true;
	}
	
    local id = vobTable.len();
    vobTable.append({vob = Vob(nazwa), nazwa = nazwa});
	vobTable[id].vob.setPosition(pos.x, pos.y, pos.z);
	vobTable[id].vob.setRotation(rotation.x, rotation.y, rotation.z);
    vobTable[id].vob.collision = col;
	pos.x = pos.x + (sin(((rotation.y + 90) - floor(rotation.y / 360) * 360) * 3.14 / 180.0) * speedMoving);
	pos.z = pos.z + (cos(((rotation.y + 90) - floor(rotation.y / 360) * 360) * 3.14 / 180.0) * speedMoving);	
	operationVob.setPosition(pos.x, pos.y, pos.z);
	Camera.setTargetVob(operationVob);
	updateGUIDraws();
}

function worldBuilder::deleteVob()
{
    if(vobTable.len() > 0)
    vobTable.remove(vobTable.len()-1);
}


////// Callbacksy do GUI

addEventHandler("onCheckBox", function(instance, status)
{
    if(worldBuilder.onWB == true)
	{
        switch(instance)
		{
		    case zmienkolizje:
			    kolizjaTryb = kolizjaTryb + 1;
			    if(kolizjaTryb == 0 || kolizjaTryb == 2)
				{
				    status = false;
				}
			    else if(kolizjaTryb == 1)
				{
				    status = true;
				}
				else if(kolizjaTryb == 3)
				{
				    kolizjaTryb = 0;
					status = false;
				}
			    worldBuilder.operationVob.collision = status;
				worldBuilder.updateGUIDraws();
			break;
			
			case zmienpomoc:
			    pomocDraw.visible = status;
			    pomocDraw2.visible = status;
			break;
		}
	}
});

addEventHandler("onKey", function(key)
{
    if(worldBuilder.onWB == true && !chatInputIsOpen())
	{
	    worldBuilder.keyHandler(key);
	}
});

function startWorldBuilder(params)
{
 	local args = sscanf("s", params);
	if (!args)
	{
	    addMessage(255,255,255,"/wb <haslo>");
	    return;	
	}
	
    local haslo = args[0];
	
	if (haslo != hasloDoWB)
	{
	    addMessage(255,255,255,"Zle haslo do wb!");
	    return;	
	}

	if(active_GUI == true)
	{
	    addMessage(255,255,255,"Nie podczas pracy na GUI!");
	    return;	
    }	
	
	active_GUI = true;
	
	setTimer(timeOutWB, 500, 1);
}

addCommand("wb", startWorldBuilder);

function timeOutWB()
{
	worldBuilder.start();
}
