
// By Quarchodron / CC(2018) / Made for RolePlay v.0.3

///////////////////////////////////////////////////////////
addEvent("onEndDialogOption")
///////////////////////////////////////////////////////////

class createDialog
{
    constructor(tableDialog)
	{
	    dialog = {};
         
        for(local i = 0; i < tableDialog.len(); i = i + 1)
        {
            dialog[i] <- {};
			dialog[i].nazwa <- "";
			dialog[i].button <- null;
			dialog[i].rozmowa <- [];
        }		
		 
	    local id = 0;
	    foreach(v,k in tableDialog)
		{
		    dialog[id].nazwa = k.name;
			foreach(opcja in k.option)
			{
			    dialog[id].rozmowa.append(opcja);		
			}
			id = id + 1;
		} 
		
		dialogMenu = null;
		
		local _this = this;
		addEventHandler("onMenu", function(menu, button, btnStatus, id){ _this.menuHandler(menu, button, btnStatus, id) });
	}
	
	function showDialog()
	{
	    dialogMenu = Gui.Menu({
        x = 2213,
        y = 6464,
        width = 3500,
        height = 300,
        margin = 50,
        hoverTxt = "MENU_INGAME.TGA",
        hoverColor = [255, 255, 255],
        });	
	
        foreach(v,k in dialog)
		{
		    k.button = dialogMenu.addOption(k.nazwa, "MENU_CHOICE_BACK.TGA" 255, 255, 255, "MENU_CHOICE_BACK.TGA", 200, 200, 200);
		}
		
		dialogMenu.setVisible(true);
	}
	
	function hideDialog()
	{
	    dialogMenu.setVisible(false);
		dialogMenu = null;
		
		foreach(v,k in dialog)
		{
		    k.button = null;
		}
	}

	function menuHandler(menu, button, btnStatus, id)
	{
        if(menu == dialogMenu && button == MOUSE_LMB  && btnStatus == MOUSE_BOTTOM)
        {	
		    foreach(v,k in dialog)
		    {
		        if(k.button == id)
				{
				    showAnimatedDialog(this, k.rozmowa, v);
					dialogMenu.setVisible(false);
					break;
				}
		    }		
		}
	}
	
	function hideDialogAnimation(idDialog)
	{ 
	    callEvent("onEndDialogOption", idDialog, dialog[idDialog].nazwa);
		if(dialogMenu != null)
		{
		    dialogMenu.setVisible(true);
		}
	}
	
	dialogMenu = null;
	dialog = null;
}
