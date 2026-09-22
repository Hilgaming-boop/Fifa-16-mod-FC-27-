local MenuHub = {}
local BND_LIVE_MENU = "bnd_live_menu"
clickAction = nil
function MenuHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {}
  
  o.Menu = {}
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision1"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_tab_mission1"
    
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision2"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_tab_mission2"    
    
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision3"},
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_tab_mission3"
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision4"},
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_tab_mission4"
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision5"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_tab_mission5"    
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision6"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_tab_mission6"
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision7"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_tab_mission7"    
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision8"},
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_tab_mission8"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision9"},
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_tab_mission9"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision10"},
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_tab_mission10"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision11"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission11"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision12"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission12"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision13"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission13"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision14"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission14"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision15"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission15"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision16"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission16"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision17"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission17"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision18"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission18"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision19"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission19"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision20"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission20"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision21"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission21"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision22"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission22"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision23"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission23"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision24"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission24"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision25"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission25"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$Tab_Mision26"},
    autoScaleImageToTileHeight = { "false" },
    clickAction = "act_tab_mission26"
  })
  
  o.im.Subscribe(BND_LIVE_MENU, function()
    o:_publishMenu()
  end)
  
  return o
end

function MenuHub:_publishMenu()
  local dataToPublish = { index = 0, data = self.Menu }
  self.im.Publish(BND_LIVE_MENU, dataToPublish)
end

function MenuHub:finalize()
end

return MenuHub