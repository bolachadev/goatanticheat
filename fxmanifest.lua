fx_version 'bodacious'
game 'gta5'

author "GoatDev"
version "1.2"

dependency {
	"screenshot-basic",
	"core",
	"zona"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"cl_side/client.lua",
	"config.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"sv_side/server.lua",
	"config.lua"
}