NHTargetFrame = {}

function NHTargetFrame:updateTargets()
    local i = 1
    for GUID, unit in pairs(NHEnemyDB) do
        if i < 5 then
            _G["NHBoss"..i]:SetUnit(unit)
        elseif i < 21 then
            _G["NHMob"..(i - 4)]:SetUnit(unit)
        end
        i = i + 1
    end
end

local function initTargetFrames()
    for i = 0,3 do
        local bar = _G["NHBoss"..(i + 1)]
        bar:SetPoint("TOP", 0, i * -16)
    end
    for i = 0,19 do
        local bar = _G["NHMob"..(i + 1)]
        bar:SetWidthRec(100)
        bar:SetPoint("TOP", 0, math.floor(i / 4) * -16)
        NHTargetBar:SetSmallMode(bar, true)
    end
end

function NHTargetFrame_OnLoad(self)
    initTargetFrames()
    table.insert(NHEnemyDBEvents.onEnemyAdded, function (GUID)
        NHTargetFrame:updateTargets()
    end)
end