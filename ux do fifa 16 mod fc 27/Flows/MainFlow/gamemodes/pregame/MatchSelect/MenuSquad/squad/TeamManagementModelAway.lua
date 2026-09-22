local ItemModel, TableUtil, FormationModel = ...
local MAX_STARTING = 11
local TeamManagementModel = {}
local BND_CHEMISTRY_MATRIX = "bnd_chemistry_matrix"
local BND_STARTING_11 = "bnd_starting_11"
local BND_SUBS_AND_RES = "bnd_subs_and_res"
local BND_TEAM_NAME = "bnd_team_name"
local BND_TEAM_CREST = "bnd_team_crest"
local BND_TEAM_MAN = "bnd_team_man"
local BND_TEAM_RATING = "bnd_team_rating"
local BND_TEAM_RATING_LABEL = "bnd_team_rating_label"
local BND_TEAM_OVERALL = "bnd_team_overall"
local BND_PLAYER_COMPARISON_DATA = "bnd_player_comparison_data"
local ACT_ITEM_SHOW_BIO = "act_item_show_bio"
local ACT_SWAP_PLAYERS = "act_swap_players"
local ACT_COMPARE_PLAYERS = "act_compare_players"
local ACT_SEND_ITEM_DATA = "act_send_item_data"
local BND_PLAYER_RATING = "bnd_player_rating"
local BND_PLAYER_AVATAR = "bnd_player_avatar"
local BND_ACTIVE_PLAYER_VISIBLE = "bnd_active_player_visible"
local BND_PASSIVE_PLAYER_VISIBLE = "bnd_passive_player_visible"
local attributeNames = { "PAC", "SHO", "PAS", "DRI", "DEF", "PHY" }



function TeamManagementModel:new(init)
  print("[TeamManagementModel]: new()")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    FUTSquadManagementService = o.api("FUTSquadManagementService"),
    SquadManagementService = o.api("SquadMgtService"),
    TacticsService = o.api("TacticsService"),
    CardService = o.api("CardService"),
    GameSetupService = o.api("GameSetupService")
  }
  o.teamID = o.services.GameSetupService.GetTeamId(false)
  o.models = {
    ItemModel = ItemModel:new({
      im = o.im,
      api = o.api,
      nav = o.nav,
      loc = o.loc
    }),
    FormationModel = FormationModel:new({
      im = o.im,
      api = o.api,
      nav = o.nav,
      loc = o.loc,
      teamID = o.teamID,
      gamemode = o.gamemode,
      onFormationChangeCallback = function(...)
        o:_onFormationChanged(...)
      end
    })
  }
  o.formationList = o.models.FormationModel:getFormationList()
  o.teamInfo = o.services.SquadManagementService.GetTeamInfo(o.teamID)
  o.players = o:getPlayers(o.teamID)
  o.chemistryMatrix = nil
  o.playerComparisonData = o:getPlayerComparisonData(nil, nil)
  o.im.Subscribe(BND_CHEMISTRY_MATRIX, function() o:_publishChemistryMatrix() end)
  o.im.Subscribe(BND_STARTING_11, function() o:_publishStarting11() end)
  o.im.Subscribe(BND_SUBS_AND_RES, function() o:_publishSubsAndRes() end)
  o.im.Subscribe(BND_TEAM_NAME, function() o:_publishTeamStats(BND_TEAM_NAME) end)
  o.im.Subscribe(BND_TEAM_CREST, function() o:_publishTeamStats(BND_TEAM_CREST) end)
  o.im.Subscribe(BND_TEAM_MAN, function() o:_publishTeamStats(BND_TEAM_MAN) end)
  o.im.Subscribe(BND_TEAM_RATING, function() o:_publishTeamStats(BND_TEAM_RATING) end)
  o.im.Subscribe(BND_TEAM_RATING_LABEL, function() o:_publishTeamRatingLabel() end)
  o.im.Subscribe(BND_TEAM_OVERALL, function() o:_publishTeamStats(BND_TEAM_OVERALL) end)
  o.im.Subscribe(BND_ITEM_COLLECTION_CONTEXT_MENU_VISIBLE, function() end)
  o.im.Subscribe(BND_PLAYER_COMPARISON_DATA, function() o:_publishPlayerComparisonData() end)
  o.im.Subscribe("bnd_active_player_rating", function() end)
  o.im.Subscribe("bnd_passive_player_rating", function() end)
  o.im.Subscribe("bnd_active_player_avatar", function() end)
  o.im.Subscribe("bnd_passive_player_avatar", function() end)
  o.im.Subscribe("bnd_swap1_active", function() end)
  o.im.Subscribe("bnd_swap2_active", function() end)
  o.im.Subscribe("bnd_swap3_active", function() end)
  o.im.Subscribe("bnd_swap1_passive", function() end)
  o.im.Subscribe("bnd_swap2_passive", function() end)
  o.im.Subscribe("bnd_swap3_passive", function() end)
  o.im.Subscribe("bnd_active_player_name", function() end)
  o.im.Subscribe("bnd_passive_player_name", function() end)
  o.im.Subscribe("bnd_active_player_position", function() end)
  o.im.Subscribe("bnd_passive_player_position", function() end)
  o.im.Subscribe(BND_ACTIVE_PLAYER_VISIBLE, function() end)
  o.im.Subscribe(BND_PASSIVE_PLAYER_VISIBLE, function() end)

  o.im.RegisterAction(ACT_ITEM_SHOW_BIO, function(actionName, uniqueID)
    o:showBio(uniqueID.groupID)
  end)
  o.im.RegisterAction(ACT_SWAP_PLAYERS, function(actionName, data)
    o:swapPlayersByIndex(data.activeIndex, data.passiveIndex)
  end)
  o.im.RegisterAction(ACT_COMPARE_PLAYERS, function(actionName, data)
    o:comparePlayers(data.activePlayer, data.passivePlayer)
  end)
  o.im.RegisterAction(ACT_SEND_ITEM_DATA, function(actionName, data)
    o:_compareData(data)
  end)
  return o
end

function TeamManagementModel:getPlayers(teamID)
  print("[TeamManagementModel]: getPlayers()")
  local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0) or {}
  for i, v in ipairs(players) do
    v.id = i - 1
    v.type = ItemModel.TYPE_FIELD_PLAYER
    v.level = self.models.ItemModel:getItemLevelByRating(v.rating)
  end
  return players
end


function TeamManagementModel:comparePlayers(activePlayer, passivePlayer)
    self.playerComparisonData = self:getPlayerComparisonData(activePlayer, passivePlayer)
    self:_publishPlayerComparisonData()

    if activePlayer then
        self.im.Publish("bnd_active_player_rating", activePlayer.rating)
        self.im.Publish("bnd_active_player_avatar", {
            name = "$Head",
            id = activePlayer.CARD_ID or 0
        })
        self.im.Publish("bnd_swap1_active", {
            name = "$Swap1",
            id = activePlayer.CARD_ID or 0
        })
        self.im.Publish("bnd_swap2_active", {
            name = "$Swap2",
            id = activePlayer.CARD_ID or 0
        })
        self.im.Publish("bnd_swap3_active", {
            name = "$Swap3",
            id = activePlayer.CARD_ID or 0
        })
        self.im.Publish("bnd_active_player_name", activePlayer.playerName)

        self.im.Publish("bnd_active_player_position", activePlayer.position)
        
        self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, true)
    else
        self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, false)
    end

    if passivePlayer then
        self.im.Publish("bnd_passive_player_rating", passivePlayer.rating)
        self.im.Publish("bnd_passive_player_avatar", {
            name = "$Head",
            id = passivePlayer.CARD_ID or 0
        })
        self.im.Publish("bnd_swap1_passive", {
            name = "$Swap1",
            id = passivePlayer.CARD_ID or 0
        })
        self.im.Publish("bnd_swap2_passive", {
            name = "$Swap2",
            id = passivePlayer.CARD_ID or 0
        })
        self.im.Publish("bnd_swap3_passive", {
            name = "$Swap3",
            id = passivePlayer.CARD_ID or 0
        })
        self.im.Publish("bnd_passive_player_name", passivePlayer.playerName)
        
        self.im.Publish("bnd_passive_player_position", passivePlayer.position)
        self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, true)
    else
        self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, false)
    end
end

function TeamManagementModel:clearPlayerVisibility()
  self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, false)
  self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, false)
  self:publishSwapAssets()
end

function TeamManagementModel:publishSwapAssets()
  self.im.Publish("bnd_swap1_active", {
    name = "$Swap1",
    id = 0
  })

  self.im.Publish("bnd_swap2_passive", {
    name = "$Swap2",
    id = 0
  })

  self.im.Publish("bnd_swap3_active", {
    name = "$Swap3",
    id = 0
  })
end

function TeamManagementModel:swapPlayersByIndex(activeIndex, passiveIndex)
    print("[TeamManagementModel]: swapPlayersByIndex{" .. activeIndex .. ", " .. passiveIndex .. "}")

    local passivePlayer = self.players[passiveIndex + 1]
    local activePlayer = self.players[activeIndex + 1]
    local activeID = activePlayer.id
    local passiveID = passivePlayer.id

    self.players[passiveIndex + 1] = activePlayer
    self.players[passiveIndex + 1].id = passiveID
    self.players[activeIndex + 1] = passivePlayer
    self.players[activeIndex + 1].id = activeID

    local newActivePlayer = self.players[activeIndex + 1]
    local newPassivePlayer = self.players[passiveIndex + 1]
    self.im.Publish("bnd_active_player_name", activePlayer.playerName)
    self.im.Publish("bnd_active_player_position", activePlayer.position)
    self.im.Publish("bnd_active_player_rating", newActivePlayer.rating)
    self.im.Publish("bnd_active_player_avatar", {
        name = "$Head",
        id = newActivePlayer.CARD_ID or 0
    })
    self.im.Publish("bnd_passive_player_name", passivePlayer.playerName)
    self.im.Publish("bnd_passive_player_position", passivePlayer.position)
    self.im.Publish("bnd_passive_player_rating", newPassivePlayer.rating)
    self.im.Publish("bnd_passive_player_avatar", {
        name = "$Head",
        id = newPassivePlayer.CARD_ID or 0
    })
    self:publishSwapAssets()
end

function TeamManagementModel:getPlayerComparisonData(activePlayer, passivePlayer)
  print("[TeamManagementModel: getPlayerComparisonData(activePlayer = " .. tostring(activePlayer) .. ", passivePlayer = " .. tostring(passivePlayer) .. "): Listing comparison data...")
  local comparisonData = {}
  if activePlayer == nil and passivePlayer == nil then
    comparisonData.attributes = -1
    comparisonData.activeStats = -1
    comparisonData.passiveStats = -1
  else
    assert(activePlayer, "Active player must not be nil to initiate a player comparison.")
    comparisonData.attributes = {}
    comparisonData.activeStats = {}
    comparisonData.passiveStats = {}
    
    -- Custom labels yang ingin Anda gunakan
    local customLabels = {
      " ", 
      " ", 
      " ", 
      " ", 
      " ", 
      " "
    }
    
    for i = 1, 6 do
      -- Gunakan customLabels sebagai ganti label dari player
      comparisonData.attributes[i] = customLabels[i] -- Ganti activePlayer["label" .. i] dengan customLabels[i]
      comparisonData.activeStats[i] = activePlayer["stat" .. i]
      if passivePlayer and passivePlayer.isGoalie == activePlayer.isGoalie then
        comparisonData.passiveStats[i] = passivePlayer["stat" .. i]
      else
        comparisonData.passiveStats[i] = " "
      end
    end
  end
  TableUtil.print(comparisonData)
  return comparisonData
end

function TeamManagementModel:saveSquad()
  print("[TeamManagementModel]: saveSquad()")
  local playerIDs = {}
  for i = 1, #self.players do
    playerIDs[i] = self.players[i].CARD_ID
  end
  self.services.SquadManagementService.SetCurrentPlayerLineup(1, self.teamID, 0, 0, playerIDs)
  self.services.TacticsService.SetFormation(1, self.teamID, self.models.FormationModel:getCurrentFormationID())
end


function TeamManagementModel:_publishStarting11()
  if self.players == nil then
    return
  end
  print("[TeamManagementModel]: _publishStarting11()")
  local starting11 = {}
  for i = 1, MAX_STARTING do
    starting11[i] = self.players[i]
  end
  self.im.Publish(BND_STARTING_11, {data = starting11})
end


function TeamManagementModel:_publishSubsAndRes()
  if self.players == nil then
    return
  end
  print("[TeamManagementModel]: _publishSubsAndRes()")
  local nSubs = self.services.SquadManagementService.GetNumberOfSubs()
  local nRes = self.services.SquadManagementService.GetNumberOfReserves(self.teamID)
  local subs = {}
  local res = {}
  local subsAndRes = {}
  for i = 1, nSubs do
    subs[i] = self.players[i + MAX_STARTING]
  end
  table.insert(subsAndRes, {
    label = self.loc.LocalizeString("LTXT_SQD_SUBSTITUTES"),
    data = subs
  })
  if 0 < nRes then
    for i = 1, nRes do
      res[i] = self.players[i + MAX_STARTING + nSubs]
    end
    table.insert(subsAndRes, {
      label = self.loc.LocalizeString("LTXT_SQD_RESERVES"),
      data = res
    })
  end
  self.im.Publish(BND_SUBS_AND_RES, subsAndRes)
end

function TeamManagementModel:_publishChemistryMatrix()
  print("[TeamManagementModel]: _publishChemistryMatrix()")
  self.chemistryMatrix = self.services.FUTSquadManagementService.GetFormationLinks(self.models.FormationModel:getCurrentFormationID())
  for i, v in ipairs(self.chemistryMatrix) do
    v.PLAYER_LINKSTRENGTH = -1
  end
  self.im.Publish(BND_CHEMISTRY_MATRIX, {
    formation = self.models.FormationModel:getCurrentFormation(),
    chemistryLinks = self.chemistryMatrix
  })
end

function TeamManagementModel:_publishTeamStats(bindingName)
  if bindingName == nil then
    self:_publishTeamStats(BND_TEAM_NAME)
    self:_publishTeamStats(BND_TEAM_CREST)
    self:_publishTeamStats(BND_TEAM_MAN)
    self:_publishTeamStats(BND_TEAM_RATING)
    self:_publishTeamStats(BND_TEAM_OVERALL)
  elseif bindingName == BND_TEAM_NAME then
    self.im.Publish(BND_TEAM_NAME, self.loc.LocalizeString("TeamName_Abbr15_" .. self.teamID))
  elseif bindingName == BND_TEAM_CREST then
    self.im.Publish(BND_TEAM_CREST, {
      name = "$Crest",
      id = self.teamID
    })
  elseif bindingName == BND_TEAM_MAN then
    self.im.Publish(BND_TEAM_MAN, {
      name = "$ManagerCard",
      id = self.teamID
    })
  elseif bindingName == BND_TEAM_RATING then
    self.im.Publish(BND_TEAM_RATING, self.teamInfo.starRating)
  elseif bindingName == BND_TEAM_OVERALL then
    self.im.Publish(BND_TEAM_OVERALL, self.teamInfo.overall)
  else
    print("[TeamManagementModel]: _publishTeamStats(): Team stat unknown.")
  end
end


function TeamManagementModel:_publishPlayerComparisonData()
  self.im.Publish(BND_PLAYER_COMPARISON_DATA, self.playerComparisonData)
end


function TeamManagementModel:_publishTeamRatingLabel()
  local ratingLabel = self.loc.LocalizeString("LTXT_SQD_TEAM_RATING_LABEL")
  ratingLabel = ratingLabel .. "      " .. tostring(self.teamInfo.overall)
  self.im.Publish(BND_TEAM_RATING_LABEL, ratingLabel)
end


function TeamManagementModel:showBio(positionIndex)
    print("[TeamManagementModel]: showBio(" .. (positionIndex or "nil") .. ")")
    local targetPlayers = {}
    for i, v in ipairs(self.players) do
        local player = TableUtil.shallowcopy(v)
        player.type = self.models.ItemModel:toFEType(player.CARD_TYPE, player.CARD_ID)
        table.insert(targetPlayers, player)
    end

    -- Publish player info for selected index (without name)
    local selectedPlayer = self.players[positionIndex + 1]
    if selectedPlayer then
        self.im.Publish("bnd_player_rating", selectedPlayer.rating)
        self.im.Publish("bnd_player_avatar", {
            name = "$Head",
            id = selectedPlayer.CARD_ID
        })
    end

    self.nav.Event(nil, "evt_show_player_bio", {
        targetPlayers = targetPlayers,
        targetPositionIndex = positionIndex
    })
end

function TeamManagementModel:_setPlayerVisibility(activeVisible, passiveVisible)
  self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, activeVisible)
  self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, passiveVisible)
end

function TeamManagementModel:finalize()
    print("[TeamManagementModel]: finalize()")
    
    self.models.ItemModel:finalize()
    self.models.FormationModel:finalize()
    self.im.UnregisterAction(ACT_SWAP_PLAYERS)
    self.im.UnregisterAction(ACT_COMPARE_PLAYERS)
    self.im.UnregisterAction(ACT_ITEM_SHOW_BIO)
    self.im.Unsubscribe(BND_CHEMISTRY_MATRIX)
    self.im.Unsubscribe(BND_STARTING_11)
    self.im.Unsubscribe(BND_SUBS_AND_RES)
    self.im.Unsubscribe(BND_TEAM_NAME)
    self.im.Unsubscribe(BND_TEAM_CREST)
    self.im.Unsubscribe(BND_TEAM_MAN)
    self.im.Unsubscribe(BND_TEAM_RATING)
    self.im.Unsubscribe(BND_TEAM_RATING_LABEL)
    self.im.Unsubscribe(BND_TEAM_OVERALL)
    self.im.Unsubscribe(BND_PLAYER_COMPARISON_DATA)
    self.im.Unsubscribe(BND_PLAYER_AVATAR)
    self.im.Unsubscribe(BND_PLAYER_RATING)
    self.im.Unsubscribe("bnd_active_player_rating")
    self.im.Unsubscribe("bnd_passive_player_rating")
    self.im.Unsubscribe("bnd_active_player_avatar")
    self.im.Unsubscribe("bnd_passive_player_avatar")
    self.im.Unsubscribe("bnd_swap1_active")
    self.im.Unsubscribe("bnd_swap2_active")
    self.im.Unsubscribe("bnd_swap3_active")
    self.im.Unsubscribe("bnd_swap1_passive")
    self.im.Unsubscribe("bnd_swap2_passive")
    self.im.Unsubscribe("bnd_swap3_passive")
    self.im.Unsubscribe(BND_ACTIVE_PLAYER_VISIBLE)
    self.im.Unsubscribe(BND_PASSIVE_PLAYER_VISIBLE)
end
return TeamManagementModel
