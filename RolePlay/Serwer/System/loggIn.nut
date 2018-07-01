// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

function tryToLoggMeIn(pid, _name, _haslo)
{
	local checkPassword = io.file("Database/Account/"+_name+".acc", "r");
	if (checkPassword.isOpen)
	{
		local haslo = checkPassword.read(io_type.LINE);
        if(haslo == _haslo)
		{
		    callClientFunc(pid,"hideLoggIn");
			setPlayerName(pid, _name);
			loadAccount(pid);
			loadItems(pid);
			loadFileProfession(pid);
			sendMessageToPlayer(pid, 255, 255, 255, "Uda³o ci siê zalogowaæ. Mi³ej rozgrywki!");
		}
		else
		{
		    callClientFunc(pid,"showErrMessage",3);
		}
		checkPassword.close();
	}
	else
	{
	    sendMessageToPlayer(pid, 255, 255, 255, "Zarejestrowales sie. Witamy na serwerze!");
	    sendMessageToPlayer(pid, 255, 255, 255, "Twoje haslo to : "+_haslo+" zapamietaj to!");
	    callClientFunc(pid,"hideLoggIn");
		registerAccount(pid, _name, _haslo);
	}
}