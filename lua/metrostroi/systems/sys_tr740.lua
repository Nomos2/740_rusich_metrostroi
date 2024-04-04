Metrostroi.DefineSystem("TR_740")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	-- Output voltage from contact rail
	self.Main750V = 0.0
	self.ContactState1 = 0
	self.ContactState2 = 0
	self.ContactState3 = 0
	self.ContactState4 = 0
end

function TRAIN_SYSTEM:Inputs()
	return { }
end

function TRAIN_SYSTEM:Outputs()
	return { "Main750V","ContactState1","ContactState2","ContactState3","ContactState4"}
end


function TRAIN_SYSTEM:Think(dT)
	-- Don't do logic if train is broken
	local fB,mB = self.Train.FrontBogey,self.Train.MiddleBogey

	self.Main750V = 0
	if IsValid(fB) then
		self.Main750V = math.max(self.Main750V,fB.Voltage)
		self.ContactState1 = fB.NextStates[1] and 1 or 0
		self.ContactState2 = fB.NextStates[2] and 1 or 0
	else
		self.ContactState1 = 0
		self.ContactState2 = 0
	end
	if IsValid(mB) then
		self.Main750V = math.max(self.Main750V,mB.Voltage)
		self.ContactState3 = mB.NextStates[1] and 1 or 0
		self.ContactState4 = mB.NextStates[2] and 1 or 0
	else
		self.ContactState3 = 0
		self.ContactState4 = 0
	end
end