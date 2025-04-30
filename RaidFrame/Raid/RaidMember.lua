function NHRaidMember_OnLoad(frame)
    frame.reference = "raid"..string.sub(frame:GetName(), 7)
    frame.text = _G[frame:GetName().."Text"]
    frame.button = _G[frame:GetName().."Button"]
    frame.mana = _G[frame:GetName().."ManaBar"]
    frame.button:SetAttribute("unit", frame.reference)
    frame.button:RegisterForClicks("AnyDown")
    frame.forceVisible = false

    function frame:update()
        local playerName = UnitName(frame.reference)
        frame.text:SetText(playerName)
        frame:SetMinMaxValues(0, UnitHealthMax(frame.reference))
        frame:SetValue(UnitHealth(frame.reference))
        frame.mana:SetMinMaxValues(0, UnitManaMax(frame.reference))
        frame.mana:SetValue(UnitMana(frame.reference))
        if playerName then
            frame:Show()
        elseif not frame.forceVisible then
            frame:Hide()
        end
    end

    function frame:setHealerMode(active)
        if active then
            frame.button:SetAttribute("action1", 1)
            frame.button:SetAttribute("action2", 3)
            frame.button:SetAttribute("action3", 2)
        else
            frame.button:SetAttribute("action1", 62)
            frame.button:SetAttribute("action2", 110)
            frame.button:SetAttribute("action3", 109)
        end
    end

    function frame:setVisible(visible)
        if visible then
            frame.mana:Show()
            frame:SetBackdropColor(0, 0, 0, 1)
        else
            frame.mana:Hide()
            frame.text:SetText("")
            frame:SetMinMaxValues(0, 1)
            frame:SetValue(0)
            frame:SetBackdropColor(0, 0, 0, 0)
        end
    end
end