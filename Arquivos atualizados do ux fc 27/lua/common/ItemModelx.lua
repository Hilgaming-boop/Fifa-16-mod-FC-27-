local SharedFUTEnums, FutServerTypesDefinition, TableUtil, EventManager, CardsErrors, VirtualButton = ...
local ACT_CONTEXT_MENU_SHOW_BIO = "act_item_show_bio"
local ACT_CONTEXT_MENU_SWAP_WITH_CLUB = "act_item_swap_with_club"
local ACT_CONTEXT_MENU_REMOVE_FROM_SQUAD = "act_item_remove_from_squad"
local ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE = "act_item_send_to_trade_pile"
local ACT_CONTEXT_MENU_APPLY_CONSUMABLE = "act_item_apply_consumable"
local ACT_CONTEXT_MENU_QUICK_SELL = "act_item_quick_sell"
local ACT_CONTEXT_MENU_MOVE_TO_SQUAD = "act_move_to_squad"
local ACT_CONTEXT_MENU_MAKE_ACTIVE = "act_make_active"
local ACT_CONTEXT_MENU_MOVE_TO_CLUB = "act_move_to_club"
local ACT_CONTEXT_MENU_APPLY_CONSUMABLE_PACK = "act_item_apply_consumable_pack"
local ACT_CONTEXT_MENU_QUICK_LIST = "act_item_quick_list"
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local ERROR_PLAYER_ALREADY_EXISTS = 1
local ERROR_OTHER = 2
local ItemModel = {}
ItemModel.TYPE_NONE = 0
ItemModel.TYPE_PLAYER = 1
ItemModel.TYPE_MANAGER = 2
ItemModel.TYPE_CONSUMABLE = 3
ItemModel.TYPE_FIELD_NONE = 10
ItemModel.TYPE_FIELD_PLAYER = 11
ItemModel.TYPE_FIELD_MANAGER = 12
ItemModel.TYPE_ESCROW_PLAYER = 21
ItemModel.TYPE_ESCROW_MANAGER = 22
ItemModel.TYPE_ESCROW_CONSUMABLE = 23
ItemModel.CONTEXT_DEFAULT = "default"
ItemModel.CONTEXT_FIELD = "field"
ItemModel.CONTEXT_ESCROW = "escrow"
ItemModel.CONTEXT_STICKERBOOK = "stickerbook"
ItemModel.CONTEXT_STORE = "store"
ItemModel.CONTEXT_TOTW = "totw"
ItemModel.FUT_ITEM_TYPE = SharedFUTEnums.CardAttrib.Card.eCardType
ItemModel.FUT_ITEM_SUBTYPE = SharedFUTEnums.CardAttrib.Card.eSpecialCardType
ItemModel.FUT_ITEM_CATEGORY = SharedFUTEnums.CardAttrib.Card.eCategory
ItemModel.FUT_ITEM_LEVEL = SharedFUTEnums.CardAttrib.Card.eCardLevel
ItemModel.FUT_ITEM_TOTW = SharedFUTEnums.CardAttrib.Card.eCardTOTW
ItemModel.FUT_ITEM_RARITY = SharedFUTEnums.CardAttrib.Card.eCardRarity
ItemModel.FUT_ITEM_SEARCHTYPE = SharedFUTEnums.MyClub.eSearchType
ItemModel.DECK_TYPE = FutServerTypesDefinition.FUT.FutDeckType
ItemModel.INVENTORY_SEARCH_TYPE = FutServerTypesDefinition.FUT.FutCollectionSearchType
ItemModel.CARDINVENTORY = SharedFUTEnums.CardInventory
ItemModel.MAX_CONSUMABLES_IN_CLUB = 65
ItemModel.MAX_ITEMS_TRANSFER_LIST = 30
ItemModel.CARDS_ERROR = CardsErrors.FUT.FutServerError
function ItemModel:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    FUTSquadManagementService = o.api("FUTSquadManagementService"),
    CardService = o.api("CardService"),
    ItemsService = o.api("ItemsService"),
    MyClubService = o.api("MyClubService"),
    EventManagerService = o.api("EventManagerService"),
    MarketPriceService = o.api("MarketPriceService")
  }
  o.searchId = -1
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end
  )
  return o
end

function ItemModel:toFEType(itemType, itemID, itemContext)
  local FEType = ItemModel.TYPE_NONE
  if itemID == 0 or itemType >= ItemModel.FUT_ITEM_TYPE.EMPTY_UNKNOWN then
    if itemContext == ItemModel.CONTEXT_FIELD or itemContext == ItemModel.CONTEXT_TOTW then
      FEType = ItemModel.TYPE_FIELD_NONE
    else
      FEType = ItemModel.TYPE_NONE
    end
  elseif itemType == ItemModel.FUT_ITEM_TYPE.PLAYER then
    if itemContext == ItemModel.CONTEXT_FIELD or itemContext == ItemModel.CONTEXT_TOTW then
      FEType = ItemModel.TYPE_FIELD_PLAYER
    elseif itemContext == ItemModel.CONTEXT_ESCROW then
      FEType = ItemModel.TYPE_ESCROW_PLAYER
    else
      FEType = ItemModel.TYPE_PLAYER
    end
  elseif itemType == ItemModel.FUT_ITEM_TYPE.MANAGER or itemType == ItemModel.FUT_ITEM_TYPE.HEADCOACH or itemType == ItemModel.FUT_ITEM_TYPE.FITNESSCOACH or itemType == ItemModel.FUT_ITEM_TYPE.PHYSIO or itemType == ItemModel.FUT_ITEM_TYPE.GKCOACH then
    if itemContext == ItemModel.CONTEXT_FIELD or itemContext == ItemModel.CONTEXT_TOTW then
      FEType = ItemModel.TYPE_FIELD_MANAGER
    elseif itemContext == ItemModel.CONTEXT_ESCROW then
      FEType = ItemModel.TYPE_ESCROW_MANAGER
    else
      FEType = ItemModel.TYPE_MANAGER
    end
  elseif itemContext == ItemModel.CONTEXT_ESCROW then
    FEType = ItemModel.TYPE_ESCROW_CONSUMABLE
  else
    FEType = ItemModel.TYPE_CONSUMABLE
  end
  return FEType
end

function ItemModel:getPlayerPositionByID(id)
  return self.services.CardService.GetPositionNameByID(id)
end

function ItemModel:getPlayerMoraleByValue(value)
  return self.services.CardService.GetMoraleByValue(value)
end

function ItemModel:getItemRarityByRating(rating)
  if rating < 65 then
    return ItemModel.FUT_ITEM_TOTW.PURPLE_CARD
    elseif rating < 77 then
    return ItemModel.FUT_ITEM_TOTW.BLUE_CARD
  elseif rating < 80 then
    return ItemModel.FUT_ITEM_TOTW.BLUERED_CARD
    elseif rating < 83 then
    return ItemModel.FUT_ITEM_TOTW.GREEN_CARD
    elseif rating < 86 then
    return ItemModel.FUT_ITEM_TOTW.ORANGE_CARD
    elseif rating < 89 then
    return ItemModel.FUT_ITEM_TOTW.PINK_CARD
  else
    return ItemModel.FUT_ITEM_TOTW.TEAL_CARD
  end
end

function ItemModel:getItemStructureByID(itemIDs, itemContext)
  print("[ItemModel]: getItemStructureByID(itemContext = " .. tostring(itemContext) .. "): Listing Item structures for " .. tostring(table.getn(itemIDs)) .. " Items...")
  local itemData = self.services.CardService.GetCardListInfo(itemIDs)
  do
    do
      for i, i in ipairs(itemData) do
        i.type = self:toFEType(i.CARD_TYPE, i.CARD_ID, itemContext)
        i.subtype = i.CARD_SUBTYPE or -1
        if i.CARD_TYPE == ItemModel.FUT_ITEM_TYPE.PLAYER then
          local modifiedAttributes = self.services.CardService.GetCardModifiedAttributes(i)
          do
            for i, i in pairs(modifiedAttributes) do
              i[i] = i
            end
          end
        end
        if playerStatus ~= nil and playerStatus == ItemModel.PLAYER_STATUS_HIDE then
          i.INJURY_TYPE_VAL = nil
          i.HAS_RED = nil
          i.NUM_YELLOW = nil
        end
      end
    end
  end
  return itemData
end

function ItemModel:getItemStructureByIDWithoutDuplicates(itemIDs, itemContext)
  print("[ItemModel]: getItemStructureByIDWithoutDuplicates(itemContext = " .. tostring(itemContext) .. "): Listing Item structures for " .. tostring(table.getn(itemIDs)) .. " Items...")
  local itemData = self.services.CardService.GetCardListInfoWithoutDuplicates(itemIDs)
  do
    do
      for i, i in ipairs(itemData) do
        i.type = self:toFEType(i.CARD_TYPE, i.CARD_ID, itemContext)
        i.subtype = i.CARD_SUBTYPE or -1
        if i.CARD_TYPE == ItemModel.FUT_ITEM_TYPE.PLAYER then
          local modifiedAttributes = self.services.CardService.GetCardModifiedAttributes(i)
          do
            for i, i in pairs(modifiedAttributes) do
              i[i] = i
            end
          end
        end
        if playerStatus ~= nil and playerStatus == ItemModel.PLAYER_STATUS_HIDE then
          i.INJURY_TYPE_VAL = nil
          i.HAS_RED = nil
          i.NUM_YELLOW = nil
        end
      end
    end
  end
  return itemData
end

function ItemModel:requestMarketValues(items, forceServerCall, onCompleteCallback)
  self.onRequestMarketValuesCompleteCallback = onCompleteCallback
  local valuesRequested = self.services.MarketPriceService.RequestMarketValues(items, forceServerCall)
  if valuesRequested == 0 then
    local data = {}
    data.success = true
    self:_onRequestMarketValueComplete(data)
  end
end

function ItemModel:getContextMenu(item, itemContext, isInField)
  if isInField == nil then
  end
  local isInField = isInField
  local itemFEType = item.type
  local itemBEType = item.CARD_TYPE
  local itemBESubtype = item.CARD_SUBTYPE
  local itemDiscardValue = item.discardValue or nil
  local activeSquadStatus = self:getActiveSquadStatus()
  local activeSquadAvailability = string.format("%d/%d", activeSquadStatus.count, activeSquadStatus.total)
  local isActiveSquadAvailable = tonumber(activeSquadStatus.available) >= 0
  local squadIndex = -1
  if itemFEType == ItemModel.TYPE_PLAYER or itemFEType == ItemModel.TYPE_FIELD_PLAYER or itemFEType == ItemModel.TYPE_MANAGER or itemFEType == ItemModel.TYPE_FIELD_MANAGER then
    squadIndex = self:ActiveSquadIndex(item)
  end
  local isItemInActiveSquad = squadIndex > 0
  local isItemDuplicated = item.duplicated or false
  local isItemActive = item.isActive or false
  local isRedCarded = item.isRedcarded or false
  local isTradeable = item.isTradeable or false
  local contextMenu
  local isQuickListEnabled = false
  local itemQuickListValue = -1
  if isQuickListEnabled then
    local itemMarketValue = self.services.MarketPriceService.GetMarketValue(item)
    itemQuickListValue = itemMarketValue.min
  end
  if itemQuickListValue == -1 or isTradeable == false then
    itemQuickListValue = self.loc.LocalizeString("LTXT_CONTEXT_NA")
  end
  local transferListNotFull = self.services.ItemsService.GetTradePileSize() < ItemModel.MAX_ITEMS_TRANSFER_LIST
  local tradePileStatus = self.services.ItemsService.GetTradePileSize() .. "/" .. ItemModel.MAX_ITEMS_TRANSFER_LIST
  local consumablePileNotFull = self.services.ItemsService.GetConsumablePileSize() < ItemModel.MAX_CONSUMABLES_IN_CLUB
  local consumablePileStatus = self.services.ItemsService.GetConsumablePileSize() .. "/" .. ItemModel.MAX_CONSUMABLES_IN_CLUB
  if itemContext == ItemModel.CONTEXT_FIELD then
    if itemFEType == ItemModel.TYPE_PLAYER or itemFEType == ItemModel.TYPE_FIELD_PLAYER then
      contextMenu = {
        index = -1,
        data = {
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_PLAYER_BIO"),
            clickAction = ACT_CONTEXT_MENU_SHOW_BIO,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconPlayerBio"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_SWAP_WITH_CLUB"),
            clickAction = ACT_CONTEXT_MENU_SWAP_WITH_CLUB,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconSwapWithClub"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_REMOVE_FROM_SQUAD"),
            clickAction = ACT_CONTEXT_MENU_REMOVE_FROM_SQUAD,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconRemoveFromSquad"
          },
          {
            name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_SEND_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
            clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
            enabled = not isRedCarded and transferListNotFull and isTradeable,
            image = nil,
            info = isTradeable and tradePileStatus or nil,
            propImage = "$IconSendToTransfer"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_APPLY_CONSUMABLE"),
            clickAction = ACT_CONTEXT_MENU_APPLY_CONSUMABLE,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconApplyConsumable"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
            clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
            enabled = true,
            image = "$CoinsSmallIcon",
            info = itemDiscardValue,
            propImage = "$IconQuickSell"
          }
        }
      }
      if isQuickListEnabled == true then
        if self.services.CardService.IsContractInContextMenuEnabled() and isInField then
          table.insert(contextMenu.data, 7, {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_LIST"),
            clickAction = ACT_CONTEXT_MENU_QUICK_LIST,
            enabled = transferListNotFull and isTradeable,
            image = "$CoinsSmallIcon",
            info = itemQuickListValue,
            propImage = nil
          })
        else
          table.insert(contextMenu.data, 6, {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_LIST"),
            clickAction = ACT_CONTEXT_MENU_QUICK_LIST,
            enabled = transferListNotFull and isTradeable,
            image = "$CoinsSmallIcon",
            info = itemQuickListValue,
            propImage = nil
          })
        end
      end
    elseif itemFEType == ItemModel.TYPE_MANAGER or itemFEType == ItemModel.TYPE_FIELD_MANAGER then
      contextMenu = {
        index = -1,
        data = {
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_SWAP_WITH_CLUB"),
            clickAction = ACT_CONTEXT_MENU_SWAP_WITH_CLUB,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconSwapWithClub"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_REMOVE_FROM_SQUAD"),
            clickAction = ACT_CONTEXT_MENU_REMOVE_FROM_SQUAD,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconRemoveFromSquad"
          },
          {
            name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_SEND_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
            clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
            enabled = transferListNotFull and isTradeable,
            image = nil,
            info = isTradeable and tradePileStatus or nil,
            propImage = "$IconSendToTransfer"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_APPLY_CONSUMABLE"),
            clickAction = ACT_CONTEXT_MENU_APPLY_CONSUMABLE,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconApplyConsumable"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
            clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
            enabled = true,
            image = "$CoinsSmallIcon",
            info = itemDiscardValue,
            propImage = "$IconQuickSell"
          }
        }
      }
    elseif itemFEType == ItemModel.TYPE_NONE or itemFEType == ItemModel.TYPE_FIELD_NONE then
      local locString = itemBEType == ItemModel.FUT_ITEM_TYPE.EMPTY_MANAGER and "FUT_AddManager" or "LTXT_SQD_PLAYER_ITEM_CONTEXT_MENU_ADD"
      contextMenu = {
        index = -1,
        data = {
          {
            name = self.loc.LocalizeString(locString),
            clickAction = ACT_CONTEXT_MENU_SWAP_WITH_CLUB,
            info = "",
            propImage = "$IconAddPlayer"
          }
        }
      }
    else
      error("Invalid parameters.")
    end
  elseif itemContext == ItemModel.CONTEXT_STICKERBOOK then
    if itemFEType == ItemModel.TYPE_PLAYER or itemFEType == ItemModel.TYPE_FIELD_PLAYER then
      contextMenu = {
        index = -1,
        data = {
          {
            name = self.loc.LocalizeString("LTXT_CMN_PLAYER_ITEM_CONTEXT_MENU_SEND_TO_ACTIVE_SQUAD"),
            clickAction = ACT_CONTEXT_MENU_MOVE_TO_SQUAD,
            enabled = isActiveSquadAvailable and not isItemInActiveSquad,
            image = nil,
            info = activeSquadAvailability,
            propImage = "$IconSendToSquad"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_PLAYER_BIO"),
            clickAction = ACT_CONTEXT_MENU_SHOW_BIO,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconPlayerBio"
          },
          {
            name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
            clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
            enabled = not isRedCarded and transferListNotFull and isTradeable,
            image = nil,
            info = isTradeable and tradePileStatus or nil,
            propImage = "$IconSendToTransfer"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
            clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
            enabled = true,
            image = "$CoinsSmallIcon",
            info = itemDiscardValue,
            propImage = "$IconQuickSell"
          }
        }
      }
      if isQuickListEnabled == true then
        table.insert(contextMenu.data, 4, {
          name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_LIST"),
          clickAction = ACT_CONTEXT_MENU_QUICK_LIST,
          enabled = transferListNotFull and isTradeable,
          image = "$CoinsSmallIcon",
          info = itemQuickListValue,
          propImage = nil
        })
      end
    elseif itemFEType == ItemModel.TYPE_MANAGER or itemFEType == ItemModel.TYPE_FIELD_MANAGER then
      if itemBEType == ItemModel.FUT_ITEM_TYPE.MANAGER then
        contextMenu = {
          index = -1,
          data = {
            {
              name = self.loc.LocalizeString("LTXT_CMN_PLAYER_ITEM_CONTEXT_MENU_SEND_TO_ACTIVE_SQUAD"),
              clickAction = ACT_CONTEXT_MENU_MOVE_TO_SQUAD,
              enabled = not isItemInActiveSquad,
              image = nil,
              info = nil,
              propImage = "$IconSendToSquad"
            },
            {
              name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
              clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
              enabled = transferListNotFull and isTradeable,
              image = nil,
              info = isTradeable and tradePileStatus or nil,
              propImage = "$IconSendToTransfer"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
              clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
              enabled = true,
              image = "$CoinsSmallIcon",
              info = itemDiscardValue,
              propImage = "$IconQuickSell"
            }
          }
        }
      else
        contextMenu = {
          index = -1,
          data = {
            {
              name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
              clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
              enabled = transferListNotFull and isTradeable,
              image = nil,
              info = isTradeable and tradePileStatus or nil,
              propImage = "$IconSendToTransfer"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
              clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
              enabled = true,
              image = "$CoinsSmallIcon",
              info = itemDiscardValue,
              propImage = "$IconQuickSell"
            }
          }
        }
      end
    elseif itemFEType == ItemModel.TYPE_CONSUMABLE then
      if itemBEType == ItemModel.FUT_ITEM_TYPE.DEVELOPMENT then
        contextMenu = {
          index = -1,
          data = {
            {
              name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
              clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
              enabled = transferListNotFull and isTradeable,
              image = nil,
              info = isTradeable and tradePileStatus or nil,
              propImage = "$IconSendToTransfer"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
              clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
              enabled = true,
              image = "$CoinsSmallIcon",
              info = itemDiscardValue,
              propImage = "$IconQuickSell"
            }
          }
        }
      else
        contextMenu = {
          index = -1,
          data = {
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MAKE_ACTIVE"),
              clickAction = ACT_CONTEXT_MENU_MAKE_ACTIVE,
              enabled = not isItemActive,
              image = nil,
              info = nil,
              propImage = "$IconMakeActive"
            },
            {
              name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
              clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
              enabled = not isItemActive and transferListNotFull and isTradeable,
              image = nil,
              info = isTradeable and tradePileStatus or nil,
              propImage = "$IconSendToTransfer"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
              clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
              enabled = not isItemActive,
              image = "$CoinsSmallIcon",
              info = itemDiscardValue,
              propImage = "$IconQuickSell"
            }
          }
        }
      end
    end
  elseif itemContext == ItemModel.CONTEXT_STORE then
    if itemFEType == ItemModel.TYPE_PLAYER or itemFEType == ItemModel.TYPE_FIELD_PLAYER then
      contextMenu = {
        index = -1,
        data = {
          {
            name = self.loc.LocalizeString("LTXT_CMN_PLAYER_ITEM_CONTEXT_MENU_SEND_TO_ACTIVE_SQUAD"),
            clickAction = ACT_CONTEXT_MENU_MOVE_TO_SQUAD,
            enabled = isActiveSquadAvailable and not isItemDuplicated and not isItemInActiveSquad,
            image = nil,
            info = activeSquadAvailability,
            propImage = "$IconSendToSquad"
          },
          {
            name = self.loc.LocalizeString("LTXT_SQD_PLAYER_ITEM_CONTEXT_MENU_STORE_IN_CLUB"),
            clickAction = ACT_CONTEXT_MENU_MOVE_TO_CLUB,
            enabled = not isItemDuplicated,
            image = nil,
            info = nil,
            propImage = "$IconSendToClub"
          },
          {
            name = self.loc.LocalizeString("LTXT_SQD_PLAYER_ITEM_CONTEXT_MENU_PLAYER_BIO"),
            clickAction = ACT_CONTEXT_MENU_SHOW_BIO,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconPlayerBio"
          },
          {
            name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
            clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
            enabled = transferListNotFull and isTradeable,
            image = nil,
            info = isTradeable and tradePileStatus or nil,
            propImage = "$IconSendToTransfer"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
            clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
            enabled = true,
            image = "$CoinsSmallIcon",
            info = itemDiscardValue,
            propImage = "$IconQuickSell"
          }
        }
      }
      if isQuickListEnabled == true then
        table.insert(contextMenu.data, 5, {
          name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_LIST"),
          clickAction = ACT_CONTEXT_MENU_QUICK_LIST,
          enabled = transferListNotFull and isTradeable,
          image = "$CoinsSmallIcon",
          info = itemQuickListValue,
          propImage = nil
        })
      end
    elseif itemFEType == ItemModel.TYPE_MANAGER or itemFEType == ItemModel.TYPE_FIELD_MANAGER then
      if itemBEType == ItemModel.FUT_ITEM_TYPE.MANAGER then
        contextMenu = {
          index = -1,
          data = {
            {
              name = self.loc.LocalizeString("LTXT_CMN_PLAYER_ITEM_CONTEXT_MENU_SEND_TO_ACTIVE_SQUAD"),
              clickAction = ACT_CONTEXT_MENU_MOVE_TO_SQUAD,
              enabled = not isItemDuplicated and not isItemInActiveSquad,
              image = nil,
              info = nil,
              propImage = "$IconSendToSquad"
            },
            {
              name = self.loc.LocalizeString("LTXT_SQD_PLAYER_ITEM_CONTEXT_MENU_STORE_IN_CLUB"),
              clickAction = ACT_CONTEXT_MENU_MOVE_TO_CLUB,
              enabled = not isItemDuplicated,
              image = nil,
              info = nil,
              propImage = "$IconSendToClub"
            },
            {
              name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
              clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
              enabled = transferListNotFull and isTradeable,
              image = nil,
              info = isTradeable and tradePileStatus or nil,
              propImage = "$IconSendToTransfer"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
              clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
              enabled = true,
              image = "$CoinsSmallIcon",
              info = itemDiscardValue,
              propImage = "$IconQuickSell"
            }
          }
        }
      else
        contextMenu = {
          index = -1,
          data = {
            {
              name = self.loc.LocalizeString("LTXT_SQD_PLAYER_ITEM_CONTEXT_MENU_STORE_IN_CLUB"),
              clickAction = ACT_CONTEXT_MENU_MOVE_TO_CLUB,
              enabled = not isItemDuplicated,
              image = nil,
              info = nil,
              propImage = "$IconSendToClub"
            },
            {
              name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
              clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
              enabled = transferListNotFull and isTradeable,
              image = nil,
              info = isTradeable and tradePileStatus or nil,
              propImage = "$IconSendToTransfer"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
              clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
              enabled = true,
              image = "$CoinsSmallIcon",
              info = itemDiscardValue,
              propImage = "$IconQuickSell"
            }
          }
        }
      end
    elseif itemBESubtype == ItemModel.FUT_ITEM_SUBTYPE.FREE_CARD_PACKS then
      contextMenu = {
        index = -1,
        data = {
          {
            name = self.loc.LocalizeString("FUT_NI_Actions_Pack"),
            clickAction = ACT_CONTEXT_MENU_APPLY_CONSUMABLE_PACK,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconItemYes"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
            clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
            enabled = true,
            image = "$CoinsSmallIcon",
            info = itemDiscardValue,
            propImage = "$IconQuickSell"
          }
        }
      }
    elseif itemBESubtype == ItemModel.FUT_ITEM_SUBTYPE.AWARD_PACKS then
      contextMenu = {
        index = -1,
        data = {
          {
            name = self.loc.LocalizeString("FUT_NI_Actions_UnlockCard"),
            clickAction = ACT_CONTEXT_MENU_APPLY_CONSUMABLE,
            enabled = true,
            image = nil,
            info = nil,
            propImage = "$IconItemYes"
          },
          {
            name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
            clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
            enabled = true,
            image = "$CoinsSmallIcon",
            info = itemDiscardValue,
            propImage = "$IconQuickSell"
          }
        }
      }
    elseif itemFEType == ItemModel.TYPE_CONSUMABLE then
      if itemBEType == ItemModel.FUT_ITEM_TYPE.DEVELOPMENT then
        contextMenu = {
          index = -1,
          data = {
            {
              name = self.loc.LocalizeString("LTXT_SQD_PLAYER_ITEM_CONTEXT_MENU_STORE_IN_CLUB"),
              clickAction = ACT_CONTEXT_MENU_MOVE_TO_CLUB,
              enabled = not isItemDuplicated and consumablePileNotFull,
              image = nil,
              info = consumablePileStatus,
              propImage = "$IconSendToClub"
            },
            {
              name = isTradeable and self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE") or self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_UNTRADEABLE"),
              clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
              enabled = transferListNotFull and isTradeable,
              image = nil,
              info = isTradeable and tradePileStatus or nil,
              propImage = "$IconSendToTransfer"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
              clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
              enabled = true,
              image = "$CoinsSmallIcon",
              info = itemDiscardValue,
              propImage = "$IconQuickSell"
            }
          }
        }
      else
        contextMenu = {
          index = -1,
          data = {
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MAKE_ACTIVE"),
              clickAction = ACT_CONTEXT_MENU_MAKE_ACTIVE,
              enabled = not isItemDuplicated and not isItemActive,
              image = nil,
              info = nil,
              propImage = "$IconMakeActive"
            },
            {
              name = self.loc.LocalizeString("LTXT_SQD_PLAYER_ITEM_CONTEXT_MENU_STORE_IN_CLUB"),
              clickAction = ACT_CONTEXT_MENU_MOVE_TO_CLUB,
              enabled = not isItemDuplicated and not isItemActive,
              image = nil,
              info = nil,
              propImage = "$IconSendToClub"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_MOVE_TO_TRADE_PILE"),
              clickAction = ACT_CONTEXT_MENU_SEND_TO_TRADE_PILE,
              enabled = transferListNotFull and isTradeable,
              image = nil,
              info = isTradeable and tradePileStatus or nil,
              propImage = "$IconSendToTransfer"
            },
            {
              name = self.loc.LocalizeString("LTXT_CMN_ITEM_CONTEXT_MENU_QUICK_SELL"),
              clickAction = ACT_CONTEXT_MENU_QUICK_SELL,
              enabled = true,
              image = "$CoinsSmallIcon",
              info = itemDiscardValue,
              propImage = "$IconQuickSell"
            }
          }
        }
      end
    end
  elseif itemContext == ItemModel.CONTEXT_TOTW and (itemFEType == ItemModel.TYPE_PLAYER or itemFEType == ItemModel.TYPE_FIELD_PLAYER) then
    contextMenu = {
      index = -1,
      data = {
        {
          name = self.loc.LocalizeString("LTXT_SQD_PLAYER_ITEM_CONTEXT_MENU_PLAYER_BIO"),
          clickAction = ACT_CONTEXT_MENU_SHOW_BIO,
          enabled = true,
          image = nil,
          info = nil,
          propImage = "$IconPlayerBio"
        }
      }
    }
  end
  return contextMenu
end

function ItemModel:getConsumableBoost(target, consumable)
  assert(target ~= nil, "Target player/manager Item is nil.")
  assert(consumable ~= nil, "Target consumable Item is nil")
  local boost = {
    applicable = true,
    affectsAllPlayers = false,
    affectsAllAttributes = false,
    description = consumable.description
  }
  if target.CARD_TYPE ~= ItemModel.FUT_ITEM_TYPE.PLAYER and target.CARD_TYPE ~= ItemModel.FUT_ITEM_TYPE.MANAGER and consumable.CARD_TYPE ~= ItemModel.FUT_ITEM_TYPE.DEVELOPMENT then
    boost.applicable = false
    return boost
  end
  if consumable.subtype == ItemModel.FUT_ITEM_SUBTYPE.TEAM_TALKS then
    boost.consumableType = self.loc.LocalizeString("FUT_MYCLUB_CONSUMABLES_TEAMTALKS_EARNED")
    boost.originalValue = target.stat7
    boost.itemValue = consumable.incValue
    boost.staffModifierValue = target.staff7
    boost.staffBonus = math.floor(boost.staffModifierValue * 0.01 * boost.itemValue)
    boost.staffModifier = string.format("%d (%s)", boost.staffBonus, self.loc.FormatLocString("LTXT_VAR_EISM_PERCENT", {
      tostring(boost.staffModifierValue)
    }))
    boost.newValue = boost.originalValue + boost.itemValue + boost.staffBonus
    boost.affectsAllPlayers = consumable.numPlayers == 0
    if boost.newValue > 99 then
      boost.newValue = 99
    end
  elseif consumable.subtype == ItemModel.FUT_ITEM_SUBTYPE.HEALING then
    local injuryType = self.services.CardService.GetPlayerStatus(target, false).INJURY_TYPE_VAL
    local injuryLength = tonumber(self.services.CardService.GetPlayerStatus(target, false).INJURY_LENGTH)
    local healingType = consumable.incType
    local healingLength = consumable.incValue
    boost.affectsAllAttributes = healingType == 7
    if injuryType == 8 or injuryLength == 0 then
      boost.applicable = false
      boost.warning = self.loc.LocalizeString("FUT_INS_HEALING_ALL")
    elseif injuryType == healingType or healingType == 7 then
      boost.consumableType = self.loc.LocalizeString("FUT_MYCLUB_CONSUMABLES_HEALING_EARNED")
      boost.originalValue = injuryLength
      boost.itemValue = healingLength
      boost.staffModifierValue = target[string.format("staffHealing%d", injuryType)]
      boost.staffBonus = math.floor(boost.staffModifierValue * 0.01 * boost.itemValue)
      boost.staffModifier = string.format("%d (%s)", boost.staffBonus, self.loc.FormatLocString("LTXT_VAR_EISM_PERCENT", {
        tostring(boost.staffModifierValue)
      }))
      boost.newValue = injuryLength - healingLength - boost.staffBonus
      if boost.newValue <= 0 then
        boost.newValue = 0
      end
    else
      boost.applicable = false
      boost.warning = self.loc.LocalizeString("PlayerNotInjuredHere")
    end
  elseif consumable.subtype == ItemModel.FUT_ITEM_SUBTYPE.FITNESS then
    boost.consumableType = self.loc.LocalizeString("FUT_MYCLUB_CONSUMABLES_FITNESS_EARNED")
    boost.originalValue = target.stat8
    boost.itemValue = consumable.incValue
    boost.staffModifierValue = target.staff8
    boost.staffBonus = math.floor(boost.staffModifierValue * 0.01 * boost.itemValue)
    boost.staffModifier = string.format("%d (%s)", boost.staffBonus, self.loc.FormatLocString("LTXT_VAR_EISM_PERCENT", {
      tostring(boost.staffModifierValue)
    }))
    boost.newValue = boost.originalValue + boost.itemValue + boost.staffBonus
    boost.affectsAllPlayers = consumable.numPlayers == 0
    if boost.newValue > 99 then
      boost.newValue = 99
    end
  elseif consumable.subtype == ItemModel.FUT_ITEM_SUBTYPE.TRAINING_SESSION then
    local baseAttributes = self.services.CardService.GetCardModifiedAttributes(target)
    boost.affectsAllAttributes = consumable.numPlayers == 0
    if consumable.numPlayers == 0 then
      boost.consumableType = self.loc.LocalizeString("FUT_MYCLUB_CONSUMABLES_TRAINING_EARNED")
      boost.originalValue = "--"
      boost.itemValue = consumable.incValue
      boost.staffModifierValue = 0
      boost.staffBonus = 0
      boost.staffModifier = "--"
      boost.newValue = "--"
    else
      local attributeType = consumable.incType + 1
      boost.consumableType = self.loc.LocalizeString("FUT_MYCLUB_CONSUMABLES_TRAINING_EARNED")
      boost.originalValue = baseAttributes[string.format("baseAttribute%d", attributeType)]
      boost.itemValue = consumable.incValue
      boost.staffModifierValue = target[string.format("staff%d", attributeType)]
      boost.staffBonus = math.floor(boost.staffModifierValue * 0.01 * boost.itemValue)
      boost.staffModifier = string.format("%d (%s)", boost.staffBonus, self.loc.FormatLocString("LTXT_VAR_EISM_PERCENT", {
        tostring(boost.staffModifierValue)
      }))
      boost.newValue = boost.originalValue + boost.itemValue + boost.staffBonus
      if boost.newValue > 99 then
        boost.newValue = 99
      end
    end
  elseif consumable.subtype == ItemModel.FUT_ITEM_SUBTYPE.TACTIC_TRAINING then
    if consumable.incType ~= target.positionID then
      boost.applicable = false
      boost.warning = self.loc.FormatLocString("FUT_INS_TACTICS_TRAINING", {
        self:getPlayerPositionByID(consumable.incType)
      })
    else
      boost.consumableType = self.loc.LocalizeString("FUT_MYCLUB_CONSUMABLES_TRAINING_EARNED")
      boost.originalValue = target.position
      boost.itemValue = consumable.value
      boost.staffModifierValue = 0
      boost.staffBonus = 0
      boost.staffModifier = "--"
      boost.newValue = self:getPlayerPositionByID(consumable.incValue)
    end
  elseif consumable.subtype == ItemModel.FUT_ITEM_SUBTYPE.PLAYER_ADVANCED_TRAINING or consumable.subtype == ItemModel.FUT_ITEM_SUBTYPE.MANAGER_ADVANCED_TRAINING then
    boost.consumableType = self.loc.LocalizeString("FUT_MYCLUB_CONSUMABLES_TRAINING_EARNED")
    boost.originalValue = target.formation
    boost.itemValue = consumable.footer
    boost.staffModifierValue = 0
    boost.staffBonus = 0
    boost.staffModifier = "--"
    boost.newValue = consumable.footer
  else
    error("Unhandled subtype: " .. consumable.subtype)
  end
  print("[ItemModel]: getConsumableBoost(): Getting boost for target CARD_ID = " .. tostring(target.CARD_ID) .. ", of consumable CARD_ID " .. tostring(consumable.CARD_ID) .. "...")
  TableUtil.print(boost)
  return boost
end

function ItemModel:addItemToActiveSquad(item, itemContext, onCompleteCallback, onFailCallback)
  print("[ItemModel]: addItemToActiveSquad(): Adding Item:")
  TableUtil.print(item)
  self.onAddItemToActiveSquadCompleteCallback = onCompleteCallback
  self.onAddItemToActiveSquadFailCallback = onFailCallback
  local emptySpot = self:getActiveSquadStatus()
  if item.type == ItemModel.TYPE_MANAGER or item.type == ItemModel.TYPE_FIELD_MANAGER or item.type == ItemModel.TYPE_ESCROW_MANAGER then
    emptySpot.available = emptySpot.total
  end
  if item.type == ItemModel.TYPE_PLAYER and emptySpot.count == emptySpot.total then
    if self.onAddItemToActiveSquadFailCallback ~= nil then
      self.onAddItemToActiveSquadFailCallback()
    end
    self.onAddItemToActiveSquadCompleteCallback = nil
    self.onAddItemToActiveSquadFailCallback = nil
  elseif itemContext == ItemModel.CONTEXT_ESCROW or itemContext == ItemModel.CONTEXT_STORE then
    function self.onMoveCardCompleteCallback(response)
      self:_onAddItemToActiveSquadComplete(response, item, emptySpot.available)
    end
    
    self.services.CardService.MoveCard({item}, self:getDeckTypeFromItemContext(itemContext), ItemModel.DECK_TYPE.DECK_TYPE_SQUAD)
  elseif itemContext == ItemModel.CONTEXT_STICKERBOOK then
    if self.services.FUTSquadManagementService.AddPlayer(emptySpot.available, item) then
      self.services.FUTSquadManagementService.SaveCurrentSquad()
      if self.onAddItemToActiveSquadCompleteCallback ~= nil then
        self.onAddItemToActiveSquadCompleteCallback()
      end
    elseif self.onAddItemToActiveSquadFailCallback ~= nil then
      self.onAddItemToActiveSquadFailCallback()
    end
    self.onAddItemToActiveSquadCompleteCallback = nil
    self.onAddItemToActiveSquadFailCallback = nil
  else
    if self.services.FUTSquadManagementService.AddPlayer(emptySpot.available, item) then
      if self.onAddItemToActiveSquadCompleteCallback ~= nil then
        self.onAddItemToActiveSquadCompleteCallback()
      end
    elseif self.onAddItemToActiveSquadFailCallback ~= nil then
      self.onAddItemToActiveSquadFailCallback()
    end
    self.onAddItemToActiveSquadCompleteCallback = nil
    self.onAddItemToActiveSquadFailCallback = nil
  end
end

function ItemModel:addItemToActiveSquadAt(item, positionIndex, itemContext, onCompleteCallback, onFailCallback)
  print("[ItemModel]: addItemToActiveSquadAt(positionIndex = " .. positionIndex .. ", itemContext = " .. (itemContext or ItemModel.CONTEXT_DEFAULT) .. ")")
  self.onAddItemToActiveSquadAtCompleteCallback = onCompleteCallback
  self.onAddItemToActiveSquadAtFailCallback = onFailCallback
  if itemContext == ItemModel.CONTEXT_ESCROW then
    local activeSquad = self.services.FUTSquadManagementService.GetSquadLineup()
    if activeSquad[positionIndex + 1].CARD_ID > 0 then
      if self.onAddItemToActiveSquadAtFailCallback ~= nil then
        self.onAddItemToActiveSquadAtFailCallback(ERROR_OTHER)
      end
      self.onAddItemToActiveSquadAtCompleteCallback = nil
      self.onAddItemToActiveSquadAtFailCallback = nil
    else
      function self.onMoveCardCompleteCallback(response)
        self:_onAddItemToActiveSquadAtComplete(response, item, positionIndex)
      end
      
      self.services.CardService.MoveCard({item}, self:getDeckTypeFromItemContext(itemContext), ItemModel.DECK_TYPE.DECK_TYPE_SQUAD)
    end
  elseif itemContext == ItemModel.CONTEXT_STICKERBOOK then
    if self.services.FUTSquadManagementService.AddPlayer(positionIndex, item) then
      self.services.FUTSquadManagementService.SaveCurrentSquad()
      if self.onAddItemToActiveSquadAtCompleteCallback ~= nil then
        self.onAddItemToActiveSquadAtCompleteCallback()
      end
    elseif self.onAddItemToActiveSquadAtFailCallback ~= nil then
      self.onAddItemToActiveSquadAtFailCallback(ERROR_PLAYER_ALREADY_EXISTS)
    end
    self.onAddItemToActiveSquadAtCompleteCallback = nil
    self.onAddItemToActiveSquadAtFailCallback = nil
  else
    if self.services.FUTSquadManagementService.AddPlayer(positionIndex, item) then
      self.services.FUTSquadManagementService.SaveCurrentSquad(true)
      if self.onAddItemToActiveSquadAtCompleteCallback ~= nil then
        self.onAddItemToActiveSquadAtCompleteCallback()
      end
    elseif self.onAddItemToActiveSquadAtFailCallback ~= nil then
      self.onAddItemToActiveSquadAtFailCallback(ERROR_PLAYER_ALREADY_EXISTS)
    end
    self.onAddItemToActiveSquadAtCompleteCallback = nil
    self.onAddItemToActiveSquadAtFailCallback = nil
  end
end

function ItemModel:removeItemFromActiveSquadAt(item, positionIndex)
  print("[ItemModel]: removeItemFromActiveSquadAt(positionIndex = " .. positionIndex .. ")")
  self.services.FUTSquadManagementService.RemovePlayer(positionIndex, item.CARD_ID)
  self.services.FUTSquadManagementService.SaveCurrentSquad(true)
end

function ItemModel:swapPlayersInActiveSquadByPositionIndex(activePositionIndex, passivePositionIndex)
  print("[ItemModel]: swapPlayersInActiveSquadByPositionIndex(activePositionIndex = " .. activePositionIndex .. ", passivePositionIndex = " .. passivePositionIndex .. ")")
  self.services.FUTSquadManagementService.SwapPlayers(activePositionIndex, passivePositionIndex)
  self.services.FUTSquadManagementService.SaveCurrentSquad(false)
end

function ItemModel:makeItemActive(item, onCompleteCallback, onFailCallback)
  print("[ItemModel]: makeItemActive(): Activating Item:")
  TableUtil.print(item)
  self.onMakeItemActiveCompleteCallback = onCompleteCallback
  self.onMakeItemActiveFailCallback = onFailCallback
  self.services.MyClubService.MakeCardActive(item)
end

function ItemModel:applyItem(item, targets, onCompleteCallback, onFailCallback)
  print("[ItemModel]: applyItem(): Applying Item:")
  TableUtil.print(item)
  print("[ItemModel]: applyItem(): ...to targets:")
  TableUtil.print(targets)
  self.onApplyItemCompleteCallback = onCompleteCallback
  self.onApplyItemFailCallback = onFailCallback
  self.services.CardService.ApplyCard(item, targets)
end

function ItemModel:addItemToTradePile(item, itemContext, onCompleteCallback, onFailCallback)
  print("[ItemModel]: addItemToTradePile(itemContext = " .. (itemContext or ItemModel.CONTEXT_DEFAULT) .. "): Adding Item:")
  TableUtil.print(item)
  self.onAddItemToTradePileCompleteCallback = onCompleteCallback
  self.onAddItemToTradePileFailCallback = onFailCallback
  function self.onMoveCardCompleteCallback(response)
    self:_onAddItemToTradePileComplete(response, itemContext)
  end
  
  self.services.CardService.MoveCard(item, self:getDeckTypeFromItemContext(itemContext), ItemModel.DECK_TYPE.DECK_TYPE_ESCROW)
end

function ItemModel:quickSellItem(item, itemContext, onCompleteCallback, onFailCallback)
  print("[ItemModel]: quickSellItem(): Quick selling Item:")
  TableUtil.print(item)
  assert(itemContext, "[ItemModel]: quickSellItem(): Item context not defined.")
  self.onQuickSellCompleteCallback = onCompleteCallback
  self.onQuickSellFailCallback = onFailCallback
  self.services.CardService.CardsDiscardCardList(item, self:getDeckTypeFromItemContext(itemContext))
end

function ItemModel:getDeckTypeFromItemContext(itemContext)
  if itemContext == ItemModel.CONTEXT_FIELD then
    return ItemModel.DECK_TYPE.DECK_TYPE_SQUAD
  elseif itemContext == ItemModel.CONTEXT_ESCROW then
    return ItemModel.DECK_TYPE.DECK_TYPE_ESCROW
  elseif itemContext == ItemModel.CONTEXT_STICKERBOOK then
    return ItemModel.DECK_TYPE.DECK_TYPE_STICKERBOOK
  elseif itemContext == ItemModel.CONTEXT_STORE then
    return ItemModel.DECK_TYPE.DECK_TYPE_UNASSIGNED
  else
    error("[ItemModel]: getDeckTypeFromItemContext(" .. tostring(itemContext) .. "): The specified Item context does not have a matching deck type.")
    return nil
  end
end

function ItemModel:generateBlankItem(itemType)
  return {
    UUID = 0,
    UUID_UPPER = 0,
    UUID_LOWER = 0,
    CARD_ID = 0,
    CARD_TYPE = itemType,
    id = -1,
    level = 0,
    rarity = 0
  }
end

function ItemModel:getActiveSquadStatus()
  local squad = self.services.FUTSquadManagementService.GetSquadLineup()
  local size = #squad
  local rtn = {
    available = -1,
    count = 0,
    total = size
  }
  do
    do
      for i = 1, size do
        if squad[i].CARD_ID == 0 then
          if rtn.available < 0 then
            rtn.available = i - 1
          end
        else
          rtn.count = rtn.count + 1
        end
      end
    end
  end
  return rtn
end

function ItemModel:ActiveSquadIndex(item)
  local manager = self.services.FUTSquadManagementService.GetManagerID()
  local squad = self.services.FUTSquadManagementService.GetSquadLineup()
  local size = table.getn(squad)
  if item.CARD_ID == manager.CARD_ID then
    return size
  else
    do
      for i = 1, size do
        if squad[i].CARD_ID == item.CARD_ID then
          return i
        end
      end
    end
  end
  return -1
end

function ItemModel:errorPopup(title, message)
  local buttonOk = VirtualButton:new({
    nav = self.nav,
    icon = "$FooterIconNo",
    label = "LTXT_CMN_BACK",
    clickEvents = {
      "evt_hide_popup"
    }
  })
  local popupData = {
    title = title,
    message = message,
    buttons = {buttonOk}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function ItemModel:_onAddItemToActiveSquadComplete(response, item, positionIndex)
  print("[ItemModel]: _onAddItemToActiveSquadComplete(response = " .. (response and tostring(response.success) or "nil") .. ")")
  if response.success == true then
    if self.services.FUTSquadManagementService.AddPlayer(positionIndex, item) then
      self.services.FUTSquadManagementService.SaveCurrentSquad()
      if self.onAddItemToActiveSquadCompleteCallback ~= nil then
        self.onAddItemToActiveSquadCompleteCallback()
      end
    elseif self.onAddItemToActiveSquadFailCallback ~= nil then
      self.onAddItemToActiveSquadFailCallback()
    end
  elseif self.onAddItemToActiveSquadFailCallback ~= nil then
    self.onAddItemToActiveSquadFailCallback(response.reason)
  end
  self.onAddItemToActiveSquadCompleteCallback = nil
  self.onAddItemToActiveSquadFailCallback = nil
end

function ItemModel:_onAddItemToActiveSquadAtComplete(response, item, positionIndex)
  print("[ItemModel]: _onAddItemToActiveSquadAtComplete(response = " .. (response and tostring(response.success) or "nil") .. ")")
  if response.success == true then
    self.services.FUTSquadManagementService.AddPlayer(positionIndex, item)
    self.services.FUTSquadManagementService.SaveCurrentSquad()
    if self.onAddItemToActiveSquadAtCompleteCallback ~= nil then
      self.onAddItemToActiveSquadAtCompleteCallback()
    end
  elseif self.onAddItemToActiveSquadAtFailCallback ~= nil then
    self.onAddItemToActiveSquadAtFailCallback(response.reason)
  end
  self.onAddItemToActiveSquadAtCompleteCallback = nil
  self.onAddItemToActiveSquadAtFailCallback = nil
end

function ItemModel:_onMakeItemActiveComplete(response)
  print("[ItemModel]: _onMakeItemActiveComplete(response = " .. (response and tostring(response.status) or "nil") .. ")")
  if response.status == "OK" then
    if self.onMakeItemActiveCompleteCallback ~= nil then
      self.onMakeItemActiveCompleteCallback()
    end
  elseif self.onMakeItemActiveFailCallback ~= nil then
    self.onMakeItemActiveFailCallback()
  end
  self.onMakeItemActiveCompleteCallback = nil
  self.onMakeItemActiveFailCallback = nil
end

function ItemModel:_onApplyItemComplete(response)
  print("[ItemModel]: _onApplyItemComplete(response = " .. (response and tostring(response.success) or "nil") .. ")")
  if response.success == true then
    self.services.FUTSquadManagementService.SaveCurrentSquad(true)
    if self.onApplyItemCompleteCallback ~= nil then
      self.onApplyItemCompleteCallback()
    end
  elseif self.onApplyItemFailCallback ~= nil then
    self.onApplyItemFailCallback()
  end
  self.onApplyItemCompleteCallback = nil
  self.onApplyItemFailCallback = nil
end

function ItemModel:_onAddItemToTradePileComplete(response, itemContext)
  print("[ItemModel]: _onAddItemToTradePileComplete(response = " .. (response and tostring(response.success) or "nil") .. ")")
  if response.success == true then
    if self.onAddItemToTradePileCompleteCallback ~= nil then
      self.onAddItemToTradePileCompleteCallback()
    end
  elseif self.onAddItemToTradePileFailCallback ~= nil then
    self.onAddItemToTradePileFailCallback(response.reason)
  end
  self.onAddItemToTradePileCompleteCallback = nil
  self.onAddItemToTradePileFailCallback = nil
end

function ItemModel:_onQuickSellComplete(response)
  print("[ItemModel]: _onQuickSellComplete(response = " .. (response and tostring(response.success) or "nil") .. ")")
  if response.success == true then
    if self.onQuickSellCompleteCallback ~= nil then
      self.onQuickSellCompleteCallback()
    end
  elseif self.onQuickSellFailCallback ~= nil then
    self.onQuickSellFailCallback()
  end
  self.onQuickSellCompleteCallback = nil
  self.onQuickSellFailCallback = nil
end

function ItemModel:_onRequestMarketValueComplete(response)
  print("[ItemModel]: _onRequestMarketValueComplete(response = " .. (response and tostring(response.success) or "nil") .. ")")
  if self.onRequestMarketValuesCompleteCallback ~= nil then
    self.onRequestMarketValuesCompleteCallback(response.success)
  end
  self.onRequestMarketValuesCompleteCallback = nil
end

function ItemModel:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.MakeClubCardActive then
    self:_onMakeItemActiveComplete(data)
  elseif eventType == EVENT_TYPES.OnCardsDiscard then
    self:_onQuickSellComplete(data)
  elseif eventType == EVENT_TYPES.OnCardsMoved then
    if self.onMoveCardCompleteCallback then
      self.onMoveCardCompleteCallback(data)
      self.onMoveCardCompleteCallback = nil
    end
  elseif eventType == EVENT_TYPES.ApplyCard then
    self:_onApplyItemComplete(data)
  elseif eventType == EVENT_TYPES.ClubSearch then
    if self.searchId == data.searchId then
      self.searchId = -1
    end
  elseif eventType == EVENT_TYPES.OnMarketPriceReceived then
    print("ItemModel:handleEvent:OnMarketPriceReceived = " .. tostring(data))
    self:_onRequestMarketValueComplete(data)
    TableUtil.print(data)
  end
end

function ItemModel:moveItemToClub(item, itemContext, onCompleteCallback, onFailCallback)
  print("[ItemModel]: moveItemToClub(itemContext = " .. (itemContext or ItemModel.CONTEXT_DEFAULT) .. "): Adding Item:")
  TableUtil.print(item)
  self.onMoveItemToClubCompleteCallback = onCompleteCallback
  self.onMoveItemToClubFailCallback = onFailCallback
  function self.onMoveCardCompleteCallback(response)
    self:_onMoveItemToClubComplete(response, itemContext)
  end
  
  self.services.CardService.MoveCard(item, self:getDeckTypeFromItemContext(itemContext), ItemModel.DECK_TYPE.DECK_TYPE_STICKERBOOK)
end

function ItemModel:_onMoveItemToClubComplete(response, itemContext)
  print("[ItemModel]: _onMoveItemToClubComplete(response = " .. (response and tostring(response.success) or "nil") .. ")")
  if response.success == true then
    if self.onMoveItemToClubCompleteCallback ~= nil then
      self.onMoveItemToClubCompleteCallback()
    end
  elseif self.onMoveItemToClubFailCallback ~= nil then
    self.onMoveItemToClubFailCallback(response.reason)
  end
  self.onMoveItemToClubCompleteCallback = nil
  self.onMoveItemToClubFailCallback = nil
end

function ItemModel:finalize()
  self.onAddItemToActiveSquadCompleteCallback = nil
  self.onAddItemToActiveSquadFailCallback = nil
  self.onAddItemToActiveSquadAtCompleteCallback = nil
  self.onAddItemToActiveSquadAtFailCallback = nil
  self.onMakeItemActiveCompleteCallback = nil
  self.onMakeItemActiveFailCallback = nil
  self.onApplyItemCompleteCallback = nil
  self.onApplyItemFailCallback = nil
  self.onAddItemToTradePileCompleteCallback = nil
  self.onAddItemToTradePileFailCallback = nil
  self.onMoveItemToClubCompleteCallback = nil
  self.onMoveItemToClubFailCallback = nil
  self.onQuickSellCompleteCallback = nil
  self.onQuickSellFailCallback = nil
  self.onMoveCardCompleteCallback = nil
  self.onRequestMarketValuesCompleteCallback = nil
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return ItemModel
