NHEnemyDB = {}
NHEnemyDBEvents = {
    onEnemyAdded = {}
}

function NHEnemyDB:registerUnit(GUID, name, flags)
    if NHEnemyDB[GUID] then return end
    if bit.band(COMBATLOG_OBJECT_REACTION_HOSTILE, flags) ~= 0 then
        NHEnemyDB[GUID] = {name = name}
        for index, value in ipairs(NHEnemyDBEvents.onEnemyAdded) do
            value(GUID)
        end
    end
end