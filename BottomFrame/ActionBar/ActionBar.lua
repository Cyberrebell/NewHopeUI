local o

local function AddActionButtons()
    for y = 0,4 do
        for x = 0,11 do
            NHActionButton:new(y * 12 + (x + 1), o):SetPoint("BOTTOMLEFT", x * 42, y * 42)
        end
    end
end

function NHActionBar_OnLoad()
    o = _G["NHActionBar"]
    AddActionButtons()
end