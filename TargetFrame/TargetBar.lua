NHTargetBar = {}

function NHTargetBar:PostClick(frame, button, down)
    SendChatMessage(frame.target.name, "SAY")
    frame:SetChecked(0)
end

function NHTargetBar:OnUpdate(frame, elapsed)
    if frame.target then
        local hp = frame.target.hp.value
        local maxHP = frame.target.hp.max
        frame.text:SetText(frame.target.name.." "..hp.." / "..maxHP..(" (%.1f"):format(100 * hp / maxHP).."%)")
        frame:SetMinMaxValues(0, maxHP)
        frame:SetValue(hp)
    else
        frame:Hide()
    end
end

function NHTargetBar_OnLoad(frame)
    frame.text = _G[frame:GetName().."Text"]
    function frame:SetUnit(unit)
        frame.target = unit
        local button = _G[frame:GetName().."Button"]
        button.targetName = frame.target.name
        frame:Show()
    end
end