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
--
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}
--
ENT.ClientPropsInitialized = false

--[[ENT.ClientProps["test_prop"] = {
	model = "models/props_junk/metalbucket01a.mdl", --Заготовка под информатор нормальный.
	pos = Vector(190,-34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop1"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(-38,-34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop2"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(-275,-34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop3"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(-228,34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop4"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(3,34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
ENT.ClientProps["test_prop5"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(235,34,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}]]

ENT.ClientProps["salonR"] = {
	model = "models/metrostroi_train/81-740/salon/salon_rear.mdl",
    pos = Vector(-211.2, 0, 5.5),
    ang = Angle(0,180,0),
	hide = 1.5, 	
}
--Новые модели 2023
ENT.ClientProps["Naddver_off_740"] = { 
    model = "models/metrostroi_train/81-740/salon/naddverka_off_740.mdl",
	pos = Vector(-15.8,-37.15,57.1),
    ang = Angle(0,0,0),
	scale = 1,	
}
ENT.ClientProps["Zavod_table_sochl"] = { 
    model = "models/metrostroi_train/81-740/salon/zavod.mdl",
	pos = Vector(287.2,44,48),
    ang = Angle(90,-180,0),
	scale = 3,
	hide = 1,		
}
ENT.ClientProps["Zavod_table_sochl_torec"] = { 
    model = "models/metrostroi_train/81-740/salon/zavod.mdl",
	pos = Vector(-332.4,-20,59),
    ang = Angle(90,0,0),
	scale = 3,
	hide = 1, 	
}

ENT.ClientProps["krepezh"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(64.5, 0, -75.2),
    ang = Angle(0,180,0), 
	nohide = true,   	  
}
ENT.ClientProps["handrails_offside"] = {
    model = "models/metrostroi_train/81-740/body/740_body_additional.mdl",
    pos = Vector(21.8, 10, -76.5),
    ang = Angle(0,180,0),   
	nohide = true,	
}
ENT.ClientProps["handrails"] = {
	model = "models/metrostroi_train/81-740/salon/handrails/handrails_r.mdl",
    pos = Vector(-116.7, -1, -75),
    ang = Angle(0,180,0),
	hide = 1.5, 	
}
ENT.ClientProps["lamps_salon_off_r"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_off.mdl",
    pos = Vector(1.1, 0.05, -0.4),
    ang = Angle(0,0,0), 
	hide = 2,
}
ENT.ClientProps["door_cab_t"] = {
	model = "models/metrostroi_train/81-740/salon/door_br.mdl",
	pos = Vector(-334.5, 15, 8.8), 
	ang = Angle(0,180,0),
	hide = 1.5, 	
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-332,-15,55), ---334.8,14.5,9
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2, 	
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=2000,"", model = {
            var="RearDoor",sndid="door_cab_t",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},   
	}	
}
ENT.ButtonMap["RearDoor_front"] = {
    pos = Vector(-337,15,55), ---334.8,14.5,9
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2, 	
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=2000,"", model = {
            var="RearDoor_front",sndid="door_cab_t",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},   
	}	
}

ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-206-131,45,-46),
    ang = Angle(180,90,270),
    width = 900,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
	screenHide = true,
	
    buttons = {
		{ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip=""},
		{ID = "RearBrakeLineIsolationToggle",x=0, y=0, w=400, h=100,tooltip=""},
    }
}	
ENT.ClientProps["RearTrain"] = {
	model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
	pos = Vector(-336, -25, -54),
	ang = Angle(0,90,0),
	hide = 1,			
}
ENT.ClientProps["RearBrake"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
	pos = Vector(-336, 25, -54),
	ang = Angle(0,90,0),
	hide = 2,	
}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,5,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["Tickers_rear"] = {
	pos = Vector(286.2,27,65.85), --446 -- 14 -- -0,5
	ang = Angle(0,-90,90),
	width = 1024,
	height = 64,
	scale = 0.054,
	hide=true,
	hideseat=1,		
}	
	
ENT.ClientProps["lamps_salon_on_rear_avar1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(-197.3, 0.3, -74.885),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
	hide = 1,     	 
}
ENT.ClientProps["lamps_salon_on_rear_avar2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(286.15, -57.8, -74.88),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
	hide = 1,	
}
for i = 1,11 do
ENT.ClientProps["lamps_salon_on_rear"..i-1] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(341.5-54*i+1,0.3,-74.92),
    ang = Angle(0,180,0),
    color = Color(245,238,223),	
	hide = 1,  	
}

ENT.ClientProps["lamps_salon_on_rear1"..i] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(341.5-54*i+1,-57.78,-74.88),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
	hide = 1, 	   
}
end

local function GetDoorPosition(n,G,j)
	if j == 0 			--	x						--	y        --	z
	then return Vector(195.5 - -35.0*G - 232.1*n, -66*(1-2*G), 4.3)
	else return Vector(265.6 - 35.0*(1+G) - 232.1*n,-67.5*(1-2*G),4.3)
	end
end

for n=0,2 do
	for G=0,1 do
		ENT.ClientProps["door"..n.."x"..G.."a"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl",
			pos = GetDoorPosition(n,G,0),
			ang = Angle(0,90 +180*G,0), 
			hide = 2,				
			scale = 1.001,			    			
		}
		ENT.ClientProps["door"..n.."x"..G.."b"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl",
			pos = GetDoorPosition(n,G,1),
			ang = Angle(0,90 +180*G,0),
			hide = 2,					
			scale = 1.001,		  			
		}
		end
end

local yventpos = {
    414.5+0*117-159,
	414.5+2*117+5-159,
	214.5+4*117+0.5-15,
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
	
    self.PassengerEnts = {}
    self.PassengerEntsStucked = {}	
    self.PassengerPositions = {}	

	self.PassengerModels = {
        "models/metrostroi/passengers/f1.mdl",
        "models/metrostroi/passengers/f2.mdl",
        "models/metrostroi/passengers/f3.mdl",
        "models/metrostroi/passengers/f4.mdl",
	    "models/metrostroi/passengers/f5.mdl",	
        "models/metrostroi/passengers/m1.mdl",
        "models/metrostroi/passengers/m2.mdl",
	    "models/metrostroi/passengers/m3.mdl",	
        "models/metrostroi/passengers/m4.mdl",
        "models/metrostroi/passengers/m5.mdl",
    }
    self:GetNW2Entity("HeadTrain").PreviousCompressorState = false			
	
    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,4 do
        self.VentRand[i] = math.Rand(0.5,2)
        self.VentState[i] = 0
        self.VentVol[i] = 0
    end	
end	

function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end 	
    self.HeadTrain = self:GetNW2Entity("HeadTrain")	
    local train = self.HeadTrain 
    if not IsValid(train) then return end		
	
for k=0,3 do
self.ClientProps["TrainNumberL"..k] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(-310+k*6.6-4*6.6/2, 63.4, 18),
        ang = Angle(0,180,-3.29),
        hide = 1,
        callback = function(self)
            train.WagonNumber = false 
		end,
    } 
end

--[[train.ClientProps["test_prop"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(-140,0,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
train.ClientProps["test_prop_1"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(-360,0,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}
train.ClientProps["test_prop_2"] = {
	model = "models/props_junk/metalbucket01a.mdl",
	pos = Vector(-590,0,55),
	ang = Angle(0,0,0),
	scale = 0.5,	
	nohide = true,
}]]
for avar = 1,2 do
	local animation = math.random (5,12)	
	local animation1 = math.random (0.5,1)	
    local colV = self:GetNW2Vector("Lamp7404"..avar)
    local col = Color(colV.x,colV.y,colV.z)	
	if not IsValid(train) then return end		
	self:ShowHideSmooth("lamps_salon_on_rear_avar"..avar,train:Animate("LampsEmer",train:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,animation1,animation,false),col)  
end	

    local state = self:GetPackedBool("CompressorWork")
    self:SetSoundState("compressor",state and 1.0 or 0,1)

for i = 1,11 do	
    local colV = self:GetNW2Vector("Lamp7404"..i)
    local col = Color(colV.x,colV.y,colV.z)	   
	if not IsValid(train) then return end	
	self:ShowHideSmooth("lamps_salon_on_rear"..i-1,train:Animate("LampsFull",train:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)	
    self:ShowHideSmooth("lamps_salon_on_rear1"..i,train:Animate("LampsFull",train:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)	
end
	
	local ZavodTable = train:GetNW2Int("ZavodTable",1)	
    if not IsValid(train) then return end		
    self:ShowHide("Zavod_table_sochl",ZavodTable==2)
    self:ShowHide("Zavod_table_sochl_torec",ZavodTable==3)
	
	--Анимация дверей.
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    if not IsValid(train) then return end		
    for b=0,2 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = train:GetPackedBool(st)
            local id,sid = st..(b+1),"door"..b.."x"..k
            local state = train:GetPackedRatio(id)
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
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*train.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*train.DeltaTime,0,1)
            end
	        self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.9+self.DoorLoopStates[id]*0.1)					
			local n_l1 = "door"..b.."x"..k.."a"
            local n_r1 = "door"..b.."x"..k.."b"							
            self:Animate(n_r1,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)			
			self:Animate(n_l1,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
        end
	end	
	
    if not IsValid(train) then return end	
	local dT = train.DeltaTime		
    train.RearLeak = math.Clamp(train.RearLeak + 10*(-train:GetPackedRatio("RearLeak")-train.RearLeak)*dT,0,1)	
    self:SetSoundState("rear_isolation",train.RearLeak,0.9+0.2*train.RearLeak)	

    if not IsValid(train) then return end		
    self:Animate("RearBrake", train:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain", train:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)	
	
    local dPdT = train:GetPackedRatio("BrakeCylinderPressure_dPdT")
    if not IsValid(train) then return end		
    train.ReleasedPdT = math.Clamp(train.ReleasedPdT + 4*(-train:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-train.ReleasedPdT)*dT,0,1)
    self:SetSoundState("release_rear",math.Clamp(train.ReleasedPdT,0,1)^1.65,1.0)		
	
	local speed = train:GetPackedRatio("Speed", 0)

    local ventSpeedAdd = math.Clamp(speed/30,0,1)

    local vstate = self:GetPackedBool("Vent2Work")
    if not IsValid(train) then return end		
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
		
		local VentSound = train:GetNW2Int("VentSound",1)	
		if VentSound==1 then
        self:SetSoundState("vent"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
		end	
		if VentSound==2 then
        self:SetSoundState("vent1"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
		end 	
    end		
	
    if not IsValid(train) then return end		
	local BBEs = train:GetNW2Int("BBESound",1)	
	if BBEs==1 then		
    self:SetSoundState("bbe_v1", self:GetPackedBool("BBEWork") and 1 or 0, 1)
	end
	if BBEs==2 then		
    self:SetSoundState("bbe_v2", self:GetPackedBool("BBEWork") and 1 or 0, 1)
	end	
	if BBEs==3 then		
    self:SetSoundState("bbe_v3", self:GetPackedBool("BBEWork") and 1 or 0, 1)
	end		
   
	local door_cab_t = self:Animate("door_cab_t",self:GetPackedBool("RearDoor") and 0.99 or -0.05, 0, 0.55, 4.5, 0.55) 	
	local door4s = (door_cab_t > 0 or self:GetPackedBool("RearDoor"))
    if self.Door4 ~= door4s then
        self.Door4 = door4s
        self:PlayOnce("RearDoor","bass",door4s and 1 or 0)
    end

    self.HeadTrain = self:GetNW2Entity("HeadTrain")	
    local train = self.HeadTrain 
    if not IsValid(train) then return end		
	
    local work = train:GetPackedBool("AnnPlay")	
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
    return soundid,location,range,pitch
end 

function ENT:DrawPost(special)
    self.HeadTrain = self:GetNW2Entity("HeadTrain")	
    local train = self.HeadTrain	
    if not IsValid(train) then return end		
	self.RTMaterial:SetTexture("$basetexture", train.Tickers)		
    self:DrawOnPanel("Tickers_rear",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
end

Metrostroi.GenerateClientProps()