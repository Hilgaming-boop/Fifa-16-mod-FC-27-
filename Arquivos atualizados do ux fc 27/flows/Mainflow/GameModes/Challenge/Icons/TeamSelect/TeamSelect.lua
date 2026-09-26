
local TeamSelect = {}

local bndTeamList = "bnd_team_list"

local ACT_TEAM_SELECT = "act_team_select"

local TeamListData = {}

challengeId = 1
-- Shuffle rivalTeamList
local function shuffleArray(array)
  math.randomseed(os.time()) -- Initialize random seed
  for i = #array, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

TeamList = { 126710,126711,126712,128338,128362,128401,127951,127924,127950,128400,128004,128028,128299,127948,128000,128322,127925,127949,127993,111205,128404,114815,127902,127901,127905,115510,127903,127904,127906 }

shuffleArray(TeamList)

-- Shuffle rivalTeamList
local function shuffleArray(array)
  math.randomseed(os.time()) -- Initialize random seed
  for i = #array, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

rivalTeamList = { 126710,126711,126712,128338,128362,128401,127951,127924,127950,128400,128004,128028,128299,127948,128000,128322,127925,127949,127993,111205,128404,114815,127902,127901,127905,115510,127903,127904,127906 }

-- Shuffle rivalTeamList
shuffleArray(rivalTeamList)
-- Function to update opponentsCount with a random value between 1 and 20
local function updateOpponentsCount()
  return function()
    local opponentsCount = math.random(5, 5) -- Update opponentsCount with a random value between 1 and 20
    return opponentsCount
  end
end

-- Create a function to get the updated opponentsCount based on the new pattern
local getNextOpponentsCount = updateOpponentsCount()

function TeamSelect:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService")
  }
   o.visible = false
   o.im.Subscribe("bnd_visible", function()
     o:publishVisible()
  end)
  o.im.Subscribe("bnd_loading_visible", function()
     o:publishVisible()
  end)
  if currentChallengeInfo[challengeId] and currentChallengeInfo[challengeId].homeID ~= 0 then
   
   o.nav.Event(nil, "evt_team_select")
  else
    o.visible = true
    o:publishVisible()
    o:Init()
    o.im.Subscribe(bndTeamList, function()
      o:publishTeamRows()
    end)
    o.im.RegisterAction(ACT_TEAM_SELECT, function(actionName, data)
     if data then
       o:StartChallenge(data)
      end
    end)
    
  o.player3d = {
    name = "$M_Player3d",
    id = 0
  }
  math.randomseed(os.clock() * 1543 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(5)
  
  o.im.Subscribe("bnd_player3d", function()
    o.player3d.id = random2
    o.im.Publish("bnd_player3d", o.player3d)
  end)
  
  end
  return o
end

function TeamSelect:publishVisible()
   self.im.Publish("bnd_visible", self.visible)
   self.im.Publish("bnd_loading_visible", not self.visible)
end

-- Initialize data
function TeamSelect:Init()
  for i = 1, table.getn(TeamList) do
    local teamInfo = self.services.SquadManagementService.GetTeamInfo(TeamList[i])
    local obj = {
      assetId = TeamList[i],
      clickAction = "act_team_select",
      teamName = self.loc.LocalizeString("TeamName_Abbr15_"..TeamList[i]),
      shortTeamName = self.loc.LocalizeString("TeamName_Abbr3_"..TeamList[i]),
      data = {},
      rating = teamInfo.starRating
    }
    table.insert(TeamListData, obj)
  end
end

-- Initialize battle information with a specified number of opponents
function TeamSelect:InitGrouping(teamId)
  currentChallengeInfo[challengeId] = {
    Index = challengeId,
    homeID = teamId,
    difficulty = 1,
    isSuccess = 0
  }
  local groupingList = {}
  local usedTeamIds = {}  -- Track used team IDs to avoid duplicates
  local opponentsCount = getNextOpponentsCount() -- Get the updated opponents count

  for i = 1, table.getn(rivalTeamList) do
    -- Ensure teams with the same ID do not match and limit the opponents
    if rivalTeamList[i] ~= teamId and not usedTeamIds[rivalTeamList[i]] and opponentsCount > 0 then
      local difficulty = i > 8 and 8 or i
      local isUnlock = i == 1 and true or false

      table.insert(groupingList, {
        [1] = teamId,
        [2] = rivalTeamList[i],
        [3] = "0", -- homescroe
        [4] = "0", -- awayscore
        [5] = false, -- whether the match is completed
        [6] = difficulty, -- match difficulty
        [7] = false, -- whether the team won
        [8] = isUnlock, -- whether it's unlocked
        ["data"] = {}
      })

      -- Mark the rival team ID as used
      usedTeamIds[rivalTeamList[i]] = true
      opponentsCount = opponentsCount - 1
    end
  end

  -- Update opponents count for the next challenge
  getNextOpponentsCount = updateOpponentsCount()

  ChallengeGrouping[challengeId] = groupingList
end

function TeamSelect:publishTeamRows()
  for i, v in ipairs(TeamListData) do
    v.data.TeamCrest = {
      name = "$Crest",
      id = TeamListData[i].assetId
    }
    v.data.TeamName = TeamListData[i].teamName
    v.data.Rating = TeamListData[i].rating
    v.data.clickAction = TeamListData[i].clickAction
    v.data.FontColor = "0xffffff"
    v.data.TeamNameFontColor = "0xffffff"
    v.data.Icon = {
       name = "$IconMatchBall",
       id = 2
    }
    v.data.RightText = "PLAY"
  end
  self.im.Publish(bndTeamList, TeamListData)
end

function TeamSelect:StartChallenge(data)
  local currentTeamIndex = data.id + 1

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
      "evt_hide_popup"
    }
  }
  
  function buttonYes.clickCallback()
    self:InitGrouping(TeamListData[currentTeamIndex].assetId)
    self.nav.Event(nil, "evt_team_select")
  end
  
  local popupData = {
    title = "INFO",
    message = "Confirm to choose "..TeamListData[currentTeamIndex].teamName.." to start the challenge ?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamSelect:finalize()
  self.im.Unsubscribe("bnd_player3d")
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe("bnd_loading_visible")
  self.im.Unsubscribe(bndTeamList)
  self.im.UnregisterAction(ACT_TEAM_SELECT)
  TeamListData = {}
end

return TeamSelect
