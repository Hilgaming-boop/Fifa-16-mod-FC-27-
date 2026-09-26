local GameControls = (...)
local GameControlsTest = {}
local bndLeftStickData = "bnd_left_stick_data"
local bndDataButtonA = "bnd_button_A_data"
local bndDataButtonB = "bnd_button_B_data"
local bndDataButtonC = "bnd_button_C_data"
local bndDataButtonS = "bnd_button_S_data"
local bndDataButtonPause = "bnd_button_pause_data"
local bndToggleTouchInputLabel = "bnd_touch_input_label"
local actToggleTouchInput = "act_toggle_touch_input"
function GameControlsTest:new(init)
  print("GameControlsTest::new()")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o:bindGameControlsData()
  o:bindTestButtonsData()
  o:disableTouchInput()
  return o
end

function GameControlsTest:bindGameControlsData()
  self.leftStickData = {}
  self:setDefaultDataLeftStick(self.leftStickData)
  self.im.Subscribe(bndLeftStickData, function()
    self.im.Publish(bndLeftStickData, self.leftStickData)
  end
  )
  self.dataButtonA = {}
  self:setDefaultDataButtonA(self.dataButtonA)
  self.im.Subscribe(bndDataButtonA, function()
    self.im.Publish(bndDataButtonA, self.dataButtonA)
  end
  )
  self.dataButtonB = {}
  self:setDefaultDataButtonB(self.dataButtonB)
  self.im.Subscribe(bndDataButtonB, function()
    self.im.Publish(bndDataButtonB, self.dataButtonB)
  end
  )
  self.dataButtonC = {}
  self:setDefaultDataButtonC(self.dataButtonC)
  self.im.Subscribe(bndDataButtonC, function()
    self.im.Publish(bndDataButtonC, self.dataButtonC)
  end
  )
  self.dataButtonS = {}
  self:setDefaultDataButtonS(self.dataButtonS)
  self.im.Subscribe(bndDataButtonS, function()
    self.im.Publish(bndDataButtonS, self.dataButtonS)
  end
  )
  self.dataButtonPause = {}
  self:setDefaultDataButtonPause(self.dataButtonPause)
  self.im.Subscribe(bndDataButtonPause, function()
    self.im.Publish(bndDataButtonPause, self.dataButtonPause)
  end
  )
end

function GameControlsTest:setDefaultDataLeftStick(data)
  data = data or {}
  data.isVisible = true
  data.isPressed = false
  data.centerX = 189
  data.centerY = 432
  data.radius = 100
  data.knobOffsetX = 0
  data.knobOffsetY = 0
end

function GameControlsTest:setDefaultDataButtonA(data)
  data = data or {}
  data.isVisible = true
  data.isPressed = false
  data.centerX = 874
  data.centerY = 555
  data.radius = 68
  data.label = "PASSING"
end

function GameControlsTest:setDefaultDataButtonB(data)
  data = data or {}
  data.isVisible = true
  data.isPressed = false
  data.centerX = 1051
  data.centerY = 378
  data.radius = 68
  data.label = "SHOOTING"
end

function GameControlsTest:setDefaultDataButtonC(data)
  data = data or {}
  data.isVisible = true
  data.isPressed = false
  data.centerX = 913
  data.centerY = 417
  data.radius = 68
  data.label = "CALL 2ND DEFENDER"
end

function GameControlsTest:setDefaultDataButtonS(data)
  data = data or {}
  data.isVisible = true
  data.isPressed = false
  data.centerX = 1035
  data.centerY = 539
  data.radius = 84
  data.label = "SPRINT & TACKLE"
end

function GameControlsTest:setDefaultDataButtonPause(data)
  data = data or {}
  data.isVisible = true
  data.isPressed = false
  data.centerX = 1051
  data.centerY = 100
  data.radius = 34
end

function GameControlsTest:bindTestButtonsData()
  self.im.Subscribe(bndToggleTouchInputLabel, function()
    self.im.Publish(bndToggleTouchInputLabel, self.toggleTouchInputLabel)
  end
  )
  self.im.RegisterAction(actToggleTouchInput, function()
    self:toggleTouchInput()
  end
  )
end

function GameControlsTest:toggleTouchInput()
  if self.isTouchInputEnabled == false then
    self:enableTouchInput()
  else
    self:disableTouchInput()
  end
end

function GameControlsTest:enableTouchInput()
  self.isTouchInputEnabled = true
  self.gameControlsViewModel = GameControls:new({
    im = self.im,
    api = self.api,
    nav = self.nav,
    locl = self.loc
  })
  self:updateToggleTouchInputLabel("Disable Touch Input")
end

function GameControlsTest:disableTouchInput()
  self.isTouchInputEnabled = false
  self:destroyGameControlsViewModel()
  self:updateToggleTouchInputLabel("Enable Touch Input")
end

function GameControlsTest:destroyGameControlsViewModel()
  if self.gameControlsViewModel ~= nil then
    self.gameControlsViewModel:finalize()
    self.gameControlsViewModel = nil
  end
end

function GameControlsTest:updateToggleTouchInputLabel(label)
  self.toggleTouchInputLabel = label
  self.im.Refresh(bndToggleTouchInputLabel)
end

function GameControlsTest:finalize()
  print("GameControlsTest::finalize()")
  self:destroyGameControlsViewModel()
  self.im.Unsubscribe(bndLeftStickData)
  self.im.Unsubscribe(bndDataButtonA)
  self.im.Unsubscribe(bndDataButtonB)
  self.im.Unsubscribe(bndDataButtonC)
  self.im.Unsubscribe(bndDataButtonS)
  self.im.Unsubscribe(bndDataButtonPause)
  self.im.Unsubscribe(bndToggleTouchInputLabel)
  self.im.UnregisterAction(actToggleTouchInput)
end

return GameControlsTest
