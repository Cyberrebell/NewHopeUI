local function AddActionButtons(self)
    for y = 0,4 do
        for i = 0,15 do
            local slot = y * 12 + (i + 1)
            if i > 13 then --bar 10 buttons to the right
                slot = 109 + (y * 2) + i - 14
            elseif i > 11 then --bar 7 buttons to the right
                slot = 61 + (y * 2) + i - 12
            end
            NHActionButton:new(slot, self):SetPoint("BOTTOMLEFT", i * 42, y * 42)
        end
    end
    local panicButton = NHActionButton:new(71, self)
    panicButton:SetPoint("BOTTOMLEFT", 0, 162)
    panicButton:SetScale(1)
    local mechanicButton = NHActionButton:new(72, self)
    mechanicButton:SetPoint("BOTTOMLEFT", 476, 162)
    mechanicButton:SetScale(1)
end

function NHActionBar_OnLoad(self)
    AddActionButtons(self)
end