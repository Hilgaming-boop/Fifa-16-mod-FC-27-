-- Mod By MVN PROD --
-- League Mode Division --

local Liga = {}

-- Constants
local PRICEMIN, PRICEMAX, WAGEMIN, WAGEMAX, TVALUE = nil, nil, nil, nil, nil
local ID_MIN_BID, ID_MAX_BID, ID_MIN_BUY, ID_MAX_BUY = 1, 2, 3, 4
local BND_MIN_BID, BND_MAX_BID, BND_MIN_BUY, BND_MAX_BUY = "bnd_min_bid", "bnd_max_bid", "bnd_min_buy", "bnd_max_buy"
local ACT_AMOUNT_DECREASE, ACT_AMOUNT_INCREASE = "act_amount_decrease", "act_amount_increase"
local ACT_SEARCH, ACT_RESET = "act_search", "act_reset"
local MAX_VALUE, MIN_VALUE = 200000000, 0
local BND_MATCH_LIST, ACT_ADVANCE = "bnd_match_list", "act_advance"

local ligaId = 1

local currentMatch = {
  HomeTeamID = 0,
  AwayTeamID = 0,
  HomeKitIndex = 0,
  AwayKitIndex = 1
}

local rivalListData = {}
local matchesPlayed = 0

-- Helper functions
local function adjustBid(currentBid, increment, step)
  local newBid = math.floor(currentBid / step) * step + increment
  return math.max(MIN_VALUE, math.min(newBid, MAX_VALUE))
end

function Liga:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    settingsService = o.api("SettingsService"),
    SquadManagementService = o.api("SquadMgtService")
  }

  o.currentOptions = o.services.settingsService.GetCurrentOptions()
  o:Init()
  
  o.playerData = {
    homeTeamCrest = { name = "$Crest", id = GLOBAL_TEAMBUY },
    player = { name = "$Head", id = GLOBAL_PLAYERINSTALL }
  }
  
  o.amountMinBid, o.amountMaxBid, o.amountMinBuy, o.amountMaxBuy = MIN_VALUE, MIN_VALUE, MIN_VALUE, MIN_VALUE
  o.rejectionCount = 0
  
  o:addDataBindings()
  o:addChangeBidValueActions()
  o:addSearchActions()
  o:publishPlayerCount()
  o:updatePricePlaceholders()
  o:subscribeEvents()
  o:getOVR()

  return o
end

-- Initialization
function Liga:Init()
  for _, match in ipairs(LigaGrouping[ligaId]) do
    table.insert(rivalListData, {
      homeID = match[1], awayID = match[2], homeScore = match[4], awayScore = match[5],
      homeScorers = match.data.homeScorers, awayScorers = match.data.awayScorers,
      clickAction = ACT_ADVANCE, isUnlock = match[9], data = {}
    })
  end
end

function Liga:getOVR()
  local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, GLOBAL_TEAMBUY, 0)
  if players then
    for _, player in ipairs(players) do
      if player.CARD_ID == GLOBAL_PLAYERINSTALL then
        playerRating = player.rating or 50
        playerPosition = player.position or "CM"
        break
      end
    end
  end
end

function calculateTransferValue(age, rating, position)
  local baseValue = 15000000
  local ageFactor = (age >= 16 and age <= 20) and 2.5 or (age > 21 and age <= 23) and 2.0 or (age > 23 and age <= 28) and 1.6 or (age > 28 and age <= 32) and 1.2 or 0.7
  local ratingFactor = (rating >= 90) and 2.8 or (rating >= 85) and 2.3 or (rating >= 80) and 1.8 or (rating >= 75) and 1.4 or 1.0
  local positionMultipliers = {
    ["GK"] = 1.0, ["LB"] = 1.2, ["RB"] = 1.2, ["CB"] = 1.5, ["RCB"] = 1.5, ["LCB"] = 1.3,
    ["LWB"] = 1.4, ["RWB"] = 1.4, ["RM"] = 1.4, ["LM"] = 1.4, ["CDM"] = 1.3, ["LDM"] = 1.3, ["RDM"] = 1.3,
    ["CM"] = 1.5, ["CAM"] = 1.6, ["RW"] = 2.0, ["LW"] = 2.0, ["ST"] = 2.1, ["CF"] = 2.1, ["RF"] = 1.8, ["LF"] = 1.8
  }
  local positionFactor = positionMultipliers[position] or 1.0
  local transferValue = baseValue * ageFactor * ratingFactor * positionFactor
  return math.max(MIN_VALUE, math.min(transferValue, MAX_VALUE))
end

function Liga:adjustTransferValue(baseValue, age, rating, replacementCount)
  local adjustedValue = baseValue
  local maxIncrease = MAX_VALUE - baseValue

  if age < 23 and rating >= 80 and math.random() < 0.5 then
    local increase = math.random(10000000, 20000000)
    adjustedValue = adjustedValue + math.min(increase, maxIncrease)
    maxIncrease = maxIncrease - increase
  end

  if rating >= 82 and math.random() < 0.6 then
    local increase = math.random(15000000, 25000000)
    adjustedValue = adjustedValue + math.min(increase, maxIncrease)
    maxIncrease = maxIncrease - increase
  end

  if replacementCount == 1 then
    local increase = math.random(5000000, 10000000)
    adjustedValue = adjustedValue + math.min(increase, maxIncrease)
  end

  return math.min(adjustedValue, MAX_VALUE)
end

-- New function to calculate minimum acceptable value with discounts
function Liga:calculateMinTransferValue(baseValue, age, rating, index, replacementCount)
  local minValue = baseValue
  local maxDiscount = baseValue * 0.5 -- Cap discount at 50%

  -- Condition 1: Old players (30+), 80% chance
  if age >= 30 and math.random() < 0.8 then
    local discount = baseValue * math.random(10, 20) / 100 -- 10%-20%
    minValue = minValue - math.min(discount, maxDiscount)
  end

  -- Condition 2: Players outside starting 11 (index > 11)
  if index > 11 then
    if index >= 18 and math.random() < 0.7 then -- 70% chance for deep reserves
      local discount = baseValue * math.random(15, 25) / 100 -- 15%-25%
      minValue = minValue - math.min(discount, maxDiscount)
    elseif math.random() < 0.4 then -- 40% chance for 12-17
      local discount = baseValue * math.random(5, 15) / 100 -- 5%-15%
      minValue = minValue - math.min(discount, maxDiscount)
    end
  end

  -- Condition 3: High replacement count (3+), not the best among peers
  if replacementCount >= 3 then
    local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, GLOBAL_TEAMBUY, 0)
    local isBest = true
    if players then
      for i = 12, #players do
        local player = players[i]
        if player.position == playerPosition and player.rating > rating then
          isBest = false
          break
        end
      end
    end
    if not isBest and math.random() < 0.6 then -- 60% chance if not the best
      local discount = baseValue * math.random(10, 20) / 100 -- 10%-20%
      minValue = minValue - math.min(discount, maxDiscount)
    end
  end

  return math.max(MIN_VALUE, minValue) -- Ensure it doesn't go below MIN_VALUE
end

playerAge = GetPlayerAge(GLOBAL_PLAYERINSTALL) or 25

-- Event subscriptions
function Liga:subscribeEvents()
  local function publishMatchLabel() self:publishMatchLabel() end
  local events = {
    "bnd_teamname_label", "bnd_teamstats_label", "bnd_status_label", 
    "bnd_transfervalue_label", "bnd_team_logo", "bnd_player_head", 
    "bnd_teammp_label", "bnd_finish_label", BND_MATCH_LIST
  }
  
  for _, event in ipairs(events) do
    self.im.Subscribe(event, publishMatchLabel)
  end
  
  self.im.RegisterAction(ACT_ADVANCE, function(_, data) self:PlayMatch(data) end)
end

-- Data Binding
function Liga:addDataBindings()
  local function updateBinding(bnd, value)
    self.im.Publish(bnd, { value = 1, locValue = self.loc.LocalizeInteger(value) })
    self:updatePricePlaceholders()
  end

  self.im.Subscribe(BND_MIN_BID, function() updateBinding(BND_MIN_BID, self.amountMinBid) end)
  self.im.Subscribe(BND_MAX_BID, function() updateBinding(BND_MAX_BID, TVALUE) end)
  self.im.Subscribe(BND_MIN_BUY, function() updateBinding(BND_MIN_BUY, self.amountMinBuy) end)
  self.im.Subscribe(BND_MAX_BUY, function() updateBinding(BND_MAX_BUY, self.amountMaxBuy) end)
end

-- Bid value changes
function Liga:addChangeBidValueActions()
  self.im.RegisterAction(ACT_AMOUNT_DECREASE, function(actionName, id)
    local binding = ""
    if id == ID_MIN_BID then
      self.amountMinBid = adjustBid(self.amountMinBid, -50000, 50000)
      binding = BND_MIN_BID
    elseif id == ID_MAX_BID then
      self.amountMaxBid = adjustBid(self.amountMaxBid, -1000000, 1000000)
      binding = BND_MAX_BID
    elseif id == ID_MIN_BUY then
      self.amountMinBuy = adjustBid(self.amountMinBuy, -100000, 100000)
      binding = BND_MIN_BUY
    elseif id == ID_MAX_BUY then
      self.amountMaxBuy = adjustBid(self.amountMaxBuy, -500000, 500000)
      WAGEMAX = self.amountMaxBuy
      binding = BND_MAX_BUY
    end
    self:publishAmountSelector(binding)
    self:publishPlayerCount()
    self:findPlayerInfo(GLOBAL_PLAYERINSTALL, GLOBAL_TEAMBUY)
    self:publishMatchLabel()
  end)

  self.im.RegisterAction(ACT_AMOUNT_INCREASE, function(actionName, id)
    local binding = ""
    if id == ID_MIN_BID then
      self.amountMinBid = adjustBid(self.amountMinBid, 50000, 50000)
      binding = BND_MIN_BID
    elseif id == ID_MAX_BID then
      self.amountMaxBid = adjustBid(self.amountMaxBid, 1000000, 1000000)
      binding = BND_MAX_BID
    elseif id == ID_MIN_BUY then
      self.amountMinBuy = adjustBid(self.amountMinBuy, 100000, 100000)
      binding = BND_MIN_BUY
    elseif id == ID_MAX_BUY then
      self.amountMaxBuy = adjustBid(self.amountMaxBuy, 500000, 500000)
      WAGEMAX = self.amountMaxBuy
      binding = BND_MAX_BUY
    end
    self:publishAmountSelector(binding)
    self:publishPlayerCount()
    self:findPlayerInfo(GLOBAL_PLAYERINSTALL, GLOBAL_TEAMBUY)
    self:publishMatchLabel()
  end)
end

-- Search actions
function Liga:addSearchActions()
  self.im.RegisterAction(ACT_SEARCH, function() self:search() end)
  self.im.RegisterAction(ACT_RESET, function() self:resetAllFilters() end)
end

-- Placeholder management
function Liga:updatePricePlaceholders()
  PRICEMIN, PRICEMAX, WAGEMIN, WAGEMAX = self.amountMinBid, self.amountMaxBid, self.amountMinBuy, self.amountMaxBuy
end

-- Cleanup
function Liga:finalize()
  local toUnregister = {ACT_ADVANCE, ACT_AMOUNT_DECREASE, ACT_AMOUNT_INCREASE, ACT_SEARCH, ACT_RESET}
  local toUnsubscribe = {BND_MATCH_LIST, BND_MIN_BID, BND_MAX_BID, BND_MIN_BUY, BND_MAX_BUY, 
                         "bnd_teamname_label", "bnd_teamstats_label", "bnd_status_label", 
                         "bnd_transfervalue_label", "bnd_team_logo", "bnd_player_head", 
                         "bnd_teammp_label", "bnd_finish_label"}

  for _, action in ipairs(toUnregister) do
    self.im.UnregisterAction(action)
  end
  for _, binding in ipairs(toUnsubscribe) do
    self.im.Unsubscribe(binding)
  end
  rivalListData = {}
end

-- Player and Match Management
function Liga:publishMatchLabel()
  local wins, draws, losses = GetTeamWins(currentSelectedTeamID), GetTeamDraws(currentSelectedTeamID), GetTeamLosses(currentSelectedTeamID)
  WINS, DRAWS, LOSSES = wins, draws, losses

  local matchesPlayed = GLOBAL_MATCHUP_COUNT or (wins + draws + losses)
  local winPercentage = matchesPlayed > 0 and (wins / matchesPlayed) * 100 or 0
  winPercentage = string.format("%.2f", winPercentage)

  local playerInfo = self:findPlayerInfo(GLOBAL_PLAYERINSTALL, GLOBAL_TEAMBUY)
  PLAYERPOSITION, PLAYERINDEX = playerInfo and playerInfo.position or "", playerInfo and playerInfo.index or 0
  
  TVALUE = calculateTransferValue(playerAge, playerRating, playerPosition)
  self.im.Publish("bnd_teamname_label", "")
  self.im.Publish("bnd_team_logo", self.playerData.homeTeamCrest)
  self.im.Publish("bnd_player_head", self.playerData.player)
  if playerInfo then
    self.im.Publish("bnd_teammp_label", "player replacement count is " .. COUNT .. " the player index is " .. PLAYERINDEX)
  else
    self.im.Publish("bnd_teammp_label", "")
  end
  self.im.Publish("bnd_status_label", "")
  self.im.Publish("bnd_transfervalue_label", "€" .. self.loc.LocalizeInteger(TVALUE))
end

function Liga:publishPlayerCount()
  local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, GLOBAL_TEAMBUY, 0)
  local replacementCount = 0
  
  if players then
    local playerInfo = self:findPlayerInfo(GLOBAL_PLAYERINSTALL, GLOBAL_TEAMBUY)
    if playerInfo then
      local playerPosition = playerInfo.position
      for index = 12, #players do
        local player = players[index]
        if player.position == playerPosition then
          replacementCount = replacementCount + 1
        end
      end
    end
  end
  
  self.im.Publish("bnd_status_label", replacementCount .. " replacements for playerID " .. GLOBAL_PLAYERINSTALL .. " in teamID " .. GLOBAL_TEAMBUY)
  COUNT = replacementCount
end

function Liga:findPlayerInfo(playerID, teamID)
  local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)
  if players then
    for index, player in ipairs(players) do
      if player.CARD_ID == playerID then
        return { index = index, position = player.position }
      end
    end
  end
  return nil
end

function Liga:swapPlayersInTeam(teamID, cardIDToSwap)
  local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)
  if not players or #players == 0 then
    print("[Restart]: No players found for teamID " .. teamID)
    return
  end

  local playerToSwap, playerToSwapIndex, playerPositionToMatch = nil, nil, nil
  for index, player in ipairs(players) do
    if player.CARD_ID == cardIDToSwap then
      playerToSwap, playerToSwapIndex, playerPositionToMatch = player, index, player.position
      break
    end
  end

  if not playerToSwap then
    print("[Restart]: Player with CARD_ID " .. cardIDToSwap .. " not found in teamID " .. teamID)
    return
  end

  for index = 12, #players do
    local player = players[index]
    if player.position == playerPositionToMatch then
      players[playerToSwapIndex], players[index] = players[index], players[playerToSwapIndex]
      local updatedPlayerIDs = {}
      for _, player in ipairs(players) do
        table.insert(updatedPlayerIDs, player.CARD_ID)
      end
      self.services.SquadManagementService.SetCurrentPlayerLineup(0, teamID, 0, 0, updatedPlayerIDs)
      print("[Restart]: Swapped player " .. cardIDToSwap .. " with player " .. players[playerToSwapIndex].CARD_ID .. " in teamID " .. teamID)
      return  
    end
  end

  print("[Restart]: No player outside starting lineup found with position " .. playerPositionToMatch .. " to swap with CARD_ID " .. cardIDToSwap .. " in teamID " .. teamID)
end

-- Match Play
function Liga:PlayMatch(data)
  local currentMatchIndex = data.id + 1
  currentLigaData.Index = ligaId
  currentLigaData.round = currentMatchIndex
  local currentMatchData = LigaGrouping[ligaId][currentMatchIndex]
  
  local index = 0
  if currentMatchData[6] == false and currentMatchData[9] == true then
    index = 1
  elseif currentMatchData[6] == true and currentMatchData[9] == true then
    index = 2
  elseif currentMatchData[6] == true and currentMatchData[8] == false and currentMatchData[9] == true then
    index = 2
  end

  if index == 1 then
    currentLigaData.homeID, currentLigaData.awayID = currentLigaInfo[ligaId].homeID, currentMatchData[2]
    currentLigaData.difficulty = currentMatchData[7]
    currentMatch.HomeTeamID, currentMatch.AwayTeamID = currentLigaData.homeID, currentLigaData.awayID
    self:KickOff()
    matchesPlayed = matchesPlayed + 1
  elseif index == 2 then
    currentLigaData.homeID, currentLigaData.awayID = currentLigaInfo[ligaId].homeID, currentMatchData[2]
    currentLigaData.difficulty = currentMatchData[7]
    currentMatch.HomeTeamID, currentMatch.AwayTeamID = currentLigaData.homeID, currentLigaData.awayID
  else
    self:StopMatch()
  end
end

-- Search and Reset
function Liga:search()
  self:publishPlayerCount()
  local playerInfo = self:findPlayerInfo(GLOBAL_PLAYERINSTALL, GLOBAL_TEAMBUY)
  local playerIndex = playerInfo and playerInfo.index or 0
  
  local baseTValue = calculateTransferValue(playerAge, playerRating, playerPosition)
  TVALUE = self:adjustTransferValue(baseTValue, playerAge, playerRating, COUNT)
  local minTValue = self:calculateMinTransferValue(baseTValue, playerAge, playerRating, playerIndex, COUNT)
  
  if WAGEMAX >= minTValue then
    if COUNT < 1 then
      self:Failed("No replacements available")
    elseif WAGEMAX > GLOBAL_FUNDS then
      self:Failed("Insufficient funds")
    else
      -- Use TVALUE as the final cost if WAGEMAX meets it, otherwise use WAGEMAX
      TVALUE = (WAGEMAX >= TVALUE) and TVALUE or WAGEMAX
      self:Successful()
      self:clearSlot()
      self.rejectionCount = 0
    end
  else
    self.rejectionCount = self.rejectionCount + 1
    local message = self.loc.LocalizeString("TeamName_Abbr15_" .. GLOBAL_TEAMBUY) .. " are not impressed by your offer of €" .. self.loc.LocalizeInteger(WAGEMAX) .. " (Target: €" .. self.loc.LocalizeInteger(TVALUE) .. ", Min: €" .. self.loc.LocalizeInteger(minTValue) .. ")"
    self.im.Publish("bnd_status_label", message)
    
    if self.rejectionCount >= 3 then
      self:Failed("Club has rejected your offer too many times")
    elseif WAGEMAX < 0.5 * TVALUE then
      self:Failed("Offer is too low compared to market value")
    elseif GLOBAL_FUNDS < WAGEMAX then 
      self:Failed("You don't have enough funds to complete this transfer")
    end
  end
end

function Liga:resetAllFilters()
  self.amountMinBid, self.amountMaxBid, self.amountMinBuy, self.amountMaxBuy = MIN_VALUE, MIN_VALUE, MIN_VALUE, MIN_VALUE
  self.rejectionCount = 0
  self:publishAmountSelector()
  self:updatePricePlaceholders()
end

function Liga:publishAmountSelector(bindingName)
  if bindingName == nil then
    self:publishAmountSelector(BND_MIN_BID)
    self:publishAmountSelector(BND_MAX_BID)
    self:publishAmountSelector(BND_MIN_BUY)
    self:publishAmountSelector(BND_MAX_BUY)
  else
    self.im.Refresh(bindingName)
  end
end

function Liga:clearSlot()
  if SCOUTINDEX == 1 then SLOTTM1, SLOTPL1 = nil, nil
  elseif SCOUTINDEX == 2 then SLOTTM2, SLOTPL2 = nil, nil
  elseif SCOUTINDEX == 3 then SLOTTM3, SLOTPL3 = nil, nil
  elseif SCOUTINDEX == 4 then SLOTTM4, SLOTPL4 = nil, nil
  elseif SCOUTINDEX == 5 then SLOTTM5, SLOTPL5 = nil, nil
  elseif SCOUTINDEX == 6 then SLOTTM6, SLOTPL6 = nil, nil
  elseif SCOUTINDEX == 7 then SLOTTM7, SLOTPL7 = nil, nil
  elseif SCOUTINDEX == 8 then SLOTTM8, SLOTPL8 = nil, nil
  elseif SCOUTINDEX == 9 then SLOTTM9, SLOTPL9 = nil, nil
  elseif SCOUTINDEX == 10 then SLOTTM10, SLOTPL10 = nil, nil
  end
end

-- Success and Failure Scenarios
function Liga:Failed(reason)
  local buttonYes = {
    icon = "$FooterIconNo",
    label = "Close",
    clickEvents = {"evt_back", "evt_hide_popup"}
  }
  local popupData = {
    title = "TRANSFER FAILED",
    message = reason or "Player is too important to " .. self.loc.LocalizeString("TeamName_Abbr15_" .. GLOBAL_TEAMBUY),
    buttons = {buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function Liga:saveSquad()
  print("[TeamManagementModel]: saveSquad()")
  local playerIDs = {}
  for i = 1, #players do
    playerIDs[i] = players[i].CARD_ID
  end
  self.services.SquadManagementService.SetCurrentPlayerLineup(0, self.teamID, 0, 0, playerIDs)
  self.services.TacticsService.SetFormation(0, self.teamID, self.models.FormationModel:getCurrentFormationID())
  self:checkSquadEligibility()
end

function Liga:Successful()
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Done",
    clickEvents = {"evt_back", "evt_back","evt_squad", "evt_hide_popup"}
  }
  local popupData = {
    title = "TRANSFER SUCCESSFUL",
    message = "Player has joined for €" .. self.loc.LocalizeInteger(TVALUE) .. ". View in squad",
    buttons = {buttonYes}
  }
  
  self.nav.Event(nil, "evt_show_popup", popupData)
  
  local playerInfo = self:findPlayerInfo(GLOBAL_PLAYERINSTALL, GLOBAL_TEAMBUY)
  if playerInfo and playerInfo.index >= 1 and playerInfo.index <= 11 then
    self:swapPlayersInTeam(GLOBAL_TEAMBUY, GLOBAL_PLAYERINSTALL)
    transferPlayer(GLOBAL_PLAYERINSTALL, GLOBAL_TEAMBUY, currentSelectedTeamID)
  else
    transferPlayer(GLOBAL_PLAYERINSTALL, GLOBAL_TEAMBUY, currentSelectedTeamID)
  end
  GLOBAL_FUNDS = GLOBAL_FUNDS - WAGEMAX
end

return Liga