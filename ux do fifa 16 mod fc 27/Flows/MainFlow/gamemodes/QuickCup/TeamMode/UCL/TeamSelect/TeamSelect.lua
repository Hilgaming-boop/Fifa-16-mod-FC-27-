-------------------------------------------
-- MOD By LAOSIJI edit ROBER FL  --
-------------------------------------------

local TeamSelect = {}

local bndTeamList = "bnd_team_list"

local ACT_TEAM_SELECT = "act_team_select"

local TeamListData = {}

local cupId = 1
TeamList = {
  243, 112172, 10, 819, 21, 46, 73, 457, 44, 240, 22, 247, 1, 236, 241, 48
}


function TeamSelect:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService")
  }
  
    o.cuplogo = {
      name = "$LeagueLogo",
      id = 2236
    }
    o.team1 = {
      name = "$Crest64x64",
      id = 243
    }
    o.team2 = {
      name = "$Crest64x64",
      id = 112172
    }
    o.team3 = {
      name = "$Crest64x64",
      id = 10
    }
    o.team4 = {
      name = "$Crest64x64",
      id = 819
    }
    o.team5 = {
      name = "$Crest64x64",
      id = 21
    }
    o.team6 = {
      name = "$Crest64x64",
      id = 46
    }
    o.team7 = {
      name = "$Crest64x64",
      id = 73
    }
    o.team8 = {
      name = "$Crest64x64",
      id = 457
    }
    o.team9 = {
      name = "$Crest64x64",
      id = 44
    }
    o.team10 = {
      name = "$Crest64x64",
      id = 240
    }
    o.team11 = {
      name = "$Crest64x64",
      id = 22
    }
    o.team12 = {
      name = "$Crest64x64",
      id = 247
    }
    o.team13 = {
      name = "$Crest64x64",
      id = 1
    }
    o.team14 = {
      name = "$Crest64x64",
      id = 236
    }
    o.team15 = {
      name = "$Crest64x64",
      id = 241
    }
    o.team16 = {
      name = "$Crest64x64",
      id = 48
    }
    
    o.im.Subscribe("bnd_cuplogo", function()
    o.im.Publish("bnd_cuplogo", o.cuplogo)
  end)
  o.im.Subscribe("bnd_team1", function()
    o.im.Publish("bnd_team1", o.team1)
  end)
  o.im.Subscribe("bnd_team2", function()
    o.im.Publish("bnd_team2", o.team2)
  end)
  o.im.Subscribe("bnd_team3", function()
    o.im.Publish("bnd_team3", o.team3)
  end)
  o.im.Subscribe("bnd_team4", function()
    o.im.Publish("bnd_team4", o.team4)
  end)
  o.im.Subscribe("bnd_team5", function()
    o.im.Publish("bnd_team5", o.team5)
  end)
  o.im.Subscribe("bnd_team6", function()
    o.im.Publish("bnd_team6", o.team6)
  end)
  o.im.Subscribe("bnd_team7", function()
    o.im.Publish("bnd_team7", o.team7)
  end)
  o.im.Subscribe("bnd_team8", function()
    o.im.Publish("bnd_team8", o.team8)
  end)
  o.im.Subscribe("bnd_team9", function()
    o.im.Publish("bnd_team9", o.team9)
  end)
  o.im.Subscribe("bnd_team10", function()
    o.im.Publish("bnd_team10", o.team10)
  end)
  o.im.Subscribe("bnd_team11", function()
    o.im.Publish("bnd_team11", o.team11)
  end)
  o.im.Subscribe("bnd_team12", function()
    o.im.Publish("bnd_team12", o.team12)
  end)
  o.im.Subscribe("bnd_team13", function()
    o.im.Publish("bnd_team13", o.team13)
  end)
  o.im.Subscribe("bnd_team14", function()
    o.im.Publish("bnd_team14", o.team14)
  end)
  o.im.Subscribe("bnd_team15", function()
    o.im.Publish("bnd_team15", o.team15)
  end)
  o.im.Subscribe("bnd_team16", function()
    o.im.Publish("bnd_team16", o.team16)
  end)
  
   o.visible = false
   o.im.Subscribe("bnd_visible", function()
     o:publishVisible()
  end)
  o.im.Subscribe("bnd_loading_visible", function()
     o:publishVisible()
  end)
   if currentCupInfo[cupId] and currentCupInfo[cupId].homeID ~= 0 then
   
    o.nav.Event(nil, "evt_team_select")
  else
    o.visible = true
    o:publishVisible()
    o:Init()
    --o:InitGrouping()
    o.im.Subscribe(bndTeamList, function()
      o:publishTeamRows()
    end)
    o.im.RegisterAction(ACT_TEAM_SELECT, function(actionName, data)
     if data then
       o:StartQuickCup(data)
      end
    end)
  end
  
  return o
end

function TeamSelect:publishVisible()
   self.im.Publish("bnd_visible", self.visible)
   self.im.Publish("bnd_loading_visible", not self.visible)
end

-- 初始化数据
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

-- 初始化分组信息
function TeamSelect:InitGrouping()
  currentCupInfo[cupId] = {
    cupIndex = cupId,
    homeID = 0
  }
  local groupingList = {}
  local randomTeamList = self:RandomGrouping()
  for i = 1, table.getn(randomTeamList) do
    local temp = i * 2 - 1
    if temp < #randomTeamList then
      table.insert(groupingList, {
        [1] = randomTeamList[temp],
        [2] = randomTeamList[temp+1],
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

function TeamSelect:RandomGrouping()
  local result = {}
  local copyTeamList = self:clone(TeamList)
  local random
  for i = 1, table.getn(TeamList) do
    if #copyTeamList > 0 then
      random = math.random(#copyTeamList)
      table.insert(result, copyTeamList[random])
      table.remove(copyTeamList, random)
    end
  end
  return result
end

function TeamSelect:clone(master)
  local temp2 = {}
  for k, v in pairs(master) do
      if type(v) == "table" then
          temp2[k] = clone(v)
      else
          temp2[k] = v
      end
  end
  return temp2
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
       name = "",
       id = 1
    }
    v.data.RightText = ""
  end
  self.im.Publish(bndTeamList, TeamListData)
end

function TeamSelect:StartQuickCup(data)
  local currentTeamIndex = data.id + 1
  --currentCupInfo[cupId].homeID = TeamListData[currentTeamIndex].assetId
  
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
    self:InitGrouping()
    currentCupInfo[cupId].homeID = TeamListData[currentTeamIndex].assetId
    self.nav.Event(nil, "evt_team_select")
  end
  
  local popupData = {
    title = "INFO",
    message = "Confirm to choose "..TeamListData[currentTeamIndex].teamName.." to start the cup competition?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamSelect:finalize()
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe("bnd_loading_visible")
  self.im.Unsubscribe("bnd_cuplogo")
  self.im.Unsubscribe(bndTeamList)
  self.im.UnregisterAction(ACT_TEAM_SELECT)
  TeamListData = {}
end

return TeamSelect
