
// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

local AllHouses = {};

local function loadAllHouses()
{
    local count = 0;
	
	for(local i = 0; i < 100; i++)
	{
	    local loadfile = io.file("Database/House/house_"+count+".txt", "r");
	    if (loadfile.isOpen)
	    {
		    local owner = loadfile.read(io_type.LINE);
		    AllHouses[count] <- {};
			AllHouses[count].owner <- owner;
			AllHouses[count].items <- {};
			
            /// Read Items In House :
			
		print("Dodano dom id : "+count+" z wlascicielem "+owner + ".");
		
        local args = 0;
	    do
		{
            args = loadfile.read(io_type.LINE);		
		    if(args != null)
		    {
                local arg = sscanf("sd", args);
                addItemToHouse(count, arg[0], arg[1]);
		    }		    
            else
            {
                break;
            }
        } while (args != null)   				
        		
		count = count + 1;
		}else{break;};
	}
}

addEventHandler("onInit", loadAllHouses)

/// Wysyłamy informacje na temat właścicieli!

function onPlayerEnterGame(pid)
{
    foreach(v,k in AllHouses)
    {
        callClientFunc(pid, "setHouseOwning", v, k.owner);
    }	
}

addEventHandler("onPlayerJoin",onPlayerEnterGame);


/// Funkcje do obsługi skrzynek w domach!

function addItemToHouse(id, item, amount, val = false)
{
	if(AllHouses[id].items.rawin(item))
	{
	    AllHouses[id].items[item] = AllHouses[id].items[item] + amount;
	}else{
		AllHouses[id].items[item] <- amount;
	}
	
	if(val){saveItemsHouse(id)};
}

function removeItemFromHouse(id, item, amount)
{
	if(AllHouses[id].items.rawin(item))
	{
		if(AllHouses[id].items[item] > amount)
		{
			AllHouses[id].items[item] = AllHouses[id].items[item] - amount;
		}
		else
		{
			AllHouses[id].items.rawdelete(item);
		}
	}
}

function saveItemsHouse(id)
{
	local files = io.file("Database/House/house_"+id+".txt", "w");
    files.write(AllHouses[id].owner+"\n");
    foreach(v,k in AllHouses[id].items)
	{
	    files.write(v + " " + k + "\n");
	}
	files.close();
}

/// Funkcja do wysłania listy przedmiotów w GUI domu!

function sendRequestToSendMeItemsHouse(pid, idhome)
{
    foreach(v,k in AllHouses[idhome].items)
	{
	    callClientFunc(pid, "addRowToGUIHouse", v, k);
	}
}


/// Funkcja do odbierania przedmiotów graczofju :)

function tryToResendFromHousePlayer(pid, id, slot, amount)
{
    local _slot = 0;
	
	foreach(v,k in AllHouses[id].items)
	{
	    if(_slot == slot)
		{
		    if(k >= amount)
			{
			    removeItemFromHouse(id, v, amount);
			    giveItem(pid, v, amount);
				callClientFunc(pid, "resetAllGrdListGUIHouse");
				saveItemsHouse(id);
			}
		}
		_slot = _slot + 1;
	}
};