function NHRaidMember_OnLoad(frame)
    frame.text = _G[frame:GetName().."Text"]
    frame.button = _G[frame:GetName().."Button"]
    frame.mana = _G[frame:GetName().."ManaBar"]
    frame.button:RegisterForClicks("AnyDown")
    frame.forceVisible = false
    frame.raidIndex = tonumber(string.sub(frame:GetName(), 7))
    frame.reference = nil

    function frame:update()
        if frame.reference ~= nil then
            frame:SetMinMaxValues(0, UnitHealthMax(frame.reference))
            frame:SetValue(UnitHealth(frame.reference))
            frame.mana:SetMinMaxValues(0, UnitManaMax(frame.reference))
            frame.mana:SetValue(UnitMana(frame.reference))
        end
    end

    function frame:updateReference()
        if GetNumRaidMembers() > 0 then
            frame.reference = "raid"..frame.raidIndex
        else
            if frame.raidIndex == 1 then
                frame.reference = "player"
            else
                frame.reference = "party"..(frame.raidIndex - 1)
            end
        end
        frame.button:SetAttribute("unit", frame.reference)
        local playerName = UnitName(frame.reference)
        frame.text:SetText(playerName)
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