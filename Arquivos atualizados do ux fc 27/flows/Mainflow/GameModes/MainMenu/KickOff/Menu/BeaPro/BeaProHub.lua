
local BeaProHub = {}

local BND_MENU_LIST = "bnd_menu_list"

function BeaProHub:new(init)
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
    images = { "$_ModeInfo5" },
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_career"
  })
  
    
  o.im.Subscribe(BND_MENU_LIST, function()
    o:_publishMenuList()
  end)
  
  return o
end

function BeaProHub:_publishMenuList()
  local dataToPublish = {
    index = 0,
    data = self.MenuLists
  }
  self.im.Publish(BND_MENU_LIST, dataToPublish)
end

function BeaProHub:finalize()
  
  self.im.Unsubscribe(BND_MENU_LIST)
end

return BeaProHub