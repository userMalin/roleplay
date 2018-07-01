// By Quarchodron / CC(2018) / Made for RolePlay v.0.3

local Professions = {};

local function loadProfession()
{
    Professions[PROFESSION.KOWAL] <- 0;
    Professions[PROFESSION.ALCHEMIK] <- 0;
    Professions[PROFESSION.KUCHARZ] <- 0;
    Professions[PROFESSION.DRWAL] <- 0;
    Professions[PROFESSION.MYSLIWY] <- 0;
    Professions[PROFESSION.RYBAK] <- 0;
    Professions[PROFESSION.ZLODZIEJ] <- 0;
    Professions[PROFESSION.BIMBROWNIK] <- 0;		
}

addEventHandler("onInit", loadProfession);


function getListOfProfession()
{
    return Professions;
}

function setProfession(id, val)
{
    Professions[id] = val;
	callServerFunc("setPlayerProfession", heroId, id, val);
}

function getProfession(id)
{
    return Professions[id];
}

function loadProfessions(...)
{
	foreach(id, val in vargv)
	{
        Professions[id] = val.tointeger();
    }	
}