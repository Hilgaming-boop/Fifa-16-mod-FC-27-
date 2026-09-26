
local ManagerHub = {}

local BND_MENU_LIST = "bnd_menu_list"

function ManagerHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
  }
  
  ------------------------------------------------------------------------------------------

  math.randomseed(os.clock() * 1352 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(5)
  

  ------------------------------------------------------------------------------------------
  o.MenuLists = {}

  table.insert(o.MenuLists, {
    headline = { "" },
    description = "",
    images = { "$_ModeInfo6" },
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_challenge"
  })
  
    
  o.im.Subscribe(BND_MENU_LIST, function()
    o:_publishMenuList()
  end)
  
  return o
end

function ManagerHub:_publishMenuList()
  local dataToPublish = {
    index = 0,
    data = self.MenuLists
  }
  self.im.Publish(BND_MENU_LIST, dataToPublish)
end

function ManagerHub:finalize()
  
  self.im.Unsubscribe(BND_MENU_LIST)
end

return ManagerHub