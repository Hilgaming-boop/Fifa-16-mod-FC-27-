--- IMPROVED TEAM SELECT BY MOUNTSA ---
local TeamSelect = {}
local NUM_TABS = 16
local MIN_TEAMS_FOR_CUP = 16
local MAX_TEAMS_FOR_CUP = 16
local DEFAULT_FLAG_ID = 0
for i = 1, 16 do
    _G["BND_TAB" .. i .. "_VISIBLE"] = "bnd_tab" .. i .. "_visible"
end
for i = 1, 16 do
  _G["TAB" .. i] = i
end
local BND_TEAM_RATING = "bnd_team_rating"
local bndTeamList = "bnd_team_list"
local BND_BG_CUP = "bnd_cup_bg"
local ACT_TEAM_SELECT = "act_team_select"
local ACT_CONFIRM = "act_confirm"
local ACT_selected = "act_selected"
local ACT_RANDOM = "act_random"

local OriginalTeamList = { 116326,116020,116010,115998,116280,116009,116033,116017,116325,116011,116343,116035,116034,116016,116012,115997 }

local fixedTeams = {
116326,116020,116010,115998,116280,116009,116033,116017,116325,116011,116343,116035,116034,116016,116012,115997 }

-- TEAM_FLAG_ID yang sesuai untuk team ID baru
local TEAM_FLAG_ID = {
  [116326] = 45, [116020] = 14, [116010] = 14, [115998] = 21,
  [116280] = 27, [116009] = 14, [116033] = 18, [116017] = 14,
  
  [116325] = 45, [116011] = 14, [116343] = 14, [116035] = 18,
  [116034] = 18, [116016] = 14, [116012] = 14, [115997] = 21
}

local filteredList = {}
for _, id in ipairs(OriginalTeamList) do
  local isUsed = false
  for _, fixed in ipairs(fixedTeams) do
    if id == fixed then
      isUsed = true
      break
    end
  end
  if not isUsed then
    table.insert(filteredList, id)
  end
end

local function shuffleArray(array)
  local n = #array
  for i = n, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

shuffleArray(OriginalTeamList)

TeamList = {}
for i = 1, 16 do
  table.insert(TeamList, OriginalTeamList[i])
end

local currentTab = TAB1

cupId = 16

function TeamSelect:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  o.services = {
    SaveLoadService = o.api("SaveLoadService"),
    CountryService = o.api("CountryService"),
    EventManagerService = o.api("EventManagerService"),
    SquadManagementService = o.api("SquadMgtService")
  }
  
  -- Inisialisasi tabTeams dengan team ID baru untuk cupId = 2
  o.tabTeams = {
    [TAB1] = {116326}, [TAB2] = {116020}, [TAB3] = {116010}, [TAB4] = {115998},
    [TAB5] = {116280}, [TAB6] = {116009}, [TAB7] = {116033}, [TAB8] = {116017},
    [TAB9] = {116325}, [TAB10] = {116011}, [TAB11] = {116343}, [TAB12] = {116035},
    [TAB13] = {116034}, [TAB14] = {116016}, [TAB15] = {116012}, [TAB16] = {115997}
  }
  
  o.cupData = {
    cupBg = {
      name = "$Bg_Cup",
      id = cupId
    }
  }
  
  currentCupInfo[cupId] = nil
  QuickCupGrouping[cupId] = nil

  if currentCupInfo[cupId] == nil then
    currentCupInfo[cupId] = { cupIndex = cupId, homeID = 0, awayID = 0 }
  end

  if currentCupInfo[cupId].homeID == 0 and o.services.StorageService then
    local savedId = o.services.StorageService.GetInt("last_selected_team_id") or 0
    if savedId ~= 0 then
      currentCupInfo[cupId].homeID = savedId
    end
  end

  if currentCupInfo[cupId].homeID ~= 0 then
    o.nav.Event(nil, "evt_team_select")
  else
    o:InitGrouping()
    o.im.Subscribe(bndTeamList, function()
      o:publishTeamRows()
    end)
    
    o.im.RegisterAction(ACT_TEAM_SELECT, function(actionName, data)
      if data then
        o:StartQuickCup(data)
      end
    end)
    
    o.im.RegisterAction(ACT_CONFIRM, function(actionName, data)
      if data then
        o:StartQuickCup(data)
      end
    end)
  end
  
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)
  
  o.currentCountryID = -1
  o.buttonsID = {}

  for i = 1, 16 do
    table.insert(o.buttonsID, i)
    o.im.Subscribe("bnd_tab" .. i .. "_visible", function() end)
  end
  
  o.im.Subscribe("bnd_cup_bg", function()
    o.im.Publish("bnd_cup_bg", o.cupData.cupBg)
  end)
  
  o.im.RegisterAction(ACT_selected, function(actionName, data)
    o:HideSelections()
    currentTab = o.buttonsID[data.buttonID + 1]
    o.im.Publish("bnd_tab"..currentTab.."_visible", true)
    o:Init(currentTab)
    o:InitGrouping()
    o.selectedTeamIndex = nil
    o:publishTeamRating()
    o:publishTeamRows()
  end)

  o.im.RegisterAction(ACT_RANDOM, function(actionName, data)
    o:RandomizeTeams()
  end)

  o.teamObjects = {}
  local initialTeamIds = {
    116326,116020,116010,115998,116280,116009,116033,116017,
    116325,116011,116343,116035,116034,116016,116012,115997
  }

  for i, id in ipairs(initialTeamIds) do
    o.teamObjects[i] = {
      name = "$Crest",
      id = id
    }
  end
    
  for i = 1, 16 do
    local key = "bnd_team" .. i
    o.im.Subscribe(key, function()
      o.im.Publish(key, o.teamObjects[i])
    end)
  end
  
  o.im.Subscribe(BND_TEAM_RATING, function()
    o:publishTeamRating()
  end)
  
  return o
end

function TeamSelect:RandomizeTeams()
  local allTeams = {}
  for _, teamId in ipairs(fixedTeams) do
    table.insert(allTeams, teamId)
  end
  for _, teamId in ipairs(filteredList) do
    table.insert(allTeams, teamId)
  end
  
  math.randomseed(os.time())
  for i = #allTeams, 2, -1 do
    local j = math.random(i)
    allTeams[i], allTeams[j] = allTeams[j], allTeams[i]
  end
  
  local selectedTeams = {}
  for i = 1, 16 do
    if allTeams[i] then
      table.insert(selectedTeams, allTeams[i])
    end
  end
  
  for tabIndex = 1, 16 do
    if selectedTeams[tabIndex] then
      self.tabTeams[tabIndex] = {selectedTeams[tabIndex]}
    end
  end
  
  for i = 1, 16 do
    if selectedTeams[i] then
      self.teamObjects[i] = {
        name = "$Crest",
        id = selectedTeams[i]
      }
    end
  end
  
  for i = 1, 16 do
    self.im.Publish("bnd_team" .. i, self.teamObjects[i])
  end
  
  self:Init(currentTab)
  self:publishTeamRating()
  self:publishTeamRows()
  
  self:InitGrouping()
end

function TeamSelect:getFlagIdByTeamId(teamId)
  -- Gunakan service CountryService untuk mendapatkan flag ID yang sesuai
  if self.services.CountryService and self.services.CountryService.GetFlagIdByTeamId then
    local flagId = self.services.CountryService.GetFlagIdByTeamId(teamId)
    if flagId and flagId ~= 0 then
      return flagId
    end
  end
  
  -- Fallback ke mapping manual jika service tidak tersedia atau mengembalikan 0
  return TEAM_FLAG_ID[teamId] or DEFAULT_FLAG_ID
end

function TeamSelect:Init(tabID)
    TeamListData = {} 
    local teamsForTab = self.tabTeams[tabID] or self.tabTeams[TAB1]
    
    for i, teamId in ipairs(teamsForTab) do
        local teamInfo = self.services.SquadManagementService.GetTeamInfo(teamId) or {}
        local flagId = self:getFlagIdByTeamId(teamId)
        
        local obj = {
            assetId = teamId,
            clickAction = "act_team_select",
            teamName = self.loc.LocalizeString("TeamName_Abbr15_"..teamId),
            shortTeamName = self.loc.LocalizeString("TeamName_Abbr3_"..teamId),
            ratingLabel = string.format("%.1f", teamInfo.starRating or 0),
            data = {
                TeamCrest = { name = "$Crest", id = teamId },
                flagCrest = { name = "$Flag128x128", id = flagId },
                TeamName = self.loc.LocalizeString("TeamName_Abbr15_"..teamId),
                Rating = teamInfo.starRating or 0,
                clickAction = "act_team_select",
                FontColor = "0xffffff",
                TeamNameFontColor = "0xffffff",
                Icon = { name = "$IconMatchBall", id = 2 }
            },
            rating = teamInfo.starRating or 0,
            offense = teamInfo.offense or 0,
            midfield = teamInfo.midfield or 0,
            defense = teamInfo.defense or 0
        }
        table.insert(TeamListData, obj)
    end
end

function TeamSelect:InitGrouping()
  currentCupInfo[cupId] = {
    cupIndex = cupId,
    homeID = 0
  }
  local groupingList = {}
  for i = 1, #TeamList do
    local temp = i * 2 - 1
    if temp < #TeamList then
      table.insert(groupingList, {
        [1] = TeamList[temp],
        [2] = TeamList[temp+1],
        [3] = "0",
        [4] = "0",
        [5] = false,
        [6] = 0,
        [7] = false
      })
    end
  end
  QuickCupGrouping[cupId] = groupingList
end

function TeamSelect:publishTeamRating()
  local displayIndex = self.selectedTeamIndex or 1
  if not TeamListData or not TeamListData[displayIndex] then
    self.im.Publish(BND_TEAM_RATING, self:createEmptyRating())
    return
  end
  local teamData = TeamListData[displayIndex]
  local teamRating = {
    attackValue = math.floor(teamData.offense or 0),
    middleValue = math.floor(teamData.midfield or 0),
    defenseValue = math.floor(teamData.defense or 0),
    attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
    middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
    defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF"),
    overallRating = string.format("%.1f", teamData.rating or 0),
    teamName = teamData.teamName or ""
  }
  
  self.im.Publish(BND_TEAM_RATING, teamRating)
end

function TeamSelect:createEmptyRating()
    return {
        attackValue = 0,
        middleValue = 0,
        defenseValue = 0,
        attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
        middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
        defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF"),
        overallRating = "0.0",
        teamName = ""
    }
end

function TeamSelect:publishTeamRows()
  for i, v in ipairs(TeamListData) do
    local teamId = v.assetId
    local flagId = self:getFlagIdByTeamId(teamId)

    v.data.TeamCrest = {
      name = "$Crest",
      id = teamId
    }

    v.data.flagCrest = {
      name = "$Flag128x128",
      id = flagId
    }

    v.data.TeamName = v.teamName
    v.data.Rating = TeamListData[i].rating 
    v.data.clickAction = v.clickAction
    v.data.FontColor = "0xffffff"
    v.data.TeamNameFontColor = "0xffffff"
    v.data.Icon = {
      name = "$IconMatchBall",
      id = 2
    }
  end

  self.im.Publish(bndTeamList, TeamListData)
end

function TeamSelect:StartQuickCup(data)
  local currentTeamIndex = data.id + 1
  currentCupInfo[cupId].homeID = TeamListData[currentTeamIndex].assetId
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {
      "evt_team_select",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "Confirm to Choose \n"..TeamListData[currentTeamIndex].teamName.."\n To Start the Cup Competition?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamSelect:HideSelections()
    for i = 1, 16 do
        self.im.Publish("bnd_tab" .. i .. "_visible", false)
    end
end

function TeamSelect:finalize()
  self.im.Unsubscribe(BND_TEAM_RATING)
  self.im.Unsubscribe(bndTeamList)
  self.im.Unsubscribe("bnd_cup_bg")
  self.im.UnregisterAction(ACT_TEAM_SELECT)
  self.im.UnregisterAction(ACT_CONFIRM)
  self.im.UnregisterAction(ACT_RANDOM)
  for _, tab in ipairs(self.buttonsID) do
    self.im.Unsubscribe("bnd_tab"..tab.."_visible")
  end
  self.im.UnregisterAction(ACT_selected)
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end

return TeamSelect
--- IMPROVED TEAM SELECT BY MOUNTSA ---