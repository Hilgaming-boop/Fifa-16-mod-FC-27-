-- Mod By MVN PROD --
-- League Mode Devision --
-- REMOD BY MOUNTSA --
local PlayerAge, Brain, data = ...
-- ============================================================
-- 1. Hitung jumlah pertandingan per round (support tim ganjil)
-- ============================================================
local function calculateMatchesPerRound(teamList)
    local totalTeams = #teamList
    local isOdd = (totalTeams % 2 ~= 0)
    if isOdd then
        totalTeams = totalTeams + 1 -- tambahkan dummy "bye"
    end
    return math.floor(totalTeams / 2), isOdd
end

local matchesPerRound, hasOddTeam = calculateMatchesPerRound(TeamList)
local Liga = {}

local bndmatchscore = "bnd_match_score"
local bndMatchFixtures = "bnd_Match_Fixtures"
local bndTeamCrest = "bnd_team_crest"
local bndTeamName = "bnd_team_name"
local bndmatchstanding = "bnd_match_standing"
local bndadsstanding = "bnd_ads_standing"
local bndBackgroundCareer = "bnd_background_career"
local ACT_ADVANCE = "act_advance"
local ACT_EXIT = "act_exit"
local BND_REALTIME = "bnd_realtime"
local PROGRESS = "act_progressdate"
local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local ACT_SELECTED = "act_selected"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3

ligaId = 1
mode = 1

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
  o.dateAdvanceDelay = 30

  o:Init()

  o.Banner= {
    name = "$Ads",
    id = 0
  }
  
  math.randomseed(os.clock() * 1352 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(19)
  o.im.Subscribe("bnd_ads", function()
    o.Banner.id = random2
    o.im.Publish("bnd_ads", o.Banner)
  end)
  o.im.Subscribe(BND_REALTIME, function()
    local currentTime = os.date("%A, %h %d")
    local state = currentTime    
      o.im.Publish(BND_REALTIME, state)   
  end)
  
  o.im.Subscribe(bndmatchscore, function()
     o:publishMatchRows()
  end)
  
  o.im.Subscribe("bnd_background_career", function()
    o:publishFinishLabel()
  end)
  
   o.im.Subscribe(bndmatchstanding, function()
     o:publishMatchRows2()
  end)
  
  o.im.Subscribe(bndadsstanding, function()
     o:publishMatchRows6()
  end)
  
  o.buttonsID = { TAB1, TAB2, TAB3 }
  o.im.Subscribe(BND_TAB1_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB2_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB3_VISIBLE, function()
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
  
  o.im.Subscribe("bnd_day_date_marginLeft", function()
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
  
  o.im.Subscribe("bnd_crest_day2", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_crest_day3", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_crest_day4", function()
    o:publishFinishLabel()
  end)	
  
  o.im.Subscribe("bnd_crest_day5", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_logo_league", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_logo_league_rival", function()
    o:publishFinishLabel()
  end)
  
   o.im.Subscribe("bnd_table_career", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_league_color", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_color_action", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_table_league", function()
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
  
  o.im.Subscribe("bnd_name_day2", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_name_day3", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_name_day4", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_name_day5", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("match_up_Info_M2", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("match_up_Info_M3", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("match_up_Info_M4", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("match_up_Info_M5", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_checkmark_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_matchup_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_formatted_Date", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_next_Date", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_league_name", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_league_name_central", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_day_date", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_new_nixture", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_prev_Date", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_advance_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_month_label", function()
    o:publishFinishLabel()
  end)
  
  o:HideSelections()
  o.im.Publish(BND_TAB1_VISIBLE, true)
  o.im.RegisterAction(ACT_SELECTED, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1 then
      o.im.Publish(BND_TAB1_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2 then
      o.im.Publish(BND_TAB2_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB3 then
      o.im.Publish(BND_TAB3_VISIBLE, true)
    end
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

  return o
end

function Liga:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)
  self.im.Publish(BND_TAB3_VISIBLE, false)

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
    if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
        SelectedTeamID = currentSelectedTeamID
    elseif selectedteam and selectedteam ~= 0 then
        SelectedTeamID = TeamList[selectedteam]
    elseif currentMatch and currentMatch.HomeTeamID and currentMatch.HomeTeamID ~= 0 then
        SelectedTeamID = currentMatch.HomeTeamID
    end

    local teamStats = {}

    -- 🔹 Kumpulin semua data tim
    for _, teamID in ipairs(TeamList) do
        table.insert(teamStats, {
            id   = teamID,
            name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID), -- ambil nama tim buat sorting alfabet
            pts  = tonumber(GetTeamPoints(teamID)),
            gd   = tonumber(GetTeamGoalsScored(teamID)) - tonumber(GetTeamGoalsConceded(teamID)),
            ga   = tonumber(GetTeamGoalsScored(teamID)),
        })
    end

    -- 🔹 Cek apakah semua tim masih 0 poin, 0 GD, 0 GF
    local allZero = true
    for _, stat in ipairs(teamStats) do
        if stat.pts ~= 0 or stat.gd ~= 0 or stat.gf ~= 0 then
            allZero = false
            break
        end
    end

    -- 🔹 Urutkan standings
    if not allZero then
        table.sort(teamStats, function(a, b)
            if a.pts ~= b.pts then
                return a.pts > b.pts
            elseif a.gd ~= b.gd then
                return a.gd > b.gd
            elseif a.gf ~= b.gf then
                return a.gf > b.gf
            else
                return a.name < b.name
            end
        end)
    else
        -- 🚩 Kalau masih kosong semua, urutkan alfabet saja
        table.sort(teamStats, function(a, b)
            return a.name < b.name
        end)
    end

    -- 🔹 Rank label otomatis sesuai liga
    local leagueRankLabels = {
        -- contoh mapping: [1] = "Champion", [18] = "Relegation"
    }
    local rankLabels = leagueRankLabels[IDLeague] or {}

    -- 🔹 Generate daftar tim
    local teamDataList = {}
    for _, stat in ipairs(teamStats) do
        local teamID = stat.id
        local teamData = {}

        teamData.TeamCrest = { name = "$Crest64x64", id = teamID }
        teamData.TeamName = stat.name
        teamData.TeamWin = tostring(GetTeamWins(teamID))
        teamData.TeamDraw = tostring(GetTeamDraws(teamID))
        teamData.TeamLoss = tostring(GetTeamLosses(teamID))
        teamData.TeamPoint = stat.pts
        teamData.TeamGA = tonumber(GetTeamGoalsScored(teamID))   -- Goals For
        teamData.TeamGC = tonumber(GetTeamGoalsConceded(teamID)) -- Goals Against
        teamData.TeamGD = stat.gd                                -- Goal Difference
        teamData.Teammp = GLOBAL_MATCHUP_COUNT
        teamData.clickAction = "ViewTeamDetails_" .. teamID
        teamData.TeamScoreFontColor = "0xffffff"
        teamData.TeamNameFontColor = "0xffffff"
        teamData.FontColor = "0xffffff"

        if SelectedTeamID and teamID == SelectedTeamID then
            teamData.Icon = { name = "$my_team", id = teamID }
        else
            teamData.Icon = nil
        end

        table.insert(teamDataList, { data = teamData })
    end

    -- 🔹 Sorting utama (Points > GD > Goals For > Nama tim)
    table.sort(teamDataList, function(a, b)
        if a.data.TeamPoint ~= b.data.TeamPoint then
            return a.data.TeamPoint > b.data.TeamPoint
        end
        if a.data.TeamGD ~= b.data.TeamGD then
            return a.data.TeamGD > b.data.TeamGD
        end
        if a.data.TeamGA ~= b.data.TeamGA then
            return a.data.TeamGA > b.data.TeamGA
        end
        return a.data.TeamName < b.data.TeamName
    end)

    -- 🔹 Kalau semua poin = 0 → urutkan alfabet
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

    -- 🔹 Tambahkan posisi & label relegasi/juara sesuai rank
    for i, team in ipairs(teamDataList) do
        local pos = i
        team.data.Teampos = tostring(pos)

        local label = rankLabels[pos] or ""
        team.data.RelegationText = label
        team.data.RightText = ""

        -- Debug
        print(string.format(
            "[DEBUG] Team: %s | Posisi: %d | Label: %s",
            team.data.TeamName, pos, label
        ))
    end

    -- ============================================================
    -- 🔹 Filter hanya posisi 1–5
    -- ============================================================
    local top5List = {}
    for i, team in ipairs(teamDataList) do
        if i <= 4 then
            table.insert(top5List, team)
        end
    end

    -- 🔹 Publish ke UI (hanya top 5)
    self.im.Publish(bndmatchstanding, top5List)
end

function Liga:publishMatchRows6()
    if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
        SelectedTeamID = currentSelectedTeamID
    elseif selectedteam and selectedteam ~= 0 then
        SelectedTeamID = TeamList[selectedteam]
    elseif currentMatch and currentMatch.HomeTeamID and currentMatch.HomeTeamID ~= 0 then
        SelectedTeamID = currentMatch.HomeTeamID
    end

    local teamStats = {}

    -- 🔹 Kumpulin semua data tim
    for _, teamID in ipairs(TeamList) do
        table.insert(teamStats, {
            id   = teamID,
            name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID),
            pts  = tonumber(GetTeamPoints(teamID)),
            gd   = tonumber(GetTeamGoalsScored(teamID)) - tonumber(GetTeamGoalsConceded(teamID)),
            ga   = tonumber(GetTeamGoalsScored(teamID)),
        })
    end

    -- 🔹 Cek apakah semua tim masih 0 poin, 0 GD, 0 GF
    local allZero = true
    for _, stat in ipairs(teamStats) do
        if stat.pts ~= 0 or stat.gd ~= 0 or stat.gf ~= 0 then
            allZero = false
            break
        end
    end

    -- 🔹 Urutkan standings
    if not allZero then
        table.sort(teamStats, function(a, b)
            if a.pts ~= b.pts then
                return a.pts > b.pts
            elseif a.gd ~= b.gd then
                return a.gd > b.gd
            elseif a.gf ~= b.gf then
                return a.gf > b.gf
            else
                return a.name < b.name
            end
        end)
    else
        table.sort(teamStats, function(a, b)
            return a.name < b.name
        end)
    end

    local rankLabels = (leagueRankLabels and leagueRankLabels[IDLeague]) or {}

    -- 🔹 Generate daftar tim lengkap
    local teamDataList = {}
    for _, stat in ipairs(teamStats) do
        local teamID = stat.id
        local teamData = {}

        teamData.TeamCrest = { name = "$Crest64x64", id = teamID }
        teamData.TeamName = stat.name
        teamData.TeamWin = tostring(GetTeamWins(teamID))
        teamData.TeamDraw = tostring(GetTeamDraws(teamID))
        teamData.TeamLoss = tostring(GetTeamLosses(teamID))
        teamData.TeamPoint = stat.pts
        teamData.TeamGA = tonumber(GetTeamGoalsScored(teamID))
        teamData.TeamGC = tonumber(GetTeamGoalsConceded(teamID))
        teamData.TeamGD = stat.gd
        teamData.Teammp = GLOBAL_MATCHUP_COUNT
        teamData.clickAction = "ViewTeamDetails_" .. teamID
        teamData.TeamScoreFontColor = "0xffffff"
        teamData.TeamNameFontColor = "0xffffff"
        teamData.FontColor = "0xffffff"

        if SelectedTeamID and teamID == SelectedTeamID then
            teamData.Icon = { name = "$my_team", id = teamID }
        end

        table.insert(teamDataList, { data = teamData })
    end

    -- 🔹 Sorting utama (Points > GD > Goals For > Nama tim)
    table.sort(teamDataList, function(a, b)
        if a.data.TeamPoint ~= b.data.TeamPoint then
            return a.data.TeamPoint > b.data.TeamPoint
        end
        if a.data.TeamGD ~= b.data.TeamGD then
            return a.data.TeamGD > b.data.TeamGD
        end
        if a.data.TeamGA ~= b.data.TeamGA then
            return a.data.TeamGA > b.data.TeamGA
        end
        return a.data.TeamName < b.data.TeamName
    end)

    -- 🔹 Kalau semua poin = 0 → urutkan alfabet
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

    -- 🔹 Tambahkan posisi & label relegasi/juara sesuai rank
    for i, team in ipairs(teamDataList) do
        local pos = i
        team.data.Teampos = tostring(pos)
        local label = rankLabels[pos] or ""
        team.data.RelegationText = label
        team.data.RightText = ""
    end

    -- 🔹 Publish ke UI (semua tim)
    self.im.Publish(bndadsstanding, teamDataList)
end
-- ============================================
-- 📋 DAFTAR LIGA & TIM
-- ============================================
local leagueTeams = {
    [0] = {},
    [1] = {269, 270, 271, 819, 822, 1443, 1447, 1516, 1786, 1788, 15006, 272},
    [4] = {681, 1750, 670, 229, 100087, 110724, 230, 673, 680, 231, 674, 232, 2014, 537, 15005, 122231},
    [7] = {1629, 598, 1035, 111052, 517, 1048, 383, 567, 1598, 1041, 111041, 1719, 569, 568, 1043, 112472, 1053, 111059, 111057, 130361},
    [10] = {634, 1913, 245, 1903, 247, 1910, 100632, 1908, 246, 100646, 1906, 1915, 1914, 100634, 1904, 645, 1971, 100638},
    [13] = {13, 1925, 14, 110, 18, 19, 5, 2, 10, 144, 1, 11, 1799, 1943, 1808, 7, 9, 8, 1796, 106, 126987},
    [14] = {15, 97, 1800, 1919, 109, 1960, 1952, 1807, 1794, 1806, 12, 3, 1795, 1792, 1951, 1790, 91, 1801, 88, 1947, 17, 94, 95, 89},
    [16] = {65, 69, 76, 219, 73, 66, 64, 74, 1738, 72, 71, 1530, 57, 378, 1809, 217, 111817, 68},
    [17] = {379, 210, 62, 294, 1816, 111659, 1815, 115494, 58, 110321, 1814, 1805, 614, 67, 111273, 111276, 70, 1819},
    [19] = {175, 38, 112172, 23, 36, 32, 1831, 21, 100409, 1824, 25, 111235, 22, 110329, 10029, 169, 31, 28},
    [20] = {580, 165, 110500, 10030, 1832, 34, 485, 166, 171, 110636, 29, 531, 110588, 110502, 160, 576, 159, 503},
    [31] = {52, 46, 347, 55, 1842, 110556, 206, 110374, 39, 48, 44, 54, 45, 189, 50, 1745, 47, 110738, 111974, 111434},
    [32] = {1746, 205, 111811, 1744, 1837, 1843, 1848, 110740, 110908, 110915, 111433, 111657, 112124, 112493, 112494, 110741, 200, 2038, 110912, 113147},
    [39] = {111140, 114161, 697, 114640, 111928, 693, 688, 112828, 694, 691, 113149, 112893, 114162, 112885, 687, 112134, 101112, 112996, 112606, 111651, 698, 111065, 696, 689, 111139, 111138, 695, 111144, 113018, 121439},
    [41] = {298, 300, 417, 418, 918, 919, 920, 922, 1463, 1523, 1756, 1757, 2041, 112199, 113459, 121491},
    [50] = {81, 181, 83, 77, 80, 100805, 78, 86, 82, 180, 79, 621},
    [53] = {1860, 449, 457, 243, 461, 240, 241, 453, 448, 450, 483, 110062, 481, 479, 463, 480, 452, 110827, 1853, 468},
    [54] = {472, 100888, 462, 467, 456, 1861, 110839, 1854, 459, 110069, 573, 10846, 244, 110832, 1968, 242, 1867, 100852, 1894, 15012, 110711, 114554},
    [56] = {319, 320, 321, 433, 700, 702, 708, 710, 711, 111594, 111705, 112072, 112126, 113458, 113892, 1870},
    [60] = {1797, 1793, 1933, 4, 1930, 1926, 1917, 1958, 361, 149, 1939, 1932, 1938, 15015, 1940, 1931, 143, 142, 1928, 1804, 1923, 1929, 1961, 112259},
    [60] = {1797, 1793, 1933, 4, 1930, 1926, 1917, 1958, 361, 149, 1939, 1932, 1938, 15015, 1940, 1931, 143, 142, 1928, 1804, 1923, 1929, 1961, 112259},
    [61] = {92, 121, 127, 135, 381, 1798, 1802, 1803, 1920, 1924, 1934, 1935, 1936, 1937, 1944, 1962, 15048, 110313, 110890, 112222, 112254, 112260, 112764, 113926},
    [65] = {305, 306, 423, 445, 563, 753, 834, 837, 1571, 1572, 422},
    [66] = {301, 420, 873, 1871, 110206, 110745, 110746, 110747, 110749, 111083, 111086, 111088, 111091, 111097, 114326, 111082, 112510, 1569},
    [67] = {312, 315, 100764, 100765, 100767, 100769, 110102, 110109, 110227, 110231, 110232, 110239, 112217, 112218, 112261, 130988, 110222},
    [68] = {326, 325, 110776, 436, 327, 101033, 113142, 111339, 101014, 101020, 741, 748, 101026, 101037, 121174, 111117, 101025, 101032},
    [76] = {133333, 263, 110870, 393, 1884, 278, 111596, 110943, 111353, 110981, 115650, 115651, 115652, 115700, 110969, 110968, 110986, 112908, 112716, 111008, 111010, 111014, 110989, 110990, 130109, 257, 130633, 100135, 100325, 130678, 130733, 101315, 100820, 101070, 130615, 111969, 264, 100818, 110472, 130053, 1202, 112028, 129105, 129107, 130250, 129108, 129109, 111160, 129229, 129112, 129113, 129114, 129148, 129117, 130258, 130927, 129115, 129116, 130246, 129128, 129129, 129130, 130244, 129118, 129119, 129155, 129120, 129121, 130249, 129122, 129123, 129125, 129126, 129127, 130259, 129205, 130245, 130929, 129131, 129156, 129157, 129158, 129197, 129201, 129202, 129203, 130257, 129159, 129133, 129196, 110941, 130247, 130930, 130251, 129050, 129134, 129135, 129136, 129137, 130248, 111172, 129147, 129195, 129138, 129194, 129145, 129149, 129209, 130255, 130256, 129143, 129151, 129217, 129222, 129225, 130243, 130932, 129140, 129141, 129032, 129033, 129142, 129200, 130238, 130933, 129152, 110940, 129198, 130936, 130180, 112090, 101142, 111727, 112812, 116493, 130184, 130028, 130025, 130185, 111731, 130187, 130163, 130026, 130188, 112208, 130227, 115701, 114423, 114427, 114424, 114426, 114430, 114428, 114429, 114425, 112190, 101047, 101059, 267, 121795, 122375, 114615, 114611, 15029, 101108, 110991, 111013, 111006, 111011, 111329, 111334, 112667, 114581, 114598, 115653},
    [77] = {126985, 126986, 115513, 126989, 126990},
    [78] = {110082, 1365, 1366, 1367, 111512, 111111, 1353, 111533, 111506, 1331, 111505, 111513, 111487, 111391, 111523, 111449, 111514, 111536, 111532, 111456, 1357, 111464, 111510, 1395, 1393, 1667, 1391, 1387, 1386, 1383, 1377, 1375, 1370, 1369, 1341, 1338, 111515, 1330, 1363, 1362, 1328, 1360, 1359, 1356, 1415, 1886, 1411, 111114, 111521, 111473, 111466, 111465, 111462, 111459, 111455, 111451, 111448, 111130, 111115, 1318, 111112, 1343, 111109, 111108, 111099, 1335, 110081, 105035, 105022, 111527, 111461, 111475, 111525, 111453, 1354, 111528, 111504, 1361, 111526, 1325, 1319, 105013, 1413, 1327, 1322, 974, 1334, 1352, 111518, 112048, 111545, 111485, 111489, 111550, 1364, 1337, 111488, 1355, 111530, 1336, 111481, 112062, 112044, 111483, 112046, 112049, 111472, 111392, 111549, 112054, 112060, 111740, 111463, 105042, 111516, 111502, 111486, 111537, 112486, 112063, 111547, 111548, 111546, 111524, 112067, 1321, 114639, 1349, 1323, 1333, 111450, 111555, 111113},
    [80] = {191, 209, 252, 254, 256, 2017, 15009, 15040, 110720, 111822, 113616, 780},
    [83] = {980, 982, 1473, 1474, 1477, 1478, 2056, 110765, 112115, 112258, 112558, 2055, 112555},
    [189] = {322, 324, 894, 896, 897, 898, 900, 1704, 1713, 1862, 10032, 110770, 1715},
    [308] = {1438, 10020, 112513, 1887, 234, 744, 112809, 114510, 1896, 236, 237, 1888, 718, 1891, 1900, 121463, 717, 112516},
    [330] = {308, 310, 100757, 100761, 110072, 110075, 110078, 110750, 110751, 110752, 110815, 113378, 114147, 114385, 114549, 121459, 114546, 114545, 100759},
    [335] = {101097, 110978, 112585, 112116, 111328, 112705, 112584, 111327, 110977, 112535, 110975, 110980, 112531},
    [336] = {101100, 101099, 101105, 101101, 101103, 111722, 101106, 101104, 112523, 112744, 112992, 101102, 112526, 112578, 112715, 111723, 112579, 112527},
    [338] = {101110, 111326, 101109, 112615, 115536, 110998, 111001, 112184, 111325, 112868},
    [341] = {101121, 1878, 111678, 110781, 110147, 1032, 101114, 110150, 1879, 112678, 1881, 1880, 114899, 110152, 110144, 1882, 113134, 1970},
    [347] = {110929, 110930, 110935, 110932, 111104, 130254, 130320, 130321, 130322, 130323, 130324, 130325, 130326, 130327, 130328, 130329},
    [349] = {101146, 101147, 101148, 101150, 101151, 111038, 111575, 111730, 112092, 112093, 113157, 113161, 113186, 113197, 101145, 112906, 130572, 130578, 101149, 150722},
    [350] = {112390, 111674, 112096, 112139, 113057, 112883, 112393, 113060, 113217, 607, 113037, 605, 112387, 112391, 121735, 113222, 115892, 121798},
    [351] = {111393, 111395, 111396, 111397, 111398, 111399, 111400, 111766, 112224, 112427, 114023, 114604, 121739},
    [353] = {110396, 111706, 101083, 112713, 111716, 1877, 112965, 111708, 101085, 110093, 111711, 112689, 113044, 111710, 101088, 110395, 111715, 112670, 110580, 1013, 110404, 111019, 1876, 101084, 110953, 111022, 111020, 115472, 111707, 111713},
    [365] = {111510, 111506, 111533, 111528, 111521, 111504, 111518, 111526, 111488, 111515, 111505, 111115, 111114, 111485, 1415, 111530, 111523, 111527, 111549, 111532, 1411, 1413, 111512, 111466, 974, 111536, 111514, 111525, 111513, 111392, 111391, 111464, 111516, 111502, 111524, 112067},
    [1107] = {111622, 130181, 130182, 129054, 129055, 129056, 129057, 129058, 129059},
    [1114] = {111637, 111640, 111641, 111642, 111645, 111646, 130225, 130226},
    [1115] = {111090, 111658, 111670, 111733, 112094, 112099, 112234, 112631, 130278, 130281, 130279, 130382},
    [1117] = {111737, 111738, 112024, 130029, 130031, 130151, 130152, 130153, 130154, 130155, 130156, 130157, 130159, 130870},
    [1170] = {129094, 129095, 129096, 129097, 129098, 129099, 129100, 129101, 129102, 129103, 129104},
    [1171] = {129082, 129083, 129084, 129085, 129086, 129087, 129088, 129089, 129090, 129091, 129092, 129093},
    [1172] = {129074, 129075, 129076, 129077, 129078, 129079, 129080, 129081},
    [1245] = {127948, 127949, 127924, 128000, 127889, 111205, 128398, 128396, 114422, 114421, 127993, 127950, 128362, 114815, 128404, 128299, 128338, 128004, 128400, 127951, 128028, 114420, 128399, 128397, 114419, 128401, 127925, 128322, 127819, 127794, 128371, 127032, 128402, 128403, 128884, 128405, 128406, 128407, 127730},
    [1246] = {127886, 127887, 127909, 115510, 127905, 127910, 127904, 129885, 127908, 127907, 127902, 127901, 127903, 126425, 129883, 127885, 127906},
    [1407] = {130476, 130477, 130478, 130479, 130480, 130481, 130482, 130483, 130484, 130485},
    [2012] = {110955, 111724, 111768, 111769, 111774, 111779, 112163, 112540, 112979, 112985, 114628, 116360, 116361, 121173, 121487, 121488, 121531, 122305},
    [2013] = {110961, 110962, 111701, 111836, 112098, 112100, 112167, 112459, 113959, 114693, 114696, 130080, 130221, 113729},
    [2034] = {111156, 111157, 130242, 130599, 130600, 130814, 130815, 130816, 130817, 130818, 130819, 130820, 130821, 130822, 130823, 150650},
    [2076] = {27, 33, 162, 487, 492, 506, 523, 526, 543, 583, 1825, 1826, 110176, 110501, 110532, 110645, 110678, 110685, 110697, 111239},
    [2136] = {113005, 113008, 113002, 116428, 113000, 131144, 115511, 113010, 131139, 115362, 131143, 115682, 131147, 113007, 131140, 113003, 113006, 113984, 113009, 131145, 116440, 131142, 131148, 113011, 113012, 113394, 113258, 113997, 113004, 113987, 131141, 113991, 112999, 113996, 112998, 113001, 113998, 121877, 121124},
    [2149] = {111629, 111633, 113040, 113146, 113257, 113297, 113298, 113299, 113300, 113301, 113302, 114168, 115202, 122681},
    [2215] = {115995, 115996, 115997, 115998, 115999, 116001, 116002, 116003, 116004, 116005, 116021, 122589, 121386, 122533},
    [2216] = {116020, 116010, 116017, 116343, 116014, 116016, 116012, 116013, 116015, 116009, 116011, 122176},
    [2218] = {116036, 116037, 116040, 116039, 116042, 116038, 116035, 116416, 116034, 116033, 116386, 116041, 122370, 122588, 121724, 116044, 116417},
    [2221] = {116300, 116302, 116303, 116304, 116305, 116306, 116307, 116308, 116309, 116310, 116311, 116312, 121477, 121478},
    [2222] = {116325, 116326, 116327, 116328, 116331, 116332, 116333, 116334, 116336, 116337, 121125, 121391, 121720, 121733, 122629, 121123},
    [2231] = {150735, 155450, 155449, 155448, 155447, 155446, 111180, 111181, 111183, 111184, 111348, 115514, 115868, 130037, 130040, 130046, 130219, 130220, 155445},
    [2235] = {155606, 155603, 155611, 155604, 155614, 155607, 155601, 155600, 155612, 155617, 155616, 155620, 155621, 155618, 155602, 155624, 155609, 155630},
    [2236] = {73, 243, 10, 21, 9, 44, 5, 22, 241, 1, 32, 240, 234, 39, 483, 45, 1824, 231, 18, 247, 245, 48, 237, 280, 266, 918, 219, 819, 69, 325, 2014, 113888, 448, 13, 111282, 110919},
    [2237] = {130383, 115618, 115616, 115620, 115617, 115621, 115622, 115623, 130091, 130098, 130101, 115624, 115625},
    [2238] = {14, 2, 52, 236, 36, 326, 189, 246, 65, 66, 72, 25, 1896, 449, 673, 78, 191, 450, 86, 1884, 393, 101078, 1516, 900, 896, 1903, 209, 211, 100761, 112372, 110468, 1874, 320, 100545, 100632, 919},
    [2240] = {116280, 116282, 121358, 121359, 121360, 121361, 121362, 121363},
    [2250] = {111500, 111498, 111497, 111499, 101137, 130802, 130803, 130804, 130805, 130806, 130808, 130809, 130810, 130811, 130812, 130813},
    [2252] = {150601, 150600, 112730, 111736, 150602, 115529, 130288, 130291, 130292, 130293, 130294, 130295, 130296, 130384, 130386, 130999},
    [2254] = {155622, 155619, 155623, 155625, 155626, 155615, 155610, 155605, 155631, 155632, 155633, 155634, 155635, 155636, 155637, 155638, 155639, 155640, 155641, 155642},
    [2255] = {155613, 155608, 155628, 155629, 155627},
    [2260] = {150632, 150631, 150630, 150633, 150634, 150635, 150636, 150637, 150638, 150639, 150640},
    [2264] = {115512, 115515}
}

local leagueNames = {
}

-- ============================================
-- 🔍 FUNGSI CARI LIGA
-- ============================================

-- 🔸 Cari liga satu tim
function GetLeagueIDByTeamID(teamID)
    for leagueID, teams in pairs(leagueTeams) do
        for _, id in ipairs(teams) do
            if id == teamID then
                return leagueID
            end
        end
    end
    return 0
end

-- 🔸 Cari league yang sama untuk banyak tim (versi kamu)
function getSharedLeagueIDExtended(teamList)
    for leagueID, teams in pairs(leagueTeams) do
        local allInLeague = true
        for _, tid in ipairs(teamList) do
            local found = false
            for _, id in ipairs(teams) do
                if id == tid then
                    found = true
                    break
                end
            end
            if not found then
                allInLeague = false
                break
            end
        end
        if allInLeague then
            return leagueID
        end
    end
    return 0 -- fallback ID liga kalau tidak ketemu
end

-- 🔸 Ambil nama liga
function GetLeagueNameByTeamID(teamID)
    local leagueID = GetLeagueIDByTeamID(teamID)
    return leagueNames[leagueID] or "Unknown League"
end

-- ============================================
-- ⚽ FUNGSI UTAMA: PUBLISH MATCH ROWS
-- ============================================
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
                if scorer == CARD_ID then totalGoals = totalGoals + 1 end
            end
            for _, scorer in ipairs(match.awayScorers or {}) do
                if scorer == CARD_ID then totalGoals = totalGoals + 1 end
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
    for i = 1, math.min(4, #combinedLineup) do
        table.insert(topPlayers, combinedLineup[i])
    end

    -- 🎯 Cek apakah semua tim dari liga yang sama
    local sharedLeagueID = getSharedLeagueIDExtended(TeamList)
    print("[Liga] Shared league ID:", sharedLeagueID)

    for rank, player in ipairs(topPlayers) do
        local playerName = player.playerName
        local position = tostring(player.position)
        local rating = tostring(player.rating)
        local teamName = self.loc.LocalizeString("TeamName_Abbr3_" .. player.teamID)

        -- ⚙️ Jika semua tim dari 1 liga, pakai sharedLeagueID
        -- Jika tidak, fallback ke liga tim pemain
        local leagueID = (sharedLeagueID ~= 0) and sharedLeagueID or GetLeagueIDByTeamID(player.teamID)
        local leagueName = leagueNames[leagueID] or "Unknown League"

        print(string.format("[TopScorer] %s (%s) - %s | LeagueID: %d (%s)", playerName, teamName, position, leagueID, leagueName))

        local row = {
            data = {
                PlayerName = playerName,
                Position = position,
                Rating = rating,
                TeamName = teamName,
                Goals = player.goalCount,
                Rank = tostring(rank),
                PlayerHead = { name = "$Head", id = player.CARD_ID },
                TeamCrest = { name = "$Crest64x64", id = player.teamID },
                Nationality = { name = "$Flag128x128", id = player.nationalityID },

                -- ✅ Gunakan TableAds sesuai ID liga
                TableAsset = {
    name = "$TableAds",
    id = (leagueID ~= nil and leagueID ~= 0) and leagueID or 0
},
            }
        }

        table.insert(filteredRivalListData, row)
    end

    self.im.Publish(bndmatchscore, filteredRivalListData)
end

function Liga:publishMatchRows3()
    local filteredRivalListData = {}

    -- 🔹 Tentukan tim yang sedang dipilih
    local SelectedTeamID = nil
    if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
        SelectedTeamID = currentSelectedTeamID
    elseif selectedteam and selectedteam ~= 0 then
        SelectedTeamID = TeamList[selectedteam]
    elseif currentMatch and currentMatch.HomeTeamID and currentMatch.HomeTeamID ~= 0 then
        SelectedTeamID = currentMatch.HomeTeamID
    end

    if not SelectedTeamID or SelectedTeamID == 0 then
        print("[WARN] No team selected, showing all fixtures.")
        SelectedTeamID = nil
    else
        print("[INFO] Showing fixtures for team ID:", SelectedTeamID)
    end

    -- 🔹 Tentukan jumlah tim & total matchday
    local totalTeams = self.TotalTeams or 20
    local totalMatchdays = (totalTeams - 1) * 2

    -- 🔹 Tanggal awal & akhir musim
    local startDate = os.time{year=2025, month=8, day=1}   -- matchday 1
    local secondDate = nil
    if totalTeams == 20 then
        secondDate = os.time{year=2025, month=8, day=9}
    elseif totalTeams == 18 then
        secondDate = os.time{year=2025, month=8, day=10}
    elseif totalTeams == 16 then
        secondDate = os.time{year=2025, month=8, day=11}
    elseif totalTeams == 14 then
        secondDate = os.time{year=2025, month=8, day=12}
    else
        secondDate = os.time{year=2025, month=8, day=9}
    end
    local endDate = os.time{year=2026, month=5, day=31}

    -- 🔹 Hitung interval antar match (agar matchday terakhir tepat 31 May)
    local totalDaysSeason = os.difftime(endDate, startDate) / (24 * 3600)
    local usedDaysFirstGap = os.difftime(secondDate, startDate) / (24 * 3600)
    local remainingDays = totalDaysSeason - usedDaysFirstGap
    local intervalDays = math.floor(remainingDays / (totalMatchdays - 2))

    -- 🔹 Format nama hari & bulan
    local dayNames = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}
    local monthNames = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"}

    local fixtureIndex = 0
    for i, v in ipairs(rivalListData) do
        local involved = (SelectedTeamID == nil) or (v.homeID == SelectedTeamID or v.awayID == SelectedTeamID)
        if involved then
            fixtureIndex = fixtureIndex + 1

            -- 🔹 Tentukan tanggal match
            local matchDate
            if fixtureIndex == 1 then
                matchDate = startDate
            elseif fixtureIndex == 2 then
                matchDate = secondDate
            else
                matchDate = secondDate + ((fixtureIndex - 2) * intervalDays * 24 * 3600)
            end

            -- 🔹 Format tanggal jadi teks
            local t = os.date("*t", matchDate)
            local dayName = dayNames[t.wday]
            local monthAbbr = monthNames[t.month]
            local dateText = string.format("%s - %s, %s %d %d",
                (v.homeID == SelectedTeamID) and "Home" or "Away",
                dayName, monthAbbr, t.day, t.year
            )

            local opponentID = (v.homeID == SelectedTeamID) and v.awayID or v.homeID

            -- 🔹 Crest kiri = logo liga
            v.data.TeamHomeCrest = { name = "$LeagueLogo2", id = IDLeague or 0 }
            v.data.TeamHomeName = dateText

            -- 🔹 Crest kanan = tim lawan
            v.data.TeamAwayCrest = { name = "$Crest64x64", id = opponentID }
            v.data.TeamAwayName = self.loc.LocalizeString("TeamName_Abbr15_" .. opponentID)

            -- 🔹 Skor atau VS
            v.data.MatchScore = (v.homeScore and v.awayScore) and (v.homeScore .. " - " .. v.awayScore) or "VS"

            -- 🔹 Warna teks
            v.data.TeamScoreFontColor = "0xffffff"
            v.data.TeamNameFontColor = "0x4A2C6D"
            v.data.FontColor = "0x4A2C6D"

            table.insert(filteredRivalListData, v)
        end
    end

    self.im.Publish(bndMatchFixtures, filteredRivalListData)
    print(string.format("[INFO] Fixtures: %d | interval antar match: %d hari | terakhir: 31 May 2026", #filteredRivalListData, intervalDays))
end
------------------------------------------------------------------------------------------

function GetLeagueFromTeam(teamID)
    for i, team in ipairs(gTeams) do
        if team.id == teamID then
            return team.leagueID
        end
    end
    return 0
end
-- ============================================================
-- 2. Update cache form (skip dummy bye tapi tetap lanjut)
-- ============================================================
function updateTeamFormCache()
    if GLOBAL_MATCHUP_COUNT < 5 then return end

    TeamFormCache = {}
    for _, teamID in ipairs(TeamList) do
        TeamFormCache[teamID] = { wins = 0, draws = 0, losses = 0 }
    end

    local matchesPerDay = matchesPerRound
    local currentMatchday = GLOBAL_MATCHUP_COUNT + 1
    local startMatchday = math.max(1, currentMatchday - 5)
    local startIndex = (startMatchday - 1) * matchesPerDay + 1
    local endIndex = (currentMatchday - 1) * matchesPerDay

    for i = startIndex, endIndex do
        local matchData = LigaGrouping[ligaId][i]
        if matchData then
            local homeID, awayID = matchData[1], matchData[2]

            -- Skip dummy bye
            if homeID ~= 0 and TeamFormCache[homeID] then
                local homeScore, awayScore = matchData[4], matchData[5]
                if homeScore > awayScore then
                    TeamFormCache[homeID].wins = TeamFormCache[homeID].wins + 1
                elseif homeScore == awayScore then
                    TeamFormCache[homeID].draws = TeamFormCache[homeID].draws + 1
                else
                    TeamFormCache[homeID].losses = TeamFormCache[homeID].losses + 1
                end
            end

            if awayID ~= 0 and TeamFormCache[awayID] then
                local homeScore, awayScore = matchData[4], matchData[5]
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
    for position = 1, math.min(4, #sortedTeams) do
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
    local absVal = math.abs(funds)
    if absVal >= 1e12 then
        return ("$%.2fT"):format(funds / 1e12):gsub("%.00T", "T")
    elseif absVal >= 1e9 then
        return ("$%.2fB"):format(funds / 1e9):gsub("%.00B", "B")
    elseif absVal >= 1e6 then
        return ("$%.2fM"):format(funds / 1e6):gsub("%.00M", "M")
    elseif absVal >= 1e3 then
        return ("$%.2fK"):format(funds / 1e3):gsub("%.00K", "K")
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
    self.im.Publish("bnd_formatted_Date", "")
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
-- Ambil tanggal dari GLOBAL_DATE_PLACEHOLDER (format: dd/mm/yy)
local dateString = GLOBAL_DATE_PLACEHOLDER or "01/08/25"

-- Validasi format input
if not dateString:match("^%d%d/%d%d/%d%d$") then
    print("Warning: Invalid GLOBAL_DATE_PLACEHOLDER '" .. tostring(dateString) .. "', using default '01/08/25'")
    dateString = "01/08/25"
end

-- Pecah menjadi hari, bulan, tahun
local day, month, year = dateString:match("(%d%d)/(%d%d)/(%d%d)")

-- Paksa tahun selalu 2025
local fullYear = 2025

-- Buat tabel waktu awal (jam 00:00:00)
local timeTable = { 
    day = tonumber(day), 
    month = tonumber(month), 
    year = fullYear, 
    hour = 0, 
    min = 0, 
    sec = 0 
}

-- Convert ke epoch time
local time = os.time(timeTable)

-- Format utama (pakai tanggal dari time)
local formattedDate = os.date("%A, %b %d", time)

-- Prev & Next date (±1 hari)
local prevTime = time - 86400
local prevDate = os.date("%A, %b %d", prevTime)
local nextTime = time + 86400
local nextDate = os.date("%A, %b %d", nextTime)

-- Tambahan: 2 hari sebelumnya & sesudahnya
local prev2Time = time - (2 * 86400)
local prev2Date = os.date("%A, %b %d", prev2Time)
local next2Time = time + (2 * 86400)
local next2Date = os.date("%A, %b %d", next2Time)

-- Ambil tabel tanggal dari formattedDate
local dayTable = os.date("*t", time)

-- Ambil jam & menit dari waktu nyata (sistem)
local now = os.date("*t")
dayTable.hour = now.hour
dayTable.min = now.min
dayTable.sec = now.sec

-- Convert lagi ke epoch dengan jam real-time
local finalDayTime = os.time(dayTable)

-- Format final untuk dayDate
local dayDate = os.date("%B %d %I:%M %p", finalDayTime)

-- Debug print hasil
print("formattedDate:", formattedDate)        -- contoh: Monday, Aug 18
print("prev2Date:", prev2Date)                -- contoh: Saturday, Aug 16
print("prevDate:", prevDate)                  -- contoh: Sunday, Aug 17
print("nextDate:", nextDate)                  -- contoh: Tuesday, Aug 19
print("next2Date:", next2Date)                -- contoh: Wednesday, Aug 20
print("dayDate (real-time hours):", dayDate)  -- contoh: Aug 18 10:30 AM

    local currentDay, currentMonth, currentYear = tonumber(day), tonumber(month), tonumber(year)
    if not isValidDate(currentDay, currentMonth, currentYear) then
        dateString = "01/08/25"
        currentDay, currentMonth, currentYear = 1, 8, 25
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

    -- 🔹 Daftar liga & tim
local leagueTeams = {
    [0] = {},
    [1] = {269, 270, 271, 819, 822, 1443, 1447, 1516, 1786, 1788, 15006, 272},
    [4] = {681, 1750, 670, 229, 100087, 110724, 230, 673, 680, 231, 674, 232, 2014, 537, 15005, 122231},
    [7] = {1629, 598, 1035, 111052, 517, 1048, 383, 567, 1598, 1041, 111041, 1719, 569, 568, 1043, 112472, 1053, 111059, 111057, 130361},
    [10] = {634, 1913, 245, 1903, 247, 1910, 100632, 1908, 246, 100646, 1906, 1915, 1914, 100634, 1904, 645, 1971, 100638},
    [13] = {13, 1925, 14, 110, 18, 19, 5, 2, 10, 144, 1, 11, 1799, 1943, 1808, 7, 9, 8, 1796, 106, 126987},
    [14] = {15, 97, 1800, 1919, 109, 1960, 1952, 1807, 1794, 1806, 12, 3, 1795, 1792, 1951, 1790, 91, 1801, 88, 1947, 17, 94, 95, 89},
    [16] = {65, 69, 76, 219, 73, 66, 64, 74, 1738, 72, 71, 1530, 57, 378, 1809, 217, 111817, 68},
    [17] = {379, 210, 62, 294, 1816, 111659, 1815, 115494, 58, 110321, 1814, 1805, 614, 67, 111273, 111276, 70, 1819},
    [19] = {175, 38, 112172, 23, 36, 32, 1831, 21, 100409, 1824, 25, 111235, 22, 110329, 10029, 169, 31, 28},
    [20] = {580, 165, 110500, 10030, 1832, 34, 485, 166, 171, 110636, 29, 531, 110588, 110502, 160, 576, 159, 503},
    [31] = {52, 46, 347, 55, 1842, 110556, 206, 110374, 39, 48, 44, 54, 45, 189, 50, 1745, 47, 110738, 111974, 111434},
    [32] = {1746, 205, 111811, 1744, 1837, 1843, 1848, 110740, 110908, 110915, 111433, 111657, 112124, 112493, 112494, 110741, 200, 2038, 110912, 113147},
    [39] = {111140, 114161, 697, 114640, 111928, 693, 688, 112828, 694, 691, 113149, 112893, 114162, 112885, 687, 112134, 101112, 112996, 112606, 111651, 698, 111065, 696, 689, 111139, 111138, 695, 111144, 113018, 121439},
    [41] = {298, 300, 417, 418, 918, 919, 920, 922, 1463, 1523, 1756, 1757, 2041, 112199, 113459, 121491},
    [50] = {81, 181, 83, 77, 80, 100805, 78, 86, 82, 180, 79, 621},
    [53] = {1860, 449, 457, 243, 461, 240, 241, 453, 448, 450, 483, 110062, 481, 479, 463, 480, 452, 110827, 1853, 468},
    [54] = {472, 100888, 462, 467, 456, 1861, 110839, 1854, 459, 110069, 573, 10846, 244, 110832, 1968, 242, 1867, 100852, 1894, 15012, 110711, 114554},
    [56] = {319, 320, 321, 433, 700, 702, 708, 710, 711, 111594, 111705, 112072, 112126, 113458, 113892, 1870},
    [60] = {1797, 1793, 1933, 4, 1930, 1926, 1917, 1958, 361, 149, 1939, 1932, 1938, 15015, 1940, 1931, 143, 142, 1928, 1804, 1923, 1929, 1961, 112259},
    [60] = {1797, 1793, 1933, 4, 1930, 1926, 1917, 1958, 361, 149, 1939, 1932, 1938, 15015, 1940, 1931, 143, 142, 1928, 1804, 1923, 1929, 1961, 112259},
    [61] = {92, 121, 127, 135, 381, 1798, 1802, 1803, 1920, 1924, 1934, 1935, 1936, 1937, 1944, 1962, 15048, 110313, 110890, 112222, 112254, 112260, 112764, 113926},
    [65] = {305, 306, 423, 445, 563, 753, 834, 837, 1571, 1572, 422},
    [66] = {301, 420, 873, 1871, 110206, 110745, 110746, 110747, 110749, 111083, 111086, 111088, 111091, 111097, 114326, 111082, 112510, 1569},
    [67] = {312, 315, 100764, 100765, 100767, 100769, 110102, 110109, 110227, 110231, 110232, 110239, 112217, 112218, 112261, 130988, 110222},
    [68] = {326, 325, 110776, 436, 327, 101033, 113142, 111339, 101014, 101020, 741, 748, 101026, 101037, 121174, 111117, 101025, 101032},
    [76] = {133333, 263, 110870, 393, 1884, 278, 111596, 110943, 111353, 110981, 115650, 115651, 115652, 115700, 110969, 110968, 110986, 112908, 112716, 111008, 111010, 111014, 110989, 110990, 130109, 257, 130633, 100135, 100325, 130678, 130733, 101315, 100820, 101070, 130615, 111969, 264, 100818, 110472, 130053, 1202, 112028, 129105, 129107, 130250, 129108, 129109, 111160, 129229, 129112, 129113, 129114, 129148, 129117, 130258, 130927, 129115, 129116, 130246, 129128, 129129, 129130, 130244, 129118, 129119, 129155, 129120, 129121, 130249, 129122, 129123, 129125, 129126, 129127, 130259, 129205, 130245, 130929, 129131, 129156, 129157, 129158, 129197, 129201, 129202, 129203, 130257, 129159, 129133, 129196, 110941, 130247, 130930, 130251, 129050, 129134, 129135, 129136, 129137, 130248, 111172, 129147, 129195, 129138, 129194, 129145, 129149, 129209, 130255, 130256, 129143, 129151, 129217, 129222, 129225, 130243, 130932, 129140, 129141, 129032, 129033, 129142, 129200, 130238, 130933, 129152, 110940, 129198, 130936, 130180, 112090, 101142, 111727, 112812, 116493, 130184, 130028, 130025, 130185, 111731, 130187, 130163, 130026, 130188, 112208, 130227, 115701, 114423, 114427, 114424, 114426, 114430, 114428, 114429, 114425, 112190, 101047, 101059, 267, 121795, 122375, 114615, 114611, 15029, 101108, 110991, 111013, 111006, 111011, 111329, 111334, 112667, 114581, 114598, 115653},
    [77] = {126985, 126986, 115513, 126989, 126990},
    [78] = {110082, 1365, 1366, 1367, 111512, 111111, 1353, 111533, 111506, 1331, 111505, 111513, 111487, 111391, 111523, 111449, 111514, 111536, 111532, 111456, 1357, 111464, 111510, 1395, 1393, 1667, 1391, 1387, 1386, 1383, 1377, 1375, 1370, 1369, 1341, 1338, 111515, 1330, 1363, 1362, 1328, 1360, 1359, 1356, 1415, 1886, 1411, 111114, 111521, 111473, 111466, 111465, 111462, 111459, 111455, 111451, 111448, 111130, 111115, 1318, 111112, 1343, 111109, 111108, 111099, 1335, 110081, 105035, 105022, 111527, 111461, 111475, 111525, 111453, 1354, 111528, 111504, 1361, 111526, 1325, 1319, 105013, 1413, 1327, 1322, 974, 1334, 1352, 111518, 112048, 111545, 111485, 111489, 111550, 1364, 1337, 111488, 1355, 111530, 1336, 111481, 112062, 112044, 111483, 112046, 112049, 111472, 111392, 111549, 112054, 112060, 111740, 111463, 105042, 111516, 111502, 111486, 111537, 112486, 112063, 111547, 111548, 111546, 111524, 112067, 1321, 114639, 1349, 1323, 1333, 111450, 111555, 111113},
    [80] = {191, 209, 252, 254, 256, 2017, 15009, 15040, 110720, 111822, 113616, 780},
    [83] = {980, 982, 1473, 1474, 1477, 1478, 2056, 110765, 112115, 112258, 112558, 2055, 112555},
    [189] = {322, 324, 894, 896, 897, 898, 900, 1704, 1713, 1862, 10032, 110770, 1715},
    [308] = {1438, 10020, 112513, 1887, 234, 744, 112809, 114510, 1896, 236, 237, 1888, 718, 1891, 1900, 121463, 717, 112516},
    [330] = {308, 310, 100757, 100761, 110072, 110075, 110078, 110750, 110751, 110752, 110815, 113378, 114147, 114385, 114549, 121459, 114546, 114545, 100759},
    [335] = {101097, 110978, 112585, 112116, 111328, 112705, 112584, 111327, 110977, 112535, 110975, 110980, 112531},
    [336] = {101100, 101099, 101105, 101101, 101103, 111722, 101106, 101104, 112523, 112744, 112992, 101102, 112526, 112578, 112715, 111723, 112579, 112527},
    [338] = {101110, 111326, 101109, 112615, 115536, 110998, 111001, 112184, 111325, 112868},
    [341] = {101121, 1878, 111678, 110781, 110147, 1032, 101114, 110150, 1879, 112678, 1881, 1880, 114899, 110152, 110144, 1882, 113134, 1970},
    [347] = {110929, 110930, 110935, 110932, 111104, 130254, 130320, 130321, 130322, 130323, 130324, 130325, 130326, 130327, 130328, 130329},
    [349] = {101146, 101147, 101148, 101150, 101151, 111038, 111575, 111730, 112092, 112093, 113157, 113161, 113186, 113197, 101145, 112906, 130572, 130578, 101149, 150722},
    [350] = {112390, 111674, 112096, 112139, 113057, 112883, 112393, 113060, 113217, 607, 113037, 605, 112387, 112391, 121735, 113222, 115892, 121798},
    [351] = {111393, 111395, 111396, 111397, 111398, 111399, 111400, 111766, 112224, 112427, 114023, 114604, 121739},
    [353] = {110396, 111706, 101083, 112713, 111716, 1877, 112965, 111708, 101085, 110093, 111711, 112689, 113044, 111710, 101088, 110395, 111715, 112670, 110580, 1013, 110404, 111019, 1876, 101084, 110953, 111022, 111020, 115472, 111707, 111713},
    [365] = {111510, 111506, 111533, 111528, 111521, 111504, 111518, 111526, 111488, 111515, 111505, 111115, 111114, 111485, 1415, 111530, 111523, 111527, 111549, 111532, 1411, 1413, 111512, 111466, 974, 111536, 111514, 111525, 111513, 111392, 111391, 111464, 111516, 111502, 111524, 112067},
    [1107] = {111622, 130181, 130182, 129054, 129055, 129056, 129057, 129058, 129059},
    [1114] = {111637, 111640, 111641, 111642, 111645, 111646, 130225, 130226},
    [1115] = {111090, 111658, 111670, 111733, 112094, 112099, 112234, 112631, 130278, 130281, 130279, 130382},
    [1117] = {111737, 111738, 112024, 130029, 130031, 130151, 130152, 130153, 130154, 130155, 130156, 130157, 130159, 130870},
    [1170] = {129094, 129095, 129096, 129097, 129098, 129099, 129100, 129101, 129102, 129103, 129104},
    [1171] = {129082, 129083, 129084, 129085, 129086, 129087, 129088, 129089, 129090, 129091, 129092, 129093},
    [1172] = {129074, 129075, 129076, 129077, 129078, 129079, 129080, 129081},
    [1245] = {127948, 127949, 127924, 128000, 127889, 111205, 128398, 128396, 114422, 114421, 127993, 127950, 128362, 114815, 128404, 128299, 128338, 128004, 128400, 127951, 128028, 114420, 128399, 128397, 114419, 128401, 127925, 128322, 127819, 127794, 128371, 127032, 128402, 128403, 128884, 128405, 128406, 128407, 127730},
    [1246] = {127886, 127887, 127909, 115510, 127905, 127910, 127904, 129885, 127908, 127907, 127902, 127901, 127903, 126425, 129883, 127885, 127906},
    [1407] = {130476, 130477, 130478, 130479, 130480, 130481, 130482, 130483, 130484, 130485},
    [2012] = {110955, 111724, 111768, 111769, 111774, 111779, 112163, 112540, 112979, 112985, 114628, 116360, 116361, 121173, 121487, 121488, 121531, 122305},
    [2013] = {110961, 110962, 111701, 111836, 112098, 112100, 112167, 112459, 113959, 114693, 114696, 130080, 130221, 113729},
    [2034] = {111156, 111157, 130242, 130599, 130600, 130814, 130815, 130816, 130817, 130818, 130819, 130820, 130821, 130822, 130823, 150650},
    [2076] = {27, 33, 162, 487, 492, 506, 523, 526, 543, 583, 1825, 1826, 110176, 110501, 110532, 110645, 110678, 110685, 110697, 111239},
    [2136] = {113005, 113008, 113002, 116428, 113000, 131144, 115511, 113010, 131139, 115362, 131143, 115682, 131147, 113007, 131140, 113003, 113006, 113984, 113009, 131145, 116440, 131142, 131148, 113011, 113012, 113394, 113258, 113997, 113004, 113987, 131141, 113991, 112999, 113996, 112998, 113001, 113998, 121877, 121124},
    [2149] = {111629, 111633, 113040, 113146, 113257, 113297, 113298, 113299, 113300, 113301, 113302, 114168, 115202, 122681},
    [2215] = {115995, 115996, 115997, 115998, 115999, 116001, 116002, 116003, 116004, 116005, 116021, 122589, 121386, 122533},
    [2216] = {116020, 116010, 116017, 116343, 116014, 116016, 116012, 116013, 116015, 116009, 116011, 122176},
    [2218] = {116036, 116037, 116040, 116039, 116042, 116038, 116035, 116416, 116034, 116033, 116386, 116041, 122370, 122588, 121724, 116044, 116417},
    [2221] = {116300, 116302, 116303, 116304, 116305, 116306, 116307, 116308, 116309, 116310, 116311, 116312, 121477, 121478},
    [2222] = {116325, 116326, 116327, 116328, 116331, 116332, 116333, 116334, 116336, 116337, 121125, 121391, 121720, 121733, 122629, 121123},
    [2231] = {150735, 155450, 155449, 155448, 155447, 155446, 111180, 111181, 111183, 111184, 111348, 115514, 115868, 130037, 130040, 130046, 130219, 130220, 155445},
    [2235] = {155606, 155603, 155611, 155604, 155614, 155607, 155601, 155600, 155612, 155617, 155616, 155620, 155621, 155618, 155602, 155624, 155609, 155630},
    [2236] = {73, 243, 10, 21, 9, 44, 5, 22, 241, 1, 32, 240, 234, 39, 483, 45, 1824, 231, 18, 247, 245, 48, 237, 280, 266, 918, 219, 819, 69, 325, 2014, 113888, 448, 13, 111282, 110919},
    [2237] = {130383, 115618, 115616, 115620, 115617, 115621, 115622, 115623, 130091, 130098, 130101, 115624, 115625},
    [2238] = {14, 2, 52, 236, 36, 326, 189, 246, 65, 66, 72, 25, 1896, 449, 673, 78, 191, 450, 86, 1884, 393, 101078, 1516, 900, 896, 1903, 209, 211, 100761, 112372, 110468, 1874, 320, 100545, 100632, 919},
    [2240] = {116280, 116282, 121358, 121359, 121360, 121361, 121362, 121363},
    [2250] = {111500, 111498, 111497, 111499, 101137, 130802, 130803, 130804, 130805, 130806, 130808, 130809, 130810, 130811, 130812, 130813},
    [2252] = {150601, 150600, 112730, 111736, 150602, 115529, 130288, 130291, 130292, 130293, 130294, 130295, 130296, 130384, 130386, 130999},
    [2254] = {155622, 155619, 155623, 155625, 155626, 155615, 155610, 155605, 155631, 155632, 155633, 155634, 155635, 155636, 155637, 155638, 155639, 155640, 155641, 155642},
    [2255] = {155613, 155608, 155628, 155629, 155627},
    [2260] = {150632, 150631, 150630, 150633, 150634, 150635, 150636, 150637, 150638, 150639, 150640},
    [2264] = {115512, 115515}
}


leagueNames = {
    [1]    = "3F Superliga",
    [4]    = "Jupiler Pro League",
    [7]    = "Brasileirão Serie A",
    [10]   = "Eredivisie",
    [13]   = "Premier League",
    [14]   = "Sky Bet Championship",
    [16]   = "Ligue 1 McDonald’s",
    [17]   = "Ligue 2 BKT",
    [19]   = "Bundesliga",
    [20]   = "2. Bundesliga",
    [31]   = "Serie A Enilive",
    [32]   = "Serie BKT",
    [39]   = "MLS",
    [41]   = "Eliteserien",
    [50]   = "cinch Premiership",
    [53]   = "LaLiga EA SPORTS",
    [54]   = "LaLiga HYPERMOTION",
    [56]   = "Allsvenskan",
    [60]   = "League One",
    [61]   = "League Two",
    [65]   = "SSE Premier Div",
    [66]   = "Ekstraklasa",
    [67]   = "Russian Premier",
    [68]   = "Süper Lig",
    [76]   = "Rest of World",
    [77]   = "Rest of World (2)",
    [78]   = "International",
    [80]   = "ADMIRAL Bundesliga",
    [83]   = "K League 1",
    [189]  = "Super League",
    [308]  = "Liga Portugal",
    [330]  = "SuperLiga Romania",
    [335]  = "Campeonato Scotiabank",
    [336]  = "Liga Colombia",
    [338]  = "Campeonato Uruguay",
    [341]  = "Liga MX",
    [347]  = "DStv Premiership",
    [349]  = "J1 League",
    [350]  = "Saudi League",
    [351]  = "A-League Men",
    [353]  = "Torneo Binance",
    [365]  = "AFC",
    [1107] = "HK Premier",
    [1114] = "Singapore Premier",
    [1115] = "Qatar Stars League",
    [1117] = "Uzbek Super League",
    [1170] = "Cambodian Premier",
    [1171] = "Myanmar National",
    [1172] = "Laos League 1",
    [1245] = "Classic Team",
    [1246] = "Classic Internasional",
    [1407] = "Bashundhara Premier",
    [2012] = "Chinese Super League",
    [2013] = "ADNOC Pro League",
    [2034] = "Mobilis Ligue 1",
    [2076] = "3. Liga",
    [2136] = "Intl Women",
    [2149] = "Indian Super League",
    [2215] = "Frauen-Bundesliga",
    [2216] = "WSL",
    [2218] = "Division 1 Féminine",
    [2221] = "NWSL",
    [2222] = "Liga F",
    [2231] = "Egypt Premier",
    [2235] = "BRI Super League",
    [2236] = "UCL",
    [2237] = "Super League Malaysia",
    [2238] = "UEL",
    [2240] = "UEFA WCL",
    [2250] = "Botola Pro",
    [2252] = "Thai League 1",
    [2254] = "Pegadaian Championship",
    [2255] = "PNM Liga Nusantara",
    [2260] = "V.League 1",
    [2264] = "ASEAN U23",
}

-- ============================================================
-- 🔹 Warna utama tiap liga (bisa dipakai untuk teks, rectangle, dll)
-- ============================================================
-- ============================================================
-- 🔹 Warna utama liga (untuk latar, tabel, dll)
-- ============================================================
local leagueColors = {
    [10] = "0x141318",
    [13] = "0x18001A",
    [16] = "0x0C0506",
    [19] = "0x0C0506",
    [2235] = "0x0C0506",
    [2236] = "0x000026",
    [2261] = "0x1C217C",
    [308] = "0x141318",
    [31] = "0x161850",
    [4] = "0x141318",
    [53] = "0x0C0506",
    [0] = "0x141318" -- fallback
}

-- ============================================================
-- 🔹 Warna aksi liga (baru, untuk highlight, tombol, teks, dll)
-- ============================================================
local leagueActionColors = {
    [10] = "0x534CB6",   -- misalnya lebih terang
    [13] = "0x783ABA",
    [16] = "0xD42F29",
    [19] = "0xD42F29",
    [2235] = "0xD42F29",
    [308] = "0x2E2B33",
    [31] = "0xD42F29",
    [4]  = "0x534CB6",
    [53] = "0xD42F29",
    [0]  = "0x534CB6" -- fallback
}

-- Ambil warna liga berdasarkan ID
function GetLeagueColorByID(leagueID)
    if leagueColors[leagueID] then
        return leagueColors[leagueID]
    else
        return leagueColors[0]  -- fallback ke putih
    end
end

function GetLeagueActionColorByID(leagueID)
    if leagueActionColors[leagueID] then
        return leagueActionColors[leagueID]
    else
        return leagueActionColors[0]
    end
end

-- 🔹 Fungsi ambil nama liga
function GetLeagueNameByID(leagueID)
    if leagueNames[leagueID] then
        return leagueNames[leagueID]
    else
        return leagueNames[0] -- fallback → League 0
    end
end

-- 🔹 Cari league yang sama untuk banyak tim
function getSharedLeagueIDExtended(teamList)
    for leagueID, teams in pairs(leagueTeams) do
        local allInLeague = true
        for _, tid in ipairs(teamList) do
            local found = false
            for _, id in ipairs(teams) do
                if id == tid then
                    found = true
                    break
                end
            end
            if not found then
                allInLeague = false
                break
            end
        end
        if allInLeague then
            return leagueID
        end
    end
    return 0 -- fallback ID liga kalau tidak ketemu
end

-- ============================================================
-- 🔹 Fungsi ordinal (peringkat ke-1, ke-2, dst)
-- ============================================================
local function ordinal(n)
    n = tonumber(n)
    if not n then return "-" end
    local suffix = "th"
    if n % 100 < 11 or n % 100 > 13 then
        if n % 10 == 1 then
            suffix = "st"
        elseif n % 10 == 2 then
            suffix = "nd"
        elseif n % 10 == 3 then
            suffix = "rd"
        end
    end
    return tostring(n) .. suffix
end

-- 🔹 Hitung margin kiri (opsional buat UI teks)
local function calculateMarginLeft(teamName, fontSize)
    local avgWidth = fontSize * 0.6
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

---- ============================================================
-- 🔹 Fungsi format tanggal untuk tiap matchday (dinamis)
-- ============================================================
local function getMatchdayDate(matchdayNumber, totalMatchdays)
    -- Matchday 1 mulai 1 Agustus 2025
    local startTime = os.time{year=2025, month=8, day=1}
    -- Matchday terakhir 31 Mei 2026
    local endTime   = os.time{year=2026, month=5, day=31}

    -- Total selisih hari
    local totalDays = os.difftime(endTime, startTime) / (24*60*60)

    -- Jika cuma 1 matchday → langsung tanggal awal
    if totalMatchdays <= 1 then
        return os.date("%A, %b %d", startTime)
    end

    -- Jarak antar matchday (dibagi rata)
    local interval = totalDays / (totalMatchdays - 1)

    -- Hitung tanggal matchday sekarang
    local matchTime = startTime + math.floor((matchdayNumber - 1) * interval) * 24 * 60 * 60

    -- Format → "Senin, Aug 01"
    return os.date("%A, %b %d", matchTime)
end

-- ============================================================
-- 🔹 Ambil info matchup
-- ============================================================
local matchupInfo = ""
local globalMatchupCount = GLOBAL_MATCHUP_COUNT or 0
local matchupIndex = 0
local matchupInfoHomeAbbr, matchupInfoAwayAbbr
local leagueName = ""

for i, v in ipairs(rivalListData or {}) do
    if v.homeID == currentSelectedTeamID or v.awayID == currentSelectedTeamID then
        if matchupIndex == globalMatchupCount then
            local opponentID = (v.homeID == currentSelectedTeamID) and v.awayID or v.homeID

            -- Cari liga bersama
            local teamList = { currentSelectedTeamID, opponentID }
            local nextMatch = rivalListData[i+1]
            if nextMatch then
                table.insert(teamList, nextMatch.homeID)
                table.insert(teamList, nextMatch.awayID)
            end

            local sharedLeague = getSharedLeagueIDExtended(teamList)
            if not sharedLeague or sharedLeague == 0 then
                sharedLeague = getSharedLeagueIDExtended({currentSelectedTeamID, opponentID})
            end
            if not sharedLeague or sharedLeague == 0 then
                sharedLeague = 0 -- fallback
            end

            -- Ambil semua match currentSelectedTeamID
            local myMatches = {}
            for _, m in ipairs(rivalListData or {}) do
                if m.homeID == currentSelectedTeamID or m.awayID == currentSelectedTeamID then
                    table.insert(myMatches, m)
                end
            end

            -- Hitung total matchday berdasarkan jumlah match
            local totalMatchdays = #myMatches

            -- Nama & rank sekarang
            local homeName     = self.loc.LocalizeString("TeamName_Abbr15_" .. v.homeID)            
            local awayName     = self.loc.LocalizeString("TeamName_Abbr15_" .. v.awayID)
            local homeAbbrName = self.loc.LocalizeString("TeamName_Abbr3_" .. v.homeID)    
            local awayAbbrName = self.loc.LocalizeString("TeamName_Abbr3_" .. v.awayID)  
            local LeagueNames = self.loc.LocalizeString("LeagueName_Abbr15_" .. sharedLeague)  

            local homeRank = getTeamRank(v.homeID)    
            local awayRank = getTeamRank(v.awayID)    
            local leagueColor = GetLeagueColorByID(IDLeague)

            -- Status sekarang
            matchupInfo  = (v.homeID == currentSelectedTeamID) and "Home" or "Away"    
            matchupInfo2 = homeName 
            matchupInfo3 = awayName
            matchupInfo4 = homeRank
            matchupInfo5 = awayRank

            IDHome    = v.homeID    
            IDAway    = v.awayID    
            IDLeague  = sharedLeague    
            leagueName = GetLeagueNameByID(IDLeague)  -- fallback 0
            
            -- 🔹 Ambil warna liga dan simpan ke variabel lokal
            local leagueColorValue = GetLeagueColorByID(IDLeague)
            LeagueColorValue = leagueColorValue
            
            -- 🔹 Ambil warna aksi liga
            local leagueActionColorValue = GetLeagueActionColorByID(IDLeague)
            LeagueActionColorValue = leagueActionColorValue

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
    local dayDateMargin = calculateMarginLeft(leagueName, 17)

    self.im.Publish("bnd_short_name_team_home", matchupInfo2)
    self.im.Publish("bnd_short_name_team_away", matchupInfo3)
    self.im.Publish("bnd_league_name_central", leagueName)
    self.im.Publish("bnd_rank_home", matchupInfo4)
    self.im.Publish("bnd_rank_away", matchupInfo5)
    self.im.Publish("bnd_day_date", dayDate)

    self.im.Publish("bnd_home_team_pos_marginLeft", homeMargin)
    self.im.Publish("bnd_away_team_pos_marginLeft", awayMargin)
    self.im.Publish("bnd_day_date_marginLeft", dayDateMargin)

    self.im.Publish("bnd_abbr_name_team_home", matchupInfoHomeAbbr)
    self.im.Publish("bnd_abbr_name_team_away", matchupInfoAwayAbbr)
    self.im.Publish("bnd_logo_league", {name = "$LeagueLogo2", id = IDLeague})
    self.im.Publish("bnd_logo_league_rival", {name = "$LeagueLogo2", id = IDLeague})
    self.im.Publish("bnd_background_career", {name = "$BackgroundCareer", id = IDLeague})
    self.im.Publish("bnd_table_career", {name = "$TableCareer", id = IDLeague})
    self.im.Publish("bnd_table_league", {name = "$TableLeague", id = IDLeague})
    self.im.Publish("bnd_team_crest_home", {name = "$Crest", id = IDHome})
    self.im.Publish("bnd_team_crest_away", {name = "$Crest", id = IDAway})
    self.im.Publish("bnd_league_color", LeagueColorValue)
    self.im.Publish("bnd_color_action", LeagueActionColorValue)
    self.im.Publish("bnd_league_name", leagueName)
    self.im.Publish("bnd_prev_Date", "")
    self.im.Publish("bnd_next_Date", "")
    self.im.Publish("bnd_new_nixture", "New Fixture In Day")
    self.im.Publish("bnd_advance_label", "Advance")
    matchday = true
else
    -- Non-match day
    self.im.Publish("bnd_date_label", displayDays)
    self.im.Publish("bnd_checkmark_label", "PRE-SEASON \nTOURNAMENT INVITE")
    self.im.Publish("bnd_logo_checkmark", "$Logo_No_Schedule")
    self.im.Publish("bnd_formatted_Date", formattedDate)
    self.im.Publish("bnd_logo_league_rival", {name = "$LeagueLogo2", id = IDLeague})
    self.im.Publish("bnd_background_career", {name = "$BackgroundCareer", id = IDLeague})
    self.im.Publish("bnd_table_career", {name = "$TableCareer", id = IDLeague})
    self.im.Publish("bnd_table_league", {name = "$TableLeague", id = IDLeague})
    self.im.Publish("bnd_league_name", leagueName)
    self.im.Publish("bnd_prev_Date", prevDate)
    self.im.Publish("bnd_next_Date", nextDate)
    self.im.Publish("bnd_league_color", LeagueColorValue)
    self.im.Publish("bnd_color_action", LeagueActionColorValue)
    self.im.Publish("bnd_new_nixture", "")
    self.im.Publish("bnd_advance_label", "Advance")
    matchday = false
   end
end


function Liga:Publishhomeinfo()
    if not GLOBAL_TEAM_ID then
        print("[Publishhomeinfo] GLOBAL_TEAM_ID not set")
        return
    end

    -- Ambil ID liga utama dan shared league
    local mainLeagueID = GetTeamLeagueID(GLOBAL_TEAM_ID)
    local sharedLeagueID = getSharedLeagueIDExtended(GLOBAL_TEAM_ID)

    local mainLeagueName = GetLeagueNameByID(mainLeagueID)
    local sharedLeagueName = nil

    if sharedLeagueID and sharedLeagueID ~= mainLeagueID then
        sharedLeagueName = GetLeagueNameByID(sharedLeagueID)
    end

    -- Buat teks info untuk tabel karier
    local careerInfoText
    if sharedLeagueName then
        careerInfoText = string.format("%s & %s", mainLeagueName or "Unknown", sharedLeagueName or "Unknown")
    else
        careerInfoText = mainLeagueName or "Unknown League"
    end

    -- Publish teks liga ke table karier
    self:publish(bnd_x, { text = careerInfoText })

    -- Siapkan data logo (crest)
    local leagueCrest = {
        name = "$TableLeague",
        id = sharedLeagueID or mainLeagueID
    }

    -- Publish logo liga
    self:publish("bnd_x", leagueCrest)

    print(string.format(
        "[Publishhomeinfo] Published: %s | Crest ID: %d",
        careerInfoText,
        leagueCrest.id or -1
    ))
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

    if day == 31 and month == 8 and year == 25 then
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

-- ============================================================
-- 3. Mainkan match (skip bye tapi tetap lanjut ke matchday berikut)
-- ============================================================
function Liga:PlayMatch()
    local startIndex = (GLOBAL_MATCHUP_COUNT * matchesPerRound) + 1
    local endIndex = startIndex + (matchesPerRound - 1)
    local foundMatchIndex

    for i = startIndex, endIndex do
        local matchData = LigaGrouping[ligaId][i]
        if matchData 
            and (matchData[1] == currentSelectedTeamID or matchData[2] == currentSelectedTeamID) then
            foundMatchIndex = i
            break
        end
    end

    if not foundMatchIndex then
        print("No match found for team " .. currentSelectedTeamID)
        return
    end

    local currentMatchData = LigaGrouping[ligaId][foundMatchIndex]
    local homeID, awayID = currentMatchData[1], currentMatchData[2]

    -- Kalau ketemu bye, otomatis lewati tapi tetap maju ke matchday berikutnya
    if homeID == 0 or awayID == 0 then
        print("This round is a bye for team " .. currentSelectedTeamID)
        GLOBAL_MATCHUP_COUNT = GLOBAL_MATCHUP_COUNT + 1
        return
    end

    -- Simpan data liga
    currentLigaData.Index = ligaId
    currentLigaData.round = foundMatchIndex
    currentLigaData.homeID = homeID
    currentLigaData.awayID = awayID
    currentLigaData.difficulty = currentMatchData[7]

    -- Setup pertandingan
    currentMatch.MatchType = "Epl"
    currentMatch.HomeTeamID = homeID
    currentMatch.AwayTeamID = awayID
    currentMatch.isUserSideHome = (homeID == currentSelectedTeamID) and 0 or 1

    local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, currentSelectedTeamID, 0)
    if not players then error("Failed to retrieve player lineup") end

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
      "evt_back"
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
  self.im.Unsubscribe("bnd_ads_standing")
  self.im.Unsubscribe("bnd_matchup_label")
  self.im.Unsubscribe("bnd_home_team_pos_marginLeft")
  self.im.Unsubscribe("bnd_away_team_pos_marginLeft")
  self.im.Unsubscribe("bnd_day_date_marginLeft")
  self.im.Unsubscribe("bnd_next_Date")
  self.im.Unsubscribe("bnd_league_name")
  self.im.Unsubscribe("bnd_league_name_central")
  self.im.Unsubscribe("bnd_day_date")
  self.im.Unsubscribe("bnd_new_nixture")
  self.im.Unsubscribe("bnd_formatted_Date")
  self.im.Unsubscribe("bnd_prev_Date")
  self.im.Unsubscribe("bnd_advance_label")
  self.im.Unsubscribe("bnd_month_label")
  self.im.Unsubscribe("bnd_finish_label")
  self.im.Unsubscribe("bnd_rank_home")
  self.im.Unsubscribe("bnd_rank_away")
  self.im.Unsubscribe(BND_TAB1_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_VISIBLE)
  self.im.Unsubscribe(BND_TAB3_VISIBLE)
  self.im.UnregisterAction(ACT_SELECTED)
  rivalListData = {}
end

return Liga

-- Thanks : Ma'ruf Id & Laosiji --
-- REMOD BY MOUNTSA --
-- @mvnprod.official - Remain Be Creative --
