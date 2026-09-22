local SelectFromListPopup = {}
local BND_TITLE = "bnd_title"
local BND_INDEX = "bnd_index"
local BND_LIST = "bnd_list"
local BND_WIDTH = "bnd_width"
local BND_HEIGHT = "bnd_height"
local BND_ROWS = "bnd_rows"
local BND_COLUMNS = "bnd_columns"
local BND_BULLET_INDICATOR = "bnd_bullet_indicator"
local BND_ITEM_TYPE = "bnd_item_type"
local BND_OVERLAY_WIDTH = "bnd_overlay_width"
local BND_OVERLAY_HEIGHT = "bnd_overlay_height"
local BND_OVERLAY_VISIBLE = "bnd_overlay_visible"
local ACT_CLOSE = "act_close"
local ACT_CHANGE = "act_change"
function SelectFromListPopup:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {}
  o.im.Subscribe(BND_TITLE, function()
    o.im.Publish(BND_TITLE, o.data.title)
  end
  )
  o.im.Subscribe(BND_ITEM_TYPE, function()
    o.im.Publish(BND_ITEM_TYPE, o.data.itemType)
  end
  )
  o.im.Subscribe(BND_BULLET_INDICATOR, function()
    o.im.Publish(BND_BULLET_INDICATOR, o.data.bulletIndicator)
  end
  )
  o.im.Subscribe(BND_WIDTH, function()
    o.im.Publish(BND_WIDTH, o.data.width)
  end
  )
  o.im.Subscribe(BND_HEIGHT, function()
    o.im.Publish(BND_HEIGHT, o.data.height)
  end
  )
  o.im.Subscribe(BND_ROWS, function()
    o.im.Publish(BND_ROWS, o.data.rows)
  end
  )
  o.im.Subscribe(BND_COLUMNS, function()
    o.im.Publish(BND_COLUMNS, o.data.columns)
  end
  )
  o.im.Subscribe(BND_LIST, function()
    o.im.Publish(BND_LIST, o.data.tableData)
  end
  )
  o.im.Subscribe(BND_OVERLAY_WIDTH, function()
    o.im.Publish(BND_OVERLAY_WIDTH, o.data.overlayWidth)
  end
  )
  o.im.Subscribe(BND_OVERLAY_HEIGHT, function()
    o.im.Publish(BND_OVERLAY_HEIGHT, o.data.overlayHeight)
  end
  )
  o.im.Subscribe(BND_OVERLAY_VISIBLE, function()
    o.im.Publish(BND_OVERLAY_VISIBLE, true)
  end
  )
  o.im.RegisterDataAction(BND_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    local selectionData = {index = index}
    o.data.callBack(selectionData)
    o.nav.Event(nil, "evt_hide_overlay")
  end
  )
  o.im.RegisterAction(ACT_CLOSE, function(actionName, data)
    local selectionData = {canceled = true}
    o.data.callBack(selectionData)
    o.nav.Event(nil, "evt_hide_overlay")
  end
  )
  return o
end

function SelectFromListPopup:finalize()
  self.im.Unsubscribe(BND_TITLE)
  self.im.Unsubscribe(BND_LIST)
  self.im.Unsubscribe(BND_WIDTH)
  self.im.Unsubscribe(BND_HEIGHT)
  self.im.Unsubscribe(BND_ROWS)
  self.im.Unsubscribe(BND_COLUMNS)
  self.im.Unsubscribe(BND_BULLET_INDICATOR)
  self.im.Unsubscribe(BND_ITEM_TYPE)
  self.im.Unsubscribe(BND_OVERLAY_WIDTH)
  self.im.Unsubscribe(BND_OVERLAY_HEIGHT)
  self.im.Unsubscribe(BND_OVERLAY_VISIBLE)
  self.im.UnregisterAction(ACT_CLOSE)
  self.im.UnregisterDataAction(BND_INDEX, ACT_CHANGE)
end

return SelectFromListPopup
