-- CustomCup By Mounsta
-- Patch Mod InisialA (SaveTur & Sistem)

local Tour = {}
local bndMatchList = "bnd_match_list"
local BND_BG_CUP = "bnd_bg_tour"
local bndLogo = "bnd_logo"
local bndTeamLogo = "bnd_team_logo"
local bndTeamName = "bnd_team_name"
local bndTourlabel = "bnd_tour_label"

local bndColorTourId = "bnd_color_tourid"
local bndColorTourId2 = "bnd_color_tourid2"

local tourId = GlobalTournamentSettings and GlobalTournamentSettings.tourId or 1

-- DETEKSI CUSTOM CREST UNTUK WORLD CUP 2026
local CREST_CREST64 = (tourId == 2) and "$CrestWorldCup2026" or "$Crest64x64"

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

function Tour:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.im = init.im; o.nav = init.nav; o.loc = init.loc; o.api = init.api

    o.services = {
        squad = o.api("SquadMgtService")
    }

    o.tourId = GlobalTournamentSettings.tourId or 1
    o.playerTeamID = currentTourInfo and currentTourInfo[o.tourId] and currentTourInfo[o.tourId].homeID or 0

    print(" Initializing Goalscorers screen for tourId: " .. o.tourId)

    o:setupSubscriptions()
    o:publishMatchRows()

    return o
end

function Tour:setupSubscriptions()
    self.im.Subscribe(bndMatchList, function() self:publishMatchRows() end)

    self.im.Subscribe(BND_BG_CUP, function()
        self.im.Publish(BND_BG_CUP, {name = "$Bg_Cup", id = self.tourId})
    end)

    self.im.Subscribe(bndLogo, function()
        self.im.Publish(bndLogo, {name = "$CustomLogo", id = self.tourId})
    end)

    self.im.Subscribe(bndTeamLogo, function()
        self.im.Publish(bndTeamLogo, {name = CREST_CREST64, id = self.playerTeamID})
    end)

    self.im.Subscribe(bndTeamName, function()
        self.im.Publish(bndTeamName, self.loc.LocalizeString("TeamName_Abbr15_"..self.playerTeamID))
    end)

    self.im.Subscribe(bndTourlabel, function()
        local tourName = tourIdToNameMap[self.tourId] or tourIdToNameMap.default
        self.im.Publish(bndTourlabel, tourName)
    end)

    --  Publish warna 1
    self.im.Subscribe(bndColorTourId, function()
        local clr = tourIdToColorMap[self.tourId] or tourIdToColorMap.default
        self.im.Publish(bndColorTourId, clr)
    end)

    --  Publish warna 2 (DISET KE tourIdToColorTabMap KARENA TABELNYA ITU)
    self.im.Subscribe(bndColorTourId2, function()
        local clr2 = tourIdToColorTabMap[self.tourId] or tourIdToColorTabMap.default
        self.im.Publish(bndColorTourId2, clr2)
    end)
end

function Tour:publishMatchRows()
    print("⚙️ Publishing ONLY Red Card rows...")
    local tourId = self.tourId

    TournamentStats[tourId] = TournamentStats[tourId] or {
        Goals = {}, Appearances = {},
        YellowCards = {}, RedCards = {}
    }
    TeamPlayerCache[tourId] = TeamPlayerCache[tourId] or {}

    -------------------------------------------------------
    -- LOAD HANYA PLAYER DENGAN KARTU MERAH
    -------------------------------------------------------
    local allPlayerStats = {}

    for teamID, players in pairs(TeamPlayerCache[tourId]) do
        for _, player in ipairs(players) do
            if player and player.CARD_ID then
                local playerID = player.CARD_ID
                local redCount = TournamentStats[tourId].RedCards[playerID] or 0

                -- FILTER: HANYA pemain dengan kartu merah > 0
                if redCount > 0 then
                    local playerStats = {
                        cardId = playerID,
                        playerName = player.playerName or "Unknown",
                        position = player.position or "N/A",
                        teamID = teamID,
                        nationalityID = player.nationalityID or 0,
                        redCards = redCount,
                        appearances = TournamentStats[tourId].Appearances[playerID] or 0,
                        rating = player.rating or 0
                    }
                    table.insert(allPlayerStats, playerStats)
                end
            end
        end
    end

    -------------------------------------------------------
    -- SORTING (Paling banyak kartu merah di atas)
    -------------------------------------------------------
    table.sort(allPlayerStats, function(a, b)
        if a.redCards ~= b.redCards then return a.redCards > b.redCards end
        return a.playerName < b.playerName
    end)

    -------------------------------------------------------
    -- KIRIM KE UI (HANYA RED CARD)
    -------------------------------------------------------
    local uiDataList = {}
    for rank, p in ipairs(allPlayerStats) do
        table.insert(uiDataList, {
            data = {
                PlayerName = p.playerName,
                Position = p.position,
                Rating = tostring(p.rating),
                TeamName = self.loc.LocalizeString("TeamName_Abbr15_" .. p.teamID),
                RedCard = p.redCards,
                Rank = tostring(rank),
                PlayerHead = { name = "$Head", id = p.cardId },
                TeamCrest = { name = CREST_CREST64, id = p.teamID },
                Nationality = { name = "$Flag128x128", id = p.nationalityID }
            }
        })
    end

    self.im.Publish(bndMatchList, uiDataList)
    print(" Published " .. #uiDataList .. " players to the Red Card screen.")
end

function Tour:finalize()
    self.im.Unsubscribe(bndMatchList)
    self.im.Unsubscribe(BND_BG_CUP)
    self.im.Unsubscribe(bndLogo)
    self.im.Unsubscribe(bndTeamLogo)
    self.im.Unsubscribe(bndTeamName)
    self.im.Unsubscribe(bndTourlabel)

    --  unsubscribe dua warna
    self.im.Unsubscribe(bndColorTourId)
    self.im.Unsubscribe(bndColorTourId2)

    print(" Goalscorers module finalized.")
end

return Tour
