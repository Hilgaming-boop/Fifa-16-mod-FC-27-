
local MusicHub = {}

function MusicHub:new(init)
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

function MusicHub:openBrowser()
  if self.services.MiscService.IsInternetConnectionAvailable() then
    local url = "https://open.spotify.com/playlist/37i9dQZF1DX3wF1YbAXxkA"
    local temp = math.random(1, 100000)
    local link = url.."?temp="..temp
    self.services.BrowserService.SetHomePage(link)
    isInitializeNotice = false
    self.nav.Event(nil, "evt_open_browser")
  end
  end

function MusicHub:finalize()
end

return MusicHub