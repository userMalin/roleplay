///////////////////////////
//      Author: Tommy
////////////////////////////

class T_Bot
{
    constructor(ai, _name, _instance)
    {
        object = {
            id = createNpc(_name),
            instance = _instance,
            hp = 100,
            maxHp = 100,
            x = 0,
            y = 0,
            z = 0,
            angle = 0,
            distance = 1500,
            distanceAttack = 100,
        };

        ai_type = ai;
    }

    //struct bot

    function targetColor(r, g, b)
    {
        setPlayerColor(object.id, r, g, b);
    }

    function health(hp, maxHp)
    {
        object.hp = hp;
        object.maxHp = maxHp;
    }

    function name(_name)
    {
        setPlayerName(object.id, _name)
    }

    function armor(_armor)
    {
        object.armor <- _armor;
    }

    function meleeWeapon(weapon)
    {
        object.weapon <- weapon;
    }

    function strength(_str)
    {
        object.str <- _str;
    }

    function dexterity(_dexterity)
    {
        object.dex <- _dexterity;
    }

    function skill(_oneh, _twoh)
    {
        object.oneh <- _oneh;
        object.twoh <- _twoh;
        object.cbow <- 100;
        object.bow <- 100;
    }

    function visual(_bodyModel, _bodyTxt, _headModel, _headTxt)
    {
        object.bodyModel <- _bodyModel;
        object.bodyTxt <- _bodyTxt;
        object.headModel <- _headModel;
        object.headTxt <- _headTxt;
    }

    //spawn bot
    
    function spawn()
    {
        isSpawn = true;

        spawnNpc(object.id);
        setPlayerInstance(object.id, object.instance);
        setPlayerHealth(object.id, object.hp);
        setPlayerMaxHealth(object.id, object.maxHp);   
        setPlayerPosition(object.id, object.x, object.y, object.z);
        setPlayerAngle(object.id, object.angle);  

        if(object.instance == "PC_HERO")
        {
            if(object.rawin("bodyModel"))setPlayerVisual(object.id, object.bodyModel, object.bodyTxt, object.headModel, object.headTxt);
            if(object.rawin("str"))setPlayerStrength(object.id, object.str);
            if(object.rawin("dex"))setPlayerDexterity(object.id, object.dex);
            if(object.rawin("onehdex"))setPlayerSkillWeapon(object.id, WEAPON_1H, object.oneh)
			if(object.rawin("twoh"))setPlayerSkillWeapon(object.id, WEAPON_2H, object.twoh)
            if(object.rawin("armor"))equipArmor(object.id, object.armor);
            //if(object.weaponType == WEAPON_TYPE.SWORD)
                if(object.rawin("weapon"))equipMeleeWeapon(object.id, object.weapon);

            if(object.rawin("oneh"))
            {
                setPlayerSkillWeapon(object.id, WEAPON_1H, object.oneh);
                setPlayerSkillWeapon(object.id, WEAPON_2H, object.twoh);
            }
            
            switch(ai_type)
            {
                case AI_TYPE.ONEH:
                    setPlayerWeaponMode(object.id, 3)
                break;
                case AI_TYPE.TWOH:
                    setPlayerWeaponMode(object.id, 4)
                break;
            }
            //else
                //equipMeleeWeapon(object.id, object.rangedWeapon);
        }
    }

    function unspawn()
    {
        isSpawn = false;

        unspawnNpc(object.id);
    }

    function respawn(_x, _y, _z, _angle, _anim)
    {
        object.x = _x;
        object.y = _y;
        object.z = _z;
        object.angle = _angle;

        if(isSpawn)
        {
            this.unspawn();
            this.spawn();
        }
    }

    function position(_x, _y, _z)
    {
        object.x = _x;
        object.y = _y;
        object.z = _z;

        setPlayerPosition(object.id, _x, _y, _z);
    }

    function getPosition()
    {
        return getPlayerPosition(object.id);
    }

    function angle(_angle)
    {
        object.angle = _angle;
        setPlayerAngle(object.id, _angle);
    }

    function playAnimation(_anim)
    {
        animation = _anim;
        playAni(object.id, _anim);
    }

    function changeHealth(_hp)
    {
        object.hp = _hp;
        setPlayerHealth(object.id, _hp);
    }


    object = null;
    animation = "";
    lastAnim = "";
    target = null;// null == lost target
    ai_type = null;
    warn = 0;

    isSpawn = false;
    isDie = false;
};

//---------------------------------
//          BOT CREATOR
//---------------------------------

SyncBot <- [];

function createBot(ai, name, instance)//edit (send id instance)
{
    SyncBot.append(T_Bot(ai, name, instance));
}

//---------------------------------

function createBot_Hp(id, hp, maxHp)
{
    SyncBot[id].health(hp, maxHp);
}

//---------------------------------

function createBot_Str(id, str)
{
    SyncBot[id].strength(str);
}

//---------------------------------

function createBot_Dex(id, dex)
{
    SyncBot[id].dexterity(dex);
}

//---------------------------------

/*function createBot_Name(id, name)
{
    SyncBot[id].name(namedex);
}*/

//---------------------------------

function createBot_Color(id, r, g, b)
{
    SyncBot[id].targetColor(r, g, b);
}

//---------------------------------

function createBot_Armor(id, armor)
{
    SyncBot[id].armor(armor);
}

//---------------------------------

function createBot_MeleeWeapon(id, weapon)
{
    SyncBot[id].meleeWeapon(weapon);
}

//---------------------------------

function createBot_Visual(id, bodyModel, bodyTxt, headModel, headTxt)
{
    SyncBot[id].visual(bodyModel, bodyTxt, headModel, headTxt);
}

//---------------------------------

function createBot_Position(id, x, y, z, angle)
{
    SyncBot[id].position(x, y, z);
    SyncBot[id].angle(angle);
}

//---------------------------------

function createBot_Skill(id, oneh, twoh)
{
    SyncBot[id].skill(oneh, twoh);
}

//---------------------------------

function createBot_Distance(id, distance)
{
    SyncBot[id].object.distance = distance;
}

//---------------------------------

function createBot_DistanceAttack(id, distance)
{
    SyncBot[id].object.distanceAttack = distance;
}


//---------------------------------
//             SYNC
//---------------------------------

function sender_Bot(id, targetId)
{
    SyncBot[id].target = targetId;
}

//---------------------------------

function lastPosition_Bot(id, x, y, z, angle)
{
    SyncBot[id].target = null;
    SyncBot[id].position(x, y, z);
    SyncBot[id].angle(angle);
    select_Ai(id, ACTION.KILLED_PLAYER);
}

//---------------------------------

function update_Bot(id, x, y, z, angle, anim)
{
    if(SyncBot[id].target != null)
    {
        SyncBot[id].position(x, y, z);
        SyncBot[id].angle(angle);
        SyncBot[id].playAnimation(anim);
    }
}

//---------------------------------

function health_Bot(id, hp)
{
    SyncBot[id].changeHealth(hp)
    
    if(hp <= 0)
    {
        SyncBot[id].isDie = true;
        SyncBot[id].target = null;
        select_Ai(id, ACTION.LOST_TARGET);
    }
}

//---------------------------------

function respawn_Bot(id, x, y, z, angle)
{
    SyncBot[id].changeHealth(SyncBot[id].object.maxHp);
    SyncBot[id].position(x, y, z);
    SyncBot[id].angle(angle);
    SyncBot[id].isDie = false;

    local pos = getPlayerPosition(heroId), bpos = SyncBot[id].getPosition();
    local distance = getDistance3d(pos.x, pos.y, pos.z, bpos.x, bpos.y, bpos.z);
    if(distance <= 2500) SyncBot[id].spawn();
}

//---------------------------------
//             SENDER

function syncPositionBot(i)
{
    local bot = SyncBot[i];
    local pos =  getPlayerPosition(heroId);
    local botPos = bot.getPosition();
    local a = getVectorAngle(botPos.x, botPos.z, pos.x, pos.z);
    
    bot.object.x = botPos.x;
    bot.object.y = botPos.y;
    bot.object.z = botPos.z;
    
    bot.angle(a);

    sendSyncBot(UNRELIABLE, SYNC_BOT.UPDATE, heroId, i, botPos.x, botPos.y, botPos.z, bot.object.angle, bot.animation);
}

//---------------------------------

function syncHealthBot(id, dmg)
{
    SyncBot[id].changeHealth(SyncBot[id].object.hp + dmg);

    sendSyncBot(RELIABLE_ORDERED, SYNC_BOT.HEALTH, id, dmg, heroId);
}

//---------------------------------

function REFRESH()
{
    foreach(i, bot in SyncBot)
    {
        if(bot.target == heroId && !bot.isDie)
        {
            if(bot.isSpawn)
                select_Ai(i, ACTION.TARGET);
                syncPositionBot(i);
        }
        
        local pos = getPlayerPosition(heroId);
        local distance = getDistance3d(pos.x, pos.y, pos.z, bot.object.x, bot.object.y, bot.object.z);
        if(distance <= 2500)
        {
            if(!bot.isSpawn && !bot.isDie) bot.spawn();
                
        }else{
            if(bot.isSpawn) bot.unspawn();
                
        }
    }
}

setTimer(REFRESH, 500, 0);

//---------------------------------

function hitHandler(killerid, playerid, dmg)
{
    foreach(i, bot in SyncBot)
    {
        if(playerid == bot.object.id)
        {
            syncHealthBot(i, dmg);
        }
    }
}
addEventHandler("onPlayerHit", hitHandler)


//---------------------------------
//          BOT FUNCTION
//---------------------------------

function setBotPosition(id, x, y, z)
{
    SyncBot[id].position(x, y, z);
}

//---------------------------------

function setBotColor(id, r, g, b)
{
    SyncBot[id].targetColor(r, g, b);
}

//---------------------------------

function setBotName(id, name)
{
    setPlayerName(SyncBot[id].object.id, name);
}

//---------------------------------

function setBotHealth(id, hp)
{
    SyncBot[id].changeHealth(hp);
}
