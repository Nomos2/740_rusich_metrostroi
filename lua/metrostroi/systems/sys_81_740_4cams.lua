--------------------------------------------------------------------------------
-- БОИ (Блок Обработки Информации) и БВЗ (Блок Видеозеркал)
--------------------------------------------------------------------------------

-- Надо бы уже вырезать этот DOS и сделать как в оригинале, но многие просили оставить выбор FPS, так что я оставил

Metrostroi.DefineSystem("81_740_4CAMS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.State = -1
	self.Service = 0
	self.Selected = 0
	
	self.Train:LoadSystem("CAMS5","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS6","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS7","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS8","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS9","Relay","Switch",{bass=true})
	self.Train:LoadSystem("CAMS10","Relay","Switch",{bass=true})
	
	
	
	self.TriggerNames = {
		"CAMS5",
		"CAMS6",
		"CAMS7",
		"CAMS8",
		"CAMS9",
		"CAMS10",		
	}

	self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
	end
	--self.Brightness = 100
		
	self.Tbl = {
		[ 5] = {
			[1] = {false,true},
			[2] = {true,false},
		},
		[ 6] = {
			[1] = {false,false},
			[2] = {true,true},
		},
		[ 7] = {
			[1] = {false,false},
			[2] = {true,false},
		},
		[ 8] = {
			[1] = {false,true},
			[2] = {true,true},
		},				
		[ 9] = {
			[1] = {true,false},
		},
		[10] = {
			[1] = {false,false},
		},
	}	
	self.StateTimer = CurTime()
	self.LastEntered = 0
	self.ButtonRing = false
end

function TRAIN_SYSTEM:Outputs()
	--return {"State","ControllerState"}
end

function TRAIN_SYSTEM:Inputs()
	return {"ReservePower"}
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if SERVER then
	function TRAIN_SYSTEM:Trigger(name,value)
		local name = name:gsub("CAMS","")
		local Train = self.Train
		if self.State > -1 and Train:GetNW2Int("CAMSTimer",0)/20 >= 0 then
			if value then
				Train:SetNW2Int("CAMSButton", name)
			else
				Train:SetNW2Int("CAMSButton", nil)
			end
		end
		if self.State == -1 then
			if value then
				local statetimer = Train:GetNW2Int("CAMSTimer",0)/20
				if statetimer > -11.5 and statetimer <= -8.9 then
					self.Service = 1
				end
			end
		end
		if self.State >= 0 and self.Service == 0 then
			if not self.ButtonDelay then
				local numname = tonumber(name) or 0
				if value then
					local WagNum = Train:GetNW2Int("CAMSWagNum")
					if numname >= 5 and (self.LastEntered ~= numname) then
						if self.ButtonSilentInstant then
							self.Cam1,self.Cam1E = true,(self.Tbl[numname][1][2] and Train.WagonList[WagNum] or Train)
							self.Cam2 = false
							Train:SetNW2Bool("CAMSCam1Pos",self.Tbl[numname][1][1])
							Train:SetNW2Entity("CAMSCam2E",nil)
							if self.Tbl[numname][2] then
								self.Cam2,self.Cam2E = self.Cam1,(self.Tbl[numname][2][2] and Train.WagonList[WagNum] or Train)
								Train:SetNW2Entity("CAMSCam2E",self.Cam2E)
								Train:SetNW2Bool("CAMSCam2Pos",self.Tbl[numname][2][1])
							end
							self.Selected = 0
							if self.State ~= 0 then self.State = 0 end
							self.LastEntered = numname
							self.ButtonSilentInstant = false
						else
							self.ButtonDelay = true
							if Train:GetNW2Bool("CAMSBeep",true) == true then
								self.ButtonRing = true
							end
							timer.Simple(0.2,function()
								self.ButtonRing = false
							end)
							timer.Simple(math.Rand(0.7, 1.0),function()
								self.ButtonDelay = false
								if not IsValid(Train) then return end
								self.Cam1,self.Cam1E = true,(self.Tbl[numname][1][2] and Train.WagonList[WagNum] or Train)
								self.Cam2 = false
								Train:SetNW2Bool("CAMSCam1Pos",self.Tbl[numname][1][1])
								Train:SetNW2Entity("CAMSCam2E",nil)
								if self.Tbl[numname][2] then
									self.Cam2,self.Cam2E = self.Cam1,(self.Tbl[numname][2][2] and Train.WagonList[WagNum] or Train)
									Train:SetNW2Entity("CAMSCam2E",self.Cam2E)
									Train:SetNW2Bool("CAMSCam2Pos",self.Tbl[numname][2][1])
								end
								self.Selected = 0
								if self.State ~= 0 then self.State = 0 end
								self.LastEntered = numname
							end)
						end
					end
				end
			end
		end
	end
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		self.Power = (Train.Electric.Battery80V*Train.SF1.Value > 0 or Train.Electric.ReservePower > 0) and Train.SF6.Value > 0.5 --and Train.SFV33.Value > 0.5
		if not self.Power and self.State ~= -4 then self.LastEntered = 0 self.Selected = 0 self.State = -4 self.StateTimer = nil end
		--if self.State == -4 and not self.Power then self.StateTimer = CurTime()+math.Rand(10,12) end
		if self.State == -4 and self.Power then --turned off
			self.State = -3 
			self.StateTimer = CurTime() + 3
			self.Service = 0
		elseif self.Power and self.State == -3 and CurTime()-self.StateTimer > 0 then --no signal screen
			self.State = -2
			self.StateTimer = CurTime() + math.Rand(4.5, 6.5)
		elseif self.Power and self.State == -2 and CurTime()-self.StateTimer > 0 then --ms-dos loading
			Train:SetNW2Int("CAMSButton", nil)
			self.State = -1
			self.StateTimer = CurTime() + 18
		elseif self.State == -1 and CurTime()-self.StateTimer > 0 then --work
			self.State = 0
			self.ButtonSilentInstant = true
			self:Trigger("7", true) --turn on forward cameras
			self:Trigger("7", false)
			
			if Train:GetNW2Int("CAMSWagNum",0) == 0 then
				local wagn = math.min(10,#Train.WagonList)
				Train:SetNW2Int("CAMSWagNum",wagn)
				Train:SetNW2Bool("CAMSLast",Train.WagonList[wagn].WagonNumber > 200)
			end
			if self.Inv == nil then
				self.Inv = Train:GetWagonNumber() > Train.WagonList[#Train.WagonList]:GetWagonNumber()
				Train:SetNW2Bool("CAMSInv",Train:GetWagonNumber() > Train.WagonList[#Train.WagonList]:GetWagonNumber())
			end
		end
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				self:Trigger(v,Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
		if self.State == 0 then --work
			if self.Service == 1 then
				Train:SetNW2String("CAMSScreenService","menu")
				Train:SetNW2String("CAMSTipService"," Camera switching sound")
				self.SelectedService = 1
				self.State = 1
			end
			local cam1,cam2 = false,false
			for i=1,#Train.WagonList do
				local train = Train.WagonList[i]
				if train.SF6 and train.SFV33 and train.Battery.Value*train.SFV33.Value*(train.Electric.KM2 and train.Electric.KM2 or 1)  == 1 then
					if self.Cam1E == train then cam1 = true end
					if self.Cam2E == train then cam2 = true end
				end
			end
			if self.Cam1 == true and (not IsValid(self.Cam1E) or not cam1) then self.Cam1 = false end		
			if self.Cam1 == true then
				Train:SetNW2Bool("CAMSCam1C",true)
				Train:SetNW2Entity("CAMSCam1E",self.Cam1E)
			else
				self.Cam1 = true
				Train:SetNW2Bool("CAMSCam1C",false)
			end
			if self.Cam2 == true and (self.LastEntered > 8 or not IsValid(self.Cam2E) or not cam2) then self.Cam2 = false end	
			
			if self.Cam2 == true then
				Train:SetNW2Bool("CAMSCam2C",true)
				Train:SetNW2Entity("CAMSCam2E",self.Cam2E)
			else
				if self.Cam2 and self.Cam2 ~= true and CurTime()-self.Cam2 > 0 then self.Cam2 = true end
				if not self.Cam2 and cam2 then self.Cam2 = CurTime()+1 end
				
				Train:SetNW2Bool("CAMSCam2C",false)
			end

			local rebootTime = Train:GetNW2Float("CAMSRebootTime", 0)
			if Train:GetNW2Int("CAMSButton", 0) ~= 0 then --rebooting
				if rebootTime > 3.5 then
					Train:SetNW2Float("CAMSRebootTime", 0)
					self.State = -4
				else
					Train:SetNW2Float("CAMSRebootTime", rebootTime + dT)
				end
			else
				if rebootTime ~= 0 then
					Train:SetNW2Float("CAMSRebootTime", 0)
				end
			end
		elseif self.State == 1 then --service
			if Train:GetNW2Int("CAMSButton",0) == 0 then
				self.PressedService = 0
			end
			if Train:GetNW2Int("CAMSButton",0) == 8 and self.SelectedService < 5 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.SelectedService = self.SelectedService+1
				self.PressedService = 1
				if self.SelectedService == 2 then
					Train:SetNW2String("CAMSTipService"," Camera's frames per second")
				elseif self.SelectedService == 3 then
					Train:SetNW2String("CAMSTipService"," Select program language")
				elseif self.SelectedService == 4 then
					Train:SetNW2String("CAMSTipService"," Load Setup Defualts")
				elseif self.SelectedService == 5 then
					Train:SetNW2String("CAMSTipService"," Save and reboot")
				end
			end
			if (Train:GetNW2Int("CAMSButton",0) == 9 or Train:GetNW2Int("CAMSButton",0) == 10) and self.SelectedService == 3 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.PressedService = 1
				if Train:GetNW2String("CAMSLanguage","en") == "ru" then
					Train:SetNW2String("CAMSLanguage","en")
					Train:SetNW2String("CAMSLanguageText","English")
				else
					Train:SetNW2String("CAMSLanguage","ru")
					Train:SetNW2String("CAMSLanguageText","Russian")
				end
			end
			if Train:GetNW2Int("CAMSButton",0) == 10 and self.SelectedService == 2 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.PressedService = 1
				if Train:GetNW2Int("CAMSFPS",05) == 01 then
					Train:SetNW2Int("CAMSFPS",03)
				elseif Train:GetNW2Int("CAMSFPS",05) == 03 then
					Train:SetNW2Int("CAMSFPS",05)
				elseif Train:GetNW2Int("CAMSFPS",05) == 05 then
					Train:SetNW2Int("CAMSFPS",10)
				elseif Train:GetNW2Int("CAMSFPS",05) == 10 then
					Train:SetNW2Int("CAMSFPS",15)
				elseif Train:GetNW2Int("CAMSFPS",05) == 15 then
					Train:SetNW2Int("CAMSFPS",20)
				elseif Train:GetNW2Int("CAMSFPS",05) == 20 then
					Train:SetNW2Int("CAMSFPS",25)
				elseif Train:GetNW2Int("CAMSFPS",05) == 25 then
					Train:SetNW2Int("CAMSFPS",30)
				elseif Train:GetNW2Int("CAMSFPS",05) == 30 then
					Train:SetNW2Int("CAMSFPS",40)
				elseif Train:GetNW2Int("CAMSFPS",05) == 40 then
					Train:SetNW2Int("CAMSFPS",50)
				elseif Train:GetNW2Int("CAMSFPS",05) == 50 then
					Train:SetNW2Int("CAMSFPS",60)
				end
			end
			if Train:GetNW2Int("CAMSButton",0) == 9 and self.SelectedService == 2 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.PressedService = 1
				if Train:GetNW2Int("CAMSFPS",05) == 03 then
					Train:SetNW2Int("CAMSFPS",01)
				elseif Train:GetNW2Int("CAMSFPS",05) == 05 then
					Train:SetNW2Int("CAMSFPS",03)
				elseif Train:GetNW2Int("CAMSFPS",05) == 10 then
					Train:SetNW2Int("CAMSFPS",05)
				elseif Train:GetNW2Int("CAMSFPS",05) == 15 then
					Train:SetNW2Int("CAMSFPS",10)
				elseif Train:GetNW2Int("CAMSFPS",05) == 20 then
					Train:SetNW2Int("CAMSFPS",15)
				elseif Train:GetNW2Int("CAMSFPS",05) == 25 then
					Train:SetNW2Int("CAMSFPS",20)
				elseif Train:GetNW2Int("CAMSFPS",05) == 30 then
					Train:SetNW2Int("CAMSFPS",25)
				elseif Train:GetNW2Int("CAMSFPS",05) == 40 then
					Train:SetNW2Int("CAMSFPS",30)
				elseif Train:GetNW2Int("CAMSFPS",05) == 50 then
					Train:SetNW2Int("CAMSFPS",40)
				elseif Train:GetNW2Int("CAMSFPS",05) == 60 then
					Train:SetNW2Int("CAMSFPS",50)
				end
			end
			if Train:GetNW2Int("CAMSButton",0) == 7 and self.SelectedService == 2 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "language_select" then
				self.SelectedService = 1
				self.PressedService = 1
			end
			if Train:GetNW2Int("CAMSButton",0) == 8 and self.SelectedService == 1 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "language_select" then
				self.SelectedService = 2
				self.PressedService = 1
			end
			if Train:GetNW2Int("CAMSButton",0) == 7 and self.SelectedService > 1 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "fps_select" then
				self.SelectedService = self.SelectedService-1
				self.PressedService = 1
			end
			if Train:GetNW2Int("CAMSButton",0) == 8 and self.SelectedService < 11 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "fps_select" then
				self.SelectedService = self.SelectedService + 1
				self.PressedService = 1
			end
			if Train:GetNW2Int("CAMSButton",0) == 7 and self.SelectedService > 1 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.SelectedService = self.SelectedService-1
				self.PressedService = 1
				if self.SelectedService == 1 then
					Train:SetNW2String("CAMSTipService"," Camera switching sound")
				elseif self.SelectedService == 2 then
					Train:SetNW2String("CAMSTipService"," Camera's frames per second")
				elseif self.SelectedService == 3 then
					Train:SetNW2String("CAMSTipService"," Select program language (not for this utility)")
				elseif self.SelectedService == 4 then
					Train:SetNW2String("CAMSTipService"," Load Setup Defualts")
				end
			end
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.SelectedService == 1 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.PressedService = 1
				if Train:GetNW2Bool("CAMSBeep",false) == false then
					Train:SetNW2Bool("CAMSBeep",true)
				else
					Train:SetNW2Bool("CAMSBeep",false)
				end
			end	
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.SelectedService == 3 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.PressedService = 1
				Train:SetNW2String("CAMSScreenService","language_select")
				if Train:GetNW2String("CAMSLanguage","en") == "ru" then
					self.SelectedService = 1
				else
					self.SelectedService = 2
				end
			end
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.SelectedService == 2 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.PressedService = 1
				Train:SetNW2String("CAMSScreenService","fps_select")
				if Train:GetNW2Int("CAMSFPS",05) == 03 then
					self.SelectedService = 2
				elseif Train:GetNW2Int("CAMSFPS",05) == 05 then
					self.SelectedService = 3
				elseif Train:GetNW2Int("CAMSFPS",05) == 10 then
					self.SelectedService = 4
				elseif Train:GetNW2Int("CAMSFPS",05) == 15 then
					self.SelectedService = 5
				elseif Train:GetNW2Int("CAMSFPS",05) == 20 then
					self.SelectedService = 6
				elseif Train:GetNW2Int("CAMSFPS",05) == 25 then
					self.SelectedService = 7
				elseif Train:GetNW2Int("CAMSFPS",05) == 30 then
					self.SelectedService = 8
				elseif Train:GetNW2Int("CAMSFPS",05) == 40 then
					self.SelectedService = 9
				elseif Train:GetNW2Int("CAMSFPS",05) == 50 then
					self.SelectedService = 10
				elseif Train:GetNW2Int("CAMSFPS",05) == 60 then
					self.SelectedService = 11
				else
					self.SelectedService = 1
				end
			end
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.SelectedService == 1 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "language_select" then
				self.PressedService = 1
				Train:SetNW2String("CAMSScreenService","menu")
				Train:SetNW2Bool("CAMSLanguage","ru")
				Train:SetNW2String("CAMSLanguageText","Russian")
				self.SelectedService = 3
			end
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.SelectedService == 2 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "language_select" then
				self.PressedService = 1
				Train:SetNW2String("CAMSScreenService","menu")
				Train:SetNW2Bool("CAMSLanguage","en")
				Train:SetNW2String("CAMSLanguageText","English")
				self.SelectedService = 3
			end
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "fps_select" then
				self.PressedService = 1
				if self.SelectedService == 1 then
					Train:SetNW2Int("CAMSFPS",01)
				elseif self.SelectedService == 2 then
					Train:SetNW2Int("CAMSFPS",03)
				elseif self.SelectedService == 3 then
					Train:SetNW2Int("CAMSFPS",05)
				elseif self.SelectedService == 4 then
					Train:SetNW2Int("CAMSFPS",10)
				elseif self.SelectedService == 5 then
					Train:SetNW2Int("CAMSFPS",15)
				elseif self.SelectedService == 6 then
					Train:SetNW2Int("CAMSFPS",20)
				elseif self.SelectedService == 7 then
					Train:SetNW2Int("CAMSFPS",25)
				elseif self.SelectedService == 8 then
					Train:SetNW2Int("CAMSFPS",30)
				elseif self.SelectedService == 9 then
					Train:SetNW2Int("CAMSFPS",40)
				elseif self.SelectedService == 10 then
					Train:SetNW2Int("CAMSFPS",50)
				elseif self.SelectedService == 11 then
					Train:SetNW2Int("CAMSFPS",60)
				end
				Train:SetNW2String("CAMSScreenService","menu")
				self.SelectedService = 2
			end
			
			if Train:GetNW2Int("CAMSButton",0) == 5 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "language_select" then
				self.PressedService = 1
				Train:SetNW2String("CAMSScreenService","menu")
				self.SelectedService = 3
			end
			if Train:GetNW2Int("CAMSButton",0) == 5 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "fps_select" then
				self.PressedService = 1
				Train:SetNW2String("CAMSScreenService","menu")
				self.SelectedService = 2
			end
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.SelectedService == 4 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				self.PressedService = 1
				Train:SetNW2Bool("CAMSBeep",true)
				Train:SetNW2Int("CAMSFPS",05)
				Train:SetNW2String("CAMSLanguage",GetConVar("metrostroi_language"):GetString())
				if Train:GetNW2String("CAMSLanguage","en") == "ru" then
					Train:SetNW2String("CAMSLanguageText","Russian")
				else
					Train:SetNW2String("CAMSLanguageText","English")
				end
			end
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "fps_select" then
				self.PressedService = 1
				Train:SetNW2String("CAMSScreenService","menu")
				self.SelectedService = 2
			end
			if Train:GetNW2Int("CAMSButton",0) == 6 and self.SelectedService == 5 and self.PressedService == 0 and Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				timer.Simple( 0.2, function()
					Train:SetNW2String("CAMSTipService","Rebooting...")
					Train:SetNW2String("CAMSScreenService","blank")
				end)
				timer.Simple( 1.5, function() self.State = -4 end)
			end
			
		end
		
		--send values
		Train:SetNW2Int("CAMSSelectedService",self.SelectedService)
		Train:SetNW2Int("CAMSState",self.State)	
		Train:SetNW2Int("CAMSState",self.State)
		Train:SetNW2Int("CAMSService",self.Service)	
		Train:SetNW2Int("CAMSSelected",self.Selected)	
		Train:SetNW2Int("CAMSLastSelected",self.LastSelected or 0)
		Train:SetNW2Int("CAMSLastEntered",self.LastEntered or 0)
		Train:SetNW2Int("CAMSTimer",self.StateTimer and (CurTime()-self.StateTimer)*20 or 0)
		--Train:SetNW2Int("CAMSBrightness",self.Brightness)		
	end
else
	local function createFont(name,font,size,weight,blur,scanlines,underline, antialias)
		surface.CreateFont("Metrostroi_740_"..name, {
			font = font,
			size = size,
			weight = weight or 400,
			blursize = blur or false,
			antialias = antialias,--(name ~= "CAMS2"),
			underline = underline,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = false,
			outline = false,
			extended = true,
			scanlines = scanlines or false,
		})
	end
	createFont("CAMS","Thintel",64,0,0,0,false)
	createFont("CAMS3","PerfectDOSVGA437_fixed",32,0,0,0,false,false)
	createFont("CAMS4","PerfectDOSVGA437_fixed",20,0,0,0,false,true)
	
	local camera_preset_icon = surface.GetTextureID("models/metrostroi_train/81-740/cabine/cam/cam_icon_preset")
	local nosignal = surface.GetTextureID("models/metrostroi_train/81-740/cabine/cam/nosignal_nec")
	local camera_preset_set_icon = surface.GetTextureID("models/metrostroi_train/81-740/cabine/cam/cam_icon_preset_select")
	
	local tbl = {
		[ 5] = {
			[1] = {-1,-1},
			[2] = {-1, 1},
		},
		[ 6] = {
			[1] = { 1,-1},
			[2] = { 1, 1},
		},
		[ 7] = {
			[1] = {-1,-1},
			[2] = { 1,-1},
		},
		[ 8] = {
			[1] = {-1, 1},
			[2] = { 1, 1},
		},				
		[ 9] = {
			[1] = {-1,-1},
		},
		[10] = {
			[1] = { 1,-1},
		},
	}
	
    function TRAIN_SYSTEM:ClientInitialize()
	
        self.Cam1 = self.Train:CreateRT("740CAMSC1",1024,768,true)
        self.Cam2 = self.Train:CreateRT("740CAMSC2",512,768,true)
        self.Cam3 = self.Train:CreateRT("740CAMSC3",512,768,true)
		
		self.scalex,self.scaley = ScrW()/1024,ScrH()/661 --ScrW()/1768*1.725,ScrH()/992*1.5 
		
		--self.scalex,self.scaley = ScrW()/1768*1.725,ScrH()/992*1.5 

		self.Train:SetNW2Bool("CAMSBeep", true)
		self.Train:SetNW2Int("CAMSFPS", 05)
		self.Train:SetNW2String("CAMSLanguage",GetConVar("metrostroi_language"):GetString())
		if self.Train:GetNW2String("CAMSLanguage", "en") == "ru" then
			self.Train:SetNW2String("CAMSLanguageText", "Russian")
		else
			self.Train:SetNW2String("CAMSLanguageText", "English")
		end
		if math.random(1, 200) == 200 then
			self.Train:SetNW2Bool("CAMSCUMS", true)
		else
			self.Train:SetNW2Bool("CAMSCUMS", false)
		end
		self.Train:SetNW2Int("CAMSYear", math.random(2008, 2013))
		self.Train:SetNW2Float("CAMSRebootTime", 0)
    end
    local CamRT = surface.GetTextureID( "pp/rt" )
    local CamRTM = Material( "pp/rt" )
    local CamsPos = Vector(777-144-131,34,-14)
    function TRAIN_SYSTEM:ClientThink()
		if not self.Train:ShouldDrawPanel("CAMS") then return end
		self.scalex,self.scaley = ScrW()/1024,ScrH()/661 --ScrW()/1768*1.725,ScrH()/992*1.5 
	
        local train = self.Train
		local lastenter = train:GetNW2Int("CAMSLastEntered",0) > 8
        local state = train:GetNW2Int("CAMSState",0)
        --local camstate = train:GetNW2Int("CAMSCamState",1)
		--local brightness = train:GetNW2Int("CAMSBrightness",100)
        if state == 0 then
			local Cam1,Cam1E,Cam1Pos = train:GetNW2Bool("CAMSCam1C"),train:GetNW2Entity("CAMSCam1E"),train:GetNW2Bool("CAMSCam1Pos",false)
			local Cam2,Cam2E,Cam2Pos = train:GetNW2Bool("CAMSCam2C"),train:GetNW2Entity("CAMSCam2E"),train:GetNW2Bool("CAMSCam2Pos",false)		
			
            if Cam1 and not Cam2 and lastenter then
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam1",1/train:GetNW2Int("CAMSFPS",05),self.Cam1,Cam1E,Vector(760-144-131,-75,60)+(Cam1Pos and Vector(0,144,0) or Vector(0,0,0)),Angle(10,180,0),1024,768,1,1,1)
			end
            if Cam1 then
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam3",1/train:GetNW2Int("CAMSFPS",05),self.Cam2,Cam1E,Vector(760-144-131,-70,60)+(Cam1Pos and Vector(0,144,0) or Vector(0,0,-1)),Angle(5,180,0),1024,768,1,1,1)
			end
			if Cam2 then
				Metrostroi.RenderCamOnRT(train,CamsPos,"Cam2",1/train:GetNW2Int("CAMSFPS",05),self.Cam3,Cam2E,Vector(760-144-131,-75,60)+(Cam2Pos and Vector(0,144,0) or Vector(0,0,0)),Angle(5,180,0),1024,768,1,1,1)
			end		
        end
		
		if self.state ~= -3 then	
			render.SetColorMaterial(0,0,0) 
			render.PushRenderTarget(self.Train.CAMS,0,0,1024,768)
			cam.Start2D()
			surface.SetDrawColor(0,0,0)
			surface.DrawRect(0,0,1024,768)
			self:CAMS(self.Train)	
			cam.End2D()
			render.PopRenderTarget()
		end
		self.state = state
	end
	local blue = Color(0,0,255)
	local shadow_blue = Color(0,0,127)
	local white = Color(255,255,255)
	local yellow = Color(255,255,0)
	local black = Color(0,0,0)
	
	local gray = Color(200, 200, 200)
	local magenta = Color(255, 0, 255)
	local red = Color (255,0,0)
	local green = Color (0,255,0)
	local cyan = Color (0,255,255)
	
	
	local font = "Metrostroi_740_CAMS"
	function TRAIN_SYSTEM:CAMS(Train)
		local scx,scy = self.scalex,self.scaley
		local state = Train:GetNW2Int("CAMSState",0)
		local service  = Train:GetNW2Int("CAMSService",0)
		local sel = Train:GetNW2Int("CAMSSelected",0)
		local wagnum = Train:GetNW2Int("CAMSWagNum",0)
		local statetimer = Train:GetNW2Int("CAMSTimer",0)/20
		local lastenter = Train:GetNW2Int("CAMSLastEntered",0) > 8
		local cum = Train:GetNW2Bool("CAMSCUMS",false)
		--RunConsoleCommand("say",statetimer)

		if state == -4 or state == -5 then
			surface.SetDrawColor(0,0,0)
			surface.DrawRect(0,0,1024,768)
		end
		--state = -3
		surface.SetDrawColor(Color(255,255,255))		
		if state == -3 then
			surface.SetDrawColor(21,21,21)
			surface.DrawRect(0,0,1024,768)
			--draw.SimpleText("полосочки",font,512,368,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
		elseif state == -2 then
			--draw.SimpleText("пингивинчики",font,512,368,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
			surface.SetTexture(nosignal)
			surface.DrawTexturedRectRotated(512,384,1024,768,0)
			--surface.DrawTexturedRectRotated(158,64,128,128,0)
		
		elseif state == -1 then
			--for i=1,48 do
				--draw.SimpleText(i,font.."2",15,0+i*16,white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
			--end
			surface.SetDrawColor(2,2,2)
			surface.DrawRect(0,0,1024,768)
			local y = 16
			local x = 5
			if statetimer > -17.15 and statetimer < -0.5 then
				surface.SetDrawColor(21,21,21)
				surface.DrawRect(0,0,1024,768)
			end
			if statetimer > -16.3 and statetimer < -0.5 then
				draw.SimpleText("CMOS battery failed",font.."4",1,1,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				y=20
			end
			if statetimer > -16 and statetimer < -0.5 then
				draw.SimpleText("Booting from drive C...",font.."4",1,40,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("Starting MS-DOS...",font.."4",1,60,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				y=100
			end
			if statetimer > -14.2 and statetimer < -0.5 then
				draw.SimpleText("HIMEM is testing extended memory...",font.."4",1,100,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				y=100
				x=393
			end
			if statetimer > -12 and statetimer < -0.5 then
				draw.SimpleText("done.",font.."4",391,100,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=5
				y=120
			end
			if statetimer > -11.5 and statetimer < -0.5 and service == 0 then
				draw.SimpleText("Press any key to run Setup",font.."4",1,140,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=287
				y=140
			end
			if statetimer > -11.5 and statetimer < -0.5 and service == 1 then
				draw.SimpleText("Entering setup...",font.."4",1,140,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=188
				y=140
			end
			if statetimer > -8.9 and statetimer < -0.5 then
				draw.SimpleText("Starting systems...",font.."4",1,180,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=146
				y=180
			end
			
			if statetimer > -8.7 and statetimer < -0.5 then
				if cum then
					draw.SimpleText("╔═══════════════════════════════════════════════════════════╗",font.."4",1,200,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("║ █▀▀█ █  █ █▀▄▀█  █▀▀▀█ █   █ █▀▀▀█ ▀▀█▀▀ █▀▀▀ █▀▄▀█ █▀▀▀█ ║",font.."4",1,220,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("║ █    █  █ █ █ █  ▀▀▀▄▄ █▄▄▄█ ▀▀▀▄▄   █   █▀▀▀ █ █ █ ▀▀▀▄▄ ║",font.."4",1,240,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("║ █▄▄█ █▄▄█ █   █  █▄▄▄█   █   █▄▄▄█   █   █▄▄▄ █   █ █▄▄▄█ ║",font.."4",1,260,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("╚═══════════════════════╕Version CUM╒═══════════════════════╝",font.."4",1,280,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					x=1
					y=300
				else
					draw.SimpleText("╔═══════════════════════════════════════════════════════════╗",font.."4",1,200,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("║ █▀▀█ █▀▀█ █▀▄▀█  █▀▀▀█ █   █ █▀▀▀█ ▀▀█▀▀ █▀▀▀ █▀▄▀█ █▀▀▀█ ║",font.."4",1,220,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("║ █    █▄▄█ █ █ █  ▀▀▀▄▄ █▄▄▄█ ▀▀▀▄▄   █   █▀▀▀ █ █ █ ▀▀▀▄▄ ║",font.."4",1,240,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("║ █▄▄█ █  █ █   █  █▄▄▄█   █   █▄▄▄█   █   █▄▄▄ █   █ █▄▄▄█ ║",font.."4",1,260,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("╚═══════════════════════╕Version 3.3╒═══════════════════════╝",font.."4",1,280,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					x=1
					y=300
				end
			end
			if statetimer > -8.0 and statetimer < -0.5 then
				draw.SimpleText("CAM1...",font.."4",1,320,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=92
				y=320
			end
			if statetimer > -7.97 and statetimer < -0.5 then
				draw.SimpleText("OK!",font.."4",81,320,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=120
				y=320
			end
			if statetimer > -7.95 and statetimer < -0.5 then
				draw.SimpleText("CAM2..." ,font.."4",1,340,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=92
				y=340
			end
			if statetimer > -7.93 and statetimer < -0.5 then
				draw.SimpleText("OK!",font.."4",81,340,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=120
				y=340
			end
			if statetimer > -7.90 and statetimer < -0.5 then
				draw.SimpleText("CAM3...",font.."4",1,360,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=92
				y=360
			end
			if statetimer > -7.87 and statetimer < -0.5 then
				draw.SimpleText("OK!",font.."4",81,360,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=120
				y=360
			end
			if statetimer > -7.85 and statetimer < -0.5 then
				draw.SimpleText("CAM4...",font.."4",1,380,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=92
				y=380
			end

			if statetimer > -7.82 and statetimer < -0.5 then
				draw.SimpleText("OK!",font.."4",81,380,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=120
				y=380
			end
			if statetimer > -5 and statetimer < -0.5 then
				draw.SimpleText("Preparing GUI...",font.."4",1,400,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=179
				y=400
			end
			if statetimer > -0.9 and statetimer < -0.5 then
				draw.SimpleText("Starting GUI...",font.."4",1,420,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				x=169
				y=420
			end
			
			if statetimer > -0.5 and statetimer < -0.1 then
				surface.SetDrawColor(2,2,2)
				surface.DrawRect(0,0,1024,768)
			end
			if statetimer > -0.1 and statetimer < 0.0 then
				surface.SetDrawColor(21,21,21)
				surface.DrawRect(0,0,1024,768)
			end
			
			if CurTime()%1 < 0.5 and statetimer > -17 and statetimer < -0.5 then
				draw.SimpleText("_",font.."4",x,y,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
			end			
			--local text = 
		elseif state == 0 then	

			local LastEntered = Train:GetNW2Int("CAMSLastEntered",0)
			local Cam1,Cam1E,Cam1Pos = Train:GetNW2Bool("CAMSCam1C"),Train:GetNW2Entity("CAMSCam1E"),Train:GetNW2Bool("CAMSCam1Pos",false)
			local Cam2,Cam2E,Cam2Pos = Train:GetNW2Bool("CAMSCam2C"),Train:GetNW2Entity("CAMSCam2E"),Train:GetNW2Bool("CAMSCam2Pos",false)
			surface.SetDrawColor(21,21,21)
			surface.DrawRect(0,0,1024,768)
			if not IsValid(Cam2E) then
				if Cam1 and not Cam2 and lastenter then
					render.DrawTextureToScreenRect(self.Cam1,scx*1024,0,-1024*scx,768*scy)				
				end				
			elseif Cam1 or Cam2 then
				if LastEntered == 8 then
					if Cam2 then render.DrawTextureToScreenRect(self.Cam3,scx*512,0,scx*512,scy*768) end				
					if Cam1 then render.DrawTextureToScreenRect(self.Cam2,0,0,scx*512,scy*768) end		
				elseif LastEntered == 6 then
					if Cam2 then render.DrawTextureToScreenRect(self.Cam3,scx*512,0,512*scx,768*scy) end
					if Cam1 then render.DrawTextureToScreenRect(self.Cam2,scx*512,0,-512*scx,768*scy) end
				else
					if Cam2 then render.DrawTextureToScreenRect(self.Cam3,scx*512,0,-512*scx,scy*768) end
					if Cam1 then render.DrawTextureToScreenRect(self.Cam2,scx*(1024+(LastEntered == 5 and -512 or 0)),0,-512*scx*(LastEntered == 5 and -1 or 1),768*scy) end
				end
			end
			
			surface.SetDrawColor(white)
			surface.SetTexture(camera_preset_icon)
			surface.DrawTexturedRectRotated(90,680,64,128,0)

			if sel == 0 and (Cam1 or Cam2) then
				surface.SetTexture(camera_preset_set_icon)
				surface.DrawTexturedRectUV(74+tbl[LastEntered][1][1]*18.5,664+tbl[LastEntered][1][2]*27.5,32,32,0,0,-tbl[LastEntered][1][1],-tbl[LastEntered][1][2],1)
				--surface.DrawTexturedRectUV(89+(Cam1Pos and -18.5 or 18.5)*(Train == Cam1E and 1 or -1),104+(Cam1Pos and -1 or 1)*(Train == Cam1E and -27.5 or 27.5)*(Train:GetNW2Int("CAMSLastEntered",0) == 9 and -1 or 1),32,32,0,0,(Cam1Pos and 1 or -1)*(Train == Cam1E and 1 or -1),Train == Cam1E and 1 or -1)

				if not lastenter then
					surface.SetTexture(camera_preset_set_icon)
					surface.DrawTexturedRectUV(74+tbl[LastEntered][2][1]*18.5,664+tbl[LastEntered][2][2]*27.5,32,32,0,0,-tbl[LastEntered][2][1],-tbl[LastEntered][2][2],1)					
					--surface.DrawTexturedRectUV(89+(Cam2Pos and -18.5 or 18.5)*(Train == Cam2E and 1 or -1),104+(Cam2Pos and -1 or 1)*(Train == Cam2E and 27.5 or -27.5),32,32,0,0,(Cam2Pos and 1 or -1)*(Train == Cam2E and 1 or -1),Train == Cam2E and 1 or -1)
				end
			end
			
		elseif state == 1 and service == 1 then
			
			--начинается кромешный пиздец, но так строится псевдографика
			if statetimer > 0 then
			
				--background
				for i=1,23 do
					draw.SimpleText("█████████████████████████████████████████████████████████",font.."3",0,i*32,blue,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					--draw.SimpleText("123456789123456789123456789123456789123456789123456789123",font.."3",0,i*32,blue,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				end
				
				--title and tip background
				draw.SimpleText("█████████████████████████████████████████████████████████",font.."3",0,0,gray,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("█████████████████████████████████████████████████████████",font.."3",0,736,gray,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				
				--title and tip text
				draw.SimpleText("CAM SYSTEMS SETUP             ООО \"МЕТРОКОМ-М\" (C) "..Train:GetNW2Int("CAMSYear",2008),font.."3",18,0,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText(Train:GetNW2String("CAMSTipService"),font.."3",0,736,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				
				--main menu
				if Train:GetNW2String("CAMSScreenService","menu") == "menu" then
				
					--window shadow
					draw.SimpleText(" ███████████████████████████████",font.."3",232,608,shadow_blue,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					for i=1,13 do
						draw.SimpleText("                               █",font.."3",232,192+32*i,shadow_blue,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					end
					
					--window background
					for i=0,12 do
						draw.SimpleText("███████████████████████████████",font.."3",232,192+32*i,red,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					
					--window borders
					draw.SimpleText("┌─────────────────────────────┐",font.."3",232,192,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					for i=1,11 do
						draw.SimpleText("│                             │",font.."3",232,192+32*i,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					end
					draw.SimpleText("├─────────────────────────────┤",font.."3",232,256,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					draw.SimpleText("└─────────────────────────────┘",font.."3",232,576,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					
					
					
					--window title
					draw.SimpleText("          Service menu",font.."3",232,224,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					
					
					
					--settings
					if Train:GetNW2Int("CAMSSelectedService",0) == 1 then
						draw.SimpleText("    ███████████",font.."3",232,320,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						if Train:GetNW2Bool("CAMSBeep",false) == false then
							draw.SimpleText("    ( ) Speaker",font.."3",232,320,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						else
							draw.SimpleText("    (*) Speaker",font.."3",232,320,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						end
					else
						if Train:GetNW2Bool("CAMSBeep",false) == false then
							draw.SimpleText("    ( ) Speaker",font.."3",232,320,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						else
							draw.SimpleText("    (*) Speaker",font.."3",232,320,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						end
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 2 then
						draw.SimpleText("    ████████████████",font.."3",232,384,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						if Train:GetNW2Int("CAMSFPS", 05) < 10 then
							draw.SimpleText("    Camera FPS: [0"..Train:GetNW2Int("CAMSFPS",05).."]",font.."3",232,384,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						else
							draw.SimpleText("    Camera FPS: ["..Train:GetNW2Int("CAMSFPS",05).."]",font.."3",232,384,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						end
					else
						if Train:GetNW2Int("CAMSFPS", 05) < 10 then
							draw.SimpleText("    Camera FPS: [0"..Train:GetNW2Int("CAMSFPS",05).."]",font.."3",232,384,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						else
							draw.SimpleText("    Camera FPS: ["..Train:GetNW2Int("CAMSFPS",05).."]",font.."3",232,384,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						end
					end
					
					if Train:GetNW2Int("CAMSSelectedService",0) == 3 then
						draw.SimpleText("    ███████████████████",font.."3",232,416,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("    Language: ["..Train:GetNW2String("CAMSLanguageText","Japaneese").."]",font.."3",232,416,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("    Language: ["..Train:GetNW2String("CAMSLanguageText","Japaneese").."]",font.."3",232,416,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					end
					
					if Train:GetNW2Int("CAMSSelectedService",0) == 4 then
						draw.SimpleText("    ███████████████████",font.."3",232,480,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("    Load Setup Defualts",font.."3",232,480,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("    Load Setup Defualts",font.."3",232,480,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					end
					
					if Train:GetNW2Int("CAMSSelectedService",0) == 5 then
						draw.SimpleText("    ███████████████",font.."3",232,512,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("    Save and reboot",font.."3",232,512,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("    Save and reboot",font.."3",232,512,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					end
				end
				
				if Train:GetNW2String("CAMSScreenService","menu") == "blank" then
				
				end
				
				if Train:GetNW2String("CAMSScreenService","menu") == "language_select" then
					--background
					for i=0,3 do
						draw.SimpleText("██████████████",font.."3",376,352+32*i,red,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					draw.SimpleText(" ██████████████",font.."3",376,480,shadow_blue,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					for i=1,3 do
						draw.SimpleText("              █",font.."3",376,352+32*i,shadow_blue,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					end
					
					--borders
					draw.SimpleText("┌─          ─┐",font.."3",376,352,gray,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					draw.SimpleText("└────────────┘",font.."3",376,448,gray,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					for i=0,1 do
						draw.SimpleText("│            │",font.."3",376,384+32*i,gray,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					draw.SimpleText("   Language",font.."3",376,352,gray,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					if Train:GetNW2Int("CAMSSelectedService",0) == 1 then
						draw.SimpleText("   ███████",font.."3",376,384,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   Russian ",font.."3",376,384,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   Russian ",font.."3",376,384,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 2 then
						draw.SimpleText("   ███████",font.."3",376,416,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   English ",font.."3",376,416,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   English ",font.."3",376,416,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
				end
				
				if Train:GetNW2String("CAMSScreenService","menu") == "fps_select" then
					--background
					for i=0,12 do
						draw.SimpleText("█████████████",font.."3",394,160+32*i,red,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					
					draw.SimpleText(" █████████████",font.."3",394,576,shadow_blue,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					for i=1,12 do
						draw.SimpleText("             █",font.."3",394,160+32*i,shadow_blue,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					end
					
					--borders
					draw.SimpleText("┌─         ─┐",font.."3",394,160,gray,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					draw.SimpleText("└───────────┘",font.."3",394,544,gray,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					for i=1,11 do
						draw.SimpleText("│           │",font.."3",394,160+32*i,gray,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					draw.SimpleText("   CAM FPS",font.."3",394,160,gray,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					if Train:GetNW2Int("CAMSSelectedService",0) == 1 then
						draw.SimpleText("   ██",font.."3",394,192,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   01 ",font.."3",394,192,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   01 ",font.."3",394,192,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 2 then
						draw.SimpleText("   ██",font.."3",394,224,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   03 ",font.."3",394,224,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   03 ",font.."3",394,224,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 3 then
						draw.SimpleText("   ██",font.."3",394,256,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   05",font.."3",394,256,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   05",font.."3",394,256,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 4 then
						draw.SimpleText("   ██",font.."3",394,288,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   10 ",font.."3",394,288,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   10 ",font.."3",394,288,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 5 then
						draw.SimpleText("   ██",font.."3",394,320,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   15 ",font.."3",394,320,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   15 ",font.."3",394,320,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 6 then
						draw.SimpleText("   ██",font.."3",394,352,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   20 ",font.."3",394,352,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   20 ",font.."3",394,352,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 7 then
						draw.SimpleText("   ██",font.."3",394,384,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   25 ",font.."3",394,384,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   25 ",font.."3",394,384,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 8 then
						draw.SimpleText("   ██",font.."3",394,416,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   30 ",font.."3",394,416,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   30 ",font.."3",394,416,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 9 then
						draw.SimpleText("   ██",font.."3",394,448,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   40 ",font.."3",394,448,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   40 ",font.."3",394,448,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					if Train:GetNW2Int("CAMSSelectedService",0) == 10 then
						draw.SimpleText("   ██",font.."3",394,480,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   50 ",font.."3",394,480,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   50 ",font.."3",394,480,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
					
					if Train:GetNW2Int("CAMSSelectedService",0) == 11 then
						draw.SimpleText("   ██",font.."3",394,512,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
						draw.SimpleText("   60 ",font.."3",394,512,black,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					else
						draw.SimpleText("   60 ",font.."3",394,512,white,TEXT_ALIGN_left,TEXT_ALIGN_LEFT)
					end
				end
					
				--control tip background
				if Train:GetNW2Int("CAMSButton",0) == 7 then
					draw.SimpleText(" █ ",font.."3",18,576,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				else
					draw.SimpleText(" █ ",font.."3",18,576,gray,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				end
				
				if Train:GetNW2Int("CAMSButton",0) == 10 then
					draw.SimpleText("  █",font.."3",18,608,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				else
					draw.SimpleText("  █",font.."3",18,608,gray,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				end
				if Train:GetNW2Int("CAMSButton",0) == 6 then
					draw.SimpleText("  █",font.."3",18,640,green,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				else
					draw.SimpleText("  █",font.."3",18,640,gray,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				end

				if Train:GetNW2Int("CAMSButton",0) == 5 then
					draw.SimpleText("█  ",font.."3",18,640,red,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				else
					draw.SimpleText("█  ",font.."3",18,640,gray,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				end
				if Train:GetNW2Int("CAMSButton",0) == 9 then
					draw.SimpleText("█  ",font.."3",18,608,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				else
					draw.SimpleText("█  ",font.."3",18,608,gray,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				end
				if Train:GetNW2Int("CAMSButton",0) == 8 then
					draw.SimpleText(" █ ",font.."3",18,672,white,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				else
					draw.SimpleText(" █ ",font.."3",18,672,gray,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				end
				
				--control tip symbols
				draw.SimpleText(" ↑ ",font.."3",18,576,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("- +",font.."3",18,608,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText("X √",font.."3",18,640,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText(" ↓ ",font.."3",18,672,black,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
					
				
				
			end
		end
	end
end