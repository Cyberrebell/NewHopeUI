NHTargetFrame = {}

function NHTargetFrame:updateTargets()
    local i = 1
    for GUID, unit in pairs(NHEnemyDB) do
        if i < 5 then
            _G["NHBoss"..i]:SetUnit(unit)
        elseif i < 25 then
            _G["NHMob"..(i - 4)]:SetUnit(unit)
        end
        i = i + 1
    end
    for k = i,24 do
        if k < 5 then
            _G["NHBoss"..k]:SetUnit(nil)
        else
            _G["NHMob"..(k - 4)]:SetUnit(nil)
        end
    end
end

local function initTargetFrames()
    for i = 0,3 do
        local bar = _G["NHBoss"..(i + 1)]
        bar:SetPoint("TOP", 0, i * -16)
        bar:Hide()
    end
    for i = 0,19 do
        local bar = _G["NHMob"..(i + 1)]
        bar:SetWidthRec(100)
        bar:SetPoint("TOP", 0, math.floor(i / 4) * -16)
        NHTargetBar:SetSmallMode(bar, true)
        bar:Hide()
    end
end

function NHTargetFrame_OnLoad(self)
    initTargetFrames()
    table.insert(NHEnemyDBEvents.onEnemyAdded, function (GUID)
        NHTargetFrame:updateTargets()
    end)
    table.insert(NHEnemyDBEvents.onEnemyRemoved, function (GUID)
        NHTargetFrame:updateTargets()
    end)
    table.insert(NHEnemyDBEvents.onEnemiesUpdated, function ()
        NHTargetFrame:updateTargets()
    end)
end