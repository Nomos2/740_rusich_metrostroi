local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_kalinin")
or Map:find("gm_metro_krl")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")
or Map:find("gm_metropbl")) then
	return
end

ENT.NoTrain = true

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Category		= ""
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Model 			= "models/metrostroi_train/81-740/body/81-740_4_rear_reference.mdl"

local yventpos = {
    -14.5+0*117-144,
	-14.5+2*117+5-144,
	-44.5+4*117+0.5-144,
}

function ENT:PassengerCapacity()
    return 177
end
local function GetDoorPosition(n,G)			--	x						--	y        --	z
	return Vector(-195.5 - -35.0*G - 232.1*n, -66*(1-2*G), 4.3)
end
function ENT:GetStandingArea()    --смещение пассажиров
	return Vector(270-15,-25,-47),Vector(-285,25,-46) 	
end 
function ENT:BoardPassengers(delta)
    self:SetNW2Entity("gmod_subway_81-740_4", self.HeadTrain)	
    local train = self.HeadTrain
	if not IsValid(train) then return end		
	self:SetNW2Float("PassengerCount", math.max(0,math.min(train:PassengerCapacity(),self:GetNW2Float("PassengerCount") + delta)))
end

function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
	--for i = 1,10 do
		--local id3 = Format("b3tunnel_%d",i)	
		--local id3 = Format("b3tunnel_%d",i)	
		
		--self.SoundNames[id3.."a"] = "subway_trains/bogey/st"..i.."a.wav"
		--self.SoundNames[id3.."b"] = "subway_trains/bogey/st"..i.."b.wav"
		--self.SoundPositions[id3.."a"] = {700,1e9,Vector(-456+144,0,-74),1}
		--self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
		
		--self.SoundNames[id3.."a"] = "subway_trains/bogey/st"..i.."a.wav"
		--self.SoundNames[id3.."b"] = "subway_trains/bogey/st"..i.."b.wav"
		--self.SoundPositions[id3.."a"] = {700,1e9,Vector(-532,0,-74.5),1}
		--self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
	--end
	--for i = 1,14 do
		--local id3 = Format("b3street_%d",i)		
		--local id3 = Format("b3street_%d",i)	

		--self.SoundNames[id3.."a"] = "subway_trains/bogey/wheels/street_"..i.."a.mp3"
		--self.SoundNames[id3.."b"] = "subway_trains/bogey/wheels/street_"..i.."b.mp3"
		--self.SoundPositions[id3.."a"] = {700,1e9,Vector(-456+144,0,-74),1.5}
		--self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]	
		
		--self.SoundNames[id3.."a"] = "subway_trains/bogey/wheels/street_"..i.."a.mp3"
		--self.SoundNames[id3.."b"] = "subway_trains/bogey/wheels/street_"..i.."b.mp3"
		--self.SoundPositions[id3.."a"] = {700,1e9,Vector(-532,0,-74.5),1.5}
		--self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
	--end --Не работает код.
	
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456+144, 0,-63),1}
    self.SoundNames["compressor"] = {loop=2,"subway_trains/rusich/compressor/compressor740_start.wav","subway_trains/rusich/compressor/compressor740_loop.wav","subway_trains/rusich/compressor/compressor740_stop.wav"}
    self.SoundPositions["compressor"] = {800,1e9,Vector(-18,-40,-66),0.4}	
	
    for i=1,4 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/rusich/vent/vent_loop.wav"}
        self.SoundPositions["vent"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
        self.SoundNames["vent1"..i] = {loop=true,"subway_trains/rusich/vent/vent_loop_1.wav"}
        self.SoundPositions["vent1"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
    end		
	
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"
	
    self.SoundNames["bbe_v1"]   = {"subway_trains/rusich/bbes/bbe.wav",loop = true}
    self.SoundPositions["bbe_v1"] = {800,1e9,Vector(50,0,-40),0.4}	
    self.SoundNames["bbe_v2"]   = {"subway_trains/rusich/bbes/bbe_1.wav",loop = true}
    self.SoundPositions["bbe_v2"] = {800,1e9,Vector(50,0,-40),0.4} 	
    self.SoundNames["bbe_v3"]   = {"subway_trains/rusich/bbes/bbe_new.wav",loop = true}
    self.SoundPositions["bbe_v3"] = {800,1e9,Vector(50,0,-40),0.4}		

	self.SoundNames["cab_door_open"] = "subway_trains/rusich/door/torec/door_torec_open_end.wav"
    self.SoundNames["cab_door_close"] = "subway_trains/rusich/door/torec/door_close_1.mp3"	
	local j = math.random (1,3)	
    self.SoundNames["release_rear"] = {loop=true,"subway_trains/rusich/pneumo_release_"..j..".wav"}
    self.SoundPositions["release_rear"] = {1200,1e9,Vector(600-144,0,-70),0.4}		

	local loop = math.random (1,2)
	local start = math.random (1,5)		
	local closed = math.random (1,5)	
	local open = math.random (1,3)	
    for i=0,2 do	
	for k=0,1 do	
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/rusich/doors/door_loop_"..loop..".wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."s"] = {"subway_trains/rusich/doors/door_start_"..start..".wav"}
            self.SoundPositions["door"..i.."x"..k.."s"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/rusich/doors/door_open_end"..open..".wav"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/rusich/doors/door_close"..closed..".wav"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {200,1e9,GetDoorPosition(i,k),0.5}
        end	
	end
end

ENT.AnnouncerPositions = {}
ENT.AnnouncerPositions = {
    {Vector(190,-34,55),250,0.1},
	--{Vector(-38,-34,55),50,0.1},
    --{Vector(-275,-34,55),50,0.1},
    --{Vector(-228,34,55),50,0.1},
    --{Vector(3,34,55),250,0.1},
    --{Vector(235,34,55),250,0.1},
}
-- Setup door positions
ENT.LeftDoorPositions = {}
ENT.RightDoorPositions = {}
for i=0,3 do
    table.insert(ENT.LeftDoorPositions,GetDoorPosition(i,1))
    table.insert(ENT.RightDoorPositions,GetDoorPosition(i,0))
end

ENT.SubwayTrain = nil