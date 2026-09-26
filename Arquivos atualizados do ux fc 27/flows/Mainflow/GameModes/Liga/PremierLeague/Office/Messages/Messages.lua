-- New Custom Menu By MVNPROD --
local MensHub = {}
local bndBackgroundCareer = "bnd_background_career"
local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local BND_TAB4_VISIBLE = "bnd_tab4_visible"
local BND_TAB5_VISIBLE = "bnd_tab5_visible"
local ACT_MVNPROD = "act_mvnprod"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5
function MensHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    EventManagerService = o.api("EventManagerService"),
    BrowserService = o.api("BrowserService"),
    MiscService = o.api("MiscService")
  }
  o.player3d = {
    name = "$",
    id = 0
  }
  math.randomseed(os.clock() * 1543 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(10)
  
  o.im.Subscribe("bnd_player3d", function()
    o.player3d.id = random2
    o.im.Publish("bnd_player3d", o.player3d)
  end)
  o.im.Subscribe(bndBackgroundCareer, function()  
    o.im.Publish(bndBackgroundCareer, {name = "$BackgroundCareer", id = IDLeague})   
  end)
  
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
  o:handleEvent(...)
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
  o.im.Subscribe(BND_TAB5_VISIBLE, function()
  end)
  o:HideSelections()
  o.im.Publish(BND_TAB1_VISIBLE, true)
  o.im.RegisterAction(ACT_MVNPROD, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1 then
      o.im.Publish(BND_TAB1_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2 then
      o.im.Publish(BND_TAB2_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB3 then
      o.im.Publish(BND_TAB3_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB4 then
      o.im.Publish(BND_TAB4_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB5 then
      o.im.Publish(BND_TAB5_VISIBLE, true)
    end
  end)
  return o
end
function MensHub:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)
  self.im.Publish(BND_TAB3_VISIBLE, false)
  self.im.Publish(BND_TAB4_VISIBLE, false)
  self.im.Publish(BND_TAB5_VISIBLE, false)
end
function MensHub:finalize()
  self.im.Unsubscribe(BND_TAB1_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_VISIBLE)
  self.im.Unsubscribe(BND_TAB3_VISIBLE)
  self.im.Unsubscribe(BND_TAB4_VISIBLE)
  self.im.Unsubscribe(BND_TAB5_VISIBLE)
  self.im.UnregisterAction(ACT_MVNPROD)
  self.im.Unsubscribe("bnd_player3d")
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end
return MensHub
-- New Custom Menu By MVNPROD --