local ESX = exports['es_extended']:getSharedObject()
local ResetStress = false

ESX.RegisterCommand('cash', 'user', function(xPlayer)
	local Player = ESX.GetPlayerFromId(xPlayer)
    local cashamount = xPlayer.getAccount('money')
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
end, false, {
	help = 'Check Cash Balance'
})


ESX.RegisterCommand('bank', 'user', function(xPlayer)
	local Player = ESX.GetPlayerFromId(xPlayer)
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


ESX.RegisterServerCallback('hud:server:getMenu', function(_, cb)
    cb(Config.Menu)
end)
