NHMessageHandler = {threatMessagesStarted = false}

local function threatMsgKeyToGUID(key)
    key = string.gsub(key, "\255", "\000")
    key = string.gsub(key, "\254\253", "\255")
    key = string.gsub(key, "\254\251", "\061")
    key = string.gsub(key, "\254\250", "\058")
    key = string.gsub(key, "\254\252", "\254")
    return format("0x%02X%02X%02X%02X%02X%02X%02X%02X", string.byte(key, 1, 8))
end

function NHMessageHandler:OnAddonMessageReceived(prefix, text, _, sender)
    if prefix == "TL2" then
        local subject = string.sub(text, 0, 2)
        local threatTarget
        if subject == "ST" then
            threatTarget = NHPlayerGUID
        elseif subject == "TU" then
            threatTarget = UnitGUID(sender)
        end
        if threatTarget then
            for key, val in string.gmatch(text, "([^=:]+)=(%d+),") do
                local GUID = threatMsgKeyToGUID(key)
                NHEnemyDB[GUID].threat[threatTarget] = tonumber(val)
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage("Unknown TL2 message: "..text)
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage("Unknown addon message: "..text)
    end
end

function NHMessageHandler:EnableThreatMessages()
    if not NHMessageHandler.threatMessagesStarted then
        NHMessageHandler.threatMessagesStarted = true
        SendAddonMessage("TL2", "RU", "WHISPER", "Btbserver")
        DEFAULT_CHAT_FRAME:AddMessage("threat messages started")
    end
end