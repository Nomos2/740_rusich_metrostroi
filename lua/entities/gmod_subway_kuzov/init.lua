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

ENT.SyncTable = {"RearBrakeLineIsolation","RearTrainLineIsolation"}
 
function ENT:Initialize()
    self:SetModel("models/metrostroi_train/81-740/body/81-740_4_rear.mdl")
	self.NoTrain = false 
    self.BaseClass.Initialize(self)
--	self:SetPos(self:GetPos() + Vector(0,0,0))	
	
--	self.TrainEntities = {}	
	
    self.NormalMass = 24000
	
    self.PassengerSeat = self:CreateSeat("passenger",Vector(-135,-40,-25),Angle(0,90,0),"models/nova/airboat_seat.mdl")
    self.PassengerSeat2 = self:CreateSeat("passenger",Vector(-135,40,-25),Angle(0,270,0),"models/nova/airboat_seat.mdl")  
    self.PassengerSeat3 = self:CreateSeat("passenger",Vector(95,40,-25),Angle(0,270,0),"models/nova/airboat_seat.mdl") 
    self.PassengerSeat4 = self:CreateSeat("passenger",Vector(95,-40,-25),Angle(0,90,0),"models/nova/airboat_seat.mdl")  	
    self.PassengerSeat:SetRenderMode(RENDERMODE_NONE)
	self.PassengerSeat:SetColor(Color(0,0,0,0))
    self.PassengerSeat2:SetRenderMode(RENDERMODE_NONE)
	self.PassengerSeat2:SetColor(Color(0,0,0,0))
    self.PassengerSeat3:SetRenderMode(RENDERMODE_NONE)
	self.PassengerSeat3:SetColor(Color(0,0,0,0))
    self.PassengerSeat4:SetRenderMode(RENDERMODE_NONE)
	self.PassengerSeat4:SetColor(Color(0,0,0,0))
	
	self.Lights = {
		[14] = { "dynamiclight",    Vector( 220, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
		[15] = { "dynamiclight",    Vector( 10, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [16] = { "dynamiclight",    Vector( -260, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 250, fov=180,farz = 128 },
    }	
	
	self.InteractionZones = {	
		{
			ID = "RearBrakeLineIsolationToggle",
			Pos = Vector(-337,22.0,-44), Radius = 8,
        },
		{
			ID = "RearTrainLineIsolationToggle",
			Pos = Vector(-337,-22.0,-44), Radius = 8, 
        },
        {
            ID = "RearDoor",
            Pos = Vector(-320, 0, 0), Radius = 31
        },
	}   	
	
	self.RearDoor = false	
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
	self.HeadTrain = self:GetNW2Entity("HeadTrain")	
	local train = self.HeadTrain	
    if not IsValid(train) then return end		
	local ahahaha =  math.random (1,5)
	for i = 1,12 do
		self:SetNW2Int("DoorsAnim"..i,math.random(ahahaha,15))
	end
	
		local sp = math.random (-6,-15)		
		local sp1 = math.random (10,17)			
		--скорость дверей
		for k,v in pairs(train.Pneumatic.LeftDoorSpeed) do
			train.Pneumatic.LeftDoorSpeed[k] = -3.5 + math.random(sp,sp1) / 12
		end
		
		for k,v in pairs(train.Pneumatic.RightDoorSpeed) do
			train.Pneumatic.RightDoorSpeed[k] = -3.5 + math.random(sp,sp1) / 12	
		end	

    self:UpdateLampsColors()
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
	
function ENT:Think()	
	self.HeadTrain = self:GetNW2Entity("HeadTrain")
	local train = self.HeadTrain    
	if not IsValid(self.HeadTrain) then self:Remove() return end
	local retVal = self.BaseClass.Think(self)

	if not self.HeadTrain.RearBrakeLineIsolation then
		self.HeadTrain.RearBrakeLineIsolation = self.RearBrakeLineIsolation
	end
	if not self.HeadTrain.RearTrainLineIsolation then
		self.HeadTrain.RearTrainLineIsolation = self.RearTrainLineIsolation
	end
	local Panel = train.Panel	
	self:SetPackedBool("RearDoor",self.RearDoor)
    local power = train.Electric.Battery80V > 62
    self:SetPackedBool("Vent2Work",train.Electric.Vent2>0)	
    self:SetPackedBool("BBEWork",power and train.BUV.BBE > 0)
    self:SetPackedBool("CompressorWork",train.Pneumatic.Compressor) 
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)

--	print(self.RearBrakeLineIsolation.Value)

--	self:SetNW2Bool("RBLI",train.RearBrakeLineIsolation.Value > 0)
--	self:SetNW2Bool("RTLI",train.RearTrainLineIsolation.Value > 0)
	
    --local state = math.abs(train.AsyncInverter.InverterFrequency/(11+train.AsyncInverter.State*5))--(10+8*math.Clamp((self.AsyncInverter.State-0.4)/0.4,0,1)))
    --self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+train.AsyncInverter.State/1),0,1)*math.Clamp(train.Speed/6,0,1))
    --self:SetPackedRatio("asyncstate", math.Clamp(train.AsyncInverter.State/0.2*math.abs(train.AsyncInverter.Current)/100,0,1))
    --self:SetPackedRatio("chopper", math.Clamp(train.Electric.Chopper>0 and train.Electric.IChopped/100 or 0,0,1))		
	 
      self:SetPackedBool("DoorL",train.DoorLeft)
      self:SetPackedBool("DoorR",train.DoorRight)    
      self.LeftDoorsOpening = train.DoorLeft
      self.RightDoorsOpening = train.DoorRight
      self.LeftDoorsOpen = train.LeftDoorsOpen
      self.RightDoorsOpen = train.RightDoorsOpen 
	  
		--скорость дверей
		for k,v in pairs(train.Pneumatic.LeftDoorSpeed) do
			train.Pneumatic.LeftDoorSpeed[k] = -2, 6
		end
		
		for k,v in pairs(train.Pneumatic.RightDoorSpeed) do
			train.Pneumatic.RightDoorSpeed[k] = -2, 6
		end

	local lightsActive1 = power and train.SFV20.Value > 0 
    local lightsActive2 = power and train.BUV.MainLights 
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

	local passlight = power and (train.BUV.MainLights and 1 or train.SFV20.Value > 0.5 and 0.4) or 0 
    train:SetPackedRatio("SalonLighting",passlight) 	
	self:SetLightPower(14,passlight > 0, passlight and mul/20) 
	self:SetLightPower(15,passlight > 0.5, passlight and mul/20)
	self:SetLightPower(16,passlight > 0, passlight and mul/20) 
	
    return retVal		 
end	

function ENT:OnRemove()
    -- Remove all linked objects
    constraint.RemoveAll(self)
    if self.TrainEntities then
        for k,v in pairs(self.TrainEntities) do
            SafeRemoveEntity(v)
        end
    end
    if IsValid(self.HeadTrain) then self.HeadTrain:Remove() end
end

function ENT:IsolationsOpen()
	self.RearBrakeLineIsolation:TriggerInput("Toggle",1)
	self.RearTrainLineIsolation:TriggerInput("Toggle",1)
	timer.Simple(1,function()
		self.RearBrakeLineIsolation:TriggerInput("Open",1)
		self.RearTrainLineIsolation:TriggerInput("Open",1)
	end)
end

function ENT:OnButtonPress(button,ply)
	self.HeadTrain = self:GetNW2Entity("HeadTrain")
	local train = self.HeadTrain
    if not IsValid(train) then return end
    if button == "RearDoor" and (self.RearDoor or not train.BUV.BlockTorec) then self.RearDoor = not self.RearDoor end
	if button == "RearBrakeLineIsolationToggle" then
		self:PlayOnce("RearBrakeLineIsolation","bass",1)
	end
	if button == "RearTrainLineIsolationToggle" then
		self:PlayOnce("RearTrainLineIsolation","bass",1)
	end
end	
function ENT:OnButtonRelease(button)
end