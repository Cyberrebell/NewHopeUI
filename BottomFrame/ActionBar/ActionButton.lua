NHActionButton = {}

function NHActionButton:new(slot, parentFrame)
    local button = CreateFrame("CheckButton", "ActionButton"..slot, parentFrame, "NHActionButton")
	button:RegisterForClicks("AnyUp")
    button:RegisterForDrag("LeftButton", "RightButton")
    button:SetScale(0.77)
    button:SetAttribute("action", slot)
    button.slot = slot
    return button
end

function NHActionButton:OnUpdate(self, elapsed)
    NHActionButton:UpdateIcon(self)
    NHActionButton:UpdateState(self)
end

function NHActionButton:OnDragStart(self, button)
    PickupAction(self.slot);
end

function NHActionButton:OnReceiveDrag(self)
    PlaceAction(self.slot)
end

function NHActionButton:PostClick(self, button, down)
    NHActionButton:UpdateState(self)
end

function NHActionButton:UpdateState(self)
	if (IsCurrentAction(self.slot) or IsAutoRepeatAction(self.slot)) then
		self:SetChecked(1)
	else
		self:SetChecked(0)
	end
end

function NHActionButton:UpdateIcon(self)
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