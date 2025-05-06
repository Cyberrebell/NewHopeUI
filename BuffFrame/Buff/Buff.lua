function NHBuff_OnLoad(frame)
    frame:RegisterForClicks("RightButtonUp")
    frame.duration = _G[frame:GetName().."Duration"]
    frame.count = _G[frame:GetName().."Counts"]

    function frame:update(buff)
        frame.buff = buff
        if buff then
            frame.name = buff.name
            frame:SetBackdrop({bgFile=buff.icon})
            frame.duration:SetText(NHBuff_formatTime(buff.expirationTime))
            if buff.count > 1 then
                frame.count:SetText(buff.count)
            else
                frame.count:SetText(nil)
            end
            frame:Show()
        else
            frame:SetBackdrop({})
            frame:Hide()
        end
    end

    function frame:PostClick(btn, button, down)
        frame:SetChecked(0)
        CancelPlayerBuff(frame.name)
    end

    function frame:OnEnter()
        GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
        GameTooltip:SetUnitBuff(frame.buff.unit, frame.buff.index)
        GameTooltip:Show()
    end

    function frame:OnLeave()
        GameTooltip:Hide()
    end
end

function NHBuff_formatTime(seconds)
    if seconds == nil then
        return ""
    end
    if seconds > 86400 then
        return math.ceil(seconds / 86400).."d"
    elseif seconds > 3600 then
        return math.ceil(seconds / 3600).."h"
    elseif seconds > 60 then
        return math.ceil(seconds / 60).."m"
    else
        return math.ceil(seconds).."s"
    end
end