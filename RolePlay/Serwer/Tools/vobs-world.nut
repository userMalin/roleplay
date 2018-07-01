
// By Quarchodron / CC(2018) / Made for RolePlay v.0.2

local allVobsInWorld = [];

///// Klasa do voba : 

class loadVob
{
    constructor(_x,_y,_z, _rot1, _rot2, _rot3, _collsion, _name, _author)
	{
	    position = [];
		rotation = [];
	   
	    name = _name;
		author = _author;
		collision = _collsion;
		rotation = [_rot1, _rot2, _rot3];
		position = [_x, _y, _z];
	}
	
	name = null;
	position = null;
	rotation = null;
	collision = null;
	author = null;
}

/////// Callback jak gracz wejdzie wczyta mu ten szajs.

local function loadVobsOnStart(pid)
{
    local loadmap = io.file("Database/Tools/map.wb", "r");
    if (loadmap.isOpen)
    {
	local args = 0;
	    do
		{
            args = loadmap.read(io_type.LINE);		
		    if(args != null)
		    {
            local arg = sscanf("dddddddss", args);
			local loadedVob = loadVob(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8]);
		    allVobsInWorld.append(loadedVob);
			sendThisVobClient(pid, allVobsInWorld.len() - 1);
		    }		    
            else
            {
                break;
            }
        } while (args != null)     
	}
	loadmap.close();
}

addEventHandler("onPlayerJoin",loadVobsOnStart);

///// Funkcja do dodania voba wprost z world buildnera.
 
function addThisVobToMap(posx, posy, posz, rot1,rot2,rot3, kolizja, name, author)
{
    local loadedVob = loadVob(posx, posy, posz, rot1,rot2,rot3, kolizja, name, author);
    allVobsInWorld.append(loadedVob);
	
	for (local i = 0; i < getMaxSlots(); i++)
	{
		if(isPlayerConnected(i))
		{
		    sendThisVobClient(i, allVobsInWorld.len() - 1);
		}
	}
}

///// Zapis mapy.

function saveWBMap()
{
    local savemap = io.file("Database/Tools/map.wb", "w");
	if(savemap)
	{
        foreach(v,k in allVobsInWorld)
		{
		    savemap.write(k.position[0] + " " + k.position[1] + " " + k.position[2] + " " + k.rotation[0] + " " + k.rotation[1] + " " + k.rotation[2] + " " + k.collision + " " + k.name + " " + k.author + "\n");
		}
	savemap.close();
	}
}

///// Wysyła voba klienteli: 

function sendThisVobClient(pid, id)
{
    local vob = allVobsInWorld[id];
	local packet = Packet();
    packet.writeUInt16(PacketId.SENDVOBS);
    packet.writeString(vob.name);
    packet.writeString(vob.author);
    packet.writeInt16(vob.collision);
    packet.writeInt32(vob.position[0]);
    packet.writeInt32(vob.position[1]);
    packet.writeInt32(vob.position[2]);
    packet.writeInt16(vob.rotation[0]);
    packet.writeInt16(vob.rotation[1]);
    packet.writeInt16(vob.rotation[2]);
    packet.send(pid, RELIABLE_ORDERED);
}