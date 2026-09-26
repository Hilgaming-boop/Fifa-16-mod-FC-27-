-- LAOSIJI
-- REMOD MOUNTSA
local QuickCup = {}
local ACT_ADVANCE = "act_advance"
local ACT_RESTART = "act_restart"
local BND_REALTIME = "bnd_realtime"
local maxMatchSize = 15
local cupId = 16
local bndList = {}

currentMatch = {
  HomeTeamID = 0,
  AwayTeamID = 0,
  HomeKitIndex = 0,
  AwayKitIndex = 1
}

function QuickCup:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    settingsService = o.api("SettingsService")
  }
  o.currentOptions = o.services.settingsService.GetCurrentOptions()
  
  for i = 1, 30 do
    bndList[i] = "bnd_team"..i.."_score"
    bndList[i+30] = "bnd_team"..i.."_crest"
  end
  
  o.cupData = {
    cupBg = {
      name = "$Bg_Cup",
      id = cupId
    },
    cupMap = {
      name = "$CupMap",
      id = cupId
    },
    cuplogo = {
      name = "$CupLogo",
      id = cupId
    },
    trophy = {
      name = "$CupTrophy",
      id = cupId
    },
    championCrest = {
      name = "$Crest",
      id = 0
    },
    homeTeamCrest = {
      name = "$Crest",
      id = currentCupInfo[cupId].homeID
    },
    awayTeamCrest = {
      name = "$Crest",
      id = 0
    },
    isFinish = false,
    Round = "Round of 16"
  }
  
  -- Subscribe untuk semua binding
  o.im.Subscribe("bnd_cup_bg", function()
    o.im.Publish("bnd_cup_bg", o.cupData.cupBg)
  end)
  
  o.im.Subscribe("bnd_cup_map", function()
    o.im.Publish("bnd_cup_map", o.cupData.cupMap)
  end)
  
  o.im.Subscribe("bnd_cup_logo", function()
    o.im.Publish("bnd_cup_logo", o.cupData.cuplogo)
  end)
  
  o.im.Subscribe("bnd_trophy", function()
    o.im.Publish("bnd_trophy", o.cupData.trophy)
  end)
  
  o.Banner = {
    name = "$Ads",
    id = 0
  }
  
  math.randomseed(os.clock() * 1352 + os.time())
  local random2 = math.random(5)
  
  o.im.Subscribe("bnd_ads", function()
    o.Banner.id = random2
    o.im.Publish("bnd_ads", o.Banner)
  end)
  
  o.im.Subscribe(BND_REALTIME, function()
    local currentTime = os.date("Match Schedule: %d %b %Y %H:%M")
    o.im.Publish(BND_REALTIME, currentTime)
  end)
  
  for k, v in pairs(bndList) do
    o.im.Subscribe(v, function()
      o:InitOptions()
    end)
  end
  
  o.im.Subscribe("bnd_match_visible", function()
    o:publishMatchInfo()
  end)
  
  o.im.Subscribe("bnd_home_crest", function()
    o:publishMatchInfo()
  end)
  
  o.im.Subscribe("bnd_away_crest", function()
    o:publishMatchInfo()
  end)
  
  o.im.Subscribe("bnd_home_team", function()
    o:publishMatchInfo()
  end)
  
  o.im.Subscribe("bnd_away_team", function()
    o:publishMatchInfo()
  end)
  
  o.im.Subscribe("bnd_home_team_short", function()
    o:publishMatchInfo()
  end)
  
  o.im.Subscribe("bnd_away_team_short", function()
    o:publishMatchInfo()
  end)
  
  o.im.Subscribe("bnd_text", function()
    o.im.Publish("bnd_text", "Next Match")
  end)
  
  o.im.Subscribe("bnd_champion_visible", function()
    o:publishChampion()
  end)
  
  o.im.Subscribe("bnd_champion_crest", function()
    o:publishChampion()
  end)
  
  o.im.Subscribe("bnd_champion_team", function()
    o:publishChampion()
  end)
  
  o.im.RegisterAction(ACT_ADVANCE, function(actionName)
    o:PlayMatch()
  end)
  
  o.im.RegisterAction(ACT_RESTART, function(actionName)
    o:PlayReStart()
  end)
  
  return o
end

function QuickCup:InitOptions()
  local currentCupGrouping = QuickCupGrouping[cupId]
  
  for k = 1, #currentCupGrouping do
    local index = k * 2 - 1
    local bindingKey = "bnd_team"..index
    
    self.im.Publish(bindingKey.."_crest", {
      name = "$Crest64x64",
      id = currentCupGrouping[k][1]
    })
    self.im.Publish(bindingKey.."_score", currentCupGrouping[k][3])
    
    bindingKey = "bnd_team"..(index + 1)
    self.im.Publish(bindingKey.."_crest", {
      name = "$Crest64x64",
      id = currentCupGrouping[k][2]
    })
    self.im.Publish(bindingKey.."_score", currentCupGrouping[k][4])
  end     
  
  if currentCupGrouping[maxMatchSize][5] then
    if currentCupGrouping[maxMatchSize][6] == currentCupInfo[cupId].homeID then 
      self.cupData.championCrest.id = currentCupInfo[cupId].homeID
    else
      self.cupData.championCrest.id = currentCupGrouping[maxMatchSize][6]
    end
    self.cupData.isFinish = true
    self:publishChampion()
  end
end

function QuickCup:publishChampion()
  self.im.Publish("bnd_champion_visible", self.cupData.isFinish)
  self.im.Publish("bnd_match_visible", not self.cupData.isFinish)
  
  if self.cupData.championCrest.id ~= 0 and self.cupData.isFinish then
    self.im.Publish("bnd_text", "Champion of the Tournament")
    self.im.Publish("bnd_champion_crest", self.cupData.championCrest)
    self.im.Publish("bnd_champion_team", self.loc.LocalizeString("TeamName_Abbr15_"..self.cupData.championCrest.id))
  end
end

function QuickCup:publishMatchInfo()
  if self.cupData.championCrest.id == 0 and not self.cupData.isFinish then
    self.im.Publish("bnd_match_visible", true)
    self.im.Publish("bnd_text", self.cupData.Round)
    self.im.Publish("bnd_home_crest", self.cupData.homeTeamCrest)
    self.im.Publish("bnd_home_team", self.loc.LocalizeString("TeamName_Abbr15_"..self.cupData.homeTeamCrest.id))
    self.im.Publish("bnd_home_team_short", self.loc.LocalizeString("TeamName_Abbr3_"..self.cupData.homeTeamCrest.id))
    
    self.cupData.awayTeamCrest.id = self:GetMatchAwayTeamId()
    self.im.Publish("bnd_away_crest", self.cupData.awayTeamCrest)
    self.im.Publish("bnd_away_team", self.loc.LocalizeString("TeamName_Abbr15_"..self.cupData.awayTeamCrest.id))
    self.im.Publish("bnd_away_team_short", self.loc.LocalizeString("TeamName_Abbr3_"..self.cupData.awayTeamCrest.id))
  end
end

function QuickCup:GetMatchAwayTeamId()
  local currentCupGrouping = QuickCupGrouping[cupId]
  local awayTeamId = 0
  
  for i = 1, #currentCupGrouping do
    if not currentCupGrouping[i][5] then
      if currentCupGrouping[i][1] == currentCupInfo[cupId].homeID then
        awayTeamId = currentCupGrouping[i][2]
        self.cupData.Round = self:GetMatchRound(i)
      elseif currentCupGrouping[i][2] == currentCupInfo[cupId].homeID then
        awayTeamId = currentCupGrouping[i][1]
        self.cupData.Round = self:GetMatchRound(i)
      end
    end
  end
  
  return awayTeamId
end

function QuickCup:GetMatchRound(index)
  if index >= 1 and index <= 8 then
    return "Round of 16"
  elseif index >= 9 and index <= 12 then
    return "Quarter Final"
  elseif index >= 13 and index <= 14 then
    return "Semi Final"
  elseif index == 15 then
    return "Grand Final"
  else
    return "Knockout Stage"
  end
end

function QuickCup:PlayMatch()
  currentCupData.maxMatchSize = maxMatchSize
  currentCupData.cupIndex = cupId
  local currentCupGrouping = QuickCupGrouping[cupId]
  local matchIndex = 0
  
  for i = 1, #currentCupGrouping do
    if not currentCupGrouping[i][5] then
      if currentCupGrouping[i][1] == currentCupInfo[cupId].homeID then
        matchIndex = i
        currentCupData.homeID = currentCupInfo[cupId].homeID
        currentCupData.awayID = currentCupGrouping[i][2]
      elseif currentCupGrouping[i][2] == currentCupInfo[cupId].homeID then
        matchIndex = i
        currentCupData.homeID = currentCupInfo[cupId].homeID
        currentCupData.awayID = currentCupGrouping[i][1]
      end
    end
  end
  
  currentMatch.HomeTeamID = currentCupData.homeID
  currentMatch.AwayTeamID = currentCupData.awayID
  
  if matchIndex > 0 then
    self.nav.Event(nil, "evt_advance")
  else
    self:StopMatch()
  end
end

function QuickCup:PlayReStart()
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {"evt_hide_popup"}
  }
  
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {"evt_restart", "evt_hide_popup"}
  }
  
  local popupData = {
    title = "CONFIRMATION",
    message = "Do you want to end the current competition?",
    buttons = {buttonNo, buttonYes}
  }
  
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function QuickCup:StartMatch()
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {"evt_hide_popup"}
  }
  
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Start Match",
    clickEvents = {"evt_advance", "evt_hide_popup"}
  }
  
  local popupData = {
    title = "READY TO PLAY",
    message = "Are you ready to start the match?",
    buttons = {buttonNo, buttonYes}
  }
  
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function QuickCup:StopMatch()
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "OK",
    clickEvents = {"evt_restart", "evt_hide_popup"}
  }
  
  local popupData = {
    title = "COMPETITION ENDED",
    message = "The tournament has concluded",
    buttons = {buttonYes}
  }
  
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function QuickCup:finalize()
  self.im.UnregisterAction(ACT_RESTART)
  self.im.UnregisterAction(ACT_ADVANCE)
  
  local bindingsToUnsubscribe = {
    BND_REALTIME,
    "bnd_champion_crest",
    "bnd_text",
    "bnd_cup_bg",
    "bnd_cup_logo",
    "bnd_trophy",
    "bnd_cup_map",
    "bnd_champion_visible",
    "bnd_match_visible",
    "bnd_champion_team",
    "bnd_home_crest",
    "bnd_away_crest",
    "bnd_home_team",
    "bnd_away_team",
    "bnd_home_team_short",
    "bnd_away_team_short",
    "bnd_ads"
  }
  
  for _, binding in ipairs(bindingsToUnsubscribe) do
    self.im.Unsubscribe(binding)
  end
  
  for _, v in pairs(bndList) do
    self.im.Unsubscribe(v)
  end
end

return QuickCup
-- MOUNTSA