class Gui.Manager
{
    static windows = [];

    constructor(_node = null)
    {
        isOpen = false;
        isMoveActive = false;
        dimension = null;
        move = true;

        gui = {
            node = null,
            element = [],
        };

        if(_node != null)
        {
            gui.node = _node;
            windows.append(this);
        }

        local _this = this;
        addEventHandler("onClick", function(btn, status){ _this.mouseClick(btn, status) });
        addEventHandler("onFPSLimit", function(){ _this.renderLimit() });
    }

    function node(_instance)
    {
        gui.node = _instance;
        windows.append(this);
        return _instance;
    }

    function element(_instance)
    {
        gui.element.append(_instance);
        return _instance;
    }

    function setPosition(_x, _y)
    {
        local elementDistance = {
            x = [],
            y = [],
        }

        local nodePos = gui.node.getPositionPx();

        foreach(_element in gui.element)
        {
            local pos = _element.getPositionPx();

            elementDistance.x.append(pos.x - nodePos.x);
            elementDistance.y.append(pos.y - nodePos.y);
        }

        gui.node.setPositionPx(_x, _y);

        foreach(i, _element in gui.element)
        {
            _element.setPositionPx(_x + elementDistance.x[i], _y + elementDistance.y[i])
        }
    }

    function visible(bool)
    {
        isOpen = bool;
        gui.node.setVisible(bool);

        foreach(i, _element in gui.element)
        {
            _element.setVisible(bool);
        }   
		callEvent("changeStateMenu", bool);
    }

    function unlock(bool)
    {
        gui.node.active = bool;

        foreach(i, _element in gui.element)
        {
            _element.active = bool;
        }         
    }

    function alpha(val)
    {
        gui.node.setAlpha(val);

        foreach(i, _element in gui.element)
        {
            _element.setAlpha(val);
        }         
    }

    function top()
    {
        gui.node.top();

        foreach(i, _element in gui.element)
        {
            _element.top();
        }    
    }

    function mouseClick(btn, status)
    {
        if(btn == MOUSE_LMB && move)
        {
            switch(status)
            {
                case MOUSE_BOTTOM:
                    if(isMouseInPositionTexture(gui.node) && isOpen)
                    {
                        local cur = getCursorPositionPx();
                        local pos = gui.node.getPositionPx();
                        dimension = {
                            x = pos.x - cur.x,
                            y = pos.y - cur.y
                        };
                        isMoveActive = true;
                    }
                    break;
                case MOUSE_TOP:
                    isMoveActive = false;
                    break;
            }
        }
    }

    function renderLimit()
    {
        if(isMoveActive)
        {
            local cur = getCursorPositionPx();
            this.setPosition(cur.x + dimension.x, cur.y + dimension.y);
        }
    }

    static function allHide()
    {
        foreach(_window in windows)
            _window.visible(false);
    }   

    isMoveActive = false;
    isOpen = false;
    move = false;
    gui = null;
    dimension = null;
};
/*)
local gui = Gui.Manager();
local node = gui.node(Gui.Texture(200, 200, 200, 150, "DLG_CONVERSION.TGA"));
local draw = gui.element(Gui.Draw(0, 0, "My Text"));

//struct (create)
Gui.Manager.node(instance);
Gui.Manager.element(instance);
//////////
Gui.Manager.isOpen;
Gui.Manager.visible(bool);
Gui.Manager.unlock(bool);
Gui.Manager.move = true;
Gui.Manager.alpha(int);*/

/*
local gui = Gui.Manager();
local node = gui.node(Gui.Texture(4000, 4000, 4000, 4000, "DLG_CONVERSATION.TGA"));

addEventHandler("onInit", function(){
    gui.visible(true);
    setCursorVisible(true)
});*/
