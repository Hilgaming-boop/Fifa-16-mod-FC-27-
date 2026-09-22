-------------------------------------------------------
-- BY ROBER FL --
-------------------------------------------------------


local CreditsHub = {}
local actToDFLinfoTile = "act_to_DFLinfo_tile"

function CreditsHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    BrowserService = o.api("BrowserService"),
    MiscService = o.api("MiscService")
  }
  
  ---------------------------------
  -- Talamlegit  INFO --
  ---------------------------------
  o.im.RegisterAction(actTotalamlegitinfoTile, function(actionName)
    o:_opentalamlegitinfoPopup(actionName)
  end)
  function CreditsHub:_opentalamlegitinfoPopup()
  local titleText = "THEME EAFC25*"
  local messageText = "Version 1.0*                                                                                        !ATTENTION!                                                                            The creators of this mod (DFL) do not allow link changes in any way to profit from our work. Respect the Mod Creators!"
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