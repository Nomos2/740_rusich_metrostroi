--------------------------------------------------------------------------------
-- Блок Управления и Контроля Поезда (Витязь)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_740_4VITYAZ")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("VityazNoth","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazNext","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF4","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz1","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz4","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz7","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz2","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz5","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz8","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz0","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz3","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz6","Relay","Switch",{bass=true})
    self.Train:LoadSystem("Vityaz9","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF5","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF6","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazBack","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF7","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazT","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazCurrent","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazNum","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazSOT","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazVO","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF8","Relay","Switch",{bass=true})
    self.Train:LoadSystem("VityazF9","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazPVU","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazUTV","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazTV1","Relay","Switch",{bass=true})
	self.Train:LoadSystem("VityazTV2","Relay","Switch",{bass=true})
	self.TriggerNames = {
        "Vityaz1",
        "Vityaz2",
        "Vityaz3",
        "Vityaz4",
        "Vityaz5",
        "Vityaz6",
        "Vityaz7",
        "Vityaz8",
        "Vityaz9",
        "VityazF5",
		"Vityaz0",
		"VityazF9",
		
		"VityazF4",
		"VityazPVU",
		"VityazVO",
		"VityazT",
		"VityazCurrent",
		"VityazSOT",
		"VityazF2",
		"VityazNum",
		
        "VityazF6",
        "VityazF7",
		"VityazNext",
		"VityazBack",
		
		"VityazUTV",
		"VityazTV1",
		"VityazTV2",
		"VityazNoth",
		"VityazF8",
		
        "AttentionMessage"
    }
	self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		if self.Train[v] then self.Triggers[v] = self.Train[v].Value > 0.5 end
	end
	self.State = 0
	self.State2 = 0
    self.WrongPassword = false
	self.Trains = {}
	self.Errors = {}
	self.Error = 0
	self.Counter = 0
	self.Brightness = 5
	self.OldVersion = true
	
	self.ProstExchTimer = math.random(1024,3072)

	self.Recuperation = true

	self.Password = ""
	
	self.Klimat1Mode = false -- os.date("%b") == "Nov" or os.date("%b") == "Dec" or os.date("%b") == "Jan" or os.date("%b") == "Feb" or os.date("%b") == "Mar" -- true/false  зима/лето
	self.Klimat2Mode = false -- os.date("%b") == "Nov" or os.date("%b") == "Dec" or os.date("%b") == "Jan" or os.date("%b") == "Feb" or os.date("%b") == "Mar"
	-- Переключается по комиссионному смотру по указу начальства
	-- с зимним режимом можно кататься хоть до марта, хоть до мая
	-- ПОЭТОМУ ВЫСТАВЛЯЙТЕ САМИ, ЧТОБЫ ЖИЗНЬ МЁДОМ НЕ КАЗАЛАСЬ МУХАХАХАХАХАХАХ
	
	self.PrOstVersion = false -- рандом мб потом на старую/новую (2022 г) версию когда инфа появится

	self.Selected = 0
	
	self.Date = os.date("%d".."%m")
    self.Time = os.date("%H".."%M")
	self.RouteNumber = "0"
	self.WagNum = 0
	self.DepotCode = "0"
	self.DepeatStation = "0"
	self.Path = "0"
	self.Dir = "0"
	self.Deadlock = "0"
	self.BTB = false

	--self.TestPUType = math.random() > 0.3 and 1 or 2

	self.Compressor = false

	self.BlockLeft = true
	self.BlockRight = true
	self.States = {}

	self.PVU = {}
	
	self.AutoStart = false

	self.Prost = false
	self.Kos = false
	self.Ovr = false
	
	self.EnginesStrength = 0
	self.ControllerState = 0
end

function TRAIN_SYSTEM:Outputs()
	return {"State","ControllerState","Prost","Kos"}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "OldVersion" then
		self.OldVersion = value
	end
end
if SERVER then
	function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
		if not self.Trains[sourceid] then return end
		if textdata == "Get" then
			self.Reset = 1
		else
			self.Trains[sourceid][textdata] = numdata
		end
	end
	function TRAIN_SYSTEM:CState(name,value,target,bypass)
		if self.Reset or self.States[name] ~= value or bypass then
			self.States[name] = value
			for i=1,self.WagNum do
				self.Train:CANWrite("BUKP",self.Train:GetWagonNumber(),target or "BUV",self.Trains[i],name,value)
			end
		end
	end

	function TRAIN_SYSTEM:CStateTarget(name,targetname,targetsys,targetid,value)
		if self.Reset or self.States[name] ~= value or bypass then
			self.States[name] = value
			self.Train:CANWrite("BUKP",self.Train:GetWagonNumber(),targetsys,targetid,targetname,value)
		end
	end

	TRAIN_SYSTEM.VityazPass = "2002"
	TRAIN_SYSTEM.Checks = {
		KAH=false,ALS=false,Ring=false,
		DoorSelectL=false,DoorSelectR=false,
		DoorBlock=false, DoorClose=false,AttentionMessage=false,Attention=false,AttentionBrake=false,
		DoorLeft=false, DoorRight=false, AccelRate = false, Stand = false,
		Pant1=false,Pant2=false,Vent2=false,PassLight=false,
		TorecDoors=false,BBE=false,Compressor=false
	}

	function TRAIN_SYSTEM:Trigger(name,value)
		local Train = self.Train
		local char = name:gsub("Vityaz","");char = tonumber(char)
		if self.State == -3 then
			if not self.CountOfTriggers then self.CountOfTriggers = 0 end
			for k,v in pairs(self.TriggerNames) do
				if name == v then
					Train:SetNW2Bool("VityazMNMM"..k,value)
					self.CountOfTriggers = self.CountOfTriggers + 1
					Train:SetNW2Int("VityazCountOfTriggers",self.CountOfTriggers)
				end
			end
			--Train:SetNW2Int("PUType",self.TestPUType)
		elseif self.State == 1 then
			if name == "VityazF5" and value then self.Password = self.Password:sub(1,-2) end
			if name == "VityazF8" and value then
				if self.Password == self.VityazPass then
					self.State = 2
					self.WrongPassword = false
					self.Selected = 0
				else
					self.Password = ""
                    self.WrongPassword = false
				end
			end
			if char and #self.Password < 4 and value then self.Password = self.Password..char end
			Train:SetNW2String("VityazPass",self.Password)
		elseif self.State == 2 then
			if self.State2 == 0 then
				if self.Entering then
					local num = (self.Selected==1 or self.Selected==2) and 4 or (self.Selected==8 or self.Selected==9) and 1 or self.Selected==6 and 3 or 2
					if name == "VityazF8" and value and #self.Entering == num then
						if self.Selected == 1 then self.Date = self.Entering end
						if self.Selected == 2 then self.Time = self.Entering end
						if self.Selected == 3 then self.RouteNumber = self.Entering end
						if self.Selected == 4 and tonumber(self.Entering) < 10 then self.WagNum = tonumber(self.Entering) end
						if self.Selected == 6 then self.DepotCode = self.Entering end
						if self.Selected == 7 then self.DepeatStation = self.Entering end
						if self.Selected == 8 then self.Path = self.Entering end
						if self.Selected == 9 then self.Dir = self.Entering end
						self.Entering = false
					end
					if name == "VityazF9" and value then
						self.Entering = false
					end
					if char and value then
						if char and #self.Entering < num and value then
							self.Entering = self.Entering..char
						end
					end
					if name == "VityazF5" and value then self.Entering = self.Entering:sub(1,-2) end
				else
					if name == "VityazF6" and value and self.Selected > 0 then
						self.Selected = self.Selected - 1
					end
					if name == "VityazF7" and value and self.Selected < 9 then
						self.Selected = self.Selected + 1
					end
					if name == "VityazF8" and value and self.WagNum > 0 then
						self.State = 3
						for i=1,self.WagNum do
							Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUV",self.Trains[i],"Orientate",i%2 > 0)
						end
					end
					if name == "VityazF9" and value then
						if self.Selected == 0 then self.State2 = 1 self.Selected = 0 end
						if self.Selected > 0 then self.Entering = "" end
					end
				end
			elseif self.State2 == 1 then
				if name == "VityazF8" and value then
					if self.Entering and #self.Entering == 4 then
						local wagnum = tonumber(self.Entering)
						self.Trains[wagnum] = {}
						if not wagnum or wagnum == 0 then
							self.Trains[wagnum] = nil
							wagnum = nil
						end
						self.Trains[self.Selected+1] = wagnum
						self.Entering = false
					elseif not self.Entering then
						self.State2 = 0
						self.Selected = 0
					end
				end
				if name == "VityazF9" and value then
					if self.Entering then
							self.Entering = false
					else
						self.Entering = ""
					end
				end
				if self.Entering then
					if name == "VityazF5" and value then self.Entering = self.Entering:sub(1,-2) end
					if char and #self.Entering < 4 and value then
						self.Entering = self.Entering..char
					end
					Train:SetNW2String("VityazEnter",self.Entering)
				else
					if name == "VityazF6" and value and self.Selected > 0 then
						self.Selected = self.Selected - 1
					end
					if name == "VityazF7" and value and self.Selected < 8 then
						self.Selected = self.Selected + 1
					end
				end
			end
		elseif self.State == 3 and name == "VityazF8" and value then
			self.State = 2
		elseif self.State == 4 and name == "VityazF8" and value then
			self.Prost = true
			self.Kos = true
			self.Ovr = true
			self.State = 5
			self.State2 = 0
			self.Errors = {}
		elseif self.State == 5 and self.State2 == 0 and value then
			--[[if self.Prost and name == "VityazBack" and value then
				self.Prost = false
				self.Kos = 	false
			elseif not self.Prost and name == "VityazBack" and value then
				self.Prost = true
				self.Kos = 	true
			end]]
			-- Контрастность
			if not self.OldVersion and self.Brightness < 5 and name == "VityazF6" and value then
				self.Brightness = self.Brightness + 1
			end
			if not self.OldVersion and self.Brightness > 1 and name == "VityazF7" and value then
				self.Brightness = self.Brightness - 1
			end
			if self.ProstCanEnDis and char then
				if char == 3 then
					self.Prost = not self.Prost
					self.Kos = 	self.Prost
					self.ProstCanEnDis = nil
				elseif char == 9 then
					self.Prost = self.Kos and not self.Prost
					self.ProstCanEnDis = nil
				end
			elseif not self.ProstCanEnDis and char == 9 then
				self.State2 = 4 
				self.Selected = 1
			end
			if (name == "VityazF8" and value) then
				self.ProstCanEnDis = true
			else
				self.ProstCanEnDis = nil
			end

		elseif self.State == 5 and self.State2 == 2 and value then
			if name == "VityazF6" and self.Selected > 0 then
				self.Selected = self.Selected - 1
			end
			if name == "VityazF7" and self.Selected < 1 then
				self.Selected = self.Selected + 1
			end
		elseif self.State == 5 and self.State2 == 4 and value then
			if name == "VityazF6" and self.Selected > -1 then
				self.Selected = self.Selected - 1
				if self.Selected == -1 then
					self.State2 = 5
				end
			end
			if name == "VityazF7" and self.Selected < 4 then
				self.Selected = self.Selected + 1
				if self.Selected == 4 then
					self.State2 = 5
				end
			end
			if name == "VityazF2" and self.Selected == 2 and self.Klimat1Mode then 
				self.Klimat1Mode = false
			elseif name == "VityazF2" and self.Selected == 2 and not self.Klimat1Mode then
				self.Klimat1Mode = true
			end
			if name == "VityazF2" and self.Selected == 3 and self.Klimat2Mode then 
				self.Klimat2Mode = false
			elseif name == "VityazF2" and self.Selected == 3 and not self.Klimat2Mode then
				self.Klimat2Mode = true
			end
		elseif self.State == 5 and self.State2 == 5 and value then
			if name == "VityazF6" then
				self.State2 = 4
				self.Selected = 3
			end
			if name == "Vityaz9" then
				self.State2 = 4
				self.Selected = 1
			end
			if name == "VityazF7" then
				self.State2 = 4
				self.Selected = 0
			end
		elseif self.State == 5 and self.State2 == 6 and value then
			local train = self.Trains[self.Selected]
			if not self.PVU[train] then self.PVU[train] = {} end
			if char then self.PVU[train][char] = not self.PVU[train][char] end
			if name == "VityazF6" and self.Selected > 1 then
				self.Selected = self.Selected - 1
			end
			if name == "VityazF7" and self.Selected < self.WagNum then
				self.Selected = self.Selected + 1
			end
		end
		if self.State == 5 and self.State2 >= 0 and value then
			if self.WagNum <= 5 then
				if name == "VityazF4" then
					self.State2 = 0
				end
				
				--if name == "VityazF2" then self.State2 = 4 end
				
				if name == "Vityaz2" and self.State2 ~= 6 then self.State2 = 5 end
				if name == "VityazT" then self.State2 = 1 end
				if name == "VityazCurrent" then self.State2 = 2 self.Selected = 0 end
				if name == "VityazVO" then self.State2 = 4 self.Selected = 0 end
				if name == "Vityaz9" and self.ProstCanEnDis then self.State2 = 4 self.Selected = 1 end
				if name == "VityazPVU" then self.State2 = 6 self.Selected = 1 end
				if name == "VityazTV1" or name == "VityazTV2" then self.State = 6 self.PrevState2 = self.State2 end 
				if name == "VityazNum" then self.State2 = 0 end
				if name == "VityazSOT" then self.State2 = 3 end
				if self.State2 ~= 6 and name == "Vityaz1" and Train.BARS.Speed == 0 and self.Recuperation == true then self.Recuperation = false elseif name == "Vityaz1" and Train.BARS.Speed == 0 and self.Recuperation == false then self.Recuperation = true end
			end
		end

		if self.State == 5 and name == "AttentionMessage" and value then
			local currerr = 0
			for id,err in pairs(self.Errors) do
				if err and (currerr == 0 or id < currerr) then
					currerr = id
				end
			end
			if (currerr == 10 or currerr > 14) and self.Errors[currerr] then
				self.Errors[currerr] = false
			end
		end
		if self.State == 6 and value then
			if name == "VityazUTV" then self.State = 5 self.State2 = self.PrevState2 self.PrevState2 = nil end
		end
	end
	function TRAIN_SYSTEM:CheckError(id,cond)

		if (id == 21 or id == 22 or id == 24 or id == 25) then
			if cond then
				if self.Errors[id] ~= false then self.Errors[id] = CurTime() end
			else
				self.Errors[id] = nil
			end
		else
			if cond then
				if self.Errors[id] ~= false then self.Errors[id] = CurTime() end
			elseif id < 15 and self.Errors[id] and self.Errors[id] ~= CurTime() or self.Errors[id] == false then
				self.Errors[id] = nil
			end
		end
	end
	function TRAIN_SYSTEM:Think(dT)
		--print(self.ProstCanEnDis)
        if self.State > 0 and self.Reset and self.Reset ~= 1 then self.Reset = false end
        local Train = self.Train
		Train:SetNW2Int("Monitor:Brightness", self.Brightness)
		Train:SetNW2Bool("OldVersion", self.OldVersion)
        local Panel = Train.Panel
        local Power = Train.Electric.Battery80V*Train.SF1.Value > 0 or Train.Electric.ReservePower > 0
        local VityazWork = Train.SF5.Value > 0 and Power
		--rint(Train.Electric.Main750V,Train.Electric.Recurperation)
		--print(self.State)
		if self.VityazTimer then
			Train:SetNW2Int("VityazWorkTimer",self.VityazTimer)
		end
        if not VityazWork and self.State ~= (Power and -2 or 0) and (not Power or self.State ~= -3) then
            if self.State == 0 then
                self.State = -3
            else
                self.State = (Power and -2 or 0)
            end
            self.VityazTimer = nil
            self.Reset = nil
            self.Compressor = false
            self.Ring = false
            self.Error = 0
            self.ErrorRing = nil
        end
        if VityazWork and (self.State == 0 or self.State == -2 or Power and self.State == -3) then
            self.State = Power and -1 or -3
            self.VityazTimer = CurTime()
        end
	
		if self.State == -1 and CurTime()-self.VityazTimer > 1 then

			self.State = 1
			self.State2 = 0

			self.VityazTimer = false
			self.Counter = 0

			self.Password = ""
			Train:SetNW2String("VityazPass","")

			self.States = {}
			self.PVU = {}
			for k,v in ipairs(self.Trains) do
				if self.Trains[v] then self.Trains[v] = {} end
			end

			self.PTEnabled = nil
			self.HVBad = false
		end
		if self.State == -3 or self.State > 0 then
			for k,v in pairs(self.TriggerNames) do
				if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
					self:Trigger(v,Train[v].Value > 0.5)
					self.Triggers[v] = Train[v].Value > 0.5
				end
			end
			self.Counter = self.Counter + (self.OldVersion and math.random(3,4) or math.random(6,7))
			if self.Counter > 799 then
				self.Counter = 0
			end
			if Train.SF13.Value > 0 then Train:SetNW2Int("VityazCounter",self.Counter) end
		end
		if self.State > 0 then
			if self.State == 2 then
				Train:SetNW2String("VityazDate",self.Date)
				Train:SetNW2String("VityazTime",self.Time)
				Train:SetNW2String("VityazRouteNumber",self.RouteNumber)
				Train:SetNW2Int("VityazWagNum",self.WagNum)
				Train:SetNW2String("VityazDepotCode",self.DepotCode)
				Train:SetNW2String("VityazDepeatStation",self.DepeatStation)
				Train:SetNW2String("VityazPath",self.Path)
				Train:SetNW2String("VityazDir",self.Dir)
				Train:SetNW2String("VityazDeadlock",self.Deadlock)
				Train:SetNW2String("VityazEnter",self.Entering or "-")
				if self.WagNum < 6 then
					if self.AutoStart then
						for i=1,self.WagNum do
							Train:SetNW2Bool("VityazWagI"..i,true)
						end
						initialized = true
						self.State = 5
						self.Prost = true
						self.Kos = true
						self.Ovr = true	
						self.Errors = {}
						self.AutoStart = false
					end
				end
			end
			if self.State == 3 then
				local initialized = self.WagNum<6
				Train:SetNW2Bool("VityazNotInitialize",self.WagNum>5)
				for i=1,self.WagNum do
					local train = self.Trains[self.Trains[i]]
					if train then
						if not train.WagNOrientated and train.BUVWork and not train.BadCombination then--and train.PTEnabled then
							Train:SetNW2Bool("VityazWagI"..i,true)
						else
							Train:SetNW2Bool("VityazWagI"..i,false)
							initialized = false
						end
					else
						initialized = false
					end
				end
				if initialized then
					self.State = 4
					local i = 1
					for k,v in pairs(self.Checks) do
						Train:SetPackedBool("VityazBTest"..k,false)
						i = i + 1
					end
					Train:SetNW2Int("VityazBTest",0)
				end
			end
			if self.State == 4 then
				Train:SetNW2Bool("VityazNotInitialize",self.WagNum>5)
				local i = 1
				local num = 0
				local EnginesStrength = 0
				for k,v in pairs(self.Checks) do
					if Train[k].Value > 0 then
						Train:SetNW2Bool("VityazBTest"..k,true)
						self.Checks[k] = true
					end
					i = i + 1
					if v then num = num + 1 end
				end
				Train:SetNW2Int("VityazBTest",num)
			end

			local stength = 0
			local EnginesStrength = 0
			local RV = (1-Train.KV["KRO5-6"]) + Train.KV["KRR15-16"] + (1-Train.SF2.Value)
			local doorLeft,doorRight,doorClose = false,false,false
			self.DoorClosed = false
			if self.State == 5 then
				Train:SetNW2Bool("VityazNotInitialize",self.WagNum<6)
				local Back = false--Train:ReadTrainWire(4) > 0 and (Train.SF2.Value*(1-Train.KV["KRO5-6"]) or Train.SF3.Value*Train.KV["KRR15-16"]) > 0
				local err3,err4,err6,err7,err10,err11,err15,err16,err17,err19,err20,err22,err23
				local HVBad = false
                for i=1,self.WagNum do
                    local train = self.Trains[self.Trains[i]] or {}
                    if train.DriveStrength then EnginesStrength = EnginesStrength + train.DriveStrength end
                    if train.BrakeStrength then EnginesStrength = EnginesStrength + train.BrakeStrength end

                    if train.RV and self.Trains[i] ~= Train:GetWagonNumber() then
                        Back = true
                    end
                    if train.HVBad then HVBad = true end
                end
                if HVBad and not self.HVBad then self.HVBad = CurTime() end
                if not HVBad and self.HVBad then self.HVBad = false end
                self.SchemeEngaged = false

                if RV > 0 and not Back then
                    for i=1,self.WagNum do
                        Train:CANWrite("BUKP",Train:GetWagonNumber(),"BUV",self.Trains[i],"Orientate",i%2 > 0)
                    end
                    if self.Reset == nil then
                        self.Reset = true
                    end
					if Train.VityazF8.Value < 0.5 then self.ProstCanEnDis = nil end
					--if self.ProstTimer and Train.VityazF8.Value < 0.5 then self.ProstTimer = nil end
					--Train:SetNW2Bool("VityazProstTimer",self.ProstTimer and CurTime()-self.ProstTimer > 0.5)
					Train:SetNW2Bool("VityazProst",self.Prost)
					Train:SetNW2Bool("VityazKos",self.Kos)
					--Door controls
					if not err4 and Train.BARS.Speed < 1.8 and Train.DoorLeft.Value > 0 and Train.DoorSelectL.Value > 0 and Train.DoorSelectR.Value == 0 and (not Train.Prost_Kos.BlockDoorsL or Train.Attention.Value > 0 or Train.DoorBlock.Value == 1) then
						doorLeft = true
					end
					if not err4 and Train.BARS.Speed < 1.8 and Train.DoorRight.Value > 0 and Train.DoorSelectR.Value > 0 and Train.DoorSelectL.Value == 0 and (not Train.Prost_Kos.BlockDoorsR or Train.Attention.Value > 0 or Train.DoorBlock.Value == 1) then
						doorRight = true
					end
					local min,max
					self.DoorClosed = true
					for i=1,self.WagNum do
						local trainid = self.Trains[i]
						local train = self.Trains[trainid]
						if not train then
							self.State = 1
						end
						local doorclose = true
						for i=1,8 do
							if not train["Door"..i.."Closed"] then
								doorclose = false
								break
							end
						end
						if not doorclose then
							self.DoorClosed = false
						end
						err3 = err3 or not train.BUVWork
						err4 = err4 or train.WagNOrientated
						err6 = err6 or train.EmergencyBrake
						err7 = err7 or train.ParkingBrakeEnabled
						--err7 = err7 or train.WagNOrientated
						err10 = err10 or train.PTEnabled or train.MPTEnabled
						err11 = err11 or not doorclose
						err15 = err15 or train.DoorBack and trainid ~= Train:GetWagonNumber()
						err16 = err16 or not train.AirSpringOkay
						err20 = err20 --or not train.PassLightEnabled
						err22 = err22 or train.EmerBrakeEnabled
						err23 = err23 or not train.DUKS
						--print(not train.HVBad and (train.BBEEnabled > 0 or Train.Compressor.Value == 0))
						if train then
							if not min then min = train.MinBCAnyPressure end
                            if not max then max = train.MaxBCAnyPressure end
						end
						-- Автоматически включает состояние дверей при их открытии
						--[[
						if self.DCCache ~= self.DoorClosed then
							self.DCCache = self.DoorClosed
							if self.DCCache then
								self.State2 = self.OldState2
								self.Selected = self.OldSelected
							else
								self.OldState2 = self.State2
								self.OldSelected = self.Selected
								self.State2 = 5
							end
						end]]

						Train:SetNW2Bool("VityazDoors"..i,doorclose)
						Train:SetNW2Bool("VityazBV"..i,train.BVEnabled)
						Train:SetNW2Bool("VityazScheme"..i,not train.NoAssembly)
						self:CState("Vent2C",Train.Vent2.Value > 0)
						local trainsel = self.Trains[i]
                        for a=1,9 do Train:SetNW2Bool("VityazRPVU"..a..i,self.PVU[trainsel] and self.PVU[trainsel][a]) end
						self.SchemeEngaged = self.SchemeEngaged or not train.NoAssembly
						Train:SetNW2Bool("VityazMPT"..i,not train.PTEnabled and not train.MPTEnabled) -- ПТ ВКЛ
						Train:SetNW2Bool("VityazMPB"..i,not train.ParkingBrakeEnabled) -- СТ ТОРМ
						Train:SetNW2Bool("VityazMEB"..i,not train.EmergencyBrake) -- ЭКС ТОР
						Train:SetNW2Bool("VityazMBUV"..i,not train.BUVWork) -- БУВ
						Train:SetNW2Bool("VityazMBBEBroken"..i,not train.BBEBroken) -- ЗАЩ ДИП
						Train:SetNW2Bool("VityazMRessora"..i,train.AirSpringOkay) -- Рессора
						Train:SetNW2Bool("VityazMDUKS"..i,train.DUKS)
						Train:SetNW2Bool("VityazMBTBR"..i,train.BTBReady) -- БТБ ГОТ
						Train:SetNW2Bool("VityazKKFull"..i, train.ConditionerWork)
						Train:SetNW2Bool("VityazKKEmer"..i, train.ConditionerEmer)
						--print(train.Vent2Enabled)
						Train:SetNW2Bool("VityazMKK1Mode",self.Klimat1Mode)
						Train:SetNW2Bool("VityazMKK2Mode",self.Klimat2Mode)
						Train:SetNW2Bool("ProstVersion",self.PrOstVersion)
						Train:SetNW2Bool("VityazMBTB",Train.BARS.BTB) -- БТБ
						Train:SetNW2Int("VityazMBarsBlock",Train.BARSBlock.Value) -- БТБ
						Train:SetNW2Bool("VityazMBARS1",Train.SF4.Value == 0 or Train.BARS.Speed == 0 or Train.BARS.Brake > 0) -- БАРС 1
						Train:SetNW2Bool("VityazMBARS2",Train.SF7.Value == 0 or Train.BARS.Speed == 0 or Train.BARS.Brake > 0) -- БАРС 2
						Train:SetNW2Bool("VityazDisableDrive",Train.BARS.DisableDrive or self.Errors[5] and Train.Panel.Controller > 0) -- ЗАПРЕТ ТР
						Train:SetNW2Bool("VityazMRecuperation",self.Recuperation) -- БАРС 1
						Train:SetNW2Bool("ProstDoorBlockL",Train.BARS.Speed < 1.8 and (not Train.Prost_Kos.BlockDoorsL or Train.Attention.Value > 0 or Train.DoorBlock.Value == 1))
						Train:SetNW2Bool("ProstDoorBlockR",Train.BARS.Speed < 1.8 and (not Train.Prost_Kos.BlockDoorsR or Train.Attention.Value > 0 or Train.DoorBlock.Value == 1))
					end
					
					local BARS = Train.BARS
					Train:SetNW2Int("VityazSpeed",Train.BARS.Speed)
					Train:SetNW2Int("VityazSpeedLimit",Train.BARS.SpeedLimit)
					Train:SetNW2Int("BARSFreq",Train.ALSFreqBlock.Value)
					Train:SetNW2Int("BARSLN",Train.BARS.LN)
					Train:SetNW2Bool("BARSNoFreq",Train.BARS.BINoFreq)
					Train:SetNW2Int("VityazSpeedLimitNext",Train.BARS.NextLimit)
					-- Если честно, я понятия не имею на счёт полного перечня сообщений
					-- и тем более их приоритет
					-- поэтому могу собрать сообщения только так
					self:CheckError(1,false) 					-- "Сбой КМ"
					self:CheckError(2,Train.SF2.Value == 0)		-- "Сбой РВ"
					self:CheckError(3,err3)						-- "Неисправн БУВ"
					self:CheckError(4,err4)						-- "Ваг не ориентир"
					self:CheckError(5,BARS.DisableDrive or self.Errors[5] and Train.Panel.Controller > 0)
					self:CheckError(6,err6)						-- ЭКСТР ТОРМОЖЕН
					self:CheckError(7,err7)						-- Стоян ТОРМ приж
					self:CheckError(11,err11 or self.Errors[11] and Train.Panel.Controller > 0) -- ДВЕРИ не закрыты

					local err13 = not HVBad and Train.Compressor.Value == 0
					local err14 = not HVBad and Train.BBE.Value == 0 
					local err12 = err13 and err14
					if err12 and not self.EnableMKIPPTimer then self.EnableMKIPPTimer = CurTime() end
					if not err12 and self.EnableMKIPPTimer then self.EnableMKIPPTimer = nil end
					self:CheckError(12,err12 and (self.EnableMKIPPTimer and CurTime() - self.EnableMKIPPTimer > 0.75) ) 	-- Включи МК и ИПП
					if err13 and not self.EnableMKTimer then self.EnableMKTimer = CurTime() end
					if not err13 or err14 and self.EnableMKTimer then self.EnableMKTimer = nil end
					self:CheckError(13,err13 and (self.EnableMKTimer and CurTime() - self.EnableMKTimer > 0.75) )			-- Включи МК
					
					if err14 and not self.EnableIPPTimer then self.EnableIPPTimer = CurTime() end
					if not err14 or err13 and self.EnableIPPTimer then self.EnableIPPTimer = nil end
					self:CheckError(14,err14 and (self.EnableIPPTimer and CurTime() - self.EnableIPPTimer > 0.75) )			-- Включи ИПП
					
					self:CheckError(15,err15)					-- Открыта кабина ХВ
					
					if err16 and not self.AirSpringOkayTimer then self.AirSpringOkayTimer = CurTime() end
					if not err16 and self.AirSpringOkayTimer then self.AirSpringOkayTimer = nil end
					self:CheckError(16,err16 and (self.AirSpringOkayTimer and CurTime() - self.AirSpringOkayTimer > 0.75) )					-- Кузов не в норме
						-- AirSpringOkay
					self:CheckError(20,err20)					-- Освещение не вкл.
					self:CheckError(21,Train.DoorBlock.Value > 0) -- вкл блок дверей
					self:CheckError(22,err22)					-- Торм рез включен
					--print(os.date("%d", 1))
					if err23 and not self.DisableDUKSTimer then self.DisableDUKSTimer = CurTime() end
					if not err23 and self.DisableDUKSTimer then self.DisableDUKSTimer = nil end
					self:CheckError(23,err23 and (self.DisableDUKSTimer and CurTime() - self.DisableDUKSTimer > 0.75) )		-- ДУКС неисправен

					self:CheckError(24, Train.BARS.Speed < 2 and Train.DoorLeft.Value > 0 and Train.DoorSelectL.Value > 0 and Train.DoorSelectR.Value == 0 and Train.Prost_Kos.BlockDoorsL and (Train.Attention.Value == 0 and Train.DoorBlock.Value == 0))
					self:CheckError(25, Train.BARS.Speed < 2 and Train.DoorRight.Value > 0 and Train.DoorSelectR.Value > 0 and Train.DoorSelectL.Value == 0 and Train.Prost_Kos.BlockDoorsR and (Train.Attention.Value == 0 and Train.DoorBlock.Value == 0))
					self:CheckError(26,self.State == 5)--self:CheckError(19,err19)

					if Train.KV["KRO5-6"] == 0 then
						if (BARS.Brake == 0 and BARS.Drive > 0 and (self.Error == 0 or self.Error == 5.5 and self.EmergencyBrake == 0 or (self.Error == 6 and Train.BUV.Slope1) or self.Error >= 9 and self.Error ~= 11 or self.Error == 11 and Train.DoorBlock.Value > 0 --[[or (self.Error > 1 or self.Error < 4) and Train.BARSBlock.Value == 3 and not err6]] )) or Train.Panel.Controller <= 0 then
							stength = Train.Panel.Controller
						end
						Train:SetNW2Bool("VityazBARSPN2",not Train.Prost_Kos.CommandKos and BARS.Brake == 0 and BARS.Active == 1 and BARS.PN2 > 0 and not Train.Pneumatic.EmerBrakeWork)
						if Train.Prost_Kos.Command ~= 0 and Train.Prost_Kos.ProstActive == 1 and Train.Panel.Controller == 0 then
							stength = Train.Prost_Kos.Command*(self.WagNum>6 and 0 or 1)
						end
						if Train.Prost_Kos.CommandKos then stength = -3*(self.WagNum>6 and 0 or 1) end
						if BARS.Brake > 0 then stength = -3*(self.WagNum>6 and 0 or 1) end

						if Train.Prost_Kos.Metka and (Train.Prost_Kos.Metka[2] or Train.Prost_Kos.Metka[3] or Train.Prost_Kos.Metka[4]) and (Train.Prost_Kos.DistToSt ~= 0 or Train.Prost_Kos.ProstActive == 1) then
							Train:SetNW2Int("VityazS",(Train.Prost_Kos.Dist or -10)*100)--(Train:ReadCell(49165)-5-5)*100)
						elseif Train:GetNW2Int("VityazS",-1000) ~= -1000 then
							Train:SetNW2Int("VityazS",-1000)
						end
						local find = false
						for k,v in pairs(Train.Prost_Kos.Metka) do
							if v and not find then
								find = true
								break
							end
						end
						--print(Train.Speed,Train.BARS.Speed)
						if Train.Prost_Kos.ProstActive and (Train.Prost_Kos.ProstActive > 0 and Train.BARS.Speed > 5) then
                            Train:SetNW2Int("ProstStength",Train.Prost_Kos.Command < 0 and -Train.Prost_Kos.Command or 0)
                            --if not self.ProstTimer then self.ProstTimer = 1052 end
							self.ProstExchTimer = self.ProstExchTimer + math.random(1,3)
							--print(self.ProstExchTimer)
                            if self.ProstExchTimer > 4096 then self.ProstExchTimer = 0 end
                            Train:SetNW2Int("ProstTimer",self.ProstExchTimer)
                            Train:SetNW2Int("ProstTotalDist",Train.Prost_Kos.sum)
                            if self.Metka1Cache ~= Train.Prost_Kos.Metka[1] or self.Metka2Cache ~= Train.Prost_Kos.Metka[2] or self.Metka3Cache ~= Train.Prost_Kos.Metka[3] or self.Metka4Cache ~= Train.Prost_Kos.Metka[4] then
                                Train:SetNW2Int("ProstMark",self.ProstExchTimer)
                                self.Metka1Cache = Train.Prost_Kos.Metka[1]
                                self.Metka2Cache = Train.Prost_Kos.Metka[2]
                                self.Metka3Cache = Train.Prost_Kos.Metka[3]
                                self.Metka4Cache = Train.Prost_Kos.Metka[4]
                            end
                        elseif Train.Prost_Kos.Dist and Train.Prost_Kos.Dist < -5 and Train.Speed > 3 then
                            Train:SetNW2Int("ProstStength",0)
                            Train:SetNW2Int("ProstTimer",0)
                            Train:SetNW2Int("ProstMark", 0)
                            Train:SetNW2Int("ProstTotalDist",0)
                        end

						Train:SetNW2Bool("VityazProstMetka",find)
						--print(Train.Prost_Kos.Dist)
						Train:SetNW2Bool("VityazProstActive",Train.Prost_Kos.ProstActive == 1 and math.abs(Train.Prost_Kos.Dist or -1000) < 200)
						Train:SetNW2Bool("VityazProstKos",not Train.Prost_Kos.Stop1 and not Train.Prost_Kos.WrongPath)--or Train.Prost_Kos.PrKos)
					elseif (Train:GetNW2Int("VityazS",-1000) ~= -1000 or Train:GetNW2Bool("VityazProstMetka",false) or Train:GetNW2Bool("VityazProstActive",false)) then
						Train:SetNW2Int("VityazS",-1000)
						Train:SetNW2Bool("VityazProstMetka",false)
						Train:SetNW2Bool("VityazProstActive",false)
					end
					if Train.Prost_Kos.Programm then
						Train:SetNW2Int("VityazProstNum",math.random(1,0xFF))
					elseif Train.Prost_Kos.Metka1 then
						Train:SetNW2Int("VityazProstNum",0xDC)
					else
						Train:SetNW2Int("VityazProstNum",0)
					end
					if err10 and stength > 0 and not self.PTEnabled then self.PTEnabled = CurTime() end
					if (not err10 or stength <= 0) and self.PTEnabled then self.PTEnabled = nil end
					self:CheckError(9,self.PTEnabled and CurTime()-self.PTEnabled > 2.5)
					self:CheckError(10,self.HVBad and CurTime()-self.HVBad > 10)

					Train:SetNW2Int("VityazType",stength ~= 0 and (stength < 0 and -1 or 1) or 0)
					Train:SetNW2Int("VityazPMin",(min or 0)*10)
                    Train:SetNW2Int("VityazPMax",(max or 0)*10)
					Train:SetNW2Int("VityazPNM",Train.Pneumatic.TrainLinePressure*10)
					Train:SetNW2Int("VityazUbs",Train.Electric.Battery80V)
					if self.State2 == 2 and self.Selected == 0 then
						for i=1,self.WagNum do
							local train = self.Trains[self.Trains[i]]
							Train:SetNW2Int("VityazIMK"..i,train.MKVoltage*10)
							Train:SetNW2Int("VityazIVO"..i,self.Trains[self.Trains[i]].VagEqConsumption*10)
							Train:SetNW2Int("VityazLV"..i,train.LVValue)
						end
					elseif self.State2 == 2 and self.Selected == 1 then
						for i=1,self.WagNum do
							local train = self.Trains[self.Trains[i]]
							Train:SetNW2Int("VityazBrakeStrength"..i,math.abs((train.BrakeStrength or 0))*20)
							Train:SetNW2Int("VityazDriveStrength"..i,math.abs((train.DriveStrength or 0))*20)
							Train:SetNW2Float("VityazElectricEnergyUsed"..i,train.ElectricEnergyUsed)
						end
					elseif self.State2 == 0 then
							for i=1,self.WagNum do
								local train = self.Trains[self.Trains[i]]
								Train:SetNW2Bool("VityazWagOr"..i,train.Orientation)
							end
						
						elseif self.State2 == 3 then
							for i=1,self.WagNum do
								local train = self.Trains[self.Trains[i]]
								Train:SetNW2Bool("VityazPSOT"..i,not train.PTEnabled)
								Train:SetNW2Bool("VityazMSOT"..i,not train.MPTEnabled) 
							end
						elseif self.State2 == 4 then
							if self.Selected == 0 then
							for i=1,self.WagNum do
								local train = self.Trains[self.Trains[i]]
								Train:SetNW2Bool("VityazMufta"..i,true) --"муфта"
								Train:SetNW2Bool("VityazAxles"..i,true) --"буксы"
								Train:SetNW2Bool("VityazCompressor"..i,true) --"мк" (исправность)
								Train:SetNW2Bool("VityazDoorBlock"..i,Train.BUV.BlockTorec) --"торц дв"
								Train:SetNW2Bool("VityazPTWork"..i,not train.PTBad) --"ТОРМ ОБ" !
								Train:SetNW2Bool("VityazTPFailure"..i, not train.TPFailure) --"Неис тп"
								Train:SetNW2Bool("VityazEmPT"..i,not train.EmPT) --"ТОРМ РК"
								Train:SetNW2Bool("VityazLightsWork"..i,train.PassLightEnabled) --"ОСВ ВКЛ"
							end
						elseif self.Selected == 1 then
							for i=1,self.WagNum do
								local train = self.Trains[self.Trains[i]]
								Train:SetNW2Bool("VityazHVGood"..i,not train.HVBad) --"НАПР КС"
								Train:SetNW2Bool("VityazPantDisabled"..i,not train.PantDisabled) --"ТКПР ОТЖ"
								Train:SetNW2Bool("VityazPTEff"..i,true) --"ПТ ЭФФ"
								Train:SetNW2Bool("VityazEDTBroken"..i,not train.EnginesBrakeBroke) --"ОТКАЗ ЭТ"
								Train:SetNW2Bool("VityazInvPro"..i,train.InvertorProtection) --"защ инв" 
								Train:SetNW2Bool("VityazInvOverH"..i,true) --"пер инв"
								Train:SetNW2Bool("VityazMejWag"..i,train.MejWag) --"МежВаг С"
								Train:SetNW2Bool("VityazVTR"..i,true) --"НЕИС ВТР"
							end
						elseif self.Selected >= 2 then
							for i=1,self.WagNum do
								local train = self.Trains[self.Trains[i]]
								Train:SetNW2Bool("VityazKKGreen"..i,true) -- Почти всё
								Train:SetNW2Bool("VityazKKRed"..i,false)
								--Train:SetNW2Bool("VityazKKEnable"..i, )
								--Train:SetNW2Bool("VityazKKEmer"..i, )
								Train:SetNW2Bool("VityazMKK1Mode",self.Klimat1Mode)
								Train:SetNW2Bool("VityazMKK2Mode",self.Klimat2Mode)
								--Train:SetNW2Bool("VityazSOVSHeating"..i,train.SOVSHeating and self.SOVSH)
								--Train:SetNW2Bool("VityazSOVSNHeating"..i,train.SOVSHeating and not self.SOVSH)
							end
						end
						elseif self.State2 == 5 then
							for i=1,self.WagNum do
								local train = self.Trains[self.Trains[i]]
								local orientation = train.Orientation
								Train:SetNW2Bool("VityazWagOr"..i,orientation)
								if i == 1 or i == self.WagNum then
									doorcount = 5
								else
									doorcount = 6
								end
								for d=1,doorcount do
									Train:SetNW2Bool("VityazDoor"..d.."L"..i,train["LeftDoor"..d.."Closed"])
									Train:SetNW2Bool("VityazDoor"..d.."R"..i,train["RightDoor"..d.."Closed"])
									--print(i.." вагон",d.." дверь",Train:GetNW2Bool("VityazDoor"..d.."L"..i,train["Door"..(orientation and d or d+6).."Closed"]),Train:GetNW2Bool("VityazDoor"..d.."R"..i,train["Door"..(orientation and d+6 or d).."Closed"]))
								end
							end
						elseif self.State2 == 6 then
							local train = self.Trains[self.Selected]
							for i=1,9 do Train:SetNW2Bool("VityazPVU"..i,self.PVU[train] and self.PVU[train][i]) end
						end
						if not self.Slope and Train.AccelRate.Value > 0 and (Train.BARS.Speed <= 2 or stength == 0) then self.Slope = true self.SlopeSpeed = (Train.BARS.Speed <= 2) end
                    	if self.Slope and ( self.SchemeEngaged or not self.SlopeSpeed and stength ~= 0) then self.Slope = false end
				else
					self.Reset = nil
					self.Slope = false
					self.State2 = 0
					if self.PTEnabled then self.PTEnabled = nil end
					self:CheckError(1,false)
					self:CheckError(2,false)
					self:CheckError(3,false)
					self:CheckError(4,false)
					self:CheckError(5,false)
					self:CheckError(6,false)
					self:CheckError(7,false)
					self:CheckError(9,false)
					self:CheckError(10,false)

					--self:CheckError(7,train.WagNOrientated)
					self:CheckError(11,false)
					self:CheckError(12,false)
					self:CheckError(17,false)
					if self.Error then self.Errors[self.Error] = false end
				end
				local currerr = 0
				for id,err in pairs(self.Errors) do
					if err and (currerr == 0 or id < currerr) then
						currerr = id
					end
				end
				if self.Error ~= currerr then
					if currerr > 0 and currerr < 11 then self.ErrorRing = CurTime() end
					self.Error = currerr
				end
				if self.ErrorRing and (currerr == 0 or currerr > 11) then self.ErrorRing = nil end
				Train:SetNW2Int("VityazError",currerr or 0)
				Train:SetNW2Int("VityazMainMsg",Back and RV>0 and 3 or Back and 2 or RV==0 and 1 or 0)
			end
			if self.State < 5 and self.Prost then
				self.Prost = false
				self.Kos = false
				self.Ovr = false
			end
			for i=1,9 do
				Train:SetNW2Int("VityazWagNum"..i,self.Trains[i] or 0)
			end
			self:CState("OpenLeft",doorLeft)
			self:CState("OpenRight",doorRight)
            self:CState("Slope",Train.KV.KRRPosition == 0 and self.Slope)
            self:CState("SlopeSpeed",self.SlopeSpeed)
			if self.WagNum > 0 then
				self.EnginesStrength = EnginesStrength/self.WagNum
			else
				self.EnginesStrength = 0
			end
			self:CState("RV",RV*Train.SF2.Value > 0,"BUKP")
			--self:CState("RVPB",(1-Train.KV["KRO5-6"])*Train.SF2.Value > 0)
			self.ControllerState = stength
			self:CState("DriveStrength",math.abs(stength))
			self:CState("Brake",stength < 0 and 1 or 0)
			self:CState("PN1",Train.BARS.PN1)
            self:CState("PN2",Train.BARS.PN2+(self.Slope and Train.KV.KROPosition ~= 0 and self.SlopeSpeed and 1 or 0))
			for t=1,self.WagNum do
				local train = self.Trains[t]
				if train then
					for i=1,9 do
						self:CStateTarget("PVU"..train.."_"..i,"PVU"..i,"BUV",train,self.PVU[train] and self.PVU[train][i])
					end
				end
			end
			local ring = false
			for i=2,self.WagNum do
				local train = self.Trains[self.Trains[i]]
				if train and train.Ring and train.RV then
					ring = true
				end
			end
			self.Ring = Train.BARS.Ring > 0 or ring or self.ErrorRing and CurTime()-self.ErrorRing < 2 or self.Error > 11 and self.Error < 21
			self.ErrorRinging = (ring or (Train.Prost_Kos.Programm and Train.Speed > 2) or self.ErrorRing and CurTime()-self.ErrorRing < 2)
			self.ProstRinging = (Train.Prost_Kos.Programm and Train.Speed > 2)

			if Train.Compressor.Value > 0 then
				self.Compressor = Train.AK.Value > 0
			else
				self.Compressor = false
			end
			if Train.DoorClose.Value > 0 then -- В новых машинах при наличии признака активной кабины и ДАЖЕ ПРИ ОТКЛЮЧЕННОМ РЕВЕРСЕ двери закроются (проврено ИРЛ)
				doorClose = true
			end
			self:CState("Ring",Train.Ring.Value > 0,"BUKP")
			self:CState("CloseDoors",doorClose)
			self:CState("TP1",Train.Pant1.Value > 0)
			self:CState("TP2",Train.Pant2.Value > 0)
			self:CState("Vent2",Train.Vent2.Value > 0)
			self:CState("PassLight",Train.PassLight.Value > 0)
			self:CState("ParkingBrake",Train.ParkingBrake.Value > 0)

			self:CState("BlockDoorTorec",Train.TorecDoors.Value > 0)
			self:CState("BBE",Train.BBE.Value > 0)
			self:CState("BVOn",Train.Panel.Controller == 0 and Train.EnableBV.Value > 0)
			self:CState("RecurperationDisable", self.Recuperation) 
			self:CState("TPTOn",Train.Panel.Controller == -3 and Train.TPT.Value > 0 and Train.BARS.Speed > 1)
			self:CState("HeatinPads",Train.Stand.Value > 0 and Train.BARS.Speed > 1 and Train.Panel.Controller <= 0)
			--self:CState("Vent2On",Train.Vent2.Value > 0)
			self:CState("BVOff",Train.DisableBV.Value > 0)

			self:CState("Ticker",Train.Ticker.Value > 0)
			self:CState("PassScheme",Train.PassScheme.Value > 0)
			self:CState("Compressor", self.Compressor)
		end
		self:CState("BUPWork",self.State > 0)
		Train:SetNW2Int("VityazSelected",self.Selected)
		Train:SetNW2Int("VityazState2",self.State2)
		Train:SetNW2Int("VityazState",Train.SF13.Value*self.State)
		if self.State > 0 and self.Reset and self.Reset == 1 then self.Reset = false end
	end
else
	local function createFont(name,font,size,weight,blur,scanlines,underline)
		surface.CreateFont("Metrostroi_7404_"..name, {
			font = font,
			size = size,
			weight = weight or 400,
			blursize = blur or false,
			antialias = true,
			underline = underline,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = true,
			additive = false,
			outline = false,
			extended = true,
			scanlines = scanlines or false,
		})
	end
	
	createFont("VityazComm","Lucida Console",25,410,0.5,1,false)
	createFont("VityazComm2","FreeSans",40,500,0.5,2,false)
	createFont("VityazBold1","FreeSans",28,400,0.5,2,false)
	surface.SetFont("Metrostroi_7404_VityazBold1")
	local txt = "█"
	local fontSize4Bold = select(1,surface.GetTextSize(txt)) ~= 15 and 24 or 28
    createFont("VityazBold","FreeSans",fontSize4Bold,400,0.5,2,false)
	createFont("VityazPU","PerfectDOSVGA437",26,400,0,0,false)
	createFont("VityazPU1","Lucida Console",24,500,false)
	createFont("VityazPU2","Lucida Console",21,300,false) 
	createFont("VityazPU3","Arial",34,600,false)
	createFont("VityazPU4","Lucida Console",17,600,false)

	function TRAIN_SYSTEM:ClientThink()
		local state = self.Train:GetNW2Int("VityazState",0)
		--print(state.." state")
		local counter = self.Train:GetNW2Int("VityazCounter",0)
		if self.Counter ~= counter or (state <= 0 and state ~= -2) and self.State ~= state then
			self.Counter = counter
			if state ~= -2 then
				self.State = state
			end
			render.PushRenderTarget(self.Train.Vityaz,0,0, 800, 600) -- Соотношение ИРЛ 800 на 600 (4:3)
			render.Clear(0, 0, 0, 0)
			cam.Start2D()
				self:VityazMonitor(self.Train)
			cam.End2D()
			render.PopRenderTarget()
		end
	end

	function TRAIN_SYSTEM:PrintText(x,y,text,col,size)
		local str = {utf8.codepoint(text,1,-1)}
		local state = self.Train:GetNW2Int("VityazState")
		local isOldFont = self.Train:GetNW2Bool("OldVersion")
		local xMultiplicate,yMultiplicate = 19,24
		for i=1,#str do
			local char = utf8.char(str[i])
			if state >= -2 then
				if char == "█" then
					draw.SimpleText(char,"Metrostroi_7404_VityazBold",-10+(x+i)*xMultiplicate,-5+y*yMultiplicate,col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				else
					if isOldFont then
						draw.SimpleText(char,"Metrostroi_7404_VityazComm2",-10+(x+i)*xMultiplicate,-5+y*yMultiplicate,col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					else
						draw.SimpleText(char,"Metrostroi_7404_VityazComm",-10+(x+i)*xMultiplicate,-5+y*yMultiplicate,col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					end
				end
			else
				draw.SimpleText(char,"Metrostroi_7404_VityazPU1",-15+(x+i)*17,y*24,col,TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
			end
		end
    end
	local Errors = {
			"Сбой КМ", -- 1
			"Сбой РВ", -- 2 
			"Неисправн БУВ", -- 3
			"Ваг не ориентир", -- 4
			"Запрет ТР БАРСом", -- 5
			"ЭКСТР ТОРМОЖЕН", -- 6
			"Стоян ТОРМ приж", -- 7
			"Дверной проем", -- 8
			"ПНЕВМОТОРМОЗ вкл.", -- 9
			"U КС не в норме", -- 10
			"ДВЕРИ не закрыты",--11
			"Включи МК и ИПП", -- 12
			"Включи МК", -- 13
			"Включи ИПП", -- 14
			"Открыта кабина ХВ", -- 15
			"Кузов не в норме", -- 16
			"Защита ИПП",	-- 17
			"БУКСЫ не в норме", -- 18
			"Неисправность МК", -- 19
			"Освещение не вкл.", -- 20
			"Вкл блок дверей", -- 21
			"Торм рез включен", -- 22
			"ДУКС неисправен", -- 23
			"Лев дв заблокир", -- 24
			"Прав дв заблокир", --25
			"ДАУ - ДНЕПР", -- 26
			"Отказ ПрОст", -- 27
	}
	
    function TRAIN_SYSTEM:VityazMonitor(Train)
		local isOld = Train:GetNW2Bool("OldVersion")
		local br = Train:GetNW2Int("Monitor:Brightness")
		local brMod = 35
		local baseBr = 255-brMod*5
		local brTotal = baseBr+br*brMod
		local red = isOld and Color(150,47,49) or Color(250,55,55,brTotal)
		local green = isOld and Color(60,95,70) or Color(103,236,91,brTotal)
		local gray = isOld and Color(170,170,170) or Color(170,170,170,brTotal)
		local speedColor = isOld and Color(52,122,85) or Color(169,236,139,brTotal)
		local yellow = isOld and Color(216,222,176) or Color(250,250,105,brTotal)
		local purple = isOld and Color(233,160,255) or Color(224,190,252,brTotal)
		local aqua = isOld and Color(137,213,236) or Color(150,193,255,brTotal)
		local aqua2 = isOld and Color(66,187,183) or Color(66,187,183,brTotal) 
		local darkpurple = isOld and Color(144,92,164) or Color(214,180,252,brTotal)
		local blue = isOld and Color(36,119,219) or Color(36,119,219,brTotal) 
		local white = isOld and Color(232,236,239) or Color(232,236,239,brTotal)
		
		local state2 = Train:GetNW2Int("VityazState2",0)
		local wagnum = Train:GetNW2Int("VityazWagNum",0)
		local mainmsg = Train:GetNW2Int("VityazMainMsg",0)
		local sel = Train:GetNW2Int("VityazSelected",0)
		local err = Train:GetNW2Int("VityazError")
		if self.State ~= 0 then
			--surface.SetDrawColor(25,13,13,180)
			local brMod = 8
			local baseBr = 255-brMod*5
			local brTotal = baseBr+br*brMod
			local сolMod = 1
			local baseСol = 10 + сolMod * 5
			local сolTotal = isOld and 10 or baseСol + br * сolMod
			surface.SetDrawColor(сolTotal,сolTotal,сolTotal,isOld and brTotal or 190)
			surface.DrawRect(0,0,800,600)
		end
		if self.State == -3 then
			local isOldVersion = Train:GetNW2Bool("OldVersion")
			--local testPuTyp = Train:GetNW2Int("PUType")
			if isOldVersion then
				surface.SetDrawColor(30,30,190)
				surface.DrawRect(0,0,800,600)
				local pix = 75  					-- Размер пикселя
				local generalPosX = 110				-- Начальная позиция по Х
				local generalPosY = 125				-- Начальная позиция по Y
				local pixoffset = pix+10			-- Маленький отступ
				local pixoffsetbig = pix+10*2.5		-- Большой отступ
				local function drawBoxPU(PosX,PosY,bool)
					surface.SetDrawColor(240,240,240)
					local onOffset = 5 				-- отступ для полуобводки
					surface.DrawOutlinedRect(bool and PosX-onOffset+2 or PosX-2, bool and PosY-onOffset+2 or PosY-2, bool and pix-onOffset+2 or pix-2, bool and pix-onOffset+2 or pix-2, 3)
					surface.SetDrawColor(bool and red or Color(22,125,12))
					surface.DrawRect(PosX,PosY,bool and pix - onOffset or pix,bool and pix-onOffset or pix)
				end
				draw.SimpleText("ТЕСТ ПУ","Metrostroi_7404_VityazPU",400,55,Color(225,219,131),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				-- Левый двойной ряд
				drawBoxPU(generalPosX,generalPosY,Train:GetNW2Bool("VityazMNMM13"))
				drawBoxPU(generalPosX+pixoffset,generalPosY,Train:GetNW2Bool("VityazMNMM14"))
				drawBoxPU(generalPosX,generalPosY+pixoffset,Train:GetNW2Bool("VityazMNMM15"))
				drawBoxPU(generalPosX+pixoffset,generalPosY+pixoffset,Train:GetNW2Bool("VityazMNMM16"))
				drawBoxPU(generalPosX,generalPosY+pixoffset*2,Train:GetNW2Bool("VityazMNMM17"))
				drawBoxPU(generalPosX+pixoffset,generalPosY+pixoffset*2,Train:GetNW2Bool("VityazMNMM18"))
				drawBoxPU(generalPosX,generalPosY+pixoffset*3,Train:GetNW2Bool("VityazMNMM19"))
				drawBoxPU(generalPosX+pixoffset,generalPosY+pixoffset*3,Train:GetNW2Bool("VityazMNMM20"))
				-- Нижние четыре
				drawBoxPU(generalPosX,generalPosY+pixoffsetbig+pixoffset*3,Train:GetNW2Bool("VityazMNMM25"))
				drawBoxPU(generalPosX+pixoffset,generalPosY+pixoffsetbig+pixoffset*3,Train:GetNW2Bool("VityazMNMM26"))
				drawBoxPU(generalPosX+pixoffset*2,generalPosY+pixoffsetbig+pixoffset*3,Train:GetNW2Bool("VityazMNMM27"))
				drawBoxPU(generalPosX+pixoffset*3,generalPosY+pixoffsetbig+pixoffset*3,Train:GetNW2Bool("VityazMNMM28"))
				-- Центральные 12
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset,generalPosY,Train:GetNW2Bool("VityazMNMM1"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*2,generalPosY,Train:GetNW2Bool("VityazMNMM2"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*3,generalPosY,Train:GetNW2Bool("VityazMNMM3"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset,generalPosY+pixoffset,Train:GetNW2Bool("VityazMNMM4"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*2,generalPosY+pixoffset,Train:GetNW2Bool("VityazMNMM5"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*3,generalPosY+pixoffset,Train:GetNW2Bool("VityazMNMM6"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset,generalPosY+pixoffset*2,Train:GetNW2Bool("VityazMNMM7"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*2,generalPosY+pixoffset*2,Train:GetNW2Bool("VityazMNMM8"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*3,generalPosY+pixoffset*2,Train:GetNW2Bool("VityazMNMM9"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset,generalPosY+pixoffset*3,Train:GetNW2Bool("VityazMNMM10"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*2,generalPosY+pixoffset*3,Train:GetNW2Bool("VityazMNMM11"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*3,generalPosY+pixoffset*3,Train:GetNW2Bool("VityazMNMM12"))
				-- Правый ряд (+ ввод)
				drawBoxPU(generalPosX+pixoffsetbig*2+pixoffset*3,generalPosY,Train:GetNW2Bool("VityazMNMM21"))
				drawBoxPU(generalPosX+pixoffsetbig*2+pixoffset*3,generalPosY+pixoffset,Train:GetNW2Bool("VityazMNMM22"))
				drawBoxPU(generalPosX+pixoffsetbig*2+pixoffset*3,generalPosY+pixoffset*2,Train:GetNW2Bool("VityazMNMM23"))
				drawBoxPU(generalPosX+pixoffsetbig*2+pixoffset*3,generalPosY+pixoffset*3,Train:GetNW2Bool("VityazMNMM24"))
				drawBoxPU(generalPosX+pixoffsetbig+pixoffset*4,generalPosY+pixoffsetbig+pixoffset*3,Train:GetNW2Bool("VityazMNMM29"))
			else
				local function drawDefBox(text,posX,posY,sizeX,sizeY,col)
					sizeX = sizeX or 150
					sizeY = sizeY or 170
					posX = posX or 0
					posY = posY or 0
					printedText = text[1] or "sample text"
					textPosX = text[2] or 0
					textPosY = text[3] or 0
					col = col or Color(230,92,152,brTotal)
					surface.SetDrawColor(col)
					surface.DrawRect(posX,posY,sizeX,sizeY)
					self:PrintText(textPosX,textPosY,printedText,Color(20,20,20,brTotal))
				end
				--local colorLightGreen = Color()
				local textBoxPosY = 20+25*5
				local textBoxPosX = 30
				local textBoxSizeX = 122
				local textBoxSizeY = 122
				local textBoxXoffset = 12
				drawDefBox({"Красный",1.7,8},textBoxPosX,textBoxPosY,textBoxSizeX,textBoxSizeY,Color(255,55,53,brTotal))
				drawDefBox({"Зеленый",9.5,8},textBoxPosX+textBoxSizeX+textBoxXoffset,textBoxPosY,textBoxSizeX,textBoxSizeY,Color(169,255,59,brTotal))
				drawDefBox({"Синий",18.5,8},textBoxPosX+textBoxSizeX*2+textBoxXoffset*2,textBoxPosY,textBoxSizeX,textBoxSizeY,Color(50,145,255,brTotal))
				drawDefBox({"Белый",26.5,8},textBoxPosX+textBoxSizeX*3+textBoxXoffset*3,textBoxPosY,textBoxSizeX,textBoxSizeY,white)
				local colorWhite = Color(230,230,230,brTotal)
				local colorGray = Color(120,120,120,brTotal)
				surface.SetDrawColor(colorWhite)
				surface.DrawOutlinedRect(20,20,800-40,600-40,2)

				self:PrintText(1.5,1,"Тест мфду-1м",colorGray)  		-- textBoxPosX,startPosY
				self:PrintText(1.5+15,1,"(150818.34433)",colorWhite)	-- textBoxPosX + 250,startPosY
				self:PrintText(1.5,2,"2e9df575cc3683acfad11fds81a3eb3b",colorWhite)
				self:PrintText(1.5,3,"CRC16 MCU1:",colorGray)
				self:PrintText(1.5 + 12,3,"A0C7",colorWhite)
				self:PrintText(1.5,4,"Время непр.работы:",colorGray)
				self:PrintText(1.5,5,"Разрешение экрана:",colorGray)
				local trans2timeTimer = 75600 -- 28200
				self:PrintText(1.5 + 19,4,os.date("%H:%M:%S",CurTime()-Train:GetNW2Int("VityazWorkTimer",0)+trans2timeTimer),colorWhite)
				self:PrintText(1.5 + 19,5,"0800х0600 (32)",colorWhite)
				local lowerTextYpos = textBoxPosY+textBoxSizeY-5
				self:PrintText(1.5, 11,"Обм",colorGray) 
				self:PrintText(1.5 + 4, 11,"S-PORT",colorWhite)
				self:PrintText(1.5, 12,"Прд",colorGray)
				self:PrintText(1.5 + 4, 12,"000000",colorWhite)
				self:PrintText(1.5, 13,"Прм",colorGray)
				self:PrintText(1.5 + 4, 13,"000000",colorWhite)
				self:PrintText(1.5, 14,"Ошб",colorGray)
				self:PrintText(1.5 + 4, 14,"000000",colorWhite)
				self:PrintText(1.5, 15,"Кнопочные панели",colorGray)
				self:PrintText(1.5, 16,"нажатий",colorGray)

				self:PrintText(1.5 + 11,16,Format("%05d", Train:GetNW2Int("VityazCountOfTriggers")),colorWhite)
				self:PrintText(1.5,18,"CPU:",colorGray)
				if not self.NextTimerUpdate then self.NextTimerUpdate = math.random(2,5) end
				if CurTime()%self.NextTimerUpdate > self.NextTimerUpdate - 0.1 then
					self.NextTimerUpdate = nil
					self.CPUPercentage = math.random(9,15)
					self.CPUTemp = math.random(30,32) + math.Round(self.CPUPercentage / 2.25)
				end
				self:PrintText(1.5 + 11,18,(self.CPUPercentage or math.random(6, 9)).."%",colorWhite)
				self:PrintText(1.5,19,"t CPU:",colorGray)
				self:PrintText(1.5 + 11,19,(self.CPUTemp or 32).."°С",colorWhite)

				local buttonPosMultiplier = 1.25
				local function setButton(posX,posY,smooth,size,text,buttonNumber,fontType) -- ДОДЕЛАТЬ ПООТОМ, КОГДА ПОЯВИТСЯ ПОЛНАЯ ИНФА!!!!
					local sizeX = size[1]*buttonPosMultiplier or 50
					local sizeY = size[2] or size[1]
					local border = 17
					local onOffset = 5 				-- отступ для полуобводки
					fontType = fontType or 4
					local currentFont = fontType == 1 and "Metrostroi_7404_VityazPU1" or fontType == 2 and "Metrostroi_7404_VityazPU2" or fontType == 3 and "Metrostroi_7404_VityazPU3" or "Metrostroi_7404_VityazPU4"
					surface.SetDrawColor(240,240,240)
					draw.RoundedBox(smooth, posX, posY, sizeX, sizeY, Train:GetNW2Bool("VityazMNMM"..buttonNumber) and green or colorGray)
					local oneLineOfText = (#text == 1)
					if oneLineOfText then
						draw.SimpleText(text[1],currentFont,posX+sizeX/2,posY+sizeY/2, Train:GetNW2Bool("VityazMNMM"..buttonNumber) and green or colorWhite,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					else
						draw.SimpleText(text[1],currentFont,posX+sizeX/2,posY+border, Train:GetNW2Bool("VityazMNMM"..buttonNumber) and green or colorWhite,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
						draw.SimpleText(text[2],currentFont,posX+sizeX/2,posY+sizeY-border, Train:GetNW2Bool("VityazMNMM"..buttonNumber) and green or colorWhite,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					end
				end
				--VityazCountOfTriggers
				local buttonPosY = lowerTextYpos+10
				local buttonPoxX = 350 -- textBoxPosX+textBoxSizeX*2.35+textBoxXoffset*2.35 -- это 392.2
				local defSize = 52
				local defSmt = 5
				local buttonXOffset = 15
				local buttonXoffsetBig = 11
				local buttonYoffset = 4
				local buttonYoffsetBig = 9
				-- Левый ряд
				setButton(buttonPoxX,buttonPosY,defSmt,{defSize},{"РЕЖ"},13,2)
				setButton(buttonPoxX+defSize+buttonXOffset,buttonPosY,defSmt,{defSize},{"ПВУ"},14,2)
				setButton(buttonPoxX,buttonPosY+defSize+buttonYoffset,defSmt,{defSize},{"ВО"},15,2)
				setButton(buttonPoxX+defSize+buttonXOffset,buttonPosY+defSize+buttonYoffset,defSmt,{defSize},{"t°"},16,2)
				setButton(buttonPoxX,buttonPosY+defSize*2+buttonYoffset*2,defSmt,{defSize},{"ТОК"},17,2)
				setButton(buttonPoxX+defSize+buttonXOffset,buttonPosY+defSize*2+buttonYoffset*2,defSmt,{defSize},{"СОТ"},18,2)
				setButton(buttonPoxX,buttonPosY+defSize*3+buttonYoffset*3,defSmt,{defSize},{"СКОР"},19,2)
				setButton(buttonPoxX+defSize+buttonXOffset,buttonPosY+defSize*3+buttonYoffset*3,defSmt,{defSize},{"№"},20,2)
				-- Центральные цифры
				local centralButtonPosX = buttonPoxX+buttonXoffsetBig+defSize*2+buttonXOffset*2
				setButton(centralButtonPosX,buttonPosY,defSmt,{defSize},{"1","БВ"},1)
				setButton(centralButtonPosX+defSize+buttonXOffset,buttonPosY,defSmt,{defSize},{"2","ДВЕРИ"},2)
				setButton(centralButtonPosX+defSize*2+buttonXOffset*2,buttonPosY,defSmt,{defSize},{"3","МК"},3)
				setButton(centralButtonPosX,buttonPosY+defSize+buttonYoffset,defSmt,{defSize},{"4","ТКПР"},4)
				setButton(centralButtonPosX+defSize+buttonXOffset,buttonPosY+defSize+buttonYoffset,defSmt,{defSize},{"5","ОСВ"},5)
				setButton(centralButtonPosX+defSize*2+buttonXOffset*2,buttonPosY+defSize+buttonYoffset,defSmt,{defSize},{"6","ТОРЦ"},6)
				setButton(centralButtonPosX,buttonPosY+defSize*2+buttonYoffset*2,defSmt,{defSize},{"7","ВЕНТ"},7)
				setButton(centralButtonPosX+defSize+buttonXOffset,buttonPosY+defSize*2+buttonYoffset*2,defSmt,{defSize},{"8","ББЭ"},8)
				setButton(centralButtonPosX+defSize*2+buttonXOffset*2,buttonPosY+defSize*2+buttonYoffset*2,defSmt,{defSize},{"9","ТП"},9)
				setButton(centralButtonPosX,buttonPosY+defSize*3+buttonYoffset*3,defSmt,{defSize},{"СБР"},10,2)
				setButton(centralButtonPosX+defSize+buttonXOffset,buttonPosY+defSize*3+buttonYoffset*3,defSmt,{defSize},{"0"},11,2)
				setButton(centralButtonPosX+defSize*2+buttonXOffset*2,buttonPosY+defSize*3+buttonYoffset*3,defSmt,{defSize},{"ВЫБ"},12,2)
				-- Нижние четыре
				setButton(buttonPoxX,buttonPosY+buttonYoffsetBig+defSize*4+buttonYoffset*4,defSmt,{defSize},{"УПР","ТВ"},25)
				setButton(buttonPoxX+defSize+buttonXOffset,buttonPosY+buttonYoffsetBig+defSize*4+buttonYoffset*4,defSmt,{defSize},{"ТВ1"},26,2)
				setButton(centralButtonPosX,buttonPosY+buttonYoffsetBig+defSize*4+buttonYoffset*4,defSmt,{defSize},{"ТВ2"},27,2)
				setButton(centralButtonPosX+defSize+buttonXOffset,buttonPosY+buttonYoffsetBig+defSize*4+buttonYoffset*4,defSmt,{defSize},{""},28)
				local centralButtonPosX = buttonPoxX+buttonXoffsetBig+defSize*2+buttonXOffset*2
				-- Правый ряд + ввод
				setButton(centralButtonPosX+defSize*3+buttonXOffset*2+buttonXoffsetBig*2,buttonPosY,defSmt,{defSize},{"↑"},21,3)
				setButton(centralButtonPosX+defSize*3+buttonXOffset*2+buttonXoffsetBig*2,buttonPosY+defSize+buttonYoffset,defSmt,{defSize},{"↓"},22,3)
				setButton(centralButtonPosX+defSize*3+buttonXOffset*2+buttonXoffsetBig*2,buttonPosY+defSize*2+buttonYoffset*2,defSmt,{defSize},{"→"},23,3)
				setButton(centralButtonPosX+defSize*3+buttonXOffset*2+buttonXoffsetBig*2,buttonPosY+defSize*3+buttonYoffset*3,defSmt,{defSize},{"←"},24,3)
				setButton(centralButtonPosX+defSize*2+buttonXOffset*2,buttonPosY+buttonYoffsetBig+defSize*4+buttonYoffset*4,defSmt,{defSize*1.93+buttonXoffsetBig,defSize},{"ВВОД"},29,1)
				--setButton(textBoxPosX+textBoxSizeX*2.35+textBoxXoffset*2.35,buttonPosY,4,{40},{2,"1","БВ"},1)
			end
		elseif self.State == 1 or self.WrongPassword == false then
			if os.date( "%m-%d" ) == "04-01" then
				self:PrintText(0,4,"В̵̓в̴͓е̵̲д̸̲͂и̷̬̕т̷̥ё̴̜́͑п̙а̷̬̜̒р̴̲оль̴",yellow)
			else
				if os.date( "%m-%d" ) == "05-15" then
				self:PrintText(1,4,"С днем рождения Московского метро :)",yellow)
			else				
				self:PrintText(12,4,"Введите  пароль",yellow)
			end
			end
			--print("тута")
			local pass = Train:GetNW2String("VityazPass","")
			self:PrintText(20-0.5*#pass,6.5,pass..string.rep(" ",4-#pass),purple)
            local yPOS = 20
			--
            for i=0,1 do
                self:PrintText(0,yPOS+i/1.5,"█",Color(6,37,89,brTotal),3)--23
                self:PrintText(1,yPOS+i/1.5,"█",Color(6,37,89,brTotal),3)--23

                self:PrintText(2,yPOS+i/1.5,"█",Color(30,75,28,brTotal),3)--23
                self:PrintText(3,yPOS+i/1.5,"█",Color(30,75,28,brTotal),3)--23

                self:PrintText(4,yPOS+i/1.5,"█",Color(28,105,109,brTotal),3)--23
                self:PrintText(5,yPOS+i/1.5,"█",Color(28,105,109,brTotal),3)--23

                self:PrintText(6,yPOS+i/1.5,"█",Color(77,14,14,brTotal),3)--23
                self:PrintText(7,yPOS+i/1.5,"█",Color(77,14,14,brTotal),3)--23

                self:PrintText(8,yPOS+i/1.5,"█",darkpurple,3)--ахахах пле
                self:PrintText(9,yPOS+i/1.5,"█",darkpurple,3)--пле сука оррр

                self:PrintText(10,yPOS+i/1.5,"█",Color(100,90,27,brTotal),3)
                self:PrintText(11,yPOS+i/1.5,"█",Color(100,90,27,brTotal),3)

                self:PrintText(12,yPOS+i/1.5,"█",Color(108,113,117,brTotal),3)
                self:PrintText(13,yPOS+i/1.5,"█",Color(108,113,117,brTotal),3)

                self:PrintText(14,yPOS+i/1.5,"█",Color(0,0,0,brTotal),3)
                self:PrintText(15,yPOS+i/1.5,"█",Color(0,0,0,brTotal),3)

                self:PrintText(16,yPOS+i/1.5,"█",blue,3)
                self:PrintText(17,yPOS+i/1.5,"█",blue,3)
				
                self:PrintText(18,yPOS+i/1.5,"█",green,3)
                self:PrintText(19,yPOS+i/1.5,"█",green,3)

                self:PrintText(20,yPOS+i/1.5,"█",aqua,3)
                self:PrintText(21,yPOS+i/1.5,"█",aqua,3)

                self:PrintText(22,yPOS+i/1.5,"█",red,3)
                self:PrintText(23,yPOS+i/1.5,"█",red,3)
				
                self:PrintText(24,yPOS+i/1.5,"█",purple,3)
                self:PrintText(25,yPOS+i/1.5,"█",purple,3)

                self:PrintText(26,yPOS+i/1.5,"█",yellow,3)
                self:PrintText(27,yPOS+i/1.5,"█",yellow,3)
    
                self:PrintText(28,yPOS+i/1.5,"█",white,3)
                self:PrintText(29,yPOS+i/1.5,"█",white,3)
				
                self:PrintText(30,yPOS+i/1.5,"█",Color(6,37,89,brTotal),3)--23
                self:PrintText(31,yPOS+i/1.5,"█",Color(6,37,89,brTotal),3)--23
				
                self:PrintText(32,yPOS+i/1.5,"█",Color(30,75,28,brTotal),3)--23
                self:PrintText(33,yPOS+i/1.5,"█",Color(30,75,28,brTotal),3)--23

                self:PrintText(34,yPOS+i/1.5,"█",Color(28,105,109,brTotal),3)--23
                self:PrintText(35,yPOS+i/1.5,"█",Color(28,105,109,brTotal),3)--23
				
                self:PrintText(36,yPOS+i/1.5,"█",Color(77,14,14,brTotal),3)--23
                self:PrintText(37,yPOS+i/1.5,"█",Color(77,14,14,brTotal),3)--23
				
                self:PrintText(38,yPOS+i/1.5,"█",darkpurple,3)
                self:PrintText(39,yPOS+i/1.5,"█",darkpurple,3)
            end
		elseif self.State == 2 then
			local enter = Train:GetNW2String("VityazEnter","-")
			if enter == "-" then enter = false end
			if state2 == 0 then
				self:PrintText(17,2,"Режим ДЕПО",yellow)
				self:PrintText(2,4,"1 Тип и номера вагонов",yellow)
					self:PrintText(36,4,">",blue)
				self:PrintText(2,6,"2 Дата",yellow)
					if sel == 1 and enter then self:PrintText(33,6,enter..string.rep("█",4-#enter),yellow) else self:PrintText(33,6,Format("%04d", Train:GetNW2String("VityazDate",os.date("%d".."%m"))),yellow) end
				self:PrintText(2,8,"3 Время выдачи состава",yellow)
					if sel == 2 and enter then self:PrintText(33,8,enter..string.rep("█",4-#enter),yellow) else self:PrintText(33,8,Format("%04d", Train:GetNW2String("VityazTime",os.date("%H".."%M"))),yellow) end
				self:PrintText(2,10,"4 Номер маршрута",yellow)
					if sel==3 and enter then self:PrintText(35,10,enter..string.rep("█",2-#enter),yellow) else self:PrintText(35,10,Format("%02d", Train:GetNW2String("VityazRouteNumber","0")),yellow) end
				self:PrintText(2,12,"5 Число вагонов",yellow)
					if sel==4 and enter then self:PrintText(35,12,enter..string.rep("█",2-#enter),yellow) else self:PrintText(35,12,Format("%02d", Train:GetNW2Int("VityazWagNum","0")),yellow) end
				self:PrintText(2,14,"6 Диаметр бандажа КП",yellow)
					self:PrintText(34,14,"860",yellow)
				self:PrintText(2,16,"7 Код депо",yellow)
					if sel==6 and enter then self:PrintText(34,16,enter..string.rep("█",3-#enter),yellow) else self:PrintText(34,16,Format("%03d", Train:GetNW2String("VityazDepotCode","0")),yellow) end
				self:PrintText(2,18,"8 Номер станции отправления",yellow)
					if sel==7 and enter then self:PrintText(35,18,enter..string.rep("█",2-#enter),yellow) else self:PrintText(35,18,Format("%02d", Train:GetNW2String("VityazDepeatStation","0")),yellow) end
				self:PrintText(2,20,"9 Номер пути",yellow)
					if sel==8 and enter then self:PrintText(36,20,enter..string.rep("█",1-#enter),yellow) else self:PrintText(36,20,Format("%d", Train:GetNW2String("VityazPath","0")),yellow) end
				self:PrintText(2,22,"10 Направление движения",yellow)
					if sel==9 and enter then self:PrintText(36,22,enter..string.rep("█",1-#enter),yellow) else self:PrintText(36,22,Format("%d", Train:GetNW2String("VityazDir","0")),yellow) end
			self:PrintText(37, 4+sel*2,"<",blue)
			elseif state2 == 1 then
				self:PrintText(10,2,"ТИП И НОМЕРА ВАГОНОВ",yellow)
				self:PrintText(5,4,"№ ваг.",yellow)
				self:PrintText(13,4,"код типа",yellow)
					self:PrintText(22,4,"заводской №",yellow)
				for i=1,9 do
					self:PrintText(6,4+i*2,tostring(i),yellow)
					self:PrintText(17,4+i*2,"2",yellow)
					if not enter or sel ~= i-1 then
						self:PrintText(26,4+i*2,Format("%04d",Train:GetNW2Int("VityazWagNum"..i)),yellow)
					end
				end
				if enter then
					self:PrintText(26,6+sel*2,enter..string.rep("█",4-#enter),yellow)
				end
				self:PrintText(32,6+sel*2,"<",blue)
			end
		elseif self.State == 3 then
		local init = Train:GetNW2Bool("VityazNotInitialize",false)
		if init then --[[surface.SetTexture(State5) surface.SetDrawColor(255,255,255) surface.DrawTexturedRectRotated(512,512,1024,1024,0) ]] else
			self:PrintText(14,4,"Неиндентифиц ваг",yellow)
			for i=1,wagnum do
				self:PrintText(15+i+(9-wagnum)/2,6,"█",Train:GetNW2Bool("VityazWagI"..i,false) and green or red)
			end
		end
		elseif self.State == 4 then
		local xbase,ybase =  10,5
		self:PrintText(xbase+4,ybase,"Основной   ПУ",yellow)
		self:PrintText(xbase+10,ybase+1,"█",Train:GetNW2Bool("VityazBTestStand") and green or red)
		self:PrintText(xbase+13,ybase+1,"█",Train:GetNW2Bool("VityazBTestALS") and green or red)
		self:PrintText(xbase+16,ybase+1,"█",Train:GetNW2Bool("VityazBTestAccelrate") and green or red)
			self:PrintText(xbase+19,ybase+1,"█",Train:GetNW2Bool("VityazBTestRing") and green or red)
		self:PrintText(xbase+8,ybase+2,"█",Train:GetNW2Bool("VityazBTestTPT") and green or red)
		--self:PrintText(2,9,"█",Train:GetNW2Bool("VityazBTestDoorSelectL") and green or red)
			--self:PrintText(4,9,"█",Train:GetNW2Bool("VityazBTestDoorSelectR") and green or red)
		self:PrintText(xbase+3,ybase+3,"█",Train:GetNW2Bool("VityazBTestDoorBlock") and green or red)
			self:PrintText(xbase+9,ybase+3,"█",Train:GetNW2Bool("VityazBTestDoorClose") and green or red)
			self:PrintText(xbase+12,ybase+3,"█",Train:GetNW2Bool("VityazBTestAttentionMessage") and green or red)
			self:PrintText(xbase+15,ybase+3,"█",Train:GetNW2Bool("VityazBTestAttention") and green or red)
			self:PrintText(xbase+18,ybase+3,"█",Train:GetNW2Bool("VityazBTestAttentionBrake") and green or red)
		self:PrintText(xbase+2,ybase+4,"█",Train:GetNW2Bool("VityazBTestDoorLeft") and green or red)
			self:PrintText(xbase+19,ybase+4,"█",Train:GetNW2Bool("VityazBTestDoorRight") and green or red)
		self:PrintText(xbase+1,ybase+6,"Вспомогательный ПУ",yellow)
		self:PrintText(xbase+1,ybase+7,"█",Train:GetNW2Bool("VityazBTestPant1") and green or red)
			self:PrintText(xbase+3,ybase+7,"█",Train:GetNW2Bool("VityazBTestPant2") and green or red)
			self:PrintText(xbase+13,ybase+7,"█", red)
			self:PrintText(xbase+15,ybase+7,"█",Train:GetNW2Bool("VityazBTestPassLight") and green or red)
			--self:PrintText(15,15,"█",Train:GetNW2Bool("VityazBTestVent2") and green or red)
		self:PrintText(xbase+5,ybase+8,"█",Train:GetNW2Bool("VityazBTestTorecDoors") and green or red)
			self:PrintText(xbase+7,ybase+8,"█",Train:GetNW2Bool("VityazBTestBBE") and green or red)
			self:PrintText(xbase+9,ybase+8,"█",Train:GetNW2Bool("VityazBTestCompressor") and green or red)
		self:PrintText(xbase,ybase+12,"Исправных клавиш",yellow)
		self:PrintText(xbase+18,ybase+12,tostring(Train:GetNW2Int("VityazBTest")),yellow)
		elseif self.State == 5 and mainmsg > 0 then
			if mainmsg == 3 then
				self:PrintText(14,2,"Включены 2 РВ",yellow)
			elseif mainmsg == 2 then
				self:PrintText(14,2,"Хвостовой ПУ",yellow)
			else
				self:PrintText(14,2,"РВ отключены",yellow)
			end
			for i = 1,wagnum do
				if not Train:GetNW2Bool("VityazMBTBR"..i,false) then
					self:PrintText(10,3,"█████ █████ █████", red)
					self:PrintText(10,4,"█       █   █", red)
					self:PrintText(10,5,"█       █   █", red)
					self:PrintText(10,6,"█████   █   █████", red)
					self:PrintText(10,7,"█   █   █   █   █", red)
					self:PrintText(10,8,"█   █   █   █   █", red)
					self:PrintText(10,9,"█████   █   █████", red)
				end
			end
		elseif self.State == 5 and state2 == 1 then
			self:PrintText(21,14,"ТЕМПЕРАТУРА САЛОНА",yellow)
			for i=1,wagnum do
				self:PrintText(22,15+i,tostring(i).."-й вагон",yellow)
				self:PrintText(32,15+i,"00.0",aqua)
			end
		elseif self.State == 5 and state2 == 2 then
			self:PrintText(21,15,"№",yellow)
			if sel == 0 then
				self:PrintText(25,13,"ТОКИ",yellow)
				self:PrintText(24,15,"ВО",yellow)
				self:PrintText(30,15,"МК",yellow)
				self:PrintText(34,13,"НАПРЯЖ",yellow)
				self:PrintText(36,15,"БС",yellow)
				for i = 1,wagnum do 
					self:PrintText(21,16+i,tostring(i),yellow)
					self:PrintText(23,16+i,Format("%03d",Train:GetNW2Int("VityazIVO"..i,0)/10),green)
					self:PrintText(29,16+i,Format("%04.1f",Train:GetNW2Int("VityazIMK"..i,0)/10),aqua)
					self:PrintText(36,16+i,Format("%02d",Train:GetNW2Int("VityazLV"..i,0)),red)
				end
			elseif sel == 1 then
				self:PrintText(23,13,"УСИЛИЕ",yellow)
				self:PrintText(23,15,"ТЯГ",yellow)
				self:PrintText(28,15,"ТОРМ",yellow)
				if not isOld then
					self:PrintText(33,13,"ЭНЕРГИЯ",yellow)
					self:PrintText(34,15,"ПОТР",yellow)
				end
				for i = 1,wagnum do 
					self:PrintText(21,16+i,tostring(i),yellow)
					self:PrintText(29,16+i,Format("%02d",Train:GetNW2Int("VityazBrakeStrength"..i,0)*2),aqua)
					self:PrintText(23,16+i,Format("%02d",Train:GetNW2Int("VityazDriveStrength"..i,0)*2),green)
					if not isOld then self:PrintText(33,16+i,Format("%07.1f",Train:GetNW2Float("VityazElectricEnergyUsed"..i,0)),red) end
				end
			end
		elseif self.State == 5 and state2 == 0 then
			self:PrintText(23,13,"НОМЕРА ВАГ",yellow)
			self:PrintText(23,15,"№ ваг",yellow)
			self:PrintText(29,15,"зав №",yellow)
			self:PrintText(36,15,"ОР",yellow)
			for i=1,wagnum do
				self:PrintText(25,16+i,tostring(i),yellow)
				self:PrintText(30,16+i,Format("%04d",Train:GetNW2Int("VityazWagNum"..i)),yellow)
				if Train:GetNW2Bool("VityazWagOr"..i) then
					self:PrintText(37,16+i,"о",yellow) -- я хуй знает почему, но тут рил маленькие буквы
				else
					self:PrintText(37,16+i,"п",purple)
				end
			end
		elseif self.State == 5 and state2 == 3 then
			self:PrintText(20,14,"ПРОТИВОЮЗОВАЯ ЗАЩИТА",yellow)
			self:PrintText(20,15,"№ вагона:",yellow)
			for i = 1,wagnum do
				for a = 1,2 do
					self:PrintText(29+i,15,tostring(i),yellow)
					self:PrintText(29+i,15+a,"█",Train:GetNW2Bool("VityazPSOT"..i) and green or purple)
					self:PrintText(29+i,17+a,"█",Train:GetNW2Bool("VityazMSOT"..i) and green or purple)
					self:PrintText(29+i,19+a,"█",Train:GetNW2Bool("VityazPSOT"..i) and green or purple)
					self:PrintText(29+i,22,"█", green)
					---self:PrintText(30+i,21,"█", green)
					for s = 1,6 do
						self:PrintText(22,15+s,"сот "..s,yellow)
					end
					self:PrintText(22,22,"мех з",yellow)
					--self:PrintText(23,21,"дукс",yellow)
				end
			end
		elseif self.State == 5 and state2 == 4 then
			local iCount
			local xPos			
			for w=1,wagnum do
				if sel < 2 then self:PrintText(24,13,"СОСТОЯНИЕ ВО",yellow) self:PrintText(22,14,"№ вагона:",yellow) self:PrintText(31+w,14,tostring(w),yellow) iCount = 7 
				elseif sel >= 2 then self:PrintText(21,14,"№ вагона",yellow) self:PrintText(29+w,14,tostring(w),yellow) iCount = 6 self:PrintText(25,13,"КЛИМАТ "..sel-1,yellow) end
				if sel == 0 then
					self:PrintText(23,15,"муфта",yellow)
					self:PrintText(31+w,15,"█",Train:GetNW2Bool("VityazMufta"..w,false) and green or purple)
					self:PrintText(23,16,"буксы",yellow)
					self:PrintText(31+w,16,"█",Train:GetNW2Bool("VityazAxles"..w,false) and green or purple)
					self:PrintText(23,17,"мк",yellow)
					if not Train:GetNW2Bool("VityazRPVU".."2"..w,false) then 
						self:PrintText(31+w,17,"█",Train:GetNW2Bool("VityazCompressor"..w,false) and green or purple)
					else
						self:PrintText(31+w,17,"Р", red)
					end
					self:PrintText(23,18,"торц дв",yellow)
					if not Train:GetNW2Bool("VityazRPVU".."6"..w,false) then 
						self:PrintText(31+w,18,"█",Train:GetNW2Bool("VityazDoorBlock"..w,false) and green or purple)
					else
						self:PrintText(31+w,18,"Р", red)
					end
					self:PrintText(23,19,"осв вкл",yellow)
					if not Train:GetNW2Bool("VityazRPVU".."5"..w,false) then 
						self:PrintText(31+w,19,"█",Train:GetNW2Bool("VityazLightsWork"..w,false) and green or purple)
					else
						self:PrintText(31+w,19,"Р", red)
					end
					self:PrintText(23,20,"неис тп",yellow)
					self:PrintText(31+w,20,"█",Train:GetNW2Bool("VityazTPFailure"..w,false) and green or purple)
					self:PrintText(23,21,"торм об",yellow)
					self:PrintText(31+w,21,"█",Train:GetNW2Bool("VityazPTWork"..w,false) and green or purple)
					self:PrintText(23,22,"торм рк",yellow)
					self:PrintText(31+w,22,"█",Train:GetNW2Bool("VityazEmPT"..w,false) and green or purple)
				elseif sel == 1 then
					self:PrintText(22,15,"ткпр отж",yellow)
					if not Train:GetNW2Bool("VityazRPVU".."4"..w,false) then 
						self:PrintText(31+w,15,"█",Train:GetNW2Bool("VityazPantDisabled"..w,false) and green or purple)
					else
						self:PrintText(31+w,15,"Р", red)
					end
					self:PrintText(22,16,"напр кс",yellow)
					self:PrintText(31+w,16,"█",Train:GetNW2Bool("VityazHVGood"..w,false) and green or purple)
					self:PrintText(22,17,"пт эфф",yellow)
					self:PrintText(31+w,17,"█",Train:GetNW2Bool("VityazPTEff"..w,false) and green or purple)
					self:PrintText(22,18,"отказ эт",yellow)
					self:PrintText(31+w,18,"█",Train:GetNW2Bool("VityazEDTBroken"..w,false) and green or purple)
					self:PrintText(22,19,"защ инв",yellow)
					self:PrintText(31+w,19,"█",Train:GetNW2Bool("VityazInvPro"..w,false) and green or purple)
					self:PrintText(22,20,"пер инв",yellow)
					self:PrintText(31+w,20,"█",Train:GetNW2Bool("VityazInvOverH"..w,false) and green or purple)
					self:PrintText(22,21,"неис втр",yellow)
					self:PrintText(31+w,21,"█",Train:GetNW2Bool("VityazVTR"..w,false) and green or purple)
					self:PrintText(22,22,"межваг с",yellow)
					self:PrintText(31+w,22,"█",Train:GetNW2Bool("VityazMejWag"..w,false) and green or purple)
				elseif sel == 2 then
					if Train:GetNW2Bool("VityazMKK1Mode",false) then
						self:PrintText(29+w,15,"З",aqua2)
					else
						self:PrintText(29+w,15,"Л",red)
					end
				elseif sel == 3 then
					if Train:GetNW2Bool("VityazMKK2Mode",false) then
						self:PrintText(29+w,15,"З",aqua2)
					else
						self:PrintText(29+w,15,"Л",red)
					end
				end
				if sel > 1 then
					self:PrintText(21,16,"кк вкл",yellow)
					self:PrintText(29+w,16,"█",Train:GetNW2Bool("VityazKKFull"..w,false) and green or purple)
					self:PrintText(21,17,"кк неис",yellow)
					self:PrintText(29+w,17,"█",Train:GetNW2Bool("VityazKKGreen"..w,false) and green or purple)
					self:PrintText(21,18,"ав вент",yellow)
					self:PrintText(29+w,18,"█",Train:GetNW2Bool("VityazKKEmer"..w,false) and green or purple)
					self:PrintText(21,19,"вент",yellow)
					--[[if not Train:GetNW2Bool("VityazRPVU".."7"..w,false) then 
						self:PrintText(29+w,16,"█",Train:GetNW2Bool("VityazKKFull"..w,false) and green or purple)
					else
						self:PrintText(29+w,16,"Р", red)
					end]]
					self:PrintText(29+w,19,"█",Train:GetNW2Bool("VityazKKGreen"..w,false) and green or purple)
					self:PrintText(29+w,21,"█",Train:GetNW2Bool("VityazKKGreen"..w,false) and green or purple)
					self:PrintText(21,20,"охлаж",yellow)
					self:PrintText(21,21,"отопл",yellow)
					self:PrintText(21,22,"датчики",yellow)
					self:PrintText(29+w,20,"█",Train:GetNW2Bool("VityazKKGreen"..w,false) and green or purple)
					self:PrintText(29+w,21,"█",Train:GetNW2Bool("VityazKKGreen"..w,false) and green or purple)
					self:PrintText(29+w,22,"█",Train:GetNW2Bool("VityazKKGreen"..w,false) and green or purple)
				end
			end
		elseif self.State == 5 and state2 == 5 then
			self:PrintText(23,13,"СОСТОЯНИЕ ДВЕРЕЙ",yellow)
			self:PrintText(21,15,"№",yellow)
			self:PrintText(23,15,"левые",yellow)
			self:PrintText(31,15,"правые",yellow)
			self:PrintText(38,15,"ор",yellow)
			for i=1,wagnum do
				if i == 1 or i == wagnum then
					doorcount = 5
				else
					doorcount = 6
				end
				local orient = Train:GetNW2Bool("VityazWagOr"..i)
				self:PrintText(21,16+i,tostring(i),yellow)
				for d=1,doorcount do
					self:PrintText(i == 1 and 23+d or 23+d and orient and 22+d or 30+d,16+i,"█",Train:GetNW2Bool("VityazDoor"..d.."L"..i,false) and green or red)
					self:PrintText(i == 1 and 31+d or 30+d and orient and 30+d or 22+d,16+i,"█",Train:GetNW2Bool("VityazDoor"..d.."R"..i,false) and green or red) 
				end
				if Train:GetNW2Bool("VityazWagOr"..i) then
					self:PrintText(38,16+i,"О",yellow)
				else
					self:PrintText(38,16+i,"П",purple)
				end
			end
		elseif self.State == 5 and state2 == 6 then
			self:PrintText(21,13,"ПОВАГОННОЕ УПРАВЛ-Е",yellow)
			self:PrintText(23,14,"вагон  №",yellow)
				self:PrintText(37,14,tostring(sel),purple)
			self:PrintText(21,15,"1 бв",yellow)
				self:PrintText(36,15,Train:GetNW2Bool("VityazPVU1") and "выкл" or "вкл",yellow)
			self:PrintText(21,16,"2 двери",yellow)
				self:PrintText(36,16,Train:GetNW2Bool("VityazPVU2") and "блок" or "небл",yellow)
			self:PrintText(21,17,"3 компрессор",yellow)
				self:PrintText(36,17,Train:GetNW2Bool("VityazPVU3") and "выкл" or "вкл",yellow)
			self:PrintText(21,18,"4 токопр",yellow)
				self:PrintText(36,18,Train:GetNW2Bool("VityazPVU4") and "отж" or "приж",yellow)
			self:PrintText(21,19,"5 освещ",yellow)
				self:PrintText(36,19,Train:GetNW2Bool("VityazPVU5") and "выкл" or "вкл",yellow)
			self:PrintText(21,20,"6 блокир т/дв",yellow)
				self:PrintText(36,20,Train:GetNW2Bool("VityazPVU6") and "выкл" or "вкл",yellow)
			self:PrintText(21,21,"7 вентил",yellow)
				self:PrintText(36,21,Train:GetNW2Bool("VityazPVU7") and "выкл" or "вкл",yellow)
			self:PrintText(21,22,"8 ббэ",yellow)
				self:PrintText(36,22,Train:GetNW2Bool("VityazPVU8") and "выкл" or "вкл",yellow)
			self:PrintText(21,23,"9 тяг привод",yellow)
				self:PrintText(36,23,Train:GetNW2Bool("VityazPVU9") and "выкл" or "вкл",yellow)
		end
		if self.State == 5 and mainmsg == 0 and state2 >= 0 then
			local init = Train:GetNW2Bool("VityazNotInitialize", false)
			if init then
				-- Выравнивание
				---- Слева
				local xAddOffset = 1 --1.05
				local cb = 10+xAddOffset -- cubebegin

				--
				if err > 0 then self:PrintText(2+xAddOffset,1,"█",Color(80,10,10,brTotal)) end
				if err > 0 and self.Counter%70 > 35  then	self:PrintText(3,1,"?", yellow) end -- Пока что пусть будет так # ПРОВЕРЬТЕ НА ЛАГИ
				self:PrintText(4+xAddOffset,1,"РЕЖИМ:",yellow)
					local typ = Train:GetNW2Int("VityazType",0)
					if typ == 1 then self:PrintText(12,1,"ХОД",red)
					elseif typ == 0 then self:PrintText(12,1,"ВЫБЕГ",red)
					elseif typ == -1 then self:PrintText(12,1,"ТОРМОЗ",red) end
				self:PrintText(2+xAddOffset,3,"№ вагона:",yellow)
					for i=1,wagnum do
						self:PrintText(11+i,3,tostring(i),yellow)
					end
				if Train:GetNW2Bool("ProstVersion",false) then
					self:PrintText(5+xAddOffset,5,"двери:",yellow)
				else
					self:PrintText(3+xAddOffset,5,"двери  :",yellow)
					self:PrintText(8+xAddOffset,5,"Л",Train:GetNW2Bool("ProstDoorBlockL",false) and green or purple)
					self:PrintText(9+xAddOffset,5,"П",Train:GetNW2Bool("ProstDoorBlockR",false) and green or purple)
				end
				for i=1,wagnum do	-- Двери
					if not Train:GetNW2Bool("VityazRPVU".."2"..i,false) then 
						self:PrintText(cb+i,5,"█",Train:GetNW2Bool("VityazDoors"..i,false) and green or red) 
					else
						self:PrintText(cb+i,5,"Р",red) 
					end
					if not Train:GetNW2Bool("VityazRPVU".."1"..i,false) then -- Бв
						self:PrintText(cb+i,6,"█",Train:GetNW2Bool("VityazBV"..i,false) and green or red)
					else
						self:PrintText(cb+i,6,"Р",red) 
					end
					if not Train:GetNW2Bool("VityazRPVU".."9"..i,false) then -- Сбор сх
						self:PrintText(cb+i,7,"█",Train:GetNW2Bool("VityazScheme"..i,false) and green or purple)
					else
						self:PrintText(cb+i,7,"Р",red) 
					end
					self:PrintText(cb+i,8,"█",Train:GetNW2Bool("VityazMPT"..i,false) and green or purple)			-- пт вкл
					self:PrintText(cb+i,9,"█",Train:GetNW2Bool("VityazMPB"..i,false) and green or purple)			-- ст торм
					self:PrintText(cb+i,10,"█",Train:GetNW2Bool("VityazMEB"..i,false) and green or purple)			-- экс торм
					self:PrintText(cb+i,11,"█",Train:GetNW2Bool("VityazMBUV"..i,false) and purple or green)			-- був
					self:PrintText(cb+i,12,"█",Train:GetNW2Bool("VityazMBBEBroken"..i,false) and green or purple) 	-- защ ипп
					self:PrintText(cb+i,13,"█",Train:GetNW2Bool("VityazMRessora"..i,false) and green or purple)		-- рессора
					self:PrintText(cb+i,14,"█",Train:GetNW2Bool("VityazMDUKS"..i,false) and green or purple)		-- дукс
					self:PrintText(cb+i,15,"█",Train:GetNW2Bool("VityazMBTBR"..i,false) and green or purple)		-- бтб гот
					if not Train:GetNW2Bool("VityazRPVU".."7"..i,false) then
						self:PrintText(cb+i,17,"█",  Train:GetNW2Bool("VityazKKFull"..i,false) and green or Train:GetNW2Bool("VityazKKEmer"..i,false) and yellow or purple)			-- климат 2
						self:PrintText(cb+i,16,"█", Train:GetNW2Bool("VityazKKFull"..i,false) and green or Train:GetNW2Bool("VityazKKEmer"..i,false) and yellow or purple)			-- климат 1
					else
						self:PrintText(cb+i,16,"Р",red)
						self:PrintText(cb+i,17,"Р",red)
					end
				end
				self:PrintText(8+xAddOffset,6,"бв:",yellow)
				self:PrintText(3+xAddOffset,7,"сбор сх:",yellow)
				if Train:GetNW2Bool("VityazMRecuperation",false) then
					self:PrintText(1+xAddOffset,7,"р", green)
				end
				self:PrintText(4+xAddOffset,8,"пт вкл:",yellow)
				self:PrintText(3+xAddOffset,9,"ст торм:",yellow)
				self:PrintText(3+xAddOffset,10,"экс тор:",yellow)
				self:PrintText(7+xAddOffset,11,"був:",yellow)
				self:PrintText(3+xAddOffset,12,"защ ипп:",yellow)
				self:PrintText(3+xAddOffset,13,"рессора:",yellow)
				self:PrintText(6+xAddOffset,14,"дукс:",yellow)
				self:PrintText(3+xAddOffset,15,"бтб гот:",yellow)
				self:PrintText(3+xAddOffset,16,"климат1:",yellow)
				self:PrintText(3+xAddOffset,17,"климат2:",yellow)
				if Train:GetNW2Bool("VityazMKK1Mode",false) then
					self:PrintText(1+xAddOffset,16,"з", aqua2)
				else
					self:PrintText(1+xAddOffset,16,"л", red)
				end
				if Train:GetNW2Bool("VityazMKK2Mode",false) then
					self:PrintText(1+xAddOffset,17,"з", aqua2)
				else
					self:PrintText(1+xAddOffset,17,"л", red)
				end

				self:PrintText(1+xAddOffset,19,"Pmin",yellow)
					self:PrintText(2+xAddOffset,20,Format("%.1f",Train:GetNW2Int("VityazPMin",0)/10),red)
				self:PrintText(6+xAddOffset,19,"Pmax",yellow)
					self:PrintText(7+xAddOffset,20,Format("%.1f",Train:GetNW2Int("VityazPMax",0)/10),red)
				self:PrintText(11+xAddOffset,19,"Pнм",yellow)
					self:PrintText(11+xAddOffset,20,Format("%.1f",Train:GetNW2Int("VityazPNM",0)/10),red)
				self:PrintText(15+xAddOffset,19,"Uбс",yellow)
					self:PrintText(15+xAddOffset,20,tostring(Train:GetNW2Int("VityazUbs",0)),red)
				if err > 0 then
					self:PrintText(2+xAddOffset,22,Errors[err],yellow)
				end
				-- Справа
				local xRightAddOffet = 2

				local BarsBlock = Train:GetNW2Int("VityazMBarsBlock",0)
				if BarsBlock == 1 then self:PrintText(33+xRightAddOffet,1,"барс2",yellow) elseif BarsBlock == 2 then self:PrintText(33+xRightAddOffet,1,"барс1",yellow) elseif BarsBlock == 3 then self:PrintText(33+xRightAddOffet,1,"уос",yellow) else --[[self:PrintText(33+xRightAddOffet,1,"выкл",yellow)]] end
				self:PrintText(22+xRightAddOffet,2,"БТБ",yellow)
						self:PrintText(26+xRightAddOffet,2,"█",Train:GetNW2Bool("VityazMBTB",false) and green or red)
				self:PrintText(29+xRightAddOffet,2,"АРС",yellow)
						self:PrintText(33+xRightAddOffet,2,"█",Train:GetNW2Bool("VityazMBARS1",false) and red or Train:GetNW2Bool("VityazDisableDrive",false) and yellow or green)
						self:PrintText(35+xRightAddOffet,2,"█",Train:GetNW2Bool("VityazMBARS2",false) and red or Train:GetNW2Bool("VityazDisableDrive",false) and yellow or green)
				local speed   = Train:GetNW2Int("VityazSpeed",0)
				local speedL  = Train:GetNW2Int("VityazSpeedLimit",0)
				local speedLN = Train:GetNW2Int("VityazSpeedLimitNext",-1)
				local noFreq  = Train:GetNW2Bool("BARSNoFreq")
				self:PrintText(22+xRightAddOffet,4,"V доп",yellow)
				self:PrintText(22+xRightAddOffet,6,"V факт",yellow)
				self:PrintText(22+xRightAddOffet,8,"V пред",yellow)
				for i=0,2 do self:PrintText(33+xRightAddOffet,4+i*2,"км/ч",yellow) end
					self:PrintText(speed > 9 and 30+xRightAddOffet or 31+xRightAddOffet,6,Format("%01d",speed),speedColor)
				if noFreq then
					self:PrintText(30+xRightAddOffet,8,"ОЧ",aqua)
					self:PrintText(30+xRightAddOffet,4,"ОЧ",aqua)
				elseif speedLN == -1 and speedL >= 20 then
					self:PrintText(speedLN > 9 and 30+xRightAddOffet or 31+xRightAddOffet,8,Format("%01d",0),aqua)
					self:PrintText(speedL > 9 and 30+xRightAddOffet or 31+xRightAddOffet,4,Format("%01d",speedL),red)
				else
					self:PrintText(speedLN > 9 and 30+xRightAddOffet or 31+xRightAddOffet,8,Format("%01d",speedLN),aqua)
					self:PrintText(speedL > 9 and 30+xRightAddOffet or 31+xRightAddOffet,4,Format("%01d",speedL),red)
				end
				local Prost = Train:GetNW2Bool("VityazProst",false)
				local Kos = Train:GetNW2Bool("VityazKos",false)
				local Metka,ProstActive,Kos2 = Train:GetNW2Bool("VityazProstMetka",false),Train:GetNW2Bool("VityazProstActive",false),Train:GetNW2Bool("VityazProstKos",false)
				self:PrintText(22+xRightAddOffet,10,"РЕЖИМ:",yellow)
				local alsfreq = Train:GetNW2Int("BARSFreq",0)
				local CurrentMode = ""
				local vityazs = Train:GetNW2Int("VityazS",-1000)/100
				local prostact = vityazs~=-1000 and (vityazs < 200 and ProstActive or Metka and vityazs > 200)
				
				if alsfreq == 1 and Train:GetNW2Bool("BARSLN") then 
					self:PrintText(37+xRightAddOffet,2,"Н", green)
				end
				if Train:GetNW2Bool("ProstVersion",false) then
					if prostact or ProstActive and speed > 0 then
						CurrentMode = "Пр Ост"
					else
						CurrentMode = (Prost and Kos2 and Metka) and "КОС" or alsfreq == 0 and "2/6" or alsfreq == 1 and "АБ" or alsfreq == 2 and "АРС-ДАУ" or "1/5"
					end
					self:PrintText(36+xRightAddOffet,10,"К",Prost and green or red)
				else
					CurrentMode = alsfreq == 1 and "ДНЕПР2/6" or "ДАУ"
					if ProstActive and speed > 0 then
						if Prost then
							self:PrintText(22+xRightAddOffet,1,"прост",Metka and green or gray)
							self:PrintText(22+xRightAddOffet,11,"норма", gray)
						end
					else
						if Prost then
							self:PrintText(22+xRightAddOffet,1,"прост",prostact and speed > 0 and green or gray)
							self:PrintText(22+xRightAddOffet,11,"норма", gray)
						end
					end
					if Kos then
						self:PrintText(29+xRightAddOffet,1,"кос",(Metka and Kos2) and green or gray)
					end
				end
				self:PrintText(28+xRightAddOffet,10,CurrentMode,yellow)
			else
				self:PrintText(4,1,"Зачем тебе так много вагонов?",yellow) -- Хз зачем, меня попросили это добавить
			end
		elseif self.State == 6 then
			surface.SetDrawColor(30,30,190)
			surface.DrawRect(0,0,1024,1024)
		end
		if self.State > 0 and self.State < 6 then
			if wagnum < 6 then
				local function tohex(num)
                    local charset = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"}
                    local tmp = {}
                    repeat
                        table.insert(tmp,1,charset[num%16+1])
                        num = math.floor(num/16)
                    until num==0
                    return table.concat(tmp)
                end
                --local prostTimer = Train:GetNW2Int("ProstTimer") + 4096
                local prostMark = Train:GetNW2Int("ProstMark") + 4096
                local prostTotalDist = Train:GetNW2Int("ProstTotalDist")
				local prostTimer = Train:GetNW2Int("ProstTimer") + 4096
				self:PrintText(0,24,Format("B%03d",self.Counter),darkpurple, 0)
				self:PrintText(5,24,"000"..Train:GetNW2Int("ProstStength"),yellow)
				self:PrintText(10,24,#tohex(prostTotalDist) == 1 and "000"..tohex(prostTotalDist) or #tohex(prostTotalDist) == 2 and "00"..tohex(prostTotalDist) or #tohex(prostTotalDist) == 3 and "0"..tohex(prostTotalDist) or "0000",yellow)
				self:PrintText(15,24,prostTimer > 4096 and tohex(prostTimer) or "0000",yellow)
				if mainmsg == 0 then
					self:PrintText(37,24,prostMark > 4096 and tohex(prostMark) or "0000",yellow)
				end
			end
		end
	end
end
