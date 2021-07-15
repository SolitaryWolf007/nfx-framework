fx_version "bodacious"
game "gta5"

author "SolitaryWolf007"
description "nFX Framework"
version "1.0"

ui_page "cli/gui/index.html"


--		- Special thanks to ImagicTheCat (https://github.com/ImagicTheCat/vRP/tree/1.0/vrp), for developing the GUI script and for the libraries (shared/).
--		- Special thanks to beetle2k (https://github.com/beetle2k/vRP-B2K), for the GUI design <3

client_scripts {
	"shared/utils.lua",
	"cli/_core.lua",
	"cli/gui.lua",
	"cli/map.lua",
	"cli/player.lua",
	"cli/survival.lua",
	"cli/vehicles.lua",
	"cli/weapons.lua",
	"cli/weather.lua"
}

server_scripts { 
	"shared/utils.lua",
	"modules/_core.lua",
	"modules/clothingstore.lua",
	"modules/groups.lua",
	"modules/gui.lua",
	"modules/inventory.lua",
	"modules/map.lua",
	"modules/player.lua",
	"modules/survival.lua",
	"modules/vehicles.lua",
	"modules/weapons.lua",
	"modules/weather.lua"
}

files {
	"shared/*.lua",
	"config/*.lua",
	"config/**/*.lua",
	"cli/gui/*",
	"cli/gui/**/*",
}