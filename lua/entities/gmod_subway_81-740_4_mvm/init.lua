AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "EnableBVEmer","Ticker","KAH","KAHk","ALS","ALSk","FDepot","PassScheme","EnableBV","DisableBV","Ring","R_Program2","R_Announcer","R_Line","R_Emer","R_Program1",
    "DoorSelectL","DoorSelectR","DoorBlock",
    "EmerBrakeAdd","EmerBrakeRelease","EmerBrake","DoorClose","AttentionMessage","Attention","AttentionBrake","EmergencyBrake",
    "SF1","SF2","SF3","SF4","SF5","SF6","SF7","SF8","SF9","SF10","SF11","SF12",
    "SF13","SF14","SF15","SF16","SF17","SF18","SF19","SF20","SF21","SF22",

    "SFV1","SFV2","SFV3","SFV4","SFV5","SFV6","SFV7","SFV8","SFV9","SFV10","SFV11",
    "SFV12","SFV13","SFV14","SFV15","SFV16","SFV17","SFV18","SFV19","SFV20","SFV21","SFV22",
    "SFV23","SFV24","SFV25","SFV26","SFV27","SFV28","SFV29","SFV30","SFV31","SFV32","SFV33","SFV34","SFV35",

    "Stand","EmergencyCompressor","EmergencyControls","Wiper","DoorLeft","AccelRate","HornB","DoorRight",

    "Pant1","Pant2","Vent1","Vent2","Vent","PassLight","CabLight","Headlights1","Headlights2",
    "ParkingBrake","TorecDoors","BBER","BBE","Compressor","CabLightStrength","AppLights1","AppLights2",
    "Battery", "ALSFreqBlock",
    "VityazF1", "VityazF2", "VityazF3", "VityazF4", "Vityaz1",  "Vityaz4",  "Vityaz7",  "Vityaz2",  "Vityaz5",  "Vityaz8",  "Vityaz0",  "Vityaz3",  "Vityaz6",  "Vityaz9",  "VityazF5", "VityazF6", "VityazF7", "VityazF8", "VityazF9",
    "K29", "UAVA",
    "EmerX1","EmerX2","EmerCloseDoors","EmergencyDoors",
    "R_ASNPMenu","R_ASNPUp","R_ASNPDown","R_ASNPOn","Antenna_off","Antenna_on","Antennamodel",
    "VentHeatMode",
	
	--"CAMS1","CAMS2","CAMS3","CAMS4",
	"CAMS5","CAMS6","CAMS7","CAMS8","CAMS9","CAMS10",

    "RearBrakeLineIsolation","RearTrainLineIsolation",
    "FrontBrakeLineIsolation","FrontTrainLineIsolation",
    "PB",   "GV",	"EmergencyBrakeValve","stopkran",
}
--------------------------------------------------------------------------------
function ENT:Initialize()
    -- Set model and initialize
	--print(self:GetNW2String("Texture"))
	self:SetModel("models/metrostroi_train/81-740/body/81-740_4_defualt_mos_front.mdl")
	
	--self:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))
	
    self.NormalMass = 24000	

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("driver",Vector(775-144,19,-30))
    --self.InstructorsSeat = self:CreateSeat("instructor",Vector(285,48,-40),Angle(0,40,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.InstructorsSeat2 = self:CreateSeat("instructor",Vector(767-144,45,-35),Angle(0,75,0),"models/vehicles/prisoner_pod_inner.mdl") 
    self.InstructorsSeat3 = self:CreateSeat("instructor",Vector(760-144,0,-40),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
    self.InstructorsSeat4 = self:CreateSeat("instructor",Vector(787-144,-25,-40),Angle(0,115,0),"models/vehicles/prisoner_pod_inner.mdl")

    --Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.DriverSeat:SetColor(Color(0,0,0,0))
    --self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    --self.InstructorsSeat:SetColor(Color(0,0,0,0))
    self.InstructorsSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat2:SetColor(Color(0,0,0,0))
    self.InstructorsSeat3:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat3:SetColor(Color(0,0,0,0))
    self.InstructorsSeat4:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.InstructorsSeat4:SetColor(Color(0,0,0,0))
	
	self.LightSensor = self:AddLightSensor(Vector(548-144,0,-130),Angle(0,90,0))
	
    -- Create bogeys
        self.FrontBogey = self:CreateBogey(Vector( 520,0,-75),Angle(0,180,0),true,"740")
--------------------------------------------------------------------------------
        self.RearBogey  = self:CreateBogey(Vector(-520,0,-75),Angle(0,0,0),true,"740NOTR") --110 0 -80 
		self.RearBogey:PhysicsInit(SOLID_VPHYSICS)
		
		self.FrontBogey:SetNWInt("MotorSoundType",2)
		self.RearBogey:SetNWInt("MotorSoundType",2)
        self.RearBogey.DisableContacts = true					
--------------------------------------------------------------------------------
        self.FrontCouple = self:CreateCouple(Vector(635,0,-60),Angle(0,0,0),true,"717")
--------------------------------------------------------------------------------
        self.RearCouple  = self:CreateCouple(Vector(-618,0,-60),Angle(0,-180,0),false,"740")
		self.RearCouple:SetModel("models/metrostroi_train/81-740/bogey/metro_couple_740.mdl") --
		self.RearCouple:PhysicsInit(SOLID_VPHYSICS)
		self.RearCouple:GetPhysicsObject():SetMass(5000)
		
	self:SetNW2Entity("FrontBogey",self.FrontBogey)
	self:SetNW2Entity("RearBogey",self.RearBogey)
	self:SetNW2Entity("FrontCouple",self.FrontCouple)
	self:SetNW2Entity("RearCouple",self.RearCouple)
	
	self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)
	self.FrontCouple.EKKDisconnected = true
    local rand = math.random()*0.05
    self.FrontBogey:SetNWFloat("SqualPitch",1.45+rand)
    self.RearBogey:SetNWFloat("SqualPitch",1.45+rand)
--------------------------------------------------------------------------------		
	timer.Simple(0.0, function() --взято с Томаса, спасибо авторам.
		local rand = math.random()*0.05
		self.MiddleBogey = self:CreateBogey(Vector(-8,0,-75),Angle(0,0,0),true,"740G")--тележка  ---160,0,-75 -410,0,-75
		self.MiddleBogey:SetNWFloat("SqualPitch",1.45+rand)
		self:SetNW2Entity("MiddleBogey",self.MiddleBogey)	
		self.MiddleBogey:SetNWInt("MotorSoundType",2)
		self.MiddleBogey:SetNWInt("Async",true)
		self.MiddleBogey:SetNWBool("DisableEngines",true)			
		self.MiddleBogey.DisableSound = 1		
		self.MiddleBogey:PhysicsInit(SOLID_VPHYSICS)		
		constraint.AdvBallsocket( 
		self,
		self.MiddleBogey,
		0, --bone
		0, --bone
		Vector(0,0,0), --Vector(70,0,90)
		Vector(0,0,0), --Vector(80,0,90)
		0, --forcelimit
		0, --torquelimit
		
		0, --xmin
		0, --ymin
		-180, --zmin
		
		0, --xmax
		0, --ymax
		180, --zmax
		
		0, --yfric
		0, --zfric
		0, --xfric
		0, --rotonly
		1 --nocollide
	)
end)	

local function CanConstrain( VAGON, self )

	if ( !VAGON )	then return false end
	if ( !VAGON:IsWorld() && !VAGON:IsValid() )	then return false end
	if ( !VAGON:GetPhysicsObjectNum( self ) || !VAGON:GetPhysicsObjectNum( self ):IsValid() )	then return false end

	return true

end

function self:CreateRear1(pos,ang,a)
	local VAGON = ents.Create("prop_physics")--ents.Create("prop_physics")
	VAGON:SetModel("models/metrostroi_train/81-740/body/81-740_4_rear_reference.mdl")--ent:SetModel("models/sligwolf/blue-x12/bluex12_train_socket.mdl")	 --"models/hunter/plates/plate.mdl"
	VAGON:SetPos(self:LocalToWorld(pos))
	VAGON:SetAngles(self:GetAngles())
	VAGON:Spawn()
	VAGON:SetOwner(self:GetOwner())	
	VAGON:GetPhysicsObject():SetMass(13000)
    VAGON:SetUseType(SIMPLE_USE)	
    -- Assign ownership	
    if CPPI and IsValid(self:CPPIGetOwner()) then VAGON:CPPISetOwner(self:CPPIGetOwner()) end	
	
	self:SetNW2Entity("VAGON",VAGON)
	--Сцепка, крепление к вагону.
	constraint.AdvBallsocket(
		VAGON,
		self.RearCouple,
		0, --bone
		0, --bone
		Vector(-320.2+20.8,0,-60),
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
	
	--Шарнирное крепление задней телеги к вагону.
	constraint.AdvBallsocket(
	VAGON,
	self.RearBogey,
		0, --bone
		0, --bone
		Vector(-200,0,75),
		Vector(200,0,75),
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
		1 --nocollide
	)
	
--Крепление вагона к средней тележке.
	constraint.AdvBallsocket( 
		self.MiddleBogey,
		VAGON,
		0, --bone
		0, --bone
		Vector(0,5,70), --Vector(70,0,90)
		Vector(100,5,70), --Vector(80,0,90)
		0, --forcelimit
		0, --torquelimit
		
		-100, --xmin --высота
		0, --ymin  --поворот влево/вправо
		-100, --zmin
		
		100, --xmax --высота
		0, --ymax --20  --поворот влево/вправо
		100, --zmax
		
		0, --yfric
		0, --zfric
		0, --xfric
		0, --rotonly
		1 --nocollide
	)
	constraint.AdvBallsocket( 
		self.MiddleBogey,
		VAGON,
		0, --bone
		0, --bone
		Vector(0,-5,70), --Vector(70,0,90)
		Vector(100,-5,70), --Vector(80,0,90)
		0, --forcelimit
		0, --torquelimit
		
		-100, --xmin --высота
		0, --ymin  --поворот влево/вправо
		-100, --zmin
		
		100, --xmax --высота
		0, --ymax --20  --поворот влево/вправо
		100, --zmax
		
		0, --yfric
		0, --zfric
		0, --xfric
		0, --rotonly
		1 --nocollide
	)
	-- Add to cleanup list
	table.insert(self.TrainEntities,VAGON)
	return VAGON
end 

--взято с Томаса, спасибо авторам.
timer.Simple(0.0, function()	
	self.Rear1 = self:CreateRear1(Vector(-331,0,0),Angle(0,0,0)) --вагон
end)
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
        [1]  = { "light",Vector(835-144, 27.5, -23), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [2]  = { "light",Vector(835-144, 40.5,-20.5), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [18]  = { "light",Vector(835-144, -27.5, -23), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        [19]  = { "light",Vector(835-144, -40.5, -20.5), Angle(0,0,0), Color(255,220,180), brightness = 0.5, scale = 0.5, texture = "sprites/light_glow02.vmt" },
        --красные огни 
        [3] = { "light",Vector(690, 41.5, -60), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[4] = { "light",Vector(690, -41.5, -60), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[5] = { "light",Vector(656, 40, 57), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
		[6] = { "light",Vector(656, -40, 57), Angle(0,0,0), Color(139, 0, 0), brightness = 0.6, scale = 0.4, texture = "sprites/light_glow02.vmt" },
        --освещение в кабине
        [10] = { "dynamiclight",    Vector( 755-144, 0, 40), Angle(0,0,0), Color(206,135,80), brightness = 1.5, distance = 550 },
        -- Interior
		[11] = { "dynamiclight",    Vector(190-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
		[12] = { "dynamiclight",    Vector(675-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [13] = { "dynamiclight",    Vector(420-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 },
		
		[14] = { "dynamiclight",    Vector( 80-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
		[15] = { "dynamiclight",    Vector(-70+144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [16] = { "dynamiclight",    Vector( -510+144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 }
    }

	 self.InteractionZones = {
        {   Pos = Vector(476, 64, 30),
            Radius = 48,
            ID = "CabinDoorLeft" },
        {   Pos = Vector(476, 64, -30),
            Radius = 48,
            ID = "CabinDoorLeft" },
        {   Pos = Vector(476, -60, 30),
            Radius = 48,
            ID = "CabinDoorRight" },
        {   Pos = Vector(466, -60, -30),
            Radius = 48,
            ID = "CabinDoorRight" },
        {   Pos = Vector(378, 39, 50),
            Radius = 32,
            ID = "OtsekDoor" },
        {   Pos = Vector(200, 39, 11),
            Radius = 48,
            ID = "OtsekDoor" },
        {
            ID = "FrontBrakeLineIsolationToggle",
            Pos = Vector(495, -22, -60), Radius = 16,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(495, 22, -60), Radius = 16,
        },
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-470, 30, -60), Radius = 16,
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-470, -30, -60), Radius = 16,
        },
        {
            ID = "RearDoor",
            Pos = Vector(764.8,5,55), Radius = 20,
        },
        {
            ID = "GVToggle",
            Pos = Vector(128,60,-75), Radius = 20,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-177, -66, -50), Radius = 20,
        },
    }
	
	function self:Use(ply)
    local tr = ply:GetEyeTrace()
    if not tr.Hit then return end
    local hitpos = self:WorldToLocal(tr.HitPos)
    print(hitpos)
    if self.InteractionZones and ply:GetPos():Distance(tr.HitPos) < 0 then
        for k,v in pairs(self.InteractionZones) do
            if hitpos:Distance(v.Pos) < v.Radius then
                self:ButtonEvent(v.ID,nil,ply)
            end
        end
    end
end	
	
    self.PassengerDoor = false
    self.CabinDoorLeft = false
    self.CabinDoorRight = false
    self.RearDoor = false
    self.OtsekDoor = true
    self.WrenchMode = 1
	self.Antenna_off = false	
	self.Antenna_on = false	
	self.KVWrenchMode = self.WrenchMode

--наложение пломб
	self.Plombs = {
        KAH = {true,"KAHk"},
        KAHk = true,
        ALS = {true,"ALSk"},
        ALSk = true,
        BARSBlock = true,
        UAVA = true,
        Init = true,
    }
	
	self.HeadLightBroken = {}
	self.RedLightBroken = {}
	--self:TrainSpawnerUpdate()
end

--если на карте нету сигналки включить ВП
function ENT:NonSupportTrigger()
	self.ALSFreqBlock:TriggerInput("Set",1)
	self.Plombs.ALSFreqBlock = nil
end
function ENT:TriggerLightSensor(coil,plate)
	--self.Prost_Kos:TriggerSensor(coil,plate)
	self.Prost_Kos:Think()
end

function ENT:TrainSpawnerUpdate()

	--рандом поломанных фар
	self.HeadLightBroken = {}
	for i = 1, 4 do
		if math.random(1, 4) == 1 then 
			self.HeadLightBroken[i] = true				
			self:SetNW2Bool("HeadLightBroken"..i, true)
		else
			self.HeadLightBroken[i] = false		
			self:SetNW2Bool("HeadLightBroken"..i, false)
		end
	end
	self.RedLightBroken = {}
	for i = 1, 4 do
		if math.random(1, 4) == 1 then 
			self.RedLightBroken[i] = true				
			self:SetNW2Bool("RedLightBroken"..i, true)
		else
			self.RedLightBroken[i] = false		
			self:SetNW2Bool("RedLightBroken"..i, false)
		end
	end
	
	local MotorType = self:GetNW2Int("MotorType")	
       if MotorType == 1 then
            MotorType = math.ceil(math.random()*1+0.5)
          else MotorType = MotorType-1 end	
	self:SetNW2Int("MotorType",MotorType)	
	self:SetNW2Int("MotorType",math.random(1, 2))		
    --рандомизация цвета табло
	--local ALS = math.random(1, 3)
	--self:SetNW2Int("tablo_color", ALS)
	--print(self:GetNW2String("Texture"))
end

--------------------------------------------------------------------------------
function ENT:Think()
    local retVal = self.BaseClass.Think(self)
    local power = self.Electric.Battery80V > 62
    --print(self,self.BPTI.T,self.BPTI.State)

    --[[ if self.BUV.Brake > 0 then
        self:SetPackedRatio("RNState", power and (Train.K2.Value>0 or Train.K3.Value>0) and self.Electric.RN > 0 and (1-self.Electric.RNState)+math.Clamp(1-(math.abs(self.Electric.Itotal)-50)/50,0,1) or 1)
    else
        self:SetPackedRatio("RNState", power and (Train.K2.Value>0 or Train.K3.Value>0) and self.Electric.RN > 0 and self.Electric.RNState+math.Clamp(1-(math.abs(self.Electric.Itotal)-50)/50,0,1) or 1)
    end--]]
    if self.BPTI.State < 0 then
        self:SetPackedRatio("RNState", ((self.BPTI.RNState)-0.25)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*2)/20,0,1))
        --self:SetNW2Int("RNFreq", 13)
    else--if self.BPTI.State > 0 then
        self:SetPackedRatio("RNState", (0.75-self.BPTI.RNState)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*2)/20,0,1))
        --self:SetNW2Int("RNFreq", ((self.BPTI.FreqState or 0)-1/3)/(2/3)*12)
    --[[ else
        self:SetPackedRatio("RNState", 0)--]]
    end
	
		--скорость дверей
		for k,v in pairs(self.Pneumatic.LeftDoorSpeed) do
			self.Pneumatic.LeftDoorSpeed[k] = -2, 10
		end
		
		for k,v in pairs(self.Pneumatic.RightDoorSpeed) do
			self.Pneumatic.RightDoorSpeed[k] = -2, 10
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
    self:SetPackedBool("BBEWork",power and self.BUV.BBE > 0)
    self:SetPackedBool("WorkBeep",power)
	self:SetPackedBool("BUKPRing",power and self.BUKP.State == 5 and self.BUKP.ProstRinging)
	self:SetPackedBool("CAMSRing",power and self.CAMS.State == 0 and self.CAMS.ButtonRing)

	local HeadlightsPower = power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.Headlights1.Value > 0 and (self.SF13.Value > 0 and self.Headlights2.Value > 0 and 1 or self.SF12.Value > 0 and 0.5) or 0
    --print(0.4+math.max(0,math.min(1,1-(self.Speed-30)/30))*0.5)
    --print((80-self.Engines.Speed))
	local brightness = math.min(1,self.Panel.Headlights1)*0.60 +
                        math.min(1,self.Panel.Headlights2)*0.40	
    self:SetPackedBool("Headlights1",self.Panel.Headlights1 > 0)
    self:SetPackedBool("Headlights2",self.Panel.Headlights2 > 0)
    local redlights = self.Panel.RedLights>0
    self:SetPackedBool("RedLights",power and (self.KV["KRO5-6"] > 0 or self.KV["KRR15-16"] > 0) and self.SF14.Value > 0)
		
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
	
	
	--self:SetLightPower(12,passlight > 0, passlight)
	--self:SetLightPower(13,passlight > 0, passlight)
	--self:SetLightPower(14,passlight > 0, passlight)
    self:SetLightPower(11,passlight > 0, passlight)
    self:SetLightPower(12,passlight > 0, passlight)
    self:SetLightPower(13,passlight > 0, passlight)
	
	self:SetLightPower(14,passlight > 0, passlight, VAGON)
    self:SetLightPower(15,passlight > 0, passlight, VAGON)
    self:SetLightPower(16,passlight > 0, passlight, VAGON)
    self:SetPackedRatio("SalonLighting",passlight)
	--print(passlight)
    --self:SetPackedRatio("TrainLine",7.3/16)
    --self:SetPackedRatio("BrakeLine",5.2/16)
    --self:SetPackedRatio("BrakeCylinder",self.AsyncInverter.PN1*1.1/6)
	self:SetNW2Int("RouteNumber",self.ASNP.RouteNumber)
	--self.RouteNumber = self.ASNP.RouteNumber
	--print(self.RouteNumber)
    self:SetPackedRatio("BIAccel",0 or power and self.BARS.BIAccel or 0)
	

	
    self:SetNW2Int("BISpeed",power and self.Speed or -1)--CurTime()%5*20
    self:SetNW2Bool("BISpeedLimitBlink",power and self.BARS.BINoFreq > 0)
    self:SetNW2Int("BISpeedLimit",power and self.BARS.SpeedLimit or 100)
    self:SetNW2Int("BISpeedLimitNext",power and self.BARS.NextLimit or 100)
    self:SetNW2Bool("BIForward",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.Speed > -0.2)
    self:SetNW2Bool("BIBack",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.Speed < 0.2)
    self:SetNW2Bool("DoorsClosed",power and self.BUKP.DoorClosed)
    self:SetNW2Bool("HVoltage",power and self.BUKP.HVBad)
    self:SetNW2Bool("DoorLeftLamp",self.Panel.DoorLeft>0)
    self:SetNW2Bool("DoorRightLamp",self.Panel.DoorRight>0)
    self:SetNW2Bool("EmerBrakeWork",self.Panel.EmerBrakeWork>0)
    self:SetNW2Bool("TickerLamp",self.Panel.Ticker>0)
    self:SetNW2Bool("KAHLamp",self.Panel.KAH>0)
    self:SetNW2Bool("ALSLamp",self.Panel.ALS>0)
    self:SetNW2Bool("PassSchemeLamp",self.Panel.PassScheme>0)
    self:SetNW2Bool("R_AnnouncerLamp",self.Panel.R_Announcer>0)
    self:SetNW2Bool("R_LineLamp",self.Panel.R_Line>0)
    self:SetNW2Bool("AccelRateLamp",power and self.BUKP.Slope)
    self:SetNW2Bool("DoorCloseLamp",self.Panel.DoorClose>0)
    self:SetNW2Bool("DoorBlockLamp",self.Panel.DoorBlock>0)
    self:SetPackedBool("AppLights", self.Panel.EqLights>0)
	
	self:SetNW2Bool("DAU",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.DAU)
	self:SetNW2Bool("XOD",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.Speed > 0.2)
	self:SetNW2Bool("Dnepr",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.Dnepr)
	self:SetNW2Bool("Ispr",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.Ispr)
	self:SetNW2Bool("LN",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.LN)
	self:SetNW2Bool("AO",power and (self.KV["KRO3-4"] > 0 or self.KV["KRR5-6"] > 0) and self.BARS.AO)

    self:SetPackedRatio("LV",self.Electric.Battery80V/150)
    self:SetPackedRatio("HV",self.Electric.Main750V/1000)
    self:SetPackedRatio("I13",(self.Electric.I13+500)/1000)
    self:SetPackedRatio("I24",(self.Electric.I24+500)/1000)
    self:SetPackedBool("PassengerDoor",self.PassengerDoor)
    self:SetPackedBool("CabinDoorLeft",self.CabinDoorLeft)
    self:SetPackedBool("CabinDoorRight",self.CabinDoorRight)
    self:SetPackedBool("RearDoor",self.RearDoor)
    self:SetPackedBool("OtsekDoor",self.OtsekDoor)
    self:SetPackedBool("CompressorWork",self.Pneumatic.Compressor)
    self:SetPackedBool("Vent2Work",self.Electric.Vent2>0)
    self:SetPackedBool("RingEnabled",self.BUKP.Ring)
	
    self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext)
    self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)
	
    self:SetPackedBool("AnnPlay",self.Panel.AnnouncerPlaying > 0)

    self:SetPackedRatio("Cran", self.Pneumatic.DriverValvePosition)
    self:SetPackedRatio("BL", self.Pneumatic.BrakeLinePressure/16.0)
    self:SetPackedRatio("TL", self.Pneumatic.TrainLinePressure/16.0)
    self:SetPackedRatio("BC", math.min(3.2,self.Pneumatic.BrakeCylinderPressure)/6.0)
    self.Engines:TriggerInput("Speed",self.Speed)

   if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and IsValid(self.MiddleBogey) and not self.IgnoreEngine then

        local A = 2*self.Engines.BogeyMoment
        self.FrontBogey.MotorForce = (24000+6500*(A < 0 and 1 or 0))--*add--35300+10000*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = self.KMR2.Value > 0.5
        self.MiddleBogey.MotorForce  = (24000+6500*(A < 0 and 1 or 0))--*add--+5000--35300
        self.MiddleBogey.Reversed = self.KMR1.Value > 0.5
		self.RearBogey.MotorForce  = (24000+6500*(A < 0 and 1 or 0))--*add--+5000--35300
        self.RearBogey.Reversed = self.KMR1.Value > 0.5		

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.09879*math.abs(A) - 0.565729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.FrontBogey.DisableContacts = self.BUV.Pant
        self.MiddleBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.MiddleBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.MiddleBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
		self.RearBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT

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
    if button == "PassengerDoor" then self.PassengerDoor = not self.PassengerDoor end
    if button == "CabinDoorLeft" then self.CabinDoorLeft = not self.CabinDoorLeft end
    if button == "OtsekDoor" then self.OtsekDoor = not self.OtsekDoor end
    if button == "CabinDoorRight" then self.CabinDoorRight = not self.CabinDoorRight end
	if button == "Antenna_on" then self.Antenna_on = not self.Antenna_on end
	if button == "Antenna_off" then self.Antenna_off = not self.Antenna_off end
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
    if button == "DoorLeft" then
        self.DoorLeft:TriggerInput("Set",0)
    end
    if button == "DoorRight" then
        self.DoorRight:TriggerInput("Set",0)
    end
    if button == "DoorClose" then
         self.EmerCloseDoors:TriggerInput("Set",0)
    end
    if button == "RearDoor" and (self.RearDoor or not self.BUV.BlockTorec) then self.RearDoor = not self.RearDoor end	
	if button == "EmergencyBrakeValveToggle" and (self.K29.Value == 1 or self.Pneumatic.V4 and self:ReadTrainWire(27) == 1) and not self.Pneumatic.KVTBTimer then
		self:PlayOnce("valve_brake_close","",1,1)
	end	
end