local Save = ...
local Newgame = {}
local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"

local bndMatchList = "bnd_match_list"

local ACT_ADVANCE = "act_advance"
local ACT_NEWGAME = "act_newgame"
local ACT_LOADGAME = "act_loadgame"
local ACT_SELECTED = "act_selected"

local TAB1 = 1
local TAB2 = 2

local savedata = Save or {}

function Newgame:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self

  o.services = {
    settingsService = o.api("SettingsService"),
    EventManagerService = o.api("EventManagerService"),
    SquadManagementService = o.api("SquadMgtService")
  }

  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
  o:handleEvent(...)
  end)


  o.im.Subscribe("bnd_matchday_label", function()
    o:publishLabel()
  end)

  o.im.RegisterAction(ACT_NEWGAME, function(_, data)
    o:newGame()
  end)

  o.im.RegisterAction(ACT_LOADGAME, function(_, data)
    o:loadGame()
  end)

  o.buttonsID = { TAB1, TAB2 }
  o.im.Subscribe(BND_TAB1_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB2_VISIBLE, function()
  end)
  o:HideSelections()
  o.im.Publish(BND_TAB1_VISIBLE, true)
  o.im.RegisterAction(ACT_SELECTED, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1 then
      o.im.Publish(BND_TAB1_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2 then
      o.im.Publish(BND_TAB2_VISIBLE, true)
    end
  end)
  return o
end

function Newgame:publishLabel()
  local text = ""
  if not LigaGrouping[ligaId] then
    text = "NEW \nCAREER"
  else
    text = "CONTINUE \nCAREER"
  end
  self.im.Publish("bnd_matchday_label", text)
end

function Newgame:newGame()
  savemode = 0
  if LigaGrouping[ligaId] then
    TeamList = TeamList
    self.nav.Event(nil, "evt_load")
  else
    self.nav.Event(nil, "evt_new")
  end
end

function Newgame:loadGame()
  if not savedata.TeamList then
    self:noSave()
  else
    savemode = 1
    self.nav.Event(nil, "evt_load")
  end
end

function Newgame:noSave()
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {
      "evt_hide_popup",
      "evt_back"
    }
  }
  local popupData = {
    title = "INFO",
    message = "You have no saved games",
    buttons = {buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function Newgame:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)

end

function Newgame:finalize()
  self.im.Unsubscribe(BND_TAB1_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_VISIBLE)
  self.im.UnregisterAction(ACT_SELECTED)

  self.im.UnregisterAction(ACT_NEWGAME)
  self.im.UnregisterAction(ACT_LOADGAME)
  self.im.Unsubscribe("bnd_matchday_label")
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end

return Newgame