NHCombatLog = {}

function NHCombatLog:OnEvent(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, value, damageType)
    NHEnemyDB_registerUnit(sourceGUID, sourceName, sourceFlags)
    NHEnemyDB_registerUnit(destGUID, destName, destFlags)
end