NHActionButtons = {}

local function AddActionButtons()
    local frame = _G["NHActionBar"]
    for y = 0,4 do
        for i = 0,15 do
            local slot = y * 12 + (i + 1)
            if i > 13 then --bar 10 buttons to the right
                slot = 109 + (y * 2) + i - 14
            elseif i > 11 then --bar 7 buttons to the right
                slot = 61 + (y * 2) + i - 12
            elseif y == 1 then --use bar 4 in place of bar 2
                slot = 3 * 12 + (i + 1)
            elseif y == 3 then --use bar 2 in place of bar 4
                slot = 1 * 12 + (i + 1)
            end
            NHActionButtons[slot] = NHActionButton:new(slot, frame)
            NHActionButtons[slot]:SetPoint("BOTTOMLEFT", i * 42, y * 42)
        end
    end
    local panicButton = NHActionButton:new(71, frame)
    panicButton:SetPoint("BOTTOMLEFT", 0, 162)
    panicButton:SetScale(1)
    local mechanicButton = NHActionButton:new(72, frame)
    mechanicButton:SetPoint("BOTTOMLEFT", 476, 162)
    mechanicButton:SetScale(1)
end

function NHKeybinds()
    for i=1,10 do
        local key = i % 10
        SetBinding("CTRL-"..key, "MULTIACTIONBAR4BUTTON"..i)
        SetBinding("SHIFT-"..key, "MULTIACTIONBAR3BUTTON"..i)
    end
end

function NHUpdateKeyBindings()
    NHKeybinds()
    for i=1,GetNumBindings() do
        local action, key1 = GetBinding(i)
        local row1Match = action:match("^ACTIONBUTTON(%d+)")
        local row2Match = action:match("^MULTIACTIONBAR4BUTTON(%d+)")
        local row3Match = action:match("^MULTIACTIONBAR3BUTTON(%d+)")
        if row1Match and key1 then
            NHActionButton:updateKeybind(NHActionButtons[tonumber(row1Match)], GetBindingText(key1, "KEY_", 1))
        elseif row2Match and key1 then
            NHActionButton:updateKeybind(NHActionButtons[tonumber(row2Match) + 36], GetBindingText(key1, "KEY_", 1))
        elseif row3Match and key1 then
            NHActionButton:updateKeybind(NHActionButtons[tonumber(row3Match) + 24], GetBindingText(key1, "KEY_", 1))
        end
    end
end

NHEventManager:connect(NHEvent.enteredWorld, AddActionButtons)
NHEventManager:connect(NHEvent.enteredWorld, NHUpdateKeyBindings)