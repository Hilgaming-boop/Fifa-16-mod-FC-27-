
local KitSelect = {}
local bndHomeTeamData = "bnd_home_team_crest"
local bndAwayTeamData = "bnd_away_team_crest"
local bndAwayReadyLabelVisible = "bnd_away_ready_label_visible"
local bndAwayToggleVisible = "bnd_away_toggle_visible"
local bndAwaySelectingKitMsgVisible = "bnd_away_selecting_kit_msg_visible"
local bndHomeReadyLabelVisible = "bnd_home_ready_label_visible"
local bndHomeToggleVisible = "bnd_home_toggle_visible"
local bndHomeSelectingKitMsgVisible = "bnd_home_selecting_kit_msg_visible"
local bndLatency = "bnd_latency"
local bndLatencyVisible = "bnd_latency_visible"
local bndBackBtnText = "bnd_back_btn_text"
local BND_HOME_KITS = "bnd_home_kits"
local BND_AWAY_KITS = "bnd_away_kits"
local BND_HOME_KITS_INDEX = "bnd_home_kit_index"
local BND_AWAY_KITS_INDEX = "bnd_away_kit_index"
local ACT_HOME_CHANGE = "act_change_home"
local ACT_AWAY_CHANGE = "act_change_away"
local BND_TOGGLE_HOME_KIT_MESSAGE = "bnd_insToggleHomeKitMessage"
local BND_TOGGLE_AWAY_KIT_MESSAGE = "bnd_insToggleAwayKitMessage"
local bndAwayKitSelectorVisible = "bnd_away_kit_selector_visible"
local bndNoOpponentQuestionMarkVisible = "bnd_no_opponent_question_mark_visible"
local bndAwayMatchmakingMessageVisible = "bnd_away_matchmaking_message_visible"
local bndAwayTeamSelector = "bnd_away_team_selector"
local bndAwayLoadingVisible = "bnd_away_loading_visible"
local bnd3DPlayersVisible = "bnd_3d_players_visible"
local bnd2DKitsVisible = "bnd_2d_kits_visible"
local bnd2DHomeKit = "bnd_2d_home_kit"
local bnd3DHomeKit = "bnd_3d_home_kit"
local bnd2DAwayKit = "bnd_2d_away_kit"
local bnd3DAwayKit = "bnd_3d_away_kit"
local bnd2DHomeKit2 = "bnd_2d_home_kit2"
local bnd2DAwayKit2 = "bnd_2d_away_kit2"
local bnd2DHomeKit3 = "bnd_2d_home_kit3"
local bnd2DAwayKit3 = "bnd_2d_away_kit3"
local bnd2DHomeKit4 = "bnd_2d_home_kit4"
local bnd2DAwayKit4 = "bnd_2d_away_kit4"
local bnd2DHomeKit5 = "bnd_2d_home_kit5"
local bnd2DAwayKit5 = "bnd_2d_away_kit5"
local bnd2DHomeKit6 = "bnd_2d_home_kit6"
local bnd2DAwayKit6 = "bnd_2d_away_kit6"
local bnd2DHomeKit7 = "bnd_2d_home_kit7"
local bnd2DAwayKit7 = "bnd_2d_away_kit7"
local bnd2DHomeKit8 = "bnd_2d_home_kit8"
local bnd2DAwayKit8 = "bnd_2d_away_kit8"
local bnd2DHomeKit9 = "bnd_2d_home_kit9"
local bnd2DAwayKit9 = "bnd_2d_away_kit9"
local bnd2DHomeKit10 = "bnd_2d_home_kit10"
local bnd2DAwayKit10 = "bnd_2d_away_kit10"
local bndHomeKitAlpha = "bnd_home_kit_alpha"
local bndAwayKitAlpha = "bnd_away_kit_alpha"

local BND_TAB1 = "bnd_tab1"
local BND_TAB2 = "bnd_tab2"
local BND_TAB3 = "bnd_tab3"
local BND_TAB4 = "bnd_tab4"
local BND_TAB5 = "bnd_tab5"
local BND_TAB6 = "bnd_tab6"
local BND_TAB7 = "bnd_tab7"
local ACT_BTN_CLICK = "act_btn_click"

local actAdvance = "act_advance"
local actBack = "act_back"
local actSettings = "act_settings"
local bndDif = "bnd_match_difficulty"
local actHomeKitPrevious = "act_home_kit_previous"
local actHomeKitNext = "act_home_kit_next"
local actAwayKitPrevious = "act_away_kit_previous"
local actAwayKitNext = "act_away_kit_next"
local BND_BG_CUP = "bnd_bg_tour"
local bndSingleTourLogo = "bnd_tour_logo"
local BND_COLOR_CUPID = "bnd_color_tourid" 
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5
local TAB6 = 6
local TAB7 = 7
function KitSelect:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  if currentMatch then
      print("✅ KitSelect: Menerima currentMatch.HomeTeamID = " .. tostring(currentMatch.HomeTeamID))
      print("✅ KitSelect: Menerima currentMatch.AwayTeamID = " .. tostring(currentMatch.AwayTeamID))
  else
      print("❌ KitSelect: ERROR! Tabel 'currentMatch' tidak ditemukan (nil). Alur dari skrip sebelumnya gagal.")

      currentMatch = { HomeTeamID = 1, AwayTeamID = 10, HomeKitIndex = 0, AwayKitIndex = 1 } 
  end

  o.services = {
      matchInfo = o.api("MatchInfoService"),
      settingsService = o.api("SettingsService"),
      UserPlate = o.api("UserPlateService"),
      MatchSetup = o.api("MatchSetupService"),
      GameSetup = o.api("GameSetupService"),
      GameState = o.api("GameStateService"),
      Pregame = o.api("PregameService"),
      LoggingService = o.api("LoggingService"),
      ClientServerService = o.api("ClientServerService"),
      EventManagerService = o.api("EventManagerService"),
      SaveLoadService = o.api("SaveLoadService")
  }
  
    o.currentOptions = o.services.settingsService.GetCurrentOptions()

    o.homeTeamID = currentTourData.homeID
    o.awayTeamID = currentTourData.awayID
	o.singleTourID = currentTourData.tourIndex
	o.colorID = currentTourData.tourColor

    if not currentTourData or not currentTourData.homeID then
        print("❌ KitSelect: Gagal membaca currentTourData. Menggunakan tim default.")
        currentTourData = { homeID = 1, awayID = 10, homeKitIndex = 0, awayKitIndex = 1, isUserSideHome = 0 }
    end

  o.im.Subscribe(bndHomeTeamData, function()
    o.im.Publish(bndHomeTeamData, {
      name = "$Crest",
      id = o.homeTeamID
    })
  end)
  o.im.Subscribe(bndAwayTeamData, function()
    o.im.Publish(bndAwayTeamData, {
      name = "$Crest",
      id = o.awayTeamID
    })
  end)
  o.homeTeamData = {
    {
      KITTYPE = 0,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 1,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 3,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 4,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 5,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 6,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 7,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 8,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 9,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 10,
      YEAR = 0,
      TEAMID = o.homeTeamID
    }
  }
  o.awayTeamData = {
    {
      KITTYPE = 0,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 1,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 3,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 4,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 5,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 6,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 7,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 8,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 9,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 10,
      YEAR = 0,
      TEAMID = o.awayTeamID
    }
  }
  
  print("KitSelect initialized:")
  print("  TOUR ID: "..tostring(o.singleTourID))
  print("  TOUR ID: "..tostring(o.colorID))
  
    o.im.Subscribe(bndSingleTourLogo, function()
        o.im.Publish(bndSingleTourLogo, {
            name = "$CupLogo",
            id = o.singleTourID
        })
    end)
    o.im.Subscribe(BND_BG_CUP, function()
        o.im.Publish(BND_BG_CUP, {
            name = "$Bg_Cup",
            id = o.singleTourID
        })
    end)
    o.im.Subscribe(BND_COLOR_CUPID, function()
        o.im.Publish(BND_COLOR_CUPID, o.colorID)
    end)
  

  currentMatch.HomeKitIndex = currentMatch.HomeKitIndex or 0
  currentMatch.AwayKitIndex = currentMatch.AwayKitIndex or 1

  o.im.Subscribe(BND_TOGGLE_HOME_KIT_MESSAGE, function() o:publishHomeKitMessage() end)
  o.im.Subscribe(BND_TOGGLE_AWAY_KIT_MESSAGE, function() o:publishAwayKitMessage() end)

  local homeKitIdx = currentMatch.HomeKitIndex + 1
  local awayKitIdx = currentMatch.AwayKitIndex + 1

  local initialHomeKit = o.homeTeamData[homeKitIdx]
  local initialAwayKit = o.awayTeamData[awayKitIdx]
  
  local initialHomeKit2 = o.homeTeamData[homeKitIdx % 3 + 1] 
  local initialHomeKit3 = o.homeTeamData[(homeKitIdx + 1) % 3 + 1]
  local initialAwayKit2 = o.awayTeamData[awayKitIdx % 3 + 1]
  local initialAwayKit3 = o.awayTeamData[(awayKitIdx + 1) % 3 + 1]

  o.im.Subscribe(bnd2DHomeKit, function() o:publish2DHomeKit(initialHomeKit) end)
  o.im.Subscribe(bnd3DHomeKit, function() o:publish3DHomeKit(initialHomeKit) end)
  o.im.Subscribe(bnd2DAwayKit, function() o:publish2DAwayKit(initialAwayKit) end)
  o.im.Subscribe(bnd3DAwayKit, function() o:publish3DAwayKit(initialAwayKit) end)
  
  o.im.Subscribe(bnd2DHomeKit2, function() o:publish2DHomeKit2(o.homeTeamData[currentMatch.HomeKitIndex == 2 and 2 or 3]) end)
  o.im.Subscribe(bnd2DAwayKit2, function() o:publish2DAwayKit2(o.awayTeamData[currentMatch.AwayKitIndex == 2 and 2 or 3]) end)
  o.im.Subscribe(bnd2DHomeKit3, function() o:publish2DHomeKit3(o.homeTeamData[currentMatch.HomeKitIndex == 1 and 1 or 2]) end)
  o.im.Subscribe(bnd2DAwayKit3, function() o:publish2DAwayKit3(o.awayTeamData[currentMatch.AwayKitIndex == 1 and 1 or 2]) end)

  o.im.Subscribe(bndHomeKitAlpha, function() o:publishHomeKitAlpha() end)
  o.im.Subscribe(bndAwayKitAlpha, function() o:publishAwayKitAlpha() end)
  o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5, TAB6, TAB7 }
  o.im.Subscribe(BND_TAB1, function() end)
  o.im.Subscribe(BND_TAB2, function() end)
  o.im.Subscribe(BND_TAB3, function() end)
  o.im.Subscribe(BND_TAB4, function() end)
  o.im.Subscribe(BND_TAB5, function() end)
  o.im.Subscribe(BND_TAB6, function() end)
  o.im.Subscribe(BND_TAB7, function() end)
  
  o.im.RegisterAction(actHomeKitPrevious, function(actionName) o:changePreviousHomeKit() end)
  o.im.RegisterAction(actHomeKitNext, function(actionName) o:changeNextHomeKit() end)
  o.im.RegisterAction(actAwayKitPrevious, function(actionName) o:changePreviousAwayKit() end)
  o.im.RegisterAction(actAwayKitNext, function(actionName) o:changeNextAwayKit() end)
  o.im.RegisterAction(actAdvance, function(actionName, data)
    if o.services.GameState.IsGamepadControllerConnected() and not o.services.SaveLoadService.GetControllerUsed() then
      o.services.SaveLoadService.SetControllerUsed(true)
      o.services.SaveLoadService.CreateAndSendMessage(8)
      local buttonOk = {
        label = "Confirm",
        clickEvents = { "evt_hide_popup" },
        clickCallback = function() o:_advance() end
      }
      local buttonNo = {
        label = "Cancel",
        clickEvents = { "evt_hide_popup" }
      }
      local popupData = {
        title = "Controller Connection",
        message = "The controller has been detected, do you want to use it as your operating mode? Press Cancel to change to Virtual Button",
        buttons = {buttonNo, buttonOk}
      }
      o.nav.Event(nil, "evt_show_popup", popupData)
    else
      o:_advance()
    end
  end)
  o.im.RegisterAction(actBack, function(actionName) o:_back() end)
  o.im.RegisterAction(actSettings, function(actionName, data) o.nav.Event(nil, "evt_to_settings") end)
  o.im.Subscribe(bndDif, function() o.im.Publish(bndDif, o.currentOptions.difficulty) end)
  
  o:HideSelections()
  o.im.Publish(BND_TAB1, true)
  o.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1 then
      o.im.Publish(BND_TAB1, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2 then
      o.im.Publish(BND_TAB2, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB3 then
      o.im.Publish(BND_TAB3, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB4 then
      o.im.Publish(BND_TAB4, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB5 then
      o.im.Publish(BND_TAB5, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB6 then
      o.im.Publish(BND_TAB6, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB7 then
      o.im.Publish(BND_TAB7, true)
    end
  end)
  return o
end

function KitSelect:HideSelections()
  self.im.Publish(BND_TAB1, false)
  self.im.Publish(BND_TAB2, false)
  self.im.Publish(BND_TAB3, false)
  self.im.Publish(BND_TAB4, false)
  self.im.Publish(BND_TAB5, false)
  self.im.Publish(BND_TAB6, false)
  self.im.Publish(BND_TAB7, false)
end

function KitSelect:publishHomeKitMessage()
  local currentHomeKitIndex = currentMatch.HomeKitIndex
  local toggleHomeMessage = ""
  if currentHomeKitIndex == 0 then
    toggleHomeMessage = "HOME"
  elseif currentHomeKitIndex == 1 then
    toggleHomeMessage = "AWAY"
  elseif currentHomeKitIndex == 3 then
    toggleHomeMessage = "THIRD"
    elseif currentHomeKitIndex == 4 then
    toggleHomeMessage = "FOURTH"
  elseif currentHomeKitIndex == 5 then
    toggleHomeMessage = "FIFTH"
  elseif currentHomeKitIndex == 6 then
    toggleHomeMessage = "SIXTH"
  elseif currentHomeKitIndex == 7 then
    toggleHomeMessage = "SEVENTH"
  elseif currentHomeKitIndex == 8 then
    toggleHomeMessage = "EIGHTH"
  elseif currentHomeKitIndex == 9 then
    toggleHomeMessage = "NINTH"
  elseif currentHomeKitIndex == 10 then
    toggleHomeMessage = "TENTH"
  end
  self.im.Publish(BND_TOGGLE_HOME_KIT_MESSAGE, toggleHomeMessage)
end

function KitSelect:publishAwayKitMessage()
  local currentAwayKitIndex = currentMatch.AwayKitIndex
  local toggleAwayMessage = ""
  if currentAwayKitIndex == 0 then
    toggleAwayMessage = "HOME"
  elseif currentAwayKitIndex == 1 then
    toggleAwayMessage = "AWAY"
  elseif currentAwayKitIndex == 3 then
    toggleAwayMessage = "THIRD"
    elseif currentAwayKitIndex == 4 then
    toggleAwayMessage = "FOURTH"
  elseif currentAwayKitIndex == 5 then
    toggleAwayMessage = "FIFTH"
  elseif currentAwayKitIndex == 6 then
    toggleAwayMessage = "SIXTH"
  elseif currentAwayKitIndex == 7 then
    toggleAwayMessage = "SEVENTH"
  elseif currentAwayKitIndex == 8 then
    toggleAwayMessage = "EIGHTH"
  elseif currentAwayKitIndex == 9 then
    toggleAwayMessage = "NINTH"
  elseif currentAwayKitIndex == 10 then
    toggleAwayMessage = "TENTH"
  end
  self.im.Publish(BND_TOGGLE_AWAY_KIT_MESSAGE, toggleAwayMessage)
end

function KitSelect:changePreviousHomeKit()
  local currentHomeKitIndex = currentMatch.HomeKitIndex
  if currentHomeKitIndex == 0 then
    currentMatch.HomeKitIndex = 10
    self:publish2DHomeKit(self.homeTeamData[10])
    self:publish3DHomeKit(self.homeTeamData[10])
    self:publish2DHomeKit2(self.homeTeamData[9])
    self:publish2DHomeKit3(self.homeTeamData[8])
    self:publish2DHomeKit4(self.homeTeamData[7])
    self:publish2DHomeKit5(self.homeTeamData[6])
    self:publish2DHomeKit6(self.homeTeamData[5])
    self:publish2DHomeKit7(self.homeTeamData[4])
    self:publish2DHomeKit8(self.homeTeamData[3])
    self:publish2DHomeKit9(self.homeTeamData[2])
    self:publish2DHomeKit10(self.homeTeamData[1])
  elseif currentHomeKitIndex == 1 then
    currentMatch.HomeKitIndex = 0 
    self:publish2DHomeKit(self.homeTeamData[1])
    self:publish3DHomeKit(self.homeTeamData[1])
    self:publish2DHomeKit2(self.homeTeamData[10])
    self:publish2DHomeKit3(self.homeTeamData[9])
    self:publish2DHomeKit4(self.homeTeamData[8])
    self:publish2DHomeKit5(self.homeTeamData[7])
    self:publish2DHomeKit6(self.homeTeamData[6])
    self:publish2DHomeKit7(self.homeTeamData[5])
    self:publish2DHomeKit8(self.homeTeamData[4])
    self:publish2DHomeKit9(self.homeTeamData[3])
    self:publish2DHomeKit10(self.homeTeamData[2])
  elseif currentHomeKitIndex == 3 then
    currentMatch.HomeKitIndex = 1
    self:publish2DHomeKit(self.homeTeamData[2])
    self:publish3DHomeKit(self.homeTeamData[2])
    self:publish2DHomeKit2(self.homeTeamData[1])
    self:publish2DHomeKit3(self.homeTeamData[10])
    self:publish2DHomeKit4(self.homeTeamData[9])
    self:publish2DHomeKit5(self.homeTeamData[8])
    self:publish2DHomeKit6(self.homeTeamData[7])
    self:publish2DHomeKit7(self.homeTeamData[6])
    self:publish2DHomeKit8(self.homeTeamData[5])
    self:publish2DHomeKit9(self.homeTeamData[4])
    self:publish2DHomeKit10(self.homeTeamData[3])
  elseif currentHomeKitIndex == 4 then
    currentMatch.HomeKitIndex = 3
    self:publish2DHomeKit(self.homeTeamData[3])
    self:publish3DHomeKit(self.homeTeamData[3])
    self:publish2DHomeKit2(self.homeTeamData[2])
    self:publish2DHomeKit3(self.homeTeamData[1])
    self:publish2DHomeKit4(self.homeTeamData[10])
    self:publish2DHomeKit5(self.homeTeamData[9])
    self:publish2DHomeKit6(self.homeTeamData[8])
    self:publish2DHomeKit7(self.homeTeamData[7])
    self:publish2DHomeKit8(self.homeTeamData[6])
    self:publish2DHomeKit9(self.homeTeamData[5])
    self:publish2DHomeKit10(self.homeTeamData[4])
  elseif currentHomeKitIndex == 5 then
    currentMatch.HomeKitIndex = 4
    self:publish2DHomeKit(self.homeTeamData[4])
    self:publish3DHomeKit(self.homeTeamData[4])
    self:publish2DHomeKit2(self.homeTeamData[3])
    self:publish2DHomeKit3(self.homeTeamData[2])
    self:publish2DHomeKit4(self.homeTeamData[1])
    self:publish2DHomeKit5(self.homeTeamData[10])
    self:publish2DHomeKit6(self.homeTeamData[9])
    self:publish2DHomeKit7(self.homeTeamData[8])
    self:publish2DHomeKit8(self.homeTeamData[7])
    self:publish2DHomeKit9(self.homeTeamData[6])
    self:publish2DHomeKit10(self.homeTeamData[5])
  elseif currentHomeKitIndex == 6 then
    currentMatch.HomeKitIndex = 5
    self:publish2DHomeKit(self.homeTeamData[5])
    self:publish3DHomeKit(self.homeTeamData[5])
    self:publish2DHomeKit2(self.homeTeamData[4])
    self:publish2DHomeKit3(self.homeTeamData[3])
    self:publish2DHomeKit4(self.homeTeamData[2])
    self:publish2DHomeKit5(self.homeTeamData[1])
    self:publish2DHomeKit6(self.homeTeamData[10])
    self:publish2DHomeKit7(self.homeTeamData[9])
    self:publish2DHomeKit8(self.homeTeamData[8])
    self:publish2DHomeKit9(self.homeTeamData[7])
    self:publish2DHomeKit10(self.homeTeamData[6])
    elseif currentHomeKitIndex == 7 then
    currentMatch.HomeKitIndex = 6
    self:publish2DHomeKit(self.homeTeamData[6])
    self:publish3DHomeKit(self.homeTeamData[6])
    self:publish2DHomeKit2(self.homeTeamData[5])
    self:publish2DHomeKit3(self.homeTeamData[4])
    self:publish2DHomeKit4(self.homeTeamData[3])
    self:publish2DHomeKit5(self.homeTeamData[2])
    self:publish2DHomeKit6(self.homeTeamData[1])
    self:publish2DHomeKit7(self.homeTeamData[10])
    self:publish2DHomeKit8(self.homeTeamData[9])
    self:publish2DHomeKit9(self.homeTeamData[8])
    self:publish2DHomeKit10(self.homeTeamData[7])
    elseif currentHomeKitIndex == 8 then
    currentMatch.HomeKitIndex = 7
    self:publish2DHomeKit(self.homeTeamData[7])
    self:publish3DHomeKit(self.homeTeamData[7])
    self:publish2DHomeKit2(self.homeTeamData[6])
    self:publish2DHomeKit3(self.homeTeamData[5])
    self:publish2DHomeKit4(self.homeTeamData[4])
    self:publish2DHomeKit5(self.homeTeamData[3])
    self:publish2DHomeKit6(self.homeTeamData[2])
    self:publish2DHomeKit7(self.homeTeamData[1])
    self:publish2DHomeKit8(self.homeTeamData[10])
    self:publish2DHomeKit9(self.homeTeamData[9])
    self:publish2DHomeKit10(self.homeTeamData[8])
    elseif currentHomeKitIndex == 9 then
    currentMatch.HomeKitIndex = 8
    self:publish2DHomeKit(self.homeTeamData[8])
    self:publish3DHomeKit(self.homeTeamData[8])
    self:publish2DHomeKit2(self.homeTeamData[7])
    self:publish2DHomeKit3(self.homeTeamData[6])
    self:publish2DHomeKit4(self.homeTeamData[5])
    self:publish2DHomeKit5(self.homeTeamData[4])
    self:publish2DHomeKit6(self.homeTeamData[3])
    self:publish2DHomeKit7(self.homeTeamData[2])
    self:publish2DHomeKit8(self.homeTeamData[1])
    self:publish2DHomeKit9(self.homeTeamData[10])
    self:publish2DHomeKit10(self.homeTeamData[9])
    elseif currentHomeKitIndex == 10 then
    currentMatch.HomeKitIndex = 9
    self:publish2DHomeKit(self.homeTeamData[9])
    self:publish3DHomeKit(self.homeTeamData[9])
    self:publish2DHomeKit2(self.homeTeamData[10])
    self:publish2DHomeKit3(self.homeTeamData[8])
    self:publish2DHomeKit4(self.homeTeamData[7])
    self:publish2DHomeKit5(self.homeTeamData[6])
    self:publish2DHomeKit6(self.homeTeamData[5])
    self:publish2DHomeKit7(self.homeTeamData[4])
    self:publish2DHomeKit8(self.homeTeamData[3])
    self:publish2DHomeKit9(self.homeTeamData[2])
    self:publish2DHomeKit10(self.homeTeamData[1])
  end
  self:publishHomeKitMessage()
end

function KitSelect:changeNextHomeKit()
  local currentHomeKitIndex = currentMatch.HomeKitIndex
  if currentHomeKitIndex == 0 then
    currentMatch.HomeKitIndex = 1
    self:publish2DHomeKit(self.homeTeamData[2])
    self:publish3DHomeKit(self.homeTeamData[2])
    self:publish2DHomeKit2(self.homeTeamData[1])
    self:publish2DHomeKit3(self.homeTeamData[3])
    self:publish2DHomeKit4(self.homeTeamData[4])
    self:publish2DHomeKit5(self.homeTeamData[5])
    self:publish2DHomeKit6(self.homeTeamData[6])
    self:publish2DHomeKit7(self.homeTeamData[7])
    self:publish2DHomeKit8(self.homeTeamData[8])
    self:publish2DHomeKit9(self.homeTeamData[9])
    self:publish2DHomeKit10(self.homeTeamData[10])
  elseif currentHomeKitIndex == 1 then
    currentMatch.HomeKitIndex = 3 
    self:publish2DHomeKit(self.homeTeamData[3])
    self:publish3DHomeKit(self.homeTeamData[3])
    self:publish2DHomeKit2(self.homeTeamData[2])
    self:publish2DHomeKit3(self.homeTeamData[1])
    self:publish2DHomeKit4(self.homeTeamData[10])
    self:publish2DHomeKit5(self.homeTeamData[9])
    self:publish2DHomeKit6(self.homeTeamData[8])
    self:publish2DHomeKit7(self.homeTeamData[7])
    self:publish2DHomeKit8(self.homeTeamData[6])
    self:publish2DHomeKit9(self.homeTeamData[5])
    self:publish2DHomeKit10(self.homeTeamData[4])
  elseif currentHomeKitIndex == 3 then
    currentMatch.HomeKitIndex = 4
    self:publish2DHomeKit(self.homeTeamData[4])
    self:publish3DHomeKit(self.homeTeamData[4])
    self:publish2DHomeKit2(self.homeTeamData[3])
    self:publish2DHomeKit3(self.homeTeamData[2])
    self:publish2DHomeKit4(self.homeTeamData[1])
    self:publish2DHomeKit5(self.homeTeamData[10])
    self:publish2DHomeKit6(self.homeTeamData[9])
    self:publish2DHomeKit7(self.homeTeamData[8])
    self:publish2DHomeKit8(self.homeTeamData[7])
    self:publish2DHomeKit9(self.homeTeamData[6])
    self:publish2DHomeKit10(self.homeTeamData[5])
  elseif currentHomeKitIndex == 4 then
    currentMatch.HomeKitIndex = 5
    self:publish2DHomeKit(self.homeTeamData[5])
    self:publish3DHomeKit(self.homeTeamData[5])
    self:publish2DHomeKit2(self.homeTeamData[4])
    self:publish2DHomeKit3(self.homeTeamData[3])
    self:publish2DHomeKit4(self.homeTeamData[2])
    self:publish2DHomeKit5(self.homeTeamData[1])
    self:publish2DHomeKit6(self.homeTeamData[10])
    self:publish2DHomeKit7(self.homeTeamData[9])
    self:publish2DHomeKit8(self.homeTeamData[8])
    self:publish2DHomeKit9(self.homeTeamData[7])
    self:publish2DHomeKit10(self.homeTeamData[6])
  elseif currentHomeKitIndex == 5 then
    currentMatch.HomeKitIndex = 6
    self:publish2DHomeKit(self.homeTeamData[6])
    self:publish3DHomeKit(self.homeTeamData[6])
    self:publish2DHomeKit2(self.homeTeamData[5])
    self:publish2DHomeKit3(self.homeTeamData[4])
    self:publish2DHomeKit4(self.homeTeamData[3])
    self:publish2DHomeKit5(self.homeTeamData[2])
    self:publish2DHomeKit6(self.homeTeamData[1])
    self:publish2DHomeKit6(self.homeTeamData[3])
    self:publish2DHomeKit7(self.homeTeamData[10])
    self:publish2DHomeKit8(self.homeTeamData[9])
    self:publish2DHomeKit9(self.homeTeamData[8])
    self:publish2DHomeKit10(self.homeTeamData[7])
    elseif currentHomeKitIndex == 6 then
    currentMatch.HomeKitIndex = 7
    self:publish2DHomeKit(self.homeTeamData[7])
    self:publish3DHomeKit(self.homeTeamData[7])
    self:publish2DHomeKit2(self.homeTeamData[6])
    self:publish2DHomeKit3(self.homeTeamData[5])
    self:publish2DHomeKit4(self.homeTeamData[4])
    self:publish2DHomeKit5(self.homeTeamData[3])
    self:publish2DHomeKit6(self.homeTeamData[2])
    self:publish2DHomeKit7(self.homeTeamData[1])
    self:publish2DHomeKit8(self.homeTeamData[10])
    self:publish2DHomeKit9(self.homeTeamData[9])
    self:publish2DHomeKit10(self.homeTeamData[8])
    elseif currentHomeKitIndex == 7 then
    currentMatch.HomeKitIndex = 8
    self:publish2DHomeKit(self.homeTeamData[8])
    self:publish3DHomeKit(self.homeTeamData[8])
    self:publish2DHomeKit2(self.homeTeamData[7])
    self:publish2DHomeKit3(self.homeTeamData[6])
    self:publish2DHomeKit4(self.homeTeamData[5])
    self:publish2DHomeKit5(self.homeTeamData[4])
    self:publish2DHomeKit6(self.homeTeamData[3])
    self:publish2DHomeKit7(self.homeTeamData[3])
    self:publish2DHomeKit8(self.homeTeamData[1])
    self:publish2DHomeKit9(self.homeTeamData[10])
    self:publish2DHomeKit10(self.homeTeamData[9])
    elseif currentHomeKitIndex == 8 then
    currentMatch.HomeKitIndex = 9
    self:publish2DHomeKit(self.homeTeamData[9])
    self:publish3DHomeKit(self.homeTeamData[9])
    self:publish2DHomeKit2(self.homeTeamData[8])
    self:publish2DHomeKit3(self.homeTeamData[7])
    self:publish2DHomeKit4(self.homeTeamData[6])
    self:publish2DHomeKit5(self.homeTeamData[5])
    self:publish2DHomeKit6(self.homeTeamData[4])
    self:publish2DHomeKit7(self.homeTeamData[3])
    self:publish2DHomeKit8(self.homeTeamData[2])
    self:publish2DHomeKit9(self.homeTeamData[1])
    self:publish2DHomeKit10(self.homeTeamData[10])
    elseif currentHomeKitIndex == 9 then
    currentMatch.HomeKitIndex = 10
    self:publish2DHomeKit(self.homeTeamData[10])
    self:publish3DHomeKit(self.homeTeamData[10])
    self:publish2DHomeKit2(self.homeTeamData[9])
    self:publish2DHomeKit3(self.homeTeamData[8])
    self:publish2DHomeKit4(self.homeTeamData[7])
    self:publish2DHomeKit5(self.homeTeamData[6])
    self:publish2DHomeKit6(self.homeTeamData[5])
    self:publish2DHomeKit7(self.homeTeamData[4])
    self:publish2DHomeKit8(self.homeTeamData[3])
    self:publish2DHomeKit9(self.homeTeamData[2])
    self:publish2DHomeKit10(self.homeTeamData[1])
  elseif currentHomeKitIndex == 10 then
    currentMatch.HomeKitIndex = 0
    self:publish2DHomeKit(self.homeTeamData[1])
    self:publish3DHomeKit(self.homeTeamData[1])
    self:publish2DHomeKit2(self.homeTeamData[10])
    self:publish2DHomeKit3(self.homeTeamData[9])
    self:publish2DHomeKit4(self.homeTeamData[8])
    self:publish2DHomeKit5(self.homeTeamData[7])
    self:publish2DHomeKit6(self.homeTeamData[6])
    self:publish2DHomeKit7(self.homeTeamData[5])
    self:publish2DHomeKit8(self.homeTeamData[4])
    self:publish2DHomeKit9(self.homeTeamData[3])
    self:publish2DHomeKit10(self.homeTeamData[2])
  end
  self:publishHomeKitMessage()
end

function KitSelect:changePreviousAwayKit()
  local currentAwayKitIndex = currentMatch.AwayKitIndex
  if currentAwayKitIndex == 0 then
    currentMatch.AwayKitIndex = 10
    self:publish2DAwayKit(self.awayTeamData[10])
    self:publish3DAwayKit(self.awayTeamData[10])
    self:publish2DAwayKit2(self.awayTeamData[9])
    self:publish2DAwayKit3(self.awayTeamData[8])
    self:publish2DAwayKit4(self.awayTeamData[7])
    self:publish2DAwayKit5(self.awayTeamData[6])
    self:publish2DAwayKit6(self.awayTeamData[5])
    self:publish2DAwayKit7(self.awayTeamData[4])
    self:publish2DAwayKit9(self.awayTeamData[3])
    self:publish2DAwayKit8(self.awayTeamData[2])
    self:publish2DAwayKit10(self.awayTeamData[1])
  elseif currentAwayKitIndex == 1 then
    currentMatch.AwayKitIndex = 0 
    self:publish2DAwayKit(self.awayTeamData[1])
    self:publish3DAwayKit(self.awayTeamData[1])
    self:publish2DAwayKit2(self.awayTeamData[10])
    self:publish2DAwayKit3(self.awayTeamData[9])
    self:publish2DAwayKit4(self.awayTeamData[8])
    self:publish2DAwayKit5(self.awayTeamData[7])
    self:publish2DAwayKit6(self.awayTeamData[6])
    self:publish2DAwayKit7(self.awayTeamData[5])
    self:publish2DAwayKit8(self.awayTeamData[4])
    self:publish2DAwayKit9(self.awayTeamData[3])
    self:publish2DAwayKit10(self.awayTeamData[2])
  elseif currentAwayKitIndex == 3 then
    currentMatch.AwayKitIndex = 1
    self:publish2DAwayKit(self.awayTeamData[2])
    self:publish3DAwayKit(self.awayTeamData[2])
    self:publish2DAwayKit2(self.awayTeamData[1])
    self:publish2DAwayKit3(self.awayTeamData[10])
    self:publish2DAwayKit4(self.awayTeamData[9])
    self:publish2DAwayKit5(self.awayTeamData[8])
    self:publish2DAwayKit6(self.awayTeamData[7])
    self:publish2DAwayKit7(self.awayTeamData[6])
    self:publish2DAwayKit8(self.awayTeamData[5])
    self:publish2DAwayKit9(self.awayTeamData[4])
    self:publish2DAwayKit10(self.awayTeamData[3])
  elseif currentAwayKitIndex == 4 then
    currentMatch.AwayKitIndex = 3
    self:publish2DAwayKit(self.awayTeamData[3])
    self:publish3DAwayKit(self.awayTeamData[3])
    self:publish2DAwayKit2(self.awayTeamData[2])
    self:publish2DAwayKit3(self.awayTeamData[1])
    self:publish2DAwayKit4(self.awayTeamData[10])
    self:publish2DAwayKit5(self.awayTeamData[9])
    self:publish2DAwayKit6(self.awayTeamData[8])
    self:publish2DAwayKit7(self.awayTeamData[7])
    self:publish2DAwayKit8(self.awayTeamData[6])
    self:publish2DAwayKit9(self.awayTeamData[5])
    self:publish2DAwayKit10(self.awayTeamData[4])
  elseif currentAwayKitIndex == 5 then
    currentMatch.AwayKitIndex = 4
    self:publish2DAwayKit(self.awayTeamData[4])
    self:publish3DAwayKit(self.awayTeamData[4])
    self:publish2DAwayKit2(self.awayTeamData[3])
    self:publish2DAwayKit3(self.awayTeamData[2])
    self:publish2DAwayKit4(self.awayTeamData[1])
    self:publish2DAwayKit5(self.awayTeamData[10])
    self:publish2DAwayKit6(self.awayTeamData[9])
    self:publish2DAwayKit7(self.awayTeamData[8])
    self:publish2DAwayKit8(self.awayTeamData[7])
    self:publish2DAwayKit9(self.awayTeamData[6])
    self:publish2DAwayKit10(self.awayTeamData[5])
  elseif currentAwayKitIndex == 6 then
    currentMatch.AwayKitIndex = 5
    self:publish2DAwayKit(self.awayTeamData[5])
    self:publish3DAwayKit(self.awayTeamData[5])
    self:publish2DAwayKit2(self.awayTeamData[4])
    self:publish2DAwayKit3(self.awayTeamData[3])
    self:publish2DAwayKit4(self.awayTeamData[2])
    self:publish2DAwayKit5(self.awayTeamData[1])
    self:publish2DAwayKit6(self.awayTeamData[10])
    self:publish2DAwayKit7(self.awayTeamData[9])
    self:publish2DAwayKit8(self.awayTeamData[8])
    self:publish2DAwayKit9(self.awayTeamData[7])
    self:publish2DAwayKit10(self.awayTeamData[6])
  elseif currentAwayKitIndex == 7 then
    currentMatch.AwayKitIndex = 6
    self:publish2DAwayKit(self.awayTeamData[6])
    self:publish3DAwayKit(self.awayTeamData[6])
    self:publish2DAwayKit2(self.awayTeamData[5])
    self:publish2DAwayKit3(self.awayTeamData[4])
    self:publish2DAwayKit4(self.awayTeamData[3])
    self:publish2DAwayKit5(self.awayTeamData[2])
    self:publish2DAwayKit6(self.awayTeamData[1])
    self:publish2DAwayKit7(self.awayTeamData[10])
    self:publish2DAwayKit8(self.awayTeamData[9])
    self:publish2DAwayKit9(self.awayTeamData[8])
    self:publish2DAwayKit10(self.awayTeamData[7])
    elseif currentAwayKitIndex == 8 then
    currentMatch.AwayKitIndex = 7
    self:publish2DAwayKit(self.awayTeamData[8])
    self:publish3DAwayKit(self.awayTeamData[8])
    self:publish2DAwayKit2(self.awayTeamData[7])
    self:publish2DAwayKit3(self.awayTeamData[6])
    self:publish2DAwayKit4(self.awayTeamData[5])
    self:publish2DAwayKit5(self.awayTeamData[4])
    self:publish2DAwayKit6(self.awayTeamData[3])
    self:publish2DAwayKit7(self.awayTeamData[2])
    self:publish2DAwayKit8(self.awayTeamData[1])
    self:publish2DAwayKit9(self.awayTeamData[10])
    self:publish2DAwayKit10(self.awayTeamData[9])
    elseif currentAwayKitIndex == 9 then
    currentMatch.AwayKitIndex = 8
    self:publish2DAwayKit(self.awayTeamData[8])
    self:publish3DAwayKit(self.awayTeamData[8])
    self:publish2DAwayKit2(self.awayTeamData[7])
    self:publish2DAwayKit3(self.awayTeamData[6])
    self:publish2DAwayKit4(self.awayTeamData[5])
    self:publish2DAwayKit5(self.awayTeamData[4])
    self:publish2DAwayKit6(self.awayTeamData[3])
    self:publish2DAwayKit7(self.awayTeamData[2])
    self:publish2DAwayKit8(self.awayTeamData[1])
    self:publish2DAwayKit9(self.awayTeamData[10])
    self:publish2DAwayKit10(self.awayTeamData[9])
    elseif currentAwayKitIndex == 10 then
    currentMatch.AwayKitIndex = 9
    self:publish2DAwayKit(self.awayTeamData[9])
    self:publish3DAwayKit(self.awayTeamData[9])
    self:publish2DAwayKit2(self.awayTeamData[8])
    self:publish2DAwayKit3(self.awayTeamData[7])
    self:publish2DAwayKit4(self.awayTeamData[6])
    self:publish2DAwayKit5(self.awayTeamData[5])
    self:publish2DAwayKit6(self.awayTeamData[4])
    self:publish2DAwayKit7(self.awayTeamData[3])
    self:publish2DAwayKit8(self.awayTeamData[2])
    self:publish2DAwayKit9(self.awayTeamData[1])
    self:publish2DAwayKit10(self.awayTeamData[10])
  end
  self:publishAwayKitMessage()
end

function KitSelect:changeNextAwayKit()
  local currentAwayKitIndex = currentMatch.AwayKitIndex
  if currentAwayKitIndex == 0 then
    currentMatch.AwayKitIndex = 1
    self:publish2DAwayKit(self.awayTeamData[2])
    self:publish3DAwayKit(self.awayTeamData[2])
    self:publish2DAwayKit2(self.awayTeamData[1])
    self:publish2DAwayKit3(self.awayTeamData[10])
    self:publish2DAwayKit4(self.awayTeamData[9])
    self:publish2DAwayKit5(self.awayTeamData[8])
    self:publish2DAwayKit6(self.awayTeamData[7])
    self:publish2DAwayKit7(self.awayTeamData[6])
    self:publish2DAwayKit8(self.awayTeamData[5])
    self:publish2DAwayKit9(self.awayTeamData[4])
    self:publish2DAwayKit10(self.awayTeamData[3])
  elseif currentAwayKitIndex == 1 then
    currentMatch.AwayKitIndex = 3 
    self:publish2DAwayKit(self.awayTeamData[3])
    self:publish3DAwayKit(self.awayTeamData[3])
    self:publish2DAwayKit2(self.awayTeamData[2])
    self:publish2DAwayKit3(self.awayTeamData[1])
    self:publish2DAwayKit4(self.awayTeamData[10])
    self:publish2DAwayKit5(self.awayTeamData[9])
    self:publish2DAwayKit6(self.awayTeamData[8])
    self:publish2DAwayKit7(self.awayTeamData[7])
    self:publish2DAwayKit8(self.awayTeamData[6])
    self:publish2DAwayKit9(self.awayTeamData[5])
    self:publish2DAwayKit10(self.awayTeamData[4])
  elseif currentAwayKitIndex == 3 then
    currentMatch.AwayKitIndex = 4
    self:publish2DAwayKit(self.awayTeamData[4])
    self:publish3DAwayKit(self.awayTeamData[4])
    self:publish2DAwayKit2(self.awayTeamData[3])
    self:publish2DAwayKit3(self.awayTeamData[2])
    self:publish2DAwayKit4(self.awayTeamData[1])
    self:publish2DAwayKit5(self.awayTeamData[10])
    self:publish2DAwayKit6(self.awayTeamData[9])
    self:publish2DAwayKit7(self.awayTeamData[8])
    self:publish2DAwayKit8(self.awayTeamData[7])
    self:publish2DAwayKit9(self.awayTeamData[6])
    self:publish2DAwayKit10(self.awayTeamData[5])
  elseif currentAwayKitIndex == 4 then
    currentMatch.AwayKitIndex = 5
    self:publish2DAwayKit(self.awayTeamData[5])
    self:publish3DAwayKit(self.awayTeamData[5])
    self:publish2DAwayKit2(self.awayTeamData[4])
    self:publish2DAwayKit3(self.awayTeamData[3])
    self:publish2DAwayKit4(self.awayTeamData[2])
    self:publish2DAwayKit5(self.awayTeamData[1])
    self:publish2DAwayKit6(self.awayTeamData[10])
    self:publish2DAwayKit7(self.awayTeamData[9])
    self:publish2DAwayKit8(self.awayTeamData[8])
    self:publish2DAwayKit9(self.awayTeamData[7])
    self:publish2DAwayKit10(self.awayTeamData[6])
  elseif currentAwayKitIndex == 5 then
    currentMatch.AwayKitIndex = 6
    self:publish2DAwayKit(self.awayTeamData[6])
    self:publish3DAwayKit(self.awayTeamData[6])
    self:publish2DAwayKit2(self.awayTeamData[5])
    self:publish2DAwayKit3(self.awayTeamData[4])
    self:publish2DAwayKit4(self.awayTeamData[3])
    self:publish2DAwayKit5(self.awayTeamData[2])
    self:publish2DAwayKit6(self.awayTeamData[1])
    self:publish2DAwayKit7(self.awayTeamData[10])
    self:publish2DAwayKit8(self.awayTeamData[9])
    self:publish2DAwayKit9(self.awayTeamData[8])
    self:publish2DAwayKit10(self.awayTeamData[7])
    elseif currentAwayKitIndex == 6 then
    currentMatch.AwayKitIndex = 7
    self:publish2DAwayKit(self.awayTeamData[7])
    self:publish3DAwayKit(self.awayTeamData[7])
    self:publish2DAwayKit2(self.awayTeamData[6])
    self:publish2DAwayKit3(self.awayTeamData[5])
    self:publish2DAwayKit4(self.awayTeamData[4])
    self:publish2DAwayKit5(self.awayTeamData[3])
    self:publish2DAwayKit6(self.awayTeamData[2])
    self:publish2DAwayKit7(self.awayTeamData[1])
    self:publish2DAwayKit8(self.awayTeamData[10])
    self:publish2DAwayKit9(self.awayTeamData[9])
    self:publish2DAwayKit10(self.awayTeamData[8])
    elseif currentAwayKitIndex == 7 then
    currentMatch.AwayKitIndex = 8
    self:publish2DAwayKit(self.awayTeamData[8])
    self:publish3DAwayKit(self.awayTeamData[8])
    self:publish2DAwayKit2(self.awayTeamData[7])
    self:publish2DAwayKit3(self.awayTeamData[5])
    self:publish2DAwayKit4(self.awayTeamData[4])
    self:publish2DAwayKit5(self.awayTeamData[3])
    self:publish2DAwayKit6(self.awayTeamData[2])
    self:publish2DAwayKit7(self.awayTeamData[1])
    self:publish2DAwayKit8(self.awayTeamData[10])
    self:publish2DAwayKit9(self.awayTeamData[9])
    self:publish2DAwayKit10(self.awayTeamData[8])
    elseif currentAwayKitIndex == 8 then
    currentMatch.AwayKitIndex = 9
    self:publish2DAwayKit(self.awayTeamData[9])
    self:publish3DAwayKit(self.awayTeamData[9])
    self:publish2DAwayKit2(self.awayTeamData[8])
    self:publish2DAwayKit3(self.awayTeamData[7])
    self:publish2DAwayKit4(self.awayTeamData[6])
    self:publish2DAwayKit5(self.awayTeamData[5])
    self:publish2DAwayKit6(self.awayTeamData[4])
    self:publish2DAwayKit7(self.awayTeamData[3])
    self:publish2DAwayKit8(self.awayTeamData[2])
    self:publish2DAwayKit9(self.awayTeamData[1])
    self:publish2DAwayKit10(self.awayTeamData[10])
    elseif currentAwayKitIndex == 9 then
    currentMatch.AwayKitIndex = 10
    self:publish2DAwayKit(self.awayTeamData[10])
    self:publish3DAwayKit(self.awayTeamData[10])
    self:publish2DAwayKit2(self.awayTeamData[9])
    self:publish2DAwayKit3(self.awayTeamData[8])
    self:publish2DAwayKit4(self.awayTeamData[7])
    self:publish2DAwayKit5(self.awayTeamData[6])
    self:publish2DAwayKit6(self.awayTeamData[5])
    self:publish2DAwayKit7(self.awayTeamData[4])
    self:publish2DAwayKit8(self.awayTeamData[3])
    self:publish2DAwayKit9(self.awayTeamData[2])
    self:publish2DAwayKit10(self.awayTeamData[1])
  elseif currentAwayKitIndex == 10 then
    currentMatch.AwayKitIndex = 0
    self:publish2DAwayKit(self.awayTeamData[1])
    self:publish3DAwayKit(self.awayTeamData[1])
    self:publish2DAwayKit2(self.awayTeamData[9])
    self:publish2DAwayKit3(self.awayTeamData[8])
    self:publish2DAwayKit4(self.awayTeamData[7])
    self:publish2DAwayKit5(self.awayTeamData[6])
    self:publish2DAwayKit6(self.awayTeamData[5])
    self:publish2DAwayKit8(self.awayTeamData[4])
    self:publish2DAwayKit9(self.awayTeamData[3])
    self:publish2DAwayKit10(self.awayTeamData[2])
  end
  self:publishAwayKitMessage()
end

function KitSelect:checkAdvance()
  if self.services.GameState.GetControllerSide(0) == 0 then
    if not self.services.GameState.IsGamepadControllerConnected() and not self.data.skipFE then
      return false
    else
      return true
    end
  end
  return true
end

function KitSelect:publish2DHomeKit(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit, {name = "$Kits", id = kitId})
end

function KitSelect:publish3DHomeKit(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd3DHomeKit, {name = "$PlayerKits", id = kitId})
end

function KitSelect:publish2DAwayKit(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit, {name = "$Kits", id = kitId})
end

function KitSelect:publish3DAwayKit(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd3DAwayKit, {name = "$PlayerKits", id = kitId})
end

function KitSelect:publish2DHomeKit2(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit2, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit2(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit2, {name = "$Kits", id = kitId})
end  
function KitSelect:publish2DHomeKit3(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit3, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit3(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit3, {name = "$Kits", id = kitId})
end  
function KitSelect:publish2DHomeKit4(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit4, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit4(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit4, {name = "$Kits", id = kitId})
end  
function KitSelect:publish2DHomeKit5(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit5, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit5(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit5, {name = "$Kits", id = kitId})
end  
function KitSelect:publish2DHomeKit6(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit6, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit6(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit6, {name = "$Kits", id = kitId})
end  

function KitSelect:publish2DHomeKit7(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit7, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit7(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit7, {name = "$Kits", id = kitId})
end  

function KitSelect:publish2DHomeKit8(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit8, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit8(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit8, {name = "$Kits", id = kitId})
end  

function KitSelect:publish2DHomeKit9(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit9, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit9(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit9, {name = "$Kits", id = kitId})
end  

function KitSelect:publish2DHomeKit10(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DHomeKit10, {name = "$Kits", id = kitId})
end
function KitSelect:publish2DAwayKit10(kitData)
  local kitId = string.format("%s_%s_%s", kitData.KITTYPE, kitData.TEAMID, kitData.YEAR)
  self.im.Publish(bnd2DAwayKit10, {name = "$Kits", id = kitId})
end

function KitSelect:publishHomeKitAlpha()
  self.im.Publish(bndHomeKitAlpha, self.userSide == self.USER_SIDE.HOME and self.userKitSelectorAlpha or self.opponentKitSelectorAlpha)
end

function KitSelect:publishAwayKitAlpha()
  self.im.Publish(bndAwayKitAlpha, self.userSide == self.USER_SIDE.AWAY and self.userKitSelectorAlpha or self.opponentKitSelectorAlpha)
end

function KitSelect:_doAdvance()
    self.nav.Event(nil, "evt_advance")
end

function KitSelect:_advance()
  self.im.ChangeActionState(actAdvance, self.im.GetActionState("INVALID"))
  self.im.ChangeActionState(actBack, self.im.GetActionState("INVALID"))

  self:_doAdvance()
end

function KitSelect:_back()
  self.nav.Event(nil, "evt_back")
end

function KitSelect:finalize()
  self.im.Unsubscribe(BND_COLOR_CUPID)
  self.im.Unsubscribe(BND_BG_CUP)
  self.im.Unsubscribe("bnd_tour_logo")
  self.im.Unsubscribe(bndHomeTeamData)
  self.im.Unsubscribe(bndAwayTeamData)
  self.im.Unsubscribe(bndAwayReadyLabelVisible)
  self.im.Unsubscribe(bndAwayToggleVisible)
  self.im.Unsubscribe(bndAwaySelectingKitMsgVisible)
  self.im.Unsubscribe(bndHomeReadyLabelVisible)
  self.im.Unsubscribe(bndHomeToggleVisible)
  self.im.Unsubscribe(bndHomeSelectingKitMsgVisible)
  self.im.Unsubscribe(bndLatency)
  self.im.Unsubscribe(bndLatencyVisible)
  self.im.Unsubscribe(bndAwayKitSelectorVisible)
  self.im.Unsubscribe(bndNoOpponentQuestionMarkVisible)
  self.im.Unsubscribe(bndAwayMatchmakingMessageVisible)
  self.im.Unsubscribe(bndAwayTeamSelector)
  self.im.Unsubscribe(bndAwayLoadingVisible)
  self.im.Unsubscribe(bnd3DPlayersVisible)
  self.im.Unsubscribe(bnd2DKitsVisible)
  self.im.Unsubscribe(bnd2DHomeKit)
  self.im.Unsubscribe(bnd3DHomeKit)
  self.im.Unsubscribe(bnd2DAwayKit)
  self.im.Unsubscribe(bnd3DAwayKit)
  self.im.Unsubscribe(bnd2DHomeKit2)
  self.im.Unsubscribe(bnd2DAwayKit2)
  self.im.Unsubscribe(bnd2DHomeKit3)
  self.im.Unsubscribe(bnd2DAwayKit3)
  self.im.Unsubscribe(bndHomeKitAlpha)
  self.im.Unsubscribe(bndAwayKitAlpha)
  self.im.Unsubscribe(bndBackBtnText)
  self.im.UnregisterAction(actAdvance)
  self.im.UnregisterAction(actBack)
  self.im.UnregisterAction(actSettings)
  self.im.Unsubscribe(bndDif)
  self.im.UnregisterAction(actHomeKitPrevious)
  self.im.UnregisterAction(actHomeKitNext)
  self.im.UnregisterAction(actAwayKitPrevious)
  self.im.UnregisterAction(actAwayKitNext)
  self.im.UnregisterAction(ACT_BTN_CLICK)
  self.im.UnregisterDataAction(BND_HOME_KITS_INDEX, ACT_HOME_CHANGE)
  self.im.UnregisterDataAction(BND_AWAY_KITS_INDEX, ACT_AWAY_CHANGE)
  self.im.Unsubscribe(BND_HOME_KITS)
  self.im.Unsubscribe(BND_AWAY_KITS)
  self.im.Unsubscribe(BND_TAB1)
  self.im.Unsubscribe(BND_TAB2)
  self.im.Unsubscribe(BND_TAB3)
  self.im.Unsubscribe(BND_TAB4)
  self.im.Unsubscribe(BND_TAB5)
  self.im.Unsubscribe(BND_TAB6)
  self.im.Unsubscribe(BND_TAB7)
end

return KitSelect