////////////////////////////
//      Author: Tommy
////////////////////////////
addEvent("onBotFocus");
addEvent("onBotDead");
addEvent("onBotHit");

class T_Bot
{
    constructor(_ai, _instance, _name, _x, _y, _z, _angle)
    {
        object = {
            instance = _instance,
            name = _name,
            default_x = _x,
            default_y = _y,
            default_z = _z,
            x = _x,
            y = _y,
            z = _z,
            r = null,
            g = null,
            b = null,
            angle = _angle,
            hp = null,
            maxHp = null,
            distance = 1500,
            attackDistance = 200,
        }

        ai_type = _ai;

        /*if(_instance == "PC_HERO")
        {
            object.str <- null;
            object.dex <- null;
            object.armor <- null;
            object.weapon <- null;
            object.oneh <- null;
            object.twoh <- null;
            object.cbow <- null;
            object.bow <- null;
            object.bodyModel <- null;
            object.bodyTxt <- null;
            object.headModel <- null;
            object.headTxt <- null;
        }*/
    }

    function changeColor(r, g, b)
    {
        object.r = r;
        object.g = g;
        object.b = b;
    }

    function health(hp, maxHp)
    {
        object.hp <- hp;
        object.maxHp <- maxHp;
    }

    function strength(_str)
    {
        object.str <- _str;
    }

    function dexterity(_dexterity)
    {
        object.dex <- _dexterity;
    }

    function armor(_armor)
    {
        object.armor <- _armor;
    }

    function meleeWeapon(weapon)
    {
        object.weapon <- weapon;
    }

    function visual(_bodyModel, _bodyTxt, _headModel, _headTxt)
    {
        object.bodyModel <- _bodyModel;
        object.bodyTxt <- _bodyTxt;
        object.headModel <- _headModel;
        object.headTxt <- _headTxt;
    }

    function skill(_oneh, _twoh)
    {
        object.oneh <- _oneh;
        object.twoh <- _twoh;
    }

    function defaultPosition()
    {
        object.x = object.default_x;
        object.y = object.default_y;
        object.z = object.default_z;
    }

    //update(sync)

    function position(_x, _y, _z)
    {
        object.x = _x;
        object.y = _y;
        object.z = _z;
    }

    function angle(_angle)
    {
        object.angle = _angle;
    }

    function changeHealth(hp)
    {
        object.hp = hp;
    }

    object = null;
    animation = null;

    ai_type = null;
    isSpawn = true;
    target = null;

    respawn = 0;
    respawnTime = 7000;

    experience = 0;
};

//---------------------------------
//          BOT CREATOR
//---------------------------------

SyncBot <- [];

function createBot(ai, name, instance, x, y, z, angle, stat = null)
{
    SyncBot.append(T_Bot(ai, name, instance, x, y, z, angle));

    local bot = SyncBot[SyncBot.len()-1];

    if(stat != null)
    {
        if(stat.rawin("hp"))                    bot.health(stat.hp, stat.maxHp);
        if(stat.rawin("str"))                   bot.strength(stat.str);
        if(stat.rawin("dex"))                   bot.dexterity(stat.dex);
        if(stat.rawin("color"))                 bot.changeColor(stat.color[0], stat.color[1], stat.color[2]);
        if(stat.rawin("armor"))                 bot.armor(stat.armor);
        if(stat.rawin("weapon"))                bot.meleeWeapon(stat.weapon);
        if(stat.rawin("bodyModel"))             bot.visual(stat.bodyModel, stat.bodyTxt, stat.headModel, stat.headTxt);
        if(stat.rawin("oneh"))                  bot.skill(stat.oneh, stat.twoh)
        if(stat.rawin("distance"))              bot.object.distance = stat.distance;
        if(stat.rawin("distanceAttack"))        bot.object.attackDistance = stat.distanceAttack;
        if(stat.rawin("respawnTime"))           bot.respawnTime = stat.respawnTime;
        if(stat.rawin("exp"))                   bot.experience = exp;      
    }

    return SyncBot.len()-1;
}

//---------------------------------

function sendCreatedBot(pid, id)
{
    local bot = SyncBot[id];

    sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE, bot.ai_type, bot.object.name, bot.object.instance);//create bot
    sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_POSITION, id, bot.object.x, bot.object.y, bot.object.z, bot.object.angle);
    

    if(bot.object.hp != null)               sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_HP, id, bot.object.hp, bot.object.maxHp);//set bot hp and maxhp
    if(bot.object.rawin("str"))             sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_STR, id, bot.object.str);
    if(bot.object.rawin("dex"))             sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_DEX, id, bot.object.dex);
    if(bot.object.r != null)                sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_COLOR, id, bot.object.r, bot.object.g, bot.object.b);
    if(bot.object.rawin("armor"))           sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_ARMOR, id, bot.object.armor);
    if(bot.object.rawin("weapon"))          sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_MELEE_WEAPON, id, bot.object.weapon);
    if(bot.object.rawin("bodyModel"))       sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_VISUAL, id, bot.object.bodyModel, bot.object.bodyTxt, bot.object.headModel, bot.object.headTxt);
    if(bot.object.rawin("oneh"))            sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_SKILL, id, bot.object.oneh, bot.object.twoh);
    if(bot.object.distance != 1500)         sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_DISTANCE, id, bot.object.distance);
    if(bot.object.attackDistance != 200)    sendSyncBot(pid, RELIABLE_ORDERED, SYNC_BOT.CREATE_DISTANCE_ATTACK, id, bot.object.attackDistance);

}

//---------------------------------

local function joinHandler(pid)
{
    foreach (i, bot in SyncBot)
    {
        sendCreatedBot(pid, i);
    }
}
addEventHandler("onPlayerJoin", joinHandler)


//---------------------------------

local function disconnectHandler(pid, reason)
{
    foreach (i, bot in SyncBot)
    {
        if(bot.target == pid)
        {
            bot.target = null;
            senderBot(i, null)
        }
    }
}
addEventHandler("onPlayerDisconnect", disconnectHandler)

//---------------------------------
//             SYNC
//---------------------------------

function update_Bot(pid, id, x, y, z, angle, anim)
{
    local bot = SyncBot[id];
    if(bot.target != null)
    {
        bot.position(x, y, z);
        bot.angle(angle);
        bot.animation = anim;

        for(local i = 0; i < getMaxSlots(); i++)
        {
            if(isPlayerConnected(i) && isPlayerSpawned(i))
            {
               if(bot.target != i)
                    sendSyncBot(i, UNRELIABLE, SYNC_BOT.UPDATE, id, x, y, z, angle, anim);
            }
        }
    }
}
//---------------------------------

function lastUpdate_Bot(id)
{
    local bot = SyncBot[id];

    for(local i = 0; i < getMaxSlots(); i++)
    {
        if(isPlayerConnected(i))
            sendSyncBot(i, RELIABLE_ORDERED, SYNC_BOT.LAST_UPDATE, id, bot.object.x, bot.object.y, bot.object.z, bot.object.angle);
    }
}

//---------------------------------

function health_Bot(id, dmg, pid)
{
    SyncBot[id].changeHealth(SyncBot[id].object.hp - dmg);
    callEvent("onBotHit", id, pid);

    if(SyncBot[id].object.hp <= 0)
    {
        callEvent("onBotDead", id, pid);
        SyncBot[id].target = null;
        callEvent("onBotFocus", id, null)
        SyncBot[id].isSpawn = false;
        SyncBot[id].respawn = 0;
    }

        for(local i = 0; i < getMaxSlots(); i++)
        {
            if(isPlayerConnected(i) && isPlayerSpawned(i))
            {
                sendSyncBot(i, RELIABLE_ORDERED, SYNC_BOT.HEALTH, id, SyncBot[id].object.hp);
            }
        }
}

//---------------------------------

function senderBot(id, targetId)
{
    for(local i = 0; i < getMaxSlots(); i++)
    {
        if(isPlayerConnected(i) && isPlayerSpawned(i))
        {
            sendSyncBot(i, RELIABLE_ORDERED, SYNC_BOT.SENDER, id, targetId)
        }
    }
}

//---------------------------------

function sync_AI(id)
{
    local bot = SyncBot[id];
    for(local i = 0; i < getMaxSlots(); i++)
    {
        if(isPlayerConnected(i) && isPlayerSpawned(i))
        {
            local pos = getPlayerPosition(i);
            local distance = getDistance3d(pos.x, pos.y, pos.z, bot.object.x, bot.object.y, bot.object.z);

            if(distance <= bot.object.distance)
            {
                if(bot.target == null && !isPlayerDead(i))
                {
                    callEvent("onBotFocus", id, i)
                    bot.target = i;
                    senderBot(id, bot.target);
                }
                else if(isPlayerDead(i) && bot.target == i)
                {
                    callEvent("onBotFocus", id, null)
                    bot.target = null;
                    lastUpdate_Bot(id);
                }
            }else{
                if(bot.target == i)
                {
                    callEvent("onBotFocus", id, null)
                    bot.target = null;
                    lastUpdate_Bot(id);
                }
            }
        }
    }
}

//---------------------------------

function sync_RespawnBot(id)
{
    local bot = SyncBot[id];
    if(!bot.isSpawn)
    {
        bot.respawn += 500;
        
        if(bot.respawn == bot.respawnTime)
        {
            bot.defaultPosition();
            bot.changeHealth(bot.object.maxHp);
            bot.isSpawn = true;

            for(local i = 0; i < getMaxSlots(); i++)
            {
                if(isPlayerConnected(i) && isPlayerSpawned(i))
                {
                    sendSyncBot(i, RELIABLE_ORDERED, SYNC_BOT.RESPAWN, id, bot.object.default_x, bot.object.default_y, bot.object.default_z, bot.object.angle)
                }
            }
        }
    }
}

//---------------------------------

function REFRESH()
{
    foreach (i, bot in SyncBot)
    {
        if(bot.isSpawn && bot.ai_type != null && bot.ai_type != AI_TYPE.NONE)
        {
            sync_AI(i);
        }else{
            sync_RespawnBot(i)
        }
    }
}

setTimer(REFRESH, 500, 0);


//---------------------------------
//             FUNCTION
//---------------------------------

function getBotName(id)
{
    return SyncBot[id].object.name;
}

//---------------------------------

function setBotExp(id, exp)
{
	SyncBot[id].experience = exp;
};

//---------------------------------

function getBotExp(id)
{
	return SyncBot[id].experience;
}

//---------------------------------

function setBotPosition(id, x, y, z)
{
	SyncBot[id].position(x, y, z);
    
    for(local i = 0; i < getMaxSlots(); i++)
    {
        if(isPlayerConnected(i) && isPlayerSpawned(i))
        {
            sendSyncBot(i, RELIABLE_ORDERED, SYNC_BOT.BOT_POSITION, id, x, y, z)
        }
    }
}

//---------------------------------

function setBotColor(id, r, g, b)
{
	SyncBot[id].changeColor(r, g, b);
    
    for(local i = 0; i < getMaxSlots(); i++)
    {
        if(isPlayerConnected(i) && isPlayerSpawned(i))
        {
            sendSyncBot(i, RELIABLE_ORDERED, SYNC_BOT.BOT_COLOR, id, r, g, b);
        }
    }
}

//---------------------------------

function setBotName(id, name)
{
	SyncBot[id].object.name = name;
    
    for(local i = 0; i < getMaxSlots(); i++)
    {
        if(isPlayerConnected(i) && isPlayerSpawned(i))
        {
            sendSyncBot(i, RELIABLE_ORDERED, SYNC_BOT.BOT_NAME, id, name);
        }
    }
}


//---------------------------------

function setBotHealth(id, hp)
{
	SyncBot[id].changeHealth(hp);
    
    for(local i = 0; i < getMaxSlots(); i++)
    {
        if(isPlayerConnected(i) && isPlayerSpawned(i))
        {
            sendSyncBot(i, RELIABLE_ORDERED, SYNC_BOT.BOT_HEALTH, id, hp);
        }
    }
}

//// dodane by Quarchodron RolePlay 0.3

function MonsterCreate(name, x,y,z, paramaters)
{
    createBot(paramaters.ai, paramaters.instance, name, x,y,z, rand() % 360, 
    {
        hp = paramaters.hp,
        maxHp = paramaters.hp,

        str = paramaters.str,
        dex = paramaters.dex,	

        experience = paramaters.exp,		
		
        color = [200,0,0],

        distanceAttack = 250,
        distance = 1000,
		
		respawnTime = paramaters.respawn,

    });
}


function NPCCreate(name, x,y,z,angle, armor, weapon, face)
{
    createBot(AI_TYPE.NONE, "PC_HERO", name, x,y,z, angle, 
    {
        hp = 200000,
        maxHp = 200000,
		
		weapon = Items.id(weapon),
		armor = Items.id(armor),
		bodyModel = "Hum_Body_Naked0", 
		bodyTxt = 45, 
		headModel = "Hum_Head_Pony", 
		headTxt = face,

        str = 520,
        dex = 520,		
		
        color = [200,200,200],
        respawnTime = 1000,
    });
}

