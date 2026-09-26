-- New Custom Menu By MVNPROD --
local MatchSelect = {}
local eventmanager, PregameManager, CommonNavVars, TableUtil = ...
local EventTypes = eventmanager.FE.FIFA.EventTypes
local BND_LOGO_TIM_HOME = "bnd_logo_tim_home"
local BND_LOGO_TIM_AWAY = "bnd_logo_tim_away"
local BND_MAN_TIM_HOME = "bnd_man_tim_home"
local BND_MAN_TIM_AWAY = "bnd_man_tim_away"
local bndHomeTeamName = "bnd_home_team_name"
local bndAwayTeamName = "bnd_away_team_name"
local bndStadiumName = "bnd_stadium_name"
local BND_INFO_MATCH = "bnd_info_match"
local ACT_ADVANCE = "act_advance"
function MatchSelect:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    matchSetup = o.api("MatchSetupService"),
    gameSetup = o.api("GameSetupService"),
    gameState = o.api("GameStateService"),
    preGame = o.api("PregameService"),
    MatchInfoService = o.api("MatchInfoService"),
    SettingsService = o.api("SettingsService"),
    EventManagerService = o.api("EventManagerService")
  }
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
  o:handleEvent(...)
  end)
  o.homeTeamID = currentMatch.HomeTeamID
  o.awayTeamID = currentMatch.AwayTeamID
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.CurrentOptions = o.services.SettingsService.GetCurrentOptions()
  o.currentTeamName = { name = ""}
  o.currentStadium = { name = "", { id = 0 } }
  o:initOptionsTeam()
  o:initOptionsStadium()
  o.im.Subscribe(bndHomeTeamName, function()
    o:publishHomeTeamName()
  end)
  o.im.Subscribe(bndAwayTeamName, function()
    o:publishAwayTeamName()
  end)
  o.im.Subscribe(bndStadiumName, function()
    o:publishStadiumName()
  end)
  LOGO_HOME = {
    name = "$Crest",
    id = o.homeTeamID
  }
  LOGO_AWAY = {
    name = "$Crest",
    id = o.awayTeamID
  }
  MAN_HOME = {
    name = "$PlayersPMH",
    id = o.homeTeamID
  }
  MAN_AWAY = {
    name = "$PlayersPMA",
    id = o.awayTeamID
  }
  o.im.Subscribe(BND_LOGO_TIM_HOME, function()
    o.im.Publish(BND_LOGO_TIM_HOME, LOGO_HOME)
  end)
  o.im.Subscribe(BND_LOGO_TIM_AWAY, function()
    o.im.Publish(BND_LOGO_TIM_AWAY, LOGO_AWAY)
  end)
  o.im.Subscribe(BND_MAN_TIM_HOME, function()
    o.im.Publish(BND_MAN_TIM_HOME, MAN_HOME)
  end)
  o.im.Subscribe(BND_MAN_TIM_AWAY, function()
    o.im.Publish(BND_MAN_TIM_AWAY, MAN_AWAY)
  end)
  o.im.Subscribe("bnd_difficulty", function()
    o.im.Publish("bnd_difficulty", o.CurrentOptions.difficulty)
  end)
  o.im.Subscribe(BND_INFO_MATCH, function()
    local state = "Stadium : "..o.currentStadium.name.."          ".."Length : - Half Length".."          ".."Difficulty : "..o.CurrentOptions.difficulty.."          ".."Match : Friendly"
    o.im.Publish(BND_INFO_MATCH, state)
  end)
  o.im.RegisterAction(ACT_ADVANCE, function(actionName)
    o:PlayMatch()
  end)
  o.im.RegisterAction("act_squadhome", function(actionName)
    currentMatch.SquadId = 0
    o.nav.Event(nil, "evt_squadhome")
  end)
  o.im.RegisterAction("act_squadaway", function(actionName)
    currentMatch.SquadId = 1
    o.nav.Event(nil, "evt_squadaway")
  end)
  return o
end
function MatchSelect:initOptionsTeam()
  local currentHomeTeam = currentMatch.HomeTeamID
      if currentHomeTeam == self.awayTeamID then
  elseif currentHomeTeam == self.homeTeamID then
  end
  self.currentTeamName.home = self.loc.LocalizeString("TeamName_Abbr15_"..self.homeTeamID)
  self.currentTeamName.away = self.loc.LocalizeString("TeamName_Abbr15_"..self.awayTeamID)
end
function MatchSelect:publishHomeTeamName()
  self.im.Publish(bndHomeTeamName, self.currentTeamName.home)
end
function MatchSelect:publishAwayTeamName()
  self.im.Publish(bndAwayTeamName, self.currentTeamName.away)
end
function MatchSelect:initOptionsStadium()
  local currentHomeTeam = currentMatch.HomeTeamID
  if currentHomeTeam == self.awayTeamID then
    self.currentStadium.bg.id = currentMatch.StadiumID2
  elseif currentHomeTeam == self.homeTeamID then
    self.currentStadium.id = currentMatch.StadiumID1
  end
  self.currentStadium.name = self.loc.LocalizeString("StadiumName_"..self.currentStadium.id)
end
function MatchSelect:publishStadiumName()
  self.im.Publish(bndStadiumName, self.currentStadium.name)
end
-- Popup Play Match --
function MatchSelect:PlayMatch()
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
    title = " PLAY MATCH ",
    message = " Are You Ready To Play Match Now ? ",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end
function MatchSelect:finalize()
  self.im.Unsubscribe("bnd_difficulty")
  self.im.Unsubscribe(bndHomeTeamName)
  self.im.Unsubscribe(bndAwayTeamName)
  self.im.Unsubscribe(bndStadiumName)
  self.im.Unsubscribe(BND_INFO_MATCH)
  self.im.UnregisterAction(ACT_ADVANCE)
  self.im.UnregisterAction("act_squadhome")
  self.im.UnregisterAction("act_squadaway")
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end
return MatchSelect
-- Thanks : All Modders
-- @mvnprodreal - Remain Be Creative --