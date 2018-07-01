
// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

local vobCamera = Vob("Quar.3DS");

function setDefaultCamera()
{
	Camera.modeChangeEnabled = true;
	Camera.enableMovement(true);
	Camera.setTargetPlayer(heroId);
}

function setCameraBeforePlayer(distance = 120)
{
	/// **  = = = = = = = = = = = = = = = = ** \\\
	local pos = getPlayerPosition(heroId);
	local angle = getPlayerAngle(heroId);
	local x = pos.x;
	local y = pos.y;
	local z = pos.z;
	vobCamera.setPosition(pos.x,pos.y,pos.z);
	vobCamera.setRotation(0, angle, 0);
	/// **  = = = = = = = = = = = = = = = = ** \\\
	x = x + (sin(angle * 3.14 / 180.0) * distance);
	z = z + (cos(angle * 3.14 / 180.0) * distance);
	/// **  = = = = = = = = = = = = = = = = ** \\\
	vobCamera.setPosition(x, y, z);
	vobCamera.setRotation(0, angle + 180, 0);
	/// **  = = = = = = = = = = = = = = = = ** \\\
	Camera.setTargetVob(vobCamera);
}

function freezeCam(val = 200)
{
	local camtimer = setTimer(function()
	{
		Camera.enableMovement(false);
	}, val, 1);
}

