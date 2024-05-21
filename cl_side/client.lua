----------------------------------------------------------------------------------------------------------------------------------------
-- Client.lua ---- ZonaShield  ---  Criado Por GoatDev
----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
goat = Tunnel.getInterface("ZonaShield")
Config = {}

----------------------------------------------------------------------------------------------------------------------------------------
--PlayerInfo
----------------------------------------------------------------------------------------------------------------------------------------
local firstspawn = true
CreateThread(function()
	while true do
		local goatdev = 2000
		for k,id in ipairs(GetActivePlayers()) do
			local player = PlayerId()
			local ped = PlayerPedId()
			local playerid = GetPlayerPed(player)
			local playerpedid = GetPlayerByEntityID(playerid)
			if player ~= ped and playerpedid ~= nil and NetworkIsPlayerActive(playerpedid) then
				playerpedid = GetPlayerServerId(playerpedid)
			else
				playerpedid = -1 
			end
			if GetEntityCoords(ped) then
				TriggerServerEvent('loaduserdata', playerpedid)
			end
			if GetEntityCoords(ped) and firstspawn then
				print("^6Player Loaded...")
				firstspawn = false
			end
		end
		Wait(goatdev)
	end
end)

function GetPlayerByEntityID(id)
	for i=0,300 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end

----------------------------------------------------------------------------------------------------------------------------------------
--Wall
----------------------------------------------------------------------------------------------------------------------------------------

local wall = false
local admin = false
local players = {}
local pname = {}
local pname2 = {}
local job = {}
RegisterCommand("wall",function()
    if not admin then
		return
	end

	if admin then
		wall = not wall
	end		

    if wall then
		drawNotification("~g~WALL ATIVADO.")
		goat.reportwallLog("WALL ATIVADO")
		print("^2WALL ATIVADO!")
		PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0)
	else
		drawNotification("~r~WALL DESATIVADO.")
		goat.reportunwallLog()
		print("^1WALL DESATIVADO!")
	end
end)
local weaponsHash = {
	[tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Animal',
   [tostring(GetHashKey('WEAPON_COUGAR'))] = 'Cougar',
   [tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
   [tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistol',
   [tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
   [tostring(GetHashKey('WEAPON_ASSAULTRIFLE_MK2'))] = 'Assault Rifke Mk2',
   [tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
   [tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
   [tostring(GetHashKey('WEAPON_AUTOSHOTGUN'))] = 'Automatic Shotgun',
   [tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup Rifle',
   [tostring(GetHashKey('WEAPON_BULLPUPRIFLE_MK2'))] = 'Bullpup Rifle Mk2',
   [tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
   [tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
   [tostring(GetHashKey('WEAPON_CARBINERIFLE_MK2'))] = 'Carbine Rifle Mk2',
   [tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG',
   [tostring(GetHashKey('WEAPON_COMBATMG_MK2'))] = 'Combat MG Mk2',
   [tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Combat PDW',
   [tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistol',
   [tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'Compact Rifle',
   [tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
   [tostring(GetHashKey('WEAPON_DOUBLEACTION'))] = 'Double Action Revolver',
   [tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare gun',
   [tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Gusenberg',
   [tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistol',
   [tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
   [tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
   [tostring(GetHashKey('WEAPON_HEAVYSNIPER_MK2'))] = 'Heavy Sniper',
   [tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Machine Pistol',
   [tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistol',
   [tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
   [tostring(GetHashKey('WEAPON_MARKSMANRIFLE_MK2'))] = 'Marksman Rifle Mk2',
   [tostring(GetHashKey('WEAPON_MG'))] = 'MG',
   [tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
   [tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
   [tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
   [tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
   [tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistol',
   [tostring(GetHashKey('WEAPON_PISTOL_MK2'))] = 'Pistol Mk2',
   [tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50',
   [tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
   [tostring(GetHashKey('WEAPON_PUMPSHOTGUN_MK2'))] = 'Pump Shotgun Mk2',
   [tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
   [tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Revolver',
   [tostring(GetHashKey('WEAPON_REVOLVER_MK2'))] = 'Revolver Mk2',
   [tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawnoff Shotgun',
   [tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
   [tostring(GetHashKey('WEAPON_SMG_MK2'))] = 'SMG Mk2',
   [tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
   [tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'SNS Pistol',
   [tostring(GetHashKey('WEAPON_SNSPISTOL_MK2'))] = 'SNS Pistol Mk2',
   [tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Special Carbine',
   [tostring(GetHashKey('WEAPON_SPECIALCARBINE_MK2'))] = 'Special Carbine Mk2',
   [tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger',
   [tostring(GetHashKey('WEAPON_STUNGUN'))] = 'Stungun',
   [tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'Vintage Pistol',
   [tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Vehicle Lasers',
   [tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
   [tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',
   [tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flaregun',
   [tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
   [tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Petrol Can',
   [tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Helicopter Crash',
   [tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Vehicle',
   [tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Ranover by Vehicle',
   [tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Vehicle Space Rocket',
   [tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tank',
   [tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
   [tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Air Defence Gun',
   [tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Launcher',
   [tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosion',
   [tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework',
   [tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
   [tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
   [tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
   [tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
   [tostring(GetHashKey('WEAPON_PIPEBOMB'))] = 'Pipe bomb',
   [tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Proximity Mine',
   [tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
   [tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
   [tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
   [tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
   [tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
   [tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Smoke Grenade',
   [tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Battleaxe',
   [tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Bottle',
   [tostring(GetHashKey('WEAPON_KNIFE'))] = 'Knife',
   [tostring(GetHashKey('WEAPON_MACHETE'))] = 'Machete',
   [tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Switch Blade',
   [tostring(GetHashKey('OBJECT'))] = 'Object',
   [tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Vehicle Rotors',
   [tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
   [tostring(GetHashKey('WEAPON_BAT'))] = 'Bat',
   [tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Crowbar',
   [tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Flashlight',
   [tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golfclub',
   [tostring(GetHashKey('WEAPON_HAMMER'))] = 'Hammer',
   [tostring(GetHashKey('WEAPON_HATCHET'))] = 'Hatchet',
   [tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Water Cannon',
   [tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Knuckle',
   [tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Night Stick',
   [tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Pool Cue',
   [tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
   [tostring(GetHashKey('WEAPON_UNARMED'))] = '',
   [tostring(GetHashKey('WEAPON_WRENCH'))] = 'Wrench',
   [tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowned',
   [tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowned in Vehicle',
   [tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
   [tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Bleed',
   [tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Electric Fence',
   [tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Exhaustion',
   [tostring(GetHashKey('WEAPON_FALL'))] = 'Falling'
}
Citizen.CreateThread(function()
	while true do
		local goatdev = 2000
		if wall then
			for k, id in ipairs(GetActivePlayers()) do
				if ((NetworkIsPlayerActive( id )) and GetPlayerPed(id) ~= PlayerPedId()) then
					local x1, y1, z1 = table.unpack( GetEntityCoords( PlayerPedId(), true ) )
					local x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
					local distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))	
					local x,y,z = table.unpack(GetPedBoneCoords(GetPlayerPed(id), 0, 0.0, 0.0, -0.9))
					local px,py,pz = table.unpack(GetGameplayCamCoord())
					if admin and (PlayerPedId() ~= GetPlayerPed(id)) then
						if GetPlayerPed(id) ~= -1 and players[id] ~= nil then
							local name = GetPlayerName(id)
							if name == nil or name == "" or name == -1 then
								name = "STEAM OFF"
							end
							local name2 = ""..pname[id]..""
							if name2 == nil or name2 == "" or name2 == -1 then
								name2 = name
							end
							local name3 = ""..pname2[id]..""
							if name3 == nil or name3 == "" or name3 == -1 then
								name3 = name
							end
							local health = (GetEntityHealth(GetPlayerPed(id)) - 100)
							if health == 1 then
								health = 0
							end
							local vidaPorcento = health / 3
							vidaPorcento = math.floor(vidaPorcento)
							if vidaPorcento == 0 then
								vidaPorcento = "~h~~r~Morto~w~"
							end
							if health / 3 >= 75 then
								vidaPorcento = "~b~"..vidaPorcento..""
							elseif health / 3 >= 50 then
								vidaPorcento = "~y~"..vidaPorcento..""
							elseif health / 3 >= 25 then
								vidaPorcento = "~o~"..vidaPorcento..""
							elseif health / 3 >= 1 then
								vidaPorcento = "~r~"..vidaPorcento..""
							end
							local arma = GetSelectedPedWeapon(GetPlayerPed(id))
							if arma == 0 then
								arma = "Arma Desconhecida"
							else
								arma = weaponsHash[tostring(arma)]
							end
							if GetDistanceBetweenCoords(x, y, z, px, py, pz, true) <= Config.ac.walldistance then
								goatdev = 1
								DrawText3D(x2, y2, z2+1.4,"~w~( ~b~"..distance.." m~w~ )\n( ~b~"..players[id].."~w~ ) "..pname[id].." "..pname2[id].."~w~ (~b~ "..vidaPorcento.." ~w~)")
								DrawText3D(x2, y2, z2-1.4,"~b~"..arma.."\n"..job[id].."")
								DrawLine(x1, y1, z1, x2, y2, z2, 255, 255, 255, 255)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(goatdev)
	end
end)

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.4, 0.4)
        SetTextColour(r, g, b, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function drawNotification(string)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(string)
	DrawNotification(true, false)
end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
        local goatdev = 10000
	    for _, id in ipairs(GetActivePlayers()) do
			local pid = goat.getId(GetPlayerServerId(id))
			if players[id] ~= pid or not players[id] then
				players[id] = pid
			end
		end
		Citizen.Wait(goatdev)
	end
end)

Citizen.CreateThread(function()
	while true do
        local goatdev = 10000
	    for _, id in ipairs(GetActivePlayers()) do
			local pname = goat.getname2(GetPlayerServerId(id))
			if pname2[id] ~= pname or not pname2[id] then
				pname2[id] = pname
			end
		end
		Citizen.Wait(goatdev)
	end
end)

Citizen.CreateThread(function()
	while true do
        local goatdev = 10000
	    for _, id in ipairs(GetActivePlayers()) do
			local pname2 = goat.getname(GetPlayerServerId(id))
			if pname[id] ~= pname2 or not pname[id] then
				pname[id] = pname2
			end
		end
		Citizen.Wait(goatdev)
	end
end)

Citizen.CreateThread(function()
	while true do
        local goatdev = 10000
	    for _, id in ipairs(GetActivePlayers()) do
			local job2 = goat.getjob(GetPlayerServerId(id))
			if job[id] ~= job2 or not job[id] then
				job[id] = job2
			end
		end
		Citizen.Wait(goatdev)
	end
end)

Citizen.CreateThread(function()
	while true do
        local goatdev = 10000
	    for _, id in ipairs(GetActivePlayers()) do
			local job2 = goat.getjob(GetPlayerServerId(id))
			if job[id] ~= job2 or not job[id] then
				job[id] = job2
			end
		end
		Citizen.Wait(goatdev)
	end
end)

Citizen.CreateThread(function()
	while true do
        local goatdev = 10000
		admin = goat.getPermissao() 
        Citizen.Wait(goatdev)
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
--AntiCheat
----------------------------------------------------------------------------------------------------------------------------------------
local resources
local loaded = false

--AntiCheat
CreateThread(function()
	local ped = PlayerPedId()
	Wait(25000)
	print("^6ZonaShield Loaded...")
	loaded = true
	while true do
		Wait(1000)
		if Config.deteccoes.aimassist == true then
			SetPlayerTargetingMode(0) --Anti AimAssist
		end
		if Config.deteccoes.godmode == true then
			if GetPlayerInvincible(ped) then
				SetPlayerInvincible(ped, false)
				goat.logplayer("Godmode (It can be by a script)\nType: 1") --Log Godmode
			end
			local health = GetEntityHealth(ped)
			Wait(10)
			SetEntityHealth(ped,  health - 1)
			Wait(100)
			if GetEntityHealth(ped) > Config.ac.maxhealth then
				goat.banplayer("GodMode\nType: 2") --Ban Godmode Type: 2
			end
			Wait(100)
			local val, bulletproof, fireproof , explosionproof , collisionproof , meleeproof, steamproof, p7, drownProof = GetEntityProofs(ped)
			if bulletproof == 1 or collisionproof == 1 or meleeproof == 1 or steamproof == 1 or drownProof == 1 then
				goat.banplayer("GodMode\nType: 3") --Ban Godmode Type: 3
			end
		end
		if Config.deteccoes.infinitestamina == true then
			if GetEntitySpeed(ped) > 7 and not IsPedInAnyVehicle(ped, true) and not IsPedFalling(ped) and not IsPedInParachuteFreeFall(ped) and not IsPedJumpingOutOfVehicle(ped) and not IsPedRagdoll(ped) then
				local staminalevel = GetPlayerSprintStaminaRemaining(ped)
				if tonumber(staminalevel) == tonumber(0.0) then
					goat.banplayer("InfiniteStamina") --Ban InfiniteStamina
				end
			end
		end
		if Config.deteccoes.antiragdoll == true then
			if not CanPedRagdoll(ped) and not IsPedInAnyVehicle(ped, true) and not IsEntityDead(ped) and not IsPedJumpingOutOfVehicle(ped) then
				goat.logplayer("AntiRagdoll (Maybe the player is creating the carachter)") --Log AntiRagdoll
			end
		end
		if Config.deteccoes.antiradar == true then
			if not IsPedInAnyVehicle(ped, true) then
				if not IsRadarHidden() then
					goat.banplayer("DisplayRadar") --Ban DisplayRadar
				end
			end
			Wait(300)
		end
		if Config.deteccoes.explosiveweapon == true then
			local weapondamage = GetWeaponDamageType(GetSelectedPedWeapon(ped))
			if weapondamage == 4 or weapondamage == 5 or weapondamage == 6 or weapondamage == 13 then
				goat.banplayer("ExplosiveWeapon") --Ban ExplosiveWeapon
			end
			Wait(300)
		end
		if Config.deteccoes.outofsession == true then
			if NetworkIsSessionStarted() then
				goat.logplayerp("Out Of Session") --Ban ExplosiveWeapon
			end
			Wait(300)
		end
		if Config.deteccoes.noclip == true then
			local heightaboveground = GetEntityHeightAboveGround(ped)
			if heightaboveground > 25 and not IsPedInAnyVehicle(ped, false) and not IsPedInParachuteFreeFall(ped) and not IsPedFalling(ped)then
				goat.logplayer("Noclip Or Fly") --Log Noclip Or Fly
			end
			Wait(300)
		end
		if Config.deteccoes.spectate == true then
			if NetworkIsInSpectatorMode() then
				goat.banplayer("Spectate") --Ban Spectate
			end
			Wait(300)
		end
		if Config.deteccoes.speed == true then
			if not IsPedInAnyVehicle(ped, true) and GetEntitySpeed(ped) > 10 and not IsPedFalling(ped) and not IsPedInParachuteFreeFall(ped) and not IsPedJumpingOutOfVehicle(ped) and not IsPedRagdoll(ped) then
				goat.banplayer("Speed") --Ban Speed
			end
			Wait(300)
		end
		if Config.deteccoes.blacklist == true then
			for _,weapon in ipairs(Config.ac.blacklistweapon) do
				local weapon1 = HasPedGotWeapon(ped, GetHashKey(weapon), false)
				if weapon1 then
					RemoveAllPedWeapons(ped, true)
					goat.logplayer("Blacklisted Weapon\n"..weapon1.."") --Log Blacklisted Weapon
				end
				Wait(1)
			end
			Wait(300)
		end
		if Config.deteccoes.termalvision == true then
			if GetUsingseethrough() then
				goat.banplayer("Termal Vision") --Ban Termal Vision
			end
			Wait(300)
		end
		if Config.deteccoes.nightvision == true then
			if GetUsingnightvision() then
				goat.banplayer("Night Vision") --Ban Night Vision
			end
			Wait(300)
		end
		if Config.deteccoes.licenseclear == true then
			if ForceSocialClubUpdate == nil then
				goat.banplayer("License Clear (Maybe AntiBan?)") --Ban LicenseClear
			end
			if ShutdownAndLaunchSinglePlayerGame == nil then
				goat.banplayer("License Clear (Maybe AntiBan?)") --Ban LicenseClear
			end
			if ActivateRockstarEditor == nil then
				goat.banplayer("License Clear (Maybe AntiBan?)") --Ban LicenseClear
			end
			Wait(300)
		end
		if Config.deteccoes.freecam == true then
			if not IsPlayerSwitchInProgress() then
				local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()) - GetFinalRenderedCamCoord())
				if (x > 50) or (y > 50) or (z > 50) or (x < -50) or (y < -50) or (z < -50) then
					goat.logplayer("FreeCam") --Log FreeCam
				end
			end
			Wait(300)
		end
		if Config.deteccoes.inject == true then
			if IsPlayerCamControlDisabled() ~= false then
				goat.banplayer("Inject Menyoo") --Ban Inject (Menyoo)
			end
			Wait(300)
		end
		if Config.deteccoes.aimassist == true then
			local aimassiststatus = GetLocalPlayerAimState()
			if aimassiststatus ~= 3 then
				goat.banplayer("Aim Assist") -- Ban Aim Assist
			end
			Wait(300)
		end
	end
end)

    Citizen.CreateThread(function()
		if Config.deteccoes.tp == true then
        while true do
            Citizen.Wait(1000)
			if loaded then
            local ped = PlayerPedId()
            local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
            local still = IsPedStill(ped)
            local vel = GetEntitySpeed(ped)
            local ped = PlayerPedId()
            local veh = IsPedInAnyVehicle(ped, true)
            local speed = GetEntitySpeed(ped)
            local para = GetPedParachuteState(ped)
            local flyveh = IsPedInFlyingVehicle(ped)
            local rag = IsPedRagdoll(ped)
            local fall = IsPedFalling(ped)
            local parafall = IsPedInParachuteFreeFall(ped)
            Wait(1000)
            local more = speed - 8.0
            local rounds = tonumber(string.format("%.2f", speed))
            local roundm = tonumber(string.format("%.2f", more))
            newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
            newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
            if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 1 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
                goat.logplayer("Teleport\nType: 1")
            end
			local playercoords = GetEntityCoords(GetPlayerPed(-1))
            local died = false
            if(playercoords.x > 0 or playercoords.x < 0) then
                newplayercoords = GetEntityCoords(GetPlayerPed(-1))
                if(died) then
                    playercoords = newplayercoords
                    died = false
                else
                    if(not IsPedInAnyVehicle(GetPlayerPed(-1), 0) and not IsPedOnVehicle(GetPlayerPed(-1)) and not IsPlayerRidingTrain(PlayerId())) then
                        --print(GetDistanceBetweenCoords(playercoords.x, playercoords.y, playercoords.z, newplayercoords.x, newplayercoords.y, newplayercoords.z, 0))
                        if(GetDistanceBetweenCoords(playercoords.x, playercoords.y, playercoords.z, newplayercoords.x, newplayercoords.y, newplayercoords.z, 0) > 0.5) then
                            goat.logplayer("Teleport\nType: 2")
                        end
                    end
                    playercoords = newplayercoords
                end
            end
			end
        end
    end
end)

	CreateThread(function()
		Wait(120000);
		if Config.deteccoes.inject == true then
		while true do
			Wait(500);
			RegisterNetEvent('esx:getSharedObject')
			AddEventHandler('esx:getSharedObject', function()
				goat.banplayer("Injection\nType: 1")
			end)
			local blacklistedCommands = Config.BlacklistedCommands or {}
			local registeredCommands = GetRegisteredCommands()

			for _, command in ipairs(registeredCommands) do
				for _, blacklistedCommand in pairs(blacklistedCommands) do
					if (string.lower(command.name) == string.lower(blacklistedCommand) or
						string.lower(command.name) == string.lower('+' .. blacklistedCommand) or
						string.lower(command.name) == string.lower('_' .. blacklistedCommand) or
						string.lower(command.name) == string.lower('-' .. blacklistedCommand) or
						string.lower(command.name) == string.lower('/' .. blacklistedCommand)) then
						goat.banplayer("Injection\nType: 2")
					end
				end
			end
		end
	end
end)

CreateThread(function()
	while Config.deteccoes.infiniteammo == true do
		Wait(0)
		if loaded then
		local ped = PlayerPedId()
		local weaponselected = GetSelectedPedWeapon(ped)
		local weaponammo = GetAmmoInPedWeapon(ped, weaponselected)
		if weaponammo > Config.ac.AmmoLimit then
			goat.banplayer("Max Ammo Limit\nAmmo Amount: "..weaponammo.."\nWeapon: "..weaponselected.."\nType: 1")
		end
		local aaa,ammo = GetAmmoInClip(ped, weaponselected)
		if IsAimCamActive() then
			if IsPedShooting(ped) then
				if ammo == GetMaxAmmoInClip(ped, weaponselected) then
					goat.banplayer("Infinite Ammo\nWeapon: "..weaponselected.."\nType: 2")
				end
				Wait(1000)
				local aa,ammo2 = GetAmmoInClip(ped, weaponselected)
				local weaponammo2 = GetAmmoInPedWeapon(ped, weaponselected)
				if ammo > 1 then
					if ammo == ammo2 then
						goat.logplayer("Infinite Ammo\nAmmo1 = "..ammo.." , Ammo2 = "..ammo2.."\nWeapon: "..weaponselected.."\nType: 3")
					end
				end
				if weaponammo == weaponammo2 then
					goat.logplayer("Infinite Ammo\nAmmo1 = "..weaponammo.." , Ammo2 = "..weaponammo2.."\nWeapon: "..weaponselected.."\nType: 4")
				end
			end
		end
		end
	end
end)

CreateThread(function()
	while Config.deteccoes.aimbot == true do
		Wait(0)
		if loaded then
		local lastcoordsx = nil
		local lastcoordsy = nil
		if IsAimCamActive() then
			local _isaiming, _entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
			if _isaiming and _entity then
				if IsEntityAPed(_entity) and not IsEntityDead(_entity) and not IsPedStill(_entity) and not IsPedStopped(_entity) and not IsPedInAnyVehicle(_entity, false) then
					local _entitycoords = GetEntityCoords(_entity)
					local retval, screenx, screeny = GetScreenCoordFromWorldCoord(_entitycoords.x, _entitycoords.y, _entitycoords.z)
					if screenx == lastcoordsx or screeny == lastcoordsy then
						goat.banplayer("Aimbot")
					end
					lastcoordsx = screenx
					lastcoordsy = screeny
				end
			end
		end
		end
	end
end)

CreateThread(function()
	while Config.deteccoes.noclip == true do
		Wait(0)
		if loaded then
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) then
			local pos = GetEntityCoords(ped)
			Wait(3000)
			local newped = PlayerPedId()
			local newpos = GetEntityCoords(newped)
			local distance = #(vector3(pos) - vector3(newpos))
			if distance > 30 and not IsEntityDead(ped) and not IsPedInParachuteFreeFall(ped) and ped == newped and not IsPedFalling(ped) then
				goat.logplayer("Noclip") --Log Noclip
			end
		end
		end
	end
end)

CreateThread(function()
	while Config.deteccoes.blips == true do
		local pid = PlayerId()
		local activeplayers = GetActivePlayers()
		for i = 1, #activeplayers do
			if i ~= pid then
				if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
					goat.logplayer("Blips") --Log Blips
				end
			end
			Wait(1)
		end
		Wait(6191)
	end
end)
local mecanico = false
CreateThread(function()
	while true do
		Wait(0)
		if loaded then
		local ped = PlayerPedId()
		local sleep = true
		if Config.deteccoes.vehiclemodifier == true then
			if not mecanico then
				if IsPedInAnyVehicle(ped, false) then
					sleep = false
					local vehiclein = GetVehiclePedIsIn(ped, 0)
					SetVehicleTyresCanBurst(vehiclein, true)
					if DoesVehicleHaveWeapons(vehiclein) then
						DisableVehicleWeapon(true, GetVehiclePedIsUsing(ped), ped)
					end
					if GetPlayerVehicleDamageModifier(PlayerId()) > 1.0 then
						goat.banplayer("Vehicle Modifier\nType: 1")
					end
					if GetVehicleCheatPowerIncrease(vehiclein) > 1.0 then
						goat.banplayer("Vehicle Modifier\nType: 2")
					end
					if not GetVehicleTyresCanBurst(vehiclein) then
						goat.banplayer("Vehicle Modifier\nType: 3")
					end
					if GetVehicleTopSpeedModifier(vehiclein) > 1.0 then
						goat.banplayer("Vehicle Modifier\nType: 4")
					end
					if GetPlayerVehicleDefenseModifier(vehiclein) > 1.0 then
						goat.banplayer("Vehicle Modifier\nType: 5")
					end
					local _color, _color2, _color3 = GetVehicleCustomPrimaryColour(vehiclein)
					local _neoncolor, _neoncolor2, _neoncolor3 = GetVehicleNeonLightsColour(vehiclein)
					local plate1 = GetVehicleNumberPlateText(vehiclein)
					Wait(1000)
					local plate2 = GetVehicleNumberPlateText(vehiclein)
					local _newcolor, _newcolor2, _newcolor3 = GetVehicleCustomPrimaryColour(vehiclein)
					local _newneoncolor, _newneoncolor2, _newneoncolor3 = GetVehicleNeonLightsColour(vehiclein)
					if IsPedInAnyVehicle(ped, false) then -- Checks again just in case..
						if tonumber(_color) ~= tonumber(_newcolor) then
							goat.banplayer("Vehicle Modifier\nType: 6")
						elseif tonumber(_color2) ~= tonumber(_newcolor2) then
							goat.banplayer("Vehicle Modifier\nType: 7")
						elseif tonumber(_color3) ~= tonumber(_newcolor3) then
							goat.banplayer("Vehicle Modifier\nType: 8")
						end
						if tonumber(_neoncolor) ~= tonumber(_newneoncolor) then
							goat.banplayer("Vehicle Modifier\nType: 9")
						elseif tonumber(_neoncolor2) ~= tonumber(_newneoncolor2) then
							goat.banplayer("Vehicle Modifier\nType: 10")
						elseif tonumber(_neoncolor3) ~= tonumber(_newneoncolor3) then
							goat.banplayer("Vehicle Modifier\nType: 11")
						end
						if plate1 ~= plate2 then
							goat.banplayer("Vehicle Modifier\nType: 12")
						end
					end
					SetEntityInvincible(vehiclein, false)
				end
			end
		end
		if sleep then Wait(1200) end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
        local goatdev = 10000
		mecanico = goat.getPermissaomecanico() 
        Citizen.Wait(goatdev)
	end
end)

RegisterNetEvent("DeleteCars")
AddEventHandler('DeleteCars', function(vehicle)
        local vehicle = NetworkGetEntityFromNetworkId(vehicle)
        if DoesEntityExist(vehicle) then
        NetworkRequestControlOfEntity(vehicle)
        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
            Wait(100)
            timeout = timeout - 100
        end
        SetEntityAsMissionEntity(vehicle, true, true)
        local timeout = 2000
        while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
            Wait(100)
            timeout = timeout - 100
        end
        Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle) )
    end
end)


if Anticheat.DeleteExplodedCars then 
	for theveh in EnumerateVehicles() do 
		if GetEntityHealth(theveh) == 0 then
			SetEntityAsMissionEntity(theveh, false, false)
			DeleteEntity(theveh)
		end
	end
end

local a1 = {{"a", "CreateMenu", "Cience"}, {"LynxEvo", "CreateMenu", "Lynx Evo"}, {"Lynx8", "CreateMenu", "Lynx8"},
            {"e", "CreateMenu", "Lynx Revo (Cracked)"}, {"Crusader", "CreateMenu", "Crusader"},
            {"Plane", "CreateMenu", "Desudo, 6666, Luminous"}, {"gaybuild", "CreateMenu", "Lynx (Stolen)"},
            {"FendinX", "CreateMenu", "FendinX"}, {"FlexSkazaMenu", "CreateMenu", "FlexSkaza"},
            {"FrostedMenu", "CreateMenu", "Frosted"}, {"FantaMenuEvo", "CreateMenu", "FantaEvo"},
            {"LR", "CreateMenu", "Lynx Revolution"}, {"xseira", "CreateMenu", "xseira"},
            {"KoGuSzEk", "CreateMenu", "KoGuSzEk"}, {"LeakerMenu", "CreateMenu", "Leaker"},
            {"lynxunknowncheats", "CreateMenu", "Lynx UC Release"}, {"LynxSeven", "CreateMenu", "Lynx 7"},
            {"werfvtghiouuiowrfetwerfio", "CreateMenu", "Rena"}, {"ariesMenu", "CreateMenu", "Aries"},
            {"HamMafia", "CreateMenu", "HamMafia"}, {"b00mek", "CreateMenu", "b00mek"},
            {"redMENU", "CreateMenu", "redMENU"}, {"xnsadifnias", "CreateMenu", "Ruby"},
            {"moneymany", "CreateMenu", "xAries"}, {"Cience", "CreateMenu", "Cience"},
            {"TiagoMenu", "CreateMenu", "Tiago"}, {"SwagUI", "CreateMenu", "Lux Swag"}, {"LuxUI", "CreateMenu", "Lux"},
            {"Dopamine", "CreateMenu", "Dopamine"}, {"Outcasts666", "CreateMenu", "Dopamine"},
            {"ATG", "CreateMenu", "ATG Menu"}, {"Absolute", "CreateMenu", "Absolute"}}
Citizen.CreateThread(function()
    Wait(5000)
    while true do
        for a2, a3 in pairs(a1) do
            local a4 = a3[1]
            local a5 = a3[2]
            local a6 = a3[3]
            local a7 = load("return type(" .. a4 .. ")")
            if a7() == "table" then
                local a8 = load("return type(" .. a4 .. "." .. a5 .. ")")
                if a8() == "function" then
                    Anticheat:ReportCheat(29, "Cheating Type MNUIEX: " .. a4, true, true, true)
                    return
                end
            end
            Wait(10)
        end
        Wait(10000)
    end
end)

CreateObjectNoOffset_ = CreateObjectNoOffset;
CreateObjectNoOffset = function(a9, aa, ab, ac, ad, ae, af)
    if a9 == nil then
        return
    end
    Anticheat:ReportCheat(51, "Tried to spawn objects: " .. a9, true, true, true)
end;
AddExplosion_ = AddExplosion;
AddExplosion = function(aa, ab, ac, ag, ah, ai, aj, ak)
    if aa == nil then
        return
    end
    Anticheat:ReportCheat(52, "Tried to spawn explosion: " .. ag, false, true, true)
end;
AddOwnedExplosion_ = AddOwnedExplosion;
AddOwnedExplosion = function(k, aa, ab, ac, ag, ah, ai, aj, ak)
    if k == nil then
        return
    end
    Anticheat:ReportCheat(53, "Tried to spawn explosion to ped: " .. k .. " | " .. ag, false, true, true)
end;
LoadResourceFile_ = LoadResourceFile;
LoadResourceFile = function(al, am)
    if al ~= GetCurrentResourceName() then
        Anticheat:ReportCheat(53, "Load resource: " .. al, false, true, true)
    else
        LoadResourceFile_(al, am)
    end
end
RemoveAllPedWeapons_ = RemoveAllPedWeapons;
RemoveAllPedWeapons = function(k, an)
    if k ~= GetPlayerPed(-1) then
        Anticheat:ReportCheat(54, "RemoveAllWeapons", false, true, true)
    end
end
AddEventHandler('onClientResourceStart', function(al)
    local rlength = string.len(al)
    if rlength >= Anticheat.MaxResourceNameLength then -- Adjust this if you get banned while entering the server
        Anticheat:ReportCheat(49, "Count Resource high: " .. rlength, true, true, true)
    end
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(49, "Start resource: " .. al, true, true, true)
end)
AddEventHandler('onClientResourceStop', function(al)
    if al == "ClippyGeek" then
        while true do
        end
    end
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(55, "Stop resource: " .. al, true, true, true)
end)
AddEventHandler('onClientResourceStop2', function(al)
    if al == "ClippyGeek" then
        while true do
        end
    end
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(55, "Stop resource2: " .. al, true, true, true)
end)
AddEventHandler('onResourceStart', function(al)
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(56, "Start resource: " .. al, true, true, true)
end)
AddEventHandler('onResourceStop', function(al)
    if al == "ClippyGeek" then
        while true do
        end
    end
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(57, "Start resource: " .. al, true, true, true)
end)