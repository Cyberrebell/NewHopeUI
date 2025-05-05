local function applyBasicSettings(chatFrame)
	FCF_SetLocked(chatFrame, 0)
	chatFrame:SetHeight(246)
	chatFrame:SetWidth(630)
	chatFrame:SetPoint("BOTTOMLEFT", 24, 36)
	FCF_SetChatWindowFontSize(chatFrame, 12)
	FCF_SetLocked(chatFrame, 1)
end

local function setupChatFrames()
	FCF_ResetChatWindows()
	applyBasicSettings(ChatFrame1)

	applyBasicSettings(ChatFrame2)

	FCF_OpenNewWindow(WHISPER)
	applyBasicSettings(ChatFrame3)
	ChatFrame_RemoveMessageGroup(ChatFrame3, "SAY")
	ChatFrame_RemoveMessageGroup(ChatFrame3, "YELL")
	ChatFrame_RemoveMessageGroup(ChatFrame3, "GUILD")
	ChatFrame_RemoveMessageGroup(ChatFrame3, "PARTY")
	ChatFrame_RemoveMessageGroup(ChatFrame3, "CHANNEL")

	FCF_OpenNewWindow(LOOT)
	applyBasicSettings(ChatFrame4)
	ChatFrame_RemoveMessageGroup(ChatFrame4, "SAY")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "YELL")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "GUILD")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "WHISPER")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "PARTY")
	ChatFrame_RemoveMessageGroup(ChatFrame4, "CHANNEL")
	ChatFrame_AddMessageGroup(ChatFrame4, "LOOT")
end

local function load()
	if GetChatWindowInfo(4) ~= LOOT then
		setupChatFrames()
	end
    ChatFrame1:SetScale(0.7)
    ChatFrame2:SetScale(0.7)
    ChatFrame3:SetScale(0.7)
    ChatFrame4:SetScale(0.7)

    _G["NHLogo"]:SetAlpha(0.1)
    _G["NHLogo2"]:SetAlpha(0.1)
end

NHEventManager:connect(NHEvent.enteredWorld, load)