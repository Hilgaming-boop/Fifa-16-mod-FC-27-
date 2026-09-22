-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuRMHub = {}

function MenuRMHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuRMHub:finalize()
end

return MenuRMHub