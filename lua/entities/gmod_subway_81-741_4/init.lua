local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk")
or Map:find("gm_metro_krl")
or Map:find("gm_metro_kaluzh_line")
or Map:find("gm_metro_kaluzhkaya_line")
or Map:find("gm_moscow_line_7")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_bolshua_kolsevya_line")
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
    "SFV1","SFV2","SFV3","SFV4","SFV5","SFV6","SFV7","SFV8","SFV9","SFV10","SFV11",
    "SFV12","SFV13","SFV14","SFV15","SFV16","SFV17","SFV18","SFV19","SFV20","SFV21","SFV22",
    "SFV23","SFV24","SFV25","SFV26","SFV27","SFV28","SFV29","SFV30","SFV31","SFV32","SFV33",
    "RearBrakeLineIsolation","RearTrainLineIsolation", "EmerBrakeCrane1","EmerBrakeCrane2",
    "FrontBrakeLineIsolation","FrontTrainLineIsolation","Battery","PVZ_otsek","PVZ_otsek_open",
    "GV",
}
--
function ENT:Initialize()
    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-741/body/81-741_4_front.mdl")
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))	

    self.NormalMass = 24000--20000

    -- Create seat entities
	self.DriverSeat = self:CreateSeat("instructor",Vector(610,11,-35),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")

    -- Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.DriverSeat:SetColor(Color(0,0,0,0))
	
	self.DriverSeat.m_tblToolsAllowed = { "none" }		

 -- Create bogeys
        self.FrontBogey = self:CreateBogey(Vector( 505,0,-80),Angle(0,180,0),true,"740PER")
		self.FrontBogey.PneumaticPow = 0.7			
        self.RearBogey  = self:CreateBogey(Vector(-540,0,-80),Angle(0,0,0),false,"740NOTR") --110 0 -80  
		self.RearBogey:PhysicsInit(SOLID_VPHYSICS)	
		self.FrontBogey:SetNWInt("MotorSoundType",2)
		self.RearBogey:SetNWInt("MotorSoundType",2)		
	    self.RearBogey.DisableContacts = true	
		self.RearBogey.PneumaticPow = 0.7			
        self.FrontCouple = self:CreateCouple(Vector(608-17,0,-60),Angle(0,0,0),true,"740")		
        self.RearCouple = self:CreateCouple(Vector(-612-17,0,-60),Angle(0,-180,0),false,"740")
		self.RearCouple:PhysicsInit(SOLID_VPHYSICS)
		self.RearCouple:GetPhysicsObject():SetMass(5000)		
		local opt = Vector(67,0,0)
		self.FrontCouple.CouplingPointOffset = opt		
		self.RearCouple.CouplingPointOffset = opt - Vector(1,0,0)
		
		self.FrontCouple.m_tblToolsAllowed = { "none" }	
		self.RearCouple.m_tblToolsAllowed = { "none" }	
		self.FrontBogey.m_tblToolsAllowed = { "none" }	
		self.RearBogey.m_tblToolsAllowed = { "none" }		
		
		self:SetNW2Entity("FrontBogey",self.FrontBogey)
		self:SetNW2Entity("RearBogey",self.RearBogey)	
		self:SetNW2Entity("RearCouple",self.RearCouple)	
		self:SetNW2Entity("FrontCouple",self.FrontCouple)  		
	
timer.Simple(0.1, function()	
        if not IsValid(self) then return end
		self.Pricep = self:CreatePricep(Vector(-343,0,0))--вагон
		local opt65 = Vector(65,0,0)	
		self.RearCouple.CouplingPointOffset = opt65
		self.FrontCouple.CouplingPointOffset = opt65					
end)
	
	self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)

    local rand = math.random()*0.05
    self.FrontBogey:SetNWFloat("SqualPitch",1.45+rand)
    self.RearBogey:SetNWFloat("SqualPitch",1.45+rand)
--	
    -- Initialize key mapping
    self.KeyMap = {
        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",
    }
    -- Cross connections in train wires
    self.TrainWireCrossConnections = {
        [4] = 3, -- Orientation F<->B
        [13] = 12, -- Reverser F<->B
        [38] = 37, -- Doors L<->R
    }
-- зоны взаимодействия
    self.InteractionZones = {
        {
            ID = "FrontBrakeLineIsolationToggle",
            Pos = Vector(660,-22.0,-45), Radius = 16,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(660,22.0,-45), Radius = 16,
        },
        {
            ID = "FrontDoor",
            Pos = Vector(654,0,25), Radius = 20,
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
    self.Lights = {
        -- Interior
		[15] = { "dynamiclight",    Vector(280-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 }, 
		[16] = { "dynamiclight",    Vector(420-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [17] = { "dynamiclight",    Vector(705-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 },	
    }
    self.FrontDoor = false
	
    self.PVZ_otsek_close = false		
    self.PVZ_otsek = false
    self.PVZ_otsek_open = false		
	
	self.Lamps = {
        broken = {},
    }		
	
    local rand = math.random() > 0.9 and 1 or math.random(0.95,0.99)
    for i = 1,20 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.7 end
    end		
	
    self:UpdateLampsColors()		
	
end

function ENT:TrainSpawnerUpdate()
	local MotorType = self:GetNW2Int("MotorType")	
       if MotorType == 1 then
            MotorType = math.ceil(math.random()*4+0.5)
          else MotorType = MotorType-1 end	
	self:SetNW2Int("MotorType",MotorType)	
	--self:SetNW2Int("MotorType",math.random(1, 2))	

	local AsyncSound = self:GetNW2Int("AsyncSound")	
       if AsyncSound == 1 then
            AsyncSound = math.ceil(math.random()*4+0.5)
          else AsyncSound = AsyncSound-1 end	
	self:SetNW2Int("AsyncSound",AsyncSound)	
	--self:SetNW2Int("AsyncSound",math.random(1, 2))	

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
	
local ahahaha =  math.random (1,5)
	for i = 1,12 do
		self:SetNW2Int("DoorsAnim"..i,math.random(ahahaha,15))
	end
	
		local sp = math.random (-6,-15)		
		local sp1 = math.random (10,17)			
		--скорость дверей
		for k,v in pairs(self.Pneumatic.LeftDoorSpeed) do
			self.Pneumatic.LeftDoorSpeed[k] = -5.5 + math.random(-sp,sp1) / 12
		end
		
		for k,v in pairs(self.Pneumatic.RightDoorSpeed) do
			self.Pneumatic.RightDoorSpeed[k] = -15.5 + math.random(-sp,sp1) / 12
		end	
	
end	

function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),40
	local mr = math.random
    local rand = mr() > 0.8 and 1 or mr(0.95,0.99)
	local rnd1,rnd2,col = 0.7+mr()*0.3,mr()
	local typ = math.Round(mr())
	local r,g = 15,15
	for i = 1,40 do
		local chtp = mr() > rnd1
		if typ == 0 and chtp then
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
		--PrintTable(self.Lamps.broken)	
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

function ENT:CreatePricep(pos)
	local ent = ents.Create("gmod_subway_kuzov")
    if not IsValid(ent) then return end	
	ent:SetPos(self:LocalToWorld(pos))
	ent:SetAngles(self:LocalToWorldAngles(Angle(0,0,0)))
	ent:Spawn()
	ent:SetOwner(self:GetOwner())	
	ent:DrawShadow(false)				
	if CPPI and IsValid(self:CPPIGetOwner()) then ent:CPPISetOwner(self:CPPIGetOwner()) end	
	self:SetNW2Entity("gmod_subway_kuzov",ent)
	
	table.insert(self.TrainEntities,ent)
    table.insert(ent.TrainEntities,self)	

	self.MiddleBogey = self:CreateBogey(Vector(-18,0,-80),Angle(0,0,0),true,"740G")--тележка  ---160,0,-75 -410,0,-75	
	self:SetNW2Entity("MiddleBogey",self.MiddleBogey)	
    local rand = math.random()*0.05	
	self.MiddleBogey:SetNWFloat("SqualPitch",1.45+rand) 		
	self.MiddleBogey:SetNWInt("MotorSoundType",2)
	self.MiddleBogey:SetNWInt("Async",true)
	self.MiddleBogey:SetNWBool("DisableEngines",true)			
	self.MiddleBogey.DisableSound = 1	
	self.MiddleBogey.m_tblToolsAllowed = { "none" }
    self.MiddleBogey:PhysicsInit(SOLID_VPHYSICS)	
    self.MiddleBogey:GetPhysicsObject():SetMass(5000)
	
	constraint.NoCollide(self.MiddleBogey,ent,0,0)
	constraint.NoCollide(self,ent,0,0)	
	constraint.NoCollide(ent,self.MiddleBogey,0,0)
	constraint.NoCollide(self.MiddleBogey,self,0,0)		

	constraint.RemoveConstraints(self.RearCouple, "AdvBallsocket")	
	constraint.RemoveConstraints(self.MiddleBogey, "AdvBallsocket")	
	constraint.RemoveConstraints(ent, "AdvBallsocket")	
	
	constraint.Axis(
		self.RearBogey,		
		ent,
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
	constraint.AdvBallsocket(
		ent,
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
	
	local xmin = 0
	local xmax = 0
	
	local ymin = xmin
	local ymax = xmax
	
	local zmin = -10
	local zmax = 10		
	
		constraint.AdvBallsocket(
			self.MiddleBogey,	
			self,
			0, --bone
			0, --bone
			Vector(0,0,-30),
			Vector(-305,0,0),		
			0, --forcelimit
			0, --torquelimit
			xmin, --xmin
			ymin, --ymin
			zmin, --zmin
			xmax, --xmax
			ymax, --ymax
			zmax, --zmax
			0, --xfric
			0, --yfric
			0, --zfric
			0, --rotonly
			1,--nocollide
			true	
		)
		
	constraint.AdvBallsocket(
			self.MiddleBogey,
			ent,
			0, --bone
			0, --bone		
			Vector(0,0,30),
			pos,		
			0, --forcelimit
			0, --torquelimit
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
			1--nocollide
		)
		constraint.AdvBallsocket(
			self.MiddleBogey,	
			ent,
			0, --bone
			0, --bone		
			Vector(0,0,-30),
			pos,	
			0, --forcelimit
			0, --torquelimit
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
			1--nocollide
		)
	else
	
	local xmin = -2
	local xmax = 2
	
	local ymin = xmin
	local ymax = xmax
	
	local zmin = -35
	local zmax = 35
		
		constraint.AdvBallsocket(
			self.MiddleBogey,	
			self,
			0, --bone
			0, --bone
			Vector(0,0,-10),
			pos,	
			0, --forcelimit
			0, --torquelimit
			xmin, --xmin
			ymin, --ymin
			zmin, --zmin
			xmax, --xmax
			ymax, --ymax
			zmax, --zmax
			0, --xfric
			0, --yfric
			0, --zfric
			0, --rotonly
			1,--nocollide
			true	
		)		
		
		constraint.AdvBallsocket(
			self.MiddleBogey,	
			self,
			0, --bone
			0, --bone
			Vector(0,0,40),
			pos,
			0, --forcelimit
			0, --torquelimit
			xmin, --xmin
			ymin, --ymin
			zmin, --zmin
			xmax, --xmax
			ymax, --ymax
			zmax, --zmax
			0, --xfric
			0, --yfric
			0, --zfric
			0, --rotonly
			1,--nocollide
			true	
		)			
		
		constraint.AdvBallsocket(	
			self.MiddleBogey,			
			ent,
			0, --bone
			0, --bone,		
			Vector(0,0,-5),
			pos,		
			0, --forcelimit
			0, --torquelimit
			xmin, --xmin
			ymin, --ymin
			zmin, --zmin
			xmax, --xmax
			ymax, --ymax
			zmax, --zmax
			0, --xfric
			0, --yfric
			0, --zfric
			0, --rotonly
			1,--nocollide
			true	
		)
		constraint.AdvBallsocket(	
			self.MiddleBogey,			
			ent,
			0, --bone
			0, --bone,		
			Vector(0,0,25),
			pos,		
			0, --forcelimit
			0, --torquelimit
			xmin, --xmin
			ymin, --ymin
			zmin, --zmin
			xmax, --xmax
			ymax, --ymax
			zmax, --zmax
			0, --xfric
			0, --yfric
			0, --zfric
			0, --rotonly
			1,--nocollide
			true	
		)		
	end
	
    Metrostroi:RerailChange(self.FrontBogey, true)
    Metrostroi:RerailChange(self.MiddleBogey, true)
    Metrostroi:RerailChange(self.RearBogey, true)		

	--Метод mirror 				
    ent.HeadTrain = self 
    ent:SetNW2Entity("HeadTrain", self)
	
	ent.ButtonBuffer = {}
	ent.KeyBuffer = {}
	ent.KeyMap = {}			
end
--
--Основное
function ENT:Think()	
    local retVal = self.BaseClass.Think(self)
    local power = self.Electric.Battery80V > 62 --Батарея
	local Panel = self.Panel		
	
    local state = math.abs(self.AsyncInverter.InverterFrequency/(11+self.AsyncInverter.State*5))--(10+8*math.Clamp((self.AsyncInverter.State-0.4)/0.4,0,1)))
    self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+self.AsyncInverter.State/1),0,1)*math.Clamp(self.Speed/6,0,1))
    self:SetPackedRatio("asyncstate", math.Clamp(self.AsyncInverter.State/0.2*math.abs(self.AsyncInverter.Current)/100,0,1))
    self:SetPackedRatio("chopper", math.Clamp(self.Electric.Chopper>0 and self.Electric.IChopped/100 or 0,0,1))
		
	local lightsActive1 = power and self.SFV20.Value > 0 
    local lightsActive2 = power and self.BUV.MainLights 
	local mul = 0
    local Ip = 7 or 6.9 
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
	
    --свет в салоне
    local passlight = power and (self.BUV.MainLights and 1 or self.SFV20.Value > 0.5 and 0.4) or 0		
	
	self:SetLightPower(15,passlight > 0, passlight and mul/40)
	self:SetLightPower(16,passlight > 0.5, passlight and mul/40)
	self:SetLightPower(17,passlight > 0, passlight and mul/40)
		
    -- получение всяких значений
    self:SetPackedRatio("Speed", self.Speed)
    self:SetPackedBool("CompressorWork",self.Pneumatic.Compressor)
    self:SetPackedBool("Vent2Work",self.Electric.Vent2>0)
    self:SetPackedBool("BBEWork",power and self.BUV.BBE > 0)
	self:SetPackedBool("PVZ_otsek",self.PVZ_otsek)
	self:SetPackedBool("PVZ_otsek_open",self.PVZ_otsek)	
	
    self:SetPackedRatio("TrainLine", self.Pneumatic.BrakeLinePressure/16.0)
    self:SetPackedRatio("BrakeLine", self.Pneumatic.TrainLinePressure/16.0)
	self:SetPackedRatio("BrakeCylinder", math.min(3.3,self.Pneumatic.BrakeCylinderPressure)/6.0)		
	
    --self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    --self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext) 
    --self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)

    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)
    self:SetPackedBool("FrontDoor",self.FrontDoor)
	self:SetPackedRatio("SalonLighting",passlight)
    self.AsyncInverter:TriggerInput("Speed",self.Speed)
    
    --мощность двигателей и тормозов    
   if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and IsValid(self.MiddleBogey) and not self.IgnoreEngine then

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
        self.RearBogey.MotorForce  = (40000+5000*(A < 0 and 1 or 0))*add --35300
        self.RearBogey.Reversed = (self:ReadTrainWire(12) > 0.5)-->
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
--	 
--При сцепке открывать краны
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
    if button == "FrontDoor" and (self.FrontDoor or not self.BUV.BlockTorec) then self.FrontDoor = not self.FrontDoor end
	
	if button == "PVZ_otsek" then self.PVZ_otsek = not self.PVZ_otsek end	
	if button == "PVZ_otsek_open" then self.PVZ_otsek_open = not self.PVZ_otsek_open end	
end
function ENT:OnButtonRelease(button,ply)
end