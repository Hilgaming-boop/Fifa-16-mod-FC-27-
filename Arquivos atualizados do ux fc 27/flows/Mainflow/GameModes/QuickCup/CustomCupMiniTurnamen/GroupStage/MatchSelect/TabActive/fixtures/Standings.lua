-- Khusus TOURNAMENT_LOGIC --
-- MOUNTSA --
local Standings = {}
local BND_COLOR_CUPID = "bnd_color_tourid"
local BND_COLOR_CUPID2 = "bnd_color_tourid2"
local bndStandingsList = "bnd_standings_list"
local bndFixturesList = "bnd_fixtures_list"
local bndGroupStandings = "bnd_group_standings"
local bndRound16Fixtures = "bnd_round16_fixtures"
local bndQuarterFixtures = "bnd_quarter_fixtures"
local bndSemiFixtures = "bnd_semi_fixtures"
local bndFinalFixture = "bnd_final_fixture"
local bndInfoProgres = "bnd_info_progres"

local tourId = GlobalTournamentSettings and GlobalTournamentSettings.tourId or 1
local tournamentConfig = GlobalTournamentSettings and GlobalTournamentSettings.config or {
    useUCLStyle = true,
    isLeague = false
}

local tourIdToNameMap = {
    [12] = "Asean Shopee Cup",
    [23] = "Sea Games U-23",
    [27] = "ASEAN Hyundai Cup 2026",
    [32] = "Piala Presiden",
    default = "Custom Tournament"
}

local tourIdToColorMap = {
    [12] = "0x954814",
    [23] = "0x003B5F",
    [27] = "0x001741",
    [32] = "0x101010",
    default = "0x1A1A1A"
}

local tourIdToColorMap2 = {
    [12] = "0xC06801",
    [23] = "0x0003B7",
    [27] = "0x003CA8",
    [32] = "0xAD261A",
    default = "0x333333"
}

local totalGroups = 8
local teamsPerGroup = 4
local matchesPerGroup = tournamentConfig.useUCLStyle and 12 or 6
local totalGroupMatches = matchesPerGroup * totalGroups
local currentGroup = 1

local STAGE_NAMES = {
    R16 = "Round of 16", QF = "Quarter Final",
    SF = "Semi Final", F = "Final"
}

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
    o:initializeTournament()
    o:setupSubscriptions()
    o.im.RegisterAction("act_next_group", function() o:NextGroup() end)
    o.im.RegisterAction("act_prev_group", function() o:PrevGroup() end)
    o:publishAllData()
    return o
end

function Standings:setupSubscriptions()
    self.im.Subscribe(BND_COLOR_CUPID, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        local color1 = tourIdToColorMap[currentTourId]
            or tourIdToColorMap.default

        self.im.Publish(BND_COLOR_CUPID, color1)
    end)

    -- ===============================
    -- COLOR CUPID 2 (SECONDARY) ✅ NEW
    -- ===============================
    self.im.Subscribe(BND_COLOR_CUPID2, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1

        local color2 =
            (tourIdToColorMap2 and tourIdToColorMap2[currentTourId])
            or (tourIdToColorMap2 and tourIdToColorMap2.default)
            or tourIdToColorMap[currentTourId]
            or tourIdToColorMap.default

        self.im.Publish(BND_COLOR_CUPID2, color2)
    end)

    self.im.Subscribe(bndStandingsList, function() self:publishAllStandings() end)
    self.im.Subscribe(bndFixturesList, function() self:publishCurrentGroupFixtures() end)
    self.im.Subscribe(bndGroupStandings, function() self:publishCurrentGroupStandings() end)
    self.im.Subscribe(bndRound16Fixtures, function() self:publishRound16Fixtures() end)
    self.im.Subscribe(bndQuarterFixtures, function() self:publishQuarterFixtures() end)
    self.im.Subscribe(bndSemiFixtures, function() self:publishSemiFixtures() end)
    self.im.Subscribe(bndFinalFixture, function() self:publishFinalFixture() end)
    self.im.Subscribe(bndInfoProgres, function() self:publishTournamentProgress() end)
    local infoLabels = {"bnd_matchday_label", "bnd_team_label", "bnd_month_label", "bnd_realtime", "bnd_tour_label","bnd_champions_team_name", "bnd_bg_tour", "bnd_tour_logo", "bnd_group_label_current", "bnd_group_label_next", "bnd_group_label_prev","bnd_tour_trophy","bnd_champions_crest"}
    for _, label in ipairs(infoLabels) do
        self.im.Subscribe(label, function() self:publishHomeInfo() end)
    end
end

function Standings:publishAllData()
    self:publishCurrentGroupStandings()
    self:publishCurrentGroupFixtures()
    self:publishGroupLabel()
    self:publishHomeInfo()
    self:publishTournamentProgress()
    self:publishAllKnockoutFixtures()
    self:publishGroupLabel()
end

function Standings:publishAllKnockoutFixtures()
    self:publishRound16Fixtures()
    self:publishQuarterFixtures()
    self:publishSemiFixtures()
    self:publishFinalFixture()
end

function Standings:publishCurrentGroupFixtures()
    local fixturesData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    
    -- Kita paksa batasnya menjadi 6 pertandingan saja (Matchday 1, 2, dan 3)
    -- Karena 1 Matchday terdiri dari 2 pertandingan per grup, maka 3 Matchday = 6 Match.
    local maxMatchesToShow = 6 
    
    -- 1. LOOP BERDASARKAN MATCHDAY (Loncati 2 karena 1 matchday grup = 2 pertandingan)
    for mIndex = 1, maxMatchesToShow, 2 do
        local matchdayNum = math.ceil(mIndex / 2)
        
        -- HEADER MATCHDAY
        table.insert(fixturesData, {
            data = {
                MatchDay = "MATCHDAY " .. matchdayNum,
                IsHeader = true,
                MatchScore = "",
                MatchInfo = "",
                TeamAwayName = "",
                FontColor = "0xFFD700"
            }
        })

        -- 2. LOOP SEMUA GRUP (A-H)
        for gIndex = 1, totalGroups do
            local group = self.groups[gIndex]
            local groupLetter = string.char(64 + gIndex)
            
            for i = 0, 1 do
                local currentMatchIdx = mIndex + i
                local match = group and group.matches[currentMatchIdx]

                if match then
                    local isPlayerMatch = (match.homeID == playerTeamID or match.awayID == playerTeamID)
                    local scoreText = match.isPlayed and (match.homeScore .. " - " .. match.awayScore) or "VS"
                    
                    local homeNameRaw = self.loc.LocalizeString("TeamName_Abbr15_" .. (match.homeID or 0))
                    local awayNameRaw = self.loc.LocalizeString("TeamName_Abbr15_" .. (match.awayID or 0))

                    table.insert(fixturesData, {
                        data = {
                            TeamHomeCrest = { name = "$Crest64x64", id = match.homeID },
                            TeamAwayCrest = { name = "$Crest64x64", id = match.awayID },
                            TeamHomeName = "(" .. groupLetter .. ")    " .. homeNameRaw,
                            TeamAwayName = awayNameRaw,
                            MatchScore = scoreText,
                            MatchInfo = "GROUP " .. groupLetter .. " - MATCH " .. currentMatchIdx,
                            FontColor = isPlayerMatch and "0x00FF00" or "0xFFFFFF",
                            TeamNameFontColor = isPlayerMatch and "0x00FF00" or "0x4A2C6D",
                            HomeIcon = (match.homeID == playerTeamID) and { name = "$my_team" } or nil,
                            AwayIcon = (match.awayID == playerTeamID) and { name = "$my_team" } or nil
                        }
                    })
                end
            end
        end
    end

    self.im.Publish(bndFixturesList, fixturesData)
end

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
                        TeamHomeCrest = { name = "$Crest64x64", id = match[1] },
                        TeamAwayCrest = { name = "$Crest64x64", id = match[2] },
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
                        TeamHomeCrest = { name = "$Crest64x64", id = match[1] },
                        TeamAwayCrest = { name = "$Crest64x64", id = match[2] },
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
                        TeamHomeCrest = { name = "$Crest64x64", id = match[1] },
                        TeamAwayCrest = { name = "$Crest64x64", id = match[2] },
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
                        TeamHomeCrest = { name = "$Crest64x64", id = match[1] },
                        TeamAwayCrest = { name = "$Crest64x64", id = match[2] },
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

function Standings:initializeTournament()
    self.groups = {}
    if not QuickTourGrouping or not QuickTourGrouping[tourId] then
        print("❌ Error: QuickTourGrouping data not found for tourId: " .. tourId)
        return
    end
    for g = 1, totalGroups do
        self.groups[g] = { name = "GROUP " .. string.char(64 + g), teams = {}, matches = {}, standings = {} }
    end
    local teamToGroupMap = {}
    for i, matchData in ipairs(QuickTourGrouping[tourId]) do

        if matchData[8] == true then
            local homeID, awayID = matchData[1], matchData[2]
            local groupIndex = string.byte(matchData[9]) - 64
            if self.groups[groupIndex] then
                local currentGroupData = self.groups[groupIndex]
                if not teamToGroupMap[homeID] then
                    table.insert(currentGroupData.teams, homeID)
                    teamToGroupMap[homeID] = groupIndex
                end
                if not teamToGroupMap[awayID] then
                    table.insert(currentGroupData.teams, awayID)
                    teamToGroupMap[awayID] = groupIndex
                end
                table.insert(currentGroupData.matches, {homeID = homeID, awayID = awayID, homeScore = matchData[3] or 0, awayScore = matchData[4] or 0, isPlayed = matchData[5] or false, matchIndex = i})
            end
        end
    end
    if currentTourInfo[tourId] and currentTourInfo[tourId].homeID then
        local playerTeamId = currentTourInfo[tourId].homeID
        if teamToGroupMap[playerTeamId] then
            currentGroup = teamToGroupMap[playerTeamId]
        end
    end
    print("✅ Tournament initialized. Current group: " .. currentGroup)
end

function Standings:calculateGroupStandings(group)
    local teamStats = {}
    if not group or not group.teams then return {} end
    for _, teamID in ipairs(group.teams) do
        teamStats[teamID] = { teamID = teamID, played = 0, wins = 0, draws = 0, losses = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
    end
    for _, match in ipairs(group.matches) do
        if match.isPlayed then
            local home = teamStats[match.homeID]
            local away = teamStats[match.awayID]
            if home and away then
                home.played = home.played + 1; away.played = away.played + 1
                home.goalsFor = home.goalsFor + (match.homeScore or 0); home.goalsAgainst = home.goalsAgainst + (match.awayScore or 0)
                away.goalsFor = away.goalsFor + (match.awayScore or 0); away.goalsAgainst = away.goalsAgainst + (match.homeScore or 0)
                if (match.homeScore or 0) > (match.awayScore or 0) then
                    home.wins = home.wins + 1; home.points = home.points + 3; away.losses = away.losses + 1
                elseif (match.homeScore or 0) < (match.awayScore or 0) then
                    away.wins = away.wins + 1; away.points = away.points + 3; home.losses = home.losses + 1
                else
                    home.draws = home.draws + 1; away.draws = away.draws + 1; home.points = home.points + 1; away.points = away.points + 1
                end
            end
        end
    end
    local sortedStandings = {}
    for _, stats in pairs(teamStats) do table.insert(sortedStandings, stats) end
    table.sort(sortedStandings, function(a, b)
        if a.points ~= b.points then return a.points > b.points end
        local gdA = (a.goalsFor or 0) - (a.goalsAgainst or 0); local gdB = (b.goalsFor or 0) - (b.goalsAgainst or 0)
        if gdA ~= gdB then return gdA > gdB end
        if a.goalsFor ~= b.goalsFor then return a.goalsFor > b.goalsFor end
        return a.teamID < b.teamID
    end)
    return sortedStandings
end

function Standings:publishCurrentGroupStandings()
    local uiData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0

    -- Iterasi melalui semua grup yang ada
    for gIndex = 1, totalGroups do
        local group = self.groups[gIndex]
        
        if group then
            -- Hitung klasemen untuk grup saat ini
            group.standings = self:calculateGroupStandings(group)

            -- 1. INSERT HEADER GRUP
            table.insert(uiData, {
                data = {
                    GroupName = "GROUP " .. string.char(64 + gIndex),
                    NextMatch = "",
                    IsHeader  = true,
                    FontColor = "0x0C0C0C",
                    BarisRow2 = { name = "$Baris_Row" },
                    BarisRow3 = { name = "$Baris_Row_Aseet" }
                }
            })

            -- Tambahkan 1 baris kosong setelah Header
            table.insert(uiData, { data = { IsSpacer = true, GroupName = "", TeamName = "" } })

            -- 2. LOOP DATA TIM (Baris 1-4 per grup)
            for pos, team in ipairs(group.standings) do
                local isPlayerTeam = (team.teamID == playerTeamID)
                local isAdvancing = pos <= 2
                local fontColor = isPlayerTeam and "0xFFD700" or (isAdvancing and "0x00FF00" or "0x333333")
                local goalDiff = (team.goalsFor or 0) - (team.goalsAgainst or 0)

                table.insert(uiData, {
                    data = {
                        BarisRow1 = { name = "$Baris_Row" },
                        BarisRow2 = { name = "$Baris_Rowx" },
                        BarisRow3 = { name = "$Baris_Rowx" },
                        TeamCrest = { name = "$Crest32x32", id = team.teamID },
                        TeamName  = self.loc.LocalizeString("TeamName_Abbr15_" .. (team.teamID or 0)),
                        TeamPoint = team.points,
                        Teammp    = team.played,
                        TeamWin   = team.wins,
                        TeamDraw  = team.draws,
                        TeamLoss  = team.losses,
                        TeamGA    = team.goalsFor,
                        TeamGC    = team.goalsAgainst,
                        TeamGD    = goalDiff,
                        Teampos   = pos .. ".", -- Tetap 1-4 setiap grup
                        FontColor = fontColor,
                        GroupName = "",
                        NextMatch = "-",
                        Icon = isPlayerTeam and { name = "$my_team" } or nil
                    }
                })

                -- 3. LOGIKA BARIS KOSONG
                -- Berikan 1 baris kosong setelah tim 1, 2, dan 3.
                -- Untuk tim 4 (insert grup baru), jangan kasih baris kosong agar langsung nempel ke header grup berikutnya.
                if pos < 4 then
                    table.insert(uiData, {
                        data = {
                            IsSpacer = true,
                            GroupName = "",
                            TeamName = ""
                        }
                    })
                end
            end
        end
    end

    -- Publish semua data gabungan ke binding bndGroupStandings
    self.im.Publish(bndGroupStandings, uiData)
end

function Standings:publishAllStandings()
    local standingsData = {}
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    local allTeams = {}
    for groupIndex = 1, totalGroups do
        local group = self.groups[groupIndex]
        if group then
            group.standings = self:calculateGroupStandings(group)
            for _, team in ipairs(group.standings) do table.insert(allTeams, team) end
        end
    end
    table.sort(allTeams, function(a, b)
        if a.points ~= b.points then return a.points > b.points end
        local gdA = (a.goalsFor or 0) - (a.goalsAgainst or 0); local gdB = (b.goalsFor or 0) - (b.goalsAgainst or 0)
        if gdA ~= gdB then return gdA > gdB end
        return a.goalsFor > b.goalsFor
    end)
    for pos, team in ipairs(allTeams) do
        local isPlayerTeam = (team.teamID == playerTeamID)
        table.insert(standingsData, { data = {TeamCrest = { name = "$Crest32x32", id = team.teamID },TeamName = self.loc.LocalizeString("TeamName_Abbr15_" .. (team.teamID or 0)),TeamPoint = team.points, Teammp = team.played,TeamWin = team.wins, TeamDraw = team.draws, TeamLoss = team.losses,TeamGA = team.goalsFor, TeamGC = team.goalsAgainst,Teampos = pos .. ".",FontColor = isPlayerTeam and "0xFFD700" or "0x333333",Icon = isPlayerTeam and { name = "$my_team" } or nil}})
    end
    self.im.Publish(bndStandingsList, standingsData)
end

function Standings:getWinnerTeamId()
    local winnerId = 0 -- Default jika belum ada juara
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            -- Cari pertandingan dengan label "Final" yang sudah selesai (match[5] == true)
            if match[9] == STAGE_NAMES.F and match[5] == true then
                local homeScore = match[3] or 0
                local awayScore = match[4] or 0
                
                if homeScore > awayScore then
                    winnerId = match[1] -- Home menang
                elseif awayScore > homeScore then
                    winnerId = match[2] -- Away menang
                end
                break 
            end
        end
    end
    return winnerId
end

function Standings:publishHomeInfo()
    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    local currentDate = os.date("%d %B %Y")
    local currentTime = os.date("%h %d | %I:%M %p")
    
    -- Ambil ID Tim Juara
    local winnerTeamId = self:getWinnerTeamId()
    
    local displayTitle = ""
    if winnerTeamId ~= 0 then
        local winnerName = self.loc.LocalizeString("TeamName_Abbr15_" .. winnerTeamId)
        -- Format satu baris tanpa \n
        displayTitle = "WINNER OF THE " .. tourName .. " IS " .. winnerName
    else
        -- Format satu baris tanpa \n
        displayTitle = "FINAL " .. tourName
    end
    
    -- Publish ke binding
    self.im.Publish("bnd_champions_team_name", displayTitle)

    -- Publish data lainnya tetap sama
    self.im.Publish("bnd_matchday_label", self.groups[currentGroup] and self.groups[currentGroup].name or "GROUP A")
    self.im.Publish("bnd_team_label", tourName)
    self.im.Publish("bnd_month_label", currentDate)
    self.im.Publish("bnd_realtime", tourName .. " " .. currentTime)
    
    if winnerTeamId ~= 0 then
        self.im.Publish("bnd_champions_crest", { name = "$Crest", id = winnerTeamId })
    else
        self.im.Publish("bnd_champions_crest", { name = "$CupTrophy", id = tourId })
    end

    self.im.Publish("bnd_tour_label", tourName)
    self.im.Publish("bnd_tour_trophy", { name = "$CupTrophy", id = tourId })
    self.im.Publish("bnd_bg_tour", { name = "$Bg_Cup", id = tourId })
    self.im.Publish("bnd_tour_logo", { name = "$cupLogo", id = tourId })

    self:publishGroupLabel()
end

function Standings:publishGroupLabel()
    local prevGroup = (currentGroup - 2 + totalGroups) % totalGroups + 1
    local nextGroup = currentGroup % totalGroups + 1
    self.im.Publish("bnd_group_label_current", self.groups[currentGroup] and self.groups[currentGroup].name or "GROUP A")
    self.im.Publish("bnd_group_label_prev", self.groups[prevGroup] and self.groups[prevGroup].name or "GROUP H")
    self.im.Publish("bnd_group_label_next", self.groups[nextGroup] and self.groups[nextGroup].name or "GROUP B")
end

function Standings:publishTournamentProgress()
    local progressText = "Group Stage"
    local allGroupMatchesDone = true
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for i = 1, totalGroupMatches do
            if QuickTourGrouping[tourId][i] and not QuickTourGrouping[tourId][i][5] then allGroupMatchesDone = false; break end
        end
    else
        allGroupMatchesDone = false
    end
    if allGroupMatchesDone then
        local currentStage = "Tournament Completed"
        local stageOrder = {STAGE_NAMES.F, STAGE_NAMES.SF, STAGE_NAMES.QF, STAGE_NAMES.R16}
        if QuickTourGrouping and QuickTourGrouping[tourId] then
            for _, stage in ipairs(stageOrder) do
                for _, match in ipairs(QuickTourGrouping[tourId]) do
                    if match[9] == stage and not match[5] then currentStage = stage; break end
                end
                if currentStage ~= "Tournament Completed" then break end
            end
        end
        progressText = currentStage
    end
    self.im.Publish(bndInfoProgres, progressText)
end

function Standings:NextGroup()
    currentGroup = currentGroup % totalGroups + 1
    self:publishCurrentGroupFixtures()
    self:publishGroupLabel()
end

function Standings:PrevGroup()
    currentGroup = (currentGroup - 2 + totalGroups) % totalGroups + 1
    self:publishCurrentGroupFixtures()
    self:publishGroupLabel()
end

function Standings:finalize()
    local subsToClean = {BND_COLOR_CUPID,BND_COLOR_CUPID2, bndStandingsList, bndFixturesList, bndGroupStandings,bndRound16Fixtures, bndQuarterFixtures, bndSemiFixtures, bndFinalFixture,bndInfoProgres, "bnd_matchday_label", "bnd_team_label", "bnd_month_label","bnd_realtime", "bnd_tour_label", "bnd_champions_team_name", "bnd_bg_tour", "bnd_tour_logo","bnd_tour_trophy","bnd_champions_crest","bnd_group_label_current", "bnd_group_label_next", "bnd_group_label_prev"}
    for _, s in ipairs(subsToClean) do self.im.Unsubscribe(s) end
    self.im.UnregisterAction("act_next_group")
    self.im.UnregisterAction("act_prev_group")
    print("✅ Standings module finalized")
end

return Standings