////////////////////////////
//      Author: Tommy
//        BASIC AI
////////////////////////////
local timeWarn = 6;//second

enum ACTION
{
    TARGET,
    LOST_TARGET,
    KILLED_PLAYER,
    //HIT,
}

function select_Ai(id, action)
{
    local bot = SyncBot[id];
    switch(bot.ai_type)
    {
        case AI_TYPE.MONSTER: monster_AI(id, action); break;
        case AI_TYPE.ONEH: oneh_AI(id, action); break;
        case AI_TYPE.TWOH: twoh_AI(id, action); break;
    }
}

//-----------------------------------------

function monster_AI(id, action)
{
    local bot = SyncBot[id];
    
    switch(action)
    {
        case ACTION.TARGET:
            local pos = getPlayerPosition(heroId), bpos = bot.getPosition();

            local distance = getDistance3d(pos.x, pos.y, pos.z, bpos.x, bpos.y, bpos.z);
            if(distance <= bot.object.distance)
            {

                if(bot.warn == timeWarn)
                {
                            if(distance <= bot.object.distanceAttack)
                            {
                                //print(bot.object.distanceAttack)
                                if( getPlayerAni(heroId) == "S_1HATTACK" || getPlayerAni(heroId) == "T_1HATTACKL" || getPlayerAni(heroId) == "T_1HATTACKR"
                                    || getPlayerAni(heroId) == "S_2HATTACK" || getPlayerAni(heroId) == "T_2HATTACKL" || getPlayerAni(heroId) == "T_2HATTACKR" )
                                {
                                    local random = rand() % 3;
                                    switch(random)
                                    {
                                        case 0: 
                                            bot.playAnimation("T_FISTPARADEJUMPB"); 
                                            return 0;
                                        case 1: 
                                            bot.playAnimation("T_FISTRUNSTRAFEL"); 
                                            return 0;    
                                        case 1: 
                                            bot.playAnimation("S_FISTATTACK"); 
                                            break;
                                        }
                                    }

                                    if(getPlayerAni(heroId) == "S_1HRUNL" || getPlayerAni(heroId) == "S_2HRUNL" || getPlayerAni(heroId) == "S_RUNL" || getPlayerAni(heroId) == "S_FISTRUNL")
                                        {
                                        if(bot.animation == "T_FISTATTACKMOVE")
                                        {
                                            bot.playAnimation("T_FISTPARADEJUMPB");
                                            return 0;
                                        }
                                            
                                        bot.playAnimation("T_FISTATTACKMOVE")

                                    }else{
                                        local random = rand() % 3;
                                        if(random < 2 )
                                        {
                                            bot.playAnimation("S_FISTATTACK");
                                        }else{
                                            bot.playAnimation("T_FISTPARADEJUMPB");
                                            return 0;
                                        }                                       
                                    }

                                    if(getPlayerAni(heroId) == "T_1HPARADE_0" || getPlayerAni(heroId) == "T_1HPARADE_0_A2" || getPlayerAni(heroId) == "T_1HPARADE_0_A3"
                                       || getPlayerAni(heroId) == "T_2HPARADE_0" || getPlayerAni(heroId) == "T_2HPARADE_0_A2" || getPlayerAni(heroId) == "T_2HPARADE_0_A3") 
                                    {
                                        return 0;
                                    }

                                    setTimer(function()
                                    {
                                        local posP = getPlayerPosition(heroId), posB = bot.getPosition();
                                        local angle = getVectorAngle(posB.x, posB.z, posP.x, posP.z);

                                        if(angle >= bot.object.angle - 10 && angle <= bot.object.angle + 10)
                                        { 
                                            hitPlayer(bot.object.id, heroId);
                                        }
                                    }, 200, 1);
                        }else{
                             bot.playAnimation("S_FISTRUNL");
                        }
                }else{
                    bot.playAnimation("T_WARN")
                    ++bot.warn;
                }
            }
        break;
        
        case ACTION.LOST_TARGET:
            //stopAni(bot.object.id);
            bot.playAnimation("S_FISTRUN");
            bot.warn = 0;
        break;

        case ACTION.KILLED_PLAYER:
            //bot.playAnimation("S_EAT");
            bot.playAnimation("S_FISTRUN");
            bot.warn = 0;
        break;
    }
}

//-----------------------------------------

function oneh_AI(id, action)
{
    local bot = SyncBot[id];

    switch(action)
    {
        case ACTION.TARGET:
            local pos = getPlayerPosition(heroId), bpos = bot.getPosition();

            local distance = getDistance3d(pos.x, pos.y, pos.z, bpos.x, bpos.y, bpos.z);
            if(distance <= bot.object.distance)
            {    
				if(distance <= bot.object.distanceAttack)
				{  

					local random = rand() % 3;
					switch (random)
					{
						case 0: bot.playAnimation("S_1HATTACK"); break;
						case 1: setTimer(function(){ bot.playAnimation("T_1HATTACKR");}, 100, 1); break;
						case 2: setTimer(function(){ bot.playAnimation("T_1HATTACKL");}, 100, 1); break;
					} 

                    if(getPlayerAni(heroId) == "T_1HPARADE_0" || getPlayerAni(heroId) == "T_1HPARADE_0_A2" || getPlayerAni(heroId) == "T_1HPARADE_0_A3"
                       || getPlayerAni(heroId) == "T_2HPARADE_0" || getPlayerAni(heroId) == "T_2HPARADE_0_A2" || getPlayerAni(heroId) == "T_2HPARADE_0_A3") 
                    {
                        if(bot.animation == "S_1HATTACK" || bot.animation == "S_1HATTACKR" || bot.animation == "T_1HATTACKL"
                          || bot.animation == "S_2HATTACK" || bot.animation == "S_2HATTACKR" || bot.animation == "T_2HATTACKL")
                        {
                            block <- Sound("CS_IAI_ME_ME_02.WAV");
                            block.play();
                            setTimer(function()
                            {
                                block.stop();
                                delete block;
                            }, 350, 1);
                            return 0;
                        }
                    }         

                    hitPlayer(bot.object.id, heroId);           
                }else{
                    bot.playAnimation("S_RUNL")
                }
            }
        break;

        case ACTION.LOST_TARGET:
        
            //bot.position(x, y, z);
            //stopAni(bot.object.id);
            bot.playAnimation("S_RUN");
        break;

        case ACTION.KILLED_PLAYER:
            bot.playAnimation("S_RUN");
        break;
    }
}

//-----------------------------------------

function twoh_AI(id, action)
{
    local bot = SyncBot[id];

    switch(action)
    {
        case ACTION.TARGET:
            local pos = getPlayerPosition(heroId), bpos = bot.getPosition();

            local distance = getDistance3d(pos.x, pos.y, pos.z, bpos.x, bpos.y, bpos.z);
            if(distance <= bot.object.distance)
            {    
				if(distance <= bot.object.distanceAttack)
				{  

					local random = rand() % 3;
					switch (random)
					{
						case 0: bot.playAnimation("S_2HATTACK"); break;
						case 1: setTimer(function(){ bot.playAnimation("T_2HATTACKR");}, 100, 1); break;
						case 2: setTimer(function(){ bot.playAnimation("T_2HATTACKL");}, 100, 1); break;
					} 

                    if(getPlayerAni(heroId) == "T_1HPARADE_0" || getPlayerAni(heroId) == "T_1HPARADE_0_A2" || getPlayerAni(heroId) == "T_1HPARADE_0_A3"
                       || getPlayerAni(heroId) == "T_2HPARADE_0" || getPlayerAni(heroId) == "T_2HPARADE_0_A2" || getPlayerAni(heroId) == "T_2HPARADE_0_A3") 
                    {
                        if(bot.animation == "S_1HATTACK" || bot.animation == "S_1HATTACKR" || bot.animation == "T_1HATTACKL"
                          || bot.animation == "S_2HATTACK" || bot.animation == "S_2HATTACKR" || bot.animation == "T_2HATTACKL")
                        {
                            block <- Sound("CS_IAI_ME_ME_02.WAV");
                            block.play();
                            setTimer(function()
                            {
                                block.stop();
                                delete block;
                            }, 350, 1);
                            return 0;
                        }
                    }         

                    hitPlayer(bot.object.id, heroId);           
                }else{
                    bot.playAnimation("S_RUNL")
                }
            }
        break;

        case ACTION.LOST_TARGET:
        
            //bot.position(x, y, z);
            //stopAni(bot.object.id);
            bot.playAnimation("S_RUN");
        break;

        case ACTION.KILLED_PLAYER:
            bot.playAnimation("S_RUN");
        break;
    }
}