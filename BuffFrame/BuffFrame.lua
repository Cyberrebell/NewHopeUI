NHBuffFrame = { buffFrames = {}, buffs = {}, debuffFrames = {}, debuffs = {} }

local function load()
    for i=1,20 do
        NHBuffFrame.buffFrames[i] = _G["NHBuff"..i]
        local rowIndex = (i - 1) % 5
        NHBuffFrame.buffFrames[i]:SetPoint("RIGHT", rowIndex * -22, 0)
    end
    for i=1,5 do
        NHBuffFrame.debuffFrames[i] = _G["NHDebuff"..i]
        NHBuffFrame.debuffFrames[i]:SetPoint("RIGHT", (i - 1) * -122, 0)
    end
end

local function updateBuffs()
    NHTable_truncate(NHBuffFrame.buffs)
    NHBuffFrame.buffs = {}
    local i = 1
    local name, rank, icon, count, duration, expirationTime = UnitBuff("player", i)
    while name do
        NHBuffFrame.buffs[i] = {unit="player", index=i, name=name, rank=rank, icon=icon, count=count, duration=duration, expirationTime=expirationTime}
        i = i + 1
        name, rank, icon, count, duration, expirationTime = UnitBuff("player", i)
    end

    for i=1,20 do
        NHBuffFrame.buffFrames[i]:update(NHBuffFrame.buffs[i])
    end
end

local function updateDebuffs()
    NHTable_truncate(NHBuffFrame.debuffs)
    NHBuffFrame.debuffs = {}
    local i = 1
    local name, rank, icon, count, debuffType, duration, expirationTime = UnitDebuff("player", i)
    while name do
        NHBuffFrame.debuffs[i] = {unit="player", index=i, name=name, rank=rank, icon=icon, count=count, debuffType=debuffType, duration=duration, expirationTime=expirationTime}
        i = i + 1
        name, rank, icon, count, debuffType, duration, expirationTime = UnitDebuff("player", i)
    end

    for i=1,5 do
        NHBuffFrame.debuffFrames[i]:update(NHBuffFrame.debuffs[i])
    end
end

NHEventManager:connect(NHEvent.enteredWorld, load)
NHEventManager:connect(NHEvent.s2IntervalTick, updateBuffs)
NHEventManager:connect(NHEvent.s1IntervalTick, updateDebuffs)