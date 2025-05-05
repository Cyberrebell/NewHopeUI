function NHDebuff_OnLoad(frame)
    frame.duration = _G[frame:GetName().."Duration"]
    frame.count = _G[frame:GetName().."Counts"]
    frame.iconFrame = _G[frame:GetName().."IconFrame"]

    function frame:update(buff)
        if buff then
            frame.name = buff.name
            frame.iconFrame:SetBackdrop({
                bgFile=buff.icon,
                edgeFile="Interface/Tooltips/UI-Tooltip-Border",
                insets={left=5, right=5, top=5, bottom=5}})
            frame.iconFrame:SetBackdropBorderColor(1, 0, 0)
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