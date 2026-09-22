-- CustomCup By Mounsta
-- Patch Mod InisialA (SaveTur & Sistem)
-- Rober fl
-- BillzYt

local TabModel = ...
MatchSelect = {}

local BND_COLOR_CUPID = "bnd_color_tourid" 
local BND_ADS_A_VISIBLE = "bnd_ads_a_visible"
local BND_ADS_B_VISIBLE = "bnd_ads_b_visible"
local BND_BUSY_STATE_VISIBLE = "bnd_busy_state_visible"
local BND_LAST_MATCH_RESULT = "bnd_last_match_result"
local BND_HUB_ACTIONS_VISIBLE = "bnd_hub_actions_visible"
local ACT_ADVANCE = "act_advance"
local ACT_RESTART = "act_restart"
local ACT_BELUM = "act_belum"
local BND_REALTIME = "bnd_realtime"
local BND_DATE = "bnd_date"
local BND_CURRENT_ROUND = "bnd_current_round"
local BND_PANEL_LOADING = "bnd_panel_loading"
local BND_DYNAMIC_TEXT = "bnd_dynamic_label" -- Binding untuk teks dinamis mode aktif (L / K / G)

local currentSimulationPhase = 0
local matchesToSimulate = {}
local bndList = {}
local currentMatchIndex = 1
local tournamentConfig = { useUCLStyle = true, isLeague = false }

currentMatch = { HomeTeamID = 0, AwayTeamID = 0, HomeKitIndex = 0, AwayKitIndex = 1}
QuickTourGrouping = QuickTourGrouping or {}
GroupStandings = GroupStandings or {}
currentTourInfo = currentTourInfo or {}
currentTourData = currentTourData or {}
TeamPlayerCache = TeamPlayerCache or {}
currentPlayedMatchIndex = nil
GOALS = GOALS or {}
TournamentStats = TournamentStats or {}
LeagueStandings = LeagueStandings or {}
SavedTrophyData = SavedTrophyData or {} 
SavedTrophyClaimed = SavedTrophyClaimed or {} 

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

function MatchSelect:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    local tourId = GlobalTournamentSettings.tourId or 1
    o.services = {
        FifaCustomizationService = o.api("FifaCustomizationService"),
        MatchSetup = o.api("MatchSetupService"),
        settingsService = o.api("SettingsService"),
        GameSetup = o.api("GameSetupService"),
        SquadManagementService = o.api("SquadMgtService"),
        gameState = o.api("GameStateService"),
        EventManagerService = o.api("EventManagerService"),
        SocialService = o.api("SocialService")
    }
	
    o.isAdsVisible = true
    o.simulationDelayTimer = nil
    o.isSimulatingWithDelay = false
    o.currentOptions = o.services.settingsService.GetCurrentOptions()
    
    for i = 1, 62 do
        bndList[i] = "bnd_team" .. i .. "_score"
        bndList[i + 62] = "bnd_team" .. i .. "_crest"
    end
    
    currentTourInfo[tourId] = currentTourInfo[tourId] or { homeID = 0 }
    local tournamentDisplayName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
    
    o.tourData = {
        tourBg = { name = "$Bg_Cup", id = tourId },
        tourlogo = { name = "$CustomLogo", id = tourId },
        trophy = { name = "$CustomTrophy", id = tourId },
        championCrest = { name = crestName, id = 0 },
        isFinish = false, 
        Round = ""
    }
    
    o.settings = GlobalTournamentSettings or {}
    o.totalGroups = o.settings.totalGroups or 12
    o.teamsPerGroup = o.settings.teamsPerGroup or 4
    o.teamCount = o.settings.teamCount or 32
    o.matchdaysPerGroup = o.settings.matchdaysPerGroup or 6
    o.isLeagueMode = o.settings.isLeagueMode or false
    
    o:setupSubscriptions()
    o:setupActions()
    o.im.Publish("bnd_match_visible", true)
    
    o.isSimulating = false
    o._trophySaved = false 
    currentSimulationPhase = 0
    matchesToSimulate = {}
    currentMatchIndex = 1
    o.simulationInProgress = false

    local isTourFinished = true
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            if not match[5] then 
                isTourFinished = false
                break
            end
        end
    else
        isTourFinished = false
    end

    if not isTourFinished then
        SavedTrophyClaimed = {} 
    else
        o._trophySaved = false 
    end

    o:InitOptions()
    o:UpdateModeLabelText()

    return o
end

function MatchSelect:UpdateModeLabelText()
    local labelText = "T" -- Default Group + Knockout
    if self.isLeagueMode then
        labelText = "L" -- League
    elseif self.settings and self.settings.isKnockoutOnly then
        labelText = "T" -- Knockout Only
    end
    self.im.Publish(BND_DYNAMIC_TEXT, labelText)
end

function MatchSelect:GetKnockoutWinners(group, roundName)
    local matchups = {}
    local isComplete = true
    
    for _, m in ipairs(group) do
        if m[9] == roundName then
            if not m[5] then isComplete = false end
            local t1, t2 = m[1], m[2]
            local key = (t1 < t2) and (t1 .. "_" .. t2) or (t2 .. "_" .. t1)
            
            if not matchups[key] then matchups[key] = {tA = t1, tB = t2, sA = 0, sB = 0, matchesPlayed = 0} end
            
            if m[5] then
                matchups[key].matchesPlayed = matchups[key].matchesPlayed + 1
                if m[1] == matchups[key].tA then 
                    matchups[key].sA = matchups[key].sA + m[3]
                    matchups[key].sB = matchups[key].sB + m[4]
                else
                    matchups[key].sA = matchups[key].sA + m[4]
                    matchups[key].sB = matchups[key].sB + m[3]
                end
                matchups[key].lastWinner = m[6] 
            end
        end
    end

    local winners = {}
    if not isComplete then return winners, false end

    for _, pair in pairs(matchups) do
        if pair.sA > pair.sB then 
            table.insert(winners, pair.tA)
        elseif pair.sB > pair.sA then 
            table.insert(winners, pair.tB)
        else
            if pair.lastWinner and pair.lastWinner ~= 0 then 
                table.insert(winners, pair.lastWinner)
            else
                table.insert(winners, (math.random(1,2) == 1) and pair.tA or pair.tB)
            end
        end
    end
    
    return winners, true
end

function MatchSelect:InitializeLeagueStandings()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not self.isLeagueMode then return end
    
    if not LeagueStandings[tourId] then
        LeagueStandings[tourId] = {}
        if QuickTourGrouping[tourId] then
            local teamsInitialized = {}
            for _, match in ipairs(QuickTourGrouping[tourId]) do
                if match[9] == "LEAGUE" then
                    if not teamsInitialized[match[1]] then
                        LeagueStandings[tourId][match[1]] = { teamId = match[1], played = 0, wins = 0, draws = 0, losses = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
                        teamsInitialized[match[1]] = true
                    end
                    if not teamsInitialized[match[2]] then
                        LeagueStandings[tourId][match[2]] = { teamId = match[2], played = 0, wins = 0, draws = 0, losses = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
                        teamsInitialized[match[2]] = true
                    end
                end
            end
        end
    end
end

function MatchSelect:InitOptions()
    local tourId = GlobalTournamentSettings.tourId or 1
    local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
    
    if not QuickTourGrouping or not QuickTourGrouping[tourId] then 
        for i = 1, 124 do
            self.im.Publish("bnd_team"..i.."_crest", { name = crestName, id = 0 })
            self.im.Publish("bnd_team"..i.."_score", "0")
        end
        return 
    end
    
    if self.isLeagueMode then
        if LeagueStandings[tourId] and next(LeagueStandings[tourId]) then
            local teamList = {}
            for teamId, stats in pairs(LeagueStandings[tourId]) do
                table.insert(teamList, { teamId = teamId, stats = stats })
            end
            
            table.sort(teamList, function(a, b)
                if a.stats.points ~= b.stats.points then return a.stats.points > b.stats.points end
                local gdA = a.stats.goalsFor - a.stats.goalsAgainst
                local gdB = b.stats.goalsFor - b.stats.goalsAgainst
                if gdA ~= gdB then return gdA > gdB end
                return a.stats.goalsFor > b.stats.goalsFor
            end)
            
            for k = 1, #teamList do
                local team = teamList[k]
                local i = (k - 1) * 2 + 1
                self.im.Publish("bnd_team" .. i .. "_crest", { name = crestName, id = team.teamId })
                self.im.Publish("bnd_team" .. i .. "_score", tostring(team.stats.points))
                
                if k < #teamList then
                    local nextTeam = teamList[k + 1]
                    self.im.Publish("bnd_team" .. (i + 1) .. "_crest", { name = crestName, id = nextTeam.teamId })
                    self.im.Publish("bnd_team" .. (i + 1) .. "_score", tostring(nextTeam.stats.points))
                else
                    self.im.Publish("bnd_team" .. (i + 1) .. "_crest", { name = crestName, id = 0 })
                    self.im.Publish("bnd_team" .. (i + 1) .. "_score", "0")
                end
            end
        else
            for i = 1, 124 do
                self.im.Publish("bnd_team"..i.."_crest", { name = crestName, id = 0 })
                self.im.Publish("bnd_team"..i.."_score", "0")
            end
        end
        return
    end
    
    local g = QuickTourGrouping[tourId]
    for k = 1, #g do
        local m = g[k]
        local i = (k - 1) * 2 + 1
        self.im.Publish("bnd_team" .. i .. "_crest", { name = crestName, id = m[1] })
        self.im.Publish("bnd_team" .. i .. "_score", tostring(m[3]))
        self.im.Publish("bnd_team" .. (i + 1) .. "_crest", { name = crestName, id = m[2] })
        self.im.Publish("bnd_team" .. (i + 1) .. "_score", tostring(m[4]))
    end
    
    if #g > 0 then
        local final = g[#g]
        if final and final[9] == "Final" and final[5] then
            local winners, complete = self:GetKnockoutWinners(g, "Final")
            if complete and #winners > 0 then
                self.tourData.championCrest.id = winners[1]
                self.tourData.isFinish = true
                self:publishChampion()
            end
        else
            self.tourData.isFinish = false
            self.tourData.championCrest.id = 0
        end
    end
end

function MatchSelect:setupSubscriptions()
    local tourId = GlobalTournamentSettings.tourId or 1
    local tournamentDisplayName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    
	self.im.Subscribe(BND_PANEL_LOADING, function(isVisible) end)
    self.im.Subscribe(BND_DYNAMIC_TEXT, function() self:UpdateModeLabelText() end)
    
    self.im.Subscribe(BND_COLOR_CUPID, function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        local color = tourIdToColorMap[currentTourId] or tourIdToColorMap.default
        self.im.Publish(BND_COLOR_CUPID, color)
    end)

	self.im.Subscribe(BND_CURRENT_ROUND, function() 
        local round = "Group Stage"
        local tourId = GlobalTournamentSettings.tourId or 1
        if QuickTourGrouping[tourId] then
            for i = #QuickTourGrouping[tourId], 1, -1 do
                local match = QuickTourGrouping[tourId][i]
                if match[7] then round = match[9]; break end
            end
        end
        self.im.Publish(BND_CURRENT_ROUND, round)
	end)
    
    self.im.Subscribe(BND_BUSY_STATE_VISIBLE, function(isVisible) end)
    self.im.Subscribe("bnd_bg_tour", function() self.im.Publish("bnd_bg_tour", self.tourData.tourBg) end)
    self.im.Subscribe("bnd_tour_logo", function() self.im.Publish("bnd_tour_logo", self.tourData.tourlogo) end)
    self.im.Subscribe("bnd_trophy", function() self.im.Publish("bnd_trophy", self.tourData.trophy) end)
    
    self.Banner = { name = "$_Ads_Insta", id = math.random(4) }
    self.im.Subscribe("bnd_last_match_result", function() self:publishMatchInfo() end)
    self.im.Subscribe("bnd_ads", function() self.im.Publish("bnd_ads", self.Banner) end)
    self.im.Subscribe(BND_REALTIME, function() self.im.Publish(BND_REALTIME, os.date(tournamentDisplayName .. " %h %d | %I:%M %p")) end)
    self.im.Subscribe("bnd_date", function()
        local currentDate = os.date("%A, %b %d")
        self.im.Publish("bnd_date", currentDate)
    end)
    
    self.im.Subscribe("bnd_home_score", function() self:publishMatchInfo() end)
    self.im.Subscribe("bnd_away_score", function() self:publishMatchInfo() end)
    self.im.Subscribe("bnd_tour_label", function() self:publishMatchInfo() end)
    self.im.Subscribe(BND_ADS_A_VISIBLE, function() self.im.Publish(BND_ADS_A_VISIBLE, self.isAdsVisible) end)
    self.im.Subscribe(BND_ADS_B_VISIBLE, function() self.im.Publish(BND_ADS_B_VISIBLE, not self.isAdsVisible) end)
    
    for _, v in ipairs(bndList) do self.im.Subscribe(v, function() self:InitOptions() end) end
    for _, k in ipairs({ "bnd_match_visible", "bnd_home_crest", "bnd_away_crest", "bnd_home_team", "bnd_away_team","bnd_group_label", "bnd_home_team_short", "bnd_away_team_short", "bnd_team_crest", "bnd_team_name" }) do self.im.Subscribe(k, function() self:publishMatchInfo() end) end
    
    for _, k in ipairs({
        "bnd_text", "bnd_champion_visible", "bnd_champion_crest", "bnd_champion_team", 
        "bnd_champion_scorer", "bnd_champion_scorer_head", "bnd_champion_scorer_name", 
        "bnd_champion_scorer_flag", "bnd_champion_scorer_pos", "bnd_champion_scorer_ovr"
    }) do 
        self.im.Subscribe(k, function() self:publishChampion() end) 
    end
end

function MatchSelect:setupActions()
    self.im.RegisterAction(ACT_ADVANCE, function() self:PlayMatch() end)
    self.im.RegisterAction(ACT_RESTART, function() self:PlayReStart() end)
    self.im.RegisterAction(ACT_BELUM, function() self:Belum() end)

    self.im.RegisterAction("act_simulate", function()
        if self.simulationInProgress then return end
        self.simulationInProgress = true

        local tourId = GlobalTournamentSettings.tourId or 1
        local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID
        local group = QuickTourGrouping[tourId]
        
        if not group or not userTeamId then
            self.simulationInProgress = false
            return
        end
        
        local userMatchIndex = nil
        local isLeagueMatch = false
        local isKnockoutMatch = false
        
        for i, match in ipairs(group) do
            if not match[5] and (match[1] == userTeamId or match[2] == userTeamId) then
                userMatchIndex = i
                isLeagueMatch = (match[9] == "LEAGUE")
                isKnockoutMatch = match[7]
                break
            end
        end
        
        if not userMatchIndex then
            self.simulationInProgress = false
            self:InitOptions()
            self:publishMatchInfo()
            return
        end

        local userMatch = group[userMatchIndex]
        
        if self.isLeagueMode and isLeagueMatch then
            self:InitializeLeagueStandings()
            local matchday = userMatch[10]
            
            TournamentStats[tourId] = TournamentStats[tourId] or { Goals = {}, Assists = {}, Appearances = {}, YellowCards = {}, RedCards = {} }
            TeamPlayerCache[tourId] = TeamPlayerCache[tourId] or {}
            
            for _, match in ipairs(group) do
                if match[9] == "LEAGUE" and match[10] == matchday and not match[5] then
                    local scores = self:GetTeamRealScore(match[1], match[2], true)
                    match[3], match[4], match[5] = scores[match[1]], scores[match[2]], true
                    match[6] = (match[3] > match[4]) and match[1] or (match[4] > match[3]) and match[2] or 0
                    
                    self:DistributeSimulatedGoals(match[1], match[3])
                    self:DistributeSimulatedGoals(match[2], match[4])
                    self:UpdateLeagueStandings(match[1], match[2], match[3], match[4])
                end
            end
            self:SaveMatchResult()
            
            if self:CheckLeagueCompletion() then
                local ranking = {}
                for _, teamStats in pairs(LeagueStandings[tourId]) do table.insert(ranking, teamStats) end
                
                table.sort(ranking, function(a, b)
                    if a.points ~= b.points then return a.points > b.points end
                    local gdA, gdB = a.goalsFor - a.goalsAgainst, b.goalsFor - b.goalsAgainst
                    if gdA ~= gdB then return gdA > gdB end
                    return a.goalsFor > b.goalsFor
                end)
                
                if ranking[1] then
                    self.tourData.championCrest.id = ranking[1].teamId
                    self.tourData.isFinish = true
                end
            end

        elseif isKnockoutMatch then
            local currentRound = userMatch[9]
            local currentLeg = userMatch[10] 
            
            for i, match in ipairs(group) do
                if match[9] == currentRound and match[10] == currentLeg and not match[5] then
                    self:SimulateKnockoutMatch(i)
                end
            end
            
            local winners, complete = self:GetKnockoutWinners(group, currentRound)
            if complete and #winners > 0 then 
                self:GenerateNextKnockoutRound(winners) 
            end
        else
            local matchday = userMatch[10]
            for _, match in ipairs(group) do
                if match[8] and match[10] == matchday and not match[5] then
                    local scores = self:GetTeamRealScore(match[1], match[2], true)
                    match[3], match[4], match[5] = scores[match[1]], scores[match[2]], true
                    match[6] = (match[3] > match[4]) and match[1] or (match[4] > match[3]) and match[2] or 0
                    
                    self:DistributeSimulatedGoals(match[1], match[3])
                    self:DistributeSimulatedGoals(match[2], match[4])
                end
            end
            self:SaveMatchResult()
            
            local isLastGroupMatch = true
            for _, m in ipairs(group) do
                if m[8] and not m[5] then isLastGroupMatch = false; break end
            end
            if isLastGroupMatch then self:GenerateKnockoutFromGroupStandings() end
        end

        self:InitOptions()
        self:publishMatchInfo()
        self.simulationInProgress = false
    end)
    
    self.im.RegisterAction("act_ads", function()
        self.isAdsVisible = not self.isAdsVisible
        self.im.Publish(BND_ADS_A_VISIBLE, self.isAdsVisible)
        self.im.Publish(BND_ADS_B_VISIBLE, not self.isAdsVisible)
    end)
end

function MatchSelect:UpdateLeagueStandings(homeId, awayId, homeScore, awayScore)
    local tourId = GlobalTournamentSettings.tourId or 1
    if not LeagueStandings[tourId] then return end
    
    local lsHome = LeagueStandings[tourId][homeId]
    local lsAway = LeagueStandings[tourId][awayId]
    if not lsHome or not lsAway then return end
    
    lsHome.played, lsAway.played = lsHome.played + 1, lsAway.played + 1
    lsHome.goalsFor, lsHome.goalsAgainst = lsHome.goalsFor + homeScore, lsHome.goalsAgainst + awayScore
    lsAway.goalsFor, lsAway.goalsAgainst = lsAway.goalsFor + awayScore, lsAway.goalsAgainst + homeScore
    
    if homeScore > awayScore then
        lsHome.wins, lsHome.points, lsAway.losses = lsHome.wins + 1, lsHome.points + 3, lsAway.losses + 1
    elseif awayScore > homeScore then
        lsAway.wins, lsAway.points, lsHome.losses = lsAway.wins + 1, lsAway.points + 3, lsHome.losses + 1
    else
        lsHome.draws, lsAway.draws, lsHome.points, lsAway.points = lsHome.draws + 1, lsAway.draws + 1, lsHome.points + 1, lsAway.points + 1
    end
end

function MatchSelect:CheckLeagueCompletion()
    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    if not group then return false end
    
    local leagueMatches, leaguePlayed = 0, 0
    for _, match in ipairs(group) do
        if match[9] == "LEAGUE" then
            leagueMatches = leagueMatches + 1
            if match[5] then leaguePlayed = leaguePlayed + 1 end
        end
    end
    
    if leaguePlayed == leagueMatches and leagueMatches > 0 then
        if LeagueStandings[tourId] then
            local expectedPlayed = -1
            for _, stats in pairs(LeagueStandings[tourId]) do
                if expectedPlayed == -1 then
                    expectedPlayed = stats.played
                elseif stats.played ~= expectedPlayed then
                    return false
                end
            end
        end
        return true
    end
    
    return false
end

function MatchSelect:GenerateKnockoutFromLeague()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not LeagueStandings[tourId] then return end
    
    local ranking = {}
    for _, teamStats in pairs(LeagueStandings[tourId]) do table.insert(ranking, teamStats) end
    
    table.sort(ranking, function(a, b)
        if a.points ~= b.points then return a.points > b.points end
        local gdA, gdB = a.goalsFor - a.goalsAgainst, b.goalsFor - b.goalsAgainst
        if gdA ~= gdB then return gdA > gdB end
        return a.goalsFor > b.goalsFor
    end)
    
    local qualifiedTeams = {}
    for i = 1, 16 do if ranking[i] then table.insert(qualifiedTeams, ranking[i].teamId) end end
    
    self:ShuffleArray(qualifiedTeams)
    
    local isTwoLegs = GlobalTournamentSettings and GlobalTournamentSettings.isTwoLegs or false
    for i = 1, #qualifiedTeams, 2 do
        if qualifiedTeams[i] and qualifiedTeams[i+1] then
            table.insert(QuickTourGrouping[tourId], { qualifiedTeams[i], qualifiedTeams[i+1], 0, 0, false, 0, true, false, "Round of 16", 1 })
            if isTwoLegs then
                table.insert(QuickTourGrouping[tourId], { qualifiedTeams[i+1], qualifiedTeams[i], 0, 0, false, 0, true, false, "Round of 16", 2 })
            end
        end
    end
end

function MatchSelect:SimulateAllGroupMatches()
    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    if not group then return end
    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID
    if not userTeamId then return end
    
    local userCompletedMatchdays = 0
    for _, match in ipairs(group) do
        if match[8] and match[5] and (match[1] == userTeamId or match[2] == userTeamId) then
            userCompletedMatchdays = math.max(userCompletedMatchdays, match[10])
        end
    end
    
    local maxIterations = 500
    local iteration = 0
    while iteration < maxIterations do
        iteration = iteration + 1
        local foundMatch = false
        for _, match in ipairs(group) do
            if match[8] and not match[5] then
                local homePlayedCount, awayPlayedCount = 0, 0
                for _, m in ipairs(group) do
                    if m[8] and m[5] then
                        if m[1] == match[1] then homePlayedCount = homePlayedCount + 1 end
                        if m[2] == match[2] then awayPlayedCount = awayPlayedCount + 1 end
                    end
                end
                if homePlayedCount == awayPlayedCount and homePlayedCount <= userCompletedMatchdays then
                    if match[1] ~= userTeamId and match[2] ~= userTeamId then
                        local scores = self:GetTeamRealScore(match[1], match[2], true)
                        match[3], match[4], match[5] = scores[match[1]], scores[match[2]], true
                        match[6] = (match[3] > match[4] and match[1]) or (match[4] > match[3] and match[2]) or 0
                        
                        self:DistributeSimulatedGoals(match[1], match[3])
                        self:DistributeSimulatedGoals(match[2], match[4])
                        foundMatch = true
                        break
                    end
                end
            end
        end
        if not foundMatch then break end
    end
    self:SaveMatchResult()
end

function MatchSelect:OnUserMatchEnd(statsPackage)
    if not currentPlayedMatchIndex then return end
    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    local match = group[currentPlayedMatchIndex]

    match[3] = statsPackage.homeScore
    match[4] = statsPackage.awayScore
    match[5] = true
    if match[3] > match[4] then match[6] = match[1] elseif match[4] > match[3] then match[6] = match[2] else match[6] = 0 end

    local homeTeamId, awayTeamId = match[1], match[2]
    currentPlayedMatchIndex = nil

    if self.isLeagueMode and match[9] == "LEAGUE" then
        self:InitializeLeagueStandings()
        self:UpdateLeagueStandings(homeTeamId, awayTeamId, match[3], match[4])
        
        if self:CheckLeagueCompletion() then
            local ranking = {}
            for _, teamStats in pairs(LeagueStandings[tourId]) do table.insert(ranking, teamStats) end
            
            table.sort(ranking, function(a, b)
                if a.points ~= b.points then return a.points > b.points end
                local gdA, gdB = a.goalsFor - a.goalsAgainst, b.goalsFor - b.goalsAgainst
                if gdA ~= gdB then return gdA > gdB end
                return a.goalsFor > b.goalsFor
            end)
            
            if ranking[1] then
                self.tourData.championCrest.id = ranking[1].teamId
                self.tourData.isFinish = true
            end
        end
    end

    self:SaveMatchResult()
    local matchday = match[10]
    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID
    
    if match[8] then
        for _, m in ipairs(group) do
            if m[8] and m[10] == matchday and not m[5] then
                if m[1] ~= userTeamId and m[2] ~= userTeamId then
                    local scores = self:GetTeamRealScore(m[1], m[2], true)
                    m[3], m[4], m[5] = scores[m[1]], scores[m[2]], true
                    m[6] = (m[3] > match[4]) and m[1] or (m[4] > m[3]) and m[2] or 0
                    
                    self:DistributeSimulatedGoals(m[1], m[3])
                    self:DistributeSimulatedGoals(m[2], m[4])
                end
            end
        end
    end

    self:InitOptions()
    self:publishMatchInfo()
end

function MatchSelect:OnMatchEnd(stats)
    if not currentPlayedMatchIndex then return end
    local tourId = GlobalTournamentSettings.tourId or 1
    local g = QuickTourGrouping[tourId]
    local m = g[currentPlayedMatchIndex]
    
    m[3] = stats.HomeScore
    m[4] = stats.AwayScore
    m[5] = true
    m[6] = (stats.HomeScore > stats.AwayScore) and m[1] or (stats.AwayScore > stats.HomeScore) and m[2] or 0

    currentPlayedMatchIndex = nil
    self:SimulateAllGroupMatches()
    self:InitOptions()
    self:publishMatchInfo()
end

function MatchSelect:SaveTrophyData(tourId, teamId)
    if not tourId or tourId == 0 or not teamId or teamId == 0 then return end
    
    SavedTrophyData = SavedTrophyData or {}
    
    local sTeamId = tostring(teamId)
    local sTourId = tostring(tourId)
    
    SavedTrophyData[sTeamId] = SavedTrophyData[sTeamId] or {
        totalTeamTrophies = 0,
        tournaments = {}
    }
    
    SavedTrophyData[sTeamId].tournaments[sTourId] = SavedTrophyData[sTeamId].tournaments[sTourId] or 0
    SavedTrophyData[sTeamId].tournaments[sTourId] = SavedTrophyData[sTeamId].tournaments[sTourId] + 1
    
    local calculatedTotal = 0
    for _, count in pairs(SavedTrophyData[sTeamId].tournaments) do
        calculatedTotal = calculatedTotal + count
    end
    SavedTrophyData[sTeamId].totalTeamTrophies = calculatedTotal
end

function MatchSelect:publishChampion()
    local tourId = GlobalTournamentSettings.tourId or 1

    if self.tourData and self.tourData.isFinish and self.tourData.championCrest.id ~= 0 then
        local championId = self.tourData.championCrest.id

        SavedTrophyClaimed = SavedTrophyClaimed or {}
        local claimKey = tostring(tourId) .. "_" .. tostring(championId)

        if not self._trophySaved and not SavedTrophyClaimed[claimKey] then
            self:SaveTrophyData(tourId, championId)
            SavedTrophyClaimed[claimKey] = true 
            self._trophySaved = true
        end

        local topScorer = nil
        local maxGoals = -1
        local maxRating = -1

        TournamentStats[tourId] = TournamentStats[tourId] or { Goals = {} }
        TeamPlayerCache[tourId] = TeamPlayerCache[tourId] or {}

        for teamID, players in pairs(TeamPlayerCache[tourId]) do
            for _, player in ipairs(players) do
                if player and player.CARD_ID then
                    local g = TournamentStats[tourId].Goals[player.CARD_ID] or 0
                    local r = player.rating or 0

                    if (g > maxGoals) or (g == maxGoals and r > maxRating) then
                        maxGoals = g
                        maxRating = r
                        topScorer = player
                    end
                end
            end
        end

        local topScorerName = topScorer and topScorer.playerName or "-"
        local topScorerCardId = topScorer and topScorer.CARD_ID or 0
        local topScorerNationality = topScorer and topScorer.nationalityID or 0
        local topScorerPosition = topScorer and topScorer.position or "ST"
        local topScorerRating = topScorer and topScorer.rating or 0

        local scorerText = (maxGoals > 0) and ("Golden Boot Winner: " .. topScorerName .. " (" .. maxGoals .. " Goals)") or "Golden Boot Winner: - (0 Goals)"
        local championTitle = self.isLeagueMode and "LEAGUE CHAMPION" or "TOURNAMENT CHAMPION"

        self.im.Publish("bnd_champion_visible", true)
        self.im.Publish("bnd_match_visible", false)
        self.im.Publish(BND_HUB_ACTIONS_VISIBLE, false)
        self.im.Publish(BND_PANEL_LOADING, false)

        self.im.Publish("bnd_text", championTitle)
        self.im.Publish("bnd_champion_crest", self.tourData.championCrest)
        self.im.Publish("bnd_champion_team", self.loc.LocalizeString("TeamName_Abbr15_" .. championId))
        self.im.Publish("bnd_champion_scorer", scorerText)

        if topScorerCardId ~= 0 then
            self.im.Publish("bnd_champion_scorer_head", { name = "$Head", id = topScorerCardId })
            self.im.Publish("bnd_champion_scorer_name", topScorerName)
            self.im.Publish("bnd_champion_scorer_flag", { name = "$Flag128x128", id = topScorerNationality })
            self.im.Publish("bnd_champion_scorer_pos", topScorerPosition)
            self.im.Publish("bnd_champion_scorer_ovr", tostring(topScorerRating))
        else
            self.im.Publish("bnd_champion_scorer_head", nil)
            self.im.Publish("bnd_champion_scorer_name", "-")
            self.im.Publish("bnd_champion_scorer_flag", {})
            self.im.Publish("bnd_champion_scorer_pos", "")
            self.im.Publish("bnd_champion_scorer_ovr", "")
        end

        self.im.Publish("bnd_home_crest", nil)
        self.im.Publish("bnd_away_crest", nil)
        self.im.Publish("bnd_home_team", "")
        self.im.Publish("bnd_away_team", "")
        self.im.Publish("bnd_home_team_short", "")
        self.im.Publish("bnd_away_team_short", "")
        self.im.Publish(BND_LAST_MATCH_RESULT, "Tournament Completed")
    else
        self.im.Publish("bnd_champion_visible", false)
    end
end

function MatchSelect:publishMatchInfo()
    local tourId = GlobalTournamentSettings.tourId or 1
    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
    
    self:UpdateModeLabelText()

    local g = QuickTourGrouping[tourId]
    if self.isLeagueMode and g then
        local leagueCompleted = true
        local leagueMatches = 0
        local tempStandings = {}
        
        for _, match in ipairs(g) do
            if match[9] == "LEAGUE" then
                leagueMatches = leagueMatches + 1
                local hId, aId = match[1], match[2]
                if not tempStandings[hId] then tempStandings[hId] = {teamId = hId, points = 0, goalsFor = 0, goalsAgainst = 0} end
                if not tempStandings[aId] then tempStandings[aId] = {teamId = aId, points = 0, goalsFor = 0, goalsAgainst = 0} end
                
                if not match[5] then 
                    leagueCompleted = false 
                else
                    local hScore, aScore = match[3], match[4]
                    tempStandings[hId].goalsFor = tempStandings[hId].goalsFor + hScore
                    tempStandings[hId].goalsAgainst = tempStandings[hId].goalsAgainst + aScore
                    tempStandings[aId].goalsFor = tempStandings[aId].goalsFor + aScore
                    tempStandings[aId].goalsAgainst = tempStandings[aId].goalsAgainst + hScore
                    
                    if hScore > aScore then tempStandings[hId].points = tempStandings[hId].points + 3
                    elseif aScore > hScore then tempStandings[aId].points = tempStandings[aId].points + 3
                    else
                        tempStandings[hId].points = tempStandings[hId].points + 1
                        tempStandings[aId].points = tempStandings[aId].points + 1
                    end
                end
            end
        end
        
        if leagueCompleted and leagueMatches > 0 then
            local ranking = {}
            for _, stats in pairs(tempStandings) do table.insert(ranking, stats) end
            table.sort(ranking, function(a, b)
                if a.points ~= b.points then return a.points > b.points end
                local gdA, gdB = a.goalsFor - a.goalsAgainst, b.goalsFor - b.goalsAgainst
                if gdA ~= gdB then return gdA > gdB end
                return a.goalsFor > b.goalsFor
            end)
            if ranking[1] then
                self.tourData.championCrest.id = ranking[1].teamId
                self.tourData.isFinish = true
            end
        end
    end

    if self.tourData.isFinish then 
        self:publishChampion() 
        return 
    end
    
    self.im.Publish(BND_PANEL_LOADING, true)
    if not QuickTourGrouping or not QuickTourGrouping[tourId] or not currentTourInfo[tourId] then
        self.im.Publish("bnd_text", "Loading tournament data...")
        self.im.Publish(BND_PANEL_LOADING, false)
        return
    end

    local g = QuickTourGrouping[tourId]
    local userTeamId = currentTourInfo[tourId].homeID or 0
    self.im.Publish("bnd_team_crest", { name = crestName, id = userTeamId })
    self.im.Publish("bnd_team_name", self.loc.LocalizeString("TeamName_Abbr15_" .. userTeamId))

    local nextMatchFound = false
    
    for _, match in ipairs(g) do
        if not match[5] and (match[1] == userTeamId or match[2] == userTeamId) then
            local roundName = match[9]
            if self.isLeagueMode or roundName == "LEAGUE" then
                self.im.Publish("bnd_text", "LEAGUE - Matchday " .. (match[10] or "1"))
            elseif match[7] then
                self.im.Publish("bnd_text", roundName)
            elseif match[8] then
                self.im.Publish("bnd_text", "Group Stage - Group " .. roundName)
            end            

            self.im.Publish("bnd_match_visible", true)
            self.im.Publish(BND_HUB_ACTIONS_VISIBLE, false)
            self.im.Publish("bnd_home_crest", { name = crestName, id = match[1] })
            self.im.Publish("bnd_away_crest", { name = crestName, id = match[2] })
            self.im.Publish("bnd_home_team", self.loc.LocalizeString("TeamName_Abbr15_" .. match[1]))
            self.im.Publish("bnd_away_team", self.loc.LocalizeString("TeamName_Abbr15_" .. match[2]))
            
            nextMatchFound = true
            self.im.Publish(BND_PANEL_LOADING, false)
            self.im.Publish("bnd_tour_label", tourName)
            break
        end
    end

    if not nextMatchFound then
        local knockoutRounds = {}
        for _, match in ipairs(g) do
            if match[7] then
                if not knockoutRounds[match[9]] then
                    knockoutRounds[match[9]] = { name = match[9], total = 0, played = 0, matches = {} }
                end
                knockoutRounds[match[9]].total = knockoutRounds[match[9]].total + 1
                if match[5] then knockoutRounds[match[9]].played = knockoutRounds[match[9]].played + 1 end
                table.insert(knockoutRounds[match[9]].matches, match)
            end
        end
        
        local roundOrder = {"Round of 32", "Round of 16", "Quarter-Finals", "Quarter Finals", "Semi-Finals", "Final"}
        for _, roundName in ipairs(roundOrder) do
            if knockoutRounds[roundName] then
                local roundData = knockoutRounds[roundName]
                if roundData.played == roundData.total and roundData.total > 0 then
                    local nextRoundName = ""
                    if roundName == "Round of 32" then nextRoundName = "Round of 16"
                    elseif roundName == "Round of 16" then nextRoundName = "Quarter-Finals"
                    elseif roundName == "Quarter-Finals" or roundName == "Quarter Finals" then nextRoundName = "Semi-Finals"
                    elseif roundName == "Semi-Finals" then nextRoundName = "Final"
                    end
                    
                    if nextRoundName ~= "" then
                        local nextRoundExists = false
                        for _, m in ipairs(g) do
                            if m[9] == nextRoundName then nextRoundExists = true; break end
                        end
                        
                        if not nextRoundExists then
                            local winners, complete = self:GetKnockoutWinners(g, roundName)
                            if complete and #winners > 0 then
                                self:GenerateNextKnockoutRound(winners)
                                self:InitOptions()
                                self:publishMatchInfo()
                                return
                            end
                        end
                    end
                end
            end
        end
        
        local allGroupMatchesDone = true
        local stillHasGroupMatches = false
        
        for _, m in ipairs(g) do
            if m[8] and not m[5] then
                allGroupMatchesDone = false
                stillHasGroupMatches = true
                break
            end
        end
        
        if allGroupMatchesDone and stillHasGroupMatches == false then
            local knockoutExists = false
            for _, m in ipairs(g) do
                if m[7] then knockoutExists = true; break end
            end
            
            if not knockoutExists and not self.isLeagueMode then
                if not GroupStandings or not GroupStandings[tourId] or not next(GroupStandings[tourId]) then
                    GroupStandings[tourId] = {}
                    for _, m in ipairs(g) do
                        if m[8] and m[5] then
                            local groupName = "GROUP " .. m[9]
                            if not GroupStandings[tourId][groupName] then GroupStandings[tourId][groupName] = {} end
                            local st = GroupStandings[tourId][groupName]
                            for _, tid in ipairs({m[1], m[2]}) do
                                if not st[tid] then
                                    st[tid] = { teamId = tid, played = 0, win = 0, draw = 0, loss = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
                                end
                            end
                            local hs, as = st[m[1]], st[m[2]]
                            hs.played, as.played = hs.played + 1, as.played + 1
                            hs.goalsFor, hs.goalsAgainst = hs.goalsFor + m[3], hs.goalsAgainst + m[4]
                            as.goalsFor, as.goalsAgainst = as.goalsFor + m[4], as.goalsAgainst + m[3]
                            if m[3] > m[4] then
                                hs.win, as.loss, hs.points = hs.win + 1, as.loss + 1, hs.points + 3
                            elseif m[4] > m[3] then
                                as.win, hs.loss, as.points = as.win + 1, as.loss + 1, as.points + 3
                            else
                                hs.draw, as.draw = hs.draw + 1, as.draw + 1
                                hs.points, as.points = hs.points + 1, as.points + 1
                            end
                        end
                    end
                end
                self:GenerateKnockoutFromGroupStandings()
            end
            
            for _, match in ipairs(g) do
                if not match[5] and match[7] and (match[1] == userTeamId or match[2] == userTeamId) then
                    self.im.Publish("bnd_match_visible", true)
                    self.im.Publish(BND_HUB_ACTIONS_VISIBLE, false)
                    self.im.Publish("bnd_home_crest", { name = crestName, id = match[1] })
                    self.im.Publish("bnd_away_crest", { name = crestName, id = match[2] })
                    self.im.Publish("bnd_home_team", self.loc.LocalizeString("TeamName_Abbr15_" .. match[1]))
                    self.im.Publish("bnd_away_team", self.loc.LocalizeString("TeamName_Abbr15_" .. match[2]))
                    self.im.Publish("bnd_text", match[9] or "Knockout")
                    
                    nextMatchFound = true
                    self.im.Publish(BND_PANEL_LOADING, false)
                    self.im.Publish("bnd_tour_label", tourName)
                    return
                end
            end
        end
        
        if not nextMatchFound then
            self.im.Publish("bnd_match_visible", false)
            self.im.Publish(BND_HUB_ACTIONS_VISIBLE, true)
            self:InitOptions()
            
            local stillUnplayedMatches = false
            for _, m in ipairs(g) do
                if not m[5] then stillUnplayedMatches = true; break end
            end

            if stillUnplayedMatches then
                self:SimulateRestOfTournament(true)
            else
                if g and #g > 0 then
                    local final = g[#g]
                    if final and final[9] == "Final" and final[5] then
                        local winners, complete = self:GetKnockoutWinners(g, "Final")
                        if complete and #winners > 0 then
                            self.tourData.championCrest.id = winners[1]
                            self.tourData.isFinish = true
                            self:InitOptions()
                            self:publishChampion()
                            self.im.Publish(BND_PANEL_LOADING, false)
                            return
                        end
                    end
                end
                self.im.Publish("bnd_text", "Tournament ended")
            end
        end
    end

    self.im.Publish(BND_PANEL_LOADING, false)
    self.im.Publish("bnd_tour_label", tourName)
end

function MatchSelect:ShuffleArray(array)
    for i = #array, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
    end
    return array
end

function MatchSelect:SimulateCurrentMatchday()
    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    if not group then return end

    local matchday = -1
    for _, match in ipairs(group) do
        if not match[5] and match[8] then matchday = match[10]; break end
    end
    if matchday == -1 then return end

    TournamentStats[tourId] = TournamentStats[tourId] or { Goals = {}, Assists = {}, Appearances = {}, YellowCards = {}, RedCards = {} }

    for _, match in ipairs(group) do
        local homeId, awayId = match[1], match[2]
        if match[8] and match[10] == matchday and not match[5] then
            local scores = self:GetTeamRealScore(homeId, awayId, true)
            match[3], match[4], match[5] = scores[homeId], scores[awayId], true
            if match[3] > match[4] then match[6] = homeId
            elseif match[4] > match[3] then match[6] = awayId
            else match[6] = 0 end
            
            self:DistributeSimulatedGoals(homeId, match[3])
            self:DistributeSimulatedGoals(awayId, match[4])
        end
    end

    self:SaveMatchResult()

    local allGroupDone = true
    for _, match in ipairs(group) do
        if match[8] and not match[5] then allGroupDone = false; break end
    end

    if allGroupDone then self:GenerateKnockoutFromGroupStandings() end
    self:InitOptions()
end

function MatchSelect:SimulateCurrentKnockoutRound()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not QuickTourGrouping[tourId] then return end

    local group = QuickTourGrouping[tourId]
    local round = nil

    for _, m in ipairs(group) do 
        if not m[5] and m[7] then round = m[9]; break end 
    end

    if not round then return end
    local userTeamId = currentTourInfo[tourId].homeID

    for i, m in ipairs(group) do
        if m[9] == round and not m[5] then
            if m[1] ~= userTeamId and m[2] ~= userTeamId then
                self:SimulateKnockoutMatch(i)
            end
        end
    end
    
    local isRoundFinished = true
    for _, m in ipairs(group) do
        if m[9] == round and not m[5] then isRoundFinished = false; break end
    end

    if isRoundFinished then
        local winners, complete = self:GetKnockoutWinners(group, round)
        if complete and #winners > 0 then self:GenerateNextKnockoutRound(winners) end
    end

    self:InitOptions()
    self:publishMatchInfo()
end

function MatchSelect:SimulateKnockoutMatch(index)
    local tourId = GlobalTournamentSettings.tourId or 1
    if not QuickTourGrouping[tourId] or not QuickTourGrouping[tourId][index] then return end
    
    local m = QuickTourGrouping[tourId][index]
    if m[5] then return end
    
    local s1, s2 = math.random(0, 4), math.random(0, 4)
    local w = (s1 > s2) and m[1] or (s2 > s1) and m[2] or ((math.random(1, 2) == 1) and m[1] or m[2])
    
    local isTwoLegs = GlobalTournamentSettings and GlobalTournamentSettings.isTwoLegs or false
    
    if s1 == s2 and not (isTwoLegs and m[10] == 1 and m[9] ~= "Final") then 
        if w == m[1] then s1 = s1 + 1 else s2 = s2 + 1 end
    end
    
    m[3], m[4], m[5], m[6] = s1, s2, true, w
    
    self:DistributeSimulatedGoals(m[1], m[3])
    self:DistributeSimulatedGoals(m[2], m[4])
end

function MatchSelect:GenerateNextKnockoutRound(teams)
    local tourId = GlobalTournamentSettings.tourId or 1
    if #teams < 2 then return end
    
    local currentRoundName = ""
    for i = #QuickTourGrouping[tourId], 1, -1 do 
        if QuickTourGrouping[tourId][i][7] then 
            currentRoundName = QuickTourGrouping[tourId][i][9]
            break
        end 
    end
    
    local nextRoundName = ""
    if currentRoundName == "Round of 32" then nextRoundName = "Round of 16"
    elseif currentRoundName == "Round of 16" then nextRoundName = "Quarter-Finals"
    elseif currentRoundName == "Quarter-Finals" or currentRoundName == "Quarter Finals" then nextRoundName = "Semi-Finals"
    elseif currentRoundName == "Semi-Finals" then nextRoundName = "Final"
    else return end
    
    self:ShuffleArray(teams)
    
    local isTwoLegs = GlobalTournamentSettings and GlobalTournamentSettings.isTwoLegs or false
    
    for i = 1, #teams, 2 do
        if teams[i] and teams[i+1] then
            table.insert(QuickTourGrouping[tourId], { teams[i], teams[i+1], 0, 0, false, 0, true, false, nextRoundName, 1 })
            
            if isTwoLegs and nextRoundName ~= "Final" then
                table.insert(QuickTourGrouping[tourId], { teams[i+1], teams[i], 0, 0, false, 0, true, false, nextRoundName, 2 })
            end
        end
    end
    
    self:InitOptions()
    self:publishMatchInfo()
end

function MatchSelect:SimulateRestOfKnockout()
    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    if not group then return end
    
    local maxIterations = 100
    local iteration = 0
    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID
    
    while iteration < maxIterations do
        iteration = iteration + 1
        local simulatedAny = false
        local userMatchExists = false
        
        for i, match in ipairs(group) do
            if match[7] and not match[5] then
                if match[1] == userTeamId or match[2] == userTeamId then
                    userMatchExists = true
                else
                    self:SimulateKnockoutMatch(i)
                    simulatedAny = true
                    break
                end
            end
        end
        
        if userMatchExists then
            self:InitOptions()
            self:publishMatchInfo()
            return
        end
        
        if not simulatedAny then
            local lastRound = ""
            for i = #group, 1, -1 do
                if group[i][7] then lastRound = group[i][9]; break end
            end
            if lastRound == "" then break end
            
            local roundComplete = true
            for _, match in ipairs(group) do
                if match[9] == lastRound and not match[5] then
                    roundComplete = false
                    break
                end
            end
            
            if roundComplete then
                local winners, complete = self:GetKnockoutWinners(group, lastRound)
                if complete and #winners > 0 then
                    if #winners == 1 then
                        self.tourData.championCrest.id = winners[1]
                        self.tourData.isFinish = true
                        self:InitOptions()
                        self:publishChampion()
                        return
                    else
                        self:GenerateNextKnockoutRound(winners)
                        local userHasMatch = false
                        for _, match in ipairs(group) do
                            if not match[5] and (match[1] == userTeamId or match[2] == userTeamId) then
                                userHasMatch = true
                                break
                            end
                        end
                        if userHasMatch then
                            self:InitOptions()
                            self:publishMatchInfo()
                            return
                        end
                    end
                else
                    break
                end
            else
                break
            end
        end
    end
    self:InitOptions()
    self:publishMatchInfo()
end

-- [PERBAIKAN MUTLAK] Logika Klasemen Grup Diselaraskan Murni Sesuai Poin & Posisi Asli (Posisi 3/4 yang gagal bersaing langsung gugur)
function MatchSelect:GenerateKnockoutFromGroupStandings()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not GroupStandings or not GroupStandings[tourId] then
        -- Pastikan GroupStandings terinisialisasi jika belum ada
        GroupStandings[tourId] = {}
        local g = QuickTourGrouping[tourId]
        if g then
            for _, m in ipairs(g) do
                if m[8] and m[5] then
                    local groupName = "GROUP " .. m[9]
                    if not GroupStandings[tourId][groupName] then GroupStandings[tourId][groupName] = {} end
                    local st = GroupStandings[tourId][groupName]
                    for _, tid in ipairs({m[1], m[2]}) do
                        if not st[tid] then
                            st[tid] = { teamId = tid, played = 0, win = 0, draw = 0, loss = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
                        end
                    end
                    local hs, as = st[m[1]], st[m[2]]
                    hs.played, as.played = hs.played + 1, as.played + 1
                    hs.goalsFor, hs.goalsAgainst = hs.goalsFor + m[3], hs.goalsAgainst + m[4]
                    as.goalsFor, as.goalsAgainst = as.goalsFor + m[4], as.goalsAgainst + m[3]
                    if m[3] > m[4] then
                        hs.win, as.loss, hs.points = hs.win + 1, as.loss + 1, hs.points + 3
                    elseif m[4] > m[3] then
                        as.win, hs.loss, as.points = as.win + 1, hs.loss + 1, as.points + 3
                    else
                        hs.draw, as.draw = hs.draw + 1, as.draw + 1
                        hs.points, as.points = hs.points + 1, as.points + 1
                    end
                end
            end
        end
    end

    local settings = GlobalTournamentSettings or {}
    local teamsCount = settings.teamCount or self.teamCount or 32
    local knockoutRound = "Round of 16"
    
    if teamsCount == 8 then knockoutRound = "Semi-Finals"
    elseif teamsCount == 16 then knockoutRound = "Quarter-Finals"
    elseif teamsCount == 24 or teamsCount == 32 then knockoutRound = "Round of 16"
    elseif teamsCount == 48 then knockoutRound = "Round of 32"
    else knockoutRound = "Round of 16" end

    QuickTourGrouping[tourId] = QuickTourGrouping[tourId] or {}
    local standings = GroupStandings[tourId]
    local groupWinners, groupRunnersUp, thirdPlaceds, groupNames = {}, {}, {}, {}

    for groupName, _ in pairs(standings) do table.insert(groupNames, groupName) end
    table.sort(groupNames, function(a, b) return a:sub(-1) < b:sub(-1) end)

    for _, groupName in ipairs(groupNames) do
        local groupData = standings[groupName]
        local teamsArray = {}
        for _, stats in pairs(groupData) do table.insert(teamsArray, stats) end

        -- Urutkan ketat: Poin -> Selisih Gol -> Gol Memasukkan
        table.sort(teamsArray, function(a, b)
            if a.points ~= b.points then return a.points > b.points end
            local diffA, diffB = a.goalsFor - a.goalsAgainst, b.goalsFor - b.goalsAgainst
            if diffA ~= diffB then return diffA > diffB end
            return a.goalsFor > b.goalsFor
        end)

        -- MUTLAK HANYA AMBIL POSISI 1 & 2 UNTUK LOLOS OTOMATIS
        if #teamsArray >= 1 and teamsArray[1] then table.insert(groupWinners, teamsArray[1].teamId) end
        if #teamsArray >= 2 and teamsArray[2] then table.insert(groupRunnersUp, teamsArray[2].teamId) end
        -- Ambil peringkat 3 untuk diseleksi jika format mendukung (24 / 48 tim)
        if #teamsArray >= 3 and teamsArray[3] then table.insert(thirdPlaceds, teamsArray[3]) end
    end

    local knockoutTeams = {}
    if teamsCount == 8 or teamsCount == 16 or teamsCount == 32 then
        for _, id in ipairs(groupWinners) do table.insert(knockoutTeams, id) end
        for _, id in ipairs(groupRunnersUp) do table.insert(knockoutTeams, id) end
    elseif teamsCount == 24 or teamsCount == 48 then
        local limit = (teamsCount == 24) and 4 or 8
        -- Urutkan peringkat 3 terbaik secara objektif berdasarkan performa global
        table.sort(thirdPlaceds, function(a, b)
            if a.points ~= b.points then return a.points > b.points end
            local gdA, gdB = (a.goalsFor or 0) - (a.goalsAgainst or 0), (b.goalsFor or 0) - (b.goalsAgainst or 0)
            if gdA ~= gdB then return gdA > gdB end
            return (a.goalsFor or 0) > (b.goalsFor or 0)
        end)
        
        for _, id in ipairs(groupWinners) do table.insert(knockoutTeams, id) end
        for _, id in ipairs(groupRunnersUp) do table.insert(knockoutTeams, id) end
        
        -- Masukkan hanya sejumlah limit peringkat 3 terbaik (misal 8 tim untuk 48 tim)
        for i = 1, limit do 
            if thirdPlaceds[i] then 
                table.insert(knockoutTeams, thirdPlaceds[i].teamId) 
            end 
        end
    end

    self:ShuffleArray(knockoutTeams)
    local isTwoLegs = GlobalTournamentSettings and GlobalTournamentSettings.isTwoLegs or false
    
    for i = 1, #knockoutTeams, 2 do
        if knockoutTeams[i] and knockoutTeams[i+1] then
            table.insert(QuickTourGrouping[tourId], { knockoutTeams[i], knockoutTeams[i+1], 0, 0, false, 0, true, false, knockoutRound, 1 })
            
            if isTwoLegs and knockoutRound ~= "Final" then
                table.insert(QuickTourGrouping[tourId], { knockoutTeams[i+1], knockoutTeams[i], 0, 0, false, 0, true, false, knockoutRound, 2 })
            end
        end
    end
end

function MatchSelect:RecordPlayerStats(playerID, statsToRecord)
    local tourId = GlobalTournamentSettings.tourId or 1
    if not playerID or not TournamentStats[tourId] then return end
    local stats = TournamentStats[tourId]
    
    if statsToRecord.goals then stats.Goals[playerID] = (stats.Goals[playerID] or 0) + statsToRecord.goals end
    if statsToRecord.yellow_cards then stats.YellowCards[playerID] = (stats.YellowCards[playerID] or 0) + statsToRecord.yellow_cards end
    if statsToRecord.red_cards then stats.RedCards[playerID] = (stats.RedCards[playerID] or 0) + statsToRecord.red_cards end
    if statsToRecord.appearance then stats.Appearances[playerID] = (stats.Appearances[playerID] or 0) + statsToRecord.appearance end
end

function MatchSelect:DistributeSimulatedGoals(teamId, goals)
    if not teamId or teamId == 0 then return end 
    
    local tourId = GlobalTournamentSettings.tourId or 1
    
    TournamentStats[tourId] = TournamentStats[tourId] or {}
    TournamentStats[tourId].Goals = TournamentStats[tourId].Goals or {}
    TournamentStats[tourId].YellowCards = TournamentStats[tourId].YellowCards or {}
    TournamentStats[tourId].RedCards = TournamentStats[tourId].RedCards or {}
    
    TeamPlayerCache[tourId] = TeamPlayerCache[tourId] or {}
    local players = TeamPlayerCache[tourId][teamId]
    
    if not players or #players == 0 then
        local dummyCardId = teamId * 1000 + 9
        players = {
            {
                CARD_ID = dummyCardId,
                playerName = "Player " .. teamId,
                nationalityID = 0,
                position = "ST",
                rating = 80
            }
        }
        TeamPlayerCache[tourId][teamId] = players
    end
    
    if players and #players > 0 then
        if goals and goals > 0 then
            for i = 1, goals do
                local scorerIndex = math.random(1, #players)
                local scorer = players[scorerIndex]
                
                if scorer and scorer.CARD_ID then
                    TournamentStats[tourId].Goals[scorer.CARD_ID] = (TournamentStats[tourId].Goals[scorer.CARD_ID] or 0) + 1
                end
            end
        end
        
        if math.random(1, 100) <= 60 then
            local candidate = nil
            for attempts = 1, 5 do
                local randomPlayer = players[math.random(1, #players)]
                if randomPlayer and randomPlayer.CARD_ID then
                    if randomPlayer.position ~= "GK" or math.random(1, 100) <= 5 then
                        candidate = randomPlayer
                        break
                    end
                end
            end

            if candidate and candidate.CARD_ID then
                TournamentStats[tourId].YellowCards[candidate.CARD_ID] = (TournamentStats[tourId].YellowCards[candidate.CARD_ID] or 0) + 1
            end
        end
        
        if math.random(1, 100) <= 3 then
            local redCandidate = nil
            for attempts = 1, 5 do
                local randomPlayer = players[math.random(1, #players)]
                if randomPlayer and randomPlayer.CARD_ID and randomPlayer.position ~= "GK" then
                    redCandidate = randomPlayer
                    break
                end
            end

            if redCandidate and redCandidate.CARD_ID then
                TournamentStats[tourId].RedCards[redCandidate.CARD_ID] = (TournamentStats[tourId].RedCards[redCandidate.CARD_ID] or 0) + 1
            end
        end
    end
end

function MatchSelect:PlayMatch()
    local tourId = GlobalTournamentSettings.tourId or 1
    local g = QuickTourGrouping[tourId]
    if not g or #g == 0 then return end

    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID
    if not userTeamId or userTeamId == 0 then return end

    for i, matchData in ipairs(g) do
        if not matchData[5] and (matchData[1] == userTeamId or matchData[2] == userTeamId) then
            currentPlayedMatchIndex = i
            local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
            local roundName = ""
            if matchData[7] then roundName = matchData[9]
            elseif matchData[8] then
                if self.isLeagueMode then roundName = "LEAGUE MATCHDAY " .. matchData[10]
                else roundName = "GROUP " .. matchData[9] end
            end

            currentTourData.homeID = matchData[1]
            currentTourData.awayID = matchData[2]
            currentTourData.isUserSideHome = (matchData[1] == userTeamId) and 0 or 1
            currentTourData.homeKitIndex = 0
            currentTourData.awayKitIndex = 1
            currentTourData.tourIndex = tourId
            currentTourData.tourName = tourName
            currentTourData.roundName = roundName

            currentMatch.HomeTeamID = matchData[1]
            currentMatch.AwayTeamID = matchData[2]
            currentMatch.HomeKitIndex = 0
            currentMatch.AwayKitIndex = 1

            self.nav.Event(nil, "evt_advance", {
                title = "INFO",
                message = "Are you ready to play this match?",
                buttons = {
                    { icon = "$FooterIconNo", label = "Cancel", clickEvents = { "evt_hide_popup" } },
                    { icon = "$FooterIconYes", label = "Confirm", clickEvents = { "evt_advance", "evt_hide_popup" } }
                }
            })
            return
        end
    end
end

function MatchSelect:Belum()
    self.nav.Event(nil, "evt_show_popup", {
        title = "INFO",
        message = "We're working on it. \nPlease check back for upcoming updates.",
        buttons = { { icon = "$FooterIconYes", label = "OK", clickEvents = { "evt_hide_popup" } } }
    })
end

function MatchSelect:StopMatch() 
    self:SimulateRestOfTournament(true) 
end

function MatchSelect:GetTeamRealScore(a, b, allowDraw)
    local ai = self.services.SquadManagementService.GetTeamInfo(a)
    local bi = self.services.SquadManagementService.GetTeamInfo(b)

    local sa, sb = math.random(0, 5), math.random(0, 5)
    local diff = (ai.overall or 75) - (bi.overall or 75)
    local bias = 50 + (diff * 2)

    if math.random(1, 100) <= bias then
        if sa < sb then sa, sb = sb, sa end
    else
        if sb < sa then sa, sb = sb, sa end
    end

    if sa == sb and not allowDraw then
        if math.random(1, 100) <= bias then sa = sa + 1 else sb = sb + 1 end
    end

    local r = {}
    r[a] = sa
    r[b] = sb
    return r
end

function MatchSelect:SaveMatchResult()
    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    if not group then return end

    GroupStandings[tourId] = {}
    for _, m in ipairs(group) do
        if m[8] and m[5] then
            local home, away, hs, as = m[1], m[2], m[3], m[4]
            local groupName = "GROUP " .. m[9]
            
            if not GroupStandings[tourId][groupName] then GroupStandings[tourId][groupName] = {} end
            local g = GroupStandings[tourId][groupName]

            for _, tid in ipairs({home, away}) do
                if not g[tid] then
                    g[tid] = { teamId = tid, played = 0, win = 0, draw = 0, loss = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
                end
            end
            
            local hstat, astat = g[home], g[away]
            hstat.played, astat.played = hstat.played + 1, astat.played + 1
            hstat.goalsFor, hstat.goalsAgainst = hstat.goalsFor + hs, hstat.goalsAgainst + as
            astat.goalsFor, astat.goalsAgainst = astat.goalsFor + as, astat.goalsAgainst + hs
            
            if hs > as then hstat.win, astat.loss, hstat.points = hstat.win + 1, astat.loss + 1, hstat.points + 3
            elseif as > hs then astat.win, hstat.loss, astat.points = astat.win + 1, hstat.loss + 1, hstat.points + 3
            else hstat.draw, astat.draw = hstat.draw + 1, astat.draw + 1; hstat.points, astat.points = hstat.points + 1, astat.points + 1 end
        end
    end
end

function MatchSelect:SimulateRestOfTournament(forceSim)
    local tourId = GlobalTournamentSettings.tourId or 1
    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID

    local simulationLimit = 150
    local count = 0
    local lastMatchCount = -1
    local noProgressCount = 0
    
    while not self.tourData.isFinish and count < simulationLimit do
        count = count + 1
        local currentMatchCount = 0
        if QuickTourGrouping[tourId] then
            for _, m in ipairs(QuickTourGrouping[tourId]) do
                if m[5] then currentMatchCount = currentMatchCount + 1 end
            end
        end
        
        if currentMatchCount == lastMatchCount then
            noProgressCount = noProgressCount + 1
            if noProgressCount > 5 then break end
        else
            noProgressCount = 0
        end
        lastMatchCount = currentMatchCount
        
        local groupMatchesLeft = false
        if QuickTourGrouping[tourId] then 
            for _, m in ipairs(QuickTourGrouping[tourId]) do 
                if m[8] and not m[5] then 
                    if not forceSim and (m[1] == userTeamId or m[2] == userTeamId) then return end
                    groupMatchesLeft = true
                    break 
                end 
            end
        end
        
        if groupMatchesLeft then 
            self:SimulateCurrentMatchday()
        else
            local knockoutMatchesLeft = false
            if QuickTourGrouping[tourId] then 
                for _, m in ipairs(QuickTourGrouping[tourId]) do 
                    if m[7] and not m[5] then 
                        if not forceSim and (m[1] == userTeamId or m[2] == userTeamId) then return end
                        knockoutMatchesLeft = true
                        break 
                    end 
                end
            end
            
            if knockoutMatchesLeft then 
                self:SimulateCurrentKnockoutRound() 
            else
                if QuickTourGrouping[tourId] and #QuickTourGrouping[tourId] > 0 then
                    local final = QuickTourGrouping[tourId][#QuickTourGrouping[tourId]]
                    if final and final[9] == "Final" and final[5] then
                        local winners, complete = self:GetKnockoutWinners(QuickTourGrouping[tourId], "Final")
                        if complete and #winners > 0 then
                            self.tourData.championCrest.id = winners[1]
                            self.tourData.isFinish = true
                        end
                    else
                        break
                    end
                else 
                    self.tourData.isFinish = true
                end
                if self.tourData.isFinish then break end
            end
        end
    end
    self:publishChampion()
end

function MatchSelect:PlayReStart()
    local buttonNo = { icon = "$FooterIconNo", label = "Cancel", clickEvents = { "evt_hide_popup" } }
    local buttonYes = { icon = "$FooterIconYes", label = "Confirm", clickEvents = { "evt_restart", "evt_hide_popup" } }
    self.nav.Event(nil, "evt_show_popup", { title = "INFO", message = "Do you want to end the current competition?", buttons = {buttonNo, buttonYes} })
end

function MatchSelect:finalize()
    self.im.UnregisterAction(ACT_RESTART)
    self.im.UnregisterAction(ACT_ADVANCE)
    self.im.UnregisterAction(ACT_BELUM)
    self.im.UnregisterAction("act_simulate")
    self.im.UnregisterAction("act_ads") 
    self.im.Publish(BND_PANEL_LOADING, false)
    self.im.Unsubscribe(BND_PANEL_LOADING)
    self.im.Unsubscribe(BND_DYNAMIC_TEXT)

    for _, b in ipairs({ 
        BND_ADS_A_VISIBLE, BND_ADS_B_VISIBLE, BND_COLOR_CUPID, BND_REALTIME, BND_DATE, 
        BND_LAST_MATCH_RESULT, BND_HUB_ACTIONS_VISIBLE, "bnd_bg_tour", "bnd_tour_logo", 
        "bnd_trophy", "bnd_ads", "bnd_match_visible","bnd_group_label", "bnd_home_crest", 
        "bnd_away_crest", "bnd_home_team", "bnd_away_team", "bnd_home_team_short", 
        "bnd_away_team_short", "bnd_text", "bnd_champion_visible", "bnd_champion_crest", 
        "bnd_champion_team", "bnd_champion_scorer", "bnd_champion_scorer_head", 
        "bnd_champion_scorer_name", "bnd_champion_scorer_flag", "bnd_champion_scorer_pos", 
        "bnd_champion_scorer_ovr", "bnd_home_score", "bnd_away_score", "bnd_tour_label" 
    }) do 
        self.im.Unsubscribe(b) 
    end

    for _, v in pairs(bndList) do self.im.Unsubscribe(v) end
end

return MatchSelect
