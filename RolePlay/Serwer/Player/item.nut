
// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

_giveItem <- giveItem;
_removeItem <- removeItem;

local PItems = {};

for (local i = 0; i < getMaxSlots(); ++i)
{
    PItems[i] <- {};
}

function giveItem(pid, instance, amount)
{
	/// ** = = = = = = = = = = = ** \\\
	instance = instance.tostring();
	local item = instance.toupper();
	local id = Items.id(item);
	/// ** = = = = = = = = = = = ** \\\
	if(id != -1)
	{
		if(PItems[pid].rawin(id))
	    {
			PItems[pid][id] = PItems[pid][id] + amount;
		}else{
			PItems[pid][id] <- amount;
		}
	_giveItem(pid, id, amount);
	}
}

function removeItem(pid, instance, amount)
{
/// ** = = = = = = = = = = = ** \\\
local item = instance.toupper();
local id = Items.id(item);
/// ** = = = = = = = = = = = ** \\\
    if(id != -1)
    {
		if(PItems[pid].rawin(id))
		{
			if(PItems[pid][id] > amount)
			{
				PItems[pid][id] = PItems[pid][id] - amount;
			}
			else
			{
				PItems[pid].rawdelete(id);
			}
		}
	_removeItem(pid, id, amount);
	}
}

function getPlayerItems(pid)
{
	return PItems[pid];
}

	
function hasPlayerItem(instance)
{
	local item = instance.toupper();
	local id = Items.id(item);

	if(PItems[pid].rawin(id))
	{
		return PItems[pid][id];
	}
	return 0;
};

function clearPlayerEquipment(pid)
{
PItems[pid].clear();
}

////////////////////////////////////////////////////////////////
////////  //////// CALLBACKS ///////////   /////////////////////
////////////////////////////////////////////////////////////////

addEventHandler("onPlayerRespawn", function(pid)
{
    foreach(v,k in PItems[pid])
	{
	    _giveItem(pid, v, k);
	}
});

addEventHandler("onPlayerDropItem", function(pid, item_ground)
{
    local id = Items.id(item_ground.instance);
	if(PItems[pid].rawin(id))
	{
		if(PItems[pid][id] == item_ground.amount)
		{
		    PItems[pid].rawdelete(id);
		}
		else
		{
			PItems[pid][id] = PItems[pid][id] - item_ground.amount;
		}
	}
});

addEventHandler("onPlayerTakeItem", function(pid, item_ground)
{
        local id = Items.id(item_ground.instance);
	    if(PItems[pid].rawin(id))
	    {
		    PItems[pid][id] = PItems[pid][id] + item_ground.amount;
	    }else{
	    	PItems[pid][id] <- item_ground.amount;
	    }
});

function itemHasBeenUsed(pid, item, amount)
{
    local id = Items.id(item);
	if(PItems[pid].rawin(id))
	{
		if(PItems[pid][id] > amount)
		{
			PItems[pid][id] = PItems[pid][id] - amount;
		}
		else
		{
			PItems[pid].rawdelete(id);
		}
    }
}

function addItemToTable(pid, item, amount)
{
    local id = Items.id(item);
	if(PItems[pid].rawin(id))
	{
		PItems[pid][id] = PItems[pid][id] + amount;
	}else{
	    PItems[pid][id] <- amount;
	} 
}


/// Functions to Mob Iteractions

function playerCookMeal(pid)
{
    addItemToTable(pid, "ITFOMUTTON", 1);
    itemHasBeenUsed(pid, "ITFOMUTTONRAW", 1); 	
}

function playerUseSwordRaw(pid)
{
    addItemToTable(pid, "ITMISWORDRAWHOT", 1);
    itemHasBeenUsed(pid, "ITMISWORDRAW", 1); 
	local id = Items.id("ITMISWORDRAWHOT");
	_giveItem(pid, id, 1);	
}

function regiveHotSteal(pid)
{
    local id = Items.id("ITMISWORDRAWHOT");
	_giveItem(pid, id, 2);
} 