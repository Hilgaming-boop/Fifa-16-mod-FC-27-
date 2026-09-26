-- Modified By MVNPROD Youtube Channel --
local MenuHub = {}
function MenuHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
  }
  o.player3d = {
    name = "$PlayersPMH",
    id = 0
  }
  math.randomseed(os.clock() * 1543 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(5)
  o.im.Subscribe("bnd_player3d", function()
    o.player3d.id = random2
    o.im.Publish("bnd_player3d", o.player3d)
  end)
  return o
end
function MenuHub:finalize()
  self.im.Unsubscribe("bnd_player3d")
end
return MenuHub
-- Thanks : All Modders
-- @mvnprodreal - Remain Be Creative --