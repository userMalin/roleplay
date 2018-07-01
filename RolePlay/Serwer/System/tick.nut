// ------------------------------------------------------------------- //
// --                                                               -- //
// --	Project:		Gothic 2 Online Utility Scripts             -- //
// --	Developers:		HammelGammel                                -- //
// --                                                               -- //
// ------------------------------------------------------------------- //

addEvent("onTick");

addEventHandler("onInit", function()
{
	setTimer(function()
	{
		callEvent("onTick");
	}, 50, 0);
});
