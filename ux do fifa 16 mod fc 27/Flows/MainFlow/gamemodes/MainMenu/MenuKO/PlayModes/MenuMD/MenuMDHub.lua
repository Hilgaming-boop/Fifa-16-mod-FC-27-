-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuMDHub = {}

function MenuMDHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuMDHub:finalize()
end

return MenuMDHub