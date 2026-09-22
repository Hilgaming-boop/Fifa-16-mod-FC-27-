local QuickCup = {}

local ACT_ADVANCE = "act_advance"
local ACT_RESTART = "act_restart"
local actToHelpTile = "act_to_Help_tile"

local maxMatchSize = 15
cupId = 19


local bndList = {
   
}

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
  bndList[i + 30] = "bnd_team"..i.."_crest"
  bndList[i + 60] = "bnd_team"..i.."_abbr" -- Adiciona o binding para o nome do time
end
  
  o.cuplogo = {
      name = "$LeagueLogo",
      id = "CupID19"
    }
  o.cupData = {
    cupMap = {
      name = "$CupMap",
      id = cupId
    },
    trophy = {
      name = "$_Trophies",
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
    Round = ""
  }

  o.im.Subscribe("bnd_cuplogo", function()
    o.im.Publish("bnd_cuplogo", o.cuplogo)
  end)
  
  o.im.Subscribe("bnd_cup_map", function()
    o.im.Publish("bnd_cup_map", o.cupData.cupMap)
  end)

  o.im.Subscribe("bnd_trophy", function()
    o.im.Publish("bnd_trophy", o.cupData.trophy)
  end)
  
  for k,v in pairs(bndList) do
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

  o.im.Subscribe("bnd_text", function()
    o.im.Publish("bnd_text", "")
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
  
  o.im.RegisterAction(actToHelpTile, function(actionName)
    o:_openHelpPopup(actionName)
  end)
  
  return o
end

function QuickCup:InitOptions()
    -- Inicializar configuração do grupo
    local currentCupGrouping = QuickCupGrouping[cupId]
for k = 1, table.getn(currentCupGrouping) do
    local index = k * 2 - 1
    local bindingKey = "bnd_team"

    -- Publica o crest e score do time da casa
    bindingKey = bindingKey .. index
    self.im.Publish(bindingKey .. "_crest", {
      name = "$Crest",
      id = currentCupGrouping[k][1]
    })
    self.im.Publish(bindingKey .. "_score", currentCupGrouping[k][3])
    self.im.Publish(bindingKey .. "_abbr", self.loc.LocalizeString("TeamName_Abbr3_" .. currentCupGrouping[k][1]))  -- Publica a abreviatura do time da casa

    -- Publica o crest e score do time visitante
    bindingKey = "bnd_team"
    local i = index + 1
    bindingKey = bindingKey .. i
    self.im.Publish(bindingKey .. "_crest", {
      name = "$Crest",
      id = currentCupGrouping[k][2]
    })
    self.im.Publish(bindingKey .. "_score", currentCupGrouping[k][4])
    self.im.Publish(bindingKey .. "_abbr", self.loc.LocalizeString("TeamName_Abbr3_" .. currentCupGrouping[k][2]))  -- Publica a abreviatura do time visitante
end
    if currentCupGrouping[maxMatchSize][5] then
      if currentCupGrouping[maxMatchSize][6] == currentCupInfo[cupId].homeID then 
        -- Parabéns por vencer a copa
        self.cupData.championCrest.id = currentCupInfo[cupId].homeID
        
      else
        -- Derrota lamentável
        self.cupData.championCrest.id = currentCupGrouping[maxMatchSize][6]
        
      end
      self.cupData.isFinish = true
      self:publishChampion()
    end
end

function QuickCup:publishChampion()
  self.im.Publish("bnd_champion_visible", self.cupData.isFinish)
  self.im.Publish("bnd_match_visible", not self.cupData.isFinish)
  if self.cupData.championCrest.id ~= 0 and self.cupData.isFinish == true then
    self.im.Publish("bnd_text", "CHAMPION")
    self.im.Publish("bnd_champion_crest", self.cupData.championCrest)
    self.im.Publish("bnd_champion_team", self.loc.LocalizeString("TeamName_Abbr15_"..self.cupData.championCrest.id))
  end
end

function QuickCup:publishMatchInfo()
  if self.cupData.championCrest.id == 0 and self.cupData.isFinish == false then
    self.im.Publish("bnd_match_visible", not self.cupData.isFinish)
    self.im.Publish("bnd_text", self.cupData.Round)
    self.im.Publish("bnd_home_crest", self.cupData.homeTeamCrest)
    self.cupData.awayTeamCrest.id = self:GetMatchAwayTeamId()
    self.im.Publish("bnd_home_team", self.loc.LocalizeString("TeamName_Abbr15_"..self.cupData.homeTeamCrest.id))
    self.im.Publish("bnd_away_crest", self.cupData.awayTeamCrest)
    self.im.Publish("bnd_away_team", self.loc.LocalizeString("TeamName_Abbr15_"..self.cupData.awayTeamCrest.id))
  end
end

function QuickCup:GetMatchAwayTeamId()
  local currentCupGrouping = QuickCupGrouping[cupId]
  local index = 0
  for i = 1, table.getn(currentCupGrouping) do
    if currentCupGrouping[i][5] == false then
      if currentCupGrouping[i][1] == currentCupInfo[cupId].homeID then
        index = currentCupGrouping[i][2]
        self.cupData.Round = self:GetMatchRound(i)
      elseif currentCupGrouping[i][2] == currentCupInfo[cupId].homeID then
        index = currentCupGrouping[i][1]
        self.cupData.Round = self:GetMatchRound(i)
      end
    end
  end
  return index
end

function QuickCup:GetMatchRound(index)
  if index > 0 and index <= 8 then
    return "ROUND OF 16"
  elseif index > 8 and index <= 12 then
    return "QUARTER FINALS"
  elseif index > 12 and index <= 14 then
    return "SEMI FINAL"
  else
    return "FINAL"
  end
end



function QuickCup:PlayMatch()
  currentCupData.maxMatchSize = maxMatchSize
  currentCupData.cupIndex = cupId
  local currentCupGrouping = QuickCupGrouping[cupId]
  local index = 0
  for i = 1, table.getn(currentCupGrouping) do
    if currentCupGrouping[i][5] == false then
      if currentCupGrouping[i][1] == currentCupInfo[cupId].homeID then
        index = i
        currentCupData.homeID = currentCupInfo[cupId].homeID
        
        currentCupData.awayID = currentCupGrouping[i][2]
      elseif currentCupGrouping[i][2] == currentCupInfo[cupId].homeID then
        index = i
        currentCupData.homeID = currentCupInfo[cupId].homeID
        
        currentCupData.awayID = currentCupGrouping[i][1]
      end
    end
  end
  currentMatch.HomeTeamID = currentCupData.homeID
  currentMatch.AwayTeamID = currentCupData.awayID
  if index > 0 then
    self.nav.Event(nil, "evt_advance")
  else
    self:StopMatch()
  end
end

function QuickCup:PlayReStart()
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
      "evt_restart",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "Do you want to end the current competition?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function QuickCup:StartMatch()
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
      "evt_advance",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "Are you ready to start the match?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function QuickCup:StopMatch()
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup",
      "evt_refresh_on_resize"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Done",
    clickEvents = {
       "evt_restart",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "The competition has ended",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function QuickCup:_openHelpPopup()
  local titleText = "How does the tournament work?"
  local messageText = "How does the tournament work?                                    Tournaments work as follows; Choose 1/16 available teams. you will start the tournament in the round of 16, your objective is to win 4/4 matches to be the champion. Good luck!                                         -Rober FL"
  local buttonClose = {
    icon = "$FooterIconNo",
    label = "Close",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = titleText,
    message = messageText,
    buttons = {buttonClose}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end


function QuickCup:finalize()
  self.im.UnregisterAction(ACT_RESTART)
  self.im.UnregisterAction(ACT_ADVANCE)
  self.im.Unsubscribe("bnd_champion_crest")
  self.im.Unsubscribe("bnd_text")
  self.im.Unsubscribe("bnd_cuplogo")
  self.im.Unsubscribe("bnd_cupname")
  self.im.Unsubscribe("bnd_trophy")
  self.im.Unsubscribe("bnd_cup_map")
  self.im.Unsubscribe("bnd_champion_visible")
  self.im.Unsubscribe("bnd_match_visible")
  self.im.Unsubscribe("bnd_champion_team")
  self.im.Unsubscribe("bnd_home_crest")
  self.im.Unsubscribe("bnd_away_crest")
  self.im.Unsubscribe("bnd_home_team")
  self.im.Unsubscribe("bnd_away_team")
  for k,v in pairs(bndList) do
    self.im.Unsubscribe(v)
  end
  
end

return QuickCup
