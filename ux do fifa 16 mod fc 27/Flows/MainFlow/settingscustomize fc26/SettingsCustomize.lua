
local TabModel, EventManager, settings_service = ...
local SettingsCustomize = {}
local BND_IS_IN_GAME = "bnd_is_in_game"
local BND_DEBUG_SETTINGS_TAB_VISIBILITY = "bnd_debug_settings_tab_visibility"
local BND_GAMEPLAY_SETTINGS_TAB_VISIBILITY = "bnd_gameplay_settings_tab_visibility"
local ACT_ACCEPT = "act_accept"
local ACT_CANCEL = "act_cancel"
local AUTO_SWITCH_OPTION_INDEX = 1
local AUTO_SWITCH_MOVE_ASSIST_OPTION_INDEX = 2
local MOVE_ASSISTANCE_OPTION_INDEX = 3
local CONTROL_SCHEME_OPTION_INDEX = 1
local FLOATING_DPAD_OPTION_INDEX = 2
local VBUTTON_POSITION_OPTION_INDEX = 3
local SKILL_MOVES_OPTION_INDEX = 4
local LARGE_BUTTONS_OPTION_INDEX = 5
local LARGE_DPAD_OPTION_INDEX = 6
local LEFT_HANDED_OPTION_INDEX = 7
local CONTROLLERID_GAMEPAD = 0
local VOLUME_ID = settings_service.FE.UXService.BaseService.VOLUME_ID
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local LeagueIDs = {
  {ids={13,1925,14,110,18,19,5,2,10,144,1,11,1799,1943,1808,7,9,8,1796,106,126990},compID=13}, -- Premier League
  {ids={1860,449,457,243,461,240,241,453,448,450,483,110062,481,479,463,480,452,110827,1853,468},compID=53}, -- La Liga
  {ids={52,46,347,55,1842,110556,206,110374,39,48,44,54,45,189,50,1745,47,110738,111974,111434},compID=31}, -- Serie A
  {ids={175,38,112172,23,36,32,1831,21,100409,1824,25,111235,22,110329,10029,169,31,28},compID=19}, -- Bundesliga
  {ids={65,69,76,219,73,66,64,74,1738,72,71,1530,57,378,379,1809,217,111817},compID=16}, -- Ligue 1
  {ids={111114,1415,111391,111502,1413,111466,111510,111115,111512,1411,974,111392,111518,111523,111527,111528,111533,111536,111485,111488},compID=10}, -- AFC U23
  {ids={155600, 155607, 155609, 155606, 155611, 155614, 155621, 155604, 155602, 155630, 155603, 155612, 155616, 155617, 155620, 155624, 155601, 155615, 155610, 155618},compID=11}, -- BRI liga 1
  {ids={681,1750,670,100081,229,100087,110724,230,673,680,231,674,232,2014,537,675},compID=12}, -- Pro League  
  {ids={15,97,1800,1919,109,1960,1952,1807,1794,1806,12,3,1795,1792,19521,1790,91,1801,88,1951,1947,17,94,95,89},compID=14}, -- EFL Championship 
  {ids={634,1913,245,1903,247,1910,100632,1908,246,100646,1906,1915,1914,100634,1904,645,1971},compID=15}, -- Eredivisie
  {ids={111140,114161,697,114640,111928,639,688,112828,694,691,113149,112893,114162,112885,687,112134,101112,112996,112606,111651,698,111065,696,689,111139,111138,695,111144,113018,115243},compID=17}, -- Mls
  {ids={112392,112390,112408,111674,112096,112139,113057,112883,112393,113060,113217,607,113037,605,112387,112391,121735,112675,139485,113222},compID=18} -- Spl   
}

local LeagueMap = {}
for _,v in ipairs(LeagueIDs)do
  for _,id in ipairs(v.ids)do
    LeagueMap[id] = v.compID
  end
end
LeagueMap[-1] = 0

-- ðŸ”¹ FUNGSI UMUM UNTUK AMBIL ID LIGA
local function getLeague(teamID, name)
  return { name = name, id = LeagueMap[teamID] or 0 }
end

function getLeagueBackgroundByTeam(teamID)
  return getLeague(teamID, "$LeagueBG")
end
function getLeagueTableByTeam(teamID)
  return getLeague(teamID, "$TableCareer")
end
function SettingsCustomize:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.isInGame = type(o.data) == "table" and o.data.ingame or false
  print("[SettingsCustomize]: new(isInGame = " .. tostring(o.isInGame) .. ")")
  o.models = {
    TabModel = TabModel:new({
      im = o.im,
      api = o.api,
      nav = o.nav,
      loc = o.loc,
      binding = "bnd_settings_customize_tab_index",
      action = "setSettingsCustomizeTabContext"
    })
  }
  o.services = {
    SaveLoadService = o.api("SaveLoadService"),
    CustomizationService = o.api("FifaCustomizationService"),
    SettingsService = o.api("SettingsService"),
    gameStateService = o.api("GameStateService"),
    AudioService = o.api("AudioService"),
    EventManagerService = o.api("EventManagerService")
  }
  o:makeSettingsDataSnapshot()
  o.im.Subscribe(BND_IS_IN_GAME, function()
    o.im.Publish(BND_IS_IN_GAME, o.isInGame)
  end
  )
  o.nav.AddActionHandler("saveSettings", false, nil, function()
    o:_triggerSaveSettings()
  end
  )
o.im.Subscribe("bnd_leaguebackground", function()
  local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_leaguebackground", bg)
end)  
o.im.Subscribe("bnd_table_career", function()
  local tb = getLeagueTableByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_table_career", tb)
end)
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end
  )
  o.im.RegisterAction(ACT_ACCEPT, function()
    o:saveAndQuit()
  end
  )
  o.im.RegisterAction(ACT_CANCEL, function()
    o:quitAndRevert()
  end
  )
  o.debugTabVisibility = o.services.SettingsService.IsDebugSettingsTabVisible()
  o.im.Subscribe(BND_DEBUG_SETTINGS_TAB_VISIBILITY, function()
    o.im.Publish(BND_DEBUG_SETTINGS_TAB_VISIBILITY, o.debugTabVisibility)
  end
  )
  
  o.gameplayTabVisibility = o.services.SettingsService.IsGameplaySettingsTabVisible()
  o.im.Subscribe(BND_GAMEPLAY_SETTINGS_TAB_VISIBILITY, function()
    o.im.Publish(BND_GAMEPLAY_SETTINGS_TAB_VISIBILITY, o.gameplayTabVisibility)
  end
  )
  return o
end

function SettingsCustomize:saveAndQuit()
  print("[SettingsCustomize]: saveAndQuit()")
  self.nav.Event(nil, "evt_save_settings")
end

function SettingsCustomize:_triggerSaveSettings()
  local touchControllerId = 4
  local customSaveSlot = 5
  local customPendingSaveSlot = 100
  if self.services.CustomizationService.HasPendingKeyboardMouseButtonChanges() then
    self.services.CustomizationService.SetCustomControllerSlot(touchControllerId, customSaveSlot)
    self.services.CustomizationService.SetKeyboardConfiguration(touchControllerId, customPendingSaveSlot)
  end
  self.services.SaveLoadService.CreateAndSendMessage(8)
end

function SettingsCustomize:makeSettingsDataSnapshot()
  local controllerId = self.services.gameStateService.GetPreferedControllerId()
  self.customizationOptions = self.services.SettingsService.GetCustomizationOptions(controllerId)
  self.touchOptions = self.services.CustomizationService.GetTouchOptions(controllerId)
  self.gamepadConfig = self.services.CustomizationService.GetControllerConfiguration()
  self.musicVolume = self.services.SettingsService.GetAudioOptionValue(VOLUME_ID.MUSIC_VOLUME_ID)
  self.gamefxVolume = self.services.SettingsService.GetAudioOptionValue(VOLUME_ID.GAMEFX_VOLUME_ID)
  self.commentaryVolume = self.services.SettingsService.GetAudioOptionValue(VOLUME_ID.COMMENTARY_VOLUME_ID)
  self.crowdVolume = self.services.SettingsService.GetAudioOptionValue(VOLUME_ID.CROWD_VOLUME_ID)
  self.currentMusicSource = self.services.AudioService.GetCurrentAudioSource()
  self.pushNotificationsEnabled = self.services.SettingsService.GetPushNotesOn().pushOn
end

function SettingsCustomize:quitAndRevert()
  print("[SettingsCustomize]: quitAndRevert()")
  local controllerId = self.services.gameStateService.GetPreferedControllerId()
  self.services.SettingsService.SaveAutoSwitchValue(controllerId, self.customizationOptions[AUTO_SWITCH_OPTION_INDEX].data.currentValue)
  self.services.SettingsService.SaveAutoSwichMoveAssistanceValue(controllerId, self.customizationOptions[AUTO_SWITCH_MOVE_ASSIST_OPTION_INDEX].data.currentValue)
  self.services.SettingsService.SaveMoveAssistanceValue(controllerId, self.customizationOptions[MOVE_ASSISTANCE_OPTION_INDEX].data.currentValue)
  self.services.CustomizationService.SaveLargeButtonsValue(controllerId, self.touchOptions[LARGE_BUTTONS_OPTION_INDEX].data.currentValue)
  self.services.CustomizationService.SaveLargeDpadValue(controllerId, self.touchOptions[LARGE_DPAD_OPTION_INDEX].data.currentValue)
  self.services.CustomizationService.SaveLeftHandedValue(controllerId, self.touchOptions[LEFT_HANDED_OPTION_INDEX].data.currentValue)
  self.services.CustomizationService.SaveControlSchemeValue(controllerId, self.touchOptions[CONTROL_SCHEME_OPTION_INDEX].data.currentValue)
  self.services.CustomizationService.SaveFloatingDpadValue(controllerId, self.touchOptions[FLOATING_DPAD_OPTION_INDEX].data.currentValue)
  self.services.CustomizationService.SaveVButtonPositionValue(controllerId, self.touchOptions[VBUTTON_POSITION_OPTION_INDEX].data.currentValue)
  self.services.CustomizationService.SaveSkillMovesValue(controllerId, self.touchOptions[SKILL_MOVES_OPTION_INDEX].data.currentValue)
  self.services.CustomizationService.SetKeyboardConfiguration(CONTROLLERID_GAMEPAD, self.gamepadConfig)
  self.services.SettingsService.SaveAudioOptionValue(VOLUME_ID.MUSIC_VOLUME_ID, self.musicVolume)
  self.services.SettingsService.SaveAudioOptionValue(VOLUME_ID.GAMEFX_VOLUME_ID, self.gamefxVolume)
  self.services.SettingsService.SaveAudioOptionValue(VOLUME_ID.PLAYER_CALLS_ID, self.gamefxVolume)
  self.services.SettingsService.SaveAudioOptionValue(VOLUME_ID.COMMENTARY_VOLUME_ID, self.commentaryVolume)
  self.services.SettingsService.SaveAudioOptionValue(VOLUME_ID.CROWD_VOLUME_ID, self.crowdVolume)
  self.services.AudioService.OnToggleUserMusic(self.currentMusicSource)
  self.services.SettingsService.SetPushNotesOn(self.pushNotificationsEnabled)
  self.nav.Event(nil, "evt_exit_settings_customize")
end

function SettingsCustomize:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.OnUserProfileLoaded then
    self.services.SaveLoadService.CreateAndSendMessage(2)
    self.nav.Event(nil, "evt_exit_settings_customize")
  end
end

function SettingsCustomize:finalize()
  print("[SettingsCustomize]: finalize()")
  self.models.TabModel:finalize()
  self.nav.RemoveActionHandler("saveSettings")
  self.im.Unsubscribe(BND_IS_IN_GAME)
  self.im.Unsubscribe(BND_DEBUG_SETTINGS_TAB_VISIBILITY)
  self.im.Unsubscribe(BND_GAMEPLAY_SETTINGS_TAB_VISIBILITY)
  self.im.UnregisterAction(ACT_ACCEPT)
  self.im.UnregisterAction(ACT_CANCEL)
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return SettingsCustomize