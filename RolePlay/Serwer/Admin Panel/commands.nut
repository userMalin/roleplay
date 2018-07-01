

function command_ban(pid, params)
{
	local args = sscanf("ds", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /ban <id> <powod>");
		return;
	}
	
	local id = args[0];
	local powod = args[1];
	
	if (!isPlayerConnected(id))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Gracz nie jest po³¹czony!");
		return;
	}	
	
	if(isInACL("ADMIN", getPlayerName(pid)))
	{		
	    ban(id, -1, powod);
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Zbanowa³eœ "+getPlayerName(id) + " " + powod);
		sendMessageToAll(255,255,255,"Administrator "+getPlayerName(pid)+" zbanowa³/a "+getPlayerName(id)+" za "+powod);
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}

function command_kick(pid, params)
{
	local args = sscanf("ds", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /kick <id> <powod>");
		return;
	}
	
	local id = args[0];
	local powod = args[1];
	
	if (!isPlayerConnected(id))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Gracz nie jest po³¹czony!");
		return;
	}	
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{		
	    kick(id, powod);
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Da³eœ kicka "+getPlayerName(id) + " " + powod);
		sendMessageToAll(255,255,255,getPlayerName(pid)+" wyrzuci³/a "+getPlayerName(id)+" za "+powod);
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}

function command_kill(pid, params)
{
	local args = sscanf("d", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /kill <id>");
		return;
	}
	
	local id = args[0];
	
	if (!isPlayerConnected(id))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Gracz nie jest po³¹czony!");
		return;
	}	
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{		
	    setPlayerHealth(id, 0);
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Da³eœ killa "+getPlayerName(id));
		sendMessageToPlayer(id, 255, 255, 255, "Panel| Zosta³eœ zabity przez "+getPlayerName(pid));
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}

function command_color(pid, params)
{
	local args = sscanf("dddd", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /color <id> <r> <g> <b>");
		return;
	}
	
	local id = args[0];
	local r = args[1];
	local g = args[2];
	local b = args[3];
	
	if (!isPlayerConnected(id))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Gracz nie jest po³¹czony!");
		return;
	}	
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{		
	    setPlayerColor(id, r,g,b);
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Da³eœ killa "+getPlayerName(id));
		sendMessageToPlayer(id, r,g, b, "Panel| Zmieniono ci kolor przez "+getPlayerName(pid));
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}

function command_giveitem(pid, params)
{
	local args = sscanf("dsd", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /giveitem <id> <instance> <amount>");
		return;
	}
	
	local id = args[0];
	local instance = args[1];
	local amount = args[2];
	
	if (!isPlayerConnected(id))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Gracz nie jest po³¹czony!");
		return;
	}	
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{		
	    giveItem(id, instance, amount);
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Da³eœ "+getPlayerName(id)+" przedmiot : "+instance+" | "+amount);
		sendMessageToPlayer(id, 255, 255, 255, "Panel| Dano ci "+instance+" | "+amount);
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}

function command_tp(pid, params)
{
	local args = sscanf("dd", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /tp <id> <toid>");
		return;
	}
	
	local id = args[0];
	local toid = args[1];
	
	if (!isPlayerConnected(id) || !isPlayerConnected(toid))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Gracz nie jest po³¹czony!");
		return;
	}	
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{		
	    setPlayerPosition(id, getPlayerPosition(toid).x + 20, getPlayerPosition(toid).y, getPlayerPosition(toid).y + 20);
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Przeteleportowa³eœ "+getPlayerName(id)+" do "+ getPlayerName(toid));
		sendMessageToPlayer(id, 255, 255, 255, "Panel| Przeteleportowano cie do "+getPlayerName(toid));
		sendMessageToPlayer(toid, 255, 255, 255, "Panel| Przeteleportowano do ciebie "+getPlayerName(id));
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}

function command_time(pid, params)
{
	local args = sscanf("dd", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /time <hour> <minute>");
		return;
	}
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{	
		local hour = args[0];
		local min = args[1];
		
		if (hour > 23) hour = 23;
		else if (hour < 0) hour = 0;
		
		if (min > 59) min = 59;
		else if (min < 0) min = 0;

		sendMessageToAll(255,255,255,getPlayerName(pid)+" zmieni³ godzine na "+hour+":"+min);
		setTime(hour, min);
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}

function command_scale(pid, params)
{
	local args = sscanf("dfff", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /scale <id> <x> <y> <z>");
		return;
	}
	
	local id = args[0];
	local x = args[1];
	local y = args[2];
	local z = args[3];
	
	if (!isPlayerConnected(id))
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Gracz nie jest po³¹czony!");
		return;
	}	
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{		
	    setPlayerScale(id, x,y,z);
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Zmieni³eœ rozmiar "+getPlayerName(id));
		sendMessageToPlayer(id, 255,255, 5, "Panel| Zmieniono ci rozmiar przez "+getPlayerName(pid));
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}

function command_pos(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /pos nazwa");
		return;
	}
	
	local nazwa = args[0];
	
	if(isInACL("ADMIN", getPlayerName(pid)) || isInACL("MODERATOR", getPlayerName(pid)))
	{		
	    local getpos = getPlayerPosition(pid);
		saveLog("pos.txt","Pos "+nazwa+" w pozycji : "+getpos.x+","+getpos.y+","+getpos.z+" "+getPlayerAngle(pid));
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Rozstawi³eœ "+nazwa);
	}
	else
	{
        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Brak uprawieñ.");
    }    
}