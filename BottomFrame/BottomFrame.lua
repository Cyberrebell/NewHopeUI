function BottomFrame_OnLoad()
    DEFAULT_CHAT_FRAME:AddMessage("NewHopeUI started")
    hide_blizzard_ui()
end

function hide_blizzard_ui()
    PlayerFrame:Hide()
    HidePartyFrame()
    MinimapCluster:Hide()
    MainMenuBar:Hide()
    ShapeshiftBarFrame:Hide()
    --ChatFrame1:UnregisterAllEvents()
    --ChatFrame1:Hide()
end

function HidePartyFrame()
    hooksecurefunc("ShowPartyFrame", function()
        for i = 1,4 do
            getglobal("PartyMemberFrame"..i):Hide()
        end
    end)
    local f=nil
    for num = 1, 4 do
        f = getglobal("PartyMemberFrame"..num)
        f:Hide()
        f:UnregisterAllEvents()
        getglobal("PartyMemberFrame"..num.."HealthBar"):UnregisterAllEvents()
        getglobal("PartyMemberFrame"..num.."ManaBar"):UnregisterAllEvents()
    end
end