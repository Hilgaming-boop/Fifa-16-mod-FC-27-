-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuCMHub = {}

function MenuCMHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuCMHub:finalize()
end

return MenuCMHub