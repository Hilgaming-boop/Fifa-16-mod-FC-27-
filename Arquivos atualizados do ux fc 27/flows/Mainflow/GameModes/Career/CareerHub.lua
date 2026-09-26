-----------------------------------------------
---- THEME BY SEPTIAWAN ----
-----------------------------------------------

local Play = {}
local ACT_SEPTIAWAN_CLICK = "act_septiawan_click"
local ACT_WOMEN_CAREER = "act_women_career"
local BND_SEASONS_1_SELECT_VISIBLE = "bnd_seasons_1_select_visible"
local BND_SEASONS_2_SELECT_VISIBLE = "bnd_seasons_2_select_visible"
local BND_SEASONS_3_SELECT_VISIBLE = "bnd_seasons_3_select_visible"
local BND_SEASONS_4_SELECT_VISIBLE = "bnd_seasons_4_select_visible"
local BND_SEASONS_5_SELECT_VISIBLE = "bnd_seasons_5_select_visible"
local SEASONS_1 = 1
local SEASONS_2 = 2
local SEASONS_3 = 3
local SEASONS_4 = 4
local SEASONS_5 = 5
function Play:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    EventManagerService = o.api("EventManagerService"),
    BrowserService = o.api("BrowserService"),
    MiscService = o.api("MiscService")
  }
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
  o:handleEvent(...)
  end)
  o.buttonsID = { SEASONS_1, SEASONS_2, SEASONS_3, SEASONS_4, SEASONS_5 }
  o:HideSelections()
  o.im.Publish(BND_SEASONS_1_SELECT_VISIBLE, true)
  o.im.Subscribe(BND_SEASONS_1_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe(BND_SEASONS_2_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe(BND_SEASONS_3_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe(BND_SEASONS_4_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe(BND_SEASONS_5_SELECT_VISIBLE, function()
  end)
  o.im.RegisterAction(ACT_WOMEN_CAREER, function(actionName, data)
    o:Notifications()
  end)
  o.im.RegisterAction(ACT_SEPTIAWAN_CLICK, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == SEASONS_1 then
      o.im.Publish(BND_SEASONS_1_SELECT_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == SEASONS_2 then
      o.im.Publish(BND_SEASONS_2_SELECT_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == SEASONS_3 then
      o.im.Publish(BND_SEASONS_3_SELECT_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == SEASONS_4 then
      o.im.Publish(BND_SEASONS_4_SELECT_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == SEASONS_5 then
      o.im.Publish(BND_SEASONS_5_SELECT_VISIBLE, true)
    end
  end)
  return o
end

function Play:HideSelections()
  self.im.Publish(BND_SEASONS_1_SELECT_VISIBLE, false)
  self.im.Publish(BND_SEASONS_2_SELECT_VISIBLE, false)
  self.im.Publish(BND_SEASONS_3_SELECT_VISIBLE, false)
  self.im.Publish(BND_SEASONS_4_SELECT_VISIBLE, false)
  self.im.Publish(BND_SEASONS_5_SELECT_VISIBLE, false)
end

function Play:Notifications()
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Cancel",
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

function Play:finalize()
  self.im.Unsubscribe(BND_SEASONS_1_SELECT_VISIBLE)
  self.im.Unsubscribe(BND_SEASONS_2_SELECT_VISIBLE)
  self.im.Unsubscribe(BND_SEASONS_3_SELECT_VISIBLE)
  self.im.Unsubscribe(BND_SEASONS_4_SELECT_VISIBLE)
  self.im.Unsubscribe(BND_SEASONS_5_SELECT_VISIBLE)
  self.im.UnregisterAction(ACT_SEPTIAWAN_CLICK)
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end
return Play