NHCombatLog = {}

function NHCombatLog:OnCombatLog(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, value, damageType)
    NHEnemyDB_registerUnit(sourceGUID, sourceName, sourceFlags)
    NHEnemyDB_registerUnit(destGUID, destName, destFlags)
end

function NHCombatLog:OnPlayerMouseoverChanged()
    NHEnemyDB_inspectUnit("mouseover")
end

function NHCombatLog:OnUnitTargetChanged(reference)
    NHEnemyDB_inspectUnit(reference.."target")
    FocusHeat_update()
end