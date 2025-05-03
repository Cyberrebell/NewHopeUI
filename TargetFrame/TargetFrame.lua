NHTargetFrame = {targetBars = {}, bossBars = {}, mobBars = {}}

local function updateTargets()
    local i = 1
    for _, unit in pairs(NHEnemyDB_get_ordered_by_hp_max_desc()) do
        if i > 24 then return end
        NHTargetFrame.targetBars[i]:SetUnit(unit)
        i = i + 1
    end
    for j = i,24 do
        NHTargetFrame.targetBars[j]:SetUnit(nil)
    end
end

local function updateTargetBarValues()
    for _, bar in pairs(NHTargetFrame.targetBars) do
        NHTargetBar:update(bar)
    end
end

local function load()
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
        NHTargetBar:setSmallMode(bar, true)
        bar:Hide()
        table.insert(NHTargetFrame.targetBars, bar)
        table.insert(NHTargetFrame.mobBars, bar)
    end
end

NHEventManager:connect(NHEvent.enteredWorld, load)
NHEventManager:connect(NHEvent.s1IntervalTick, updateTargetBarValues)
NHEventManager:connect(NHEvent.enemyAdded, updateTargets)
NHEventManager:connect(NHEvent.enemyRemoved, updateTargets)
NHEventManager:connect(NHEvent.enemiesUpdated, updateTargets)