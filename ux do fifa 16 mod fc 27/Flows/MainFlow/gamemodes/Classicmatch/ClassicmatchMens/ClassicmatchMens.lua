-- Modified By MVNPROD Youtube Channel --

local ClassicmatchMens = {}

local bndMatchList = "bnd_match_list"

local ACT_MATCH_PLAY = "act_match_play"
currentMode = 1
-- Shuffle ClassicmatchMensList
local function shuffleArray(array)
  math.randomseed(os.time()) -- Initialize random seed
  for i = #array, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

local ClassicmatchMensList = {
  { HomeTeamID = 241,AwayTeamID = 243,StadiumID1 = 6,StadiumID2 = 2, data = {} },
  { HomeTeamID = 10, AwayTeamID = 11, StadiumID1 = 246, StadiumID2 = 1, data = {} },
  { HomeTeamID = 11, AwayTeamID = 9,  data = {},  StadiumID1 = 1, StadiumID2 = 13  },
  { HomeTeamID = 1, AwayTeamID = 5, data = {},  StadiumID1 = 156, StadiumID2 = 28  },
  { HomeTeamID = 21, AwayTeamID = 22, data = {},  StadiumID1 = 137, StadiumID2 = 30  },
  { HomeTeamID = 73, AwayTeamID = 69, data = {},  StadiumID1 = 14, StadiumID2 = 33  },
  { HomeTeamID = 44, AwayTeamID = 47,  data = {},  StadiumID1 = 5, StadiumID2 = 5  },
  { HomeTeamID = 47, AwayTeamID = 9, data = {},  StadiumID1 = 5, StadiumID2 = 13  },
  { HomeTeamID = 111205, AwayTeamID = 111072,  data = {},  StadiumID1 = 1, StadiumID2 = 6 },
  { HomeTeamID = 1335, AwayTeamID = 1369, data = {},  StadiumID1 = 14, StadiumID2 = 264  },
  { HomeTeamID = 1370, AwayTeamID = 1337, data = {},  StadiumID1 = 195, StadiumID2 = 135  },
  { HomeTeamID = 1362, AwayTeamID = 1354, data = {},  StadiumID1 = 2, StadiumID2 = 34  }, 
  { HomeTeamID = 1, AwayTeamID = 18, data = {},  StadiumID1 = 156, StadiumID2 = 5  }, 
  { HomeTeamID = 481, AwayTeamID = 449, data = {},  StadiumID1 = 176, StadiumID2 = 6  }, 
  { HomeTeamID = 461, AwayTeamID = 1853, data = {},  StadiumID1 = 6, StadiumID2 = 157  }, 
  { HomeTeamID = 457, AwayTeamID = 448, data = {},  StadiumID1 = 6, StadiumID2 = 249 }, 
  { HomeTeamID = 240, AwayTeamID = 243, data = {},  StadiumID1 = 6, StadiumID2 = 2 }, 
  { HomeTeamID = 2, AwayTeamID = 88, data = {},  StadiumID1 = 180, StadiumID2 = 155 }, 
  { HomeTeamID = 19, AwayTeamID = 97, data = {},  StadiumID1 = 180, StadiumID2 = 155 }, 
  { HomeTeamID = 7, AwayTeamID = 9, data = {},  StadiumID1 = 155, StadiumID2 = 13 }, 
  { HomeTeamID = 73, AwayTeamID = 219, data = {},  StadiumID1 = 14, StadiumID2 = 180 }, 
  { HomeTeamID = 66, AwayTeamID = 1819, data = {},  StadiumID1 = 14, StadiumID2 = 180 }, 
  { HomeTeamID = 59, AwayTeamID = 1809, data = {},  StadiumID1 = 14, StadiumID2 = 180 }, 
  { HomeTeamID = 65, AwayTeamID = 64, data = {},  StadiumID1 = 14, StadiumID2 = 180 }, 
  { HomeTeamID = 21, AwayTeamID = 33, data = {},  StadiumID1 = 137, StadiumID2 = 30 }, 
  { HomeTeamID = 22, AwayTeamID = 34, data = {},  StadiumID1 = 30, StadiumID2 = 180 }, 
  { HomeTeamID = 28, AwayTeamID = 110329, data = {},  StadiumID1 = 30, StadiumID2 = 180 }, 
  { HomeTeamID = 45, AwayTeamID = 44, data = {},  StadiumID1 = 247, StadiumID2 = 5 }, 
  { HomeTeamID = 52, AwayTeamID = 46, data = {},  StadiumID1 = 195, StadiumID2 = 5 }, 
  { HomeTeamID = 45, AwayTeamID = 47, data = {},  StadiumID1 = 247, StadiumID2 = 5 }, 
  { HomeTeamID = 48, AwayTeamID = 52, data = {},  StadiumID1 = 5, StadiumID2 = 195 }, 
  { HomeTeamID = 1837, AwayTeamID = 110556, data = {},  StadiumID1 = 5, StadiumID2 = 195 }, 
  { HomeTeamID = 1318, AwayTeamID = 1359, data = {},  StadiumID1 = 155, StadiumID2 = 157 }, 
  { HomeTeamID = 1337, AwayTeamID = 1318, data = {},  StadiumID1 = 137, StadiumID2 = 155 }, 
  { HomeTeamID = 1369, AwayTeamID = 1318, data = {},  StadiumID1 = 264, StadiumID2 = 155 }, 
  { HomeTeamID = 105035, AwayTeamID = 1337, data = {},  StadiumID1 = 15, StadiumID2 = 137 }, 
  { HomeTeamID = 1343, AwayTeamID = 1335, data = {},  StadiumID1 = 5, StadiumID2 = 14 }, 
  { HomeTeamID = 112139, AwayTeamID = 605, data = {},  StadiumID1 = 180, StadiumID2 = 157 }, 
  { HomeTeamID = 607, AwayTeamID = 112387, data = {},  StadiumID1 = 157, StadiumID2 = 180 }, 
  { HomeTeamID = 245, AwayTeamID = 246, data = {},  StadiumID1 = 15, StadiumID2 = 1 }, 
  { HomeTeamID = 247, AwayTeamID = 245, data = {},  StadiumID1 = 180, StadiumID2 = 15 }, 
  { HomeTeamID = 1915, AwayTeamID = 1913, data = {},  StadiumID1 = 15, StadiumID2 = 104 }, 
  { HomeTeamID = 1908, AwayTeamID = 100634, data = {},  StadiumID1 = 25, StadiumID2 = 195 }, 
  { HomeTeamID = 234, AwayTeamID = 237, data = {},  StadiumID1 = 33, StadiumID2 = 157 }, 
  { HomeTeamID = 236, AwayTeamID = 1898, data = {},  StadiumID1 = 33, StadiumID2 = 157 }, 
  { HomeTeamID = 1896, AwayTeamID = 1887, data = {},  StadiumID1 = 33, StadiumID2 = 157 }, 
  { HomeTeamID = 1879, AwayTeamID = 1880, data = {},  StadiumID1 = 180, StadiumID2 = 195 }, 
  { HomeTeamID = 982, AwayTeamID = 983, data = {},  StadiumID1 = 195, StadiumID2 = 249 }, 
  { HomeTeamID = 920, AwayTeamID = 299, data = {},  StadiumID1 = 157, StadiumID2 = 195 }, 
  { HomeTeamID = 819, AwayTeamID = 269, data = {},  StadiumID1 = 176, StadiumID2 = 157 },
  { HomeTeamID = 155602, AwayTeamID = 155603, data = {},  StadiumID1 = 100, StadiumID2 = 29 }, 
  { HomeTeamID = 155604, AwayTeamID = 155600, data = {},  StadiumID1 = 29, StadiumID2 = 100 }, 
  { HomeTeamID = 155614, AwayTeamID = 155611, data = {},  StadiumID1 = 29, StadiumID2 = 100 },
  { HomeTeamID = 111510, AwayTeamID = 1411, data = {},  StadiumID1 = 29, StadiumID2 = 100 }
}
shuffleArray(ClassicmatchMensList)

-- Shuffle ClassicmatchMensList
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

-- Shuffle ClassicmatchMensList
shuffleArray(ClassicmatchMensList)
-- Function to update opponentsCount with a random value between 1 and 20
local function updateOpponentsCount()
  return function()
    local opponentsCount = math.random(1, 15) -- Update opponentsCount with a random value between 1 and 20
    return opponentsCount
  end
end

-- Create a function to get the updated opponentsCount based on the new pattern
local getNextOpponentsCount = updateOpponentsCount()

function ClassicmatchMens:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService")
  }

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


function ClassicmatchMens:publishMatchRows()
  for i, v in ipairs(ClassicmatchMensList) do
    v.data.HomeTeamCrest = {
      name = "$Crest",
      id = ClassicmatchMensList[i].HomeTeamID
    }
    v.data.AwayTeamCrest = {
      name = "$Crest",
      id = ClassicmatchMensList[i].AwayTeamID
    }
    v.data.HomeTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..ClassicmatchMensList[i].HomeTeamID)
    v.data.AwayTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..ClassicmatchMensList[i].AwayTeamID)
    v.data.HomeTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_"..ClassicmatchMensList[i].HomeTeamID)
    v.data.AwayTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_"..ClassicmatchMensList[i].AwayTeamID)
    v.data.clickAction = "act_match_play"
  end
  self.im.Publish(bndMatchList, ClassicmatchMensList)
end

function ClassicmatchMens:PlayMatch(data)
  local currentMatchIndex = data.id + 1
  currentMatch.HomeTeamID = ClassicmatchMensList[currentMatchIndex].HomeTeamID
  currentMatch.AwayTeamID = ClassicmatchMensList[currentMatchIndex].AwayTeamID
  
  currentMatch.StadiumID1 = ClassicmatchMensList[currentMatchIndex].StadiumID1
  currentMatch.StadiumID2 = ClassicmatchMensList[currentMatchIndex].StadiumID2
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


function ClassicmatchMens:finalize()
  self.im.Unsubscribe("bnd_player3d")
  self.im.Unsubscribe(bndMatchList)
  self.im.UnregisterAction(ACT_MATCH_PLAY)
end

return ClassicmatchMens