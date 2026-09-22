--- Remod By Inisial A ---

local BestTeamsTour = {}
local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local BND_TAB4_VISIBLE = "bnd_tab4_visible"
local BND_TAB5_VISIBLE = "bnd_tab5_visible"
local BND_TAB6_VISIBLE = "bnd_tab6_visible"
local BND_TAB7_VISIBLE = "bnd_tab7_visible"
local BND_TAB8_VISIBLE = "bnd_tab8_visible"
local BND_TAB9_VISIBLE = "bnd_tab9_visible"
local BND_TAB10_VISIBLE = "bnd_tab10_visible"
local ACT_A = "act_a"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5
local TAB6 = 6
local TAB7 = 7
local TAB8 = 8
local TAB9 = 9
local TAB10 = 10

function BestTeamsTour:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {}

    o.team1 = {
      name = "$Crest",
      id = 5
    }
    o.team2 = {
      name = "$Crest",
      id = 11
    }
    o.team3 = {
      name = "$Crest",
      id = 21
    }
    o.team4 = {
      name = "$Crest",
      id = 22
    }
    o.team5 = {
      name = "$Crest",
      id = 241
    }
    o.team6 = {
      name = "$Crest",
      id = 243
    }
    o.team7 = {
      name = "$Crest",
      id = 73
    }
    o.team8 = {
      name = "$Crest",
      id = 45
    }
    o.team9 = {
      name = "$Crest",
      id = 155602
    }
    o.team10 = {
      name = "$Crest",
      id = 111510
    }    
  o.im.Subscribe("bnd_team1", function()
    o.im.Publish("bnd_team1", o.team1)
  end)
  o.im.Subscribe("bnd_team2", function()
    o.im.Publish("bnd_team2", o.team2)
  end)
  o.im.Subscribe("bnd_team3", function()
    o.im.Publish("bnd_team3", o.team3)
  end)
  o.im.Subscribe("bnd_team4", function()
    o.im.Publish("bnd_team4", o.team4)
  end)
  o.im.Subscribe("bnd_team5", function()
    o.im.Publish("bnd_team5", o.team5)
  end)
  o.im.Subscribe("bnd_team6", function()
    o.im.Publish("bnd_team6", o.team6)
  end)
  o.im.Subscribe("bnd_team7", function()
    o.im.Publish("bnd_team7", o.team7)
  end)
  o.im.Subscribe("bnd_team8", function()
    o.im.Publish("bnd_team8", o.team8)
  end)
  o.im.Subscribe("bnd_team9", function()
    o.im.Publish("bnd_team9", o.team9)
  end)
  o.im.Subscribe("bnd_team10", function()
    o.im.Publish("bnd_team10", o.team10)
  end)  
  
  o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5, TAB6, TAB7, TAB8, TAB9, TAB10 }
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
  o.im.Subscribe(BND_TAB6_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB7_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB8_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB9_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB10_VISIBLE, function()
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
    elseif o.buttonsID[data.buttonID + 1] == TAB6 then
      o.im.Publish(BND_TAB6_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB7 then
      o.im.Publish(BND_TAB7_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB8 then
      o.im.Publish(BND_TAB8_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB9 then
      o.im.Publish(BND_TAB9_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB10 then
      o.im.Publish(BND_TAB10_VISIBLE, true)
    end
  end)

  return o
end

function BestTeamsTour:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)
  self.im.Publish(BND_TAB3_VISIBLE, false)
  self.im.Publish(BND_TAB4_VISIBLE, false)
  self.im.Publish(BND_TAB5_VISIBLE, false)
  self.im.Publish(BND_TAB6_VISIBLE, false)
  self.im.Publish(BND_TAB7_VISIBLE, false)
  self.im.Publish(BND_TAB8_VISIBLE, false)
  self.im.Publish(BND_TAB9_VISIBLE, false)
  self.im.Publish(BND_TAB10_VISIBLE, false)  
end

function BestTeamsTour:finalize()
  self.im.Unsubscribe(BND_TAB1_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_VISIBLE)
  self.im.Unsubscribe(BND_TAB3_VISIBLE)
  self.im.Unsubscribe(BND_TAB4_VISIBLE)
  self.im.Unsubscribe(BND_TAB5_VISIBLE)
  self.im.Unsubscribe(BND_TAB6_VISIBLE)
  self.im.Unsubscribe(BND_TAB7_VISIBLE)
  self.im.Unsubscribe(BND_TAB8_VISIBLE)
  self.im.Unsubscribe(BND_TAB9_VISIBLE)
  self.im.Unsubscribe(BND_TAB10_VISIBLE)  
  self.im.UnregisterAction(ACT_A)  
end

return BestTeamsTour
