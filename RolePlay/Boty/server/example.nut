//---------------------------------
//           Example
//---------------------------------

createBot(AI_TYPE.MONSTER, "WOLF", "Wolf", 409, -91, 1344, 0, 
{
    hp = 2500,
    maxHp = 2500,

    color = [0,0,255],

    distanceAttack = 250,
    distance = 1000,

});


local pal = createBot(AI_TYPE.ONEH, "PC_HERO", "Tommy", 1075, -94, -1690, 228, 
{
    hp = 1000,
    maxHp = 1000,

    weapon = Items.id("ITMW_1H_SPECIAL_04"),
    armor = Items.id("ITAR_OREBARON_ADDON"),
    bodyModel = "Hum_Body_Naked0", 
    bodyTxt = 45, 
    headModel = "Hum_Head_Pony", 
    headTxt = 18,

    color = [255,0,0],

    str = 200,
    dex = 200,
    oneh = 100,
    twoh = 100,
    distanceAttack = 250,
    distance = 1000,

	respawnTime = 20*1000,

});

setBotExp(pal, 2000);

//----------------------------------

function botDeadHandler(botid, killerid)
{
    print(getPlayerName(killerid)+ " killed "+getBotName(botid));
	//local exp = getBotExp(botid);//return int
}
addEventHandler("onBotDead", botDeadHandler);

//----------------------------------

function botHitHandler(botid, playerid)
{
    print(getPlayerName(playerid)+ " hit "+getBotName(botid));
}
addEventHandler("onBotHit", botHitHandler);

//----------------------------------

function botFocusHandler(botid, focusId)
{
	if(focusId != null) 
		print(getBotName(botid)+ " focus to "+focusId);;
}
addEventHandler("onBotFocus", botFocusHandler);

//----------------------------------

function commandHandler(pid, cmd, params)
{
	switch(cmd)
    {
        case "botpos":
            local arg = sscanf("d", params)
            if(arg[0] < SyncBot.len())
                local pos = getPlayerPosition(pid);
                sendMessageToPlayer(pid, 250, 0, 0, "Changed position -"+getBotName(arg[0]));
                setBotPosition(params.tointeger(), pos.x, pos.y, pos.z);
        break;
        case "bothp":
            local arg = sscanf("dd", params)
            if(arg[0] < SyncBot.len())
                sendMessageToPlayer(pid, 250, 0, 0, "Changed health -"+getBotName(arg[0]));
                setBotHealth(arg[0], arg[1]);
                
        break;
        case "botcolor":
            local arg = sscanf("dddd", params)
            if(arg[0] < SyncBot.len())
                sendMessageToPlayer(pid, 250, 0, 0, "Changed color -"+getBotName(arg[0]));
                local arg = sscanf("dddd", params)
                setBotColor(arg[0], arg[1], arg[2], arg[3]);
        break;
        case "botname":
            local arg = sscanf("ds", params)
            if(arg[0] < SyncBot.len())
                sendMessageToPlayer(pid, 250, 0, 0, "Changed name -"+getBotName(arg[0]));
                setBotName(arg[0], arg[1]);
        break;
    }
}
addEventHandler("onPlayerCommand", commandHandler);
/*
//events

onBotFocus(botId, oldfocus, currfocus)//null means none player
onBotDead(botId, killerid)
onBotHit(botId, attackerId)
onBotUpdate(botId, x, y, z)//bot actual position

//function

local pal = createBot(enum aitype, instance, string name, x, y, z, angle [, 
{
    hp = 1000,
    maxHp = 1000,

    weapon = Items.id("ITMW_1H_SPECIAL_04"),
    armor = Items.id("ITAR_OREBARON_ADDON"),
    bodyModel = "Hum_Body_Naked0", 
    bodyTxt = 45, 
    headModel = "Hum_Head_Pony", 
    headTxt = 18,

    color = [255,0,0],

    str = 200,
    dex = 200,
    oneh = 100,
    twoh = 100,

    distanceAttack = 250,
    distance = 1000,

}]);
setBotExp(botid, exp);
getBotExp(botid);//return int

getBotName(botid);
setBotHealth(bot, int health);
setBotPosition(bot, int x, int y, int z);
setBotColor(bot, int r, int g, int b);
setBotName(bot, int name);
*/