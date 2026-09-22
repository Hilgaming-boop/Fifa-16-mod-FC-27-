-- mod by laosiji --
local events = {}
print("loaded events LUA")
local bndHomeEventsList = "bnd_home_events_list"
local bndAwayEventsList = "bnd_away_events_list"
local bndEmptyRowsData = "bnd_empty_rows_data"
local NUM_EMPTY_LIST_ROWS = 9
local DEFAULT_ICON_HOME_OFFSET = 60
local DEFAULT_ICON_AWAY_OFFSET = 105
local OFFSET_PER_EXTRA_CHAR = 10
local DEFAULT_MINUTE_STRING_LENGTH = 4
function events:new(init)
  print("New Function MatchEventsLua")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    matchInfo = o.api("MatchInfoService"),
    SquadManagementService = o.api("SquadMgtService")
  }
  self.eventsData = o.services.matchInfo.GetMatchEvents()

  o.TeamsData = o.services.matchInfo.GetMatchTeams()
  -- o.homeTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(0, o.TeamsData[1].assetId, 0)
  -- o.awayTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(1, o.TeamsData[2].assetId, 0)

  o.mAdditionalIconOffset = (string.len(o.loc.LocalizeString("LTXT_VAR_EISM_MINUTE")) - DEFAULT_MINUTE_STRING_LENGTH) * OFFSET_PER_EXTRA_CHAR
  o.im.Subscribe(bndHomeEventsList, function()
    o:publishHomeEventsList()
  end)
  o.im.Subscribe(bndAwayEventsList, function()
    o:publishAwayEventsList()
  end)
  o.im.Subscribe(bndEmptyRowsData, function()
    o:publishEmptyBgRows()
  end)
  return o
end

function events:publishHomeEventsList()
  local o = self.eventsData.homeData
  for i, v in ipairs(o) do
    local playerInfo = self:getPlayerInfo(o[i].data.assetId, o[i].data.name, o[i].data.number)
    v.data.image = {
      name = "$Events",
      id = o[i].data.eventId
    }
    v.data.iconOffset = DEFAULT_ICON_HOME_OFFSET + self.mAdditionalIconOffset
    v.data.head = {
      name = "$Head",
      id = playerInfo.assetId
    }
  end
  self.im.Publish(bndHomeEventsList, self.eventsData.homeData)
end

function events:publishAwayEventsList()
  local o = self.eventsData.awayData
  for i, v in ipairs(o) do
    local playerInfo = self:getPlayerInfo(o[i].data.assetId, o[i].data.name, o[i].data.number)
    v.data.image = {
      name = "$Events",
      id = o[i].data.eventId
    }
    v.data.head = {
      name = "$Head",
      id = playerInfo.assetId
    }
    v.data.iconOffset = DEFAULT_ICON_AWAY_OFFSET + self.mAdditionalIconOffset
  end
  self.im.Publish(bndAwayEventsList, self.eventsData.awayData)
end

function events:publishEmptyBgRows()
  local emptyDataArr = {}
  for i = 1, NUM_EMPTY_LIST_ROWS do
    table.insert(emptyDataArr, {
      data = {dummyParam = 0}
    })
  end
  self.im.Publish(bndEmptyRowsData, emptyDataArr)
end

function events:getPlayerInfo(teamID, name, number)
  local count = 0
  local specialString = false
  local playerInfo = {
    assetId = 0,
    jerseyNumber = number,
    playerName = name
  }
  local teamlineupData = nil
  
  if teamID == self.TeamsData[1].assetId then
    teamlineupData = homeTeamlineupData
  else
    teamlineupData = awayTeamlineupData
  end

  if string.find(name, "-") or string.find(name, "%.") then
    specialString = true
  end
 
  if specialString == false then
    count = 0
    playerInfo.playerName =  string.gsub(name, "%b()", " ")
    playerInfo.playerName =  string.gsub(playerInfo.playerName, "^%s*(.-)%s*$", "%1")
  end
  
  for _FORV_6_ = 1, table.getn(teamlineupData) do
    if _FORV_6_ <= 18 then
      if specialString == true then
        if string.find(name, teamlineupData[_FORV_6_].playerName, 1, true) and teamlineupData[_FORV_6_].jerseyNumber == number then 
          if count == 0 then
            count = count + 1
            playerInfo.assetId = teamlineupData[_FORV_6_].CARD_ID
            playerInfo.jerseyNumber = teamlineupData[_FORV_6_].jerseyNumber
            playerInfo.playerName = teamlineupData[_FORV_6_].playerName
          end
        end
      else
        if string.find(playerInfo.playerName, teamlineupData[_FORV_6_].playerName,1,true) and playerInfo.playerName == teamlineupData[_FORV_6_].playerName and teamlineupData[_FORV_6_].jerseyNumber == number then
          if count == 0 then
            count = count + 1
            playerInfo.assetId = teamlineupData[_FORV_6_].CARD_ID
            playerInfo.jerseyNumber = teamlineupData[_FORV_6_].jerseyNumber
            playerInfo.playerName = teamlineupData[_FORV_6_].playerName
          end
        end
      end
    end
  end
  return playerInfo
end

function events:finalize()
  self.im.Unsubscribe(bndHomeEventsList)
  self.im.Unsubscribe(bndAwayEventsList)
  self.im.Unsubscribe(bndEmptyRowsData)
end
return events
