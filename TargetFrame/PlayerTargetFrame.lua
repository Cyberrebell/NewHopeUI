NHPlayerTargetFrame = { frame = nil }

function NHPlayerTargetFrame_load(frame)
    NHPlayerTargetFrame.frame = frame
    frame.target = nil
    frame.text = _G[frame:GetName().."Text"]
    frame.lvl = _G[frame:GetName().."Lvl"]
    frame.health = _G[frame:GetName().."Health"]
    frame.healthPercent = _G[frame:GetName().."HealthPercent"]
    frame.mana = _G[frame:GetName().."ManaBar"]
    frame.threatbox = _G["NHPlayerTargetThreatBox"]
    frame.castbar = _G[frame:GetName().."Castbar"]
    frame.castbar.icon = _G[frame:GetName().."CastbarIcon"]
    frame.castbar.text = _G[frame:GetName().."CastbarText"]
    frame.targettarget = _G["NHPlayerTargetTarget"]
    frame.targettarget.reference = "targettarget"
    frame.targettarget.forceVisible = true
    frame.targettarget.button:SetAttribute("unit", frame.targettarget.reference)
    frame.targettarget:SetPoint("TOP", 95, 24)
end

local function setVisible(visible)
    frame = NHPlayerTargetFrame.frame
    if visible then
        frame:SetBackdropColor(0, 0, 0, 1)
        frame.threatbox:Show()
        frame.targettarget:setVisible(UnitExists("targettarget"))
    else
        frame:SetBackdropColor(0, 0, 0, 0)
        frame.mana:SetValue(0)
        frame:SetMinMaxValues(0, 1)
        frame:SetValue(0)
        frame.text:SetText("")
        frame.lvl:SetText("")
        frame.health:SetText("")
        frame.healthPercent:SetText("")
        frame.threatbox:Hide()
        frame.targettarget:setVisible(false)
        frame.castbar:Hide()
    end
end

local function updateTarget(reference)
    if reference == "player" then
        frame = NHPlayerTargetFrame.frame
        frame.text:SetText(UnitName("target"))
        frame.lvl:SetText("lvl "..UnitLevel("target"))
        frame.threatbox:updateTarget()
    end
end

local function updateCastbar()
    if NHPlayerTargetFrame.frame.target then
        local spell, _, displayName, icon, startTime, endTime = UnitCastingInfo("target")
        if spell == nil then
            spell, _, displayName, icon, startTime, endTime = UnitChannelInfo("target")
        end
        local castbar = NHPlayerTargetFrame.frame.castbar
        if spell then
            castbar:Show()
            castbar:SetMinMaxValues(startTime, endTime)
            castbar:SetValue(GetTime() * 1000)
            castbar.icon:SetTexture(icon)
            castbar.text:SetText(displayName..(" (-%.1f)"):format(endTime/1000 - GetTime()))
        else
            castbar:Hide()
        end
    end
end

local function updateValues()
    NHPlayerTargetFrame.frame.target = UnitExists("target")
    if NHPlayerTargetFrame.frame.target then
        local maxHp = UnitHealthMax("target")
        local hp = UnitHealth("target")
        frame = NHPlayerTargetFrame.frame
        frame:SetMinMaxValues(0, maxHp)
        frame:SetValue(hp)
        frame.healthPercent:SetText(math.ceil(100 * hp / maxHp).."%")
        frame.health:SetText(hp.." / "..maxHp)
        frame.mana:SetMinMaxValues(0, UnitManaMax("target"))
        frame.mana:SetValue(UnitMana("target"))
        frame.threatbox:update()
        frame.targettarget:update()
        frame.targettarget.text:SetText(UnitName(frame.targettarget.reference))
        setVisible(true)
    else
        setVisible(false)
    end
end

NHEventManager:connect(NHEvent.s0IntervalTick, updateCastbar)
NHEventManager:connect(NHEvent.s1IntervalTick, updateValues)
NHEventManager:connect(NHEvent.unitTargetChanged, updateTarget)