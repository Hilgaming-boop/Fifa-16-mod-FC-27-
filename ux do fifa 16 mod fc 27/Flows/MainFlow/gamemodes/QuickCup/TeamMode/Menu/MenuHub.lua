-------------------------------------------------------
-- By inisial A  --
-------------------------------------------------------


local MenuHub = {}

function MenuHub:updateDevDisplay()

    local devId = (GlobalDevSettings and GlobalDevSettings.devId) or 1
    local devName = (GlobalDevSettings and GlobalDevSettings.devName) or " MOUNTSA "

    self.im.Publish("bnd_avatar_dev", { name = "$Dev", id = devId })
    self.im.Publish("bnd_name_dev", devName)
end
function MenuHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {}
 
    o.im.Subscribe("bnd_avatar_dev", function() o:updateDevDisplay() end)
    o.im.Subscribe("bnd_name_dev", function() o:updateDevDisplay() end)  
 
local maxtrophy = 17
math.randomseed(os.time() + os.clock() * 1000)
o.trophy = { name = "$TrophyRandom", id = 0 }
o.im.Subscribe("bnd_trophy", function()
  o.trophy.id = math.random(1, maxtrophy)
  o.im.Publish("bnd_trophy", o.trophy)
end)   
  
  return o
end

function MenuHub:finalize()
    self.im.Unsubscribe("bnd_avatar_dev")
    self.im.Unsubscribe("bnd_name_dev")
end

return MenuHub