NHTargetBar = {}

function NHTargetBar:PostClick(self, button, down)
    SendChatMessage(self.targetName, "SAY")
    self:SetChecked(0)
end

function NHTargetBar:OnUpdate(self, elapsed)
    if self.targetName then
        local hp = UnitHealth(self.targetName)
        local maxHP = UnitHealthMax(self.targetName)
        self.text:SetText(self.targetName.." "..hp.." / "..maxHP..(" (%.1f"):format(100 * hp / maxHP).."%)")
        self:SetMinMaxValues(0, maxHP)
        self:SetValue(hp)
    else
        self:Hide()
    end
end

function NHTargetBar_OnLoad(self)
    self.text = _G[self:GetName().."Text"]
    function self:SetUnit(unit)
        local button = _G[self:GetName().."Button"]
        button.targetName = GetUnitName(unit)
        self.targetName = button.targetName
        self:Show()
    end
end