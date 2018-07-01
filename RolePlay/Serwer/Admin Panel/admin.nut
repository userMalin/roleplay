//cc(2018); Quarchodron

/* Typy uprawnieñ : 
	    "ADMIN"
	    "MODERATOR"
	    "LIDER"
*/

local Moderator_Password = "admin";
local Admin_Password = "admin";
local Lider_Password = "";

local function addCommands()
{
local configuration = io.file("Database/passwords.cfg", "r");
if (configuration.isOpen)
{
    //Admin_Password = configuration.read(io_type.LINE);
	//Moderator_Password = configuration.read(io_type.LINE);
	//Lider_Password = configuration.read(io_type.LINE);
	configuration.close();
	
	print("=========================================");
	print(" = Haslo Admin : " + Admin_Password + " ="); 
	print(" = Haslo Moderator : " + Moderator_Password + " ="); 
	print(" = Haslo Lider : " + Lider_Password + " ="); 
	print("=========================================");
}

addCommand("admin", loggInAdmin);
addCommand("moderator", loggInModerator);
addCommand("lider", loggInLider);
addCommand("changepassword", changePassAdmin);
addCommand("resetPanel", resetAllPrivilages);

addCommand("color", command_color);
addCommand("giveitem", command_giveitem);
addCommand("time", command_time);
addCommand("kill", command_kill);
addCommand("kick", command_kick);
addCommand("ban", command_ban);
addCommand("tp", command_tp);
addCommand("scale", command_scale);
addCommand("pos", command_pos);
addCommand("awans", command_awans);
}

addEventHandler("onInit",addCommands);

function loggInAdmin(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /admin haslo");
		return;
	}
	
	local haslo = args[0];
	
	if(haslo == Admin_Password)
	{
		if(loggInACL("ADMIN", getPlayerName(pid)))
		{
	    	sendMessageToPlayer(pid, 255, 255, 255, "Panel| Zalogowano do panelu admina!");
		}
		else
		{
			sendMessageToPlayer(pid, 255, 255, 255, "Panel| Jesteœ ju¿ zalogowany!");
		}
	}
	else
	{
			sendMessageToPlayer(pid, 255, 255, 255, "Panel| Z³e has³o!");
	}
}

function loggInModerator(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /moderator haslo");
		return;
	}
	
	local haslo = args[0];
	
	if(haslo == Moderator_Password)
	{
	    if(loggInACL("MODERATOR", getPlayerName(pid)))
	    {
	        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Zalogowano do panelu moderatora!");
	    }
	    else
	    {
	        sendMessageToPlayer(pid, 255, 255, 255, "Panel| Jesteœ ju¿ zalogowany!");
		}
	}
	else
	{
			sendMessageToPlayer(pid, 255, 255, 255, "Panel| Z³e has³o!");
	}
}

function loggInLider(pid, params)
{
	local args = sscanf("s", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /lider haslo");
		return;
	}
	
	local haslo = args[0];
	
	if(haslo == Lider_Password)
	{
	    if(loggInACL("LIDER", getPlayerName(pid)))
	    {
		    sendMessageToPlayer(pid, 255, 255, 255, "Panel| Zalogowano do panelu lidera!");
		}
		else
		{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Jesteœ ju¿ zalogowany!");
		}
	}
	else
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Z³e has³o!");
	}
}

function changePassAdmin(pid, params)
{
	local args = sscanf("sss", params);
	if (!args)
	{
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Uzycie : /changepassword <haslo admina> <haslo moda> <haslo lidera>");
		return;
	}
	
	if(isInACL("ADMIN", getPlayerName(pid)))
	{		
		Admin_Password = args[0];
		Moderator_Password = args[1];
		Lider_Password = args[2];		
		local configuration = io.file("Database/passwords.cfg", "w");
		if (configuration.isOpen)
		{
			myfile.write(args[0]+"\n");
			myfile.write(args[1]+"\n");
			myfile.write(args[2]);
			configuration.close();
		}
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Zmieniono has³a "+args[0]+","+args[1]+","+args[2]);
	}
}

function resetAllPrivilages(pid, params)
{
	if(isInACL("ADMIN", getPlayerName(pid)))
	{		
        ACLResetTables();
		sendMessageToPlayer(pid, 255, 255, 255, "Panel| Ka¿dego wylogowano z panelu. Nawet ciebie gagatku :)");
	}
}


