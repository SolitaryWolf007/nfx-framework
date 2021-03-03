local config = {}

config.active = true

local parts = {
	["Adesivo"] = 10,
	["Mascara"] = 1,
	["Mochila"] = 5,
	["Acessorios"] = 7,
	["Maos"] = 3,
	["Calcas"] = 4,
	["Camisa"] = 8,
	["Sapatos"] = 6,
	["Jaqueta"] = 11,
	["Chapeu"] = "p0",
	["Oculos"] = "p1",
	["Orelhas"] = "p2",
	["Braco Esquerdo"] = "p6",
	["Braco Direito"] = "p7",
	["Colete"] = 9
}

config.skinshops = {
	{ parts,vector3(75.40,-1392.92,29.37) },
	{ parts,vector3(-709.40,-153.66,37.41) },
	{ parts,vector3(-163.20,-302.03,39.73) },
	{ parts,vector3(425.58,-806.23,29.49) },
	{ parts,vector3(-822.34,-1073.49,11.32) },
	{ parts,vector3(-1193.81,-768.49,17.31) },
	{ parts,vector3(-1450.85,-238.15,49.81) },
	{ parts,vector3(4.90,6512.47,31.87) },
	{ parts,vector3(1693.95,4822.67,42.06) },
	{ parts,vector3(126.05,-223.10,54.55) },
	{ parts,vector3(614.26,2761.91,42.08) },
	{ parts,vector3(1196.74,2710.21,38.22) },
	{ parts,vector3(-3170.18,1044.54,20.86) },
	{ parts,vector3(-1101.46,2710.57,19.10) },
}

return config