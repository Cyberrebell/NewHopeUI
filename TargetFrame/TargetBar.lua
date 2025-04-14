NHTargetBar = {}

function NHTargetBar:PostClick(frame, button, down)
    SendChatMessage(frame.targetName, "SAY")
    frame:SetChecked(0)
end

function NHTargetBar:OnUpdate(frame, elapsed)
    if frame.target then
        local hp = frame.target.hp.value
        local maxHP = frame.target.hp.max
        local name = frame.target.name
        if frame.smallmode then
            name = string.sub(name, 0, 22).."\n"
        else
            name = name.." "
        end
        frame.text:SetText(name..hp.."/"..maxHP..(" (%.1f"):format(100 * hp / maxHP).."%)")
        frame:SetMinMaxValues(0, maxHP)
        frame:SetValue(hp)
        frame:SetStatusBarColor(1, math.min(0.8, frame.target.heat / 8), 0)
    end
end

function NHTargetBar:SetSmallMode(frame, value)
    frame.smallmode = value
    if frame.smallmode then
        local font, _, flags = frame.text:GetFont()
        frame.text:SetFont(font, 8, flags)
    end
end

function NHTargetBar_OnLoad(frame)
    frame.text = _G[frame:GetName().."Text"]
    function frame:SetWidthRec(width)
        frame:SetWidth(width)
        _G[frame:GetName().."Button"]:SetWidth(width)
    end
    function frame:SetUnit(unit)
        frame.target = unit
        if frame.target then
            local button = _G[frame:GetName().."Button"]
            button.targetName = frame.target.name
            frame:Show()
        else
            frame:Hide()
        end
    end
end