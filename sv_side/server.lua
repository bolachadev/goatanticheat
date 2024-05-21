----------------------------------------------------------------------------------------------------------------------------------------
-- Server.lua ---- ZonaShield ---  Criado Por GoatDev
----------------------------------------------------------------------------------------------------------------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPclient = Tunnel.getInterface("vRP")
goat = {}
Tunnel.bindInterface("ZonaShield",goat)
Proxy.addInterface("ZonaShield",goat)
vRP = Proxy.getInterface("vRP")
Config = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET USER ID AND STEAMHEX
-----------------------------------------------------------------------------------------------------------------------------------------	
function goat.getId(sourceplayer)
    local sourceplayer = sourceplayer
	if sourceplayer ~= nil and sourceplayer ~= 0 then
		local user_id = vRP.getUserId(sourceplayer)
		if user_id then
			return user_id
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Wall
-----------------------------------------------------------------------------------------------------------------------------------------	
function goat.getId(sourceplayer)
    local sourceplayer = sourceplayer
	if sourceplayer ~= nil and sourceplayer ~= 0 then
		local user_id = vRP.getUserId(sourceplayer)
		if user_id then
			return user_id
		end
	end
end

function goat.getname(sourceplayer)
    local sourceplayer = sourceplayer
    if sourceplayer ~= nil and sourceplayer ~= 0 then
        local user_id = vRP.getUserId(sourceplayer)
        local identity = vRP.getUserIdentity(user_id)
        if user_id then
            return identity.name
        end
    end
end

function goat.getname2(sourceplayer)
    local sourceplayer = sourceplayer
    if sourceplayer ~= nil and sourceplayer ~= 0 then
        local user_id = vRP.getUserId(sourceplayer)
        local identity = vRP.getUserIdentity(user_id)
        if user_id then
            return identity.firstname
        end
    end
end

function goat.getjob(sourceplayer)
    local sourceplayer = sourceplayer
    if sourceplayer ~= nil and sourceplayer ~= 0 then
        local user_id = vRP.getUserId(sourceplayer)
        local job = vRP.getUserGroupByType(user_id, "job")
        if user_id then
            return job
        end
    end
end

function goat.getPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,Config.ac.permissaowall) then
        return true
    else
        return false
    end
end

function goat.getPermissaomecanico()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,Config.ac.permissaotuning) then
        return true
    else
        return false
    end
end

function goat.reportwallLog()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
        local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
        PerformHttpRequest(Config.ac.logwall, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
                { 	------------------------------------------------------------
                    title = "**Um administrador ``ativou`` o /Wall**",
                    fields = {
                        { 
                            name = "**ID do Administrador:\n**",
                            value = "**"..identity.name.." "..identity.firstname.." ["..user_id.."]**"
                        },
                        {
							name = "**LOCALIZAÇÃO:**\n",
							value = "**"..x..", "..y..", "..z.."**"
                        },
                    }, 
                    footer = { 
                        text = "ZonaShield "..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                    },
                    color = 1286027
                }
            }
        }), { ['Content-Type'] = 'application/json' })
    end
end

function goat.reportunwallLog()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
        local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
        PerformHttpRequest(Config.ac.logwall, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
                { 	------------------------------------------------------------
                    title = "**Um administrador ``desativou`` o /Wall**",
                    fields = {
                        { 
                            name = "**ID do Administrador:\n**",
                            value = "**"..identity.name.." "..identity.firstname.." ["..user_id.."]**"
                        },
                        {
							name = "**LOCALIZAÇÃO:**\n",
							value = "**"..x..", "..y..", "..z.."**"
                        },
                    }, 
                    footer = { 
                        text = "ZonaShield "..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                    },
                    color = 1286027
                }
            }
        }), { ['Content-Type'] = 'application/json' })
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------	

function goat.getimmunityPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,Config.ac.permissaoadm) then
        return true
    else
        return false
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
--Webhook (WALL)
-----------------------------------------------------------------------------------------------------------------------------------------
function goat.reportwallLog(toggle)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
        local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
        PerformHttpRequest(Config.ac.logwall, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
                { 	------------------------------------------------------------
                    title = "**Um administrador ``ativou`` o /Wall**",
                    fields = {
                        { 
                            name = "**ID do Administrador:\n**",
                            value = "**"..identity.name.." "..identity.firstname.." ["..user_id.."]**"
                        },
                        {
							name = "**LOCALIZAÇÃO:**\n",
							value = "**"..x..", "..y..", "..z.."**"
                        },

                    }, 
                    footer = { 
                        text = "ZonaShield "..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                    },
                    color = 1286027
                }
            }
        }), { ['Content-Type'] = 'application/json' })
    end
end

function goat.reportunwallLog(toggle)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
        local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
        PerformHttpRequest(Config.ac.logwall, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield', avatar_url = imageurl, embeds = {
                { 	------------------------------------------------------------
                    title = "**Um administrador ``desativou`` o /Wall**",
                    fields = {
                        { 
                            name = "**ID do Administrador:\n**",
                            value = "**"..identity.name.." "..identity.firstname.." ["..user_id.."]**"
                        },
                        {
							name = "**LOCALIZAÇÃO:**\n",
							value = "**"..x..", "..y..", "..z.."**"
                        },
                    }, 
                    footer = { 
                        text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                    },
                    color = 1286027
                }
            }
        }), { ['Content-Type'] = 'application/json' })
    end
end

----------------------------------------------------------------------------------------------------------------------------------------
--AntiCheat-Data     /    Exit - Enter  Message
----------------------------------------------------------------------------------------------------------------------------------------

local playerinfo = 0
local userdata = json.decode(LoadResourceFile(GetCurrentResourceName(),"json/data.json"))
local acinfo = 0
local acdata = json.decode(LoadResourceFile(GetCurrentResourceName(),"json/acdata.json"))
RegisterNetEvent("loaduserdata")
AddEventHandler("loaduserdata",function()
    local source = source
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    local identity = vRP.getUserIdentity(user_id)
    local bankmoney = vRP.getBankMoney(user_id)
    local handmoney = vRP.getMoney(user_id)
    local inv = vRP.getInventory(parseInt(user_id))
    if userdata == nil then
        userdata = {}
    end
    Wait(0)
    if playerinfo ~= user_id then
        playerinfo = tostring(user_id)

        if userdata ~= nil then
            if userdata[playerinfo] == nil or userdata[playerinfo] ~= nil then
                userdata[playerinfo] = {}
                userdata[playerinfo].gameinfo = {}
                table.insert(userdata[playerinfo].gameinfo, {PhoneNumber = tostring(identity.phone), GameName = ""..tostring(identity.name).." "..tostring(identity.firstname).."", Age = tostring(identity.age), User_id = tostring(user_id), BankMoney = tostring(bankmoney), HandMoney = tostring(handmoney), RG = tostring(identity.registration), Multas = vRP.getUData(parseInt(user_id),"vRP:multas"),lastcds = {tostring(math.floor(x)),tostring(math.floor(y)),tostring(math.floor(z))},Inventory = inv})
            end
        end
    end
    SetTimeout(1000,function()
        playerinfo = 0
    end)
end)

----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("playerConnecting",function()
    local source = source
    local license = ExtractIdentifiers(source)
    local name = GetPlayerName(source)
    local ip = ExtractIdentifiers(source)
    local ACID = "LOADING"
    local goatid = goat.generateId(source,"DDLLDLDDLD",license.tokens)
    if acdata[acinfo] ~= nil and acdata[acinfo].AcBanned == false then
        ACID = acdata[acinfo].AcID
        print("\n^7"..name.." ^2Entrou no Servidor.")
        Wait(500)
        print("\n^4[+] loading info...\n")
        Wait(1000)
        print("^2AC-ID: ^7"..acdata[acinfo].AcID.."\n^2Hwid: ^7"..license.tokens.."\n^2Steam name: ^7"..name.."\n^2SteamId: ^7"..license.steam.."\n^2Ip: ^7"..ip.ip.."\n^2Time:^7 "..os.date("%d/%m/%Y | %H:%M:%S"))
    elseif acdata[acinfo] == nil then
        ACID = "LOADING"
        print("\n^7"..name.." ^2Entrou no Servidor.")
        Wait(500)
        print("\n^4[+] loading info...\n")
        Wait(1000)
        print("^2AC-ID: ^7LOADING\n^2Steam name: ^7"..name.."\n^2Hwid: ^7"..license.tokens.."\n^2SteamId: ^7"..license.steam.."\n^2Ip: ^7"..ip.ip.."\n^2Time:^7 "..os.date("%d/%m/%Y | %H:%M:%S"))
    elseif acdata[acinfo].AcBanned == true then
        print("\n^7"..name.." ^3Tentou entrar porém esta banido^7.")
        Wait(500)
        print("\n^4[+] loading info...\n")
        Wait(1000)
        print("^3AC-ID: ^7"..acdata[acinfo].AcID.."\n^3Hwid: ^7"..license.tokens.."\n^3Steam name: ^7"..name.."\n^3SteamId: ^7"..license.steam.."\n^3Ip: ^7"..ip.ip.."\n^3Time:^7 "..os.date("%d/%m/%Y | %H:%M:%S"))
    end
    local users = vRP.getUsers()
    local quantidade = 0
    for k,v in pairs(users) do
        quantidade = quantidade + 1
    end
    local isban = ""
    if acdata[acinfo] == nil then
        isban = "LOADING"
    elseif acdata[acinfo] ~= nil and acdata[acinfo].AcBanned == true then
        isban = "true (DID NOT ENTER)"
    elseif acdata[acinfo].AcBanned == false then
        isban = "false"
    end
    local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
    PerformHttpRequest(Config.ac.logplayer, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
            { 	------------------------------------------------------------
                title = "**PLAYER JOINED THE SERVER**",
                fields = {
                    { 
                        name = "**Steam Name:\n**",
                        value = "``"..name.."``"
                    },
                    {
                        name = "**AC-ID:**\n",
                        value = "``"..ACID.."``"
                    },
                    {
                        name = "**Hwid:**\n",
                        value = "``"..license.tokens.."``"
                    },
                    {
                        name = "**Steam Id:**\n",
                        value = "``"..license.steam.."``"
                    },
                    {
                        name = "**Ip:**\n",
                        value = "``"..ip.ip.."``"
                    },
                    {
                        name = "**Banned:**\n",
                        value = "``"..isban.."``"
                    },
                    {
                        name = "**Players Online:**\n",
                        value = "``"..quantidade.."``"
                    },
                    {                        
                        name = "**Sistema desenvolvido Por GoatDev.**\n",
                        value = "https://goatdev.net/."
                    }
                }, 
                footer = { 
                    text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                },
                color = 1286027
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler("playerConnecting",function(src,cb,deferrals)
    local source = source
    local license = ExtractIdentifiers(source)
    local name = GetPlayerName(source)
    local ip = ExtractIdentifiers(source)
    local goatid = goat.generateId(source,"DDLLDLDDLD",license.tokens)
    if acdata == nil then
        acdata = {}
    end
    Wait(0)
    if acinfo ~= license.tokens then
        acinfo = tostring(license.tokens)
        if acdata ~= nil then
            if acdata[acinfo] == nil then
                acdata[acinfo] = {}
                acdata[acinfo].AcBanned = false
            end
            local acbanned = acdata[acinfo].AcBanned
            if acdata[acinfo] == nil or acdata[acinfo] ~= nil then
                acdata[acinfo] = {}
                acdata[acinfo].AcID = goatid
                acdata[acinfo].AcBanned = acbanned
                acdata[acinfo].AcDiscord = tostring(license.discord)
                acdata[acinfo].AcXbl = tostring(license.xbl)
                acdata[acinfo].AcLive = tostring(license.live)
                acdata[acinfo].AcLicense = tostring(license.license)
                acdata[acinfo].AcSteam = tostring(license.steam)
                acdata[acinfo].steamname = tostring(name) 
                acdata[acinfo].ip = tostring(ip.ip)
                if acdata[acinfo].AcID == nil then
                    acdata[acinfo].AcID = goatid
                end
            end
        end
    end
    src = src or nil
    deferrals.defer()
    deferrals.update("Checking Data-Base")
    Wait(2000)
    if src == nil then
        deferrals.done("Error in source")
        return
    end

    Wait(100)

    local license2 = ExtractIdentifiers(source)

    if (license2.tokens == nil ) then
        deferrals.done("Error founding tokens. (Maybe the server don't have this permission, talk to the server owner.)")
        return
    end

    if (license2.steam == nil ) then
        deferrals.done("Error founding licenses")
        return
    end

    local ip2 = ExtractIdentifiers(source)

    if (ip2.ip == nil) then
        deferrals.done("Error founding ip")
        return
    end

    if acinfo ~= license.tokens then
        acinfo = tostring(license.tokens)
    end
    if acinfo == tostring(license.tokens) then
        if acdata ~= nil then
            if acdata[acinfo] ~= nil then
                if acdata[acinfo].AcBanned == true then
                    deferrals.done("Banned from ZonaShield. AC-ID: "..acdata[acinfo].AcID.."")
                    return
                end
                if acdata[acinfo].AcBanned == false then
                    deferrals.done()
                    return
                end
            end
        end
    end
    SetTimeout(1000,function()
        acinfo = 0
    end)
end)

----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("playerDropped", function(reason)
    local id = source
    local crds = GetEntityCoords(GetPlayerPed(id))
    local name = GetPlayerName(id)
    local ip = ExtractIdentifiers(id)
    local user_id = vRP.getUserId(id)
    local inv = vRP.getInventory(parseInt(user_id))
    local license = ExtractIdentifiers(id)
    if acinfo ~= license.tokens then
        acinfo = tostring(license.tokens)
        if acdata ~= nil then
            if acdata[acinfo] ~= nil then
                acdata[acinfo].AcID = tostring(acdata[acinfo].AcID)
                print("\n^7["..user_id.."] "..name.."  ^1Saiu do Servidor.\n^1Reason: ^7"..reason.."")
                Wait(500)
                print("\n^4[+] loading info...\n")
                Wait(1000)
                print("^1AC-ID: ^7"..acdata[acinfo].AcID.."\n^1Hwid: ^7"..license.tokens.."\n^1Steam name: ^7"..name.."\n^1SteamId: ^7"..license.steam.."\n^1Ip: ^7"..ip.ip.."\n^1Cds: ^7"..crds.x.." "..crds.y.." "..crds.z.."\n^1Inventory: ^7"..json.encode(inv).."\n^1Time:^7 "..os.date("%d/%m/%Y | %H:%M:%S"))
                local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                PerformHttpRequest(Config.ac.logplayer, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
                        { 	------------------------------------------------------------
                            title = "**PLAYER LEFT THE SERVER**",
                            fields = {
                                { 
                                    name = "**Reason:\n**",
                                    value = "``"..reason.."``"
                                },
                                { 
                                    name = "**Steam Name:\n**",
                                    value = "``"..name.."``"
                                },
                                { 
                                    name = "**AC-ID:\n**",
                                    value = "``"..acdata[acinfo].AcID.."``"
                                },
                                { 
                                    name = "**User_Id:\n**",
                                    value = "``"..user_id.."``"
                                },
                                {
                                    name = "**Hwid:**\n",
                                    value = "``"..license.tokens.."``"
                                },
                                {
                                    name = "**Steam Id:**\n",
                                    value = "``"..license.steam.."``"
                                },
                                {
                                    name = "**Ip:**\n",
                                    value = "``"..ip.ip.."``"
                                },
                                {
                                    name = "**Cds:**\n",
                                    value = "``"..crds.x.." "..crds.y.." "..crds.z.."``"
                                },
                                {
                                    name = "**Invetory:**\n",
                                    value = "``"..json.encode(inv).."``"
                                },
                                {                        
                                    name = "**Sistema desenvolvido Por GoatDev.**\n",
                                    value = "https://goatdev.net/ ."
                                }
                            }, 
                            footer = { 
                                text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                                icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                            },
                            color = 1286027
                        }
                    }
                }), { ['Content-Type'] = 'application/json' })
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Resource Start
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("onResourceStart", function(resourceName)
    local source = source
    local svname = GetConvar("sv_hostname")
    if resourceName == GetCurrentResourceName() then
        local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
        PerformHttpRequest(Config.ac.logresources, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
                { 	------------------------------------------------------------
                    title = "**RESOURCE STARTED**",
                    fields = {
                        { 
                            name = "**Resource Name:\n**",
                            value = "``"..resourceName.."``"
                        },
                        {                        
                            name = "**Sistema desenvolvido Por GoatDev**\n",
                            value = "https://goatdev.net/."
                        }
                    }, 
                    footer = { 
                        text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                    },
                    color = 1286027
                }
            }
        }), { ['Content-Type'] = 'application/json' })
        print("\n^4[+] ^7ZonaShield ^2Started\n\n^4[+]^6 Don't Forget to do the command 'acinstall' on console (ANTI INJECTION).\n^4[+] ^8Or if you want to remove the Anti Inject do 'acuninstall'.\n\n^4[+]^7 SERVER NAME: ^2"..svname.."\n^4[+]^7 RESOURCE NAME: ^2"..resourceName.."^4\n\n[+] ^7STARTED LOG ON YOUR DISCORD\n\n^4[+] ^7STARTED TIME: ^2"..os.date("%d/%m/%Y | %H:%M:%S"))
        print("^7")
    else 
        local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
        PerformHttpRequest(Config.ac.logresources, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
                { 	------------------------------------------------------------
                    title = "**RESOURCE STARTED**",
                    fields = {
                        { 
                            name = "**Resource Name:\n**",
                            value = "``"..resourceName.."``"
                        },
                        {                        
                            name = "**Sistema desenvolvido Por GoatDev**\n",
                            value = "https://goatdev.net/."
                        }
                    }, 
                    footer = { 
                        text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                    },
                    color = 1286027
                }
            }
        }), { ['Content-Type'] = 'application/json' })
        print("\n^4[+] ^7Resource Started\n^4[+] ^7Resource Name: ^4"..resourceName.."^4\n^4[+] ^7STARTED TIME: ^2"..os.date("%d/%m/%Y | %H:%M:%S"))
        print("^7")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AC-ID
-----------------------------------------------------------------------------------------------------------------------------------------

function goat.generateId(source,format,steamid)
    local abyte = string.byte("A")
    local source = source
	local zbyte = string.byte("0")
	local number = ""
	for i=1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
	return number
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Screenshot
-----------------------------------------------------------------------------------------------------------------------------------------

function goat.screenshot(source,reason,webhook)
    local user_id = vRP.getUserId(source)
    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(source,webhook,
        {
            encoding = "png",
            quality = 1
        },
        {
            username = "ZonaShield - Sistema De ScreenShot",
            avatar_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018",
            embeds = {
                {
                    color = 171512,
                    author = {
                        name = "✅ ScreenShot Enviada!\n\n❗ A Screenshot Poderá Ou Não Ter Erro De Renderização Devido Ao Fivem.\nPlayerID: "..user_id.."\nReason: "..reason.."\n\nData: "..os.date("%d/%m/%Y | %H:%M:%S")
                    }
                }
            }
        },
        30000,
        function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
            print("Sent screenshot successfully")
        end
    )
end

RegisterCommand("print",function(source,args,rawCmd)
    local source = source
    if vRP.hasPermission(source,Config.screenshotperm) then
        if args[1] then
            local nsource = vRP.getUserSource(parseInt(args[1]))
            goat.screenshot(nsource,"Command",Config.logscreenshot)
        end
    end
 end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Ac-Ban
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("AcBan")
AddEventHandler("AcBan",function(source, reason)
    local aclicense = ExtractIdentifiers(source)
    if acinfo ~= aclicense.tokens then
        acinfo = tostring(aclicense.tokens)
    end
    if acinfo == tostring(aclicense.tokens) then
        acdata[acinfo].AcBanned = true
        acdata[acinfo].bannedreason = {}
        table.insert(acdata[acinfo].bannedreason,{Reason = tostring(reason)})
    end
end)

function goat.banplayer(reason)
    local source = source
    local license = ExtractIdentifiers(source)
    local name = GetPlayerName(source)
    local identity = vRP.getUserIdentity(source)
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
    print("^1Player Banned\nPlayerName: ^7"..name.."\n^1Reason: ^7"..reason.."")
    TriggerEvent("AcBan", source,reason)
    local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
    PerformHttpRequest(Config.ac.logban, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
            { 	------------------------------------------------------------
                title = "**BANNED**",
                fields = {
                    { 
                        name = "**Player:\n**",
                        value = "``["..user_id.."]``"
                    },
                    { 
                        name = "**SteamName:\n**",
                        value = "``["..name.."]``"
                    },
                    { 
                        name = "**Hwid:\n**",
                        value = "``["..license.tokens.."]``"
                    },
                    { 
                        name = "**SteamId:\n**",
                        value = "``["..license.steam.."]``"
                    },
                    { 
                        name = "**Xbl:\n**",
                        value = "``["..license.xbl.."]``"
                    },
                    { 
                        name = "**Live:\n**",
                        value = "``["..license.live.."]``"
                    },
                    { 
                        name = "**License:\n**",
                        value = "``["..license.license.."]``"
                    },
                    { 
                        name = "**Ip:\n**",
                        value = "``["..license.ip.."]``"
                    },
                    { 
                        name = "**Discord:\n**",
                        value = "``["..license.discord.."]``"
                    },
                    { 
                        name = "**Reason:\n**",
                        value = "``"..reason.."``"
                    },
                    {                        
                        name = "**Sistema desenvolvido Por GoatDev**\n",
                        value = "https://goatdev.net/."
                    }
                }, 
                footer = { 
                    text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                },
                color = 1286027
            }
        }
    }), { ['Content-Type'] = 'application/json' })
    goat.screenshot(source,reason,Config.ac.logban)
    Wait(2000)
    if acinfo ~= license.tokens then
        acinfo = tostring(license.tokens)
    end
    if acinfo == tostring(license.tokens) then
        print(source,"ZonaShield\nBanido. AcId: "..acdata[acinfo].AcID.."\nReason: "..reason..".")
        vRP.kick(source,"ZonaShield\nBanido. AcId: "..acdata[acinfo].AcID.."\nReason: "..reason..".")
    else
        print(source,"ZonaShield\nBanido.\nReason: "..reason..".")
        vRP.kick(source,"ZonaShield\nBanido.\nReason: "..reason..".")
    end
    vRP.setBanned(parseInt(user_id),true)
    end
end

function goat.banplayerwsource(source,reason)
    local source = source
    local license = ExtractIdentifiers(source)
    local name = GetPlayerName(source)
    local identity = vRP.getUserIdentity(source)
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
        Wait(500)
    TriggerEvent("AcBan", source,reason)
    print("^1Player Banned\nPlayerName: ^7"..name.."\n^1Reason: ^7"..reason.."")
    local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
    PerformHttpRequest(Config.ac.logban, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
            { 	------------------------------------------------------------
                title = "**BANNED**",
                fields = {
                    { 
                        name = "**Player:\n**",
                        value = "``["..user_id.."]``"
                    },
                    { 
                        name = "**SteamName:\n**",
                        value = "``["..name.."]``"
                    },
                    { 
                        name = "**Hwid:\n**",
                        value = "``["..license.tokens.."]``"
                    },
                    { 
                        name = "**SteamId:\n**",
                        value = "``["..license.steam.."]``"
                    },
                    { 
                        name = "**Live:\n**",
                        value = "``["..license.live.."]``"
                    },
                    { 
                        name = "**License:\n**",
                        value = "``["..license.license.."]``"
                    },
                    { 
                        name = "**Ip:\n**",
                        value = "``["..license.ip.."]``"
                    },
                    { 
                        name = "**Discord:\n**",
                        value = "``["..license.discord.."]``"
                    },
                    { 
                        name = "**Reason:\n**",
                        value = "``"..reason.."``"
                    },
                    {                        
                        name = "**Sistema desenvolvido Por GoatDev**\n",
                        value = "https://goatdev.net/."
                    }
                }, 
                footer = { 
                    text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                },
                color = 1286027
            }
        }
    }), { ['Content-Type'] = 'application/json' })
    goat.screenshot(source,reason,Config.ac.logban)
    Wait(2000)
    if acinfo ~= license.tokens then
        acinfo = tostring(license.tokens)
    end
    if acinfo == tostring(license.tokens) then
        print(source,"ZonaShield\nBanido. AcId: "..acdata[acinfo].AcID.."\nReason: "..reason..".")
        vRP.kick(source,"ZonaShield\nBanido. AcId: "..acdata[acinfo].AcID.."\nReason: "..reason..".")
    else
        print(source,"ZonaShield\nBanido.\nReason: "..reason..".")
        vRP.kick(source,"ZonaShield\nBanido.\nReason: "..reason..".")
    end
    vRP.setBanned(parseInt(user_id),true)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------

function goat.logplayer(reason)
    local source = source
    local license = ExtractIdentifiers(source)
    local name = GetPlayerName(source)
    local identity = vRP.getUserIdentity(source)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
    print("^1Player Logged\nPlayerId: ^7"..user_id.."\n^1Reason: ^7"..reason.."")
    local imageurl = "https://media.discordapp.net/attachments/807063382662185001/845462171470266449/hazedev90x90.png"
    PerformHttpRequest(Config.ac.logsuspect, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
            { 	------------------------------------------------------------
                title = "**SUSPECT**",
                fields = {
                    { 
                        name = "**Player:\n**",
                        value = "``["..user_id.."]``"
                    },
                    { 
                        name = "**SteamName:\n**",
                        value = "``["..name.."]``"
                    },
                    { 
                        name = "**Hwid:\n**",
                        value = "``["..license.tokens.."]``"
                    },
                    { 
                        name = "**SteamId:\n**",
                        value = "``["..license.steam.."]``"
                    },
                    { 
                        name = "**Xbl:\n**",
                        value = "``["..license.xbl.."]``"
                    },
                    { 
                        name = "**Live:\n**",
                        value = "``["..license.live.."]``"
                    },
                    { 
                        name = "**License:\n**",
                        value = "``["..license.license.."]``"
                    },
                    { 
                        name = "**Ip:\n**",
                        value = "``["..license.ip.."]``"
                    },
                    { 
                        name = "**Discord:\n**",
                        value = "``["..license.discord.."]``"
                    },
                    { 
                        name = "**Reason:\n**",
                        value = "``"..reason.."``"
                    },
                    {                        
                        name = "**Sistema desenvolvido Por GoatDev**\n",
                        value = "https://goatdev.net/."
                    }
                }, 
                footer = { 
                    text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                },
                color = 1286027
            }
        }
    }), { ['Content-Type'] = 'application/json' })
    goat.screenshot(source,reason,Config.ac.logsuspect)
    end
end

function goat.logplayerwsource(source,reason)
    local license = ExtractIdentifiers(source)
    local name = GetPlayerName(source)
    local identity = vRP.getUserIdentity(source)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
        local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
    PerformHttpRequest(Config.ac.logsuspect, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
            { 	------------------------------------------------------------
                title = "**SUSPECT**",
                fields = {
                    { 
                        name = "**Player:\n**",
                        value = "``["..user_id.."]``"
                    },
                    { 
                        name = "**SteamName:\n**",
                        value = "``["..name.."]``"
                    },
                    { 
                        name = "**Hwid:\n**",
                        value = "``["..license.tokens.."]``"
                    },
                    { 
                        name = "**SteamId:\n**",
                        value = "``["..license.steam.."]``"
                    },
                    { 
                        name = "**Xbl:\n**",
                        value = "``["..license.xbl.."]``"
                    },
                    { 
                        name = "**Live:\n**",
                        value = "``["..license.live.."]``"
                    },
                    { 
                        name = "**License:\n**",
                        value = "``["..license.license.."]``"
                    },
                    { 
                        name = "**Ip:\n**",
                        value = "``["..license.ip.."]``"
                    },
                    { 
                        name = "**Discord:\n**",
                        value = "``["..license.discord.."]``"
                    },
                    { 
                        name = "**Reason:\n**",
                        value = "``"..reason.."``"
                    },
                    {                        
                        name = "**Sistema desenvolvido Por GoatDev**\n",
                        value = "https://goatdev.net/."
                    }
                }, 
                footer = { 
                    text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                },
                color = 1286027
            }
        }
    }), { ['Content-Type'] = 'application/json' })
    goat.screenshot(source,reason,Config.ac.logsuspect)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("AcUnBan")
AddEventHandler("AcUnBan",function(source)
    local aclicense = ExtractIdentifiers(source)
    if acinfo ~= aclicense.tokens then
        acinfo = tostring(aclicense.tokens)
    end
    if acinfo == tostring(aclicense.tokens) then
        acdata[acinfo].AcBanned = false
    end
end)

function goat.unbanplayer(reason)
    local source = source
    local license = ExtractIdentifiers(source)
    local name = GetPlayerName(source)
    local identity = vRP.getUserIdentity(source)
    local user_id = vRP.getUserId(source)
    local imageurl = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
    PerformHttpRequest(Config.ac.logunban, function(err, text, headers) end, 'POST', json.encode({username = ' ZonaShield ', avatar_url = imageurl, embeds = {
            { 	------------------------------------------------------------
                title = "**UNBANNED**",
                fields = {
                    { 
                        name = "**Player:\n**",
                        value = "``["..user_id.."]``"
                    },
                    { 
                        name = "**SteamName:\n**",
                        value = "``["..name.."]``"
                    },
                    { 
                        name = "**Hwid:\n**",
                        value = "``["..license.tokens.."]``"
                    },
                    { 
                        name = "**SteamId:\n**",
                        value = "``["..license.steam.."]``"
                    },
                    { 
                        name = "**Xbl:\n**",
                        value = "``["..license.xbl.."]``"
                    },
                    { 
                        name = "**Live:\n**",
                        value = "``["..license.live.."]``"
                    },
                    { 
                        name = "**License:\n**",
                        value = "``["..license.license.."]``"
                    },
                    { 
                        name = "**Ip:\n**",
                        value = "``["..license.ip.."]``"
                    },
                    { 
                        name = "**Discord:\n**",
                        value = "``["..license.discord.."]``"
                    },
                    { 
                        name = "**Reason:\n**",
                        value = "``"..reason.."``"
                    },
                    {                        
                        name = "**Sistema desenvolvido Por GoatDev**\n",
                        value = "https://goatdev.net/."
                    }
                }, 
                footer = { 
                    text = "ZonaShield - "..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://discord.com/channels/1077971061636878336/1078024540908687380/1089960190457172018"
                },
                color = 1627827
            }
        }
    }), { ['Content-Type'] = 'application/json' })
    TriggerEvent("AcUnBan", source)
end

-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('acunban', function(source,args,rawCmd)
    if args[1] then
        local source = source
        local nsource = vRP.getUserSource(parseInt(args[1]))
        local user_id = vRP.getUserId(source)
        local aclicense = ExtractIdentifiers(nsource)
        if vRP.hasPermission(user_id,Config.ac.permissaoadm) then
            if acinfo ~= aclicense.tokens then
                acinfo = tostring(aclicense.tokens)
            end
            if acinfo == tostring(aclicense.tokens) then
                if args[1] == acdata[acinfo].AcID then
                    acdata[acinfo].AcBanned = false
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('acban', function(source,args,rawCmd)
    local source = source
    local user_id = vRP.getUserId(source)
    local nsource = vRP.getUserSource(parseInt(args[1]))
    local aclicense = ExtractIdentifiers(nsource)
    if vRP.hasPermission(user_id,Config.ac.permissaoadm) then
    if acinfo ~= aclicense.tokens then
        acinfo = tostring(aclicense.tokens)
    end
    if acinfo == tostring(aclicense.tokens) then
        if args[1] == acdata[acinfo].AcID then
            acdata[acinfo].AcBanned = true
        end
    end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Extract Info
-----------------------------------------------------------------------------------------------------------------------------------------

function ExtractIdentifiers(source)
    local identifiers = {
        steam = "",
        discord = "",
        license = "",
        xbl = "",
        live = "",
		ip = "",
		tokens = ""
    }
	identifiers.ip = GetPlayerEndpoint(source)
    identifiers.tokens = GetPlayerToken(source)
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end
    return identifiers
end

----------------------------------------------------------------------------------------------------------------------------------------
--Auto-Save
----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        SaveResourceFile(GetCurrentResourceName(),"json/data.json",json.encode(userdata, { indent = true }),-1)
        SaveResourceFile(GetCurrentResourceName(),"json/acdata.json",json.encode(acdata, { indent = true }),-1)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------
--AC
----------------------------------------------------------------------------------------------------------------------------------------

--Explosao

local blockexplosao = {0, 1, 2, 4, 5, 7, 25, 29, 32, 33, 35, 36, 37, 38, 49, 70}
    AddEventHandler('explosionEvent', function(sender, ev)
        if Config.deteccoes.explosion == true then
        CancelEvent()
        if sender ~= nil then
            local player = GetPlayerPed(sender)
            local plycds = GetEntityCoords(player)
            local expcds = vector3(ev.posX, ev.posY, ev.posZ)
            local zerocds = vector3(1.55, 1.62, -0.11)
            local zerodist = #(expcds - zerocds)
            local plydist = #(plycds - expcds)
            if debugenabled then
                if ev.explosionType ~= 0 then
                    print("^8Explosion debug "..ev.explosionType.."^0")
                end
            end
            if zerodist > 150 then
                CancelEvent()
                for k,exp in pairs(blockexplosao) do
                    if ev.explosionType == exp then
                        goat.banplayerwsource(sender, "Explosão.\nExplosion Type:\n\n"..json.encode(ev).."")
                    --else
                        if plydist > 50 then
                            goat.banplayerwsource(sender, "Explosão.\nExplosion Type:\n\n"..json.encode(ev).."")
                        end
                    end
                end
            end
            if ev.isInvisible == true then
                goat.banplayerwsource(sender, "Explosão.\nExplosion Type:\n\n"..json.encode(ev).."")
            end
            if ev.isAudible == false then
                goat.banplayerwsource(sender, "Explosão.\nExplosion Type:\n\n"..json.encode(ev).."")
            end
        end
    end
end)



-- anticheat_explosions.lua

-- Lista de tipos de explosões permitidos
local allowedExplosions = {
    0,  -- Grenade
    1,  -- Grenade Launcher
    2,  -- Sticky Bomb
    3,  -- Molotov
    4,  -- Rocket
    5,  -- Tank Shell
    6,  -- Hi Octane
    7,  -- Car
    8,  -- Plane
    9,  -- Petrol Pump
    10, -- Bike
    11, -- Steam
    12, -- Flame
    13, -- Water Hydrant
    14, -- Gas Canister
    15, -- Boat
    16, -- Ship Destroy
    17, -- Truck
    18, -- Bullet
    19, -- Smoke Grenade Launcher
    20, -- Smoke Grenade
    21, -- BZ Gas
    22, -- Flare
    23, -- Gas Canister2
    24, -- Extinguisher
    25, -- Programmable AR
    26, -- Train
    27, -- Barrel
    28, -- Propane
    29, -- Blimp
    30, -- Flame Explode
    31, -- Tanker
    32, -- Plane Rocket
    33, -- Vehicle Bullet
    34, -- Gas Tank
    35, -- FireWork
    36, -- SnowBall
    37, -- Prox Mine
    38, -- Valkyrie Cannon
}

local function isExplosionAllowed(explosionType)
    for _, allowedType in ipairs(allowedExplosions) do
        if explosionType == allowedType then
            return true
        end
    end
    return false
end

AddEventHandler('explosionEvent', function(sender, ev)
    if not isExplosionAllowed(ev.explosionType) then
        CancelEvent()
        local playerName = GetPlayerName(sender)
        local explosionType = ev.explosionType
        print("Explosão cancelada do jogador: " .. playerName .. " | Tipo de explosão: " ..explosionType.."")

        goat.banplayerwsource(sender, "Explosão.\nExplosion Type:\n\n"..explosionType.." \nExplosion Type2:\n\n"..json.encode(ev).."")
        TriggerClientEvent('chatMessage', sender, "^1Anti-Cheat: Explosões não são permitidas!")
    end
end)


--Eventos

local eventos = { 
    "CarryPeople:sync", 
    "offred_lavanderia:enviarQuantia", 
    "mellotrainer:s_adminKill", 
    "mellotrainer:adminTempBan", 
    "mellotrainer:adminKick", 
    "EasyAdmin:kickPlayer", 
    "entrega_maconha:itensReceber", 
    "entrega_metafetamina:itensReceber", 
    "entrega_coca:itensReceber", 
    "j_lavanderia2:depositarDSujo", 
    "offred:salar", 
    "contrabando-comprar", 
    "comprar-nav", 
    "esx-qalle-hunting:reward", 
    "esx-qalle-hunting:sell", 
    "adminmenu:allowall", 
    "playerSpawned", 
    "esx_ambulancejob:revive", 
    "esx_billing:sendBill", 
    "esx_policejob:handcuff", 
    "esx_policejob:putInVehicle", 
    "esx_society:withdrawMoney", 
    "esx_society:depositMoney", 
    "esx_doorlock:statusShare", 
    "esx_vehicleshop:setVehicleOwned", 
    "esx_property:setPropertyOwned", 
    "esx_inventoryhud:openInventory", 
    "esx_status:add", 
    "esx_fueldelivery:pay"
}

for i, eventos in ipairs(eventos) do
    RegisterServerEvent(eventos)
    AddEventHandler(eventos, function()
        local source = source
        goat.banplayerwsource(source,"Event Triggered")
    end)
end

--Taze Player

local taze = {}
AddEventHandler("weaponDamageEvent", function(src, data)
    if Config.deteccoes.tazeplayer == true then
        local license = ExtractIdentifiers(src)
        if data.weaponType == 911657153 then
            if taze[license.tokens] ~= nil then
                taze[license.tokens].COUNT = taze[license.tokens].COUNT + 1
                if os.time() - taze[license.tokens].TIME <= 10 then
                    taze[license.tokens] = nil
                else
                    if taze[license.tokens].COUNT >= Config.ac.MaxTazeSpam then
                        goat.banplayerwsource(src,"Anti Spam Tazer.\nTry For Spam Tazer for **"..taze[license.tokens].COUNT.."** times.")
                        CancelEvent()
                    end
                end
            else
                taze[license.tokens] = {
                    COUNT = 1,
                    TIME  = os.time()
                }
            end
        end
    end
end)

--Freeze Player

local freeze = {}
AddEventHandler("clearPedTasksEvent", function(src, data)
    local license = ExtractIdentifiers(src)
    if Config.deteccoes.freezeplayer == true then
        if freeze[license.tokens] ~= nil then
            freeze[license.tokens].COUNT = freeze[license.tokens].COUNT + 1
            if os.time() - freeze[license.tokens].TIME <= 10 then
                freeze[license.tokens] = nil
            else
                if freeze[license.tokens].COUNT >= Config.ac.MaxClearPedTask then
                    goat.banplayerwsource(src,"Anti Clear Ped Tasks.\nTry Clear Ped Tasks for "..freeze[license.tokens].TIME..".")
                    CancelEvent()
                end
            end
        else
            freeze[license.tokens] = {
                COUNT = 1,
                TIME  = os.time()
            }
        end
    end
end)

--Give Weapon

AddEventHandler('giveWeaponEvent', function(sender, ev)
    if Config.deteccoes.spawnweapon == true then
        goat.banplayerwsource(sender,"Spawn Weapon.\nInfo: "..json.encode(ev).."")
        print(sender, json.encode(ev))
        CancelEvent()
    end
end)

local function handleGiveWeaponEvent2(sender, ev)
    if Config.deteccoes.spawnweapon then
        if type(ev) ~= "table" then
            print(string.format("Evento inválido de %s: %s", sender, tostring(ev)))
            return
        end
        local success, jsonData = pcall(function() return json.encode(ev) end)
        if success then
            goat.banplayerwsource(sender, string.format("Spawn Weapon.\nInfo: %s", jsonData))
            print(string.format("Jogador %s banido por spawn de arma. Info: %s", sender, jsonData))
        else
            print(string.format("Falha ao codificar JSON para o jogador %s: %s", sender, tostring(ev)))
        end
        CancelEvent()
    end
end

AddEventHandler('giveWeaponEvent2', function(sender, ev)
    local success, errorMsg = pcall(handleGiveWeaponEvent2, sender, ev)
    if not success then
        print(string.format("Erro ao processar evento giveWeaponEvent2 para o jogador %s: %s", sender, errorMsg))
    end
end)


--Remove Weapon

AddEventHandler("RemoveWeaponEvent", function(sender, ev)
    if Config.deteccoes.removeweapon == true then
        goat.banplayerwsource(sender,"Remove Weapon.\nInfo: "..json.encode(ev).."")
        print(sender, json.encode(ev))
        CancelEvent()
    end
end)

AddEventHandler("RemoveAllWeaponsEvent",function(sender, ev)
    if Config.deteccoes.removeweapon == true then
        goat.banplayerwsource(sender,"Remove All Weapon.\nInfo: "..json.encode(ev).."")
        print(sender, json.encode(ev))
        CancelEvent()
    end
end)

--Particulas

AddEventHandler("ptFxEvent", function(source, data)
    goat.logplayerwsource(source,"Particles\nInfo: "..json.encode(data).."")
	CancelEvent()
end)

--Entity Manager

local SV_VEHICLES = {}
local SV_PEDS = {}
local SV_OBJECT = {}
local Objects = {}
local Peds = {}

AddEventHandler('entityCreated', function(entity) --- this can ban wrong
    if not DoesEntityExist(entity) then
        return
    end
    local source = source
    local src = NetworkGetEntityOwner(entity)
    local user_id = vRP.getUserId(source)
    local entID = NetworkGetNetworkIdFromEntity(entity)
    local model = GetEntityModel(entity)
    local hash = GetHashKey(entity)

    if Config.deteccoes.blacklist == true then
        for i, objName in ipairs(Config.ac.blacklistcar) do
            if model == objName then
                if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
                TriggerClientEvent("DeleteCars", -1,entID)
                Citizen.Wait(800)
                goat.logplayerwsource(src,"Blacklist Vehicle Spawned\nObject: "..objName.. " Model: "..model.. " Entity: "..entity.. " Hash: "..hash)
                end
            end
        end
    end

    if Config.deteccoes.objects == true then
        for i, objName in ipairs(Config.ac.blacklistprops) do
            if model == objName then
                if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
                TriggerClientEvent("DeleteEntity", -1, entID)
                Citizen.Wait(800)
                goat.banplayerwsource(src,"Blacklist Object Spawned\nObject: "..objName.. " Model: "..model.. " Entity: "..entity.. " Hash: "..hash)
                break
                end
            end
        end
    end
end)

AddEventHandler("entityCreated", function(ENTITY)
    if DoesEntityExist(ENTITY) then
        local TYPE  = GetEntityType(ENTITY)
        local OWNER = NetworkGetFirstEntityOwner(ENTITY)
        local sourceowner = vRP.getUserSource(OWNER)
        local NETID = NetworkGetNetworkIdFromEntity(ENTITY)
        local MODEL = GetEntityModel(ENTITY)
        local HWID  = ExtractIdentifiers(OWNER)
        local source = source
        local user_id = vRP.getUserId(source)
        --【 𝗕𝗹𝗮𝗰𝗸 𝗟𝗶𝘀𝘁 𝗠𝗮𝗻𝗮𝗴𝗲 】--
        if Config.deteccoes.objects == true  and TYPE == 3 then
            for index, value in ipairs(Objects) do
                if MODEL == GetHashKey(value) then
                    if DoesEntityExist(ENTITY) then
                        if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
                        DeleteEntity(ENTITY)
                        Wait(1000)
                        goat.logplayerwsource(sourceowner,"Anti Spawn Object")
                        end
                    end
                end
            end
        end
        if Config.deteccoes.spawnped == true and TYPE == 1 then
            for index, value in ipairs(Peds) do
                if MODEL == GetHashKey(value) then
                    if DoesEntityExist(ENTITY) then
                        if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
                        DeleteEntity(ENTITY)
                        Wait(1000)
                        goat.banplayerwsource(sourceowner,"Anti Spawn Peds")
                        end
                    end
                end
            end
        end
        if Config.deteccoes.blacklist == true  and TYPE == 2 then
            for index, value in ipairs(Config.ac.blacklistcar) do
                if MODEL == GetHashKey(value) then
                    if DoesEntityExist(ENTITY) then
                        if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
                        DeleteEntity(ENTITY)
                        Wait(1000)
                        goat.banplayerwsource(sourceowner,"Blacklist Car")
                        end
                    end
                end
            end
        end
        if Config.deteccoes.spamentitys == true  then
        local ENT = NetworkGetEntityFromNetworkId(NETID)
        --【 𝗦𝗽𝗮𝗺 𝗠𝗮𝗻𝗮𝗴𝗲𝗺𝗲𝗻𝘁 】--
        local TYPE2 = GetEntityType(ENT)
        if TYPE == 2 then
            if SV_VEHICLES[HWID.tokens] ~= nil then
                SV_VEHICLES[HWID.tokens].COUNT = SV_VEHICLES[HWID.tokens].COUNT + 1
                if os.time() - SV_VEHICLES[HWID.tokens].TIME >= 10 then
                    SV_VEHICLES[HWID.tokens] = nil
                else
                    if SV_VEHICLES[HWID.tokens].COUNT >= Config.ac.MaxVehicle then
                        for _, vehilce in ipairs(GetAllVehicles()) do
                            local ENO = NetworkGetFirstEntityOwner(vehilce)
                            if ENO == OWNER then
                                if DoesEntityExist(vehilce) then
                                    if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
                                    DeleteEntity(vehilce)
                                    end
                                end
                            end
                        end
                        goat.banplayerwsource(sourceowner,"Spam Vehicle.\n"..SV_VEHICLES[HWID.tokens].COUNT.." Cars.")
                        AddEventHandler("onResourceStop",function()
                            SV_VEHICLES[HWID.tokens].COUNT = 0
                        end)
                        AddEventHandler("playerConnecting",function()
                            SV_VEHICLES[HWID.tokens].COUNT = 0
                        end)
                    end
                end
            else
                SV_VEHICLES[HWID.tokens] = {
                    COUNT = 1,
                    TIME  = os.time()
                }
            end
        elseif TYPE == 1 then
            if SV_PEDS[HWID.tokens] ~= nil then
                SV_PEDS[HWID.tokens].COUNT = SV_PEDS[HWID.tokens].COUNT + 1
                if os.time() - SV_PEDS[HWID.tokens].TIME >= 10 then
                    SV_PEDS[HWID.tokens] = nil
                else
                    for _, peds in ipairs(GetAllPeds()) do
                        local ENO = NetworkGetFirstEntityOwner(peds)
                        if ENO == OWNER then
                            if DoesEntityExist(peds) then
                                if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
                                DeleteEntity(peds)
                                end
                            end
                        end
                    end
                    if SV_PEDS[HWID.tokens].COUNT >= Config.ac.MaxPed then
                        goat.banplayerwsource(sourceowner,"Spam Peds.\n"..SV_PEDS[HWID.tokens].COUNT.." Peds.")
                    end
                    AddEventHandler("onResourceStop",function()
                        SV_PEDS[HWID.tokens].COUNT = 0
                    end)
                    AddEventHandler("playerConnecting",function()
                        SV_PEDS[HWID.tokens].COUNT = 0
                    end)
                end
            else
                SV_PEDS[HWID.tokens] = {
                    COUNT = 1,
                    TIME  = os.time()
                }
            end
        elseif TYPE == 3 then
            if SV_OBJECT[HWID.tokens] ~= nil then
                SV_OBJECT[HWID.tokens].COUNT = SV_OBJECT[HWID.tokens].COUNT + 1
                if os.time() - SV_OBJECT[HWID.tokens].TIME >= 10 then
                    SV_OBJECT[HWID.tokens] = nil
                else
                    if SV_OBJECT[HWID.tokens].COUNT >= Config.ac.MaxObject then
                        for _, objects in ipairs(GetAllObjects()) do
                            local ENO = NetworkGetFirstEntityOwner(objects)
                            if ENO == OWNER then
                                if DoesEntityExist(objects) then
                                    if not vRP.hasPermission(user_id,Config.ac.permissaoadm) then
                                    DeleteEntity(objects)
                                    end
                                end
                            end
                        end
                        goat.banplayerwsource(sourceowner,"Spam Objects.\n"..SV_OBJECT[HWID.tokens].COUNT.." Objects.")
                        AddEventHandler("onResourceStop",function()
                            SV_OBJECT[HWID.tokens].COUNT = 0
                        end)
                        AddEventHandler("playerConnecting",function()
                            SV_OBJECT[HWID.tokens].COUNT = 0
                        end)
                    end
                end
            else
                SV_OBJECT[HWID.tokens] = {
                    COUNT = 1,
                    TIME  = os.time()
                }
            end
        end
        end
    end
end)

------------------------------------
----------    Install    -----------
------------------------------------

RegisterCommand("acinstall", function(source)
    count = 0
    skip = 0
    if source == 0 then
        local randomtextfile = RandomLetter(12) .. ".lua"
        _antiinjection = LoadResourceFile(GetCurrentResourceName(), "main.lua")
        for resources = 0, GetNumResources() - 1 do
            local _resname = GetResourceByFindIndex(resources)
            _resourcemanifest = LoadResourceFile(_resname, "__resource.lua")
            _resourcemanifest2 = LoadResourceFile(_resname, "fxmanifest.lua")
            if _resourcemanifest then
                Wait(100)
                _toadd = _resourcemanifest .. "\n\nclient_script {\n'@vrp/lib/utils.lua','" .. randomtextfile .. "'\n}"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "__resource.lua", _toadd, -1)
                print("^4[ZonaShield]: ^2Anti Injection Installed on ^7".._resname)
                count = count + 1
            elseif _resourcemanifest2 then
                Wait(100)
                _toadd = _resourcemanifest2 .. "\n\nclient_script {\n'@vrp/lib/utils.lua','" .. randomtextfile .. "'\n}"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "fxmanifest.lua", _toadd, -1)
                print("^4[ZonaShield]: ^2Anti Injection Installed on ^7".._resname)
                count = count + 1
            else
                skip = skip + 1
                print("^4[ZonaShield]: ^2Skipped Resource: ^7".._resname)
            end
        end
        print("^4[ZonaShield]: ^2Installation has finished. Succesfully installed Anti-Injection in ^7"..count.." ^2Resources. Skipped: ^7"..skip.." ^2Resources. Restart Your Server!^7")
    end
end)

RegisterCommand("acuninstall", function(source, args, rawCommand)
    if source == 0 then
        count = 0
        skip = 0
        if args[1] then
            local filetodelete = args[1] .. ".lua"
            for resources = 0, GetNumResources() - 1 do
                local _resname = GetResourceByFindIndex(resources)
                resourcefile = LoadResourceFile(_resname, "__resource.lua")
                resourcefile2 = LoadResourceFile(_resname, "fxmanifest.lua")
                if resourcefile then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^4[ZonaShield]: ^1Anti Injection Uninstalled on ^7".._resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[ZonaShield]: Skipped Resource: " .._resname)
                    end
                elseif resourcefile2 then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^4[ZonaShield]: ^1Anti Injection Uninstalled on ^7".._resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("^4[ZonaShield]: ^1Skipped Resource: ^7" .._resname)
                    end
                else
                    skip = skip + 1
                    print("^4[ZonaShield]: ^1Skipped Resource: ^7".._resname)
                end
            end
            print("^4[ZonaShield]: ^1UNINSTALLATION has finished. Succesfully uninstalled Anti-Injection in ^7"..count.." ^1Resources. Skipped: ^7"..skip.."^1 Resources. Restart Your Server!^7")
        else
            print("^4[ZonaShield]: ^1You must write the file name to uninstall Anti-Injection!^7")
        end
    end
end)

local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

RandomLetter = function(length)
    if length > 0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end
    return ""
end