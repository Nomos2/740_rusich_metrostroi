local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_kalinin")
or Map:find("gm_metro_krl")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")
or Map:find("gm_metropbl")) then
	return
end

include("shared.lua")
--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}
ENT.ClientPropsInitialized = false

--[[ENT.ClientProps["test_prop"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(85,-34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop1"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(324,-34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop2"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(550,-34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop3"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(600,34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop4"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(362,34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop5"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(136,34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}]]


ENT.ButtonMap["PVZ"] = {
    pos = Vector(654,52,-12), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90),
    width = 330, 
    height = 350,
    scale = 0.0625,
    hideseat=0.2,

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

        {ID = "SFV12Toggle",x=0*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV13Toggle",x=1*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV14Toggle",x=2*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV15Toggle",x=3*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV16Toggle",x=4*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV17Toggle",x=5*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV18Toggle",x=6*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV19Toggle",x=7*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV20Toggle",x=8*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV21Toggle",x=9*30, y=150, w=30,h=50, tooltip = "",}, 
        {ID = "SFV22Toggle",x=10*30, y=150, w=30,h=50, tooltip = ""},

        {ID = "SFV24Toggle",x=0*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV26Toggle",x=1*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV27Toggle",x=2*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV28Toggle",x=3*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV29Toggle",x=4*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV30Toggle",x=5*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV31Toggle",x=6*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV32Toggle",x=7*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV33Toggle",x=8*30, y=300, w=30,h=50, tooltip = ""},
    }
}
for k,buttbl in ipairs(ENT.ButtonMap["PVZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-16, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end
ENT.ButtonMap["Battery"] = {
    pos = Vector(650,18.11,-5), --446 -- 14 -- -0,5
    ang = Angle(0,0,90),
    width = 30,
    height = 30,
    scale = 0.0625,

    buttons = {
        {ID = "BatteryToggle",x=0, y=0, w=30,h=30   , tooltip = "", model = {
            model = "models/metrostroi_train/81-717/battery_enabler.mdl",
            var="Battery",speed=0.5,vmin=1,vmax=0.8,
            sndvol = 0.8, snd = function(val) return val and "pak_on" or "pak_off" end,
			sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(654,15,55), ---334.8,14.5,9
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=2000, tooltip="", model = {
            var="FrontDoor",sndid="door_cab_f",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,	 
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,180,0),
        }},
    }
}
ENT.ButtonMap["FrontDoor_rear"] = {
    pos = Vector(659,-15,55), ---334.8,14.5,9
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=2000, tooltip="", model = {
            var="FrontDoor_rear",sndid="door_cab_f",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,	 
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,180,0),
        }},
    }
}

ENT.ButtonMap["PVZ_otsek_open"] = {
    pos = Vector(640,62,-9), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90),
    width = 642,
    height = 500,
    scale = 0.0625,
    buttons = {
        {ID = "PVZ_otsek",x=0,y=0,w=642,h=500, tooltip=""},
    }
}
ENT.ButtonMap["PVZ_otsek_close"] = {
    pos = Vector(520,45,-9), --446 -- 14 -- -0,5
    ang = Angle(0,0,90),
    width = 442,
    height = 400,
    scale = 0.0625,
    buttons = {
        {ID = "PVZ_otsek",x=0,y=0,w=442,h=400, tooltip=""},
    }
}

ENT.ClientProps["salon"] = {
	model = "models/metrostroi_train/81-741/salon/salon.mdl",
	pos = Vector(322.6,0,0),
	ang = Angle(0,180,0),
	hide = 1,
}
ENT.ClientProps["otsek"] = {
	model = "models/metrostroi_train/81-741/salon/otsek.mdl",
	pos = Vector(322.6,0,0),
	ang = Angle(0,180,0),
	hide = 1,
}
ENT.ClientProps["otsek_open"] = {
	model = "models/metrostroi_train/81-741/salon/otsek.mdl",
	pos = Vector(587.6,-275,0),
	ang = Angle(0,270,0),
	hide = 1,
}
ENT.ClientProps["handrails"] = {
	model = "models/metrostroi_train/81-740/salon/handrails/handrails_r.mdl",
	pos = Vector(438.8,1,-75),-- -115.5, -1, -75
	ang = Angle(0,0,0),
	hide = 1.2,
}
ENT.ClientProps["door_cab_f"] = {
	model = "models/metrostroi_train/81-740/salon/door_br.mdl",
	pos = Vector(657,-15.2,8.8),
	ang = Angle(0,0,0.1),
	scale = 1.001,
	hide = 1.5,
}
ENT.ClientProps["krepezh"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(257.6,0,-74.6),
    ang = Angle(0,0,0),
    nohide = true,
}

----Аварийка
ENT.ClientProps["lamps_salon_on_avar_front1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_avar_front2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
----Аварийка

ENT.ClientProps["lamps_salon_on_front_left1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(34.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(144.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(197,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(251,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(305,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(359,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(413,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(467,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left10"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left11"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(576.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}


ENT.ClientProps["lamps_salon_on_front1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(34.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(144.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(197,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(251,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(305,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(359,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(413,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(467,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front10"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front11"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(576.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}

ENT.ClientProps["lamps_salon_off"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_off.mdl",
    pos = Vector(379,0,0),
    ang = Angle(0,0,0),
	nohide = true,
}
ENT.ClientProps["handrails_offside_front"] = {
    model = "models/metrostroi_train/81-740/body/740_body_additional.mdl",
    pos = Vector(300.9,-10,-80),
    ang = Angle(0,0.2,0),
    nohide = true,
}
ENT.ButtonMap["Tickers"] = {
    pos = Vector(35.9, -27.5, 66.0), 
    ang = Angle(0,90,90),
    width = 1024,
    height = 64,
    scale = 0.0545,
    hide=true,
    hideseat=1,
}
ENT.ButtonMap["GV"] = {
    pos = Vector(364,-60,-82),
    ang = Angle(0,90,-90),
    width = 110,
    height = 110,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 110,h = 110, tooltip="", model = {
            var="GV",sndid = "gv_wrench",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
        }},
    }
}
ENT.ClientProps["gv"] = {
    model = "models/metrostroi/81-717/gv.mdl",
    pos = Vector(364.2,-55,-76),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
	hideseat = 0.5,
}

ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,90,-90),
	hideseat = 0.5,
}
ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(660,-35.0,-45),
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
ENT.ClientProps["FrontBrake"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(660, -25, -56.5), 
    ang = Angle(15,-90,0),
	hide = 1,
}
ENT.ClientProps["FrontTrain"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(660, 25, -56.5),
    ang = Angle( -15,-90,0),
	hide = 1,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

--Новые модели 2023.
ENT.ClientProps["Zavod_table_front"] = { --Заводская табличка
    model = "models/metrostroi_train/81-741/salon/zavod.mdl",
	pos = Vector(654.56,15,60),
    ang = Angle(90,-180,0),
	hide = 1,
	scale = 3,	
}
ENT.ClientProps["Naddver_off_right"] = { 
    model = "models/metrostroi_train/81-741/salon/naddverka_off.mdl",
	pos = Vector(360.5,0.05,0),
    ang = Angle(0,0,0),
	scale = 1,
	hide = 2, 	
}
ENT.ClientProps["Naddver_off_left"] = { 
    model = "models/metrostroi_train/81-741/salon/naddverka_off.mdl",
	pos = Vector(325.3,-0.03,0.05),
    ang = Angle(0,180,0),
	scale = 1,
	hide = 2, 	
}
--------------------------------------------------------------------------------
-- Add doors
--------------------------------------------------------------------------------
local function GetDoorPosition(b,k,j)
	if j == 0 
	then return Vector(591.9 - 35.15*k     - 232.1*b,-67.5*(1-2*k),4)
	else return Vector(592 - 35.0*(1-k) - 232.1*b,-66*(1-2*k),4)
	end
end

for b=0,2 do
	for k=0,1 do
		ENT.ClientProps["door"..b.."x"..k.."a"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl",
			pos = GetDoorPosition(b,k,0),
			ang = Angle(0,90 +180*k,0),   
			scale = 1.001,				
			hide = 2,
		}
		ENT.ClientProps["door"..b.."x"..k.."b"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl",
			pos = GetDoorPosition(b,k,1),
			ang = Angle(0,90 +180*k,0),   
			scale = 1.001,				
			hide = 2,
		}
	end 
end


local yventpos = {
    414.5+0*117-144,
	414.5+2*117+5-144,
	414.5+4*117+0.5-144,
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Tickers = self:CreateRT("741Ticker",1024,64)
    render.PushRenderTarget(self.Tickers,0,0,1024, 64)
    render.Clear(0, 0, 0, 0)
    render.PopRenderTarget()
    self.ReleasedPdT = 0
    self.PreviousCompressorState = false
    self.CompressorVol = 0
    self.TISUVol = 0

    self.FrontLeak = 0
    self.RearLeak = 0

    self.ParkingBrake = 0

    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,8 do
    self.VentRand[i] = math.Rand(0.5,2)
    self.VentState[i] = 0
    self.VentVol[i] = 0
    end
	
	self.FrontBogey = self:GetNW2Entity("FrontBogey")	
	self.RearBogey = self:GetNW2Entity("RearBogey")
end

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
    bogey.SoundNames["ted1_740"]  = "subway_trains/rusich/engines/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/rusich/engines/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/rusich/engines/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/rusich/engines/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/rusich/engines/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/rusich/engines/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/rusich/engines/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/rusich/engines/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/rusich/engines/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/rusich/engines/engine_80.wav"

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
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async3.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/rusich/bogey/braking_async3.wav"
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
    bogey.SoundNames["ted1_740"]  = "subway_trains/rusich/engines/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/rusich/engines/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/rusich/engines/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/rusich/engines/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/rusich/engines/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/rusich/engines/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/rusich/engines/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/rusich/engines/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/rusich/engines/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/rusich/engines/engine_80.wav"

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
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async3.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/rusich/bogey/braking_async3.wav"
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

    bogey.SoundNames["ted1_740"]  = "subway_trains/rusich/engines_new_1/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/rusich/engines_new_1/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/rusich/engines_new_1/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/rusich/engines_new_1/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/rusich/engines_new_1/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/rusich/engines_new_1/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/rusich/engines_new_1/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/rusich/engines_new_1/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/rusich/engines_new_1/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/rusich/engines_new_1/engine_80.wav"

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
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async4.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/rusich/bogey/braking_async4.wav"
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
    bogey.SoundNames["ted1_740"]  = "subway_trains/rusich/engines_1/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/rusich/engines_1/engine_16_"..eng..".wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/rusich/engines_1/engine_24_"..eng..".wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/rusich/engines_1/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/rusich/engines_1/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/rusich/engines_1/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/rusich/engines_1/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/rusich/engines_1/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/rusich/engines_1/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/rusich/engines_1/engine_80.wav"

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
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async4.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/rusich/bogey/braking_async4.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
		
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

function ENT:Think()
    self.BaseClass.Think(self)
	local MiddleBogey = self:GetNW2Entity("MiddleBogey")	
	local refresh = false--true		
	
	if self:GetNW2Int("MotorType")==1 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines/engine_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 1 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end		
	end
	
	if self:GetNW2Int("MotorType")==2 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new/engine_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 1 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new/engine_8.wav" 
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
	if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new_1/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end	
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new_1/engine_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 1 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end	
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new_1/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
	end
	
	if self:GetNW2Int("MotorType")==5 then		
	if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_1/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end		
	if IsValid(MiddleBogey) and MiddleBogey.SoundNames and MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_1/engine_8.wav" 
	or MiddleBogey.EngineSNDConfig and MiddleBogey.EngineSNDConfig[1] and MiddleBogey.EngineSNDConfig[1][5] ~= 1 or refresh then
		self:ReInitBogeySounds(MiddleBogey)
	end	
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_1/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
end	

for k=0,3 do
    self.ClientProps["TrainNumberR"..k] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(635-k*6.6+4*6.6/2,-63.35,18),
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
				rightNum:SetPos(self:LocalToWorld(Vector(635-k*6.6+4*6.6/2,-63.35,18)))
                rightNum:SetSkin(num)
            end	
            local leftNum = train1.ClientEnts["TrainNumberL"..k]	
	        local num = math.floor(self.WagonNumber%(10^(k+1))/10^k)										
            if IsValid(leftNum) then	
                leftNum:SetLocalPos(Vector(-310+k*6.6-4*6.6/2, 63.4, 18))
                leftNum:SetSkin(num)		
            end  								
			end
		end
end

local function GetDoorPositionRear(b,k,j)
	if j == 0 			--	x						--	y        --	z
	then return Vector(195.5 - -35.0*k - 232.1*b, -66*(1-2*k), 4.3)
	else return Vector(265.6 - 35.0*(1+k) - 232.1*b,-67.5*(1-2*k),4.3)
	end
end

    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,1,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

    local dT = self.DeltaTime

    local parking_brake = math.max(0,-self:GetPackedRatio("ParkingBrakePressure_dPdT",0))
    self.ParkingBrake = self.ParkingBrake+(parking_brake-self.ParkingBrake)*dT*10
    self:SetSoundState("parking_brake",self.ParkingBrake,1.4)
	
    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)	

    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    --print(dPdT)
    self:SetSoundState("release_front",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)	
    self:SetSoundState("release_middle",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)

for avar = 1,2 do	
    -----------------------Задняя часть	
    local colV = self:GetNW2Vector("Lamp7404"..avar)
    local col = Color(colV.x,colV.y,colV.z)		
    -----------------------Задняя часть
    -----------------------Передняя часть	
    self:ShowHideSmooth("lamps_salon_on_avar_front"..avar,self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,1,5,false),col)	
    -----------------------Передняя часть		
end	

for i = 0,11 do	
    -----------------------Передняя часть
    local colV = self:GetNW2Vector("Lamp7404"..i)
    local col = Color(colV.x,colV.y,colV.z)	
	self:ShowHideSmooth("lamps_salon_on_front"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false),col)
	self:ShowHideSmooth("lamps_salon_on_front_left"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false),col)
	-----------------------Передняя часть
end

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
	
    local PVZ_otsek = self:GetNW2Bool("PVZ_otsek")
    self:HidePanel("PVZ_otsek_close",not PVZ_otsek)
    self:HidePanel("PVZ_otsek_open", PVZ_otsek)	
    self:HidePanel("PVZ",not PVZ_otsek)		
	
    self:ShowHide("otsek",not PVZ_otsek)	
    self:ShowHide("otsek_open",PVZ_otsek)	

	local ZavodTable = self:GetNW2Int("ZavodTable",1)	
    self:ShowHide("Zavod_table_front",ZavodTable==1)	

	--Анимация дверей.
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for b=0,2 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(b+1),"door"..b.."x"..k
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
            local n_l = "door"..b.."x"..k.."a"
            local n_r = "door"..b.."x"..k.."b"						
            self:Animate(n_l,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
            self:Animate(n_r,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)	
        end
	end
	
    local door_f = self:GetPackedBool("FrontDoor")
    local door_cab_f = self:Animate("door_cab_f",door_f and 0.99 or -0.05, 0, 0.5, 4.5, 0.55)
	local door1s = (door_cab_f > 0 or door_f)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("FrontDoor","bass",door1s and 1 or 0)
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
    self:SetSoundState("rolling_low"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2",rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2"  ,rol70*rollings,rol70p) --70
	
    self:SetSoundState("rolling_low_middle"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2_middle",rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2_middle"  ,rol70*rollings,rol70p) --70

--[[	
    --local state = (RealTime()%4/3)^1.5
    --local strength = 1--self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-15)/15,0,1))
    local state = self:GetPackedRatio("asynccurrent")--^1.5--RealTime()%2.5/2	
    local strength = self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-23)/23,0,1))
	--print(state/0.3+0.2)
	--self:SetSoundState("async1", tunstreet*math.Clamp((state)/0.26+0.2,0,1)*strength, 1)
    --self:SetSoundState("chopper", tunstreet*self:GetPackedRatio("chopper"), 1)  	
	
    local state = self:GetPackedRatio("RNState")
    self.TISUVol = math.Clamp(self.TISUVol+(state-self.TISUVol)*dT*8,0,1)
	
	local AsyncSound = self:GetNW2Int("AsyncSound",1)
	if AsyncSound==1 then		
    self:SetSoundState("async1", self.TISUVol/1.5, 1)
	end
	if AsyncSound==2 then		
    self:SetSoundState("async2", self.TISUVol/1.5, 1)
	end		
	if AsyncSound==3 then		
    self:SetSoundState("async3", self.TISUVol/1.5, 1)
	end		
	if AsyncSound==4 then		
    self:SetSoundState("async4", self.TISUVol/1.5, 1)
	end		
	if AsyncSound==5 then		
    self:SetSoundState("async5", self.TISUVol/1.5, 1)
	end	
	if AsyncSound==6 then		
    self:SetSoundState("async6", self.TISUVol/1.5, 1)
	end		
	]]
	
    local state = self:GetPackedRatio("asynccurrent")--^1.5--RealTime()%2.5/2	
    local strength = self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-23)/23,0,1))*0.5
		
    self:SetSoundState("ONIX", tunstreet*math.Clamp((state)/0.26+0.2,0,1)*strength, 1)--+math.Clamp(state,0,1)*0.1)
    self:SetSoundState("chopper_onix", tunstreet*self:GetPackedRatio("chopper"), 1)			

    local work = self:GetPackedBool("AnnPlay")
    for k,v in ipairs(self.AnnouncerPositions) do
        if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume(work and (v[3] or 1)  or 0.7)
        end
    end
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end

function ENT:DrawPost(special)
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("Tickers",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
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
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()