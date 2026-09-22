-------------------------------------------------------
-- By Rober FL  --
-------------------------------------------------------


local PlayModesHub = {}

function PlayModesHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
  }

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
  local random2 = math.random(6)
  local random3 = math.random(7)
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

function PlayModesHub:finalize()
end

return PlayModesHub