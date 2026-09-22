-------------------------------------------------------
-- By Rober FL  --
-- Remod Inisial A --
-------------------------------------------------------


local MainMenuHub = {}

function MainMenuHub:updateDevDisplay()

    local devId = (GlobalDevSettings and GlobalDevSettings.devId) or 1
    local devName = (GlobalDevSettings and GlobalDevSettings.devName) or " MOUNTSA "

    self.im.Publish("bnd_avatar_dev", { name = "$Dev", id = devId })
    self.im.Publish("bnd_name_dev", devName)
end
function MainMenuHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
  }
    o.im.Subscribe("bnd_avatar_dev", function() o:updateDevDisplay() end)
    o.im.Subscribe("bnd_name_dev", function() o:updateDevDisplay() end)  

  o.Menubg = {
    name = "$_Bg_MenuHome",
    id = 0
  }
  o.modeInfobg = {
    name = "$_ModeInfo",
    id = 0
  }
  math.randomseed(os.clock() * 1357 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(1)
  local random3 = math.random(1)
  o.im.Subscribe("bnd_Menu_bg", function()
    o.Menubg.id = random3
    o.im.Publish("bnd_Menu_bg", o.Menubg)
  end)
  o.im.Subscribe("bnd_modeInfo_bg", function()
    o.modeInfobg.id = random2
    o.im.Publish("bnd_modeInfo_bg", o.modeInfobg)
  end)
  
  return o
end

function MainMenuHub:finalize()
    self.im.Unsubscribe("bnd_avatar_dev")
    self.im.Unsubscribe("bnd_name_dev")
end

return MainMenuHub