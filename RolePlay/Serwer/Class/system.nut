
local Classes = [];

function registerClass(name, id, func)
{
    Classes.append({name = name, id = id, func = func});
}

function getClassName(id)
{
    foreach(v,k in Classes)
	{  
	    if(k.id == id)
		{
		return k.name;
		}
	}
	return "";
}

function giveSpecificClass(pid, clas)
{
    foreach(v,k in Classes)
	{
	    if(k.id == clas)
		{
		    k.func(pid);
		    return;
		}
	}
}

function showClassList(pid, params)
{
	local rozdzielnik = 0;
	local string = "";
    foreach(v,k in Classes)
	{
        rozdzielnik = rozdzielnik + 1;
		string = string + " ("+k.id+") - "+k.name+" ||" 
		if(rozdzielnik == 3)
		{
		    sendMessageToPlayer(pid, 255, 255, 255, string); rozdzielnik = 0; string = "";
		}
	}
}

function isClassExist(clas)
{
    foreach(v,k in Classes)
	{  
	    if(k.id == clas)
		{
		return true;
		}
	}
	return false;
}

function command_awans(pid, params)
{
	local args = sscanf("dd", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /awans <id> <id klasy>");
		return;
	}
	
	local id = args[0];
	local klasa = args[1];
	
	if (!isPlayerConnected(id))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Gracz nie jest po³¹czony!");
		return;
	}	

	if (!isClassExist(klasa))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Nie ma takiej klasy!");
		return;
	}		
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)) || isInACL("LIDER", getPlayerName(pid)))
	{
        sendMessageToPlayer(id, 255, 255, 255, "Panel| Dosta³eœ klase "+getClassName(klasa)+"("+klasa+") od gracza "+getPlayerName(pid));	
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Da³eœ klase id "+getClassName(klasa)+"("+klasa+") dla gracza "+getPlayerName(id));
		giveSpecificClass(id, klasa);
		setPlayerKlasa(id, klasa);
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}
