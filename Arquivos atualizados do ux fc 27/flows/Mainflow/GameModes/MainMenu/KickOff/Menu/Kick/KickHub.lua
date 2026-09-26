local KickHub = {}

function KickHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {}
  
  
  ------------------------------------------------------------------------------------------


  ------------------------------------------------------------------------------------------

  return o
end




function KickHub:finalize()

end

return KickHub