-- Remod By Inisial A --

local Liga = {}
local bndMatchList = "bnd_match_list"
local bndMatchList1 = "bnd_match_list1"
local bndTeamLogo = "bnd_team_logo"
local bndTeamName = "bnd_team_name"
local ACT_ADVANCE = "act_advance"

ligaId = 1

--  FULL FIXED LEAGUE LABEL SCRIPT --

local LeagueIDs = {
  {ids={13,1925,14,110,18,19,5,2,10,144,1,11,1799,1943,1808,7,9,8,1796,106,126990},compID=13}, -- Premier League
  {ids={1860,449,457,243,461,240,241,453,448,450,483,110062,481,479,463,480,452,110827,1853,468},compID=53}, -- La Liga
  {ids={52,46,347,55,1842,110556,206,110374,39,48,44,54,45,189,50,1745,47,110738,111974,111434},compID=31}, -- Serie A
  {ids={175,38,112172,23,36,32,1831,21,100409,1824,25,111235,22,110329,10029,169,31,28},compID=19}, -- Bundesliga
  {ids={65,69,76,210,219,73,62,66,64,74,1738,72,71,1530,57,378,379,1809,217,111817},compID=16}, -- Ligue 1
  {ids={111114,1415,111391,111502,1413,111466,111510,111115,111512,1411,974,111392,111518,111523,111527,111528,111533,111536,111485,111488},compID=10}, -- AFC U23
  {ids={155600,155607,155609,155606,155611,155614,155621,155604,155602,155630,155603,155612,155616,155617,155620,155624,155601,155615,155610,155618},compID=11}, -- BRI Liga 1
  {ids={681,1750,670,100081,229,100087,110724,230,673,680,231,674,232,2014,537,675},compID=12}, -- Pro League  
  {ids={15,97,1800,1919,109,1960,1952,1807,1794,1806,12,3,1795,1792,19521,1790,91,1801,88,1951,1947,17,94,95,89},compID=14}, -- EFL Championship 
  {ids={634,1913,245,1903,247,1910,100632,1908,246,100646,1906,1915,1914,100634,1904,645,1971},compID=15}, -- Eredivisie
  {ids={111140,114161,697,114640,111928,639,688,112828,694,691,113149,112893,114162,112885,687,112134,101112,112996,112606,111651,698,111065,696,689,111139,111138,695,111144,113018,115243},compID=17}, -- MLS
  {ids={112392,112390,112408,111674,112096,112139,113057,112883,112393,113060,113217,607,113037,605,112387,112391,121735,112675,139485,113222},compID=18} -- SPL   
}

local LeagueMap = {}
for _,v in ipairs(LeagueIDs) do
  for _,id in ipairs(v.ids) do
    LeagueMap[id] = v.compID
  end
end
LeagueMap[-1] = 0

local LeagueNames = {
  [13] = "PREMIER LEAGUE",
  [53] = "LALIGA EA SPORTS",
  [31] = "SERIE A",
  [19] = "BUNDESLIGA",
  [16] = "LIGUE 1",
  [10] = "AFC ASIAN CUP QATAR U23",
  [11] = "BRI SUPER LEAGUE",
  [12] = "PRO LEAGUE",
  [14] = "EFL CHAMPIONSHIP",
  [15] = "EREDIVISIE",
  [17] = "MLS",
  [18] = "ROSHN SAUDI LEAGUE"
}

local function getLeague(teamID, name)
  return { name = name, id = LeagueMap[teamID] or 0 }
end

if not round then round = 1 end
if not selectedteam then selectedteam = 0 end

currentMatch = {
  HomeTeamID = 0,
  AwayTeamID = 0,
  HomeKitIndex = 0,
  AwayKitIndex = 1
}

local rivalListData = {}
local matchesPlayed = 0

function Liga:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    settingsService = o.api("SettingsService"),
    SquadManagementService = o.api("SquadMgtService")
  }

  o.currentOptions = o.services.settingsService.GetCurrentOptions()
  o.Init()
  
  --  Subscribe bindings utama
  o.im.Subscribe(bndMatchList, function() o:publishMatchRows() end)
  o.im.Subscribe(bndMatchList1, function() o:publishMatchRows2() end)

  --  Tambahan label liga
  o.im.Subscribe("bnd_league_label", function()
    o:publishLeagueLabel()
  end)

  --  Subscribe lain
  o.im.Subscribe("bnd_leaguebackground", function()
    local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
    o.im.Publish("bnd_leaguebackground", bg)
  end)

  o.im.Subscribe("bnd_leaguetable", function()
    local tbl = getLeagueTableAllByTeam(currentSelectedTeamID)
    o.im.Publish("bnd_leaguetable", tbl)
  end)

  o.im.Subscribe("bnd_logotable", function()
    local ll = getLeagueLogotableByTeam(currentSelectedTeamID)
    o.im.Publish("bnd_logotable", ll)
  end)

  o.im.Subscribe(bndTeamLogo, function()  
    o.im.Publish(bndTeamLogo, {name = "$Crest64x64", id = currentSelectedTeamID})   
  end)
  
  o.im.Subscribe(bndTeamName, function()  
    o.im.Publish(bndTeamName, o.loc.LocalizeString("TeamName_Abbr15_"..currentSelectedTeamID))       
  end)

  o.im.Subscribe("bnd_match_label", function() o:publishMatchLabel() end)
  o.im.Subscribe("bnd_point_label", function() o:publishMatchLabel() end)
  o.im.Subscribe("bnd_finish_label", function() o:publishFinishLabel() end)
  o.im.Subscribe("bnd_team_label", function() o:publishLabel() end)
  o.im.Subscribe("bnd_matchup_label", function() o:publishFinishLabel() end)
  o.im.Subscribe("bnd_matchday_label", function() o:publishLabel() end)
  o.im.Subscribe("bnd_advance_label", function() o:publishFinishLabel() end)
  o.im.Subscribe("bnd_month_label", function() o:publishFinishLabel() end)
  
  o.im.RegisterAction(ACT_ADVANCE, function(actionName, data)
    if data then o:PlayMatch(data) end
  end)

  o.im.RegisterAction("act_nextteam", function() o:NextTeam() end)
  o.im.RegisterAction("act_previousteam", function() o:PrevTeam() end)
  o.im.RegisterAction("act_next", function() o:NextMatchday() end)
  o.im.RegisterAction("act_decrease", function() o:PrevMatchday() end)
  
  return o
end

--  FUNGSI LABEL LIGA (AUTO DETECT + DEFAULT EA SPORTS)
function Liga:publishLeagueLabel()
  local teamID = currentSelectedTeamID or selectedteam or 0
  local leagueID = LeagueMap[teamID] or 0
  local leagueName = LeagueNames[leagueID]

  --  Default fallback
  if not leagueName or leagueName == "" then
    leagueName = "EA SPORTS"
  end
  
  self.im.Publish("bnd_league_label", leagueName)
end

function Liga:Init()
  local LigaGroupingList = LigaGrouping[ligaId]
  for i = 1, table.getn(LigaGroupingList) do
    local obj = {
      homeID = LigaGroupingList[i][1],
      awayID = LigaGroupingList[i][2],
      homeScore = LigaGroupingList[i][4],
      awayScore = LigaGroupingList[i][5],
      data = {}
    }
    table.insert(rivalListData, obj)
  end
end

function Liga:publishLabel()
  self.im.Publish("bnd_matchday_label", "Matchday " .. round)
  if selectedteam == 0 then
    self.im.Publish("bnd_team_label", "Matchday ")
  else
    self.im.Publish("bnd_team_label", self.loc.LocalizeString("TeamName_Abbr15_" .. TeamList[selectedteam]))
  end
end

local SelectedTeamID = (selectedteam ~= 0) and TeamList[selectedteam] or nil

function Liga:getNextOpponent(teamID)
    if not GLOBAL_MATCHUP_COUNT then return nil end

    local nextMatchday = GLOBAL_MATCHUP_COUNT + 1
    local matchRangeStart = (nextMatchday-1)*10 + 1
    local matchRangeEnd = nextMatchday*10

    for j = matchRangeStart, matchRangeEnd do
        if LigaGrouping[ligaId] and LigaGrouping[ligaId][j] then
            local matchData = LigaGrouping[ligaId][j]
            if matchData[1] == teamID then
                return matchData[2]
            elseif matchData[2] == teamID then
                return matchData[1]
            end
        end
    end
    return nil
end

--Remod By Inisial A--
function Liga:publishMatchRows2()
    local teamDataList = {}
    local SelectedTeamID = nil

    -- Tentukan tim yang dipilih
    if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
        SelectedTeamID = currentSelectedTeamID
    elseif selectedteam and selectedteam ~= 0 then
        SelectedTeamID = TeamList[selectedteam]
    elseif currentMatch and currentMatch.HomeTeamID and currentMatch.HomeTeamID ~= 0 then
        SelectedTeamID = currentMatch.HomeTeamID
    end

    local LigaGroupingList = LigaGrouping[ligaId]
    local matchCount = #TeamList / 2
    local startIndex = ((round - 1) * matchCount) + 1
    local endIndex = startIndex + matchCount - 1

    -- =============================
    -- Mapping label per liga (compID)
    -- =============================
    local leagueLabelRanges = {
        ------------------------------------[13] = { {pos=1,label="Champion"}, {pos=2,label="UEFA Champions League"}, {pos=4,label="UEFA Europa League"}, {pos=6,label="UEFA Conference League"} },
        ------------------------------------[53] = { {pos=1,label="Champion"}, {pos=2,label="UEFA Champions League"}, {pos=4,label="UEFA Europa League"}, {pos=6,label="UEFA Conference League"} },
        ------------------------------------[31] = { {pos=1,label="Champion"}, {pos=2,label="UEFA Champions League"}, {pos=4,label="UEFA Europa League"}, {pos=6,label="UEFA Conference League"} },
        ------------------------------------[19] = { {pos=1,label="Champion"}, {pos=2,label="UEFA Champions League"}, {pos=4,label="UEFA Europa League"}, {pos=6,label="UEFA Conference League"} },
        ------------------------------------[16] = { {pos=1,label="Champion"}, {pos=2,label="UEFA Champions League"}, {pos=5,label="UEFA Europa League"}, {pos=7,label="UEFA Conference League"} },
        ------------------------------------[11] = { {pos=1,label="Champion"}, {pos=2,label="AFC Champions League Elite"}, {pos=4,label="AFC Champions League Two"}, {pos=6,label="AFC Challenge League"} },
        ------------------------------------[18] = { {pos=1,label="Champion"}, {pos=2,label="AFC Champions League Elite"}, {pos=4,label="AFC Champions League Two"}, {pos=6,label="AFC Challenge League"} },        
    }

    -- =============================
    -- Warna label per liga
    -- =============================
    local leagueLabelColors = {
        ------[13] = "0x000000", -- Merah keunguan
        ------[53] = "0x000000", -- Biru
        ------[31] = "0x000000", -- Abu-abu
        ------[19] = "0x000000", -- Biru muda
        ------[16] = "0x000000", -- Biru
        ------[11] = "0x000000", -- Biru tua
    }

    -- =============================
    -- Kumpulkan data tim
    -- =============================
    for _, teamID in ipairs(TeamList) do
        local teamData = {}
        teamData.TeamCrest = { name = "$Crest64x64", id = teamID }
        teamData.TeamName = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID)

        local function safeNum(val) return tonumber(val) or 0 end
        local function safeStr(val) return val and tostring(val) or "0" end

        teamData.TeamWin  = safeStr(GetTeamWins(teamID))
        teamData.TeamDraw = safeStr(GetTeamDraws(teamID))
        teamData.TeamLoss = safeStr(GetTeamLosses(teamID))
        teamData.TeamGA   = safeNum(GetTeamGoalsScored(teamID))
        teamData.TeamGC   = safeNum(GetTeamGoalsConceded(teamID))
        teamData.TeamGD   = teamData.TeamGA - teamData.TeamGC
        teamData.TeamPoint= safeNum(GetTeamPoints(teamID))
        teamData.Teammp   = GLOBAL_MATCHUP_COUNT or 0
        teamData.clickAction = "ViewTeamDetails_" .. teamID

        local normalColor = "0x808080"
        local highlightColor = "0xFFFFFF"
        local colorToUse = (SelectedTeamID and teamID == SelectedTeamID) and highlightColor or normalColor

        teamData.TeamNameColor = colorToUse
        teamData.TeamposColor  = colorToUse
        teamData.TeammpColor   = colorToUse
        teamData.TeamWinColor  = colorToUse
        teamData.TeamDrawColor = colorToUse
        teamData.TeamLossColor = colorToUse
        teamData.TeamGAColor   = colorToUse
        teamData.TeamGCColor   = colorToUse

        local compID = LeagueMap[teamID] or 0
        teamData.TeamLigaID = compID

    local nextOpponentID = self:getNextOpponent(teamID)
    if nextOpponentID then
        teamData.NextOpponentCrest = {
            name = "$Crest64x64",
            id = nextOpponentID
        }
    else
        teamData.NextOpponentCrest = {
            name = "$Crest64x64",
            id = 0
        }
    end

        if SelectedTeamID and teamID == SelectedTeamID then
            teamData.Icon = { name = "$checkmark", id = teamID }
        else
            teamData.Icon = nil
        end

        teamData.RightText = ""
        table.insert(teamDataList, { data = teamData })
    end

    -- =============================
    -- Urutkan tabel
    -- =============================
    table.sort(teamDataList, function(a,b)
        if a.data.TeamPoint ~= b.data.TeamPoint then return a.data.TeamPoint > b.data.TeamPoint end
        if a.data.TeamGD ~= b.data.TeamGD then return a.data.TeamGD > b.data.TeamGD end
        return a.data.TeamName < b.data.TeamName
    end)

    for i, team in ipairs(teamDataList) do
        team.data.Teampos = tostring(i)
    end

    -- =============================
    -- Sisipkan label sesuai ID
    -- =============================
    local labeledList = {}
    local totalTeams = #teamDataList
    local relegationStart = totalTeams - 2
    local relegationPlaced = false

    for i, row in ipairs(teamDataList) do
        local pos = tonumber(row.data.Teampos)
        local leagueText = nil
        local color = "0x000000"
        local compID = row.data.TeamLigaID
        local labelRanges = leagueLabelRanges[compID]

        if leagueLabelColors[compID] then
            color = leagueLabelColors[compID]
        end

        -- Ambil label persis sesuai ID
        -------if labelRanges then
            -------for _, l in ipairs(labelRanges) do
                -------if pos == l.pos then
                    -------leagueText = l.label
                    -------break
                -------end
            -------end
        -------end

        -- Default Champion & Relegation
        -------if not leagueText then
            -------if pos == 1 then
                -------leagueText = "Champion"
            -------elseif pos >= relegationStart and not relegationPlaced then
                -------leagueText = "Relegation"
                -------relegationPlaced = true
            -------end
        -------end

        if leagueText then
            table.insert(labeledList, {
                data = {
                    IsLabelRow = true,
                    LeagueLabel = leagueText,
                    LeagueLabelColor = "0xFFFFFFFF",
                    LeagueLabelBGColor = color,
                    Teampos = "",
                    TeamName = "",
                    Teammp = "",
                    TeamWin = "",
                    TeamDraw = "",
                    TeamLoss = "",
                    TeamGA = "",
                    TeamGC = "",
                    TeamPoint = ""
                }
            })
        end

        table.insert(labeledList, row)
    end

    self.im.Publish(bndMatchList1, labeledList)
end

function Liga:publishMatchRows()
  local filteredRivalListData = {}
  local matchCount = (#TeamList / 2)

  local SelectedTeamID = nil
  if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
    SelectedTeamID = currentSelectedTeamID
  elseif selectedteam and selectedteam ~= 0 then
    SelectedTeamID = TeamList[selectedteam]
  end

  for i, v in ipairs(rivalListData) do
    local shouldIncludeMatch = false

    if selectedteam == 0 then
      shouldIncludeMatch = i >= ((round * matchCount) - (matchCount - 1)) and i <= (round * matchCount)
    else
      shouldIncludeMatch = (rivalListData[i].homeID == TeamList[selectedteam] or rivalListData[i].awayID == TeamList[selectedteam])
    end

    if shouldIncludeMatch then
      v.data.TeamHomeCrest = { name = "$Crest64x64", id = rivalListData[i].homeID }
      v.data.TeamAwayCrest = { name = "$Crest64x64", id = rivalListData[i].awayID }
      v.data.TeamHomeName = self.loc.LocalizeString("TeamName_Abbr3_" .. rivalListData[i].homeID)
      v.data.TeamAwayName = self.loc.LocalizeString("TeamName_Abbr3_" .. rivalListData[i].awayID)

      local maxRowsWithScores = GLOBAL_MATCHUP_COUNT * 10
      if i <= maxRowsWithScores then
        rivalListData[i].data.MatchScore = rivalListData[i].homeScore .. " - " .. rivalListData[i].awayScore
      else
        rivalListData[i].data.MatchScore = "  vs"
      end

      v.data.TeamScoreFontColor = "0xffffff"
      v.data.TeamNameFontColor = "0x4A2C6D"
      v.data.FontColor = "0x4A2C6D"

      v.data.HomeIcon = (rivalListData[i].homeID == SelectedTeamID) and { name = "$checkmark", id = rivalListData[i].homeID } or nil
      v.data.AwayIcon = (rivalListData[i].awayID == SelectedTeamID) and { name = "$checkmark", id = rivalListData[i].awayID } or nil
      
      v.data.RightText = ""
      table.insert(filteredRivalListData, v)
    end
  end
  
  self.im.Publish(bndMatchList, filteredRivalListData)
end

function Liga:NextMatchday()
  if not TeamList or #rivalListData == 0 then return end
  local matchCount = #TeamList / 2
  local maxRound = #rivalListData / matchCount
  if round < maxRound then
    round = round + 1
    self:publishMatchRows2()
    self:publishMatchRows()
    self:publishLabel()
  end
end

function Liga:PrevMatchday()
  if round > 1 then
    round = round - 1
    self:publishMatchRows2()
    self:publishMatchRows()
    self:publishLabel()
  end
end

function Liga:NextTeam()
  if not TeamList then return end
  local teamCount = #TeamList
  selectedteam = selectedteam + 1
  if selectedteam > teamCount then
    selectedteam = 0
  end
  self:publishMatchRows2()
  self:publishMatchRows()
  self:publishLabel()
end

function Liga:PrevTeam()
  if not TeamList then return end
  local teamCount = #TeamList
  if selectedteam > 0 then
    selectedteam = selectedteam - 1
  else
    selectedteam = teamCount
  end
  self:publishMatchRows2()
  self:publishMatchRows()
  self:publishLabel()
end

function Liga:finalize()
  self.im.UnregisterAction(ACT_ADVANCE)
  self.im.Unsubscribe("bnd_match_list")
  self.im.Unsubscribe("bnd_match_list1")
  self.im.Unsubscribe("bnd_matchday_label")
  self.im.Unsubscribe("bnd_point_label")
  self.im.Unsubscribe("bnd_team_label")
  self.im.Unsubscribe("bnd_matchup_label")
  self.im.Unsubscribe("bnd_matchdate_label")
  self.im.Unsubscribe("bnd_league_label")
  self.im.Unsubscribe("bnd_advance_label")
  self.im.Unsubscribe("bnd_month_label")
  self.im.Unsubscribe("bnd_finish_label")
  rivalListData = {}
end

return Liga