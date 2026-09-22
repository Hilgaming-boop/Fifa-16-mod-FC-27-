local Config, sessionVars = ...
local StartMatch = {}

local CONSTANTS = {
  PLAYER_COUNT = 11,
  KIT_TYPES = {0, 1, 3},
  COLORS = {BLACK = "0x000000", WHITE = "0xFFFFFF"},
  VISIBILITY = {ON = 1, OFF = 0.02},
  SIDES = {"Home", "Away"},
  KEYS = {"Crest", "Kit"},
  FORMATION_DEFAULT = "formation21",
  DIFFICULTY_LEVELS = {"Amateur", "Beginner", "Intermediate", "Experienced", "World Class"},
  MONTH_NAMES = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"},
}

local function subscribeBindings(im, bindings, context)
  for _, binding in ipairs(bindings) do
    for i = 1, binding.count do
      im.Subscribe(binding.prefix .. i .. (binding.suffix or ""), function() binding.callback(context) end)
    end
  end
end

function StartMatch:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self

  o.services = {
    SquadManagementService = o.api("SquadMgtService"),
    settingsService = o.api("SettingsService"),
    gameSetupService = o.api("GameSetupService"),
    gameStateService = o.api("GameStateService"),
    TacticsService = o.api("TacticsService")
  }

  o.homeTeamID = currentMatch.HomeTeamID
  o.awayTeamID = currentMatch.AwayTeamID
  o.formationID = o.services.TacticsService.GetFormation(0, currentSelectedTeamID)
  local controllerId = o.services.gameStateService.GetPreferedControllerId() or 1
  o.customizationOptions = o.services.settingsService.GetCustomizationOptions(controllerId) or {}
  o.selectedBtnIndex = 1
  o.selectedTabBtnIdx = 1
  o.services.gameStateService.PauseAIandRendering(false)
  if o.homeTeamID == currentSelectedTeamID then
            -- Current team is the home team
            o.services.gameSetupService.SetTeam(0, o.homeTeamID)
            o.services.gameSetupService.SetTeam(1, o.awayTeamID)
            o.services.gameStateService.SetUserSideAsHome()
        elseif o.awayTeamID == currentSelectedTeamID then
            -- Current team is the away team
            o.services.gameSetupService.SetTeam(1, o.homeTeamID)
            o.services.gameSetupService.SetTeam(0, o.awayTeamID)
            o.services.gameStateService.SetUserSideAsHome()
        end
        o.currentOptions = o.services.settingsService.GetCurrentOptions() or {}

  o.teamData = {
    Home = {},
    Away = {},
  }
  for _, side in ipairs(CONSTANTS.SIDES) do
    local teamID = o[side:lower() .. "TeamID"]
    for i, kitType in ipairs(CONSTANTS.KIT_TYPES) do
      o.teamData[side][i] = {KITTYPE = kitType, YEAR = 0, TEAMID = teamID}
    end
  end

  local bindings = {
    {prefix = "bnd_starting", count = CONSTANTS.PLAYER_COUNT, callback = function(self) self:publishPlayers("formation" .. o.formationID) end},
    {prefix = "bnd_selected", count = CONSTANTS.PLAYER_COUNT, callback = function(self) self:publishPlayersBool() end},
    {prefix = "bnd_startingname", count = CONSTANTS.PLAYER_COUNT, callback = function(self) self:publishPlayers("formation" .. o.formationID) end},
    {prefix = "bnd_startingpos", count = CONSTANTS.PLAYER_COUNT, callback = function(self) self:publishPlayers("formation" .. o.formationID) end},
    {prefix = "bnd_startingovr", count = CONSTANTS.PLAYER_COUNT, callback = function(self) self:publishPlayers("formation" .. o.formationID) end},
    {prefix = "bnd_posTop", count = CONSTANTS.PLAYER_COUNT, callback = function(self) self:publishPlayers("formation" .. o.formationID) end},
    {prefix = "bnd_posLeft", count = CONSTANTS.PLAYER_COUNT, callback = function(self) self:publishPlayers("formation" .. o.formationID) end},
    {prefix = "bnd_btn", suffix = "textcolor", count = 3, callback = function(self) self:publishUI() end},
    {prefix = "bnd_btn", suffix = "visibility", count = 3, callback = function(self) self:publishUI() end},
    {prefix = "bnd_btn", suffix = "tabvisible", count = 2, callback = function(self) self:publishUI() end},
    {prefix = "bnd_btntabvisibility", count = 2, callback = function(self) self:publishTabUI() end},
    {prefix = "bnd_btntabtextcolor", count = 2, callback = function(self) self:publishTabUI() end},
  }
  subscribeBindings(o.im, bindings, o)

  for _, side in ipairs(CONSTANTS.SIDES) do
    for _, key in ipairs(CONSTANTS.KEYS) do
      o.im.Subscribe("bnd_" .. side .. key, function() o:publishTeamInfo() end)
    end
  end
  o.im.Subscribe("bnd_MatchInfo", function() o:publishMatchData() end)
  o.im.Subscribe("bnd_squadbtnvisible", function() o:publishUI() end)
  o.im.Subscribe("bnd_headvisible", function() o:publishUI() end)

  local actions = {
    {"act_btn1", function() o:_clickAction(1) end},
    {"act_btn2", function() o:_clickAction(2) end},
    {"act_btn3", function() o:_clickAction(3) end},
    {"act_onSquad", function() o:_clickAction(4) end},
    {"act_subbtn1", function() o:subTabAction(1) end},
    {"act_subbtn2", function() o:subTabAction(2) end},
    {"act_exit", function() o:exit() end},
  }
  for _, action in ipairs(actions) do
    o.im.RegisterAction(action[1], action[2])
  end
  if not sessionVars.get("isPreMatch") then
    o:init()
  end
  o:publishUI()
  return o
end

function StartMatch:init()
  local teamID = currentSelectedTeamID or self.homeTeamID
  local players = getCachedTeamPlayers(teamID) or {}
  local mainFormation = self.formationID
  local mainSquad = {}
    for i = 1, #players do
      mainSquad[i] = players[i].CARD_ID
    end
  sessionVars.set("teamMgtData", {players = mainSquad, formation = mainFormation})
  sessionVars.set("isPreMatch", true)
end

function StartMatch:exit()
  local teamID = currentSelectedTeamID or self.homeTeamID
  local TeamCachedData = sessionVars.get("TeamCachedData")
  local teamData = sessionVars.get("teamMgtData")
  local players = teamData.players
  local formationID = teamData.formation
  self.services.SquadManagementService.SetCurrentPlayerLineup(0, teamID, 0, 0, players)
  self.services.TacticsService.SetFormation(0, teamID, formationID)
  local squad = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)
  TeamCachedData[teamID].players = squad  
  sessionVars.set("TeamCachedData", TeamCachedData)
  sessionVars.set("isPreMatch", false)
  sessionVars.set("teamMgtData", nil)
  self.nav.Event(nil, "evt_back")
end

function StartMatch:publishUI(idx)
  idx = idx or self.selectedBtnIndex or 1
  self.selectedBtnIndex = idx
  for i = 1, 3 do
    self.im.Publish("bnd_btn" .. i .. "textcolor", i == idx and CONSTANTS.COLORS.BLACK or CONSTANTS.COLORS.WHITE)
    self.im.Publish("bnd_btn" .. i .. "visibility", i == idx and CONSTANTS.VISIBILITY.ON or CONSTANTS.VISIBILITY.OFF)
  end
  self.im.Publish("bnd_headvisible", idx ~= 2)
  self.im.Publish("bnd_squadbtnvisible", idx ~= 2)
  self.im.Publish("bnd_btn1tabvisible", idx == 2)
  self.im.Publish("bnd_btn2tabvisible", idx == 3)
end

function StartMatch:subTabAction(idx)
  local actions = {
    [2] = {"evt_matchsim", "evt_advance"}, 
    [3] = {"evt_kitselect", "evt_to_settings_customize"}, 
  }
  if self.selectedTabBtnIdx ~= idx then
    self:publishTabUI(idx)
  else
    local action = actions[self.selectedBtnIndex] or actions[2] 
    if idx == 2 and self.selectedBtnIndex == 2 then
      coachMode = true
    end
    self.nav.Event(nil, action[idx])
  end
end

function StartMatch:publishTabUI(idx)
  idx = idx or 1
  self.selectedTabBtnIdx = idx
  for i = 1, 2 do
    self.im.Publish("bnd_btntabtextcolor" .. i, i == idx and CONSTANTS.COLORS.BLACK or CONSTANTS.COLORS.WHITE)
    self.im.Publish("bnd_btntabvisibility" .. i, i == idx and CONSTANTS.VISIBILITY.ON or CONSTANTS.VISIBILITY.OFF)
  end
end

function StartMatch:_clickAction(idx)
  if self.selectedBtnIndex ~= idx then
    if idx ~= 4 then
      self:publishUI(idx)
    else
      self.nav.Event(nil, "evt_squad")
    end
  elseif idx == 1 then
    self.nav.Event(nil, "evt_advance")
  end
  self:resetTabState()
end

function StartMatch:resetTabState()
  self.selectedTabBtnIdx = 0
end

function StartMatch:publishPlayersBool()
  for i = 1, CONSTANTS.PLAYER_COUNT do
    self.im.Publish("bnd_selected" .. i, false)
  end
end

function StartMatch:publishPlayers(formationKey)
  local teamID = currentSelectedTeamID or self.homeTeamID
  local players = getCachedTeamPlayers(teamID) or {}
  local kitData = self.teamData.Home[1]
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  local formation = Config.FORMATION_POSITIONS[formationKey or CONSTANTS.FORMATION_DEFAULT] or {}
  for i = 1, CONSTANTS.PLAYER_COUNT do
    local player = players[i] or {}
    self.im.Publish("bnd_starting" .. i, {name = "$Head", id = player.CARD_ID or 0})
    self.im.Publish("bnd_startingname" .. i, player.playerName or "")
    self.im.Publish("bnd_startingpos" .. i, player.position or "")
    self.im.Publish("bnd_startingovr" .. i, player.rating or 0)
    self.im.Publish("bnd_posTop" .. i, (formation[i] or {}).top or 0)
    self.im.Publish("bnd_posLeft" .. i, (formation[i] or {}).left or 0)
  end
end

function StartMatch:parseDate(dateStr)
  if not dateStr then return nil, "Date string is nil" end
  local day, month, year = dateStr:match("^(%d%d)/(%d%d)/(%d%d)$")
  if not day then return nil, "Invalid date format" end
  return {day = tonumber(day), month = tonumber(month), year = 2000 + tonumber(year)}
end

function StartMatch:formatDate(dateStr)
  local date, err = self:parseDate(dateStr or GLOBAL_DATE_PLACEHOLDER or "01/01/00")
  if not date then return "Unknown Date" end
  return string.format("%d %s %d", date.day, CONSTANTS.MONTH_NAMES[date.month] or "Unknown", date.year)
end

function StartMatch:getMatchData(data)
  return data and data.currentValue or 0
end

function StartMatch:publishTeamInfo()
  local homeKitIndex = currentMatch.HomeKitIndex or 0
  local awayKitIndex = currentMatch.AwayKitIndex or 0
  local homeKitData = self.teamData.Home[homeKitIndex + 1] or self.teamData.Home[1]
  local awayKitData = self.teamData.Away[awayKitIndex + 1] or self.teamData.Away[1]
  local homeKitId = string.format("%s_%s_%s", homeKitData.KITTYPE, homeKitData.TEAMID, homeKitData.YEAR)
  local awayKitId = string.format("%s_%s_%s", awayKitData.KITTYPE, awayKitData.TEAMID, awayKitData.YEAR)
  self.im.Publish("bnd_HomeCrest", {name = "$Crest", id = self.homeTeamID})
  self.im.Publish("bnd_AwayCrest", {name = "$Crest", id = self.awayTeamID})
  self.im.Publish("bnd_HomeKit", {name = "$Kits", id = homeKitId})
  self.im.Publish("bnd_AwayKit", {name = "$Kits", id = awayKitId})
end

function StartMatch:publishMatchData()
  local halfLength = self:getMatchData(self.customizationOptions[4] and self.customizationOptions[4].data) or 1
  local difficultyIndex = self:getMatchData(self.customizationOptions[5] and self.customizationOptions[5].data) or 0
  local difficulty = CONSTANTS.DIFFICULTY_LEVELS[difficultyIndex + 1] or "Unknown"
  local date = self:formatDate(GLOBAL_DATE_PLACEHOLDER)
  local stadiumName = self.currentOptions.stadium or "Emirates Stadium"
  local matchInfo = string.format("%s | %s | %s | %d Minute%s", stadiumName, date, difficulty, halfLength, halfLength == 1 and "" or "s")
  self.im.Publish("bnd_MatchInfo", matchInfo)
end

return StartMatch