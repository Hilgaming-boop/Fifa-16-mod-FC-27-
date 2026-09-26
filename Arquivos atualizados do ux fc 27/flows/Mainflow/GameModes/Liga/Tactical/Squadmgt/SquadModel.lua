-- models/SquadModel.lua

local SquadModel = {}

function SquadModel:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self

  o.Config = init.Config
  o.playerById = {}
  o.currentSubSet = 0
  o.numSets = 2
  o.maxSetIndex = 1
  o.lastSheetPlayersHash = nil

  return o
end

local function computePlayersHash(players)
  local hash = 0
  for i, cardId in ipairs(players or {}) do
    hash = hash + (cardId or 0) * i
  end
  return hash
end

function SquadModel:updateSquadData()
  local sheetPlayers = sheets[1].players
  if not sheetPlayers then
    print("Error: sheets[1].players is not available")
    return false
  end

  local currentHash = computePlayersHash(sheetPlayers)
  if self.lastSheetPlayersHash == currentHash then
    return false
  end
  self.lastSheetPlayersHash = currentHash

  self.playerById = {}
  local cachedPlayers = getCachedTeamPlayers(currentSelectedTeamID)
  for i = 1, #sheetPlayers do
    if cachedPlayers[i] then
      self.playerById[cachedPlayers[i].CARD_ID] = cachedPlayers[i]
    end
  end

  local totalSubstitutes = #sheetPlayers - self.Config.PLAYER_RANGES.starting.count
  local firstSetSize = 7
  local otherSetSize = self.Config.PLAYER_RANGES.subres.count
  local remainingSubstitutes = totalSubstitutes - firstSetSize
  self.numSets = remainingSubstitutes <= 0 and 1 or math.max(2, math.ceil(remainingSubstitutes / otherSetSize) + 1)
  self.maxSetIndex = self.numSets - 1

  return true
end

function SquadModel:scrollSubSet(btn)
  if btn == 2 then -- Down
    if self.currentSubSet < self.maxSetIndex then
      self.currentSubSet = self.currentSubSet + 1
      return true
    end
  elseif btn == 1 then -- Up
    if self.currentSubSet > 0 then
      self.currentSubSet = self.currentSubSet - 1
      return true
    end
  end
  return false
end

function SquadModel:getSheetIndex(playerIndex, type)
  local sheetPlayers = sheets[1].players
  if not sheetPlayers then
    return nil
  end

  local range = self.Config.PLAYER_RANGES[type]
  if not range then
    return nil
  end

  if type == "starting" then
    if playerIndex <= range.count then
      return playerIndex
    end
  else -- subres
    local setSize = self.currentSubSet == 0 and 7 or range.count
    if playerIndex <= setSize then
      local sheetIndex = range.start + (self.currentSubSet == 0 and 0 or 7 + (self.currentSubSet - 1) * range.count) + playerIndex - 1
      if sheetIndex <= #sheetPlayers then
        return sheetIndex
      end
    end
  end
  return nil
end

function SquadModel:getPlayerBySheetIndex(sheetIndex)
  local sheetPlayers = sheets[1].players
  if not sheetPlayers or sheetIndex < 1 or sheetIndex > #sheetPlayers then
    return nil
  end
  return self.playerById[sheetPlayers[sheetIndex]]
end

function SquadModel:swapPlayers(sheetIdx1, sheetIdx2)
  local sheetPlayers = sheets[1].players
  if sheetPlayers and sheetIdx1 <= #sheetPlayers and sheetIdx2 <= #sheetPlayers then
    sheetPlayers[sheetIdx1], sheetPlayers[sheetIdx2] = sheetPlayers[sheetIdx2], sheetPlayers[sheetIdx1]
  end
end

function SquadModel:getPlayers()
  return sheets[1].players
end

function SquadModel:getPlayerById(cardId)
  return self.playerById[cardId]
end

function SquadModel:getCurrentSubSet()
  return self.currentSubSet
end

function SquadModel:getNumSets()
  return self.numSets
end

function SquadModel:finalize()
  self.playerById = nil
end

return SquadModel