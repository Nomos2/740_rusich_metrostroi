local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk")
or Map:find("gm_metro_krl")
--or Map:find("gm_metro_kaluzh_line")
--or Map:find("gm_metro_kaluzhkaya_line")
or Map:find("gm_metro_demixovo")
or Map:find("gm_metrostroi_demixovo")
or Map:find("gm_moscow_line_7")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_bolshua_kolsevya_line")
or Map:find("kahovskya_line11a")
or Map:find("varshavskoe1")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")
or Map:find("gm_metropbl")) then 
	return
end 

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "EnableBVEmer","Ticker","KAH","ALS","ALSk","FDepot","PassScheme","EnableBV","DisableBV","Ring","R_Program2","R_Announcer","R_Line","R_Emer","R_Program1",
    "DoorSelectL","DoorSelectR","DoorBlock","TPT","RTE","ABSD",
    "EmerBrakeAdd","EmerBrakeRelease","EmerBrake","DoorClose","AttentionMessage","Attention","AttentionBrake","EmergencyBrake",
    "SF1","SF2","SF3","SF4","SF5","SF6","SF7","SF8","SF9","SF10","SF11","SF12",
    "SF13","SF14","SF15","SF16","SF17","SF18","SF19","SF20","SF21","SF22",

    "SFV1","SFV2","SFV3","SFV4","SFV5","SFV6","SFV7","SFV8","SFV9","SFV10","SFV11",
    "SFV12","SFV13","SFV14","SFV15","SFV16","SFV17","SFV18","SFV19","SFV20","SFV21","SFV22",
    "SFV23","SFV24","SFV25","SFV26","SFV27","SFV28","SFV29","SFV30","SFV31","SFV32","SFV33","SFV34","SFV35",

    "Stand","EmergencyCompressor","EmergencyControls","Wiper","DoorLeft","AccelRate","HornB","DoorRight",

    "Pant1","Pant2","Vent2","Vent","PassLight","CabLight","Headlights1","Headlights2",
    "ParkingBrake","TorecDoors","BBER","BBE","Compressor","CabLightStrength","AppLights1","AppLights2",
    "Battery", "ALSFreqBlock",
    "VityazF1", "VityazF2", "VityazF3", "VityazF4", "Vityaz1",  "Vityaz4",  "Vityaz7",  "Vityaz2",  "Vityaz5",  "Vityaz8",  "Vityaz0",  "Vityaz3",  "Vityaz6",  "Vityaz9",  "VityazF5", "VityazF6", "VityazF7", "VityazF8", "VityazF9",
    "K29", "UAVA", "EmerBrakeCrane1","EmerBrakeCrane2",
    "EmerX1","EmerX2","EmerCloseDoors","EmergencyDoors",
    "R_ASNPMenu","R_ASNPUp","R_ASNPDown","R_ASNPOn",
    "VentHeatMode",
	
	--"CAMS1","CAMS2","CAMS3","CAMS4",
	"CAMS5","CAMS6","CAMS7","CAMS8","CAMS9","CAMS10",
    "PB",   "GV",	"EmergencyBrakeValve","stopkran",
}

function ENT:Initialize()
    -- Set model and initialize		
	self:SetModel("models/metrostroi_train/81-740/body/81-740_4_front.mdl")	
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))
	
    self.NormalMass = 24000

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(775-159-9,19,-27))
    self.InstructorsSeat = self:CreateSeat("instructor",Vector(586-15-9,-40,-30),Angle(0,90,0),"models/nova/jeep_seat.mdl")
    self.InstructorsSeat2 = self:CreateSeat("instructor",Vector(767-159-9,45,-35),Angle(0,75,0),"models/vehicles/prisoner_pod_inner.mdl") 
    self.InstructorsSeat4 = self:CreateSeat("instructor",Vector(787-159-9,-25,-40),Angle(0,115,0),"models/vehicles/prisoner_pod_inner.mdl")	

    --Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.DriverSeat:SetColor(Color(0,0,0,0))
	self.DriverSeat.m_tblToolsAllowed = {"none"}		
	
    self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat:SetColor(Color(0,0,0,0))
	self.InstructorsSeat.m_tblToolsAllowed = {"none"}	
	
    self.InstructorsSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat2:SetColor(Color(0,0,0,0))
	self.InstructorsSeat2.m_tblToolsAllowed = {"none"}	
	
    self.InstructorsSeat4:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat4:SetColor(Color(0,0,0,0))
	self.InstructorsSeat4.m_tblToolsAllowed = {"none"}		
	
	self.LightSensor = self:AddLightSensor(Vector(627-9,0,-125),Angle(0,90,0))
	self.ASSensor = self:AddLightSensor(Vector(515-9,-45,-95),Angle(90,0,0),"models/hunter/blocks/cube05x2x025.mdl") --для МСМП
	
    -- Create bogeys
        self.FrontBogey = self:CreateBogey(Vector( 520-25,0,-80),Angle(0,180,0),true,"740PER")	
        self.RearBogey  = self:CreateBogey(Vector(-15-25.5,0,-80),Angle(0,0,0),false,"740G") --110 0 -80  -532-25,0,-80
        self.RearBogey:SetMoveType(MOVETYPE_VPHYSICS)	
		self.FrontBogey:SetNWInt("MotorSoundType",2)
		self.RearBogey:SetNWInt("MotorSoundType",2)			
        self.FrontCouple = self:CreateCouple(Vector(627-14,0,-60),Angle(0,0,0),true,"740")
        self.RearCouple = self:CreateCouple(Vector(-641-9,0,-60),Angle(0,-180,0),false,"740")
        self.RearCouple:PhysicsInit(SOLID_VPHYSICS)
        self.RearCouple:SetMoveType(MOVETYPE_VPHYSICS)
        self.RearCouple:SetSolid(SOLID_VPHYSICS)
		self.RearCouple:GetPhysicsObject():SetMass(5000)		
		
		self.FrontCouple.m_tblToolsAllowed = {"none"}
		self.RearCouple.m_tblToolsAllowed = {"none"}	
		self.FrontBogey.m_tblToolsAllowed = {"none"}	
		self.RearBogey.m_tblToolsAllowed = {"none"}
		self:SetNW2Entity("FrontBogey",self.FrontBogey)
		self:SetNW2Entity("RearBogey",self.RearBogey)
		local opt = Vector(70,0,0)
		self.FrontCouple.CouplingPointOffset = opt		 
		self.RearCouple.CouplingPointOffset = Vector(85,0,0)   		
		
	timer.Simple(0.1, function()			
        if not IsValid(self) then return end
		self.Pricep = self:CreatePricep(Vector(0,0,0))--вагон	
		local opt65 = Vector(65,0,0)	
		self.RearCouple.CouplingPointOffset = opt65
		self.FrontCouple.CouplingPointOffset = opt65			
	end)
	
	self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)	
	
	self.FrontCouple.EKKDisconnected = true

    local rand = math.random()*0.05
    self.FrontBogey:SetNWFloat("SqualPitch",1.45+rand)
    self.RearBogey:SetNWFloat("SqualPitch",1.45+rand)	
			
    -- Initialize key mapping
    self.KeyMap = {
        [KEY_W] = "PanelKVUp",
        [KEY_S] = "PanelKVDown",
        [KEY_1] = "PanelKV1",
        [KEY_2] = "PanelKV2",
        [KEY_3] = "PanelKV3",
        [KEY_4] = "PanelKV4",
        [KEY_5] = "PanelKV5",
        [KEY_6] = "PanelKV6",
        [KEY_7] = "PanelKV7",
        [KEY_8] = "PanelKV8",
        [KEY_9] = "KRO-",
        [KEY_0] = "KRO+",

        [KEY_A] = "DoorLeft",
        [KEY_D] = "DoorRight",
        [KEY_V] = "DoorClose",
        [KEY_G] = "EnableBVSet",
        [KEY_SPACE] = {
            def="PBSet",
            [KEY_LSHIFT] = "AttentionBrakeSet",
        },
	    [KEY_N] = "TPTToggle",		

        [KEY_PAD_ENTER] = "KVWrenchKV",
        [KEY_EQUAL] = "R_Program1Set",
        [KEY_RBRACKET] = "R_Program1Set",
        [KEY_MINUS] = "R_Program2Set",
        [KEY_LSHIFT] = {
            def="PanelControllerUnlock",
            [KEY_SPACE] = "AttentionBrakeSet",
            [KEY_V] = "EmergencyDoorsToggle",
            --[KEY_7] = "WrenchNone",
            --[KEY_8] = "WrenchKRR",
            [KEY_9] = "KRR-",
            [KEY_0] = "KRR+",
            [KEY_G] = "EnableBVEmerSet",
            [KEY_2] = "RingSet",
            [KEY_L] = "HornEngage",

            [KEY_PAD_ENTER] = "KVWrenchNone",
        },
        [KEY_LALT] = {
            [KEY_V] = "DoorCloseToggle",
            [KEY_PAD_1] = "Vityaz1Set",
            [KEY_PAD_2] = "Vityaz2Set",
            [KEY_PAD_3] = "Vityaz3Set",
            [KEY_PAD_4] = "Vityaz4Set",
            [KEY_PAD_5] = "Vityaz5Set",
            [KEY_PAD_6] = "Vityaz6Set",
            [KEY_PAD_7] = "Vityaz7Set",
            [KEY_PAD_8] = "Vityaz8Set",
            [KEY_PAD_9] = "Vityaz9Set",
            [KEY_PAD_0] = "Vityaz0Set",
            [KEY_PAD_DECIMAL] = "VityazF5Set",
            [KEY_PAD_ENTER] = "VityazF8Set",
            [KEY_UP] = "VityazF6Set",
            [KEY_LEFT] = "VityazF5Set",
            [KEY_DOWN] = "VityazF7Set",
            [KEY_RIGHT] = "VityazF9Set",
            [KEY_PAD_MINUS] = "VityazF2Set",
            [KEY_PAD_PLUS] = "VityazF3Set",
            [KEY_PAD_MULTIPLY] = "VityazF4Set",
            [KEY_PAD_DIVIDE] = "VityazF1Set",
            [KEY_SPACE] = "AttentionMessageSet",
        },
        [KEY_PAD_PLUS] = "EmerBrakeAddSet",
        [KEY_PAD_MINUS] = "EmerBrakeReleaseSet",
        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",

        [KEY_PAD_DIVIDE] = "EmerX1Set",
        [KEY_PAD_MULTIPLY] = "EmerX2Set",
        [KEY_PAD_9] = "EmerBrakeToggle",

		
        [KEY_BACKSPACE] = "EmergencyBrakeToggle",
        [KEY_L] = "HornBSet",
    }
    self.KeyMap[KEY_RALT] = self.KeyMap[KEY_LALT]
    self.KeyMap[KEY_RSHIFT] = self.KeyMap[KEY_LSHIFT]
    self.KeyMap[KEY_RCONTROL] = self.KeyMap[KEY_LCONTROL]

    -- Cross connections in train wires
    self.TrainWireCrossConnections = {
        [4] = 3, -- Orientation F<->B
        [13] = 12, -- Reverser F<->B
        [38] = 37, -- Doors L<->R
    }

 self.Lights = {
        --белые огни
        [1]  = { "light",Vector(832-159-9, 27.5, -23), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [2]  = { "light",Vector(832-159-9, 40.5,-20.5), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [18]  = { "light",Vector(832-159-9, -27.5, -23), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [19]  = { "light",Vector(832-159-9, -40.5, -20.5), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        --красные огни 
        [3] = { "light",Vector(690-14.5-9, 41.5, -60), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[4] = { "light",Vector(690-14.5-9, -41.5, -60), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[5] = { "light",Vector(656-14.5-9, 40, 57), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[6] = { "light",Vector(656-14.5-9, -40, 57), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
        --освещение в кабине
        [10] = { "dynamiclight",    Vector( 755-159-9, 0, 40), Angle(0,0,0), Color(206,135,80), brightness = 1.5, distance = 550 },
        -- Interior
		[11] = { "dynamiclight",    Vector(260-159-9, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
		[12] = { "dynamiclight",    Vector(420-159-9, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [13] = { "dynamiclight",    Vector(675-159-9, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 },
    }
	
	self.InteractionZones = {
		{
			ID = "CabinDoorLeft", 
			Pos = Vector(476-9, 64, -30),Radius = 48,
        },    	
        {
			ID = "CabinDoorRight", 
			Pos = Vector(466-9, -60, -30),Radius = 48,
	    },	
		
        --[[{
			ID = "OtsekDoor",
			Pos = Vector(200, 39, 11),Radius = 48,
        },]]
		
		{
			ID = "FrontBrakeLineIsolationToggle",
			Pos = Vector(830-159-9,-25.0,-42), Radius = 14,
        },
		{
			ID = "FrontTrainLineIsolationToggle",
			Pos = Vector(830-159-9,25.0,-42), Radius = 14,
        },
		{
			ID = "GVToggle",
			Pos = Vector(222-15-9,-17,-82), Radius = 20,
        },
    }
	
    self.PassengerDoor = false
    self.CabinDoorLeft = false
    self.CabinDoorRight = false
    self.OtsekDoor = true
    self.WrenchMode = 1
	self.Antenna = false	
	self.Password = false
	self.KVWrenchMode = self.WrenchMode

--наложение пломб
	self.Plombs = {
        ALS = {true,"ALSk"},
        ALSk = true,
        BARSBlock = true,
        RTE = true,
        ABSD = true,
        UAVA = true,
        Init = true,
		R_ASNPOn = true,		
    }
	self.Lamps = {
        broken = {},
    }	
	
    local rand = math.random() > 0.9 and 1 or math.random(0.95,0.99)
    for i = 1,20 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.7 end
    end
	
	self.HeadLightBroken = {}
	self.RedLightBroken = {}
	
    self:UpdateLampsColors()	
end
--если на карте нету сигналки включить ВП
function ENT:NonSupportTrigger()
    self.ALS:TriggerInput("Set",1)
    self.ALSk:TriggerInput("Set",0)
    self.Plombs.ALS = nil
    self.Plombs.ALSk = nil
end
function ENT:TriggerLightSensor(coil,plate)
	self.Prost_Kos:Think()
end

function ENT:TrainSpawnerUpdate()
	for i = 1,4 do
		self:SetNW2Int("DoorsAnim"..i,math.random(5,15))
	end
		local sp = math.random (-6,-15)		
		local sp1 = math.random (10,17)			
		--скорость дверей
		for k,v in pairs(self.Pneumatic.LeftDoorSpeed) do
			self.Pneumatic.LeftDoorSpeed[k] = -15.1 + math.random(-sp,sp1) / 4
		end
		
		for k,v in pairs(self.Pneumatic.RightDoorSpeed) do
			self.Pneumatic.RightDoorSpeed[k] = -15.1 + math.random(-sp,sp1) / 4
		end	

	--рандом поломанных фар	
	self.HeadLightBroken = {}
	for i = 1, 4 do
		if math.random(1, 20) == 1 then 
			self.HeadLightBroken[i] = true				
			self:SetNW2Bool("HeadLightBroken"..i, true)
		else
			self.HeadLightBroken[i] = false		
			self:SetNW2Bool("HeadLightBroken"..i, false)
		end
	end
	self.RedLightBroken = {}
	for i = 1, 4 do
		if math.random(1, 90) == 1 then 
			self.RedLightBroken[i] = true				
			self:SetNW2Bool("RedLightBroken"..i, true)
		else
			self.RedLightBroken[i] = false		
			self:SetNW2Bool("RedLightBroken"..i, false)
		end
	end
	
	--рандом поломанных ламп в салоне
	self.SalonLightBroken = {}
	for i = 1, 9 do
		if math.random(1, 15) == 1 then 
			self.SalonLightBroken[i] = true				
			self:SetNW2Bool("SalonLightBroken"..i, true)
		else
			self.SalonLightBroken[i] = false		
			self:SetNW2Bool("SalonLightBroken"..i, false)
		end	
	end	
    
    local bukpType = self:GetNW2Int("BUKPVersion")
    self.BUKP:TriggerInput("OldVersion",(bukpType == 1 and math.random() > 0.3) or bukpType == 2)

	local MotorType = self:GetNW2Int("MotorType")	
       if MotorType == 1 then
            MotorType = math.ceil(math.random()*4+0.5)
          else MotorType = MotorType-1 end	
	self:SetNW2Int("MotorType",MotorType)	
	
	local RingSound = self:GetNW2Int("RingSound")	
       if RingSound == 1 then
            RingSound = math.ceil(math.random()*3+0.5)
          else RingSound = RingSound-1 end	
	self:SetNW2Int("RingSound",RingSound)		

	local ZavodTable = self:GetNW2Int("ZavodTable")	
       if ZavodTable == 1 then
            ZavodTable = math.ceil(math.random()*1+0.5)
          else ZavodTable = ZavodTable-1 end	
	self:SetNW2Int("ZavodTable",ZavodTable)		

	local VentSound = self:GetNW2Int("VentSound")	
       if VentSound == 1 then
            VentSound = math.ceil(math.random()*1+0.5)
          else VentSound = VentSound-1 end	
	self:SetNW2Int("VentSound",VentSound)	
    self:UpdateLampsColors()
end

function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),0
	local mr = math.random
    local rand = mr() > 0.8 and 1 or mr(0.95,0.99)
	local rnd1,rnd2,col = 0.7+mr()*0.3,mr()
	local typ = math.Round(mr())
	local r,g = 15,15
	for i = 1,20 do
		local chtp = mr() > rnd1
		if typ == 0 and not chtp or typ == 1 and chtp then
			if mr() > rnd2 then
				r = -20+mr()*25
				g = 0
			else
				g = -5+mr()*15
				r = g
			end
			col = Vector(245+r,228+g,189)
		else
			if mr() > rnd2 then
				g = mr()*15
				b = g
			else
				g = 15
				b = -10+mr()*25
			end
			col = Vector(255,235+g,235+b)
		end
		lCol = lCol + col
		lCount = lCount + 1
		if i%8.3<1 then
			local id = 9+math.ceil(i/8.3)
			--self:SetLightPower(id,false)
			local tcol = (lCol/lCount)/255
			--self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
			lCol = Vector() lCount = 0
		end
		self:SetNW2Vector("Lamp7404"..i,col)
        self.Lamps.broken[i] = math.random() > rand and math.random() > 0.7
	end
end

--[[function ENT:ReplaceWheelsSound()
	if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and IsValid(self.FrontBogey.Wheels) and IsValid(self.RearBogey.Wheels) then
		local FrontBogeyWheels,RearBogeyWheels = self.FrontBogey.Wheels.PhysicsCollide,self.RearBogey.Wheels.PhysicsCollide
		FrontBogeyWheels = function(data,physobj)
			if data.HitEntity and data.HitEntity:IsValid() and data.HitEntity:GetClass() == "prop_door_rotating" then
				FrontBogeyWheels.LastJunctionTime = FrontBogeyWheels.LastJunctionTime or CurTime()
				local dt = CurTime() - FrontBogeyWheels.LastJunctionTime
	
				if dt > 3.5 then
					local speed = FrontBogeyWheels:GetVelocity():Length() * 0.06858
					if speed > 10 then
						FrontBogeyWheels.LastJunctionTime = CurTime()
	
						local pitch_var = math.random(90,110)
						local pitch = pitch_var*math.max(0.8,math.min(1.3,speed/40))
						FrontBogeyWheels:EmitSound("subway_trains/740_4/bogey/junct_"..math.random(2,3)..".wav",100,pitch )
					end
				end
			end
		end
		RearBogeyWheels = function(data,physobj)
			if data.HitEntity and data.HitEntity:IsValid() and data.HitEntity:GetClass() == "prop_door_rotating" then
				RearBogeyWheels.LastJunctionTime = RearBogeyWheels.LastJunctionTime or CurTime()
				local dt = CurTime() - RearBogeyWheels.LastJunctionTime
	
				if dt > 3.5 then
					local speed = RearBogeyWheels:GetVelocity():Length() * 0.06858
					if speed > 10 then
						RearBogeyWheels.LastJunctionTime = CurTime()
	
						local pitch_var = math.random(90,110)
						local pitch = pitch_var*math.max(0.8,math.min(1.3,speed/40))
						RearBogeyWheels:EmitSound("subway_trains/740_4/bogey/junct_"..math.random(2,3)..".wav",100,pitch )
					end
				end
			end
		end
	end
end]] --Попытка замены звуков тележек от Димастерса.

function Metrostroi:RerailChange(ent, bool)
    if not IsValid(ent) then return end
    if bool then
        timer.Remove("metrostroi_rerailer_solid_reset_"..ent:EntIndex())    
    else
        timer.Create("metrostroi_rerailer_solid_reset_"..ent:EntIndex(),1e9,1,function() end)    
    end
end
	
function ENT:CreatePricep(pos,ang)
	local ent = ents.Create("gmod_subway_kuzov")		
    if not IsValid(ent) then return end
	ent:SetPos(self:LocalToWorld(Vector(-356-9,0,0)))
	ent:SetAngles(self:LocalToWorldAngles(Angle(0,0,0)))	
	ent:Spawn()
	ent:SetOwner(self:GetOwner())	
	ent:DrawShadow(false)
	if CPPI and IsValid(self:CPPIGetOwner()) then ent:CPPISetOwner(self:CPPIGetOwner()) end
	self:SetNW2Entity("gmod_subway_kuzov",ent)
	
	table.insert(self.TrainEntities,ent)      
    table.insert(ent.TrainEntities,self)	
	
	self.PricepBogey = self:CreateBogey(Vector(-532-25,0,-80),Angle(0,0,0),true,"740NOTR")--тележка  ---160,0,-75 -410,0,-75 -15-25.5,0,-80	
	self:SetNW2Entity("PricepBogey",self.PricepBogey)
	self.PricepBogey = self:GetNW2Entity("PricepBogey")	
	local PB = self.PricepBogey 
	if not IsValid(PB) then return end		
    local rand = math.random()*0.05
	PB:SetNWFloat("SqualPitch",1.45+rand)
	PB:SetNWInt("MotorSoundType",2)
	PB:SetNWInt("Async",true)
	PB.m_tblToolsAllowed = {"none"}
	PB:PhysicsInit(SOLID_VPHYSICS)    
	PB.DisableContacts = true
    constraint.NoCollide(ent,self,0,0)	
	self.FrontBogey = self:GetNW2Entity("FrontBogey")	
	local FB = self.FrontBogey 	
	self.RearBogey = self:GetNW2Entity("RearBogey")	
	local RB = self.RearBogey
	
	constraint.Axis(
		PB,		
		ent,
		0,
		0,
		Vector(0,0,0),
		Vector(0,0,0),
        0,
		0,
		0,
		0,
		Vector(0,0,-1),
	false)
	--Сцепка, крепление к вагону.
	constraint.AdvBallsocket(
		ent,
        self.RearCouple,
        0, --bone
        0, --bone
        Vector(-281,0,-60),
        Vector(0,0,0),
        1, --forcelimit
        1, --torquelimit
        -2, --xmin
        -2, --ymin
        -15, --zmin
        2, --xmax
        2, --ymax
        15, --zmax
        0.1, --xfric
        0.1, --yfric
        1, --zfric
        0, --rotonly
        1, --nocollide
	false) 		
	
	local Map = game.GetMap():lower() or ""    	
	if Map:find("gm_mustox_neocrimson_line") or
	Map:find("gm_mus_neoorange") or
	Map:find("gm_metro_kalinin") or	
	Map:find("gm_metro_nekrasovskaya_line") or	
	Map:find("gm_metro_pink_line_redux") or
	Map:find("gm_jar_pll_redux") or
	Map:find("gm_metro_crossline") or	
	Map:find("gm_metro_mosldl") or	
	Map:find("gm_metro_nsk_line") or		
	Map:find("gm_metro_jar_imagine_line") or	
	Map:find("gm_smr_1987") then	
	
	constraint.Axis(
		RB,
		ent,
		0,
		0,
        Vector(0,0,0),
		Vector(0,0,0),
        0,
		0,
		0,
		1,
		Vector(0,0,1),
	false) 
	
	else
	
	local zmin = -45
	local zmax = 45
	
   RB:SetSolid(SOLID_VPHYSICS)
	
  constraint.AdvBallsocket( 
		RB,
		self,
		0, 
		0, 
		Vector(0,0,25),
		pos, 
		0, 
		0, 
		
        -5, --xmin
        -5, --ymin
        zmin, --zmin
        5, --xmax
        5, --ymax
        zmax, --zmax
		
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1,--nocollide
		false		
	) 
	constraint.AdvBallsocket( 
		RB,
		self,
		0, 
		0, 
		Vector(0,0,-40),
		pos, 
		0, 
		0, 
		
        -5, --xmin
        -5, --ymin
        zmin, --zmin
        5, --xmax
        5, --ymax
        zmax, --zmax
		
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1,--nocollide
		false		
	) 		
	
	constraint.AdvBallsocket( 
		ent,
		RB,
		0, 
		0, 
		Vector(310,0,20),
		pos, 
		0, 
		0, 
		
        -2, --xmin
        -2, --ymin
        zmin, --zmin
        2, --xmax
        2, --ymax
        zmax, --zmax
		
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1,--nocollide
		false		
	) 
	constraint.AdvBallsocket( 
		ent,
		RB,
		0, 
		0, 
		Vector(310,0,-40),
		pos, 
		0, 
		0, 
		
        -2, --xmin
        -2, --ymin 
        zmin, --zmin
        2, --xmax
        2, --ymax
        zmax, --zmax
		
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1,--nocollide
		false		
	) 	
	end
	
    Metrostroi:RerailChange(FB, true)
    Metrostroi:RerailChange(PB, true)
    Metrostroi:RerailChange(RB, true)		

	--Метод mirror 				
    ent.HeadTrain = self 
    ent:SetNW2Entity("HeadTrain", self)
	
	ent.ButtonBuffer = {}
	ent.KeyBuffer = {}
	ent.KeyMap = {}			
	
	return ent
end
---------------------------------------------------------------------------
function ENT:Think()
    local retVal = self.BaseClass.Think(self)
    local power = self.Electric.Battery80V > 62
    local powerPPZ = (power and self.SF1.Value > 0) or self.Electric.ReservePower > 0
	local Panel = self.Panel	
    local state = math.abs(self.AsyncInverter.InverterFrequency/(11+self.AsyncInverter.State*5))--(10+8*math.Clamp((self.AsyncInverter.State-0.4)/0.4,0,1)))
    self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+self.AsyncInverter.State/1),0,1)*math.Clamp(self.Speed/6,0,1))
    self:SetPackedRatio("asyncstate", math.Clamp(self.AsyncInverter.State/0.2*math.abs(self.AsyncInverter.Current)/100,0,1))
    self:SetPackedRatio("chopper", math.Clamp(self.Electric.Chopper>0 and self.Electric.IChopped/100 or 0,0,1))	
		
	local lightsActive1 = power and self.SFV20.Value > 0 
    local lightsActive2 = power and self.BUV.MainLights 
	local mul = 0
    local Ip = 6.9
    local Im = 1
	for i = 1,20 do
       if (lightsActive2 or (lightsActive1 and math.ceil((i+Ip-Im)%Ip)==1)) then
            if not self.Lamps[i] and not self.Lamps.broken[i] then self.Lamps[i] = CurTime() + math.Rand(0.1,math.Rand(1.15,2.5)) --[[print(self.Lamps[i]-CurTime())]] end
        else
            self.Lamps[i] = nil
        end
        if (self.Lamps[i] and CurTime() - self.Lamps[i] > 0) then
            mul = mul + 1
            self:SetPackedBool("lightsActive"..i,true)
        else
            self:SetPackedBool("lightsActive"..i,false)
        end
    end

    self:SetPackedRatio("Speed", self.Speed) 
    self:SetNW2Int("Wrench",self.WrenchMode) 
    self:SetPackedRatio("Controller",Panel.Controller) 
    self:SetPackedRatio("KRO",(self.KV.KROPosition+1)/2) 
    self:SetPackedRatio("KRR",(self.KV.KRRPosition+1)/2) 
	
    self:SetPackedRatio("VentCondMode",self.VentCondMode.Value/3)
    self:SetPackedRatio("VentStrengthMode",self.VentStrengthMode.Value/3)
    --self:SetPackedRatio("VentHeatMode",self.VentHeatMode.Value/2)
    self:SetPackedRatio("BARSBlock",self.BARSBlock.Value/3) 
    --self:SetPackedBool("WorkBeep",power)
	self:SetPackedBool("BUKPRing",powerPPZ and self.BUKP.State == 5 and self.BUKP.ProstRinging) 
	self:SetPackedBool("CAMSRing",powerPPZ and self.CAMS.State == 0 and self.CAMS.ButtonRing) 
    --print(0.4+math.max(0,math.min(1,1-(self.Speed-30)/30))*0.5)
    --print((80-self.Engines.Speed))
    self:SetPackedBool("Headlights1Enabled",Panel.Headlights1 > 0)
    self:SetPackedBool("Headlights2Enabled",Panel.Headlights2 > 0)
    local headlights = Panel.Headlights1*0.5+Panel.Headlights2*0.5	
    local redlights = Panel.RedLights>0
    self:SetPackedBool("RedLights",redlights)
		
    self:SetLightPower(1,not self.HeadLightBroken[3] and Panel.Headlights2> 0,1)
    self:SetLightPower(2,not self.HeadLightBroken[1] and Panel.Headlights1> 0,1)
    self:SetLightPower(18,not self.HeadLightBroken[4] and Panel.Headlights2> 0,1)
    self:SetLightPower(19,not self.HeadLightBroken[2] and Panel.Headlights1> 0,1)
	
	--self:SetLightPower(17,headlights>0,headlights)
    self:SetLightPower(3,not self.HeadLightBroken[3] and Panel.RedLights>0,1)
    self:SetLightPower(4,not self.HeadLightBroken[1] and Panel.RedLights>0,1)
    self:SetLightPower(5,not self.HeadLightBroken[4] and Panel.RedLights>0,1)
    self:SetLightPower(6,not self.HeadLightBroken[2] and Panel.RedLights>0,1)
    local cablight = Panel.CabLights
    self:SetLightPower(10,cablight > 0 ,cablight)
    self:SetPackedBool("CabinEnabledEmer", cablight > 0)
    self:SetPackedBool("CabinEnabledFull", cablight > 0.5)
    local passlight = power and (self.BUV.MainLights and 1 or self.SFV20.Value > 0.5 and 0.4) or 0
	
	self:SetLightPower(11,passlight > 0, passlight and mul/20)
	self:SetLightPower(12,passlight > 0.5, passlight and mul/20)
	self:SetLightPower(13,passlight > 0, passlight and mul/20)
	
    self:SetPackedRatio("SalonLighting",passlight) 
	--print(passlight)
    self:SetPackedRatio("TrainLine", self.Pneumatic.BrakeLinePressure/16.0) 
    self:SetPackedRatio("BrakeLine", self.Pneumatic.TrainLinePressure/16.0) 
	self:SetPackedRatio("BrakeCylinder", math.min(3.3,self.Pneumatic.BrakeCylinderPressure)/6.0) 
	self:SetNW2Int("RouteNumber",self.ASNP.RouteNumber)
    self:SetPackedRatio("BIAccel",0 or powerPPZ and self.BARS.BIAccel or 0) 
	self:SetNW2Bool("BIPower",powerPPZ and self.SF13.Value > 0)
    self:SetNW2Int("BISpeed",(powerPPZ and self.BARS.Speed) or -1)--CurTime()%5*20
    self:SetNW2Bool("BISpeedLimitBlink",powerPPZ and self.BARS.BINoFreq > 0)
    self:SetNW2Int("BISpeedLimit",powerPPZ and self.BARS.SpeedLimit or 100)
    self:SetNW2Int("BISpeedLimitNext",powerPPZ and self.BARS.NextLimit or 100)
    self:SetNW2Bool("BIForward",powerPPZ  and (self:ReadTrainWire(12) > 0 and self.BARS.Speed >= 0 or self:ReadTrainWire(13) > 0 and self.BARS.Speed <= 0))
    self:SetNW2Bool("BIBack",powerPPZ and (self:ReadTrainWire(12) > 0 and self.BARS.Speed <= 0 or self:ReadTrainWire(13) > 0 and self.BARS.Speed >= 0))
    self:SetNW2Bool("DoorsClosed",powerPPZ and self.BUKP.DoorClosed)
    self:SetNW2Bool("HVoltage",powerPPZ and self.BUKP.HVBad)
    self:SetNW2Bool("DoorLeftLamp",Panel.DoorLeft>0)
    self:SetNW2Bool("DoorRightLamp",Panel.DoorRight>0)
    self:SetNW2Bool("EmerBrakeWork",Panel.EmerBrakeWork>0)
    self:SetNW2Bool("TickerLamp",Panel.Ticker>0)
    self:SetNW2Bool("KAHLamp",Panel.KAH>0)
    self:SetNW2Bool("EmergencyDoorsLamp",Panel.EmergencyDoors>0)
    self:SetNW2Bool("EmergencyControlsLamp",Panel.EmergencyControls>0)
    self:SetNW2Bool("ALSLamp",Panel.ALS>0)
    self:SetNW2Bool("PassSchemeLamp",Panel.PassScheme>0)
    self:SetNW2Bool("R_AnnouncerLamp",Panel.R_Announcer>0)
    self:SetNW2Bool("R_LineLamp",Panel.R_Line>0)
    self:SetNW2Bool("AccelRateLamp",powerPPZ and self.BUKP.Slope)
    self:SetNW2Bool("DoorCloseLamp",Panel.DoorClose>0)
    self:SetNW2Bool("DoorBlockLamp",Panel.DoorBlock>0)
    self:SetPackedBool("AppLights", Panel.EqLights>0)
	self:SetNW2Bool("TPTLamp",Panel.TPT>0)
	self:SetNW2Bool("WiperLamp",Panel.Wiper>0)	
	self:SetNW2Bool("StandLamp",Panel.Stand>0)		
	
	self:SetNW2Bool("DAU",powerPPZ and self.SF13.Value > 0 and self.BARS.DAU)
	self:SetNW2Bool("XOD",powerPPZ and self.SF13.Value > 0 and self.Speed > 0.2 and not self.BARS.AO and not self.BARS.DisableDrive and self.BARS.Brake == 0 and self.BARS.Brake2 == 0)
	self:SetNW2Bool("Dnepr",powerPPZ and self.SF13.Value > 0 and self.BARS.Dnepr)
	self:SetNW2Bool("Ispr",powerPPZ and self.SF13.Value > 0 and self.BARS.Ispr)
	self:SetNW2Bool("LN",powerPPZ and self.SF13.Value > 0 and self.BARS.LN)
	self:SetNW2Bool("AO",powerPPZ and self.SF13.Value > 0 and self.BARS.AO)

    self:SetPackedRatio("LV",self.Electric.Battery80V/150) 
    self:SetPackedRatio("HV",self.Electric.Main750V/1000) 
	self:SetPackedRatio("I",(self.BUV.I+500)/1000)
    self:SetPackedRatio("I13",(self.AsyncInverter.Current+500)/1000)
    self:SetPackedRatio("I24",(self.AsyncInverter.Current+500)/1000)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor) 
    self:SetPackedBool("CabinDoorLeft",self.CabinDoorLeft) 
    self:SetPackedBool("CabinDoorRight",self.CabinDoorRight) 
    self:SetPackedBool("OtsekDoor",self.OtsekDoor)	
    self:SetPackedBool("Vent2Work",self.Electric.Vent2>0)
    self:SetPackedBool("RingEnabled",self.BUKP.Ring) 
    self:SetPackedBool("Antenna",self.Antenna)	
    self:SetPackedBool("Password",self.Password)		
	
    --self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    --self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext)
    --self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)

    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)
    self:SetPackedRatio("Cran", self.Pneumatic.DriverValvePosition) 
    self:SetPackedRatio("BL", self.Pneumatic.BrakeLinePressure/16.0) 
    self:SetPackedRatio("TL", self.Pneumatic.TrainLinePressure/16.0) 
    self:SetPackedRatio("BC", math.max(math.min(3.2,self.Pneumatic.BrakeCylinderPressure),math.min(3.2,self.Pneumatic.MiddleBogeyBrakeCylinderPressure))/6.0) 

    self.AsyncInverter:TriggerInput("Speed", self.Speed)
	
	local fB,rB,pB = self.FrontBogey,self.RearBogey,self.PricepBogey	
	
   if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and IsValid(self.PricepBogey) and not self.IgnoreEngine then

        local A = self.AsyncInverter.Torque
		--print(A)
        local add = 1
        if math.abs(self:GetAngles().pitch) > 4 then
            add = math.min((math.abs(self:GetAngles().pitch)-4)/2,1)
        end
        self.FrontBogey.MotorForce = (40000+5000*(A < 0 and 1 or 0))*add --35300
        self.FrontBogey.Reversed = (self:ReadTrainWire(13) > 0.5)--<
        --self.FrontBogey.Reversed = self.KMR2.Value > 0
        --self.FrontBogey.DisableSound = 1
        self.PricepBogey.MotorForce  = (40000+5000*(A < 0 and 1 or 0))*add --35300
        self.PricepBogey.Reversed = (self:ReadTrainWire(12) > 0.5)-->
        --self.RearBogey.Reversed = self.KMR1.Value > 0
        --self.RearBogey.DisableSound = 1

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.6*(10.0-self.Speed)/10.0) end
        self.PricepBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.FrontBogey.DisableContacts = self.BUV.Pant or fB.DisableContactsManual	
		
		self.RearBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.MiddleBogeyBrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.MiddleBogeyBrakeCylinderPressure_dPdT
        self.RearBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)         		
        self.RearBogey.DisableContacts = self.BUV.Pant or rB.DisableContactsManual		
		
		self.PricepBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.PricepBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.PricepBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
	    self.PricepBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)	

    end
    return retVal
end

function ENT:OnCouple(train,isfront)
    if isfront and self.FrontAutoCouple then
        self.FrontBrakeLineIsolation:TriggerInput("Open",1)
        self.FrontTrainLineIsolation:TriggerInput("Open",1)
        self.FrontAutoCouple = false
    elseif not isfront and self.RearAutoCouple then
        self.Pricep:IsolationsOpen()
        self.RearAutoCouple = false
    end
    self.BaseClass.OnCouple(self,train,isfront)
end

function ENT:OnButtonPress(button,ply)
    if string.find(button,"PneumaticBrakeSet") then
        self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
        return
    end
	if button == "IGLA23" then
        self.IGLA2:TriggerInput("Set",1)
        self.IGLA3:TriggerInput("Set",1)
    end
	if button == "EmergencyBrakeValveToggle" and (self.K29.Value == 1 or self.Pneumatic.V4 and self:ReadTrainWire(27) == 1) and not self.Pneumatic.RVTBTimer and self.Pneumatic.BrakeLinePressure > 2 then
		self:PlayOnce("valve_brake_open","",1.1,1)
		self:SetPackedRatio("EmerValve",CurTime()+3.8)
	end

    if button == "ALS" and not self.Plombs.ALS then
        self.ALSk:TriggerInput("Open",1)
        self.ALS:TriggerInput("Close",1)
    end	
	
    if button == "PassengerDoor" then self.PassengerDoor = not self.PassengerDoor end
    if button == "CabinDoorLeft" then self.CabinDoorLeft = not self.CabinDoorLeft end
    if button == "OtsekDoor" then self.OtsekDoor = not self.OtsekDoor end
    if button == "CabinDoorRight" then self.CabinDoorRight = not self.CabinDoorRight end
    if button == "Antenna" then self.Antenna = not self.Antenna end	
	if button == "Password" then self.Password = not self.Password end	
    if button == "DoorLeft" then
        self.DoorSelectL:TriggerInput("Set",1)
        self.DoorSelectR:TriggerInput("Set",0)
        if self.EmergencyDoors.Value == 1 or self.DoorClose.Value == 0 then
            self.DoorLeft:TriggerInput("Set",1)
        end
    end
    if button == "DoorRight" then
        self.DoorSelectL:TriggerInput("Set",0)
        self.DoorSelectR:TriggerInput("Set",1)
        if self.EmergencyDoors.Value == 1 or self.DoorClose.Value == 0 then
          self.DoorRight:TriggerInput("Set",1)
        end
    end
    if button == "DoorClose" then
        if self.EmergencyDoors.Value == 1 then
            self.EmerCloseDoors:TriggerInput("Set",1)
        else
                 self.DoorClose:TriggerInput("Set",1-self.DoorClose.Value)
            self.EmerCloseDoors:TriggerInput("Set",0)
        end
    end
        if button == "KRO+" then
		if self.KV.KRRPosition == 0 then
			self.KV:TriggerInput("KROSet",self.KV.KROPosition+1)
		else
			--self.KV:TriggerInput("KRRSet",self.KV.KRRPosition+1)
		end
    end
    if button == "KRO-" then
		if self.KV.KRRPosition == 0 then
			self.KV:TriggerInput("KROSet",self.KV.KROPosition-1)
		else
			--self.KV:TriggerInput("KRRSet",self.KV.KRRPosition-1)
		end
    end
	if button == "KRR+" and self.KV.KROPosition == 0 then
        self.KV:TriggerInput("KRRSet",self.KV.KRRPosition+1)
	end
	if button == "KRR-" and self.KV.KROPosition == 0 then
        self.KV:TriggerInput("KRRSet",self.KV.KRRPosition-1)
	end
    if button == "WrenchKRO" then
        if self.KV.KRRPosition == 0 then
            --self:PlayOnce("kro_in","cabin",1)
            self.WrenchMode = 1
			self.KVWrenchMode = self.WrenchMode
        end
    end
    if button == "WrenchKRR" then
        if self.KV.KROPosition == 0 and self.WrenchMode ~= 2 then
            --self:PlayOnce("krr_in","cabin",1)
            self.WrenchMode = 2
			self.KVWrenchMode = self.WrenchMode
            RunConsoleCommand("say",ply:GetName().." want drive with KRU!")
        end
    end
	if button:find("KRO") or button:find("KRR") then
		self.WrenchMode = (self.KV.KROPosition ~= 0 and 1 or (self.KV.KRRPosition ~= 0 and 2) or 0)
		self.KVWrenchMode = self.WrenchMode
	end
end
function ENT:OnButtonRelease(button,ply)
    if string.find(button,"PneumaticBrakeSet") then
        if button == "PneumaticBrakeSet1" and (self.Pneumatic.DriverValvePosition == 1) then
            self.Pneumatic:TriggerInput("BrakeSet",2)
        end
        return
    end
        if button == "IGLA23" then
        self.IGLA2:TriggerInput("Set",0)
        self.IGLA3:TriggerInput("Set",0)
    end
    if button == "KAH" then
        self.KAH:TriggerInput("Open",1)
    end	
    if button == "DoorLeft" then
        self.DoorLeft:TriggerInput("Set",0)
    end
    if button == "DoorRight" then
        self.DoorRight:TriggerInput("Set",0)
    end
    if button == "DoorClose" then
         self.EmerCloseDoors:TriggerInput("Set",0)
    end
	if button == "EmergencyBrakeValveToggle" and (self.K29.Value == 1 or self.Pneumatic.V4 and self:ReadTrainWire(27) == 1) and not self.Pneumatic.RVTBTimer then
		self:PlayOnce("valve_brake_close","",1,1)
	end	
end
