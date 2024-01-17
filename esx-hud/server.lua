local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterCommand('cash', 'user', function(xPlayer)
    local src = tonumber(xPlayer.playerId) 
	local Player = ESX.GetPlayerFromId(src)
    local cashamount = Player.getAccount('money').money
    print(json.encode(cashamount))
    TriggerClientEvent('hud:client:ShowAccounts', src, 'cash', cashamount)
end, false, {
	help = 'Check Cash Balance'
})


ESX.RegisterCommand('bank', 'user', function(xPlayer)
	local Player = ESX.GetPlayerFromId(xPlayer.playerId)
    local bankamount = Player.getAccount('bank').money
    TriggerClientEvent('hud:client:ShowAccounts', xPlayer.playerId, 'bank', bankamount)
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
