ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('flakey:paypal:balance')
AddEventHandler('flakey:paypal:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('flakey:paypal:info', _source, balance)
end)

RegisterServerEvent('flakey:paypal:transfer')
AddEventHandler('flakey:paypal:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(to)
	local amount = amountt
	local balance = 0
	if(xTarget == nil or xTarget == -1) then
		TriggerClientEvent('notification', _source, "Recipient not found", 2)
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = xTarget.getAccount('bank').money
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('notification', _source, "You cannot paypal yourself 4head", 2)
		else
			if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
				TriggerClientEvent('notification', _source, "You don't have enough money for this paypal transfer", 2)
			else
				xPlayer.removeAccountMoney('bank', tonumber(amount))
				xTarget.addAccountMoney('bank', tonumber(amount))
				TriggerClientEvent("paypaling:addBalance", xTarget.source, amount)
				TriggerClientEvent('notification', _source, "You successfully transfer $" .. amount, 3)
				TriggerClientEvent('notification', to, "You have just received $" .. amount .. ' via paypal', 3)
			end
		end
	end
end)



