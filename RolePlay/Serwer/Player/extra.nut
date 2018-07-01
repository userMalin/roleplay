// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

local PExtra = {};

for (local i = 0; i < getMaxSlots(); ++i)
{
    PExtra[i] <- {};
	PExtra[i].klasa <- -1;
	PExtra[i].password <- null;
	PExtra[i].login <- false;
	PExtra[i].sprint <- 1000;
}

function setPlayerKlasa(pid, val)
{
PExtra[pid].klasa = val;
}

function getPlayerKlasa(pid)
{
return PExtra[pid].klasa;
}

function setPlayerPassword(pid, val)
{
PExtra[pid].password = val;
}

function getPlayerPassword(pid)
{
return PExtra[pid].password;
}

function setPlayerLogin(pid, val)
{
PExtra[pid].login = val;
}

function getPlayerLogin(pid)
{
return PExtra[pid].login;
}

function setPlayerSprint(pid, val)
{
PExtra[pid].sprint = val;
}

function getPlayerSprint(pid)
{
return PExtra[pid].sprint;
}

function resetPlayerExtraStatistics(pid)
{
	PExtra[pid].klasa = -1;
	PExtra[pid].sprint = 1000;
	PExtra[pid].password = null;
	PExtra[pid].login = false;
}

