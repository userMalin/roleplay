//----------------------------------------------------------------------------
//              AUTHOR PACKET SCRIPT: Bimbol, modified by Tommy
//----------------------------------------------------------------------------

enum SYNC_BOT 
{
    SENDER = 0,
    UPDATE = 1,
    LAST_UPDATE = 2,
    RESPAWN = 3,
    HEALTH = 4,
    
    CREATE = 5,
    CREATE_HP = 6,
    CREATE_STR = 7,
    CREATE_DEX = 8,
    CREATE_NAME = 9,
    CREATE_COLOR = 10,
    CREATE_ARMOR = 11,
    CREATE_MELEE_WEAPON = 12,
    CREATE_RANGE_WEAPON = 13,
    CREATE_VISUAL = 14,
    CREATE_POSITION = 15,
    CREATE_SKILL = 16,
    CREATE_DISTANCE = 17,
    CREATE_DISTANCE_ATTACK = 18,

	BOT_POSITION = 19,
	BOT_COLOR = 20,
	BOT_NAME = 21,
	BOT_HEALTH = 22,


    ID = 120,
}

namePacket <- [
    "update_Bot",
    "spawn_Bot",
    "health_Bot",
];


//
function sendSyncBot(pid, type, funcID, ...)
{
	packet <- Packet();
	packet.writeChar(SYNC_BOT.ID);
    packet.writeInt8(funcID)
	packet.writeChar(vargv.len());

	foreach(val in vargv)
	{
		switch (typeof(val))
		{
		case "null":
			packet.writeChar('n');
			break;

		case "bool":
			packet.writeChar('b');
			packet.writeBool(val);
			break;

		case "integer":
			packet.writeChar('i');
            if(val >= -128 && val <= 127)
			{
				packet.writeChar(1);
				packet.writeInt8(val);
			}
            else if(val >= -32767 && val <= 32767)
			{
				packet.writeChar(2);
				packet.writeInt16(val);
			}
		    else 
			{
				packet.writeChar(3);
				packet.writeInt32(val); 
			}
			break;

		case "float":
			packet.writeChar('f');
			packet.writeFloat(val);
			break;

		case "string":
			packet.writeChar('s');
			packet.writeString(val);
			break;
		}
	}

	packet.send(pid, type);
	delete packet;
}

local function packetReceiver(pid, packet)
{
	local id = packet.readChar();
	if (id == SYNC_BOT.ID)
	{
		local nameID = packet.readInt8();
        local func = namePacket[nameID] + "(";
		local len = packet.readChar();

		for (local i = 0; i < len; ++i)
		{
			if (i > 0) func += ","

			switch (packet.readChar())
			{
			case 'n':
				func += "null";
				break;

			case 'b':
				func += packet.readBool();
				break;

			case 'i':
				local char = packet.readChar();
                if(char == 1) func += packet.readInt8();
                else if(char == 2) func += packet.readInt16();
                else func += packet.readInt32(); 
				break;

			case 'f':
				func += packet.readFloat();
				break;

			case 's':
				func += "\"" + packet.readString() + "\"";
				break;
			}
		}

		func += ")";
		local compiledScript = compilestring(func);
		compiledScript();
	}
}

addEventHandler("onPacket", packetReceiver);

function update_Bot(_name)
{
    print("Hello World")
}