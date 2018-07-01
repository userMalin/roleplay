//cc(2018); By Quarchodron

/*
    Author : Quarchodron
	Version : 0.4
	Name : RolePlay
	CC(2018)
*/


function onInitGameMode()
{

}

addEventHandler("onInit",onInitGameMode);


/*
===============================================
       Callbacksy i inne takie :).
===============================================
*/


function onPlayerEnterGame(pid)
{
    setPlayerName(pid, "Niezalogowany Gracz " +pid);
}

addEventHandler("onPlayerJoin",onPlayerEnterGame);

//-------------------------------------------------------------

function onPlayerRespawnAD(pid)
{
    setPlayerPosition(pid, -10774.3,-1071.17,6935.86);
    if(getPlayerLogin(pid) == true)
	{ 
	    spawnPlayer(pid);
	}
}

addEventHandler("onPlayerRespawn",onPlayerRespawnAD);

//-------------------------------------------------------------

function onPlayerLeaveGame(pid, rs)
{
    if(getPlayerLogin(pid) == true)
	{
	    saveAccount(pid);
		saveItems(pid);
		saveFileProfession(pid);
	}
	
	resetPlayerStatistics(pid);
	clearPlayerEquipment(pid);
	resetPlayerExtraStatistics(pid);
	resetPlayerProfession(pid);
}

addEventHandler("onPlayerDisconnect",onPlayerLeaveGame);

//-------------------------------------------------------------

function messageHandler(pid, message)
{
    local pos = getPlayerPosition(pid);
	for (local i = 0; i < getMaxSlots(); i++)
	{
		if(isPlayerConnected(i))
		{
		    local pos2 = getPlayerPosition(i);
		    if (getDistance3d(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) <= 1000)
    		if(message.len() < 50)
			{
			sendMessageToPlayer(i, 255, 255, 255, getPlayerName(pid) +" mówi: "+message);
			}else if(message.len() < 120 ){
			local message1 = message.slice(0, 50);
			local message2 = message.slice(50);
			sendMessageToPlayer(i, 255, 255, 255, getPlayerName(pid) +" mówi: "+message1);
			sendMessageToPlayer(i, 255, 255, 255, ".."+message2);
			}else if(message.len() > 120){	
			local message1 = message.slice(0, 50);
			local message2 = message.slice(50,120);
			local message3 = message.slice(120);
			sendMessageToPlayer(i, 255, 255, 255, getPlayerName(pid) +" mówi: "+message1);
			sendMessageToPlayer(i, 255, 255, 255, ".."+message2);			
			sendMessageToPlayer(i, 255, 255, 255, ".."+message3);	
			}
		}
	}
}

addEventHandler("onPlayerMessage", messageHandler);

/*
===============================================
     Funkcje uzupe³niaj¹ce do ca³ego gm.
===============================================
*/

function irand(max) 
{
    // Generate a pseudo-random integer between 0 and max
    local roll = (1.0 * rand() / RAND_MAX) * (max + 1);
    return roll.tointeger();
}

function numberIsBetween(number, one, two)
{
    if(number >= one && number <= two)
	{
	    return true;
	}
	return false;
}


function messageDistance(pid, message, distance, r, g, b, tag,sufix)
{
    local pos = getPlayerPosition(pid);
	for (local i = 0; i < getMaxSlots(); i++)
	{
		if(isPlayerConnected(i))
		{
		    local pos2 = getPlayerPosition(i);
		    if (getDistance3d(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) <= distance)
    		if(message.len() < 50)
			{
			sendMessageToPlayer(i, r, g, b, tag+""+message +""+sufix);
			}else if(message.len() < 120 ){
			local message1 = message.slice(0, 50);
			local message2 = message.slice(50);
			sendMessageToPlayer(i, r, g, b, tag+""+message1);
			sendMessageToPlayer(i, r, g, b, ".."+message2 +""+sufix);
			}else if(message.len() > 120){	
			local message1 = message.slice(0, 50);
			local message2 = message.slice(50,120);
			local message3 = message.slice(120);
			sendMessageToPlayer(i, r, g, b, tag+""+message1);
			sendMessageToPlayer(i, r, g, b, ".."+message2);			
			sendMessageToPlayer(i, r, g, b, ".."+message3 +""+sufix);
			}
		}
	}
}