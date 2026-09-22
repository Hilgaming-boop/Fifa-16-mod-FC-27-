-- =========================================================
-- Trophy lua mod inisialA --
-- =========================================================

local TabModel = ...
Trophy = {}

SavedTrophyData = SavedTrophyData or {}
currentTourInfo = currentTourInfo or {}

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

local BND_COLOR_CUPID = "bnd_color_tourid" 
local BND_COLOR_CUPID2 = "bnd_color_tourid2" 
local BND_BG_TOUR = "bnd_bg_tour"
local BND_TOUR_LOGO = "bnd_tour_logo"
local BND_TROPHY = "bnd_trophy"
local BND_TROPHY_LEFT = "bnd_trophy_left"
local BND_TROPHY_RIGHT = "bnd_trophy_right"

local BND_TOUR_LABEL = "bnd_tour_label"
local BND_PANEL_LOADING = "bnd_panel_loading"
local BND_TROPHY_COUNT = "bnd_trophy_count" 
local BND_CHAMPION_TEAM = "bnd_champion_team" 
local BND_DYNAMIC_TEXT = "bnd_dynamic_label"

local ACT_BACK = "act_back"
local ACT_NEXT = "act_next"
local ACT_PREV = "act_prev"

function Trophy:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    local activeTourId = GlobalTournamentSettings and GlobalTournamentSettings.tourId or 1
    o.loc = init and init.loc or nil

    o.tourIds = {}
    for id, _ in pairs(tourIdToNameMap) do
        if type(id) == "number" then
            table.insert(o.tourIds, id)
        end
    end
    table.sort(o.tourIds)

    o.currentIndex = 1
    for i, id in ipairs(o.tourIds) do
        if id == activeTourId then
            o.currentIndex = i
            break
        end
    end
    o.currentTourId = o.tourIds[o.currentIndex]

    o.currentTeamId = 0
    if currentTourInfo and currentTourInfo[o.currentTourId] then
        o.currentTeamId = currentTourInfo[o.currentTourId].homeID or 0
    end

    print(string.format("[Trophy Module] Initialized | Active Tour ID: %d | Total Valid Tours: %d", o.currentTourId, #o.tourIds))
    
    o:setupSubscriptions()
    o:setupActions()
    o:UpdateTrophyDisplay()
    o:UpdateModeLabelText()

    return o
end

function Trophy:UpdateModeLabelText()
    local labelText = "T"
    
    if GlobalTournamentSettings then
        if GlobalTournamentSettings.isLeagueMode then
            labelText = "L"
        elseif GlobalTournamentSettings.isKnockoutOnly then
            labelText = "T"
        end
    end
    
    self.im.Publish(BND_DYNAMIC_TEXT, labelText)
end

function Trophy:setupSubscriptions()
    self.im.Subscribe(BND_DYNAMIC_TEXT, function() self:UpdateModeLabelText() end)
    self.im.Subscribe(BND_PANEL_LOADING, function(isVisible) end)
    
    self.im.Subscribe(BND_COLOR_CUPID, function() 
        local color = tourIdToColorMap[self.currentTourId] or tourIdToColorMap.default
        self.im.Publish(BND_COLOR_CUPID, color) 
    end)
    
    self.im.Subscribe(BND_COLOR_CUPID2, function() 
        local color2 = tourIdToColorTabMap[self.currentTourId] or tourIdToColorTabMap.default
        self.im.Publish(BND_COLOR_CUPID2, color2) 
    end)
    
    self.im.Subscribe(BND_BG_TOUR, function() 
        self.im.Publish(BND_BG_TOUR, { name = "$Bg_Cup", id = self.currentTourId }) 
    end)
    
    self.im.Subscribe(BND_TOUR_LOGO, function() 
        self.im.Publish(BND_TOUR_LOGO, { name = "$CustomLogo", id = self.currentTourId }) 
    end)
    
    self.im.Subscribe(BND_TROPHY, function() 
        self.im.Publish(BND_TROPHY, { name = "$CustomTrophy", id = self.currentTourId }) 
    end)

    self.im.Subscribe(BND_TROPHY_LEFT, function()
        local leftIndex = self.currentIndex - 1
        if leftIndex < 1 then leftIndex = #self.tourIds end
        local leftTourId = self.tourIds[leftIndex]
        self.im.Publish(BND_TROPHY_LEFT, { name = "$CustomTrophy", id = leftTourId })
    end)

    self.im.Subscribe(BND_TROPHY_RIGHT, function()
        local rightIndex = self.currentIndex + 1
        if rightIndex > #self.tourIds then rightIndex = 1 end
        local rightTourId = self.tourIds[rightIndex]
        self.im.Publish(BND_TROPHY_RIGHT, { name = "$CustomTrophy", id = rightTourId })
    end)

    self.im.Subscribe(BND_TOUR_LABEL, function() 
        local tourName = tourIdToNameMap[self.currentTourId] or tourIdToNameMap.default
        self.im.Publish(BND_TOUR_LABEL, tourName)
    end)
    
    self.im.Subscribe(BND_TROPHY_COUNT, function() 
        local winsForThisTour = 0
        local sTeamId = tostring(self.currentTeamId)
        local sTourId = tostring(self.currentTourId)
        if SavedTrophyData and SavedTrophyData[sTeamId] and SavedTrophyData[sTeamId].tournaments then
            winsForThisTour = SavedTrophyData[sTeamId].tournaments[sTourId] or 0
        end
        self.im.Publish(BND_TROPHY_COUNT, "Trophies Won: " .. tostring(winsForThisTour))
    end)
    
    self.im.Subscribe(BND_CHAMPION_TEAM, function() 
        local totalTeamWins = 0
        local sTeamId = tostring(self.currentTeamId)
        if SavedTrophyData and SavedTrophyData[sTeamId] then
            totalTeamWins = SavedTrophyData[sTeamId].totalTeamTrophies or 0
        end
        
        if self.currentTeamId ~= 0 and self.loc then
            local teamName = self.loc.LocalizeString("TeamName_Abbr15_" .. self.currentTeamId)
            self.im.Publish(BND_CHAMPION_TEAM, teamName .. " | Total Trophies: " .. tostring(totalTeamWins))
        else
            self.im.Publish(BND_CHAMPION_TEAM, "Total Trophies: " .. tostring(totalTeamWins))
        end
    end)
end

function Trophy:setupActions()
    self.im.RegisterAction(ACT_BACK, function()
        self.nav.Event(nil, "evt_back")
    end)
    
    self.im.RegisterAction(ACT_NEXT, function()
        self.currentIndex = self.currentIndex + 1
        if self.currentIndex > #self.tourIds then
            self.currentIndex = 1
        end
        self.currentTourId = self.tourIds[self.currentIndex]
        self:UpdateTrophyDisplay()
    end)

    self.im.RegisterAction(ACT_PREV, function()
        self.currentIndex = self.currentIndex - 1
        if self.currentIndex < 1 then
            self.currentIndex = #self.tourIds
        end
        self.currentTourId = self.tourIds[self.currentIndex]
        self:UpdateTrophyDisplay()
    end)
end

function Trophy:UpdateTrophyDisplay()
    self.im.Publish(BND_PANEL_LOADING, true)
    self:UpdateModeLabelText()
    
    local tourName = tourIdToNameMap[self.currentTourId] or tourIdToNameMap.default
    local tourColor = tourIdToColorMap[self.currentTourId] or tourIdToColorMap.default
    local tourColorTab = tourIdToColorTabMap[self.currentTourId] or tourIdToColorTabMap.default
    
    if currentTourInfo and currentTourInfo[self.currentTourId] and currentTourInfo[self.currentTourId].homeID then
        self.currentTeamId = currentTourInfo[self.currentTourId].homeID
    end

    local winsForThisTour = 0
    local totalTeamWins = 0
    local sTeamId = tostring(self.currentTeamId)
    local sTourId = tostring(self.currentTourId)
    
    if SavedTrophyData and SavedTrophyData[sTeamId] then
        totalTeamWins = SavedTrophyData[sTeamId].totalTeamTrophies or 0
        if SavedTrophyData[sTeamId].tournaments then
            winsForThisTour = SavedTrophyData[sTeamId].tournaments[sTourId] or 0
        end
    end
    
    local leftIndex = self.currentIndex - 1
    if leftIndex < 1 then leftIndex = #self.tourIds end
    local leftTourId = self.tourIds[leftIndex]
    
    local rightIndex = self.currentIndex + 1
    if rightIndex > #self.tourIds then rightIndex = 1 end
    local rightTourId = self.tourIds[rightIndex]

    self.im.Publish(BND_COLOR_CUPID, tourColor)
    self.im.Publish(BND_COLOR_CUPID2, tourColorTab)
    self.im.Publish(BND_BG_TOUR, { name = "$Bg_Cup", id = self.currentTourId })
    self.im.Publish(BND_TOUR_LOGO, { name = "$CustomLogo", id = self.currentTourId })
    
    self.im.Publish(BND_TROPHY_LEFT, { name = "$CustomTrophy", id = leftTourId })
    self.im.Publish(BND_TROPHY, { name = "$CustomTrophy", id = self.currentTourId })
    self.im.Publish(BND_TROPHY_RIGHT, { name = "$CustomTrophy", id = rightTourId })
    
    self.im.Publish(BND_TOUR_LABEL, tourName)
    self.im.Publish(BND_TROPHY_COUNT, "Trophies Won: " .. tostring(winsForThisTour))
    
    if self.currentTeamId ~= 0 and self.loc then
        print(string.format("[Trophy Gallery] Active: [%d] %s | Left: %d | Right: %d", self.currentTourId, tourName, leftTourId, rightTourId))
    end
    
    self.im.Publish(BND_PANEL_LOADING, false)
end

function Trophy:finalize()
    local subsToClean = {
        BND_DYNAMIC_TEXT, BND_COLOR_CUPID, BND_COLOR_CUPID2, BND_BG_TOUR, BND_TOUR_LOGO, BND_TROPHY,
        BND_TROPHY_LEFT, BND_TROPHY_RIGHT, BND_TOUR_LABEL, 
        BND_TROPHY_COUNT, BND_CHAMPION_TEAM, BND_PANEL_LOADING
    }
    
    for _, s in ipairs(subsToClean) do
        self.im.Unsubscribe(s)
    end
    
    self.im.UnregisterAction(ACT_BACK)
    self.im.UnregisterAction(ACT_NEXT)
    self.im.UnregisterAction(ACT_PREV)

    print("[Trophy Module] Finalized")
end

return Trophy
