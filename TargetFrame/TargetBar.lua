NHTargetBar = {}

local function NHEnemyDB_threat_player_and_max(GUID)
    if not NHEnemyDB[GUID] then return 1, 1 end
    local playerThreat = 0
    if NHEnemyDB[GUID].threat[NHPlayerGUID] then
        playerThreat = NHEnemyDB[GUID].threat[NHPlayerGUID]
    end

    local maxThreat = 0
    for _, val in pairs(NHEnemyDB[GUID].threat) do
        if val > maxThreat then
            maxThreat = val
        end
    end
    return playerThreat, maxThreat
end

function NHTargetBar:PostClick(frame, button, down)
    frame:SetChecked(0)
end

function NHTargetBar:OnUpdate(frame, elapsed)
    if frame.target then
        local hp = frame.target.hp.value
        local maxHP = frame.target.hp.max
        local name = frame.target.name
        if frame.smallmode then
            name = string.sub(name, 0, 22).."\n"
        else
            name = name.." "
        end
        frame.text:SetText(name..hp.."/"..maxHP..(" (%.1f"):format(100 * hp / maxHP).."%)")
        frame:SetMinMaxValues(0, maxHP)
        frame:SetValue(hp)
        frame:SetStatusBarColor(1, math.min(0.8, frame.target.heat / 8), 0)
        local playerThreat, maxThreat = NHEnemyDB_threat_player_and_max(frame.target.guid)
        frame.threat:SetMinMaxValues(0, maxThreat)
        frame.threat:SetValue(playerThreat)
    end
end

function NHTargetBar:SetSmallMode(frame, value)
    frame.smallmode = value
    if frame.smallmode then
        local font, _, flags = frame.text:GetFont()
        frame.text:SetFont(font, 8, flags)
    end
end

function NHTargetBar_OnLoad(frame)
    frame.text = _G[frame:GetName().."Text"]
    frame.button = _G[frame:GetName().."Button"]
    frame.threat = _G[frame:GetName().."ThreatBar"]
    function frame:SetWidthRec(width)
        frame:SetWidth(width)
        frame.button:SetWidth(width)
        frame.threat:SetWidth(width)
    end
    function frame:SetUnit(unit)
        frame.target = unit
        if frame.target then
            frame.button.targetName = frame.target.name
            if not NHIsInfight then
                frame.button:SetAttribute("unit", NHTable_first(unit.references))
                frame:Show()
            end
        elseif not NHIsInfight then
            frame:Hide()
        end
    end
end