local ESX = exports['es_extended']:getSharedObject()
local ResetStress = false

ESX.RegisterCommand('cash', 'user', function(xPlayer)
	local Player = ESX.GetPlayerFromId(source)
    local cashamount = xPlayer.getAccount('money')
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
end, false, {
	help = 'Check Cash Balance'
})


ESX.RegisterCommand('cash', 'user', function(xPlayer)
	local Player = ESX.GetPlayerFromId(source)
    local bankamount = xPlayer.getAccount('bank')
    TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankamount)
end, false, {
	help = 'Check bank Balance'
})

ESX.RegisterCommand('dev', 'admin', function(xPlayer)
	TriggerClientEvent('qb-admin:client:ToggleDevmode', xPlayer)
end, false, {
	help = 'Enable/Disable developer Mode'
})

RegisterNetEvent('hud:server:GainStress', function(amount)
    if Config.DisableStress then return end
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local Job = Player.PlayerData.job.name
    local JobType = Player.PlayerData.job.type
    local newStress
    if not Player or Config.WhitelistedJobs[JobType] or Config.WhitelistedJobs[Job] then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    Player.showNotification(_U('notify.stress_gain'), 'error', 1500)

end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    if Config.DisableStress then return end
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    Player.showNotification(_U('notify.stress_removed'))
end)


ESX.RegisterServerCallback('hud:server:getMenu', function(_, cb)
    cb(Config.Menu)
end)
