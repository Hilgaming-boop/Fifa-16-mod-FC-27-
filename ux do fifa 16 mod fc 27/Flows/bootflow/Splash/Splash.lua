local Splash = {}
function Splash:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
return Splash