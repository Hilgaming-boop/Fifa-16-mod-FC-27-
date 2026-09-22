-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuLMHub = {}

function MenuLMHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuLMHub:finalize()
end

return MenuLMHub