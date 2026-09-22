-- CustomCup By Mounsta
-- Patch Mod InisialA (SaveTur & Sistem)
-- Rober fl
-- BillzYt

local MatchPlay = {}

local BND_COLOR_CUPID = "bnd_color_tourid"
local BND_COLOR_CUPID2 = "bnd_color_tourid2"
local BND_PANEL_LOADING = "bnd_panel_loading"
local BND_MATCH_INFO = "bnd_match_info"
local BND_MATCH_HOUR = "bnd_match_hour"
local BND_HOME_SIDE_ICON = "bnd_home_side_icon"
local BND_AWAY_SIDE_ICON = "bnd_away_side_icon"
local bnd2DHomeKit = "bnd_2d_home_kit"
local bnd2DAwayKit = "bnd_2d_away_kit"
local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local BND_TAB4_VISIBLE = "bnd_tab4_visible"
local ACT_ADVANCE = "act_advance"
local ACT_CUSTOMIZE = "act_customize"
local ACT_BTN_CLICK = "act_btn_click"
local TAB1, TAB2, TAB3, TAB4 = 1, 2, 3, 4

local tourId = GlobalTournamentSettings and GlobalTournamentSettings.tourId or 1

-- DETEKSI CUSTOM CREST UNTUK WORLD CUP 2026
local CREST_NORMAL = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"

-- PERBAIKAN: Gunakan 'or' agar tidak mereset data yang dibawa dari KitSelect
currentMatch = currentMatch or { HomeTeamID = 0, AwayTeamID = 0, HomeKitIndex = 0, AwayKitIndex = 1 }
currentTourData = currentTourData or {}

local tourIdToNameMap = {
    [1] = "UEFA Champions League", [2] = "FIFA World Cup 2026", [3] = "UEFA Europa League",
    [4] = "CONMEBOL Libertadores", [5] = "Copa do Brasil", [6] = "UEFA Euro",
    [7] = "Dfb Pokal", [8] = "CONMEBOL Sudamericana", [9] = "The Emirates FA Tour",
    [10] = "Copa del Rey", [11] = "Coppa Italia", [12] = "Asean Shopee Cup",
    [13] = "US Open Tour", [14] = "EA Sports Cup", [15] = "FIFA Club World Cup",
    [16] = "UEFA Women CL", [17] = "UEFA Conference League", [18] = "Coupe de France",
    [19] = "Copa Argentina", [20] = "Copa MX", [21] = "AFC Challenge League",
    [22] = "Classic Tour", [23] = "Sea Games U-23", [24] = "AFC Champions League Elit",
    [25] = "Copa America", [26] = "Africa Cup Of Nations", [27] = "ASEAN Hyundai Cup 2026",
    [28] = "UEFA Nations League", [29] = "Kratingdaeng Piala Indonesia", [30] = "ALL STAR CUP",
    [31] = "AFC Champions League Two", [32] = "Piala Presiden", [33] = "Leagues Cup",
    [34] = "AFC Asian Cup 2023", [50] = "Saudi Arab Tour", [133] = "Premier League", [144] = "Championship", [533] = "Laliga", [544] = "Segunda División", [311] = "Serie A", [322] = "Serie B", [199] = "BundesLiga", [200] = "BundesLiga 2", [166] = "Ligue 1", [177] = "League 2", [350] = "Saudi League", [2235] = "BRI Super League", [2254] = "Pegadaian Liga 2", default = "Custom Tournament"
}

local tourIdToColorMap = {
    [1]   = "0x000026", -- UCL: Dark Blue
    [2]   = "0x0051FF", -- World Cup 2026: Bright Blue
    [3]   = "0x2F0103", -- UEL: Dark Maroon
    [4]   = "0x111111", -- Libertadores: Dark Black
    [5]   = "0x003311", -- Copa do Brasil: Dark Green
    [6]   = "0x0A1128", -- Euro: Navy Blue
    [7]   = "0x1A1A1A", -- Dfb Pokal: Dark Grey
    [8]   = "0x221100", -- Sudamericana: Dark Bronze
    [9]   = "0x880000", -- FA Cup: Red
    [10]  = "0x990000", -- Copa del Rey: Red
    [11]  = "0x002266", -- Coppa Italia: Blue
    [12]  = "0xFF3300", -- Asean Shopee Cup: Orange Red
    [13]  = "0x001133", -- US Open: Dark Blue
    [14]  = "0x1A1A1A", -- EA Sports Cup: Dark Grey
    [15]  = "0x1A1A1A", -- Club World Cup: Deep Blue
    [16]  = "0x000026", -- UEFA Women CL: Dark Blue
    [17]  = "0x044508", -- UEFA Conference League: Forest Green
    [18]  = "0x002060", -- Coupe de France: Blue
    [19]  = "0x003366", -- Copa Argentina: Sky Blue Tint
    [20]  = "0x004d00", -- Copa MX: Green
    [21]  = "0x3E0118", -- AFC Challenge League: Dark Wine
    [22]  = "0x1A1A1A", -- Classic Tour: Dark Grey
    [23]  = "0xCC0000", -- Sea Games U-23: Red
    [24]  = "0x16002D", -- AFC Champions League Elit: Royal Purple
    [25]  = "0x002D62", -- Copa America: Blue
    [26]  = "0x006600", -- Africa Cup Of Nations: Green
    [27]  = "0xFF6600", -- ASEAN Hyundai Cup: Orange
    [28]  = "0x001B3A", -- UEFA Nations League: Navy
    [29]  = "0xCC0000", -- Piala Indonesia: Red
    [30]  = "0x330033", -- ALL STAR CUP: Dark Purple
    [31]  = "0x00084E", -- AFC Champions League Two: Deep Navy
    [32]  = "0xFF4500", -- Piala Presiden: Orange Red
    [33]  = "0x00A86B", -- Leagues Cup: Jade Green
    [34]  = "0x070A91", -- AFC Asian Cup: Blue
    [50]  = "0x004D1A", -- Saudi Arab Tour: Emerald Green
    [133] = "0x1a0524", -- Premier League: Deep Royal Purple (Plum Dark)
    [144] = "0x001d22", -- Championship: Dark Teal / Deep Cyan Navy
    [533] = "0x121212", -- La Liga: Matte Black / Dark Slate Clean
    [544] = "0x1C2321", -- Segunda División: Gunmetal Dark
    [311] = "0x001e3d", -- Serie A: Deep Azure Blue
    [322] = "0x001224", -- Serie B: Dark Navy
    [199] = "0x121212", -- Bundesliga: Official Dark Charcoal / Matte Black
    [200] = "0x0D1117", -- Bundesliga 2: Dark Charcoal Black
    [166] = "0x050C1A", -- Ligue 1: Dark Navy Blue
    [177] = "0x002B6B", -- League 2: Cobalt Blue Dark
    [350] = "0x032613", -- Saudi League: Roshn Dark Emerald
    [2235]= "0x000F2E", -- BRI Super League: Deep BRI Blue
    [2254]= "0x0B291F", -- Pegadaian Liga 2: Dark Forest Green
    default = "0x121212"
}

local tourIdToColorTabMap = {
    [1]   = "0xE00069", -- UCL Accent
    [2]   = "0xDB0785", -- World Cup 2026 Accent
    [3]   = "0x990009", -- UEL Accent
    [4]   = "0x282A30", -- Libertadores Accent
    [5]   = "0x006622", -- Copa do Brasil Accent
    [6]   = "0x1C2D5A", -- Euro Accent
    [7]   = "0x333333", -- Dfb Pokal Accent
    [8]   = "0x442200", -- Sudamericana Accent
    [9]   = "0xCC0000", -- FA Cup Accent
    [10]  = "0xCC0000", -- Copa del Rey Accent
    [11]  = "0x0044CC", -- Coppa Italia Accent
    [12]  = "0xFF6600", -- Asean Shopee Cup Accent
    [13]  = "0x003366", -- US Open Accent
    [14]  = "0x282A30", -- EA Sports Cup Accent
    [15]  = "0x282A30", -- Club World Cup Accent
    [16]  = "0xE00069", -- UEFA Women CL Accent
    [17]  = "0x099312", -- UEFA Conference League Accent
    [18]  = "0x004080", -- Coupe de France Accent
    [19]  = "0x0059B3", -- Copa Argentina Accent
    [20]  = "0x008000", -- Copa MX Accent
    [21]  = "0x760138", -- AFC Challenge League Accent
    [22]  = "0x282A30", -- Classic Tour Accent
    [23]  = "0xFF0000", -- Sea Games U-23 Accent
    [24]  = "0x341C5E", -- AFC Champions League Elit Accent
    [25]  = "0x0047AB", -- Copa America Accent
    [26]  = "0x009900", -- Africa Cup Of Nations Accent
    [27]  = "0xFF8000", -- ASEAN Hyundai Cup Accent
    [28]  = "0x003366", -- UEFA Nations League Accent
    [29]  = "0xFF0000", -- Piala Indonesia Accent
    [30]  = "0x660066", -- ALL STAR CUP Accent
    [31]  = "0x000B70", -- AFC Champions League Two Accent
    [32]  = "0xFF6622", -- Piala Presiden Accent
    [33]  = "0x00CC88", -- Leagues Cup Accent
    [34]  = "0x1D24CE", -- AFC Asian Cup Accent
    [50]  = "0x00802B", -- Saudi Arab Tour Accent
    [133] = "0x38003C", -- Premier League Accent
    [144] = "0x004D5A", -- Championship Accent
    [533] = "0xEE3124", -- Laliga Accent
    [544] = "0x3E4A51", -- Segunda División Accent
    [311] = "0x00529B", -- Serie A Accent
    [322] = "0x003366", -- Serie B Accent
    [199] = "0xD20515", -- Bundesliga Accent
    [200] = "0x2C3539", -- Bundesliga 2 Accent
    [166] = "0x1E3A8A", -- Ligue 1 Accent
    [177] = "0x1E90FF", -- League 2 Accent
    [350] = "0x006622", -- Saudi League Accent
    [2235]= "0x0033CC", -- BRI Super League Accent
    [2254]= "0x15573B", -- Pegadaian Liga 2 Accent
    default = "0x282A30"
}

local tourIdToRefereeNameMap = {
    [1]  = "Clément Turpin",
    [3]  = "Carlos del Cerro",
    [4]  = "Wilmar Roldán",
    [8]  = "Facundo Tello",
    [14] = "Yamashita Yoshimi",
    [17] = "Yudi Nurcahya",
    [21] = "Christopher Beath",
    [22] = "Mark Clattenburg",
    [24] = "Orel Grinfeld",
    [30] = "Bruno Arleu de Araujo",
    [31] = "Szymon Marciniak",
    default = "Default Referee"
}

function MatchPlay:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    local tourId = GlobalTournamentSettings.tourId or 1
    o.services = {
        FifaCustomizationService = o.api("FifaCustomizationService"),
        MatchSetup = o.api("MatchSetupService"),
        settingsService = o.api("SettingsService"),
        GameSetup = o.api("GameSetupService"),
        SquadManagementService = o.api("SquadMgtService")
    }

    o.isAdsVisible = true
    o.currentOptions = o.services.settingsService.GetCurrentOptions()

    o.tourData = {
        tourBg = { name = "$Bg_Cup", id = tourId },
        tourlogo = { name = "$CustomLogo", id = tourId },
        trophy = { name = "$CustomTrophy", id = tourId }
    }

    o.buttonsID = { TAB1, TAB2, TAB3, TAB4 }

    o:setupSubscriptions()
    o:setupActions()
    
    o.im.Publish("bnd_match_visible", true)
    o:HideSelections()
    o.im.Publish(BND_TAB1_VISIBLE, true)

    print(" MatchPlay Initialized for Tour: " .. tourIdToNameMap[tourId] .. " (ID: " .. tostring(tourId) .. ")")
    return o
end

function MatchPlay:HideSelections()
    self.im.Publish(BND_TAB1_VISIBLE, false)
    self.im.Publish(BND_TAB2_VISIBLE, false)
    self.im.Publish(BND_TAB3_VISIBLE, false)
    self.im.Publish(BND_TAB4_VISIBLE, false)
end

function MatchPlay:setupSubscriptions()
    local tourId = GlobalTournamentSettings.tourId or 1

    --  SUBSCRIPTIONS BÁSICAS (WARNA UTAMA & WARNA KEDUA)
    self.im.Subscribe(BND_COLOR_CUPID, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        local color = tourIdToColorMap[currentTourId] or tourIdToColorMap.default
        self.im.Publish(BND_COLOR_CUPID, color)
    end)

    self.im.Subscribe(BND_COLOR_CUPID2, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        local color2 = tourIdToColorTabMap[currentTourId] or tourIdToColorTabMap.default
        self.im.Publish(BND_COLOR_CUPID2, color2)
    end)

    self.im.Subscribe(BND_PANEL_LOADING, function(isVisible) end)
    self.im.Subscribe(bnd2DHomeKit, function() end)
    self.im.Subscribe(bnd2DAwayKit, function() end)

    --  SUBSCRIPTIONS DE INFORMAÇÕES DO MATCH
    self.im.Subscribe("bnd_bg_tour", function() self.im.Publish("bnd_bg_tour", self.tourData.tourBg) end)
    self.im.Subscribe("bnd_tour_logo", function() self.im.Publish("bnd_tour_logo", self.tourData.tourlogo) end)
    self.im.Subscribe("bnd_trophy", function() self.im.Publish("bnd_trophy", self.tourData.trophy) end)

    --  SUBSCRIPTION PARA INFORMAÇÕES COMPLETAS DO MATCH (Hora, Estádio, Árbitro, Dificuldade)
    self.im.Subscribe(BND_MATCH_INFO, function()
        local halfLength = self.currentOptions.halfLengthData or "6 minutes"
        local currentDate = os.date("%d %B %Y")
        local stadiumName = self.currentOptions.stadium or "Default Stadium"
        local weather = self.currentOptions.weather or "Clear"
        local refereeName = "Referee: " .. (tourIdToRefereeNameMap[tourId] or "Default Referee")
        local currentHour = tonumber(os.date("%H"))
        local difficulty = self.currentOptions.difficulty or "Legendary"

        local dynamicTimeOfDay
        if currentHour >= 5 and currentHour < 12 then
            dynamicTimeOfDay = "Morning"
        elseif currentHour >= 12 and currentHour < 18 then
            dynamicTimeOfDay = "Afternoon"
        else
            dynamicTimeOfDay = "Night"
        end

        local line1 = string.format("%s | %s | %s | %s", stadiumName, currentDate, refereeName, difficulty)
        local line2 = string.format("%s | %s | %s", halfLength, dynamicTimeOfDay, weather)
        local matchTimeString = line1 .. "\n" .. line2

        self.im.Publish(BND_MATCH_INFO, matchTimeString)
    end)

    --  SUBSCRIPTION PARA MOSTRAR APENAS A HORA (9:00 PM)
    self.im.Subscribe(BND_MATCH_HOUR, function()
        local matchHour = self:getMatchHour()
        self.im.Publish(BND_MATCH_HOUR, matchHour)
    end)

    --  SUBSCRIPTIONS PARA MATCH INFO
    for _, k in ipairs({
        "bnd_home_side_icon", "bnd_away_side_icon", "bnd_user_side_icon",
        "bnd_match_visible", "bnd_home_crest", "bnd_away_crest",
        "bnd_home_team", "bnd_away_team", "bnd_group_label",
        "bnd_home_team_short", "bnd_away_team_short", "bnd_team_crest", "bnd_team_name"
    }) do
        self.im.Subscribe(k, function() self:publishMatchInfo() end)
    end

    --  SUBSCRIPTIONS PARA TABS
    self.im.Subscribe(BND_TAB1_VISIBLE, function() end)
    self.im.Subscribe(BND_TAB2_VISIBLE, function() end)
    self.im.Subscribe(BND_TAB3_VISIBLE, function() end)
    self.im.Subscribe(BND_TAB4_VISIBLE, function() end)

    self.im.Subscribe("bnd_tour_label", function() self:publishMatchInfo() end)
end

function MatchPlay:setupActions()
    --  ACTION PARA INICIAR MATCH
    self.im.RegisterAction(ACT_ADVANCE, function()
        self:Advance()
    end)

    --  ACTION PARA CUSTOMIZAR MATCH
    self.im.RegisterAction(ACT_CUSTOMIZE, function()
        self:CustomizeMatch()
    end)

    --  ACTION PARA TABS
    self.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)
        self:HideSelections()
        if self.buttonsID[data.buttonID + 1] == TAB1 then
            self.im.Publish(BND_TAB1_VISIBLE, true)
        elseif self.buttonsID[data.buttonID + 1] == TAB2 then
            self.im.Publish(BND_TAB2_VISIBLE, true)
        elseif self.buttonsID[data.buttonID + 1] == TAB3 then
            self.im.Publish(BND_TAB3_VISIBLE, true)
        elseif self.buttonsID[data.buttonID + 1] == TAB4 then
            self.im.Publish(BND_TAB4_VISIBLE, true)
        end
    end)
end

--  FUNÇÃO PARA OBTER APENAS A HORA (9:00 PM)
function MatchPlay:getMatchHour()
    local hour = tonumber(os.date("%H"))
    local minute = os.date("%M")
    local ampm = hour >= 12 and "PM" or "AM"
    
    if hour > 12 then
        hour = hour - 12
    elseif hour == 0 then
        hour = 12
    end
    
    return string.format("%d:%s %s", hour, minute, ampm)
end

--  PUBLICAR INFORMAÇÕES DO MATCH
function MatchPlay:publishMatchInfo()
    local tourId = GlobalTournamentSettings.tourId or 1
    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default

    self.im.Publish(BND_PANEL_LOADING, true)

    if not currentTourData or not currentTourData.homeID or not currentTourData.awayID then
        self.im.Publish("bnd_text", "Loading match data...")
        self.im.Publish(BND_PANEL_LOADING, false)
        return
    end

    local homeTeamId = currentTourData.homeID
    local awayTeamId = currentTourData.awayID
    local roundName = currentTourData.roundName or "Group Stage"

    self.im.Publish("bnd_text", roundName)
    self.im.Publish("bnd_match_visible", true)
    self.im.Publish("bnd_home_crest", { name = CREST_NORMAL, id = homeTeamId })
    self.im.Publish("bnd_away_crest", { name = CREST_NORMAL, id = awayTeamId })
    self.im.Publish("bnd_home_team", self.loc.LocalizeString("TeamName_Abbr15_" .. homeTeamId))
    self.im.Publish("bnd_away_team", self.loc.LocalizeString("TeamName_Abbr15_" .. awayTeamId))

    -- PERBAIKAN BACA KIT: Prioritaskan membaca kit dari currentTourData hasil save KitSelect
    local hkIndex = currentTourData.homeKitIndex or currentMatch.HomeKitIndex or 0
    local akIndex = currentTourData.awayKitIndex or currentMatch.AwayKitIndex or 1

    -- Update ulang currentMatch biar datanya sinkron
    currentMatch.HomeKitIndex = hkIndex
    currentMatch.AwayKitIndex = akIndex

    print("DEBUG: Publishing kits - HomeKitIndex=" .. tostring(hkIndex) .. ", AwayKitIndex=" .. tostring(akIndex))
    self:publish2DKit(bnd2DHomeKit, homeTeamId, hkIndex)
    self:publish2DKit(bnd2DAwayKit, awayTeamId, akIndex)

    --  PUBLICAR ÍCONE DE CONTROLE (Qual time o usuário controla)
    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    if userTeamId == homeTeamId then
        self.im.Publish(BND_HOME_SIDE_ICON, "$_IconController")
        self.im.Publish(BND_AWAY_SIDE_ICON, nil)
    else
        self.im.Publish(BND_HOME_SIDE_ICON, nil)
        self.im.Publish(BND_AWAY_SIDE_ICON, "$_IconController")
    end

    self.im.Publish(BND_PANEL_LOADING, false)
    self.im.Publish("bnd_tour_label", tourName)

    print(" MatchPlay: Informações do match publicadas")
    print("   -> Home Kit Index: " .. tostring(currentMatch.HomeKitIndex))
    print("   -> Away Kit Index: " .. tostring(currentMatch.AwayKitIndex))
end

--  PUBLICAR KITS 2D
function MatchPlay:publish2DKit(binding, teamId, kitType)
    if not teamId or teamId == 0 then return end
    local kitId = string.format("%s_%s_%s", kitType, teamId, 0)
    self.im.Publish(binding, {name = "$Kits", id = kitId})
end

--  INICIAR MATCH
function MatchPlay:Advance()
    local buttonNo = {
        icon = "$FooterIconNo",
        label = "Cancel",
        clickEvents = { "evt_hide_popup", "evt_refresh_on_resize" }
    }
    local buttonYes = {
        icon = "$FooterIconYes",
        label = "Confirm",
        clickEvents = { "evt_hide_popup" }
    }

    function buttonYes.clickCallback()
        self.nav.Event(nil, "evt_advance")
    end

    local popupData = {
        title = "Play Match",
        message = "Are you ready to start the match?",
        buttons = { buttonNo, buttonYes }
    }

    self.nav.Event(nil, "evt_show_popup", popupData)
    print(" MatchPlay: Mostrando diálogo de confirmação de match")
end

--  CUSTOMIZAR MATCH (Kits, Táticas, etc)
function MatchPlay:CustomizeMatch()
    self.nav.Event(nil, "evt_customize")
    print(" MatchPlay: Abrindo tela de customização")
end

--  LIMPAR TUDO AO FINALIZAR
function MatchPlay:finalize()
    -- Unsubscribe Actions
    self.im.UnregisterAction(ACT_ADVANCE)
    self.im.UnregisterAction(ACT_CUSTOMIZE)
    self.im.UnregisterAction(ACT_BTN_CLICK)

    -- Unsubscribe Bindings
    local subsToClean = {
        BND_COLOR_CUPID, BND_COLOR_CUPID2, BND_PANEL_LOADING, BND_MATCH_INFO, BND_MATCH_HOUR,
        BND_HOME_SIDE_ICON, BND_AWAY_SIDE_ICON, bnd2DHomeKit, bnd2DAwayKit,
        BND_TAB1_VISIBLE, BND_TAB2_VISIBLE, BND_TAB3_VISIBLE, BND_TAB4_VISIBLE,
        "bnd_bg_tour", "bnd_tour_logo", "bnd_trophy",
        "bnd_match_visible", "bnd_home_crest", "bnd_away_crest",
        "bnd_home_team", "bnd_away_team", "bnd_group_label",
        "bnd_home_team_short", "bnd_away_team_short",
        "bnd_team_crest", "bnd_team_name", "bnd_tour_label"
    }

    for _, s in ipairs(subsToClean) do
        self.im.Unsubscribe(s)
    end

    print(" MatchPlay module finalized")
end

return MatchPlay
