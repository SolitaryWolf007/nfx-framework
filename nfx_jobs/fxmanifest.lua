fx_version 'bodacious'
game 'gta5'

author 'SolitaryWolf007'
description 'nFX Jobs'
version '1.0'

client_scripts {
	"@nfx/shared/utils.lua",
	"cli/cli__core.lua",
	"cli/*.lua",

}

server_scripts { 
	"@nfx/shared/utils.lua",
	"srv/srv__core.lua",
	"srv/*.lua",
}

files {
	"config/*",
	"config/**/*"
}