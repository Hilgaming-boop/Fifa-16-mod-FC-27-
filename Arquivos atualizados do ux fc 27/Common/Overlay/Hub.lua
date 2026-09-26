-- Mod By MVN PROD --
-- League Mode Division --

local Liga = {}
local bndMatchList = "bnd_match_list"
local ACT_ADVANCE = "act_advance"
GLOBAL_PLAYERIN = 0

ligaId = 1

currentMatch = {
  HomeTeamID = 0,
  AwayTeamID = 0,
  HomeKitIndex = 0,
  AwayKitIndex = 1
}

-- Dev2
local rivalListData = {}
local matchesPlayed = 0  -- Counter to track the number of matches played

function Liga:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    settingsService = o.api("SettingsService"),
    SquadManagementService = o.api("SquadMgtService")
  }

  o.currentOptions = o.services.settingsService.GetCurrentOptions()
  o.Init()

  o.im.Subscribe(bndMatchList, function()
     o:publishMatchRows()
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
  
  o.im.Subscribe("bnd_match_label", function()
    o:publishMatchLabel()
  end)

  o.im.Subscribe("bnd_finish_label", function()
    o:publishFinishLabel()
  end)

  o.im.RegisterAction(ACT_ADVANCE, function(actionName, data)
    if data then
      o:PlayMatch(data)
    end
  end)

  return o
end

------------------------------------------------------------------------------------------

function Liga:Init()
  local LigaGroupingList = LigaGrouping[ligaId]
  for i = 1, table.getn(LigaGroupingList) do
    local obj = {
      homeID = LigaGroupingList[i][1],
      awayID = LigaGroupingList[i][2],
      homeScore = LigaGroupingList[i][4],
      awayScore = LigaGroupingList[i][5],
      
      clickAction = "act_advance",
      isUnlock = LigaGroupingList[i][9],
      data = {}
    }
    table.insert(rivalListData, obj)
  end
end

------------------------------------------------------------------------------------------

function Liga:publishMatchRows()
    local filteredRivalListData = {}
    
    local function createRow(teamID, playerID, rowIndex)
        local teamLineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)
        
        if not teamLineup or #teamLineup == 0 then
            print("[Liga:publishMatchRows]: Team lineup for teamID " .. teamID .. " is empty or invalid.")
            self:Empty()
            return nil
        end
        
        local selectedPlayer = nil
        for _, player in ipairs(teamLineup) do
            if player.CARD_ID == playerID then
                selectedPlayer = player
                break
            end
        end
        
        if not selectedPlayer then
            print("[Liga:publishMatchRows]: No player found with CARD_ID " .. playerID .. " in teamID " .. teamID)
            return nil
        end
        
        local teamname = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID)
        return {
            id = rowIndex - 1, -- Zero-based index for click action
            data = {
                PlayerName = selectedPlayer.playerName,
                Position = selectedPlayer.position,
                Rating = selectedPlayer.rating,
                NameTeam = teamname,
                PlayerHead = { name = "$Head", id = selectedPlayer.CARD_ID },
                State = { name = "$State_Hub", id = 1 },
                PlayerTeam = { name = "$Crest", id = teamID },
                PlayerNationality = { name = "$Flag128x128", id = selectedPlayer.nationalityID },
                HomeTeamName = teamname,
                HomeTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_" .. teamID),
                clickAction = "act_advance",
                TeamScoreFontColor = "0xffffff",
                TeamNameFontColor = "0x4A2C6D",
                FontColor = "0x4A2C6D"
            }
        }
    end

    for i = 1, 30 do
        local teamVar = _G["SLOTTM" .. i]
        local playerVar = _G["SLOTPL" .. i]
        
        if teamVar and playerVar then
            local row = createRow(teamVar, playerVar, i)
            if row then
                table.insert(filteredRivalListData, row)
            end
        end
    end

    self.im.Publish(bndMatchList, filteredRivalListData)
end

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

function Liga:PlayMatch(data)
    local currentMatchIndex = data.id + 1

    -- Reindex slots if there are empty (nil) slots or duplicates
    local tempSLOTTM = {}
    local tempSLOTPL = {}
    local seenPairs = {}

    for i = 1, 30 do
        local tmKey = _G["SLOTTM" .. i]
        local plKey = _G["SLOTPL" .. i]

        if tmKey and plKey then
            local pairKey = tostring(tmKey) .. ":" .. tostring(plKey)
            if not seenPairs[pairKey] then
                seenPairs[pairKey] = true
                table.insert(tempSLOTTM, tmKey)
                table.insert(tempSLOTPL, plKey)
            end
        end
    end

    -- Clear original slots and reassign unique valid values sequentially
    for i = 1, 30 do
        _G["SLOTTM" .. i] = tempSLOTTM[i] or nil
        _G["SLOTPL" .. i] = tempSLOTPL[i] or nil
    end

    -- Assign teamID and player ID based on currentMatchIndex
    if currentMatchIndex <= #tempSLOTTM then  -- Ensure index is within bounds
        GLOBAL_TEAMBUY = tempSLOTTM[currentMatchIndex]
        GLOBAL_PLAYERINSTALL = tempSLOTPL[currentMatchIndex]
        SCOUTINDEX = currentMatchIndex
    else
        print("[Liga:PlayMatch]: Index out of bounds. No match data for index " .. currentMatchIndex)
        return  -- or handle this case appropriately
    end

    -- Check if there is a selected match index
    if currentMatchIndex then
        self:Breakthrough() -- Call self:Breakthrough()
    end
end
------------------------------------------------------------------------------------------

function Liga:Breakthrough()
  local buttonRemove = {
	  type = "Cancel",
    icon = "$FooterIconNo",
    label = "Remove",
    clickEvents = {
      "evt_remove",
      "evt_hide_popup"
    }
  }
  local buttonNo = {
	type = "Cancel",
    icon = "$FooterIconNo",

    label = "Cancel",

    clickEvents = {
     
      "evt_hide_popup"

    }

  }
  local buttonYes = {
	  type "Confirm",
    icon = "$FooterIconYes",
    label = "View in team",
    clickEvents = {
      "evt_squad",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "Negotiation",
    message = "Proceed with transfer?",
    buttons = {buttonRemove, buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function Liga:Empty()

  local buttonNo = {
	type = "Cancel",
    icon = "$FooterIconNo",

    label = "Not Now",

    clickEvents = {

      "evt_back",	
      "evt_hide_popup"

    }

  }

  local buttonYes = {
	type = "Confirm",
    icon = "$FooterIconYes",

    label = "Take Me There",

    clickEvents = {

      "evt_team",


      "evt_hide_popup"

    }

  }

  local popupData = {

    title = "SELECT TEAM",

    message = "You haven't selected a Team",

    buttons = {buttonNo, buttonYes}

  }

  self.nav.Event(nil, "evt_show_popup", popupData)

end

function Liga:Insufficient()
  local buttonYes = {
	  type = "Cancel",
    icon = "$FooterIconNo",
    label = "Close",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "Tranfer Negotiation failed",
    message = "Not enough Transfer funds",
    buttons = {buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function Liga:Full()

  local buttonYes = {
	type = "Cancel",
    icon = "$FooterIconNo",

    label = "Close",

    clickEvents = {

      "evt_hide_popup"

    }

  }

  local popupData = {

    title = "Transfer Failed",

    message = "Squad size is too full",

    buttons = {buttonYes}

  }

  self.nav.Event(nil, "evt_show_popup", popupData)

end

function Liga:Small()
	
  local buttonYes = {
	type = "Cancel",
    icon = "$FooterIconNo",

    label = "Close",

    clickEvents = {

      "evt_hide_popup"

    }

  }

  local popupData = {

    title = "Transfer Failed",

    message = "We are not looking to sell \n any of our players at this time",

    buttons = {buttonYes}

  }

  self.nav.Event(nil, "evt_show_popup", popupData)

end

function Liga:Continue()



  local buttonYes = {


	type = "Confirm",
    icon = "$FooterIconNo",



    label = "Close",



    clickEvents = {



      "evt_hide_popup"



    }



  }



  local popupData = {



    title = "Transfer Failed",



    message = "We are not looking to sell \n any of our players at this time",



    buttons = {buttonYes}



  }



  self.nav.Event(nil, "evt_hide_popup", popupData)



end


function Liga:finalize()
  self.im.UnregisterAction(ACT_ADVANCE)
  self.im.Unsubscribe("bnd_match_list")
  self.im.Unsubscribe("bnd_team_crest")
  self.im.Unsubscribe("bnd_team_name")
  self.im.Unsubscribe("bnd_match_label")
  self.im.Unsubscribe("bnd_finish_label")
  rivalListData = {}
  
end

return Liga

-- Thanks : Ma'ruf Id & Laosiji --
-- @mvnprod.official - Remain Be Creative --