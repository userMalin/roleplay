
// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

local AllHouses = [];

local function addHouses()
{
    //////// STARY OBÓZ / /////////////////
	
	/// Dom w którym mieszkał diego w colony! 
	
    AllHouses.append(createHouse(0, Area({
	pos =
	[
	  {x = -3247.73, z = 2947.2},
	  {x = -3629.89, z = 3700.19},
	  {x = -3191.09, z = 3912.3},
	  {x = -2816.71, z = 3228.24}
	]
 
	world = "COLONY.ZEN"
   }), -305, -725));
   
    AllHouses.append(createHouse(1, Area({
	pos =
	[
	  {x = -4451.73, z = 4032.2},
	  {x = -4319.89, z = 4506.19},
	  {x = -3497.09, z = 4219.3},
	  {x = -3708.71, z = 3762.24}
	]
 
	world = "COLONY.ZEN"
   }), -507, -777));
}


addEventHandler("onInit", addHouses);

///// Funkcje do listy domów !

function setHouseOwning(id, name)
{
    foreach(v,k in AllHouses)
	{
	    if(k.area_id == id)
		{
		    k.setOwnerHouse(name);
		    break;
		}
	}
}


addEventHandler("onPlayerEnterHouse", function(id, owner)
{
    if(owner == getPlayerName(heroId))
	{
	    showNotification("Dom nr."+id+" : "+owner+" (P - panel)");
	}else
	{
	    showNotification("Dom nr."+id+" : "+owner);
	}	
})
