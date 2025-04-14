NHTargetFrame = {}

function NHTargetFrame:updateTargets()
    local i = 1
    for GUID, unit in pairs(NHEnemyDB) do
        if i < 5 then
            _G["NHBoss"..i]:SetUnit(unit)
        end
        i = i + 1
    end
end

function NHTargetFrame_OnLoad(self)
    for i = 0,3 do
        local bar = _G["NHBoss"..(i + 1)]
        bar:SetPoint("TOP", 0, i * -16)
    end
    table.insert(NHEnemyDBEvents.onEnemyAdded, function (GUID)
        NHTargetFrame:updateTargets()
    end)
end