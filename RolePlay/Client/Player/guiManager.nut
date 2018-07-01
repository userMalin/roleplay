// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

/*
===============================================
    Funkcje uzupełniające pokazywanie GUI
===============================================
*/

function showGUIManager(window = null)
{
    if(window != null)
	{
	    window.visible(true);
	}
	setVisibleGothicBar(false);
    setFreeze(true);
    setCursorVisible(true);
	freezeCam();
	active_GUI = true;
	Chat.hide();
}


function hideGUIManager(window = null)
{
    if(window != null)
	{
	    window.visible(false);
	}
	setVisibleGothicBar(true);
    setFreeze(false);
    setCursorVisible(false);
    setDefaultCamera();
    Chat.show();
    active_GUI = false;
}

//////////////////////////////////////

function disableAllKeys()
{
  for(local i = 0; i<200; i++)
  {
  disableKey(i, true);
  }
}

function enableAllKeys()
{
  for(local i = 0; i<200; i++)
  {
  disableKey(i, false);
  }
  /// Wyjątki
  disableKey(1, true);
  disableKey(48, true);
  disableKey(46, true);
  disableKey(29, true);
  disableKey(56, true);
  disableKey(66, true);
}