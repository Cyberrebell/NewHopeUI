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