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

    self.NormalMass = 24000
	self:GetBaseVelocity()	

    -- Create seat entities
	self.DriverSeat = self:CreateSeat("instructor",Vector(610-340,11,-35),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")

    -- Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.DriverSeat:SetColor(Color(0,0,0,0))
	
	self.DriverSeat.m_tblToolsAllowed = {"none"}		

 -- Create bogeys
    self.FrontBogey = self:CreateBogey(Vector( 170,0,-74.5),Angle(0,180,0),true,"740PER")
    self.RearBogey  = self:CreateBogey(Vector(-358.5,0,-74.91),Angle(0,0,0),false,"740G")
	self.RearBogey:SetSolid(SOLID_VPHYSICS)
	self.RearBogey:PhysicsInit(SOLID_VPHYSICS)    
	self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)	
	self.FrontBogey:SetNWInt("MotorSoundType",2)
	self.RearBogey:SetNWInt("MotorSoundType",2)  
	self.FrontBogey.m_tblToolsAllowed = {"none"}		
    local rand = math.random()*0.05
    self.FrontBogey:SetNWFloat("SqualPitch",1.45+rand)
    self.RearBogey:SetNWFloat("SqualPitch",1.45+rand)
	self.RearBogey.m_tblToolsAllowed = {"none"}	   
	
	timer.Simple(0.1, function()    
	if not IsValid(self) then return end
	self.CoupleFront = self:CreateCouple(Vector( 247,0,-60),Angle(0,0,0),true,"740")
	self.CoupleFront.m_tblToolsAllowed = {"none"}
	self:SetNW2Entity("CoupleFront",self.CoupleFront)	
	self.Pricep = self:CreatePricep(Vector(0,0,0))--вагон		
	end)
	
	self:SetNW2Entity("FrontBogey",self.FrontBogey)
	self:SetNW2Entity("RearBogey",self.RearBogey)

    self.RearBogey.CouplingPointOffset = Vector(-635,0,0) 
    self.FrontBogey.CouplingPointOffset = Vector(-144,0,0) 
	
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
            Pos = Vector(660-340,-22.0,-45), Radius = 16,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(660-340,22.0,-45), Radius = 16,
        },
        {
            ID = "FrontDoor",
            Pos = Vector(654-340,0,25), Radius = 20,
        },
        {
            ID = "GVToggle",
            Pos = Vector(128-340,60,-75), Radius = 20,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-177-340, -66, -50), Radius = 20,
        },
    }
    self.Lights = {
        -- Interior
		[15] = { "dynamiclight",    Vector(280-144-340, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 }, 
		[16] = { "dynamiclight",    Vector(420-144-340, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [17] = { "dynamiclight",    Vector(705-144-340, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 },	
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
	for i = 1,6 do
		self:SetNW2Int("DoorsAnim"..i,math.random(ahahaha,15))
	end
	
		local sp = math.random (-6,-15)
		local sp1 = math.random (10,17)
		--скорость дверей
		for k,v in pairs(self.Pneumatic.LeftDoorSpeed) do
			self.Pneumatic.LeftDoorSpeed[k] = -5.5 + math.random(-sp,sp1) / 6
		end

		for k,v in pairs(self.Pneumatic.RightDoorSpeed) do
			self.Pneumatic.RightDoorSpeed[k] = -15.5 + math.random(-sp,sp1) / 6
		end	
	
end

function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),20
	local mr = math.random
    local rand = mr() > 0.8 and 1 or mr(0.95,0.99)
	local rnd1,rnd2,col = 0.7+mr()*0.3,mr()
	local typ = math.Round(mr())
	local r,g = 15,15
	for i = 1,20 do
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
function ENT:CreatePricep(pos,ang)
	local ent = ents.Create("gmod_subway_kuzov")
    if not IsValid(ent) then return end
	ent:SetPos(self:LocalToWorld(Vector(-684,0,0)))
    ent:SetAngles(self:LocalToWorldAngles(Angle(0,0,0)))
	ent:Spawn()
	ent:SetOwner(self:GetOwner())
	ent:DrawShadow(false)
	if CPPI and IsValid(self:CPPIGetOwner()) then ent:CPPISetOwner(self:CPPIGetOwner()) end
    ent.SpawnPos = pos
    ent.SpawnAng = ang	
	self:SetNW2Entity("gmod_subway_kuzov",ent)
    ent:SetNWEntity( "gmod_subway_kuzov", self )    
  
	table.insert(ent.TrainEntities,self)      
    table.insert(self.TrainEntities,ent)	

	self.PricepBogey = self:CreateBogey(Vector(-885,0,-76.1),Angle(0,0,0),false,"740NOTR")
	self.PricepBogey:SetSolid(SOLID_VPHYSICS)
	self.PricepBogey:PhysicsInit(SOLID_VPHYSICS)
    local rand = math.random()*0.05
	self.PricepBogey:SetNWFloat("SqualPitch",1.45+rand)
	self.PricepBogey:SetNWInt("MotorSoundType",2)
	self.PricepBogey:SetNWInt("Async",true)
	self.PricepBogey.m_tblToolsAllowed = {"none"}
	self:SetNW2Entity("PricepBogey",self.PricepBogey)
    local RB = self.RearBogey	
	local PB = self.PricepBogey 

    local xmax = 1.75    
    local ymax = 1.75
    local zmax = 25

    local xmin = -1.75    
    local ymin = -1.75
    local zmin = -25
    --local VCT1 = Vector(314,0,65) 

    constraint.AdvBallsocket(
		self,
		RB,
        0, --bone
        0, --bone    
		Vector(-314,0,3),
		Vector(-314,0,60),
		0, --forcelimit
		0, --torquelimit
		0, --xmin
		0, --ymin
		zmin, --zmin
		0, --xmax
		0, --ymax
		zmax, --zmax
        0, --xfric
        0, --yfric
        0, --zfric
        0, --rotonly
        1 --nocollide
    )

    --[[constraint.AdvBallsocket(
		ent,
		PB,
		0, --bone
		0, --bone
		VCT1,
		VCT1,
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
		1 --nocollide
	)]]

    --[[constraint.AdvBallsocket(
		ent,
		PB,
		0, --bone
		0, --bone
		Vector(314,0,5),
		VCT1,
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
		1 --nocollide
	)]]
	
    local VLD = IsValid
	
	if VLD(ent:GetPhysicsObject()) then
        self.NormalMass = ent:GetPhysicsObject():GetMass()
    end
	--[[if VLD(self:GetPhysicsObject()) then
        RB.NormalMass = self:GetPhysicsObject():GetMass()
    end]]
	if VLD(ent:GetPhysicsObject()) then
        RB.NormalMass = ent:GetPhysicsObject():GetMass()
    end
	if VLD(PB:GetPhysicsObject()) then
        self.NormalMass = PB:GetPhysicsObject():GetMass()
    end
	--Метод mirror 				
    ent.HeadTrain = self 
    ent:SetNW2Entity("HeadTrain", self)
	
	ent.ButtonBuffer = {}
	ent.KeyBuffer = {}
	ent.KeyMap = {}
	
	return ent
end
--
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
	
    local passlight = power and (self.BUV.MainLights and 1 or self.SFV20.Value > 0.5 and 0.4) or 0
	
	self:SetLightPower(15,passlight > 0, passlight and mul/40)
	self:SetLightPower(16,passlight > 0.5, passlight and mul/40)
	self:SetLightPower(17,passlight > 0, passlight and mul/40)
	local fB = self.FrontBogey
	local rB = self.RearBogey
	local pB = self.PricepBogey	
    self:SetPackedRatio("Speed", self.Speed)
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
	
    if IsValid(fB) and IsValid(rB) and IsValid(pB) and not self.IgnoreEngine then

        local A = self.AsyncInverter.Torque
		--print(A)
        local add = 1
        if math.abs(self:GetAngles().pitch) > 4 then
		add = math.min((math.abs(self:GetAngles().pitch)-4)/2,1)
        end
        fB.MotorForce = (40000+5000*(A < 0 and 1 or 0))*add --35300
        fB.Reversed = (self:ReadTrainWire(13) > 0.5)--<
        pB.MotorForce  = (40000+5000*(A < 0 and 1 or 0))*add --35300
        pB.Reversed = (self:ReadTrainWire(12) > 0.5)-->

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.6*(10.0-self.Speed)/10.0) end
        fB.MotorPower  = P*0.5*((A > 0) and 1 or -1)
        pB.MotorPower = P*0.5*((A > 0) and 1 or -1)

        -- Apply brakes
		--передняя тележка
        fB.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        fB.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        fB.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)
        fB.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        fB.DisableContacts = self.BUV.Pant or fB.DisableContactsManual		
		
		--средняя тележка		
		rB.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        rB.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        rB.BrakeCylinderPressure_dPdT = -self.Pneumatic.MiddleBogeyBrakeCylinderPressure_dPdT
	    rB.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)
        rB.DisableContacts = self.BUV.Pant or rB.DisableContactsManual	
	    rB.DisableSound = 1   	
		--задняя тележка		
        pB.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        pB.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        pB.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)
        pB.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT        		
        pB.DisableContacts = true		
 	

    end
    return retVal
end
--
function ENT:OnCouple(train,isfront)
    if isfront and self.FrontAutoCouple then
        self.FrontBrakeLineIsolation:TriggerInput("Open",1.0)
        self.FrontTrainLineIsolation:TriggerInput("Open",1.0)
        self.FrontAutoCouple = false
    elseif not isfront and self.RearAutoCouple then
        self.Pricep:IsolationsOpen()
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