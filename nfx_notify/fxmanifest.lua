fx_version "bodacious"
game "gta5" 

author 'Summerz' --> (https://github.com/contatosummerz/vrpex/tree/master/vrp_notify)
modification 'SolitaryWolf007'
description 'nFX Notify'
version '1.0'

client_scripts {
	"@nfx/shared/utils.lua",
	"cli/*.lua",

}

ui_page "cli/ui/index.html"

files {
    "cli/ui/*",
    "cli/ui/**/*",
}