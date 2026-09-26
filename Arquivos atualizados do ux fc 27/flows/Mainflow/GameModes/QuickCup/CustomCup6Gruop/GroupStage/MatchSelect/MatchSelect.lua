-- MOUNTSA - FULL TOURNAMENT SYSTEM
local TabModel = ...
QuickTour = {}
local BND_COLOR_CUPID = "bnd_color_tourid" 
local BND_ADS_A_VISIBLE = "bnd_ads_a_visible"
local BND_ADS_B_VISIBLE = "bnd_ads_b_visible"
local BND_BUSY_STATE_VISIBLE = "bnd_busy_state_visible"
local BND_LAST_MATCH_RESULT = "bnd_last_match_result"
local BND_HUB_ACTIONS_VISIBLE = "bnd_hub_actions_visible"
local ACT_END = "act_end"
local ACT_ADVANCE = "act_advance"
local ACT_RESTART = "act_restart"
local ACT_BELUM = "act_belum"
local BND_REALTIME = "bnd_realtime"
local BND_DATE = "bnd_date"
local BND_CURRENT_ROUND = "bnd_current_round"
local BND_PANEL_LOADING = "bnd_panel_loading"
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

local tourIdToNameMap = {
    [6]  = "UEFA Euro",
    [13] = "US Open Tour",
    [19] = "Copa Argentina",
    [26] = "Africa Cup Of Nations",
    [28] = "UEFA Nations League",
    [34] = "AFC Asian Cup 2027",
    default = "Custom Tournament"
}

local tourIdToColorMap = {
    [6]  = "0x000351",
    [13] = "0x1A1A1A",
    [19] = "0x1A1A1A",
    [26] = "0x550002",
    [28] = "0x19253B",
    [34] = "0x002D04",
    default = "0x1A1A1A"
}

function QuickTour:new(init)
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
    o.tourData = {
        tourBg = { name = "$Bg_Cup", id = tourId },
        tourlogo = { name = "$CupLogo", id = tourId },
        trophy = { name = "$CupTrophy", id = tourId },
        championCrest = { name = "$Crest", id = 0 },
        isFinish = false, 
        Round = ""
    }
    o:setupSubscriptions()
    o:setupActions()
    o.im.Publish("bnd_match_visible", true)
    print("QuickTour Initialized for Tour: " .. tournamentDisplayName .. " (ID: "..tostring(tourId)..")")

    self.isSimulating = false
    currentSimulationPhase = 0
    matchesToSimulate = {}
    currentMatchIndex = 1
    self.simulationInProgress = false

	return o
end

function QuickTour:setupSubscriptions()
    local tourId = GlobalTournamentSettings.tourId or 1
    local tournamentDisplayName = tourIdToNameMap[tourId] or tourIdToNameMap.default
	self.im.Subscribe(BND_PANEL_LOADING, function(isVisible) end)
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
            if match[7] then
                round = match[9]
                break
            end
        end
    end
    
    self.im.Publish(BND_CURRENT_ROUND, round)
	end)
    self.im.Subscribe(BND_BUSY_STATE_VISIBLE, function(isVisible) end)
    self.im.Subscribe("bnd_bg_tour", function() self.im.Publish("bnd_bg_tour", self.tourData.tourBg) end)
    self.im.Subscribe("bnd_tour_logo", function() self.im.Publish("bnd_tour_logo", self.tourData.tourlogo) end)
    self.im.Subscribe("bnd_trophy", function() self.im.Publish("bnd_trophy", self.tourData.trophy) end)
    self.Banner = { name = "$Ads", id = math.random(5) }
    self.im.Subscribe("bnd_last_match_result", function() self:publishMatchInfo() end)
    self.im.Subscribe("bnd_ads", function() self.im.Publish("bnd_ads", self.Banner) end)
    self.im.Subscribe(BND_REALTIME, function() self.im.Publish(BND_REALTIME, os.date(tournamentDisplayName .. " %h %d | %I:%M %p")) end)
    -- 🕒 Subscribe real-time date (English format: Day, Month Date)
    self.im.Subscribe("bnd_date", function()
    local currentDate = os.date("%A, %b %d")  -- contoh: Saturday, November 08
    self.im.Publish("bnd_date", currentDate)
    end)
    self.im.Subscribe("bnd_home_score", function() self:publishMatchInfo() end)
    self.im.Subscribe("bnd_away_score", function() self:publishMatchInfo() end)
    self.im.Subscribe("bnd_tour_label", function() self:publishMatchInfo() end)
    self.im.Subscribe(BND_ADS_A_VISIBLE, function() self.im.Publish(BND_ADS_A_VISIBLE, self.isAdsVisible) end)
    self.im.Subscribe(BND_ADS_B_VISIBLE, function() self.im.Publish(BND_ADS_B_VISIBLE, not self.isAdsVisible) end)
    for _, v in ipairs(bndList) do self.im.Subscribe(v, function() self:InitOptions() end) end
    for _, k in ipairs({ "bnd_match_visible", "bnd_home_crest", "bnd_away_crest", "bnd_home_team", "bnd_away_team","bnd_group_label", "bnd_home_team_short", "bnd_away_team_short", "bnd_team_crest", "bnd_team_name" }) do self.im.Subscribe(k, function() self:publishMatchInfo() end) end
    for _, k in ipairs({"bnd_text", "bnd_champion_visible", "bnd_champion_crest", "bnd_champion_team"}) do self.im.Subscribe(k, function() self:publishChampion() end) end
end

function QuickTour:setupActions()
    self.im.RegisterAction(ACT_ADVANCE, function() self:PlayMatch() end)
    self.im.RegisterAction(ACT_RESTART, function() self:PlayReStart() end)
    self.im.RegisterAction(ACT_BELUM, function() self:Belum() end)
    self.im.RegisterAction(ACT_END, function() self:ResetTournament() end)
	-- Ubah bagian act_simulate di dalam function QuickTour:setupActions() menjadi seperti ini:

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

    -- Cari pertandingan user yang belum dimainkan (pertandingan aktif saat ini)
    local targetMatchIndex = nil
    for i, match in ipairs(group) do
        if not match[5] and (match[1] == userTeamId or match[2] == userTeamId) then
            targetMatchIndex = i
            break
        end
    end

    if targetMatchIndex then
        local match = group[targetMatchIndex]
        local homeId, awayId = match[1], match[2]

        -- 1. Simulasi Skor (Menggunakan logika knockout jika itu fase gugur, atau liga jika grup)
        if match[7] then -- Jika Knockout
            self:SimulateKnockoutMatch(targetMatchIndex)
        else -- Jika Group Stage
            local scores = self:GetTeamRealScore(homeId, awayId, true)
            match[3], match[4], match[5] = scores[homeId], scores[awayId], true
            match[6] = (match[3] > match[4]) and homeId or (match[4] > match[3]) and awayId or 0
        end

        -- 2. Simulasi Statistik Pemain (Penampilan & Gol)
        local function simulateStats(teamId, score)
            local players = TeamPlayerCache[tourId] and TeamPlayerCache[tourId][teamId] or {}
            if #players > 0 then
                for _, p in ipairs(players) do
                    self:RecordPlayerStats(p.CARD_ID, {appearance = 1})
                end
                for _ = 1, score do
                    local randomPlayer = players[math.random(#players)]
                    self:RecordPlayerStats(randomPlayer.CARD_ID, {goals = 1})
                end
            end
        end

        simulateStats(homeId, match[3])
        simulateStats(awayId, match[4])

        -- 3. Simpan dan Update Tampilan
        self:SaveMatchResult()
        
        -- Cek apakah group stage baru saja selesai setelah match ini
        local isLastGroupMatch = true
        for _, m in ipairs(group) do
            if m[8] and not m[5] then isLastGroupMatch = false; break end
        end
        if isLastGroupMatch and not match[7] then
            self:GenerateKnockoutFromGroupStandings()
        end

        -- Jika di fase knockout dan match selesai, cek apakah perlu generate round berikutnya
        -- (Hanya jika semua match di round tersebut sudah kelar)
        if match[7] then
            local roundName = match[9]
            local roundFinished = true
            local winners = {}
            for _, m in ipairs(group) do
                if m[9] == roundName then
                    if not m[5] then roundFinished = false end
                    table.insert(winners, m[6])
                end
            end
            if roundFinished and #winners > 0 then
                self:GenerateNextKnockoutRound(winners)
            end
        end

        print("⏩ Match Skipped: " .. self.loc.LocalizeString("TeamName_Abbr15_" .. homeId) .. " vs " .. self.loc.LocalizeString("TeamName_Abbr15_" .. awayId))
    end

    self:InitOptions()
    self:publishMatchInfo()
    self.simulationInProgress = false
end)
    self.im.RegisterAction("evt_force_reset_tournament", function()
        print("QuickTour received force reset command...")
        self:ResetTournament()
    end)
    self.im.RegisterAction("act_ads", function()
        self.isAdsVisible = not self.isAdsVisible
        self.im.Publish(BND_ADS_A_VISIBLE, self.isAdsVisible)
        self.im.Publish(BND_ADS_B_VISIBLE, not self.isAdsVisible)
        print("Ad visibility toggled. A is: " .. tostring(self.isAdsVisible) .. ", B is: " .. tostring(not self.isAdsVisible))
    end)
end

function QuickTour:InitOptions()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not QuickTourGrouping or not QuickTourGrouping[tourId] then 
        for i = 1, 124 do
            self.im.Publish("bnd_team"..i.."_crest", { name = "$Crest64x64", id = 0 })
            self.im.Publish("bnd_team"..i.."_score", "0")
        end
        return 
    end
    local g = QuickTourGrouping[tourId]
    for k = 1, #g do
        local m = g[k]
        local i = (k - 1) * 2 + 1
        self.im.Publish("bnd_team" .. i .. "_crest", { name = "$Crest64x64", id = m[1] })
        self.im.Publish("bnd_team" .. i .. "_score", tostring(m[3]))
        self.im.Publish("bnd_team" .. (i + 1) .. "_crest", { name = "$Crest64x64", id = m[2] })
        self.im.Publish("bnd_team" .. (i + 1) .. "_score", tostring(m[4]))
    end
    if #g > 0 then
        local final = g[#g]
        if final and final[9] == "Final" and final[5] and final[6] ~= 0 then
            self.tourData.championCrest.id = final[6]
            self.tourData.isFinish = true
            self:publishChampion()
        else
            self.tourData.isFinish = false
            self.tourData.championCrest.id = 0
        end
    end
end

function QuickTour:publishChampion()
    local tourId = GlobalTournamentSettings.tourId or 1
    if self.tourData.isFinish and self.tourData.championCrest.id ~= 0 then
        local championId = self.tourData.championCrest.id
        print("🏆 Displaying champion: " .. self.loc.LocalizeString("TeamName_Abbr15_" .. championId))
        self.im.Publish("bnd_champion_visible", true)
        self.im.Publish("bnd_match_visible", false)
        self.im.Publish(BND_HUB_ACTIONS_VISIBLE, false)
		self.im.Publish(BND_PANEL_LOADING, false)
        self.im.Publish("bnd_text", "THE CHAMPION")
        self.im.Publish("bnd_champion_crest", self.tourData.championCrest)
        self.im.Publish("bnd_champion_team", self.loc.LocalizeString("TeamName_Abbr15_" .. championId))
        self.im.Publish("bnd_home_crest", nil); self.im.Publish("bnd_away_crest", nil)
        self.im.Publish("bnd_home_team", ""); self.im.Publish("bnd_away_team", "")
        self.im.Publish("bnd_home_team_short", ""); self.im.Publish("bnd_away_team_short", "")
        self.im.Publish(BND_LAST_MATCH_RESULT, "Tournament Completed")
    else
        self.im.Publish("bnd_champion_visible", false)
    end
end

function QuickTour:publishMatchInfo()
    -- ❌ HILANGKAN auto simulasi (past matchdays)
    -- self:SimulatePastMatchdays() -- REMOVE / COMMENT this!

    local tourId = GlobalTournamentSettings.tourId or 1
    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    
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
    self.im.Publish("bnd_team_crest", { name = "$Crest64x64", id = userTeamId })
    self.im.Publish("bnd_team_name", self.loc.LocalizeString("TeamName_Abbr15_" .. userTeamId))
    
    local nextMatchFound = false
    for _, match in ipairs(g) do
        if not match[5] and (match[1] == userTeamId or match[2] == userTeamId) then
            local roundName = match[9]
            if match[7] then  
                self.im.Publish("bnd_text", roundName)
            else
                self.im.Publish("bnd_text", "Group Stage - Group " .. roundName)
            end

            self.im.Publish("bnd_match_visible", true)
            self.im.Publish(BND_HUB_ACTIONS_VISIBLE, false)
            self.im.Publish("bnd_home_crest", { name = "$Crest64x64", id = match[1] })
            self.im.Publish("bnd_away_crest", { name = "$Crest64x64", id = match[2] })
            self.im.Publish("bnd_home_team", self.loc.LocalizeString("TeamName_Abbr15_" .. match[1]))
            self.im.Publish("bnd_away_team", self.loc.LocalizeString("TeamName_Abbr15_" .. match[2]))
            
            print("🔍 Match found in " .. roundName .. ": " .. 
                  self.loc.LocalizeString("TeamName_Abbr15_" .. match[1]) .. " vs " .. 
                  self.loc.LocalizeString("TeamName_Abbr15_" .. match[2]))
            
            nextMatchFound = true
            break
        end
    end

    if not nextMatchFound then
        self.im.Publish("bnd_match_visible", false)
        self.im.Publish(BND_HUB_ACTIONS_VISIBLE, true)
        self:InitOptions() 
        
        if self.tourData.isFinish then
            self:publishChampion()
        else
            -- ⬇️ LOGIKA BARU UNTUK SIMULASI SISA TURNAMEN
            local stillUnplayedMatches = false
            for _, m in ipairs(g) do
                -- Cek apakah match adalah Group Stage (m[8]) atau Knockout (m[7]) DAN belum dimainkan (!m[5])
                if (m[8] or m[7]) and not m[5] then
                    stillUnplayedMatches = true
                    break
                end
            end

            if stillUnplayedMatches then
                print("⚠️ User gugur. Memulai simulasi sisa turnamen untuk mendapatkan statistik final.")
                self:SimulateRestOfTournament(true) -- Force simulasi sampai final
                
            else
                -- Jika tidak ada lagi match yang belum dimainkan (Turnamen benar-benar selesai)
                local currentRound = "Unknown Stage"
                for _, m in ipairs(g) do
                    if m[7] and not m[5] then 
                        currentRound = m[9]
                        break
                    end
                end
                
                -- Tampilkan babak terakhir user gugur
                self.im.Publish("bnd_text", "Eliminated in " .. currentRound)
                self:StopMatch() -- Panggil StopMatch (yang kini memaksa simulasi penuh)
            end
            -- ⬆️ AKHIR LOGIKA BARU
        end
    end
    
    self.im.Publish(BND_PANEL_LOADING, false)
    self.im.Publish("bnd_tour_label", tourName)
end

function QuickTour:SimulatePastMatchdays()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not QuickTourGrouping or not QuickTourGrouping[tourId] then return end
    
    print("⚙️ QuickTour.lua: Checking for and simulating any past, unplayed matchdays...")

    local tourData = QuickTourGrouping[tourId]
    local highestPlayedMatchday = 0

    for _, match in ipairs(tourData) do
        if match[5] == true and match[8] == true then
            if match[10] > highestPlayedMatchday then
                highestPlayedMatchday = match[10]
            end
        end
    end

    if highestPlayedMatchday == 0 then
        print("   -> No matches played yet. Nothing to simulate.")
        return
    end

    print("   -> Highest completed matchday found: " .. highestPlayedMatchday)

    local simulatedCount = 0
    for i, match in ipairs(tourData) do
        if match[8] == true and match[10] <= highestPlayedMatchday and match[5] == false then
            print("   -> Found unplayed past match on matchday " .. match[10] .. ". Simulating match index " .. i)
            
            local scores = self:GetTeamRealScore(match[1], match[2])
            match[3] = scores[match[1]]
            match[4] = scores[match[2]]
            match[5] = true
            
            if match[3] > match[4] then match[6] = match[1]
            elseif match[4] > match[3] then match[6] = match[2]
            else match[6] = 0 end
            
            simulatedCount = simulatedCount + 1
        end
    end

    if simulatedCount > 0 then
        print("✅ QuickTour.lua: Simulation complete. Simulated " .. simulatedCount .. " past matches.")
        self:SaveMatchResult()
    else
        print("   -> All past matchdays are already up to date.")
    end
end

function QuickTour:SimulateCurrentMatchday()
    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    if not group then return end

    local matchday = -1
    for _, match in ipairs(group) do
        if not match[5] and match[8] then
            matchday = match[10]
            break
        end
    end
    if matchday == -1 then return end

    print("🕹️ Simulating Matchday " .. matchday)

    TournamentStats[tourId] = TournamentStats[tourId] or {
        Goals = {}, Assists = {}, Appearances = {},
        YellowCards = {}, RedCards = {}
    }

    for _, match in ipairs(group) do
        local homeId, awayId = match[1], match[2]
        if match[8] and match[10] == matchday and not match[5] then

            local scores = self:GetTeamRealScore(homeId, awayId, true)
            match[3], match[4], match[5] = scores[homeId], scores[awayId], true
            if match[3] > match[4] then match[6] = homeId
            elseif match[4] > match[3] then match[6] = awayId
            else match[6] = 0 end

            if self.services and self.services.GameMenu then
                self.services.GameMenu.RecordAIMatchStats(homeId, awayId, match[3], match[4])
            end

            local homePlayers = TeamPlayerCache[tourId] and TeamPlayerCache[tourId][homeId] or {}
            local awayPlayers = TeamPlayerCache[tourId] and TeamPlayerCache[tourId][awayId] or {}

            local function recordGoals(numGoals, players, teamId)
                for _ = 1, numGoals do
                    if #players > 0 then
                        local p = players[math.random(#players)]
                        if p and p.CARD_ID then
                            TournamentStats[tourId].Goals[p.CARD_ID] = (TournamentStats[tourId].Goals[p.CARD_ID] or 0) + 1
                            print(string.format("⚽ Goal: %s (%s) for team %s",
                                p.playerName or "Unknown", p.CARD_ID, teamId))
                        end
                    end
                end
            end

            recordGoals(match[3], homePlayers, homeId)
            recordGoals(match[4], awayPlayers, awayId)

            local function recordAppearances(players)
                for _, p in ipairs(players) do
                    if p.CARD_ID then
                        TournamentStats[tourId].Appearances[p.CARD_ID] = (TournamentStats[tourId].Appearances[p.CARD_ID] or 0) + 1
                    end
                end
            end

            recordAppearances(homePlayers)
            recordAppearances(awayPlayers)
        end
    end

    self:SaveMatchResult()

    local allGroupDone = true
    for _, match in ipairs(group) do
        if match[8] and not match[5] then
            allGroupDone = false
            break
        end
    end

    if allGroupDone and not (tournamentConfig and tournamentConfig.isLeague) then
        print("🏁 Group stage finished. Proceeding to Knockout...")
        self:GenerateKnockoutFromGroupStandings()
    end

    self:InitOptions()
    self:publishMatchInfo()
end

function QuickTour:ShuffleArray(array)
    for i = #array, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
    end
    return array
end

function QuickTour:SimulateCurrentKnockoutRound()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not QuickTourGrouping[tourId] then return end

    local group = QuickTourGrouping[tourId]
    local round = nil

    for _, m in ipairs(group) do 
        if not m[5] and m[7] then 
            round = m[9] 
            break 
        end 
    end

    if not round then
        print("⚠️ No current knockout round found to simulate.")
        return
    end

    print("🔀 Simulating all other matches in " .. round .. "...")
    
    local userTeamId = currentTourInfo[tourId].homeID
    local allOtherMatchesPlayed = true

    for i, m in ipairs(group) do
        if m[9] == round and not m[5] then
            if m[1] == userTeamId or m[2] == userTeamId then
                print("--> Skipping simulation for user's match: " .. m[1] .. " vs " .. m[2])
                allOtherMatchesPlayed = false
            else
                self:SimulateKnockoutMatch(i)
            end
        end
    end
    
    local isRoundFinished = true
    for _, m in ipairs(group) do
        if m[9] == round and not m[5] then
            isRoundFinished = false
            break
        end
    end

    if isRoundFinished then
        print("🏆 All matches in " .. round .. " are complete. Generating next round...")
        local winners = {}
        for _, m in ipairs(group) do
            if m[9] == round then
                table.insert(winners, m[6])
            end
        end
        if #winners > 0 then
            self:GenerateNextKnockoutRound(winners)
        end
    else
        print("--> User must play their match before the next round can be generated.")
    end

    self:InitOptions()
    self:publishMatchInfo()
end

function QuickTour:SimulateKnockoutMatch(index)
    local tourId = GlobalTournamentSettings.tourId or 1
    if not QuickTourGrouping[tourId] or not QuickTourGrouping[tourId][index] then print("❌ Invalid match index: " .. index); return; end
    local m = QuickTourGrouping[tourId][index]
    if m[5] then return end
    local s1, s2 = math.random(0, 4), math.random(0, 4)
    local w = (s1 > s2) and m[1] or (s2 > s1) and m[2] or ((math.random(1, 2) == 1) and m[1] or m[2])
    if s1 == s2 then if w == m[1] then s1 = s1 + 1 else s2 = s2 + 1 end; end
    m[3], m[4], m[5], m[6] = s1, s2, true, w
    print("⚽ Match " .. index .. ": " .. m[1] .. " " .. s1 .. "-" .. s2 .. " " .. m[2] .. " | Winner: " .. w)
end

function QuickTour:GenerateNextKnockoutRound(teams)
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
    if currentRoundName == "Round of 16" then nextRoundName = "Quarter Final"
    elseif currentRoundName == "Quarter Final" then nextRoundName = "Semi Final"
    elseif currentRoundName == "Semi Final" then nextRoundName = "Final"
    else return end
    
    -- PENTING: Jangan gunakan ShuffleArray agar urutan M1, M2, dst tetap terjaga
    -- Indeks 1&2 (M1 vs M2), Indeks 3&4 (M3 vs M4), dst.
    for i = 1, #teams, 2 do
        if teams[i] and teams[i+1] then
            table.insert(QuickTourGrouping[tourId], {
                teams[i], teams[i+1], 
                0, 0, false, 0, true, false,
                nextRoundName, 1
            })
        end
    end
    
    self:InitOptions()
    self:publishMatchInfo()
end

function QuickTour:GenerateKnockoutFromGroupStandings()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not GroupStandings[tourId] then return end

    local standings = GroupStandings[tourId]  
    QuickTourGrouping[tourId] = QuickTourGrouping[tourId] or {}  

    local lastGroupMatchday = 0  
    for _, m in ipairs(QuickTourGrouping[tourId]) do  
        if m[10] and m[10] > lastGroupMatchday then lastGroupMatchday = m[10] end  
    end  
    local R16_MATCHDAY = lastGroupMatchday + 1

    local function sortTeamsLogic(a, b)
        if a.points ~= b.points then return a.points > b.points end
        local gdA = a.goalsFor - a.goalsAgainst
        local gdB = b.goalsFor - b.goalsAgainst
        if gdA ~= gdB then return gdA > gdB end
        return a.goalsAgainst < b.goalsAgainst
    end

    -- Mengambil data setiap grup
    local groupsData = {}
    local allThirdPlaces = {}
    local letters = {"A", "B", "C", "D", "E", "F"}

    for _, letter in ipairs(letters) do
        local gName = "GROUP " .. letter
        local t = {}
        for _, v in pairs(standings[gName] or {}) do table.insert(t, v) end
        table.sort(t, sortTeamsLogic)
        
        groupsData[letter] = t -- t[1]=Juara, t[2]=RunnerUp, t[3]=P3
        if t[3] then table.insert(allThirdPlaces, t[3]) end
    end

    -- Sortir Peringkat 3 Terbaik
    table.sort(allThirdPlaces, sortTeamsLogic)

    -- Sesuai Struktur Pesanan Anda:
    -- M1: JG A vs P3-1 | M2: JG B vs P3-2 | M3: JG C vs P3-3 | M4: JG D vs P3-4
    -- M5: JG E vs RG A | M6: RG C vs RG D | M7: JG F vs RG B | M8: RG E vs RG F
    local pairings = {
        {groupsData["A"][1], allThirdPlaces[1]}, -- M1
        {groupsData["B"][1], allThirdPlaces[2]}, -- M2
        {groupsData["C"][1], allThirdPlaces[3]}, -- M3
        {groupsData["D"][1], allThirdPlaces[4]}, -- M4
        {groupsData["E"][1], groupsData["A"][2]}, -- M5
        {groupsData["C"][2], groupsData["D"][2]}, -- M6
        {groupsData["F"][1], groupsData["B"][2]}, -- M7
        {groupsData["E"][2], groupsData["F"][2]}  -- M8
    }

    for _, pair in ipairs(pairings) do
        table.insert(QuickTourGrouping[tourId], {  
            pair[1].teamId, pair[2].teamId,  
            0, 0, false, 0,  
            true, false, "Round of 16", R16_MATCHDAY  
        })
    end
    print("✅ Round of 16 Generated based on fixed bracket M1-M8.")
end

function QuickTour:RecordPlayerStats(playerID, statsToRecord)
    local tourId = GlobalTournamentSettings.tourId or 1
    if not playerID or not TournamentStats[tourId] then return end

    local stats = TournamentStats[tourId]
    
    if statsToRecord.goals then
        stats.Goals[playerID] = (stats.Goals[playerID] or 0) + statsToRecord.goals
    end
    if statsToRecord.assists then
        stats.Assists[playerID] = (stats.Assists[playerID] or 0) + statsToRecord.assists
    end
    if statsToRecord.yellow_cards then
        stats.YellowCards[playerID] = (stats.YellowCards[playerID] or 0) + statsToRecord.yellow_cards
    end
    if statsToRecord.red_cards then
        stats.RedCards[playerID] = (stats.RedCards[playerID] or 0) + statsToRecord.red_cards
    end
    if statsToRecord.appearance then
        stats.Appearances[playerID] = (stats.Appearances[playerID] or 0) + statsToRecord.appearance
    end
end

function QuickTour:OnUserMatchEnd(statsPackage)
    print("📈 QuickTour received stats package from GameMenu.")
    if not currentPlayedMatchIndex then 
        print("❌ Error: QuickTour received stats but no match was recorded as being played.")
        return 
    end

    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    local match = group[currentPlayedMatchIndex]

    match[3] = statsPackage.homeScore
    match[4] = statsPackage.awayScore
    match[5] = true
    if match[3] > match[4] then match[6] = match[1] elseif match[4] > match[3] then match[6] = match[2] else match[6] = 0 end

    local homeTeamId = match[1]
    local awayTeamId = match[2]
    local allEvents = {}
    if statsPackage.matchEvents.homeData then for _, e in ipairs(statsPackage.matchEvents.homeData) do table.insert(allEvents, {event=e.data, teamId=homeTeamId}) end end
    if statsPackage.matchEvents.awayData then for _, e in ipairs(statsPackage.matchEvents.awayData) do table.insert(allEvents, {event=e.data, teamId=awayTeamId}) end end

    local function findId(teamId, number)
        if not TeamPlayerCache[tourId] or not TeamPlayerCache[tourId][teamId] then return nil end
        for _, p in ipairs(TeamPlayerCache[tourId][teamId]) do
            if p.jerseyNumber == number then return p.CARD_ID end
        end
        return nil
    end

    local homeLineup = TeamPlayerCache[tourId][homeTeamId] or {}
    local awayLineup = TeamPlayerCache[tourId][awayTeamId] or {}
    for _, p in ipairs(homeLineup) do self:RecordPlayerStats(p.CARD_ID, {appearance = 1}) end
    for _, p in ipairs(awayLineup) do self:RecordPlayerStats(p.CARD_ID, {appearance = 1}) end
    
    for _, item in ipairs(allEvents) do
        local playerId = findId(item.teamId, item.event.number)
        if playerId then
            if item.event.eventId == 0 then self:RecordPlayerStats(playerId, {goals = 1}) end
            if item.event.eventId == 11 then self:RecordPlayerStats(playerId, {assists = 1}) end
            if item.event.eventId == 2 then self:RecordPlayerStats(playerId, {yellow_cards = 1}) end
            if item.event.eventId == 3 then self:RecordPlayerStats(playerId, {red_cards = 1}) end
        end
    end
    
    currentPlayedMatchIndex = nil


    self:SaveMatchResult()
    print("✅ User-played match results saved. Now checking for knockout stage generation.")

    local isLastGroupMatch = true
    for _, match_check in ipairs(group) do
        if match_check[8] and not match_check[5] then
            isLastGroupMatch = false
            break
        end
    end

    if isLastGroupMatch then
        print("🏁 Group stage finished (triggered by user match). Proceeding to Knockout...")
        self:GenerateKnockoutFromGroupStandings()
    end

    self:publishMatchInfo()
    print("✅ User-played match results and stats have been successfully processed.")
end

function QuickTour:OnMatchEnd(stats)
    print("Match ended. Processing stats...")
    if not currentPlayedMatchIndex then
        print("Error: No match index was recorded.")
        return
    end

    local tourId = GlobalTournamentSettings.tourId or 1
    local g = QuickTourGrouping[tourId]
    local m = g[currentPlayedMatchIndex]
    
    m[3] = stats.HomeScore
    m[4] = stats.AwayScore
    m[5] = true
    m[6] = (stats.HomeScore > stats.AwayScore) and m[1] or (stats.AwayScore > stats.HomeScore) and m[2] or 0

    local tourId = GlobalTournamentSettings.tourId or 1
    local currentStats = TournamentStats[tourId]

    for _, scorer in ipairs(stats.GoalScorers or {}) do
        currentStats.Goals[scorer.PlayerID] = (currentStats.Goals[scorer.PlayerID] or 0) + 1
    end

    for _, assister in ipairs(stats.Assisters or {}) do
        currentStats.Assists[assister.PlayerID] = (currentStats.Assists[assister.PlayerID] or 0) + 1
    end
    
    for _, player in ipairs(stats.YellowCardPlayers or {}) do
        currentStats.YellowCards[player.PlayerID] = (currentStats.YellowCards[player.PlayerID] or 0) + 1
    end

    for _, player in ipairs(stats.RedCardPlayers or {}) do
        currentStats.RedCards[player.PlayerID] = (currentStats.RedCards[player.PlayerID] or 0) + 1
    end

    print("Match results saved for match index: " .. currentPlayedMatchIndex)
    currentPlayedMatchIndex = nil

    self:InitOptions()
    self:publishMatchInfo()
end

function QuickTour:PlayMatch()
    local tourId = GlobalTournamentSettings.tourId or 1
    local g = QuickTourGrouping[tourId]
    
    if not g or #g == 0 then
        print("❌ QuickTour: Tidak ada jadwal turnamen yang ditemukan.")
        return
    end
    
    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID
    if not userTeamId or userTeamId == 0 then
        print("❌ QuickTour: ID tim pengguna tidak valid.")
        return
    end

    for i, matchData in ipairs(g) do
        if not matchData[5] and (matchData[1] == userTeamId or matchData[2] == userTeamId) then
            print("✅ QuickTour: Pertandingan ditemukan di indeks:", i)
            currentPlayedMatchIndex = i
            
            local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
            local roundName = ""
            if matchData[7] then
                roundName = matchData[9]
            elseif matchData[8] then
                roundName = "GROUP " .. matchData[9]
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
            
            print("⚽ QuickTour: Menyiapkan data pertandingan...")
            print("   -> Nama Turnamen:", currentTourData.tourName)
            print("   -> Ronde Saat Ini:", currentTourData.roundName)
			print("✅ QuickTour: Mengirim tourId '" .. tostring(tourId) .. "' ke layar berikutnya.")
			
            self.nav.Event(nil, "evt_advance")
            return
        end
    end
    
    print("⚠️ QuickTour: Tidak ada pertandingan yang tersedia untuk tim Anda.")
end

function QuickTour:PlayReStart()

    QuickTourGrouping = {}
    GroupStandings = {}
    currentTourInfo = {}
    currentTourData = {}
    TeamPlayerCache = {}
    TournamentStats = {}
    GOALS = {}
    
    GroupStageTeams = {}

    currentPlayedMatchIndex = nil
    GlobalTournamentSettings.tourId = nil 
    self.tourData.isFinish = false
	self.simulationInProgress = false
    self.tourData.championCrest.id = 0
    currentSimulationPhase = 0
    matchesToSimulate = {}
    currentMatchIndex = 0
	
 self.nav.Event(nil, "evt_show_popup", {
    title = "RESTART", message = "Are you sure you want to restart the tournament?",
    buttons = {
      { label = "Cancel", icon = "$FooterIconNo", label = "Cancel", clickEvents = { "evt_hide_popup" } },
      { label = "Confirm", icon = "$FooterIconYes", label = "Confirm", clickEvents = { "evt_force_reset_tournament", "evt_hide_popup" } }
    }
 })
end

function QuickTour:Belum()
    self.nav.Event(nil, "evt_show_popup", {
        title = "INFO",
        message = "We're working on it. \nPlease check back for upcoming updates.",
        buttons = {
            {
                icon = "$FooterIconYes",
                label = "OK",
                clickEvents = { "evt_hide_popup" }
            }
        }
    })
end

function QuickTour:StopMatch() self:SimulateRestOfTournament() end
function QuickTour:GetTeamRealScore(a, b, allowDraw)
    local ai = self.services.SquadManagementService.GetTeamInfo(a)
    local bi = self.services.SquadManagementService.GetTeamInfo(b)

    local sa, sb = math.random(0, 5), math.random(0, 5)
    local diff = (ai.overall or 75) - (bi.overall or 75)
    local bias = 50 + (diff * 2)

    -- bias kemenangan
    if math.random(1, 100) <= bias then
        if sa < sb then sa, sb = sb, sa end
    else
        if sb < sa then sa, sb = sb, sa end
    end

    -- ❗ JANGAN paksa menang jika allowDraw = true
    if sa == sb and not allowDraw then
        if math.random(1, 100) <= bias then
            sa = sa + 1
        else
            sb = sb + 1
        end
    end

    local r = {}
    r[a] = sa
    r[b] = sb
    return r
end

function QuickTour:SaveMatchResult()
    local tourId = GlobalTournamentSettings.tourId or 1
    local group = QuickTourGrouping[tourId]
    if not group then return end

    print("Recalculating all group standings...")
    GroupStandings[tourId] = {}

    for _, m in ipairs(group) do
        if m[8] and m[5] then
            local home, away, hs, as = m[1], m[2], m[3], m[4]
            local groupName = "GROUP " .. m[9]
            
            if not GroupStandings[tourId][groupName] then
                GroupStandings[tourId][groupName] = {}
            end
            local g = GroupStandings[tourId][groupName]

            for _, tid in ipairs({home, away}) do
                if not g[tid] then
                    g[tid] = { teamId = tid, played = 0, win = 0, draw = 0, loss = 0, goalsFor = 0, goalsAgainst = 0, points = 0 }
                end
            end
            
            local hstat = g[home]; local astat = g[away]
            hstat.played = hstat.played + 1
            astat.played = astat.played + 1
            hstat.goalsFor = hstat.goalsFor + hs
            hstat.goalsAgainst = hstat.goalsAgainst + as
            astat.goalsFor = astat.goalsFor + as
            astat.goalsAgainst = astat.goalsAgainst + hs
            
            if hs > as then 
                hstat.win = hstat.win + 1
                astat.loss = astat.loss + 1
                hstat.points = hstat.points + 3
            elseif as > hs then 
                astat.win = astat.win + 1
                hstat.loss = hstat.loss + 1
                astat.points = astat.points + 3
            else 
                hstat.draw = hstat.draw + 1
                astat.draw = astat.draw + 1
                hstat.points = hstat.points + 1
                astat.points = astat.points + 1
            end
        end
    end
    print("Standings recalculation complete.")
end

function QuickTour:SimulateRestOfTournament(forceSim) -- TAMBAH PARAMETER forceSim
    local tourId = GlobalTournamentSettings.tourId or 1
    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID

    print("⚠️ Simulating rest of tournament... (forceSim: " .. tostring(forceSim) .. ")")
    local simulationLimit = 60 -- Tingkatkan limit simulasi agar tidak berhenti terlalu cepat
    local count = 0
    
    while not self.tourData.isFinish and count < simulationLimit do
        
        -- 1. Cek Pertandingan Group Stage
        local groupMatchesLeft = false
        if QuickTourGrouping[tourId] then 
            for _, m in ipairs(QuickTourGrouping[tourId]) do 
                if m[8] and not m[5] then 
                    -- Hentikan simulasi jika itu match user (kecuali forceSim true)
                    if not forceSim and (m[1] == userTeamId or m[2] == userTeamId) then
                        print("🚫 Simulation paused: Next match is user's match (Group Stage).")
                        return 
                    end
                    groupMatchesLeft = true; 
                    break 
                end 
            end
        end
        
        if groupMatchesLeft then 
            self:SimulateCurrentMatchday()
        else
            -- 2. Cek Pertandingan Knockout Stage
            local knockoutMatchesLeft = false
            if QuickTourGrouping[tourId] then 
                for _, m in ipairs(QuickTourGrouping[tourId]) do 
                    if m[7] and not m[5] then 
                        -- Hentikan simulasi jika itu match user (kecuali forceSim true)
                        if not forceSim and (m[1] == userTeamId or m[2] == userTeamId) then
                            print("🚫 Simulation paused: Next match is user's match (Knockout Stage).")
                            return
                        end
                        knockoutMatchesLeft = true; 
                        break 
                    end 
                end
            end
            
            if knockoutMatchesLeft then 
                self:SimulateCurrentKnockoutRound() 
            else
                -- 3. Turnamen Selesai
                if QuickTourGrouping[tourId] and #QuickTourGrouping[tourId] > 0 then
                    local final = QuickTourGrouping[tourId][#QuickTourGrouping[tourId]]
                    if final and final[9] == "Final" and final[5] then
                        self.tourData.championCrest.id = final[6]
                        self.tourData.isFinish = true
                        print("✅ Simulation complete. Champion: " .. final[6])
                    end
                else 
                    self.tourData.isFinish = true; 
                end
                
                if self.tourData.isFinish then break end
            end
        end
        count = count + 1
    end
    self:publishChampion()
end

function QuickTour:ResetTournament()
    print("--- FULL TOURNAMENT RESET ---")

    QuickTourGrouping = {}
    GroupStandings = {}
    currentTourInfo = {}
    currentTourData = {}
    TeamPlayerCache = {}
    TournamentStats = {}
    GOALS = {}
    
    GroupStageTeams = {}

    currentPlayedMatchIndex = nil
    GlobalTournamentSettings.tourId = nil 
    self.tourData.isFinish = false
	self.simulationInProgress = false
    self.tourData.championCrest.id = 0
    currentSimulationPhase = 0
    matchesToSimulate = {}
    currentMatchIndex = 0
    self.nav.Event(nil, "evt_force_reset_tournament")
end

function QuickTour:finalize()

    self.im.UnregisterAction(ACT_END); self.im.UnregisterAction(ACT_RESTART)
    self.im.UnregisterAction(ACT_ADVANCE)
    self.im.UnregisterAction(ACT_BELUM)
	self.im.UnregisterAction("act_ads") 
    self.im.Publish(BND_PANEL_LOADING, false)
    self.im.Unsubscribe(BND_PANEL_LOADING)

    for _, b in ipairs({ BND_ADS_A_VISIBLE, BND_ADS_B_VISIBLE, BND_COLOR_CUPID, BND_REALTIME,BND_DATE,BND_LAST_MATCH_RESULT, BND_HUB_ACTIONS_VISIBLE, "bnd_bg_tour", "bnd_tour_logo", "bnd_trophy", "bnd_ads", "bnd_match_visible","bnd_group_label", "bnd_home_crest", "bnd_away_crest", "bnd_home_team", "bnd_away_team", "bnd_home_team_short", "bnd_away_team_short", "bnd_text", "bnd_champion_visible", "bnd_champion_crest", "bnd_champion_team", "bnd_home_score", "bnd_away_score", "bnd_tour_label" }) do self.im.Unsubscribe(b) end
    for _, v in pairs(bndList) do self.im.Unsubscribe(v) end
end

return QuickTour