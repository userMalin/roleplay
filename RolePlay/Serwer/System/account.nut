// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

function registerAccount(pid, name, password)
{
	setPlayerPassword(pid, password);
	setPlayerKlasa(pid, 1);
	setPlayerName(pid, name);
	setPlayerLogin(pid, true);
	setPlayerPosition(pid, -10774.3,-1071.17,6935.86);
	setPlayerVisual(pid, 0, 0, 0, 0);
	giveSpecificClass(pid, 1);
	spawnPlayer(pid);

    local pos = getPlayerPosition(pid);
	local savefile = io.file("Database/Account/"+name+".acc", "w");
    savefile.write(password+"\n");
    savefile.write(getPlayerKlasa(pid)+"\n");
	savefile.write(getPlayerWyglad(pid)[0]+"\n");
	savefile.write(getPlayerWyglad(pid)[1]+"\n");
	savefile.write(getPlayerWyglad(pid)[2]+"\n");
	savefile.write(getPlayerWyglad(pid)[3]+"\n");
	savefile.write(getPlayerStrength(pid)+"\n");
	savefile.write(getPlayerDexterity(pid)+"\n");
	savefile.write(getPlayerHealth(pid)+"\n");
	savefile.write(getPlayerMaxHealth(pid)+"\n");
	savefile.write(getPlayerMana(pid)+"\n");
	savefile.write(getPlayerMaxMana(pid)+"\n");
	savefile.write(getPlayerMagicLevel(pid)+"\n");
	savefile.write(getPlayerSkillWeapon(pid,0)+"\n");
	savefile.write(getPlayerSkillWeapon(pid,1)+"\n");
	savefile.write(getPlayerSkillWeapon(pid,2)+"\n");
	savefile.write(getPlayerSkillWeapon(pid,3)+"\n");
	savefile.write(pos.x+"\n");
	savefile.write(pos.y+"\n");
	savefile.write(pos.z+"\n");
	savefile.write(getPlayerAngle(pid)+"\n");
	savefile.write(getPlayerLevel(pid)+"\n");
	savefile.write(getPlayerExp(pid)+"\n");
	savefile.write(getPlayerLp(pid)+"\n");
	savefile.write(getPlayerSprint(pid)+"\n");
	savefile.close();
}

function loadAccount(pid)
{
	local loadfile = io.file("Database/Account/"+getPlayerName(pid)+".acc", "r");
	if (loadfile.isOpen)
	{
        local password = loadfile.read(io_type.LINE);
		local klasa = loadfile.read(io_type.LINE).tointeger();
		local wyglad1 = loadfile.read(io_type.LINE).tointeger();
		local wyglad2 = loadfile.read(io_type.LINE).tointeger();
		local wyglad3 = loadfile.read(io_type.LINE).tointeger();
		local wyglad4 = loadfile.read(io_type.LINE).tointeger();
		local str = loadfile.read(io_type.LINE).tointeger();		
		local dex = loadfile.read(io_type.LINE).tointeger();	
		local hp = loadfile.read(io_type.LINE).tointeger();	
		local hpmax = loadfile.read(io_type.LINE).tointeger();	
		local mana = loadfile.read(io_type.LINE).tointeger();	
		local manamax = loadfile.read(io_type.LINE).tointeger();	
		local magiclvl = loadfile.read(io_type.LINE).tointeger();	
		local oneh = loadfile.read(io_type.LINE).tointeger();	
		local twoh = loadfile.read(io_type.LINE).tointeger();
		local bow = loadfile.read(io_type.LINE).tointeger();
		local cbow = loadfile.read(io_type.LINE).tointeger();
		local posx = loadfile.read(io_type.LINE).tointeger();
		local posy = loadfile.read(io_type.LINE).tointeger();
		local posz = loadfile.read(io_type.LINE).tointeger();
		local angle = loadfile.read(io_type.LINE).tointeger();
		local lvl = loadfile.read(io_type.LINE).tointeger();
		local exp = loadfile.read(io_type.LINE).tointeger();
		local lp = loadfile.read(io_type.LINE).tointeger();
		local sprint = loadfile.read(io_type.LINE).tointeger();
		
		setPlayerPassword(pid, password);
		setPlayerKlasa(pid, klasa);
		setPlayerVisual(pid, wyglad1, wyglad2, wyglad3, wyglad4);
		setPlayerStrength(pid, str);
		setPlayerDexterity(pid, dex);
		setPlayerHealth(pid, hp);
		setPlayerMaxHealth(pid, hpmax);
		setPlayerMaxMana(pid, manamax);
		setPlayerMana(pid, mana);
		setPlayerMagicLevel(pid, magiclvl);
		setPlayerSkillWeapon(pid, 0, oneh);
		setPlayerSkillWeapon(pid, 1, twoh);
		setPlayerSkillWeapon(pid, 2, bow);
		setPlayerSkillWeapon(pid, 3, cbow);
		setPlayerPosition(pid, posx,posy,posz);
		setPlayerAngle(pid, angle);
		setPlayerLevel(pid, lvl);
		setPlayerExp(pid, exp);
		setPlayerLp(pid, lp);
		setPlayerSprint(pid, sprint);
		
		/// Inicjalizacja tego sprintu po stronie klienta!
		
		callClientFunc(pid, "setSprintPlayer", sprint);
		
		///////////////////////////////////////////////////
		
		loadfile.close();
		
		setPlayerLogin(pid, true);
    	spawnPlayer(pid);
	}
}

function saveAccount(pid)
{
    local pos = getPlayerPosition(pid);
	local savefile = io.file("Database/Account/"+getPlayerName(pid)+".acc", "w");
    savefile.write(getPlayerPassword(pid)+"\n");
    savefile.write(getPlayerKlasa(pid)+"\n");
	savefile.write(getPlayerWyglad(pid)[0]+"\n");
	savefile.write(getPlayerWyglad(pid)[1]+"\n");
	savefile.write(getPlayerWyglad(pid)[2]+"\n");
	savefile.write(getPlayerWyglad(pid)[3]+"\n");
	savefile.write(getPlayerStrength(pid)+"\n");
	savefile.write(getPlayerDexterity(pid)+"\n");
	savefile.write(getPlayerHealth(pid)+"\n");
	savefile.write(getPlayerMaxHealth(pid)+"\n");
	savefile.write(getPlayerMana(pid)+"\n");
	savefile.write(getPlayerMaxMana(pid)+"\n");
	savefile.write(getPlayerMagicLevel(pid)+"\n");
	savefile.write(getPlayerSkillWeapon(pid,0)+"\n");
	savefile.write(getPlayerSkillWeapon(pid,1)+"\n");
	savefile.write(getPlayerSkillWeapon(pid,2)+"\n");
	savefile.write(getPlayerSkillWeapon(pid,3)+"\n");
	savefile.write(pos.x+"\n");
	savefile.write(pos.y+"\n");
	savefile.write(pos.z+"\n");
	savefile.write(getPlayerAngle(pid)+"\n");
	savefile.write(getPlayerLevel(pid)+"\n");
	savefile.write(getPlayerExp(pid)+"\n");
	savefile.write(getPlayerLp(pid)+"\n");
	savefile.write(getPlayerSprint(pid)+"\n");
	savefile.close();
}

function saveItems(pid)
{
    local savefile = io.file("Database/Items/"+getPlayerName(pid)+".eq", "w");
    foreach(v,k in getPlayerItems(pid))
	{
	    savefile.write(k + " " + Items.name(v) + "\n");
	}
	savefile.close();
}

function loadItems(pid)
{
    local loadeq = io.file("Database/Items/"+getPlayerName(pid)+".eq", "r");
    if (loadeq.isOpen)
    {
	local args = 0;
	     do
		 {
            args = loadeq.read(io_type.LINE);		
		    if(args != null)
		    {
            local arg = sscanf("ds", args);
		    giveItem(pid, arg[1], arg[0]);
		    }		    
            else
            {
                break;
            }
         } while (args != null)     
	}
	loadeq.close();
}

function saveFileProfession(pid)
{
    local savep = io.file("Database/Profession/"+getPlayerName(pid)+".prof", "w");
    foreach(v,k in getPlayerListOfProfession(pid))
	{
	    savep.write(v + " " + k + "\n"); 
	}
	savep.close();
}

function loadFileProfession(pid)
{
    local loadp = io.file("Database/Profession/"+getPlayerName(pid)+".prof", "r");
    if (loadp.isOpen)
    {
	local args = 0;
	     do
		 {
            args = loadp.read(io_type.LINE);		
		    if(args != null)
		    {
            local arg = sscanf("dd", args);
		    setPlayerProfession(pid, arg[0], arg[1]);
		    }		    
            else
            {
                break;
            }
         } while (args != null)     
	}
	loadp.close();
	loadProfessions(pid);
}