NHRaid = { members = {} }

local function load()
    for i=1,30 do
        local raidMember = _G["NHRaid"..i]
        local yOffset = (i - 1) % 10
        raidMember:SetPoint("TOP", 0, yOffset * -21)
        table.insert(NHRaid.members, raidMember)
        raidMember:setHealerMode(false)
    end
end

local function update()
    for _, raidMember in pairs(NHRaid.members) do
        raidMember:update()
    end
    _G["NHPlayerTargetTarget"]:setHealerMode(NHPlayer.isHeal)
end

local function updateReferences()
    for _, raidMember in pairs(NHRaid.members) do
        raidMember:updateReference()
        raidMember:setHealerMode(NHPlayer.isHeal)
        raidMember:update()
    end
end

NHEventManager:connect(NHEvent.enteredWorld, load)
NHEventManager:connect(NHEvent.enteredWorld, updateReferences)
NHEventManager:connect(NHEvent.s0IntervalTick, update)
NHEventManager:connect(NHEvent.raidRoasterUpdate, updateReferences)
NHEventManager:connect(NHEvent.leaveCombat, updateReferences)