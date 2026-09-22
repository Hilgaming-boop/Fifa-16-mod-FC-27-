-- Modified By MVNPROD Youtube Channel --
local Timer = ...
local TeamRoster = {}

local bndPlayerList = "bnd_player_list"

local ACT_PLAYER_SELECT = "act_player_select"
local ACT_HIDE = "act_hide"
local ACT_RELEASE = "act_release"
local ACT_TOGGLE = "act_toggle"

local PlayerListData = {}
local teamPlayers = {}
local playerData
local statsubs = {"gs", "cs", "yc", "rc"}
local toggle = false
local selectedPlayerIndex = 1
local isPanelOpen = false

local statNameBindings = {
    "bnd_stat1_name",
    "bnd_stat2_name", 
    "bnd_stat3_name",
    "bnd_stat4_name",
    "bnd_stat5_name",
    "bnd_stat6_name"
}

local statColorBindings = {
    "bnd_stat1_color",
    "bnd_stat2_color",
    "bnd_stat3_color", 
    "bnd_stat4_color",
    "bnd_stat5_color",
    "bnd_stat6_color"
}

local positionOrder = {
    GK = 0, SW = 1, RWB = 2, RB = 3, RCB = 4, CB = 5, LCB = 6, LB = 7, LWB = 8, 
    RDM = 9, CDM = 10, LDM = 11, RM = 12, RCM = 13, CM = 14, LCM = 15, LM = 16, 
    RAM = 17, CAM = 18, LAM = 19, RF = 20, CF = 21, LF = 22, RW = 23, RS = 24, 
    ST = 25, LS = 26, LW = 27
}

TeamID = 0

function TeamRoster:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService"),
    gameSetup = o.api("GameSetupService")
  }
  TeamID = currentSelectedTeamID
  o.visible = true
  o.rowvisible = true
  o.panelvisible = false
  o.statvisible = false
  o.infovisible = true
  o.currentIndex = 0
  o.oldIndex = -1
-- ðŸ”¹ O.IM SUBSCRIBE EVENT
o.im.Subscribe("bnd_leaguebackground", function()
  local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_leaguebackground", bg)
end)
  o.im.Subscribe("bnd_background_visible", function()
    o:publishBg()
  end)
  o.im.Subscribe("bnd_table_visible", function()
    o:publishBg()
  end)  
  o.im.Subscribe("bnd_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_loading_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_rowvisible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_panelvisible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_panelanim", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_plstat_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_plinfo_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_team_crest", function()
    o.im.Publish("bnd_team_crest", {
      name = "$Crest",
      id = TeamID
    })
  end)
  o.im.Subscribe("bnd_team_name", function()
    o.im.Publish("bnd_team_name", o.loc.LocalizeString("TeamName_Abbr15_"..TeamID))
  end)
  o.im.Subscribe("bnd_player_avatar", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_name", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_ID", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_position", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_value", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_fitness", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_suspstatus", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_country", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_rating", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_3d_player", function()
    o:publishPlayerInfo()
  end)

  for i = 1, 6 do
    o.im.Subscribe(statNameBindings[i], function()
      o:publishStatNames()
    end)
  end

  for i = 1, 6 do
    o.im.Subscribe(statColorBindings[i], function()
      o:publishStatColors()
    end)
  end

  for i = 1, 6 do
    o.im.Subscribe("bnd_player_stat"..i, function()
      o:publishPlayerInfo()
    end)
  end
        
  for i = 1, 4 do
    o.im.Subscribe("bnd_friendly".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end
  for i = 1, 4 do
    o.im.Subscribe("bnd_dom".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end
  for i = 1, 4 do
    o.im.Subscribe("bnd_total".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end

  o:Init()
  o.im.Subscribe(bndPlayerList, function()
    o:publishPlayerRows()
  end)
  o.im.RegisterAction(ACT_PLAYER_SELECT, function(actionName, data)
  if data then
    o:selectPlayer(data)
  end
end)
  o.im.RegisterAction(ACT_HIDE, function(actionName, data)
    o:hidePanel()
  end)
  o.im.RegisterAction(ACT_RELEASE, function(actionName, data)
    o:releasePlayer()
  end)
  o.im.RegisterAction(ACT_TOGGLE, function(actionName, data)
    o:toggleView()
  end)
  
  return o
end

local function getStatColor(value)
    if value >= 85 then
        return "0x00FF00"  -- Verde
    elseif value >= 75 then
        return "0xFFFF00"  -- Amarillo 
    elseif value >= 65 then
        return "0xFFA500"  -- Naranja 
    else
        return "0xFF0000"  -- Rojo 
    end
end

function TeamRoster:publishStatNames()
    if not playerData then return end
    
    local statNames = {}
    
    if playerData.position == "GK" then
        statNames = {
            "Diving",
            "Handling", 
            "Kicking", 
            "Reflexes",
            "Speed",
            "Positioning"
        }
    else
        statNames = {
            "Pace",
            "Shooting",
            "Passing",
            "Dribbling", 
            "Defending",
            "Physical"
        }
    end
    
    for i = 1, 6 do
        self.im.Publish(statNameBindings[i], statNames[i] or "")
    end
end

function TeamRoster:publishStatColors()
    if not playerData then return end
    
    for i = 1, 6 do
        local statValue = playerData["stat"..i] or 0
        local statColor = getStatColor(statValue)
        self.im.Publish(statColorBindings[i], statColor)
    end
end

function TeamRoster:publishVisible()
  self.im.Publish("bnd_visible", self.visible)
  if self.panelvisible then
    self.im.Publish("bnd_rowvisible", false)
  else
    self.im.Publish("bnd_rowvisible", self.rowvisible)
  end
  self.im.Publish("bnd_panelvisible", self.panelvisible)
  self.im.Publish("bnd_panelanim", 0.0)
  self.im.Publish("bnd_plstat_visible", self.statvisible)
  self.im.Publish("bnd_plinfo_visible", self.infovisible)
  self.im.Publish("bnd_loading_visible", not self.visible)

  if self.panelvisible then
    local animValues = {0.1, 0.3, 0.4, 0.6, 0.7, 0.8, 1.0}

    local function setNextAnim(index)
      if index > #animValues then
        print("[TeamRoster]: Animation sequence completed")
        self.panelAnimTimer = nil
        return
      end

      local value = animValues[index]
      local delay = 0.05

      self.panelAnimTimer = Timer:new({
        id = "panelAnimTimer_" .. index,
        interval = delay,
        reps = 1,
        onTimerComplete = function(id, repsCount)
          print(string.format("[TeamRoster]: Timer completed, setting bnd_panelanim to %.1f", value))
          self.im.Publish("bnd_panelanim", value)
          setNextAnim(index + 1)
        end
      })
      self.panelAnimTimer:start()
      print(string.format("[TeamRoster]: Started %d-second timer to set bnd_panelanim to %.1f", delay, value))
    end

    setNextAnim(1)
  end
end

function TeamRoster:publishPlayerInfo(data)
  local suspStatus = "Ok"
  local fitnessStatus = "Match Fit"
  local plgoals = 0
  local plcleansheets = 0
  local plyellowcard = 0
  local plredcard = 0
  if data then 
    self.im.Publish("bnd_player_avatar", {
      name = "$Head",
      id = data.CARD_ID
    })
    self.im.Publish("bnd_player_name", data.lastname)
    self.im.Publish("bnd_player_ID", data.CARD_ID)
    self.im.Publish("bnd_player_position", data.position)
    self.im.Publish("bnd_player_country", {
      name = "$Flag128x128",
      id = data.nationalityID
    })
    if isSuspended[data.playerName] == 2 then
      fitnessStatus = "Injured. Back (" .. injuryRecoveryDate[data.playerName] .. ")"
    elseif isSuspended[data.playerName] == 1 then
      suspStatus = "Red Carded"
    end
    local playerInfo = getPlayerInfo(data.CARD_ID, currentSelectedTeamID)
    local Index = playerInfo and playerInfo.index
    local repCount = playerReplacementCount(currentSelectedTeamID, data.position)
    local days = daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
    local playervalue, minvalue = computeTransferValue(GetPlayerAge(data.CARD_ID), data.rating, data.position, Index, repCount, days)
    self.im.Publish("bnd_value", "$" .. self.loc.LocalizeInteger(playervalue))
    self.im.Publish("bnd_suspstatus", suspStatus)
    self.im.Publish("bnd_fitness", data.days)
    self.im.Publish("bnd_player_rating", data.rating)
    self.im.Publish("bnd_3d_player", {
      name = "$PLAYER_ID",
      id = data.CARD_ID
    })
    
    for i = 1, 6 do
      local statValue = data["stat"..i] or 0
      self.im.Publish("bnd_player_stat"..i, statValue)
    end
    
    self:publishStatNames()
    
    self:publishStatColors()
    
    plgoals = GOALS[data.CARD_ID] or 0
    plcleansheets = 0
    plyellowcard = yellowCardRecords[data.playerName] or 0
    plredcard = redCardRecords[data.playerName] or 0
    local stats = {plgoals, plcleansheets, plyellowcard, plredcard}
    for i = 1, 4 do
      self.im.Publish("bnd_dom" .. statsubs[i], stats[i])
      self.im.Publish("bnd_friendly" .. statsubs[i], 0)
      self.im.Publish("bnd_total" .. statsubs[i], stats[i])
    end
  end
end

-- 初始化数据
function TeamRoster:Init()
  local teamInfo = self.services.SquadManagementService.GetTeamInfo(TeamID)
  local teamLineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, TeamID, 0)
  
  local previouslySelectedId = nil
  if selectedPlayerIndex >= 1 and selectedPlayerIndex <= #PlayerListData then
    previouslySelectedId = PlayerListData[selectedPlayerIndex].playerInfo.CARD_ID
  end
  
  PlayerListData = {}
  
  if teamLineup then
    for i = 1, #teamLineup do
      local obj = {
        assetId = teamLineup[i].CARD_ID,
        clickAction = "act_player_select",
        playerInfo = teamLineup[i],
        data = {
          PlayerAvatar = {
            name = "$Head",
            id = teamLineup[i].CARD_ID
          },
          PlayerName = teamLineup[i].playerName,
          Rating = teamLineup[i].rating,
          clickAction = "act_player_select",
          FontColor = "0xffffff",
          Position = teamLineup[i].position
        }
      }
      table.insert(PlayerListData, obj)
    end
    
    table.sort(PlayerListData, function(a, b)
      local aPos = positionOrder[a.playerInfo.position] or 99
      local bPos = positionOrder[b.playerInfo.position] or 99
      
      if aPos ~= bPos then
        return aPos < bPos
      else
        return tonumber(a.playerInfo.rating) > tonumber(b.playerInfo.rating)
      end
    end)
    
    if previouslySelectedId then
      for i, player in ipairs(PlayerListData) do
        if player.playerInfo.CARD_ID == previouslySelectedId then
          selectedPlayerIndex = i
          break
        end
      end
    else
      selectedPlayerIndex = 1
    end
  end
end

function TeamRoster:publishPlayerRows()
  for i, v in ipairs(PlayerListData) do
    v.data.PlayerAvatar = {
      name = "$Head",
      id = v.playerInfo.CARD_ID
    }
    v.data.PlayerName = v.playerInfo.playerName
    v.data.Rating = v.playerInfo.rating
    v.data.clickAction = v.clickAction
    v.data.FontColor = "0xffffff"
    v.data.Position = v.playerInfo.position
    if i == selectedPlayerIndex then
      v.data.Background = {
        name = "$League_Bg",
        id = 0
      }
    else
      v.data.Background = nil
    end
  end
  
  self.im.Publish(bndPlayerList, PlayerListData)
  
  if #PlayerListData > 0 and selectedPlayerIndex >= 1 and selectedPlayerIndex <= #PlayerListData then
    playerData = PlayerListData[selectedPlayerIndex].playerInfo    
    self:publishPlayerInfo(playerData)
  end
end

function TeamRoster:selectPlayer(data)
  if not data or not data.id then return end
  
  local playerIndex = data.id + 1
  if playerIndex < 1 or playerIndex > #PlayerListData then return end
  
  if selectedPlayerIndex ~= playerIndex then
    selectedPlayerIndex = playerIndex
    self:publishPlayerRows()
    
    playerData = PlayerListData[playerIndex].playerInfo    
    self:publishPlayerInfo(playerData)
    
    if not isPanelOpen then
      isPanelOpen = true
      self.panelvisible = false
      self.im.Publish("bnd_panelvisible", false)
      self.im.Publish("bnd_rowvisible", true)
      self:publishVisible()
    end
  else
    isPanelOpen = not isPanelOpen
    self.panelvisible = isPanelOpen
    self.im.Publish("bnd_panelvisible", isPanelOpen)
    self.im.Publish("bnd_rowvisible", not isPanelOpen)
    self:publishVisible()
  end
end

function TeamRoster:publishPlayerDetail(data)
  local playerIndex = data.id + 1
  self.oldIndex = self.currentIndex
  self.currentIndex = playerIndex
  if self.oldIndex == self.currentIndex then
    self.panelvisible = true
    self.im.Publish("bnd_panelvisible", false)
    self.im.Publish("bnd_rowvisible", true)
    self:publishVisible()
  end
  playerData = PlayerListData[playerIndex].playerInfo    
  self:publishPlayerInfo(playerData)  
end

function TeamRoster:hidePanel()
  isPanelOpen = false
  self.panelvisible = false
  self.im.Publish("bnd_panelvisible", false)
  self.im.Publish("bnd_rowvisible", true)
  self:publishVisible()
end

function TeamRoster:toggleView()
  if toggle == false then
    self.im.Publish("bnd_plinfo_visible", false)
    self.im.Publish("bnd_plstat_visible", true)
    toggle = true
  else
    self.im.Publish("bnd_plinfo_visible", true)
    self.im.Publish("bnd_plstat_visible", false)
    toggle = false
  end
end

function TeamRoster:releasePlayer()
  if not playerData then return end
  
  self:showReleasePopup()
    
  Timer:new({
    interval = 0.3,
    reps = 1,
    onTimerComplete = function()
      local success = releasePlayer(playerData.CARD_ID, currentSelectedTeamID)
      if success then
        local currentScrollPosition = selectedPlayerIndex
        
        PlayerListData = {}
        self:Init()
        
        if currentScrollPosition > #PlayerListData then
          selectedPlayerIndex = #PlayerListData
        else
          selectedPlayerIndex = currentScrollPosition
        end
        
        self:publishPlayerRows()
        self.panelvisible = false 
        isPanelOpen = false
        self.im.Publish("bnd_panelvisible", false)
        self.im.Publish("bnd_rowvisible", true)
        self:publishVisible()
      end
    end
  }):start()
end

function TeamRoster:update(elapsedTime)
  if self.panelAnimTimer then
    self.panelAnimTimer:update(elapsedTime)
  end
end

function TeamRoster:finalize()
  if self.panelAnimTimer then
    self.panelAnimTimer:finalize()
    self.panelAnimTimer = nil
    print("[TeamRoster]: Panel anim timer finalized")
  end
  
  for i = 1, 6 do
    self.im.Unsubscribe(statNameBindings[i])
  end
  
  for i = 1, 6 do
    self.im.Unsubscribe(statColorBindings[i])
  end
  
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe("bnd_loading_visible")
  self.im.Unsubscribe("bnd_team_crest")
  self.im.Unsubscribe("bnd_team_name")
  self.im.Unsubscribe("bnd_player_name")
  self.im.Unsubscribe("bnd_player_avatar")
  self.im.Unsubscribe("bnd_player_ID")
  self.im.Unsubscribe("bnd_player_position")
  self.im.Unsubscribe("bnd_player_country")
  self.im.Unsubscribe("bnd_player_rating")
  self.im.Unsubscribe("bnd_3d_player")
  for i = 1, 6 do
    self.im.Unsubscribe("bnd_player_stat"..i)
  end
  self.im.Unsubscribe(bndPlayerList)
  self.im.UnregisterAction(ACT_PLAYER_SELECT)
end

return TeamRoster