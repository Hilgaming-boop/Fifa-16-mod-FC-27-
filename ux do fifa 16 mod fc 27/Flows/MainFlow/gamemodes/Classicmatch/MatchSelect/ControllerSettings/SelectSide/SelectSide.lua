
-- New SelectSide by MVNPROD YouTube Channel --

local SelectSide = {}
local eventmanager, PregameManager, CommonNavVars, TableUtil = ...
local EventTypes = eventmanager.FE.FIFA.EventTypes
local ICON_HOME = "$IconHome"
local ICON_AWAY = "$IconAway"
local ICON_COM = "$IconCom"
local ICON_HIDE = "$"
local actToggleHome = "act_toggle_home"
local actToggleAway = "act_toggle_away"
local actToggleCom = "act_toggle_com"
local bndSideHomeIcon = "bnd_side_home_icon"
local bndSideAwayIcon = "bnd_side_away_icon"
local bndSideComIcon1 = "bnd_side_com_icon1"
local bndSideComIcon2 = "bnd_side_com_icon2"
-- [0] Home, [1] Away, [2] Com, [3] Com
function SelectSide:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    matchSetup = o.api("MatchSetupService"),
    gameSetup = o.api("GameSetupService"),
    gameState = o.api("GameStateService"),
    preGame = o.api("PregameService"),
    EventManagerService = o.api("EventManagerService")
  }
  --o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
  --o:handleEvent(...)
  --end)
  o:setUserSideAsHome()
  o.im.Subscribe(bndSideHomeIcon, function()
    o:publishSideHomeIcon()
  end)
  o.im.Subscribe(bndSideAwayIcon, function()
    o:publishSideAwayIcon()
  end)
  o.im.Subscribe(bndSideComIcon1, function()
    o:publishSideComIcon1()
  end)
  o.im.Subscribe(bndSideComIcon2, function()
    o:publishSideComIcon2()
  end)
  o.im.RegisterAction(actToggleHome, function(actionName)
    o:swapSides()
  end)
  o.im.RegisterAction(actToggleAway, function(actionName)
    o:swapSides()
  end)
  o.im.RegisterAction(actToggleCom, function(actionName)
    o:swapSides()
  end)
  return o
end
function SelectSide:publishSideHomeIcon()
  self.im.Publish(bndSideHomeIcon, self.homeSideIcon)
end
function SelectSide:publishSideAwayIcon()
  self.im.Publish(bndSideAwayIcon, self.awaySideIcon)
end
function SelectSide:publishSideComIcon1()
  self.im.Publish(bndSideComIcon1, self.comSideIcon1)
end
function SelectSide:publishSideComIcon2()
  self.im.Publish(bndSideComIcon2, self.comSideIcon2)
end
function SelectSide:swapSides()
      if currentMatch.Side == 0 then
    self:setUserSideAsCom2()
  elseif currentMatch.Side == 1 then
    self:setUserSideAsCom1()
  elseif currentMatch.Side == 2 then
    self:setUserSideAsHome()
  elseif currentMatch.Side == 3 then
    self:setUserSideAsAway()
  else
    self:setUserSideAsHome()
  end
  self:publishSideHomeIcon()
  self:publishSideAwayIcon()
  self:publishSideComIcon1()
  self:publishSideComIcon2()
end
function SelectSide:setUserSideAsHome()
  --self.services.gameState.SetUserSideAsHome()
  self.homeSideIcon = ICON_HOME
  self.awaySideIcon = ICON_HIDE
  self.comSideIcon1 = ICON_HIDE
  self.comSideIcon2 = ICON_HIDE
  currentMatch.Side = 0
end
function SelectSide:setUserSideAsAway()
  --self.services.gameState.SetUserSideAsAway()
  self.homeSideIcon = ICON_HIDE
  self.awaySideIcon = ICON_AWAY
  self.comSideIcon1 = ICON_HIDE
  self.comSideIcon2 = ICON_HIDE
  currentMatch.Side = 1
end
function SelectSide:setUserSideAsCom1()
  self.homeSideIcon = ICON_HIDE
  self.awaySideIcon = ICON_HIDE
  self.comSideIcon1 = ICON_COM
  self.comSideIcon2 = ICON_HIDE
  currentMatch.Side = 2
end
function SelectSide:setUserSideAsCom2()
  self.homeSideIcon = ICON_HIDE
  self.awaySideIcon = ICON_HIDE
  self.comSideIcon1 = ICON_HIDE
  self.comSideIcon2 = ICON_COM
  currentMatch.Side = 3
end
function SelectSide:finalize()
  self.im.UnregisterAction(actToggleHome)
  self.im.UnregisterAction(actToggleAway)
  self.im.Unsubscribe(bndSideHomeIcon)
  self.im.Unsubscribe(bndSideAwayIcon)
  self.im.Unsubscribe(bndSideComIcon1)
  self.im.Unsubscribe(bndSideComIcon2)
  --self.services.EventManagerService.UnregisterHandler(self.handlerId)
end
return SelectSide