NHMessageHandler = {threatMessagesStarted = false}

local function threatMsgKeyToGUID(key)
    key = string.gsub(key, "\255", "\000")
    key = string.gsub(key, "\254\253", "\255")
    key = string.gsub(key, "\254\251", "\061")
    key = string.gsub(key, "\254\250", "\058")
    key = string.gsub(key, "\254\252", "\254")
    return format("0x%02X%02X%02X%02X%02X%02X%02X%02X", string.byte(key, 1, 8))
end

local function byteToHex(byte)
    local hex = tonumber(byte, 16)
    local replacements = {[0] = "\255", [58] = "\254\250", [61] = "\254\251", [254] = "\254\252", [255] = "\254\253"}
    return replacements[hex] or string.char(hex)
end

local function threatGUIDToMsgKey(GUID)
    local guidVal = string.match(GUID, "0x(.*)")
    return string.gsub(guidVal, "(%x%x)", byteToHex)
end

local function sendThreatMessage(reference, targetGUID)
    local GUID = UnitGUID(reference)
    local threat = NHEnemyDB[targetGUID].threat[GUID]
    local msg = "TU"..threatGUIDToMsgKey(GUID)..":"..format("%s=%d,", threatGUIDToMsgKey(targetGUID), threat)
    SendAddonMessage("TL2", msg, "RAID")
end

function NHMessageHandler:OnAddonMessageReceived(prefix, text, _, sender)
    if prefix == "TL2" then
        local subject = string.sub(text, 0, 2)
        local threatTarget
        if subject == "ST" then
            threatTarget = NHPlayerGUID
        elseif subject == "TU" then --THREAT_UPDATE
            threatTarget = UnitGUID(sender)
        end
        if threatTarget then
            for key, val in string.gmatch(text, "([^=:]+)=(%d+),") do
                local GUID = threatMsgKeyToGUID(key)
                if NHEnemyDB[GUID] then
                    NHEnemyDB[GUID].threat[threatTarget] = tonumber(val)
                    if subject == "ST" then
                        sendThreatMessage("Player", GUID)
                    end
                end
            end
        else
--             DEFAULT_CHAT_FRAME:AddMessage("Unknown TL2 message: "..text)
        end
    else
--         DEFAULT_CHAT_FRAME:AddMessage("Unknown addon message: "..text)
    end
end

function NHMessageHandler:EnableThreatMessages()
    if not NHMessageHandler.threatMessagesStarted then
        NHMessageHandler.threatMessagesStarted = true
        SendAddonMessage("TL2", "RU", "WHISPER", "Btbserver")
        DEFAULT_CHAT_FRAME:AddMessage("threat messages started")
    end
end