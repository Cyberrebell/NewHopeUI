local delta_interval = 0.3
local delta = 0

function NewHopeUI_OnUpdate(frame, elapsed)
    delta = delta + elapsed
    if delta > delta_interval then
        NHPlayer.pos.x, NHPlayer.pos.y = GetPlayerMapPosition("player")
        NHEnemyDB_update()

        NHPlayerTargetFrame:update()

        for _, bar in pairs(NHTargetFrame.targetBars) do
            NHTargetBar:update(bar)
        end

        NHRaid:update()

        delta = delta - delta_interval
    end
end

function NewHopeUI_OnLoad()
    --DEFAULT_CHAT_FRAME:AddMessage("NewHopeUI started")
    HideBlizzardUI()
end

function HideBlizzardUI()
    PlayerFrame:Hide()
    HidePartyFrame()
    MinimapCluster:Hide()
    MainMenuBar:Hide()
    ShapeshiftBarFrame:Hide()
    BuffFrame:Hide()
    CastingBarFrame:UnregisterAllEvents()
    CastingBarFrame:Hide()
    TargetFrame:UnregisterAllEvents()
    TargetFrameHealthBar:UnregisterAllEvents()
    TargetFrameManaBar:UnregisterAllEvents()
    TargetFrame:Hide()
    TargetofTargetFrame:UnregisterAllEvents()
    TargetofTargetFrame:Hide()
    --ChatFrame1:UnregisterAllEvents()
    --ChatFrame1:Hide()
end

function HidePartyFrame()
    hooksecurefunc("ShowPartyFrame", function()
        for i = 1,4 do
            getglobal("PartyMemberFrame"..i):Hide()
        end
    end)
    for i = 1,4 do
        local frame = getglobal("PartyMemberFrame"..i)
        frame:Hide()
        frame:UnregisterAllEvents()
        getglobal("PartyMemberFrame"..i.."HealthBar"):UnregisterAllEvents()
        getglobal("PartyMemberFrame"..i.."ManaBar"):UnregisterAllEvents()
    end
end

function NHTable_erase(tab, value)
    for key, val in pairs(tab) do
        if val == value then
            table.remove(tab, key);
            return true
        end
    end
    return false
end

function NHTable_first(tab)
    for _, val in pairs(tab) do
        return val
    end
    return nil
end

function NHTable_count(tab)
    local n = 0
    for _ in pairs(tab) do
        n = n + 1
    end
    return n
end

function NHTable_truncate(tab)
    for key, _ in pairs(tab) do
        tab[key] = nil
    end
end

function NHTable_print(tab)
    local result = "{"
    for key, val in pairs(tab) do
        result = result..key..":"..val..","
    end
    DEFAULT_CHAT_FRAME:AddMessage(result.."}")
end