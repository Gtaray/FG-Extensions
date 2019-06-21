function onInit()
    setHoverCursor("hand");
    ActionsManager.registerResultHandler("durability", onDurabilityResult);
end

function onDoubleClick(x,y)
    return onDurabilityRoll();
end			

function onDragStart(button, x, y, draginfo)
    return onDurabilityRoll(draginfo);
end

function onDurabilityRoll(draginfo)
    local nodeItem = window.getDatabaseNode();
    local nodeChar = nodeItem.getChild("...");
    local rActor = ActorManager.getActor("pc", nodeChar);
    local sDur = DB.getValue(nodeItem, "durability", "")
    rRoll = {};

    if sDur == "" then
        return false;
    end
    
    sDur = sDur:lower();
    rRoll = { 
        sType = "durability", 
        sDesc = "Durability roll on " .. DB.getValue(nodeItem, "name", ""),
        aDice = { sDur },
        nMod = 0
    };

    ActionsManager.performAction(draginfo, rActor, rRoll);
    return true;
end

function onDurabilityResult(rSource, rTarget, rRoll)
    local bSuccess = false;
    for _,v in ipairs(rRoll.aDice) do
        if v.result > 2 then
            bSuccess = true;
        end
    end

    local msg = ActionsManager.createActionMessage(rSource, rRoll);
    msg.type = "dice";

    if bSuccess then
        msg.text = msg.text .. " [SUCCESS]";
    else
        msg.text = msg.text .. " [FAILURE]";
        DB.setValue(window.node, "durability", "string", decrementDurability());
    end
    Comm.deliverChatMessage(msg);	
end

function decrementDurability()
    local sDur = DB.getValue(window.node, "durability", "");

    if sDur == "D12" then
        return "D10";
    elseif sDur == "D10" then
        return "D8";
    elseif sDur == "D8" then
        return "D6";
    elseif sDur == "D6" then
        return "D4";
    else
        return ""
    end
end