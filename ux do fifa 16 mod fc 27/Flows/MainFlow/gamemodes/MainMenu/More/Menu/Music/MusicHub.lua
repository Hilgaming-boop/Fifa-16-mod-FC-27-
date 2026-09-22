
local MusicHub = {}
local actToMountsainfoTile = "act_to_soundtrack_tile"

function MusicHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    BrowserService = o.api("BrowserService"),
    MiscService = o.api("MiscService")
  }
  

  o.im.RegisterAction(actToMountsainfoTile, function(actionName)
    o:_openMountsainfoPopup(actionName)
  end)
  function MusicHub:_openMountsainfoPopup()
  local titleText = ""
  local messageText = ""
  local buttonClose = {
    icon = "$FooterIconNo",
    label = "Close",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = titleText,
    message = messageText,
    buttons = {buttonClose}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end
  
  return o
end

function MusicHub:finalize()
end

return MusicHub