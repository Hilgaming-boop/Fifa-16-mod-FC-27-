local SaveHub = {}

function SaveHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    BrowserService = o.api("BrowserService"),
    MiscService = o.api("MiscService")
  }

  if not isInitializeNotice then
    o:openBrowser()
  end
  
  return o
end

function SaveHub:openBrowser()
    local url = "http://127.0.0.1:3184"
    local temp = math.random(1, 100000)

    local link = url.."/save/" .. davunSave
    print(link)
    self.services.BrowserService.SetHomePage(link)
    isInitializeNotice = false
    self.nav.Event(nil, "evt_open_browser")
  end

function SaveHub:finalize()
end

return SaveHub
