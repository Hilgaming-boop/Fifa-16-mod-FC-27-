-- models/UIModel.lua

local UIModel = {}

-- Lookup table for rowpos and rowheight
local setConfig = {
  [5] = { rowpos = {125, 150, 175, 200, 225}, rowheight = 25 },
  [4] = { rowpos = {125, 155, 185, 215}, rowheight = 37.5 },
  [3] = { rowpos = {125, 165, 205}, rowheight = 50 },
  [2] = { rowpos = {125, 175}, rowheight = 75 }
}

function UIModel:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self

  o.Config = init.Config
  o.im = init.im
  o.isDirty = true

  return o
end

function UIModel:markDirty()
  self.isDirty = true
end

function UIModel:publishPanel(squadModel)
  local sheetPlayers = squadModel:getPlayers()
  if not sheetPlayers or not self.isDirty then
    return
  end

  local numSets = squadModel:getNumSets()
  local currentSubSet = squadModel:getCurrentSubSet()
  local config = setConfig[numSets] or setConfig[2]
  self.im.Publish("bnd_rowpos", config.rowpos[currentSubSet + 1] or config.rowpos[1])
  self.im.Publish("bnd_rowheight", config.rowheight)

  local setSize = currentSubSet == 0 and 7 or self.Config.PLAYER_RANGES.subres.count
  local subStartIndex = self.Config.PLAYER_RANGES.subres.start + (currentSubSet == 0 and 0 or 7 + (currentSubSet - 1) * self.Config.PLAYER_RANGES.subres.count)
  for i = 1, self.Config.PLAYER_RANGES.subres.count do
    if i <= setSize and subStartIndex + i - 1 <= #sheetPlayers then
      local sheetIndex = subStartIndex + i - 1
      local cardId = sheetPlayers[sheetIndex]
      local p = squadModel:getPlayerById(cardId)
      if p then
        self.im.Publish("bnd_head" .. i, { name = "$Head", id = cardId })
        self.im.Publish("bnd_name" .. i, p.playerName)
        self.im.Publish("bnd_pos" .. i, p.position)
        self.im.Publish("bnd_ovr" .. i, p.rating)
      else
        self.im.Publish("bnd_head" .. i, { name = "$Head", id = nil })
        self.im.Publish("bnd_name" .. i, nil)
        self.im.Publish("bnd_pos" .. i, nil)
        self.im.Publish("bnd_ovr" .. i, nil)
      end
    else
      self.im.Publish("bnd_head" .. i, { name = "$Head", id = nil })
      self.im.Publish("bnd_name" .. i, nil)
      self.im.Publish("bnd_pos" .. i, nil)
      self.im.Publish("bnd_ovr" .. i, nil)
    end
  end

  for i = 1, self.Config.PLAYER_RANGES.starting.count do
    local cardId = sheetPlayers[i]
    local p = squadModel:getPlayerById(cardId)
    if p then
      self.im.Publish("bnd_starting" .. i, { name = "$Head", id = cardId })
      self.im.Publish("bnd_startingname" .. i, p.playerName)
      self.im.Publish("bnd_startingpos" .. i, p.position)
      self.im.Publish("bnd_startingovr" .. i, p.rating)
    else
      self.im.Publish("bnd_starting" .. i, { name = "$Head", id = nil })
      self.im.Publish("bnd_startingname" .. i, nil)
      self.im.Publish("bnd_startingpos" .. i, nil)
      self.im.Publish("bnd_startingovr" .. i, nil)
    end
  end

  local formation = self.Config.FORMATION_POSITIONS["formation" .. tostring(sheets[1].formationid)]
  for i = 1, #formation do
    self.im.Publish("bnd_posTop" .. i, formation[i].top)
    self.im.Publish("bnd_posLeft" .. i, formation[i].left)
  end

  self.isDirty = false
end

function UIModel:publishSelectionBindings(squadModel, selectionModel)
  local sheetPlayers = squadModel:getPlayers()
  if not sheetPlayers then
    return
  end

  local currentSubSet = squadModel:getCurrentSubSet()
  local setSize = currentSubSet == 0 and 7 or self.Config.PLAYER_RANGES.subres.count
  local subStartIndex = self.Config.PLAYER_RANGES.subres.start + (currentSubSet == 0 and 0 or 7 + (currentSubSet - 1) * self.Config.PLAYER_RANGES.subres.count)

  for i = 1, self.Config.PLAYER_RANGES.starting.count do
    self.im.Publish("bnd_selected" .. i, selectionModel:isPlayerSelected(i))
  end

  for i = 1, self.Config.PLAYER_RANGES.subres.count do
    local isSelected = false
    if i <= setSize and subStartIndex + i - 1 <= #sheetPlayers then
      local currentSheetIndex = subStartIndex + i - 1
      isSelected = selectionModel:isPlayerSelected(currentSheetIndex)
    end
    self.im.Publish("bnd_selectedsubres" .. i, isSelected)
  end

  local sel1, sel2 = selectionModel:getSelectedPlayers()
  for i = 1, 2 do
    local sel = i == 1 and sel1 or sel2
    if sel then
      local cardId = sheetPlayers[sel.sheetIndex]
      local player = squadModel:getPlayerById(cardId)
      if player then
        self.im.Publish("bnd_selectedhead" .. i, { name = "$Head", id = cardId })
        self.im.Publish("bnd_playername" .. i, player.playerName)
        self.im.Publish("bnd_playernationality" .. i, { name = "$Flag128x128", id = player.nationalityID })
        self.im.Publish("bnd_playerposition" .. i, player.position)
        self.im.Publish("bnd_playerrating" .. i, player.rating)
      else
        self.im.Publish("bnd_selectedhead" .. i, { name = "$Head", id = nil })
        self.im.Publish("bnd_playername" .. i, nil)
        self.im.Publish("bnd_playernationality" .. i, nil)
        self.im.Publish("bnd_playerposition" .. i, nil)
        self.im.Publish("bnd_playerrating" .. i, nil)
      end
    else
      self.im.Publish("bnd_selectedhead" .. i, { name = "$Head", id = nil })
      self.im.Publish("bnd_playername" .. i, nil)
      self.im.Publish("bnd_playernationality" .. i, nil)
      self.im.Publish("bnd_playerposition" .. i, nil)
      self.im.Publish("bnd_playerrating" .. i, nil)
    end
  end
end

function UIModel:publishSelectedHead(squadModel, selectionModel)
  local sheetPlayers = squadModel:getPlayers()
  if not sheetPlayers then
    return
  end

  local sel1, sel2 = selectionModel:getSelectedPlayers()
  for i = 1, 2 do
    local sel = i == 1 and sel1 or sel2
    if sel then
      local cardId = sheetPlayers[sel.sheetIndex]
      local player = squadModel:getPlayerById(cardId)
      if player then
        self.im.Publish("bnd_selectedhead" .. i, { name = "$Head", id = cardId })
        self.im.Publish("bnd_playername" .. i, player.playerName)
        self.im.Publish("bnd_playernationality" .. i, { name = "$Flag128x128", id = player.nationalityID })
        self.im.Publish("bnd_playerposition" .. i, player.position)
        self.im.Publish("bnd_playerrating" .. i, player.rating)
      else
        self.im.Publish("bnd_selectedhead" .. i, { name = "$Head", id = nil })
        self.im.Publish("bnd_playername" .. i, nil)
        self.im.Publish("bnd_playernationality" .. i, nil)
        self.im.Publish("bnd_playerposition" .. i, nil)
        self.im.Publish("bnd_playerrating" .. i, nil)
      end
    else
      self.im.Publish("bnd_selectedhead" .. i, { name = "$Head", id = nil })
      self.im.Publish("bnd_playername" .. i, nil)
      self.im.Publish("bnd_playernationality" .. i, nil)
      self.im.Publish("bnd_playerposition" .. i, nil)
      self.im.Publish("bnd_playerrating" .. i, nil)
    end
  end

  for i = 1, self.Config.PLAYER_RANGES.starting.count do
    self.im.Publish("bnd_selected" .. i, selectionModel:isPlayerSelected(i))
  end

  local currentSubSet = squadModel:getCurrentSubSet()
  local setSize = currentSubSet == 0 and 7 or self.Config.PLAYER_RANGES.subres.count
  local subStartIndex = self.Config.PLAYER_RANGES.subres.start + (currentSubSet == 0 and 0 or 7 + (currentSubSet - 1) * self.Config.PLAYER_RANGES.subres.count)
  for i = 1, self.Config.PLAYER_RANGES.subres.count do
    local isSelected = false
    if i <= setSize and subStartIndex + i - 1 <= #sheetPlayers then
      local currentSheetIndex = subStartIndex + i - 1
      isSelected = selectionModel:isPlayerSelected(currentSheetIndex)
    end
    self.im.Publish("bnd_selectedsubres" .. i, isSelected)
  end
end

function UIModel:publishMatchLabel()
  -- Implement if needed
end

function UIModel:finalize()
  -- No cleanup needed
end

return UIModel