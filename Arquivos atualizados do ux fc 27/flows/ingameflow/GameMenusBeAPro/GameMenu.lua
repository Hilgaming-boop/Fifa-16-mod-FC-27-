-- MVN PROD Modified --

local TableUtil, CommonNavVars, GameStateServiceEnums, OverlayParam, EventManager = ...
local GameMenu = {}
local BND_HOME_PAUSES = "bnd_home_team_pauses"
local BND_AWAY_PAUSES = "bnd_away_team_pauses"
local BND_HOME_USER_DATA = "bnd_home_user_data"
local BND_AWAY_USER_DATA = "bnd_away_user_data"
local BND_HOME_TEAM_CREST = "bnd_home_team_crest"
local BND_AWAY_TEAM_CREST = "bnd_away_team_crest"
local BND_PLAYER = "bnd_player"
local BND_MAN = "bnd_man"
local BND_HOME_TEAM_NAME_ABBR = "bnd_home_team_name_abbr"
local BND_AWAY_TEAM_NAME_ABBR = "bnd_away_team_name_abbr"
local BND_HOME_TEAM_NAME = "bnd_home_team_name"
local BND_AWAY_TEAM_NAME = "bnd_away_team_name"
local BND_RESULT = "bnd_result"
local BND_SHOOTOUT_RESULT = "bnd_shootout_result"
local BND_MATCH_TYPE = "bnd_match_type"
local BND_GAME_STATE = "bnd_game_state"
local BND_STADIUM_NAME = "bnd_stadium_name"
local BND_TIME = "bnd_time"
local BND_MATCH_FACTS = "bnd_match_facts"
local BND_LIVE_TILE_RESUME = "bnd_live_tile_resume"
local BND_LIVE_TILE_SQUAD = "bnd_live_tile_squad"
local bndLiveTileList = "bnd_live_tile_list"
local bndLiveTileList2 = "bnd_live_tile_list2"
local BND_LIVE_TILE_REPLAY = "bnd_live_tile_replay"
local BND_LIVE_TILE_RESTART = "bnd_live_tile_restart"
local BND_LIVE_TILE_SETTINGS = "bnd_live_tile_settings"
local BND_LIVE_TILE_FORFEIT = "bnd_live_tile_forfeit"
local BND_LIVE_TILE_MATCHFACTS = "bnd_live_tile_matchfacts"
local BND_LIVE_TILE_CAPTURED_MEDIA = "bnd_live_tile_captured_media"
local BND_LIVE_TILE_CAPTURED_MEDIA_ENABLED = "bnd_live_tile_captured_media_enabled"
local BND_LIVE_TILE_QUIT = "bnd_live_tile_quit"
local BND_SHOW_ONLINE_INFO = "bnd_show_online_info"
local BND_SHOW_OFFLINE_INFO = "bnd_show_offline_info"
local BND_LIVE_TILE_MATCHHIGHLIGHTS = "bnd_live_tile_matchhighlights"
local BND_LIVE_TILE_MATCHGRADE = "bnd_live_tile_matchgrade"
local BND_LIVE_TILE_REPLAY_ENABLED = "bnd_live_tile_replay_enable"
local ACT_TOGGLE_PAUSE = "act_toggle_pause"
local ACT_FORFEIT_MATCH = "act_forfeit_match"
local ACT_QUIT_MATCH = "act_quit_match"
local ACT_RESTART_MATCH = "act_restart_match"
local ACT_TO_INGAME_SQUAD = "act_to_ingame_squad"
local ACT_TO_INGAME_SQUADAWAY = "act_to_ingame_squadaway"
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local BACK_KEY_PRESSED = GameStateServiceEnums.FE.UXService.GameStateServiceListener.BACK_KEY_PRESSED



function GameMenu:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.navContext = o.data
  o.flow = o.navContext.flow
  print("[GameMenu]: new(gamemode = " .. tostring(o.navContext.gamemode) .. ", flow = " .. tostring(o.navContext.flow) .. ", type = " .. tostring(o.navContext.type) .. ", gameState = " .. tostring(o.navContext.gameState) .. ")")
  o.services = {
    GameStateService = o.api("GameStateService"),
    liveTilesService = o.api("FUTLiveTilesService"),
    MatchInfoService = o.api("MatchInfoService"),
    OverlayService = o.api("OverlayService"),
    GameSetupService = o.api("GameSetupService"),
    SocialService = o.api("SocialService"),
    PauseMenuService = o.api("PauseMenuService"),
    SeasonProgressService = o.api("SeasonProgressService"),
    SettingsService = o.api("SettingsService"),
    UserPlateService = o.api("UserPlateService"),
    MediaCaptureService = o.api("MediaCaptureService"),
    ReplayService = o.api("ReplayService"),
    ScreenInfoService = o.api("ScreenInfoService"),
    DNFService = o.api("DNFService"),
    EventManagerService = o.api("EventManagerService"),
    TeamService = o.api("TeamService"),
    SquadManagementService = o.api("SquadMgtService")
  }
  o.labelResumeOff = "Resume Match"
  o.labelResumeOn = "Resume Match"
  o.labelFactsOff = "Match Facts"
  o.labelFactsOn = "Match Facts"
  o.labelAccessibilityOff = "Accessibility"
  o.labelAccessibilityOn = "Accessibility"
  o.labelReplayOff = "Highlighter"
  o.labelReplayOn = "Highlighter"
  o.labelSettingsOff = "Settings"
  o.labelSettingsOn = "Settings"
  o.labelRestartOff = "Restart Match"
  o.labelRestartOn  = "Restart Match"
  o.labelEndOff     = "End Match"
  o.labelEndOn      = "End Match"
  o.labelAdvanceOff   = "Advance"
  o.labelAdvanceOn    = "Advance"
  o.labelHighlightOff = "Highlighter"
  o.labelHighlightOn  = "Highlighter"
  o.im.RegisterAction(ACT_TOGGLE_PAUSE, function(actionName)
    o:resumeMatch()
  end
  )
  o.im.RegisterAction(ACT_FORFEIT_MATCH, function(actionName)
    o:forfeitMatch()
  end)
  o.im.RegisterAction(ACT_QUIT_MATCH, function(actionName)
    o:quitMatch()
  end)
  o.im.RegisterAction(ACT_RESTART_MATCH, function(actionName)
    o:restartMatch()
  end
  )
  o.im.RegisterAction(ACT_TO_INGAME_SQUAD, function(actionName)
    o.nav.Event(nil, "evt_to_ingame_squad")
  end
  )
  o.im.RegisterAction(ACT_TO_INGAME_SQUADAWAY, function(actionName)
    o.nav.Event(nil, "evt_to_ingame_squadaway")
  end
  )
o.im.RegisterAction("act_menu_resume", function()
    o:OnTabResumeClicked()
  end)
  o.im.RegisterAction("act_menu_accessibility", function()
    o:OnTabAccessibilityClicked()
  end)
   o.im.RegisterAction("act_menu_facts", function()
    o:OnTabFactsClicked()
  end)
   o.im.RegisterAction("act_menu_replay", function()
    o:OnTabReplayClicked()
  end)
   o.im.RegisterAction("act_menu_settings", function()
    o:OnTabSettingsClicked()
  end)
  o.im.RegisterAction("act_menu_restart", function()
    o:OnTabRestartClicked()
  end)
  o.im.RegisterAction("act_menu_end", function()
    o:OnTabEndClicked()
  end)
  o.im.RegisterAction("act_menu_advance", function()
    o:OnTabAdvanceClicked()
  end)
  o.im.RegisterAction("act_menu_highlight", function()
    o:OnTabHighlightClicked()
  end)
  o.im.RegisterAction("act_next_update", function()
    o:NextUpdate()
  end)
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:handleEvent(...)
  end
  )
  o.im.Subscribe(BND_HOME_PAUSES, function()
    o.im.Publish(BND_HOME_PAUSES, o:getPausesRemaining())
  end
  )
  o.im.Subscribe(BND_AWAY_PAUSES, function()
    o.im.Publish(BND_AWAY_PAUSES, o:getPausesRemaining(true))
  end
  )
  o.im.Subscribe(BND_HOME_USER_DATA, function()
    o.im.Publish(BND_HOME_USER_DATA, {
      userImage = o:getAvatarPath(),
      team = o:getTeam().assetId
    })
  end
  )
  o.im.Subscribe(BND_AWAY_USER_DATA, function()
    o.im.Publish(BND_AWAY_USER_DATA, {
      userImage = o:getAvatarPath(true),
      team = o:getTeam(true).assetId
    })
  end
  )
  o.im.Subscribe(BND_HOME_TEAM_CREST, function()
    o.im.Publish(BND_HOME_TEAM_CREST, o:getTeamCrest())
  end
  )
  o.im.Subscribe(BND_AWAY_TEAM_CREST, function()
    o.im.Publish(BND_AWAY_TEAM_CREST, o:getTeamCrest(true))
  end
  )
  o.im.Subscribe(BND_PLAYER, function()
    o.im.Publish(BND_PLAYER, o:getPlayer())
  end
  )
    o.im.Subscribe(BND_MAN, function()
    o.im.Publish(BND_MAN, o:getMan())
  end
  )
  o.im.Subscribe(BND_HOME_TEAM_NAME_ABBR, function()
    o.im.Publish(BND_HOME_TEAM_NAME_ABBR, o:getTeam().teamNameAbbr)
  end
  )
  o.im.Subscribe(BND_AWAY_TEAM_NAME_ABBR, function()
    o.im.Publish(BND_AWAY_TEAM_NAME_ABBR, o:getTeam(true).teamNameAbbr)
  end
  )
  o.im.Subscribe(BND_HOME_TEAM_NAME, function()
    o.im.Publish(BND_HOME_TEAM_NAME, o:getTeam().teamName)

  end
  )
  o.im.Subscribe(BND_AWAY_TEAM_NAME, function()
    o.im.Publish(BND_AWAY_TEAM_NAME, o:getTeam(true).teamName)
    
  end
  )
  o.im.Subscribe(BND_RESULT, function()
    o.im.Publish(BND_RESULT, o.services.MatchInfoService.GetMatchResult())
  end
  )
  o.im.Subscribe(BND_SHOOTOUT_RESULT, function()
    o.im.Publish(BND_SHOOTOUT_RESULT, o:getShootoutResult())
  end
  )
  o.im.Subscribe(BND_MATCH_TYPE, function()
    o.im.Publish(BND_MATCH_TYPE, o:getMatchType("Friendly match"))
  end
  )
  o.im.Subscribe(BND_GAME_STATE, function()
    local currentTime = os.date("%H:%M")
    local state = o:getGameState().." | "..currentTime.." | "..o.services.SettingsService.GetCurrentOptions().stadium.." | "..o:getMatchType()
    o.im.Publish(BND_GAME_STATE, state)
  end
  )
  o.im.Subscribe(BND_STADIUM_NAME, function()
    o.im.Publish(BND_STADIUM_NAME, o.services.SettingsService.GetCurrentOptions().stadium)
  end
  )
  o.im.Subscribe(BND_TIME, function()
    o.im.Publish(BND_TIME, o.services.OverlayService.GetGameClockString())
  end
  )
  o.im.Subscribe(BND_MATCH_FACTS, function()
    o.im.Publish(BND_MATCH_FACTS, o:getMatchFacts())
  end)
  o.im.Subscribe(BND_LIVE_TILE_RESUME, function()
    o.im.Publish(BND_LIVE_TILE_RESUME, OverlayParam.split(("RESUME"), " "))
  end
  )
  o.im.Subscribe(BND_LIVE_TILE_SQUAD, function()
    o.im.Publish(BND_LIVE_TILE_SQUAD, {
      ("SQUAD")
    })
  end
  )
 o.im.Subscribe(BND_LIVE_TILE_MATCHFACTS, function()
    o.im.Publish(BND_LIVE_TILE_MATCHFACTS, {
      ("STATS & EVENTS")
    })
  end
  )
  o.im.Subscribe(BND_LIVE_TILE_MATCHGRADE, function()
    o:BND_LIVE_TILE_MATCHGRADE()
  end
  )
  o.im.Subscribe(BND_LIVE_TILE_MATCHHIGHLIGHTS, function()
    o.im.Publish(BND_LIVE_TILE_MATCHHIGHLIGHTS, {
      ("HIGHLIGHTS")
    })
  end
  )
  o.im.Subscribe(BND_LIVE_TILE_QUIT, function()
    o.im.Publish(BND_LIVE_TILE_QUIT, {
      ("QUIT MATCH")
    })
  end
  )
  o.liveTileLists = {}
  table.insert(o.liveTileLists, {
    headline = {
      "SQUAD"
    },
    subHeadline = "HOME",
    images = {
      o:getTeamCrest()
    },
    autoScaleImageToTileHeight= true,
    clickAction = ACT_TO_INGAME_SQUAD
  })
  table.insert(o.liveTileLists, {
    headline = {
      "SQUAD"
    },
    subHeadline = "AWAY",
    images = {
      o:getTeamCrest(true)
    },
    autoScaleImageToTileHeight= true,
    clickAction = ACT_TO_INGAME_SQUADAWAY
  })
  o.im.Subscribe(bndLiveTileList, function()
    o:_publishLiveTiles()
  end
  )
  o.liveTileLists2 = {}
  table.insert(o.liveTileLists2, {
    headline = {
      "SETTINGS"
    },
    images = {
      "$_IconSettings"
    },
    autoScaleImageToTileHeight= true,
    clickAction = "act_to_settings"
  })

  if currentMode == 0 then
    table.insert(o.liveTileLists2, {
        headline = {
          "SIDE SELECT"
        },
        images = {
          "$_IconSelectSide"
        },
        autoScaleImageToTileHeight= true,
        clickAction = "act_selectside"
    })
  end
  
  
  o.im.Subscribe(bndLiveTileList2, function()
    o:_publishLiveTiles2()
  end)
  o.im.Subscribe(BND_LIVE_TILE_REPLAY, function()
    o.im.Publish(BND_LIVE_TILE_REPLAY, {
      ("REPLAY")
    })
  end
  )
  o.im.Subscribe(BND_LIVE_TILE_SETTINGS, function()
    o.im.Publish(BND_LIVE_TILE_SETTINGS, {
      ("SETTINGS")
    })
  end
  )
  
  o.im.Subscribe(BND_LIVE_TILE_CAPTURED_MEDIA_ENABLED, function()
    o.im.Publish(BND_LIVE_TILE_CAPTURED_MEDIA_ENABLED, o.services.MediaCaptureService.HasCapturedMedia())
  end
  )
  o.im.Subscribe(BND_LIVE_TILE_FORFEIT, function()
    o.im.Publish(BND_LIVE_TILE_FORFEIT, {
      ("END MATCH")
    })
  end
  )
    o.im.Subscribe(BND_LIVE_TILE_RESTART, function()
    o.im.Publish(BND_LIVE_TILE_RESTART, OverlayParam.split(("RESTART"), " "))
  end
  )
  o.im.Subscribe(BND_SHOW_ONLINE_INFO, function()
    o.im.Publish(BND_SHOW_ONLINE_INFO, o.navContext.flow == CommonNavVars.FLOWS.ONLINE)
  end
  )
  o.im.Subscribe(BND_SHOW_OFFLINE_INFO, function()
    o.im.Publish(BND_SHOW_OFFLINE_INFO, o.navContext.flow == CommonNavVars.FLOWS.OFFLINE)
  end
  )

  o.im.Subscribe(BND_LIVE_TILE_REPLAY_ENABLED, function()
    o.im.Publish(BND_LIVE_TILE_REPLAY_ENABLED, not o.services.PauseMenuService.IsOnlineGame())
  end
  )
o.im.Subscribe("bnd_label_resume_off", function()
    o.im.Publish("bnd_label_resume_off", o.labelResumeOff)
  end)
  o.im.Subscribe("bnd_label_resume_on", function()
    o.im.Publish("bnd_label_resume_on", "")
  end)
  o.im.Subscribe("bnd_label_accessibility_off", function()
    o.im.Publish("bnd_label_accessibility_off", o.labelAccessibilityOff)
  end)
  o.im.Subscribe("bnd_label_accessibility_on", function()
    o.im.Publish("bnd_label_accessibility_on", "")
  end)
   o.im.Subscribe("bnd_label_facts_off", function()
    o.im.Publish("bnd_label_facts_off", o.labelFactsOff)
  end)
  o.im.Subscribe("bnd_label_facts_on", function()
    o.im.Publish("bnd_label_facts_on", "")
  end)
   o.im.Subscribe("bnd_label_replay_off", function()
    o.im.Publish("bnd_label_replay_off", o.labelReplayOff)
  end)
  o.im.Subscribe("bnd_label_replay_on", function()
    o.im.Publish("bnd_label_replay_on", "")
  end)
   o.im.Subscribe("bnd_label_settings_off", function()
    o.im.Publish("bnd_label_settings_off", o.labelSettingsOff)
  end)
  o.im.Subscribe("bnd_label_settings_on", function()
    o.im.Publish("bnd_label_settings_on", "")
  end)
  o.im.Subscribe("bnd_label_restart_off", function()
    o.im.Publish("bnd_label_restart_off", o.labelRestartOff)
  end)
  o.im.Subscribe("bnd_label_restart_on", function()
    o.im.Publish("bnd_label_restart_on", "")
  end)
  o.im.Subscribe("bnd_label_end_off", function()
    o.im.Publish("bnd_label_end_off", o.labelEndOff)
  end)
  o.im.Subscribe("bnd_label_end_on", function()
    o.im.Publish("bnd_label_end_on", "")
  end)
  o.im.Subscribe("bnd_label_advance_off", function()
    o.im.Publish("bnd_label_advance_off", o.labelAdvanceOff)
  end)
  o.im.Subscribe("bnd_label_advance_on", function()
    o.im.Publish("bnd_label_advance_on", "")
  end)
  o.im.Subscribe("bnd_label_highlight_off", function()
    o.im.Publish("bnd_label_highlight_off", o.labelHighlightOff)
  end)
  o.im.Subscribe("bnd_label_highlight_on", function()
    o.im.Publish("bnd_label_highlight_on", "")
  end)
  if o.flow == CommonNavVars.FLOWS.OFFLINE then
    o.services.ScreenInfoService.SetScreenName("PauseMenuOffline")
  end
  function o.resumeGameListener(...)
    o:resumeMatch()
  end
  
  o.services.GameStateService.RegisterListener(BACK_KEY_PRESSED, o.resumeGameListener)
  o.isGamePaused = true
o.im.Publish("bnd_label_resume_off", o.labelResumeOff)
  o.im.Publish("bnd_label_resume_on", "")
  o.im.Publish("bnd_label_accessibility_off", o.labelAccessibilityOff)
  o.im.Publish("bnd_label_accessibility_on", "")
  o.im.Publish("bnd_label_facts_off", o.labelFactsOff)
  o.im.Publish("bnd_label_facts_on", "")
  o.im.Publish("bnd_label_replay_off", o.labelReplayOff)
  o.im.Publish("bnd_label_replay_on", "")
  o.im.Publish("bnd_label_settings_off", o.labelSettingsOff)
  o.im.Publish("bnd_label_settings_on", "")
  o.im.Publish("bnd_label_restart_off", o.labelRestartOff)
  o.im.Publish("bnd_label_restart_on", "")
  o.im.Publish("bnd_label_end_off", o.labelEndOff)
  o.im.Publish("bnd_label_end_on", "")
  o.im.Publish("bnd_label_advance_off", o.labelAdvanceOff)
  o.im.Publish("bnd_label_advance_on", "")
  o.im.Publish("bnd_label_highlight_off", o.labelHighlightOff)
  o.im.Publish("bnd_label_highlight_on", "")
  return o
end

function GameMenu:BND_LIVE_TILE_MATCHGRADE()
  local MatchGrade = self:GetMatchGrade()
  local dataToInsert = {
    headline = { "" },
    description = "",
    images = {
      {
        name = "$Grade",
        id = MatchGrade
      }
    }
  }
  self.im.Publish(BND_LIVE_TILE_MATCHGRADE, dataToInsert)
end

function GameMenu:_publishLiveTiles()
  local dataToPublish = {
    index = 0,
    data = self.liveTileLists
  }
  self.im.Publish(bndLiveTileList, dataToPublish)
end

function GameMenu:_publishLiveTiles2()
  local dataToPublish = {
    index = 0,
    data = self.liveTileLists2
  }
  self.im.Publish(bndLiveTileList2, dataToPublish)
end

function GameMenu:handleEvent(eventType, data)
  if eventType == EVENT_TYPES.UpdateNumberOfPausesLeft then
    self:onNumberOfPauseLeftChanged()
  end
end

function GameMenu:resumeMatch()
  print("[GameMenu]: resumeMatch()")
  local screenName = self.services.ScreenInfoService.GetCurrentScreenName()
  print("[GameMenu]: resumeMatch: self.isGamePaused = " .. tostring(self.isGamePaused) .. ", GetCurrentScreenName: " .. tostring(screenName))
  if screenName == "GenericPopup" then
    self.nav.Event(nil, "evt_hide_popup")
  elseif screenName == "Customization" or screenName == "TouchControls" or screenName == "AudioVisual" or screenName == "General" or screenName == "ControllerControls" or screenName == "DebugSettings" then
    self.nav.Event(nil, "evt_save_settings")
  elseif screenName == "SpeechDownloadPopup" then
    self.nav.Event(nil, "evt_hide_speechdownload_popup")
  elseif self.isGamePaused then
    self.isGamePaused = false
    self.nav.Event(nil, "evt_toggle_pause")
  end
end

function GameMenu:NextUpdate()
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Close",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "For now the menu is not available, please wait for the next update.",
    buttons = {buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

-- Menu Restart --
function GameMenu:restartMatch()
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
      "evt_restart_match",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "RESTART MATCH",
    message = "Are you sure you want to restart this match?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

-- Menu Forfeit Match --
function GameMenu:forfeitMatch()
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
        "evt_quit_from_game",
        "evt_hide_popup"
      }
    }
    local popupData = {
      title = "END MATCH",
      message = "Are you sure you want to end this match? \n If so, you will lose and fail the Player Career mission.",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

-- Menu Quit Match --
function GameMenu:quitMatch()
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
      "evt_quit",
      "evt_hide_popup"
    }
  }
  function buttonYes.clickCallback()
    self:handleCupResult()
    self:handleChallengeResult()
    self:handleMatchDayResult()
    self:handleBeaproResult()
    self:handleLigaResult()
    if currentMode == 4 then
      local index = cameraIndex + 0
      self.services.SettingsService.SaveCameraValue(index)
    end
    self.nav.Event(nil, "evt_quit")
  end
  local popupData = {
    title = " QUIT MATCH ",
    message = "Continue your Player Career mission!",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function GameMenu:onNumberOfPauseLeftChanged()
  self.im.Refresh(BND_HOME_PAUSES)
  self.im.Refresh(BND_AWAY_PAUSES)
end

function GameMenu:getMatchType()
  -- if self.navContext.gamemode == CommonNavVars.GAMEMODES.FTF then
    --return ("Friendly match")
 -- elseif self.navContext.gamemode == CommonNavVars.GAMEMODES.REAL then
   -- return ("Real Team")
--  else
   -- return self.loc.LocalizeString(string.format("%s_%s_%s", self.navContext.gamemode, self.navContext.flow, self.navContext.type))
  -- end
  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      return "Emirates Fa Cup"
    elseif currentCupData.cupIndex == 2 then
      return "UEFA Champions League"
    elseif currentCupData.cupIndex == 3 then
      return "FIFA World Cup"
    elseif currentCupData.cupIndex == 4 then
      return "UEFA Europa League"
    elseif currentCupData.cupIndex == 5 then
      return "Roshn Saudi League"
    elseif currentCupData.cupIndex == 6 then
      return "Africa Cup Of Nations"
    elseif currentCupData.cupIndex == 7 then
      return "Championship Series"
    elseif currentCupData.cupIndex == 8 then
      return "Afc Champions Cup"
    elseif currentCupData.cupIndex == 9 then
      return "Piala Presiden"
    elseif currentCupData.cupIndex == 10 then
      return "World Cup Women's"
    elseif currentCupData.cupIndex == 11 then
      return "Women's Super League"
    elseif currentCupData.cupIndex == 12 then
      return "Women's Champions League"
    elseif currentCupData.cupIndex == 13 then
      return "Premier League"
    elseif currentCupData.cupIndex == 14 then
      return "UEFA Conference League"
    elseif currentCupData.cupIndex == 15 then
      return "UEFA Euro 2024™"
    elseif currentCupData.cupIndex == 16 then
      return "D1 Arkema"
    elseif currentCupData.cupIndex == 17 then
      return "Copa Argentina"
    elseif currentCupData.cupIndex == 18 then
      return "Copa America"
    elseif currentCupData.cupIndex == 19 then
      return "Copa Do Brasil"
    elseif currentCupData.cupIndex == 20 then
      return "AFC Asian Cup"
    elseif currentCupData.cupIndex == 21 then
      return "La Liga EA Sports"
    elseif currentCupData.cupIndex == 22 then
      return "La Liga Hypermotion"
    elseif currentCupData.cupIndex == 23 then
      return "1.Bundesliga"
    elseif currentCupData.cupIndex == 24 then
      return "2.Bundesliga"
    elseif currentCupData.cupIndex == 25 then
      return "Serie A"
    elseif currentCupData.cupIndex == 26 then
      return "Ligue 1"
    elseif currentCupData.cupIndex == 27 then
      return "Mls Cup"
    elseif currentCupData.cupIndex == 28 then
      return "World Cup Club"
    elseif currentCupData.cupIndex == 29 then
      return "Rest Of World"
    elseif currentCupData.cupIndex == 30 then
      return "Classic Teams"
      
    end
  else
  if self:isInTable(self:getTeam(), EnglandTeams) and self:isInTable(self:getTeam(true), EnglandTeams) then
    return "Premier League"
  elseif self:isInTable(self:getTeam(), SpainTeams) and self:isInTable(self:getTeam(true), SpainTeams) then
    return "La Liga"
  elseif self:isInTable(self:getTeam(), SpainBTeams) and self:isInTable(self:getTeam(true), SpainBTeams) then
    return "Hypermotion"
  elseif self:isInTable(self:getTeam(), LigaFTeams) and self:isInTable(self:getTeam(true), LigaFTeams) then
    return "Liga F"
  elseif self:isInTable(self:getTeam(), GermanyTeams) and self:isInTable(self:getTeam(true), GermanyTeams) then
    return "1. Bundesliga"
  elseif self:isInTable(self:getTeam(), Germany2Teams) and self:isInTable(self:getTeam(true), Germany2Teams) then
    return "2. Bundesliga"
  elseif self:isInTable(self:getTeam(), FranceTeams) and self:isInTable(self:getTeam(true), FranceTeams) then
    return "Ligue 1"
  elseif self:isInTable(self:getTeam(), FranceBTeams) and self:isInTable(self:getTeam(true), FranceBTeams) then
    return "Ligue 2"
  elseif self:isInTable(self:getTeam(), D1ArkemaTeams) and self:isInTable(self:getTeam(true), D1ArkemaTeams) then
    return "D1 Arkema"
  elseif self:isInTable(self:getTeam(), ItalyTeams) and self:isInTable(self:getTeam(true),ItalyTeams) then
    return "Serie A"
  elseif self:isInTable(self:getTeam(), ItalyBTeams) and self:isInTable(self:getTeam(true),ItalyBTeams) then
    return "Serie B"
  elseif self:isInTable(self:getTeam(), IndonesiaTeams) and self:isInTable(self:getTeam(true),IndonesiaTeams) then
    return "BRI Liga 1"
  elseif self:isInTable(self:getTeam(), WorldCupTeams) and self:isInTable(self:getTeam(true),WorldCupTeams) then
    return "International"
  elseif self:isInTable(self:getTeam(), InternationalWomansTeams) and self:isInTable(self:getTeam(true),InternationalWomansTeams) then
    return "International Woman"
  elseif self:isInTable(self:getTeam(), SaudiArabiaTeams) and self:isInTable(self:getTeam(true),SaudiArabiaTeams) then
    return "Roshn Saudi League"
  elseif self:isInTable(self:getTeam(), UnitedStatesTeams) and self:isInTable(self:getTeam(true),UnitedStatesTeams) then
    return "Mls"
  elseif self:isInTable(self:getTeam(), NwslTeams) and self:isInTable(self:getTeam(true),NwslTeams) then
    return "USA NWSL"
  elseif self:isInTable(self:getTeam(), WomensSuperLeagueTeams) and self:isInTable(self:getTeam(true),WomensSuperLeagueTeams) then
    return "W.S.L"
  elseif self:isInTable(self:getTeam(), LeagueOneEflTeams) and self:isInTable(self:getTeam(true),LeagueOneEflTeams) then
    return "EFL League One"
  elseif self:isInTable(self:getTeam(), LeagueTwoEflTeams) and self:isInTable(self:getTeam(true),LeagueTwoEflTeams) then
    return "EFL League Two"
  elseif self:isInTable(self:getTeam(), ChampionshipEflTeams) and self:isInTable(self:getTeam(true),ChampionshipEflTeams) then
    return "EFL Champions"
  elseif self:isInTable(self:getTeam(), UefaTeams) and self:isInTable(self:getTeam(true),UefaTeams) then
    return "UEFA Champions League"
  elseif self:isInTable(self:getTeam(), UefaEropaTeams) and self:isInTable(self:getTeam(true),UefaEropaTeams) then
    return "UEFA Europa League"
  elseif self:isInTable(self:getTeam(), UefaWomensTeams) and self:isInTable(self:getTeam(true),UefaWomensTeams) then
    return "UEFA Womens League"
  elseif self:isInTable(self:getTeam(), ScotlandTeams) and self:isInTable(self:getTeam(true),ScotlandTeams) then
    return "Premiership"
  elseif self:isInTable(self:getTeam(), PortugalTeams) and self:isInTable(self:getTeam(true),PortugalTeams) then
    return "Liga Portugal"
  elseif self:isInTable(self:getTeam(), NetherlandsTeams) and self:isInTable(self:getTeam(true),NetherlandsTeams) then
    return "Eredivisie"
  elseif self:isInTable(self:getTeam(), BelgiumTeams) and self:isInTable(self:getTeam(true),BelgiumTeams) then
    return "Pro League"
  elseif self:isInTable(self:getTeam(), ArgentinaTeams) and self:isInTable(self:getTeam(true),ArgentinaTeams) then
    return "Primera Division"
  elseif self:isInTable(self:getTeam(), BrazilTeams) and self:isInTable(self:getTeam(true),BrazilTeams) then
    return "Liga Do Brasil"
  elseif self:isInTable(self:getTeam(), ClassicTeams) and self:isInTable(self:getTeam(true),ClassicTeams) then
    return "Classic Team"
  elseif self:isInTable(self:getTeam(), Classic2Teams) and self:isInTable(self:getTeam(true),Classic2Teams) then
    return "Classic Team B"
  elseif self:isInTable(self:getTeam(), DenmarkTeams) and self:isInTable(self:getTeam(true),DenmarkTeams) then
    return "3F SuperLiga"
  elseif self:isInTable(self:getTeam(), EquadorTeams) and self:isInTable(self:getTeam(true),EquadorTeams) then
    return "Liga Pro"
  elseif self:isInTable(self:getTeam(), EgyptTeams) and self:isInTable(self:getTeam(true),EgyptTeams) then
    return "WE EPL"
  elseif self:isInTable(self:getTeam(), MalaysiaTeams) and self:isInTable(self:getTeam(true),MalaysiaTeams) then
    return "Malaysia Super League"
  elseif self:isInTable(self:getTeam(), MexicoTeams) and self:isInTable(self:getTeam(true),MexicoTeams) then
    return "Liga MX"
  elseif self:isInTable(self:getTeam(), RusiaTeams) and self:isInTable(self:getTeam(true),RusiaTeams) then
    return "Russian League"
  elseif self:isInTable(self:getTeam(), SouthAfricaTeams) and self:isInTable(self:getTeam(true),SouthAfricaTeams) then
    return "South African FL"
  elseif self:isInTable(self:getTeam(), SwitzerlandTeams) and self:isInTable(self:getTeam(true),SwitzerlandTeams) then
    return "Raiffeisen SL"
  elseif self:isInTable(self:getTeam(), TurkeyTeams) and self:isInTable(self:getTeam(true),TurkeyTeams) then
    return "Turkey Super League"
    
    
  
  
  else 
    return "Match Day"
  end
  end
end

function GameMenu:getShootoutResult()
  local matchScore = self.services.MatchInfoService.GetMatchScore()
  local homeScore = matchScore.homeShootout
  local awayScore = matchScore.awayShootout
  if homeScore == -1 or awayScore == -1 then
    return ""
  else
    return string.format("(%s - %s) %s", tostring(homeScore), tostring(awayScore), ("PEN"))
  end
end

function GameMenu:getGameState()
  if self.navContext.gameState == CommonNavVars.GAME_STATES.PAUSE then
    return ("GAME PAUSED")
  elseif self.navContext.gameState == CommonNavVars.GAME_STATES.HALFTIME then
    return ("HALFTIME")
  elseif self.navContext.gameState == CommonNavVars.GAME_STATES.FULLTIME then
    return ("FULLTIME")
  elseif self.navContext.gameState == CommonNavVars.GAME_STATES.OT_HALFTIME then
    return ("OT HALFTIME")
  elseif self.navContext.gameState == CommonNavVars.GAME_STATES.OT_FULLTIME then
    return ("OT FULLTIME")
  elseif self.navContext.gameState == CommonNavVars.GAME_STATES.SHOOTOUT_PAUSE then
    return ("SHOOTOUT PAUSE")
  else
    return nil
  end
end


function GameMenu:OnTabResumeClicked()
  self.activeTab = "resume"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_resume")
end

function GameMenu:OnTabAccessibilityClicked()
  self.activeTab = "accessibility"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_accessibility")
end

function GameMenu:OnTabFactsClicked()
  self.activeTab = "facts"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_facts")
end

function GameMenu:OnTabReplayClicked()
  self.activeTab = "replay"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_replay")
end

function GameMenu:OnTabSettingsClicked()
  self.activeTab = "settings"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_settings")
end

function GameMenu:OnTabRestartClicked()
  self.activeTab = "restart"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_restart")
end

function GameMenu:OnTabEndClicked()
  self.activeTab = "end"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_end")
end

function GameMenu:OnTabAdvanceClicked()
  self.activeTab = "advance"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_advance")
end

function GameMenu:OnTabHighlightClicked()
  self.activeTab = "highlight"
  self:RefreshLabels()
  self.nav.Event(nil, "evt_tab_highlight")
end

function GameMenu:RefreshLabels()
  self.im.Publish("bnd_label_resume_off", self.labelResumeOff)
  self.im.Publish("bnd_label_resume_on", "")
  self.im.Publish("bnd_label_accessibility_off", self.labelAccessibilityOff)
  self.im.Publish("bnd_label_accessibility_on", "")
  self.im.Publish("bnd_label_facts_off", self.labelFactsOff)
  self.im.Publish("bnd_label_facts_on", "")
  self.im.Publish("bnd_label_replay_off", self.labelReplayOff)
  self.im.Publish("bnd_label_replay_on", "")
  self.im.Publish("bnd_label_settings_off", self.labelSettingsOff)
  self.im.Publish("bnd_label_settings_on", "")
  self.im.Publish("bnd_label_restart_off", self.labelRestartOff)
  self.im.Publish("bnd_label_restart_on", "")
  self.im.Publish("bnd_label_end_off", self.labelEndOff)
  self.im.Publish("bnd_label_end_on", "")
  self.im.Publish("bnd_label_advance_off", self.labelAdvanceOff)
  self.im.Publish("bnd_label_advanve_on", "")
  self.im.Publish("bnd_label_highlight_off", self.labelHighlightOff)
  self.im.Publish("bnd_label_highlight_on", "")
  if self.activeTab == "resume" then
    self.im.Publish("bnd_label_resume_off", "")
    self.im.Publish("bnd_label_resume_on", self.labelResumeOn)
  elseif self.activeTab == "accessibility" then
    self.im.Publish("bnd_label_accessibility_off", "")
    self.im.Publish("bnd_label_accessibility_on", self.labelAccessibilityOn)
  elseif self.activeTab == "facts" then
    self.im.Publish("bnd_label_facts_off", "")
    self.im.Publish("bnd_label_facts_on", self.labelFactsOn)
  elseif self.activeTab == "replay" then
    self.im.Publish("bnd_label_replay_off", "")
    self.im.Publish("bnd_label_replay_on", self.labelReplayOn)
  elseif self.activeTab == "settings" then
    self.im.Publish("bnd_label_settings_off", "")
    self.im.Publish("bnd_label_settings_on", self.labelSettingsOn)
  elseif self.activeTab == "restart" then
    self.im.Publish("bnd_label_restart_off", "")
    self.im.Publish("bnd_label_restart_on", self.labelRestartOn)
  elseif self.activeTab == "end" then
    self.im.Publish("bnd_label_end_off", "")
    self.im.Publish("bnd_label_end_on", self.labelEndOn)
  elseif self.activeTab == "advance" then
    self.im.Publish("bnd_label_advance_off", "")
    self.im.Publish("bnd_label_advance_on", self.labelAdvanceOn)
  elseif self.activeTab == "highlight" then
    self.im.Publish("bnd_label_highlight_off", "")
    self.im.Publish("bnd_label_highlight_on", self.labelHighlightOn)
  end
end


function GameMenu:getAvatarPath(isAway)
  local userIsHostTeam = self.services.GameSetupService.IsHostTeam()
  if userIsHostTeam and isAway or not userIsHostTeam and not isAway then
    if self.navContext.flow ~= CommonNavVars.FLOWS.ONLINE then
      return nil
    else
      return self.services.SocialService.GetImagePathForOpponent(true)
    end
  else
    return self.services.SocialService.GetImagePathForUser(true)
  end
end

function GameMenu:getTeam(isAway)
  local teamData = self.services.MatchInfoService.GetMatchTeams()
  if isAway then
    return teamData[2]
  else
    return teamData[1]
  end
end

function GameMenu:handleCupResult()
  local cupIndex = currentCupData.cupIndex
  if cupIndex > 0 then
    local currentCupGrouping = QuickCupGrouping[cupIndex]
    local matchScore = self.services.MatchInfoService.GetMatchScore()
    local time = self.services.OverlayService.GetGameClockString()
    local gameTime = string.sub(time, 1, string.find(time, ":") - 1)
    local homeShootoutScore = matchScore.homeShootout
    local awayShootoutScore = matchScore.awayShootout
    local facts = self:getMatchFacts()
    local homeScore = facts[1].data.value
    local awayScore = facts[1].data.valueRight
    if homeShootoutScore ~= -1 or awayShootoutScore ~= -1 then
        homeScore = homeScore + homeShootoutScore
        awayScore = awayScore + awayShootoutScore
    end
    if gameTime + 0 < 90 then
        homeScore = 0
        awayScore = 3
    end  
    
    for i = 1, table.getn(QuickCupGrouping[cupIndex]) do
      if not QuickCupGrouping[cupIndex][i][5] then
        if QuickCupGrouping[cupIndex][i][1] == currentCupData.homeID then
          QuickCupGrouping[cupIndex][i][3] = tostring(homeScore)
          QuickCupGrouping[cupIndex][i][4] = tostring(awayScore)
          QuickCupGrouping[cupIndex][i][5] = true
          if homeScore + 0 > awayScore + 0 then
            QuickCupGrouping[cupIndex][i][6] = currentCupData.homeID
          else
            QuickCupGrouping[cupIndex][i][6] = currentCupData.awayID
          end
        elseif QuickCupGrouping[cupIndex][i][2] == currentCupData.homeID then
          QuickCupGrouping[cupIndex][i][3] = tostring(awayScore)
          QuickCupGrouping[cupIndex][i][4] = tostring(homeScore)
          QuickCupGrouping[cupIndex][i][5] = true
          if homeScore + 0 > awayScore + 0 then
            QuickCupGrouping[cupIndex][i][6] = currentCupData.homeID
          else
            QuickCupGrouping[cupIndex][i][6] = currentCupData.awayID
          end
        else
            local teamA = QuickCupGrouping[cupIndex][i][1]
            local teamB = QuickCupGrouping[cupIndex][i][2]
            local scoreList = self:GetTeamRealScore(teamA, teamB)
            QuickCupGrouping[cupIndex][i][3] = tostring(scoreList[teamA])
            QuickCupGrouping[cupIndex][i][4] = tostring(scoreList[teamB])
            QuickCupGrouping[cupIndex][i][5] = true
            if scoreList[teamA] > scoreList[teamB] then
                QuickCupGrouping[cupIndex][i][6] = QuickCupGrouping[cupIndex][i][1]
            else
                QuickCupGrouping[cupIndex][i][6] = QuickCupGrouping[cupIndex][i][2]
            end
        end
      end
    end
    -- 根据胜负关系生成下一轮的对阵表
    local isExist = false
    local length = #QuickCupGrouping[cupIndex]
    local index = 0
    for j = length, 1,  -1 do
        if QuickCupGrouping[cupIndex][j][1] == currentCupData.homeID or QuickCupGrouping[cupIndex][j][2] == currentCupData.homeID then     
          index = index + 1    
          if QuickCupGrouping[cupIndex][j][6] == currentCupData.homeID and index == 1 then
              isExist = true
              break
          end
        end
    end
    if isExist then
        if length < currentCupData.maxMatchSize then
            for k = 1, length do
              local temp = k * 2 - 1
              if temp < length then
                if not QuickCupGrouping[cupIndex][temp][7] and not QuickCupGrouping[cupIndex][temp+1][7] and QuickCupGrouping[cupIndex][temp][5] == true and QuickCupGrouping[cupIndex][temp+1][5] == true then
                  QuickCupGrouping[cupIndex][temp][7] = true
                  QuickCupGrouping[cupIndex][temp+1][7] = true
                  local l = #QuickCupGrouping[cupIndex] + 1
                  QuickCupGrouping[cupIndex][l] = {
                    [1] = 0,
                    [2] = 0,
                    [3] = "0",
                    [4] = "0",
                    [5] = false,
                    [6] = 0,
                    [7] = false
                  }
                  QuickCupGrouping[cupIndex][l][1] = QuickCupGrouping[cupIndex][temp][6]
                  QuickCupGrouping[cupIndex][l][2] = QuickCupGrouping[cupIndex][temp+1][6]
                  QuickCupGrouping[cupIndex][l][3] = "0"
                  QuickCupGrouping[cupIndex][l][4] = "0"
                  QuickCupGrouping[cupIndex][l][5] = false
                  QuickCupGrouping[cupIndex][l][6] = 0
                end
              end
            end
        end
    else
        if length < currentCupData.maxMatchSize then
            for k = 1, table.getn(QuickCupGrouping[cupIndex]) do
              local temp = k * 2 - 1
              if temp < #QuickCupGrouping[cupIndex] then
                if not QuickCupGrouping[cupIndex][temp][7] and not QuickCupGrouping[cupIndex][temp+1][7] and QuickCupGrouping[cupIndex][temp][5] == true and QuickCupGrouping[cupIndex][temp+1][5] == true then
                  QuickCupGrouping[cupIndex][temp][7] = true
                  QuickCupGrouping[cupIndex][temp+1][7] = true
                  local l = #QuickCupGrouping[cupIndex] + 1
                  QuickCupGrouping[cupIndex][l] = {
                    [1] = 0,
                    [2] = 0,
                    [3] = "0",
                    [4] = "0",
                    [5] = false,
                    [6] = 0,
                    [7] = false
                  }
                  QuickCupGrouping[cupIndex][l][1] = QuickCupGrouping[cupIndex][temp][6]
                  QuickCupGrouping[cupIndex][l][2] = QuickCupGrouping[cupIndex][temp+1][6]
                  if QuickCupGrouping[cupIndex][temp][6] ~= currentCupData.homeID and QuickCupGrouping[cupIndex][temp+1][6] ~= currentCupData.homeID then
                    local teamA = QuickCupGrouping[cupIndex][temp][6]
                    local teamB = QuickCupGrouping[cupIndex][temp+1][6]
                    local scoreList = self:GetTeamRealScore(teamA, teamB)
                    QuickCupGrouping[cupIndex][l][3] = tostring(scoreList[teamA])
                    QuickCupGrouping[cupIndex][l][4] = tostring(scoreList[teamB])
                    QuickCupGrouping[cupIndex][l][5] = true
                    if scoreList[teamA] > scoreList[teamB] then
                      QuickCupGrouping[cupIndex][l][6] = QuickCupGrouping[cupIndex][temp][6]
                    else
                      QuickCupGrouping[cupIndex][l][6] = QuickCupGrouping[cupIndex][temp+1][6]
                    end
                  else
                    QuickCupGrouping[cupIndex][l][3] = "0"
                    QuickCupGrouping[cupIndex][l][4] = "0"
                    QuickCupGrouping[cupIndex][l][5] = false
                    QuickCupGrouping[cupIndex][l][6] = 0
                  end
                end
              end
            end
        end
    end
    
    
  end
end

function GameMenu:GetRandomScore(v1, v2)
  if not v1 then
    v1 = 0
  end
  if not v2 then
    v2 = 5
  end
  --math.randomseed(os.clock() * 1357 + os.time())
  local randomScore = math.random(v1, v2)
  return randomScore
end

function GameMenu:GetTeamRealScore(teamA, teamB)
    local teamA_Info = self.services.SquadManagementService.GetTeamInfo(teamA)
    local teamB_Info = self.services.SquadManagementService.GetTeamInfo(teamB)
    local randomTeamA = self:GetRandomScore(1,100)
    local randomTeamB = self:GetRandomScore(1,100)
    local scoreTeamA = self:GetRealScore(randomTeamA)
    local scoreTeamB = self:GetRealScore(randomTeamB)
    local scoreList = {}
    scoreList[teamA] = 0
    scoreList[teamB] = 0
    local poor = math.abs(teamA_Info.overall - teamB_Info.overall)
    local radio = self:GetTeamWinRatio(poor)
    local random = self:GetRandomScore(1,100)
    if teamA_Info.overall > teamB_Info.overall then
        if random <= radio then
            if scoreTeamA > scoreTeamB then
                scoreList[teamA] = scoreTeamA
                scoreList[teamB] = scoreTeamB
            elseif scoreTeamA < scoreTeamB then
                scoreList[teamA] = scoreTeamB
                scoreList[teamB] = scoreTeamA
            else
                scoreList[teamA] = scoreTeamA + 1
                scoreList[teamB] = scoreTeamB
            end
        else
            -- 爆冷
            if scoreTeamA > scoreTeamB then
                scoreList[teamA] = scoreTeamB
                scoreList[teamB] = scoreTeamA
            elseif scoreTeamA < scoreTeamB then
                scoreList[teamA] = scoreTeamA
                scoreList[teamB] = scoreTeamB
            else
                scoreList[teamA] = scoreTeamA
                scoreList[teamB] = scoreTeamB + 1
            end
        end
    elseif teamA_Info.overall < teamB_Info.overall then
        if random <= radio then
            if scoreTeamA > scoreTeamB then
                scoreList[teamA] = scoreTeamB
                scoreList[teamB] = scoreTeamA
            elseif scoreTeamA < scoreTeamB then
                scoreList[teamA] = scoreTeamA
                scoreList[teamB] = scoreTeamB
            else
                scoreList[teamA] = scoreTeamA
                scoreList[teamB] = scoreTeamB + 1
            end
        else
            -- 爆冷
            if scoreTeamA > scoreTeamB then
                scoreList[teamA] = scoreTeamA
                scoreList[teamB] = scoreTeamB
            elseif scoreTeamA < scoreTeamB then
                scoreList[teamA] = scoreTeamB
                scoreList[teamB] = scoreTeamA
            else
                scoreList[teamA] = scoreTeamA + 1
                scoreList[teamB] = scoreTeamB
            end
        end
    else 
        scoreList[teamA] = scoreTeamA
        scoreList[teamB] = scoreTeamB
        if scoreTeamA == scoreTeamB then
            local x = math.random(1, 2)
            if x == 1 then
                scoreList[teamA] = scoreTeamA + 1
            else
                scoreList[teamB] = scoreTeamB + 1
            end
        end
    end
    return scoreList
end

function GameMenu:GetRealScore(random)
    if random > 0 and random <= 15 then
        return 0
    elseif random > 15 and random <= 40 then
        return 1
    elseif random > 40 and random <= 70 then
        return 2
    elseif random > 70 and random <= 85 then
        return 3
    elseif random > 85 and random <= 95 then
        return 4
    elseif random > 95 and random <= 100 then
        return 5
    end
end

function GameMenu:GetTeamWinRatio(poor)
    if poor <= 0 then
        return 50
    elseif poor > 0 and poor <= 3 then
        return 65
    elseif poor > 3 and poor <= 5 then
        return 75
    elseif poor > 5 and poor <= 10 then
        return 85
    elseif poor > 10 and poor <= 15 then
        return 90
    elseif random > 15 and random <= 20 then
        return 95
    else
        return 98
    end
end


function GameMenu:getTeamCrest(isAway)
  return {
    name = "$Crest",
    id = self:getTeam(isAway).assetId
  }
end

function GameMenu:getPlayer(isAway)
  return {
    name = "$PlayerMOM",
    id = self:getTeam(isAway).assetId
  }
end


function GameMenu:getMan(isAway)
  return {
    name = "$MyCoach",
    id = self:getTeam(isAway).assetId
  }
end



function GameMenu:handleChallengeResult()
  local Index = currentChallengeData.Index
  local round = currentChallengeData.round
  if Index > 0 then
     -- local currentMatchData = ChallengeGrouping[Index][round]
      local matchScore = self.services.MatchInfoService.GetMatchScore()
      local time = self.services.OverlayService.GetGameClockString()
      local gameTime = string.sub(time, 1, string.find(time, ":") - 1)
      local homeShootoutScore = matchScore.homeShootout
      local awayShootoutScore = matchScore.awayShootout
      local facts = self:getMatchFacts()
      local homeScore = facts[1].data.value
      local awayScore = facts[1].data.valueRight
      if homeShootoutScore ~= -1 or awayShootoutScore ~= -1 then
          homeScore = homeScore + homeShootoutScore
          awayScore = awayScore + awayShootoutScore
      end
      if gameTime + 0 < 90 then
          homeScore = 0
          awayScore = 3
      end
      ChallengeGrouping[Index][round][3] = homeScore
      ChallengeGrouping[Index][round][4] = awayScore
      ChallengeGrouping[Index][round][5] = true
      if homeScore + 0 > awayScore + 0 then
          ChallengeGrouping[Index][round][7] = true
          -- 解锁下一个比赛
          if round + 0 < #ChallengeGrouping[Index] then
             local nextIndex = round + 1
             ChallengeGrouping[Index][nextIndex][8] = true
          else
              currentChallengeInfo[Index].isSuccess = 2
          end
      else
          currentChallengeInfo[Index].isSuccess = 1
      end

  end
end

function GameMenu:handleLigaResult()
  local Index = currentLigaData.Index
  local round = currentLigaData.round
  if Index > 0 then
     -- local currentMatchData = LigaGrouping[Index][round]
      local matchScore = self.services.MatchInfoService.GetMatchScore()
      local time = self.services.OverlayService.GetGameClockString()
      local gameTime = string.sub(time, 1, string.find(time, ":") - 1)
      local homeShootoutScore = matchScore.homeShootout
      local awayShootoutScore = matchScore.awayShootout
      local facts = self:getMatchFacts()
      local homeScore = facts[1].data.value
      local awayScore = facts[1].data.valueRight
      if homeShootoutScore ~= -1 or awayShootoutScore ~= -1 then
          homeScore = homeScore + homeShootoutScore
          awayScore = awayScore + awayShootoutScore
      end
      if gameTime + 0 < 90 then
          homeScore = 0
          awayScore = 3
      end
      LigaGrouping[Index][round][4] = homeScore
      LigaGrouping[Index][round][5] = awayScore
      LigaGrouping[Index][round][6] = true
      if homeScore + 0 > awayScore + 0 then
          LigaGrouping[Index][round][8] = true
          -- 解锁下一个比赛
          if round + 0 < #LigaGrouping[Index] then
             local nextIndex = round + 1
             LigaGrouping[Index][nextIndex][9] = true
          else
              currentLigaInfo[Index].isSuccess = 2
          end
      else
          currentLigaInfo[Index].isSuccess = 1
      end

  end
end

function GameMenu:handleMatchDayResult()
  if currentMode == 6 then
    local matchScore = self.services.MatchInfoService.GetMatchScore()
    local time = self.services.OverlayService.GetGameClockString()
    local gameTime = string.sub(time, 1, string.find(time, ":") - 1)
    local homeShootoutScore = matchScore.homeShootout
    local awayShootoutScore = matchScore.awayShootout
    local facts = self:getMatchFacts()
    local homeScore = facts[1].data.value
    local awayScore = facts[1].data.valueRight
    if homeShootoutScore ~= -1 or awayShootoutScore ~= -1 then
      homeScore = homeScore + homeShootoutScore
      awayScore = awayScore + awayShootoutScore
    end
    if gameTime + 0 < 90 then
      homeScore = 0
      awayScore = 3
    end
    currentDayMatchList[currentMatch.MatchIndex].score = homeScore.." - "..awayScore
  end
end

function GameMenu:handleBeaproResult()
  local Index = currentBeaproData.Index
  local round = currentBeaproData.round
  if Index > 0 then
     -- local currentMatchData = BeaproGrouping[Index][round]
      local matchScore = self.services.MatchInfoService.GetMatchScore()
      local time = self.services.OverlayService.GetGameClockString()
      local gameTime = string.sub(time, 1, string.find(time, ":") - 1)
      local homeShootoutScore = matchScore.homeShootout
      local awayShootoutScore = matchScore.awayShootout
      local facts = self:getMatchFacts()
      local homeScore = facts[1].data.value
      local awayScore = facts[1].data.valueRight
      if homeShootoutScore ~= -1 or awayShootoutScore ~= -1 then
          homeScore = homeScore + homeShootoutScore
          awayScore = awayScore + awayShootoutScore
      end
      if gameTime + 0 < 90 then
          homeScore = 0
          awayScore = 3
      end
      BeaproGrouping[Index][round][3] = homeScore
      BeaproGrouping[Index][round][4] = awayScore
      BeaproGrouping[Index][round][5] = true
      if homeScore + 0 > awayScore + 0 then
          BeaproGrouping[Index][round][7] = true
          -- 解锁下一个比赛
          if round + 0 < #BeaproGrouping[Index] then
             local nextIndex = round + 1
             BeaproGrouping[Index][nextIndex][8] = true
          else
              currentBeaproInfo[Index].isSuccess = 2
          end
      else
          currentBeaproInfo[Index].isSuccess = 1
      end

  end
end

function GameMenu:GetMatchGrade()
  -- 共五个评级 A B C D F
  local Grade = 0
  local homeScore = self:getGoals(false)
  local awayScore = self:getGoals(true)
  local diffScore = math.abs(homeScore - awayScore)
  if homeScore > awayScore then
    if diffScore >= 2 then
      Grade = 0
    else
      Grade = 1
    end
  elseif homeScore == awayScore then
    Grade = 2
  else
    if diffScore >= 2 then
      Grade = 4
    else
      Grade = 3
    end
  end
  return Grade
end


function GameMenu:getMatchFacts()
  local facts = self.services.MatchInfoService.GetMatchFacts(true)
  local o = facts.homeData
  for i, v in ipairs(o) do
    v.data.valueRight = facts.awayData[i].data.value
  end
  return o
end

function GameMenu:getPausesRemaining(isAway)
  if self.navContext == CommonNavVars.FLOWS.OFFLINE then
    return nil
  end
  local userIsHostTeam = self.services.GameSetupService.IsHostTeam()
  if userIsHostTeam and isAway or not userIsHostTeam and not isAway then
    return tostring(self.services.PauseMenuService.GetOponentPausesLeft())
  else
    return tostring(self.services.PauseMenuService.GetLocalPausesLeft())
  end
end

function GameMenu:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function GameMenu:getGoals(isAway)
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

function GameMenu:finalize()
  print("[GameMenu]: finalize()")
  self.services.GameStateService.UnRegisterListener(BACK_KEY_PRESSED)
  self.im.Unsubscribe(BND_HOME_PAUSES)
  self.im.Unsubscribe(BND_AWAY_PAUSES)
  self.im.Unsubscribe(BND_HOME_USER_DATA)
  self.im.Unsubscribe(BND_AWAY_USER_DATA)
  self.im.Unsubscribe(BND_HOME_TEAM_CREST)
  self.im.Unsubscribe(BND_AWAY_TEAM_CREST)
  self.im.Unsubscribe(BND_PLAYER)
self.im.Unsubscribe("bnd_label_resume_off")
  self.im.Unsubscribe("bnd_label_resume_on")
  self.im.Unsubscribe("bnd_label_home_off")
  self.im.Unsubscribe("bnd_label_home_on")
  self.im.Unsubscribe("bnd_label_away_off")
  self.im.Unsubscribe("bnd_label_away_on")
  self.im.Unsubscribe("bnd_label_facts_off")
  self.im.Unsubscribe("bnd_label_facts_on")
  self.im.Unsubscribe("bnd_label_replay_off")
  self.im.Unsubscribe("bnd_label_replay_on")
  self.im.Unsubscribe("bnd_label_settings_off")
  self.im.Unsubscribe("bnd_label_settings_on")
  self.im.Unsubscribe("bnd_label_side_off")
  self.im.Unsubscribe("bnd_label_side_on")
  self.im.Unsubscribe("bnd_label_restart_off")
  self.im.Unsubscribe("bnd_label_restart_on")
  self.im.Unsubscribe("bnd_label_end_off")
  self.im.Unsubscribe("bnd_label_end_on")
  self.im.Unsubscribe("bnd_label_quit_off")
  self.im.Unsubscribe("bnd_label_quit_on")
  self.im.Unsubscribe("bnd_label_rest_off")
  self.im.Unsubscribe("bnd_label_rest_on")
  self.im.Unsubscribe("bnd_label_fact_off")
  self.im.Unsubscribe("bnd_label_fact_on")
  self.im.Unsubscribe("bnd_label_performance_off")
  self.im.Unsubscribe("bnd_label_performance_on")
  self.im.Unsubscribe("bnd_label_highlight_off")
  self.im.Unsubscribe("bnd_label_highlight_on")
  self.im.Unsubscribe(BND_MAN)
  self.im.Unsubscribe(BND_HOME_TEAM_NAME_ABBR)
  self.im.Unsubscribe(BND_AWAY_TEAM_NAME_ABBR)
  self.im.Unsubscribe(BND_HOME_TEAM_NAME)
  self.im.Unsubscribe(BND_AWAY_TEAM_NAME)
  self.im.Unsubscribe(BND_RESULT)
  self.im.Unsubscribe(BND_SHOOTOUT_RESULT)
  self.im.Unsubscribe(BND_MATCH_TYPE)
  self.im.Unsubscribe(BND_GAME_STATE)
  self.im.Unsubscribe(BND_STADIUM_NAME)
  self.im.Unsubscribe(BND_TIME)
  self.im.Unsubscribe(BND_LIVE_TILE_MATCHFACTS)
  self.im.Unsubscribe(BND_LIVE_TILE_RESUME)
  self.im.Unsubscribe(BND_LIVE_TILE_SQUAD)
  self.im.Unsubscribe(bndLiveTileList)
  self.im.Unsubscribe(BND_LIVE_TILE_REPLAY)
  self.im.Unsubscribe(bndLiveTileList2)
  self.im.Unsubscribe(BND_LIVE_TILE_SETTINGS)
  self.im.Unsubscribe(BND_LIVE_TILE_FORFEIT)
  self.im.Unsubscribe(BND_LIVE_TILE_MATCH_FACTS)
  self.im.Unsubscribe(BND_LIVE_TILE_CAPTURED_MEDIA)
  self.im.Unsubscribe(BND_LIVE_TILE_CAPTURED_MEDIA_ENABLED)
  self.im.Unsubscribe(BND_LIVE_TILE_QUIT)
  self.im.Unsubscribe(BND_SHOW_ONLINE_INFO)
  self.im.Unsubscribe(BND_SHOW_OFFLINE_INFO)
  self.im.Unsubscribe(BND_LIVE_TILE_HIGHLIGHTS)
  self.im.Unsubscribe(BND_LIVE_TILE_REPLAY_ENABLED)
  self.im.UnregisterAction(ACT_TOGGLE_PAUSE)
  self.im.UnregisterAction(ACT_FORFEIT_MATCH)
  self.im.UnregisterAction(ACT_QUIT_MATCH)
  self.im.UnregisterAction(ACT_TO_INGAME_SQUAD)
  self.im.UnregisterAction(ACT_TO_INGAME_SQUADAWAY)
  self.im.UnregisterAction(ACT_RESTART_MATCH)
  elf.im.Unsubscribe(BND_LIVE_TILE_MATCHGRADE)
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
  if self.flow == CommonNavVars.FLOWS.OFFLINE then
    self.services.ScreenInfoService.UnsetScreenName("PauseMenuOffline")
  end
end

return GameMenu
