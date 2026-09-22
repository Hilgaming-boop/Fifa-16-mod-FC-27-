-- Modified By MVNPROD Youtube Channel --

local ClassicmatchWomens = {}

local bndMatchList = "bnd_match_list"

local ACT_MATCH_PLAY = "act_match_play"
currentMode = 1
-- Shuffle ClassicmatchWomensList
local function shuffleArray(array)
  math.randomseed(os.time()) -- Initialize random seed
  for i = #array, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

local ClassicmatchWomensList = {
  { HomeTeamID = 116327,AwayTeamID = 116326,StadiumID1 = 183,StadiumID2 = 1,data = {} },
  { HomeTeamID = 116325,AwayTeamID = 116330,StadiumID1 = 14,StadiumID2 = 6,data = {} },
  { HomeTeamID = 116010,AwayTeamID = 116012,StadiumID1 = 28,StadiumID2 = 1,data = {} },
  { HomeTeamID = 116018, AwayTeamID = 116033, StadiumID1 = 195, StadiumID2 = 14, data = {} },
  { HomeTeamID = 116013, AwayTeamID = 116386,  data = {},  StadiumID1 = 195, StadiumID2 = 195  },
  { HomeTeamID = 116009, AwayTeamID = 116011, data = {},  StadiumID1 = 156, StadiumID2 = 116  },
  { HomeTeamID = 116014, AwayTeamID = 116016, data = {},  StadiumID1 = 137, StadiumID2 = 30  },
  { HomeTeamID = 116017, AwayTeamID = 116034, data = {},  StadiumID1 = 246, StadiumID2 = 14  },
  { HomeTeamID = 116035, AwayTeamID = 116280,  data = {},  StadiumID1 = 14, StadiumID2 = 247  },
  { HomeTeamID = 116326, AwayTeamID = 116343, data = {},  StadiumID1 = 2, StadiumID2 = 13  },
  { HomeTeamID = 113996, AwayTeamID = 112998, data = {},  StadiumID1 = 264, StadiumID2 = 192  },
  { HomeTeamID = 113394, AwayTeamID = 112999, data = {},  StadiumID1 = 261, StadiumID2 = 158  },
  { HomeTeamID = 113000, AwayTeamID = 113001, data = {},  StadiumID1 = 326, StadiumID2 = 261  },
  { HomeTeamID = 115362, AwayTeamID = 113002, data = {},  StadiumID1 = 2, StadiumID2 = 1  },
  { HomeTeamID = 115511, AwayTeamID = 113006, data = {},  StadiumID1 = 29, StadiumID2 = 176  },
  { HomeTeamID = 113010, AwayTeamID = 131144, data = {},  StadiumID1 = 195, StadiumID2 = 137  },
  { HomeTeamID = 113258, AwayTeamID = 113007, data = {},  StadiumID1 = 183, StadiumID2 = 176  }
}
shuffleArray(ClassicmatchWomensList)

-- Shuffle ClassicmatchWomensList
local function shuffleArray(array)
  math.randomseed(os.time()) -- Initialize random seed
  for i = #array, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

currentMatch = {
   HomeTeamID = 0,
   AwayTeamID = 0,
   Side = 0, -- 0 home 1 away
   HomeKitIndex = 0,
   AwayKitIndex = 1,
   StadiumID1 = 0,
   StadiumID2 = 0
}

-- Shuffle ClassicmatchWomensList
shuffleArray(ClassicmatchWomensList)
-- Function to update opponentsCount with a random value between 1 and 20
local function updateOpponentsCount()
  return function()
    local opponentsCount = math.random(1, 15) -- Update opponentsCount with a random value between 1 and 20
    return opponentsCount
  end
end

-- Create a function to get the updated opponentsCount based on the new pattern
local getNextOpponentsCount = updateOpponentsCount()

function ClassicmatchWomens:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService")
  }

  o.player3d = {
    name = "$W_Player3d",
    id = 0
  }
  math.randomseed(os.clock() * 1543 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(15)
  
  o.im.Subscribe("bnd_player3d", function()
    o.player3d.id = random2
    o.im.Publish("bnd_player3d", o.player3d)
  end)
  
  o.im.Subscribe(bndMatchList, function()
    o:publishMatchRows()
  end)

  o.im.RegisterAction(ACT_MATCH_PLAY, function(actionName, data)
   if data then
     o:PlayMatch(data)
    end
  end)
  
  return o
end


function ClassicmatchWomens:publishMatchRows()
  for i, v in ipairs(ClassicmatchWomensList) do
    v.data.HomeTeamCrest = {
      name = "$Crest",
      id = ClassicmatchWomensList[i].HomeTeamID
    }
    v.data.AwayTeamCrest = {
      name = "$Crest",
      id = ClassicmatchWomensList[i].AwayTeamID
    }
    v.data.HomeTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..ClassicmatchWomensList[i].HomeTeamID)
    v.data.AwayTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..ClassicmatchWomensList[i].AwayTeamID)
    v.data.HomeTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_"..ClassicmatchWomensList[i].HomeTeamID)
    v.data.AwayTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_"..ClassicmatchWomensList[i].AwayTeamID)
    v.data.clickAction = "act_match_play"
  end
  self.im.Publish(bndMatchList, ClassicmatchWomensList)
end

function ClassicmatchWomens:PlayMatch(data)
  local currentMatchIndex = data.id + 1
  currentMatch.HomeTeamID = ClassicmatchWomensList[currentMatchIndex].HomeTeamID
  currentMatch.AwayTeamID = ClassicmatchWomensList[currentMatchIndex].AwayTeamID
  
  currentMatch.StadiumID1 = ClassicmatchWomensList[currentMatchIndex].StadiumID1
  currentMatch.StadiumID2 = ClassicmatchWomensList[currentMatchIndex].StadiumID2
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
      "evt_match_play",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "Are you ready to start the game?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end


function ClassicmatchWomens:finalize()
  self.im.Unsubscribe("bnd_player3d")
  self.im.Unsubscribe(bndMatchList)
  self.im.UnregisterAction(ACT_MATCH_PLAY)
end

return ClassicmatchWomens