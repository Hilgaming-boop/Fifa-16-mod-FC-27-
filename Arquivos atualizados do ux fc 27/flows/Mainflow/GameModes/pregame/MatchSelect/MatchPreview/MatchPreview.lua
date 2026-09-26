-- Modified By ALPHATRIX Youtube Channel --
local MatchSelect = {}
local eventmanager, PregameManager, CommonNavVars, TableUtil = ...
local EventTypes = eventmanager.FE.FIFA.EventTypes
local BND_LOGO_TIM_HOME = "bnd_logo_tim_home"
local BND_LOGO_TIM_AWAY = "bnd_logo_tim_away"
local BND_MAN_TIM_HOME = "bnd_man_tim_home"
local BND_MAN_TIM_AWAY = "bnd_man_tim_away"
local BND_NAMA_TIM_HOME = "bnd_nama_tim_home"
local BND_NAMA_TIM_AWAY = "bnd_nama_tim_away"
local BND_NAMA_STADION = "bnd_nama_stadion"
local BND_INFO_MATCH = "bnd_info_match"
local ACT_ADVANCE = "act_advance"

local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local BND_TAB4_VISIBLE = "bnd_tab4_visible"
local ACT_BTN_CLICK = "act_btn_click"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4

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
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.CurrentOptions = o.services.SettingsService.GetCurrentOptions()
  o.im.Subscribe(BND_MAN_TIM_HOME, function()
    o.im.Publish(BND_MAN_TIM_HOME, {
      name = "$PlayersPMH",
      id = string.format("%d", o.services.gameSetup.GetHomeAssetId())
    })
  end)
  o.im.Subscribe(BND_MAN_TIM_AWAY, function()
    o.im.Publish(BND_MAN_TIM_AWAY, {
      name = "$PlayersPMA",
      id = string.format("%d", o.services.gameSetup.GetAwayAssetId())
    })
  end)
  o.im.Subscribe(BND_LOGO_TIM_HOME, function()
    o.im.Publish(BND_LOGO_TIM_HOME, {
      name = "$Crest",
      id = string.format("%d", o.services.gameSetup.GetHomeAssetId())
    })
  end)
  o.im.Subscribe(BND_LOGO_TIM_AWAY, function()
    o.im.Publish(BND_LOGO_TIM_AWAY, {
      name = "$Crest",
      id = string.format("%d", o.services.gameSetup.GetAwayAssetId())
    })
  end)
  o.im.Subscribe(BND_NAMA_TIM_HOME, function()
    o.im.Publish(BND_NAMA_TIM_HOME, o.TeamsData[1].teamName)
  end)
  o.im.Subscribe(BND_NAMA_TIM_AWAY, function()
    o.im.Publish(BND_NAMA_TIM_AWAY, o.TeamsData[2].teamName)
  end)
  o.im.Subscribe(BND_NAMA_STADION, function()
    o.im.Publish(BND_NAMA_STADION, o.CurrentOptions.stadium)
  end)
  o.im.Subscribe("bnd_difficulty", function()
    o.im.Publish("bnd_difficulty", o.CurrentOptions.difficulty)
  end)
  o.im.RegisterAction(ACT_ADVANCE, function(actionName)
    o:PlayMatch()
  end)
o.im.Subscribe(BND_INFO_MATCH, function()
  -- Ambil kondisi cuaca dari CurrentOptions
  local weather = o.CurrentOptions.weather or "Sunny"

  -- Buat jam pertandingan acak
  local hour = math.random(1, 12)
  local minute = math.random(0, 59)
  local ampm = math.random(1, 2) == 1 and "AM" or "PM"
  local formattedTime = string.format("%02d:%02d %s", hour, minute, ampm)

  -- Gabungkan info match
  local state = "Stadium : " .. o.CurrentOptions.stadium ..
                "          Length : 4 - Half Length" ..
                "          Difficulty : " .. o.CurrentOptions.difficulty ..
                "          Condition: " .. weather .. " | " .. formattedTime

  o.im.Publish(BND_INFO_MATCH, state)
end)
  o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5 }
  o.im.Subscribe(BND_TAB1_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB2_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB3_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB4_VISIBLE, function()
  end)
  
  function MatchSelect:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)
  self.im.Publish(BND_TAB3_VISIBLE, false)
  self.im.Publish(BND_TAB4_VISIBLE, false)
end
  
  o:HideSelections()
  o.im.Publish(BND_TAB1_VISIBLE, true)
  o.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1 then
      o.im.Publish(BND_TAB1_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2 then
      o.im.Publish(BND_TAB2_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB3 then
      o.im.Publish(BND_TAB3_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB4 then
      o.im.Publish(BND_TAB4_VISIBLE, true)
    end
  end)

  return o
end

function MatchSelect:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)
  self.im.Publish(BND_TAB3_VISIBLE, false)
  self.im.Publish(BND_TAB4_VISIBLE, false)
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
  self.im.Unsubscribe(BND_INFO_MATCH)
  self.im.UnregisterAction(ACT_ADVANCE)
  self.im.Unsubscribe(bndDif)
  self.im.Unsubscribe(BND_TAB1_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_VISIBLE)
  self.im.Unsubscribe(BND_TAB3_VISIBLE)
  self.im.Unsubscribe(BND_TAB4_VISIBLE)
  self.im.UnregisterAction(ACT_BTN_CLICK)
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end
return MatchSelect
-- Thanks : All Modders
-- @mvnprodreal - Remain Be Creative --