local playerHealth
local playerHealthText
local playerPower
local playerPowerText
local playerCastbar
local playerCastbarText
local playerCastbarIcon
local incomingHeal
local incomingHealText

function NHPlayer_OnLoad(self)
    playerHealth = _G["NHPlayerHealth"]
    playerHealthText = _G["NHPlayerHealthText"]
    playerPower = _G["NHPlayerPower"]
    playerPowerText = _G["NHPlayerPowerText"]
    playerCastbar = _G["NHPlayerCastbar"]
    playerCastbarText = _G["NHPlayerCastbarText"]
    playerCastbarIcon = _G["NHPlayerCastbarIcon"]
    incomingHeal = _G["NHIncomingHeal"]
    incomingHealText = _G["NHIncomingHealText"]
end

function NHPlayer_OnUpdate(self, elapsed)
    local maxHP = UnitHealthMax("player")
    playerHealth:SetMinMaxValues(0, maxHP)
    playerHealth:SetValue(UnitHealth("player"))
    playerHealthText:SetText(playerHealth:GetValue().." / "..maxHP)

    local maxPower = UnitManaMax("player")
    playerPower:SetMinMaxValues(0, maxPower)
    playerPower:SetValue(UnitMana("player"))
    playerPowerText:SetText(playerPower:GetValue().." / "..maxPower)

    local spell, _, displayName, icon, startTime, endTime = UnitCastingInfo("player")
    if spell == nil then
        spell, _, displayName, icon, startTime, endTime = UnitChannelInfo("player")
    end
    if spell then
        playerCastbar:Show()
        playerCastbar:SetMinMaxValues(startTime, endTime)
        playerCastbar:SetValue(GetTime() * 1000)
        playerCastbarIcon:SetTexture(icon)
        playerCastbarText:SetText(displayName..(" (-%.1f)"):format(endTime/1000 - GetTime()))
    else
        playerCastbar:Hide()
    end

    local inc = 200
    if inc > 0 then
        incomingHeal:Show()
        local width = math.min(inc * 150 / maxHP, 100)
        incomingHeal:SetWidth(width)
        incomingHeal:SetPoint("TOPLEFT", -width, 0)
        incomingHealText:SetText("+"..inc)
    else
        incomingHeal:Hide()
    end
end