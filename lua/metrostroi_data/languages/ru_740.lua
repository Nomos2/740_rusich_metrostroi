local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_krl")
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
Entities.gmod_subway_81-740_4.Name = 81-740.4 (Русич головной beta)
Entities.gmod_subway_81-741_4.Name = 81-741.4 (Русич промежуток beta)
self.Train.SubwayTrain.Name        = 81-740.4 (Русич головной beta)

#Cameras
Train.740.CameraCond    = Управление кондиционером, ИГЛА
Train.740.CameraPPZ     = ППЗ
Train.740.CameraPV      = ВПУ
Train.740.CameraVityaz  = САУ "Витязь"
Train.740.CameraKRMH    = Краны КРМШ и УАВА
Train.740.CameraPVZ     = ПВЗ
Train.740.BUCIK    		= БУЦИК (Не работает)

#common 

Spawner.740.MotorType    = Тип звука ТЭД
Spawner.740.Common.Random   = Случайно
Spawner.740.MotorType2    = Тип 1
Spawner.740.MotorType3    = Тип 2
Spawner.740.MotorType4    = Тип 3 Старые (С Яузы)
Spawner.740.MotorType5    = Тип 4
Spawner.740.MotorType6    = Тип 5

Spawner.740.ZavodTable     = Расположение таблички завода-изготовителя
Spawner.740.ZavodTable2    = Тип 1 Около кабины машиниста/торцевой двери передней секции и около перехода между секциями
Spawner.740.ZavodTable3    = Тип 2 Около торцевой двери задней секции и около перехода между секциями

Spawner.740.RingSound     = Тип звука звонка
Spawner.740.RingSound2    = Тип 1
Spawner.740.RingSound3    = Тип 2
Spawner.740.RingSound4    = Тип 3
Spawner.740.RingSound5    = Тип 4

Spawner.740.BUKPVersion   = Версия прошивки БУКП
Spawner.740.BUKPVersion1  = Старая
Spawner.740.BUKPVersion2  = Новая

Spawner.740.VentSound    = Тип звука шума кондиционера
Spawner.740.VentSound2    = Тип 1
Spawner.740.VentSound3    = Тип 2 

Common.740.CabinDoorLeft2 	= Левая дверь в кабину машиниста
Common.740.CabinDoorRight2	= Правая дверь в кабину машиниста

Common.740.CabinDoorLeft 	= Левая дверь кабины машиниста
Common.740.CabinDoorRight	= Правая дверь кабины машиниста

Common.740.BLTLPressure     = Давление в напорной (чёрная стрелка) и тормозной (красная стрелка) магистралях
Common.740.BCPressure		= Давление в тормозных цилиндрах
Common.740.BatteryVoltage  	= Напряжение на аккумуляторной батарее (В)
Common.740.HighVoltage      = Напряжение на контактном рельсе (кВ)
Common.740.EnginesCurrent1  = Ток I группы тяговых двигателей (А)

Common.740.UAVA2			= УАВА: Включение автоматического выключателя автостопа
Common.740.KRMH				= КРМШ: Резервное включение крана машиниста

Common.740.FrontBrakeLineIsolationToggle 	= Концевой кран тормозной магистрали
Common.740.FrontTrainLineIsolationToggle 	= Концевой кран напорной магистрали
Common.740.RearTrainLineIsolationToggle 	= Концевой кран напорной магистрали
Common.740.RearBrakeLineIsolationToggle 	= Концевой кран тормозной магистрали

Common.741.FrontBrakeLineIsolationToggle 	= Концевой кран тормозной магистрали
Common.741.FrontTrainLineIsolationToggle 	= Концевой кран напорной магистрали
Common.741.RearTrainLineIsolationToggle 	= Концевой кран напорной магистрали
Common.741.RearBrakeLineIsolationToggle 	= Концевой кран тормозной магистрали

Common.741.RearDoor 						= Задняя торцевая дверь
Common.740.FrontDoor 						= Передняя торцевая дверь

Common.740.Password 						= Установить/снять подсказку пароля
Common.740.Antenna  						= Установить/снять антенну

Common.740.Vityaz.F1             = Витязь: F1
Common.740.Vityaz.F2             = Витязь: СКОР
Common.740.Vityaz.F4             = Витязь: Штатный режим
Common.740.Vityaz.F5             = Витязь: СБР
Common.740.Vityaz.F6             = Витязь: Вверх\Скорость
Common.740.Vityaz.F7             = Витязь: Вниз\Токи
Common.740.Vityaz.F8             = Витязь: Ввод\Вагонное оборудование
Common.740.Vityaz.F9             = Витязь: Выбор\Управление вагонным оборудованием
Common.740.Vityaz.0              = Витязь: 0
Common.740.Vityaz.1              = Витязь: 1
Common.740.Vityaz.2              = Витязь: 2
Common.740.Vityaz.3              = Витязь: 3
Common.740.Vityaz.4              = Витязь: 4
Common.740.Vityaz.5              = Витязь: 5
Common.740.Vityaz.6              = Витязь: 6
Common.740.Vityaz.7              = Витязь: 7
Common.740.Vityaz.8              = Витязь: 8
Common.740.Vityaz.9              = Витязь: 9

Common.740.Vityaz.PVU   	     = Витязь: ПВУ
Common.740.Vityaz.VO             = Витязь: ВО
Common.740.Vityaz.Current     	 = Витязь: ТОК 
Common.740.Vityaz.SOT   		 = Витязь: СОТ
Common.740.Vityaz.Num   		 = Витязь: №
Common.740.Vityaz.T   		     = Витязь: t°
Common.740.Vityaz.Next       	 = Витязь: Вперед
Common.740.Vityaz.Back           = Витязь: Назад
Common.740.Vityaz.UTV 		     = Витязь: УПР ТВ	
Common.740.Vityaz.TV1 		     = Витязь: ТВ 1
Common.740.Vityaz.TV2 		     = Витязь: ТВ 2
Common.740.Vityaz.Noth 		     = Витязь: Не используется

Common.740.ABSD 				 = АБСД: Аварийная блокировка сигнализатора давления
Common.740.RTE 				 	 = РТЭ: Резервный тормоз экстренный

Common.740.VentCMode        = Режим работы вентилятора
Common.740.VentCMode+       = Увеличение силы обогрева
Common.740.VentCMode-       = Уменьшение силы обогрева
Common.740.VentSMode-       = Увеличение силы вентилятора
Common.740.VentSMode+       = Уменьшение силы вентилятора

Common.740.EmerX1           = Резервный пуск в режиме ход 1
Common.740.EmerX2           = Резервный пуск в режиме ход 2
Common.740.EmerCloseDoors   = Резервное закрытие дверей
Common.740.EmergencyDoors   = Включение резервного управления дверьми

Common.740.SF1              = SF1: Питание общее
Common.740.SF2              = SF2: Управление основное
Common.740.SF3              = SF3: Управление резервное
Common.740.SF4              = SF4: БАРС
Common.740.SF5              = SF5: БУП (блок управления поездом)
Common.740.SF6              = SF6: БКЦУ (блок коммутации цепей управления)
Common.740.SF7              = SF7: ППО (АСОТП)
Common.740.SF8              = SF8: Оповещение
Common.740.SF9              = SF9: Радиосвязь
Common.740.SF10             = SF10: Ориентация вагона
Common.740.SF11             = SF11: Направление движения
Common.740.SF12             = SF12: Фары 1-й группы
Common.740.SF13             = SF13: Фары 2-й группы
Common.740.SF14             = SF14: Огни габаритные
Common.740.SF15             = SF15: Освещение кабины
Common.740.SF16             = SF16: Отопление
Common.740.SF17             = SF17: Кондиционер кабины
Common.740.SF18             = SF18: Гребнесмазыватель
Common.740.SF19             = SF19: Питание крана машиниста основное
Common.740.SF20             = SF20: Питание крана машиниста резервное
Common.740.SF21             = SF21: Двери открытие
Common.740.SF22             = SF22: Двери закрытие

Common.740.Pant1            = Отжатие токоприёмников 1-й группы
Common.740.Pant2            = Отжатие токоприёмников 2-й группы
Common.740.Vent2            = Вентиляция салона
Common.740.TorecDoors       = Двери торцевые
Common.740.BBER             = Резервное включение ИПП
Common.740.BBE              = Включение ИПП
Common.740.CabLightStrength = Яркость освещения кабины
Common.740.AppLights        = Освещение аппаратного отсека
Common.740.BARSBlock        = Блокировка неисправных БАРСов
Common.740.AppVent          = Вентиляция аппаратного отсека
Common.740.PassLights		= Освещение салона
Common.740.CabLights		= Освещение кабины
Common.740.VF1				= Фары 1 группа
Common.740.VF2				= Фары 2 группа
Common.740.ParkingBrake		= Стояночный тормоз
Common.740.MK				= Включение мотор-компрессора
Common.740.VB				= ВБ: Включение батарей
Common.740.ALSFreqBlock-	= Переключатель режимов дешифратора
Common.740.ALSFreqBlock+	= Переключатель режимов дешифратора
Common.740.BRU				= БРУ

Common.740.IGLA.Button1		= ИГЛА: Первая кнопка
Common.740.IGLA.Button2		= ИГЛА: Вторая кнопка
Common.740.IGLA.Button3		= ИГЛА: Третья кнопка
Common.740.IGLA.Button4		= ИГЛА: Четвертая кнопка
Common.740.IGLA.Button23	= ИГЛА: Вторая и третья кнопка
Common.740.IGLA.IGLAPI		= ИГЛА: Пожар
Common.740.IGLA.IGLAErr		= ИГЛА: Ошибка

Common.740.SpeedCurr 		= Фактическая скорость
Common.740.SpeedAttent		= Рекомендуемая скорость
Common.740.SpeedAccept 		= Текущая скорость
Common.740.SpeedAccept1 	= Допустимая скорость
Common.740.Forward          = Движение вперед
Common.740.Backward 		= Движение назад

Common.740.AccelRate			= Включение режима "Подъём"
Common.740.HVoltage 			= Лампа отсутствия напряжения в контактной сети
Common.740.Stand           		= Прогрев колодок
Common.740.ALS					= Кнопка перевода системы АРС в режим локомотивной сигнализации
Common.740.Ring             	= Передача управления (звонок)
Common.740.PassScheme       	= Включение наддверного табло в салоне
Common.740.DisableBV 			= Отключение БВ
Common.740.R_Line 				= Включение микрофона машиниста
Common.740.R_Emer				= Включение экстренной связи
Common.740.Wiper 				= Включение стеклоочистителя
Common.740.R_Announcer      	= Омыватель
Common.740.EmergencyCompressor	= Кнопка резервного мотор-компрессора
Common.740.EmergencyControls    = Выключатель резервного включения цепей управления
Common.740.DoorSelectL          = Выбор левых дверей
Common.740.DoorSelectR          = Выбор правых дверей
Common.740.DoorBlock            = Движение без контроля дверей
Common.740.KDL                  = Открытие левых дверей
Common.740.KDP                  = Открытие правых дверей
Common.740.EBrakeAdd            = Увеличение уставки резервного тормоза
Common.740.EBrakeRelease        = Уменьшение уставки резервного тормоза
Common.740.EBrakeToggle         = Включение резервного тормоза
Common.740.EmergencyBrake       = Включение экстренного тормоза
Common.740.DoorClose            = Закрытие дверей
Common.740.AttentionMessage     = Кнопка восприятия сообщения
Common.740.LSD  				= Лампа сигнализации дверей (двери закрыты)
Common.740.KAH					= Кнопка включения аварийного хода БАРС
Common.740.ALSk					= Крышка кнопки АЛС
Common.740.ARS.KB 				= КБ: Кнопка бдительности
Common.740.ARS.KVT				= КВТ: Кнопка восприятия торможения
Common.740.Program1				= Пуск записи (программа 1)
Common.740.Program2				= Пуск записи (программа 2)
Common.740.Horn					= Тайфун
Common.740.TPT                  = ТПТ: Торможение промежуточными тележками

Common.740.CAMS5Set				= Обзор: Левый борт
Common.740.CAMS6Set 			= Обзор: Правый борт
Common.740.CAMS7Set 			= Обзор: Головные
Common.740.CAMS8Set 			= Обзор: Хвостовые
Common.740.CAMS9Set 			= Обзор: Левая
Common.740.CAMS10Set		 	= Обзор: Правая

Common.740.SFV1             = SF1: Питание цепей управления вагона
Common.740.SFV2             = SF2: Питание блока управления вагона
Common.740.SFV3             = SF3: Питание блока управления тяговым приводом
Common.740.SFV4             = SF4: Управление блоком управления тяговым приводом
Common.740.SFV5             = SF5: Резервное управление блоком управления тяговым приводом
Common.740.SFV6             = SF6: БУТП питание
Common.740.SFV7             = SF7: Блок бортового энергоснабжения
Common.740.SFV8             = SF8: Противоюз
Common.740.SFV9             = SF9: БВ питание
Common.740.SFV10            = SF10: ППО (АСОТП ПЦБК)
Common.740.SFV11            = SF11: Мотор-компрессор
Common.740.SFV12            = SF12: Двери закрытие
Common.740.SFV13            = SF13: Открытие левых дверей
Common.740.SFV14            = SF14: Открытие правых дверей
Common.740.SFV15            = SF15: Двери торцевые
Common.740.SFV16            = SF16: Оповещение
Common.740.SFV17            = SF17: Экстренная связь
Common.740.SFV18            = SF18: Резерв
Common.740.SFV19            = SF19: Освещение салона питание
Common.740.SFV20            = SF20: Освещение салона аварийное
Common.740.SFV21            = SF21: Датчик скорости
Common.740.SFV22            = SF22: Тормоз стояночный
Common.740.SFV23            = SF23: Управление вентиляцией салона
Common.740.SFV24            = SF24: Питание вентиляции салона
Common.740.SFV25            = SF25: Питание возбудителя (͡° ͜ʖ ͡°)
Common.740.SFV26            = SF26: Питание зарядного конденсатора
Common.740.SFV27            = SF27: Токоприёмники
Common.740.SFV28            = SF28: Инвертор
Common.740.SFV29            = SF29: Резерв
Common.740.SFV30            = SF30: Резерв
Common.740.SFV31            = SF31: Резерв
Common.740.SFV32            = SF32: Уравнительные цепи питания
Common.740.SFV33            = SF33: Видео

Common.740.LN               = ЛН: Лампа соответствия направления движения
Common.740.Dnepr			= ДНЕПР: Лампа включения режима "Днепр"
Common.740.XOD				= ХОД: Лампа отсутствия запрета тягового режима от БАРС
Common.740.DAU				= ДАУ: Лампа работы дублирующего автономного устройства 
Common.740.Ispr 			= ИСПР: Лампа исправности комплектов БАРС
Common.740.AO				= АО: Лампа получения сигнала абсолютной остановки
Common.740.Forw				= Движение вперёд
Common.740.Back				= Движение назад

Common.740.EmergencyBrakeValve				= Стопкран

#gmod_subway_81-740_4
#Buttons:

Entities.gmod_subway_81-740_4.Buttons.BackVent.VentCondMode-      = @[Common.740.VentCMode] @[Common.ALL.CCW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentCondMode+      = @[Common.740.VentCMode] @[Common.ALL.CW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentStrengthMode-  = @[Common.740.VentSMode-] @[Common.ALL.CCW]
Entities.gmod_subway_81-740_4.Buttons.BackVent.VentStrengthMode+  = @[Common.740.VentSMode+] @[Common.ALL.CW]

Entities.gmod_subway_81-740_4.Buttons.EmergencyBrake1.EmerBrakeCrane1Toggle = @[Common.740.EmergencyBrakeValve]

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

Entities.gmod_subway_81-740_4.Buttons.CraneCap2.ABSDToggle   	   = @[Common.740.ABSD]
Entities.gmod_subway_81-740_4.Buttons.CraneCap2.RTEToggle  		   = @[Common.740.RTE]

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
Entities.gmod_subway_81-740_4.Buttons.BackDown.ALSFreqBlockToggle     = @[Common.740.ALSFreqBlock-]
Entities.gmod_subway_81-740_4.Buttons.BackDown.ALSFreqBlockToggle     = @[Common.740.ALSFreqBlock+]

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

Entities.gmod_subway_81-740_4.Buttons.CabinDoorR.CabinDoorRight       = @[Common.740.CabinDoorRight]
Entities.gmod_subway_81-740_4.Buttons.CabinDoorL.CabinDoorLeft        = @[Common.740.CabinDoorLeft]

Entities.gmod_subway_81-740_4.Buttons.CabinDoorR2.CabinDoorRight       = @[Common.740.CabinDoorRight2]
Entities.gmod_subway_81-740_4.Buttons.CabinDoorL2.CabinDoorLeft        = @[Common.740.CabinDoorLeft2]

Entities.gmod_subway_81-740_4.Buttons.VoltHelper2.!HV                 = @[Common.740.HighVoltage]
Entities.gmod_subway_81-740_4.Buttons.VoltHelper2.!I1_3               = @[Common.740.EnginesCurrent1]
Entities.gmod_subway_81-740_4.Buttons.PneumoHelper2.!BrakeTrainLine   = @[Common.740.BLTLPressure]
Entities.gmod_subway_81-740_4.Buttons.PneumoHelper1.!BrakeCylinder    = @[Common.740.BCPressure]
Entities.gmod_subway_81-740_4.Buttons.GV.GVToggle                     = @[Common.740.BRU]

Entities.gmod_subway_81-740_4.Buttons.Antenna.Antenna      	  = @[Common.740.Antenna]
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
Entities.gmod_subway_81-740_4.Spawner.MotorType.1 		  	  = @[Spawner.740.Common.Random] 
Entities.gmod_subway_81-740_4.Spawner.MotorType.2         	  = @[Spawner.740.MotorType2]
Entities.gmod_subway_81-740_4.Spawner.MotorType.3          	  = @[Spawner.740.MotorType3]
Entities.gmod_subway_81-740_4.Spawner.MotorType.4          	  = @[Spawner.740.MotorType4]
Entities.gmod_subway_81-740_4.Spawner.MotorType.5          	  = @[Spawner.740.MotorType5]
Entities.gmod_subway_81-740_4.Spawner.MotorType.6          	  = @[Spawner.740.MotorType6]

Entities.gmod_subway_81-740_4.Spawner.ZavodTable.Name 		  = @[Spawner.740.ZavodTable] 
Entities.gmod_subway_81-740_4.Spawner.ZavodTable.1 		  	  = @[Spawner.740.Common.Random] 
Entities.gmod_subway_81-740_4.Spawner.ZavodTable.2         	  = @[Spawner.740.ZavodTable2]
Entities.gmod_subway_81-740_4.Spawner.ZavodTable.3            = @[Spawner.740.ZavodTable3]

Entities.gmod_subway_81-740_4.Spawner.VentSound.Name 		  = @[Spawner.740.VentSound] 
Entities.gmod_subway_81-740_4.Spawner.VentSound.1 		  	  = @[Spawner.740.Common.Random] 
Entities.gmod_subway_81-740_4.Spawner.VentSound.2         	  = @[Spawner.740.VentSound2]
Entities.gmod_subway_81-740_4.Spawner.VentSound.3             = @[Spawner.740.VentSound3]

Entities.gmod_subway_81-740_4.Spawner.RingSound.Name 		  = @[Spawner.740.RingSound] 
Entities.gmod_subway_81-740_4.Spawner.RingSound.1 		  	  = @[Spawner.740.Common.Random] 
Entities.gmod_subway_81-740_4.Spawner.RingSound.2         	  = @[Spawner.740.RingSound2]
Entities.gmod_subway_81-740_4.Spawner.RingSound.3             = @[Spawner.740.RingSound3]
Entities.gmod_subway_81-740_4.Spawner.RingSound.4         	  = @[Spawner.740.RingSound4]
Entities.gmod_subway_81-740_4.Spawner.RingSound.5             = @[Spawner.740.RingSound5]

Entities.gmod_subway_81-740_4.Spawner.BUKPVersion.Name 		  = @[Spawner.740.BUKPVersion]
Entities.gmod_subway_81-740_4.Spawner.BUKPVersion.1 	      = @[Spawner.740.Common.Random] 
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