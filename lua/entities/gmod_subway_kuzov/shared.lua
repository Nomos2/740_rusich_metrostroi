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

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category		= "Metrostroi (trains)"
ENT.Model 			= "models/metrostroi_train/81-740/body/81-740_4_rear_reference.mdl"

ENT.NoTrain = true

local yventpos = {
	11,9,78,
	-40,-1,78,
}

function ENT:PassengerCapacity()
    return 172
end
local function GetDoorPosition(n,G)	--	x--	y        --	z
	return Vector(-195.5 - -35.0*G - 232.1*n, 66*(1-2*G), 4.3)
end
function ENT:GetStandingArea()    --смещение пассажиров
	return Vector(270-15,-25,-47),Vector(-285,25,-46) 	
end	
function ENT:BoardPassengers(delta)	
	self.HeadTrain = self:GetNW2Entity("HeadTrain")	
	local train = self.HeadTrain 
	if not IsValid(train) then return end
	self:SetNW2Float("PassengerCount", math.max(0,math.min(self:PassengerCapacity(),train:GetNW2Float("PassengerCount") + delta)))
end

-- Setup door positions
ENT.LeftDoorPositions = {}
ENT.RightDoorPositions = {}
for i=0,3 do
    table.insert(ENT.LeftDoorPositions,GetDoorPosition(i,0))
    table.insert(ENT.RightDoorPositions,GetDoorPosition(i,1))
end

function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456+144, 0,-63),1}
    self.SoundNames["compressor"] = {loop=58,"subway_trains/740_4/compressor/compressor_start.wav","subway_trains/740_4/compressor/compressor_loop.wav","subway_trains/740_4/compressor/compressor_end.wav"}
    self.SoundPositions["compressor"] = {300,1e9,Vector(-18,-40,-66),0.4}
	self.SoundNames["compressor_pn"] = "subway_trains/740_4/compressor/compressor_psh.wav"
    self.SoundPositions["compressor_pn"] = {485,1e9,Vector(-18,-40,-66),0.4}
	
    for i=1,4 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/740_4/vent/vent_loop.wav"}
        self.SoundPositions["vent"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
        self.SoundNames["vent1"..i] = {loop=true,"subway_trains/740_4/vent/vent_loop_1.wav"}
        self.SoundPositions["vent1"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
    end
	
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"
    self.SoundNames["RearBrakeLineIsolation"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"
    self.SoundNames["RearTrainLineIsolation"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"	
	
    self.SoundNames["bbe"]   = {"subway_trains/740_4/bbe.wav",loop = true}
    self.SoundPositions["bbe"] = {800,1e9,Vector(50,0,-40),0.5}	

	self.SoundNames["cab_door_open"] = "subway_trains/740_4/doors/torec/door_torec_open.mp3"
    self.SoundNames["cab_door_close"] = "subway_trains/740_4/doors/torec/door_torec_close.mp3"	
	local j = math.random (1,3)	
    self.SoundNames["release_rear"] = {loop=true,"subway_trains/740_4/new/pneumo_release_"..j..".wav"}
    self.SoundPositions["release_rear"] = {1200,1e9,Vector(600-144,0,-70),0.4}

	local snd = math.random (1,2)	
	local closed = math.random (1,3)	
    for i=0,2 do	
	for k=0,1 do	
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/740_4/doors/door_loop"..snd..".wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."s"] = {"subway_trains/740_4/doors/door_open_start"..snd..".wav"}
            self.SoundPositions["door"..i.."x"..k.."s"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/740_4/doors/door_open_end"..snd..".wav"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/740_4/doors/door_close_end"..closed..".wav"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {200,1e9,GetDoorPosition(i,k),0.5}
        end	
	end
end

ENT.AnnouncerPositions = {}
ENT.AnnouncerPositions = {
    {Vector(190,-34,55),50,0.2},
	{Vector(-38,-34,55),50,0.2},
    {Vector(-275,-34,55),50,0.2},
    {Vector(-228,34,55),50,0.2},
    {Vector(3,34,55),50,0.2},
    {Vector(235,34,55),50,0.2},
}
function ENT:InitializeSystems()
	self:LoadSystem("RearBrakeLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
	self:LoadSystem("RearTrainLineIsolation","Relay","Switch", { normally_closed = true, bass = true})
end

ENT.SubwayTrain = nil