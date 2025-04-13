function NHTargetFrame_OnLoad(self)
    for i = 0,3 do
        local bar = _G["NHBoss"..(i + 1)]
        bar:SetPoint("TOP", 0, i * -16)
    end
    _G["NHBoss1"]:SetUnit("player")
end