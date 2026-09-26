-- Squad.lua
-- !@ DavunPes

local Config, SquadModel, SelectionModel, UIModel, ConfigModel = ...

local Squad = {}

function Squad:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self

  -- Initialize services
  o.services = {
    settingsService = o.api("SettingsService")
  }
  o.currentOptions = o.services.settingsService.GetCurrentOptions()

  -- Initialize models
  o.configModel = ConfigModel:new({ Config = Config })
  o.squadModel = SquadModel:new({ Config = Config })
  o.selectionModel = SelectionModel:new({ Config = Config })
  o.uiModel = UIModel:new({ Config = Config, im = o.im })

  -- Bind actions and subscriptions
  o:setupBindings()
  o:setupActions()

  -- Initialize squad data
  o.squadModel:updateSquadData()
  o.uiModel:markDirty()

  return o
end

function Squad:setupBindings()
  local bindings = {
    { prefix = "bnd_head", count = 8, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_name", count = 8, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_pos", count = 8, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_ovr", count = 8, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_starting", count = 11, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_selected", count = 11, callback = function() self.uiModel:publishSelectionBindings(self.squadModel, self.selectionModel) end },
    { prefix = "bnd_selectedsubres", count = 8, callback = function() self.uiModel:publishSelectionBindings(self.squadModel, self.selectionModel) end },
    { prefix = "bnd_startingname", count = 11, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_startingpos", count = 11, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_startingovr", count = 11, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_posTop", count = 11, callback = function() self.uiModel:publishPanel(self.squadModel) end },
    { prefix = "bnd_posLeft", count = 11, callback = function() self.uiModel:publishPanel(self.squadModel) end }
  }

  for _, binding in ipairs(bindings) do
    for i = 1, binding.count do
      self.im.Subscribe(binding.prefix .. i, binding.callback)
    end
  end

  self.im.Subscribe("bnd_match_label", function() self.uiModel:publishMatchLabel() end)
  self.im.Subscribe("bnd_selectedhead1", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_selectedhead2", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_playername1", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_playernationality1", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_playerposition1", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_playername2", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_playernationality2", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_playerposition2", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_playerrating1", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_selectedhea", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_playerrating2", function() self.uiModel:publishSelectedHead(self.squadModel, self.selectionModel) end)
  self.im.Subscribe("bnd_rowpos", function() self.uiModel:publishPanel(self.squadModel) end)
  self.im.Subscribe("bnd_rowheight", function() self.uiModel:publishPanel(self.squadModel) end)
end

function Squad:setupActions()
  for i = 1, self.configModel:getPlayerRanges().starting.count do
    self.im.RegisterAction("act_player" .. i, function(actionName, data)
      self:onSelect(i, "starting")
    end)
  end
  for i = 1, self.configModel:getPlayerRanges().subres.count do
    self.im.RegisterAction("act_subres" .. i, function(actionName, data)
      self:onSelect(i, "subres")
    end)
  end
  for i = 1, 2 do
    self.im.RegisterAction("act_scrollbtn" .. i, function(actionName, data)
      self:scrollBtn(i)
    end)
  end
end

function Squad:scrollBtn(btn)
  local changed = self.squadModel:scrollSubSet(btn)
  if changed then
    self.uiModel:markDirty()
    self.uiModel:publishPanel(self.squadModel)
    self.uiModel:publishSelectionBindings(self.squadModel, self.selectionModel)
  end
end

function Squad:onSelect(playerIndex, type)
  local sheetIndex = self.squadModel:getSheetIndex(playerIndex, type)
  if not sheetIndex then
    print("Error: Invalid sheet index for type=" .. type .. ", playerIndex=" .. playerIndex)
    return
  end

  local player = self.squadModel:getPlayerBySheetIndex(sheetIndex)
  if not player then
    print("Error: No player at sheetIndex=" .. sheetIndex)
    return
  end

  local swapOccurred = self.selectionModel:selectPlayer(playerIndex, type, sheetIndex)
  if swapOccurred then
    local sel1, sel2 = self.selectionModel:getSelectedPlayers()
    self.squadModel:swapPlayers(sel1.sheetIndex, sel2.sheetIndex)
    self.selectionModel:clearSelections()
    self.squadModel:updateSquadData()
    self.uiModel:markDirty()
    self.uiModel:publishPanel(self.squadModel)
  end
  self.uiModel:publishSelectionBindings(self.squadModel, self.selectionModel)
end

function Squad:finalize()
  self.squadModel:finalize()
  self.selectionModel:finalize()
  self.uiModel:finalize()
  self.configModel = nil
end

return Squad