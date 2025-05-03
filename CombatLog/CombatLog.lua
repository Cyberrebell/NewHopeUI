NHCombatLog = {}
NHIsInfight = false
NHPlayerGUID = nil

function NHCombatLog:OnCombatLog(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, value, damageType)
    NHEnemyDB_registerUnit(sourceGUID, sourceName, sourceFlags)
    NHEnemyDB_registerUnit(destGUID, destName, destFlags)
end

local function enterCombat()
    NHIsInfight = true
    NHPlayerGUID = UnitGUID("player")
end

local function leaveCombat()
    NHIsInfight = false
end

NHEventManager:connect(NHEvent.enterCombat, enterCombat)
NHEventManager:connect(NHEvent.leaveCombat, leaveCombat)