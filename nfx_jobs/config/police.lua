local config = {}
--==============================================================
-- POLICE
--==============================================================
config.prison_coords = vector3(1680.11,2513.0,45.56)
config.prison_outside = vector3(1850.5,2604.0,45.5)
config.prison_radius = 200.00

config.regcss = [[
	.div_polreg {
		background: rgba(0, 102, 255,0.7);
		color: #d3d3d3;
		bottom: 9%;
		right: 2.2%;
		position: absolute;
		padding: 20px 30px;
		font-family: Arial;
		line-height: 30px;
		letter-spacing: 1.5px;
		border-radius: 5px;
		border-right: 4px solid #000000;
	}
	.div_polreg b {
		color: #ffffff;
		padding: 0 4px 0 0;
	}

	.div_polreg center {
		text-align: center;
	}
]]

return config