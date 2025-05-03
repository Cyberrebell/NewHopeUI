NHActionButton = {}

function NHActionButton:new(slot, parentFrame)
    local button = CreateFrame("CheckButton", "ActionButton"..slot, parentFrame, "NHActionButton")
	button:RegisterForClicks("AnyUp")
    button:RegisterForDrag("LeftButton", "RightButton")
    button:SetScale(0.77)
    button:SetAttribute("action", slot)
    button.slot = slot
    button.count = _G[button:GetName().."Count"]
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
        if IsActionInRange(self.slot) == 0 then
            self:SetBackdropColor(1, 0, 0)
        else
            self:SetBackdropColor(1, 1, 1)
        end
    else
        self:SetNormalTexture("Interface/Buttons/UI-Quickslot")
        self:SetBackdrop({})
    end
end

function NHActionButton:updateCount(self)
    local count = GetActionCount(self.slot)
    if (count == 0) then
        count = nil
    end
    self.count:SetText(count)
end

function NHActionButton:updateKeybind(self, key)
    _G[self:GetName().."Keybind"]:SetText(key)
end