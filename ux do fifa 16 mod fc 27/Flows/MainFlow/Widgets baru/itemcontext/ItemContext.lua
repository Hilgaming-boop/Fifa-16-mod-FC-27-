local TableUtil, VirtualButton, EventManager, PlayerViewModel, ItemModel, ConsumableManager, LiveTilesService, FormationModel = ...
local ItemContext = {}
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local CONSUMABLE_MANAGER = ConsumableManager.FeCards.Consumable
local FUT_LIVE_TILES_TYPE = LiveTilesService.FE.UXService.FUTLiveTilesType
local BND_ITEMCONTEXT_ITEMS_DATA = "bnd_itemcontext_items_data"
local BND_ITEM_OPTIONS_DATA = "bnd_item_options_data"
local BND_REQUESTED_ITEM_DATA = "bnd_requested_item_data"
local BND_CONTEXT_GROUP_ID = "bnd_context_group_id"
local BND_CONTEXT_SQUAD_POS_ID = "bnd_context_squad_pos_id"
local BND_ITEM_VIEW_ENABLED = "bnd_item_view_enabled"
local ACT_ON_ITEMTOGGLE_LOADED = "act_on_itemtoggle_loaded"
local ACT_ON_ITEM_TOGGLE_COMPLETE = "act_on_item_toggle_complete"
local ACT_GET_ITEM_DATA_FROM_ITEMID = "act_get_item_data_from_itemid"
local ACT_ITEM_SHOW_BIO = "act_item_show_bio"
local ACT_ITEM_QUICK_SELL = "act_item_quick_sell"
local ACT_MOVE_TO_CLUB = "act_move_to_club"
local ACT_MOVE_TO_SQUAD = "act_move_to_squad"
local ACT_SEND_TO_TRADE_PILE = "act_item_send_to_trade_pile"
local ACT_MAKE_ACTIVE = "act_make_active"
local ACT_ITEM_APPLY_CONSUMABLE = "act_item_apply_consumable"
local ACT_ITEM_APPLY_CONSUMABLE_PACK = "act_item_apply_consumable_pack"
local ACT_DISABLE_INTERACTION = "act_disable_interaction"
local ACT_ENABLE_INTERACTION = "act_enable_interaction"
local ACT_ITEM_REMOVE_FROM_SQUAD = "act_item_remove_from_squad"
local ACT_ITEM_SWAP_WITH_CLUB = "act_item_swap_with_club"
local ACT_EXIT_ITEM_CONTEXT = "act_exit_context_popup"
local MAX_STARTING = 11
local MAX_SUBS = 7
local MAX_RES = 5
local MAX_MANAGER = 1
local STARTING_POSITION_INDEX = 1
local SUBS_POSITION_INDEX = STARTING_POSITION_INDEX + MAX_STARTING
local RES_POSITION_INDEX = SUBS_POSITION_INDEX + MAX_SUBS
local MANAGER_POSITION_INDEX = RES_POSITION_INDEX + MAX_RES
function ItemContext:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.dataSet = {}
  o.itemIdList = o.data.itemIdList
  o.itemIndex = o.data.itemIndex
  o.isItemToggleLoaded = false
  o.squadId = o.data.squadId
  o.quickSellItemFunc = o.data.quickSellItemFunc
  o.addItemToActiveSquadFunc = o.data.addItemToActiveSquadFunc
  o.moveItemToClubFunc = o.data.moveItemToClubFunc
  o.hideItemContextCallbackFunc = o.data.hideItemContextCallbackFunc
  o.itemContextType = ItemModel.CONTEXT_STORE
  if o.data.onDataRefreshedFunc ~= nil then
    o.data.onDataRefreshedFunc.registerRefreshCallback(o.handleDataRefreshed, o)
  end
  if o.data.isSquad then
    o.itemContextType = ItemModel.CONTEXT_FIELD
  end
  if o.data.isInventory then
    o.itemContextType = ItemModel.CONTEXT_STICKERBOOK
  end
  o.services = {
    EventManagerService = o.api("EventManagerService"),
    CardService = o.api("CardService"),
    FutStoreService = o.api("FutStoreService"),
    FUTLiveTilesService = o.api("FUTLiveTilesService"),
    MarketPriceService = o.api("MarketPriceService"),
    FUTSquadManagementService = o.api("FUTSquadManagementService"),
    ScreenInfoService = o.api("ScreenInfoService")
  }
  o.services.ScreenInfoService.SetScreenName("ItemContext")
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvents(...)
  end
  )
  o.teamID = o.services.FUTSquadManagementService.GetFUTTeamId()
  o.models = {
    ItemModel = ItemModel:new({
      im = o.im,
      api = o.api,
      loc = o.loc,
      nav = o.nav
    }),
    PlayerViewModel = PlayerViewModel:new({
      im = o.im,
      api = o.api,
      loc = o.loc,
      nav = o.nav
    }),
    FormationModel = FormationModel:new({
      im = o.im,
      api = o.api,
      nav = o.nav,
      loc = o.loc,
      teamID = o.teamID,
      gamemode = "fut",
      onFormationChangeCallback = function(...)
        o:_onFormationChanged(...)
      end
      
    })
  }
  o.im.Subscribe(BND_ITEMCONTEXT_ITEMS_DATA, function()
  end
  )
  o.im.Subscribe(BND_ITEM_OPTIONS_DATA, function()
  end
  )
  o.im.Subscribe(BND_REQUESTED_ITEM_DATA, function()
  end
  )
  o.im.Subscribe(BND_CONTEXT_GROUP_ID, function()
  end
  )
  o.im.Subscribe(BND_CONTEXT_SQUAD_POS_ID, function()
  end
  )
  o.im.Subscribe(BND_ITEM_VIEW_ENABLED, function()
  end
  )
  o.im.RegisterAction(ACT_ON_ITEMTOGGLE_LOADED, function(actionName, data)
    o.isItemToggleLoaded = true
    o:_publishItemIdsData()
  end
  )
  o.im.RegisterAction(ACT_ON_ITEM_TOGGLE_COMPLETE, function(actionName, data)
    o:_setPlayerViewEnabled(o.itemIdList[data.groupID], data.groupID)
    o:_publishItemContextData(data)
  end
  )
  o.im.RegisterAction(ACT_GET_ITEM_DATA_FROM_ITEMID, function(actionName, data)
    o:_getItemFromIdWithContext(data)
  end
  )
  o.im.RegisterAction(ACT_ITEM_SHOW_BIO, function(actionName, data)
    o:showBio(o.itemIdList[data.groupID], data.groupID)
  end
  )
  o.im.RegisterAction(ACT_ITEM_QUICK_SELL, function(actionName, data)
    if o.itemContextType == ItemModel.CONTEXT_FIELD then
      o:quickSellItem(o.itemIdList[data.groupID], data.squadPosID)
    else
      o:quickSellItem(o.itemIdList[data.groupID], data.groupID)
    end
  end
  )
  o.im.RegisterAction(ACT_MOVE_TO_CLUB, function(actionName, data)
    o:moveItemToClub(o.itemIdList[data.groupID], data.groupID)
  end
  )
  o.im.RegisterAction(ACT_MOVE_TO_SQUAD, function(actionName, data)
    o:addItemToActiveSquad(o.itemIdList[data.groupID], data.groupID)
  end
  )
  o.im.RegisterAction(ACT_SEND_TO_TRADE_PILE, function(actionName, data)
    o:sendItemToTradePile(o.itemIdList[data.groupID], data.groupID)
  end
  )
  o.im.RegisterAction(ACT_MAKE_ACTIVE, function(actionName, data)
    o:makeActive(o.itemIdList[data.groupID], data.groupID)
  end
  )
  o.im.RegisterAction(ACT_ITEM_APPLY_CONSUMABLE, function(actionName, data)
    if o.itemContextType == ItemModel.CONTEXT_STORE then
      o:applyItem(o.itemIdList[data.groupID], data.groupID, false)
    else
      o:applyConsumable(o.itemIdList, data.groupID)
    end
  end
  )
  o.im.RegisterAction(ACT_ITEM_APPLY_CONSUMABLE_PACK, function(actionName, data)
    o:applyItem(o.itemIdList[data.groupID], data.groupID, true)
  end
  )
  o.im.RegisterAction(ACT_DISABLE_INTERACTION, function(actionName, data)
    o:_toggleActionValidity(false)
  end
  )
  o.im.RegisterAction(ACT_ENABLE_INTERACTION, function(actionName, data)
    o:_toggleActionValidity(true)
  end
  )
  o.im.RegisterAction(ACT_ITEM_REMOVE_FROM_SQUAD, function(actionName, data)
    o:removeItemFromSquad(o.itemIdList[data.groupID], data.groupID)
  end
  )
  o.im.RegisterAction(ACT_ITEM_SWAP_WITH_CLUB, function(actionName, data)
    o:swapWithClub(o.itemIdList[data.squadPosID], data.squadPosID)
  end
  )
  o.im.RegisterAction(ACT_EXIT_ITEM_CONTEXT, function()
    o:_hideItemContext()
  end
  )
  return o
end

function ItemContext:_handleEvents(eventType, data)
  local screenName = self.services.ScreenInfoService.GetCurrentScreenName()
  if eventType == EVENT_TYPES.OnBackPressed then
    if screenName == "ConsumablesPopup" then
      self.nav.Event(nil, "evt_hide_overlay")
    elseif screenName == "GenericPopup" then
    else
      self:_hideItemContext()
    end
  end
end

function ItemContext:_hideItemContext()
  if self.hideItemContextCallbackFunc ~= nil then
    self.hideItemContextCallbackFunc.hideItemContextCallback()
  end
  self.nav.Event(nil, "evt_hide_item_context")
end

function ItemContext:handleDataRefreshed(newItemIds, selfRef)
  selfRef.itemIdList = newItemIds
  selfRef:_publishItemIdsData()
end

function ItemContext:_toggleActionValidity(isValid)
  if isValid then
    self.im.ChangeActionState(ACT_ITEM_SHOW_BIO, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_ITEM_QUICK_SELL, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_MOVE_TO_CLUB, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_MOVE_TO_SQUAD, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_SEND_TO_TRADE_PILE, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_ITEM_APPLY_CONSUMABLE, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_ITEM_APPLY_CONSUMABLE_PACK, self.im.GetActionState("VALID"))
  else
    self.im.ChangeActionState(ACT_ITEM_SHOW_BIO, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_ITEM_QUICK_SELL, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_MOVE_TO_CLUB, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_MOVE_TO_SQUAD, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_SEND_TO_TRADE_PILE, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_ITEM_APPLY_CONSUMABLE, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_ITEM_APPLY_CONSUMABLE_PACK, self.im.GetActionState("INVALID"))
  end
end

function ItemContext:_getItemFromIdWithContext(listOfItemIds)
  local requestedItemData = {}
  requestedItemData = self.models.ItemModel:getItemStructureByID(listOfItemIds, "field")
  do
    do
      for i, i in ipairs(requestedItemData) do
        i.contextMenu = self.models.ItemModel:getContextMenu(requestedItemData[i], self.itemContextType)
        i.dirtyType = listOfItemIds[i].dirtyType
        i.POS_IN_SQUAD = listOfItemIds[i].POS_IN_SQUAD
      end
    end
  end
  self.im.Publish(BND_REQUESTED_ITEM_DATA, requestedItemData)
end

function ItemContext:_publishItemIdsData()
  if self.isItemToggleLoaded then
    self.dataSet = {}
    if #self.itemIdList > 0 then
      do
        for i = 1, #self.itemIdList do
          table.insert(self.dataSet, self.itemIdList[i])
        end
      end
    else
      table.insert(self.dataSet, self.itemIdList)
    end
    self.im.Publish(BND_ITEMCONTEXT_ITEMS_DATA, {
      data = self.dataSet,
      index = self.itemIndex
    })
  end
end

function ItemContext:_publishItemContextData(data)
  self.im.Publish(BND_ITEM_OPTIONS_DATA, data.contextData)
  self.im.Publish(BND_CONTEXT_GROUP_ID, data.groupID)
  self.im.Publish(BND_CONTEXT_SQUAD_POS_ID, data.squadPosID)
end

function ItemContext:_getItemFromId(itemId)
  local requestedItemData = {}
  requestedItemData = self.models.ItemModel:getItemStructureByID(itemId, self.itemContextType)
  return requestedItemData
end

function ItemContext:showBio(item, index)
  if item.CARD_TYPE ~= ItemModel.FUT_ITEM_TYPE.PLAYER then
    return
  end
  local playerItems = {}
  do
    do
      for i, i in pairs(self.itemIdList) do
        table.insert(playerItems, i)
      end
    end
  end
  self:_hideItemContext()
  self.nav.Event(nil, "evt_show_player_bio", {targetPlayers = playerItems, targetPositionIndex = index})
end

function ItemContext:quickSellItem(item, positionIndex)
  local targetItem = {}
  local currentTarget = {}
  table.insert(currentTarget, item)
  targetItem = self:_getItemFromId(currentTarget)
  local buttonNo = VirtualButton:new({
    nav = self.nav,
    label = "LTXT_CMN_NO",
    clickEvents = {
      "evt_hide_popup"
    }
  })
  local buttonYes = VirtualButton:new({
    nav = self.nav,
    label = "LTXT_CMN_YES",
    clickEvents = {
      "evt_hide_popup"
    },
    clickCallback = function()
      self.nav.Event(nil, "evt_show_blocking_load")
      self.models.ItemModel:quickSellItem(targetItem, self.itemContextType, function()
        if self.quickSellItemFunc ~= nil then
          self.quickSellItemFunc.quickSellItem(positionIndex)
        end
        self:removeItemAt(positionIndex)
      end
      , function()
        self.nav.Event(nil, "evt_hide_blocking_load")
      end
      )
    end
    
  })
  local popupMessage = string.format(self.loc.LocalizeString("LTXT_QUICK_SELL_CONFIRMATION"), self.loc.LocalizeInteger(targetItem[1].discardValue))
  local popupMessageObject = {}
  popupMessageObject.localized = true
  popupMessageObject.message = popupMessage
  local popupData = {
    title = "LTXT_QUICK_SELL_CONFIRMATION_TITLE",
    message = popupMessageObject,
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function ItemContext:moveItemToClub(item, positionIndex)
  self.nav.Event(nil, "evt_show_blocking_load")
  local currentTarget = {}
  table.insert(currentTarget, item)
  self.models.ItemModel:moveItemToClub(self:_getItemFromId(currentTarget), self.itemContextType, function()
    self:removeItemAt(positionIndex)
    if self.moveItemToClubFunc ~= nil then
      self.moveItemToClubFunc.moveItemToClub()
    end
  end
  , function(reason)
    self.nav.Event(nil, "evt_hide_blocking_load")
    if reason == ItemModel.CARDS_ERROR.CARDS_CB_ERR_ESCROW_FULL then
      self.models.ItemModel:errorPopup("LTXT_CONSUMABLE_PILE_FULL_TITLE", "FUT_TRADE_PILE_CONSUMABLE_FULL")
    else
      self.models.ItemModel:errorPopup("LTXT_CMN_FUT_ERROR_TITLE", "CARDS_CB_ERR_TIMEOUT")
    end
  end
  )
end

function ItemContext:addItemToActiveSquad(item, positionIndex)
  self.nav.Event(nil, "evt_show_blocking_load")
  local currentTarget = {}
  table.insert(currentTarget, item)
  self.models.ItemModel:addItemToActiveSquad(self:_getItemFromId(currentTarget)[1], self.itemContextType, function()
    self:removeItemAt(positionIndex)
    if self.addItemToActiveSquadFunc ~= nil then
      self.addItemToActiveSquadFunc.addItemToActiveSquad()
    end
  end
  , function()
    self.nav.Event(nil, "evt_hide_blocking_load")
  end
  )
end

function ItemContext:sendItemToTradePile(item, positionIndex)
  self.nav.Event(nil, "evt_show_blocking_load")
  local currentTarget = {}
  table.insert(currentTarget, item)
  self.models.ItemModel:addItemToTradePile(self:_getItemFromId(currentTarget), self.itemContextType, function()
    if self.itemContextType == ItemModel.CONTEXT_FIELD then
      self:removeItemFromSquad(item, positionIndex)
    else
      self:removeItemAt(positionIndex)
    end
  end
  , function(reason)
    self.nav.Event(nil, "evt_hide_blocking_load")
    if reason == ItemModel.CARDS_ERROR.CARDS_CB_ERR_ESCROW_FULL then
      self.models.ItemModel:errorPopup("FUT_NI_TB_TradePileFullTitle", "LTXT_TRANSFER_LIST_FULL")
    else
      self.models.ItemModel:errorPopup("LTXT_CMN_FUT_ERROR_TITLE", "CARDS_CB_ERR_TIMEOUT")
    end
  end
  )
end

function ItemContext:makeActive(item, positionIndex)
  self.nav.Event(nil, "evt_show_blocking_load")
  local currentTarget = {}
  table.insert(currentTarget, item)
  self.models.ItemModel:makeItemActive(self:_getItemFromId(currentTarget)[1], function()
    self:removeItemAt(positionIndex)
    self.nav.Event(nil, "evt_hide_blocking_load")
  end
  , function()
    self.nav.Event(nil, "evt_hide_blocking_load")
  end
  )
end

function ItemContext:applyItem(item, positionIndex, isPackFromPack)
  self.nav.Event(nil, "evt_show_blocking_load")
  local currentTarget = {}
  table.insert(currentTarget, item)
  self.models.ItemModel:applyItem(self:_getItemFromId(currentTarget)[1], {}, function()
    self:removeItemAt(positionIndex)
  end
  , function()
    self.nav.Event(nil, "evt_hide_blocking_load")
    self.models.ItemModel:errorPopup("LTXT_CMN_FUT_ERROR_TITLE", "CARDS_CB_ERR_TIMEOUT")
  end
  )
end

function ItemContext:removeItemAt(index)
  table.remove(self.itemIdList, index)
  self.itemIndex = index - 1
  if #self.itemIdList > 0 then
    if index > #self.itemIdList then
      self.itemIndex = 0
    end
    self:_publishItemIdsData()
  else
    self:_hideItemContext()
  end
  self.nav.Event(nil, "evt_hide_blocking_load")
end

function ItemContext:removeItemFromSquad(item, positionIndex)
  local currentTarget = {}
  table.insert(currentTarget, item)
  self.models.ItemModel:removeItemFromActiveSquadAt(self:_getItemFromId(currentTarget)[1], positionIndex - 1)
  self:removeItemAt(positionIndex)
end

function ItemContext:swapWithClub(item, squadPositionIndex)
  local targetItem, targetPositionID
  local manager = self.models.ItemModel:getItemStructureByID({
    self.services.FUTSquadManagementService.GetManagerID()
  }, ItemModel.CONTEXT_FIELD)[1]
  if squadPositionIndex < 0 then
    print("invalid squad position")
  end
  if squadPositionIndex < MANAGER_POSITION_INDEX then
    targetItem = TableUtil.shallowcopy(item)
    targetPositionID = self.models.FormationModel:getPositionIDByPositionIndex(squadPositionIndex)
  else
    targetItem = TableUtil.shallowcopy(manager)
  end
  targetItem.type = self.models.ItemModel:toFEType(targetItem.CARD_TYPE, targetItem.CARD_ID)
  self.nav.Event(nil, "evt_show_search_popup", {
    itemIdList = self.itemIdList,
    targetItem = targetItem,
    targetPositionID = targetPositionID,
    positionIndex = squadPositionIndex,
    managerIndex = MANAGER_POSITION_INDEX
  })
  self:_hideItemContext()
end

function ItemContext:applyConsumable(itemIdList, positionIndex)
  local filteredItemsIds = {}
  local posIndex = -1
  do
    do
      for i, i in pairs(itemIdList) do
        if i.CARD_TYPE == ItemModel.FUT_ITEM_TYPE.PLAYER or i.CARD_TYPE == ItemModel.FUT_ITEM_TYPE.MANAGER then
          table.insert(filteredItemsIds, i)
          if itemIdList[positionIndex].UUID_UPPER == i.UUID_UPPER and itemIdList[positionIndex].UUID_LOWER == i.UUID_LOWER then
            posIndex = #filteredItemsIds
          end
        end
      end
    end
  end
  self:_hideItemContext()
  self.nav.Event(nil, "evt_show_overlay", {
    vvm = "/flows/mainflow/gamemodes/fut/club/squad/consumables/ConsumablesPopup.vvm",
    data = {
      squadID = self.squadId,
      targetItems = filteredItemsIds,
      targetPositionIndex = posIndex,
      saveSquadCallback = function(onCompleteCallback, onFailCallback)
        self:saveCurrentSquad(onCompleteCallback, onFailCallback)
      end
      
    }
  })
end

function ItemContext:saveCurrentSquad(onCompleteCallback, onFailCallback)
  if not self.dirtySquad then
    if onCompleteCallback ~= nil then
      onCompleteCallback()
    end
    return
  end
  self.onSaveSquadCompleteCallback = onCompleteCallback
  self.onSaveSquadFailCallback = onFailCallback
  self.services.FUTSquadManagementService.SaveCurrentSquad()
end

function ItemContext:_onFormationChanged(currentFormationIndex)
  self.dirtySquad = true
  self.services.FUTSquadManagementService.SetFormation(self.teamID, self.models.FormationModel:getCurrentFormationID(), false)
end

function ItemContext:_setPlayerViewEnabled(item, positionIndex)
  if item.CARD_TYPE == ItemModel.FUT_ITEM_TYPE.PLAYER or item.CARD_TYPE == ItemModel.FUT_ITEM_TYPE.MANAGER then
    self.im.Publish(BND_ITEM_VIEW_ENABLED, true)
  else
    self.im.Publish(BND_ITEM_VIEW_ENABLED, false)
  end
end

function ItemContext:finalize()
  self.models.ItemModel:finalize()
  self.models.PlayerViewModel:finalize()
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
  self.im.Unsubscribe(BND_ITEMCONTEXT_ITEMS_DATA)
  self.im.Unsubscribe(BND_ITEM_OPTIONS_DATA)
  self.im.Unsubscribe(BND_REQUESTED_ITEM_DATA)
  self.im.Unsubscribe(BND_CONTEXT_GROUP_ID)
  self.im.Unsubscribe(BND_CONTEXT_SQUAD_POS_ID)
  self.im.Unsubscribe(BND_ITEM_VIEW_ENABLED)
  self.im.UnregisterAction(ACT_ON_ITEMTOGGLE_LOADED)
  self.im.UnregisterAction(ACT_ON_ITEM_TOGGLE_COMPLETE)
  self.im.UnregisterAction(ACT_GET_ITEM_DATA_FROM_ITEMID)
  self.im.UnregisterAction(ACT_ITEM_SHOW_BIO)
  self.im.UnregisterAction(ACT_ITEM_QUICK_SELL)
  self.im.UnregisterAction(ACT_MOVE_TO_CLUB)
  self.im.UnregisterAction(ACT_MOVE_TO_SQUAD)
  self.im.UnregisterAction(ACT_SEND_TO_TRADE_PILE)
  self.im.UnregisterAction(ACT_MAKE_ACTIVE)
  self.im.UnregisterAction(ACT_ITEM_APPLY_CONSUMABLE)
  self.im.UnregisterAction(ACT_ITEM_APPLY_CONSUMABLE_PACK)
  self.im.UnregisterAction(ACT_DISABLE_INTERACTION)
  self.im.UnregisterAction(ACT_ENABLE_INTERACTION)
  self.im.UnregisterAction(ACT_ITEM_REMOVE_FROM_SQUAD)
  self.im.UnregisterAction(ACT_ITEM_SWAP_WITH_CLUB)
  self.im.UnregisterAction(ACT_EXIT_ITEM_CONTEXT)
  self.services.ScreenInfoService.UnsetScreenName("ItemContext")
end

return ItemContext
