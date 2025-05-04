NHActionButton = {}

function NHActionButton:new(slot, parentFrame)
    local button = CreateFrame("CheckButton", "ActionButton"..slot, parentFrame, "NHActionButton")
	button:RegisterForClicks("AnyUp")
    button:RegisterForDrag("LeftButton", "RightButton")
    button:SetScale(0.77)
    button:SetAttribute("action", slot)
    button.slot = slot
    button.count = _G[button:GetName().."Counts"]
    button.cooldown = _G[button:GetName().."Cooldowns"]
    --_G[button:GetName().."Keybind"]:SetText(slot)
    return button
end

function NHActionButton:OnDragStart(self, button)
    PickupAction(self.slot);
end

function NHActionButton:OnReceiveDrag(self)
    PlaceAction(self.slot)
end

function NHActionButton:updateState(self)
	if (IsCurrentAction(self.slot) or IsAutoRepeatAction(self.slot)) then
		self:SetChecked(1)
	else
		self:SetChecked(0)
	end
end

function NHActionButton:updateIcon(self)
    if (HasAction(self.slot)) then
        self:SetNormalTexture("")
        self:SetBackdrop({bgFile=GetActionTexture(self.slot)})
        local isUsable = IsUsableAction(self.slot)
        if isUsable then
            if IsActionInRange(self.slot) == 0 then
                self:SetBackdropColor(1, 0.1, 0.1)
            else
                self:SetBackdropColor(1, 1, 1)
            end
        else
            self:SetBackdropColor(0.4, 0.4, 0.4)
        end
    else
        self:SetNormalTexture("Interface/Buttons/UI-Quickslot")
        self:SetBackdrop({})
    end
end

function NHActionButton:updateCount(self)
    local count = nil
    if IsConsumableAction(self.slot) or IsStackableAction(self.slot) then
        count = GetActionCount(self.slot)
    end
    self.count:SetText(count)
end

function NHActionButton:updateCooldown(self)
    CooldownFrame_SetTimer(self.cooldown, GetActionCooldown(self.slot))
end

function NHActionButton:updateKeybind(self, key)
    _G[self:GetName().."Keybind"]:SetText(key)
end