--------------------------------------------------------------------------------
-- 81-740 tickers
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
-- Fixed by LiWinDom (STEAM_0:0:190697714)
--------------------------------------------------------------------------------

Metrostroi.DefineSystem("81_740_4Ticker")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
end

if TURBOSTROI then return end

function TRAIN_SYSTEM:Inputs()
    return {}
end

function TRAIN_SYSTEM:Outputs()
    return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
if CLIENT then
    function TRAIN_SYSTEM:ClientInitialize()
    end
	local function createFont(font, size)
        surface.CreateFont("Metrostroi_740_ticker", {
            font = font,
            size = size,
            weight = 00,
            blursize = false,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = true,
            outline = false,
            extended = true,
            scanlines = false,
        })
    end
    createFont("Moscow_metro_round_fix", 42)
    function TRAIN_SYSTEM:ClientThink()
        local str = self.Train:GetNW2String("TickerMessage","")
        local col = Color(self.Train:GetNW2Int("TickerColorR",255), self.Train:GetNW2Int("TickerColorG",0), self.Train:GetNW2Int("TickerColorB",0))
        local pos = self.Train:GetNW2Int("TickerState",0)
        if self.Train:ShouldDrawPanel("Tickers") and (self.Text ~= str or self.Position ~= pos) then
            self.Text = str
            self.Position = pos
            self.Color = col
            render.PushRenderTarget(self.Train.Tickers,0,0,1000,64)
            render.Clear(0, 0, 0, 0)
            cam.Start2D()				
            self:Tickers(self.Train)
            cam.End2D()
            render.PopRenderTarget() 
        end
    end
    function TRAIN_SYSTEM:PrintText(x, text, color)
	    local Train = self.Train
        local drawColor = color or Color(200, 0, 0)
        local str = {utf8.codepoint(text, 1, -1)}
        for i = 0, #str - 1 do
            local xpos = i * 35.5 + x * 3.505

            --if i*26.5+x*3.005+20 < 0 then continue end
            --if (i-33)*26.5+x*3.005+20 > 0 then continue end
            if -18.5 < xpos and xpos < 41 * 23 then
                local char = utf8.char(str[i + 1])
                draw.SimpleText(char, "Metrostroi_740_ticker", xpos + 40, 30, drawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
    end
--draw.SimpleText(char,"Metrostroi_Tickers",(x+i)*20.5+8,34,Color(0,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

    function TRAIN_SYSTEM:Tickers(Train)
        if self.Text  ~= "" then
            self:PrintText(self.Position, self.Text, self.Color)
        end
    end
    return
end

function TRAIN_SYSTEM:Initialize()
    self.Weekdays = {} --TODO: через отдельный файл
    self.Weekdays["Mon"] = "ПН"
    self.Weekdays["Tue"] = "ВТ"
    self.Weekdays["Wed"] = "СР"
    self.Weekdays["Thu"] = "ЧТ"
    self.Weekdays["Fri"] = "ПТ"
    self.Weekdays["Sat"] = "СБ"
    self.Weekdays["Sun"] = "ВС"

    self.ReplaceStations = {}
    self.EnStations = {} --TODO: через отдельный файл
    --Pink line
    self.EnStations["Первомайская"] = "Pervomayskaya"
    self.EnStations["Зябликово"] = "Zyablikovo"
    self.EnStations["Партизанская"] = "Partizanskaya"
    self.EnStations["Гидропарк"] = "Gidropark"
    --LDL
    self.EnStations["Дубровка"] = "Dubrovka"
    self.EnStations["Кожуховская"] = "Kozhuhovskaya"
    self.EnStations["Печатники"] = "Pechatniki"
    self.EnStations["Волжская"] = "Volzhskaya"
    self.EnStations["Люблино"] = "Lyublino"		
    --Nekrasovka
    self.EnStations["Некрасовка"] = "Nekrasovka"
    self.EnStations["Лухмановская"] = "Luhmanovskaya"
    self.EnStations["Улица Дмитриевского"] = "Ulitsa Dmitrievskogo"
    self.EnStations["Косино"] = "Kosino"
    self.EnStations["Юго-Восточная"] = "Yugo-Vostochnaya"
    self.EnStations["Окская"] = "Okskaya"
    self.EnStations["Стахановская"] = "Stahanovskaya"
    self.EnStations["Нижегородская"] = "Nizhegorodskaya"
    --Surface
    self.EnStations["Советская"] = "Sovetskaya"
    self.EnStations["Артемидовская"] = "Artemidovskaya"
    self.ReplaceStations["Антиколлаб-ская"] = "Антиколлаборанистическая"
    self.EnStations["Антиколлаб-ская"] = "Antikollaboranisticheskaya"
    self.EnStations["Индустриальная"] = "Industrialnaya"
    self.EnStations["Площадь Восстания"] = "Ploshad Vostaniya"
    self.EnStations["Куровская"] = "Kurovskaya"
    self.ReplaceStations["Ул. Кляйнера"] = "Улица Айзека Кляйнера"
    self.EnStations["Ул. Кляйнера"] = "Ulitsa Ajzeka Klyajnera"
	
    --b50
    self.EnStations["Автозаводская"] = "Avtozavodskaya"
    self.EnStations["Индустриальная"] = "Industrialnaya"
    self.EnStations["Московская"] = "Moskovskaya"
    self.EnStations["Октябрьская"] = "Oktybr'skaya"
    self.EnStations["Площадь Мира"] = "Ploshad' Mira"
    self.EnStations["Новоармейская"] = "Novoarmeyskaya"
    self.EnStations["Вокзальная"] = "Volzalnaya"
    self.EnStations["Комсомольская"] = "Komsomolskaya"
    self.EnStations["Электросила"] = "Electrosila"	
    self.EnStations["Театральная площадь"] = "Teatralnaya Ploshad'"
    self.EnStations["Синеозерная"] = "Sineozernaya"
    self.EnStations["Минская"] = "Minskaya"	
    self.EnStations["Царские ворота"] = "Tsarskiye vorota"
    self.EnStations["Междустройская"] = "Mezdustroiskaya"
    self.EnStations["Музей скульптур"] = "Muzei Skulptur"		
    self.EnStations["Автостанция Южная"] = "Avtostanciya Yuzhaya"		

    self.Advert = 1
    self.AdvertSymbol = 0
    self.CurrentAdvert = ""
    self.isMoving = true
    self.CurColor = Color(255, 32, 32)
    self.Status = -1
    self.ShowStation = false
    self.Station = nil
    self.Next = false
    self.EnShow = false
end

function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
    if textdata == "Curr" then
        self.Station = numdata
    elseif textdata == "Next" then
        self.Next = numdata
    end

    self.ShowStation = true
end

function TRAIN_SYSTEM:Think()
    local Train = self.Train
    local Power = Train.Panel.TickerPower>0
    local Work = Train.Panel.TickerWork>=0 and Metrostroi.TickerAdverts
    if Power and (Work or self.Advert ~= -1) then
        self.AdvertSymbol = self.AdvertSymbol - 96*Train.DeltaTime
        if ((self.AdvertSymbol < -(utf8.len(self.CurrentAdvert)*10+40)) or self.ShowStation == true) then
            self.AdvertSymbol = 400
            self.isMoving = true
            
            if Work and self.Status >= 0 then
                if self.Station == nil then
                    self.Status = 0
                end

                if self.Status == 1 or self.ShowStation == true then
                    self.ShowStation = false
                    if self.Station then
                        self.CurColor = Color(164, 255, 32)
                        if self.Next == true then
                            self.EnShow = false
                            if self.ReplaceStations[self.Station] then
                                self.CurrentAdvert = Format("Следующая станция %s", self.ReplaceStations[self.Station])
                            else
                                self.CurrentAdvert = Format("Следующая станция %s", self.Station)
                            end
                            if self.EnStations[self.Station] then
                                self.CurrentAdvert = self.CurrentAdvert..Format("          The next station is %s", self.EnStations[self.Station])
                            end
                            self.Status = 2
                        else
                            self.Status = 1
                            if self.EnShow == true and self.EnStations[self.Station] then
                                self.CurrentAdvert = Format("This is \"%s\"", self.EnStations[self.Station])
                                self.EnShow = false
                            else
                                if self.ReplaceStations[self.Station] then
                                    self.CurrentAdvert = Format("%s", self.ReplaceStations[self.Station])
                                else
                                    self.CurrentAdvert = Format("%s", self.Station)
                                end
                                self.EnShow = true
                            end

                            if utf8.len(self.CurrentAdvert) <= 27 then
                                self.isMoving = false
                            else
                                if self.ReplaceStations[self.Station] then
                                    self.CurrentAdvert = Format("%s. This is \"%s\"", self.ReplaceStations[self.Station], self.EnStations[self.Station])
                                else
                                    self.CurrentAdvert = Format("%s. This is \"%s\"", self.Station, self.EnStations[self.Station])
                                end
                            end
                        end
                    else
                        self.Status = 0
                    end
                elseif self.Status == 0 then
                    self.isMoving = false
                    self.CurColor = Color(255, 164, 32)
                    self.CurrentAdvert = os.date("%d.%m.%Yг.    %H:%M")
                    if self.Weekdays[os.date("%a")] then
                        self.CurrentAdvert = self.Weekdays[os.date("%a")].."    "..self.CurrentAdvert
                    else
                        self.CurrentAdvert = os.date("%a").."   "..self.CurrentAdvert
                    end
                    if self.Station ~= nil then
                        self.Status = 1
                    end 
                else
                    self.CurColor = Color(255, 32, 32)
                    self.Advert = math.random(1, table.getn(Metrostroi.TickerAdverts))
                    self.CurrentAdvert = Metrostroi.TickerAdverts[self.Advert]
                    self.Advert = math.random(1, table.getn(Metrostroi.TickerAdverts))
                    self.CurrentAdvert = self.CurrentAdvert.."          В вагонах действует бесплатная Wi-Fi сеть \"MT_FREE\""
                    self.Status = 0
                end
            else
                self.Station = nil
				self.CurColor = Color(255, 164, 32)
                self.CurrentAdvert = "НИИ Фабрики SENT БЕГУЩАЯ СТРОКА V2.2"
				if os.date( "%m-%d" ) == "04-01" then
				    self.CurrentAdvert = "УважааааААААААААеееееееееееееееееееееееммммММММММММЫЫЫЫЫЫЫЫЫЫееее пааааааааааааааааааААААААСССААААЖИРЫ"
				end
                self.Status = 0
                self.AdvertSymbol = 40*8
            end
        end
    else
        self.Station = nil
        self.isMoving = true
        self.CurColor = Color(255, 255, 255)
        self.AdvertSymbol = 40*8
        self.CurrentAdvert = ""
		if os.date( "%m-%d" ) == "04-01" then
		    self.CurrentAdvert = "Ты думал здесь что-то будет?"
		end
        self.Status = -1
    end
    --[[
    local str = ""
    for p, c in utf8.codes(self.CurrentAdvert) do
        str = str..utf8.char(c+10)
    end]]
    Train:SetNW2String("TickerMessage",self.CurrentAdvert)
    --Train:SetNW2Int("TickerState",math.ceil(math.min(0,self.AdvertSymbol)))
    colR, colG, colB = self.CurColor:Unpack()
    Train:SetNW2Int("TickerColorR", colR)
    Train:SetNW2Int("TickerColorG", colG)
    Train:SetNW2Int("TickerColorB", colB)
    if self.isMoving == true then
        Train:SetNW2Int("TickerState",math.ceil(self.AdvertSymbol))
    else
        Train:SetNW2Int("TickerState",0)
    end
end