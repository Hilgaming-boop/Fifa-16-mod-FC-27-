-- MVN PROD Modified --

local TableUtil, CommonNavVars, CABModel, eventmanager = ...
local EventTypes = eventmanager.FE.FIFA.EventTypes

local USER_MATCH_STATUS = {
  WON = 0,
  LOST = 1,
  DRAW = 2
}
local TEAM_MATCH_STATUS = {
  WON = 0,
  LOST = 1,
  DRAW = 2
}

local BND_PRW1 = "bnd_pr_w1"
local BND_PRW2 = "bnd_pr_w2"
local BND_PRW3 = "bnd_pr_w3"
local BND_PRL1 = "bnd_pr_l1"
local BND_PRL2 = "bnd_pr_l2"
local BND_PRL3 = "bnd_pr_l3"
local BND_PRD1 = "bnd_pr_d1"
local BND_PRD2 = "bnd_pr_d2"
local BND_PRD3 = "bnd_pr_d3"

local BND_HOME_W = "bnd_home_w"
local BND_HOME_L = "bnd_home_l"
local BND_HOME_D = "bnd_home_d"
local BND_AWAY_W = "bnd_away_w"
local BND_AWAY_L = "bnd_away_l"
local BND_AWAY_D = "bnd_away_d"

local BND_MATCH_WON_FOOTER_VISIBLE = "bnd_match_won_footer_visible"
local BND_MATCH_LOST_FOOTER_VISIBLE = "bnd_match_lost_footer_visible"
local BND_MATCH_DRAW_FOOTER_VISIBLE = "bnd_match_draw_footer_visible"

local BND_TEAM_WON_FOOTER_VISIBLE = "bnd_team_won_footer_visible"
local BND_TEAM_LOST_FOOTER_VISIBLE = "bnd_team_lost_footer_visible"
local BND_TEAM_DRAW_FOOTER_VISIBLE = "bnd_team_draw_footer_visible"

local BND_MATCH_DATA_PANEL_VISIBLE = "bnd_match_data_panel_visible"
local BND_DEFAULT_BANNER_VISIBLE = "bnd_default_banner_visible"
local BND_AD_BANNER_DATA = "bnd_ad_banner_data"
local PostmatchMenu = {}
function PostmatchMenu:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.navContext = o.data
  print("[PostmatchMenu]: new(gamemode = " .. tostring(o.navContext.gamemode) .. ", flow = " .. tostring(o.navContext.flow) .. ", type = " .. tostring(o.navContext.type) .. ", gameState = " .. tostring(o.navContext.gameState) .. ")")
  o.services = {
    GameSetupService = o.api("GameSetupService"),
    MatchInfoService = o.api("MatchInfoService"),
    EventManagerService = o.api("EventManagerService")
  }
  o.powService = o.api("PowService")
  o.screenName = "worldpostmatch"
  o.defaultAdVisible = true
  o.models = {
    CABModel = CABModel:new({
      im = o.im,
      api = o.api,
      nav = o.nav,
      loc = o.loc,
      screenName = "worldpostmatch"
    })
  }
  ------------------------------------------------------------------------------------------
  -- PLAYER Stats
  math.randomseed(os.clock() * 1000 + os.time())
  local PRwon1 = (math.random(75, 96)* 0.1)
  local PRwon2 = (math.random(45, 60)* 0.1)
  local PRwon3 = (math.random(30, 46)* 0.1)
  local PRlost1 = (math.random(40, 60)* 0.1)
  local PRlost2 = (math.random(25, 35)* 0.1)
  local PRlost3 = (math.random(10, 20)* 0.1)
  local PRdraw1 = (math.random(51, 74)* 0.1)
  local PRdraw2 = (math.random(30, 40)* 0.1)
  local PRdraw3 = (math.random(10, 25)* 0.1)
  ------------------------------------------------------------------------------------------
  o.im.Subscribe(BND_PRW1, function()
    o.im.Publish(BND_PRW1, PRwon1)
  end)
  o.im.Subscribe(BND_PRW2, function()
    o.im.Publish(BND_PRW2, PRwon2)
  end)
  o.im.Subscribe(BND_PRW3, function()
    o.im.Publish(BND_PRW3, PRwon3)
  end)
  ------------------------------------------------------------------------------------------
  o.im.Subscribe(BND_PRL1, function()
    o.im.Publish(BND_PRL1, PRlost1)
  end)
  o.im.Subscribe(BND_PRL2, function()
    o.im.Publish(BND_PRL2, PRlost2)
  end)
  o.im.Subscribe(BND_PRL3, function()
    o.im.Publish(BND_PRL3, PRlost3)
  end)
  ------------------------------------------------------------------------------------------
  o.im.Subscribe(BND_PRD1, function()
    o.im.Publish(BND_PRD1, PRdraw1)
  end)
  o.im.Subscribe(BND_PRD2, function()
    o.im.Publish(BND_PRD2, PRdraw2)
  end)
  o.im.Subscribe(BND_PRD3, function()
    o.im.Publish(BND_PRD3, PRdraw3)
  end)
  ------------------------------------------------------------------------------------------
  -- TEAM Stats 
  math.randomseed(os.clock() * 1000 + os.time())
  local HMwon = (math.random(75, 96)* 0.1)
  local HMlost = (math.random(60, 70)* 0.1)
  local HMdraw = (math.random(30, 55)* 0.1)
  local AWwon = (math.random(75, 90)* 0.1)
  local AWlost = (math.random(65, 70)* 0.1)
  local AWdraw = (math.random(30, 50)* 0.1)
  ------------------------------------------------------------------------------------------
  o.im.Subscribe(BND_HOME_W, function()
    o.im.Publish(BND_HOME_W, HMwon)
  end)
  o.im.Subscribe(BND_HOME_L, function()
    o.im.Publish(BND_HOME_L, HMlost)
  end)
  o.im.Subscribe(BND_HOME_D, function()
    o.im.Publish(BND_HOME_D, HMdraw)
  end)
  ------------------------------------------------------------------------------------------
  o.im.Subscribe(BND_AWAY_W, function()
    o.im.Publish(BND_AWAY_W, AWwon)
  end)
  o.im.Subscribe(BND_AWAY_L, function()
    o.im.Publish(BND_AWAY_L, AWlost)
  end)
  o.im.Subscribe(BND_AWAY_D, function()
    o.im.Publish(BND_AWAY_D, AWdraw)
  end)
  ------------------------------------------------------------------------------------------
  o.im.Subscribe(BND_MATCH_WON_FOOTER_VISIBLE, function()
    o.im.Publish(BND_MATCH_WON_FOOTER_VISIBLE, o:getUserMatchStatus() == USER_MATCH_STATUS.WON)
  end)
  o.im.Subscribe(BND_MATCH_LOST_FOOTER_VISIBLE, function()
    o.im.Publish(BND_MATCH_LOST_FOOTER_VISIBLE, o:getUserMatchStatus() == USER_MATCH_STATUS.LOST)
  end)
  o.im.Subscribe(BND_MATCH_DRAW_FOOTER_VISIBLE, function()
    o.im.Publish(BND_MATCH_DRAW_FOOTER_VISIBLE, o:getUserMatchStatus() == USER_MATCH_STATUS.DRAW)
  end)
  ------------------------------------------------------------------------------------------
  o.im.Subscribe(BND_TEAM_WON_FOOTER_VISIBLE, function()
    o.im.Publish(BND_TEAM_WON_FOOTER_VISIBLE, o:getUserMatchStatus() == TEAM_MATCH_STATUS.WON)
  end)
  o.im.Subscribe(BND_TEAM_LOST_FOOTER_VISIBLE, function()
    o.im.Publish(BND_TEAM_LOST_FOOTER_VISIBLE, o:getUserMatchStatus() == TEAM_MATCH_STATUS.LOST)
  end)
  o.im.Subscribe(BND_TEAM_DRAW_FOOTER_VISIBLE, function()
    o.im.Publish(BND_TEAM_DRAW_FOOTER_VISIBLE, o:getUserMatchStatus() == TEAM_MATCH_STATUS.DRAW)
  end)
  ------------------------------------------------------------------------------------------
  o.im.Subscribe(BND_MATCH_DATA_PANEL_VISIBLE, function()
    o.im.Publish(BND_MATCH_DATA_PANEL_VISIBLE, o:_isDefaultMatchDataPanelVisible())
  end)
  o.im.Subscribe(BND_DEFAULT_BANNER_VISIBLE, function()
    o.im.Publish(BND_DEFAULT_BANNER_VISIBLE, o:_isDefaultAdBannerVisible())
  end)
  o.im.Subscribe(BND_AD_BANNER_DATA, function()
    o:publishBannerData()
  end)
  ------------------------------------------------------------------------------------------
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)
  o.powService.RequestAdBannersByScreen(o.screenName)
  return o
end
function PostmatchMenu:getUserMatchStatus()
  local userIsHostTeam = self.services.GameSetupService.IsHostTeam()
  local scoreResult = self.services.MatchInfoService.GetMatchScore()
  local TEAM_HOME = 0
  local TEAM_AWAY = 1
  if scoreResult.winner ~= TEAM_HOME and scoreResult.winner ~= TEAM_AWAY then
    return USER_MATCH_STATUS.DRAW
  elseif scoreResult.winner == TEAM_HOME and userIsHostTeam or scoreResult.winner == TEAM_AWAY and not userIsHostTeam then
    return USER_MATCH_STATUS.WON
  else
    return USER_MATCH_STATUS.LOST
  end
  if scoreResult.winner ~= TEAM_HOME and scoreResult.winner ~= TEAM_AWAY then
    return TEAM_MATCH_STATUS.DRAW
  elseif scoreResult.winner == TEAM_HOME and userIsHostTeam or scoreResult.winner == TEAM_AWAY and not userIsHostTeam then
    return TEAM_MATCH_STATUS.WON
  else
    return TEAM_MATCH_STATUS.LOST
  end
end
function PostmatchMenu:getGoals(isAway)
  local matchResults = self.services.MatchInfoService.GetMatchResult()
  local dashIdx = string.find(matchResults, self.loc.LocalizeString("LTXT_COMMON_SCORE_SEPARATOR"))
  local homeGoals = tonumber(string.sub(matchResults, 1, dashIdx - 2))
  local awayGoals = tonumber(string.sub(matchResults, dashIdx + 2))
  if isAway then
    return awayGoals
  else
    return homeGoals
  end
end
function PostmatchMenu:handleEvent(eventType, data)
  if eventType == EventTypes.AdBannersDataAvailable then
    if data.screenName == self.screenName then
      local rawData = self.powService.GetAdBannersByScreen(self.screenName)
      local nData = table.getn(rawData)
      if 0 < nData then
        self.advertTileData = rawData
        self:publishBannerData()
      end
    end
  elseif eventType == EventTypes.AdBannersDataNotAvailable then
    if data.screenName == self.screenName then
      self.advertTileData = self.models.CABModel:getFakeData()
      self:publishBannerData()
    end
  elseif eventType == EventTypes.OnBackPressed then
    print("PostmatchMenu:handleEvent OnBackPressed")
    self.nav.Event(nil, "evt_quit")
  end
end
function PostmatchMenu:publishBannerData()
  if self.advertTileData ~= nil then
    self.im.Publish(BND_AD_BANNER_DATA, self.advertTileData[1])
    self.im.Publish(BND_DEFAULT_BANNER_VISIBLE, self:_isDefaultAdBannerVisible())
  end
end
function PostmatchMenu:_isDefaultMatchDataPanelVisible()
  if self.navContext.type == CommonNavVars.TYPES.SEASONS or self.navContext.type == CommonNavVars.TYPES.TOURNAMENTS then
    return false
  else
    return true
  end
end
function PostmatchMenu:_isDefaultAdBannerVisible()
  if self.advertTileData == nil then
    self.defaultAdVisible = true
    return true
  end
  local nData = table.getn(self.advertTileData)
  if 0 < nData then
    self.defaultAdVisible = false
  end
  return self.defaultAdVisible
end
function PostmatchMenu:finalize()
  print("[PostmatchMenu]: finalize()")
  self.models.CABModel:finalize()
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
  self.im.Unsubscribe(BND_MATCH_DATA_PANEL_VISIBLE)
  self.im.Unsubscribe(BND_MATCH_WON_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_MATCH_LOST_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_MATCH_DRAW_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_WON_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_LOST_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_DRAW_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_DEFAULT_BANNER_VISIBLE)
  self.im.Unsubscribe(BND_AD_BANNER_DATA)
  self.im.Unsubscribe(BND_PRW1)
  self.im.Unsubscribe(BND_PRW2)
  self.im.Unsubscribe(BND_PRW3)
  self.im.Unsubscribe(BND_PRL1)
  self.im.Unsubscribe(BND_PRL2)
  self.im.Unsubscribe(BND_PRL3)
  self.im.Unsubscribe(BND_PRD1)
  self.im.Unsubscribe(BND_PRD2)
  self.im.Unsubscribe(BND_PRD3)
  self.im.Unsubscribe(BND_HOME_W)
  self.im.Unsubscribe(BND_HOME_L)
  self.im.Unsubscribe(BND_HOME_D)
  self.im.Unsubscribe(BND_AWAY_W)
  self.im.Unsubscribe(BND_AWAY_L)
  self.im.Unsubscribe(BND_AWAY_D)
end
return PostmatchMenu
