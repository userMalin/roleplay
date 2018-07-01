
// By Quarchodron / CC(2018) / Made for RolePlay v.0.4

local allNotices = [];
local renderNotices = getTickCount() + 50;


class createNotification
{
    constructor(tekst, r, g, b, mnoznik = 0)
	{
	    drawN = Draw(8000 - textWidth(tekst), 2350 + (mnoznik * 280), tekst);
		drawN.setColor(r,g,b);
		
		tekstN = Texture(8000 - textWidth(tekst) - 50,2300 + (mnoznik * 280), textWidth(tekst) + 50, 250, "Menu_Choice_Back.TGA");
	    
		mnoznikN = mnoznik;
		notiTimer = 0;
		moveDown = false;
	}
	
	function show()
	{
	    drawN.visible = true;
		tekstN.visible = true;
		
		drawN.setAlpha(0);
		tekstN.setAlpha(0);
		
		drawN.top();
		
		notiTimer = 0;
	}
	
	function flipDown()
	{
	    mnoznikN = mnoznikN + 1;
		
		moveDown = 0;		
	}
	
	function timeCount()
	{
	    notiTimer ++;
		
		if(notiTimer > 0 && notiTimer < 10)
		{
		    drawN.setAlpha(drawN.getAlpha() + 25);
			tekstN.setAlpha(tekstN.getAlpha() + 25);
		}else if(notiTimer > 90)
		{
		    drawN.setAlpha(drawN.getAlpha() - 25);
			tekstN.setAlpha(tekstN.getAlpha() - 25);

                if(notiTimer > 99)
                {
                    endOfNotification(this);
                }				
		}
		
		if(moveDown != false)
		{
		    moveDown = moveDown + 1;
			
			local nowPosDraw = drawN.getPosition();
			local nowTekstDraw = tekstN.getPosition();
			
		    drawN.setPosition(nowPosDraw.x, nowPosDraw.y + 35);
		    tekstN.setPosition(nowTekstDraw.x, nowTekstDraw.y + 35);			
			
			if(moveDown >= 8)
			{
		        drawN.setPosition(8000 - textWidth(drawN.text), 2350 + (mnoznikN * 280));
		        tekstN.setPosition(8000 - textWidth(drawN.text), 2300 + (mnoznikN * 280));
			
			    moveDown = false;
			}
		}
	}
	
	mnoznikN = 0;
	notiTimer = 0;
	drawN = null;
	tekstN = null;
	moveDown = false;
}

function showNotification(tekst, r = 255, g = 255, b = 255)
{
	if(allNotices.len() > 0)
	{
		foreach(v,k in allNotices)
		{
			k.flipDown();
		}
	}
		
    local noti = createNotification(tekst, r,g,b);
	allNotices.append(noti);
	allNotices[allNotices.len() - 1].show();
}

addEventHandler("onRender", function()
{
	if (renderNotices < getTickCount())
	{
		if(allNotices.len() > 0)
		{
		    foreach(v,k in allNotices)
			{
			    k.timeCount();
			}
		}
		renderNotices = getTickCount() + 100;			
    }
});

function endOfNotification(id)
{
    allNotices.remove(0);
}