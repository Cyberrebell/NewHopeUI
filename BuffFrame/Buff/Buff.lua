function NHBuff_OnLoad(frame)
    frame:RegisterForClicks("RightButtonUp")

    function frame:update(icon, name)
        frame.name = name
        if icon then
            frame:SetBackdrop({bgFile=icon})
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
end