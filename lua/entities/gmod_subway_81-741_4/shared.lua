local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_krl")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")
or Map:find("gm_metropbl")) then
	return
end

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType 		= "81-740"
ENT.Model 			= "models/metrostroi_train/81-741/body/81-741_4_front.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = true
 
function ENT:PassengerCapacity()
    return 198
end	

function ENT:GetStandingArea()
    return Vector(530,-25,-47), Vector(50,25,-41)
end
local function GetDoorPosition(b,k)	--Правые двери			--Левые двери
	return Vector(652.5  - 35.0*k     -  338.8*b, -67.5*(1-2*k), 4.3)
end

local yventpos = {
    414.5+0*117-144,
	414.5+2*117+5-144,
	414.5+4*117+0.5-144,
}

function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
	
	for i = 1,10 do
		local id1 = Format("b1tunnel_%d",i)
		local id2 = Format("b2tunnel_%d",i)
		local id3 = Format("b3tunnel_%d",i)		
		self.SoundNames[id1.."a"] = "subway_trains/740_4/bogey/wheels/tunnel/st"..i.."a.wav"
		self.SoundNames[id1.."b"] = "subway_trains/740_4/bogey/wheels/tunnel/st"..i.."b.wav"
		self.SoundPositions[id1.."a"] = {700,1e9,Vector( 520,0,-75),1}
		self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
		
		self.SoundNames[id2.."a"] = "subway_trains/740_4/bogey/wheels/tunnel/yakobs/st"..i.."a.wav"
		self.SoundNames[id2.."b"] = "subway_trains/740_4/bogey/wheels/tunnel/yakobs/st"..i.."b.wav"
		self.SoundPositions[id2.."a"] = {700,1e9,Vector(-1,0,-74),1}
		self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
		
		self.SoundNames[id3.."a"] = "subway_trains/740_4/bogey/wheels/tunnel/st"..i.."a.wav"
		self.SoundNames[id3.."b"] = "subway_trains/740_4/bogey/wheels/tunnel/st"..i.."b.wav"
		self.SoundPositions[id3.."a"] = {700,1e9,Vector(-520,0,-74.5),1}
		self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
	end
	for i = 1,14 do
		local id1 = Format("b1street_%d",i)
		local id2 = Format("b2street_%d",i)
		local id3 = Format("b3street_%d",i)		
		self.SoundNames[id1.."a"] = "subway_trains/740_4/bogey/wheels/street/street_"..i.."a.mp3"
		self.SoundNames[id1.."b"] = "subway_trains/740_4/bogey/wheels/street/street_"..i.."b.mp3"
		self.SoundPositions[id1.."a"] = {700,1e9,Vector( 520,0,-75),1.5}
		self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
		
		self.SoundNames[id2.."a"] = "subway_trains/740_4/bogey/wheels/street/yakobs/street_"..i.."a.mp3"
		self.SoundNames[id2.."b"] = "subway_trains/740_4/bogey/wheels/street/yakobs/street_"..i.."b.mp3"
		self.SoundPositions[id2.."a"] = {700,1e9,Vector(-1,0,-74),1.5}
		self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"] 
		
		self.SoundNames[id3.."a"] = "subway_trains/740_4/bogey/wheels/street/street_"..i.."a.mp3"
		self.SoundNames[id3.."b"] = "subway_trains/740_4/bogey/wheels/street/street_"..i.."b.mp3"
		self.SoundPositions[id3.."a"] = {700,1e9,Vector(-520,0,-74.5),1.5}
		self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
	end	
	
	--Костыль в лице id2 и 3, они работают только на передней секции, цель - переписать их под заднюю секцию без внедрения кода непосредственно в заднюю секцию. 	
	
    self.SoundNames["chopper_onix"]   = {"subway_trains/740_4/chopper.wav",loop = true}
    self.SoundPositions["chopper_onix"] = {200,1e9,Vector(144,0,0),2}	
    self.SoundNames["ONIX"]   = {"subway_trains/740_4/inverter.wav", loop = true}
    self.SoundPositions["ONIX"] = {400,1e9,Vector(344,0,0),1.5}	
	
    for i=1,4 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/740_4/vent/vent_loop.wav"}
        self.SoundPositions["vent"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
        self.SoundNames["vent1"..i] = {loop=true,"subway_trains/740_4/vent/vent_loop_1.wav"}
        self.SoundPositions["vent1"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
    end

    self.SoundNames["compressor_pn"] = "subway_trains/740_4/compressor/compressor_psh.wav"
    self.SoundPositions["compressor_pn"] = {485,1e9,Vector(-18+-144,-40,-66),0.7} --FIXME: Pos

	local rol = math.random (1,2)
	local j = math.random (1,3)
    self.SoundNames["release_front"] = {loop=true,"subway_trains/740_4/new/pneumo_release_"..j..".wav"}
    self.SoundPositions["release_front"] = {485,1e9,Vector(-53,0,-70),0.25}
    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["parking_brake"] = {400,1e9,Vector(-13+144,0,-70),0.95}
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"
    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(443, 0,-63),1}
	
    self.SoundNames["rolling_5"] = {loop=true,"subway_trains/740_4/bogey/skrip1.mp3"}	
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/740_4/bogey/rolling_10.wav"}
    self.SoundNames["rolling_30"] = {loop=true,"subway_trains/740_4/bogey/rolling_30.wav"}
    self.SoundNames["rolling_55"] = {loop=true,"subway_trains/740_4/bogey/rolling_55.wav"}
    self.SoundNames["rolling_75"] = {loop=true,"subway_trains/740_4/bogey/rolling_75.wav"}
    self.SoundPositions["rolling_5"] = {485,1e9,Vector(520,0,0),0.4}	
    self.SoundPositions["rolling_10"] = {485,1e9,Vector(520,0,0),0.53}
    self.SoundPositions["rolling_30"] = {485,1e9,Vector(520,0,0),0.7}
    self.SoundPositions["rolling_55"] = {485,1e9,Vector(520,0,0),0.85}
    self.SoundPositions["rolling_75"] = {485,1e9,Vector(520,0,0),0.9}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/740_4/bogey/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/740_4/bogey/rolling_outside_medium"..rol..".wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/740_4/bogey/rolling_outside_high"..rol..".wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(520,0,0),0.6*0.4}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(520,0,0),0.90*0.4}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(520,0,0),0.90*0.4}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(520,0,0),1.00*0.4}

    self.SoundNames["valve_brake"] = {loop=true,"subway_trains/740_4/new/stopkran_loop.wav"}
    self.SoundPositions["valve_brake"] = {400,1e9,Vector(418.25,-49.2,1.3),1} -- Скорректируйте позицию
	
    self.SoundNames["rolling_5_middle"] = {loop=true,"subway_trains/740_4/bogey/skrip1.mp3"}	
    self.SoundNames["rolling_10_middle"] = {loop=true,"subway_trains/740_4/bogey/rolling_10.wav"}
    self.SoundNames["rolling_30_middle"] = {loop=true,"subway_trains/740_4/bogey/rolling_30.wav"}
    self.SoundNames["rolling_55_middle"] = {loop=true,"subway_trains/740_4/bogey/rolling_55.wav"}
    self.SoundNames["rolling_75_middle"] = {loop=true,"subway_trains/740_4/bogey/rolling_75.wav"}
    self.SoundPositions["rolling_5_middle"] = {485,1e9,Vector(-1,0,0),0.4}	
    self.SoundPositions["rolling_10_middle"] = {485,1e9,Vector(-1,0,0),0.53}
    self.SoundPositions["rolling_30_middle"] = {485,1e9,Vector(-1,0,0),0.7}
    self.SoundPositions["rolling_55_middle"] = {485,1e9,Vector(-1,0,0),0.85}
    self.SoundPositions["rolling_75_middle"] = {485,1e9,Vector(-1,0,0),0.9}
    self.SoundNames["rolling_low_middle"] = {loop=true,"subway_trains/740_4/bogey/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium2_middle"] = {loop=true,"subway_trains/740_4/bogey/rolling_outside_medium"..rol..".wav"}
    self.SoundNames["rolling_high2_middle"] = {loop=true,"subway_trains/740_4/bogey/rolling_outside_high"..rol..".wav"}
    self.SoundPositions["rolling_low_middle"] = {480,1e12,Vector(-1,0,0),0.6*0.4}
    self.SoundPositions["rolling_medium1_middle"] = {480,1e12,Vector(-1,0,0),0.90*0.4}
    self.SoundPositions["rolling_medium2_middle"] = {480,1e12,Vector(-1,0,0),0.90*0.4}
    self.SoundPositions["rolling_high2_middle"] = {480,1e12,Vector(-1,0,0),1.00*0.4}	

    self.SoundNames["gv_f"] = {"subway_trains/740_4/new/bru/bru_off-on.mp3","subway_trains/740_4/new/bru/bru_off-on2.mp3","subway_trains/740_4/new/bru/bru_off-on3.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/740_4/new/bru/bru_on-off.mp3","subway_trains/740_4/new/bru/bru_on-off2.mp3"}
    self.SoundPositions["gv_f"] = {80,1e9,Vector(-126.4,50,-60-23.5),0.8}
    self.SoundPositions["gv_b"] = {80,1e9,Vector(-126.4,50,-60-23.5),0.8}
    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"
	
  	self.SoundNames["door_cab_open"] = "subway_trains/740_4/doors/torec/door_torec_open.mp3"
    self.SoundNames["door_cab_close"] = "subway_trains/740_4/doors/torec/door_torec_close.mp3"	

	local loop = math.random (1,2)
	local start = math.random (1,2)		
	local closed = math.random (1,3)	
	local open = math.random (1,2)	
    for i=0,2 do	
	for k=0,1 do	
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/740_4/doors/door_loop"..loop..".wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."s"] = {"subway_trains/740_4/doors/door_open_start"..start..".wav"}
            self.SoundPositions["door"..i.."x"..k.."s"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/740_4/doors/door_open_end"..open..".wav"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/740_4/doors/door_close_end"..closed..".wav"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {200,1e9,GetDoorPosition(i,k),0.5}
        end	
	end
    self.SoundNames["batt_on"] = "subway_trains/720/batt_on.mp3"
    self.SoundPositions["batt_on"] = {400,1e9,Vector(126.4,50,-60-23.5),0.3}
end

function ENT:InitializeSystems()
    self:LoadSystem("TR","TR_3B_4740")
    self:LoadSystem("Electric","81_740_4ELECTRICA")
    self:LoadSystem("BUV","81_740_4BUV")
    self:LoadSystem("Pneumatic","81_740_4Pneumatic")
    self:LoadSystem("Panel","81_741_4Panel")
    self:LoadSystem("Tickers","81_740_4Ticker")
    --self:LoadSystem("PassSchemes","81_740_4PassScheme")
	self:LoadSystem("AsyncInverter","81_760_AsyncInverter")	
    self:LoadSystem("IGLA_PCBK","IGLA_740_4PCBK")	
end

ENT.AnnouncerPositions = {}
ENT.AnnouncerPositions = {
	{Vector(85,-34,55),50,0.4},
	{Vector(324,-34,55),50,0.4},
	{Vector(550,-34,55),50,0.4},
	{Vector(600,34,55),50,0.4},
	{Vector(362,34,55),50,0.4},
	{Vector(136,34,55),50,0.4},
	{Vector(-120,0,55),50,0.4},	--Костыль под информатор.
	{Vector(-360,0,55),50,0.4},	--Костыль под информатор.
	{Vector(-570,0,55),50,0.4},	--Костыль под информатор.	
}
-- Setup door positions
ENT.LeftDoorPositions = {}
ENT.RightDoorPositions = {}
for i=0,3 do
    table.insert(ENT.LeftDoorPositions,GetDoorPosition(i,1))
    table.insert(ENT.RightDoorPositions,GetDoorPosition(i,0))
end
---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81-740",
    Name = "81-741",
    WagType = 2,
    Manufacturer = "MVM",
    EKKType = 740
}
ENT.NumberRanges = {{0681,0683},{0735,0762},{0767,0784},{0786,0800},{0808,0815},{0817,0823},{0825,0844},{0847,0852},{0854,0854},{0856,0870},{0872,0881},{0882,0884},{0886,0890},{0894,0905},{0909,0911},{0913,0917}}