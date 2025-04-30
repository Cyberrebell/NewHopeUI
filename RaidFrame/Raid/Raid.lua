NHRaid = { members = {} }

function NHRaid_OnLoad(self)
    for i=1,30 do
        local raidMember = _G["NHRaid"..i]
        local yOffset = (i - 1) % 10
        raidMember:SetPoint("TOP", 0, yOffset * -21)
        table.insert(NHRaid.members, raidMember)
        raidMember:setHealerMode(false)
    end
end

function NHRaid_OnRaidRoasterUpdate()
    NHPlayer:updateSpec()
    NHRaid:update()
end

function NHRaid:update()
    for _, raidMember in pairs(NHRaid.members) do
        raidMember:setHealerMode(NHPlayer.isHeal)
        raidMember:update()
    end
    _G["NHPlayerTargetTarget"]:setHealerMode(NHPlayer.isHeal)
end