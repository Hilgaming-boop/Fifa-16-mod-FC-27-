local eventmanager = (...)
local facts = {}
print("loaded facts LUA")
local bndMatchFacts = "bnd_match_facts"
local EventTypes = eventmanager.FE.FIFA.EventTypes
function facts:new(init)
  print("New Function MatchFactsLua")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    EventManService = o.api("EventManagerService"),
    matchInfo = o.api("MatchInfoService")
  }
  o.handlerId = o.services.EventManService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)
  o.im.Subscribe(bndMatchFacts, function()
    o:publishFactsList()
  end)
  return o
end
function facts:publishFactsList()
  local listData = self.services.matchInfo.GetMatchFacts(true)
  local o = listData.homeData
  for i, v in ipairs(o) do
    v.data.valueRight = listData.awayData[i].data.value
  end
  self.im.Publish(bndMatchFacts, o)
end
function facts:handleEvent(eventType, data)
  print(eventType)
  if eventType == EventTypes.OnBackPressed then
    print("facts:handleEvent OnBackPressed")
    self.nav.Event(nil, "evt_advance")
  end
end
function facts:finalize()
  self.im.Unsubscribe(bndMatchFacts)
  self.services.EventManService.UnregisterHandler(self.handlerId)
end
return facts
