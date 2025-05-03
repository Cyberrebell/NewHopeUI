local function update()
    local GUID
    local heat = {}
    for i = 1,25 do
        GUID = UnitGUID("raid"..i.."target")
        if GUID then
            if heat[GUID] then
                heat[GUID] = heat[GUID] + 1
            else
                heat[GUID] = 1
            end
        end
    end
    for GUID, unit in pairs(NHEnemyDB) do
        if heat[GUID] then
            unit.heat = heat[GUID]
        else
            unit.heat = 0
        end
    end
end

NHEventManager:connect(NHEvent.unitTargetChanged, update)