-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuFCHub = {}

function MenuFCHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuFCHub:finalize()
end

return MenuFCHub