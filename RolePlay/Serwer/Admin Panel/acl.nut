//cc(2018); Quarchodron

local ACL = {
    Admins = [],
	Moderators = [],
    Liders = []
};

function isInACL(type, name)
{
    type = getTypeACL(type);

    switch(type)
	{
	    case 0:
        if (ACL.Admins.find(name) != null)
             return true;
		break;   
		case 1:
        if (ACL.Moderators.find(name) != null)
             return true;		    
		break;		
		case 2:
        if (ACL.Liders.find(name) != null)
             return true;		
		break;
	}
	return false;
}

function getTypeACL(name)
{
    switch(name)
	{
	    case "ADMIN":
		    return 0;
		break;
	    case "MODERATOR":
		    return 1;
		break;
	    case "LIDER":
		    return 2;
		break;
	}
	return 0;
}

function loggInACL(type, name)
{
    type = getTypeACL(type);
	
    switch(type)
	{
	    case 0:
        if (ACL.Admins.find(name) == null)
            ACL.Admins.append(name);
            return true;
		break;   
		case 1:
        if (ACL.Moderators.find(name) == null)
            ACL.Moderators.append(name);
            return true;		    
		break;		
		case 2:
        if (ACL.Liders.find(name) == null)
            ACL.Liders.append(name);
            return true;	
		break;
	}

	return false;
}

function removeNameOnDisconnect(pid, reason)
{
    local name = getPlayerName(pid);
	
    if (ACL.Admins.find(name) != null)
        ACL.Admins.remove(ACL.Admins.find(name));   
		
    if (ACL.Moderators.find(name) != null)
        ACL.Moderators.remove(ACL.Moderators.find(name));   
		
    if (ACL.Liders.find(name) != null)
        ACL.Liders.remove(ACL.Liders.find(name));   
}

addEventHandler("onPlayerDisconnect", removeNameOnDisconnect);

function ACLResetTables()
{
ACL.Admins.clear();
ACL.Moderators.clear();
ACL.Liders.clear();
}