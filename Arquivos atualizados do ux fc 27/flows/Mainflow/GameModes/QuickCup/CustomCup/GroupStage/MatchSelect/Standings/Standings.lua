-- Suporta múltiplos formatos: Group + Knockout, Knockout e League

local Standings = {}

-- Constantes de Binding
local BND_COLOR_CUPID = "bnd_color_tourid"
local BND_COLOR_CUPID2 = "bnd_color_tourid2"
local bndStandingsList = "bnd_standings_list"
local bndFixturesList = "bnd_fixtures_list"
local bndGroupStandings = "bnd_group_standings"
local bndRound32Fixtures = "bnd_round32_fixtures"
local bndRound16Fixtures = "bnd_round16_fixtures"
local bndQuarterFixtures = "bnd_quarter_fixtures"
local bndSemiFixtures = "bnd_semi_fixtures"
local bndFinalFixture = "bnd_final_fixture"
local bndInfoProgres = "bnd_info_progres"

-- Baris baru: Definisi binding champions
local bndChampionsTeamName = "bnd_champions_team_name"
local bndChampionsCrest = "bnd_champions_crest"

local tourId = GlobalTournamentSettings and GlobalTournamentSettings.tourId or 1

-- Mapeamento de IDs de Torneio para Nomes
local tourIdToNameMap = {
    [2]  = "FIFA World Cup 2026",        [5]  = "Copa do Brasil",
    [6]  = "UEFA Euro",                  [7]  = "Dfb Pokal",
    [9]  = "The Emirates FA Cup",        [10] = "Copa del Rey",
    [11] = "Coppa Italia",               [13] = "US Open Tour",
    [14] = "EA Sports Cup",              [15] = "FIFA Club World Cup",
    [16] = "UEFA Women CL",              [18] = "Coupe de France",
    [19] = "Copa Argentina",             [20] = "Copa MX",
    [25] = "Copa America",               [26] = "Africa Cup Of Nations",
    [28] = "UEFA Nations League",        [29] = "Kratingdaeng Piala Indonesia",
    [30] = "ALL STAR CUP",               [33] = "Leagues Cup",
    [34] = "AFC Asian Cup 2027",         [35] = "UEFA Champions League",
    default = "Custom Tournament"
}

-- Mapeamento de IDs de Torneio para Cores
local tourIdToColorMap = {
    [2]  = "0x001B96",        [5]  = "0x1A1A1A",
    [6]  = "0x000351",        [7]  = "0x1A1A1A",
    [9]  = "0x1A1A1A",        [10] = "0x131244",
    [11] = "0x5C0103",        [13] = "0x1A1A1A",
    [14] = "0x1A1A1A",        [15] = "0x022E01",
    [16] = "0x1A1A1A",        [18] = "0x1A1A1A",
    [19] = "0x1A1A1A",        [20] = "0x1A1A1A",
    [25] = "0x001B4D",        [26] = "0x550002",
    [28] = "0x19253B",        [29] = "0x0E3353",
    [30] = "0x1A1A1A",        [33] = "0x1A1A1A",
    [34] = "0x002D04",        [35] = "0x000026",
    default = "0x1A1A1A"
}

-- Mapeamento de IDs de Torneio para Cores de tab
local tourIdToColorTabMap = {
    [2]  = "0xDE0001",        [5]  = "0x282A30",
    [6]  = "0x000592",        [7]  = "0x282A30",
    [9]  = "0x282A30",        [10] = "0x78000B",
    [11] = "0x930205",        [13] = "0x282A30",
    [14] = "0x282A30",        [15] = "0x056001",
    [16] = "0x282A30",        [18] = "0x282A30",
    [19] = "0x282A30",        [20] = "0x282A30",
    [25] = "0x002E88",        [26] = "0x7A0002",
    [28] = "0x293C61",        [29] = "0x175081",
    [30] = "0x282A30",        [33] = "0x282A30",
    [34] = "0x00630C",        [35] = "0x000086",
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
    
    o:initializeTournament()
    o:setupSubscriptions()
    o.im.RegisterAction("act_next_group", function() o:NextGroup() end)
    o.im.RegisterAction("act_prev_group", function() o:PrevGroup() end)
    o:publishAllData()
    
    print(string.format("Standings initialized: %d groups of %d teams | %d total teams | %d matchdays | League: %s", 
        o.totalGroups, o.teamsPerGroup, o.teamCount, o.matchdaysPerGroup, tostring(o.isLeagueMode)))
    return o
end

-- Configura subscriptions para bindings
function Standings:setupSubscriptions()
    self.im.Subscribe(BND_COLOR_CUPID, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        local color = tourIdToColorMap[currentTourId] or tourIdToColorMap.default
        self.im.Publish(BND_COLOR_CUPID, color)
    end)
    
    self.im.Subscribe(BND_COLOR_CUPID2, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1

        local color2 =
            (tourIdToColorTabMap and tourIdToColorTabMap[currentTourId])
            or (tourIdToColorTabMap and tourIdToColorTabMap.default)
            or tourIdToColorMap[currentTourId]
            or tourIdToColorMap.default

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
    
    -- Baris baru: Menambahkan bndChampionsTeamName dan bndChampionsCrest ke loop subscribe
    local infoLabels = {
        "bnd_matchday_label", "bnd_team_label", "bnd_month_label", "bnd_realtime", 
        "bnd_tour_label", "bnd_bg_tour", "bnd_tour_logo", "bnd_group_label_current", 
        "bnd_group_label_next", "bnd_group_label_prev", "bnd_tour_trophy",
        bndChampionsTeamName, bndChampionsCrest
    }
    for _, label in ipairs(infoLabels) do
        self.im.Subscribe(label, function() self:publishHomeInfo() end)
    end
end

-- Baris baru: Fungsi untuk mendapatkan ID Tim Pemenang dari Fixtures.lua
function Standings:getWinnerTeamId()
    local winnerId = 0
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == STAGE_NAMES.F and match[5] == true then
                local homeScore = match[3] or 0
                local awayScore = match[4] or 0
                if homeScore > awayScore then
                    winnerId = match[1]
                elseif awayScore > homeScore then
                    winnerId = match[2]
                end
                break 
            end
        end
    end
    return winnerId
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
    local group = self.groups[currentGroup]
    if not group then print("No group data for fixtures: " .. currentGroup); return end
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    
    for _, match in ipairs(group.matches) do
        local isPlayerMatch = (match.homeID == playerTeamID or match.awayID == playerTeamID)
        local scoreText = match.isPlayed and (match.homeScore .. " - " .. match.awayScore) or "VS"
        
        table.insert(fixturesData, {
            data = {
                TeamHomeCrest = { name = "$Crest", id = match.homeID },
                TeamAwayCrest = { name = "$Crest", id = match.awayID },
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
                        TeamHomeCrest = { name = "$Crest", id = match[1] },
                        TeamAwayCrest = { name = "$Crest", id = match[2] },
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
                        TeamHomeCrest = { name = "$Crest64x64", id = match[1] },
                        TeamAwayCrest = { name = "$Crest64x64", id = match[2] },
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
                        TeamHomeCrest = { name = "$Crest", id = match[1] },
                        TeamAwayCrest = { name = "$Crest", id = match[2] },
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
                        TeamHomeCrest = { name = "$Crest", id = match[1] },
                        TeamAwayCrest = { name = "$Crest", id = match[2] },
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
                        TeamHomeCrest = { name = "$Crest", id = match[1] },
                        TeamAwayCrest = { name = "$Crest", id = match[2] },
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
                        TeamHomeCrest = { name = "$Crest", id = match[1] },
                        TeamAwayCrest = { name = "$Crest", id = match[2] },
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
    
    if isKnockoutOnly or self.isLeagueMode then
        print("Knockout-only or League tournament detected. Skipping group initialization.")
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

function Standings:publishCurrentGroupStandings()
    if self.isLeagueMode then
        self:publishLeagueStandings()
        return
    end
    
    local group = self.groups[currentGroup]
    if not group then 
        print("No group data for currentGroup: " .. currentGroup)
        return 
    end

    group.standings = self:calculateGroupStandings(group)
    local uiData = {}

    local playerTeamID = currentTourInfo[tourId] 
        and currentTourInfo[tourId].homeID or 0

    -- HEADER DIHAPUS

    for pos, team in ipairs(group.standings) do
        local isPlayerTeam = (team.teamID == playerTeamID)
        local isAdvancing = pos <= 2

        local fontColor = "0x333333"
        if isPlayerTeam then
            fontColor = "0xFFD700"
        elseif isAdvancing then
            fontColor = "0x00FF00"
        end

        local goalDiff = (team.goalsFor or 0) - (team.goalsAgainst or 0)

        table.insert(uiData, {
            data = {
                TeamCrest = {
                    name = "$Crest",
                    id = team.teamID
                },
                TeamName  = self.loc.LocalizeString(
                    "TeamName_Abbr15_" .. (team.teamID or 0)
                ),
                TeamPoint = team.points,
                Teammp    = team.played,
                TeamWin   = team.wins,
                TeamDraw  = team.draws,
                TeamLoss  = team.losses,
                TeamGA    = team.goalsFor,
                TeamGC    = team.goalsAgainst,
                TeamGD    = goalDiff,
                Teampos   = pos .. ".",
                FontColor = fontColor,
                Icon = isPlayerTeam and { name = "$my_team" } or nil
            }
        })
    end

    self.im.Publish(bndGroupStandings, uiData)
end

function Standings:publishLeagueStandings()
    local tourId = GlobalTournamentSettings.tourId or 1
    local uiData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    
    -- 🔧 RECALCULAR LeagueStandings a partir de QuickTourGrouping
    print("[Standings] Recalculating League Standings from QuickTourGrouping...")
    
    if not LeagueStandings[tourId] then
        LeagueStandings[tourId] = {}
    else
        for teamId, _ in pairs(LeagueStandings[tourId]) do
            LeagueStandings[tourId][teamId] = {
                teamId = teamId,
                played = 0,
                wins = 0,
                draws = 0,
                losses = 0,
                goalsFor = 0,
                goalsAgainst = 0,
                points = 0
            }
        end
    end
    
    -- ✅ INIT TIMES
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        local teamsInitialized = {}
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == "LEAGUE" then
                if not teamsInitialized[match[1]] then
                    if not LeagueStandings[tourId][match[1]] then
                        LeagueStandings[tourId][match[1]] = {
                            teamId = match[1],
                            played = 0,
                            wins = 0,
                            draws = 0,
                            losses = 0,
                            goalsFor = 0,
                            goalsAgainst = 0,
                            points = 0
                        }
                    end
                    teamsInitialized[match[1]] = true
                end
                
                if not teamsInitialized[match[2]] then
                    if not LeagueStandings[tourId][match[2]] then
                        LeagueStandings[tourId][match[2]] = {
                            teamId = match[2],
                            played = 0,
                            wins = 0,
                            draws = 0,
                            losses = 0,
                            goalsFor = 0,
                            goalsAgainst = 0,
                            points = 0
                        }
                    end
                    teamsInitialized[match[2]] = true
                end
            end
        end
    end
    
    -- ✅ HITUNG HASIL MATCH
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if match[9] == "LEAGUE" and match[5] then
                local homeId = match[1]
                local awayId = match[2]
                local homeScore = match[3]
                local awayScore = match[4]
                
                if LeagueStandings[tourId][homeId] and LeagueStandings[tourId][awayId] then
                    local lsHome = LeagueStandings[tourId][homeId]
                    local lsAway = LeagueStandings[tourId][awayId]
                    
                    lsHome.played = lsHome.played + 1
                    lsAway.played = lsAway.played + 1
                    
                    lsHome.goalsFor = lsHome.goalsFor + homeScore
                    lsHome.goalsAgainst = lsHome.goalsAgainst + awayScore
                    lsAway.goalsFor = lsAway.goalsFor + awayScore
                    lsAway.goalsAgainst = lsAway.goalsAgainst + homeScore
                    
                    if homeScore > awayScore then
                        lsHome.wins = lsHome.wins + 1
                        lsHome.points = lsHome.points + 3
                        lsAway.losses = lsAway.losses + 1
                    elseif awayScore > homeScore then
                        lsAway.wins = lsAway.wins + 1
                        lsAway.points = lsAway.points + 3
                        lsHome.losses = lsHome.losses + 1
                    else
                        lsHome.draws = lsHome.draws + 1
                        lsAway.draws = lsAway.draws + 1
                        lsHome.points = lsHome.points + 1
                        lsAway.points = lsAway.points + 1
                    end
                end
            end
        end
    end
    
    -- ✅ SORTING
    local teamsArray = {}
    for _, teamStats in pairs(LeagueStandings[tourId]) do
        table.insert(teamsArray, teamStats)
    end
    
    table.sort(teamsArray, function(a, b)
        if a.points ~= b.points then return a.points > b.points end
        local gdA = a.goalsFor - a.goalsAgainst
        local gdB = b.goalsFor - b.goalsAgainst
        if gdA ~= gdB then return gdA > gdB end
        return a.goalsFor > b.goalsFor
    end)
    
    -- ❌ HEADER DIHAPUS
    
    -- ✅ DATA TIM
    for pos, team in ipairs(teamsArray) do
        local isPlayerTeam = (team.teamId == playerTeamID)
        local isQualifying = pos <= 16
        
        local fontColor = "0x333333"
        if isPlayerTeam then
            fontColor = "0xFFD700"
        elseif isQualifying then
            fontColor = "0x00FF00"
        end
        
        local goalDiff = team.goalsFor - team.goalsAgainst
        
        table.insert(uiData, {
            data = {
                TeamCrest = {
                    name = "$Crest",
                    id = team.teamId
                },
                TeamName = self.loc.LocalizeString("TeamName_Abbr15_" .. (team.teamId or 0)),
                TeamPoint = team.points,
                Teammp = team.played,
                TeamWin = team.wins,
                TeamDraw = team.draws,
                TeamLoss = team.losses,
                TeamGA = team.goalsFor,
                TeamGC = team.goalsAgainst,
                TeamGD = goalDiff,
                Teampos = pos .. ".",
                FontColor = fontColor,
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
                TeamCrest = { name = "$Crest", id = team.teamID },
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

-- Publica informações da home/menu (Atualizado com Champions)
function Standings:publishHomeInfo()
    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    local currentDate = os.date("%d %B %Y")
    local currentTime = os.date("%h %d | %I:%M %p")
    
    -- Lógica de Campeão
    local winnerTeamId = self:getWinnerTeamId()
    local displayTitle = ""
    
    if winnerTeamId ~= 0 then
        local winnerName = self.loc.LocalizeString("TeamName_Abbr15_" .. winnerTeamId)
        displayTitle = "WINNER OF THE " .. tourName .. " IS " .. winnerName
        self.im.Publish(bndChampionsCrest, { name = "$Crest", id = winnerTeamId })
    else
        displayTitle = "FINAL " .. tourName
        self.im.Publish(bndChampionsCrest, { name = "$CupTrophy", id = tourId })
    end
    
    self.im.Publish(bndChampionsTeamName, displayTitle)
    
    local matchdayLabel = self.isLeagueMode and "LEAGUE" or (self.groups[currentGroup] and self.groups[currentGroup].name or "GROUP A")
    
    self.im.Publish("bnd_matchday_label", matchdayLabel)
    self.im.Publish("bnd_team_label", tourName)
    self.im.Publish("bnd_month_label", currentDate)
    self.im.Publish("bnd_realtime", tourName .. " " .. currentTime)
    
    self.im.Publish("bnd_tour_label", tourName)
    self.im.Publish("bnd_tour_trophy", { name = "$Trophy", id = tourId })
    self.im.Publish("bnd_bg_tour", { name = "$Bg_Cup", id = tourId })
    self.im.Publish("bnd_tour_logo", { name = "$CupLogo", id = tourId })

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
    
    local prevGroup = (currentGroup - 2 + self.totalGroups) % self.totalGroups + 1
    local nextGroup = currentGroup % self.totalGroups + 1
    
    self.im.Publish("bnd_group_label_current", self.groups[currentGroup] and self.groups[currentGroup].name or "GROUP A")
    self.im.Publish("bnd_group_label_prev", self.groups[prevGroup] and self.groups[prevGroup].name or "GROUP " .. string.char(64 + self.totalGroups))
    self.im.Publish("bnd_group_label_next", self.groups[nextGroup] and self.groups[nextGroup].name or "GROUP B")
end

-- Publica progresso do torneio
function Standings:publishTournamentProgress()
    local progressText = self.isLeagueMode and "LEAGUE" or "Group Stage"
    local teamCount = self.teamCount or 32
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
                progressText = "Round of 16"
                local stageOrder = {"Final", "Semi-Finals", "Quarter-Finals", "Round of 16"}
                for _, stage in ipairs(stageOrder) do
                    for _, match in ipairs(QuickTourGrouping[tourId]) do
                        if match[9] == stage and not match[5] then
                            progressText = stage
                            break
                        end
                    end
                end
            else
                progressText = string.format("LEAGUE (%d/%d)", leagueMatchesPlayed, totalLeagueMatches)
            end
        end
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

-- Limpa recursos ao finalizar (Atualizado com novos bindings)
function Standings:finalize()
    local subsToClean = {
        BND_COLOR_CUPID, BND_COLOR_CUPID2, bndStandingsList, bndFixturesList, bndGroupStandings,
        bndRound32Fixtures, bndRound16Fixtures, bndQuarterFixtures, bndSemiFixtures, bndFinalFixture,
        bndInfoProgres, "bnd_matchday_label", "bnd_team_label", "bnd_month_label",
        "bnd_realtime", "bnd_tour_label", "bnd_bg_tour", "bnd_tour_logo",
        "bnd_tour_trophy", "bnd_group_label_current", "bnd_group_label_next", "bnd_group_label_prev",
        bndChampionsTeamName, bndChampionsCrest
    }
    
    for _, s in ipairs(subsToClean) do 
        self.im.Unsubscribe(s) 
    end
    
    self.im.UnregisterAction("act_next_group")
    self.im.UnregisterAction("act_prev_group")
    
    print("Standings module finalized")
end

return Standings