local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_nsk_line")
or Map:find("gm_metro_kalinin")
or Map:find("gm_metro_krl")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")) then
	return
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.SyncTable = {
    "EnableBVEmer","Ticker","KAH","KAHk","ALS","ALSk","FDepot","PassScheme","EnableBV","DisableBV","Ring","R_Program2","R_Announcer","R_Line","R_Emer","R_Program1",
    "DoorSelectL","DoorSelectR","DoorBlock","TPT",
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
    "K29", "UAVA",
    "EmerX1","EmerX2","EmerCloseDoors","EmergencyDoors",
    "R_ASNPMenu","R_ASNPUp","R_ASNPDown","R_ASNPOn",
    "VentHeatMode",
	
	--"CAMS1","CAMS2","CAMS3","CAMS4",
	"CAMS5","CAMS6","CAMS7","CAMS8","CAMS9","CAMS10",
	--"RearBrakeLineIsolation","RearTrainLineIsolation",
    "FrontBrakeLineIsolation","FrontTrainLineIsolation",
    "PB",   "GV",	"EmergencyBrakeValve","stopkran",
}
--------------------------------------------------------------------------------

function ENT:Initialize()
    -- Set model and initialize
	--print(self:GetNW2String("Texture"))		
	self:SetModel("models/metrostroi_train/81-740/body/81-740_4_front.mdl")	
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))
	
    self.NormalMass = 20000	
	--self.m_tblToolsAllowed = { "none" }		

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(775-144,19,-27))
    self.InstructorsSeat = self:CreateSeat("instructor",Vector(586,-40,-30),Angle(0,90,0),"models/nova/jeep_seat.mdl")
    self.InstructorsSeat2 = self:CreateSeat("instructor",Vector(767-144,45,-35),Angle(0,75,0),"models/vehicles/prisoner_pod_inner.mdl") 
    --self.InstructorsSeat3 = self:CreateSeat("instructor",Vector(760-144,0,-40),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.InstructorsSeat4 = self:CreateSeat("instructor",Vector(787-144,-25,-40),Angle(0,115,0),"models/vehicles/prisoner_pod_inner.mdl")	

    --Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.DriverSeat:SetColor(Color(0,0,0,0))
	self.DriverSeat.m_tblToolsAllowed = { "none" }		
	
    self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat:SetColor(Color(0,0,0,0))
	self.InstructorsSeat.m_tblToolsAllowed = { "none" }	
	
    self.InstructorsSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat2:SetColor(Color(0,0,0,0))
	self.InstructorsSeat2.m_tblToolsAllowed = { "none" }	
	
    --self.InstructorsSeat3:SetRenderMode(RENDERMODE_TRANSALPHA)
    --self.InstructorsSeat3:SetColor(Color(0,0,0,0))
    self.InstructorsSeat4:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat4:SetColor(Color(0,0,0,0))
	self.InstructorsSeat4.m_tblToolsAllowed = { "none" }		
	
	self.LightSensor = self:AddLightSensor(Vector(698-144,0,-130),Angle(0,90,0))
	
    -- Create bogeys
        self.FrontBogey = self:CreateBogey(Vector( 520,0,-75),Angle(0,180,0),true,"740PER")	
		self.FrontBogey.PneumaticPow = 0.7		
        self.RearBogey  = self:CreateBogey(Vector(-532,0,-75),Angle(0,0,0),false,"740NOTR") --110 0 -80 
		self.RearBogey:PhysicsInit(SOLID_VPHYSICS)			
		self.FrontBogey:SetNWInt("MotorSoundType",2)
		self.RearBogey:SetNWInt("MotorSoundType",2)
        self.RearBogey.DisableContacts = true	
		self.RearBogey.PneumaticPow = 0.7		
        self.FrontCouple = self:CreateCouple(Vector(636,0,-60),Angle(0,0,0),true,"717")
        self.RearCouple = self:CreateCouple(Vector(-625,0,-60),Angle(0,-180,0),false,"740") 
		self.RearCouple:SetModel("models/metrostroi_train/81-740/bogey/metro_couple_740.mdl") 
			
		self.FrontCouple.m_tblToolsAllowed = { "none" }
		self.RearCouple.m_tblToolsAllowed = { "none" }	
		self.FrontBogey.m_tblToolsAllowed = { "none" }	
		self.RearBogey.m_tblToolsAllowed = { "none" }			
		

	self.Timer = CurTime()	
	self.Timer2 = CurTime()	
		
timer.Simple(0, function()			
		self.Rear1 = self:CreatePricep(Vector(-340,0,0)) --вагон	
end)  	    	
	
	self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)
	self.FrontCouple.EKKDisconnected = true
    local rand = math.random()*0.05
    self.FrontBogey:SetNWFloat("SqualPitch",1.45+rand)
    self.RearBogey:SetNWFloat("SqualPitch",1.45+rand)
	
	self:SetNW2Entity("FrontBogey",self.FrontBogey)
	self:SetNW2Entity("RearBogey",self.RearBogey)	
--[[local Bogey = self:GetNW2Entity("gmod_train_bogey")	 Не работает.
if not IsValid(Bogey) then return end	
	
function Bogey:PhysicsCollide(data,physobj)
	-- Generate junction sounds
	if data.HitEntity and data.HitEntity:IsValid() and data.HitEntity:GetClass() == "prop_door_rotating" then
		self.LastJunctionTime = self.LastJunctionTime or CurTime()
		local dt = CurTime() - self.LastJunctionTime

		if dt > 3.5 then
			local speed = self:GetVelocity():Length() * 0.06858
			if speed > 10 then
				self.LastJunctionTime = CurTime()

				local pitch_var = math.random(90,110)
				local pitch = pitch_var*math.max(0.8,math.min(1.3,speed/40))
				self:EmitSound("subway_trains/rusich/bogey/junct_"..math.random(2,3)..".wav",100,pitch )
			end
		end
	end
end	]]	
--------------------------------------------------------------------------------					
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
        [1]  = { "light",Vector(832-144, 27.5, -23), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [2]  = { "light",Vector(832-144, 40.5,-20.5), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [18]  = { "light",Vector(832-144, -27.5, -23), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [19]  = { "light",Vector(832-144, -40.5, -20.5), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        --красные огни 
        [3] = { "light",Vector(690, 41.5, -60), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[4] = { "light",Vector(690, -41.5, -60), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[5] = { "light",Vector(656, 40, 57), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[6] = { "light",Vector(656, -40, 57), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
        --освещение в кабине
        [10] = { "dynamiclight",    Vector( 755-144, 0, 40), Angle(0,0,0), Color(206,135,80), brightness = 1.5, distance = 550 },
        -- Interior
		[11] = { "dynamiclight",    Vector(260-144, 20, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 }, --левая лампа аварийная
		[12] = { "dynamiclight",    Vector(420-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [13] = { "dynamiclight",    Vector(675-144, -20, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 }, --правая лампа аварийная
		
		[11.1] = { "dynamiclight",    Vector(260-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [13.1] = { "dynamiclight",    Vector(675-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 },	
    }
	
	self.InteractionZones = {
		{
			ID = "CabinDoorLeft", 
			Pos = Vector(476, 64, -30),Radius = 48,
        },    	
		
		{
			ID = "CabinDoorLeft", 
			Pos = Vector(476, -60, 30), Radius = 48,
        },	
		
        {
			ID = "CabinDoorRight", 
			Pos = Vector(466, -60, -30),Radius = 48,
	    },	
		
        --[[{
			ID = "OtsekDoor",
			Pos = Vector(200, 39, 11),Radius = 48,
        },]]
		
		{
			ID = "FrontBrakeLineIsolationToggle",
			Pos = Vector(835-144,-25.0,-44), Radius = 16,
        },
		{
			ID = "FrontTrainLineIsolationToggle",
			Pos = Vector(835-144,25.0,-44), Radius = 16,
        },
		{
			ID = "GVToggle",
			Pos = Vector(222,-17,-82), Radius = 20,
        },
    }
	
    self.PassengerDoor = false
    self.CabinDoorLeft = false
    self.CabinDoorRight = false
    self.OtsekDoor = true
    self.WrenchMode = 1
	self.Antenna = false	
	self.Password = false
	--self.RearDoor = false	
	self.KVWrenchMode = self.WrenchMode

--спасибо Valjas SaretoScripto за скрипт.
local nearlyS    
    for k,v in pairs(ents.FindByClass("gmod_track_signal")) do
        if not nearlyS or self:GetPos():DistToSqr(v:GetPos()) < self:GetPos():DistToSqr(nearlyS:GetPos()) then nearlyS = v end
    end
    if nearlyS and nearlyS.TwoToSix then self.ALSFreqBlock:TriggerInput("Set",2) 
    elseif nearlyS and not nearlyS.TwoToSix then self.ALSFreqBlock:TriggerInput("Set",3) 
    elseif nearlyS == nil then self.ALSFreqBlock:TriggerInput("Set",1) 
end

--наложение пломб
	self.Plombs = {
		KAH = {true,"KAHk"},
        KAHk = true,
        ALS = {true,"ALSk"},
        ALSk = true,
        BARSBlock = true,
        UAVA = true,
        Init = true,
        --ALSFreqBlock = true,		
		R_ASNPOn = true,		
		--ALSFreqBlock = ALSFreqPlomb,
    }
	self.Lamps = {
        broken = {},
    }	
	
    local rand = math.random() > 0.9 and 1 or math.random(0.95,0.99)
    for i = 1,40 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.7 end
    end
	
	self.HeadLightBroken = {}
	self.RedLightBroken = {}
	
    self:UpdateLampsColors()	
end
--если на карте нету сигналки включить ВП
function ENT:NonSupportTrigger()
	--self.ALSFreqBlock:TriggerInput("Set",1)
	--self.Plombs.ALSFreqBlock = nil
end
function ENT:TriggerLightSensor(coil,plate)
	--self.Prost_Kos:TriggerSensor(coil,plate)
	self.Prost_Kos:Think()
end

function ENT:TrainSpawnerUpdate()

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
            ZavodTable = math.ceil(math.random()*2+0.5)
          else ZavodTable = ZavodTable-1 end	
	self:SetNW2Int("ZavodTable",ZavodTable)	
	
	local BBEs = self:GetNW2Int("BBESound")	
       if BBEs == 1 then
            BBEs = math.ceil(math.random()*2+0.5)
          else BBEs = BBEs-1 end	
	self:SetNW2Int("BBESound",BBEs)		

	local VentSound = self:GetNW2Int("VentSound")	
       if VentSound == 1 then
            VentSound = math.ceil(math.random()*1+0.5)
          else VentSound = VentSound-1 end	
	self:SetNW2Int("VentSound",VentSound)	
		
    --рандомизация цвета табло
	--local ALS = math.random(1, 3)
	--self:SetNW2Int("tablo_color", ALS)
	--print(self:GetNW2String("Texture"))	
	
    self:UpdateLampsColors()		
	
end

function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),0
	local mr = math.random
    local rand = mr() > 0.8 and 1 or mr(0.95,0.99)
	local rnd1,rnd2,col = 0.7+mr()*0.3,mr()
	local typ = math.Round(mr())
	local r,g = 15,15
	for i = 1,40 do
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

function ENT:RerailChange(ent, bool)
    if not IsValid(ent) then return end
    if bool then
        timer.Remove("metrostroi_rerailer_solid_reset_"..ent:EntIndex())    
    else
        timer.Create("metrostroi_rerailer_solid_reset_"..ent:EntIndex(),1e9,1,function() end)    
    end
end
	
function ENT:CreatePricep(pos,ang)
	local Pricep740 = ents.Create("gmod_subway_kuzov")		
    if not IsValid(Pricep740) or not IsValid(self) then return end
	Pricep740:SetPos(self:LocalToWorld(pos))
	Pricep740:SetAngles(self:LocalToWorldAngles(Angle(0,0,0)))
	Pricep740:Spawn()
	Pricep740:SetOwner(self:GetOwner())	
	Pricep740:DrawShadow(false)			
	--Pricep740.m_tblToolsAllowed = { "none" }		
	if CPPI and IsValid(self:CPPIGetOwner()) then Pricep740:CPPISetOwner(self:CPPIGetOwner()) end	
    --PrintTable(Pricep740:GetTable())
	self:SetNW2Entity("gmod_subway_kuzov",Pricep740)
    Pricep740:SetUseType(SIMPLE_USE)

    -- Set proper parameters for the bogey
    if IsValid(Pricep740:GetPhysicsObject()) then
        Pricep740:GetPhysicsObject():SetMass(25000)
    end		

	table.insert(self.TrainEntities,Pricep740)      
    table.insert(Pricep740.TrainEntities,self)	
	
	self.MiddleBogey = self:CreateBogey(Vector(-15,0,-74),Angle(0,0,0),true,"740G")--тележка  ---160,0,-75 -410,0,-75	
	self:SetNW2Entity("MiddleBogey",self.MiddleBogey)	
    local rand = math.random()*0.05
    self.MiddleBogey:SetNWFloat("SqualPitch",1.45+rand)
	self.MiddleBogey:SetNWInt("MotorSoundType",2)
	self.MiddleBogey:SetNWInt("Async",true)
	self.MiddleBogey:SetNWBool("DisableEngines",true)			
	self.MiddleBogey.DisableSound = 1	
	self.RearCouple:PhysicsInit(SOLID_VPHYSICS)
	self.RearCouple:GetPhysicsObject():SetMass(5000)
	self.MiddleBogey.m_tblToolsAllowed = { "none" }
    if not self.NoPhysics then
        --self.MiddleBogey:PhysicsInit(SOLID_VPHYSICS)
        self.MiddleBogey:SetMoveType(MOVETYPE_VPHYSICS)
        --self.MiddleBogey:SetSolid(SOLID_VPHYSICS)
    end
    self.MiddleBogey:SetUseType(SIMPLE_USE)

    -- Set proper parameters for the bogey
    if IsValid(self.MiddleBogey:GetPhysicsObject()) then
        self.MiddleBogey:GetPhysicsObject():SetMass(5000)
    end	
		
	constraint.RemoveConstraints(self.MiddleBogey, "AdvBallsocket")	
	constraint.RemoveConstraints(Pricep740, "AdvBallsocket")
    constraint.NoCollide(Pricep740,self.MiddleBogey,0,0)			
	local Map = game.GetMap():lower() or ""        
	if 
	Map:find("gm_metro_pink_line_redux") or
	Map:find("gm_jar_pll_redux") or
	Map:find("gm_metro_crossline") or	
	Map:find("gm_metro_mosldl") or	
	Map:find("gm_smr_1987") then
	constraint.AdvBallsocket(
		self.MiddleBogey,	
		Pricep740,
		0, --bone
		0, --bone		
		Vector(0,0,0),
		Vector(0,0,0),		
		0, --forcelimit
		0, --torquelimit
		0, --xmin
		0, --ymin
		-180, --zmin
		0, --xmax
		0, --ymax
		180, --zmax
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)			
	else	
	
	local Map = game.GetMap():lower() or ""        
	if 
	Map:find("gm_mustox_neocrimson_line") or
	Map:find("gm_mus_neoorange") or
	Map:find("gm_metro_nekrasovskaya_line") then
	constraint.AdvBallsocket(
		self.MiddleBogey,	
		Pricep740,
		0, --bone
		0, --bone		
		Vector(-40,0,65),
		Vector(40,0,65),		
		1, --forcelimit
		1, --torquelimit
		-1, --xmin
		-1, --ymin
		-180, --zmin
		1, --xmax
		1, --ymax
		180, --zmax
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)
	constraint.AdvBallsocket(
		self.MiddleBogey,	
		Pricep740,
		0, --bone
		0, --bone		
		Vector(-40,0,-65),
		Vector(-40,0,65),	
		1, --forcelimit
		1, --torquelimit
		-2, --xmin
		-1, --ymin
		-180, --zmin
		1, --xmax
		2, --ymax
		180, --zmax
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)
	else

	local Map = game.GetMap():lower() or ""        
	if 
	Map:find("gm_metro_chapaevskaya_line")	then	
	constraint.AdvBallsocket(
		self.MiddleBogey,	
		Pricep740,
		0, --bone
		0, --bone		
		Vector(-40,0,20),
		Vector(40,0,20),		
		0, --forcelimit
		0, --torquelimit
		-5, --xmin
		-5, --ymin
		-180, --zmin
		5, --xmax
		5, --ymax
		180, --zmax
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)			
	constraint.AdvBallsocket(
		self.MiddleBogey,	
		Pricep740,
		0, --bone
		0, --bone		
		Vector(-40,0,-20),
		Vector(-40,0,20),	
		0, --forcelimit
		0, --torquelimit
		-5, --xmin
		-5, --ymin
		-180, --zmin
		5, --xmax
		5, --ymax
		180, --zmax
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)
	else	
	
	constraint.RemoveConstraints(Pricep740, "AdvBallsocket")	
	constraint.NoCollide(self.MiddleBogey,Pricep740, 0 ,0)	
	constraint.NoCollide(Pricep740,self.MiddleBogey, 0 ,0)		
	constraint.AdvBallsocket(
		Pricep740,
		self.MiddleBogey,
		0, --bone
		0, --bone		
		Vector(305,0,-20),
		Vector(-305,0,0),		
		0, --forcelimit
		0, --torquelimit
		-20, --xmin
		-10, --ymin
		-180, --zmin
		20, --xmax
		10, --ymax
		180, --zmax
		1, --xfric
		1, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)	
	constraint.NoCollide(self.MiddleBogey,Pricep740, 0 ,0)	
	constraint.NoCollide(Pricep740,self.MiddleBogey, 0 ,0)			
	constraint.AdvBallsocket(
		Pricep740,
		self.MiddleBogey,
		0, --bone
		0, --bone		
		Vector(305,0,20),
		Vector(-305,0,0),	
		0, --forcelimit
		0, --torquelimit
		-20, --xmin
		-10, --ymin
		-180, --zmin
		20, --xmax
		10, --ymax
		180, --zmax
		1, --xfric
		1, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)
end	
end
end
        constraint.Axis(
		self.RearBogey,		
		Pricep740,
		0,
		0,
		Vector(0,0,0),
		Vector(0,0,0),
        0,
		0,
		0,
		0,
		Vector(0,0,-1)
		)
	--Сцепка, крепление к вагону.
	constraint.RemoveConstraints(self.RearCouple, "AdvBallsocket")	
	constraint.AdvBallsocket(
		Pricep740,
        self.RearCouple,
        0, --bone
        0, --bone
        self.RearCouple.SpawnPos-pos,
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
        1 --nocollide
    ) 
	
    self:RerailChange(self.FrontBogey, true)
    self:RerailChange(self.MiddleBogey, true)
    self:RerailChange(self.RearBogey, true)		
	
function Pricep740:TrainSpawnerUpdate()
	local MotorType = self:GetNW2Int("MotorType")	
       if MotorType == 1 then
            MotorType = math.ceil(math.random()*4+0.5)
          else MotorType = MotorType-1 end	
	self:SetNW2Int("MotorType",MotorType)	
	--self:SetNW2Int("MotorType",math.random(1, 2))		

	local ZavodTable = self:GetNW2Int("ZavodTable")	
       if ZavodTable == 1 then
            ZavodTable = math.ceil(math.random()*2+0.5)
          else ZavodTable = ZavodTable-1 end	
	self:SetNW2Int("ZavodTable",ZavodTable)		
	
	local RingSound = self:GetNW2Int("RingSound")	
       if RingSound == 1 then
            RingSound = math.ceil(math.random()*3+0.5)
          else RingSound = RingSound-1 end	
	self:SetNW2Int("RingSound",RingSound)	
	
	local BBEs = self:GetNW2Int("BBESound")	
       if BBEs == 1 then
            BBEs = math.ceil(math.random()*2+0.5)
          else BBEs = BBEs-1 end	
	self:SetNW2Int("BBESound",BBEs)		
	
    --рандомизация цвета табло
	--local ALS = math.random(1, 3)
	--self:SetNW2Int("tablo_color", ALS)
	--print(self:GetNW2String("Texture"))
end	
	
function Pricep740:Use(ply)
    local tr = ply:GetEyeTrace()
    if not tr.Hit then return end
    local hitpos = self:WorldToLocal(tr.HitPos)
    print(hitpos)
    if self.InteractionZones and ply:GetPos():Distance(tr.HitPos) < 100 then
        for k,v in pairs(self.InteractionZones) do
            if hitpos:Distance(v.Pos) < v.Radius then
                self:ButtonEvent(v.ID,nil,ply)
            end
        end
    end
	
function Pricep740:ShowInteractionZones()
    for k,v in pairs(self.InteractionZones) do
        debugoverlay.Sphere(self:LocalToWorld(v.Pos),v.Radius,15,Color(255,185,0),true)
    end
end	
		
	 self.InteractionZones = {	
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-310, -13, -10), Radius = 31
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-310,-13,-10), Radius = 31
        },
        {
            ID = "RearDoor",
            Pos = Vector(-310, -13, 7), Radius = 31
        },
	} 
end

	--Метод mirror 				
	Pricep740.HeadTrain = self 
    Pricep740:SetNW2Entity("HeadTrain", self)

	Pricep740.ButtonBuffer = {}
	Pricep740.KeyBuffer = {}
	Pricep740.KeyMap = {}	
end	
	
	--[[
    local seat = ents.Create("prop_vehicle_prisoner_pod")
    seat:SetModel("models/nova/jeep_seat.mdl") --jalopy
    seat:SetPos(self:LocalToWorld(Vector(-657,-30.2,-25)))
    seat:SetAngles(self:GetAngles()+Angle(0,0,0))
    seat:SetKeyValue("limitview",0)
    seat:Spawn()
    seat:GetPhysicsObject():SetMass(0)
    seat:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:DrawShadow(false)
	seat:SetNoDraw(true)
	seat.ExitPos = self.ExitPos	
	
    --Assign ownership
    if CPPI and IsValid(self:CPPIGetOwner()) then seat:CPPISetOwner(self:CPPIGetOwner()) end
    seat:SetParent(Pricep740)	

    local seat_1 = ents.Create("prop_vehicle_prisoner_pod")	
    seat_1:SetModel("models/nova/jeep_seat.mdl") --jalopy
    seat_1:SetPos(self:LocalToWorld(Vector(-658,36,-25)))
    seat_1:SetAngles(self:GetAngles()+Angle(0,180,0))
    seat_1:SetKeyValue("limitview",0)
    seat_1:Spawn()
    seat_1:GetPhysicsObject():SetMass(0)
    seat_1:SetCollisionGroup(COLLISION_GROUP_WORLD)
    seat_1:DrawShadow(false)
	seat_1:SetNoDraw(true)	
	
    if CPPI and IsValid(self:CPPIGetOwner()) then seat_1:CPPISetOwner(self:CPPIGetOwner()) end
    seat_1:SetParent(Pricep740)]]				
---------------------------------------------------------------------------
function ENT:Think()
    local retVal = self.BaseClass.Think(self)
    local power = self.Electric.Battery80V > 62
	local Panel = self.Panel	
    local Pricep740 = self:GetNW2Entity("gmod_subway_kuzov")	
    if not IsValid(Pricep740) then return end	
	Pricep740.SyncTable = {	"RearBrakeLineIsolation","RearTrainLineIsolation"}		
    --print(self,self.BPTI.T,self.BPTI.State)
	
	self.RearDoor = false		
function Pricep740:Think()	
    self:SetPackedBool("RearDoor",self.RearDoor)	
end	
function Pricep740:OnButtonPress(button,ply)
    if button == "RearDoor" and (self.RearDoor or not self.BlockTorec)	 then self.RearDoor = not self.RearDoor end	
end		
	
    local state = math.abs(self.AsyncInverter.InverterFrequency/(11+self.AsyncInverter.State*5))--(10+8*math.Clamp((self.AsyncInverter.State-0.4)/0.4,0,1)))
    self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+self.AsyncInverter.State/1),0,1)*math.Clamp(self.Speed/6,0,1))
    self:SetPackedRatio("asyncstate", math.Clamp(self.AsyncInverter.State/0.2*math.abs(self.AsyncInverter.Current)/100,0,1))
    self:SetPackedRatio("chopper", math.Clamp(self.Electric.Chopper>0 and self.Electric.IChopped/100 or 0,0,1))	
	--print(self.Electric.IChopped,self.Electric.Chopper)
    --print(self,self.BPTI.T,self.BPTI.State)		

    --[[ if self.BUV.Brake > 0 then
        self:SetPackedRatio("RNState", power and (Train.K2.Value>0 or Train.K3.Value>0) and self.Electric.RN > 0 and (1-self.Electric.RNState)+math.Clamp(1-(math.abs(self.Electric.Itotal)-50)/50,0,1) or 1)
    else
        self:SetPackedRatio("RNState", power and (Train.K2.Value>0 or Train.K3.Value>0) and self.Electric.RN > 0 and self.Electric.RNState+math.Clamp(1-(math.abs(self.Electric.Itotal)-50)/50,0,1) or 1)
    end--]]
    --if self.BPTI.State < 0 then
        --self:SetPackedRatio("RNState", ((self.BPTI.RNState)-0.5)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*1)/35,0,1)) --снижение скорости
        --self:SetNW2Int("RNFreq", 13)
    --else--if self.BPTI.State > 0 then
        --self:SetPackedRatio("RNState", (0.95-self.BPTI.RNState)*math.Clamp((math.abs(self.Electric.Itotal/2)-36-self.Speed*1)/35,0,5))
        --self:SetNW2Int("RNFreq", ((self.BPTI.FreqState or 0)-1/3)/(2/3)*12)
    --[[ else
        self:SetPackedRatio("RNState", 0)--]]
    --end
	
		--скорость дверей
		for k,v in pairs(self.Pneumatic.LeftDoorSpeed) do
			self.Pneumatic.LeftDoorSpeed[k] = -2, 10
		end
		
		for k,v in pairs(self.Pneumatic.RightDoorSpeed) do
			self.Pneumatic.RightDoorSpeed[k] = -2, 10
		end
		
	local lightsActive1 = power and self.SFV20.Value > 0 
    local lightsActive2 = power and self.BUV.MainLights 
	local mul = 0
    local Ip = 6.9
    local Im = 1
	for i = 1,40 do
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
    self:SetPackedRatio("Controller",self.Panel.Controller) 
    self:SetPackedRatio("KRO",(self.KV.KROPosition+1)/2) 
    self:SetPackedRatio("KRR",(self.KV.KRRPosition+1)/2) 
	
    self:SetPackedRatio("VentCondMode",self.VentCondMode.Value/3)
    self:SetPackedRatio("VentStrengthMode",self.VentStrengthMode.Value/3)
    --self:SetPackedRatio("VentHeatMode",self.VentHeatMode.Value/2)
    self:SetPackedRatio("BARSBlock",self.BARSBlock.Value/3) 
	self:SetPackedRatio("ALSFreqBlock",self.ALSFreqBlock.Value/3) 
    self:SetPackedBool("BBEWork",power and self.BUV.BBE > 0
)	
    --self:SetPackedBool("WorkBeep",power)
	self:SetPackedBool("BUKPRing",power and self.BUKP.State == 5 and self.BUKP.ProstRinging) 
	self:SetPackedBool("CAMSRing",power and self.CAMS.State == 0 and self.CAMS.ButtonRing) 
    --print(0.4+math.max(0,math.min(1,1-(self.Speed-30)/30))*0.5)
    --print((80-self.Engines.Speed))
    self:SetPackedBool("Headlights1Enabled",self.Panel.Headlights1 > 0)
    self:SetPackedBool("Headlights2Enabled",self.Panel.Headlights2 > 0)
    local headlights = self.Panel.Headlights1*0.5+self.Panel.Headlights2*0.5	
    local redlights = self.Panel.RedLights>0
    self:SetPackedBool("RedLights",redlights)
		
    self:SetLightPower(1,not self.HeadLightBroken[3] and self.Panel.Headlights2> 0,1)
    self:SetLightPower(2,not self.HeadLightBroken[1] and self.Panel.Headlights1> 0,1)
    self:SetLightPower(18,not self.HeadLightBroken[4] and self.Panel.Headlights2> 0,1)
    self:SetLightPower(19,not self.HeadLightBroken[2] and self.Panel.Headlights1> 0,1)
	
	--self:SetLightPower(17,headlights>0,headlights)
    self:SetLightPower(3,not self.HeadLightBroken[3] and self.Panel.RedLights>0,1)
    self:SetLightPower(4,not self.HeadLightBroken[1] and self.Panel.RedLights>0,1)
    self:SetLightPower(5,not self.HeadLightBroken[4] and self.Panel.RedLights>0,1)
    self:SetLightPower(6,not self.HeadLightBroken[2] and self.Panel.RedLights>0,1)
	--self:SetLightPower(20,cablights)
	--self:SetLightPower(21,cablights)
	--self:SetLightPower(22,cablights)
    local cablight = self.Panel.CabLights
    self:SetLightPower(10,cablight > 0 ,cablight)
    self:SetPackedBool("CabinEnabledEmer", cablight > 0)
    self:SetPackedBool("CabinEnabledFull", cablight > 0.5)
    local passlight = power and (self.BUV.MainLights and 1 or self.SFV20.Value > 0.5 and 0.4) or 0
	
	self:SetLightPower(11,passlight > 0, passlight and mul/40)
	self:SetLightPower(12,passlight > 0.5, passlight and mul/40)
	self:SetLightPower(13,passlight > 0, passlight and mul/40)
	
	self:SetLightPower(11.1,passlight > 0, passlight and mul/40)
	self:SetLightPower(13.1,passlight > 0, passlight and mul/40)
	
	Pricep740.Lights = {
		[14] = { "dynamiclight",    Vector( 220, -20, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
		[15] = { "dynamiclight",    Vector( 10, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [16] = { "dynamiclight",    Vector( -310, 20, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 250, fov=180,farz = 128 },
		
		[14.1] = { "dynamiclight",    Vector( 200, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 }, --полный свет
        [16.1] = { "dynamiclight",    Vector( -310, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 250, fov=180,farz = 128 } 	
    }	
	
	Pricep740:SetLightPower(14,passlight > 0, passlight) 
    Pricep740:SetLightPower(15,passlight > 0.5, passlight) 
    Pricep740:SetLightPower(16,passlight > 0, passlight) 
	
	Pricep740:SetLightPower(14.1,passlight > 0, passlight) 
    Pricep740:SetLightPower(16.1,passlight > 0, passlight) 
	
    self:SetPackedRatio("SalonLighting",passlight) 
	--print(passlight)
    self:SetPackedRatio("TrainLine", self.Pneumatic.BrakeLinePressure/16.0) 
    self:SetPackedRatio("BrakeLine", self.Pneumatic.TrainLinePressure/16.0) 
	self:SetPackedRatio("BrakeCylinder", math.min(3.3,self.Pneumatic.BrakeCylinderPressure)/6.0) 
	self:SetNW2Int("RouteNumber",self.ASNP.RouteNumber)
    self:SetPackedRatio("BIAccel",0 or power and self.BARS.BIAccel or 0) 
    self:SetNW2Int("BISpeed",power and self.Speed or -1)--CurTime()%5*20
    self:SetNW2Bool("BISpeedLimitBlink",power and self.BARS.BINoFreq > 0)
    self:SetNW2Int("BISpeedLimit",power and self.BARS.SpeedLimit or 100)
    self:SetNW2Int("BISpeedLimitNext",power and self.BARS.NextLimit or 100)
    self:SetNW2Bool("BIForward",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.Speed > -0.2)
    self:SetNW2Bool("BIBack",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.Speed < 0.2)
    self:SetNW2Bool("DoorsClosed",power and self.BUKP.DoorClosed)
    self:SetNW2Bool("HVoltage",power and self.BUKP.HVBad)
    self:SetNW2Bool("DoorLeftLamp",Panel.DoorLeft>0)
    self:SetNW2Bool("DoorRightLamp",Panel.DoorRight>0)
    self:SetNW2Bool("EmerBrakeWork",Panel.EmerBrakeWork>0)
    self:SetNW2Bool("TickerLamp",Panel.Ticker>0)
    self:SetNW2Bool("KAHLamp",Panel.KAH>0)
    self:SetNW2Bool("ALSLamp",Panel.ALS>0)
    self:SetNW2Bool("PassSchemeLamp",Panel.PassScheme>0)
    self:SetNW2Bool("R_AnnouncerLamp",Panel.R_Announcer>0)
    self:SetNW2Bool("R_LineLamp",Panel.R_Line>0)
    self:SetNW2Bool("AccelRateLamp",power and self.BUKP.Slope)
    self:SetNW2Bool("DoorCloseLamp",Panel.DoorClose>0)
    self:SetNW2Bool("DoorBlockLamp",Panel.DoorBlock>0)
    self:SetPackedBool("AppLights", Panel.EqLights>0)
	self:SetNW2Bool("TPTLamp",Panel.TPT>0)
	self:SetNW2Bool("WiperLamp",Panel.Wiper>0)	
	self:SetNW2Bool("StandLamp",Panel.Stand>0)		
	
	self:SetNW2Bool("DAU",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.DAU)
	self:SetNW2Bool("XOD",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.Speed > 0.2)
	self:SetNW2Bool("Dnepr",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.Dnepr)
	self:SetNW2Bool("Ispr",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.Ispr)
	self:SetNW2Bool("LN",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.LN)
	self:SetNW2Bool("AO",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.AO)

    self:SetPackedRatio("LV",self.Electric.Battery80V/150) 
    self:SetPackedRatio("HV",self.Electric.Main750V/1000) 
	self:SetPackedRatio("I",(self.BUV.I+500)/1000)
    self:SetPackedRatio("I13",(self.AsyncInverter.Current+500)/1000)
    self:SetPackedRatio("I24",(self.AsyncInverter.Current+500)/1000)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor) 
    self:SetPackedBool("CabinDoorLeft",self.CabinDoorLeft) 
    self:SetPackedBool("CabinDoorRight",self.CabinDoorRight) 
    self:SetPackedBool("OtsekDoor",self.OtsekDoor)	
    self:SetPackedBool("CompressorWork",self.Pneumatic.Compressor) 
    self:SetPackedBool("Vent2Work",self.Electric.Vent2>0)
    self:SetPackedBool("RingEnabled",self.BUKP.Ring) 
    self:SetPackedBool("Antenna",self.Antenna)	
    self:SetPackedBool("Password",self.Password)		
	
    --self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    --self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext)
    --self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)
	
    self:SetPackedBool("AnnPlay",self.Panel.AnnouncerPlaying > 0)
    self:SetPackedRatio("Cran", self.Pneumatic.DriverValvePosition) 
    self:SetPackedRatio("BL", self.Pneumatic.BrakeLinePressure/16.0) 
    self:SetPackedRatio("TL", self.Pneumatic.TrainLinePressure/16.0) 
    self:SetPackedRatio("BC", math.max(math.min(3.2,self.Pneumatic.BrakeCylinderPressure),math.min(3.2,self.Pneumatic.MiddleBogeyBrakeCylinderPressure))/6.0) 
	
    self.AsyncInverter:TriggerInput("Speed", self.Speed)
	
   if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and IsValid(self.MiddleBogey) and not self.IgnoreEngine then

        local A = self.AsyncInverter.Torque
		--print(A)
        local add = 1
        if math.abs(self:GetAngles().pitch) > 4 then
            add = math.min((math.abs(self:GetAngles().pitch)-4)/2,1)
        end
        self.FrontBogey.MotorForce = (40000+5000*(A < 0 and 1 or 0))*add --35300
        self.FrontBogey.Reversed = (self.BUV.Reverser < 0.5)--<
        --self.FrontBogey.Reversed = self.KMR2.Value > 0
        --self.FrontBogey.DisableSound = 1
        self.RearBogey.MotorForce  = (40000+5000*(A < 0 and 1 or 0))*add --35300
        self.RearBogey.Reversed = (self.BUV.Reverser > 0.5)-->
        --self.RearBogey.Reversed = self.KMR1.Value > 0
        --self.RearBogey.DisableSound = 1

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.6*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.FrontBogey.DisableContacts = self.BUV.Pant
		self.MiddleBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.MiddleBogey.BrakeCylinderPressure = self.Pneumatic.MiddleBogeyBrakeCylinderPressure
        self.MiddleBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.MiddleBogeyBrakeCylinderPressure_dPdT
        self.MiddleBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)         		
        self.MiddleBogey.DisableContacts = self.BUV.Pant			
		self.RearBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
	    self.RearBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)	

    end
    return retVal
end	 

function ENT:OnCouple(train,isfront)
    if isfront and self.FrontAutoCouple then
        self.FrontBrakeLineIsolation:TriggerInput("Open",1.0)
        self.FrontTrainLineIsolation:TriggerInput("Open",1.0)
        self.FrontAutoCouple = false
    elseif not isfront and self.RearAutoCouple then
        self.RearBrakeLineIsolation:TriggerInput("Open",1.0)
        self.RearTrainLineIsolation:TriggerInput("Open",1.0)
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
	if button == "EmergencyBrakeValveToggle" and (self.K29.Value == 1 or self.Pneumatic.V4 and self:ReadTrainWire(27) == 1) and not self.Pneumatic.KVTBTimer and self.Pneumatic.BrakeLinePressure > 2 then	
		self:SetPackedRatio("EmerValve",CurTime()+3.8)
	end
    if button == "KAH" and not self.Plombs.KAH then
        self.KAHk:TriggerInput("Open",1)
        self.KAH:TriggerInput("Close",1)
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
	if button == "EmergencyBrakeValveToggle" and (self.K29.Value == 1 or self.Pneumatic.V4 and self:ReadTrainWire(27) == 1) and not self.Pneumatic.KVTBTimer then
		self:PlayOnce("valve_brake_close","",1,1) 
	end	
end