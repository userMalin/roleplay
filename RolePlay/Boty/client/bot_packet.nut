//----------------------------------------------------------------------------
//              AUTHOR: Bimbol, modified by Tommy
//----------------------------------------------------------------------------

enum SYNC_BOT 
{
    UPDATE = 0,
    SPAWN = 1,
    HEALTH = 2,

    ID = 120,
}

namePacket <- [
    "sender_Bot",
    "update_Bot",
    "lastPosition_Bot",
    "respawn_Bot",
    "health_Bot",

    "createBot",
    "createBot_Hp",
    "createBot_Str",
    "createBot_Dex",
    "createBot_Name",
    "createBot_Color",
    "createBot_Armor",
    "createBot_MeleeWeapon",
    "createBot_RangedWeapon",
    "createBot_Visual",
    "createBot_Position",
    "createBot_Skill",
    "createBot_Distance",
    "createBot_DistanceAttack",
	//synchronized functions
	"setBotPosition",
	"setBotColor",
	"setBotName",
	"setBotHealth",
];

//
function sendSyncBot(type, funcID, ...)
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

	packet.send(type);
	delete packet;
}

local function packetReceiver(packet)
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
		//print(func)
		local compiledScript = compilestring(func);
		compiledScript();
	}
}

addEventHandler("onPacket", packetReceiver);


//syncBot(RELIABLE_ORDERED, SYNC_BOT.UPDATE, "test")