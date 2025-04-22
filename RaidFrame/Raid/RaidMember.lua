function NHRaidMember_OnLoad(frame)
    frame.reference = "raid"..string.sub(frame:GetName(), 7)
    frame.text = _G[frame:GetName().."Text"]
    frame.button = _G[frame:GetName().."Button"]
    frame.mana = _G[frame:GetName().."ManaBar"]
    frame.button:SetAttribute("unit", frame.reference)

    function frame:Update()
        local playerName = UnitName(frame.reference)
        frame.text:SetText(playerName)
        if playerName then
            frame:Show()
        else
            frame:Hide()
        end
    end
end