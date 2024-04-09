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

include("shared.lua")
--
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}
ENT.ClientPropsInitialized = false

ENT.ClientProps["salon"] = {
	model = "models/metrostroi_train/81-740/salon/salon_rear.mdl",
    pos = Vector(-211.2, 0, 5.5),
    ang = Angle(0,180,0),
	hide = 1.5, 	
}
--Новые модели 2023
ENT.ClientProps["Naddver_off_740"] = { 
    model = "models/metrostroi_train/81-740/salon/naddverka_off_740.mdl",
	pos = Vector(-15.8,-37.15,57.1),
    ang = Angle(0,0,0),
	scale = 1,
}
ENT.ClientProps["Zavod_table_sochl"] = { 
    model = "models/metrostroi_train/81-740/salon/zavod.mdl",
	pos = Vector(287.48,44,48),
    ang = Angle(90,-180,0),
	scale = 3,
	hide = 1,
}
ENT.ClientProps["Zavod_table_sochl_torec"] = { 
    model = "models/metrostroi_train/81-740/salon/zavod.mdl",
	pos = Vector(-332.4,-20,59),
    ang = Angle(90,0,0),
	scale = 3,
	hide = 1, 	
}

ENT.ClientProps["krepezh"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(64.5, 0, -75.2),
    ang = Angle(0,180,0), 
	nohide = true,   	  
}
ENT.ClientProps["handrails_offside"] = {
    model = "models/metrostroi_train/81-740/body/740_body_additional.mdl",
    pos = Vector(21.8, 10, -76.5),
    ang = Angle(0,180,0),   
	nohide = true,	
}
ENT.ClientProps["handrails"] = {
	model = "models/metrostroi_train/81-740/salon/handrails/handrails_r.mdl",
    pos = Vector(-115.4, -1, -75),
    ang = Angle(0,180,0),
	hide = 1.5, 	
}
ENT.ClientProps["lamps_salon_off_r"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_off.mdl",
    pos = Vector(1.1, 0.05, -0.4),
    ang = Angle(0,0,0), 
	hide = 1.5,
}
ENT.ClientProps["door_cab_t"] = {
	model = "models/metrostroi_train/81-740/salon/door_br.mdl",
	pos = Vector(-334.5, 15, 8.8), 
	ang = Angle(0,180,0),
	hide = 1.5, 	
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-332,-15,55), ---334.8,14.5,9
    ang = Angle(0,90,90),
    width = 582,
    height = 1900,
    scale = 0.1/2, 	
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=582,h=1900,"", model = {
            var="RearDoor",sndid="door_cab_t",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},   
	}	
}
ENT.ButtonMap["RearDoor_front"] = {
    pos = Vector(-337,15,55), ---334.8,14.5,9
    ang = Angle(0,-90,90),
    width = 582,
    height = 1900,
    scale = 0.1/2, 	
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=582,h=1900,"", model = {
            var="RearDoor_front",sndid="door_cab_t",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},   
	}	
}

ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-337,45,-46),
    ang = Angle(180,90,270),
    width = 900,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
	screenHide = true,

    buttons = {
		{ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100,tooltip=""},
		{ID = "RearBrakeLineIsolationToggle",x=0, y=0, w=400, h=100,tooltip=""},
    }
}	
ENT.ClientProps["RearTrain"] = {
	model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
	pos = Vector(-336, -25, -53.9),
	ang = Angle(0,90,0),
	hide = 1,	
}
ENT.ClientProps["RearBrake"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
	pos = Vector(-336, 25, -53.9),
	ang = Angle(0,90,0),
	hide = 2,	
}

ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["Tickers_rear"] = {
	pos = Vector(286.2,27,65.85), --446 -- 14 -- -0,5
	ang = Angle(0,-90,90),
	width = 1024,
	height = 64,
	scale = 0.054,
	hide=true,
	hideseat=1,
}	
	
ENT.ClientProps["lamps_salon_on_rear_avar1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(-197.3, 0.3, -74.885),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
	hide = 1,     	 
}
ENT.ClientProps["lamps_salon_on_rear_avar2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(286.15, -57.8, -74.88),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
	hide = 1,	
}
for i = 1,11 do
ENT.ClientProps["lamps_salon_on_rear"..i-1] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(341.5-54*i+1,0.3,-74.92),
    ang = Angle(0,180,0),
    color = Color(245,238,223),	
	hide = 1,  	
}

ENT.ClientProps["lamps_salon_on_rear1"..i] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(341.5-54*i+1,-57.78,-74.88),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
	hide = 1, 	   
}
end

ENT.ClientProps["door0x0"] = {
	model = "models/metrostroi_train/81-740/body/door_pass.mdl",
	pos = Vector(213.1,60.5,4.5),
	ang = Angle(0,-90,0),
	hide = 2
}
ENT.ClientProps["door1x0"] = {
	model = "models/metrostroi_train/81-740/body/door_pass.mdl",
	pos = Vector(-18.5,60.5,4.5),
	ang = Angle(0,-90,0),
	hide = 2
}
ENT.ClientProps["door2x0"] = {
	model = "models/metrostroi_train/81-740/body/door_pass.mdl",
	pos = Vector(-251.5,60.5,4.5),
	ang = Angle(0,-90,0),
	hide = 2
}

ENT.ClientProps["door0x1"] = {
	model = "models/metrostroi_train/81-740/body/door_pass.mdl",
	pos = Vector(213,-60.6,4.5),
	ang = Angle(0,90,0),
	hide = 2
}
ENT.ClientProps["door1x1"] = {
	model = "models/metrostroi_train/81-740/body/door_pass.mdl",
	pos = Vector(-18.5,-60.6,4.5),
	ang = Angle(0,90,0),
	hide = 2
}
ENT.ClientProps["door2x1"] = {
	model = "models/metrostroi_train/81-740/body/door_pass.mdl",
	pos = Vector(-251.5,-60.6,4.5),
	ang = Angle(0,90,0),
	hide = 2
}

local yventpos = {
    414.5+0*117-159,
	414.5+2*117+5-159,
	214.5+4*117+0.5-15,
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
	self.DoorsAnims = {}
	for i = 1,6 do
		self.DoorsAnims[i] = self:GetNW2Int("DoorsAnim"..i,15)
	end	
    self.HeadTrain = self:GetNW2Entity("HeadTrain")	
    local train = self.HeadTrain 
    if not IsValid(train) then return end
	
	train.CompressorVol = 0	
    self.PassengerEnts = {}
    self.PassengerEntsStucked = {}	
    self.PassengerPositions = {}	

	self.PassengerModels = {
        "models/metrostroi/passengers/f1.mdl",
        "models/metrostroi/passengers/f2.mdl",
        "models/metrostroi/passengers/f3.mdl",
        "models/metrostroi/passengers/f4.mdl",
	    "models/metrostroi/passengers/f5.mdl",	
        "models/metrostroi/passengers/m1.mdl",
        "models/metrostroi/passengers/m2.mdl",
	    "models/metrostroi/passengers/m3.mdl",	
        "models/metrostroi/passengers/m4.mdl",
        "models/metrostroi/passengers/m5.mdl",
    }
    train.PreviousCompressorState = false	
	
    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,4 do
        self.VentRand[i] = math.Rand(0.5,2)
        self.VentState[i] = 0
        self.VentVol[i] = 0
    end	
end	

function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then return end 	
    self.HeadTrain = self:GetNW2Entity("HeadTrain")	
    local train = self.HeadTrain 
    if not IsValid(train) then return end
	
--Регистрация тележки
train.PricepBogey = train:GetNW2Entity("PricepBogey")	
local RB = train.PricepBogey

--Взято из cl_init тележки.
local c_gui
if IsValid(c_gui) then c_gui:Close() end

local function addButton(parent,stext,state,scolor,btext,benabled,callback)
    --local a = v[1]
    local panel = vgui.Create("DPanel")
    panel:Dock( TOP )
    panel:DockMargin( 5, 0, 5, 5 )
    panel:DockPadding( 5, 5, 5, 5 )
    if benabled then
        local button = vgui.Create("DButton",panel)
        button:Dock(RIGHT)
        button:SetText(Metrostroi.GetPhrase(btext))
        button:DockPadding( 5, 5, 5, 5 )
        button:SizeToContents()
        button:SetContentAlignment(5)
        button:SetEnabled(benabled)
        button.DoClick = callback
    end

    --DrawCutText(panel,Metrostroi.GetPhrase("Workshop.Warning"),false,"DermaDefaultBold")
    vgui.MetrostroiDrawCutText(panel,Metrostroi.GetPhrase(stext),false,"DermaDefaultBold")
    vgui.MetrostroiDrawCutText(panel,Metrostroi.GetPhrase(state),scolor,"DermaDefaultBold")

    panel:InvalidateLayout( true )
    panel:SizeToChildren(true,true )
    parent:AddItem(panel)
end

function RB:DrawGUI(tbl)
    if IsValid(c_gui) then  c_gui:Close() end
     local c_gui = vgui.Create("DFrame")
        c_gui:SetDeleteOnClose(true)
        c_gui:SetTitle(Metrostroi.GetPhrase("Common.Bogey.Title"))
        c_gui:SetSize(0, 0)
        c_gui:SetDraggable(true)
        c_gui:SetSizable(false)
        c_gui:MakePopup()
    local scrollPanel = vgui.Create( "DScrollPanel", c_gui )
    if tbl.havepb then
        addButton(scrollPanel,"Common.Bogey.ParkingBrakeState",tbl.pbdisabled and "Common.Bogey.PBDisabled" or "Common.Bogey.PBEnabled", Color(0,150,0),tbl.pbdisabled and "Common.Bogey.PBEnable" or "Common.Bogey.PBDisable",tbl.access,function(button)
            net.Start("metrostroi-bogey-menu")
                net.WriteEntity(self)
                net.WriteUInt(1,8)
            net.SendToServer()
            c_gui:Close()
        end)
    end

    scrollPanel:Dock( FILL )
    scrollPanel:InvalidateLayout( true )
    scrollPanel:SizeToChildren(false,true)
    local spPefromLayout = scrollPanel.PerformLayout
    function scrollPanel:PerformLayout()
        spPefromLayout(self)
        if not self.First then self.First = true return end
        local x,y = scrollPanel:ChildrenSize()
        if self.Centered then return end
        self.Centered = true
        c_gui:SetSize(512,math.min(350,y)+35)
        c_gui:Center()
    end
end	
	
for k=0,3 do
self.ClientProps["TrainNumberL"..k] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(-310+k*6.6-4*6.6/2, 63.4, 18),
        ang = Angle(0,180,-3.29),
        hide = 1,
        callback = function(self)
            train.WagonNumber = false 
		end,
    } 
end
    self.HeadTrain = self:GetNW2Entity("HeadTrain")	
    local train = self.HeadTrain 
    if not IsValid(train) then return end
	
	local animation = math.random (5,12)	
	local animation1 = math.random (0.5,1)
	local kr = self,train
	
	for avar = 1,2 do
		if not IsValid(train) then return end	
		local colV = kr:GetNW2Vector("Lamp7404"..avar)
		local col = Color(colV.x,colV.y,colV.z)	
		self:ShowHideSmooth("lamps_salon_on_rear_avar"..avar,train:Animate("LampsEmer",train:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,animation1,animation,false),col)  
	end	

    local state = self:GetPackedBool("CompressorWork")
    self:SetSoundState("compressor",state and 1.0 or 0,1)

	for i = 1,11 do	
		if not IsValid(train) then return end	
		local colV = kr:GetNW2Vector("Lamp7404"..i)
		local col = Color(colV.x,colV.y,colV.z)	   
		self:ShowHideSmooth("lamps_salon_on_rear"..i-1,train:Animate("LampsFull",train:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)	
		self:ShowHideSmooth("lamps_salon_on_rear1"..i,train:Animate("LampsFull",train:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)	
	end
	
	local ZavodTable = train:GetNW2Int("ZavodTable",1)	
    if not IsValid(train) then return end
    self:ShowHide("Zavod_table_soch",ZavodTable==2)	
    self:ShowHide("Zavod_table_sochl_torec",ZavodTable==2)
	
	local dT = train.DeltaTime
	--Анимация дверей.
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    if not IsValid(train) then return end
	local dT = train.DeltaTime
    for b=0,3 do
        for k=0,2 do
            local st = k==1 and "DoorR" or "DoorL"
            local doorstate = train:GetPackedBool(st)
            local id,sid = st..(b+1),"door"..b.."x"..k
            local state = train:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
					if doorstate then self:PlayOnce(sid.."s","",1,math.Rand(0.9,1.3)) end
                else
					if state > 0 then
                        self:PlayOnce(sid.."o","",1,math.Rand(0.9,1.3))	
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.9,1.3))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*train.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*train.DeltaTime,0,1)
            end
	        self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.9+self.DoorLoopStates[id]*0.1)
            local n_l = "door"..b.."x"..k--.."a"
			local n_r = "door"..b.."x"..k.."b"
            self:Animate(n_r,state,0,1,15,1)
			self:Animate(n_l,state,0,1,15,1)
        end
	end	
	
    if not IsValid(train) then return end
    train.RearLeak = math.Clamp(train.RearLeak + 10*(-train:GetPackedRatio("RearLeak")-train.RearLeak)*dT,0,1)	
    self:SetSoundState("rear_isolation",train.RearLeak,0.9+0.2*train.RearLeak)	

    if not IsValid(train) then return end
    self:Animate("RearBrake", train:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain", train:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)
	
    local dPdT = train:GetPackedRatio("BrakeCylinderPressure_dPdT")
    if not IsValid(train) then return end
    train.ReleasedPdT = math.Clamp(train.ReleasedPdT + 4*(-train:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-train.ReleasedPdT)*dT,0,1)
    self:SetSoundState("release_rear",math.Clamp(train.ReleasedPdT,0,1)^1.65,1.0)
	
	local speed = train:GetPackedRatio("Speed", 0)

    local ventSpeedAdd = math.Clamp(speed/30,0,1)

    local vstate = self:GetPackedBool("Vent2Work")
    if not IsValid(train) then return end
    for i=1,4 do
        local rand = self.VentRand[i]
        local vol = self.VentVol[i]
        local even = i%2 == 0
        local work = (even and v1state or not even and vstate)
        local target = math.min(1,(work and 1 or 0)+ventSpeedAdd*rand*0.4)*2
        if self.VentVol[i] < target then
            self.VentVol[i] = math.min(target,vol + dT/1.5*rand)
        elseif self.VentVol[i] > target then
            self.VentVol[i] = math.max(0,vol - dT/8*rand*(vol*0.3))
        end
        self.VentState[i] = (self.VentState[i] + 10*((self.VentVol[i]/2)^3)*dT)%1
        local vol1 = math.max(0,self.VentVol[i]-1)
        local vol2 = math.max(0,(self.VentVol[i-1] or self.VentVol[i+1])-1)
		
		local VentSound = train:GetNW2Int("VentSound",1)	
		if VentSound==1 then
        self:SetSoundState("vent"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
		elseif
		VentSound==2 then
        self:SetSoundState("vent1"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
		end 	
    end	
	
    self:SetSoundState("bbe", self:GetPackedBool("BBEWork") and 1 or 0, 1)
   
	local door_cab_t = self:Animate("door_cab_t",self:GetPackedBool("RearDoor") and 1 or -0.05, 0, 0.54, 4.5, 0.55) 	
	local door4s = (door_cab_t > 0 or self:GetPackedBool("RearDoor"))
    if self.Door4 ~= door4s then
        self.Door4 = door4s
        self:PlayOnce("RearDoor","bass",door4s and 1 or 0)
    end 
	
    local work = self:GetPackedBool("AnnPlay")
    for k,v in ipairs(self.AnnouncerPositions) do
	if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume(work and (v[4] or 1)  or 0.5)
		end 
	end
	
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end  

function ENT:OnButtonPressed(button)
end
function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    return soundid,location,range,pitch
end 

function ENT:DrawPost(special)
    self.HeadTrain = self:GetNW2Entity("HeadTrain")	
    local train = self.HeadTrain	
    if not IsValid(train) then return end
	self.RTMaterial:SetTexture("$basetexture", train.Tickers)
    self:DrawOnPanel("Tickers_rear",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
end

Metrostroi.GenerateClientProps()