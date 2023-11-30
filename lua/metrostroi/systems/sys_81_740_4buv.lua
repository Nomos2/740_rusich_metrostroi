--------------------------------------------------------------------------------
-- 81-720 wagon control unit
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_740_4BUV")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    if not TURBOSTROI then
        self.TrainIndex = self.Train:GetWagonNumber()
    end
    self.Battery = false
    self.Power = 0
    self.States = {}
    self.Commands = {}

    self.PowerTimer = CurTime()
    self.PowerTbl = {
        [1] = 0.0425,   --X1 150A
        [2] = 0.1295,   --X2 200A
        [3] = 0.2345,   --X3 260A
        [4] = 0.3565,   --X4 330A
        -------------------
        [0] = 0,
        -------------------
        [-1] = -0.0185, --T1 -150A
        [-2] = -0.2150, --T2 -260A
        [-3] = -0.3044, --T3 -310A
    }

    self.Slope = false

    self.BBE = 0
    self.MK = 0

    self.Reverser = 0
    self.PN2 = 0
    self.Brake = 0
    self.Drive = 0
    self.DriveStrength = 0
    self.Disassembly = 0
	
	self.I = math.random(3,6)
	self.IVO = -00.1
	
    self.Vent2 = 0
    self.DriveTimer = CurTime()

    self.CurTime = CurTime()
    self.TimerMode = CurTime()
	
	self.FirstHalf = false

    self.BlockTorec = false
	
	self.Strength = 0
	self.TargetStrength = 0
	
	self.SchemeSlope = false
	self.Recurperation = 0
end

function TRAIN_SYSTEM:Outputs()
    return {"Brake", "Drive", "DriveStrength","Recurperation", "Disassembly","Strength" ,"BBE","MK","Slope","Slope1","SchemeSlope","Vent2","TPT"}
end

function TRAIN_SYSTEM:Inputs()
    return {""}
end
function TRAIN_SYSTEM:CState(name,value)
    if self.CurrentBUP and (self.Reset or self.States[name] ~= value) then
        self.States[name] = value
        self.Train:CANWrite("BUV",self.Train:GetWagonNumber(),"BUKP",self.CurrentBUP,name,value)
    end
end

function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata == "BUPWork" and not numdata then
        self.Commands[sourceid] = {}
    elseif textdata == "Orientate" then
        self.OrientateBUP = sourceid
        self.FirstHalf = numdata
        self.Reset = CurTime()
    elseif self.CurrentBUP then
        if not self.Commands[sourceid] then self.Commands[sourceid] = {} end
        self.Commands[sourceid][textdata] = numdata
    end
end
function TRAIN_SYSTEM:Get(id)
    local Commands = self.Commands[self.CurrentBUP]
    if Commands then
        return Commands[id]
    end
end
function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:Think()
    if CurTime()-self.CurTime < 0.1 then return end
    self.DeltaTime = CurTime()-self.CurTime
    self.CurTime = CurTime()

    local Train = self.Train
    local wagcount = #Train.WagonList
	local SchemeWork = (Train:ReadTrainWire(6)*Train.SFV3.Value > 0.5 or (Train:ReadTrainWire(12)+Train:ReadTrainWire(13) == 1 and 1 or 0)*Train.SFV5.Value > 0) and 1 or 0	
    self.Power = Train.Electric.Battery80V > 62 and 1 or 0
    self.State = self.Power > 0 and Train.SFV2.Value > 0.5
    if self.State then
        if not self.States.BUVWork then
            self.Train:CANWrite("BUV",Train:GetWagonNumber(),"BUKP",nil,"Get",1)
        end
		local doorcount
		for i = 1,wagcount do
			if i == 1 or i == wagcount then
				doorcount = 5
			else
				doorcount = 6
			end
		end
		for i=1,wagcount do
			--self:CState("Door"..i.."Closed", Train.Pneumatic.LeftDoorState[d] == 0)
			for d = 1,6 do
				 self:CState("Door"..d.."Closed", Train.Pneumatic.LeftDoorState[d] == 0)
				self:CState("Door"..(d+doorcount).."Closed", Train.Pneumatic.RightDoorState[d] == 0)
				self:CState("LeftDoor"..d.."Closed", Train.Pneumatic.LeftDoorState[d] == 0)
				self:CState("RightDoor"..d.."Closed", Train.Pneumatic.RightDoorState[d] == 0)
				--print("Left Door"..d.."Closed", Train.Pneumatic.LeftDoorState[d] == 0,"Right Door"..(i+d).."Closed", Train.Pneumatic.RightDoorState[d] == 0)
			end
		end
		self:CState("MinBCAnyPressure", math.min(math.Round(Train.Pneumatic.MiddleBogeyBrakeCylinderPressure,1),math.Round(Train.Pneumatic.BrakeCylinderPressure,1)))
		self:CState("MaxBCAnyPressure", math.max(math.Round(Train.Pneumatic.MiddleBogeyBrakeCylinderPressure,1),math.Round(Train.Pneumatic.BrakeCylinderPressure,1)))
        self:CState("DoorTorec", Train.RearDoor or Train.FrontDoor)
        self:CState("DoorBack", Train.PassengerDoor or Train.CabinDoorLeft or Train.CabinDoorRight)
        self:CState("EmPT",Train:ReadTrainWire(28) > 0)
        self:CState("NoAssembly",not (self.Scheme_E)) -- #todo4Vlj
        
		local emer = Train:ReadTrainWire(45)+Train:ReadTrainWire(19)
		local bv = Train.BV.Value
		local strength,brake,drive = 0,0,0
		if emer > 0 then
			strength = Train:ReadTrainWire(45) > 0 and 4 or Train:ReadTrainWire(19) > 0 and 2 or 0
			drive = strength*bv --*Train.Electric.BUTP
		else
			brake = self.Brake--*Train.Electric.BUTP
			drive = self.Drive*bv--*Train.Electric.BUTP
			strength = self.DriveStrength
		end
        
		self:CState("Strength",self.Strength)
		self.Scheme_E = (Train.Speed < 6.5 and 0 or brake)+drive > 0 and (drive > 0 and (Train.Pneumatic.BrakeCylinderPressure < 0.7 or self.Slope1 or Train:ReadTrainWire(19)+Train:ReadTrainWire(45) > 0) or brake > 0 and Train.Pneumatic.BrakeCylinderPressure < 1.7+Train.Pneumatic.WeightLoadRatio) and SchemeWork > 0.5
        self:CState("ParkingBrakeEnabled", Train.Pneumatic.ParkingBrakePressure < 3)
        self:CState("BEPPBroken", false)
		--self:CState("Scheme", ((Train.Speed < 6.5 and 0 or brake)+drive > 0 and (drive > 0 and (Train.Pneumatic.BrakeCylinderPressure < 0.7 or self.Slope1 or Train:ReadTrainWire(19)+Train:ReadTrainWire(45) > 0) or brake > 0 and Train.Pneumatic.BrakeCylinderPressure < 1.7+Train.Pneumatic.WeightLoadRatio)) and SchemeWork > 0.5)
        self:CState("ParkingBrakeEnabled", Train.Pneumatic.ParkingBrakePressure < 3)
		self:CState("MejWag", Train:ElectricConnected(Train.FrontTrain, false) and Train:ElectricConnected(Train.RearTrain, true))
        self:CState("BEPPBroken", false)
        self:CState("EmergencyBrakeGood", Train.Pneumatic.BrakeCylinderPressure >= (2.6+Train.Pneumatic.WeightLoadRatio*0.6)-0.1)
        self:CState("EmergencyBrake", self.States.EmergencyBrakeGood--[[  and Train:ReadTrainWire(27) == 0--]] )
        self:CState("ReserveChannelBraking", Train:ReadTrainWire(28)>0)
        if Train.SFV8.Value > 0 then 
            self:CState("PTEnabled", Train.Pneumatic.BrakeCylinderPressure > 0.2)
            self:CState("MPTEnabled", Train.Pneumatic.MiddleBogeyBrakeCylinderPressure > 0.2)
        else
            self:CState("PTEnabled", true)
            self:CState("MPTEnabled", true)
        end
        self:CState("DUKS", Train.SFV8.Value > 0)
        self:CState("AirSpringOkay", Train.Pneumatic.TrainLinePressure > 2.0)
        self:CState("PTBad", false)
        self:CState("PTReady", Train.Pneumatic.AirDistributorPressure >= (2.6+Train.Pneumatic.WeightLoadRatio*0.6)-0.1)
        self:CState("PTReplace", self.PTReplace)-- and CurTime()-self.PTReplace > 1.5)
        self:CState("BTBReady", Train.Pneumatic.BTBReady)
        self:CState("TLPressure", math.Round(Train.Pneumatic.TrainLinePressure,1))
        self:CState("BLPressure", math.Round(Train.Pneumatic.BrakeLinePressure,1))
		self:CState("MBLPressure", math.Round(Train.Pneumatic.MiddleBogeyBrakeCylinderPressure,1))
        self:CState("BCPressure", math.Round(Train.Pneumatic.BrakeCylinderPressure,1))
        self:CState("HPPressure", math.Round(Train.Pneumatic.AirDistributorPressure,1))
        self:CState("WeightLoad", math.Round(Train.Pneumatic.WeightLoadRatio,2))
        self:CState("PantDisabled", self.Pant)
        self:CState("EnginesBroken", false)
        self:CState("BBEEnabled", self.BBE)
        self:CState("EmerBrakeEnabled",Train:ReadTrainWire(28) > 0)
        self:CState("BBEBroken", false)
        self:CState("InvertorProtection", Train.SFV28.Value > 0)
        self:CState("HVBad", Train.Electric.Power750V < 550)
        self:CState("LVBad", Train.Electric.Battery80V < 62)
		self:CState("LVValue", Train.Electric.Battery80V)
        self:CState("EnginesDone", self.EnginesDone and math.abs(Train.Speed) < 7.5)
        self:CState("EnginesBrakeBroke", (self:Get("Brake") or 0) > 0 and Train.BV.Value == 0 or Train.Electric.Brake > 0)
        self:CState("PassLightEnabled", self.MainLights)
        self:CState("BVEnabled", Train.BV.Value > 0)
        self:CState("DriveStrength", math.min(0,Train.AsyncInverter.Torque))--(Train.AsyncInverter.Drive*Train.AsyncInverter.Torque)/3.6)
        self:CState("BrakeStrength", math.max(0,Train.AsyncInverter.Torque))--(Train.AsyncInverter.Brake*Train.AsyncInverter.Torque)/3.6)
        self:CState("VagEqConsumption", self.IVO)--15-25
		self:CState("I", Train.AsyncInverter.Current)
        self:CState("I13", Train.AsyncInverter.Current)
        self:CState("I24", Train.AsyncInverter.Current)
        self:CState("HVVoltage", math.floor(Train.Electric.Main750V))
        self:CState("LVVoltage", math.floor(Train.Electric.Battery80V))
        self:CState("MKVoltage", math.Round(Train.Electric.BVKA_KM1*math.Rand(9,13),1))
        self:CState("ConditionerEmer", Train.Electric.ConditionerPower>0)
        self:CState("ConditionerWork", Train.Electric.ConditionerWork>0)
        self:CState("HeatEnabled", false)
		self:CState("AsyncInverter",true)
        self:CState("TPFailure",Train.Electric.BVonSelfLocking > 0)
        self:CState("MKWork", Train.Pneumatic.Compressor)
        --self:CState("MKWire", self.MK > 0)
        self:CState("BUVWork", true)
        self:CState("WagNOrientated", self.Orientation  == self.RevOrientation)
        self:CState("Orientation", self.Orientation)
        self:CState("BadCombination", (Train:ReadTrainWire(3)*Train:ReadTrainWire(4)) > 0)
    else
        self:CState("BUVWork", false)
        for k,v in pairs(self.Commands) do
            self.Commands[k] = false
        end
    end

    if self.Reset and self.Reset ~= CurTime() then
        self.Reset = nil
    end
    self.IVO = Train.Electric.Battery80V > 67 and self.BBE > 0 and self.I*2.6+math.Round(math.Rand(1,5),1) or -00.1	
    self.BBE = not self:Get("PVU8") and self:Get("BBE") and Train.SFV7.Value or 0
    if Train.Electric.Main750V < 650 or Train.Electric.Main750V > 975 then self.BBE = 0 end
    if self.BBE == 0 and self.MainLights and not self.MainLightsTimer then self.MainLightsTimer = CurTime() end
    if self.BBE > 0 or not self.MainLights or self.MainLightsTimer and CurTime()-self.MainLightsTimer > 20 then self.MainLightsTimer = nil end
    self.MainLights = not self:Get("PVU5") and (self.BBE > 0 or self.MainLightsTimer) and Train.SFV19.Value > 0.5 and self:Get("PassLight")
    Train.Electric:TriggerInput("BVDisableSignal",self:Get("PVU1") )
    self.BlockTorec = not self:Get("PVU6") and self:Get("BlockDoorTorec") and Train.SFV15.Value > 0
    local Ft = IsValid(Train.FrontTrain) and Train.FrontTrain
    local Rt = IsValid(Train.RearTrain) and Train.RearTrain
 
    --Train.Electric:TriggerInput("EqualizingCircuits",Ft and (Ft.Electric.Battery80V*Ft.BUV.BBE*Ft.SFV32.Value*Train.Battery.Value*Train.SFV32.Value > 0 and 1 or 0) or Rt and (Rt.Electric.Battery80V*Rt.BUV.BBE*Rt.SFV32.Value*Train.Battery.Value*Train.SFV32.Value > 0 and 1 or 0) or 0)
    if self:Get("Slope") then self.Slope = CurTime() elseif Train:ReadTrainWire(5) > 0 and self.Slope then self.Slope = false end
	if self.Slope and self.TargetStrength > 0 then
		self.SchemeSlope = true
	end
	if self.SchemeSlope and self.TargetStrength <= 0 then
		self.SchemeSlope = false
	end	
	if not self:Get("Slope") and self.Slope and (self:Get("SlopeSpeed") and self.TargetStrength > 0 and CurTime()-self.Slope > 2 or not self:Get("SlopeSpeed") and self.TargetStrength ~= 0) then self.Slope = false end --Train.Pneumatic.BrakeCylinderPressure < 1.5 then self.Slope = false end
	if self.Slope then self.Slope1 = true end
	if self.Slope1 and Train.Pneumatic.BrakeCylinderPressure < 0.1 then self.Slope1 = false end

    Train.Pneumatic:TriggerInput("TPTEnable", self:Get("TPTOn"))
    Train.Pneumatic:TriggerInput("HeatingPads", self:Get("HeatinPads"))
	self.Reverser = Train:ReadTrainWire(12)
	local brake = self:Get("Brake") or 0
	local strength = not self:Get("PVU9") and (self.Slope1 and true or brake>0 and Train.Pneumatic.BrakeCylinderPressure < 1.7+Train.Pneumatic.WeightLoadRatio or brake==0 and (self:Get("Slope") or Train.Pneumatic.BrakeCylinderPressure < 0.7)) and self:Get("DriveStrength") or 0
	if not self:Get("PVU9") and brake==0 and Train.Pneumatic.BrakeCylinderPressure < 0.4 then
		self.DriveTimer = CurTime()
	end
	if brake==0 and not self:Get("PVU9") then
		if Train:ReadTrainWire(45) == 1 then
			strength = 4
			self.SchemeSlope = true
		elseif Train:ReadTrainWire(19) == 1 then
			strength = 2
			self.SchemeSlope = true			
		end
	end
	local drive = math.min(1,(1-brake)*strength)
	if strength == 0 then
		brake=0
		drive=0
	end
	self.Brake = brake
	self.Drive = drive
	self.Strength = (self.Brake == 1 and -1 or 1)*strength--*SchemeWork
	Train.Electric:TriggerInput("Slope",self.SchemeSlope)
	self.TargetStrength = (self:Get("Brake") == 1 and -1 or 1)*(self:Get("DriveStrength") or 0)+((Train:ReadTrainWire(45) == 1 and 4 or Train:ReadTrainWire(19) == 1 and 2) or 0)
	--if self:Get("BARSBrake") then self.Strength = -3 end
	self.DriveStrength = strength
	--[[
	if self:Get("PVU11") then
		if self:Get("PVU1") and Train.BV.Value == 1 and Train.SFV8.Value > 0 then
			Train.BV:TriggerInput("Open",1.0)
		elseif not self:Get("PVU1") and Train.BV.Value == 0 and self.Strength == 0 then
			Train.BV:TriggerInput("Close",Train.SFV8.Value*Train.SFV9.Value)
		end
	end
	]]
	if not self.Slope then
		if (self:Get("Brake") or 0) == 0 then
			self.EnginesDone = false
		elseif Train.AsyncInverter.Brake == 1 and Train.Speed < 7 or self:Get("PVU9") then
			self.EnginesDone = true
		end
		--[[
		local PTReplace = self.States.EnginesBrakeBroke
		if PTReplace and not self.PTReplace then
			self.PTReplace =  CurTime()
			if Train.AsyncInverter.Torque ~= 0 then
				self.PTReplace = self.PTReplace + 1.3
			end
			if self:Get("PVU9")  then
				self.PTReplace = self.PTReplace - 1.2
			end
		end
		if not PTReplace and self.PTReplace then self.PTReplace = nil end]]

		if (self.EnginesDone or self.States.EnginesDone) and self.Strength < 0 and Train.Speed > 7 then
			self.EnginesDone = false
			self.States.EnginesDone = false
		end
		if self.TargetStrength < 0 and not self.PTReplaceTimer and math.abs(Train.AsyncInverter.Torque) < 0.01 then
			self.PTReplaceTimer = CurTime()
		elseif (self.TargetStrength >= 0 or math.abs(Train.AsyncInverter.Torque) >= 0.1) and self.PTReplaceTimer then
			self.PTReplaceTimer = nil
		end
		if self.PTReplaceTimer and CurTime()-self.PTReplaceTimer > 2.2 or (Train.Speed < 7 and self.TargetStrength<0) then
			self.PTReplace = true
		elseif not self.PTReplaceTimer and self.PTReplace then
			self.PTReplace = false
		end
	end
	if (not self.EnginesDone or not self.States.EnginesDone) then--and (self:Get("BARSBrake") or self:Get("AO")) then
		self.EnginesDone = true
		self.States.EnginesDone = true
	end
	local PN = self.PTReplace --self.PTReplace and CurTime()-self.PTReplace > 1.2 or self.States.EnginesDone
	self.PN1 = (self:Get("PN1") and self:Get("PN1") > 0) or PN and (self:Get("DriveStrength") and self:Get("DriveStrength") > 0) or self:Get("PR") and self.TargetStrength <=0 --or (self.Pant and Train.TR.Main750V == 0 or Train.BV.Value*Train.GV.Value == 0) --or (Train.AsyncInverter.PrevVoltage > 975 or Train.AsyncInverter.PrevVoltage < 550) and Train.AsyncInverter.Brake > 0.5) and self.Strength < 0
	self.PN2 = self.Slope and self:Get("SlopeSpeed") or (self:Get("PN2") and self:Get("PN2") > 0) or PN and (self:Get("DriveStrength") and self:Get("DriveStrength") > 2) --[[and not (self:Get("BARSBrake") or self:Get("AO"))]] -- or (self.Pant and Train.TR.Main750V == 0 or Train.BV.Value*Train.GV.Value == 0) --or (Train.AsyncInverter.PrevVoltage > 975 or Train.AsyncInverter.PrevVoltage < 550) and Train.AsyncInverter.Brake > 0.5) and self.Strength < -1
	self.Recurperation = self:Get("RecurperationDisable") and 1 or 0
    
    self.MK = not self:Get("PVU3") and self:Get("Compressor") and 1 or 0

    self.OpenLeft = not self:Get("PVU2") and self:Get("OpenLeft") and self.Orientation or self:Get("OpenRight") and not self.Orientation
    self.OpenRight = not self:Get("PVU2") and self:Get("OpenRight") and self.Orientation or self:Get("OpenLeft") and not self.Orientation
    self.CloseDoors = self:Get("PVU2") or self:Get("CloseDoors")

    self.Vent2 =  not self:Get("PVU7") and self:Get("Vent2") and 1 or 0
    self.Orientation = Train:ReadTrainWire(3) > 0
    self.RevOrientation = Train:ReadTrainWire(4) > 0
    --print(Train:ReadTrainWire(3),Train:ReadTrainWire(4))
    --if self.Orientation == self.RevOrientation then print(Train:ReadTrainWire(3),Train:ReadTrainWire(4)) end
    local BadOrientation = self.Orientation and self.Orientation  == self.RevOrientation
    if self.State and self.Orientation ~= self.RevOrientation then
        if not self.BadOrientation and self.OrientateBUP and (not self.Commands[self.OrientateBUP] or self.Orientation and self.Commands.Forward ~= self.OrientateBUP or self.RevOrientation and self.Commands.Back ~= self.OrientateBUP) then
            --print(Train:GetWagonNumber(),"New BUP",self.Orientation and "Forward" or "Back",self.OrientateBUP)
            if self.Orientation then self.Commands.Forward = self.OrientateBUP else self.Commands.Back = self.OrientateBUP end
            self.OrientateBUP = nil
        end
    end

    local ReOrientation = self.State and (self.Orientation or self.RevOrientation) and (self.Orientation ~= self.PrevOrientation or self.RevOrientation ~= self.PrevRevOrientation or self.CurrentBUP ~= (self.Orientation and self.Commands.Forward or self.Commands.Back))
    if ReOrientation then
        self.CurrentBUP = self.Orientation and self.Commands.Forward or self.Commands.Back
        --print(Train:GetWagonNumber(),"Reorientate",self.Orientation and "Forward" or "Back",self.CurrentBUP)
        self.Reset = CurTime()
        if self.CurrentBUP then
            self.Commands[self.CurrentBUP]  = {}
            Train:CANWrite("BUV",Train:GetWagonNumber(),"BUKP",self.CurrentBUP,"Get")
        end
    end
    self.BadOrientation = BadOrientation
    self.PrevOrientation = self.Train:ReadTrainWire(3) > 0
    self.PrevRevOrientation = self.Train:ReadTrainWire(4) > 0
    if Train.SFV29.Value > 0 then
        if self:Get("PVU4") or --[[ Train.Electric.Main750V < 20 and --]] (self:Get("TP1") and self.FirstHalf or self:Get("TP2") and not self.FirstHalf) then
            self.Pant = true
        else
            self.Pant = false
        end
    end
end
