NHTargetFrame = {targetBars = {}, bossBars = {}, mobBars = {}}

local function NHEnemyDB_order_by_hp_max_desc()
    local sorted = {}
    for _, val in pairs(NHEnemyDB) do
        table.insert(sorted, val)
    end
    table.sort(sorted, function (a, b)
        return a.hp.max > b.hp.max
    end)
    return sorted
end

function NHTargetFrame:updateTargets()
    local i = 1
    for _, unit in pairs(NHEnemyDB_order_by_hp_max_desc()) do
        if i > 24 then return end
        NHTargetFrame.targetBars[i]:SetUnit(unit)
        i = i + 1
    end
    for j = i,24 do
        NHTargetFrame.targetBars[j]:SetUnit(nil)
    end
end

local function initTargetFrames()
    for i = 0,3 do
        local bar = _G["NHBoss"..(i + 1)]
        bar:SetPoint("TOP", 0, i * -16)
        bar:Hide()
        table.insert(NHTargetFrame.targetBars, bar)
        table.insert(NHTargetFrame.bossBars, bar)
    end
    for i = 0,19 do
        local bar = _G["NHMob"..(i + 1)]
        bar:SetWidthRec(100)
        bar:SetPoint("TOP", 0, math.floor(i / 4) * -16)
        NHTargetBar:SetSmallMode(bar, true)
        bar:Hide()
        table.insert(NHTargetFrame.targetBars, bar)
        table.insert(NHTargetFrame.mobBars, bar)
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