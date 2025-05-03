function NHChat_onEnteredWorld()
	if GetChatWindowInfo(4) ~= LOOT then
	    NHChat_setupChatFrames()
	end
    ChatFrame1:SetScale(0.7)
    ChatFrame2:SetScale(0.7)
    ChatFrame3:SetScale(0.7)
    ChatFrame4:SetScale(0.7)

    _G["NHLogo"]:SetAlpha(0.1)
    _G["NHLogo2"]:SetAlpha(0.1)
end

function NHChat_setupChatFrames()
    FCF_ResetChatWindows()
	NHChat_ApplyBasicSettings(ChatFrame1)

	NHChat_ApplyBasicSettings(ChatFrame2)

	FCF_OpenNewWindow(WHISPER)
	NHChat_ApplyBasicSettings(ChatFrame3)
	ChatFrame_RemoveMessageGroup(ChatFrame3, "SAY")
	ChatFrame_RemoveMessageGroup(ChatFrame3, "YELL")
	ChatFrame_RemoveMessageGroup(ChatFrame3, "GUILD")
	ChatFrame_RemoveMessageGroup(ChatFrame3, "PARTY")
	ChatFrame_RemoveMessageGroup(ChatFrame3, "CHANNEL")

	FCF_OpenNewWindow(LOOT)
	NHChat_ApplyBasicSettings(ChatFrame4)
	ChatFrame_RemoveMessageGroup(ChatFrame4, "SAY")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "YELL")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "GUILD")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "WHISPER")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "PARTY")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "CHANNEL")
	ChatFrame_AddMessageGroup(ChatFrame4, "LOOT")
end

function NHChat_ApplyBasicSettings(chatFrame)
    FCF_SetLocked(chatFrame, 1)
    chatFrame:SetHeight(246)
    chatFrame:SetWidth(630)
    chatFrame:SetPoint("BOTTOMLEFT", 24, 36)
    FCF_SetChatWindowFontSize(chatFrame, 12)
end

NHEventManager:connect(NHEvent.enteredWorld, NHChat_onEnteredWorld)