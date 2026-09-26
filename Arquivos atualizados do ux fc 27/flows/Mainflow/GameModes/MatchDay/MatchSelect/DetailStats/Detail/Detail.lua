-- New Custom Menu By MVNPROD --
local Detail = {}
local eventmanager, PregameManager, CommonNavVars, TableUtil = ...
local EventTypes = eventmanager.FE.FIFA.EventTypes
local BND_LOGO_TIM_HOME = "bnd_logo_tim_home"
local BND_LOGO_TIM_AWAY = "bnd_logo_tim_away"
local BND_MAN_TIM_HOME = "bnd_man_tim_home"
local BND_MAN_TIM_AWAY = "bnd_man_tim_away"
local BND_NAMA_TIM_HOME = "bnd_nama_tim_home"
local BND_NAMA_TIM_AWAY = "bnd_nama_tim_away"
local BND_INFO_MATCH = "bnd_info_match"
local ACT_ADVANCE = "act_advance"
function Detail:new(init)
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
  LOGO_HOME = {
    name = "$Crest",
    id = o.homeTeamID
  }
  LOGO_AWAY = {
    name = "$Crest",
    id = o.awayTeamID
  }
  MAN_HOME = {
    name = "$MyCoach",
    id = o.homeTeamID
  }
  MAN_AWAY = {
    name = "$MyCoach",
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
  o.im.Subscribe(BND_NAMA_TIM_HOME, function()
    o:publishTeamNameHome()
  end)
  o.im.Subscribe(BND_NAMA_TIM_AWAY, function()
    o:publishTeamNameAway()
  end)
  o.im.Subscribe("bnd_difficulty", function()
    o.im.Publish("bnd_difficulty", o.CurrentOptions.difficulty)
  end)
  o.im.Subscribe(BND_INFO_MATCH, function()
    local state = "Stadium : "..o.CurrentOptions.stadium.."          ".."Length : - Half Length".."          ".."Difficulty : "..o.CurrentOptions.difficulty.."          ".."Match : Friendly"
    o.im.Publish(BND_INFO_MATCH, state)
  end)
  o.im.RegisterAction(ACT_ADVANCE, function(actionName)
    o:PlayMatch()
  end)
  return o
end
function Detail:publishTeamNameHome()
  local HomeTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..currentMatch.HomeTeamID)
  self.im.Publish(BND_NAMA_TIM_HOME, HomeTeamName)
end
function Detail:publishTeamNameAway()
  local AwayTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..currentMatch.AwayTeamID)
  self.im.Publish(BND_NAMA_TIM_AWAY, AwayTeamName)
end
-- Popup Play Match --
function Detail:PlayMatch()
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
function Detail:finalize()
  self.im.Unsubscribe("bnd_difficulty")
  self.im.Unsubscribe(BND_INFO_MATCH)
  self.im.UnregisterAction(ACT_ADVANCE)
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end
return Detail
-- Thanks : All Modders
-- @mvnprodreal - Remain Be Creative --