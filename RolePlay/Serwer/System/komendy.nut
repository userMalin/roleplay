// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

local function addCommendsonInit()
{
	addCommand("ja", CMD_Ja)
	addCommand("me", CMD_Ja)
	addCommand("do", CMD_Do)
	addCommand("b", CMD_Ooc)
	addCommand("sz", CMD_Sz)
	addCommand("k", CMD_K)
	addCommand("g", CMD_Globalny)
	addCommand("pw", CMD_PW)
	addCommand("pm", CMD_PW)
	addCommand("style", CMD_ChangeStyle)
	addCommand("pomoc", CMD_ShowPomoc)	
	addCommand("listaklas", showClassList);
}

addEventHandler("onInit",addCommendsonInit);

function CMD_ShowPomoc(pid, params)
{
sendMessageToPlayer(pid, 255, 255, 255, "Pomoc serwera RolePlay:");
sendMessageToPlayer(pid, 255, 255, 255, "~~ Uzupelnic");
sendMessageToPlayer(pid, 255, 255, 255, "~~ Uzupelnic");
sendMessageToPlayer(pid, 255, 255, 255, "~~ Uzupelnic");
sendMessageToPlayer(pid, 255, 255, 255, "~~ Uzupelnic");
sendMessageToPlayer(pid, 255, 255, 255, "Skrypt by Quarchodron");
}

//-------------------------------------------------------------

function CMD_ChangeStyle(pid, params)
{
	local args = sscanf("d", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "/style <0-mag 1-kobieta 2-wojskowy 3-wyluzowany 4-arogant 5-zmeczony>");
		return;
	}
	local val = args[0];
	
    ustaw_StylChodzenia(pid,val)
	sendMessageToPlayer(pid, 255, 255, 255, "Ustawiono styl chodzenia!");
}

//-------------------------------------------------------------

function CMD_Ja(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "/ja <wiadomosc>");
		return;
	}
    messageDistance(pid, args[0], 1500, 105 , 0 , 186, getPlayerName(pid)+" ","")
}

//-------------------------------------------------------------

function CMD_Do(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "/do <wiadomosc>");
		return;
	}
    messageDistance(pid, args[0], 1500, 65 , 105, 225, "**","**("+getPlayerName(pid)+")")
}

//-------------------------------------------------------------

function CMD_Ooc(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "/b <wiadomosc>");
		return;
	}
    messageDistance(pid, args[0], 1500, 128 128, 128, "(("+getPlayerName(pid)+":", "))")
}

//-------------------------------------------------------------


function CMD_Sz(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "/sz <wiadomosc>");
		return;
	}
    messageDistance(pid, args[0], 500, 128 128, 128, getPlayerName(pid)+" szepcze: ",".")
}

//-------------------------------------------------------------

function CMD_K(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "/k <wiadomosc>");
		return;
	}
    messageDistance(pid, args[0], 3000, 255, 255, 255, getPlayerName(pid)+" krzyczy: ","!")
}

//-------------------------------------------------------------

function CMD_Globalny(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "/g <wiadomosc>");
		return;
	}
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{		
        sendMessageToAll(200, 1, 1, getPlayerName(pid) + " Globalny : "+args[0]);
	}
}

//-------------------------------------------------------------

function ustaw_StylChodzenia(pid,val)
{
    switch(val)
	{
	    case 0:
	    applyPlayerOverlay(pid, Mds.id("HUMANS_MAGE.MDS"));
		break;
	    case 1:
	    applyPlayerOverlay(pid, Mds.id("HUMANS_BABE.MDS"));
		removePlayerOverlay(pid, Mds.id("HUMANS_BABE.MDS"));
		break;
	    case 2:
	    applyPlayerOverlay(pid, Mds.id("HUMANS_MILITIA.MDS"));
		break;
	    case 3:
	    applyPlayerOverlay(pid, Mds.id("HUMANS_RELAXED.MDS"));
		break;
	    case 4:
	    applyPlayerOverlay(pid, Mds.id("HUMANS_ARROGANCE.MDS"));
		break;
	    case 5:
	    applyPlayerOverlay(pid, Mds.id("HUMANS_TIRED.MDS"));
		break;
	}
}


//-------------------------------------------------------------

function CMD_PW(pid, params)
{
	local args = sscanf("ds", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "/pw <id> <wiadomosc>");
		return;
	}

	if (!isPlayerConnected(args[0]))
	{
		sendMessageToPlayer(pid, 255, 0, 0, "Nie ma osoby online o tym id.");
		return;
	}

	sendMessageToPlayer(pid, 150, 130, 0, "PW >> "+getPlayerName(args[0]) + " |"+args[0]+"| >> " + args[1]);
	sendMessageToPlayer(args[0], 130, 150, 0, "PW << "+getPlayerName(pid) + " |"+pid+"| << " + args[1]);
}


function setSprintTest(pid, val)
{
    if(val)
	{
	    applyPlayerOverlay(pid, Mds.id("HUMANS_SPRINT.MDS"));
		return;
	}
	
	removePlayerOverlay(pid, Mds.id("HUMANS_SPRINT.MDS"));
}