-- Suporta múltiplos formatos: Group + Knockout, Knockout e League

local Standings = {}

-- Constantes de Binding
local BND_COLOR_CUPID = "bnd_color_tourid"
local BND_COLOR_CUPID2 = "bnd_color_tourid2" -- Ditambahkan untuk Warna ke-2
local bndStandingsList = "bnd_standings_list"
local bndFixturesList = "bnd_fixtures_list"
local bndGroupStandings = "bnd_group_standings"
local bndRound32Fixtures = "bnd_round32_fixtures"
local bndRound16Fixtures = "bnd_round16_fixtures"
local bndQuarterFixtures = "bnd_quarter_fixtures"
local bndSemiFixtures = "bnd_semi_fixtures"
local bndFinalFixture = "bnd_final_fixture"
local bndInfoProgres = "bnd_info_progres"
local BND_DYNAMIC_TEXT = "bnd_dynamic_label" -- Binding untuk teks label mode aktif (L/K/G)
local BND_VISIBLE_HIDE = "bnd_visible_hide" -- Untuk menyembunyikan panel saat mode liga
local BND_VISIBLE_SHOW = "bnd_visible_show" -- Untuk memunculkan panel KHUSUS saat mode liga

local tourId = GlobalTournamentSettings and GlobalTournamentSettings.tourId or 1

-- DETEKSI CUSTOM CREST UNTUK WORLD CUP 2026
local CREST_NORMAL = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
local CREST_64     = (tourId == 2) and "$CrestWorldCup2026" or "$Crest64x64"

-- Mapeamento de IDs de Torneio para Nomes
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

-- Nomes padronizados de estágios knockout
local STAGE_NAMES = {
    R32 = "Round of 32",
    R16 = "Round of 16",
    QF = "Quarter-Finals",
    SF = "Semi-Finals",
    F = "Final"
}

local currentGroup = 1

-- Inicializa nova instância de Standings
function Standings:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = {
        settingsService = o.api("SettingsService"),
        SquadManagementService = o.api("SquadMgtService")
    }
    o.currentOptions = o.services.settingsService.GetCurrentOptions()
    o.groups = {}
    o.loc = init.loc
    
    local settings = GlobalTournamentSettings or {}
    o.totalGroups = settings.totalGroups or 12
    o.teamsPerGroup = settings.teamsPerGroup or 4
    o.teamCount = settings.teamCount or 32
    o.matchdaysPerGroup = settings.matchdaysPerGroup or 6
    o.isLeagueMode = settings.isLeagueMode or false
    o.isKnockoutOnly = settings.isKnockoutOnly or false
    
    o:initializeTournament()

    o:setupSubscriptions()
    o.im.RegisterAction("act_next_group", function() o:NextGroup() end)
    o.im.RegisterAction("act_prev_group", function() o:PrevGroup() end)
    o:publishAllData()
    o:UpdateModeLabelText() -- Memicu teks L/K/G di awal layar
    o:UpdateVisibilityMode() -- Memicu status Hide dan Show di awal
    
    print(string.format("Standings initialized: %d groups of %d teams | %d total teams | %d matchdays | League: %s", 
        o.totalGroups, o.teamsPerGroup, o.teamCount, o.matchdaysPerGroup, tostring(o.isLeagueMode)))
    return o
end

-- Função para atualizar a letra dinamicamente baseada no modo
function Standings:UpdateModeLabelText()
    local labelText = "T" -- Padrão (Default) para Group + Knockout
    
    if self.isLeagueMode then
        labelText = "L" -- League
    elseif self.isKnockoutOnly then
        labelText = "T" -- Knockout
    end
    
    self.im.Publish(BND_DYNAMIC_TEXT, labelText)
end

-- Configura subscriptions para bindings
function Standings:setupSubscriptions()
    self.im.Subscribe(BND_DYNAMIC_TEXT, function() self:UpdateModeLabelText() end)
    self.im.Subscribe(BND_VISIBLE_HIDE, function() self:UpdateVisibilityMode() end)
    self.im.Subscribe(BND_VISIBLE_SHOW, function() self:UpdateVisibilityMode() end)

    self.im.Subscribe(BND_COLOR_CUPID, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        local color = tourIdToColorMap[currentTourId] or tourIdToColorMap.default
        self.im.Publish(BND_COLOR_CUPID, color)
    end)

    -- DITAMBAHKAN: Publish warna kedua ke UI
    self.im.Subscribe(BND_COLOR_CUPID2, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        local color2 = tourIdToColorTabMap[currentTourId] or tourIdToColorTabMap.default
        self.im.Publish(BND_COLOR_CUPID2, color2)
    end)

    self.im.Subscribe(bndStandingsList, function() self:publishAllStandings() end)
    self.im.Subscribe(bndFixturesList, function() self:publishCurrentGroupFixtures() end)
    self.im.Subscribe(bndGroupStandings, function() self:publishCurrentGroupStandings() end)
    self.im.Subscribe(bndRound32Fixtures, function() self:publishRound32Fixtures() end)
    self.im.Subscribe(bndRound16Fixtures, function() self:publishRound16Fixtures() end)
    self.im.Subscribe(bndQuarterFixtures, function() self:publishQuarterFixtures() end)
    self.im.Subscribe(bndSemiFixtures, function() self:publishSemiFixtures() end)
    self.im.Subscribe(bndFinalFixture, function() self:publishFinalFixture() end)
    self.im.Subscribe(bndInfoProgres, function() self:publishTournamentProgress() end)
    
    local infoLabels = {"bnd_matchday_label", "bnd_team_label", "bnd_month_label", "bnd_realtime", "bnd_tour_label", "bnd_bg_tour", "bnd_tour_logo", "bnd_group_label_current", "bnd_group_label_next", "bnd_group_label_prev","bnd_tour_trophy"}
    for _, label in ipairs(infoLabels) do
        self.im.Subscribe(label, function() self:publishHomeInfo() end)
    end
end

-- Publica todos os dados de tabelas e confrontos
function Standings:publishAllData()
    self:publishCurrentGroupStandings()
    self:publishCurrentGroupFixtures()
    self:publishGroupLabel()
    self:publishHomeInfo()
    self:publishTournamentProgress()
    self:publishAllKnockoutFixtures()
    self:publishGroupLabel()
end

-- Publica todos os confrontos knockout
function Standings:publishAllKnockoutFixtures()
    -- JIKA MODE LIGA: Kosongkan paksa semua isi panel babak gugur
    if self.isLeagueMode then
        self.im.Publish(bndRound32Fixtures, {})
        self.im.Publish(bndRound16Fixtures, {})
        self.im.Publish(bndQuarterFixtures, {})
        self.im.Publish(bndSemiFixtures, {})
        self.im.Publish(bndFinalFixture, {})
        return
    end
    
    -- Jika Mode Normal (Grup/Knockout), muat como biasa
    self:publishRound32Fixtures()
    self:publishRound16Fixtures()
    self:publishQuarterFixtures()
    self:publishSemiFixtures()
    self:publishFinalFixture()
end

-- Publica confrontos do grupo/league atual
function Standings:publishCurrentGroupFixtures()
    if self.isLeagueMode then
        self:publishLeagueFixtures()
        return
    end
    
    local fixturesData = {}
    
    -- JIKA KNOCKOUT ONLY: KOSONGKAN TOTAL BAGIAN GROUP STAGE DI SINI
    if self.isKnockoutOnly then
        self.im.Publish(bndFixturesList, fixturesData)
        return
    end
    
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    local group = self.groups[currentGroup]
    if not group then 
        self.im.Publish(bndFixturesList, fixturesData)
        return 
    end
    
    for _, match in ipairs(group.matches) do
        local isPlayerMatch = (match.homeID == playerTeamID or match.awayID == playerTeamID)
        local scoreText = match.isPlayed and (match.homeScore .. " - " .. match.awayScore) or "VS"
        
        table.insert(fixturesData, {
            data = {
                TeamHomeCrest = { name = CREST_NORMAL, id = match.homeID },
                TeamAwayCrest = { name = CREST_NORMAL, id = match.awayID },
                TeamHomeName = self.loc.LocalizeString("TeamName_Abbr3_" .. (match.homeID or 0)),
                TeamAwayName = self.loc.LocalizeString("TeamName_Abbr3_" .. (match.awayID or 0)),
                MatchScore = scoreText,
                MatchInfo = "Group Stage",
                FontColor = isPlayerMatch and "0x00FF00" or "0xFFFFFF",
                TeamNameFontColor = isPlayerMatch and "0x00FF00" or "0x4A2C6D",
                HomeIcon = (match.homeID == playerTeamID) and { name = "$my_team" } or nil,
                AwayIcon = (match.awayID == playerTeamID) and { name = "$my_team" } or nil
            }
        })
    end
    self.im.Publish(bndFixturesList, fixturesData)
end

-- Publica confrontos da League
function Standings:publishLeagueFixtures()
    local fixturesData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == "LEAGUE" then
                local isPlayerMatch = (match[1] == playerTeamID or match[2] == playerTeamID)
                local scoreText = match[5] and (match[3] .. " - " .. match[4]) or "VS"
                
                table.insert(fixturesData, {
                    data = {
                        TeamHomeCrest = { name = CREST_NORMAL, id = match[1] },
                        TeamAwayCrest = { name = CREST_NORMAL, id = match[2] },
                        TeamHomeName = self.loc.LocalizeString("TeamName_Abbr3_" .. (match[1] or 0)),
                        TeamAwayName = self.loc.LocalizeString("TeamName_Abbr3_" .. (match[2] or 0)),
                        MatchScore = scoreText,
                        MatchInfo = "LEAGUE",
                        FontColor = isPlayerMatch and "0x00FF00" or "0xFFFFFF",
                        TeamNameFontColor = isPlayerMatch and "0x00FF00" or "0x4A2C6D",
                        HomeIcon = (match[1] == playerTeamID) and { name = "$my_team" } or nil,
                        AwayIcon = (match[2] == playerTeamID) and { name = "$my_team" } or nil
                    }
                })
            end
        end
    end
    self.im.Publish(bndFixturesList, fixturesData)
end

-- Publica confrontos da Round of 32
function Standings:publishRound32Fixtures()
    local fixturesData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == STAGE_NAMES.R32 then
                local isPlayerMatch = (match[1] == playerTeamID or match[2] == playerTeamID)
                local scoreText = match[5] and (match[3] .. " - " .. match[4]) or "VS"
                table.insert(fixturesData, {
                    data = {
                        TeamHomeCrest = { name = CREST_64, id = match[1] },
                        TeamAwayCrest = { name = CREST_64, id = match[2] },
                        TeamHomeName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[1] or 0)),
                        TeamAwayName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[2] or 0)),
                        MatchScore = scoreText,
                        MatchInfo = STAGE_NAMES.R32,
                        FontColor = isPlayerMatch and "0x00FF00" or "0xFFFFFF",
                        TeamNameFontColor = isPlayerMatch and "0x00FF00" or "0x4A2C6D",
                        HomeIcon = (match[1] == playerTeamID) and { name = "$my_team" } or nil,
                        AwayIcon = (match[2] == playerTeamID) and { name = "$my_team" } or nil
                    }
                })
            end
        end
    end
    self.im.Publish("bnd_round32_fixtures", fixturesData)
end

-- Publica confrontos das Oitavas de Final
function Standings:publishRound16Fixtures()
    local fixturesData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == STAGE_NAMES.R16 then
                local isPlayerMatch = (match[1] == playerTeamID or match[2] == playerTeamID)
                local scoreText = match[5] and (match[3] .. " - " .. match[4]) or "VS"
                table.insert(fixturesData, {
                    data = {
                        TeamHomeCrest = { name = CREST_NORMAL, id = match[1] },
                        TeamAwayCrest = { name = CREST_NORMAL, id = match[2] },
                        TeamHomeName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[1] or 0)),
                        TeamAwayName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[2] or 0)),
                        MatchScore = scoreText,
                        MatchInfo = STAGE_NAMES.R16,
                        FontColor = isPlayerMatch and "0x00FF00" or "0xFFFFFF",
                        TeamNameFontColor = isPlayerMatch and "0x00FF00" or "0x4A2C6D",
                        HomeIcon = (match[1] == playerTeamID) and { name = "$my_team" } or nil,
                        AwayIcon = (match[2] == playerTeamID) and { name = "$my_team" } or nil
                    }
                })
            end
        end
    end
    self.im.Publish(bndRound16Fixtures, fixturesData)
end

-- Publica confrontos das Quartas de Final
function Standings:publishQuarterFixtures()
    local fixturesData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == STAGE_NAMES.QF then
                local isPlayerMatch = (match[1] == playerTeamID or match[2] == playerTeamID)
                local scoreText = match[5] and (match[3] .. " - " .. match[4]) or "VS"
                table.insert(fixturesData, {
                    data = {
                        TeamHomeCrest = { name = CREST_NORMAL, id = match[1] },
                        TeamAwayCrest = { name = CREST_NORMAL, id = match[2] },
                        TeamHomeName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[1] or 0)),
                        TeamAwayName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[2] or 0)),
                        MatchScore = scoreText,
                        MatchInfo = STAGE_NAMES.QF,
                        FontColor = isPlayerMatch and "0x00FF00" or "0xFFFFFF",
                        TeamNameFontColor = isPlayerMatch and "0x00FF00" or "0x4A2C6D",
                        HomeIcon = (match[1] == playerTeamID) and { name = "$my_team" } or nil,
                        AwayIcon = (match[2] == playerTeamID) and { name = "$my_team" } or nil
                    }
                })
            end
        end
    end
    self.im.Publish(bndQuarterFixtures, fixturesData)
end

-- Publica confrontos das Semifinais
function Standings:publishSemiFixtures()
    local fixturesData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == STAGE_NAMES.SF then
                local isPlayerMatch = (match[1] == playerTeamID or match[2] == playerTeamID)
                local scoreText = match[5] and (match[3] .. " - " .. match[4]) or "VS"
                table.insert(fixturesData, {
                    data = {
                        TeamHomeCrest = { name = CREST_NORMAL, id = match[1] },
                        TeamAwayCrest = { name = CREST_NORMAL, id = match[2] },
                        TeamHomeName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[1] or 0)),
                        TeamAwayName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[2] or 0)),
                        MatchScore = scoreText,
                        MatchInfo = STAGE_NAMES.SF,
                        FontColor = isPlayerMatch and "0x00FF00" or "0xFFFFFF",
                        TeamNameFontColor = isPlayerMatch and "0x00FF00" or "0x4A2C6D",
                        HomeIcon = (match[1] == playerTeamID) and { name = "$my_team" } or nil,
                        AwayIcon = (match[2] == playerTeamID) and { name = "$my_team" } or nil
                    }
                })
            end
        end
    end
    self.im.Publish(bndSemiFixtures, fixturesData)
end

-- Publica confronto da Final
function Standings:publishFinalFixture()
    local fixturesData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == STAGE_NAMES.F then
                local isPlayerMatch = (match[1] == playerTeamID or match[2] == playerTeamID)
                local scoreText = match[5] and (match[3] .. " - " .. match[4]) or "VS"
                table.insert(fixturesData, {
                    data = {
                        TeamHomeCrest = { name = CREST_NORMAL, id = match[1] },
                        TeamAwayCrest = { name = CREST_NORMAL, id = match[2] },
                        TeamHomeName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[1] or 0)),
                        TeamAwayName = self.loc.LocalizeString("TeamName_Abbr15_" .. (match[2] or 0)),
                        MatchScore = scoreText,
                        MatchInfo = STAGE_NAMES.F,
                        FontColor = isPlayerMatch and "0x00FF00" or "0xFFFFFF",
                        TeamNameFontColor = isPlayerMatch and "0x00FF00" or "0x4A2C6D",
                        HomeIcon = (match[1] == playerTeamID) and { name = "$my_team" } or nil,
                        AwayIcon = (match[2] == playerTeamID) and { name = "$my_team" } or nil
                    }
                })
            end
        end
    end
    self.im.Publish(bndFinalFixture, fixturesData)
end

-- Inicializa estrutura de torneio
function Standings:initializeTournament()
    self.groups = {}
    local isKnockoutOnly = GlobalTournamentSettings.isKnockoutOnly or false
    
    if self.isLeagueMode then
        print("League tournament detected. Skipping group initialization.")
        return
    end
    
    if isKnockoutOnly then
        self:initKnockoutStages()
        print("Knockout initialized with " .. self.totalGroups .. " stages.")
        return
    end
    
    if not QuickTourGrouping or not QuickTourGrouping[tourId] then
        print("Error: QuickTourGrouping data not found for tourId: " .. tourId)
        return
    end
    
    for g = 1, self.totalGroups do
        self.groups[g] = { 
            name = "GROUP " .. string.char(64 + g), 
            teams = {}, 
            matches = {}, 
            standings = {} 
        }
    end
    
    local teamToGroupMap = {}
    for i, matchData in ipairs(QuickTourGrouping[tourId]) do
        if matchData[8] == true then
            local homeID, awayID = matchData[1], matchData[2]
            local groupLetter = matchData[9]
            local groupIndex = string.byte(groupLetter) - 64
            
            if groupIndex >= 1 and groupIndex <= self.totalGroups and self.groups[groupIndex] then
                local currentGroupData = self.groups[groupIndex]
                if not teamToGroupMap[homeID] then
                    table.insert(currentGroupData.teams, homeID)
                    teamToGroupMap[homeID] = groupIndex
                end
                if not teamToGroupMap[awayID] then
                    table.insert(currentGroupData.teams, awayID)
                    teamToGroupMap[awayID] = groupIndex
                end
                table.insert(currentGroupData.matches, {
                    homeID = homeID, 
                    awayID = awayID, 
                    homeScore = matchData[3] or 0, 
                    awayScore = matchData[4] or 0, 
                    isPlayed = matchData[5] or false, 
                    matchIndex = i
                })
            end
        end
    end
    
    if currentTourInfo[tourId] and currentTourInfo[tourId].homeID then
        local playerTeamId = currentTourInfo[tourId].homeID
        if teamToGroupMap[playerTeamId] then
            currentGroup = teamToGroupMap[playerTeamId]
        end
    end
    
    print(string.format("Tournament initialized with %d groups. Current group: %d", self.totalGroups, currentGroup))
end

-- Calcula standings de um grupo
function Standings:calculateGroupStandings(group)
    local teamStats = {}
    if not group or not group.teams then return {} end
    
    for _, teamID in ipairs(group.teams) do
        teamStats[teamID] = { 
            teamID = teamID, 
            played = 0, 
            wins = 0, 
            draws = 0, 
            losses = 0, 
            goalsFor = 0, 
            goalsAgainst = 0, 
            points = 0 
        }
    end
    
    for _, match in ipairs(group.matches) do
        if match.isPlayed then
            local home = teamStats[match.homeID]
            local away = teamStats[match.awayID]
            if home and away then
                home.played = home.played + 1
                away.played = away.played + 1
                home.goalsFor = home.goalsFor + (match.homeScore or 0)
                home.goalsAgainst = home.goalsAgainst + (match.awayScore or 0)
                away.goalsFor = away.goalsFor + (match.awayScore or 0)
                away.goalsAgainst = away.goalsAgainst + (match.homeScore or 0)
                
                if (match.homeScore or 0) > (match.awayScore or 0) then
                    home.wins = home.wins + 1
                    home.points = home.points + 3
                    away.losses = away.losses + 1
                elseif (match.homeScore or 0) < (match.awayScore or 0) then
                    away.wins = away.wins + 1
                    away.points = away.points + 3
                    home.losses = home.losses + 1
                else
                    home.draws = home.draws + 1
                    away.draws = away.draws + 1
                    home.points = home.points + 1
                    away.points = away.points + 1
                end
            end
        end
    end
    
    local sortedStandings = {}
    for _, stats in pairs(teamStats) do 
        table.insert(sortedStandings, stats) 
    end
    
    table.sort(sortedStandings, function(a, b)
        if a.points ~= b.points then return a.points > b.points end
        local gdA = (a.goalsFor or 0) - (a.goalsAgainst or 0)
        local gdB = (b.goalsFor or 0) - (b.goalsAgainst or 0)
        if gdA ~= gdB then return gdA > gdB end
        if a.goalsFor ~= b.goalsFor then return a.goalsFor > b.goalsFor end
        return a.teamID < b.teamID
    end)
    
    return sortedStandings
end

-- Mengumpulkan daftar babak knockout agar bisa digeser com Kiri/Kanan
function Standings:initKnockoutStages()
    local tourId = GlobalTournamentSettings.tourId or 1
    self.knockoutStages = {}
    local stageMap = {}
    local order = {"Round of 32", "Round of 16", "Quarter-Finals", "Semi-Finals", "Final"}
    
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            local st = match[9]
            if st and not stageMap[st] then
                for _, validStage in ipairs(order) do
                    if st == validStage then
                        stageMap[st] = true
                        break
                    end
                end
            end
        end
    end
    
    for _, st in ipairs(order) do
        if stageMap[st] then table.insert(self.knockoutStages, st) end
    end
    
    if #self.knockoutStages == 0 then self.knockoutStages = {"Knockout Stage"} end
    self.totalGroups = #self.knockoutStages
    
    currentGroup = 1
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for i, stage in ipairs(self.knockoutStages) do
            local stageComplete = true
            for _, match in ipairs(QuickTourGrouping[tourId]) do
                if match[9] == stage and not match[5] then
                    stageComplete = false
                    break
                end
            end
            currentGroup = i
            if not stageComplete then break end
        end
    end
end

-- Menampilkan fixture Knockout di widget Standings
function Standings:publishKnockoutStandings()
    local uiData = {}
    local tourId = GlobalTournamentSettings.tourId or 1
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    if not self.knockoutStages then self:initKnockoutStages() end
    local currentStage = self.knockoutStages[currentGroup]
    
    local matchCount = 1
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == currentStage then
                local homeId = match[1]
                local awayId = match[2]
                local homeScore = match[5] and tostring(match[3]) or "-"
                local awayScore = match[5] and tostring(match[4]) or "-"
                
                table.insert(uiData, {
                    data = {
                        TeamCrest = { name = CREST_NORMAL, id = homeId },
                        TeamName  = self.loc.LocalizeString("TeamName_Abbr15_" .. (homeId or 0)),
                        TeamPoint = homeScore, Teammp = "", TeamWin = "", TeamDraw = "", TeamLoss = "", TeamGA = "", TeamGC = "", TeamGD = "",
                        Teampos = matchCount .. ".",
                        FontColor = (homeId == playerTeamID) and "0xFFD700" or "0x333333",
                        Icon = (homeId == playerTeamID) and { name = "$my_team" } or nil
                    }
                })
                
                table.insert(uiData, {
                    data = {
                        TeamCrest = { name = CREST_NORMAL, id = awayId },
                        TeamName  = self.loc.LocalizeString("TeamName_Abbr15_" .. (awayId or 0)),
                        TeamPoint = awayScore, Teammp = "", TeamWin = "", TeamDraw = "", TeamLoss = "", TeamGA = "", TeamGC = "", TeamGD = "",
                        Teampos = "vs",
                        FontColor = (awayId == playerTeamID) and "0xFFD700" or "0x333333",
                        Icon = (awayId == playerTeamID) and { name = "$my_team" } or nil
                    }
                })
                matchCount = matchCount + 1
            end
        end
    end
    self.im.Publish(bndGroupStandings, uiData)
end

-- Publica standings do grupo/league/knockout atual
function Standings:publishCurrentGroupStandings()
    if self.isLeagueMode then
        self:publishLeagueStandings()
        return
    end
    
    local uiData = {}
    if self.isKnockoutOnly then
        self.im.Publish(bndGroupStandings, uiData)
        return
    end
    
    local group = self.groups[currentGroup]
    if not group then 
        self.im.Publish(bndGroupStandings, uiData)
        return 
    end

    group.standings = self:calculateGroupStandings(group)
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0

    for pos, team in ipairs(group.standings) do
        local isPlayerTeam = (team.teamID == playerTeamID)
        local isAdvancing = pos <= 2
        local fontColor = "0x333333"
        if isPlayerTeam then fontColor = "0xFFD700"
        elseif isAdvancing then fontColor = "0x00FF00" end

        local goalDiff = (team.goalsFor or 0) - (team.goalsAgainst or 0)

        table.insert(uiData, {
            data = {
                TeamCrest = { name = CREST_NORMAL, id = team.teamID },
                TeamName  = self.loc.LocalizeString("TeamName_Abbr15_" .. (team.teamID or 0)),
                TeamPoint = team.points, Teammp = team.played, TeamWin = team.wins, TeamDraw = team.draws,
                TeamLoss = team.losses, TeamGA = team.goalsFor, TeamGC = team.goalsAgainst, TeamGD = goalDiff,
                Teampos = pos .. ".", FontColor = fontColor,
                Icon = isPlayerTeam and { name = "$my_team" } or nil
            }
        })
    end
    self.im.Publish(bndGroupStandings, uiData)
end

-- Publica standings da League
function Standings:publishLeagueStandings()
    local tourId = GlobalTournamentSettings.tourId or 1
    local uiData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    
    LeagueStandings[tourId] = LeagueStandings[tourId] or {}
    for teamId, _ in pairs(LeagueStandings[tourId]) do
        LeagueStandings[tourId][teamId] = { teamId = teamId, played = 0, wins = 0, draws = 0, losses = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
    end
    
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == "LEAGUE" then
                for _, teamId in ipairs({match[1], match[2]}) do
                    if not LeagueStandings[tourId][teamId] then
                        LeagueStandings[tourId][teamId] = { teamId = teamId, played = 0, wins = 0, draws = 0, losses = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
                    end
                end
            end
        end
        
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == "LEAGUE" and match[5] == true then
                local homeId, awayId = match[1], match[2]
                local homeScore, awayScore = match[3] or 0, match[4] or 0
                local lsHome, lsAway = LeagueStandings[tourId][homeId], LeagueStandings[tourId][awayId]
                
                if lsHome and lsAway then
                    lsHome.played = lsHome.played + 1
                    lsAway.played = lsAway.played + 1
                    lsHome.goalsFor = lsHome.goalsFor + homeScore
                    lsHome.goalsAgainst = lsHome.goalsAgainst + awayScore
                    lsAway.goalsFor = lsAway.goalsFor + awayScore
                    lsAway.goalsAgainst = lsAway.goalsAgainst + homeScore
                    
                    if homeScore > awayScore then
                        lsHome.wins = lsHome.wins + 1; lsHome.points = lsHome.points + 3; lsAway.losses = lsAway.losses + 1
                    elseif awayScore > homeScore then
                        lsAway.wins = lsAway.wins + 1; lsAway.points = lsAway.points + 3; lsHome.losses = lsHome.losses + 1
                    else
                        lsHome.draws = lsHome.draws + 1; lsAway.draws = lsAway.draws + 1
                        lsHome.points = lsHome.points + 1; lsAway.points = lsAway.points + 1
                    end
                end
            end
        end
    end
    
    local teamsArray = {}
    for _, teamStats in pairs(LeagueStandings[tourId]) do table.insert(teamsArray, teamStats) end
    table.sort(teamsArray, function(a, b)
        if a.points ~= b.points then return a.points > b.points end
        local gdA, gdB = a.goalsFor - a.goalsAgainst, b.goalsFor - b.goalsAgainst
        if gdA ~= gdB then return gdA > gdB end
        return a.goalsFor > b.goalsFor
    end)
    
    for pos, team in ipairs(teamsArray) do
        local isPlayerTeam = (team.teamId == playerTeamID)
        local isQualifying = pos <= 16
        local fontColor = "0x333333"
        if isPlayerTeam then fontColor = "0xFFD700"
        elseif isQualifying then fontColor = "0x00FF00" end
        
        local goalDiff = team.goalsFor - team.goalsAgainst
        
        table.insert(uiData, {
            data = {
                TeamCrest = { name = CREST_NORMAL, id = team.teamId },
                TeamName = self.loc.LocalizeString("TeamName_Abbr15_" .. (team.teamId or 0)),
                TeamPoint = team.points, Teammp = team.played, TeamWin = team.wins, TeamDraw = team.draws,
                TeamLoss = team.losses, TeamGA = team.goalsFor, TeamGC = team.goalsAgainst, TeamGD = goalDiff,
                Teampos = pos .. ".", FontColor = fontColor,
                Icon = isPlayerTeam and { name = "$my_team" } or (isQualifying and { name = "$IconCheck" } or nil)
            }
        })
    end
    self.im.Publish(bndGroupStandings, uiData)
end

-- Publica todos os standings
function Standings:publishAllStandings()
    if self.isLeagueMode then
        self:publishLeagueStandings()
        return
    end
    
    local standingsData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    local allTeams = {}
    
    for groupIndex = 1, self.totalGroups do
        local group = self.groups[groupIndex]
        if group then
            group.standings = self:calculateGroupStandings(group)
            for _, team in ipairs(group.standings) do 
                table.insert(allTeams, team) 
            end
        end
    end
    
    table.sort(allTeams, function(a, b)
        if a.points ~= b.points then return a.points > b.points end
        local gdA = (a.goalsFor or 0) - (a.goalsAgainst or 0)
        local gdB = (b.goalsFor or 0) - (b.goalsAgainst or 0)
        if gdA ~= gdB then return gdA > gdB end
        return a.goalsFor > b.goalsFor
    end)
    
    for pos, team in ipairs(allTeams) do
        local isPlayerTeam = (team.teamID == playerTeamID)
        local goalDiff = (team.goalsFor or 0) - (team.goalsAgainst or 0)
        
        table.insert(standingsData, { 
            data = {
                TeamCrest = { name = CREST_NORMAL, id = team.teamID },
                TeamName = self.loc.LocalizeString("TeamName_Abbr15_" .. (team.teamID or 0)),
                TeamPoint = team.points, 
                Teammp = team.played,
                TeamWin = team.wins, 
                TeamDraw = team.draws, 
                TeamLoss = team.losses,
                TeamGA = team.goalsFor, 
                TeamGC = team.goalsAgainst,
                TeamGD = goalDiff,
                Teampos = pos .. ".",
                FontColor = isPlayerTeam and "0xFFD700" or "0x333333",
                Icon = isPlayerTeam and { name = "$my_team" } or nil
            }
        })
    end
    
    self.im.Publish(bndStandingsList, standingsData)
end

-- Publica informações da home/menu
function Standings:publishHomeInfo()
    self:UpdateModeLabelText() -- Menyegarkan teks label tiap kali menu direfresh

    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    local currentDate = os.date("%d %B %Y")
    local currentTime = os.date("%h %d | %I:%M %p")
    
    local matchdayLabel = "GROUP A"
    if self.isLeagueMode then
        matchdayLabel = "LEAGUE"
    elseif self.isKnockoutOnly then
        if not self.knockoutStages then self:initKnockoutStages() end
        matchdayLabel = string.upper(self.knockoutStages[currentGroup] or "")
    else
        matchdayLabel = self.groups[currentGroup] and self.groups[currentGroup].name or "GROUP A"
    end
    
    self.im.Publish("bnd_matchday_label", matchdayLabel)
    self.im.Publish("bnd_team_label", tourName)
    self.im.Publish("bnd_month_label", currentDate)
    self.im.Publish("bnd_realtime", tourName .. " " .. currentTime)
    
    self.im.Publish("bnd_tour_label", tourName)
    self.im.Publish("bnd_tour_trophy", { name = "$CustomTrophy", id = tourId })
    self.im.Publish("bnd_bg_tour", { name = "$Bg_Cup", id = tourId })
    self.im.Publish("bnd_tour_logo", { name = "$CustomLogo", id = tourId })

    self:publishGroupLabel()
end

-- Publica rótulos de grupo
function Standings:publishGroupLabel()
    if self.isLeagueMode then
        self.im.Publish("bnd_group_label_current", "LEAGUE")
        self.im.Publish("bnd_group_label_prev", "LEAGUE")
        self.im.Publish("bnd_group_label_next", "LEAGUE")
        return
    end
    
    if self.isKnockoutOnly then
        if not self.knockoutStages then self:initKnockoutStages() end
        local prevGroup = (currentGroup - 2 + self.totalGroups) % self.totalGroups + 1
        local nextGroup = currentGroup % self.totalGroups + 1
        
        self.im.Publish("bnd_group_label_current", string.upper(self.knockoutStages[currentGroup] or ""))
        self.im.Publish("bnd_group_label_prev", string.upper(self.knockoutStages[prevGroup] or ""))
        self.im.Publish("bnd_group_label_next", string.upper(self.knockoutStages[nextGroup] or ""))
        return
    end
    
    local prevGroup = (currentGroup - 2 + self.totalGroups) % self.totalGroups + 1
    local nextGroup = currentGroup % self.totalGroups + 1
    
    self.im.Publish("bnd_group_label_current", self.groups[currentGroup] and self.groups[currentGroup].name or "GROUP A")
    self.im.Publish("bnd_group_label_prev", self.groups[prevGroup] and self.groups[prevGroup].name or "GROUP " .. string.char(64 + self.totalGroups))
    self.im.Publish("bnd_group_label_next", self.groups[nextGroup] and self.groups[nextGroup].name or "GROUP B")
end

-- Publica progresso do torneio
function Standings:publishTournamentProgress()
    local progressText = self.isLeagueMode and "LEAGUE" or "Group Stage"
    local matchdaysPerGroup = self.matchdaysPerGroup or 6
    
    if self.isLeagueMode then
        if QuickTourGrouping and QuickTourGrouping[tourId] then
            local leagueMatchesPlayed = 0
            local totalLeagueMatches = 0
            for _, match in ipairs(QuickTourGrouping[tourId]) do
                if match[9] == "LEAGUE" then
                    totalLeagueMatches = totalLeagueMatches + 1
                    if match[5] then
                        leagueMatchesPlayed = leagueMatchesPlayed + 1
                    end
                end
            end
            
            if leagueMatchesPlayed == totalLeagueMatches and totalLeagueMatches > 0 then
                progressText = "Tournament Completed"
            else
                progressText = string.format("LEAGUE (%d/%d)", leagueMatchesPlayed, totalLeagueMatches)
            end
        end
    elseif self.isKnockoutOnly then
        progressText = "Knockout Stage"
        local currentStage = "Tournament Completed"
        local stageOrder = {"Final", "Semi-Finals", "Quarter-Finals", "Round of 16", "Round of 32"}
        
        if QuickTourGrouping and QuickTourGrouping[tourId] then
            for _, stage in ipairs(stageOrder) do
                for _, match in ipairs(QuickTourGrouping[tourId]) do
                    if match[9] == stage and not match[5] then 
                        currentStage = stage
                        break 
                    end
                end
                if currentStage ~= "Tournament Completed" then break end
            end
        end
        progressText = currentStage
    else
        local matchesPerGroup = (matchdaysPerGroup == 6) and 12 or 6
        local totalGroupMatches = matchesPerGroup * self.totalGroups
        local allGroupMatchesDone = true
        
        if QuickTourGrouping and QuickTourGrouping[tourId] then
            for i = 1, totalGroupMatches do
                if QuickTourGrouping[tourId][i] and not QuickTourGrouping[tourId][i][5] then 
                    allGroupMatchesDone = false
                    break 
                end
            end
        else
            allGroupMatchesDone = false
        end
        
        if allGroupMatchesDone then
            local currentStage = "Tournament Completed"
            local stageOrder = {"Final", "Semi-Finals", "Quarter-Finals", "Round of 16", "Round of 32"}
            
            if QuickTourGrouping and QuickTourGrouping[tourId] then
                for _, stage in ipairs(stageOrder) do
                    for _, match in ipairs(QuickTourGrouping[tourId]) do
                        if match[9] == stage and not match[5] then 
                            currentStage = stage
                            break 
                        end
                    end
                    if currentStage ~= "Tournament Completed" then break end
                end
            end
            progressText = currentStage
        end
    end
    
    self.im.Publish(bndInfoProgres, progressText)
end

-- Navega para próximo grupo
function Standings:NextGroup()
    if self.isLeagueMode then return end
    currentGroup = currentGroup % self.totalGroups + 1
    self:publishCurrentGroupStandings()
    self:publishCurrentGroupFixtures()
    self:publishGroupLabel()
end

-- Navega para grupo anterior
function Standings:PrevGroup()
    if self.isLeagueMode then return end
    currentGroup = (currentGroup - 2 + self.totalGroups) % self.totalGroups + 1
    self:publishCurrentGroupStandings()
    self:publishCurrentGroupFixtures()
    self:publishGroupLabel()
end

-- Update visibilitas otomatis
function Standings:UpdateVisibilityMode()
    -- BND_VISIBLE_HIDE = false jika mode liga (sehingga elemennya hilang)
    self.im.Publish(BND_VISIBLE_HIDE, not self.isLeagueMode) 
    
    -- BND_VISIBLE_SHOW = true jika mode liga (sehingga elemennya muncul)
    self.im.Publish(BND_VISIBLE_SHOW, self.isLeagueMode) 
end

-- Limpa recursos ao finalizar
function Standings:finalize()
    local subsToClean = {
        BND_DYNAMIC_TEXT, BND_COLOR_CUPID, BND_COLOR_CUPID2, bndStandingsList, bndFixturesList, bndGroupStandings,
        bndRound32Fixtures, bndRound16Fixtures, bndQuarterFixtures, bndSemiFixtures, bndFinalFixture,
        bndInfoProgres, "bnd_matchday_label", "bnd_team_label", "bnd_month_label",
        "bnd_realtime", "bnd_tour_label", "bnd_bg_tour", "bnd_tour_logo",
        "bnd_tour_trophy", "bnd_group_label_current", "bnd_group_label_next", "bnd_group_label_prev",
        "bnd_visible_hide", "bnd_visible_show" -- Memastikan binding visibilitas dibersihkan
    }
    
    for _, s in ipairs(subsToClean) do 
        self.im.Unsubscribe(s) 
    end
    
    self.im.UnregisterAction("act_next_group")
    self.im.UnregisterAction("act_prev_group")
    
    print("Standings module finalized")
end

return Standings
