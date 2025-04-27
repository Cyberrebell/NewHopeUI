NHRaid = { members = {} }

function NHRaid_OnLoad(self)
    for i=1,30 do
        local raidMember = _G["NHRaid"..i]
        local yOffset = (i - 1) % 10
        raidMember:SetPoint("TOP", 0, yOffset * -21)
        table.insert(NHRaid.members, raidMember)
        raidMember:SetHealerMode(false)
    end
end

function NHRaid_OnRaidRoasterUpdate()
    NHPlayer:UpdateSpec()
    NHRaid:Update()
end

function NHRaid:Update()
    for _, raidMember in pairs(NHRaid.members) do
        raidMember:SetHealerMode(NHPlayer.isHeal)
        raidMember:Update()
    end
end