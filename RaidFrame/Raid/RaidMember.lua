function NHRaidMember_OnLoad(frame)
    frame.reference = "raid"..string.sub(frame:GetName(), 7)
    frame.text = _G[frame:GetName().."Text"]
    frame.button = _G[frame:GetName().."Button"]
    frame.mana = _G[frame:GetName().."ManaBar"]
    frame.button:SetAttribute("unit", frame.reference)
    frame.button:RegisterForClicks("AnyDown")

    function frame:Update()
        local playerName = UnitName(frame.reference)
        frame.text:SetText(playerName)
        frame:SetMinMaxValues(0, UnitHealthMax(frame.reference))
        frame:SetValue(UnitHealth(frame.reference))
        frame.mana:SetMinMaxValues(0, UnitManaMax(frame.reference))
        frame.mana:SetValue(UnitMana(frame.reference))
        if playerName then
            frame:Show()
        else
            frame:Hide()
        end
    end

    function frame:SetHealerMode(active)
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
end