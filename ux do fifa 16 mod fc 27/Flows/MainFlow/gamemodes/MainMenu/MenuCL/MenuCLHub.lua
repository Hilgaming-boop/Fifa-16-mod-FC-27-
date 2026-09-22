-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuCLHub = {}

function MenuCLHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuCLHub:finalize()
end

return MenuCLHub