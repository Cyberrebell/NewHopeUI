function NHPlayerTargetThreatBox_OnLoad(frame)
    frame.bars = {}
    frame.guid = nil
    for i=1,5 do
        frame.bars[i] = _G[frame:GetName().."Bar"..i]
        frame.bars[i].text = _G[frame:GetName().."Bar"..i.."Text"]
        frame.bars[i]:SetPoint("TOP", 0, (i - 1) * -10)
    end

    function frame:updateTarget()
        frame.guid = UnitGUID("target")
    end

    local function getTop5()
        if not NHEnemyDB[frame.guid] then
            return {}
        end
        local targetThreat = NHEnemyDB[frame.guid].threat
        table.sort(targetThreat, function (a, b)
            return a > b
        end)
        local result = {}
        local i = 1
        for guid, threat in pairs(targetThreat) do
            result[i] = { guid = guid, threat = threat }
            i = i + 1
            if i > 5 then
                return result
            end
        end
        return result
    end

    function frame:update()
        local threatTop5 = getTop5()
        local topThreat = 0
        if threatTop5[1] then
            topThreat = threatTop5[1].threat
        end

        for i, bar in pairs(frame.bars) do
            if threatTop5[i] then
                bar.text:SetText(threatTop5[i].threat.." "..UnitName("targettarget").." ("..(100 * threatTop5[i].threat / topThreat).."%)")
                bar:SetMinMaxValues(0, topThreat)
                bar:SetValue(threatTop5[i].threat)
            else
                bar.text:SetText("")
                bar:SetMinMaxValues(0, 1)
                bar:SetValue(0)
            end
        end
    end
end