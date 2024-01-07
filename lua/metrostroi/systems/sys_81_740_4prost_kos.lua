--Original by CrIcKeT

Metrostroi.DefineSystem("81_740_4PROST")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.ProstActive = 0
	self.KosActive = 0
	self.Prost = false
	self.Kos = false
	self.Command = 0
	self.EmergencyBrake = 0
	self.CommandKos = false
	self.Stop = false	
	self.Stop1 = false 
	self.Metka = {}	
	
	self.BlockDoorsL = true
	self.BlockDoorsR = true
	
	self.Timer1 = CurTime()
	self.Metka1 = false
	self.WrongDir = false

	self.sum = 0
	self.dist2 = 350
	self.v0 = 0
end

function TRAIN_SYSTEM:Inputs()
	return { }
end

function TRAIN_SYSTEM:Outputs()
	return { "Command","Metka","ProstActive","EmergencyBrake","BlockDoorsL","BlockDoorsR","PrKos" }
end
	

function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	local Tspeed = Train.Speed
	--self.Timer = self.Timer or CurTime()
	local power = Train.Electric.Battery80V > 62 and Train.SFV34.Value == 1 and Train.ALSFreqBlock.Value ~= 1
	local RV = (1-Train.KV["KRO5-6"]) 	-- + Train.KV["KRR15-16"]  + (1-Train.SF2.Value)	
	
	self.Prost = power and Train.BUKP.Prost and Train.BUKP.State == 5 and Train:GetNW2Int("VityazMainMsg",0) == 0 and RV > 0
	self.Kos = power and Train.BUKP.Kos and Train.BUKP.State == 5 and Train:GetNW2Int("VityazMainMsg",0) == 0 and RV > 0
	if not power and (self.Metka1 or self.BlockDoorsL or self.BlockDoorsR) then
		self.BlockDoorsL = false			
		self.BlockDoorsR = false
		self.Metka1 = false
	end
	
    self.PrevTime = self.PrevTime or CurTime()
    self.DeltaTime = (CurTime() - self.PrevTime)
    self.PrevTime = CurTime()	
		
	if self.Prost then 
		if self.Metka[4] or self.Metka[2] or self.Metka[1] then
			self.sum = (self.sum + (self.v0+Train.Speed*Train.SpeedSign)*self.DeltaTime/7.2)
		else
			self.sum = 0
		end
		if self.Metka[4] then
			self.dist2 = 350-self.sum
		elseif self.Metka[2] then
			self.dist2 = 54-self.sum
		elseif self.Metka[1] then
			self.dist2 = 43-self.sum	--12	
		else
			self.dist2 = 350
		end
		if self.dist2 < -10 then
			self.dist2 = 350
		end
		local dist1 = self.dist2-200 --(x and stbl) and (stbl.x_start-x-11) or nil
		local dist3 = self.dist2--x and stbl and (stbl.x_end-x-20)			
		local dist2 = self.dist2--x and (self.Distance and self.Distance-x or dist3) or nil--Train:ReadCell(49165)
		if dist1 and dist2 then 
			if self.Metka[3] or self.Metka[4] then
				self.DistToSt = math.max(0,dist1)
			else
				self.DistToSt = 0
			end
		end
		
		if self.Metka[3] and not self.Metka[4] or self.Metka[4] and not self.Metka[3] and dist1 < -10 then
			self.ProstActive = false
			for k,v in pairs(self.Metka) do
				self.Metka[k] = false
			end		
		end	
		local Sensor = Train.LightSensor
		if not IsValid(Sensor) then return end

		local command
		local Programm
			
		for k,v in ipairs(Sensor.Commands) do
			--print(k,v.PlateType)
			if v.PlateType == 760 then--and Train:GetRight():Dot(v:GetUp())>0 then
				Programm = v.Linked or v
				command = v.Mode
			end
		end
			
		if Programm and not self.Metka1 then self.Metka1 = true end	
		self.Programm = Programm
			
		--local command = Programm and (Programm.Marker)

		--print(Programm,ProgrammType)
		--print(Programm.DistanceToOPV+1.40)

		--PrintTable(Metrostroi.GetPositionOnTrack(Train:GetPos(),Train:GetAngles()))
		--print(Train.Panel.Controller)
		if Train.Panel.Controller == 0 then
			if dist2 < 200 and (self.Metka[3] or self.Metka[2]) and self.ProstActive == 1 then
				local targetSpeed = (70.5*(math.max(0.0,math.min(1.0,(dist2)/240))^0.54))+0.4*(dist2 < 48 and 1 or 0)
				--print(dist2)
				--local a = (Tspeed/3.6)^2/(2*math.abs(dist2))
				if --[[dist2 < 50 and]] Train:GetClass()[19] == "a" and #Train.WagonList > 3 then
					if Tspeed+1 > targetSpeed then
						if Tspeed-targetSpeed < 0.38 or Tspeed < 7 then--6
							self.Command = -2
						else--if Tspeed > 7 then
							self.Command = -3--Tspeed > 7 and -3 or -2
						end
					elseif Tspeed < targetSpeed-4.5 then 
						self.Command = 0
					else
						self.Command = -1
					end 				
				else
					if Tspeed+1 > targetSpeed then
						if Tspeed-targetSpeed < 2 or Tspeed < 7 then--6 5.5
							self.Command = -2
						else
							self.Command = -3
						end
					elseif Tspeed < targetSpeed-2.75 then 
						self.Command = 0
					else
						self.Command = -1
					end 
				end
				if Tspeed < 0.1 then
					self.Command = 0
					self.ProstActive = 0
					self.CommandStop = false
				end
			end
		else
			if dist2 >= 350 then
				for k,v in pairs(self.Metka) do
					self.Metka[k] = false
				end
				self.Distance = nil
				self.sum = 0
			end
			self.Command = 0
		end			
		--	print(Programm)
		if Programm then
			self.Metk = command--(self.Metka[2] and 1 or 2)
			local find = false
			for k,v in pairs(self.Metka) do
				if Programm == v then
					find = true
				end
			end
			if not find then
				self.Metka[self.Metk] = Programm
			end
			if self.Metka[1] == Programm then
				self.RightDoors = Programm.RightDoors or false					
			end
			if Train.Panel.Controller == 0 and not self.Metka[3] and self.Metka[2] == Programm and not self.Metka[1] or self.Metk > 2 then
				self.ProstActive = 1
			end
		elseif dist1 > 0 and Programm then
			
		end
		if self.Metka[1] and math.abs(dist2) < 3 then
			self.BlockDoorsL = self.RightDoors
			self.BlockDoorsR = not self.RightDoors
		elseif (not self.BlockDoorsL or not self.BlockDoorsR) and self.Metka1 then
			self.BlockDoorsL = true
			self.BlockDoorsR = true
		end
		if dist2 < 350 then
			if not self.Timer2 then self.Timer2 = CurTime()+2 end
			if self.Timer2 and CurTime()-self.Timer2 > 0 then
				self.prevdist3 = dist3
				self.Timer2 = CurTime()+2
			end
		elseif (self.prevdist3 or self.Timer2) then
			self.prevdist3 = nil
			self.Timer2 = nil
		end
		if dist2 < 350 and self.prevdist3 and dist3-1 > self.prevdist3 then
			self.WrongDir = true
		end
		if dist2 >= 350 and self.WrongDir then
			self.WrongDir = false
		end
		if dist2 < 200 and Train.Panel.Controller ~= 0 and (self.Metka[3] or self.Metka[2]) then
			self.ProstActive = 0
		end
		if dist2 >= 350 and (self.ProstActive == 1 and not self.Metka[2]) or self.WrongDir then
			self.ProstActive = 0
			self.Distance = nil
			self.Dist = nil
			self.DistToSt = 0
		elseif dist2 < 350 then
			self.Dist = dist2
		end
	else
		--self.Distance = nil
		self.Dist = nil
		self.Command = 0	
		self.DistToSt = 0
		self.WrongDir = false		
		--[[
		if not self.Kos then
			for k,v in pairs(self.Metka) do
				self.Metka[k] = false
			end
		else
			--if self.Metka[1]
		end]]
		if Train.BKL and not Train.BUKP.Ovr then
			self.BlockDoorsL = false
			self.BlockDoorsR = false
		end
		if RV > 0 and power and Train.BUKP.State == 5 and Train:GetNW2Int("VityazMainMsg",0) == 0 and not Train.BKL then
			if not self.Kos then
				if self.Metka[4] or self.Metka[2] then
					self.sum = (self.sum + (self.v0+Train.Speed*Train.SpeedSign)*self.DeltaTime/7.2)
				else
					self.sum = 0
				end
				if self.Metka[4] then
					self.dist2 = 350-self.sum
				elseif self.Metka[2] then
					self.dist2 = 54-self.sum
				else
					self.dist2 = 350
				end
			end

			local dist1 = self.dist2-200 --(x and stbl) and (stbl.x_start-x-11) or nil
			local dist3 = self.dist2--x and stbl and (stbl.x_end-x-20)			
			local dist2 = self.dist2--x and (self.Distance and self.Distance-x or dist3) or nil--Train:ReadCell(49165)
			
			local Sensor = Train.LightSensor
			if not IsValid(Sensor) then return end

			local command
			local Programm
				
				
			for k,v in ipairs(Sensor.Commands) do
				--print(k,v.PlateType)
				if v.PlateType == 760 then--and Train:GetRight():Dot(v:GetUp())>0 then
					Programm = v.Linked or v
					command = v.Mode
				end
			end	
	
			if Programm and not self.Metka1 then self.Metka1 = true end
			self.Programm = Programm
			if Programm and command == 1 and not self.Metka[1] then
				self.Metka[1] = Programm
				self.RightDoors = Programm.RightDoors or false			
			end
			if Programm and command == 2 and not self.Metka[2] then
				self.Metka[2] = Programm
			end
			if self.Metka[1] and dist2 and math.abs(dist2) < 3 then
				self.BlockDoorsL = self.RightDoors
				self.BlockDoorsR = not self.RightDoors
			elseif (not self.BlockDoorsL or not self.BlockDoorsR) and self.Metka1 then
				self.BlockDoorsL = true
				self.BlockDoorsR = true
			end			
			--[[
			if self.sum > 57.5 then--or dist2 >= 350 and self.Metka and self.Metka[1] then
				for k,v in pairs(self.Metka) do
					self.Metka[k] = false
				end
				self.Distance = nil
			end]]
				
			--self.BlockDoorsL = false
			--self.BlockDoorsR = false
		else
			self.Programm = false
		end
	end
	if self.Kos and self.ProstActive == 0 then
		if not self.Prost then
			if self.Metka[4] or self.Metka[2] or self.Metka[1] then
				self.sum = (self.sum + (self.v0+Train.Speed*Train.SpeedSign)*self.DeltaTime/7.2)
			else
				self.sum = 0
			end
			if self.Metka[4] then
				self.dist2 = 350-self.sum
			elseif self.Metka[2] then
				self.dist2 = 54-self.sum
			elseif self.Metka[1] then
				self.dist2 = 43-self.sum	--12	
			else
				self.dist2 = 350
			end
			if self.dist2 < -10 then
				self.dist2 = 350
			end
		end
			
		local dist1 = self.dist2-200 --(x and stbl) and (stbl.x_start-x-11) or nil
		local dist3 = self.dist2--x and stbl and (stbl.x_end-x-20)			
		local dist2 = self.dist2--x and (self.Distance and self.Distance-x or dist3) or nil--Train:ReadCell(49165)
	
		local Sensor = Train.LightSensor
		if not IsValid(Sensor) then return end
		local command
		local Programm

		for k,v in ipairs(Sensor.Commands) do
			--print(k,v.PlateType)
			if v.PlateType == 760 then--and Train:GetRight():Dot(v:GetUp())>0 then
				Programm = v.Linked or v
				command = v.Mode
			end
		end

		--local command = Programm and (Programm.Marker)
			
		if Programm then
			self.Metk = command--(self.Metka[2] and 1 or 2)
			local find = false
			for k,v in pairs(self.Metka) do
				if Programm == v then
					find = true
				end
			end
			if not find then
				self.Metka[self.Metk] = Programm
			end
			if Tspeed > 2.3 then
				if self.Metka[2] == Programm and self.Metka[1] then
					self.CommandKos = true
					self.WrongPath = true
				end
				if self.Metka[1] == Programm and not self.Metka[2] then
					self.CommandKos = true
					self.WrongPath = true
				end

			end
		end		
		--[[
		if dist1 > 0 and dist1 < 400 and Programm then
			self.Metk = command
			local find = false
			for k,v in pairs(self.Metka) do
				if Programm == v then
					find = true
				end
			end
			if not find then
				self.Metka[self.Metk] = Programm
			end										
		end	]]			
		if Programm then
			if self.Metka[2] == Programm and Tspeed > 40 then
				self.CommandKos = true
			end
			if self.Metka[1] == Programm and Tspeed > 20 then
				self.CommandKos = true
			end
		end
		if dist1 < 0 and Tspeed < 1 and not self.Stop then
			self.Stop = true
		end
		local a = (Tspeed/3.6)^2/(2*dist2)
		if self.Metka[1] and dist2 < -3 and not self.Stop1 and self.PrKos and not self.WrongPath then
			self.CommandKos = true
			if Tspeed > 10 then
				--self.EmergencyBrake = 1
			end
			self.PrKos = false
		end
		if not self.Metka[1] and not self.Metka[2] and not self.Metka[3] and not self.Metka[4] and not self.PrKos then
			self.PrKos = true
		end
		if not self.Metka[2] and not self.Metka[1] and self.Stop then
			--self.CommandKos = false
			self.Stop = false
		end
		if self.Metka[1] and Tspeed < 1 and math.abs(dist2) < 3 and not self.Stop1 then
			self.Stop1 = true
		end
		if not self.Metka[2] and not self.Metka[1] and self.Stop1 then
			self.Stop1 = false
		end
		if not self.Metka[2] and not self.Metka[1] and self.WrongPath then
			self.WrongPath = false
		end
		if (RV == 0 or Train.Panel.Controller == -3) and self.CommandKos then
			self.CommandKos = false
			self.KosTimer = nil
			self.EmergencyBrake = 0					
			self.Stop = false
			self.PrevSpeed = nil
		end
		if self.CommandKos and not self.KosTimer then
			self.KosTimer = CurTime()+1
		end
		if self.CommandKos and CurTime()-self.KosTimer > 0 then
			self.PrevSpeed = Tspeed
			self.KosTimer = CurTime()+1					
		end
		--print(self.KosTimer and CurTime()-self.KosTimer)
		if self.CommandKos and Tspeed < 8 and Train.Pneumatic.EmerBrakeWork then
			--self.EmergencyBrake = 1
		end
	else
		self.CommandKos = false
		self.Stop = false
		self.Stop1 = false
		self.EmergencyBrake = 0							
		if not self.Prost then
			--[[
			for k,v in pairs(self.Metka) do
				self.Metka[k] = false
			end]]
		end		
	end
	self.v0 = Train.Speed*Train.SpeedSign
end
