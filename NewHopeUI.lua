local s1_delta_interval = 0.3
local s1_delta = 0
local s2_delta_interval = 1.0
local s2_delta = 0

function NewHopeUI_OnUpdate(frame, elapsed)
    NHEventManager:emit(NHEvent.s0IntervalTick)
    s1_delta = s1_delta + elapsed
    s2_delta = s2_delta + elapsed
    if s1_delta > s1_delta_interval then
        NHEventManager:emit(NHEvent.s1IntervalTick)
        s1_delta = s1_delta - s1_delta_interval
    end
    if s2_delta > s2_delta_interval then
        NHEventManager:emit(NHEvent.s2IntervalTick)
        s2_delta = s2_delta - s2_delta_interval
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