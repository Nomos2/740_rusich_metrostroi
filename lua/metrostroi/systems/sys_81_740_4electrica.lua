--------------------------------------------------------------------------------
-- 81-740.4 electric schemes
--------------------------------------------------------------------------------
-- Original by: Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Edit: Их дофига
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_740_4ELECTRICA")
TRAIN_SYSTEM.DontAccelerateSimulation = false	

local function Clamp(val,min,max)
    return math.max(min,math.min(max,val))
end

local function Rand(a,b) 
	return a+(b-a)*math.random()
end

local function sign(x)
	return (x>0 and 1 or x < 0 and -1 or 0)
end

function TRAIN_SYSTEM:Initialize()

    -- General power output
    self.Main750V = 0.0
    self.Aux750V = 0.0
    self.Power750V = 0.0
    self.Aux80V = 0.0
    self.Lights80V = 0.0
    self.Battery80V = 0.0
    self.ReservePower = 0.0         -- V
    self.EqualizingCircuits = 0.0   -- Типа подзаряд, но хз может ли работать свет, нужны схемы 
	
    self.Power = 0
    self.States = {}
    self.Commands = {}

    self.DriveTimer = CurTime()

    self.CurTime = CurTime()
    self.TimerMode = CurTime()
	
    -- Total energy used by train
    self.ElectricEnergyUsed = 0 -- joules
    self.ElectricEnergyDissipated = 0 -- joules
    self.EnergyChange = 0

    self.Train:LoadSystem("BV","Relay")
    self.Train:LoadSystem("GV","Relay","GV_10ZH",{bass=true})
    -- Thyristor contrller
    self.Brake = 0
    self.Drive = 0
    self.DriveStrength = 0
	self.Recurperation = 0
    self.Iexit = 0
    self.IChopped = 0
    self.Chopper = 0
	
    self.BTB = 0
    self.KTR = 0
    self.V2 = 0 -- В9
    self.V1 = 0 -- В8
    self.V11 = 0   
    self.BVKA_KM1 = 0
    self.BVKA_KM2 = 0
    self.Vent2 = 0
    self.SDWork = 0

    self.BUTPReady = 0
    self.DisableBV = 0
    self.BVactivationAttempt = 0
    self.BVcountOfTriggers = 0
    self.BVTime2On = 4.5+math.random()
    self.BVPositionCache = 0
    self.BVonSelfLocking = 0

	self.Slope = 0
	self.command = 0
    self.commandTimer = 0

    self.ConditionerPower = 0
    self.ConditionerWork = 0

    --self.Train:LoadSystem("Telemetry",nil,"",{"Electric","Panel","Engines"})
end


function TRAIN_SYSTEM:Inputs()
    return { "Recurperation","ReservePower","DisableBV","V11" }
end

function TRAIN_SYSTEM:Outputs()
    return { "Brake", "Drive","BVonSelfLocking","BV_NoAA","DisableBV",
             "Main750V", "Power750V", "Aux750V", "Aux80V", "Lights80V", "Battery80V","ReservePower",
             "BTB","V2","V1","ConditionerPower","ConditionerWork",
             "BVKA_KM1","BVKA_KM2","BUTPReady","Vent2",
             "Recurperation","Iexit","IChopped","Chopper","ElectricEnergyUsed","ElectricEnergyDissipated","EnergyChange"
        }
end

TRAIN_SYSTEM.CurrentConfig = {
	{
		[1] = 150,
		[2] = 200,
		[3] = 260,
		[4] = 320,
		[0] = 0,
		[-1]= 150,
		[-2]= 200,
		[-3]= 320,
	},
	{
		[1] = 0.67,
		[2] = 0.69,
		[3] = 0.77,
		[4] = 0.79,
		[0] = 0,
		[-1]= 0.55,
		[-2]= 0.60,
		[-3]= 0.85,
	},
}

local S = {}
local function C(x) return x and 1 or 0 end
local min,max,abs = math.min,math.max,math.abs

function TRAIN_SYSTEM:TriggerInput(name,value)
    if name == "Slope" then
		self.Slope = value
	end
    if name == "BVDisableSignal" then
		self.DisableBV = value
	end
end

--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    local Async = Train.AsyncInverter
	local BUV = Train.BUV
    --  local dT = dT/8
    ----------------------------------------------------------------------------
    -- Voltages from the third rail
    ----------------------------------------------------------------------------
    self.Main750V = Train.TR.Main750V
    self.Aux750V  = Train.TR.Main750V
    self.Power750V = self.Main750V*Train.GV.Value

	if not Async then return end

    ----------------------------------------------------------------------------
    -- Information only
    ----------------------------------------------------------------------------
    local BBE = Train.BUV.BBE > 0
    self.Aux80V = BBE and 82 or 65
    self.Lights80V = BBE and 82 or 0--Train.PowerSupply.XT3_4

    self.Battery80V = (Train.Battery.Value > 0) and (BBE and 82 or 65) or 0

    ----------------------------------------------------------------------------
    -- Some internal electric
    ----------------------------------------------------------------------------
    local P = self.Battery80V > 62 and 1 or 0
    local HV = 550 < self.Main750V and self.Main750V < 975 and 1 or 0
    --(RV)
    local Panel = Train.Panel
    if Train.KV then
        local RV = Train.KV
        local ASNP_VV = Train.ASNP_VV
        local ppzPower = P*Train.SF1.Value > 0 and 1 or self.ReservePower or 0
        Train:WriteTrainWire(3,ppzPower*(RV["KRO9-10"]*Train.SF2.Value + RV["KRR7-8"]*Train.SF3.Value)*Train.SF10.Value)
        Train:WriteTrainWire(4,0)
        Train:WriteTrainWire(10,P*Train.EmergencyCompressor.Value)
        Train:WriteTrainWire(11,P*(1-Train.ParkingBrake.Value))
        Train:WriteTrainWire(12,ppzPower*(RV["KRR3-4"]*Train.SF3.Value+RV["KRO11-12"]*Train.SF2.Value)*Train.SF11.Value)
        Train:WriteTrainWire(13,ppzPower*(RV["KRR9-10"]*Train.SF3.Value+P*RV["KRO15-16"]*Train.SF2.Value)*Train.SF11.Value)
        Train:WriteTrainWire(15,Panel.Ticker)
        Train:WriteTrainWire(16,Panel.PassScheme)
        Train:WriteTrainWire(19,P*RV["KRR7-8"]*Train.SF10.Value*Train.BARS.BTB*Train.EmerX1.Value)
        Train:WriteTrainWire(20,ASNP_VV.AmplifierPower)
        local BTBp = ppzPower*(RV["KRO13-14"]*Train.SF2.Value*Train.SF19.Value + RV["KRR11-12"]*Train.SF3.Value*Train.SF20.Value)*(1-self.SDWork)
        local BTBm = (Train.BARS.BTB+Train.ALS.Value*(Train.BARSBlock.Value==3 and 1 or 0)*(1-Train.RTE.Value))
        local BTB = math.min(1,BTBp*BTBm)
        if BTB > 0 then
            if self.BTBTimer == nil then self.BTBTimer = CurTime() end
            if self.BTBTimer and CurTime()-self.BTBTimer>0.3 then self.BTBTimer = false end
        else
            self.BTBTimer = nil
        end
        self.BTB = math.min(1,(self.BTBTimer~=false and 1 or 0)+self.BTB*Train:ReadTrainWire(26))
        Train:WriteTrainWire(24,BTB*(1-Train.EmergencyBrake.Value)*(1-Train.RTE.Value))
        Train:WriteTrainWire(25,BTB*self.BTB*(self.KTR==3 and 0 or 1))
        Train:WriteTrainWire(26,(1-BTB)*Train:ReadTrainWire(24)*(1-Train.EmergencyBrake.Value)*(1-Train.RTE.Value))
        Train:WriteTrainWire(27,BTBp)
        Train:WriteTrainWire(28,Panel.EmerBrakeWork)
        --BTB KT KO Logic
        if Panel.EmerBrakeWork > 0 then
            if Train.EmerBrakeAdd.Value > 0 and not self.KT then
                self.KTR = math.min(3,self.KTR + 1)
                self.KT = true
            elseif Train.EmerBrakeAdd.Value == 0 then
                self.KT = false
            end
            if Train.EmerBrakeRelease.Value > 0 and not self.KO then
                self.KTR = math.max(0,self.KTR - 1)
                self.KO = true
            elseif Train.EmerBrakeRelease.Value == 0 then
                self.KO = false
            end
            Train:WriteTrainWire(29,self.KTR>1 and 1 or 0)
            Train:WriteTrainWire(30,self.KTR>0 and 1 or 0)
        else
            if self.KTR > 0 then self.KTR = 0 end
            Train:WriteTrainWire(29,0)
            Train:WriteTrainWire(30,0)
        end
        Train:WriteTrainWire(31,P*Train.ParkingBrake.Value)
        Train:WriteTrainWire(32,P*Train.Vent2.Value)
        Train:WriteTrainWire(34,ppzPower*Train.SF3.Value*Train.EmergencyControls.Value)
        Train:WriteTrainWire(36,ppzPower*(RV["KRO1-2"]*Train.SF2.Value + RV["KRR1-2"]*Train.SF3.Value))
        Train:WriteTrainWire(37,ppzPower*Train.SF21.Value*Train.DoorRight.Value)
        Train:WriteTrainWire(38,ppzPower*Train.SF21.Value*Train.DoorLeft.Value)
        Train:WriteTrainWire(39,P*Train.EmerCloseDoors.Value)
        Train:WriteTrainWire(40,P*Train.EmergencyDoors.Value)
        Train:WriteTrainWire(45,ppzPower*RV["KRR7-8"]*Train.SF10.Value*Train.BARS.BTB*Train.EmerX2.Value)
        self.V2 = ppzPower*(RV["KRO13-14"]*Train.SF2.Value*Train.SF19.Value + RV["KRR11-12"]*Train.SF3.Value*Train.SF20.Value)
        self.V1 = ppzPower*(RV["KRO13-14"]*Train.SF2.Value*Train.SF19.Value + RV["KRR11-12"]*Train.SF3.Value*Train.SF20.Value)*Train.HornB.Value*Train.SF18.Value
        if Train.ABSD.Value > 0 then
            self.SDWork = 0
        else
            self.SDWork = Train.Pneumatic.SD2
        end        
        ASNP_VV.Power = ppzPower*Train.SF8.Value*Train.R_ASNPOn.Value
        ASNP_VV.AmplifierPower = ASNP_VV.Power*Train.ASNP.LineOut*(1-Train.R_Line.Value)

        Panel.R_Announcer = ppzPower*Train.SF8.Value*Train.R_Announcer.Value*Train.SF13.Value
        Panel.R_Line = ppzPower*Train.SF8.Value*Train.R_Line.Value*Train.SF13.Value
        
        --ASNP_VV.CabinSpeakerPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_G.Value
        Panel.DoorLeft = ppzPower*Train.SF21.Value*Train.DoorSelectL.Value*(1-Train.DoorSelectR.Value)*Train.SF13.Value
        Panel.EmergencyControls = ppzPower*Train.EmergencyControls.Value*Train.SF13.Value
        Panel.EmergencyDoors = ppzPower*Train.EmergencyDoors.Value*Train.SF13.Value
        Panel.EmerBrakeWork = BTB*Train.EmerBrake.Value*Train.SF13.Value
        Panel.DoorRight = ppzPower*Train.SF21.Value*Train.DoorSelectR.Value*(1-Train.DoorSelectL.Value)*Train.SF13.Value
        Panel.DoorClose = ppzPower*Train.DoorClose.Value*Train.SF13.Value
        Panel.DoorBlock = ppzPower*Train.DoorBlock.Value*Train.SF13.Value
        Panel.Ticker = ppzPower*Train.SF8.Value*Train.Ticker.Value*Train.SF13.Value
        Panel.PassScheme = ppzPower*Train.SF8.Value*Train.PassScheme.Value*Train.SF13.Value
        Panel.PassSchemeControl = Panel.PassScheme*(RV["KRO9-10"]*Train.SF2.Value+RV["KRR7-8"]*Train.SF3.Value)*Train.SF10.Value*Train.SF13.Value
        Panel.KAH = P*Train.KAH.Value*Train.SF13.Value
        Panel.ALS = P*Train.ALS.Value*Train.SF13.Value
		Panel.TPT = P*Train.TPT.Value*Train.SF13.Value
		Panel.Wiper = P*Train.Wiper.Value*Train.SF13.Value
		Panel.Stand = P*Train.Stand.Value*Train.SF13.Value		
        --Panel.AccelRate = P*Train.AccelRate.Value
        Panel.EqLights = ppzPower*Train.SF15.Value*Train.AppLights1.Value		
        Panel.CabLights = ppzPower*Train.SF15.Value*Train.CabLight.Value*(0.5+Train.CabLightStrength.Value*0.5)

        Panel.Headlights1 = ppzPower*(RV["KRO3-4"]*Train.SF2.Value+RV["KRR5-6"]*Train.SF3.Value)*Train.Headlights1.Value*Train.SF12.Value
        Panel.Headlights2 = ppzPower*(RV["KRO3-4"]*Train.SF2.Value+RV["KRR5-6"]*Train.SF3.Value)*Train.Headlights2.Value*Train.SF13.Value
        Panel.RedLights = ppzPower*(RV["KRO7-8"]*Train.SF2.Value+RV["KRR9-10"]*Train.SF3.Value)*Train.SF14.Value
        Panel.CBKIPower = ppzPower*Train.SF15.Value
    end
    Panel.PCBKPower = P*Train.SFV10.Value
    Panel.AnnouncerPlaying = Train:ReadTrainWire(20)*Train.SFV16.Value
    Panel.TickerPower = P*Train.SFV30.Value
    Panel.TickerWork = Panel.TickerPower*Train:ReadTrainWire(15)
    Panel.PassSchemePower = P*Train.SFV16.Value
    Panel.PassSchemeWork = Panel.PassSchemePower*Train:ReadTrainWire(16)
    self.BVKA_KM1 = P*HV*Train.SFV11.Value*(Train.BUV.MK+Train:ReadTrainWire(10))
    local KM2 = P*(Train:ReadTrainWire(36)*Train.SFV4.Value + Train:ReadTrainWire(34)*Train.SFV5.Value)*Train.SFV1.Value
    if self.BVKA_KM2 ~= KM2 then
        if self.BVKA_KM2 == 0 then
            Train:PlayOnce("batt_on","bass",1)
        end
        self.BVKA_KM2 = KM2
    end
	
	local command = BUV.Strength or 0--+0.5*(BUV.Strength > 0 and BUV.Slope1 and 1 or 0)
	local speed = Async.Speed -- Turbostroi acceleration enabled
	--local speed = Train.Speed -- Turbostroi acceleration disabled
	if self.command ~= command and CurTime()-self.commandTimer > (0.3+(command ~= 0 and speed > 2 and sign(command) ~= sign(self.command) and 0.6 or 0)) then
		self.commandTimer = CurTime()
		self.command = command
	end

	Async:TriggerInput("Power",self.BUTPReady*Train.GV.Value*Train.BV.Value*(Train.TR.Main750V > 975 and 0 or 1))--*(1-BUKV.DisableTP))
	--print(string.format("%.2f %.2f %d %.2f",command,Async.Speed,Async.Mode,Async.Torque))
	if self.command > 0 then--and Train.GV.Value*Train.BV.Value == 1 then--and Train.BV.Value > 0 and Train.AsyncInverter.Drive == 0 and Train.TR.Main750V > 20 then
		Async:TriggerInput("Drive",self.command)
		Async:TriggerInput("Brake",0)
	elseif self.command < 0 then--and Train.GV.Value*Train.BV.Value == 1 then--and Train.AsyncInverter.Brake == 0 then
		Async:TriggerInput("Drive",0)
		Async:TriggerInput("Brake",abs(self.command))
	else
		Async:TriggerInput("Drive",0)
		Async:TriggerInput("Brake",0)		
	end		
    --local speed = (command <= 0 and math.abs(Async.Speed) or math.max(9.6,math.abs(Async.Speed)))
	local targetI,k = self.CurrentConfig[1][self.command],self.CurrentConfig[2][self.command]
    if self.command > 0 then
		Async:TriggerInput("TargetCurrent",targetI*(1+(self.Slope == 1 and 0.1 or Train.Pneumatic.WeightLoadRatio*0.1))*((1-k)+k*Clamp((speed-3)/16,0,1)))--*(0.22+0.78*Clamp((speed-3)/14,0,1)))--*(speed > 50 and 1-(speed-50)/150 or 1) )--*(speed < 20 and 0.23+Clamp(speed/22,0,1)*0.77 or 1))--330
    elseif self.command < 0 then
		Async:TriggerInput("TargetCurrent",targetI*(1+(self.Slope == 1 and 0.1 or Train.Pneumatic.WeightLoadRatio*0.1))*((1-k)+k*Clamp((speed-3)/22,0,1)))--*Clamp((speed-2)/18,0,1))--*(Clamp(speed/30,0,1)+(speed < 10 and 0.035 or 0) ))--330
    else
        Async:TriggerInput("TargetCurrent",0)
    end
	self.EnergyChange = Async.Mode>0 and (Async.Current^2)*2.2 or 0
    self.ElectricEnergyUsed = self.ElectricEnergyUsed + max(0,self.EnergyChange)*dT		
    self.ElectricEnergyDissipated = self.ElectricEnergyDissipated + max(0,-self.EnergyChange)*dT
    self.Itotal = Async.Current
    --[[ if self.Main750V > 900 or Async.Mode>0 then
        self.Recurperation = false
    elseif self.Main750V < 875 and Async.Mode<0 then
    end--]]
    if Async.Mode<0 and Async.State>0 then
	    --[[local RecDelay = 0
	    if self.Main750V <= 970 then
            if CurTime() < RecDelay then return end
            RecDelay = CurTime()-- + 5
        end]]
	--print(RecDelay,1-(CurTime()-RecDelay > 5 and 1 or 0))
        self.Recurperation = C(self.Main750V > 550 and self.Main750V <= 970)*BUV.Recurperation--*(1-(CurTime()-RecDelay > 5 and 1 or 0))-- and 1 or 0   todo reccuperation timer
        self.Iexit = self.Iexit+(-Async.Current*2*self.Recurperation-self.Iexit)*dT*2
        --print(self.Recurperation,C(self.Main750V > 550 and self.Main750V <= 970),BUV.Recurperation)

        self.IChopped = self.IChopped+(-Async.Current*2*(1-self.Recurperation)-self.IChopped)*dT*2
        --self.PreChopper = self.Recurperation
        self.Chopper = 1-self.Recurperation-- and 1 or 0
        --print(self.IChopped, self.Chopper)
    else
        self.Recurperation = 0
        self.Iexit = 0
        self.Chopper = 0
    end
	
    self.Vent2 = P*HV*Train:ReadTrainWire(32)
    self.ConditionerPower = P*Train:ReadTrainWire(32)
    self.ConditionerWork = self.ConditionerPower*HV

    local butpPower = P*Train.SFV28.Value
    self.BUTPReady = butpPower*self.BVKA_KM2

    local strengthZero = Train.BUV.Strength == 0 and 1 or 0
    
    if not self.DisableBV then self.DisableBV = 0 end -- Без турбостороя уходит в nil
	if Train.BV.Value > 0 and Async.Current*2 > 1500 or (self.DisableBV and self.DisableBV == 1) or self.Main750V > 975 or butpPower == 0 then
        Train.BV:TriggerInput("Open",1)
        self.BVcountOfTriggers = self.BVcountOfTriggers + 1
    end
    if (Train.BV.Value == 0 and butpPower*strengthZero > 0 and (self.DisableBV and self.DisableBV == 0)) then
		if not self.BVTimer then self.BVTimer = CurTime() end
        if self.BVactivationAttempt <= 3 then
            if self.BVTimer and CurTime() - self.BVTimer > self.BVTime2On and ((self.DisableBV and self.DisableBV == 0) and self.Main750V < 975) then
                self.BVactivationAttempt = 0
                if self.BVactivationAttempt <= 3 or self.BVcountOfTriggers <= 2 then Train.BV:TriggerInput("Close",1) self.BVonSelfLocking = 0 end
                self.BVTimer = nil
            elseif self.BVTimer and CurTime() - self.BVTimer > self.BVTime2On and ((self.DisableBV and self.DisableBV == 0) or self.Main750V > 975) then
                self.BVactivationAttempt = self.BVactivationAttempt + 1
                self.BVTimer = nil
            end
        elseif self.BVactivationAttempt > 3 or self.BVcountOfTriggers > 2 then
            self.BVonSelfLocking = 1
            self.BVTimer = nil
        end
    else
        self.BVTimer = nil
	end

    if self.BVPositionCache ~= Train.BV.Value then
        self.BVPositionCache = Train.BV.Value
        self.ResetAttemptsTimer = nil
    end

    -- Сбрасываем количество попыток в течение 5 минут без сработок/краковременных выключений БВ
    if Train.BV.Value > 0 and self.BVactivationAttempt > 0 and not self.ResetAttemptsTimer then
        self.ResetAttemptsTimer = CurTime()
    end
    
    if self.ResetAttemptsTimer and CurTime() - self.ResetAttemptsTimer >= 300 then
        self.BVcountOfTriggers = 0
        self.ResetAttemptsTimer = nil
    end

    -- Сбрасываем количество попыток в течение 30 секунд путем выключения БУТП
    if butpPower == 0 and self.BVactivationAttempt > 0 and not self.RebootTimer then self.RebootTimer = CurTime() end
    if self.RebootTimer and CurTime() - self.RebootTimer >= 30 then
        self.BVactivationAttempt = 0
        self.BVcountOfTriggers = 0
        self.RebootTimer = nil
    end

    ----------------------------------------------------------------------------
    -- Solve circuits
    ----------------------------------------------------------------------------
    local bv = Train.BV.Value
    local emer = Train:ReadTrainWire(45)+Train:ReadTrainWire(19)
    local strength,brake,drive = 0,0,0
    if emer > 0 then
        strength = Train:ReadTrainWire(45) > 0 and 4 or Train:ReadTrainWire(19) > 0 and 2 or 0
        drive = strength*bv
    else
        brake = Train.BUV.Brake
        drive = Train.BUV.Drive*bv
        strength = Train.BUV.DriveStrength
    end
	local Current = Async.Current*2
end