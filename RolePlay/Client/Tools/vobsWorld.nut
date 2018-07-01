
// By Quarchodron / CC(2018) / Made for RolePlay v.0.2

local allVobsInWorld = [];

local function receiveVobs(packet)
{
  local id = packet.readUInt16();
  if (id == PacketId.SENDVOBS)
  {
    local vobLoaded = Vob(packet.readString());
    local author = packet.readString();
	local kolizja = packet.readUInt16().tointeger();
	
	vobLoaded.setPosition(packet.readInt32(), packet.readInt32(), packet.readInt32());
	vobLoaded.setRotation(packet.readInt16(), packet.readInt16(), packet.readInt16());	
	
    if(kolizja == 1) { vobLoaded.collision = true; } else { vobLoaded.collision = false; };
	
	allVobsInWorld.append({author = author, vob = vobLoaded});
	vobLoaded = null;
  }
}

addEventHandler("onPacket", receiveVobs);