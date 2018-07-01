// By Quarchodron / CC(2018) / Made for RolePlay v.0.2


/// Spawnujące sie roślinki i szansza na ich pozyskanie! 

local ground_Chance = [
{instance = "ITPL_WEED", chance = 7},
{instance = "ITPL_SWAMPHERB", chance = 2},
{instance = "ITPL_MUSHROOM_01", chance = 5},
{instance = "ITPL_BEET", chance = 3},
{instance = "ITPL_MANA_HERB_01", chance = 3},
{instance = "ITPL_HEALTH_HERB_01", chance = 3},
{instance = "ITPL_MANA_HERB_02", chance = 2},
{instance = "ITPL_HEALTH_HERB_02", chance = 2},
{instance = "ITPL_MANA_HERB_03", chance = 1},
{instance = "ITPL_HEALTH_HERB_03", chance = 1},
{instance = "ITPL_MUSHROOM_02", chance = 2},
{instance = "ITPL_BLUEPLANT", chance = 5},
{instance = "ITPL_FORESTBERRY", chance = 4},
{instance = "ITPL_PERM_HERB", chance = 1},
];

//// Klasa spawnująca dany item

class herbsOnGround
{	
	function add(x,y,z, spawntime)
	{
		local herb = getRandomHerb();
		local item = ItemsGround.spawn(Items.id(herb), 1, x, y, z, "COLONY.ZEN");
	    herbsAll.append({x = x, y = y, z = z, item = item.id, active = true, spawnTime = spawntime})
	}
	
	function onTakeHerb(pid, item_ground)
	{
        foreach(k in herbsAll)
		{
		    if(k.item == item_ground.id)
			{
			    k.active = 0;
			}
		}
	}
	
	function checkSpawns()
	{
	    foreach(v,k in herbsAll)
		{
		    if(k.active != true)
			{
			    k.active = k.active + 1;
				if(k.active == k.spawnTime)
				{
				    local herb = getRandomHerb();
				    local item = ItemsGround.spawn(Items.id(herb), 1, k.x, k.y, k.z, "COLONY.ZEN");
				    k.active = true;
					k.item = item.id;
				}
			}
		} 
	}
	
	herbsAll = [];
}

///// Funkcja losująca roślinkę z tabeli na samej górze

function getRandomHerb()
{
    local count = 0;
	
	foreach(v,k in ground_Chance)
	{
	    count = count + k.chance;
	}
	
	local randomowa = irand(count);
	
	count = 0;
	
	foreach(v,k in ground_Chance)
	{
	    local one = count;
		local two = count + k.chance;
	    if(numberIsBetween(randomowa, one, two))
        {
            return k.instance;
        }		
		count = count + k.chance;
	}
	
	return "ITPL_WEED";
}

///// Callbacsy

local function onHerbInit()
{
    setTimer(function()
    {
	    herbsOnGround.checkSpawns();
    }, 1000, 0);
};

addEventHandler("onInit", onHerbInit);

local function playerTakeHerb(pid, itemGround)
{
	herbsOnGround.onTakeHerb(pid, itemGround);
};

addEventHandler("onPlayerTakeItem", playerTakeHerb);