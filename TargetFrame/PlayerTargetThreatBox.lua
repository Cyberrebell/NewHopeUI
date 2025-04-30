function NHPlayerTargetThreatBox_OnLoad(frame)
    frame.bars = {}
    for i=1,5 do
        frame.bars[i] = _G[frame:GetName().."Bar"..i]
        frame.bars[i].text = _G[frame:GetName().."Bar"..i.."Text"]
        frame.bars[i]:SetPoint("TOP", 0, (i - 1) * -10)
    end
    function frame:update()
        for i, bar in pairs(frame.bars) do
            bar.text:SetText("Player "..i.." (80%)")
            bar:SetMinMaxValues(0, 1)
            bar:SetValue(1)
        end
    end
end