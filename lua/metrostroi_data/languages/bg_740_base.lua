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
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")
or Map:find("gm_metropbl")) then 
	return
end
return 
[[
#Base text for Bulgarian language

[bg]
lang        = Българска
AuthorText  = #Author text

#Spawner common
Spawner.Title                           = Създател на влак #FIXME
Spawner.Spawn                           = Създавайте #FIXME
Spawner.Close                           = Близо #FIXME
Spawner.Trains1                         = Разрешен ваг.
Spawner.Trains2                         = На човек
Spawner.WagNum                          = Брой коли
Common.Spawner.Texture                  = Рисуване по тяло
Common.Spawner.PassTexture              = Интериорно боядисване
Common.Spawner.CabTexture               = Боядисване на кабина
Common.Spawner.Announcer                = Тип информатор
Common.Spawner.Type1                    = Тип 1
Common.Spawner.Type2                    = Тип 2
Common.Spawner.Type3                    = Тип 3
Common.Spawner.Type4                    = Тип 4
Common.Spawner.SpawnMode                = Състояние на влака
Common.Spawner.SpawnMode.Deadlock       = Задънен край
Common.Spawner.SpawnMode.Full           = Напълно стартиран
Common.Spawner.SpawnMode.NightDeadlock  = Нощта е гадна
Common.Spawner.SpawnMode.Depot          = Депо
Common.Spawner.SchemeInvert             = Обърнете схеми за над врата

#Coupler common
Common.Couple.Title         = Хич меню
Common.Couple.CoupleState   = Състояние на теглича
Common.Couple.Coupled       = Свързан
Common.Couple.Uncoupled     = Несвързан
Common.Couple.Uncouple      = Раздвоете
Common.Couple.IsolState     = Състояние на крайните клапани
Common.Couple.Isolated      = Затворено
Common.Couple.Opened        = Отворете
Common.Couple.Open          = Отворете
Common.Couple.Isolate       = Близо
Common.Couple.EKKState      = Състояние на EKК
Common.Couple.Disconnected  = Прекъсната връзка
Common.Couple.Connected     = Свързан
Common.Couple.Connect       = Свържете се
Common.Couple.Disconnect    = Прекъснете връзката

#Bogey common
Common.Bogey.Title              = Меню количка
Common.Bogey.ContactState       = Състояние на пантографите
Common.Bogey.CReleased          = Изцедени
Common.Bogey.CPressed           = Закрепен
Common.Bogey.CPress             = Натиснете
Common.Bogey.CRelease           = Стиснете
Common.Bogey.ParkingBrakeState  = Състояние на ръчната спирачка
Common.Bogey.PBDisabled         = Ръчно деактивирано
Common.Bogey.PBEnabled          = Включени
Common.Bogey.PBEnable           = Включи
Common.Bogey.PBDisable          = Деактивирайте ръчно

#Trains common
Common.740.CW                               = (по часовниковата стрелка)
Common.740.CCW                              = (обратно на часовниковата стрелка)
]]