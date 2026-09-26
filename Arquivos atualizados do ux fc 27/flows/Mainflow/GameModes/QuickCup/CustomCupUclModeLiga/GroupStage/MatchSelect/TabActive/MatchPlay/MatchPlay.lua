-- MOUNTSA - FULL TOURNAMENT SYSTEM
QuickTour = {}
local BND_COLOR_CUPID = "bnd_color_tourid" 
local BND_ADS_A_VISIBLE = "bnd_ads_a_visible"
local BND_ADS_B_VISIBLE = "bnd_ads_b_visible"
local BND_BUSY_STATE_VISIBLE = "bnd_busy_state_visible"
local BND_LAST_MATCH_RESULT = "bnd_last_match_result"
local BND_MATCH_TIME = "bnd_match_time"
local BND_HUB_ACTIONS_VISIBLE = "bnd_hub_actions_visible"
local ACT_END = "act_end"
local ACT_ADVANCE = "act_advance"
local ACT_CUSTOMIZE = "act_customize"
local ACT_RESTART = "act_restart"
local ACT_BELUM = "act_belum"
local BND_REALTIME = "bnd_realtime"
local BND_CURRENT_ROUND = "bnd_current_round"
local BND_PANEL_LOADING = "bnd_panel_loading"
local bnd2DHomeKit = "bnd_2d_home_kit"
local bnd2DAwayKit = "bnd_2d_away_kit"
local BND_HOME_SIDE_ICON = "bnd_home_side_icon"
local BND_AWAY_SIDE_ICON = "bnd_away_side_icon"
local BND_TAB1 = "bnd_tab1"
local BND_TAB2 = "bnd_tab2"
local BND_TAB3 = "bnd_tab3"
local BND_TAB4 = "bnd_tab4"
local BND_TAB5 = "bnd_tab5"
local BND_TAB6 = "bnd_tab6"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5
local TAB6 = 6
local ACT_BTN_CLICK = "act_btn_click"
local currentSimulationPhase = 0 -- 0: tidak simulasi, 1: simulasi tim user, 2: simulasi AI
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

local tourIdToRefereeNameMap = {
    [1]  = "Clément Turpin",
    default = "Default Referee"
}

local tourIdToNameMap = {
    [1] = "UEFA Champions League", default = "Custom Tournament"
}

local tourIdToColorMap = {
  [1]="0x000026",
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

    o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5, TAB6 }
  o.im.Subscribe(BND_TAB1, function()
  end)
  o.im.Subscribe(BND_TAB2, function()
  end)
  o.im.Subscribe(BND_TAB3, function()
  end)
    o.im.Subscribe(BND_TAB4, function()
  end)
    o.im.Subscribe(BND_TAB5, function()
  end)
      o.im.Subscribe(BND_TAB6, function()
  end)
  
  
    o:HideSelections()
  o.im.Publish(BND_TAB1, true)
  o.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1 then
      o.im.Publish(BND_TAB1, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2 then
      o.im.Publish(BND_TAB2, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB3 then
      o.im.Publish(BND_TAB3, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB4 then
      o.im.Publish(BND_TAB4, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB5 then
      o.im.Publish(BND_TAB5, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB6 then
      o.im.Publish(BND_TAB6, true)
    end
  end)
  
    print("QuickTour Initialized for Tour: " .. tournamentDisplayName .. " (ID: "..tostring(tourId)..")")
    return o
end

function QuickTour:HideSelections()
  self.im.Publish(BND_TAB1, false)
  self.im.Publish(BND_TAB2, false)
  self.im.Publish(BND_TAB3, false)
  self.im.Publish(BND_TAB4, false)
  self.im.Publish(BND_TAB5, false)
  self.im.Publish(BND_TAB6, false)
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

    self.im.Subscribe(bnd2DHomeKit, function() end)
    self.im.Subscribe(bnd2DAwayKit, function() end)
	
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
   self.im.Subscribe(BND_REALTIME, function() self.im.Publish(BND_REALTIME, os.date("%I:%M %p")) end)
    
    self.im.Subscribe(BND_MATCH_TIME, function()
        local halfLength = self.currentOptions.halfLengthData or "6 minutes"
        local currentDate = os.date("%d %B %Y")
        local stadiumName = self.currentOptions.stadium or "Default Stadium"
        local weather = self.currentOptions.weather or "Clear"
        local refereeName = "Referee: ".. tourIdToRefereeNameMap[tourId] or "Default Referee"
        local currentHour = tonumber(os.date("%H"))
		local difficult = self.currentOptions.difficulty or "Legendary"
        local dynamicTimeOfDay
        if currentHour >= 5 and currentHour < 12 then
            dynamicTimeOfDay = "Morning"
        elseif currentHour >= 12 and currentHour < 18 then
            dynamicTimeOfDay = "Afternoon"
        else
            dynamicTimeOfDay = "Night"
        end
		local line1 = string.format("%s | %s | %s | %s", stadiumName, currentDate, refereeName, difficult )
		local line2 = string.format("%s | %s | %s", halfLength, dynamicTimeOfDay, weather)
		local matchTimeString = line1 .. "\n" .. line2
        self.im.Publish(BND_MATCH_TIME, matchTimeString)
    end)
    self.im.Subscribe("bnd_home_score", function() self:publishMatchInfo() end)
    self.im.Subscribe("bnd_away_score", function() self:publishMatchInfo() end)
    self.im.Subscribe("bnd_tour_label", function() self:publishMatchInfo() end)
    self.im.Subscribe(BND_ADS_A_VISIBLE, function() self.im.Publish(BND_ADS_A_VISIBLE, self.isAdsVisible) end)
    self.im.Subscribe(BND_ADS_B_VISIBLE, function() self.im.Publish(BND_ADS_B_VISIBLE, not self.isAdsVisible) end)
    for _, v in ipairs(bndList) do self.im.Subscribe(v, function() self:InitOptions() end) end
    for _, k in ipairs({"bnd_home_side_icon","bnd_away_side_icon","bnd_user_side_icon", "bnd_match_visible", "bnd_home_crest", "bnd_away_crest", "bnd_home_team", "bnd_away_team","bnd_group_label", "bnd_home_team_short", "bnd_away_team_short", "bnd_team_crest", "bnd_team_name" }) do self.im.Subscribe(k, function() self:publishMatchInfo() end) end
    for _, k in ipairs({"bnd_text", "bnd_champion_visible", "bnd_champion_crest", "bnd_champion_team"}) do self.im.Subscribe(k, function() self:publishChampion() end) end
end

function QuickTour:setupActions()
    self.im.RegisterAction(ACT_ADVANCE, function() self:PlayMatch() end)
    self.im.RegisterAction(ACT_CUSTOMIZE, function() self:CustomizeMatch() end)
    self.im.RegisterAction(ACT_RESTART, function() self:PlayReStart() end)
    self.im.RegisterAction(ACT_BELUM, function() self:Belum() end)
    self.im.RegisterAction(ACT_END, function() self:ResetTournament() end)
	self.im.RegisterAction("act_simulate", function()
    if self.simulationInProgress then
        print("⏳ Simulasi sedang berjalan...")
        return
    end

    self.simulationInProgress = true

    local tourId = GlobalTournamentSettings.tourId or 1
    local userTeamId = currentTourInfo[tourId] and currentTourInfo[tourId].homeID
    local group = QuickTourGrouping[tourId]
    
    local currentRoundIdentifier, isKnockoutRound, userMatchFound = nil, false, false
    for _, match in ipairs(group) do
        if not match[5] and (match[1] == userTeamId or match[2] == userTeamId) then
            isKnockoutRound = match[7]
            currentRoundIdentifier = isKnockoutRound and match[9] or match[10]
            userMatchFound = true
            break
        end
    end

    if not userMatchFound then
        print("ℹ️ Tidak ada jadwal Anda. Mensimulasikan sisa turnamen...")
        self:SimulateRestOfTournament()
        self.simulationInProgress = false -- Jangan lupa reset flag di sini
        return
    end

    print("▶️ Mensimulasikan Ronde/Matchday: " .. tostring(currentRoundIdentifier))

    for _, match in ipairs(group) do
        local isMatchInCurrentRound = (isKnockoutRound and match[9] == currentRoundIdentifier) or (not isKnockoutRound and match[10] == currentRoundIdentifier)
        if not match[5] and isMatchInCurrentRound and not (isKnockoutRound and (match[1] == userTeamId or match[2] == userTeamId)) then
            local scores = self:GetTeamRealScore(match[1], match[2])
            match[3], match[4], match[5] = scores[match[1]], scores[match[2]], true
            match[6] = (match[3] > match[4]) and match[1] or (match[4] > match[3]) and match[2] or 0
            
            local homePlayers = TeamPlayerCache[tourId] and TeamPlayerCache[tourId][match[1]] or {}
            local awayPlayers = TeamPlayerCache[tourId] and TeamPlayerCache[tourId][match[2]] or {}
            if #homePlayers > 0 then for _, p in ipairs(homePlayers) do self:RecordPlayerStats(p.CARD_ID, {appearance = 1}) end end
            if #awayPlayers > 0 then for _, p in ipairs(awayPlayers) do self:RecordPlayerStats(p.CARD_ID, {appearance = 1}) end end
            if #homePlayers > 0 and match[3] > 0 then for _ = 1, match[3] do self:RecordPlayerStats(homePlayers[math.random(#homePlayers)].CARD_ID, {goals = 1}) end end
            if #awayPlayers > 0 and match[4] > 0 then for _ = 1, match[4] do self:RecordPlayerStats(awayPlayers[math.random(#awayPlayers)].CARD_ID, {goals = 1}) end end
        end
    end
    
    self:SaveMatchResult()
    
    local isCurrentRoundFinished = true
    for _, m in ipairs(group) do
        local isMatchInThisRound = (isKnockoutRound and m[9] == currentRoundIdentifier) or (not isKnockoutRound and m[10] == currentRoundIdentifier)
        if isMatchInThisRound and not m[5] then isCurrentRoundFinished = false; break; end
    end

    if isCurrentRoundFinished then
        if isKnockoutRound then
            local winners = {}
            for _, m in ipairs(group) do if m[9] == currentRoundIdentifier then table.insert(winners, m[6]) end end
            if #winners > 0 then self:GenerateNextKnockoutRound(winners) end
        else
            local allGroupDone = true
            for _, m in ipairs(group) do if m[8] and not m[5] then allGroupDone = false; break; end end
            if allGroupDone then self:GenerateKnockoutFromGroupStandings() end
        end
    end
    
    self.simulationInProgress = false
    self:publishMatchInfo()
    print("✅ Simulasi ronde selesai.")
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

function QuickTour:publish2DKit(binding, teamId, kitType)
    if not teamId or teamId == 0 then return end
    local kitId = string.format("%s_%s_%s", kitType, teamId, 0)
    self.im.Publish(binding, {name = "$Kits", id = kitId})
end

function QuickTour:publishMatchInfo()
    self:SimulatePastMatchdays()
    local tourId = GlobalTournamentSettings.tourId or 1
    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    if self.tourData.isFinish then self:publishChampion(); return end
    
   -- self.im.Publish(BND_PANEL_LOADING, true)
    if not QuickTourGrouping or not QuickTourGrouping[tourId] or not currentTourInfo[tourId] then
        self.im.Publish("bnd_text", "Loading tournament data...")
    --    self.im.Publish(BND_PANEL_LOADING, false)
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
            
            self:publish2DKit(bnd2DHomeKit, match[1], currentMatch.HomeKitIndex or 0)
            self:publish2DKit(bnd2DAwayKit, match[2], currentMatch.AwayKitIndex or 1)


            if userTeamId == match[1] then
                self.im.Publish(BND_HOME_SIDE_ICON, "$UserHome")
                self.im.Publish(BND_AWAY_SIDE_ICON, nil)
            else
                self.im.Publish(BND_HOME_SIDE_ICON, nil)
                self.im.Publish(BND_AWAY_SIDE_ICON, "$UserAway")
            end
			
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
            local currentRound = "Unknown Stage"
            for _, m in ipairs(g) do
                if m[7] and not m[5] then 
                    currentRound = m[9]
                    break
                end
            end
            self.im.Publish("bnd_text", "Eliminated in " .. currentRound)
            self.im.Publish(BND_USER_SIDE_ICON, nil)
            self:StopMatch()
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

            local scores = self:GetTeamRealScore(homeId, awayId)
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
    if #teams < 2 then
        if #teams == 1 then 
            print("🏆 Final match winner determined. Tournament ends.")
        else 
            print("⚠️ Not enough teams for next round: " .. #teams)
        end
        return
    end
    
    local currentRoundName = ""
    for i = #QuickTourGrouping[tourId], 1, -1 do 
        if QuickTourGrouping[tourId][i][7] then 
            currentRoundName = QuickTourGrouping[tourId][i][9]
            break
        end 
    end
    
    local nextRoundName = ""
    if currentRoundName == "Round of 16" then 
        nextRoundName = "Quarter Final"
    elseif currentRoundName == "Quarter Final" then 
        nextRoundName = "Semi Final"
    elseif currentRoundName == "Semi Final" then 
        nextRoundName = "Final"
    else 
        print("❌ Unknown or final round: " .. tostring(currentRoundName))
        return
    end
    
    print("🔀 Generating " .. nextRoundName .. " with " .. #teams .. " teams")
    self:ShuffleArray(teams)
    
    for i = 1, #teams, 2 do
        if teams[i] and teams[i+1] then
            table.insert(QuickTourGrouping[tourId], {
                teams[i], 
                teams[i+1], 
                0, 0, 
                false,
                0,
                true,
                false,
                nextRoundName, 
                1
            })
            print("⚽ Created match: " .. teams[i] .. " vs " .. teams[i+1] .. " (" .. nextRoundName .. ")")
        end
    end
    
    self:InitOptions()
    self:publishMatchInfo()
end

function QuickTour:GenerateKnockoutFromGroupStandings()
    local tourId = GlobalTournamentSettings.tourId or 1
    if not GroupStandings or not GroupStandings[tourId] then print("❌ ERROR: Group standings data not found for tourId: " .. tourId); return; end
    print("🔀 Generating knockout stage from group standings...")
    local standings = GroupStandings[tourId]
    local groupWinners, groupRunnersUp, groupNames = {}, {}, {}
    for groupName, _ in pairs(standings) do table.insert(groupNames, groupName) end
    table.sort(groupNames) 
    for _, groupName in ipairs(groupNames) do
        local groupData = standings[groupName]
        local teamsArray = {}
        for teamId, stats in pairs(groupData) do table.insert(teamsArray, stats) end
        table.sort(teamsArray, function(a, b)
            if a.points ~= b.points then return a.points > b.points end
            local diffA = a.goalsFor - a.goalsAgainst
            local diffB = b.goalsFor - b.goalsAgainst
            if diffA ~= diffB then return diffA > diffB end
            if a.goalsFor ~= b.goalsFor then return a.goalsFor > b.goalsFor end
            return a.teamId < b.teamId
        end)
        if #teamsArray >= 1 then table.insert(groupWinners, teamsArray[1].teamId) end
        if #teamsArray >= 2 then table.insert(groupRunnersUp, teamsArray[2].teamId) end
        print("🏆 Group " .. groupName .. " Winner: " .. (teamsArray[1] and teamsArray[1].teamId or "N/A") .. ", Runner-up: " .. (teamsArray[2] and teamsArray[2].teamId or "N/A"))
    end
    local knockoutMatches = {}
    self:ShuffleArray(groupRunnersUp) 
    for i = 1, #groupWinners do
        if groupWinners[i] and groupRunnersUp[i] then
            table.insert(knockoutMatches, { groupWinners[i], groupRunnersUp[i], 0, 0, false, 0, true, false, "Round of 16", 1 })
        end
    end
    for _, match in ipairs(knockoutMatches) do table.insert(QuickTourGrouping[tourId], match); end
    print("✅ Knockout stage created with " .. #knockoutMatches .. " matches")
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

    self:SaveMatchResult()
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
            local tourColor = tourIdToColorMap[tourId] or tourIdToColorMap.default
			
            local roundName = ""
            if matchData[7] then
                roundName = matchData[9]
            elseif matchData[8] then
                roundName = "GROUP " .. matchData[9]
            end

            currentTourData.homeID = matchData[1]
            currentTourData.awayID = matchData[2]
            currentTourData.isUserSideHome = (matchData[1] == userTeamId) and 0 or 1
            currentTourData.homeKitIndex = currentMatch.HomeKitIndex or 0
            currentTourData.awayKitIndex = currentMatch.AwayKitIndex or 1

            currentTourData.tourIndex = tourId
            currentTourData.tourName = tourName   -- Data nama turnamen
            currentTourData.roundName = roundName -- Data nama ronde
            currentTourData.tourColor = tourColor -- Data nama ronde

            currentMatch.HomeTeamID = matchData[1]
            currentMatch.AwayTeamID = matchData[2]
            
            print("⚽ QuickTour: Menyiapkan data pertandingan...")

            print("   -> Nama Turnamen:", currentTourData.tourName)
            print("   -> Ronde Saat Ini:", currentTourData.roundName)
			print("✅ QuickTour: Mengirim tourId '" .. tostring(tourId) .. "' ke layar berikutnya.")
			
            self:Advance()
            return
        end
    end
    
    print("⚠️ QuickTour: Tidak ada pertandingan yang tersedia untuk tim Anda.")
end

function QuickTour:Advance()
    local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup",
      "evt_refresh_on_resize"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  function buttonYes.clickCallback()
    self.nav.Event(nil, "evt_advance")
  end
  local popupData = {
    title = "Play Match",
    message = "Are you ready to start the match?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function QuickTour:CustomizeMatch()
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
            local tourColor = tourIdToColorMap[tourId] or tourIdToColorMap.default
			
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
            currentTourData.tourName = tourName   -- Data nama turnamen
            currentTourData.roundName = roundName -- Data nama ronde
            currentTourData.tourColor = tourColor -- Data nama ronde

            currentMatch.HomeTeamID = matchData[1]
            currentMatch.AwayTeamID = matchData[2]
            currentMatch.HomeKitIndex = 0
            currentMatch.AwayKitIndex = 1
            
            print("⚽ QuickTour: Menyiapkan data pertandingan...")
            print("   -> Nama Turnamen:", currentTourData.tourName)
            print("   -> Ronde Saat Ini:", currentTourData.roundName)
			print("✅ QuickTour: Mengirim tourId '" .. tostring(tourId) .. "' ke layar berikutnya.")
			
            self.nav.Event(nil, "evt_customize")
            return
        end
    end
    
    print("⚠️ QuickTour: Tidak ada pertandingan yang tersedia untuk tim Anda.")
end

function QuickTour:PlayReStart()
 self.nav.Event(nil, "evt_show_popup", {
    title = "RESTART", message = "Are you sure you want to restart the tournament?",
    buttons = {
      {  icon = "$FooterIconNo", label = "Cancel", clickEvents = { "evt_hide_popup" } },
      { icon = "$FooterIconYes", label = "Confirm", clickEvents = { "evt_force_reset_tournament", "evt_hide_popup" } }
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
function QuickTour:GetTeamRealScore(a, b)
    local ai = self.services.SquadManagementService.GetTeamInfo(a)
    local bi = self.services.SquadManagementService.GetTeamInfo(b)
    local sa, sb = math.random(0, 5), math.random(0, 5)
    local diff = (ai.overall or 75) - (bi.overall or 75)
    local bias = 50 + (diff * 2)
    if math.random(1, 100) <= bias then if sa < sb then sa, sb = sb, sa end
    else if sb < sa then sa, sb = sb, sa end; end
    if sa == sb then if math.random(1, 100) <= bias then sa = sa + 1 else sb = sb + 1 end; end
    local r = {}; r[a] = sa; r[b] = sb; return r
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

function QuickTour:SimulateRestOfTournament()
    local tourId = GlobalTournamentSettings.tourId or 1
    print("⚠️ Simulating rest of tournament...")
    local simulationLimit = 30
    local count = 0
    while not self.tourData.isFinish and count < simulationLimit do
        local groupMatchesLeft = false
        if QuickTourGrouping[tourId] then for _, m in ipairs(QuickTourGrouping[tourId]) do if m[8] and not m[5] then groupMatchesLeft = true; break; end; end; end
        if groupMatchesLeft then self:SimulateCurrentMatchday()
        else
            local knockoutMatchesLeft = false
            if QuickTourGrouping[tourId] then for _, m in ipairs(QuickTourGrouping[tourId]) do if m[7] and not m[5] then knockoutMatchesLeft = true; break; end; end; end
            if knockoutMatchesLeft then self:SimulateCurrentKnockoutRound()
            else
                if QuickTourGrouping[tourId] and #QuickTourGrouping[tourId] > 0 then
                    local final = QuickTourGrouping[tourId][#QuickTourGrouping[tourId]]
                    if final and final[9] == "Final" and final[5] then
                        self.tourData.championCrest.id = final[6]
                        self.tourData.isFinish = true
                        print("✅ Simulation complete. Champion: " .. final[6])
                    end
                else self.tourData.isFinish = true; end
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
    currentPlayedMatchIndex = nil
    GlobalTournamentSettings.tourId = nil 
    self.tourData.isFinish = false
	self.simulationInProgress = false
    self.tourData.championCrest.id = 0
    currentSimulationPhase = 0
    matchesToSimulate = {}
    currentMatchIndex = 1
    self.nav.Event(nil, "evt_force_reset_tournament")
end

function QuickTour:finalize()
    self.im.UnregisterAction(ACT_END); self.im.UnregisterAction(ACT_RESTART)
    self.im.UnregisterAction(ACT_ADVANCE)
    self.im.UnregisterAction(ACT_BELUM)
	self.im.UnregisterAction("act_ads") 
    self.im.Publish(BND_PANEL_LOADING, false)
    self.im.Unsubscribe(BND_PANEL_LOADING)

    for _, b in ipairs({ BND_ADS_A_VISIBLE, BND_ADS_B_VISIBLE, BND_COLOR_CUPID, BND_REALTIME,BND_LAST_MATCH_RESULT, BND_HUB_ACTIONS_VISIBLE, "bnd_bg_tour", "bnd_tour_logo", "bnd_trophy", "bnd_ads", "bnd_match_visible","bnd_group_label", "bnd_home_crest", "bnd_away_crest", "bnd_home_team", "bnd_away_team", "bnd_home_team_short", "bnd_away_team_short", "bnd_text", "bnd_champion_visible", "bnd_champion_crest", "bnd_champion_team", "bnd_home_score", "bnd_away_score", "bnd_tour_label" }) do self.im.Unsubscribe(b) end
    for _, v in pairs(bndList) do self.im.Unsubscribe(v) end
end

return QuickTour