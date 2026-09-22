-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuBTHub = {}

function MenuBTHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuBTHub:finalize()
end

return MenuBTHub