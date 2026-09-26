local FUTLoginManager, VirtualButton, TableUtil, EventManager, SKUEnums = ...
local SelectLeagueTeam = {}
local BND_LEAGUE_INDEX = "bnd_league_index"
local BND_LEAGUE_LIST = "bnd_league_list"
local BND_SELECTED_LEAGUE_NAME = "bnd_selected_league_name"
local BND_LEAGUE_OVERLAY_VISIBLE = "bnd_league_overlay_visible"
local BND_TEAM_INDEX = "bnd_team_index"
local BND_TEAM_LIST = "bnd_team_list"
local BND_SELECTED_TEAM_NAME = "bnd_selected_team_name"
local BND_TEAM_OVERLAY_VISIBLE = "bnd_team_overlay_visible"
local BND_TEAM_CREST = "bnd_team_crest"
local BND_LEAGUE_CREST = "bnd_league_crest"
local BND_DETERMINED_PACK_VISIBILITY = "bnd_determined_pack_visible"
local BND_REGULAR_BG_VISIBILITY = "bnd_regular_bg_visible"
local BND_DEFAULT_CELL_DATA = "bnd_default_cell_data"
local BND_LEAGUE_LIST_INDEX = "bnd_league_list_index"
local BND_LEAGUE_LIST_TOGGLE = "bnd_league_list_toggle"
local BND_TEAM_LIST_INDEX = "bnd_team_list_index"
local BND_TEAM_LIST_TOGGLE = "bnd_team_list_toggle"
local BND_TEAM_STAR_RATING = "bnd_team_star_rating"
local BND_TEAM_RATING = "bnd_team_rating"
local ACT_SELECT_LEAGUE = "act_select_league"
local ACT_SELECT_TEAM = "act_select_team"
local ACT_SELECTOR_CANCEL = "act_selector_cancel"
local ACT_CHANGE = "act_change"
local ACT_CONFIRM = "act_confirm"
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local LOGIN_STATUS = FUTLoginManager.FeCards.LoginStatus
local TERMINATION_REASON = SKUEnums.fifaids.TerminationReason
local NUM_COLUMNS = 4
missionmode = "ER"
ligaId = 1
-- EnglandTeams
league1 = { 1,2,7,5,9,10,11,13,14,18,19,110,144,1799,1808,1943,1925,94,17,95}
-- EnglandChampionsTeams
league2 = { 3, 1919, 1796, 1961, 1800, 91, 1952, 8, 1923, 12, 97, 1792, 1951, 1929, 1790, 1801, 15, 1794, 1807, 1806, 106, 1960, 1795, 109 }
-- EnglandOneTeams
league3 = { 1932, 88, 1926, 4, 1962, 15015, 1944, 89, 110890, 143, 1939, 1958, 149, 1940, 1930, 1938, 1793, 1797, 127, 361, 1931, 1917, 1947, 1933 }
-- WomensSuperLeagueTeams
league4 = { 116009, 116015, 116013, 116010, 116016, 116020, 116343, 116017, 116012, 116018, 116011, 116014 }
-- FrenceTeams
league5 = { 57, 1530, 69, 1819, 71, 1738, 65, 70, 72, 66, 219, 73, 64, 76, 378, 379, 74, 1809 }
-- FrenceBTeams
league6 = { 614, 1816, 1813, 1815, 115494, 110569, 62, 294, 217, 68, 226, 59, 1805, 224, 111817, 110321, 111659, 58, 210, 1814, 112552, 110456 }
-- D1ArkemaTeams
league7 = { 116039, 116042, 116036, 116038, 116416, 116037, 116033, 116035, 116034, 116386, 116041, 116040 }
-- GermanyTeams
league8 = { 10029, 111235, 169, 32, 22, 23, 1824, 100409, 21, 110329, 576, 112172, 25, 1831, 36, 160, 175, 38 }
-- Germany2Teams
league9 = { 31, 110588, 171, 110500, 34, 110636, 165, 28, 485, 166, 29, 1832, 531, 10030, 580, 543, 110176, 110502 }
-- IndonesiaTeams
league10 = { 155600, 155607, 155606, 155611, 155614, 155621, 155604, 155602, 155603, 155612, 155616, 155617, 155620, 155605, 155601, 155615, 155610, 155618 }
-- Indonesia2Teams
league11 = { 155609, 155625, 155608, 155626, 155622, 155624, 155623, 155613, 155619 }
-- InternationalTeams
league12 = { 1319, 111448, 111449, 1369, 1415, 1322, 111391, 1325, 111451, 105013, 1370, 111504, 1327, 111453, 111505, 1395, 111455, 111456, 111459, 1413, 111109, 111545, 1383, 111112, 1328, 112054, 1330, 1331, 111465, 111130, 1318, 1334, 1335, 105022, 111461, 112044, 1336, 1337, 111462, 1338, 112046, 112048, 111464, 1886, 1341, 111466, 111510, 111115, 111512, 1355, 1343, 111481, 1411, 111513, 111549, 974, 111392, 111514, 111515, 112049, 111518, 111550, 1386, 111111, 111472, 111521, 105035, 111437, 1393, 110081, 1352, 111523, 111525, 111475, 1375, 111108, 111526, 1353, 1354, 111527, 1356, 1357, 111114, 1359, 1667, 110082, 111528, 1360, 1361, 111099, 1362, 112060, 1363, 1364, 111530, 111532, 112062, 111533, 111606, 111483, 1391, 1365, 1366, 1387, 1377, 111485, 111536, 111487, 111488, 1367, 111489 }
-- InternationalWomansTeams
league13 = { 113996, 112998, 113394, 112999, 113000, 113001, 131139, 131142, 115362, 113002, 113003, 113004, 131147, 116428, 115511, 116440, 113005, 113991, 113006, 113987, 113010, 131144, 113011, 113258, 113997, 113007, 131148, 131143, 115682, 113984, 113998, 113012, 113008, 131140, 113009, 131141, 131145 }
-- ItalyTeams
league14 = { 39,45,44,46,47,48,52,54,55,189,206,1746,1837,110374,111974,111811,110373,347,110741,111434 }
-- ItalyBTeams
league15 = { 50,190,199,203,205,570,1744,1837,1843,1745,1842,1847,1848,110738,111993,111434,112026,112168,112494,112791 }
-- JapanTeams
league16 = { 112906, 113186, 101148, 112444, 112093, 101147, 101145, 111730, 111038, 112092, 113160, 113157, 113161, 101150, 111575, 101146, 101151, 113197 }
-- KoreaTeams
league17 = { 2056, 980, 982, 112115, 112258, 110765, 1478, 1477, 1474, 983, 112558, 1473 }
-- MalaysiaTeams
league18 = { 115618, 115619, 115620, 115617, 115616, 115621 }
-- MexicoTeams
league19 = { 1879,101114,112678,1878,1880,113134,110781,114899,1032,101121,110147,110152,110150,110144,1970,111678,1882,1881 }
-- MoroccoTeams
league20 = { 111498, 111500, 111497, 111499 }
-- NetherlandsTeams
league21 = { 245,246,247,634,645,647,1903,1905,1906,1908,1909,1910,1913,1915,1971,100628,100632,100646 }
-- PortugalTeams
league22 = { 234,236,237,518,744,1438,1887,1896,1892,1893,1898,10031,1888,10020,111539,11898,112809,112513,114510 }
-- RestOfWorldTeams
league23 = { 278, 101099, 101100, 110981, 269, 150650, 315, 101102, 111353, 896, 819, 114426, 114430, 322, 263, 114429, 101101, 114424, 101105, 111596, 1884, 393, 114428, 114427, 110870, 133333, 110943, 100769, 126985, 126986 }
-- SaudiArabiaTeams
league24 = { 113058, 112387, 112390, 113057, 113222, 605, 607, 112883, 112139, 113060, 112391, 112392, 113037, 111674, 112393, 112572, 112408, 112096, 113217 }
-- ScotlandTeams
league25 = { 77,78,80,81,82,83,86,631,181,621,100804,100805 }
-- SouthAfricaTeams
league26 = { 110929, 110935, 110930 }
-- SpainTeams
league27 = { 448, 240, 479, 100888, 450, 463, 241, 1860, 11062, 480, 452, 453, 449, 243, 457, 462, 481, 472, 461, 483 }
-- SpainBTeams
league28 = { 1854, 114554, 10846, 1968, 110831, 110069, 260, 468, 100851, 110832, 1853, 573, 456, 110827, 244, 467, 110839, 2023, 459, 1861, 113981, 110902 }
-- LigaFTeams
league29 = { 116327, 116328, 116325, 116330, 116326 }
-- ThailandTeams
league30 = { 111736,  150600, 112730, 150601 }
-- TurkeyTeams
league31 = { 325,326,327,436,741,746,101007,101014,101016,101020,101028,101033,101041,110776,111117,111339,112120,113142,113796, 112120 }
-- UnitedStatesTeams
league32 = { 687,688,689,691,693,694,695,696,697,698,101112,111065,111138,111139,111144,111651,111928,111140,112134,112606,112828,112885,112893,112996,113149,114161,114162,114640 }
-- UnitedStatesWomensTeams
league33 = { 116303, 116300, 116302, 116304, 116303 }
-- VietnamTeams
league34 = { 150630, 150632, 150631, 150633 }
-- AfcAsiaTeams
league35 = { 111504, 111505, 111510, 111515, 111518, 111521, 111526, 111528, 111533, 111506, 111488 }
-- ArgentinaTeams
league36 = { 1013,1876,1877,110093,110394,110395,110396,110404,110406,110580,110581,101083,101084,101085,101088,111019,111706,111707,111708,111710,111711,111715,111716,112670,112689,112713,112965,113044 }
-- BelgiumTeams
league37 = { 230, 675, 1750, 231, 537, 674, 673, 681, 100081, 110724, 100087, 229, 2014, 680, 670, 232 }
-- BrazilTeams
league38 = { 383,517,568,567,598,1035,1039,1041,1043,1048,1053,1629,111041,111042,111044,111052,111976,112119,112472,115530 }
-- ClassicTeams
league39 = { 128398, 128338, 127032, 128362, 128399, 114422, 128401, 127951, 127924, 127950, 128400, 128004, 128028, 114419, 128396, 114421, 114420, 128299, 127948, 128000, 128322, 128371, 127794, 128397, 127925, 127949, 127993, 127819, 111205, 127889, 128404, 114815, 127887, 127885, 127902, 127901, 127886, 129885, 126425, 127908, 127905, 127907, 129883, 115510, 127903, 127904, 127910, 127906, 127909 }
-- EgyptTeams
league40 = { 150735, 155448, 155447, 155449, 155450 }

function SelectLeagueTeam:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    TeamService = o.api("TeamService"),
    CountryService = o.api("CountryService"),
    UserPlateService = o.api("UserPlateService"),
    GameStateService = o.api("GameStateService"),
    FUTUserInfoService = o.api("FUTUserInfoService"),
    EventManagerService = o.api("EventManagerService"),
    GameState = o.api("GameStateService")
  }
  o.isDeterminationPackKillSwitchOn = o.services.GameStateService.IsDeterminationPackKillSwitchOn()
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end)
  local defaultData = o.services.CountryService.GetDefaultTeamForRegion()
  o.currentCountryID = -1
  o.currentLeagueID = defaultData.leagueID
  o.currentTeamID = defaultData.teamID
  o.favoritePlayerID = -1
  o.countryIndex = 1
  o.leagueIndex = 1
  o.teamIndex = 1
  o.currentTeamName = ""
  o:getLeagues()
  o:registerLeagueBindings()
  o:registerTeamBindings()
  o.im.Subscribe(BND_TEAM_CREST, function()
    o:publishTeamCrest()
  end)
  o.im.Subscribe(BND_LEAGUE_CREST, function()
    o:publishLeagueCrest()
  end)
  o.im.Subscribe(BND_DETERMINED_PACK_VISIBILITY, function()
    o.im.Publish(BND_DETERMINED_PACK_VISIBILITY, not o.isDeterminationPackKillSwitchOn)
  end)
  o.im.Subscribe(BND_REGULAR_BG_VISIBILITY, function()
    o.im.Publish(BND_REGULAR_BG_VISIBILITY, o.isDeterminationPackKillSwitchOn)
  end)
  o.im.Subscribe(BND_LEAGUE_LIST_INDEX, function()
    o:publishLeagueIndex()
  end)
  o.im.Subscribe(BND_LEAGUE_LIST_TOGGLE, function()
    o:publishLeagueToggle()
  end)
  o.im.Subscribe(BND_TEAM_LIST_INDEX, function()
    o:publishTeamIndex()
  end)
  o.im.Subscribe(BND_TEAM_LIST_TOGGLE, function()
    o:publishTeamToggle()
  end)
  o.im.Subscribe(BND_TEAM_STAR_RATING, function()
    o:publishTeamStarRating()
  end)
  o.im.Subscribe(BND_TEAM_RATING, function()
    o:publishTeamRating()
  end)
  o.defaultCellData = {
    label = "",
    image = {},
    id = -1
  }
  o.im.Subscribe(BND_DEFAULT_CELL_DATA, function()
    o.im.Publish(BND_DEFAULT_CELL_DATA, o.defaultCellData)
  end)
  o.im.RegisterAction(ACT_CONFIRM, function(actionName, data)
    o.im.ChangeActionState(ACT_SELECT_LEAGUE, o.im.GetActionState("INVALID"))
    o.im.ChangeActionState(ACT_SELECT_TEAM, o.im.GetActionState("INVALID"))
    o.im.ChangeActionState(ACT_SELECTOR_CANCEL, o.im.GetActionState("INVALID"))
    o.im.ChangeActionState(ACT_CHANGE, o.im.GetActionState("INVALID"))
    o.im.ChangeActionState(ACT_CONFIRM, o.im.GetActionState("INVALID"))
    o.services.FUTUserInfoService.SetUserFavoriteTeam(o.currentTeamID)
  end)
  o.im.RegisterAction(ACT_SELECTOR_CANCEL, function()
    o:onSelectorCancel()
  end)
  o.im.RegisterDataAction(BND_LEAGUE_LIST_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    index = index + 1
    o.leaguesDataToPublish.data[o.leagueIndex].selected = false
    o.leaguesDataToPublish.data[index].selected = true
    o.leaguesDataToPublish.index = index
    o:setSelectedLeagueIndex(index)
    o.im.Refresh(BND_LEAGUE_LIST)
    o.im.Refresh(BND_TEAM_LIST_TOGGLE)
  end)
  o.im.RegisterDataAction(BND_TEAM_LIST_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    index = index + 1
    o.teamsDataToPublish.data[o.teamIndex].selected = false
    o.teamsDataToPublish.data[index].selected = true
    o.teamsDataToPublish.index = index
    o:setSelectedTeamIndex(index)
    o.im.Refresh(BND_TEAM_LIST)
  end)
  if automation then
    print("FTFSelectLeagueTeam automation exists")
    automation.Add("FTFSelectLeagueTeam", {
      FTFSelectLeagueTeam = function(currentTeamID)
        o:_juiceSelectLeagueTeam(currentTeamID)
      end
    })
  end
  return o
end

function SelectLeagueTeam:_juiceSelectLeagueTeam(currentTeamID)
  self.currentTeamID = currentTeamID
  self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(self.currentTeamID)
  self.services.FUTUserInfoService.SetUserFavoriteTeam(self.currentTeamID)
end

function SelectLeagueTeam:getLeagues()
  local leagueNames = {}
  self.leagueIDs = { -- Predefined league IDs
    13, 14, 60, 2216, 16, 17, 2218, 19, 20, 2235,
    2254, 78, 2136, 31, 32, 83, 2237, 341, 2237, 10,
    308, 76, 77, 350, 50, 347, 53, 54, 2222, 2252,
    68, 39, 2221, 2260, 365, 353, 4, 7, 1245, 1246,2231
  }
  local alternateBG = false
  for i = 1, #self.leagueIDs do
    table.insert(leagueNames, {
      label = self.leagueIDs[i], -- Use label based on the ID
      image = {
        name = "$LeagueActive",
        id = self.leagueIDs[i]
      },
      id = i,
      selected = self.currentLeagueID == self.leagueIDs[i] or (self.currentLeagueID == 0 and i == 1),
      alternateBackground = alternateBG
    })
    if self.currentLeagueID == self.leagueIDs[i] or (self.currentLeagueID <= 0 and i == 1) then
      self.currentLeagueID = self.leagueIDs[i]
      self.leagueIndex = i
    end
    if i % NUM_COLUMNS ~= 0 then
      alternateBG = not alternateBG
    end
  end

  self:setSelectedLeagueIndex(self.leagueIndex)
  currentLeagueIndex = self.leagueIndex
  self.leaguesDataToPublish = {
    index = self.leagueIndex,
    data = leagueNames
  }
  self.im.Refresh(BND_LEAGUE_LIST)
end

function SelectLeagueTeam:registerLeagueBindings()
  self.im.Subscribe(BND_LEAGUE_LIST, function()
    self.im.Publish(BND_LEAGUE_LIST, self.leaguesDataToPublish)
  end)
  self.isLeagueSelectorVisible = false
  self.im.Subscribe(BND_LEAGUE_OVERLAY_VISIBLE, function()
    self.im.Publish(BND_LEAGUE_OVERLAY_VISIBLE, self.isLeagueSelectorVisible)
  end)
  self.im.Subscribe(BND_SELECTED_LEAGUE_NAME, function()
    self.im.Publish(BND_SELECTED_LEAGUE_NAME, self.leaguesDataToPublish.data[self.leagueIndex].label)
  end)
  self.im.RegisterAction(ACT_SELECT_LEAGUE, function()
    self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("INVALID"))
    self:toggleLeagueSelectorVisibility(true)
  end)
  self.im.RegisterDataAction(BND_LEAGUE_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    self:toggleLeagueSelectorVisibility(false)
    self:setSelectedLeagueIndexHelper(index)
    self:getLeagues()
    self:publishLeagueToggle()
    self:publishTeamToggle()
    self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("VALID"))
  end)
end

function SelectLeagueTeam:setSelectedLeagueIndex(index)
  self:setSelectedLeagueIndexHelper(index)
  self:publishLeagueCrest()
  self:getTeams()
end

function SelectLeagueTeam:setSelectedLeagueIndexHelper(index)
  if self.leagueIndex ~= index then
    self.leagueIndex = index
    self.currentLeagueID = self.leagueIDs[index]
    self.im.Refresh(BND_SELECTED_LEAGUE_NAME)
    self.currentTeamID = 0
    self.teamIndex = 1
    self.im.Refresh(BND_SELECTED_TEAM_NAME)
  end
end

function SelectLeagueTeam:getTeams()
  local teamNames = {}
  local teamIDs = {}

  -- Select the appropriate team IDs based on leagueIndex
  if self.leagueIndex == 1 then
    teamIDs = league1
    TeamList = league1
  elseif self.leagueIndex == 2 then
    teamIDs = league2
    TeamList = league2
  elseif self.leagueIndex == 3 then
    teamIDs = league3
    TeamList = league3
  elseif self.leagueIndex == 4 then
    teamIDs = league4
    TeamList = league4
  elseif self.leagueIndex == 5 then
    teamIDs = league5
    TeamList = league5
  elseif self.leagueIndex == 6 then
    teamIDs = league6
    TeamList = league6
  elseif self.leagueIndex == 7 then
    teamIDs = league7
    TeamList = league7
  elseif self.leagueIndex == 8 then
    teamIDs = league8
    TeamList = league8
  elseif self.leagueIndex == 9 then
    teamIDs = league9
    TeamList = league9
  elseif self.leagueIndex == 10 then
    teamIDs = league10
    TeamList = league10
  elseif self.leagueIndex == 11 then
    teamIDs = league11
    TeamList = league11
  elseif self.leagueIndex == 12 then
    teamIDs = league12
    TeamList = league12
  elseif self.leagueIndex == 13 then
    teamIDs = league13
    TeamList = league13
  elseif self.leagueIndex == 14 then
    teamIDs = league14
    TeamList = league14
  elseif self.leagueIndex == 15 then
    teamIDs = league15
    TeamList = league15
  elseif self.leagueIndex == 16 then
    teamIDs = league16
    TeamList = league16
  elseif self.leagueIndex == 17 then
    teamIDs = league17
    TeamList = league17
  elseif self.leagueIndex == 18 then
    teamIDs = league18
    TeamList = league18
  elseif self.leagueIndex == 19 then
    teamIDs = league19
    TeamList = league19
  elseif self.leagueIndex == 20 then
    teamIDs = league20
    TeamList = league20
  elseif self.leagueIndex == 21 then
    teamIDs = league21
    TeamList = league21
  elseif self.leagueIndex == 22 then
    teamIDs = league22
    TeamList = league22
  elseif self.leagueIndex == 23 then
    teamIDs = league23
    TeamList = league23
  elseif self.leagueIndex == 24 then
    teamIDs = league24
    TeamList = league24
  elseif self.leagueIndex == 25 then
    teamIDs = league25
    TeamList = league25
  elseif self.leagueIndex == 26 then
    teamIDs = league26
    TeamList = league26
  elseif self.leagueIndex == 27 then
    teamIDs = league27
    TeamList = league27
  elseif self.leagueIndex == 28 then
    teamIDs = league28
    TeamList = league28
  elseif self.leagueIndex == 29 then
    teamIDs = league29
    TeamList = league29
  elseif self.leagueIndex == 30 then
    teamIDs = league30
    TeamList = league30
  elseif self.leagueIndex == 31 then
    teamIDs = league31
    TeamList = league31
  elseif self.leagueIndex == 32 then
    teamIDs = league32
    TeamList = league32
  elseif self.leagueIndex == 33 then
    teamIDs = league33
    TeamList = league33
  elseif self.leagueIndex == 34 then
    teamIDs = league34
    TeamList = league34
  elseif self.leagueIndex == 35 then
    teamIDs = league35
    TeamList = league35
  elseif self.leagueIndex == 36 then
    teamIDs = league36
    TeamList = league36
  elseif self.leagueIndex == 37 then
    teamIDs = league37
    TeamList = league37
  elseif self.leagueIndex == 38 then
    teamIDs = league38
    TeamList = league38
  elseif self.leagueIndex == 39 then
    teamIDs = league39
    TeamList = league39
  elseif self.leagueIndex == 40 then
    teamIDs = league40
    TeamList = league40
  end
  currentLeagueIndex = self.leagueIndex

  local alternateBG = false
  self.teamsData = self.services.TeamService.GetTeams(self.currentLeagueID, 0, 0, false) -- Initialize teamsData as an empty table
  for i = 1, #teamIDs do
    local teamData = {
      id = teamIDs[i],
      name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamIDs[i]) -- Placeholder name
    }
    table.insert(self.teamsData, teamData) -- Add to teamsData
    table.insert(teamNames, {
      label = teamData.name,
      image = {
        name = "$Crest",
        id = teamData.id
      },
      id = i,
      selected = self.currentTeamID == teamData.id or (self.currentTeamID == 0 and i == 1),
      alternateBackground = alternateBG,
      stars = teamData.starRating
    })
    if self.currentTeamID == teamData.id or (self.currentTeamID == 0 and i == 1) then
      self.currentTeamID = teamData.id
      self.teamIndex = i
      currentSelectedTeamID = teamData.id
    end
    if i % NUM_COLUMNS ~= 0 then
      alternateBG = not alternateBG
    end
  end

  self:setSelectedTeamIndex(self.teamIndex)
  self.teamsDataToPublish = {
    index = self.teamIndex,
    data = teamNames
  }
  self.im.Refresh(BND_TEAM_LIST)
end

function SelectLeagueTeam:registerTeamBindings()
  self.im.Subscribe(BND_TEAM_LIST, function()
    self.im.Publish(BND_TEAM_LIST, self.teamsDataToPublish)
  end)
  self.isTeamSelectorVisible = false
  self.im.Subscribe(BND_TEAM_OVERLAY_VISIBLE, function()
    self.im.Publish(BND_TEAM_OVERLAY_VISIBLE, self.isTeamSelectorVisible)
  end)
  self.im.Subscribe(BND_SELECTED_TEAM_NAME, function()
    self.im.Publish(BND_SELECTED_TEAM_NAME, self.teamsDataToPublish.data[self.teamIndex].label)
  end)
  self.im.RegisterAction(ACT_SELECT_TEAM, function()
    self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("INVALID"))
    self:toggleTeamSelectorVisibility(true)
  end)
  self.im.RegisterDataAction(BND_TEAM_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    self:toggleTeamSelectorVisibility(false)
    self:setSelectedTeamIndexHelper(index)
    self:getTeams()
    self:publishTeamToggle()
    self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("VALID"))
  end)
end

function SelectLeagueTeam:setSelectedTeamIndex(index)
  self:setSelectedTeamIndexHelper(index)
  self:publishTeamCrest()
end

function SelectLeagueTeam:setSelectedTeamIndexHelper(index)
  if self.teamIndex ~= index then
    self.teamIndex = index
    self.currentTeamID = self.teamsData[index].id
    self.im.Refresh(BND_SELECTED_TEAM_NAME)
  end
end

function SelectLeagueTeam:toggleLeagueSelectorVisibility(visible)
  if self.isLeagueSelectorVisible ~= visible then
    self.isLeagueSelectorVisible = visible
    self.im.Refresh(BND_LEAGUE_OVERLAY_VISIBLE)
  end
end

function SelectLeagueTeam:toggleTeamSelectorVisibility(visible)
  if self.isTeamSelectorVisible ~= visible then
    self.isTeamSelectorVisible = visible
    self.im.Refresh(BND_TEAM_OVERLAY_VISIBLE)
  end
end

function SelectLeagueTeam:onSelectorCancel()
  if self.isLeagueSelectorVisible then
    self:toggleLeagueSelectorVisibility(false)
  elseif self.isTeamSelectorVisible then
    self:toggleTeamSelectorVisibility(false)
  end
  self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("VALID"))
end

function SelectLeagueTeam:checkFUTConnection()
  local loginStatus = self.services.FUTUserInfoService.GetLoginStatus()
  if loginStatus == LOGIN_STATUS.LS_FAILED or loginStatus == LOGIN_STATUS.LS_DISCONNECTED then
    self.im.ChangeActionState(ACT_CONFIRM, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_CHANGE, self.im.GetActionState("INVALID"))
    local buttonOk = VirtualButton:new({
      nav = self.nav,
      label = "LTXT_CMN_OK",
      clickEvents = {
        "evt_hide_popup"
      },
      clickCallback = function()
        self:_enableScreen()
      end
    })
    popupData = {
      title = "LTXT_INV_RESULTS_ERROR",
      message = "LTXT_NETWORK_ERROR",
      buttons = {buttonOk}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
  end
end

function SelectLeagueTeam:_enableScreen()
  self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_SELECTOR_CANCEL, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_CHANGE, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_CONFIRM, self.im.GetActionState("VALID"))
end

function SelectLeagueTeam:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.FosFavoriteTeamComplete then
    if data.success then
      self.currentCountryID = self.services.CountryService.GetCountryInfoByFUTLeagueId(self.currentLeagueID).id
      self.services.UserPlateService.SetFavorites(self.currentCountryID, self.currentTeamID, self.favoritePlayerID)
      self.nav.Event(nil, "evt_advance")
    else
      local buttonOk = {
        label = "LTXT_CMN_OK",
        clickEvents = {
          "evt_hide_popup"
        },
        clickCallback = function()
          self:_enableScreen()
        end
      }
      local popupData = {
        title = "LTXT_CMN_FUT_ERROR_TITLE",
        message = "LTXT_SERVER_UNAVAILABLE",
        buttons = {buttonOk}
      }
      self.nav.Event(nil, "evt_show_popup", popupData)
    end
  elseif eventType == EVENT_TYPES.OnBackPressed then
  end
end

function SelectLeagueTeam:_publishData(bindingName)
  if bindingName == BND_LEAGUE_LIST then
    self.im.Publish(bindingName, self.leagues)
  elseif bindingName == BND_TEAM_LIST then
    self.im.Publish(bindingName, self.clubs)
  end
end

function SelectLeagueTeam:_publishTeamName()
  if self.currentTeamID == -1 then
    self.currentTeamName = ""
  end
  self.im.Publish(BND_TEAM_NAME, self.currentTeamName)
end

function SelectLeagueTeam:publishLeagueCrest()
  if self.currentLeagueID ~= -1 then
    local leagueCrest = {
      name = "$LeagueCrest",
      id = self.currentLeagueID
    }
    self.im.Publish(BND_LEAGUE_CREST, leagueCrest)
  end
end

function SelectLeagueTeam:publishTeamCrest()
  if self.currentTeamID ~= -1 then
  currentSelectedTeamID = self.currentTeamID
    self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(self.currentTeamID)
    local teamCrest = {
      name = "$Crest",
      id = self.currentTeamID
    }
    self.im.Publish(BND_TEAM_CREST, teamCrest)
    self:publishTeamStarRating()
    self:publishLeagueToggle()
    self:publishTeamRating()
  else
    self.favoritePlayerID = -1
  end
end

function SelectLeagueTeam:publishLeagueToggle()
  local leagueData = {}
  for i = 1, #self.leagueIDs do
    local name = self.loc.LocalizeString("LeagueName_Abbr15_" .. self.leagueIDs[i])
    table.insert(leagueData, {
      name = name,
      id = i,
      styles = {
        "TF_SELECT_FAVORITE_LEAGUE_TOGGLE"
      }
    })
  end
  self.im.Publish(BND_LEAGUE_LIST_TOGGLE, {
    data = leagueData,
    index = self.leagueIndex - 1
  })
end

function SelectLeagueTeam:publishLeagueIndex()
  self:publishLeagueCrest()
  self.im.Publish(BND_LEAGUE_LIST_INDEX, self.leagueIndex)
end

function SelectLeagueTeam:publishTeamToggle()
  local teamData = {}
  for i = 1, #self.teamsData do
    local name = self.teamsData[i].name
    table.insert(teamData, {
      name = name,
      id = i,
      styles = {
        "TF_SELECT_FAVORITE_TEAM_TOGGLE"
      }
    })
  end
  self.im.Publish(BND_TEAM_LIST_TOGGLE, {
    data = teamData,
    index = self.teamIndex - 1
  })
end

function SelectLeagueTeam:publishTeamIndex()
  self:publishTeamCrest()
  self.im.Publish(BND_TEAM_LIST_INDEX, self.teamIndex)
end

function SelectLeagueTeam:publishTeamStarRating()
  self.im.Publish(BND_TEAM_STAR_RATING, self.teamsData[self.teamIndex].starRating)
end
function SelectLeagueTeam:publishTeamRating()
  local teamRating = {
    attackValue = string.format("%d", self.teamsData[self.teamIndex].offense),
    middleValue = string.format("%d", self.teamsData[self.teamIndex].midfield),
    defenseValue = string.format("%d", self.teamsData[self.teamIndex].defense),
    attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
    middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
    defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
  }
  self.im.Publish(BND_TEAM_RATING, teamRating)
end

function SelectLeagueTeam:finalize()
  self.im.Unsubscribe(BND_LEAGUE_LIST)
  self.im.Unsubscribe(BND_SELECTED_LEAGUE_NAME)
  self.im.Unsubscribe(BND_LEAGUE_OVERLAY_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_LIST)
  self.im.Unsubscribe(BND_SELECTED_TEAM_NAME)
  self.im.Unsubscribe(BND_TEAM_OVERLAY_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_CREST)
  self.im.Unsubscribe(BND_LEAGUE_CREST)
  self.im.Unsubscribe(BND_DETERMINED_PACK_VISIBILITY)
  self.im.Unsubscribe(BND_REGULAR_BG_VISIBILITY)
  self.im.Unsubscribe(BND_LEAGUE_LIST_TOGGLE)
  self.im.Unsubscribe(BND_TEAM_LIST_INDEX)
  self.im.Unsubscribe(BND_TEAM_LIST_TOGGLE)
  self.im.Unsubscribe(BND_TEAM_STAR_RATING)
  self.im.Unsubscribe(BND_TEAM_RATING)
  self.im.Unsubscribe(BND_LEAGUE_LIST_INDEX)
  self.im.Unsubscribe(BND_DEFAULT_CELL_DATA)
  self.im.UnregisterDataAction(BND_LEAGUE_LIST_INDEX, ACT_CHANGE)
  self.im.UnregisterDataAction(BND_TEAM_LIST_INDEX, ACT_CHANGE)
  self.im.UnregisterDataAction(BND_LEAGUE_INDEX, ACT_CHANGE)
  self.im.UnregisterDataAction(BND_TEAM_INDEX, ACT_CHANGE)
  self.im.UnregisterAction(ACT_CONFIRM)
  self.im.UnregisterAction(ACT_SELECTOR_CANCEL)
  self.im.UnregisterAction(ACT_SELECT_LEAGUE)
  self.im.UnregisterAction(ACT_SELECT_TEAM)
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return SelectLeagueTeam