// By Quarchodron / CC(2018) / Made for RolePlay v.0.3

local paramsScv = {
    str = 30, 
	hp = 100,
	dex = 0,
	exp = 70,
	instance = "SCAVENGER",
	ai = AI_TYPE.MONSTER,
	respawn = 1000 * 60 * 10, // 1000 - sekunda * 60  = minuta * 10 = respawn co 10 minut
}

local paramsLurker = {
    str = 70, 
	hp = 250,
	dex = 0,
	exp = 120,
	instance = "LURKER",
	ai = AI_TYPE.MONSTER,
	respawn = 1000 * 60 * 10, // 1000 - sekunda * 60  = minuta * 10 = respawn co 10 minut
}

local paramsYKrwio = {
    str = 20, 
	hp = 50,
	dex = 0,
	exp = 40,
	instance = "BLOODFLY",
	ai = AI_TYPE.MONSTER,
	respawn = 1000 * 60 * 10, // 1000 - sekunda * 60  = minuta * 10 = respawn co 10 minut
}



local function spawnMobs()
{
    NPCCreate("Moe NPC", 3059.92,248.125,188.125, 244, "ITAR_SMITH", "ITMW_1H_MACE_L_04", 51);
    MonsterCreate("Topielec", 961,-1407,10192, paramsLurker);
    MonsterCreate("Topielec", 4642,-1421,9280, paramsLurker);
    MonsterCreate("Topielec", 8080,-1439,11199, paramsLurker);
    MonsterCreate("Topielec", 8942,-1425,11596, paramsLurker);
    MonsterCreate("Topielec", 12620,-1366,11288, paramsLurker);
    MonsterCreate("Topielec", 16033,-1346,13735, paramsLurker);
    MonsterCreate("Topielec", 16789,-1372,13406, paramsLurker);
    MonsterCreate("Topielec", 19405,-1457,13198, paramsLurker);
    MonsterCreate("Topielec", 19041,-1344,12594, paramsLurker);
    MonsterCreate("Topielec", 18720,-1324,12075, paramsLurker);
    MonsterCreate("Topielec", 12761,-1312,13381, paramsLurker);
    MonsterCreate("Topielec", 12595,-1346,14321, paramsLurker);
    MonsterCreate("Topielec", 10845,-1353,15289, paramsLurker);
    MonsterCreate("Topielec", 7722,-1310,14974, paramsLurker);
    MonsterCreate("Topielec", 5729,-1350,16653, paramsLurker);
    MonsterCreate("Topielec", 2748,-1326,17353, paramsLurker);
    MonsterCreate("Topielec", 393,-1313,15134, paramsLurker);
    MonsterCreate("Topielec", -515,-1385,12934, paramsLurker);
    MonsterCreate("Topielec", -1947,-1372,12269, paramsLurker);
    MonsterCreate("Topielec", -2888,-1365,11857, paramsLurker);
    MonsterCreate("Topielec", -4097,-1382,11478, paramsLurker);
    MonsterCreate("Topielec", -5129,-1374,11158, paramsLurker);
    MonsterCreate("Topielec", -13353,-945,9003, paramsLurker);
    MonsterCreate("Topielec", -17393,-1021,10683, paramsLurker);
    MonsterCreate("Topielec", -19544,-1007,7667, paramsLurker);
    MonsterCreate("Topielec", -21481,-904,10311, paramsLurker);
    MonsterCreate("Topielec", -22548,-874,10594, paramsLurker);
    MonsterCreate("Topielec", -24682,-740,11556, paramsLurker);
    MonsterCreate("Topielec", -26137,-619,12403, paramsLurker);
    MonsterCreate("Topielec", -28198,-533,11203, paramsLurker);
    MonsterCreate("Topielec", -27598,-596,10143, paramsLurker);
    MonsterCreate("Topielec", -26303,-304,10358, paramsLurker);
    MonsterCreate("Topielec", -25374,-355,10442, paramsLurker);
    MonsterCreate("Topielec", -24311,-782,13383, paramsLurker);
    MonsterCreate("Topielec", -28744,-578,14591, paramsLurker);
    MonsterCreate("Mlody Krwiopijca", 4718,-1169,7882, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 5393,-1189,7818, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 7017,-1216,9504, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 7550,-1218,9755, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 7643,-1237,9211, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 8022,-1261,8918, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 10734,-1274,10423, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 10702,-1283,10295, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 10370,-1298,10124, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 9945,-1285,9783, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 10580,-174,-2435, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 10736,-18,-3251, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 10259,-167,-3453, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 9544,225,-8678, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 9034,222,-9090, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 8624,206,-9597, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 8608,277,-10195, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 3930,-527,-9367, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 3284,-554,-9465, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 587,-739,-10509, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 335,-762,-10453, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", 30,-812,-10269, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", -170,-869,-9981, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", -735,-950,-9656, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", -1210,-980,-9673, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", -1655,-932,-9843, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", -7281,-311,-8893, paramsYKrwio);
    MonsterCreate("Mlody Krwiopijca", -7664,-406,-8381, paramsYKrwio);

}

addEventHandler("onInit", spawnMobs);


local function botHitHandler(botid, playerid)
{
    local findNPC = getBotName(botid).find("NPC");
	if(findNPC != null)
	{
	    setPlayerHealth(playerid, 0);
	}
}
addEventHandler("onBotHit", botHitHandler);