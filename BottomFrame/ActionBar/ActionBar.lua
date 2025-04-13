local o

local function AddActionButtons()
    for y = 0,4 do
        for i = 0,15 do
            local slot = y * 12 + (i + 1)
            if i > 13 then
                slot = 109 + (y * 2) + i - 14
            elseif i > 11 then
                slot = 61 + (y * 2) + i - 12
            end
            NHActionButton:new(slot, o):SetPoint("BOTTOMLEFT", i * 42, y * 42)
        end
    end
    local panicButton = NHActionButton:new(71, o)
    panicButton:SetPoint("BOTTOMLEFT", 0, 162)
    panicButton:SetScale(1)
    local mechanicButton = NHActionButton:new(72, o)
    mechanicButton:SetPoint("BOTTOMLEFT", 476, 162)
    mechanicButton:SetScale(1)
end

function NHActionBar_OnLoad()
    o = _G["NHActionBar"]
    AddActionButtons()
end