local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk")
or Map:find("gm_metro_krl")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")
or Map:find("gm_metropbl")) then 
	return
end

include("shared.lua")
--
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}

--Головная часть 
ENT.ButtonMap["PUU"] = {
    pos = Vector(814.8-159-9, 43, 2.2), --446 -- 14 -- -0,5
    ang = Angle(0,-90,40),
    width = 685,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
			{ID = "!DoorsClosed",x=93, y=30.5, radius=8, tooltip = "",model = {
			model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="DoorsClosed"},
        }},
		
        {ID = "StandToggle",x=213, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
			lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="StandLamp",anim=true,z=0}, 				
            var="Stand",speed=12, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "notused1234",x=183, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=1.85,
            var="Stand123",speed=12, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "notused123",x=123, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=1.85,
            var="Stand123",speed=12, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		    {ID = "!HVoltage",x=147.5+37.83*0.16, y=30.5, radius=8, tooltip = "",model = {
			model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="HVoltage"},
        }},
        {ID = "KAHToggle",x=147.5+37.83*3, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="KAHLamp", anim=true},
            var="KAH",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "ALSToggle",x=147.5+37.83*4, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl", z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="ALSLamp",z=0.1, anim=true},
            var="ALS",speed=8, vmin=0, vmax=0.7, disable="ALSToggle",
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "ALSkToggle",x=127+37.83*4, y=27.5+10, w=40,h=20, tooltip="", model = {
            model = "models/metrostroi_train/81/krishka.mdl", ang = 0, z = 1,
            var="ALSk",speed=8,min=0.32,max=0.721, disable="ALSToggle",
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=70,x=15,y=-40,z=-3.6,var="ALSPl", ID="ALSPl",},
            sndvol = 1, snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
		{ID = "AccelRateSet",x=147.5+37.88*5-7, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=1.85,
            var="AccelRate",speed=8, vmin=0, vmax=0.7,
           -- lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="AccelRateLamp",anim=true},
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "RingSet",x=147.5+37.83*6-10, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=1.85,
            var="Ring",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		/*
        {ID = "FDepotToggle",x=147.5+37.83*5, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=6,
            var="FDepot",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		*/
        {ID = "PassSchemeToggle",x=151.5+37.83*7.5-8, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
           lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="PassSchemeLamp",anim=true},
            var="PassScheme",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		/*
        {ID = "EmergencyCompressorSet",x=148+37.83*9+10, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/buttons/b7.mdl",z=7,
            var="EmergencyCompressor",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		*/
		
        {ID = "notused123456",x=95+37.83*8, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=1.85,
            var="notused123",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		
        {ID = "DisableBVSet",x=156+37.83*8, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=1.85,
            var="DisableBV",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "notused1123",x=490.63, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=1.85,
            --lamp = {model = "models/metrostroi_train/81-722/lamp_yellow.mdl",var="TickerLamp", z=0.1, anim=true},
            var="notused1123",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program2Set",x=579.63+36.5*0, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=1.85,--blue
            var="R_Program2",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_AnnouncerToggle",x=576.63+36.5*2.75, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_blue.mdl",z=2.5,--blue
          --  lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="R_AnnouncerLamp",anim=true, color=Color(50,150,200)},
            var="R_Announcer",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_LineToggle",x=545, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=1.85,--blue
            lamp = {model = "models/metrostroi_train/81-722/lamp_yellow.mdl",var="R_LineLamp",anim=true},
            var="R_Line",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_EmerSet",x=576.63+35.5*1, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",skin =2,z=1.85,--blue
            var="R_Emer",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		/*
        {ID = "R_Program1Set",x=576.63+35.2*4, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/buttons/b5.mdl",z=2.7,--blue
            var="R_Program1",speed=8, vmin=0, vmax=0,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
*/
/*
        {ID = "EnableBVEmerSet",x=52, y=110, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/button_circle2.mdl",z=3,
            var="EnableBVEmer",speed=12, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
	*/	
		{ID = "EmergencyCompressorSet",x=576.63+36.5*1.05, y=90, radius=15, tooltip = "",model = { --566.63+36.5*1
            model = "models/metrostroi_train/81-722/button_white.mdl", z=1.85,
            var="EmergencyCompressor",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmergencyControlsToggle",x=576.63+36.5*2.3, y=90, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl", z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_red.mdl",var="EmergencyControlsLamp",z=0, anim=true},
            var="EmergencyControls",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "WiperToggle",x=579.63+35.75*1.8, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_blue.mdl",z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_blue.mdl",var="WiperLamp", anim=true,z=0},			
            var="Wiper",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "notused12345",x=531, y=95, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=3.85,ang = Angle (0,0,0),
			scale = 0.4,
            var="notused12345",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!VDop",x=269, y=69, w=107, h=6, tooltip = ""},
        {ID = "!VFact",x=269, y=76+9, w=107, h=6, tooltip = ""},
        {ID = "!VPred",x=269, y=76+17, w=107, h=6, tooltip = ""},
		{ID = "!VDop2",x=381, y=65, w=26, h=28, tooltip = ""},
    }
}

ENT.ClientProps["Head0-_--"] = {
    model = "models/metrostroi_train/81-740/body/headlight.mdl", --_-- обозначает положение фары на маске.
    pos = Vector(324.5-159.4-9, 4.8, -55.8),
    ang = Angle(-7,0,0),
    scale = 1.1, 
    nohide=true,
}
ENT.ClientProps["Head--_-0"] = {
    model = "models/metrostroi_train/81-740/body/headlight.mdl",
    pos = Vector(324.5-159.4-9, 86.3, -55.8),
    ang = Angle(-7,0,0),
    scale = 1.1, 
    nohide=true,
}
ENT.ClientProps["Head-0_--"] = {
    model = "models/metrostroi_train/81-740/body/headlight.mdl",
    pos = Vector(324.8-159.4-9, 18.3, -58.2),
    ang = Angle(-7,0,0),
    scale = 1.1, 
    nohide=true,
}
ENT.ClientProps["Head--_0-"] = {
    model = "models/metrostroi_train/81-740/body/headlight.mdl",
    pos = Vector(324.8-159.4-9, 73.4, -58.2),
    ang = Angle(-7,0,0),
    scale = 1.1, 
    nohide=true,
}
	
ENT.ClientProps["krepezh"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(286-8-9,0,-71),
    ang = Angle(0,0,0),
    nohide = true,
}

ENT.ClientProps["salon"] = {
	model = "models/metrostroi_train/81-740/salon/salon.mdl",
	pos = Vector(0-15-9.3,0.2,0),
	ang = Angle(0,0,0),
	hide = 1.5,
}
ENT.ClientProps["handrails"] = {
	model = "models/metrostroi_train/81-740/salon/handrails/handrails.mdl",
	pos = Vector(368-161-9.3,-5,-2),
	ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_off"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off.mdl",
    pos = Vector(-15-9.3,0,0),
    ang = Angle(0,0,0),
    hide=2,
}

--Аварийка
ENT.ClientProps["lamps_salon_on_avar1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(689-159-9.3,-58,-74.15),
    ang = Angle(0,-180,0),
	hide=2,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_avar2"] = { 
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(309-159-9.3,0.6,-74.15),
    ang = Angle(0,-180,0),
	hide=2,
    color = Color(245,238,223),		
}
--Аварийка


ENT.ClientProps["lamps_salon_on1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(689-159-9.3,0.55,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(636-159-9.3,0.55,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(581-159-9.3,0.55,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(527-159-9.3,0.55,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(473-159-9.3,0.55,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(419-159-9.3,0.45,-74.2),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(364-159-9.3,0.55,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(309-159-9.3,0.55,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(255-159-9.3,0.55,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}

ENT.ClientProps["lamps_salon_on_fr1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(689-159-9.3,-58.08,-74.15),
    ang = Angle(0,180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(635-159-9.3,-58.08,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(581-159-9.3,-58.08,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(527-159-9.3,-58.08,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(473-159-9.3,-58.08,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(418.7-159-9.3,-58.08,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(364-159-9.3,-58.08,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(310-159-9.3,-58.08,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(255.9-159-9.3,-58.08,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
local rnd = math.random (0,-10)
ENT.ClientProps["wiper"] = { --дворник от 760
    model = "models/metrostroi_train/81-740/body/81-740_wiper.mdl",
    pos = Vector(176.8-15-9,-10,0),
    ang = Angle(0,0,rnd),
	nohide = true,		
}

ENT.ButtonMap["ALSPANELLAMPS"] = { -- дополнительные лампы АЛС 
	pos = Vector(812-159-9,17.2,-0.01), --446 -- 14 -- -0,5
	ang = Angle(0,-90,40),
	width = 75,
	height = 50,
	scale = 0.0625,
	hideseat=0.2,

        buttons = {
		{ID = "!LN",x=10.8, y=13.7, radius=10, tooltip = "",model = {
            name="LN", lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="LN",z=-3.5, color=Color(120,255,50)},
        }},
		{ID = "!Dnepr",x=28, y=34.1, radius=10, tooltip = "",model = {
            name="Dnepr",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="Dnepr",z=-3.5, color=Color(255,0,0)},
        }},
		{ID = "!XOD",x=28, y=13.7, radius=10, tooltip = "",model = {
            name="XOD",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="XOD",z=-3.5, color=Color(250, 250, 15)},
        }},
		{ID = "!DAU",x=45, y=34.1, radius=10, tooltip = "",model = {
            name="DAU",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="DAU",z=-3.5, color=Color(255,0,0)},
        }},
		{ID = "!AO",x=10.8, y=34.1, radius=10, tooltip = "",model = {
            name="AO",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="AO",z=-3.5, color=Color(255,50,0)},
        }},
		{ID = "!Ispr",x=45, y=13.7, radius=10, tooltip = "",model = {
            name="Ispr",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="Ispr",z=-3.5, color=Color(120,255,50)},
		}},	
		{ID = "!Forw",x=55, y=10, w=18, h=10, tooltip = ""},
        {ID = "!Back",x=55, y=25, w=18, h=10, tooltip = ""},
    }
}
ENT.ButtonMap["PUL"] = {
    pos = Vector(807-159-9, 34.5, -3.1),
    ang = Angle(0,-90,21.5),
    width = 100,
    height = 220,
    scale = 0.0450,
    hideseat=0.2,

    buttons = {
        {ID = "DoorSelectLToggle",x=13, y=65, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-4.8,  --models/metrostroi_train/81-720/buttons/b4.mdl
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorLeftLamp",anim=true},
            var="DoorSelectL",speed=8, vmin=0, vmax=0.6,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DoorSelectRToggle",x=70, y=65, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-4.8,
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorRightLamp",anim=true},
            var="DoorSelectR",speed=8, vmin=0, vmax=0.6,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DoorBlockToggle",x=70, y=130, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=-6,  --models/metrostroi_train/81-720/buttons/b6.mdl
			lamp = {model = "models/metrostroi_train/81-722/lamp_red.mdl",var="DoorBlockLamp",anim=true},
            var="DoorBlock",speed=8, vmin=0, vmax=0.5,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		/*
*/
        {ID = "DoorLeftSet",x=70, y=197, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-5.3,
			lamp = {model ="models/metrostroi_train/81-722/lamp_black.mdl", var ="DoorLeftLamp",anim=true},
				--models/metrostroi_train/81-720/button_circle1.mdl
            var="DoorLeft",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["PUR"] = {
    pos = Vector(806.5-159-9,13.5,-3.3), --446 -- 14 -- -0,5
    ang = Angle(0,-90,22),
    width = 220,
    height = 210,
    scale = 0.0450,
    hideseat=0.2,

    buttons = {
        /*{ID = "AccelRateSet",x=13, y=79.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=-6,
            var="AccelRate",speed=12, vmin=0, vmax=1,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="AccelRateLamp",anim=true},
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},*/		
		{ID = "TPTToggle",x=24, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=-6,
            var="TPT",speed=12, vmin=0, vmax=0.5,
            lamp = {model = "models/metrostroi_train/81-722/lamp_red.mdl",var="TPTLamp",anim=true},
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerBrakeAddSet",x=65.5, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-5.1,  --models/metrostroi_train/81-720/buttons/b2.mdl
            var="EmerBrakeAdd",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerBrakeReleaseSet",x=106, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-5.1,   --models/metrostroi_train/81-720/buttons/b5.mdl
            var="EmerBrakeRelease",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerBrakeToggle",x=149, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-5.1,        --b6
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="EmerBrakeWork",anim = true,color = Color(200,200,200)},
            var="EmerBrake",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmergencyBrakeToggle",x=188, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler2.mdl",z=-10, ang=180,
            var="EmergencyBrake",speed=12, vmin=0, vmax=1,
            sndvol = 0.5, snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DoorCloseToggle",x=21, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=-5.1, --models/metrostroi_train/81-720/buttons/b5.mdl
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",z=0.0,var="DoorCloseLamp",anim=true}, --models/metrostroi_train/81-720/buttons/l1.mdl ,anim=true,color=Color(80,255,100)
            var="DoorClose",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AttentionMessageSet",x=65, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=-5.1,
            var="AttentionMessage",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AttentionSet",x=105, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=-5.1,
            var="Attention",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AttentionBrakeSet",x=148, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=-5.1,  --models/metrostroi_train/81-720/buttons/b6.mdl
            var="AttentionBrake",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "R_Program1Set",x=188, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=-5.1,--blue
            var="R_Program1",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "HornBSet",x=25.5, y=191, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=-5,  --models/metrostroi_train/81-720/button_circle1.mdl
            var="HornB",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DoorRightSet",x=110, y=191, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-5,  --models/metrostroi_train/81-720/button_circle1.mdl
			lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorRightLamp",anim=true},
            var="DoorRight",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["RV"] = {
    pos = Vector(806.4-159-9,52,-4),
    ang = Angle(-1,-90,30),
    width = 60,
    height = 200,
    scale = 0.0450,

    buttons = {
	    {ID = "EmergencyDoorsToggle",x=30, y=15, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=-2.8,  --models/metrostroi_train/81-720/tumbler2.mdl
			lamp = {model ="models/metrostroi_train/81-722/lamp_green.mdl", var="EmergencyDoorsLamp", anim=true},
            var="EmergencyDoors",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerX1Set",x=30, y=125, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-3,
            var="EmerX1",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerX2Set",x=30, y=180, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-3, --models/metrostroi_train/81-720/button_circle3.mdl
            var="EmerX2",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerCloseDoorsSet",x=30, y=70, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-3,
            var="EmerCloseDoors",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["CAMSButtons"] = {
    pos = Vector(807.3-159-9,46.9,-3.72),
    ang = Angle(-1,-90,30),
    width = 100,
    height = 120,
    scale = 0.055,
	hideseat=0.2,

    buttons = {
        {ID = "CAMS7Set",x=39, y=26, w=20,h=20, tooltip = "",model = {
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS7",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS9Set",x=9, y=41, w=20,h=20, tooltip = "",model = { 
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.9,
			var="CAMS9",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS5Set",x=9, y=68, w=20,h=20, tooltip = "",model = { 
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS5",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS10Set",x=70, y=41, w=20,h=20, tooltip = "",model = { 
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS10",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS6Set",x=70, y=68, w=20,h=20, tooltip = "",model = {
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS6",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS8Set",x=39, y=86, w=20,h=20, tooltip = "",model = {
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS8",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["PneumoHelper1"] = {
    pos = Vector(788-159-9,58.5,15.2),
    ang = Angle(0,0,92),
    width = 70,
    height = 76,
    scale = 0.0625,
    buttons = {
        {ID = "!BrakeCylinder",x=35, y=38, radius=38, tooltip = ""},
    }
}
ENT.ButtonMap["PneumoHelper2"] = {
    pos = Vector(788-159-9,58.2,22.3),
    ang = Angle(0,0,92),
    width = 70,
    height = 76,
    scale = 0.0625,
    buttons = {
        {ID = "!BrakeTrainLine",x=35, y=38, radius=38, tooltip = ""},
    }
}

--Вольтаж
ENT.ButtonMap["VoltHelper2"] = {
    pos = Vector(817-159-9,50.7,22),
    ang = Angle(0,-90,108),
    width = 60,
    height = 118,
    scale = 0.0625,

    buttons = {
        {ID = "!HV",x=0, y=0, w=60, h=50, tooltip = ""},
        {ID = "!I1_3",x=0, y=64, w=60, h=50, tooltip = ""},
    }
}

--ИГЛА
ENT.ButtonMap["IGLA_C"] = {
    pos = Vector(735.85-159-9,34.1,44.6),
    ang = Angle(0,90,90),
    width = 512,
    height = 107,
    scale = 0.0171,
    hideseat=0.8,
    hide=true,
}
ENT.ButtonMap["IGLAButtons_C"] = {
    pos = Vector(735.85-159-9,34,45.71),
    ang = Angle(0,90,90),
    width = 147,
    height = 75,
    scale = 0.0625,
    hideseat=0.2,
    buttons = {
        {ID = "IGLA1Set",x=22+32.5*-0.18,y=58,w=14,h=12,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod1.mdl",var="IGLA:ButtonL1",scale = 1,color=Color(175,250,20),x=0.5,y=-2.5,z=-2.5},
        }},
        {ID = "IGLA2Set",x=23+32.5*0.89,y=58,w=14,h=12,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod1.mdl",var="IGLA:ButtonL2",scale = 1,color=Color(175,250,20),x=-2.5,y=-2.7,z=-2.5},
        }},
        {ID = "IGLA23",x=65,y=58,w=14,h=12,tooltip=""},
        {ID = "IGLA3Set",x=80,y=58,w=14,h=12,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod1.mdl",var="IGLA:ButtonL3",scale = 1,color=Color(175,250,20),x=1,y=-2.7,z=-2.5},
        }},
        {ID = "IGLA4Set",x=15+32.5*3,y=58, w=14,h=12,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod1.mdl",var="IGLA:ButtonL4",scale = 1,color=Color(175,250,20),x=1,y=-2.7,z=-2.5},
        }},
        {ID = "!IGLAFire",x=136,y=62,radius=3,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="IGLA:Fire",scale = 0.95,color=Color(255,56,30),z=-2.5,ang=0,},
        }},
        {ID = "!IGLAErr",x=136,y=69.1,radius=3,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="IGLA:Error",scale = 0.95,color=Color(255,168,000),z=-2.5,ang=0},
        }},
    }
}
ENT.ButtonMap["Tickers"] = {
    pos = Vector(162.8-159-9,-27.2,66.45), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 1024,
    height = 64,
    scale = 0.055,
    hide=true,
    hideseat=1,
}
ENT.ButtonMap["BackVent"] = {
    pos = Vector(735.25-158.7-9,27,47), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 80,
    height = 110,
    scale = 0.0625,
    hide=0.8,

    buttons = {
    {ID = "!VentCondMode",x=36, y=35, radius=0, model = {
        model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=10,ang=-91,
        sndvol = 0.8, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0), scale = 0.9,
        getfunc = function(ent) return ent:GetPackedRatio("VentCondMode") end,var="VentCondMode",
        speed=4, min=0.76,max=0.0
    }},
    {ID = "VentCondMode-",x=11,y=14,w=30,h=40,tooltip=""},
    {ID = "VentCondMode+",x=30,y=14,w=30,h=40,tooltip=""},
    {ID = "!VentStrengthMode",x=36, y=83, radius=0, model = {
        model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=10,ang=-91,
        sndvol = 0.8, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0), scale = 0.9,
        getfunc = function(ent) return ent:GetPackedRatio("VentStrengthMode") end,var="VentStrengthMode",
        speed=4, min=0.76,max=0.0
    }},
    {ID = "VentStrengthMode-",x=11,y=63,w=30,h=40,tooltip=""},
    {ID = "VentStrengthMode+",x=30,y=63,w=30,h=40,tooltip=""},
    }
}

ENT.ButtonMap["BackPPZ"] = {
    pos = Vector(735.52-159-9,22,35), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 400,
    height = 310,
    scale = 0.0625,
    hideseat=0.8,
    hide=true,
	
	buttons = {
        {ID = "SF1Toggle",x=61.5+0*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF2Toggle",x=61.5+1*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF3Toggle",x=61.5+2*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF4Toggle",x=61.5+3*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF5Toggle",x=61.5+4*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF6Toggle",x=61.5+5*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF7Toggle",x=61.5+6*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF8Toggle",x=61.5+7*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF9Toggle",x=61.5+8*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF10Toggle",x=61.5+9*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF11Toggle",x=61.5+10*28.8, y=73, w=20,h=40, tooltip = ""},

        {ID = "SF12Toggle",x=61.5+0*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF13Toggle",x=61.5+1*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF14Toggle",x=61.5+2*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF15Toggle",x=61.5+3*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF16Toggle",x=61.5+4*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF17Toggle",x=61.5+5*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF18Toggle",x=61.5+6*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF19Toggle",x=61.5+7*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF20Toggle",x=61.5+8*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF21Toggle",x=61.5+9*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF22Toggle",x=61.5+10*28.8, y=205, w=20,h=40, tooltip = ""},
    }
}

for k,buttbl in ipairs(ENT.ButtonMap["BackPPZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-18, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "switch2_on" or "switch2_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end
ENT.ButtonMap["PVZ"] = {
    pos = Vector(700.52-159-9,60,32.2), --446 -- 14 -- -0,5
    ang = Angle(0,0,94),
    width = 330,
    height = 160,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "SFV1Toggle",x=0*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV2Toggle",x=1*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV3Toggle",x=2*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV4Toggle",x=3*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV5Toggle",x=4*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV6Toggle",x=5*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV7Toggle",x=6*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV8Toggle",x=7*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV9Toggle",x=8*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV10Toggle",x=9*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV11Toggle",x=10*30, y=0, w=30,h=50, tooltip = ""},

        {ID = "SFV12Toggle",x=0*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV13Toggle",x=1*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV14Toggle",x=2*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV15Toggle",x=3*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV16Toggle",x=4*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV17Toggle",x=5*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV18Toggle",x=6*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV19Toggle",x=7*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV20Toggle",x=8*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV21Toggle",x=9*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV22Toggle",x=10*30, y=55, w=30,h=50, tooltip = ""},

		{ID = "SFV23Toggle",x=0*30, y=110, w=30,h=50, tooltip = "",},	
        {ID = "SFV24Toggle",x=1*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV25Toggle",x=2*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV26Toggle",x=3*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV27Toggle",x=4*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV28Toggle",x=5*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV29Toggle",x=6*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV30Toggle",x=7*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV31Toggle",x=8*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV32Toggle",x=9*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV33Toggle",x=10*30, y=110, w=30,h=50, tooltip = "",},		
    }
}
for k,buttbl in ipairs(ENT.ButtonMap["PVZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-17, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end

ENT.ButtonMap["BackDown"] = {
    pos = Vector(735.52-159-9,23,12), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 400,
    height = 350,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "Pant1Toggle",x=85, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Pant1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Pant2Toggle",x=120, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Pant2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vent2Toggle",x=158+30, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",z=-2.6, ang=180,
            var="Vent2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "PassLightToggle",x=222, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="PassLight",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CabLightToggle",x=260, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="CabLight",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Headlights1Toggle",x=290, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Headlights1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Headlights2Toggle",x=330, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Headlights2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "ParkingBrakeToggle",x=81, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="ParkingBrake",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "TorecDoorsToggle",x=115, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="TorecDoors",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "BBERToggle",x=152, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="BBER",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "BBEToggle",x=183, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="BBE",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CompressorToggle",x=210, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Compressor",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CabLightStrengthToggle",x=250, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="CabLightStrength",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AppLights1Toggle",x=290, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="AppLights1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AppLights2Toggle",x=335, y=118, radius=12, tooltip = "", model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="AppLights2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_ppz_on_new" or "switch_ppz_off_new" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!BARSBlock",x=214, y=190, radius=0, model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=12,
            getfunc = function(ent) return ent:GetPackedRatio("BARSBlock") end,var="BARSBlock",
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=-90,x=-16,y=36,z=-5,var="BARSBlockPl", ID="BARSBlockPl",},
            speed=6, min=0.5,max=0.15,
            sndvol = 1, snd = function(_,val) return val==3 and "switch_batt_on" or val == 0 and "switch_batt_off" or "switch_batt" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "BARSBlock-",x=188,y=172,w=30,h=40,tooltip="",model={
            plomb = {var="BARSBlockPl", ID="BARSBlockPl", },
        }},
        {ID = "BARSBlock+",x=212,y=172,w=30,h=40,tooltip="", model={
            plomb = {var="BARSBlockPl", ID="BARSBlockPl", },
        }},
        {ID = "BatteryToggle",x=334, y=190, radius=20, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=12, ang=45,
            var="Battery",speed=2,
            sndvol = 1, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            vmin=0.15, vmax=0
        }},
        {ID = "ALSFreqBlockToggle",x=334, y=294, radius=12, tooltip = "", model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=4, ang=180, scale = 0.5,
            var="ALSFreqBlock",speed=12,min = 0.6, max = 0.9,
            sndvol = 0.5, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["CraneCap2"] = {
    pos = Vector(788.12-159.3-9,-4.5,-20.2),
    ang = Angle(0,-90,31),
    width = 120,
    height = 25,
    scale = 0.0625,
    hideseat=0.2,
    buttons = { --
        {ID = "ABSDToggle",x=10, y=10, radius=12, tooltip = "nolang_АБСД: Аварийная блокировка сигнализатора давления", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-6,
            var="ABSD",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=-90,x=-1,y=24,z=0,var="ABSDPl",ID="ABSDPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},	
        {ID = "RTEToggle",x=100, y=10, radius=12, tooltip = "nolang_РТЭ: Резервный тормоз экстренный", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-6,
            var="RTE",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=-90,x=-1,y=24,z=0,var="RTEPl",ID="RTEPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["VityazButtons"] = {
    pos = Vector(806.12-159.3-9,-4.5,-4.2),
    ang = Angle(0,-90,31),
    width = 120,
    height = 90,
    scale = 0.0625,
    hideseat=0.2,
    buttons = {
		{ID = "VityazF4Set",x=1, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f1.mdl",z=0, ang=0,var="VityazF1",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, --sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazPVUSet",x=20, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f1.mdl",z=0, ang=0,var="VityazF1",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, --sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazVOSet",x=1, y=13, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f2.mdl",z=0, ang=0,var="VityazF2",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, --sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazCurrentSet",x=1, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f3.mdl",z=0, ang=0,var="VityazF3",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazSOTSet",x=20, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f3.mdl",z=0, ang=0,var="VityazF3",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF2Set",x=1, y=47, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_f4.mdl",z=0, ang=0,var="VityazF4",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazNumSet",x=20, y=47, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_f4.mdl",z=0, ang=0,var="VityazF4",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz1Set",x=40, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_1.mdl",z=0, ang=0, var="Vityaz1",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz4Set",x=40, y=13, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_4.mdl",z=0, ang=0, var="Vityaz4",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz7Set",x=40, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_7.mdl",z=0, ang=0, var="Vityaz7",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz2Set",x=58, y=-4, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_2.mdl",z=0, ang=0, var="Vityaz2",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazTSet",x=20, y=13, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_2.mdl",z=0, ang=0, var="Vityaz2",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz5Set",x=58, y=13, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_5.mdl",z=0, ang=0, var="Vityaz5",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz8Set",x=58, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_8.mdl",z=0, ang=0, var="Vityaz8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz0Set",x=58, y=47, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_0.mdl",z=0, ang=0, var="Vityaz0",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz3Set",x=76, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_3.mdl",z=0, ang=0, var="Vityaz3",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz6Set",x=76, y=13, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_6.mdl",z=0, ang=0, var="Vityaz6",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz9Set",x=76, y=30, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_9.mdl",z=0, ang=0, var="Vityaz9",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, --sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF5Set",x=40, y=47, w=20,h=20, tooltip = "",model = {
          --  model = "models/metrostroi_train/81-720/vyitaz/v_f5.mdl",z=0, ang=0, var="VityazF5",speed=16,
			sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF6Set",x=96, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f6.mdl",z=0, ang=0, var="VityazF6",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF7Set",x=96, y=13, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f7.mdl",z=0, ang=0, var="VityazF7",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazNextSet",x=96, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f7.mdl",z=0, ang=0, var="VityazF7",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazBackSet",x=96, y=47, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF9Set",x=76, y=47, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f9.mdl",z=0, ang=0, var="VityazF9",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazF8Set",x=80, y=68, w=35,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazUTVSet",x=1, y=68, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazTV1Set",x=20, y=68, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazTV2Set",x=40, y=68, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazNothSet",x=60, y=68, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["BTO"] = {
    pos = Vector(775.12-144-9,-21,-44), --446 -- 14 -- -0,5
    ang = Angle(0,0,0),
    width = 224,
    height = 50,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "K29Toggle", x=24,  y=26, radius=75, tooltip="", model = {
            model = "models/metrostroi_train/81-720/720_cran.mdl", ang=-90,
            var="K29",speed=4, max=0.28
        }},
        {ID = "UAVAToggle", x=24+200,  y=26, radius=75, tooltip="", model = {
            model = "models/metrostroi_train/81-720/720_cran.mdl", ang=-90,
            plomb = {var="UAVAPl", ID="UAVAPl", },
            var="UAVA",speed=4, max=0.28
        }},
    }
}

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(835-160-8-9,-35.0,-44),
    ang = Angle(0,90,90),
    width = 700,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=0, y=0, w=300, h=100, tooltip=""},
        {ID = "FrontTrainLineIsolationToggle",x=400, y=0, w=300, h=100, tooltip=""},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(835-159-9, -17, -53.9),
    ang = Angle(30,-90,0),
	scale = 0.8,
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(835-159-9, 17, -53.9),
    ang = Angle( -30,-90,0),
	scale = 0.8,
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,2,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,2,1,50,1e3,Angle(-90,0,0)}}

--Головная часть
ENT.ButtonMap["CabinDoorL"] = {
    pos = Vector(750-168-9,59.6,55),
    ang = Angle(0,00,94),
    width = 900,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorLeft",x=0,y=0,w=900,h=2000, tooltip="", model = {
            var="CabinDoorLeft",sndid="door_cab_l",
            sndvol = 0.1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["CabinDoorL2"] = {
    pos = Vector(790-163-9,60,55),
    ang = Angle(0,180,86),
    width = 900,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorLeft",x=0,y=0,w=900,h=2000, tooltip="", model = {
            var="CabinDoorLeft",sndid="door_cab_l",
            sndvol = 0.1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["CabinDoorR"] = {
    pos = Vector(790-163-9,-59.5,52),
    ang = Angle(0,180,94),
    width = 900,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorRight",x=0,y=0,w=900,h=2000, tooltip="", model = {
            var="CabinDoorRight",sndid="door_cab_r",
            sndvol = 0.1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["CabinDoorR2"] = {
    pos = Vector(750-168-9,-60,52),
    ang = Angle(0,0,86),
    width = 900,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorRight",x=0,y=0,w=900,h=2000, tooltip="", model = {
            var="CabinDoorRight",sndid="door_cab_r",
            sndvol = 0.1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ClientProps["lamp_f"] = {
    model = "models/metrostroi_train/81-720/lamp_revers_up.mdl",
    pos = Vector(333.75-159-9,5.68,21.15),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["lamp_b"] = {
    model = "models/metrostroi_train/81-720/lamp_revers_down.mdl",
    pos = Vector(333.6-159-9,5.68,21.15),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["fireextinguisher"] = {
    model = "models/metrostroi_train/81-502/fireextinguisher.mdl", scale=0.9,
    pos = Vector(446-159-9,30.1, -0.6),
    ang = Angle(0,0,0),
    hideseat = 0.8,
}
ENT.ClientProps["fireextinguisher2"] = {
    model = "models/metrostroi_train/81-502/fireextinguisher.mdl", scale=0.9,
    pos = Vector(1050.8-159-9,-220.5, -0.6),
    ang = Angle(0,140,0),
    hideseat = 0.8,
}
--1st april cabin bucket
if os.date( "%m-%d" ) == "04-01" then
ENT.ClientProps["april_bucket"] = {
    model = "models/props_junk/metalbucket01a.mdl",
    pos = Vector(810.8-159-9,-45.5, -39.6),
    ang = Angle(0,140,0),
    hide = 1,
}
print("happy bucket day!")
end
ENT.ClientProps["AntennaProp"] = {
    model = "models/metrostroi_train/81-740/body/antenna/antenna.mdl",
    pos = Vector(234.25-15-9,21.3,-124.5),
    ang = Angle(-6,0,0),
    nohide = true,
}
ENT.ClientProps["PasswordProp"] = {
    model = "models/metrostroi_train/81-740/cabine/password.mdl",
    pos = Vector(672.3-15-9,-6,3.4),
    ang = Angle(90,180,33),
	scale = 1,	
    hide = 1,
}
---Segments
ENT.ClientProps["speed1"] = {
    model = "models/metrostroi_train/81-720/digits/digit.mdl",
    pos = Vector(810.9-159-9, 17.1+1.495, -0.98),
    ang = Angle(140,0,0),
    color = Color(20,255,50),
    hideseat = 0.2,
}
ENT.ClientProps["speed2"] = {
    model = "models/metrostroi_train/81-720/digits/digit.mdl",
    pos = Vector(810.9-159-9, 18, -0.98),
    ang = Angle(140,0,0),
    color = Color(20,255,50),
    hideseat = 0.2,
}

for i=1,5 do
    ENT.ClientProps["speeddop"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_red.mdl",
        pos = Vector(205.3-15-9, 1.305*(i-1)+3, 102.58),
        ang = Angle(10,0,0.2),
        skin = 0,
        color = Color(255,55,55),
        scale = 0.99,		
        hideseat = 0.8,
    }
    ENT.ClientProps["speedfact"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_green.mdl",
        pos = Vector(344.58-159-9, -1.305*(i-1)+2.95, 103.72),
        ang = Angle(10,0,-0.2),
        skin = 0,
        color = Color(90,255,80),
        hideseat = 0.8,
    }
    ENT.ClientProps["speedrek"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_yellow.mdl",
        pos = Vector(344.420-159-9, 1.32*(i-1)+2.75, 103.47),
        ang = Angle(10,0,0.3),
        skin = 0,
        color = Color(255,255,60),
        hideseat = 0.8,
    }
end
ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/equipment/arrow_nm.mdl",
    pos = Vector(790.33-159-9, 58.98, 12.90),
    ang = Angle(-45.000000,0.000000,-270.000000),
    hideseat = 0.2,
}
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/equipment/arrow_nm.mdl",
    pos = Vector(790.33-159-9,58.57,20.10),
    ang = Angle(-40.000000,0.000000,-270.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/equipment/arrow_tm.mdl",
    pos = Vector(790.33-159-9, 58.54, 20.10),
    ang = Angle(-40.000000,0.000000,-270.000000),
    hideseat = 0.2,
}
--Вольтаж
ENT.ClientProps["volt_hv"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(817.57-159-9,48.90,19.8),
    ang = Angle(37.156513,-80,108),
    hideseat = 0.2,
	scale = 1,
}
ENT.ClientProps["volt_rail_case"] = {
    model = "models/metrostroi_train/81-740/cabine/electric/voltm.mdl",
    pos = Vector(817.4-159-9,47.9,21),
    ang = Angle(-16.8,0,0),
    hideseat = 0.2,
}

ENT.ClientProps["amp_i13"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(818.7-159-9,48.90,15.8),
    ang = Angle(40.156513,-71.4,108.8),
    hideseat = 0.2,
	scale = 1,	
}
ENT.ClientProps["amp_engine_case"] = {
    model = "models/metrostroi_train/81-740/cabine/electric/amperm.mdl",
    pos = Vector(818.6-159-9,47.9,17),
    ang = Angle(-16.3,-0.5,0),
    hideseat = 0.2,
}
ENT.ClientProps["PPZpanel"] = {
    model = "models/metrostroi_train/81-740/cabine/electric/paneltex.mdl",
    pos = Vector(735.5-159-9,50,50),
    ang = Angle(180,270,0),
    scale = 1,
	hide = 2,
}
ENT.ClientProps["PPZpanel_IGLA"] = {
    model = "models/metrostroi_train/81-740/cabine/electric/IGLA.mdl",
    pos = Vector(735.4-159-9,38,40.5),
    ang = Angle(0,180,0),
    scale = 1,
    hide = 2,
}
ENT.ClientProps["manometresp"] = {
    model = "models/metrostroi_train/81-740/cabine/monometres.mdl",
    pos = Vector(792-159-9,58.3,15),
    ang = Angle(0,0,2),
    scale = 1,
    hide = 1,
}
ENT.ClientProps["vityazpanel"] = {
    model = "models/metrostroi_train/81-740/cabine/cralix/vityazpanel.mdl",
    pos = Vector(465-159-9,1.5,0),
    ang = Angle(0,0,0),
    scale = 1,
    hide = 1,
}
ENT.ClientProps["redlights740up1"] = {
    model = "models/metrostroi_train/81-740/body/cralix/headlights81-740up.mdl",
    pos = Vector(464.2-159-9,0.6,-0.7),
    ang = Angle(0,0,0),
    scale = 1.01,
    nohide=true,
}
ENT.ClientProps["redlights740up2"] = {
    model = "models/metrostroi_train/81-740/body/cralix/headlights81-740up.mdl",
    pos = Vector(464.2-159-9,-79.4,-0.7),
    ang = Angle(0,0,0),
    scale = 1.01,
    nohide=true,
}
ENT.ClientProps["redlights740down1"] = {
    model = "models/metrostroi_train/81-740/body/cralix/headlights81-740down.mdl",
    pos = Vector(468-159.8-9,0.6,0,0),
    ang = Angle(0,0,0),
    scale = 1,
    nohide=true,
}
ENT.ClientProps["redlights740down2"] = {
    model = "models/metrostroi_train/81-740/body/cralix/headlights81-740down.mdl",
    pos = Vector(468-159.99-9,-82.4,-1.5),
    ang = Angle(-0.2,0,0),
    scale = 1,
    nohide=true,
}
ENT.ClientProps["EmergencyBrakeValve"] = {
	model = "models/metrostroi_train/81-740/cabine/StopKran.mdl",
	pos = Vector(1197-159-9,-58.8,2),
	ang = Angle(0,180,2),
	hide = 2,
}

ENT.ButtonMap["EmergencyBrake1"] = {
    pos = Vector(635-9,-59.7,14),
    ang = Angle(0,180,90),
    width = 70,
    height = 600,
    scale = 0.1,
    buttons = {
        {ID = "EmerBrakeCrane1Toggle",x=0, y=0, w= 70,h = 600, tooltip = "Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай \n Дёргай",model = {
            model = "models/metrostroi_train/81-717/stop_mvm.mdl",
            pos = Vector(55,10,0),ang = Angle(-90,0,0),
            var="EmerBrakeCrane1",speed=1.5, vmin=0, vmax=0.25,
            --sndvol = 0.8, snd = function(_,val) return val == 1 and "valve_brake_open" or val == 2 and "valve_brake" or val == 0 and "valve_brake_close" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["GV"] = {
    pos = Vector(222-16-9,51.5,-80),
    ang = Angle(0,90,-90),
    width = 70,
    height = 70,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 70,h = 70, tooltip="", model = {
            var="GV",sndid = "gv_wrench",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
        }},
    }
}
ENT.ClientProps["gv"] = {
    model = "models/metrostroi/81-717/gv.mdl",
    pos = Vector(366-160-9,55,-76),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
    hideseat = 0.2,
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,90,-90),
    hideseat = 0.2,
}
ENT.ClientProps["door_cab_m"] = {
    model = "", --models/metrostroi_train/81-720/720_door_cab.mdl
    pos = Vector(374.9-159-9,-45.5+25.5,-12.3),
    ang = Angle(0,-90-1,0)
}
ENT.ClientProps["door_cab_o"] = {
    model = "", --models/metrostroi_train/81-720/720_cab_otsek.mdl
    pos = Vector(374.9-159-9,26,-15),
    ang = Angle(0,-90+0.45,-0.15)
}
ENT.ClientProps["KRO"] = {
    model = "models/metrostroi_train/81-740/cabine/pult/tum_r.mdl",
    pos = Vector(805.2-159-9,48.2,-4.8),
    ang = Angle(150,0,180),
    hideseat = 0.2,
}
ENT.ClientProps["KRR"] = {
    model = "models/metrostroi_train/81-740/cabine/pult/tum_r_rad.mdl",
    pos = Vector(802-159-9,48.2,-6.7),
    ang = Angle(150,0,180),
    hideseat = 0.2,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-720/720_kv.mdl",
    pos = Vector(796.4-159-9,24.2,-6.4),
    ang = Angle(0.000000,-90.000000,23.699429),
    hideseat = 0.2,
	scale = 0.8,
}
ENT.ClientPropsInitialized = false
ENT.ClientProps["km013"] = {
    model = "models/metrostroi_train/81-720/720_km013.mdl",
    pos = Vector(780-159-9,-8,-25.3),
    ang = Angle(180,90,-110),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"km013",function(ent,_,var) return "br_013" end,1,1,50,1e3,Angle(-90,0,0)})

ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(810.138672-159-9,35.572510,-30),
    ang = Angle(0,-90,0),
    hideseat = 0.2,
}
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,30,1e3,Angle(-90,0,0)})

ENT.ClientProps["Pult"] = {
	model = "models/metrostroi_train/81-740/cabine/Pult/pult.mdl",
	pos = Vector(465.4-159-9, 6, 0),
	ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["bucik_old"] = {
	model = "models/metrostroi_train/81-740/cabine/Pult/bucik.mdl",
	pos = Vector(465.4-159-9, 6, 0),
	ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["door_cab_r"] = {
	model = "models/metrostroi_train/81-740/cabine/cabin_right.mdl",
	pos = Vector(766-159.8-9, -65.9,0),
	ang = Angle(0,90,0.55),
	scale = 1.001,		
	hide = 1,
}
ENT.ClientProps["door_cab_l"] = {
	model = "models/metrostroi_train/81-740/cabine/cabin_left.mdl",
	pos = Vector(765-159.45-9, 62.9, 0),
	ang = Angle(0,-90,0.25),
	scale = 1.01,
	hide = 1,
}

--Модели 2023.
ENT.ClientProps["Zavod_table_front"] = { --Заводская табличка
    model = "models/metrostroi_train/81-740/salon/zavod.mdl",
	pos = Vector(543.2-15-9,15,60),
    ang = Angle(90,-180,0),
	hide = 1,
	scale = 3,	
}
ENT.ClientProps["ASNP_test"] = {
	model = "models/740_vrb/vrb_asnp.mdl",
	pos = Vector(682.5-15-9,-52.8,-11), --684.5-15,-56,-11
	ang = Angle(0,-90,0), --0,-105,0 
	hideseat=0.8,
}
ENT.ButtonMap["ASNPScreen"] = {
    pos = Vector(658.63-9,-52.1,-6.1), --446 -- 14 -- -0,5 
    ang = Angle(0,-152.3,90),
    width = 520,
    height = 125,
    scale = 0.01,
    hide=0.8,
}
ENT.ButtonMap["ASNP"] = {
    pos = Vector(660.8-9,-51,-6.1), --446 -- 14 -- -0,5
    ang = Angle(0,-152.3,90),
    width = 120,
    height = 50,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "R_ASNPMenuSet",x=39, y=35, radius=16, z=4, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl", scale=0,
            var="R_ASNPMenu",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPUpSet",x=105, y=2, radius=8, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl", scale=0,
            var="R_ASNPUp",speed=12, vmin=0, vmax=0.9,z=4, 
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button2_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPDownSet",x=105, y=14, radius=8, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl", scale=0,
            var="R_ASNPDown",speed=12, vmin=0, vmax=0.9,z=4, 
            sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPOnToggle",x=10, y=10, radius=8, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler2.mdl", ang=0, scale=0.7,z=1.5,
            var="R_ASNPOn",speed=12, vmin=1, vmax=0,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=90,x=-0.5,z=2,y=-12,scale=0.7,var="R_ASNPOnPl",ID="R_ASNPOnPl",},	
            sndvol = 0.5,snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ClientProps["Gerb_msk"] = {
	model = "models/metrostroi_train/81-740/body/gerb.mdl",
	pos = Vector(565-15-9,63.9,35),
	ang = Angle(0,0,-86.8),
	nohide = true,
	scale = 3,
}
ENT.ClientProps["Gerb_msk_right"] = {
	model = "models/metrostroi_train/81-740/body/gerb.mdl",
	pos = Vector(565-15-9,-62.9,36),
	ang = Angle(0,180,-86.8),
	nohide = true,
	scale = 3,
}

ENT.ClientProps["Gerb_msk1"] = {
	model = "models/metrostroi_train/81-740/body/gerb.mdl",
	pos = Vector(565-15-9,63.9,35),
	ang = Angle(0,0,-86.8),
	nohide = true,
	scale = 3,
}
ENT.ClientProps["Gerb_msk_right1"] = {
	model = "models/metrostroi_train/81-740/body/gerb.mdl",
	pos = Vector(565-15-9,-62.9,36),
	ang = Angle(0,180,-86.8),
	nohide = true,
	scale = 3,
}

ENT.ClientProps["Naddver_off"] = {
	model = "models/metrostroi_train/81-740/salon/naddverka_off.mdl",
	pos = Vector(314.75-15-9,37.38,58.1),
	ang = Angle(0,0,0),
	scale = 1,	
	nohide = true,
}
ENT.ButtonMap["Antenna"] = {
    pos = Vector(835-161-9,-7.5,-19.5),
    ang = Angle(0,90,84),
    width = 240,
    height = 150,
    scale = 0.0625,
    hideseat=0.2,
	
	buttons = {
        {ID = "Antenna",x=0,y=0,w=240,h=150,tooltip="",},
    }
}
ENT.ButtonMap["Password"] = {
    pos = Vector(672.25-15-9,-6,4.2),
    ang = Angle(0,-123,90),
    width = 50,
    height = 25,
    scale = 0.0625,
    hideseat=0.2,
	
	buttons = {
        {ID = "Password",x=0,y=0,w=50,h=25	,tooltip="",},
    }
}

local yventpos = {
    414.5+0*117-159-28,
	414.5+2*117+5-159,
	214.5+4*117+0.5-15-144,
}

ENT.ButtonMap["CAMS"] = {
    pos = Vector(809.1-159-9.11,52.37,10.58),
    ang = Angle(0,-57.7,90),
    width = 0,
    height = 0,
    scale = 0.012,
	system = "CAMS",
	hide=0.5,
}
ENT.ButtonMap["Vityaz"] = {
	pos = Vector(658-9, -4.7, 12.1),
    ang = Angle(0,-122.4,90),
    width = 0,
    height = 0,
    scale = 0.0125,    
	hide=0.5,
}

 ENT.Lights = {
    [1] = { "headlight",	Vector(690-15-9,0,-35), Angle(0,0,0), Color(216,161,92), farz=5144,brightness = 4, hfov=105,vfov=105, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true}, --Фары 
    [2] = { "headlight",    Vector(968-159-9,0,50), Angle(-1,0,0), Color(255,0,0), fov=170 ,brightness = 0.3, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true}, --Красные фары 
    [3] = { "headlight",    Vector(358-159-9,40,43.9), Angle(50,40,-0), Color(206,135,80), fov=100,farz=200,brightness = 0,shadows=1}, --отсеки
}
function ENT:Initialize()

    self.BaseClass.Initialize(self)
	self.DoorsAnims = {}
	for i = 1,8 do
		self.DoorsAnims[i] = self:GetNW2Int("DoorsAnim"..i,15)
	end

	self.BaseClass.Initialize(self)
	self.Vityaz = self:CreateRT("740Vityaz",800,600)
	self.ASNP = self:CreateRT("740ASNP",512,128)
	self.IGLA = self:CreateRT("740IGLA",512,128)
    self.Tickers = self:CreateRT("740Ticker",1024,64)
    render.PushRenderTarget(self.Tickers,0,0,1024, 64)
    render.Clear(0, 0, 0, 0)
    render.PopRenderTarget()
	self.CAMS = self:CreateRT("740CAMS",1024,768)
    self.ReleasedPdT = 0
    self.CraneRamp = 0
    self.CraneRRamp = 0
	
	self.HeadLightBroken1 = false
	self.HeadLightBroken2 = false
	self.HeadLightBroken3 = false
	self.HeadLightBroken4 = false
	
	self.RedLightBroken1 = false
	self.RedLightBroken2 = false
	self.RedLightBroken3 = false
	self.RedLightBroken4 = false	
	
	self.EmergencyValveRamp = 0
	self.StopKranValveRamp = 0
	self.EmergencyValveEPKRamp = 0
	self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.ParkingBrake = 0

    self.PreviousRingState = false

    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,4 do
        self.VentRand[i] = math.Rand(0.5,2)
        self.VentState[i] = 0
        self.VentVol[i] = 0
    end
	
	self.FrontBogey = self:GetNW2Entity("FrontBogey")	
	self.MiddleBogey = self:GetNW2Entity("MiddleBogey")	
	self.RearBogey = self:GetNW2Entity("RearBogey")		
	
end	
	
local Cpos = {
    0,0.24,0.5,0.55,0.6,1
}

local function GetDoorPosition(n,G,j)
	if j == 0 		--Правые двери			--Левые двери
	then return Vector(651.5-15-9  - 35.0*G     -  338.8*n-144, -67.5*(1-2*G), 4.3)
	else return Vector(651.5-15-9  - 35.0*(1-G) -  338.8*n-144, -66*(1-2*G), 4.25)
	end
end 

for n=0,1 do
    for G=0,1 do
        ENT.ClientProps["door"..n.."x"..G.."a"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl",
			pos = GetDoorPosition(n,G,0),
			ang = Angle(0,90 +180*G,0),
			scale = 1.001,			
			hide = 2,
		}
		ENT.ClientProps["door"..n.."x"..G.."b"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl",
			pos = GetDoorPosition(n,G,1),
			ang = Angle(0,90 +180*G,0),
			scale = 1.001,			
			hide = 2,				
		}
    end
end

if Metrostroi.Version >= 1537278077 then
function ENT:ReInitBogeySounds(bogey)
	if not IsValid(bogey) then return end
	
	local MotorType = self:GetNW2Int("MotorType")	

    -- Bogey-related sounds
    bogey.SoundNames = {}
    bogey.EngineSNDConfig = {}
    
	if self:GetNW2Int("MotorType")==1 then		
	bogey.MotorSoundType = bogey:GetNWInt("MotorSoundType",1)
    for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end
    table.insert(bogey.EngineSNDConfig,{"ted1_740" ,08,00,16,  1})--40
    table.insert(bogey.EngineSNDConfig,{"ted2_740" ,16,08-4,24,1})--35
    table.insert(bogey.EngineSNDConfig,{"ted3_740" ,24,16-4,32,1})--32
    table.insert(bogey.EngineSNDConfig,{"ted4_740" ,32,24-4,40,1})--28
    table.insert(bogey.EngineSNDConfig,{"ted5_740" ,40,32-4,48,1})--22
    table.insert(bogey.EngineSNDConfig,{"ted6_740" ,48,40-4,56,1})--18
    table.insert(bogey.EngineSNDConfig,{"ted7_740" ,56,48-4,64,1})--15
    table.insert(bogey.EngineSNDConfig,{"ted8_740" ,64,56-4,72,1})--10
    table.insert(bogey.EngineSNDConfig,{"ted9_740" ,72,64-4,80,1})--07
    table.insert(bogey.EngineSNDConfig,{"ted10_740",80,72-4,88,1})--05
    --table.insert(bogey.EngineSNDConfig,{"ted11_720",88,80-4   ,0.00})--02

    bogey.SoundNames = {}
	
    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"
    --bogey.SoundNames["tedm_703"]  = "subway_trains/bogey/engines/703/engines_medium.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted1_740"]  = "subway_trains/740_4/engines/V1/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/740_4/engines/V1/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/740_4/engines/V1/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/740_4/engines/V1/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/740_4/engines/V1/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/740_4/engines/V1/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/740_4/engines/V1/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/740_4/engines/V1/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/740_4/engines/V1/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/740_4/engines/V1/engine_80.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,2)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/740_4/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/740_4/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/740_4/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/740_4/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/740_4/bogey/braking_async3.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/740_4/bogey/braking_async3.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"
end
	
if MotorType==2 then		
    for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end
    table.insert(bogey.EngineSNDConfig,{"ted1_740" ,08,00,16,  1})--40
    table.insert(bogey.EngineSNDConfig,{"ted2_740" ,16,08-4,24,1})--35
    table.insert(bogey.EngineSNDConfig,{"ted3_740" ,24,16-4,32,1})--32
    table.insert(bogey.EngineSNDConfig,{"ted4_740" ,32,24-4,40,1})--28
    table.insert(bogey.EngineSNDConfig,{"ted5_740" ,40,32-4,48,1})--22
    table.insert(bogey.EngineSNDConfig,{"ted6_740" ,48,40-4,56,1})--18
    table.insert(bogey.EngineSNDConfig,{"ted7_740" ,56,48-4,64,1})--15
    table.insert(bogey.EngineSNDConfig,{"ted8_740" ,64,56-4,72,1})--10
    table.insert(bogey.EngineSNDConfig,{"ted9_740" ,72,64-4,80,1})--07
    table.insert(bogey.EngineSNDConfig,{"ted10_740",80,72-4,88,1})--05	
	
    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"
    --bogey.SoundNames["tedm_703"]  = "subway_trains/bogey/engines/703/engines_medium.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted1_740"]  = "subway_trains/740_4/engines/V4/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/740_4/engines/V4/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/740_4/engines/V4/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/740_4/engines/V4/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/740_4/engines/V4/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/740_4/engines/V4/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/740_4/engines/V4/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/740_4/engines/V4/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/740_4/engines/V4/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/740_4/engines/V4/engine_80.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,2)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/740_4/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/740_4/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/740_4/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/740_4/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/740_4/bogey/braking_async3.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/740_4/bogey/braking_async3.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"

end	
if MotorType==3 then
 for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end	
	table.insert(bogey.EngineSNDConfig,{"ted1_720" ,08,00,16,1*0.4})
	table.insert(bogey.EngineSNDConfig,{"ted2_720" ,16,08-4,24,1*0.43})
	table.insert(bogey.EngineSNDConfig,{"ted3_720" ,24,16-4,32,1*0.46})
	table.insert(bogey.EngineSNDConfig,{"ted4_720" ,32,24-4,40,1*0.49})
	table.insert(bogey.EngineSNDConfig,{"ted5_720" ,40,32-4,48,1*0.52})
	table.insert(bogey.EngineSNDConfig,{"ted6_720" ,48,40-4,56,1*0.55})
	table.insert(bogey.EngineSNDConfig,{"ted7_720" ,56,48-4,64,1*0.58})
	table.insert(bogey.EngineSNDConfig,{"ted8_720" ,64,56-4,72,1*0.61})
	table.insert(bogey.EngineSNDConfig,{"ted9_720" ,72,64-4,80,1*0.64})
	table.insert(bogey.EngineSNDConfig,{"ted10_720",80,72-4,88,1*0.67})
	table.insert(bogey.EngineSNDConfig,{"ted11_720",88,80-4   ,1*0.7})

    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"

    bogey.SoundNames["ted1_717"]  = "subway_trains/bogey/engines/717/engines_8.wav"
    bogey.SoundNames["ted2_717"]  = "subway_trains/bogey/engines/717/engines_16.wav"
    bogey.SoundNames["ted3_717"]  = "subway_trains/bogey/engines/717/engines_24.wav"
    bogey.SoundNames["ted4_717"]  = "subway_trains/bogey/engines/717/engines_32.wav"
    bogey.SoundNames["ted5_717"]  = "subway_trains/bogey/engines/717/engines_40.wav"
    bogey.SoundNames["ted6_717"]  = "subway_trains/bogey/engines/717/engines_48.wav"
    bogey.SoundNames["ted7_717"]  = "subway_trains/bogey/engines/717/engines_56.wav"
    bogey.SoundNames["ted8_717"]  = "subway_trains/bogey/engines/717/engines_64.wav"
    bogey.SoundNames["ted9_717"]  = "subway_trains/bogey/engines/717/engines_72.wav"
    bogey.SoundNames["ted10_717"] = "subway_trains/bogey/engines/717/engines_80.wav"

    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
    bogey.SoundNames["flangea"]      = "subway_trains/bogey/skrip1.wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/bogey/skrip2.wav"
    bogey.SoundNames["flange1"]      = "subway_trains/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/bogey/flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/bogey/braking_async1.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/bogey/braking_async2.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"
	end
if MotorType==4 then
for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end
	table.insert(bogey.EngineSNDConfig,{"ted1_740" ,08,00,16,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted2_740" ,16,08-4,24,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted3_740" ,24,16-4,32,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted4_740" ,32,24-4,40,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted5_740" ,40,32-4,48,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted6_740" ,48,40-4,56,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted7_740" ,56,48-4,64,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted8_740" ,64,56-4,72,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted9_740" ,72,64-4,80,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted10_740",80,72-4,88,1*1})

    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"

    bogey.SoundNames["ted1_740"]  = "subway_trains/740_4/engines/V3/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/740_4/engines/V3/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/740_4/engines/V3/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/740_4/engines/V3/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/740_4/engines/V3/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/740_4/engines/V3/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/740_4/engines/V3/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/740_4/engines/V3/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/740_4/engines/V3/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/740_4/engines/V3/engine_80.wav"

    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,2)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/740_4/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/740_4/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/740_4/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/740_4/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/740_4/bogey/braking_async4.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/740_4/bogey/braking_async4.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"
	
end		
if MotorType==5 then
for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end		
	table.insert(bogey.EngineSNDConfig,{"ted1_740" ,08,00,16,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted2_740" ,16,08-4,24,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted3_740" ,24,16-4,32,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted4_740" ,32,24-4,40,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted5_740" ,40,32-4,48,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted6_740" ,48,40-4,56,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted7_740" ,56,48-4,64,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted8_740" ,64,56-4,72,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted9_740" ,72,64-4,80,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted10_740",80,72-4,88,1*1})

    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
	local eng = math.random (1,2)	
    bogey.SoundNames["ted1_740"]  = "subway_trains/740_4/engines/V2/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/740_4/engines/V2/engine_16_"..eng..".wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/740_4/engines/V2/engine_24_"..eng..".wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/740_4/engines/V2/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/740_4/engines/V2/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/740_4/engines/V2/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/740_4/engines/V2/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/740_4/engines/V2/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/740_4/engines/V2/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/740_4/engines/V2/engine_80.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,2)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/740_4/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/740_4/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/740_4/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/740_4/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/740_4/bogey/braking_async4.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/740_4/bogey/braking_async4.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/740_4/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/740_4/bogey/skrip2_"..skripit..".wav"
		
    -- Remove old sounds
    if bogey.Sounds then
        for k,v in pairs(bogey.Sounds) do
            v:Stop()
        end
    end

    -- Create sounds
    bogey.Sounds = {}
    bogey.Playing = {}
    for k,v in pairs(bogey.SoundNames) do
        --if not file.Exists(v, "MOD") then
--          bogey.SoundNames[k] = nil
        --end
        util.PrecacheSound(v)
        local e = bogey
        if (k == "brake3a") and IsValid(bogey:GetNW2Entity("TrainWheels")) then
            e = bogey:GetNW2Entity("TrainWheels")
        end
        bogey.Sounds[k] = CreateSound(e, Sound(v))
    end

    bogey.Async = nil
    --bogey.MotorSoundType = nil
end
end
else return end
	
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then return end	
	local MiddleBogey = self:GetNW2Entity("MiddleBogey")	
	local refresh = false--true		
	
	if self:GetNW2Int("MotorType")==1 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V1/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/V1/engines/engine_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 1 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/V1/engines/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end		
	end
	
	if self:GetNW2Int("MotorType")==2 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V4/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V4/engine_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 1 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/engines/V4/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
	end
	
	if self:GetNW2Int("MotorType")==3 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_720"] ~= "subway_trains/bogey/engines/720/speed_8.wav"  
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 0.4) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_720"] ~= "subway_trains/bogey/engines/720/speed_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 0.4 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_720"] ~= "subway_trains/bogey/engines/720/speed_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 0.4) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end		
	end
	
	if self:GetNW2Int("MotorType")==4 then		
	if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V3/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end	
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V3/engine_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 1 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end	
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V3/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
	end
	
	if self:GetNW2Int("MotorType")==5 then		
	if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V2/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end		
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V2/engine_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 1 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end	
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/740_4/engines/V2/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
end

for k=0,3 do
    self.ClientProps["TrainNumberR"..k] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(705-k*6.6+4*6.6/2-159-9, -63.9, 14),
        ang = Angle(0,0,-3.29),
		hide = 1,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    } 	 	  
end

function self:UpdateWagonNumber()
		self.HeadTrain1 = self:GetNW2Entity("gmod_subway_kuzov")	
		local train1 = self.HeadTrain1 
		if not IsValid(train1) then return end	
		
		train1.HeadTrain = self 
		train1:SetNW2Entity("HeadTrain", self)
		
for k=0,3 do
        --if i< count then			
			if self.WagonNumber then				
            local rightNum = self.ClientEnts["TrainNumberR"..k]		
	        local num = math.floor(self.WagonNumber%(10^(k+1))/10^k)
            if IsValid(rightNum) then
				rightNum:SetPos(self:LocalToWorld(Vector(705-k*6.6+4*6.6/2-159-9, -63.9, 14)))
                rightNum:SetSkin(num)
            end	
            local leftNum = train1.ClientEnts["TrainNumberL"..k]	
	        local num = math.floor(self.WagonNumber%(10^(k+1))/10^k)										
            if IsValid(leftNum) then	
                leftNum:SetLocalPos(Vector(-310+k*6.6-4*6.6/2, 63.4, 18))
                leftNum:SetSkin(num)		
            end  								
			self.HeadLightBroken1 = self:GetNW2Bool("HeadLightBroken1",false)
			self.HeadLightBroken2 = self:GetNW2Bool("HeadLightBroken2",false)
			self.HeadLightBroken3 = self:GetNW2Bool("HeadLightBroken3",false)
			self.HeadLightBroken4 = self:GetNW2Bool("HeadLightBroken4",false)
			 
			self.RedLightBroken1 = self:GetNW2Bool("RedLightBroken1",false)
			self.RedLightBroken2 = self:GetNW2Bool("RedLightBroken2",false)
			self.RedLightBroken3 = self:GetNW2Bool("RedLightBroken3",false)
			self.RedLightBroken4 = self:GetNW2Bool("RedLightBroken4",false)	
			end
		end
end
	 self:SetLightPower(3,self.Door5 and self:GetPackedBool("AppLights"),self:GetPackedBool("AppLights") and 1 or 0)
    --ANIMS
    self:Animate("brake_line", self:GetPackedRatio("BL"), 0, 0.753,  256,2)
    self:Animate("train_line", self:GetPackedRatio("TL"),   0, 0.753,  4096,2)
    self:Animate("brake_cylinder", self:GetPackedRatio("BC"), 0, 0.746,  64,12)
	
    self:SetSoundState("ring_vityaz",self:GetPackedBool("BUKPRing",false) and 1.6 or 0,1)
    self:SetSoundState("ring_cams",self:GetPackedBool("CAMSRing",false) and 1.6 or 0,1)
	
	--Вольтаж
    self:Animate("volt_hv",self:GetPackedRatio("HV"),1.0,0.722,94,4)
    self:Animate("amp_i13",self:GetPackedRatio("I13"),1,0.722,92,2) --I13

    self:Animate("controller", (self:GetPackedRatio("Controller")+4)/8, 0, 0.425,  2.5,false)

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)		

    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,1,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)	
	
	local dT = self.DeltaTime
	
    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    self:SetSoundState("release_front",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)	
    self:SetSoundState("release_middle",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)

    self:Animate("KRO", self:GetPackedRatio("KRO",0), 0.525, 1,  4,false)
    self:Animate("KRR", self:GetPackedRatio("KRR",0), 0.525, 1,  4,false)
    self:Animate("km013", Cpos[self:GetPackedRatio("Cran")] or 0, 0, 0.7,  2,false)
    self:Animate("PB",  self:GetPackedBool("PB") and 1 or 0,0,0.2,  8,false)
	
	self:ShowHide("AntennaProp",not self:GetNW2Bool("Antenna"))
	self:ShowHide("PasswordProp",not self:GetNW2Bool("Password"))	
	
	local ZavodTable = self:GetNW2Int("ZavodTable",1)	
    self:ShowHide("Zavod_table_front",ZavodTable==1)
	
	local Map = game.GetMap():lower() or ""	
	local kek1 = Map:find("gm_metro_crossline_n4a") 
	or Map:find("gm_metro_crossline_c4") 
	or Map:find("gm_metro_crossline_m12") 
	or Map:find("gm_metro_crossline_n3") 
	or Map:find("gm_smr_1987") 
	or Map:find("gm_jar_pll")
	or Map:find("gm_metro_pink_line") 
	or Map:find("gm_metro_surfacemetro")
	or Map:find("gm_metro_sunnytown")	
	or Map:find("gm_metro_ruralline")
	or Map:find("gm_metro_nsk_line")		
	or Map:find("gm_line_2")	
	or Map:find("gm_dnipro")	
	
	
    self:ShowHide("Gerb_msk",kek1)
    self:ShowHide("Gerb_msk_right",kek1)		
	
    self:ShowHide("Gerb_msk1",not kek1)
    self:ShowHide("Gerb_msk_right1",not kek1)	
	
	local animation = math.random (5,12)	
	local animation1 = math.random (0.5,1)	
	
	--Головная часть	
for avar = 1,2 do
	--Головная часть
    local colV = self:GetNW2Vector("Lamp7404"..avar)
    local col = Color(colV.x,colV.y,colV.z)	
	self:ShowHideSmooth("lamps_salon_on_avar"..avar,self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,animation1,animation,false),col)  
end

for i = 1,10 do	
	--Головная часть
    local colV = self:GetNW2Vector("Lamp7404"..i)
    local col = Color(colV.x,colV.y,colV.z)		
    self:ShowHideSmooth("lamps_salon_on"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)
    self:ShowHideSmooth("lamps_salon_on_fr"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)	
end

for i = 1,11 do	
	--Головная часть
    local colV = self:GetNW2Vector("Lamp7404"..i)
    local col = Color(colV.x,colV.y,colV.z)			
	--Задняя часть
end
	
	local cab_lamp = self:Animate("cab_lamp",self:GetPackedBool("CabinEnabledFull") and 1 or self:GetPackedBool("CabinEnabledEmer") and 0.5 or 0,0,1,5,false)
    self:ShowHideSmooth("cab_emer",cab_lamp)
    self:ShowHideSmooth("cab_full",cab_lamp)

    self:ShowHideSmooth("lamp_f",self:Animate("lamp_forw",self:GetPackedBool("BIForward") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("lamp_b",self:Animate("lamp_back",self:GetPackedBool("BIBack") and 1 or 0,0,1,5,false))

    local accel = self:GetPackedRatio("BIAccel",0)
    local speed = self:GetNW2Int("BISpeed",0)
    local limit = self:GetNW2Int("BISpeedLimit",0)
    self:ShowHide("speed1",speed ~= -1)
    self:ShowHide("speed2",speed ~= -1)
    if speed ~= -1 then
        if IsValid(self.ClientEnts["speed1"]) then self.ClientEnts["speed1"]:SetSkin(speed/10) end
        if IsValid(self.ClientEnts["speed2"]) then self.ClientEnts["speed2"]:SetSkin(speed%10) end
    end

    local bi_power = self:GetNW2Bool("BIPower", false)
	if bi_power then
        for i=1,5 do
            local blink = self:GetNW2Bool("BISpeedLimitBlink") 
            if blink and CurTime()%1 <=0.5 then
                limit = 98
            end
            local nxt = self:GetNW2Int("BISpeedLimitNext",0)
            if IsValid(self.ClientEnts["speeddop"..i]) then self.ClientEnts["speeddop"..i]:SetSkin(math.Clamp(50-limit/2-(i-1)*10,0,10)) end
            if IsValid(self.ClientEnts["speedfact"..i]) then self.ClientEnts["speedfact"..i]:SetSkin(math.Clamp(speed/2-(i-1)*10,0,10)) end
            if IsValid(self.ClientEnts["speedrek"..i]) then self.ClientEnts["speedrek"..i]:SetSkin(math.Clamp(50-nxt/2-(i-1)*10,0,10)) end
        end
    else
        for i=1,5 do
            if IsValid(self.ClientEnts["speeddop"..i]) then self.ClientEnts["speeddop"..i]:SetSkin(0) end
            if IsValid(self.ClientEnts["speedfact"..i]) then self.ClientEnts["speedfact"..i]:SetSkin(0) end
            if IsValid(self.ClientEnts["speedrek"..i]) then self.ClientEnts["speedrek"..i]:SetSkin(0) end
        end
    end
			
	local bool2num ={ [true]=1, [false]=0 }
	local negbool2num ={ [true]=0, [false]=1 }
    local HL1 = bool2num[self:GetPackedBool("Headlights1Enabled")]*negbool2num[self.HeadLightBroken1] or 1
    local HL2 = bool2num[self:GetPackedBool("Headlights1Enabled")]*negbool2num[self.HeadLightBroken2] or 1
    local HL3 = bool2num[self:GetPackedBool("Headlights2Enabled")]*negbool2num[self.HeadLightBroken3] or 1
    local HL4 = bool2num[self:GetPackedBool("Headlights2Enabled")]*negbool2num[self.HeadLightBroken4] or 1
    local RL  = self:Animate("RedLights",  self:GetPackedBool("RedLights") and 1 or 0,0,1,6,false)
	--print(HL1..HL2..HL3..HL4)
	
	local HLs1 = self:Animate("Headlights1", self:GetPackedBool("Headlights1Enabled") and 1 or 0,0,1,6,false)*(HL1+HL2==0 and 0 or 1)
	local HLs2 = self:Animate("Headlights2", self:GetPackedBool("Headlights2Enabled") and 1 or 0,0,1,6,false)*(HL3+HL4==0 and 0 or 1)
	
	
	self:ShowHideSmooth("Head--_-0", not self.HeadLightBroken1 and HLs1 or 0)
	self:ShowHideSmooth("Head0-_--", not self.HeadLightBroken2 and HLs1 or 0)
	self:ShowHideSmooth("Head--_0-", not self.HeadLightBroken3 and HLs2 or 0)
	self:ShowHideSmooth("Head-0_--", not self.HeadLightBroken4 and HLs2 or 0)
	
    self:ShowHideSmooth("redlights740up1",not self.RedLightBroken1 and RL or 0)
    self:ShowHideSmooth("redlights740up2",not self.RedLightBroken2 and RL or 0)
	self:ShowHideSmooth("redlights740down1",not self.RedLightBroken3 and RL or 0)
    self:ShowHideSmooth("redlights740down2",not self.RedLightBroken4 and RL or 0)
    local headlights = HL1*0.1+HL2*0.1+HL3*0.1+HL4*0.1+HLs1*0.2+HLs2*0.4
	--print(headlights)
    self:SetLightPower(1,headlights>0,headlights)
    self:SetLightPower(2,RL>0,RL)
	--print(self:GetPackedRatio("Headlights"))
    if IsValid(self.GlowingLights[1]) then
        if self:GetPackedRatio("Headlights") < 1 and self.GlowingLights[1]:GetFarZ() ~= 4096 then
            self.GlowingLights[1]:SetFarZ(4096)
        end
        if self:GetPackedRatio("Headlights") == 1 and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
	end
	
	if (self:GetPackedBool("wiper")) and self.Anims["wiper"] and self:GetPackedBool("Battery") then
		local anim = self.Anims["wiper"].value		
		if anim == 0 then
			self.WiperDir = true
		elseif anim == 1 then
			self.WiperDir = false
		end
		self:Animate("wiper",self.WiperDir and 1 or 0,0,1,0.42,false)
	elseif self:GetPackedBool("Battery") then
		self:Animate("wiper",0,0,1,0.42,false)		
	end
	
	--Анимация дверей.
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for n=0,2 do
        for G=0,1 do
            local st = G==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(n+1),"door"..n.."x"..G
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
					if doorstate then self:PlayOnce(sid.."s","",1,math.Rand(0.9,1.3)) end--math.Rand(0.9,1.3))				
                else
					if state > 0 then
                        self:PlayOnce(sid.."o","",1,math.Rand(0.9,1.3))
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.9,1.3))						
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.9+self.DoorLoopStates[id]*0.1)	
            local n_l = "door"..n.."x"..G.."a"
            local n_r = "door"..n.."x"..G.."b"				
            self:Animate(n_l,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
            self:Animate(n_r,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)								
        end
	end
	
	
    local door_m = self:GetPackedBool("PassengerDoor")
    local door_l = self:GetPackedBool("CabinDoorLeft")
    local door_r = self:GetPackedBool("CabinDoorRight")
    --local door_o = self:GetPackedBool("OtsekDoor") or self.CurrentCamera == 7
	
    local door_cab_m = self:Animate("door_cab_m",door_m and 1 or -0.05,0,0.235, 8, 0.05)
	
	    --[[local door1s = (door_cab_m > 0 or door_m)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("PassengerDoor","bass" ,door1s and 1 or 0)
    end]]

    local door_cab_l = self:Animate("door_cab_l",door_l	/*self:GetPackedBool(169)*/ and 0.99/*self.Door3 or 0.89)*/ or 0,0,1, 4, 1)
    local door_cab_r = self:Animate("door_cab_r",door_r	/*self:GetPackedBool(169)*/ and 0.99/*(self.Door4 or 0.99)*/ or 0,0,1, 4, 1)
    local door_cab_o = self:Animate("door_cab_o",door_o and 1 or -0.05,0,0.3, 8, 0.05) 			--self:Animate("door_cab_r",door_r and 1 or -0.1,0,0.25, 2, 0.5)
	
    local door2s = door_cab_l > 0.05 and door_cab_l and 2 or (door_cab_l == 1.95 and 2 or door_l and 1 or 0)
    if self.Door2 ~= door2s or self.DoorCL ~= door_l then
        self.DoorCL = door_l
        self.Door2 = door2s
        self:PlayOnce("CabinDoorLeft","bass",door2s)
    end
    
    local door3s = door_cab_r > 0.05 and door_cab_r and 2 or (door_cab_r == 1.95 and 2 or door_r and 1 or 0)
    if self.Door3 ~= door3s or self.DoorCR ~= door_r then
        self.DoorCR = door_r
        self.Door3 = door3s
        self:PlayOnce("CabinDoorRight","bass",door3s)
    end	
		
    --[[local door5s = (door_cab_o > 0 or door_o)
    if self.Door5 ~= door5s then
        self.Door5 = door5s
        self:PlayOnce("OtsekDoor","bass",door5s and 1 or 0)
    end
    self:HidePanel("PVZ",not self.Door5)]]

    local dT = self.DeltaTime

    local parking_brake = math.max(0,-self:GetPackedRatio("ParkingBrakePressure_dPdT",0))
    self.ParkingBrake = self.ParkingBrake+(parking_brake-self.ParkingBrake)*dT*10
    self:SetSoundState("parking_brake",self.ParkingBrake,1.4)

    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)

    local ramp = self:GetPackedRatio("Crane_dPdT",0)
    if ramp > 0 then
        self.CraneRamp = self.CraneRamp + ((0.2*ramp)-self.CraneRamp)*dT
    else
        self.CraneRamp = self.CraneRamp + ((0.9*ramp)-self.CraneRamp)*dT
    end
    self.CraneRRamp = math.Clamp(self.CraneRRamp + 1.0*((1*ramp)-self.CraneRRamp)*dT,0,1)
    self:SetSoundState("crane013_release",self.CraneRRamp^1.5,1.0)
    self:SetSoundState("crane013_brake",math.Clamp(-self.CraneRamp*1.5,0,1)^1.3,1.0)
    self:SetSoundState("crane013_brake2",math.Clamp(-self.CraneRamp*1.5-0.95,0,1.5)^2,1.0)

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    self:SetSoundState("emer_brake",self.EmergencyValveRamp,1.0)

    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
	
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+math.min(0.4,self.EmergencyBrakeValveRamp*0.5))
	self:SetSoundState("valve_brake_open",self.EmergencyBrakeValveRamp > 0.0001 and CurTime()-self:GetPackedRatio("EmerValve",1e9) < 0 and 1 or 0,1)	

	local RingSound = self:GetNW2Int("RingSound",1)
	
    local state = self:GetPackedBool("RingEnabled")
	if RingSound==1 then		
    self:SetSoundState("ring",state and 0.40 or 0,1)
	elseif
	RingSound==2 then
    self:SetSoundState("ring_old",state and 0.40 or 0,1)
	elseif
	RingSound==3 then
    self:SetSoundState("ring_new",state and 0.40 or 0,1)
	elseif	
	RingSound==4 then
    self:SetSoundState("ring_1",state and 0.40 or 0,1)
	end	

    local speed = self:GetPackedRatio("Speed", 0)

    local ventSpeedAdd = math.Clamp(speed/30,0,1)

    local vstate = self:GetPackedBool("Vent2Work")
    for i=1,4 do
        local rand = self.VentRand[i]
        local vol = self.VentVol[i]
        local even = i%2 == 0
        local work = (even and v1state or not even and vstate)
        local target = math.min(1,(work and 1 or 0)+ventSpeedAdd*rand*0.4)*2
        if self.VentVol[i] < target then
            self.VentVol[i] = math.min(target,vol + dT/1.5*rand)
        elseif self.VentVol[i] > target then
            self.VentVol[i] = math.max(0,vol - dT/8*rand*(vol*0.3))
        end
        self.VentState[i] = (self.VentState[i] + 10*((self.VentVol[i]/2)^3)*dT)%1
        local vol1 = math.max(0,self.VentVol[i]-1)
        local vol2 = math.max(0,(self.VentVol[i-1] or self.VentVol[i+1])-1)
		
		local VentSound = self:GetNW2Int("VentSound",1)	
		if VentSound==1 then
        self:SetSoundState("vent"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
		end		
		if VentSound==2 then
        self:SetSoundState("vent1"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
		end			
    end	
    --local rol10 = math.Clamp(speed/5,0,1)*(1-math.Clamp((speed-50)/8,0,1))
    --local rol70 = math.Clamp((speed-50)/8,0,1)
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.5,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local tunstreet = (rollingi+rollings*0.2)
    local rol5 = math.Clamp(speed/5,0,1)*(1-math.Clamp((speed-10)/5,0,1))
    local rol5p = Lerp((speed-5)/5,0.9,1.1)		
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-20)/12,0,1))
    local rol10p = Lerp((speed-12)/12,0.9,1.1)
    local rol30 = math.Clamp((speed-20)/12,0,1)*(1-math.Clamp((speed-40)/12,0,1))
    local rol30p = Lerp((speed-15)/30,0.8,1.2)
    local rol55 = math.Clamp((speed-40)/12,0,1)*(1-math.Clamp((speed-65)/15,0,1))
    local rol55p = Lerp(0.8+(speed-43)/24,0.8,1.2)
    local rol75 = math.Clamp((speed-65)/15,0,1)
    local rol75p = Lerp(0.8+(speed-67)/16,0.8,1.2)
    self:SetSoundState("rolling_5",rollingi*rol5,rol5p)	
    self:SetSoundState("rolling_10",rollingi*rol10,rol10p)
    self:SetSoundState("rolling_30",rollingi*rol30,rol30p)
    self:SetSoundState("rolling_55",rollingi*rol55,rol55p)
    self:SetSoundState("rolling_75",rollingi*rol75,rol75p)
	
    self:SetSoundState("rolling_5_middle",rollingi*rol5,rol5p)	
    self:SetSoundState("rolling_10_middle",rollingi*rol10,rol10p)
    self:SetSoundState("rolling_30_middle",rollingi*rol30,rol30p)
    self:SetSoundState("rolling_55_middle",rollingi*rol55,rol55p)
    self:SetSoundState("rolling_75_middle",rollingi*rol75,rol75p)	

    local rol10 = math.Clamp(speed/15,0,1)*(1-math.Clamp((speed-18)/35,0,1))
    local rol10p = Lerp((speed-15)/14,0.6,0.78)
    local rol40 = math.Clamp((speed-18)/35,0,1)*(1-math.Clamp((speed-55)/40,0,1))
    local rol40p = Lerp((speed-15)/66,0.6,1.3)
    local rol70 = math.Clamp((speed-55)/20,0,1)--*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp((speed-55)/27,0.78,1.15)
    --local rol80 = math.Clamp((speed-70)/5,0,1)
    --local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_low"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2",rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2"  ,rol70*rollings,rol70p) --70

    self:SetSoundState("rolling_low_middle"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2_middle",rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2_middle"  ,rol70*rollings,rol70p) --70		
	
    local state = self:GetPackedRatio("asynccurrent")--^1.5--RealTime()%2.5/2	
    local strength = self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-23)/23,0,1))*0.5
		
    self:SetSoundState("ONIX", tunstreet*math.Clamp((state)/0.26+0.2,0,1)*strength, 1)--+math.Clamp(state,0,1)*0.1)
    self:SetSoundState("chopper_onix", tunstreet*self:GetPackedRatio("chopper"), 1)
    local work = self:GetPackedBool("AnnPlay")
    for k,v in ipairs(self.AnnouncerPositions) do
	if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume(work and (v[4] or 1)  or 0.5)
		end 
	end	
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end  

function ENT:OnButtonPressed(button)

end
function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
	if soundid:sub(1,4) == "IGLA" then
    return range > 0 and "igla_on" or "igla_off",location,1,pitch
    end
    return soundid,location,range,pitch
end 
function ENT:DrawPost(special)
    self.RTMaterial:SetTexture("$basetexture", self.Vityaz)
    self:DrawOnPanel("Vityaz",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(400,300,800,600,0)
    end)
    self.RTMaterial:SetTexture("$basetexture", self.ASNP)
    self:DrawOnPanel("ASNPScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(145,50,490,112.8,0)
    end)
	--ИГЛА
    self.RTMaterial:SetTexture("$basetexture",self.IGLA)
    self:DrawOnPanel("IGLA_C",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)
	self.RTMaterial:SetTexture("$basetexture", self.CAMS)
    self:DrawOnPanel("CAMS",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(529,446,1024,768,0) 
    end)
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("Tickers",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
end

Metrostroi.GenerateClientProps()