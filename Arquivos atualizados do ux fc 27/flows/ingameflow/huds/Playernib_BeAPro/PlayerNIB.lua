-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

local PlayerNIB = {}

local OverlayParam, EventManager, TableUtil = ...
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes

local STATE_INACTIVE = "HIDE"
local STATE_UPDATE = "UPDATE"
local STATE_ACTIVE = "SHOW"

local SIDE_HOME = 0
local SIDE_AWAY = 1

local BND_STAMINA = "bnd_stamina"
local BND_PLAYER_INFO = "bnd_player_info"
local BND_ACTIVE = "bnd_active"

local bndHomeCrest = "bnd_home_team_crest"
local bndAwayCrest = "bnd_away_team_crest"

function PlayerNIB:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
  GameStateService = o.api("GameStateService"),
    matchInfo = o.api("MatchInfoService"),
    userPlate = o.api("UserPlateService"),
    settingsService = o.api("SettingsService"),
    gameSetupService = o.api("GameSetupService"),
    EventManagerService = o.api("EventManagerService")
  }
  
  o.side = o.data and o.data.side or SIDE_HOME
  
  o.im.Subscribe(BND_ACTIVE, function()
    o:_publishActivity()
  end
  )
  o.im.Subscribe(BND_PLAYER_INFO, function()
    o:_publishPlayerInfo()
  end
  )
  o.im.Subscribe(BND_STAMINA, function()
    o:_publishStamina()
  end
  )
  
  o.TeamsData = o.services.matchInfo.GetMatchTeams()
  
  o.isUserHome = o.services.gameSetupService.IsHostTeam()
  
  homeCrest = {
    name = "$Crest",
    id = o.TeamsData[1].assetId
  }
  awaycrest = {
    name = "$Crest",
    id = o.TeamsData[2].assetId
  }
  
  o.im.Subscribe(bndHomeCrest, function()
    o.im.Publish(bndHomeCrest, homeCrest)
  end)
  o.im.Subscribe(bndAwayCrest, function()
    o.im.Publish(bndAwayCrest, awaycrest)
  end)
  
  o:setState(STATE_INACTIVE)
  
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end
  )
  
  return o
end

function PlayerNIB:setState(state)
  self.state = state or STATE_INACTIVE
  self:_publishActivity()
end

function PlayerNIB:getPlayerInfo(params)
  return {
    name = params[9],
    number = params[12]
  }
end

function PlayerNIB:getStamina(params)
  return {
    stamina = tonumber(params[1]),
    shortStamina = tonumber(params[2])
  }
end

function PlayerNIB:_onPlayerNIBUpdate(subtype, hideshow, subtypestr, msg)
  self:setState(hideshow)
  if self.state ~= STATE_INACTIVE and msg ~= nil and msg ~= "" then
    local params = OverlayParam.split(msg, "|")
    if table.getn(params) == 1 then
      if tonumber(params[1]) ~= nil then
        local alpha = tonumber(params[1]) / 100
        self:_publishAlpha(alpha)
      end
    elseif table.getn(params) == 2 then
    elseif table.getn(params) == 3 then
    elseif table.getn(params) == 8 then
      self.stamina = self:getStamina(params)
      self:_publishStamina()
    elseif table.getn(params) == 10 then
      self.stamina = self:getStamina(params)
      self:_publishStamina()
    elseif table.getn(params) == 16 then
      self.playerInfo = self:getPlayerInfo(params)
      self.stamina = self:getStamina(params)
      self:_publishPlayerInfo()
      self:_publishStamina()
    elseif table.getn(params) == 17 then
      self.playerInfo = self:getPlayerInfo(params)
      self.stamina = self:getStamina(params)
      self:_publishPlayerInfo()
      self:_publishStamina()
    end
  end
end

function PlayerNIB:_publishActivity()
  self.im.Publish(BND_ACTIVE, self.state ~= STATE_INACTIVE)
end

function PlayerNIB:_publishPlayerInfo()
  if self.playerInfo == nil then
    return
  end
  self.im.Publish(BND_PLAYER_INFO, self.playerInfo)
end

function PlayerNIB:_publishStamina()
  if self.stamina == nil then
    return
  end
  self.im.Publish(BND_STAMINA, self.stamina)
end

function PlayerNIB:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.OverlayTypeNIBBL and self.side == SIDE_HOME or eventType == EVENT_TYPES.OverlayTypeNIBBR and self.side == SIDE_AWAY then
    self:_onPlayerNIBUpdate(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function PlayerNIB:finalize()

  self.im.Unsubscribe(BND_ACTIVE)
  self.im.Unsubscribe(BND_PLAYER_INFO)
  self.im.Unsubscribe(BND_STAMINA)
  
  self.im.Unsubscribe(bndHomeCrest)
  self.im.Unsubscribe(bndAwayCrest)
  
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
  
end

return PlayerNIB