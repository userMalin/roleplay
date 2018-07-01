
// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

addEvent("onPlayerEnterAreaHouse");
addEvent("onPlayerLeaveAreaHouse");

addEvent("onPlayerEnterHouse");
addEvent("onPlayerLeaveHouse");

class createHouse
{
    constructor(id, _area, roof, floor)
	{
	    area_id = id;
        area = _area;	

        roof_y = roof;
        floor_y = floor;		
	    inhouse = false;
		
		owner = null;
		
		local _this = this;
        addEventHandler("onPlayerEnterAreaHouse", function(areae){ _this.enterHouse(areae) });
	    addEventHandler("onPlayerLeaveAreaHouse", function(areae){ _this.leaveHouse(areae) });
		
        area.onEnter = function(){callEvent("onPlayerEnterAreaHouse", this);}	
        area.onExit = function(){callEvent("onPlayerLeaveAreaHouse", this);}	
    }
	
	function enterHouse(areas)
	{
	    if(areas == area)
		{
		    local pos = getPlayerPosition(heroId);
		
		    if(pos.y >= floor_y && pos.y <= roof_y)
		    {
		        inhouse = true;
				callEvent("onPlayerEnterHouse", area_id, owner);
		    }			     
		}
	}
	
	function leaveHouse(areas)
	{
	    if(areas == area)
		{
		    if(inhouse)
		    {
		        inhouse = false;	
				callEvent("onPlayerLeaveHouse", area_id, owner);
		    }			     
		}
	}
	
	function setOwnerHouse(name)
	{
	    owner = name;
	}
	
	function getOwnerHouse()
	{
	    return owner;
	}
	
	roof_y = 0;
	floor_y = 0;
	area_id = -1;
	area = null;
	inhouse = false;
	owner = null;
}

