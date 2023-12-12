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
return 
[[
#81-740_4

[en]
Entities.gmod_subway_81-740_4.Name = 81-740.4 (Rusich head beta)
Entities.gmod_subway_81-741_4.Name = 81-741.4 (Middle Rusich beta)
self.Train.SubwayTrain.Name        = 81-740.4 (Rusich head beta)

#Cameras
Train.740.CameraCond    = Air conditioner, IGLA #
Train.740.CameraPPZ     = PPZ 
Train.740.CameraPV      = VPU 
Train.740.CameraVityaz  = SAU "Vityaz" 
Train.740.CameraKRMH    = KRMSH and UAVA valves 
Train.740.CameraPVZ     = PVZ 

#common 

Spawner.740.MotorType     = Sound type TED
Spawner.740.MotorType.Random   = Random
Spawner.740.MotorType2    = Type 1
Spawner.740.MotorType3    = Type 2
Spawner.740.MotorType4    = Type 3 Old (From Yauza)
Spawner.740.MotorType5    = Type 4
Spawner.740.MotorType6    = Type 5

Spawner.740.ZavodTable    = Location of the manufacturer's nameplate
Spawner.740.ZavodTable.Random   = Random
Spawner.740.ZavodTable2    = Type 1 Near the driver's cab/front section front door
Spawner.740.ZavodTable3    = Type 2 Near the transition between sections
Spawner.740.ZavodTable4    = Type 3 Near the end door of the rear section

Spawner.740.RingSound    = Type of ring sound
Spawner.740.RingSound.Random   = Random
Spawner.740.RingSound2    = Type 1
Spawner.740.RingSound3    = Type 2
Spawner.740.RingSound4    = Type 3
Spawner.740.RingSound5    = Type 4

Spawner.740.BUKPVersion   = BUKP firmware version
Spawner.740.BUKPVersion1  = Old
Spawner.740.BUKPVersion2  = New

Spawner.740.VentSound    = Air conditioner noise sound type
Spawner.740.VentSound.Random   = Random
Spawner.740.VentSound2    = Type 1
Spawner.740.VentSound3    = Type 2 

Common.740.CabinDoorLeft2 	= Left door to the driver's cab
Common.740.CabinDoorRight2	= Right door to the driver's cab

Common.740.CabinDoorLeft 	= Left driver's cab door
Common.740.CabinDoorRight	= Right driver's cab door

Common.740.BLTLPressure     = Pressure in the pressure (black arrow) and brake (red arrow) lines
Common.740.BCPressure		= Brake cylinder pressure
Common.740.BatteryVoltage  	= Battery voltage (V)
Common.740.HighVoltage      = Contact rail voltage (kV)
Common.740.EnginesCurrent1  = Current of group I of traction motors (A)

Common.740.UAVA2			= UAVA: Turning on the hitchhiker's automatic switch
Common.740.KRMH				= CRMSH: Standby activation of the driver's crane

Common.740.FrontBrakeLineIsolationToggle 	= Brake line end valve
Common.740.FrontTrainLineIsolationToggle 	= Pressure line end valve
Common.740.RearTrainLineIsolationToggle 	= Pressure line end valve
Common.740.RearBrakeLineIsolationToggle 	= Brake line end valve

Common.741.FrontBrakeLineIsolationToggle 	= Brake line end valve
Common.741.FrontTrainLineIsolationToggle 	= Pressure line end valve
Common.741.RearTrainLineIsolationToggle 	= Pressure line end valve
Common.741.RearBrakeLineIsolationToggle 	= Brake line end valve

Common.741.RearDoor 						= Rear end door
Common.740.FrontDoor 						= Front end door

Common.740.Password 						= Set/remove password hint
Common.740.Antenna  						= Install/remove the antenna

Common.740.Vityaz.F1             = Vityaz: F1
Common.740.Vityaz.F2             = Vityaz: Speed
Common.740.Vityaz.F4             = Vityaz: Normal mode
Common.740.Vityaz.F6             = Vityaz: Up\Speed
Common.740.Vityaz.F7             = Vityaz: Down \ Currents
Common.740.Vityaz.F8             = Vityaz: Input\Railcar equipment
Common.740.Vityaz.F9             = Vityaz: Choice\Car equipment management
Common.740.Vityaz.F5             = Vityaz: ZV
Common.740.Vityaz.0              = Vityaz: 0
Common.740.Vityaz.1              = Vityaz: 1
Common.740.Vityaz.2              = Vityaz: 2
Common.740.Vityaz.3              = Vityaz: 3
Common.740.Vityaz.4              = Vityaz: 4
Common.740.Vityaz.5              = Vityaz: 5
Common.740.Vityaz.6              = Vityaz: 6
Common.740.Vityaz.7              = Vityaz: 7
Common.740.Vityaz.8              = Vityaz: 8
Common.740.Vityaz.9              = Vityaz: 9

Common.740.Vityaz.PVU   	     = Vityaz: PVU
Common.740.Vityaz.VO             = Vityaz: VO
Common.740.Vityaz.Current     	 = Vityaz: Current 
Common.740.Vityaz.SOT   		 = Vityaz: SOT
Common.740.Vityaz.Num   		 = Vityaz: №
Common.740.Vityaz.T   		     = Vityaz: t°
Common.740.Vityaz.Next       	 = Vityaz: Next
Common.740.Vityaz.Back           = Vityaz: Back
Common.740.Vityaz.UTV 		     = Vityaz: Management ТV	
Common.740.Vityaz.TV1 		     = Vityaz: ТV 1
Common.740.Vityaz.TV2 		     = Vityaz: ТV 2
Common.740.Vityaz.Noth 		     = Vityaz: Don't use

Common.740.VentCMode        = Fan operation mode
Common.740.VentCMode+       = Increasing the heating power
Common.740.VentCMode-       = Reducing the heating force
Common.740.VentSMode-       = Increase fan power
Common.740.VentSMode+       = Reducing fan power

Common.740.EmerX1           = Back-up start in move 1 mode
Common.740.EmerX2           = Back-up start in move 2 mode
Common.740.EmerCloseDoors   = Backup door closing
Common.740.EmergencyDoors   = Enabling backup door control

Common.740.SF1              = SF1: General power
Common.740.SF2              = SF2: Main control
Common.740.SF3              = SF3: Backup management
Common.740.SF4              = SF4: BARS
Common.740.SF5              = SF5: BUP (train control unit)
Common.740.SF6              = SF6: BKU (control circuit switching unit)
Common.740.SF7              = SF7: SOFTWARE (Automated control system)
Common.740.SF8              = SF8: Notification
Common.740.SF9              = SF9: Radio communication
Common.740.SF10             = SF10: Orientation of the car
Common.740.SF11             = SF11: Direction of travel
Common.740.SF12             = SF12: Headlights of the 1st group
Common.740.SF13             = SF13: Headlights of the 2st group
Common.740.SF14             = SF14: Marker lights
Common.740.SF15             = SF15: Cabin lighting
Common.740.SF16             = SF16: Heating
Common.740.SF17             = SF17: Cabin air conditioning
Common.740.SF18             = SF18: Grebnesmazyvatel
Common.740.SF19             = SF19: The driver's crane's main power supply
Common.740.SF20             = SF20: Driver's crane backup power supply
Common.740.SF21             = SF21: Doors opening
Common.740.SF22             = SF22: Doors closing

Common.740.Pant1            = Pressing of current collectors of the 1st group
Common.740.Pant2            = Pressing of current collectors of the 2st group
Common.740.Vent2            = Interior ventilation
Common.740.TorecDoors       = End doors
Common.740.BBER             = Backup power-up of the IPP
Common.740.BBE              = Enabling IPP
Common.740.CabLightStrength = Cabin lighting brightness
Common.740.AppLights        = Hardware compartment lighting
Common.740.BARSBlock        = Blocking faulty BARS
Common.740.AppVent          = Ventilation of the hardware compartment
Common.740.PassLights		= Interior lighting
Common.740.CabLights		= Cabin lighting
Common.740.VF1				= Headlights 1 group
Common.740.VF2				= Headlights 2 group
Common.740.ParkingBrake		= Parking Brake
Common.740.MK				= Switching on the motor-compressor
Common.740.VB				= WB: Turning on the batteries
Common.740.ALSFreqBlock-	= ALS decoder switch (Counter-Clockwise)
Common.740.ALSFreqBlock+	= ALS decoder switch (Clockwise)
Common.740.BRU				= Switchgear unit

Common.740.IGLA.Button1		= IGLA: First button
Common.740.IGLA.Button2		= IGLA: Second button
Common.740.IGLA.Button3		= IGLA: Third button
Common.740.IGLA.Button4		= IGLA: The fourth button
Common.740.IGLA.Button23	= IGLA: Second and third buttons
Common.740.IGLA.IGLAPI		= IGLA: Fire
Common.740.IGLA.IGLAErr		= IGLA: Error

Common.740.SpeedCurr 		= Actual speed
Common.740.SpeedAttent		= Recommended speed
Common.740.SpeedAccept 		= Current speed
Common.740.SpeedAccept1 	= Permissible speed
Common.740.Forward          = Moving forward
Common.740.Backward 		= Moving backwards

Common.740.AccelRate		= Enabling the "Rise" mode"
Common.740.HVoltage 		= Lamp for the absence of voltage in the contact network
Common.740.Stand            = Warming up the pads
Common.740.ALS				= Button for switching the APC system to locomotive alarm mode
Common.740.Ring             = Transfer of control (call)
Common.740.PassScheme       = Turning on the door display in the passenger compartment
Common.740.DisableBV 		= Disabling the BV
Common.740.R_Line 			= Turning on the driver's microphone
Common.740.R_Emer			= Enabling emergency communication
Common.740.Wiper 			= Turning on the windscreen wiper
Common.740.R_Announcer      = Washer
Common.740.EmergencyCompressor	= Backup motor compressor button
Common.740.EmergencyControls	= Control circuit backup switch
Common.740.DoorSelectL          = Selecting the left doors
Common.740.DoorSelectR          = Selecting the right doors
Common.740.DoorBlock            = Movement without door control
Common.740.KDL                  = Opening the left doors
Common.740.KDP                  = Opening the right doors
Common.740.EBrakeAdd            = Increasing the reserve brake setpoint
Common.740.EBrakeRelease        = Decrease the reserve brake setpoint
Common.740.EBrakeToggle         = Activating the backup brake
Common.740.EmergencyBrake       = Activating the emergency brake
Common.740.DoorClose            = Closing doors
Common.740.AttentionMessage     = Message perception button
Common.740.LSD  				= Door alarm lamp (doors are closed)
Common.740.KAH					= Emergency power button BARS
Common.740.ALSk					= ALS button cover
Common.740.ARS.KB 				= KB: Alert button
Common.740.ARS.KVT				= KW: Brake perception button
Common.740.Program1				= Start recording (program 1)
Common.740.Program2				= Start recording  (program 2)
Common.740.Horn					= Horn
Common.740.TPT                  = TPT: Braking by intermediate bogeys

Common.740.CAMS5Set				= Overview: Port side
Common.740.CAMS6Set 			= Overview: Starboard side
Common.740.CAMS7Set 			= Overview: Headsets
Common.740.CAMS8Set 			= Overview: Tail Lights
Common.740.CAMS9Set 			= Overview: Left
Common.740.CAMS10Set		 	= Overview: Right

Common.740.ABSD 				 = Emergency locking of the pressure sensor (ABSD)
Common.740.RTE 				 	 = Emergency backup brake (RTE)

Common.740.SFV1             = SF1: Power supply for car control circuits
Common.740.SFV2             = SF2: Car control unit power supply
Common.740.SFV3             = SF3: Power supply for the traction drive control unit
Common.740.SFV4             = SF4: Control of the traction drive control unit
Common.740.SFV5             = SF5: Backup control of the traction drive control unit
Common.740.SFV6             = SF6: BOOTP nutrition
Common.740.SFV7             = SF7: On-board power supply unit
Common.740.SFV8             = SF8: Antiskid
Common.740.SFV9             = SF9: BV power
Common.740.SFV10            = SF10: Software (Automated control system TP PCBC)
Common.740.SFV11            = SF11: Motor-compressor
Common.740.SFV12            = SF12: Doors closing
Common.740.SFV13            = SF13: Opening the left doors
Common.740.SFV14            = SF14: Opening the right doors
Common.740.SFV15            = SF15: End doors
Common.740.SFV16            = SF16: Notification
Common.740.SFV17            = SF17: Emergency communication
Common.740.SFV18            = SF18: Reserve
Common.740.SFV19            = SF19: Interior lighting power supply
Common.740.SFV20            = SF20: Emergency interior lighting
Common.740.SFV21            = SF21: Speed sensor
Common.740.SFV22            = SF22: Parking brake
Common.740.SFV23            = SF23: Interior ventilation control
Common.740.SFV24            = SF24: Power supply for interior ventilation
Common.740.SFV25            = SF25: Pathogen nutrition ( ͡° ͜ʖ ͡°)
Common.740.SFV26            = SF26: Charging capacitor power supply
Common.740.SFV27            = SF27: Current collectors
Common.740.SFV28            = SF28: inverter
Common.740.SFV29            = SF29: Reserve
Common.740.SFV30            = SF30: Reserve
Common.740.SFV31            = SF31: Reserve
Common.740.SFV32            = SF32: Balancing power circuits
Common.740.SFV33            = SF33: Video

Common.740.LN               = LN: Direction matching lamp
Common.740.Dnepr			= DNEPR: Lamp for switching on the Dnepr mode
Common.740.XOD				= XOD: XOD Lamp
Common.740.DAU				= DAU: Lamp for the operation of a backup autonomous device 
Common.740.Ispr 			= ISPR: Service lamp of BARS
Common.740.AO				= AO: Absolute stop signal receiving lamp
Common.740.Forw				= Forward movement
Common.740.Back				= Backward movement

#gmod_subway_81-740_4
#Buttons:

Entities.gmod_subway_81-740_4.Buttons.BackVent.VentCondMode-      = @[Common.740.VentCMode] @[Common.ALL.CCW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentCondMode+      = @[Common.740.VentCMode] @[Common.ALL.CW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentStrengthMode-  = @[Common.740.VentSMode-] @[Common.ALL.CCW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentStrengthMode+  = @[Common.740.VentSMode+] @[Common.ALL.CW]

Entities.gmod_subway_81-740_4.Buttons.EmergencyBrake1.EmerBrakeCrane1Toggle = @[Common.ALL.EmergencyBrakeValve]

Entities.gmod_subway_81-740_4.Buttons.RV.EmerX1Set                = @[Common.740.EmerX1]
Entities.gmod_subway_81-740_4.Buttons.RV.EmerX2Set                = @[Common.740.EmerX2]
Entities.gmod_subway_81-740_4.Buttons.RV.EmerCloseDoorsSet        = @[Common.740.EmerCloseDoors]
Entities.gmod_subway_81-740_4.Buttons.RV.EmergencyDoorsToggle     = @[Common.740.EmergencyDoors]

Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz0Set = @[Common.740.Vityaz.0]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz1Set = @[Common.740.Vityaz.1]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz2Set = @[Common.740.Vityaz.2]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz3Set = @[Common.740.Vityaz.3]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz4Set = @[Common.740.Vityaz.4]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz5Set = @[Common.740.Vityaz.5]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz6Set = @[Common.740.Vityaz.6]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz7Set = @[Common.740.Vityaz.7]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz8Set = @[Common.740.Vityaz.8]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.Vityaz9Set = @[Common.740.Vityaz.9]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazF2Set = @[Common.740.Vityaz.F2]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazF4Set = @[Common.740.Vityaz.F4]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazF5Set = @[Common.740.Vityaz.F5]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazF6Set = @[Common.740.Vityaz.F6]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazF7Set = @[Common.740.Vityaz.F7]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazF8Set = @[Common.740.Vityaz.F8]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazF9Set = @[Common.740.Vityaz.F9]

Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazPVUSet   = @[Common.740.Vityaz.PVU]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazVOSet    = @[Common.740.Vityaz.VO]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazCurrentSet = @[Common.740.Vityaz.Current]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazSOTSet   = @[Common.740.Vityaz.SOT]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazNumSet   = @[Common.740.Vityaz.Num]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazTSet 	   = @[Common.740.Vityaz.T]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazNextSet  = @[Common.740.Vityaz.Next]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazBackSet  = @[Common.740.Vityaz.Back]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazUTVSet   = @[Common.740.Vityaz.UTV]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazTV1Set   = @[Common.740.Vityaz.TV1]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazTV2Set   = @[Common.740.Vityaz.TV2]
Entities.gmod_subway_81-740_4.Buttons.VityazButtons.VityazNothSet  = @[Common.740.Vityaz.Noth]

Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF1Toggle           = @[Common.740.SF1]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF2Toggle           = @[Common.740.SF2]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF3Toggle           = @[Common.740.SF3]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF4Toggle           = @[Common.740.SF4]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF5Toggle           = @[Common.740.SF5]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF6Toggle           = @[Common.740.SF6]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF7Toggle           = @[Common.740.SF7]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF8Toggle           = @[Common.740.SF8]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF9Toggle           = @[Common.740.SF9]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF10Toggle          = @[Common.740.SF10]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF11Toggle          = @[Common.740.SF11]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF12Toggle          = @[Common.740.SF12]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF13Toggle          = @[Common.740.SF13]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF14Toggle          = @[Common.740.SF14]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF15Toggle          = @[Common.740.SF15]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF16Toggle          = @[Common.740.SF16]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF17Toggle          = @[Common.740.SF17]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF18Toggle          = @[Common.740.SF18]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF19Toggle          = @[Common.740.SF19]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF20Toggle          = @[Common.740.SF20]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF21Toggle          = @[Common.740.SF21]
Entities.gmod_subway_81-740_4.Buttons.BackPPZ.SF22Toggle          = @[Common.740.SF22]

Entities.gmod_subway_81-740_4.Buttons.BackDown.Pant1Toggle            = @[Common.740.Pant1]
Entities.gmod_subway_81-740_4.Buttons.BackDown.Pant2Toggle            = @[Common.740.Pant2]
Entities.gmod_subway_81-740_4.Buttons.BackDown.Vent2Toggle            = @[Common.740.Vent2]
Entities.gmod_subway_81-740_4.Buttons.BackDown.PassLightToggle        = @[Common.740.PassLights]
Entities.gmod_subway_81-740_4.Buttons.BackDown.CabLightToggle         = @[Common.740.CabLights]
Entities.gmod_subway_81-740_4.Buttons.BackDown.Headlights1Toggle      = @[Common.740.VF1]
Entities.gmod_subway_81-740_4.Buttons.BackDown.Headlights2Toggle      = @[Common.740.VF2]
Entities.gmod_subway_81-740_4.Buttons.BackDown.ParkingBrakeToggle     = @[Common.740.ParkingBrake]
Entities.gmod_subway_81-740_4.Buttons.BackDown.TorecDoorsToggle       = @[Common.740.TorecDoors]
Entities.gmod_subway_81-740_4.Buttons.BackDown.BBERToggle             = @[Common.740.BBER]
Entities.gmod_subway_81-740_4.Buttons.BackDown.BBEToggle              = @[Common.740.BBE]
Entities.gmod_subway_81-740_4.Buttons.BackDown.CompressorToggle       = @[Common.740.MK]
Entities.gmod_subway_81-740_4.Buttons.BackDown.CabLightStrengthToggle = @[Common.740.CabLightStrength]
Entities.gmod_subway_81-740_4.Buttons.BackDown.AppLights1Toggle       = @[Common.740.AppLights]
Entities.gmod_subway_81-740_4.Buttons.BackDown.AppLights2Toggle       = @[Common.740.AppVent]
Entities.gmod_subway_81-740_4.Buttons.BackDown.BARSBlock-             = @[Common.740.BARSBlock] @[Common.ALL.CCW]
Entities.gmod_subway_81-740_4.Buttons.BackDown.BARSBlock+             = @[Common.740.BARSBlock] @[Common.ALL.CW]
Entities.gmod_subway_81-740_4.Buttons.BackDown.BatteryToggle          = @[Common.740.VB]

Entities.gmod_subway_81-740_4.Buttons.PUU.!DoorsClosed                = @[Common.740.LSD]
Entities.gmod_subway_81-740_4.Buttons.PUU.StandToggle                 = @[Common.740.Stand]
Entities.gmod_subway_81-740_4.Buttons.PUU.KAHToggle                   = @[Common.740.KAH]
Entities.gmod_subway_81-740_4.Buttons.PUU.ALSkToggle                  = @[Common.740.ALSk]
Entities.gmod_subway_81-740_4.Buttons.PUU.ALSToggle                   = @[Common.740.ALS]
Entities.gmod_subway_81-740_4.Buttons.PUU.!HVoltage                   = @[Common.740.HVoltage]
Entities.gmod_subway_81-740_4.Buttons.PUU.PassSchemeToggle            = @[Common.740.PassScheme]
Entities.gmod_subway_81-740_4.Buttons.PUU.EmergencyCompressorSet      = @[Common.740.EmergencyCompressor]
Entities.gmod_subway_81-740_4.Buttons.PUU.DisableBVSet                = @[Common.740.DisableBV]
Entities.gmod_subway_81-740_4.Buttons.PUU.RingSet                     = @[Common.740.Ring]
Entities.gmod_subway_81-740_4.Buttons.PUU.R_Program2Set               = @[Common.740.Program2]
Entities.gmod_subway_81-740_4.Buttons.PUU.R_AnnouncerToggle           = @[Common.740.R_Announcer]
Entities.gmod_subway_81-740_4.Buttons.PUU.R_LineToggle                = @[Common.740.R_Line]
Entities.gmod_subway_81-740_4.Buttons.PUU.R_EmerSet                   = @[Common.740.R_Emer]
Entities.gmod_subway_81-740_4.Buttons.PUU.EmergencyControlsToggle     = @[Common.740.EmergencyControls]
Entities.gmod_subway_81-740_4.Buttons.PUU.WiperToggle                 = @[Common.740.Wiper]

Entities.gmod_subway_81-740_4.Buttons.PUU.!VDop                       = @[Common.740.SpeedAccept1]
Entities.gmod_subway_81-740_4.Buttons.PUU.!VDop2                      = @[Common.740.SpeedAccept]
Entities.gmod_subway_81-740_4.Buttons.PUU.!VFact                      = @[Common.740.SpeedCurr]
Entities.gmod_subway_81-740_4.Buttons.PUU.!VPred                      = @[Common.740.SpeedAttent]
Entities.gmod_subway_81-740_4.Buttons.PUU.AccelRateSet                = @[Common.740.AccelRate]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!Forw             = @[Common.740.Forward]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!Back             = @[Common.740.Backward]

Entities.gmod_subway_81-740_4.Buttons.PUR.R_Program1Set               = @[Common.740.Program1]
Entities.gmod_subway_81-740_4.Buttons.PUR.EmerBrakeAddSet             = @[Common.740.EBrakeAdd]
Entities.gmod_subway_81-740_4.Buttons.PUR.EmerBrakeReleaseSet         = @[Common.740.EBrakeRelease]
Entities.gmod_subway_81-740_4.Buttons.PUR.EmerBrakeToggle             = @[Common.740.EBrakeToggle]
Entities.gmod_subway_81-740_4.Buttons.PUR.EmergencyBrakeToggle        = @[Common.740.EmergencyBrake]
Entities.gmod_subway_81-740_4.Buttons.PUR.DoorCloseToggle             = @[Common.740.DoorClose]
Entities.gmod_subway_81-740_4.Buttons.PUR.AttentionMessageSet         = @[Common.740.AttentionMessage]
Entities.gmod_subway_81-740_4.Buttons.PUR.AttentionSet                = @[Common.740.ARS.KB]
Entities.gmod_subway_81-740_4.Buttons.PUR.AttentionBrakeSet           = @[Common.740.ARS.KVT]
Entities.gmod_subway_81-740_4.Buttons.PUR.HornBSet                    = @[Common.740.Horn]
Entities.gmod_subway_81-740_4.Buttons.PUR.DoorRightSet                = @[Common.740.KDP]
Entities.gmod_subway_81-740_4.Buttons.PUR.TPTToggle             	  = @[Common.740.TPT]

Entities.gmod_subway_81-740_4.Buttons.PUL.DoorSelectLToggle           = @[Common.740.DoorSelectL]
Entities.gmod_subway_81-740_4.Buttons.PUL.DoorSelectRToggle           = @[Common.740.DoorSelectR]
Entities.gmod_subway_81-740_4.Buttons.PUL.DoorBlockToggle             = @[Common.740.DoorBlock]
Entities.gmod_subway_81-740_4.Buttons.PUL.DoorLeftSet                 = @[Common.740.KDL]

Entities.gmod_subway_81-740_4.Buttons.CAMSButtons.CAMS5Set            = @[Common.740.CAMS5Set] 
Entities.gmod_subway_81-740_4.Buttons.CAMSButtons.CAMS6Set            = @[Common.740.CAMS6Set] 
Entities.gmod_subway_81-740_4.Buttons.CAMSButtons.CAMS7Set            = @[Common.740.CAMS7Set]
Entities.gmod_subway_81-740_4.Buttons.CAMSButtons.CAMS8Set            = @[Common.740.CAMS8Set]
Entities.gmod_subway_81-740_4.Buttons.CAMSButtons.CAMS9Set            = @[Common.740.CAMS9Set]
Entities.gmod_subway_81-740_4.Buttons.CAMSButtons.CAMS10Set           = @[Common.740.CAMS10Set]

Entities.gmod_subway_81-740_4.Buttons.CraneCap2.ABSDToggle   	      = @[Common.740.ABSD]
Entities.gmod_subway_81-740_4.Buttons.CraneCap2.RTEToggle  		      = @[Common.740.RTE]

Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV1Toggle          = @[Common.740.SFV1]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV2Toggle          = @[Common.740.SFV2]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV3Toggle          = @[Common.740.SFV3]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV4Toggle          = @[Common.740.SFV4]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV5Toggle          = @[Common.740.SFV5]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV6Toggle          = @[Common.740.SFV6]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV7Toggle          = @[Common.740.SFV7]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV8Toggle          = @[Common.740.SFV8]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV9Toggle          = @[Common.740.SFV9]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV10Toggle         = @[Common.740.SFV10]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV11Toggle         = @[Common.740.SFV11]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV12Toggle         = @[Common.740.SFV12]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV13Toggle         = @[Common.740.SFV13]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV14Toggle         = @[Common.740.SFV14]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV15Toggle         = @[Common.740.SFV15]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV16Toggle         = @[Common.740.SFV16]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV17Toggle         = @[Common.740.SFV17]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV18Toggle         = @[Common.740.SFV18]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV19Toggle         = @[Common.740.SFV19]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV20Toggle         = @[Common.740.SFV20]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV21Toggle         = @[Common.740.SFV21]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV22Toggle         = @[Common.740.SFV22]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV23Toggle         = @[Common.740.SFV23]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV24Toggle         = @[Common.740.SFV24]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV25Toggle         = @[Common.740.SFV25]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV26Toggle         = @[Common.740.SFV26]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV27Toggle         = @[Common.740.SFV27]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV28Toggle         = @[Common.740.SFV28]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV29Toggle         = @[Common.740.SFV29]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV30Toggle         = @[Common.740.SFV30]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV31Toggle         = @[Common.740.SFV31]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV32Toggle         = @[Common.740.SFV32]
Entities.gmod_subway_81-740_4.Buttons.PVZ.SFV33Toggle         = @[Common.740.SFV33]

Entities.gmod_subway_81-740_4.Buttons.ASNP.R_ASNPMenuSet      = @[Common.ASNP.ASNPMenu]
Entities.gmod_subway_81-740_4.Buttons.ASNP.R_ASNPUpSet        = @[Common.ASNP.ASNPUp]
Entities.gmod_subway_81-740_4.Buttons.ASNP.R_ASNPDownSet      = @[Common.ASNP.ASNPDown]
Entities.gmod_subway_81-740_4.Buttons.ASNP.R_ASNPOnToggle     = @[Common.ASNP.ASNPOn]

Entities.gmod_subway_81-740_4.Buttons.IGLAButtons_C.IGLA1Set    = @[Common.740.IGLA.Button1]
Entities.gmod_subway_81-740_4.Buttons.IGLAButtons_C.IGLA2Set    = @[Common.740.IGLA.Button2]
Entities.gmod_subway_81-740_4.Buttons.IGLAButtons_C.IGLA23	    = @[Common.740.IGLA.Button23]
Entities.gmod_subway_81-740_4.Buttons.IGLAButtons_C.IGLA3Set    = @[Common.740.IGLA.Button3]
Entities.gmod_subway_81-740_4.Buttons.IGLAButtons_C.IGLA4Set    = @[Common.740.IGLA.Button4]
Entities.gmod_subway_81-740_4.Buttons.IGLAButtons_C.!IGLAFire   = @[Common.740.IGLA.IGLAPI]
Entities.gmod_subway_81-740_4.Buttons.IGLAButtons_C.!IGLAErr    = @[Common.740.IGLA.IGLAErr]

Entities.gmod_subway_81-740_4.Buttons.BTO.K29Toggle           = @[Common.740.KRMH]
Entities.gmod_subway_81-740_4.Buttons.BTO.UAVAToggle          = @[Common.740.UAVA2]

Entities.gmod_subway_81-740_4.Buttons.FrontPneumatic.FrontBrakeLineIsolationToggle    = @[Common.740.FrontBrakeLineIsolationToggle]
Entities.gmod_subway_81-740_4.Buttons.FrontPneumatic.FrontTrainLineIsolationToggle    = @[Common.740.FrontTrainLineIsolationToggle]

Entities.gmod_subway_81-741_4.Buttons.FrontPneumatic.FrontBrakeLineIsolationToggle    = @[Common.741.FrontBrakeLineIsolationToggle]
Entities.gmod_subway_81-741_4.Buttons.FrontPneumatic.FrontTrainLineIsolationToggle    = @[Common.741.FrontTrainLineIsolationToggle]

Entities.gmod_subway_81-740_4.Buttons.CabinDoorR.CabinDoorRight       = @[Common.740.CabinDoorRight]
Entities.gmod_subway_81-740_4.Buttons.CabinDoorL.CabinDoorLeft        = @[Common.740.CabinDoorLeft]

Entities.gmod_subway_81-740_4.Buttons.CabinDoorR2.CabinDoorRight       = @[Common.740.CabinDoorRight2]
Entities.gmod_subway_81-740_4.Buttons.CabinDoorL2.CabinDoorLeft        = @[Common.740.CabinDoorLeft2]

Entities.gmod_subway_81-740_4.Buttons.VoltHelper2.!HV                 = @[Common.740.HighVoltage]
Entities.gmod_subway_81-740_4.Buttons.VoltHelper2.!I1_3               = @[Common.740.EnginesCurrent1]
Entities.gmod_subway_81-740_4.Buttons.PneumoHelper2.!BrakeTrainLine   = @[Common.740.BLTLPressure]
Entities.gmod_subway_81-740_4.Buttons.PneumoHelper1.!BrakeCylinder    = @[Common.740.BCPressure]
Entities.gmod_subway_81-740_4.Buttons.GV.GVToggle                     = @[Common.740.BRU]

Entities.gmod_subway_81-740_4.Buttons.Antenna.Antenna         = @[Common.740.Antenna]
Entities.gmod_subway_81-740_4.Buttons.Password.Password       = @[Common.740.Password]

Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!LN       = @[Common.740.LN]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!Dnepr    = @[Common.740.Dnepr]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!XOD      = @[Common.740.XOD]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!DAU      = @[Common.740.DAU]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!Ispr     = @[Common.740.Ispr]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!AO       = @[Common.740.AO]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!Forw     = @[Common.740.Forw]
Entities.gmod_subway_81-740_4.Buttons.ALSPANELLAMPS.!Back     = @[Common.740.Back]

#gmod_subway_kuzov
#Buttons:
Entities.gmod_subway_kuzov.Buttons.RearPneumatic.RearTrainLineIsolationToggle    = @[Common.741.RearTrainLineIsolationToggle]
Entities.gmod_subway_kuzov.Buttons.RearPneumatic.RearBrakeLineIsolationToggle    = @[Common.741.RearBrakeLineIsolationToggle]
Entities.gmod_subway_kuzov.Buttons.RearDoor.RearDoor   							 = @[Common.741.RearDoor]

#gmod_subway_81-741_4
Entities.gmod_subway_81-741_4.Buttons.Battery.BatteryToggle   = @[Common.740.VB]
Entities.gmod_subway_81-741_4.Buttons.GV.GVToggle             = @[Common.740.BRU]

Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV1Toggle          = @[Common.740.SFV1]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV2Toggle          = @[Common.740.SFV2]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV3Toggle          = @[Common.740.SFV3]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV4Toggle          = @[Common.740.SFV4]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV5Toggle          = @[Common.740.SFV5]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV6Toggle          = @[Common.740.SFV6]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV7Toggle          = @[Common.740.SFV7]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV8Toggle          = @[Common.740.SFV8]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV9Toggle          = @[Common.740.SFV9]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV10Toggle         = @[Common.740.SFV10]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV11Toggle         = @[Common.740.SFV11]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV12Toggle         = @[Common.740.SFV12]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV13Toggle         = @[Common.740.SFV13]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV14Toggle         = @[Common.740.SFV14]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV15Toggle         = @[Common.740.SFV15]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV16Toggle         = @[Common.740.SFV16]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV17Toggle         = @[Common.740.SFV17]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV18Toggle         = @[Common.740.SFV18]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV19Toggle         = @[Common.740.SFV19]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV20Toggle         = @[Common.740.SFV20]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV21Toggle         = @[Common.740.SFV21]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV22Toggle         = @[Common.740.SFV22]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV24Toggle         = @[Common.740.SFV24]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV26Toggle         = @[Common.740.SFV26]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV27Toggle         = @[Common.740.SFV27]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV28Toggle         = @[Common.740.SFV28]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV29Toggle         = @[Common.740.SFV29]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV30Toggle         = @[Common.740.SFV30]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV31Toggle         = @[Common.740.SFV31]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV32Toggle         = @[Common.740.SFV32]
Entities.gmod_subway_81-741_4.Buttons.PVZ.SFV33Toggle         = @[Common.740.SFV33]

Entities.gmod_subway_81-741_4.Buttons.FrontDoor.FrontDoor       = @[Common.740.FrontDoor]
Entities.gmod_subway_81-741_4.Buttons.FrontDoor_rear.FrontDoor  = @[Common.740.FrontDoor]
Entities.gmod_subway_81-741_4.Buttons.FrontPneumatic.FrontBrakeLineIsolationToggle    = @[Common.741.FrontBrakeLineIsolationToggle]
Entities.gmod_subway_81-741_4.Buttons.FrontPneumatic.FrontTrainLineIsolationToggle    = @[Common.741.FrontTrainLineIsolationToggle]
#Spawner:
Entities.gmod_subway_81-740_4.Spawner.Announcer.Name          = @[Common.Spawner.Announcer]

Entities.gmod_subway_81-740_4.Spawner.MotorType.Name 		  = @[Spawner.740.MotorType] 
Entities.gmod_subway_81-740_4.Spawner.MotorType.1 		  	  = @[Spawner.740.MotorType.Random] 
Entities.gmod_subway_81-740_4.Spawner.MotorType.2         	  = @[Spawner.740.MotorType2]
Entities.gmod_subway_81-740_4.Spawner.MotorType.3          	  = @[Spawner.740.MotorType3]
Entities.gmod_subway_81-740_4.Spawner.MotorType.4          	  = @[Spawner.740.MotorType4]
Entities.gmod_subway_81-740_4.Spawner.MotorType.5          	  = @[Spawner.740.MotorType5]
Entities.gmod_subway_81-740_4.Spawner.MotorType.6          	  = @[Spawner.740.MotorType6]

Entities.gmod_subway_81-740_4.Spawner.ZavodTable.Name 		  = @[Spawner.740.ZavodTable] 
Entities.gmod_subway_81-740_4.Spawner.ZavodTable.1 		  	  = @[Spawner.740.ZavodTable.Random] 
Entities.gmod_subway_81-740_4.Spawner.ZavodTable.2         	  = @[Spawner.740.ZavodTable2]
Entities.gmod_subway_81-740_4.Spawner.ZavodTable.3            = @[Spawner.740.ZavodTable3]
Entities.gmod_subway_81-740_4.Spawner.ZavodTable.4         	  = @[Spawner.740.ZavodTable4]

Entities.gmod_subway_81-740_4.Spawner.VentSound.Name 		  = @[Spawner.740.VentSound] 
Entities.gmod_subway_81-740_4.Spawner.VentSound.1 		  	  = @[Spawner.740.VentSound.Random] 
Entities.gmod_subway_81-740_4.Spawner.VentSound.2         	  = @[Spawner.740.VentSound2]
Entities.gmod_subway_81-740_4.Spawner.VentSound.3             = @[Spawner.740.VentSound3]

Entities.gmod_subway_81-740_4.Spawner.RingSound.Name 		  = @[Spawner.740.RingSound] 
Entities.gmod_subway_81-740_4.Spawner.RingSound.1 		  	  = @[Spawner.740.RingSound.Random] 
Entities.gmod_subway_81-740_4.Spawner.RingSound.2         	  = @[Spawner.740.RingSound2]
Entities.gmod_subway_81-740_4.Spawner.RingSound.3             = @[Spawner.740.RingSound3]
Entities.gmod_subway_81-740_4.Spawner.RingSound.4         	  = @[Spawner.740.RingSound4]
Entities.gmod_subway_81-740_4.Spawner.RingSound.5             = @[Spawner.740.RingSound5]

Entities.gmod_subway_81-740_4.Spawner.BUKPVersion.Name 		  = @[Spawner.740.BUKPVersion]
Entities.gmod_subway_81-740_4.Spawner.BUKPVersion.1 	      = @[Spawner.740.RingSound.Random] 
Entities.gmod_subway_81-740_4.Spawner.BUKPVersion.2 		  = @[Spawner.740.BUKPVersion1]
Entities.gmod_subway_81-740_4.Spawner.BUKPVersion.3 		  = @[Spawner.740.BUKPVersion2]

Entities.gmod_subway_81-740_4.Spawner.SpawnMode.Name          = @[Common.Spawner.SpawnMode]
Entities.gmod_subway_81-740_4.Spawner.SpawnMode.1             = @[Common.Spawner.SpawnMode.Full]
Entities.gmod_subway_81-740_4.Spawner.SpawnMode.2             = @[Common.Spawner.SpawnMode.Deadlock]
Entities.gmod_subway_81-740_4.Spawner.SpawnMode.3             = @[Common.Spawner.SpawnMode.NightDeadlock]
Entities.gmod_subway_81-740_4.Spawner.SpawnMode.4             = @[Common.Spawner.SpawnMode.Depot]

Entities.gmod_subway_81-740_4.Spawner.Texture.Name     = @[Common.Spawner.Texture]
Entities.gmod_subway_81-740_4.Spawner.PassTexture.Name = @[Common.Spawner.PassTexture]
Entities.gmod_subway_81-740_4.Spawner.CabTexture.Name  = @[Common.Spawner.CabTexture]
]]