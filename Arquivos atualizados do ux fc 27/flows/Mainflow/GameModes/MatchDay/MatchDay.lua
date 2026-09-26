
local MatchDayList = ...
local MatchDay = {}

local bndMatchList = "bnd_match_list"

local ACT_MATCH_PLAY = "act_match_play"
currentMode = 6


local typeList = {
  {
    name = "Friendly Match",
    color = ""
  },
  {
    name = "Premier League",
    color = "39003E"
  },
  {
    name = "La Liga",
    color = "1e1e1e"
  },
  {
    name = "Bundesliga",
    color = "1e1e1e"
  },
  {
    name = "Serie A",
    color = "474BE5"
  },
  {
    name = "Roshn Saudi League",
    color = "4B4B4B"
  },
  {
    name = "UEFA Champions League",
    color = "040D46"
  },
  {
    name = "UEFA Europa League",
    color = "1e1e1e"
  }
  
}


currentMatch = {
   MatchIndex = 0,
   HomeTeamID = 0,
   AwayTeamID = 0,
   Side = 0, -- 0 home 1 away
   HomeKitIndex = 0,
   AwayKitIndex = 1,
   SquadId = 0
}

function MatchDay:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService")
  }

  o.isEmpty = false
  -- o.currentDayMatchList = {}

  if #currentDayMatchList == 0 then
    o:filterDate()
  end

  o.im.Subscribe(bndMatchList, function()
    o:publishMatchRows()
  end)

  o.im.Subscribe("bnd_match_empty", function()
    o:publishEmpty()
  end)

  o.im.RegisterAction(ACT_MATCH_PLAY, function(actionName, data)
   if data then
     o:PlayMatch(data)
    end
  end)
  
  o.player3d = {
    name = "$PlayersPMH",
    id = 0
  }
  math.randomseed(os.clock() * 1543 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(1000)
  
  o.im.Subscribe("bnd_player3d", function()
    o.player3d.id = random2
    o.im.Publish("bnd_player3d", o.player3d)
  end)
  
  return o
end

function MatchDay:filterDate()
  local currentDate = os.date("%Y/%m/%d")
  for i = 1, #MatchDayList do
    if MatchDayList[i].Date == currentDate then
      table.insert(currentDayMatchList, MatchDayList[i])
    end
  end
  if #currentDayMatchList == 0 then
    self.isEmpty = true
  end
end

function MatchDay:publishEmpty()
  if #currentDayMatchList == 0 then
    self.isEmpty = true
  end
  self.im.Publish("bnd_match_empty", self.isEmpty)
end


function MatchDay:publishMatchRows()
  for i, v in ipairs(currentDayMatchList) do
    v.data.HomeTeamCrest = {
      name = "$Crest",
      id = currentDayMatchList[i].HomeTeamID
    }
    v.data.AwayTeamCrest = {
      name = "$Crest",
      id = currentDayMatchList[i].AwayTeamID
    }
    v.data.HomeTeamName = self.loc.LocalizeString("TeamName_Abbr3_"..currentDayMatchList[i].HomeTeamID)
    v.data.AwayTeamName = self.loc.LocalizeString("TeamName_Abbr3_"..currentDayMatchList[i].AwayTeamID)
    v.data.MatchScore = currentDayMatchList[i].score == "" and "0 - 0" or currentDayMatchList[i].score
    v.data.MatchTimeAndType = currentDayMatchList[i].Date.." | "..self:getNameByType(currentDayMatchList[i].type)
    v.data.clickAction = "act_match_play"
    v.data.MatchBackground = self:getBackgroundColorByType(currentDayMatchList[i].type)
  end
  self.currentDayMatchList = currentDayMatchList
  self.im.Publish(bndMatchList, self.currentDayMatchList)
end

function MatchDay:getBackgroundColorByType(type)
  local index = type + 1
  return typeList[index].color == "" and "0x00fc7f" or "0x"..typeList[index].color
end

function MatchDay:getNameByType(type)
  local index = type + 1
  return typeList[index].name
end

function MatchDay:PlayMatch(data)
  local currentMatchIndex = data.id + 1
  currentMatch.MatchIndex = currentMatchIndex
  currentMatch.HomeTeamID = currentDayMatchList[currentMatchIndex].HomeTeamID
  currentMatch.AwayTeamID = currentDayMatchList[currentMatchIndex].AwayTeamID
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Comfirm",
    clickEvents = {
      "evt_match_play",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "Are you ready to start the game ?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end


function MatchDay:finalize()
  self.im.Unsubscribe(bndMatchList)
  self.im.Unsubscribe("bnd_player3d")
  self.im.Unsubscribe("bnd_match_empty")
  self.im.UnregisterAction(ACT_MATCH_PLAY)
  self.currentDayMatchList = {}
end

return MatchDay

-- Thanks : Ma'ruf Id & Laosiji --
-- @mvnprod.official - Remain Be Creative --