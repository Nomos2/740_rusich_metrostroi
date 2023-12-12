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

[ru]
Entities.gmod_subway_81-740_4.Name = 81-740.4 (Русич глава beta)
Entities.gmod_subway_81-741_4.Name = 81-741.4 (Русич празнина beta)
self.Train.SubwayTrain.Name        = 81-740.4 (Русич глава beta)

#Cameras
Train.740.CameraCond    = Управление на климатике, ИГЛА
Train.740.CameraPPZ     = ППЗ
Train.740.CameraPV      = ВПУ
Train.740.CameraVityaz  = САУ "Витяз"
Train.740.CameraKRMH    = Крановете на КРМШ и УАВА
Train.740.CameraPVZ     = ПВЗ

#common 

Spawner.740.MotorType    = Тип звук ТЕД
Spawner.740.MotorType.Random   = Случайно
Spawner.740.MotorType2    = Тип 1
Spawner.740.MotorType3    = Тип 2
Spawner.740.MotorType4    = Тип 3 Стари (От Яуза)
Spawner.740.MotorType5    = Тип 4
Spawner.740.MotorType6    = Тип 5

Spawner.740.ZavodTable    = Местоположение на табелата на производителя
Spawner.740.ZavodTable.Random   = Случайно
Spawner.740.ZavodTable2    = Тип 1 близо до кабината на водача / крайната врата на предната секция
Spawner.740.ZavodTable3    = Тип 2 близо до прехода между секциите
Spawner.740.ZavodTable4    = Тип 3 Близо до крайната врата на задната секция

Spawner.740.RingSound    = Тип звук на звънене
Spawner.740.RingSound.Random   = Случайно
Spawner.740.RingSound2    = Тип 1
Spawner.740.RingSound3    = Тип 2
Spawner.740.RingSound4    = Тип 3
Spawner.740.RingSound5    = Тип 4

Spawner.740.BUKPVersion   = версия на фърмуера БУКП
Spawner.740.BUKPVersion1  = Стар вариант
Spawner.740.BUKPVersion2  = Нова вариант

Spawner.740.VentSound    = Тип звук на климатика
Spawner.740.VentSound.Random   = Случайно
Spawner.740.VentSound2    = Тип 1
Spawner.740.VentSound3    = Тип 2 

Common.740.CabinDoorLeft2 	= Лява врата към кабината на водача
Common.740.CabinDoorRight2	= Дясна врата към кабината на водача

Common.740.CabinDoorLeft 	= Лява врата на кабината на водача
Common.740.CabinDoorRight	= Дясна врата на кабината на водача

Common.740.BLTLPressure     = Налягане в напорните (черна стрелка) и спирачните (червена стрелка) линии
Common.740.BCPressure		= Налягане в спирачните цилиндри
Common.740.BatteryVoltage  	= Напрежение на батерията (В)
Common.740.HighVoltage      = Напрежение на контактната релса (кВ)
Common.740.EnginesCurrent1  = Ток 0 групи тягови двигатели (А)

Common.740.UAVA2			= УАВА: включване на прекъсвача на автостопа
Common.740.KRMH				= КРМШ: резервно включване на крана на машиниста

Common.740.FrontBrakeLineIsolationToggle 	= Краен клапан на спирачната линия
Common.740.FrontTrainLineIsolationToggle 	= Кран под налягане
Common.740.RearTrainLineIsolationToggle 	= Кран под налягане
Common.740.RearBrakeLineIsolationToggle 	= Краен клапан на спирачната линия

Common.741.FrontBrakeLineIsolationToggle 	= Краен клапан на спирачната линия
Common.741.FrontTrainLineIsolationToggle 	= Кран под налягане
Common.741.RearTrainLineIsolationToggle 	= Кран под налягане
Common.741.RearBrakeLineIsolationToggle 	= Краен клапан на спирачната линия

Common.741.RearDoor 						= Задна крайна врата
Common.740.FrontDoor 						= Предна крайна врата

Common.740.Password 						= Задаване/премахване на подсказка за парола
Common.740.Antenna  						= Инсталирайте/премахнете антената

Common.740.Vityaz.F1             = Витяз: F1
Common.740.Vityaz.F2             = Витяз: СКОР
Common.740.Vityaz.F4             = Витяз: Редовен режим
Common.740.Vityaz.F5             = Витяз: СБР
Common.740.Vityaz.F6             = Витяз: Нагоре\Скорост
Common.740.Vityaz.F7             = Витяз: Надолу\Течения
Common.740.Vityaz.F8             = Витяз: Вход\вагонно оборудване
Common.740.Vityaz.F9             = Витяз: Избор\Управление на вагонното оборудване
Common.740.Vityaz.0              = Витяз: 0
Common.740.Vityaz.1              = Витяз: 1
Common.740.Vityaz.2              = Витяз: 2
Common.740.Vityaz.3              = Витяз: 3
Common.740.Vityaz.4              = Витяз: 4
Common.740.Vityaz.5              = Витяз: 5
Common.740.Vityaz.6              = Витяз: 6
Common.740.Vityaz.7              = Витяз: 7
Common.740.Vityaz.8              = Витяз: 8
Common.740.Vityaz.9              = Витяз: 9

Common.740.Vityaz.PVU   	     = Витяз: ПВУ
Common.740.Vityaz.VO             = Витяз: ВО
Common.740.Vityaz.Current     	 = Витяз: ТОК 
Common.740.Vityaz.SOT   		 = Витяз: СОТ
Common.740.Vityaz.Num   		 = Витяз: №
Common.740.Vityaz.T   		     = Витяз: t°
Common.740.Vityaz.Next       	 = Витяз: Напред
Common.740.Vityaz.Back           = Витяз: Назад
Common.740.Vityaz.UTV 		     = Витяз: УПР ТВ	
Common.740.Vityaz.TV1 		     = Витяз: ТВ 1
Common.740.Vityaz.TV2 		     = Витяз: ТВ 2
Common.740.Vityaz.Noth 		     = Витяз: Не използувам

Common.740.VentCMode        = Режим на работа на вентилатора
Common.740.VentCMode+       = Увеличаване на отоплителната сила
Common.740.VentCMode-       = Намаляване на отоплителната сила
Common.740.VentSMode-       = Увеличете силата на вентилатора
Common.740.VentSMode+       = Намаляване на силата на вентилатора

Common.740.EmerX1           = Резервен старт в режим ход 1
Common.740.EmerX2           = Резервен старт в режим ход 2
Common.740.EmerCloseDoors   = Резервно затваряне на вратите
Common.740.EmergencyDoors   = Активиране на резервното управление на вратите

Common.740.SF1              = SF1: Хранене общо
Common.740.SF2              = SF2: Управление основно
Common.740.SF3              = SF3: Управление на резерва
Common.740.SF4              = SF4: БАРС (Блок автоматично регулиране на скоростта)
Common.740.SF5              = SF5: БУП (блок за управление на влака)
Common.740.SF6              = SF6: БКЦУ (блок за превключване на управляващи вериги)
Common.740.SF7              = SF7: ППО (АСОТП)
Common.740.SF8              = SF8: Сигнал
Common.740.SF9              = SF9: Радио
Common.740.SF10             = SF10: Ориентация на вагона
Common.740.SF11             = SF11: Посока
Common.740.SF12             = SF12: Фарове от 1-ва група
Common.740.SF13             = SF13: Фарове от 2-ва група
Common.740.SF14             = SF14: Габаритни светлини
Common.740.SF15             = SF15: Осветление на кабината
Common.740.SF16             = SF16: Отопление
Common.740.SF17             = SF17: Климатик в кабината
Common.740.SF18             = SF18: Гребен смазка
Common.740.SF19             = SF19: Основно захранване на крана на машиниста
Common.740.SF20             = SF20: Захранване кран машинист резервно
Common.740.SF21             = SF21: Отваряне на вратата
Common.740.SF22             = SF22: Затваряне на вратите

Common.740.Pant1            = Изстискване на токоприемници от 1-ва група
Common.740.Pant2            = Изстискване на токоприемници от 2-ва група
Common.740.Vent2            = Вътрешна вентилация
Common.740.TorecDoors       = Крайни врати
Common.740.BBER             = Резервно включване на ИПП
Common.740.BBE              = Включване на ИПП
Common.740.CabLightStrength = Яркост на осветлението в кабината
Common.740.AppLights        = Осветление на хардуерното отделение
Common.740.BARSBlock        = Блокиране на дефектни БАРС
Common.740.AppVent          = Вентилация на хардуерното отделение
Common.740.PassLights		= Вътрешно осветление
Common.740.CabLights		= Осветление на кабината
Common.740.VF1				= Фарове 1 група
Common.740.VF2				= Фарове 2 група
Common.740.ParkingBrake		= Ръчна спирачка
Common.740.MK				= Включване на мотор-компресора
Common.740.VB				= Сб: включване на батериите
Common.740.ALSFreqBlock-	= Превключвател за режим на декриптор
Common.740.ALSFreqBlock+	= Превключвател за режим на декриптор
Common.740.BRU				= БРУ

Common.740.IGLA.Button1		= ИГЛА: Първият бутон
Common.740.IGLA.Button2		= ИГЛА: Втори бутон
Common.740.IGLA.Button3		= ИГЛА: Трети бутон
Common.740.IGLA.Button4		= ИГЛА: Четвърти бутон
Common.740.IGLA.Button23	= ИГЛА: Втори и трети бутон
Common.740.IGLA.IGLAPI		= ИГЛА: Пожар
Common.740.IGLA.IGLAErr		= ИГЛА: Грешка

Common.740.SpeedCurr 		= Действителна скорост
Common.740.SpeedAttent		= Препоръчителна скорост
Common.740.SpeedAccept 		= Текуща скорост
Common.740.SpeedAccept1 	= Допустима скорост
Common.740.Forward          = Движение напред
Common.740.Backward 		= Движение назад

Common.740.AccelRate			= Активиране на режим "Повдигане"
Common.740.HVoltage 			= Лампа без напрежение в контактната мрежа
Common.740.Stand           		= Подгряване на подложки
Common.740.ALS					= Бутон за превключване на системата АРС в режим на локомотивна аларма
Common.740.Ring             	= Прехвърляне на контрол (обаждане)
Common.740.PassScheme       	= Включване на таблото за врати в кабината
Common.740.DisableBV 			= Изключване на БВ
Common.740.R_Line 				= Включване на микрофона на машиниста
Common.740.R_Emer				= Активиране на аварийна комуникация
Common.740.Wiper 				= Включване на чистачката
Common.740.R_Announcer      	= Миене
Common.740.EmergencyCompressor	= Бутон за резервен мотор-компресор
Common.740.EmergencyControls    = Превключвател за резервно включване на контролните вериги
Common.740.DoorSelectL          = Избор на леви врати
Common.740.DoorSelectR          = Избор на десни врати
Common.740.DoorBlock            = Движение без контрол на вратите
Common.740.KDL                  = Отваряне на левите врати
Common.740.KDP                  = Отваряне на десните врати
Common.740.EBrakeAdd            = Увеличете зададената точка на резервната спирачка
Common.740.EBrakeRelease        = Намаляване на зададената точка на резервната спирачка
Common.740.EBrakeToggle         = Включване на резервната спирачка
Common.740.EmergencyBrake       = Задействане на аварийната спирачка 	
Common.740.DoorClose            = Затваряне на вратите
Common.740.AttentionMessage     = Бутон за възприемане на съобщение
Common.740.LSD  				= Алармена лампа за врати (затворени врати)
Common.740.KAH					= Бутон за аварийно движение БАРС
Common.740.ALSk					= Капак на бутона АЛС
Common.740.ARS.KB 				= КБ: бутон за бдителност
Common.740.ARS.KVT				= КВС: бутон за възприемане на спирачката
Common.740.Program1				= Стартиране на запис (програма 1)
Common.740.Program2				= Стартиране на запис (програма 2)
Common.740.Horn					= Тайфун
Common.740.TPT                  = ТПТ: Спиране от междинни колички

Common.740.CAMS5Set				= Преглед: пристанищен борд
Common.740.CAMS6Set 			= Преглед: десен борд
Common.740.CAMS7Set 			= Преглед: Глави
Common.740.CAMS8Set 			= Преглед: Опашка
Common.740.CAMS9Set 			= Преглед: Ляво
Common.740.CAMS10Set		 	= Преглед: Дясно

Common.740.ABSD 				 = АБСД: Аварийная блокировка сигнализатора давления 
Common.740.RTE 				 	 = Аварийна резервна спирачка (РТЭ)

Common.740.SFV1             = SF1: Захранване на веригите за управление на вагона
Common.740.SFV2             = SF2: Захранване на контролния блок на вагона
Common.740.SFV3             = SF3: Захранване на блока за управление на тяговото задвижване
Common.740.SFV4             = SF4: Управление на блока за управление на тяговото задвижване
Common.740.SFV5             = SF5: Резервно управление на блока за управление на тяговото задвижване
Common.740.SFV6             = SF6: БУТП храна
Common.740.SFV7             = SF7: Бордово захранване
Common.740.SFV8             = SF8: Aнти хлъзгане
Common.740.SFV9             = SF9: БВ храна
Common.740.SFV10            = SF10: ППО (АСОТП ПЦБК)
Common.740.SFV11            = SF11: Мотор-компрессор
Common.740.SFV12            = SF12: Затваряне на вратите
Common.740.SFV13            = SF13: Отваряне на левите врати
Common.740.SFV14            = SF14: Отваряне на десните врати
Common.740.SFV15            = SF15: Крайни врати
Common.740.SFV16            = SF16: Сигнал
Common.740.SFV17            = SF17: Спешна комуникация
Common.740.SFV18            = SF18: Резерва
Common.740.SFV19            = SF19: Вътрешно осветление захранване
Common.740.SFV20            = SF20: Аварийно вътрешно осветление
Common.740.SFV21            = SF21: Сензор за скорост
Common.740.SFV22            = SF22: Ръчна спирачка
Common.740.SFV23            = SF23: Контрол на вътрешната вентилация
Common.740.SFV24            = SF24: Вътрешно вентилационно захранване
Common.740.SFV25            = SF25: Хранене на патогена
Common.740.SFV26            = SF26: Захранване на зареждащия кондензатор
Common.740.SFV27            = SF27: Токоприемници
Common.740.SFV28            = SF28: Инвертор
Common.740.SFV29            = SF29: Резерва
Common.740.SFV30            = SF30: Резерва
Common.740.SFV31            = SF31: Резерва
Common.740.SFV32            = SF32: Балансиращи силови вериги
Common.740.SFV33            = SF33: Видео

Common.740.LN               = ЛН: Лампа за съвпадение на посоката
Common.740.Dnepr			= ДНЕПР: Лампа за включване на режим Днепър
Common.740.XOD				= ХОД: Лампа за ход
Common.740.DAU				= ДАУ: Лампа за работа на резервно автономно устройство 
Common.740.Ispr 			= ИСПР: Сервизна лампа на комплекти БАРС
Common.740.AO				= АО: Лампа за получаване на абсолютен стоп сигнал
Common.740.Forw				= Движение напред
Common.740.Back				= Движение назад

#gmod_subway_81-740_4
#Buttons:

Entities.gmod_subway_81-740_4.Buttons.BackVent.VentCondMode-      = @[Common.740.VentCMode] @[Common.ALL.CCW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentCondMode+      = @[Common.740.VentCMode] @[Common.ALL.CW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentStrengthMode-  = @[Common.740.VentSMode-] @[Common.ALL.CCW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentStrengthMode+  = @[Common.740.VentSMode+] @[Common.ALL.CW]

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

Entities.gmod_subway_81-740_4.Buttons.EmergencyBrake1.EmerBrakeCrane1Toggle = @[Common.ALL.EmergencyBrakeValve]

Entities.gmod_subway_81-740_4.Buttons.CraneCap2.ABSDToggle   	 = @[Common.740.ABSD]
Entities.gmod_subway_81-740_4.Buttons.CraneCap2.RTEToggle  		 = @[Common.740.RTE]

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
Entities.gmod_subway_kuzov.Buttons.RearDoor_front.RearDoor   					 = @[Common.741.RearDoor]

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