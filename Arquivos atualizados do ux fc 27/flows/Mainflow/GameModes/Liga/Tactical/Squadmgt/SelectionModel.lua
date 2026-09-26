-- models/SelectionModel.lua

local SelectionModel = {}

function SelectionModel:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self

  o.Config = init.Config
  o.selectedPlayers = {}

  return o
end

function SelectionModel:selectPlayer(playerIndex, type, sheetIndex)
  print("SelectionModel:selectPlayer: type=" .. type .. ", playerIndex=" .. playerIndex .. ", sheetIndex=" .. sheetIndex)

  local isSelected = false
  for i, sel in ipairs(self.selectedPlayers) do
    if sel.sheetIndex == sheetIndex then
      isSelected = true
      table.remove(self.selectedPlayers, i)
      print("Deselected player: sheetIndex=" .. sheetIndex)
      break
    end
  end

  if not isSelected then
    if #self.selectedPlayers >= 2 then
      table.remove(self.selectedPlayers, 1)
    end
    table.insert(self.selectedPlayers, { index = playerIndex, type = type, sheetIndex = sheetIndex })
    print("Selected player: sheetIndex=" .. sheetIndex)
  end

  if #self.selectedPlayers == 2 then
    print("Swap triggered: sheetIdx1=" .. self.selectedPlayers[1].sheetIndex .. ", sheetIdx2=" .. self.selectedPlayers[2].sheetIndex)
    return true
  end
  return false
end

function SelectionModel:getSelectedPlayers()
  return self.selectedPlayers[1], self.selectedPlayers[2]
end

function SelectionModel:clearSelections()
  self.selectedPlayers = {}
end

function SelectionModel:isPlayerSelected(sheetIndex)
  for _, sel in ipairs(self.selectedPlayers) do
    if sel.sheetIndex == sheetIndex then
      return true
    end
  end
  return false
end

function SelectionModel:finalize()
  self.selectedPlayers = nil
end

return SelectionModel