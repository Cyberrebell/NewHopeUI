NHEnemyDB = {}
NHEnemyDBEvents = {
    onEnemyAdded = {},
    onEnemyRemoved = {},
    onEnemiesUpdated = {}
}

function NHEnemyDB_registerUnit(GUID, name, flags)
    if NHEnemyDB[GUID] then return end
    if bit.band(COMBATLOG_OBJECT_REACTION_HOSTILE, flags) ~= 0 then
        NHEnemyDB[GUID] = {guid = GUID, name = name, hp = {value = 1, max = 1}, heat = 0, references = {}, threat = {}, pos = {}}
        NHEnemyDB[GUID].pos.x, NHEnemyDB[GUID].pos.y = GetPlayerMapPosition("player")
        for _, value in ipairs(NHEnemyDBEvents.onEnemyAdded) do
            value(GUID) -- emit onEnemyAdded Event for all listeners
        end
    end
end

function NHEnemyDB_removeUnit(GUID)
    if NHEnemyDB[GUID] then
        NHEnemyDB[GUID] = nil
        for _, value in ipairs(NHEnemyDBEvents.onEnemyRemoved) do
            value(GUID) -- emit onEnemyRemoved Event for all listeners
        end
    end
end

local function NHEnemyDB_cleanupOutdatedReferences()
    for GUID, unit in pairs(NHEnemyDB) do
        for key, reference in pairs(unit.references) do
            if UnitGUID(reference) ~= GUID then
                table.remove(unit.references, key)
            end
        end
    end
end

local function inspectUnit(reference)
    local GUID = UnitGUID(reference)
    if not GUID then return end
    if UnitReaction(reference, "player") > 2 or UnitHealth(reference) < 1 then return end
    if not NHEnemyDB[GUID] then NHEnemyDB_registerUnit(GUID, UnitName(reference), COMBATLOG_OBJECT_REACTION_HOSTILE) end
    NHEnemyDB[GUID].hp.value = UnitHealth(reference)
    NHEnemyDB[GUID].hp.max = UnitHealthMax(reference)

    if not tContains(NHEnemyDB[GUID].references, reference) then
        table.insert(NHEnemyDB[GUID].references, reference)
    end

    local referenceTarget = reference.."target"
    if string.len(referenceTarget) < 22 then
        inspectUnit(referenceTarget)
    end
end

function NHEnemyDB_inspectUnit(reference)
    inspectUnit(reference)
    NHEnemyDB_cleanupOutdatedReferences()
    for _, value in ipairs(NHEnemyDBEvents.onEnemiesUpdated) do
        value() -- emit onEnemiesUpdated Event for all listeners
    end
end

function NHEnemyDB_truncate()
    NHTable_truncate(NHEnemyDB)
    for _, value in ipairs(NHEnemyDBEvents.onEnemiesUpdated) do
        value() -- emit onEnemiesUpdated Event for all listeners
    end
end

function NHEnemyDB_update()
    for GUID, unit in pairs(NHEnemyDB) do
        local playerDistance = math.sqrt(math.pow(unit.pos.x - NHPlayerPos.x, 2) + math.pow(unit.pos.y - NHPlayerPos.y, 2), 2)
        if playerDistance > 0.05 then
            NHEnemyDB_removeUnit(GUID)
        else
            local ref = NHTable_first(NHEnemyDB[GUID].references)
            if ref and UnitExists(ref) then
                NHEnemyDB[GUID].hp.value = UnitHealth(ref)
            end
            if NHEnemyDB[GUID].hp.value < 1 then
                DEFAULT_CHAT_FRAME:AddMessage("Removing "..NHEnemyDB[GUID].name.." because of death.")
                NHEnemyDB_removeUnit(GUID)
            end
        end
    end
end