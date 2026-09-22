-- Remod By MounTsa --

local Liga = {}
local bndMatchList = "bnd_match_list"
local bndMatchList1 = "bnd_match_list1"
local bndTeamLogo = "bnd_team_logo"
local bndTeamName = "bnd_team_name"
local ACT_ADVANCE = "act_advance"

ligaId = 1

if not round then
  round = 1
else 
  round = round
end

if not selectedteam then
  selectedteam = 0
else 
  selectedteam = selectedteam
end

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
  
  o.im.Subscribe(bndMatchList, function()
     o:publishMatchRows()
  end)
  
  o.im.Subscribe(bndMatchList1, function()
     o:publishMatchRows2()
  end)
 
-- 🔹 O.IM SUBSCRIBE EVENT
o.im.Subscribe("bnd_leaguebackground", function()
  local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_leaguebackground", bg)
end)
  
o.im.Subscribe("bnd_table_career", function()
  local tb = getLeagueTableByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_table_career", tb)
end)

o.im.Subscribe("bnd_standings_career", function()
  local st = getLeagueStandingsByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_standings_career", st)
end)

o.im.Subscribe("bnd_logoleague", function()
  local ll = getLeagueLogoByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_logoleague", ll)
end)

  o.im.Subscribe(bndTeamLogo, function()  
    o.im.Publish(bndTeamLogo, {name = "$Crest64x64", id = currentSelectedTeamID})   
  end)
  
  o.im.Subscribe(bndTeamName, function()  
    o.im.Publish(bndTeamName, o.loc.LocalizeString("TeamName_Abbr15_"..currentSelectedTeamID))       
  end)
  
  o.im.Subscribe("bnd_match_label", function()
    o:publishMatchLabel()
  end)
  
  o.im.Subscribe("bnd_point_label", function()
    o:publishMatchLabel()
  end)
  
  o.im.Subscribe("bnd_finish_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_team_label", function()
    o:publishLabel()
  end)
  
  o.im.Subscribe("bnd_matchup_label", function()
    o:publishFinishLabel()
  end)
  
  o.im.Subscribe("bnd_matchday_label", function()
    o:publishLabel()
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

  o.im.RegisterAction("act_nextteam", function() o:NextTeam() end)
  o.im.RegisterAction("act_previousteam", function() o:PrevTeam() end)
  o.im.RegisterAction("act_next", function() o:NextMatchday() end)
  o.im.RegisterAction("act_decrease", function() o:PrevMatchday() end)
  
  return o
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

function Liga:publishMatchRows2()
  local teamDataList = {}
  local SelectedTeamID = nil

  -- Tentukan tim yang sedang dipilih
  if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
    SelectedTeamID = currentSelectedTeamID
  elseif selectedteam and selectedteam ~= 0 then
    SelectedTeamID = TeamList[selectedteam]
  elseif currentMatch and currentMatch.HomeTeamID and currentMatch.HomeTeamID ~= 0 then
    SelectedTeamID = currentMatch.HomeTeamID
  end

  for _, teamID in ipairs(TeamList) do
    local teamData = {}
    teamData.TeamCrest = { name = "$Crest64x64", id = teamID }
    teamData.TeamName = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID)
    teamData.TeamWin = tostring(GetTeamWins(teamID))
    teamData.TeamDraw = tostring(GetTeamDraws(teamID))
    teamData.TeamPoint = tonumber(GetTeamPoints(teamID))
    teamData.TeamLoss = tostring(GetTeamLosses(teamID))
    teamData.TeamGA = tonumber(GetTeamGoalsScored(teamID))
    teamData.TeamGC = tonumber(GetTeamGoalsConceded(teamID))
    teamData.TeamGD = teamData.TeamGA - teamData.TeamGC
    teamData.Teammp = GLOBAL_MATCHUP_COUNT
    teamData.clickAction = "ViewTeamDetails_" .. teamID
    teamData.TeamScoreFontColor = "0xffffff"
    teamData.TeamNameFontColor = "0xffffff"
    teamData.FontColor = "0xffffff"

    -- Tambah rectangle highlight
    if SelectedTeamID and teamID == SelectedTeamID then
      teamData.Highlight = true
      teamData.HighlightColor = "0xFFFFFF" 
      teamData.Background = { name = "$HighlightRect", color = "0xFFFFFF", alpha = 0 }
      teamData.Icon = { name = "$checkmark", id = teamID }
    else
      teamData.Highlight = false
      teamData.HighlightColor = "0x000000"
      teamData.Background = nil
      teamData.Icon = nil
    end

    teamData.RightText = ""
    table.insert(teamDataList, { data = teamData })
  end

  -- Urutkan berdasarkan poin, GD, dan nama
  table.sort(teamDataList, function(a, b)
    if a.data.TeamPoint ~= b.data.TeamPoint then
      return a.data.TeamPoint > b.data.TeamPoint
    end
    if a.data.TeamGD ~= b.data.TeamGD then
      return a.data.TeamGD > b.data.TeamGD
    end
    return a.data.TeamName < b.data.TeamName
  end)

  -- Cek jika semua poin masih 0
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

  -- Tambahkan posisi peringkat
  for i, team in ipairs(teamDataList) do
    team.data.Teampos = tostring(i)
  end

  -- Publish ke UI
  self.im.Publish(bndMatchList1, teamDataList)
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