// By Quarchodron / CC(2018) / Made for RolePlay v.0.2

class addCraft
{
    constructor(_source, _reward)
	{
	    source = {};
		reward = {};
		
	    foreach(v,k in _source)
		{
		    source[k[0]] <- k[1];
		}
	    foreach(v,k in _reward)
		{
		    reward[k[0]] <- k[1];
		}
	}
	
	function execute()
	{
	    local exegood = true;
		
	    foreach(v,k in source)
		{
		    local item = hasItem(v);
			if(item < k)
			{
			    exegood = false;
				callEvent("onCallCraft", this, false);
				break;
			}
		}
		
		if(exegood == true)
		{
		    callEvent("onCallCraft", this, true);
			
	        foreach(v,k in source)
		    {
                removeItem(heroId, v, k);
		    }

	        foreach(v,k in reward)
		    {
                giveItem(heroId, v, k);
		    }			
		}
	}
	
	function getSource()
	{
	    return source;
		foreach(v,k in source)
		{
		    print(v + " " + k);
		}
	}
	
	source = null;
	reward = null;
}