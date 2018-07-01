// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

local PTrade = {};

for (local i = 0; i < getMaxSlots(); ++i)
{
    PTrade[i] <- {};
	PTrade[i].tradeid <- -1;
	PTrade[i].intrade <- false;
}

function sendOfferTrade(pid, idtrader, item, amount, cena)
{
    //// Sprawdzamy czy nie prowadzi już handlu!
	
    if(PTrade[idtrader].intrade == true)
	{
	    sendMessageToPlayer(pid, 255, 255, 255, "Gracz na którego patrzysz prowadzi już wymianę!");
	    callClientFunc(pid, "endTradeWithReason");
        return;	
	}
    //// Sprawdzamy czy aby sie zalogował. (Na wszelki wypadek ale to nie możliwe)
	
    if(getPlayerLogin(pid) == false || getPlayerLogin(idtrader) == false)
	{
	    sendMessageToPlayer(pid, 255, 255, 255, "Jeden z was jest nie zalogowany!");
	    callClientFunc(pid, "endTradeWithReason");
        return;	
	}

    PTrade[pid].tradeid = idtrader;
	PTrade[pid].intrade = true;
    PTrade[idtrader].tradeid = pid;
	PTrade[idtrader].intrade = true;
    
	callClientFunc(idtrader,"showTradeOffer",pid,item,amount,cena);
}

function agreeTrade(pid, idtrader, item, amount, cena)
{
    //// Sprawdzamy czy aby sie zalogował. (Na wszelki wypadek ale to nie możliwe)
	
    if(getPlayerLogin(pid) == false || getPlayerLogin(idtrader) == false)
	{
	    sendMessageToPlayer(pid, 255, 255, 255, "Jeden z was jest nie zalogowany!");
	    callClientFunc(pid, "endTradeWithReason");
		callClientFunc(idtrader, "endTradeWithReason");
        return;	
	}  
	
	//// Sprawdzamy czy posiadają itemy do handlu obaj!
	
	if(!hasPlayerItem(pid, "ITMI_GOLD") >= cena)
	{
	    sendMessageToPlayer(pid, 255, 255, 255, "Nie posiadasz tyle złota!");
	    sendMessageToPlayer(idtrader, 255, 255, 255, "Nie posiada tyle zlota!");
	    callClientFunc(pid, "endTradeWithReason");
		callClientFunc(idtrader, "endTradeWithReason");
        return;		    
	}
	
	//// Sprawdzamy czy posiadają itemy do handlu obaj!
	
	if(!hasPlayerItem(idtrader, item) >= amount)
	{
	    sendMessageToPlayer(pid, 255, 255, 255, "Osoba z którą handlujesz nie posiada już tego przedmiotu!");
	    sendMessageToPlayer(idtrader, 255, 255, 255, "Nie posiadasz już tego przedmiotu!");
	    callClientFunc(pid, "endTradeWithReason");
		callClientFunc(idtrader, "endTradeWithReason");
        return;		    
	}
	
	removeItem(idtrader, item, amount);
	giveItem(pid, item, amount);
	removeItem(pid, "ITMI_GOLD", cena);
	giveItem(idtrader, "ITMI_GOLD", cena);
	sendMessageToPlayer(idtrader, 255, 255, 255, "Handel przebiegł pomyślnie!");
	sendMessageToPlayer(pid, 255, 255, 255, "Handel przebiegł pomyślnie!");
	callClientFunc(pid, "endTradeWithReason");
	callClientFunc(idtrader, "endTradeWithReason");	
	wasteTimeEnd(pid);
	wasteTimeEnd(idtrader);
}

function endTrade(pid, tradeid)
{
	sendMessageToPlayer(pid, 255, 255, 255, "Handel został odrzucony!");
	sendMessageToPlayer(idtrader, 255, 255, 255, "Handel został odrzucony!");
	callClientFunc(pid, "endTradeWithReason");
	callClientFunc(idtrader, "endTradeWithReason");	
	wasteTimeEnd(pid);
	wasteTimeEnd(idtrader);
}


function onPlayerLeaveTrade(pid, rs)
{
    ////// Gdyby ktoś z nich wyszedł konczymy handel!
    if(PTrade[pid].intrade == true)
	{
        PTrade[PTrade[pid].tradeid].tradeid = -1;
	    PTrade[PTrade[pid].tradeid].intrade = false;
		callClientFunc(PTrade[pid].tradeid, "endTradeWithReason");
	}
    PTrade[pid].tradeid = -1;
	PTrade[pid].intrade = false;
}

addEventHandler("onPlayerDisconnect",onPlayerLeaveTrade);


function wasteTimeEnd(pid)
{
    PTrade[pid].tradeid = -1;
	PTrade[pid].intrade = false;
}