function NHRaid_OnLoad(self)
    for i=1,30 do
        local raidMember = _G["NHRaid"..i]
        local yOffset = (i - 1) % 10
        raidMember:SetPoint("TOP", 0, yOffset * -21)
    end
end

function NHRaid_OnRaidRoasterUpdate()
    for i=1,30 do
        _G["NHRaid"..i]:Update()
    end
end