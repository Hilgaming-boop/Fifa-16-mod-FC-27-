-------------------------------------------
-- Rober FL --
-------------------------------------------

local MenuUCLHub = {}

function MenuUCLHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  return o
end

function MenuUCLHub:finalize()
end

return MenuUCLHub