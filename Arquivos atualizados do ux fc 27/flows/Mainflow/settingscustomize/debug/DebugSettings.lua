local debugSettings = {}

local TableUtil = (...)

---------------------------------------------------------------------------------------------------
local BND_DEBUG_SETTINGS_LIST_DATA = "bnd_debug_settings_list_data"
---------------------------------------------------------------------------------------------------

local bndRenderResolution = "bnd_render_resolution"
local bndCrowdModeDefault = "bnd_crowd_mode_default"
local bndCrowdModeReplay = "bnd_crowd_mode_replay"
local bndCrowdModeNis = "bnd_crowd_mode_nis"
local bndCrowdModeHighlight = "bnd_crowd_mode_highlight"
local bndCrowdModeSetpiece = "bnd_crowd_mode_setpiece"

local actChangeRenderResolution = "act_change_render_resolution"
local actChangeCrowdModeDefault = "act_change_crowd_mode_default"
local actChangeCrowdModeReplay = "act_change_crowd_mode_replay"
local actChangeCrowdModeNis = "act_change_crowd_mode_nis"
local actChangeCrowdModeHighlight = "act_change_crowd_mode_highlight"
local actChangeCrowdModeSetpiece = "act_change_crowd_mode_setpiece"

local RENDER_RESOLUTION_INDEX = 1
local CROWD_MODE_INDEX_DEFAULT = 2
local CROWD_MODE_INDEX_REPLAY = 3
local CROWD_MODE_INDEX_NIS = 4
local CROWD_MODE_INDEX_HIGHLIGHT = 5
local CROWD_MODE_INDEX_SETPIECE = 6

local CrowdModeDefaultServiceIndex = 0
local CrowdModeReplayServiceIndex = 1
local CrowdModeNisServiceIndex = 2
local CrowdModeHighlightServiceIndex = 3
local CrowdModeSetpieceServiceIndex = 4

function debugSettings:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    settingsService = o.api("SettingsService"),
    gameStateService = o.api("GameStateService")
  }
  o:initValues()
  o.im.RegisterAction(actChangeRenderResolution, function(actionName, data)
    o:onRenderResolutionChanged(data)
  end)
  o.im.RegisterAction(actChangeCrowdModeDefault, function(actionName, data)
    o:onCrowdModeDefaultChanged(data)
  end)
  o.im.RegisterAction(actChangeCrowdModeReplay, function(actionName, data)
    o:onCrowdModeReplayChanged(data)
  end)
  o.im.RegisterAction(actChangeCrowdModeNis, function(actionName, data)
    o:onCrowdModeNisChanged(data)
  end)
  o.im.RegisterAction(actChangeCrowdModeHighlight, function(actionName, data)
    o:onCrowdModeHighlightChanged(data)
  end)
  o.im.RegisterAction(actChangeCrowdModeSetpiece, function(actionName, data)
    o:onCrowdModeSetpieceChanged(data)
  end)

  --------------------------------------------------------------------------------
  o.im.Subscribe(BND_DEBUG_SETTINGS_LIST_DATA, function()
    o:publishDebugSettingsListData()
  end)
  --------------------------------------------------------------------------------

  o.im.Subscribe(bndRenderResolution, function()
    o:publishRenderResolution()
  end)
  o.im.Subscribe(bndCrowdModeDefault, function()
    o:publishCrowdModeDefault()
  end)
  o.im.Subscribe(bndCrowdModeReplay, function()
    o:publishCrowdModeReplay()
  end)
  o.im.Subscribe(bndCrowdModeNis, function()
    o:publishCrowdModeNis()
  end)
  o.im.Subscribe(bndCrowdModeHighlight, function()
    o:publishCrowdModeHighlight()
  end)
  o.im.Subscribe(bndCrowdModeSetpiece, function()
    o:publishCrowdModeSetpiece()
  end)
  
  return o
end

function debugSettings:initValues()
  self.customizationOptions = self.services.settingsService.GetDebugSetting()
  self:initRenderResolutionData(self.customizationOptions[RENDER_RESOLUTION_INDEX].data)
  self:initCrowdModeDefaultData(self.customizationOptions[CROWD_MODE_INDEX_DEFAULT].data)
  self:initCrowdModeReplayData(self.customizationOptions[CROWD_MODE_INDEX_REPLAY].data)
  self:initCrowdModeNisData(self.customizationOptions[CROWD_MODE_INDEX_NIS].data)
  self:initCrowdModeHighlightData(self.customizationOptions[CROWD_MODE_INDEX_HIGHLIGHT].data)
  self:initCrowdModeSetpieceData(self.customizationOptions[CROWD_MODE_INDEX_SETPIECE].data)
end
function debugSettings:initRenderResolutionData(renderResolutionData)
  local renderResolutiondata = {
      currentValue = renderResolutionData.currentValue,
      data = {
        { value=0, name="Default" },
        { value=1, name="Low" },
        { value=2, name="Standard" },
        { value=3, name="High" },
        { value=4, name="Ultra" }
        
      }
  }
  self.renderResolutionData = renderResolutiondata
  self.renderResolutionData.label="Render Resolution"
  self.renderResolutionData.rowChangeAction = "act_change_render_resolution"
  self:setSelectedIndex(self.renderResolutionData)
end

function debugSettings:initCrowdModeDefaultData(crowdModeDefaultData)
  local crowdModeDefaultdata = {
      currentValue = crowdModeDefaultData.currentValue,
      data = {
        { value=0, name="Animated" },
        { value=1, name="Static" },
        { value=2, name="Off" }
      }
  }
  self.crowdModeDefaultData = crowdModeDefaultdata
  self.crowdModeDefaultData.label="Crowd Default"
  self.crowdModeDefaultData.rowChangeAction = "act_change_crowd_mode_default"
  self:setSelectedIndex(self.crowdModeDefaultData)
end

function debugSettings:initCrowdModeReplayData(crowdModeReplayData)
  local crowdModeReplaydata = {
      currentValue = crowdModeReplayData.currentValue,
      data = {
        { value=0, name="Animated" },
        { value=1, name="Static" },
        { value=2, name="Off" }
      }
  }
  self.crowdModeReplayData = crowdModeReplaydata
  self.crowdModeReplayData.label="Crowd Replay"
  self.crowdModeReplayData.rowChangeAction = "act_change_crowd_mode_replay"
  self:setSelectedIndex(self.crowdModeReplayData)
end

function debugSettings:initCrowdModeNisData(crowdModeNisData)
  local crowdModeNisdata = {
      currentValue = crowdModeNisData.currentValue,
      data = {
        { value=0, name="Animated" },
        { value=1, name="Static" },
        { value=2, name="Off" }
      }
  }
  self.crowdModeNisData = crowdModeNisdata
  self.crowdModeNisData.label="Crowd Nis"
  self.crowdModeNisData.rowChangeAction = "act_change_crowd_mode_nis"
  self:setSelectedIndex(self.crowdModeNisData)
end

function debugSettings:initCrowdModeHighlightData(crowdModeHighlightData)
  local crowdModeHighlightdata = {
      currentValue = crowdModeHighlightData.currentValue,
      data = {
        { value=0, name="Animated" },
        { value=1, name="Static" },
        { value=2, name="Off" }
      }
  }
  self.crowdModeHighlightData = crowdModeHighlightdata
  self.crowdModeHighlightData.label="crowd Highlight"
  self.crowdModeHighlightData.rowChangeAction = "act_change_crowd_mode_highlight"
  self:setSelectedIndex(self.crowdModeHighlightData)
end

function debugSettings:initCrowdModeSetpieceData(crowdModeSetpieceData)
  local crowdModeSetpiecedata = {
      currentValue = crowdModeSetpieceData.currentValue,
      data = {
        { value=0, name="Animated" },
        { value=1, name="Static" },
        { value=2, name="Off" }
      }
  }
  self.crowdModeSetpieceData = crowdModeSetpiecedata
  self.crowdModeSetpieceData.label="Crowd Setpiece"
  self.crowdModeSetpieceData.rowChangeAction = "act_change_crowd_mode_setpiece"
  self:setSelectedIndex(self.crowdModeSetpieceData)
end

function debugSettings:setSelectedIndex(optionData)
  local selectedIndex = self:GetValueIndex(optionData.data, optionData.currentValue)
  optionData.index = selectedIndex
end

function debugSettings:publishRenderResolution()
  self.im.Publish(bndRenderResolution, self.renderResolutionData)
end
function debugSettings:publishCrowdModeDefault()
  self.im.Publish(bndCrowdModeDefault, self.crowdModeDataDefault)
end
function debugSettings:publishCrowdModeReplay()
  self.im.Publish(bndCrowdModeReplay, self.crowdModeReplayData)
end
function debugSettings:publishCrowdModeNis()
  self.im.Publish(bndCrowdModeNis, self.crowdModeNisData)
end
function debugSettings:publishCrowdModeHighlight()
  self.im.Publish(bndCrowdModeHighlight, self.crowdModeHighlightData)
end
function debugSettings:publishCrowdModeSetpiece()
  self.im.Publish(bndCrowdModeSetpiece, self.crowdModeSetpieceData)
end

function debugSettings:onRenderResolutionChanged(newOption)
  local newValue = newOption.value
  if self.renderResolutionData.currentValue ~= newValue then
    self.renderResolutionData.currentValue = newValue
    self.services.settingsService.SaveRenderResolutionValue(newValue)
  end
end
function debugSettings:onCrowdModeDefaultChanged(newOption)
  local newValue = newOption.value
  if self.crowdModeDefaultData.currentValue ~= newValue then
    self.crowdModeDefaultData.currentValue = newValue
    self.services.settingsService.SaveCrowdModeValue(newValue, CrowdModeDefaultServiceIndex)
  end
end
function debugSettings:onCrowdModeReplayChanged(newOption)
  local newValue = newOption.value
  if self.crowdModeReplayData.currentValue ~= newValue then
    self.crowdModeReplayData.currentValue = newValue
    self.services.settingsService.SaveCrowdModeValue(newValue, CrowdModeReplayServiceIndex)
  end
end
function debugSettings:onCrowdModeNisChanged(newOption)
  local newValue = newOption.value
  if self.crowdModeNisData.currentValue ~= newValue then
    self.crowdModeNisData.currentValue = newValue
    self.services.settingsService.SaveCrowdModeValue(newValue, CrowdModeNisServiceIndex)
  end
end
function debugSettings:onCrowdModeHighlightChanged(newOption)
  local newValue = newOption.value
  if self.crowdModeHighlightData.currentValue ~= newValue then
    self.crowdModeHighlightData.currentValue = newValue
    self.services.settingsService.SaveCrowdModeValue(newValue, CrowdModeHighlightServiceIndex)
  end
end
function debugSettings:onCrowdModeSetpieceChanged(newOption)
  local newValue = newOption.value
  if self.crowdModeSetpieceData.currentValue ~= newValue then
    self.crowdModeSetpieceData.currentValue = newValue
    self.services.settingsService.SaveCrowdModeValue(newValue, CrowdModeSetpieceServiceIndex)
  end
end

function debugSettings:publishDebugSettingsListData()
  local dirtyIndices = {}
  local nRows = 10
  for i = 0, nRows do
    table.insert(dirtyIndices, i)
  end
  local dataList = {
    dirty = dirtyIndices,
    data = {
      {
        data = self.renderResolutionData
      },
      {
        data = self.crowdModeDefaultData
      },
      {
        data = self.crowdModeReplayData
      },
      {
        data = self.crowdModeNisData
      },
      {
        data = self.crowdModeHighlightData
      },
      {
        data = self.crowdModeSetpieceData
      }
    }
  }
  self.im.Publish(BND_DEBUG_SETTINGS_LIST_DATA, dataList)
end

function debugSettings:GetValueIndex(data, value)
  local i = 1
  while i <= #data and data[i].value ~= value do
    i = i + 1
  end
  return i - 1
end

function debugSettings:finalize()

  self.im.Unsubscribe(BND_DEBUG_SETTINGS_LIST_DATA)

  self.im.Unsubscribe(bndRenderResolution)
  self.im.Unsubscribe(bndCrowdModeDefault)
  self.im.Unsubscribe(bndCrowdModeReplay)
  self.im.Unsubscribe(bndCrowdModeNis)
  self.im.Unsubscribe(bndCrowdModeHighlight)
  self.im.Unsubscribe(bndCrowdModeSetpiece)
  
  self.im.UnregisterAction(actChangeRenderResolution)
  self.im.UnregisterAction(actChangeCrowdModeDefault)
  self.im.UnregisterAction(actChangeCrowdModeReplay)
  self.im.UnregisterAction(actChangeCrowdModeNis)
  self.im.UnregisterAction(actChangeCrowdModeHighlight)
  self.im.UnregisterAction(actChangeCrowdModeSetpiece)
end

return debugSettings