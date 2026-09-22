-- Mod By MVN PROD --
-- League Mode Devision --
-- REMOD BY MOUNTSA --
local PlayerAge, Brain, data = ...
local matchesPerRound = math.floor(#TeamList / 2)
local Liga = {}

local bndmatchscore = "bnd_match_score"
local bndMatchFixtures = "bnd_Match_Fixtures"
local bndTeamCrest = "bnd_team_crest"
local bndTeamName = "bnd_team_name"
local bndmatchstanding = "bnd_match_standing"
local bndTableCareer = "bnd_table_career"
local ACT_ADVANCE = "act_advance"
local ACT_EXIT = "act_exit"
local BND_REALTIME = "bnd_realtime"
local PROGRESS = "act_progressdate"
local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local BND_TAB4_VISIBLE = "bnd_tab4_visible"
local BND_TAB5_VISIBLE = "bnd_tab5_visible"
local ACT_A = "act_a"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5

ligaId = 1
mode = 1

-- 🔹 DAFTAR ID LIGA & PEMETAAN

local LeagueIDs = {
  {ids={13,1925,14,110,18,19,5,2,10,144,1,11,1799,1943,1808,7,9,8,1796,106,126990},compID=13}, -- Premier League
  {ids={1860,449,457,243,461,240,241,453,448,450,483,110062,481,479,463,480,452,110827,1853,468},compID=53}, -- La Liga
  {ids={52,46,347,55,1842,110556,206,110374,39,48,44,54,45,189,50,1745,47,110738,111974,111434},compID=31}, -- Serie A
  {ids={175,38,112172,23,36,32,1831,21,100409,1824,25,111235,22,110329,10029,169,31,28},compID=19}, -- Bundesliga
  {ids={65,69,76,219,73,66,64,74,1738,72,71,1530,57,378,379,1809,217,111817},compID=16}, -- Ligue 1
  {ids={155600, 155607, 155609, 155606, 155611, 155614, 155621, 155604, 155602, 155630, 155603, 155612, 155616, 155617, 155620, 155624, 155601, 155615, 155610, 155618},compID=2235}, -- BRI liga 1
  {ids={681,1750,670,100081,229,100087,110724,230,673,680,231,674,232,2014,537,675},compID=12}, -- Pro League  
  {ids={15,97,1800,1919,109,1960,1952,1807,1794,1806,12,3,1795,1792,19521,1790,91,1801,88,1951,1947,17,94,95,89},compID=14}, -- EFL Championship 
  {ids={634,1913,245,1903,247,1910,100632,1908,246,100646,1906,1915,1914,100634,1904,645,1971},compID=15}, -- Eredivisie
  {ids={111140,114161,697,114640,111928,639,688,112828,694,691,113149,112893,114162,112885,687,112134,101112,112996,112606,111651,698,111065,696,689,111139,111138,695,111144,113018,115243},compID=39}, -- Mls
  {ids={112392,112390,112408,111674,112096,112139,113057,112883,112393,113060,113217,607,113037,605,112387,112391,121735,112675,139485,113222},compID=350} -- Spl   
}

local LeagueMap = {}
for _,v in ipairs(LeagueIDs)do
  for _,id in ipairs(v.ids)do
    LeagueMap[id] = v.compID
  end
end
LeagueMap[-1] = 0

-- 🔹 FUNGSI UMUM UNTUK AMBIL ID LIGA
local function getLeague(teamID, name)
  return { name = name, id = LeagueMap[teamID] or 0 }
end

function getLeagueBackgroundByTeam(teamID)
  return getLeague(teamID, "$LeagueBG")
end

function getLeagueTableAllByTeam(teamID)
  return getLeague(teamID, "$TableAllCareer")
end

function getLeagueTableByTeam(teamID)
  return getLeague(teamID, "$TableCareer")
end

function getLeagueStandingsByTeam(teamID)
  return getLeague(teamID, "$Logo_Standing")
end

function getLeagueTabCupByTeam(teamID)
  return getLeague(teamID, "$Tab_Liga")
end

function getLeagueButtonLigaByTeam(teamID)
  return getLeague(teamID, "$Button_Liga")
end

function getLeaguePitchLigaByTeam(teamID)
  return getLeague(teamID, "$Pitch_Liga")
end

function getLeagueTabColorByTeam(teamID)
  return getLeague(teamID, "$Tab_Color")
end

function getLeagueSearchingColorByTeam(teamID)
  return getLeague(teamID, "$Searching_Color")
end

function getLeagueLogoByTeam(teamID)
  return getLeague(teamID, "$LogoStandings")
end

function getLeagueLogotableByTeam(teamID)
  return getLeague(teamID, "$LogoTable")
end

if not loaded then
  loaded = "no"
else
  loaded = loaded
end

currentMatch = {
  HomeTeamID = 0,
  AwayTeamID = 0,
  HomeKitIndex = 0,
  AwayKitIndex = 1,
  isUserSideHome = 0 -- Tambahkan baris ini
}
-- Dev2
local rivalListData = {}
local matchesPlayed = 0
local matchday = false
local autoAdvance = false
local currentAdvanceDate = nil

function Liga:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    settingsService = o.api("SettingsService"),
    SquadManagementService = o.api("SquadMgtService")
}
  o.brain = Brain:new()
  o.models = {
   PlayerAge = PlayerAge:new({
      api = o.api,
      loc = o.loc,
      nav = o.nav
    })
}

  o.currentOptions = o.services.settingsService.GetCurrentOptions()

  o.isAdvancingDate = false 
  o.dateAdvanceTimer = 0 
  o.dateAdvanceDelay = 20

  o:Init()

  o.Banner= {
    name = "$Ads",
    id = 1
  }
local maxBanner = 5
math.randomseed(os.time() + os.clock() * 1000)
o.Banner = { name = "$Ads", id = 1 }
o.im.Subscribe("bnd_ads", function()
  o.Banner.id = math.random(1, maxBanner)
  o.im.Publish("bnd_ads", o.Banner)
end)   
  o.im.Subscribe(BND_REALTIME, function()
    local currentTime = os.date("")
    local state = currentTime    
      o.im.Publish(BND_REALTIME, state)   
  end)
  
  o.im.Subscribe(bndmatchscore, function()
     o:publishMatchRows()
  end)
  
-- 🔹 O.IM SUBSCRIBE EVENT
o.im.Subscribe("bnd_leaguebackground", function()
  local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_leaguebackground", bg)
end)
  
o.im.Subscribe("bnd_tab_cup", function()
  local tc = getLeagueTabCupByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_tab_cup", tc)
end)

o.im.Subscribe("bnd_button_liga", function()
  local bt = getLeagueButtonLigaByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_button_liga", bt)
end)

o.im.Subscribe("bnd_tab_color", function()
  local c = getLeagueTabColorByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_tab_color", c)
end)

o.im.Subscribe("bnd_logoleague", function()
  local ll = getLeagueLogoByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_logoleague", ll)
end)
  
   o.im.Subscribe(bndmatchstanding, function()
     o:publishMatchRows2()
  end)
  
  o.im.Subscribe(bndMatchFixtures, function()
     o:publishMatchRows3()
  end)
  
  o.im.Subscribe(bndTeamCrest, function()  
    o.im.Publish(bndTeamCrest, {name = "$Crest64x64", id = currentSelectedTeamID})   
  end)
  
  o.im.Subscribe(bndTeamName, function()  
        o.im.Publish(bndTeamName, o.loc.LocalizeString("TeamName_Abbr15_"..currentSelectedTeamID))       
    end)
  
  o.im.Subscribe("bnd_match_label", function()
    o:publishMatchLabel()
  end)
  
  o.im.Subscribe("bnd_epl_visible", function()
    o:publishBg()
  end)
  
  o.im.Subscribe("bnd_point_label", function()
    o:publishMatchLabel()
  end)
  
  o.im.RegisterAction(ACT_ADVANCE, function()
    o:GetBack()
  end)
  o.im.RegisterAction(ACT_EXIT, function(actionName, data)
    o:exitCareer()
  end)
  
  o.im.Subscribe("bnd_finish_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_finance", function()
    o:publishFinance()
  end)
  
  o.im.Subscribe("bnd_financeextra", function()
    o:publishFinance()
  end)
  
  o.im.Subscribe("bnd_date_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_home_team_pos_marginLeft", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_away_team_pos_marginLeft", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_rank_home", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_rank_away", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_team_crest_home", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_team_crest_away", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_logo_checkmark", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_short_name_team_home", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_short_name_team_away", function()
    o:publishFinishLabel()
  end)
  o.im.Subscribe("bnd_abbr_name_team_home", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_abbr_name_team_away", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_checkmark_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_matchup_label", function()
    o:publishFinishLabel()
  end)

  o.im.Subscribe("bnd_fifa16", function()
    o:publishFinishLabel()
  end)

  o.im.Subscribe("bnd_next_label", function()
    o:publishFinishLabel()
  end)  
  
  o.im.Subscribe("bnd_matchdate_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_matchtag", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_league_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_advance_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_month_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.RegisterAction(ACT_ADVANCE, function(actionName, data)
    if data then
      o:PlayMatch(data)
    end
  end)
  o.im.RegisterAction(PROGRESS, function(actionName, data)
    o:NoMatch()
  end)
  o:fitnessRecovery(GLOBAL_DATE_PLACEHOLDER)
  
  o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5 }
  
  o.im.Subscribe(BND_TAB1_VISIBLE, function()
  end)
  
  o.im.Subscribe(BND_TAB2_VISIBLE, function()
  end)
  
  o.im.Subscribe(BND_TAB3_VISIBLE, function()
  end)
  
  o.im.Subscribe(BND_TAB4_VISIBLE, function()
  end)
  
  o.im.Subscribe(BND_TAB5_VISIBLE, function()
  end)
  
  o:HideSelections()
  o.im.Publish(BND_TAB1_VISIBLE, true)
  
  o.im.RegisterAction(ACT_A, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1 then
      o.im.Publish(BND_TAB1_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2 then
      o.im.Publish(BND_TAB2_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB3 then
      o.im.Publish(BND_TAB3_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB4 then
      o.im.Publish(BND_TAB4_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB5 then
      o.im.Publish(BND_TAB5_VISIBLE, true)
    end
  end)    

  return o
end
------------------------------------------------------------------------------------------

function Liga:publishBg()
  self.im.Publish("bnd_epl_visible", self.eplvisible)
end

function Liga:update(elapsedTime)
    if not self.isAdvancingDate then
        return
    end
	--- MOUNTSA ---
    self.dateAdvanceTimer = self.dateAdvanceTimer - 1

    if self.dateAdvanceTimer <= 0 then
        self:AdvanceOneDayAndCheck()
        
        self.dateAdvanceTimer = self.dateAdvanceDelay
    end
end

function Liga:AdvanceOneDayAndCheck()
    local day, month, year, newDate = self:AdvanceDate()
	--- MOUNTSA ---
    self:publishFinishLabel() 
    self:fitnessRecovery(newDate)
    self:publishFinance()

    -- Refresh standings setiap hari maju (menghindari lag 1)
    pcall(function() self:publishMatchLabel() end)

    if matchday == true then
        print("Matchday found on: " .. newDate .. ". Stopping animation.")
        self.isAdvancingDate = false
        self:PlayMatch()
    end
    if (day == 3 and month == 6) or (day == 2 and month == 6) then
        self:SeasonEnd()
        self.isAdvancingDate = false
    end
end


function Liga:Init()
  local LigaGroupingList = LigaGrouping[ligaId]
  for i = 1, table.getn(LigaGroupingList) do
    local obj = {
      homeID = LigaGroupingList[i][1],
      awayID = LigaGroupingList[i][2],
      homeScore = LigaGroupingList[i][4],
      awayScore = LigaGroupingList[i][5],
      
      clickAction = "act_advance",
      isUnlock = LigaGroupingList[i][9],
      data = {}
    }
    table.insert(rivalListData, obj)
  end
end

-----------------------------------------------------------------------------------------
function Liga:fitnessRecovery(currentDate)
    -- Get the lineup for the current selected team
    local lineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, currentSelectedTeamID, 0)
    local teamPlayers = {}  -- Cache player names from the current team for quick lookup
    if lineup then
        for _, player in ipairs(lineup) do
            teamPlayers[player.playerName] = true  -- Store player names as keys
        end
    end

    -- Check each injured player
    for playerName, recoveryDate in pairs(injuryRecoveryDate) do
        if self:isDateReached(currentDate, recoveryDate) then
            isSuspended[playerName] = 0  -- Remove suspension
            injuryRecoveryDate[playerName] = nil  -- Clear record
            -- Only call backFromInjury if the player is from currentSelectedTeamID
            if teamPlayers[playerName] then
                self:backFromInjury(playerName)
            end
        end
    end
end

function Liga:isDateReached(currentDate, recoveryDate)
    local function parseDate(dateStr)
        local d, m, y = dateStr:match("(%d%d)/(%d%d)/(%d%d)")
        return os.time({ day = tonumber(d), month = tonumber(m), year = 2000 + tonumber(y) })  
    end

    return parseDate(currentDate) >= parseDate(recoveryDate)
end
------------------------------------------------------------------------------------------
function Liga:publishMatchRows2()
  local teamDataList = {}

  for _, teamID in ipairs(TeamList) do
    local teamData = {}
    teamData.TeamCrest = {
      name = "$Crest64x64",
      id = teamID
    }
    teamData.TeamName = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID)
    teamData.TeamWin = tostring(GetTeamWins(teamID))
    teamData.TeamDraw = tostring(GetTeamDraws(teamID))
    teamData.TeamPoint = tonumber(GetTeamPoints(teamID)) -- Convert to number for sorting
    teamData.TeamLoss = tostring(GetTeamLosses(teamID))
    teamData.TeamGA = tonumber(GetTeamGoalsScored(teamID)) -- Convert for calculations
    teamData.TeamGC = tonumber(GetTeamGoalsConceded(teamID)) -- Convert for calculations
    teamData.TeamGD = teamData.TeamGA - teamData.TeamGC -- Calculate Goal Difference
    teamData.Teammp = GLOBAL_MATCHUP_COUNT
    teamData.clickAction = "ViewTeamDetails_" .. teamID

    teamData.TeamScoreFontColor = "0xffffff"
    teamData.TeamNameFontColor = "0xffffff"
    teamData.FontColor = "0xffffff"
    teamData.Icon = {
      name = "$IconTeam",
      id = teamID
    }
    teamData.RightText = ""

    table.insert(teamDataList, {data = teamData})
  end

  table.sort(teamDataList, function(a, b)
    -- Primary sort: Points (descending)
    if a.data.TeamPoint ~= b.data.TeamPoint then
      return a.data.TeamPoint > b.data.TeamPoint
    end

    if a.data.TeamGD ~= b.data.TeamGD then
      return a.data.TeamGD > b.data.TeamGD
    end

    return a.data.TeamName < b.data.TeamName
  end)

  local allZeroPoints = true
  for _, team in ipairs(teamDataList) do
    if team.data.TeamPoint > 0 then
      allZeroPoints = false
      break
    end
  end

  if allZeroPoints then
    table.sort(teamDataList, function(a, b)
      return a.data.TeamName < b.data.TeamName
    end)
  end

  for i, team in ipairs(teamDataList) do
    team.data.Teampos = tostring(i) .. ""
  end

  self.im.Publish(bndmatchstanding, teamDataList)
end
------------------------------------------------------------------------------------------
function Liga:publishMatchRows()
    if GLOBAL_MATCHUP_COUNT == 0 then
        print("[Liga:publishMatchRows]: GLOBAL_MATCHUP_COUNT is zero. No matches to process.")
        self:NoScorer()
        return
    end

    local filteredRivalListData = {}

    local combinedLineup = {}
    for _, teamID in ipairs(TeamList) do
        local lineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)
        if lineup and #lineup > 0 then
            for _, player in ipairs(lineup) do
                player.teamID = teamID
                table.insert(combinedLineup, player)
            end
        end
    end

    if #combinedLineup == 0 then
        print("[Liga:publishMatchRows]: Combined lineup for TeamList is empty or invalid.")
        self:Empty()
        return
    end

    local function countPlayerGoals(CARD_ID)
        local totalGoals = 0
        local maxMatches = GLOBAL_MATCHUP_COUNT * 10

        for i, match in ipairs(rivalListData or {}) do
            if i > maxMatches then break end

            for _, scorer in ipairs(match.homeScorers or {}) do
                if scorer == CARD_ID then
                    totalGoals = totalGoals + 1
                end
            end

            for _, scorer in ipairs(match.awayScorers or {}) do
                if scorer == CARD_ID then
                    totalGoals = totalGoals + 1
                end
            end
        end
        return totalGoals
    end
    
    for _, player in ipairs(combinedLineup) do
        local normalGoals = countPlayerGoals(player.CARD_ID)
        local additionalGoals = GOALS[player.CARD_ID] or 0
        player.goalCount = normalGoals + additionalGoals
    end

    table.sort(combinedLineup, function(a, b)
        return a.goalCount > b.goalCount
    end)

    local topPlayers = {}
    for i = 1, math.min(50, #combinedLineup) do
        table.insert(topPlayers, combinedLineup[i])
    end

    for rank, player in ipairs(topPlayers) do
        local playerName = player.playerName
        local position = tostring(player.position)
        local rating = tostring(player.rating)
        local teamName = self.loc.LocalizeString("TeamName_Abbr3_" .. player.teamID)

        local row = {
            data = {
                PlayerName = playerName,
                Position = position,
                Rating = rating,
                TeamName = teamName,
                Goals = player.goalCount,
                Rank = tostring(rank) .. "",
                PlayerHead = {
                    name = "$Head",
                    id = player.CARD_ID
                },
                TeamCrest = {
                    name = "$Crest64x64",
                    id = player.teamID
                },
                Nationality = {
                    name = "$Flag128x128",
                    id = player.nationalityID
                },
            }
        }
        table.insert(filteredRivalListData, row)
    end

    self.im.Publish(bndmatchscore, filteredRivalListData)

    -- Segera perbarui standings/label setelah match score berubah
    -- (menghindari delay 1 match sebelum UI standing ter-update)
    pcall(function() self:publishMatchLabel() end)
end

------------------------------------------------------------------------------------------

function Liga:publishMatchRows3()
  local filteredRivalListData = {}

  for i, v in ipairs(rivalListData) do

      v.data.TeamHomeCrest = {
        name = "$Crest64x64",
        id = rivalListData[i].homeID
      }
      v.data.TeamAwayCrest = {
        name = "$Crest64x64",
        id = rivalListData[i].awayID
      }
      v.data.TeamHomeName = self.loc.LocalizeString("TeamName_Abbr3_"..rivalListData[i].homeID)
      v.data.TeamAwayName = self.loc.LocalizeString("TeamName_Abbr3_"..rivalListData[i].awayID)

    local maxRowsWithScores = GLOBAL_MATCHUP_COUNT * 10

    if i <= maxRowsWithScores then

        rivalListData[i].data.MatchScore = rivalListData[i].homeScore .. "  -  " .. rivalListData[i].awayScore -- Append scores
    else
        rivalListData[i].data.MatchScore = "VS"
    end

      v.data.TeamScoreFontColor = "0xffffff"
      v.data.TeamNameFontColor = "0x4A2C6D"
      v.data.FontColor = "0x4A2C6D"

      if not rivalListData[i].isUnlock then
        v.data.Icon = { name = "$", id = 1 }
        v.data.RightText = ""
      else
        v.data.Icon = { name = "$", id = 2 }
        v.data.RightText = ""
      end

      table.insert(filteredRivalListData, v)
    end
  
  self.im.Publish(bndMatchFixtures, filteredRivalListData)

  -- Pastikan label standing ikut ter-refresh jika fixtures / skor berubah
  pcall(function() self:publishMatchLabel() end)
end

function GetLeagueFromTeam(teamID)
    for i, team in ipairs(gTeams) do
        if team.id == teamID then
            return team.leagueID
        end
    end
    return 0
end

function updateTeamFormCache()
    if GLOBAL_MATCHUP_COUNT < 5 then
        return
    end
    TeamFormCache = {}
    for _, teamID in ipairs(TeamList) do
        TeamFormCache[teamID] = { wins = 0, draws = 0, losses = 0 }
    end
        
    local matchesPerDay = matchesPerRound -- 使用上面定义的变量9.15
    local currentMatchday = GLOBAL_MATCHUP_COUNT + 1
    local startMatchday = math.max(1, currentMatchday - 5)
    local startIndex = (startMatchday - 1) * matchesPerDay + 1
    local endIndex = (currentMatchday - 1) * matchesPerDay
    for i = startIndex, endIndex do
        local matchData = LigaGrouping[ligaId][i]
        if matchData then
            local homeID = matchData[1]
            local awayID = matchData[2]
            local homeScore = matchData[4]
            local awayScore = matchData[5]
            if TeamFormCache[homeID] then
                if homeScore > awayScore then
                    TeamFormCache[homeID].wins = TeamFormCache[homeID].wins + 1
                elseif homeScore == awayScore then
                    TeamFormCache[homeID].draws = TeamFormCache[homeID].draws + 1
                else
                    TeamFormCache[homeID].losses = TeamFormCache[homeID].losses + 1
                end
            end
            if TeamFormCache[awayID] then
                if awayScore > homeScore then
                    TeamFormCache[awayID].wins = TeamFormCache[awayID].wins + 1
                elseif awayScore == homeScore then
                    TeamFormCache[awayID].draws = TeamFormCache[awayID].draws + 1
                else
                    TeamFormCache[awayID].losses = TeamFormCache[awayID].losses + 1
                end
            end
        end
    end
end

function Liga:publishMatchLabel()
    local targetTeamIDs = TeamList
    local teamStats = {}

    for _, teamID in ipairs(targetTeamIDs) do
        teamStats[teamID] = {wins = 0, draws = 0, losses = 0, points = 0, goalsScored = 0, goalsConceded = 0, matchesCount = 0}
    end

    for _, match in ipairs(rivalListData) do
        local homeID = match.homeID
        local awayID = match.awayID
        local homeScore = match.homeScore
        local awayScore = match.awayScore

        for _, teamID in ipairs({homeID, awayID}) do
            if teamStats[teamID] and teamStats[teamID].matchesCount < GLOBAL_MATCHUP_COUNT then
                local isHome = teamID == homeID
                local score = isHome and homeScore or awayScore
                local opponentScore = isHome and awayScore or homeScore

                teamStats[teamID].goalsScored = teamStats[teamID].goalsScored + score
                teamStats[teamID].goalsConceded = teamStats[teamID].goalsConceded + opponentScore
                teamStats[teamID].matchesCount = teamStats[teamID].matchesCount + 1

                if score > opponentScore then
                    teamStats[teamID].wins = teamStats[teamID].wins + 1
                    teamStats[teamID].points = teamStats[teamID].points + 3
                elseif score == opponentScore then
                    teamStats[teamID].draws = teamStats[teamID].draws + 1
                    teamStats[teamID].points = teamStats[teamID].points + 1
                else
                    teamStats[teamID].losses = teamStats[teamID].losses + 1
                end
            end
        end
    end

    function GetTeamPoints(teamID)
        return teamStats[teamID].points or 0
    end

    function GetTeamWins(teamID)
        return teamStats[teamID].wins or 0
    end

    function GetTeamDraws(teamID)
        return teamStats[teamID].draws or 0
    end

    function GetTeamLosses(teamID)
        return teamStats[teamID].losses or 0
    end

    function GetTeamGoalsScored(teamID)
        return teamStats[teamID].goalsScored or 0
    end

    function GetTeamGoalsConceded(teamID)
        return teamStats[teamID].goalsConceded or 0
    end

    for _, teamID in ipairs(TeamList) do

        local points, _ = GetTeamPoints(teamID)

        local wins, _ = GetTeamWins(teamID)

        local draws, _ = GetTeamDraws(teamID)

        local losses, _ = GetTeamLosses(teamID)

        local goalsScored, _ = GetTeamGoalsScored(teamID)  -- Get goals scored for team

        local goalsConceded, _ = GetTeamGoalsConceded(teamID)  -- Get goals conceded for team

        teamStats[teamID] = {

            points = points,

            wins = wins,

            draws = draws,

            losses = losses,

            goalsScored = goalsScored,

            goalsConceded = goalsConceded

        }
    end

    local sortedTeams = {}

    for teamID, stats in pairs(teamStats) do

        table.insert(sortedTeams, {teamID = teamID, stats = stats})

    end

    table.sort(sortedTeams, function(a, b)

    if a.stats.points == b.stats.points then

        local aGD = a.stats.goalsScored - a.stats.goalsConceded

        local bGD = b.stats.goalsScored - b.stats.goalsConceded

        if aGD == bGD then

            if a.stats.goalsScored == b.stats.goalsScored then

                local aName = self.loc.LocalizeString("TeamName_Abbr15_" .. a.teamID)

                local bName = self.loc.LocalizeString("TeamName_Abbr15_" .. b.teamID)

                return aName < bName

            else
                return a.stats.goalsScored > b.stats.goalsScored  -- More goals scored is better when GD is equal

            end
        else
            return aGD > bGD
        end
    else
        return a.stats.points > b.stats.points
    end
end)
    local rankingsLabel = "\n"
    local pointsLabel = ""
    local gsLabel = ""
    local gcLabel = ""
    for position = 1, math.min(5, #sortedTeams) do
        local team = sortedTeams[position]

        TM1 = sortedTeams[1].teamID 
	    TM2 = sortedTeams[2].teamID 
	    TM3 = sortedTeams[3].teamID 
	    TM4 = sortedTeams[4].teamID 
	    TM5 = sortedTeams[5].teamID 
	    TM6 = sortedTeams[6].teamID 
	    TM7 = sortedTeams[7].teamID 
	    TM8 = sortedTeams[8].teamID 
	    TM9 = sortedTeams[9].teamID 
	    TM10 = sortedTeams[10].teamID 
	    TM18 = sortedTeams[18].teamID 
    	TM19 = sortedTeams[19].teamID 
    	TM20 = sortedTeams[20].teamID 
        local teamName = self.loc.LocalizeString("TeamName_Abbr15_" .. team.teamID)
        rankingsLabel = rankingsLabel .. position .. ". " .. teamName .. "\n"

        pointsLabel = pointsLabel .. team.stats.points .. "\n"

        gsLabel = gsLabel .. team.stats.goalsScored .. "\n"

        gcLabel = gcLabel .. team.stats.goalsConceded .. "\n"

    end

    if sortedTeams[18] then
        local teamID18 = sortedTeams[18].teamID

        GLOBAL_PLACEHOLDER_REL1 = teamID18
    else
        GLOBAL_PLACEHOLDER_REL1 = 9
    end
    if sortedTeams[19] then
        local teamID19 = sortedTeams[19].teamID

        GLOBAL_PLACEHOLDER_REL2 = teamID19
    else
        GLOBAL_PLACEHOLDER_REL2 = "No team at 19th position"
    end
    if sortedTeams[20] then
        local teamID20 = sortedTeams[20].teamID
        GLOBAL_PLACEHOLDER_REL3 = teamID20
    else
        GLOBAL_PLACEHOLDER_REL3 = "No team at 20th position"
    end

    self.im.Publish("bnd_match_label", rankingsLabel)

    self.im.Publish("bnd_point_label", pointsLabel)
    self.GetTeamPoints = GetTeamPoints
    self.GetTeamWins = GetTeamWins
    self.GetTeamDraws = GetTeamDraws
    self.GetTeamLosses = GetTeamLosses
    self.GetTeamGoalsScored = GetTeamGoalsScored
    self.GetTeamGoalsConceded = GetTeamGoalsConceded

    -- sync lastMatchupCount dengan GLOBAL_MATCHUP_COUNT untuk mencegah 'lag 1'
    lastMatchupCount = GLOBAL_MATCHUP_COUNT or lastMatchupCount
end

lastMatchupCount = GLOBAL_MATCHUP_COUNT or 0

local DAYS_IN_MONTH = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

local function isLeapYear(year)
    return year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)
end

local function getDaysInMonth(month, year)
    if month == 2 and isLeapYear(year) then
        return 29
    end
    return DAYS_IN_MONTH[month]
end

local function isValidDate(day, month, year)
    if not (day and month and year) then return false end
    if month < 1 or month > 12 then return false end
    local maxDays = getDaysInMonth(month, year)
    return day >= 1 and day <= maxDays
end

local function isValidMatchDateYY(dateStr)
    if not dateStr or not dateStr:match("^%d%d%d%d%d%d$") then return false end
    local month, day, year = dateStr:match("^(%d%d)(%d%d)(%d%d)$")
    month, day, year = tonumber(month), tonumber(day), tonumber(year)
    if not (month and day and year) then return false end
    if month < 1 or month > 12 or day < 1 or year < 0 or year > 99 then return false end
    local maxDays = getDaysInMonth(month, year)
    return day <= maxDays
end

function Liga:formatFunds(funds)
    if funds >= 1e6 then
        local m = funds / 1e6
        return m < 10 and ("$%.2fM"):format(m) or ("$%.1fM"):format(m):gsub("%.0M", "M")
    elseif funds >= 1e3 then
        return ("$%dK"):format(funds / 1e3)
    else
        return "$" .. funds
    end
end

function Liga:publishFinance()
    self.im.Publish("bnd_finance", self:formatFunds(GLOBAL_FUNDS))
    if revenue.totalRevenue then
      self.im.Publish("bnd_financeextra", "+ " .. self:formatFunds(revenue.totalRevenue))
    end
end

function Liga:publishFinishLabel()
	--- Remod MOUNTSA ---
    self.im.Publish("bnd_date_label", "")
    self.im.Publish("bnd_month_label", "")
    self.im.Publish("bnd_matchup_label", "")
    self.im.Publish("bnd_matchdate_label", "")
    self.im.Publish("bnd_short_name_team_home", "")
    self.im.Publish("bnd_short_name_team_away", "")
    self.im.Publish("bnd_abbr_name_team_home", "") 
    self.im.Publish("bnd_abbr_name_team_away", "") 
    self.im.Publish("bnd_logo_league", {name = "$", id = 0})
    self.im.Publish("bnd_team_crest_home", {name = "$", id = 0})
    self.im.Publish("bnd_team_crest_away", {name = "$", id = 0})
    self.im.Publish("bnd_checkmark_label", "")
    self.im.Publish("bnd_logo_checkmark", {name = "$", id = 0})
    -- =================================================================
    local dateString = GLOBAL_DATE_PLACEHOLDER or "01/08/24"
    if not dateString:match("^%d%d/%d%d/%d%d$") then
        print("Warning: Invalid GLOBAL_DATE_PLACEHOLDER '" .. tostring(dateString) .. "', using default '01/08/24'")
        dateString = "01/08/24"
    end
    
    if not dateString:match("^%d%d/%d%d/%d%d$") then
    print("Warning: Invalid GLOBAL_DATE_PLACEHOLDER '" .. tostring(dateString) .. "', using default '01/08/24'")
    dateString = "01/08/24"
    end

    local day, month, year = dateString:match("(%d%d)/(%d%d)/(%d%d)")
    local fullYear = "20" .. year
    local timeTable = { day = tonumber(day), month = tonumber(month), year = tonumber(fullYear), hour = 0, min = 0, sec = 0 }
    local time = os.time(timeTable)
    local formattedDate = os.date("%A, %b %d", time)
    local prevTime = time - 86400
    local prevDate = os.date("%A, %b %d", prevTime)
    local nextTime = time + 86400
    local nextDate = os.date("%A, %b %d", nextTime)

    local currentDay, currentMonth, currentYear = tonumber(day), tonumber(month), tonumber(year)
    if not isValidDate(currentDay, currentMonth, currentYear) then
        dateString = "01/08/24"
        currentDay, currentMonth, currentYear = 1, 8, 24
    end

    local mmddyy = string.format("%02d%02d%02d", currentMonth, currentDay, currentYear)
    local isExcludedDate = false
    for _, date in ipairs(matchDates or {}) do
        if mmddyy == date then
            isExcludedDate = true
            break
        end
    end

    local nextDays = {}
    for i = 1, 4 do
        local nextDay, nextMonth, nextYear = currentDay + i, currentMonth, currentYear
        if nextDay > getDaysInMonth(nextMonth, nextYear) then
            nextDay = nextDay - getDaysInMonth(nextMonth, nextYear)
            nextMonth = nextMonth + 1
            if nextMonth > 12 then
                nextMonth = 1
                nextYear = nextYear + 1
            end
        end
        table.insert(nextDays, nextDay)
    end

    local displayDays = string.format(
        "%02d                                        %02d                    %02d                    %02d                    %02d",
        currentDay, nextDays[1], nextDays[2], nextDays[3], nextDays[4]
    )

    local monthNames = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
    local currentMonthName = monthNames[currentMonth] or "Unknown"

local function ordinal(n)
    local suffix = "TH"
    if n % 100 < 11 or n % 100 > 13 then
        local lastDigit = n % 10
        if lastDigit == 1 then
            suffix = "ST"
        elseif lastDigit == 2 then
            suffix = "ND"
        elseif lastDigit == 3 then
            suffix = "RD"
        end
    end
    return tostring(n) .. suffix
end

-- 🔹 Hitung margin kiri (opsional buat UI teks)
local function calculateMarginLeft(teamName, fontSize)
    local avgWidth = fontSize * 0.7
    return math.floor(#teamName * avgWidth) + 20
end

-- ============================================================
-- 🔹 Ambil peringkat tim
-- ============================================================
function getTeamRank(teamID)
    local stats = {}
    local teamIndex = {}

    for i, id in ipairs(TeamList) do
        teamIndex[id] = i
        table.insert(stats, {
            id  = id,
            pts = tonumber(GetTeamPoints(id)) or 0,
            gd  = (tonumber(GetTeamGoalsScored(id)) or 0) - (tonumber(GetTeamGoalsConceded(id)) or 0),
            ga  = tonumber(GetTeamGoalsScored(id)) or 0,
        })
    end

    local allZero = true
    for _, t in ipairs(stats) do
        if t.pts ~= 0 or t.gd ~= 0 or t.ga ~= 0 then
            allZero = false
            break
        end
    end

    if allZero then
        table.sort(stats, function(a, b)
            return teamIndex[a.id] < teamIndex[b.id]
        end)
    else
        table.sort(stats, function(a, b)
            if a.pts ~= b.pts then
                return a.pts > b.pts
            elseif a.gd ~= b.gd then
                return a.gd > b.gd
            elseif a.ga ~= b.ga then
                return a.ga > b.ga
            else
                return teamIndex[a.id] < teamIndex[b.id]
            end
        end)
    end

    for rank, t in ipairs(stats) do
        if t.id == teamID then
            return ordinal(rank)  -- 🔹 pakai fungsi ordinal di sini
        end
    end

    return "-"
end


    local matchupInfo = ""
    local globalMatchupCount = GLOBAL_MATCHUP_COUNT or 0
    local matchupIndex = 0
    local matchupInfoHomeAbbr, matchupInfoAwayAbbr 
    
    for i, v in ipairs(rivalListData or {}) do
        if v.homeID == currentSelectedTeamID or v.awayID == currentSelectedTeamID then
            if matchupIndex == globalMatchupCount then
                            -- Nama & rank sekarang
            local homeName     = self.loc.LocalizeString("TeamName_Abbr15_" .. v.homeID)            
            local awayName     = self.loc.LocalizeString("TeamName_Abbr15_" .. v.awayID)
            local homeAbbrName = self.loc.LocalizeString("TeamName_Abbr3_" .. v.homeID)    
            local awayAbbrName = self.loc.LocalizeString("TeamName_Abbr3_" .. v.awayID)  

            local homeRank = getTeamRank(v.homeID)    
            local awayRank = getTeamRank(v.awayID)    

            -- Status sekarang
            matchupInfo  = (v.homeID == currentSelectedTeamID) and "Home" or "Away"    
            matchupInfo2 = homeName 
            matchupInfo3 = awayName
            matchupInfo4 = homeRank
            matchupInfo5 = awayRank
            
            
                IDHome = v.homeID
                IDAway = v.awayID
                IDLeague = currentSelectedTeamID
                matchupInfoHomeAbbr = homeAbbrName
                matchupInfoAwayAbbr = awayAbbrName
                break
            end
            matchupIndex = matchupIndex + 1
        end
    end

    if isExcludedDate and matchupInfo ~= "" then
    -- Match day
    self.im.Publish("bnd_matchup_label", matchupInfo)
    self.im.Publish("bnd_formatted_Date", formattedDate)
    local homeMargin = calculateMarginLeft(matchupInfo2, 25)
    local awayMargin = calculateMarginLeft(matchupInfo3, 25)

       self.im.Publish("bnd_short_name_team_home", matchupInfo2)
       self.im.Publish("bnd_short_name_team_away", matchupInfo3)
       self.im.Publish("bnd_rank_home", matchupInfo4)
       self.im.Publish("bnd_rank_away", matchupInfo5)

        self.im.Publish("bnd_realtime", os.date("%H:%M %p"))
        self.im.Publish("bnd_matchdate_label", formattedDate)
        self.im.Publish("bnd_home_team_pos_marginLeft", homeMargin)
        self.im.Publish("bnd_away_team_pos_marginLeft", awayMargin)
        self.im.Publish("bnd_abbr_name_team_home", matchupInfoHomeAbbr)
        self.im.Publish("bnd_abbr_name_team_away", matchupInfoAwayAbbr)
        self.im.Publish("bnd_fifa16", "$Logo_garis")         
        self.im.Publish("bnd_next_label", "Next Match Schedule,")       
        self.im.Publish("bnd_logo_league", {name = "$LogoStandings", id = IDLeague})
        self.im.Publish("bnd_team_crest_home", {name = "$Crest", id = IDHome})
        self.im.Publish("bnd_team_crest_away", {name = "$Crest", id = IDAway})
        self.im.Publish("bnd_league_label", os.Date)
        self.im.Publish("bnd_matchtag", os.Date)
        self.im.Publish("bnd_advance_label", "Advance")
        matchday = true
    else
        -- Non-match day: show calendar info
        self.im.Publish("bnd_date_label", displayDays)        
        self.im.Publish("bnd_checkmark_label", "PRE-SEASON TOURNAMENT INVITE")
        self.im.Publish("bnd_logo_checkmark", "$Logo_No_Schedule")
        self.im.Publish("bnd_next_label", "Next Match Schedule,")           
        self.im.Publish("bnd_matchdate_label", formattedDate)
        self.im.Publish("bnd_league_label", prevDate)
        self.im.Publish("bnd_matchtag", nextDate)
        self.im.Publish("bnd_advance_label", "Advance")
        matchday = false
    end
end


function Liga:AdvanceDate()
	--- MOUNTSA ---
    if not GLOBAL_DATE_PLACEHOLDER or not GLOBAL_DATE_PLACEHOLDER:match("^%d%d/%d%d/%d%d$") then
        error("Invalid GLOBAL_DATE_PLACEHOLDER format: " .. tostring(GLOBAL_DATE_PLACEHOLDER))
    end

    local day, month, year = GLOBAL_DATE_PLACEHOLDER:match("(%d%d)/(%d%d)/(%d%d)")
    day, month, year = tonumber(day), tonumber(month), tonumber(year)

    if not isValidDate(day, month, year) then
        error("Invalid date: " .. GLOBAL_DATE_PLACEHOLDER)
    end

    if day == 31 and month == 8 and year == 24 then
        day, month = 1, 9
    else
        day = day + 1
        if day > getDaysInMonth(month, year) then
            day = 1
            month = month + 1
            if month > 12 then
                month = 1
                year = year + 1
            end
        end
    end

    local newDate = string.format("%02d/%02d/%02d", day, month, year)
    if GLOBAL_DATE_PLACEHOLDER ~= newDate then
        GLOBAL_DATE_PLACEHOLDER = newDate
        print("New Date: " .. newDate)
    end

    return day, month, year, newDate
end

function Liga:NoMatch()
    if matchday == true then
        self:PlayMatch()
        return
    end
	--- MOUNTSA ---
    if self.isAdvancingDate then
        return
    end

    self.isAdvancingDate = true
    self.dateAdvanceTimer = 0
end

-- Function to play a match
function Liga:PlayMatch()       
        -- Find match for the current team9.15
        local startIndex = (GLOBAL_MATCHUP_COUNT * matchesPerRound) + 1
        local endIndex = startIndex + (matchesPerRound - 1)
        local foundMatchIndex
        for i = startIndex, endIndex do
            local matchData = LigaGrouping[ligaId][i]
            if matchData and (matchData[1] == currentSelectedTeamID or matchData[2] == currentSelectedTeamID) then
                foundMatchIndex = i
                break
            end
        end

        if not foundMatchIndex then
            print("No match found involving currentSelectedTeamID in indexes " .. startIndex .. "-" .. endIndex)
            return
        end

        local currentMatchData = LigaGrouping[ligaId][foundMatchIndex]
        currentLigaData.Index = ligaId
        currentLigaData.round = foundMatchIndex
        currentLigaData.homeID = currentMatchData[1]
        currentLigaData.awayID = currentMatchData[2]
        currentLigaData.difficulty = currentMatchData[7]
        currentMatch.MatchType = "Epl"
        currentMatch.HomeTeamID = currentMatchData[1]
        currentMatch.AwayTeamID = currentMatchData[2]
		currentMatch.isUserSideHome = (currentMatch.HomeTeamID == currentSelectedTeamID) and 0 or 1
        local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, currentSelectedTeamID, 0)
        if not players then
            error("Failed to retrieve player lineup")
        end
        for i = 1, 18 do
            local playerID = players[i].CARD_ID
            if isSuspended[playerID] == 1 or isSuspended[playerID] == 2 then
                self:Ineligible()
                return
            end
        end
  self:KickOff()
end
-----------------------------------------------------------------------------------------
function Liga:KickOff()
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {
      "evt_advance",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "Do You Want To Play Match ?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
  if not matchdayLoaded[GLOBAL_MATCHUP_COUNT + 1] then
    self.brain:simSys(GLOBAL_MATCHUP_COUNT + 1)
  end
end

function Liga:SeasonEnd()
  local buttonYes = {
    icon = "$FooterIconNo",
    label = "Close",
    clickEvents = {
      "evt_hide_popup",
      "evt_restart"
    }
  }
  local popupData = {
    title = "END SEASON",
    message = "Mission mode has being completed, \n End season",
    buttons = {buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function Liga:Ineligible()
  local buttonYes = {
    icon = "$FooterIconNo",
    label = "Close",
    clickEvents = {
      "evt_hide_popup",
      "evt_squad"
    }
  }
  local popupData = {
    title = "SQUAD IS INELIGIBLE",
    message = "Your squad has an ineligible player. \n Fix in Team Management",
    buttons = {buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function Liga:backFromInjury(playerName)
  local buttonYes = {
    icon = "$general_help_squads_icon",
    label = "Close",
    clickEvents = {
      "evt_hide_popup",
      "evt_squad"
    }
  }
  local popupData = {
    title = "PLAYER BACK",
    message = playerName .. " is back from injury",
    buttons = {buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function Liga:exitCareer()
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup",
      "evt_back",
      "evt_back",
      "evt_back"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {
    	"evt_hide_popup",
    "evt_savegame"
    }
  }
  local popupData = {
    title = "EXIT CAREER",
    message = "Do you want to save your progress before you leave",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function Liga:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)
  self.im.Publish(BND_TAB3_VISIBLE, false)
  self.im.Publish(BND_TAB4_VISIBLE, false)
  self.im.Publish(BND_TAB5_VISIBLE, false)
end

function Liga:finalize()
  self.im.UnregisterAction(ACT_ADVANCE)
  self.models.PlayerAge:finalize()
  self.models.FaCup:finalize()
  self.models.Help:finalize()
  self.im.Unsubscribe("bnd_match_score")
  self.im.Unsubscribe("bnd_Match_Fixtures")
  self.im.Unsubscribe("bnd_match_label")
  self.im.Unsubscribe("bnd_point_label")
  self.im.Unsubscribe("bnd_date_label")
  self.im.Unsubscribe("bnd_match_standing")
  self.im.Unsubscribe("bnd_matchup_label")
  self.im.Unsubscribe("bnd_home_team_pos_marginLeft")
  self.im.Unsubscribe("bnd_away_team_pos_marginLeft")
  self.im.Unsubscribe("bnd_matchtag")
  self.im.Unsubscribe("bnd_fifa16")  
  self.im.Unsubscribe("bnd_next_label")    
  self.im.Unsubscribe("bnd_matchdate_label")
  self.im.Unsubscribe("bnd_league_label")
  self.im.Unsubscribe("bnd_advance_label")
  self.im.Unsubscribe("bnd_month_label")
  self.im.Unsubscribe("bnd_finish_label")
  self.im.Unsubscribe("bnd_rank_home")
  self.im.Unsubscribe("bnd_rank_away")
  self.im.Unsubscribe(BND_REALTIME)      
  self.im.Unsubscribe(BND_TAB1_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_VISIBLE)
  self.im.Unsubscribe(BND_TAB3_VISIBLE)
  self.im.Unsubscribe(BND_TAB4_VISIBLE)
  self.im.Unsubscribe(BND_TAB5_VISIBLE)
  self.im.UnregisterAction(ACT_A)      
  rivalListData = {}
end

return Liga

-- Thanks : Ma'ruf Id & Laosiji --
-- REMOD BY MOUNTSA --
-- @mvnprod.official - Remain Be Creative --