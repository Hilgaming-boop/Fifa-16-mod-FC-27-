
local CreditsHub = {}
local actToMountsainfoTile = "act_to_Mountsa_tile"

function CreditsHub:new(init)
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
  function CreditsHub:_openMountsainfoPopup()
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

function CreditsHub:finalize()
end

return CreditsHub