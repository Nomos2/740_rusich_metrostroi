Metrostroi.DefineSystem("IGLA_740_4PCBK")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.States = {}
    self.State = -1
    self.Timer = 0
    self.Time = 0

    self.KVC = 1

end
if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
    return {  "" }
end
function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata== "Update" then
        self.Update = true
    end
end
function TRAIN_SYSTEM:CANWrite(name,value)
    self.Train:CANWrite("IGLA_PCBK",self.Train:GetWagonNumber(),"IGLA_CBKI",nil,name,value)
end
function TRAIN_SYSTEM:CState(name,value)
    if self.Update or self.States[name] ~= value then
        self.States[name] = value
        self.Train:CANWrite("IGLA_PCBK",self.Train:GetWagonNumber(),"IGLA_CBKI",nil,name,value)
    end
end
function TRAIN_SYSTEM:Think(dT)
    local Train = self.Train
    if Train.Panel.PCBKPower == 0 or self.Reset then
        self.Reset = false
        if self.State ~= -1 then
            self.State = -1
            self.Timer = nil
        end
    end
    if self.State == -1 and (Train.Panel.PCBKPower > 0) then
        self.State = 0
        self.Timer = CurTime()+math.random()*0.3
    end
    if self.State == 0 and CurTime()-self.Timer > 1.2 then
        self.State = 1
        self.Time = CurTime()
        self.EngageTimer = nil
    end
    if self.State == 1 and (CurTime() - self.Time) > 1.4 then
        if self.Update then
            self:CANWrite("Timer",CurTime())
        end
        local electric = self.Train.Electric
        self.Time= CurTime()+math.random()*0.4
        self:CState("PTROverheat",false)
        self:CState("PTROverheating",false)
        self.Update = false
    end
end