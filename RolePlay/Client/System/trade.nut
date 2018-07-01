// By Quarchodron / CC(2018) / Made for RolePlay v.0.1

local responseTimer = null;
local tradeId = -1;
local inTrade = false;
local itemTrade = null;
local amountTrade = null;
local priceTrade = null;



function startTrade(params)
{
    /////// Sprawdzamy czy masz jakiœ aktywny handel?!
	
	if(inTrade == true)
	{
	    addMessage(255,255,255,"Jesteœ w trakcie prowadzenia wymiany handlowej!");
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
	    addMessage(255,255,255,"le wprowadzona cena!");
	    return;	
	}
	
	////// Sprawdzamy Czy na kogoœ patrzysz!
	
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
	
	////// Ostatnie sprawdzenie i wys³anie oferty Handlowej!
	
	if(hasItem(isItem.instance) >= amount)
	{
		addMessage(255,255,255,"Oferta handlowa "+getItemName(isItem.instance) + " " + amount + " za " + price + " golda. ");
		addMessage(255,255,255,"Zosta³a wys³ana do "+getPlayerName(FocusId)+". Proszê czekaæ na odpowiedŸ!.");
		
		inTrade = true;
		
		responseTimer = setTimer("wasteTimeResponse", 10000, 1);
		callServerFunc("sendOfferTrade", heroId, tradeId, isItem.instance, amount, price);
	}

}

///// Tutaj odbierasz ofertê!

function showTradeOffer(pid, item, amount, cena)
{
    /////// Blokujemy mo¿liwoœæ handlu!
    tradeId = pid;
	inTrade = true;
	////// Odbieramy pakunek!
	amountTrade = amount;
	itemTrade = item;
	priceTrade = cena;
	addMessage(255,255,255,"Oferta handlowa "+getItemName(isItem.instance) + " " + amount + " za " + price + " golda. ");
	addMessage(255,255,255,"Zosta³a odebrana od "+getPlayerName(tradeId)+". /agree aby zaakceptowaæ lub /reject");	
	responseTimer = setTimer("wasteTimeResponse", 10000, 1);
}

function agreeOffer(params)
{
    /////// Handlujesz wogóle?
    if(inTrade == false)
	{
	    addMessage(255,255,255,"Nie prowadzisz wymiany!");
	    return;
	}
    ////// Ty jesteœ handluj¹cym czy robi¹cym handel?	
	if(itemTrade == null)
	{
		addMessage(255,255,255,"Poczekaj na odpowiedŸ z drugiej strony!");
	    return;
	}
	 
	callServerFunc("agreeTrade", heroId, tradeId, itemTrade, amountTrade, priceTrade);
}

function rejectOffer(params)
{
    /////// Handlujesz wogóle?
    if(inTrade == false)
	{
	    addMessage(255,255,255,"Nie prowadzisz wymiany!");
	    return;
	}
	 
	callServerFunc("endTrade", heroId, tradeId);
}

///// Na wypadek gdyby nie starczy³o czasu!

function wasteTimeResponse()
{
	amountTrade = -1;
	itemTrade = null;
	priceTrade = -1;
    inTrade = false;
	callServerFunc("wasteTimeEnd", heroId);
	responseTimer = null;
}

///// Na wypadek b³êdu po stronie serwera

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