-- Modified By MVNPROD Youtube Channel --

local ClassicMatch = {}

local bndMatchList = "bnd_match_list"

local ACT_MATCH_PLAY = "act_match_play"
currentMode = 1
-- Shuffle ClassicMatchList
local function shuffleArray(array)
  math.randomseed(os.time()) -- Initialize random seed
  for i = #array, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

local ClassicMatchList = {
  { HomeTeamID = 126710, AwayTeamID = 126711, data = {},  StadiumID1 = 2, StadiumID2 = 34  },
  { HomeTeamID = 126712, AwayTeamID = 126710, data = {},  StadiumID1 = 14, StadiumID2 = 264  },
  { HomeTeamID = 128338, AwayTeamID = 128362, data = {},  StadiumID1 = 96, StadiumID2 = 13  },
  { HomeTeamID = 128004, AwayTeamID = 127924, data = {},  StadiumID1 = 156, StadiumID2 = 28  },
  { HomeTeamID = 127950, AwayTeamID = 128004, data = {},  StadiumID1 = 137, StadiumID2 = 30  },
  { HomeTeamID = 128028, AwayTeamID = 128299, data = {},  StadiumID1 = 14, StadiumID2 = 33  },
  { HomeTeamID = 127948, AwayTeamID = 128000, data = {},  StadiumID1 = 5, StadiumID2 = 5  },
  { HomeTeamID = 128322, AwayTeamID = 127925, data = {},  StadiumID1 = 5, StadiumID2 = 13  },
  { HomeTeamID = 127949, AwayTeamID = 127993, data = {},  StadiumID1 = 1, StadiumID2 = 6 },
  { HomeTeamID = 111205, AwayTeamID = 128404, data = {},  StadiumID1 = 14, StadiumID2 = 264  },
  { HomeTeamID = 114815, AwayTeamID = 128004, data = {},  StadiumID1 = 195, StadiumID2 = 135  },
  { HomeTeamID = 128362, AwayTeamID = 127950, data = {},  StadiumID1 = 2, StadiumID2 = 34  },
  { HomeTeamID = 127950, AwayTeamID = 127948, data = {},  StadiumID1 = 14, StadiumID2 = 264  },
  { HomeTeamID = 126710, AwayTeamID = 128299, data = {},  StadiumID1 = 195, StadiumID2 = 135  },
  { HomeTeamID = 127925, AwayTeamID = 127949, data = {},  StadiumID1 = 2, StadiumID2 = 34  }
}
shuffleArray(ClassicMatchList)

-- Shuffle ClassicMatchList
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

-- Shuffle ClassicMatchList
shuffleArray(ClassicMatchList)
-- Function to update opponentsCount with a random value between 1 and 20
local function updateOpponentsCount()
  return function()
    local opponentsCount = math.random(1, 15) -- Update opponentsCount with a random value between 1 and 20
    return opponentsCount
  end
end

-- Create a function to get the updated opponentsCount based on the new pattern
local getNextOpponentsCount = updateOpponentsCount()

function ClassicMatch:new(init)
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


function ClassicMatch:publishMatchRows()
  for i, v in ipairs(ClassicMatchList) do
    v.data.HomeTeamCrest = {
      name = "$Crest",
      id = ClassicMatchList[i].HomeTeamID
    }
    v.data.AwayTeamCrest = {
      name = "$Crest",
      id = ClassicMatchList[i].AwayTeamID
    }
    v.data.HomeTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..ClassicMatchList[i].HomeTeamID)
    v.data.AwayTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..ClassicMatchList[i].AwayTeamID)
    v.data.HomeTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_"..ClassicMatchList[i].HomeTeamID)
    v.data.AwayTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_"..ClassicMatchList[i].AwayTeamID)
    v.data.clickAction = "act_match_play"
  end
  self.im.Publish(bndMatchList, ClassicMatchList)
end

function ClassicMatch:PlayMatch(data)
  local currentMatchIndex = data.id + 1
  currentMatch.HomeTeamID = ClassicMatchList[currentMatchIndex].HomeTeamID
  currentMatch.AwayTeamID = ClassicMatchList[currentMatchIndex].AwayTeamID
  
  currentMatch.StadiumID1 = ClassicMatchList[currentMatchIndex].StadiumID1
  currentMatch.StadiumID2 = ClassicMatchList[currentMatchIndex].StadiumID2
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


function ClassicMatch:finalize()
  self.im.Unsubscribe("bnd_player3d")
  self.im.Unsubscribe(bndMatchList)
  self.im.UnregisterAction(ACT_MATCH_PLAY)
end

return ClassicMatch