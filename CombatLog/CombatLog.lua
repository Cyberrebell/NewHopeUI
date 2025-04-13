NHCombatLog = {}

function NHCombatLog:OnEvent(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, value, damageType)
    NHEnemyDB:registerUnit(sourceGUID, sourceName, sourceFlags)
    NHEnemyDB:registerUnit(destGUID, destName, destFlags)
end