NHPlayerTargetFrame = { frame = nil }

function NHPlayerTargetFrame_OnLoad(frame)
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

function NHPlayerTargetFrame_OnUpdate(frame, elapsed)
    if frame.target then
        local spell, _, displayName, icon, startTime, endTime = UnitCastingInfo("target")
        if spell == nil then
            spell, _, displayName, icon, startTime, endTime = UnitChannelInfo("target")
        end
        if spell then
            frame.castbar:Show()
            frame.castbar:SetMinMaxValues(startTime, endTime)
            frame.castbar:SetValue(GetTime() * 1000)
            frame.castbar.icon:SetTexture(icon)
            frame.castbar.text:SetText(displayName..(" (-%.1f)"):format(endTime/1000 - GetTime()))
        else
            frame.castbar:Hide()
        end
    end
end

function NHPlayerTargetFrame:updateTarget(reference)
    NHPlayerTargetFrame.frame.text:SetText(UnitName("target"))
    NHPlayerTargetFrame.frame.lvl:SetText("lvl "..UnitLevel("target"))
    NHPlayerTargetFrame.frame.threatbox:updateTarget()
end

function NHPlayerTargetFrame:update()
    NHPlayerTargetFrame.frame.target = UnitExists("target")
    if NHPlayerTargetFrame.frame.target then
        local maxHp = UnitHealthMax("target")
        local hp = UnitHealth("target")
        NHPlayerTargetFrame.frame:SetMinMaxValues(0, maxHp)
        NHPlayerTargetFrame.frame:SetValue(hp)
        NHPlayerTargetFrame.frame.healthPercent:SetText(math.ceil(100 * hp / maxHp).."%")
        NHPlayerTargetFrame.frame.health:SetText(hp.." / "..maxHp)
        NHPlayerTargetFrame.frame.mana:SetMinMaxValues(0, UnitManaMax("target"))
        NHPlayerTargetFrame.frame.mana:SetValue(UnitMana("target"))
        NHPlayerTargetFrame.frame.threatbox:update()
        NHPlayerTargetFrame.frame.targettarget:update()
        NHPlayerTargetFrame:setVisible(true)
    else
        NHPlayerTargetFrame:setVisible(false)
    end
end

function NHPlayerTargetFrame:setVisible(visible)
    if visible then
        NHPlayerTargetFrame.frame:SetBackdropColor(0, 0, 0, 1)
        NHPlayerTargetFrame.frame.threatbox:Show()
        NHPlayerTargetFrame.frame.targettarget:setVisible(UnitExists("targettarget"))
    else
        NHPlayerTargetFrame.frame:SetBackdropColor(0, 0, 0, 0)
        NHPlayerTargetFrame.frame.mana:SetValue(0)
        NHPlayerTargetFrame.frame:SetMinMaxValues(0, 1)
        NHPlayerTargetFrame.frame:SetValue(0)
        NHPlayerTargetFrame.frame.text:SetText("")
        NHPlayerTargetFrame.frame.lvl:SetText("")
        NHPlayerTargetFrame.frame.health:SetText("")
        NHPlayerTargetFrame.frame.healthPercent:SetText("")
        NHPlayerTargetFrame.frame.threatbox:Hide()
        NHPlayerTargetFrame.frame.targettarget:setVisible(false)
        NHPlayerTargetFrame.frame.castbar:Hide()
    end
end