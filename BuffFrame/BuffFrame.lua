NHBuffFrame = { buffFrames = {}, buffs = {} }

local function load()
    for i=1,20 do
        NHBuffFrame.buffFrames[i] = _G["NHBuff"..i]
        local rowIndex = (i - 1) % 5
        NHBuffFrame.buffFrames[i]:SetPoint("RIGHT", rowIndex * -22, 0)
    end
end

local function update()
    NHTable_truncate(NHBuffFrame.buffs)
    NHBuffFrame.buffs = {}
    local i = 1
    local name, rank, icon, count, duration, expirationTime = UnitBuff("player", i)
    while name do
        NHBuffFrame.buffs[i] = { name = name, rank = rank, icon = icon, count = count, duration = duration, expirationTime = expirationTime }
        i = i + 1
        name, rank, icon, count, duration, expirationTime = UnitBuff("player", i)
    end

    for i=1,20 do
        local buffFrame = NHBuffFrame.buffFrames[i]
        local buff = NHBuffFrame.buffs[i]
        if buff then
            buffFrame:update(buff.icon, buff.name)
        else
            buffFrame:update(nil, nil)
        end
    end
end

NHEventManager:connect(NHEvent.enteredWorld, load)
NHEventManager:connect(NHEvent.s2IntervalTick, update)