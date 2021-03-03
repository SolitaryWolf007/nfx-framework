fx_version "bodacious"
game "gta5" 

author "SolitaryWolf007"
description "nFX Admin"
version "1.0"

client_scripts {
	"@nfx/shared/utils.lua",
	"cli/*.lua",

}

server_scripts { 
	"@nfx/shared/utils.lua",
	"srv/*.lua",
}

files {
	"config/*",
	"config/**/*"
}