NHEvent = {
    enteredWorld = {},
    enemyAdded = {},
    enemyRemoved = {},
    enemiesUpdated = {}
}

NHEventManager = {}

function NHEventManager:connect(event, handler)
    table.insert(event, handler)
end

function NHEventManager:emit(event, ...)
    for _, value in ipairs(event) do
        value(...)
    end
end