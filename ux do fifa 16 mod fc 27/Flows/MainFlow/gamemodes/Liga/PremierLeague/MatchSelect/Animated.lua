local Animated = {}
local TIME_DELAY = 0.5
local START_TIME = 0.2

function Animated:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self

  o.services = {
    ScreenInfoService = o.api("ScreenInfoService"),
    QuickEventsService = o.api("QuickEventsService"),
    AudioService = o.api("AudioService")
  }

  o.count = 0  -- Start counting from 0
  o.maxCount = 7  -- Count up to 7
  o.startTime = START_TIME
  o.isSwiping = o.services.QuickEventsService.ShouldQuickEventDisplaySwipeText()

  -- subscribe animations for all counts (0-6)
  for i = 0, 6 do
    local anim = "bnd_animate_count" .. i
    o.im.Subscribe(anim, function() o.im.Publish(anim, false) end)
  end

  o.services.ScreenInfoService.SetScreenName("Animated")

  return o
end

function Animated:update(elapsedTime)
  self.startTime = self.startTime + elapsedTime
  if self.startTime >= TIME_DELAY then
    self.startTime = self.startTime - TIME_DELAY

    if self.count <= self.maxCount or (self.count == self.maxCount and self.isSwiping) then
      local isLast = (self.count == self.maxCount and not self.isSwiping)
      local soundId = isLast and "" or ""

      self.services.AudioService.PlaySoundById(soundId, "root", {
        soundId = "",
        type = "",
        state = { name = "VALID", val = 0 }
      })

      self:_publishCount()
    else
      self.nav.Event(nil, "")
    end
  end
end

function Animated:_publishCount()
  -- hide all panels (1-7)
  for i = 1, 7 do
    self.im.Publish("bnd_panel" .. i .. "_visible", false)
  end
  -- reset all animations (0-6)
  for i = 0, 6 do
    self.im.Publish("bnd_animate_count" .. i, false)
  end

  local panelId = self.count + 1  -- Since count starts at 0
  if panelId >= 1 and panelId <= 7 then
    self.im.Publish("bnd_panel" .. panelId .. "_visible", true)
    self.im.Publish("bnd_animate_count" .. (panelId - 1), true)
  end

  self.count = self.count + 1  -- Increment count
end

function Animated:finalize()
  for i = 0, 6 do
    self.im.Unsubscribe("bnd_animate_count" .. i)
  end

  self.services.ScreenInfoService.UnsetScreenName("Animated")
end

return Animated