-- models/ConfigModel.lua

local ConfigModel = {}

function ConfigModel:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self

  o.Config = init.Config

  return o
end

function ConfigModel:getPlayerRanges()
  return self.Config.PLAYER_RANGES
end

function ConfigModel:getFormation()
  return self.Config.FORMATION_POSITIONS.formation1 -- Extend to support dynamic selection
end

return ConfigModel