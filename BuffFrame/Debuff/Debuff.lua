function NHDebuff_OnLoad(frame)
    frame.duration = _G[frame:GetName().."Duration"]
    frame.count = _G[frame:GetName().."Counts"]

    function frame:update(buff)
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
end