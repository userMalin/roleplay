// By Quarchodron / CC(2018) / Made for RolePlay v.0.3

local Professions = {};

local function loadProfession()
{
    for (local i = 0; i < getMaxSlots(); ++i)
    {
	    Professions[i] <- {};
        Professions[i][PROFESSION.KOWAL] <- 0;
        Professions[i][PROFESSION.ALCHEMIK] <- 0;
        Professions[i][PROFESSION.KUCHARZ] <- 0;
        Professions[i][PROFESSION.DRWAL] <- 0;
        Professions[i][PROFESSION.MYSLIWY] <- 0;
        Professions[i][PROFESSION.RYBAK] <- 0;
        Professions[i][PROFESSION.ZLODZIEJ] <- 0;
        Professions[i][PROFESSION.BIMBROWNIK] <- 0;
    }
}

addEventHandler("onInit", loadProfession);


function getPlayerListOfProfession(pid)
{
    return Professions[pid];
}

function setPlayerProfession(pid, id, val)
{
    Professions[pid][id] = val;
}

function getPlayerProfession(pid, id)
{
    return Professions[pid][id];
}

function loadProfessions(i)
{
    callClientFunc(i, "loadProfessions", Professions[i][PROFESSION.KOWAL],Professions[i][PROFESSION.ALCHEMIK],Professions[i][PROFESSION.KUCHARZ],Professions[i][PROFESSION.DRWAL],Professions[i][PROFESSION.MYSLIWY],Professions[i][PROFESSION.RYBAK],Professions[i][PROFESSION.ZLODZIEJ],Professions[i][PROFESSION.BIMBROWNIK]);
}

function resetPlayerProfession(pid)
{
    foreach(profesja in Professions[pid])
    {
        profesja = 0;
    }
}