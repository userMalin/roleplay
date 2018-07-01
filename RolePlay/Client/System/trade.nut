// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

local responseTimer = null;
local tradeId = -1;
local inTrade = false;
local itemTrade = null;
local amountTrade = null;
local priceTrade = null;



function startTrade(params)
{
    /////// Sprawdzamy czy masz jaki� aktywny handel?!
	
	if(inTrade == true)
	{
	    addMessage(255,255,255,"Jeste� w trakcie prowadzenia wymiany handlowej!");
	    return;	
	}

 	local args = sscanf("ddd", params);
	if (!args)
	{
	    addMessage(255,255,255,"/h <nr slotu> <ilosc przedmiotu> <cena>");
	    return;	
	}
	
    ////// Sprawdzamy Komende!
	local isItem = getItemBySlot(args[0]);
	
	if(isItem == null)
	{
	    addMessage(255,255,255,"Nie ma przedmiotu o tym numerze!");
	    return;	
	}
	
	local item = Items.id(isItem.instance);
	local amount = args[1];
	local price = args[2];
	
	if(price > 0)
	{
	    addMessage(255,255,255,"�le wprowadzona cena!");
	    return;	
	}
	
	////// Sprawdzamy Czy na kogo� patrzysz!
	
	if(FocusId == -1)
	{
	    addMessage(255,255,255,"Na nikogo nie patrzysz!");
	    return;
	}
	
	///// Ustawiamy Focus :
	
	tradeId = FocusId;
	
	
	///// Sprawdzamy Item czy sie nadaje!
	
	if(getPlayerArmor(heroId) == item)
	{
		addMessage(255,255,255,"Nosisz ten przedmiot!");
		return;
	}
	if(getPlayerMeleeWeapon(heroId) == item)
	{
		addMessage(255,255,255,"Nosisz ten przedmiot!");
		return;
	}
	if(getPlayerRangedWeapon(heroId) == item)
	{
		addMessage(255,255,255,"Nosisz ten przedmiot!");
		return;
	}
	
	////// Ostatnie sprawdzenie i wys�anie oferty Handlowej!
	
	if(hasItem(isItem.instance) >= amount)
	{
		addMessage(255,255,255,"Oferta handlowa "+getItemName(isItem.instance) + " " + amount + " za " + price + " golda. ");
		addMessage(255,255,255,"Zosta�a wys�ana do "+getPlayerName(FocusId)+". Prosz� czeka� na odpowied�!.");
		
		inTrade = true;
		
		responseTimer = setTimer("wasteTimeResponse", 10000, 1);
		callServerFunc("sendOfferTrade", heroId, tradeId, isItem.instance, amount, price);
	}

}

///// Tutaj odbierasz ofert�!

function showTradeOffer(pid, item, amount, cena)
{
    /////// Blokujemy mo�liwo�� handlu!
    tradeId = pid;
	inTrade = true;
	////// Odbieramy pakunek!
	amountTrade = amount;
	itemTrade = item;
	priceTrade = cena;
	addMessage(255,255,255,"Oferta handlowa "+getItemName(isItem.instance) + " " + amount + " za " + price + " golda. ");
	addMessage(255,255,255,"Zosta�a odebrana od "+getPlayerName(tradeId)+". /agree aby zaakceptowa� lub /reject");	
	responseTimer = setTimer("wasteTimeResponse", 10000, 1);
}

function agreeOffer(params)
{
    /////// Handlujesz wog�le?
    if(inTrade == false)
	{
	    addMessage(255,255,255,"Nie prowadzisz wymiany!");
	    return;
	}
    ////// Ty jeste� handluj�cym czy robi�cym handel?	
	if(itemTrade == null)
	{
		addMessage(255,255,255,"Poczekaj na odpowied� z drugiej strony!");
	    return;
	}
	 
	callServerFunc("agreeTrade", heroId, tradeId, itemTrade, amountTrade, priceTrade);
}

function rejectOffer(params)
{
    /////// Handlujesz wog�le?
    if(inTrade == false)
	{
	    addMessage(255,255,255,"Nie prowadzisz wymiany!");
	    return;
	}
	 
	callServerFunc("endTrade", heroId, tradeId);
}

///// Na wypadek gdyby nie starczy�o czasu!

function wasteTimeResponse()
{
	amountTrade = -1;
	itemTrade = null;
	priceTrade = -1;
    inTrade = false;
	callServerFunc("wasteTimeEnd", heroId);
	responseTimer = null;
}

///// Na wypadek b��du po stronie serwera

function endTradeWithReason()
{
	amountTrade = -1;
	itemTrade = null;
	priceTrade = -1;
    killTimer(responseTimer);
	inTrade = false;
	responseTimer = null;
}

addCommand("h", startTrade);
addCommand("agree", agreeOffer);
addCommand("reject", rejectOffer);