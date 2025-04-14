NHEnemyDB = {}
NHEnemyDBEvents = {
    onEnemyAdded = {}
}

local function sort_by_max_hp()
    table.sort(NHEnemyDB, function (a, b)
        return a.hp.max > b.hp.max
    end)
end

function NHEnemyDB_registerUnit(GUID, name, flags)
    if NHEnemyDB[GUID] then return end
    if bit.band(COMBATLOG_OBJECT_REACTION_HOSTILE, flags) ~= 0 then
        NHEnemyDB[GUID] = {guid = GUID, name = name, hp = {value = 1, max = 1}}
        sort_by_max_hp()
        for index, value in ipairs(NHEnemyDBEvents.onEnemyAdded) do
            value(GUID) -- emit onEnemyAdded Event for all listeners
        end
    end
end