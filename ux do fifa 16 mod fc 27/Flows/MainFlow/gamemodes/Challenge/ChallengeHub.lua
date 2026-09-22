-------------------------------------------
-- MOD BY LAOSIJI --
-------------------------------------------

local ChallengeHub = {}

local BND_LIVE_TILE_ICONS = "bnd_live_tile_icons"
local BND_LIVE_TILE_SEASON = "bnd_live_tile_season"
local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local BND_TAB4_VISIBLE = "bnd_tab4_visible"
local BND_TAB5_VISIBLE = "bnd_tab5_visible"
local ACT_A = "act_a"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5
currentMode = 3

function ChallengeHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {}
  
  o.modelplayer = {
    name = "$_ModelPlayer",
    id = 0
  }
  math.randomseed(os.clock() * 1357 + os.time())
  local currentTime = os.date("%H") + 0
  local random1 = math.random(7)
  o.im.Subscribe("bnd_ModelPlayer", function()
    o.modelplayer.id = random1
    o.im.Publish("bnd_ModelPlayer", o.modelplayer)
  end)

  o.im.Subscribe(BND_LIVE_TILE_ICONS, function()
    o:BND_LIVE_TILE_ICONS()
  end)

  function ChallengeHub:BND_LIVE_TILE_ICONS()
    local dataToInsert =
    {
      headline = { "" },
      description = "",
      images = {
        {
          name = "$_Challenge",
          id = 10
        }
        
      }
    }
    self.im.Publish(BND_LIVE_TILE_ICONS, dataToInsert)
  end
  
  o.im.Subscribe(BND_LIVE_TILE_SEASON, function()
    o:BND_LIVE_TILE_SEASON()
  end)

  function ChallengeHub:BND_LIVE_TILE_SEASON()
    local dataToInsert =
    {
      headline = { "" },
      description = "",
      images = {
        {
          name = "$_Challenge",
          id = 11
        }
        
      }
    }
    self.im.Publish(BND_LIVE_TILE_SEASON, dataToInsert)
  end
  
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
  o.im.RegisterAction(ACT_A, function(actionName, data)
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

function ChallengeHub:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)
  self.im.Publish(BND_TAB3_VISIBLE, false)
  self.im.Publish(BND_TAB4_VISIBLE, false)
  self.im.Publish(BND_TAB5_VISIBLE, false)
end

function ChallengeHub:finalize()
  self.im.Unsubscribe(BND_LIVE_TILE_ICONS)
  self.im.Unsubscribe(BND_LIVE_TILE_SEASON)
  self.im.Unsubscribe(BND_TAB1_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_VISIBLE)
  self.im.Unsubscribe(BND_TAB3_VISIBLE)
  self.im.Unsubscribe(BND_TAB4_VISIBLE)
  self.im.Unsubscribe(BND_TAB5_VISIBLE)
  self.im.UnregisterAction(ACT_A)  
  
end

return ChallengeHub
