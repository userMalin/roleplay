// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

_setPlayerStrength <- setPlayerStrength; 
_setPlayerDexterity <- setPlayerDexterity;
_setPlayerMaxHealth <- setPlayerMaxHealth;
_setPlayerHealth <- setPlayerHealth;
_setPlayerMaxMana <- setPlayerMaxMana;
_setPlayerMana <- setPlayerMana;
_setPlayerMagicLevel <- setPlayerMagicLevel;
_setPlayerTalent <- setPlayerTalent;	
_setPlayerSkillWeapon <- setPlayerSkillWeapon;
_setPlayerVisual <- setPlayerVisual;

local headModel = ["Hum_Head_Fighter","Hum_Head_Pony","Hum_Head_Bald","Hum_Head_Thief","Hum_Head_Psionic","Hum_Head_Babe"];
local bodyModel = ["Hum_Body_Naked0","Hum_Body_Babe0"];

local PStatistics = {};

for (local i = 0; i < getMaxSlots(); ++i)
{
    PStatistics[i] <- {};
	PStatistics[i].hp <- 100;
	PStatistics[i].mana <- 100;
	PStatistics[i].str <- 10;
	PStatistics[i].dex <- 100;
	PStatistics[i].weapons <- [0,0,0,0];
	PStatistics[i].wyglad <- [0,0,0,0];
	PStatistics[i].skill <- [0,0,0,0,0,0,0];
	PStatistics[i].lvl <- 0;
	PStatistics[i].magiclvl <- 0;
	PStatistics[i].exp <- 0;
	PStatistics[i].lp <- 0;
	PStatistics[i].nextlvlexp <- 500;
}

// $#############################################$ \\

function setPlayerStrength(pid, val)
{
	PStatistics[pid].str = val;
	_setPlayerStrength(pid, val);
}

function getPlayerStrength(pid)
{
    return PStatistics[pid].str;
}

// $#############################################$ \\

function setPlayerDexterity(pid, val)
{
	PStatistics[pid].dex = val;
	_setPlayerDexterity(pid, val);
}

function getPlayerDexterity(pid)
{
    return PStatistics[pid].dex;
}

// $#############################################$ \\

function setPlayerMaxMana(pid, val)
{
	PStatistics[pid].mana = val;
	_setPlayerMaxMana(pid, val);
}

function getPlayerMaxMana(pid)
{
    return PStatistics[pid].mana;
}

// $#############################################$ \\

function setPlayerMaxHealth(pid, val)
{
	PStatistics[pid].hp = val;
	_setPlayerMaxHealth(pid, val)
}

function getPlayerMaxHealth(pid)
{
    return PStatistics[pid].hp;
}

// $#############################################$ \\

function setPlayerMagicLevel(pid, val)
{
    PStatistics[pid].magiclvl = val;
	_setPlayerMagicLevel(pid, val);
}

function getPlayerMagicLevel(pid)
{
    return PStatistics[pid].magiclvl;
}

// $#############################################$ \\

function setPlayerTalent(pid, id, val)
{
	PStatistics[pid].skill[id] = val;
	_setPlayerTalent(pid, id, val);
}

function getPlayerTalent(pid, id)
{
	return PStatistics[pid].skill[id];
}

// $#############################################$ \\

function setPlayerSkillWeapon(pid, id, val)
{
	PStatistics[pid].weapons[id] = val;
	_setPlayerSkillWeapon(pid, id, val);
}

function getPlayerSkillWeapon(pid, id)
{
    return PStatistics[pid].weapons[id];
}

// $#############################################$ \\

function setPlayerVisual(pid, val1, val2, val3, val4)
{
	PStatistics[pid].wyglad = [val1,val2,val3,val4];
	_setPlayerVisual(pid, bodyModel[val1], val2, headModel[val3], val4);
}

function getPlayerWyglad(pid)
{
	return PStatistics[pid].wyglad;
}

// $#############################################$ \\

function setPlayerLp(pid, val)
{
	PStatistics[pid].lp = val;
    callClientFunc(pid, "setLearnPoints", val);
}

function getPlayerLp(pid)
{
    return PStatistics[pid].lp;
}

// $#############################################$ \\

function setPlayerLevel(pid, val)
{
    PStatistics[pid].lvl = val;
    callClientFunc(pid, "setLevel", val);
}

function getPlayerLevel(pid)
{
    return PStatistics[pid].lvl;
}

// $#############################################$ \\

function setPlayerExp(pid, val)
{
    PStatistics[pid].exp = val;
    callClientFunc(pid, "setExp", val);
}

function getPlayerExp(pid)
{
    return PStatistics[pid].exp;
}

// $#############################################$ \\

function setPlayerNextLvlExp(pid, val)
{
    PStatistics[pid].nextlvlexp = val;
    callClientFunc(pid, "setNextLevelExp", val);
}

function getPlayerNextLvlExp(pid)
{
    return PStatistics[pid].nextlvlexp;
}

////////////////////////////////////////////////////////////////
////////  //////// CALLBACKS ///////////   /////////////////////
////////////////////////////////////////////////////////////////

addEventHandler("onPlayerRespawn", function(pid)
{
	_setPlayerStrength(pid, PStatistics[pid].str);
	_setPlayerDexterity(pid, PStatistics[pid].dex);
	_setPlayerMaxHealth(pid, PStatistics[pid].hp);
	_setPlayerHealth(pid, PStatistics[pid].hp);
	_setPlayerMaxMana(pid, PStatistics[pid].mana);
	_setPlayerMana(pid, PStatistics[pid].mana);
	_setPlayerMagicLevel(pid, PStatistics[pid].magiclvl);
	_setPlayerTalent(pid, 0, PStatistics[pid].skill[0]);
	_setPlayerTalent(pid, 1, PStatistics[pid].skill[1]);
	_setPlayerTalent(pid, 2, PStatistics[pid].skill[2]);
	_setPlayerTalent(pid, 3, PStatistics[pid].skill[3]);
	_setPlayerTalent(pid, 4, PStatistics[pid].skill[4]);
	_setPlayerTalent(pid, 5, PStatistics[pid].skill[5]);
	_setPlayerTalent(pid, 6, PStatistics[pid].skill[6]);
	_setPlayerSkillWeapon(pid, 0, PStatistics[pid].weapons[0]);
	_setPlayerSkillWeapon(pid, 1, PStatistics[pid].weapons[1]);
	_setPlayerSkillWeapon(pid, 2, PStatistics[pid].weapons[2]);
	_setPlayerSkillWeapon(pid, 3, PStatistics[pid].weapons[3]);
	setPlayerLp(pid,PStatistics[pid].lp);
	setPlayerLevel(pid,PStatistics[pid].lvl);
	setPlayerNextLvlExp(pid,PStatistics[pid].nextlvlexp);
	setPlayerExp(pid,PStatistics[pid].exp);
	_setPlayerVisual(pid, bodyModel[PStatistics[pid].wyglad[0]], PStatistics[pid].wyglad[1], headModel[PStatistics[pid].wyglad[2]], PStatistics[pid].wyglad[3]);
});

function resetPlayerStatistics(pid)
{
	PStatistics[pid].hp = 100;
	PStatistics[pid].mana = 100;
	PStatistics[pid].str = 10;
	PStatistics[pid].dex = 100;
	PStatistics[pid].weapons = [0,0,0,0];
	PStatistics[pid].wyglad = [0,0,0,0];
	PStatistics[pid].skill = [0,0,0,0,0,0,0];
	PStatistics[pid].lvl = 0;
	PStatistics[pid].magiclvl = 0;
	PStatistics[pid].exp = 0;
	PStatistics[pid].lp = 0;
	PStatistics[pid].nextlvlexp = 500;
};

