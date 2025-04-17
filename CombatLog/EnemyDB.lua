NHEnemyDB = {}
NHEnemyDBEvents = {
    onEnemyAdded = {},
    onEnemyRemoved = {},
    onEnemiesUpdated = {}
}

function NHEnemyDB_get_sorted_hp_max()
    local sorted = {}
    for _, val in pairs(NHEnemyDB) do
        table.insert(sorted, val)
    end
    table.sort(sorted, function (a, b)
        return a.hp.max > b.hp.max
    end)
    return sorted
end

function NHEnemyDB_registerUnit(GUID, name, flags)
    if NHEnemyDB[GUID] then return end
    if bit.band(COMBATLOG_OBJECT_REACTION_HOSTILE, flags) ~= 0 then
        NHEnemyDB[GUID] = {guid = GUID, name = name, hp = {value = 1, max = 1}, heat = 0, references = {}, threat = {}}
        for _, value in ipairs(NHEnemyDBEvents.onEnemyAdded) do
            value(GUID) -- emit onEnemyAdded Event for all listeners
        end
    end
end

function NHEnemyDB_removeUnit(GUID)
    if NHEnemyDB[GUID] then
        table.remove(NHEnemyDB, GUID)
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
    if not UnitIsEnemy("player", GUID) then return end
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