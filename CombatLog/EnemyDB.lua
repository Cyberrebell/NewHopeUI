NHEnemyDB = {}

function NHEnemyDB_registerUnit(GUID, name, flags)
    if NHEnemyDB[GUID] then return end
    if bit.band(COMBATLOG_OBJECT_REACTION_HOSTILE, flags) ~= 0 then
        NHEnemyDB[GUID] = {guid = GUID, name = name, hp = {value = 1, max = 1}, heat = 0, references = {}, threat = {}, pos = {x = 0, y = 0}}
        NHEnemyDB[GUID].pos.x, NHEnemyDB[GUID].pos.y = GetPlayerMapPosition("player")
        NHEventManager:emit(NHEvent.enemyAdded, GUID)
    end
end

function NHEnemyDB_removeUnit(GUID)
    if NHEnemyDB[GUID] then
        NHEnemyDB[GUID] = nil
        NHEventManager:emit(NHEvent.enemyRemoved, GUID)
    end
end

function NHEnemyDB_get_ordered_by_hp_max_desc()
    local sorted = {}
    for _, val in pairs(NHEnemyDB) do
        table.insert(sorted, val)
    end
    table.sort(sorted, function (a, b)
        return a.hp.max > b.hp.max
    end)
    return sorted
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
    if UnitReaction(reference, "player") > 2 then return end
    if NHEnemyDB[GUID] then NHEnemyDB[GUID].hp.value = UnitHealth(reference) end
    if UnitHealth(reference) < 1 then return end
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
    NHEventManager:emit(NHEvent.enemiesUpdated)
end

function NHEnemyDB_truncate()
    NHTable_truncate(NHEnemyDB)
    NHEventManager:emit(NHEvent.enemiesUpdated)
end

local function update()
    for GUID, unit in pairs(NHEnemyDB) do
        local playerDistance = math.sqrt(math.pow(unit.pos.x - NHPlayer.pos.x, 2) + math.pow(unit.pos.y - NHPlayer.pos.y, 2), 2)
        if playerDistance > 0.05 then
            NHEnemyDB_removeUnit(GUID)
        else
            local ref = NHTable_first(NHEnemyDB[GUID].references)
            if ref and UnitExists(ref) then
                NHEnemyDB[GUID].hp.value = UnitHealth(ref)
            end
            if NHEnemyDB[GUID].hp.value < 1 then
                NHEnemyDB_removeUnit(GUID)
            end
        end
    end
end

local function handleMouseover(reference)
    NHEnemyDB_inspectUnit("mouseover")
    for _, unit in pairs(NHEnemyDB) do
        for key, ref in pairs(unit.references) do
            if ref == "mouseover" then
                table.remove(unit.references, key)
            end
        end
    end
end

NHEventManager:connect(NHEvent.s1IntervalTick, update)
NHEventManager:connect(NHEvent.unitTargetChanged, function (reference) NHEnemyDB_inspectUnit(reference.."target") end)
NHEventManager:connect(NHEvent.playerMouseoverChanged, handleMouseover)
NHEventManager:connect(NHEvent.enterCombat, function () NHEnemyDB_inspectUnit("target") end)
NHEventManager:connect(NHEvent.leaveCombat, NHEnemyDB_truncate)