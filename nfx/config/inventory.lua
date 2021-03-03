local config = {}
--======================================================
-- INVENTORY
--======================================================
config.default_weight = 6

config.max_weight = 90
--======================================================
-- ITEMS
--======================================================
config.items = {
    ["bread"] = { ["name"] = "Bread", ["index"] = "bread", ["weight"] = 0.2, ["type"] = "item" },
    ["water"] = { ["name"] = "Water", ["index"] = "water", ["weight"] = 0.5, ["type"] = "item" },
    ["handcuffs"] = { ["name"] = "Handcuffs", ["index"] = "handcuffs", ["weight"] = 0.5, ["type"] = "item" },
    ["repairkit"] = { ["name"] = "Repair Kit", ["index"] = "repairkit", ["weight"] = 1.2, ["type"] = "item" },
    
    ["w|WEAPON_PISTOL"] = { ["name"] = "Pistol", ["index"] = "pistol", ["weight"] = 2.5, ["type"] = "weapon" },
    ["a|WEAPON_PISTOL"] = { ["name"] = "Pistol Ammo", ["index"] = "a-pistol", ["weight"] = 0.2, ["type"] = "ammo" },
}
--======================================================
-- VEHICLES CHESTS
--======================================================
config.vehicle_chests = {
    ["adder"] = 40,
    ["airbus"] = 30,
    ["airtug"] = 40,
    ["akula"] = 100,
    ["akuma"] = 15,
    ["alpha"] = 40,
    ["alphaz1"] = 500,
    ["ambulance"] = 30,
    ["annihilator"] = 100,
    ["apc"] = 100,
    ["ardent"] = 40,
    ["asbo"] = 20,
    ["asea2"] = 40,
    ["asea"] = 40,
    ["asterope"] = 40,
    ["autarch"] = 40,
    ["avarus"] = 15,
    ["avenger"] = 500,
    ["bagger"] = 15,
    ["baller2"] = 40,
    ["baller3"] = 40,
    ["baller4"] = 40,
    ["baller5"] = 40,
    ["baller6"] = 40,
    ["baller"] = 40,
    ["banshee2"] = 40,
    ["banshee"] = 40,
    ["barracks2"] = 100,
    ["barracks3"] = 100,
    ["barracks"] = 100,
    ["barrage"] = 100,
    ["bati2"] = 15,
    ["bati"] = 15,
    ["benson"] = 40,
    ["besra"] = 500,
    ["bestiagts"] = 40,
    ["bf400"] = 15,
    ["bfinjection"] = 50,
    ["biff"] = 40,
    ["bifta"] = 50,
    ["bison2"] = 100,
    ["bison3"] = 100,
    ["bison"] = 100,
    ["bjxl"] = 40,
    ["blade"] = 30,
    ["blazer2"] = 50,
    ["blazer3"] = 50,
    ["blazer4"] = 50,
    ["blazer5"] = 50,
    ["blazer"] = 50,
    ["blimp3"] = 500,
    ["blista3"] = 40,
    ["blista"] = 20,
    ["bmx"] = 5,
    ["bobcatxl"] = 100,
    ["bodhi2"] = 50,
    ["bombushka"] = 500,
    ["boxville2"] = 100,
    ["boxville3"] = 100,
    ["boxville4"] = 100,
    ["boxville5"] = 100,
    ["boxville"] = 100,
    ["brawler"] = 50,
    ["brickade"] = 30,
    ["brioso"] = 20,
    ["bruiser2"] = 50,
    ["bruiser3"] = 50,
    ["bruiser"] = 50,
    ["brutus2"] = 50,
    ["brutus3"] = 50,
    ["brutus"] = 50,
    ["btype2"] = 40,
    ["btype3"] = 40,
    ["btype"] = 40,
    ["buccaneer2"] = 30,
    ["buccaneer"] = 30,
    ["buffalo2"] = 40,
    ["buffalo3"] = 40,
    ["buffalo"] = 40,
    ["bulldozer"] = 40,
    ["bullet"] = 40,
    ["burrito2"] = 100,
    ["burrito3"] = 100,
    ["burrito4"] = 100,
    ["burrito5"] = 100,
    ["burrito"] = 100,
    ["bus"] = 30,
    ["buzzard2"] = 100,
    ["buzzard"] = 100,
    ["caddy2"] = 40,
    ["caddy3"] = 40,
    ["caddy"] = 40,
    ["camper"] = 100,
    ["caracara2"] = 50,
    ["caracara"] = 50,
    ["carbonizzare"] = 40,
    ["carbonrs"] = 15,
    ["cargobob2"] = 100,
    ["cargobob"] = 100,
    ["casco"] = 40,
    ["cavalcade2"] = 40,
    ["cavalcade"] = 40,
    ["cerberus2"] = 40,
    ["cerberus3"] = 40,
    ["cerberus"] = 40,
    ["cheburek"] = 40,
    ["cheetah2"] = 40,
    ["cheetah"] = 40,
    ["chernobog"] = 100,
    ["chimera"] = 15,
    ["chino2"] = 30,
    ["chino"] = 30,
    ["cliffhanger"] = 15,
    ["clique"] = 30,
    ["coach"] = 30,
    ["cog55"] = 40,
    ["cog552"] = 40,
    ["cogcabrio"] = 30,
    ["cognoscenti2"] = 40,
    ["cognoscenti"] = 40,
    ["comet2"] = 40,
    ["comet3"] = 40,
    ["comet4"] = 40,
    ["comet5"] = 40,
    ["contender"] = 40,
    ["coquette2"] = 40,
    ["coquette3"] = 30,
    ["coquette"] = 40,
    ["cruiser"] = 5,
    ["crusader"] = 100,
    ["cuban800"] = 500,
    ["cutter"] = 40,
    ["cyclone"] = 40,
    ["daemon2"] = 15,
    ["daemon"] = 15,
    ["deathbike2"] = 15,
    ["deathbike3"] = 15,
    ["deathbike"] = 15,
    ["defiler"] = 15,
    ["deluxo"] = 40,
    ["deveste"] = 40,
    ["deviant"] = 30,
    ["diabolus2"] = 15,
    ["dilettante2"] = 20,
    ["dilettante"] = 20,
    ["dinghy2"] = 35,
    ["dinghy3"] = 35,
    ["dinghy4"] = 35,
    ["dinghy"] = 35,
    ["dloader"] = 50,
    ["docktug"] = 40,
    ["dodo"] = 500,
    ["dominator2"] = 30,
    ["dominator3"] = 30,
    ["dominator4"] = 30,
    ["dominator5"] = 30,
    ["dominator6"] = 30,
    ["dominator"] = 30,
    ["double"] = 15,
    ["drafter"] = 40,
    ["dubsta2"] = 40,
    ["dubsta3"] = 50,
    ["dubsta"] = 40,
    ["dukes2"] = 30,
    ["dukes"] = 30,
    ["dump"] = 40,
    ["dune2"] = 50,
    ["dune3"] = 50,
    ["dune4"] = 50,
    ["dune5"] = 50,
    ["dune"] = 50,
    ["duster"] = 500,
    ["dynasty"] = 40,
    ["elegy2"] = 40,
    ["elegy"] = 40,
    ["ellie"] = 30,
    ["emerus"] = 40,
    ["emperor2"] = 40,
    ["emperor3"] = 40,
    ["emperor"] = 40,
    ["enduro"] = 15,
    ["entity2"] = 40,
    ["entityxf"] = 40,
    ["esskey"] = 15,
    ["everon"] = 50,
    ["exemplar"] = 30,
    ["f620"] = 30,
    ["faction2"] = 30,
    ["faction3"] = 30,
    ["faction"] = 30,
    ["fagaloa"] = 40,
    ["faggio3"] = 15,
    ["faggio"] = 15,
    ["fbi2"] = 30,
    ["fbi"] = 30,
    ["fcr2"] = 15,
    ["fcr"] = 15,
    ["felon2"] = 30,
    ["felon"] = 30,
    ["feltzer2"] = 40,
    ["feltzer3"] = 40,
    ["firetruk"] = 30,
    ["flashgt"] = 40,
    ["flatbed"] = 40,
    ["fmj"] = 40,
    ["forklift"] = 40,
    ["fq2"] = 40,
    ["freecrawler"] = 50,
    ["frogger"] = 100,
    ["fugitive"] = 40,
    ["furia"] = 40,
    ["furoregt"] = 40,
    ["fusilade"] = 40,
    ["futo"] = 40,
    ["gargoyle"] = 15,
    ["gauntlet2"] = 30,
    ["gauntlet3"] = 30,
    ["gauntlet4"] = 30,
    ["gauntlet"] = 30,
    ["gb200"] = 40,
    ["gburrito2"] = 100,
    ["gburrito"] = 100,
    ["glendale"] = 40,
    ["gp1"] = 40,
    ["granger"] = 40,
    ["gresley"] = 40,
    ["gt500"] = 40,
    ["guardian"] = 40,
    ["habanero"] = 40,
    ["hakuchou2"] = 15,
    ["hakuchou"] = 15,
    ["halftrack"] = 100,
    ["handler"] = 40,
    ["hauler2"] = 40,
    ["hauler"] = 40,
    ["havok"] = 100,
    ["hellion"] = 50,
    ["hermes"] = 30,
    ["hexer"] = 15,
    ["hotknife"] = 30,
    ["hotring"] = 40,
    ["howard"] = 500,
    ["hunter"] = 100,
    ["huntley"] = 40,
    ["hustler"] = 30,
    ["hydra"] = 500,
    ["imorgon"] = 40,
    ["impaler2"] = 30,
    ["impaler3"] = 30,
    ["impaler4"] = 30,
    ["impaler"] = 30,
    ["imperator2"] = 30,
    ["imperator3"] = 30,
    ["imperator"] = 30,
    ["infernus2"] = 40,
    ["infernus"] = 40,
    ["ingot"] = 40,
    ["innovation"] = 15,
    ["insurgent2"] = 50,
    ["insurgent3"] = 50,
    ["insurgent"] = 50,
    ["intruder"] = 40,
    ["issi2"] = 20,
    ["issi3"] = 20,
    ["issi4"] = 20,
    ["issi5"] = 20,
    ["issi6"] = 20,
    ["issi7"] = 40,
    ["italigtb2"] = 40,
    ["italigtb"] = 40,
    ["italigto"] = 40,
    ["jackal"] = 30,
    ["jb700"] = 40,
    ["jb7002"] = 40,
    ["jester2"] = 40,
    ["jester3"] = 40,
    ["jester"] = 40,
    ["jetmax"] = 35,
    ["journey"] = 100,
    ["jugular"] = 40,
    ["kalahari"] = 50,
    ["kamacho"] = 50,
    ["kanjo"] = 20,
    ["khamelion"] = 40,
    ["khanjali"] = 100,
    ["komoda"] = 40,
    ["krieger"] = 40,
    ["kuruma2"] = 40,
    ["kuruma"] = 40,
    ["landstalker"] = 40,
    ["lazer"] = 500,
    ["le7b"] = 40,
    ["lectro"] = 15,
    ["lguard"] = 30,
    ["limo2"] = 40,
    ["locust"] = 40,
    ["lurcher"] = 30,
    ["luxor2"] = 500,
    ["luxor"] = 500,
    ["lynx"] = 40,
    ["mamba"] = 40,
    ["mammatus"] = 500,
    ["mananacorpse"] = 40,
    ["manchez"] = 15,
    ["marquis"] = 35,
    ["marshall"] = 50,
    ["massacro2"] = 40,
    ["massacro"] = 40,
    ["maverick"] = 100,
    ["menacer"] = 50,
    ["mesa2"] = 40,
    ["mesa3"] = 50,
    ["mesa"] = 40,
    ["michelli"] = 40,
    ["microlight"] = 500,
    ["miljet"] = 500,
    ["minitank"] = 100,
    ["minivan2"] = 100,
    ["minivan"] = 100,
    ["mixer2"] = 40,
    ["mixer"] = 40,
    ["mogul"] = 500,
    ["molotok"] = 500,
    ["monroe"] = 40,
    ["monster3"] = 50,
    ["monster4"] = 50,
    ["monster5"] = 50,
    ["monster"] = 50,
    ["moonbeam2"] = 30,
    ["moonbeam"] = 30,
    ["mower"] = 40,
    ["mule2"] = 40,
    ["mule3"] = 40,
    ["mule4"] = 40,
    ["mule"] = 40,
    ["nebula"] = 40,
    ["nemesis"] = 15,
    ["neo"] = 40,
    ["neon"] = 40,
    ["nero2"] = 40,
    ["nero"] = 40,
    ["nightblade"] = 15,
    ["nightshade"] = 30,
    ["nightshark"] = 50,
    ["nimbus"] = 500,
    ["ninef2"] = 40,
    ["ninef"] = 40,
    ["nokota"] = 500,
    ["novak"] = 40,
    ["omnis"] = 40,
    ["oppressor2"] = 15,
    ["oppressor"] = 15,
    ["osiris"] = 40,
    ["outlaw"] = 50,
    ["packer"] = 40,
    ["panto"] = 20,
    ["paradise"] = 100,
    ["paragon2"] = 40,
    ["paragon"] = 40,
    ["pariah"] = 40,
    ["patriot2"] = 40,
    ["patriot"] = 40,
    ["pbus2"] = 30,
    ["pbus"] = 30,
    ["pcj"] = 15,
    ["penetrator"] = 40,
    ["penumbra"] = 40,
    ["peyote2"] = 30,
    ["peyote"] = 40,
    ["pfister811"] = 40,
    ["phantom2"] = 40,
    ["phantom3"] = 40,
    ["phantom"] = 40,
    ["phoenix"] = 30,
    ["picador"] = 30,
    ["pigalle"] = 40,
    ["police2"] = 30,
    ["police3"] = 30,
    ["police4"] = 30,
    ["police"] = 30,
    ["policeb"] = 30,
    ["policeold1"] = 30,
    ["policeold2"] = 30,
    ["policet"] = 30,
    ["polmav"] = 30,
    ["pony2"] = 100,
    ["pony"] = 100,
    ["pounder2"] = 40,
    ["pounder"] = 40,
    ["prairie"] = 20,
    ["pranger"] = 30,
    ["premier"] = 40,
    ["primo2"] = 40,
    ["primo"] = 40,
    ["prototipo"] = 40,
    ["pyro"] = 500,
    ["radi"] = 40,
    ["raiden"] = 40,
    ["rallytruck"] = 30,
    ["rancherxl2"] = 50,
    ["rancherxl"] = 50,
    ["rapidgt2"] = 40,
    ["rapidgt3"] = 40,
    ["rapidgt"] = 40,
    ["raptor"] = 40,
    ["ratbike"] = 15,
    ["ratloader2"] = 30,
    ["ratloader"] = 30,
    ["rcbandito"] = 50,
    ["reaper"] = 40,
    ["rebel2"] = 50,
    ["rebel"] = 50,
    ["rebla"] = 40,
    ["regina"] = 40,
    ["rentalbus"] = 30,
    ["retinue2"] = 40,
    ["retinue"] = 40,
    ["revolter"] = 40,
    ["rhapsody"] = 20,
    ["rhino"] = 100,
    ["riata"] = 50,
    ["riot2"] = 30,
    ["riot"] = 30,
    ["ripley"] = 40,
    ["rocoto"] = 40,
    ["rogue"] = 500,
    ["romero"] = 40,
    ["rrocket"] = 15,
    ["rubble"] = 40,
    ["ruffian"] = 15,
    ["ruiner2"] = 30,
    ["ruiner3"] = 30,
    ["ruiner"] = 30,
    ["rumpo2"] = 100,
    ["rumpo3"] = 100,
    ["rumpo"] = 100,
    ["ruston"] = 40,
    ["s80"] = 40,
    ["sabregt2"] = 30,
    ["sabregt"] = 30,
    ["sadler2"] = 40,
    ["sadler"] = 40,
    ["sanchez2"] = 15,
    ["sanchez"] = 15,
    ["sanctus"] = 15,
    ["sandking2"] = 50,
    ["sandking"] = 50,
    ["savage"] = 100,
    ["savestra"] = 40,
    ["sc1"] = 40,
    ["scarab2"] = 100,
    ["scarab3"] = 100,
    ["scarab"] = 100,
    ["schafter2"] = 40,
    ["schafter3"] = 40,
    ["schafter4"] = 40,
    ["schafter5"] = 40,
    ["schafter6"] = 40,
    ["schlagen"] = 40,
    ["schwarzer"] = 40,
    ["scorcher"] = 5,
    ["scramjet"] = 40,
    ["scrap"] = 40,
    ["seabreeze"] = 500,
    ["seashark2"] = 35,
    ["seashark3"] = 35,
    ["seashark"] = 35,
    ["seasparrow"] = 100,
    ["seminole"] = 40,
    ["sentinel2"] = 30,
    ["sentinel3"] = 40,
    ["sentinel"] = 30,
    ["serrano"] = 40,
    ["seven70"] = 40,
    ["shamal"] = 500,
    ["sheava"] = 40,
    ["sheriff2"] = 30,
    ["sheriff"] = 30,
    ["shotaro"] = 15,
    ["skylift"] = 100,
    ["slamvan2"] = 30,
    ["slamvan3"] = 30,
    ["slamvan4"] = 30,
    ["slamvan5"] = 30,
    ["slamvan6"] = 30,
    ["slamvan"] = 30,
    ["sovereign"] = 15,
    ["specter2"] = 40,
    ["specter"] = 40,
    ["speeder"] = 35,
    ["speedo2"] = 100,
    ["speedo4"] = 100,
    ["speedo"] = 100,
    ["squalo"] = 35,
    ["stafford"] = 40,
    ["stalion2"] = 30,
    ["stalion"] = 30,
    ["stanier"] = 40,
    ["starling"] = 500,
    ["stinger"] = 40,
    ["stingergt"] = 40,
    ["stockade3"] = 40,
    ["stockade"] = 40,
    ["stratum"] = 40,
    ["streiter"] = 40,
    ["stretch"] = 40,
    ["strikeforce"] = 500,
    ["stromberg"] = 40,
    ["stunt"] = 500,
    ["submersible2"] = 35,
    ["sugoi"] = 40,
    ["sultan2"] = 40,
    ["sultan"] = 40,
    ["sultanrs"] = 40,
    ["suntrap"] = 35,
    ["superd"] = 40,
    ["supervolito2"] = 100,
    ["supervolito"] = 100,
    ["surano"] = 40,
    ["surfer2"] = 100,
    ["surfer"] = 100,
    ["surge"] = 40,
    ["swift2"] = 100,
    ["swift"] = 100,
    ["swinger"] = 40,
    ["t20"] = 40,
    ["taco"] = 100,
    ["tailgater"] = 40,
    ["taipan"] = 40,
    ["tampa2"] = 40,
    ["tampa3"] = 30,
    ["tampa"] = 30,
    ["taxi"] = 30,
    ["technical2"] = 50,
    ["technical3"] = 50,
    ["technical"] = 50,
    ["tempesta"] = 40,
    ["terbyte"] = 40,
    ["tezeract"] = 40,
    ["thrax"] = 40,
    ["thrust"] = 15,
    ["thruster"] = 100,
    ["tiptruck2"] = 40,
    ["tiptruck"] = 40,
    ["titan"] = 500,
    ["torero"] = 40,
    ["tornado2"] = 40,
    ["tornado4"] = 40,
    ["tornado5"] = 40,
    ["tornado6"] = 40,
    ["tornado"] = 40,
    ["toro2"] = 35,
    ["toro"] = 35,
    ["toros"] = 40,
    ["tourbus"] = 30,
    ["towtruck2"] = 40,
    ["towtruck"] = 40,
    ["tractor2"] = 40,
    ["tractor3"] = 40,
    ["tractor"] = 40,
    ["trailerlarge"] = 40,
    ["trailersmall2"] = 100,
    ["trash"] = 30,
    ["tribike2"] = 5,
    ["tribike3"] = 5,
    ["tribike"] = 5,
    ["trophytruck2"] = 50,
    ["trophytruck"] = 50,
    ["tropic"] = 35,
    ["tropos"] = 40,
    ["tug"] = 35,
    ["tula"] = 500,
    ["tulip"] = 30,
    ["turismo2"] = 40,
    ["turismor"] = 40,
    ["tyrant"] = 40,
    ["tyrus"] = 40,
    ["utillitruck2"] = 40,
    ["utillitruck3"] = 40,
    ["utillitruck"] = 40,
    ["vacca"] = 40,
    ["vader"] = 15,
    ["vagner"] = 40,
    ["vagrant"] = 50,
    ["valkyrie2"] = 100,
    ["valkyrie"] = 100,
    ["vamos"] = 30,
    ["velum2"] = 500,
    ["velum"] = 500,
    ["verlierer2"] = 40,
    ["vestra"] = 500,
    ["vigero"] = 30,
    ["vigilante"] = 40,
    ["vindicator"] = 15,
    ["virgo2"] = 30,
    ["virgo3"] = 30,
    ["virgo"] = 30,
    ["viseris"] = 40,
    ["visione"] = 40,
    ["volatol"] = 500,
    ["volatus"] = 100,
    ["voltic2"] = 40,
    ["voltic"] = 40,
    ["voodoo2"] = 30,
    ["voodoo"] = 30,
    ["vortex"] = 15,
    ["vstr"] = 40,
    ["warrener"] = 40,
    ["washington"] = 40,
    ["wastelander"] = 30,
    ["windsor2"] = 30,
    ["windsor"] = 30,
    ["wolfsbane"] = 15,
    ["xa21"] = 40,
    ["xls2"] = 40,
    ["xls"] = 40,
    ["yosemite2"] = 30,
    ["yosemite"] = 30,
    ["youga2"] = 100,
    ["youga"] = 100,
    ["z190"] = 40,
    ["zentorno"] = 40,
    ["zhaba"] = 50,
    ["zion2"] = 30,
    ["zion3"] = 40,
    ["zion"] = 30,
    ["zombiea"] = 15,
    ["zombieb"] = 15,
    ["zorrusso"] = 40,
    ["zr380"] = 40,
    ["zr3802"] = 40,
    ["zr3803"] = 40,
    ["ztype"] = 40,
    ["­diablous"] = 15,
    ["­oracle"] = 30,
}

return config