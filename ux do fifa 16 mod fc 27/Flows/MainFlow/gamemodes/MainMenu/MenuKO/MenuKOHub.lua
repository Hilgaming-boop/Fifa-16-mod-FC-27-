-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuKOHub = {}

function MenuKOHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuKOHub:finalize()
end

return MenuKOHub