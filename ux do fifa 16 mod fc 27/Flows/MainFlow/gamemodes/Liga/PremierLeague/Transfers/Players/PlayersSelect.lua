-- New Custom Menu By MVNPROD --
local MensHub = {}
local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local BND_TAB4_VISIBLE = "bnd_tab4_visible"
local BND_TAB5_VISIBLE = "bnd_tab5_visible"
local BND_TAB6_VISIBLE = "bnd_tab6_visible"
local BND_TAB7_VISIBLE = "bnd_tab7_visible"
local BND_TAB8_VISIBLE = "bnd_tab8_visible"
local ACT_MVNPROD = "act_mvnprod"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5
local TAB6 = 6
local TAB7 = 7
local TAB8 = 8

local BND_PLAYER_LIST = "bnd_player_list"
local ACT_PLAYER_SELECT = "act_player_select"
local ACT_SCROLL_DOWN = "act_scroll_down"
local ACT_SCROLL_UP = "act_scroll_up"
local ACT_ADVANCE = "act_advance"

local BigTeams = {
    [241] = true,
    [243] = true,
    [240] = true,
    [10] = true,
    [9] = true,
    [21] = true,
    [73] = true,
    [45] = true,
    [5] = true,
    [11] = true,
    [1] = true,
    [44] = true,
    [131681] = true,
    [22] = true,
    [245] = true,
    [234] = true,
    [1876] = true,
    [110374] = true
}

local MidTeams = {
    [1877] = true,
    [449] = true,
    [457] = true,
    [2] = true,
    [448] = true,
    [110] = true,
    [110374] = true,
    [189] = true,
    [36] = true,
    [175] = true,
    [65] = true,
    [74] = true
}

local SmallTeams = {
    [20969688] = true
}

local playerListData = {}
local scoutingCache = {}
local currentPlayerIndex = 1
local playersPerPage = 8
local allPlayersData = {}
local selectedPlayerIndex = nil

function MensHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    EventManagerService = o.api("EventManagerService"),
    BrowserService = o.api("BrowserService"),
    MiscService = o.api("MiscService"),
    SquadManagementService = o.api("SquadMgtService")
  }
  o.player3d = {
    name = "$",
    id = 0
  }
  math.randomseed(os.clock() * 1543 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(10)
  
  o.im.Subscribe("bnd_player3d", function()
    o.player3d.id = random2
    o.im.Publish("bnd_player3d", o.player3d)
  end)
  
-- ðŸ”¹ O.IM SUBSCRIBE EVENT
o.im.Subscribe("bnd_leaguebackground", function()
  local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_leaguebackground", bg)
end)

o.im.Subscribe("bnd_table_career", function()
  local tb = getLeagueTableByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_table_career", tb)
end)
  
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)
  
  o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5, TAB6, TAB7, TAB8 }
  o.im.Subscribe(BND_TAB1_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB2_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB3_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB4_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB5_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB6_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB7_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB8_VISIBLE, function()
  end)
  
o:initializePlayerSystem()

o:resetToFirstPage()
  
  o.im.RegisterAction(ACT_MVNPROD, function(actionName, data)
    o:HideSelections()
    local tabIndex = o.buttonsID[data.buttonID + 1]

    if tabIndex then
        o.im.Publish("bnd_tab" .. tabIndex .. "_visible", true)

        local playerSlot = tabIndex
        if playerSlot <= #playerListData then
            selectedPlayerIndex = playerSlot
            o:publishPlayerRows()
            o:publishSelectedPlayerInfo()
        end
    end
end)
  
  return o
end

function MensHub:initializePlayerSystem()
  self:loadAllPlayers()
  
  for i = 1, playersPerPage do
    self.im.Subscribe("bnd_player_" .. i, function()
      self:publishPlayerData(i)
    end)
    
    self.im.Subscribe("bnd_player_name_" .. i, function()
      self:publishPlayerData(i)
    end)
    
    self.im.Subscribe("bnd_player_age_" .. i, function()
      self:publishPlayerData(i)
    end)
    
    self.im.Subscribe("bnd_player_age_label_" .. i, function()
      self:publishPlayerData(i)
    end)
    
    self.im.Subscribe("bnd_player_country_" .. i, function()
      self:publishPlayerData(i)
    end)
    
    self.im.Subscribe("bnd_player_position_" .. i, function()
      self:publishPlayerData(i)
    end)
    
    self.im.Subscribe("bnd_player_crest_" .. i, function()
      self:publishPlayerData(i)
    end)
    
    self.im.Subscribe("bnd_player_rating_" .. i, function()
      self:publishPlayerData(i)
    end)
  end
  
  self.im.Subscribe(BND_PLAYER_LIST, function()
    self:publishPlayerRows()
  end)
  
  self.im.Subscribe("bnd_selected_player_info", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_rating_range", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_scouting_percentage", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_name", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_head", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_position", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_rating", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_nationality", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_team", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_player_age", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_team_name_3", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_scouting_msg", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_advertasing_msg", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_first_name", function()
    self:publishSelectedPlayerInfo()
  end)
  
  self.im.Subscribe("bnd_selected_player_last_name", function()
    self:publishSelectedPlayerInfo()
  end)
  
    for i = 1, 6 do
    self.im.Subscribe("bnd_selected_player_stat_" .. i, function()
        self:publishSelectedPlayerInfo()
    end)
    
    self.im.Subscribe("bnd_selected_player_stat_label_" .. i, function()
        self:publishSelectedPlayerInfo()
    end)
end
  
  for i = 1, playersPerPage do
    self.im.RegisterAction("act_player_" .. i, function(actionName, data)
      self:selectPlayer(i)
    end)
  end
  
  self.im.RegisterAction(ACT_SCROLL_DOWN, function(actionName, data)
    self:scrollPlayers(1)
  end)
  
  self.im.RegisterAction(ACT_SCROLL_UP, function(actionName, data)
    self:scrollPlayers(-1)
  end)
  
  self.im.RegisterAction(ACT_ADVANCE, function(actionName, data)
    self:addToHub(data)
  end)
end

function MensHub:resetToFirstPage()
    currentPlayerIndex = 1
    selectedPlayerIndex = 1
    self:updatePlayerList()
    self:publishPlayerRows()
    self:publishSelectedPlayerInfo()
    
    self:HideSelections()
    self.im.Publish(BND_TAB1_VISIBLE, true)
    
    print("Sistema de jugadores resetado a la primera página")
end

function MensHub:getLeagueColor()
    local currentLeague = self:getCurrentLeague()
    return leagueColors[currentLeague] or leagueColors[0] 
end

function MensHub:getCurrentLeague()
    if not currentSelectedTeamID then
        return 0
    end
    
    local teamService = self.api("TeamService")
    if teamService and teamService.GetTeamLeague then
        local leagueID = teamService.GetTeamLeague(currentSelectedTeamID)
        if leagueID and leagueID > 0 then
            return leagueID
        end
    end
    
    local leagueMap = {
        -- 1
[269]=1, [270]=1, [271]=1, [819]=1, [820]=1, [822]=1, [1443]=1, [1447]=1,
[1516]=1, [1786]=1, [1788]=1, [15001]=1,

-- 4
[681]=4, [1750]=4, [670]=4, [100081]=4, [229]=4, [100087]=4, [110724]=4,
[230]=4, [673]=4, [680]=4, [231]=4, [674]=4, [232]=4, [2014]=4, [537]=4,
[675]=4,

-- 7
[1629]=7, [598]=7, [1035]=7, [111052]=7, [517]=7, [1048]=7, [383]=7,
[567]=7, [1598]=7, [1041]=7, [111041]=7, [1719]=7, [569]=7, [568]=7,
[1043]=7, [112472]=7, [1053]=7, [111059]=7, [111057]=7, [130361]=7,

-- 10
[634]=10, [1913]=10, [245]=10, [1903]=10, [247]=10, [1910]=10, [100632]=10,
[1908]=10, [246]=10, [100646]=10, [1906]=10, [1915]=10, [1914]=10,
[100634]=10, [1904]=10, [645]=10, [1971]=10,

-- 13
[13]=13, [1925]=13, [14]=13, [110]=13, [18]=13, [19]=13, [5]=13, [2]=13,
[10]=13, [144]=13, [1]=13, [11]=13, [1799]=13, [1943]=13, [1808]=13,
[7]=13, [9]=13, [8]=13, [1796]=13, [106]=13, [1794]=13,

-- 14
[15]=14, [97]=14, [1800]=14, [1919]=14, [109]=14, [1960]=14, [1952]=14,
[1807]=14, [1806]=14, [12]=14, [3]=14, [1795]=14, [1792]=14,
[1951]=14, [1790]=14, [91]=14, [1801]=14, [88]=14, [1947]=14, [17]=14,
[94]=14, [95]=14, [89]=14,

-- 16
[65]=16, [69]=16, [76]=16, [219]=16, [73]=16, [66]=16, [64]=16, [74]=16,
[1738]=16, [72]=16, [71]=16, [1530]=16, [57]=16, [378]=16, [379]=16,
[1809]=16, [217]=16, [111817]=16,

-- 17
[210]=17, [62]=17, [294]=17, [1816]=17, [111659]=17, [1815]=17,
[115494]=17, [58]=17, [110321]=17, [1814]=17, [1805]=17, [614]=17,
[68]=17, [67]=17, [111273]=17, [111276]=17, [70]=17, [1819]=17,

-- 19
[175]=19, [38]=19, [112172]=19, [23]=19, [36]=19, [32]=19, [1831]=19,
[21]=19, [100409]=19, [1824]=19, [25]=19, [111235]=19, [22]=19,
[110329]=19, [10029]=19, [169]=19, [31]=19, [28]=19,

-- 20
[580]=20, [165]=20, [110500]=20, [10030]=20, [1832]=20, [34]=20, [485]=20,
[166]=20, [171]=20, [110636]=20, [29]=20, [531]=20, [110588]=20,
[110502]=20, [160]=20, [576]=20, [159]=20, [503]=20, [523]=20,

-- 31
[52]=31, [46]=31, [347]=31, [55]=31, [1842]=31, [110556]=31, [206]=31,
[110374]=31, [39]=31, [48]=31, [44]=31, [54]=31, [45]=31, [189]=31,
[50]=31, [1745]=31, [47]=31, [110738]=31, [111974]=31, [111434]=31,

-- 32
[1746]=32, [205]=32, [111811]=32, [1744]=32, [1837]=32, [1843]=32,
[1848]=32, [110373]=32, [110740]=32, [110908]=32, [110915]=32,
[111433]=32, [111657]=32, [111993]=32, [112124]=32, [112168]=32,
[112493]=32, [112494]=32, [190]=32, [110741]=32,

-- 39
[111140]=39, [114161]=39, [697]=39, [114640]=39, [111928]=39, [693]=39,
[688]=39, [112828]=39, [694]=39, [691]=39, [113149]=39, [112893]=39,
[114162]=39, [112885]=39, [687]=39, [112134]=39, [101112]=39,
[112996]=39, [112606]=39, [111651]=39, [698]=39, [111065]=39, [696]=39,
[689]=39, [111139]=39, [111138]=39, [695]=39, [111144]=39, [113018]=39,
[115243]=39,

-- 50
[81]=50, [181]=50, [83]=50, [77]=50, [80]=50, [100805]=50, [78]=50,
[86]=50, [82]=50, [180]=50, [79]=50, [621]=50,

-- 53
[1860]=53, [449]=53, [457]=53, [243]=53, [461]=53, [240]=53, [241]=53,
[453]=53, [448]=53, [450]=53, [483]=53, [110062]=53, [481]=53, [479]=53,
[463]=53, [480]=53, [452]=53, [110827]=53, [1853]=53, [468]=53,

-- 54
[472]=54, [100888]=54, [462]=54, [467]=54, [456]=54, [1861]=54,
[110839]=54, [1854]=54, [459]=54, [260]=54, [110069]=54, [573]=54,
[100851]=54, [10846]=54, [244]=54, [110832]=54, [1968]=54, [242]=54,
[1867]=54, [100852]=54, [110242]=54, [121110]=54,

-- 56
[319]=56, [320]=56, [321]=56, [433]=56, [700]=56, [702]=56, [708]=56,
[710]=56, [711]=56, [1439]=56, [111594]=56, [111705]=56, [112072]=56,
[112126]=56, [112180]=56, [113458]=56,

-- 60
[1797]=60, [1793]=60, [1933]=60, [4]=60, [1930]=60, [1926]=60, [1917]=60,
[1958]=60, [361]=60, [149]=60, [1939]=60, [1932]=60, [1938]=60,
[15015]=60, [1940]=60, [1931]=60, [143]=60, [142]=60, [1928]=60,
[1804]=60, [1923]=60, [1929]=60, [1961]=60, [112259]=60,

-- 65
[305]=65, [306]=65, [423]=65, [445]=65, [563]=65, [753]=65, [834]=65,
[837]=65, [1571]=65, [1572]=65,

-- 66
[301]=66, [420]=66, [873]=66, [1871]=66, [110206]=66, [110745]=66,
[110746]=66, [110747]=66, [110749]=66, [111083]=66, [111086]=66,
[111088]=66, [111091]=66, [111092]=66, [111097]=66, [114004]=66,
[114326]=66, [114393]=66,

-- 67
[312]=67, [315]=67, [100764]=67, [100765]=67, [100767]=67, [100769]=67,
[110102]=67, [110109]=67, [110227]=67, [110231]=67, [110232]=67,
[110239]=67, [112217]=67, [112218]=67, [112261]=67, [130988]=67,
[110222]=67,

-- 68
[326]=68, [325]=68, [110776]=68, [436]=68, [327]=68, [101041]=68,
[101033]=68, [113142]=68, [111339]=68, [101028]=68, [101014]=68,
[101020]=68, [101016]=68, [741]=68, [748]=68, [101026]=68, [101037]=68,
[121174]=68, [121388]=68,

-- 76
[133333]=76, [263]=76, [110870]=76, [393]=76, [1884]=76, [278]=76,
[111596]=76, [110943]=76, [111353]=76, [110981]=76, [115650]=76,
[115651]=76, [115652]=76, [115700]=76, [110969]=76, [110968]=76,
[110986]=76, [112908]=76, [112716]=76, [111008]=76, [111010]=76,
[111014]=76, [110989]=76, [110990]=76, [130109]=76, [257]=76, [130633]=76,
[100135]=76, [100325]=76, [130678]=76, [130733]=76, [101315]=76,
[100820]=76, [101070]=76, [130615]=76, [111969]=76, [264]=76, [100818]=76,
[111282]=76, [417]=76, [110472]=76, [130053]=76, [1202]=76, [112028]=76,
[129105]=76, [129107]=76, [130250]=76, [129108]=76, [129109]=76,
[111160]=76, [129229]=76, [129112]=76, [129113]=76, [129114]=76,
[129148]=76, [129117]=76, [130258]=76, [130927]=76, [129115]=76,
[129116]=76, [130246]=76, [129128]=76, [129129]=76, [129130]=76,
[130244]=76, [129118]=76, [129119]=76, [129155]=76, [129120]=76,
[129121]=76, [130249]=76, [129122]=76, [129123]=76, [129125]=76,
[129126]=76, [129127]=76, [130259]=76, [129205]=76, [130245]=76,
[130929]=76, [129131]=76, [129156]=76, [129157]=76, [129158]=76,
[129197]=76, [129201]=76, [129202]=76, [129203]=76, [130257]=76,
[129159]=76, [129133]=76, [129196]=76, [110941]=76, [130247]=76,
[130930]=76, [130251]=76, [129050]=76, [129134]=76, [129135]=76,
[129136]=76, [129137]=76, [130248]=76, [111172]=76, [129147]=76,
[129195]=76, [129138]=76, [129194]=76, [129145]=76, [129149]=76,
[129209]=76, [130255]=76, [130256]=76, [129143]=76, [129151]=76,
[129217]=76, [129222]=76, [129225]=76, [130243]=76, [130932]=76,
[129140]=76, [129141]=76, [129032]=76, [129033]=76, [129142]=76,
[129200]=76, [130238]=76, [130933]=76, [129152]=76, [110940]=76,
[129198]=76, [130936]=76, [130180]=76, [112090]=76, [101142]=76,
[111727]=76, [112812]=76, [116493]=76, [130184]=76, [130028]=76,
[130025]=76, [130185]=76, [111731]=76, [130187]=76, [130163]=76,
[130026]=76, [130188]=76, [112208]=76, [130227]=76, [115701]=76,
[114423]=76, [114427]=76, [114424]=76, [114426]=76, [114430]=76,
[114428]=76, [114429]=76, [114425]=76, [112190]=76
    }
    
    return leagueMap[currentSelectedTeamID] or 0
end

function MensHub:loadAllPlayers()
  allPlayersData = {}
  
local searchedTeamID = CURRENTCLUBID or 1
local teamLineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, searchedTeamID, 0)
  
  if teamLineup then
    for i, player in ipairs(teamLineup) do
      table.insert(allPlayersData, {
    CARD_ID = player.CARD_ID,
    playerName = player.playerName,
    nationalityID = player.nationalityID,
    position = player.position,
    rating = player.rating,
    teamID = searchedTeamID, 
    stat1 = player.stat1 or 0,
    stat2 = player.stat2 or 0,
    stat3 = player.stat3 or 0,
    stat4 = player.stat4 or 0,
    stat5 = player.stat5 or 0,
    stat6 = player.stat6 or 0
})
    end
  end
  
  self:updatePlayerList()
end

function MensHub:updatePlayerList()
  playerListData = {}
  
  local startIndex = (currentPlayerIndex - 1) * playersPerPage + 1
  local endIndex = math.min(startIndex + playersPerPage - 1, #allPlayersData)
  
  for i = startIndex, endIndex do
    local player = allPlayersData[i]
    if player then
      table.insert(playerListData, {
        index = i,
        data = player
      })
    end
  end
end

function MensHub:publishPlayerData(playerSlot)
    if playerSlot < 1 or playerSlot > playersPerPage then return end

    local playerData = playerListData[playerSlot]

    if playerData then
        local player = playerData.data

        local displayName = self:shortenPlayerName(player.playerName)

        self.im.Publish("bnd_player_" .. playerSlot, {
            name = "$Head",
            id = player.CARD_ID
        })

        self.im.Publish("bnd_player_name_" .. playerSlot, displayName)
        self.im.Publish("bnd_player_country_" .. playerSlot, {
            name = "$Flag128x128",
            id = player.nationalityID
        })
        self.im.Publish("bnd_player_position_" .. playerSlot, player.position)
        self.im.Publish("bnd_player_crest_" .. playerSlot, {
            name = "$Crest64x64",
            id = player.teamID
        })
        self.im.Publish("bnd_player_rating_" .. playerSlot, player.rating)
        
        local playerAge = GetPlayerAge(player.CARD_ID) or 25
        self.im.Publish("bnd_player_age_" .. playerSlot, playerAge)
        
        self.im.Publish("bnd_player_age_label_" .. playerSlot, "Age")

        if selectedPlayerIndex == playerSlot then
            self.im.Publish("bnd_player_bg_" .. playerSlot, {
                name = "$Selected_Bg",
                id = 1
            })
        else
            self.im.Publish("bnd_player_bg_" .. playerSlot, nil)
        end
    else
        self:clearPlayerSlot(playerSlot)
        self.im.Publish("bnd_player_age_label_" .. playerSlot, nil)
    end
end

function MensHub:shortenPlayerName(name)
    if #name > 8 then
        return string.sub(name, 1, 8) .. "..."
    else
        return name
    end
end

function MensHub:publishPlayerRows()
  for i = 1, playersPerPage do
    self:publishPlayerData(i)
  end
end

function MensHub:getTeamCategory(teamID)
    if BigTeams[teamID] then
        return "big"
    elseif MidTeams[teamID] then
        return "mid"
    elseif SmallTeams[teamID] then
        return "small"
    else
        return "small"
    end
end

function MensHub:generateScoutingPercentage(teamCategory, teamID, playerID)
    local cacheKey = teamID .. "_" .. playerID
    
    if scoutingCache[cacheKey] then
        return scoutingCache[cacheKey]
    end
    
    math.randomseed(os.clock() * 100000 + os.time() + playerID + teamID)
    
    local percentage
    if teamCategory == "big" then
        percentage = math.random(88, 100)
    elseif teamCategory == "mid" then
        percentage = math.random(48, 65)
    else
        percentage = math.random(0, 22)
    end
    
    scoutingCache[cacheKey] = percentage
    
    return percentage
end

function MensHub:shortenPlayerNameForScouting(fullName)
    if not fullName or type(fullName) ~= "string" then
        return fullName or "Unknown"
    end
    
    local lastSpaceIndex = string.find(fullName, "[^ ]*$")
    
    if lastSpaceIndex and lastSpaceIndex > 1 then
        local lastName = string.sub(fullName, lastSpaceIndex)
        return lastName
    else
        return fullName
    end
end

function MensHub:getScoutingMessage(playerName, teamCategory, scoutingPercentage)
    local shortName = self:shortenPlayerNameForScouting(playerName)
    
    if teamCategory == "big" then
        return shortName .. " has been fully scouted. All \n attributes and potential are confirmed."
    elseif teamCategory == "mid" then
        return shortName .. " is listed for loan so we know \n a little bit about him. You can scout further \n for more information."
    else
        return shortName .. " is not being Scouted further"
    end
end

function MensHub:getAdvertasingMsg(playerName, teamCategory, scoutingPercentage)
    if teamCategory == "big" then
        return "Scouted"
    elseif teamCategory == "mid" then
        return "Scouting"
    else
        return "Not Scouted"
    end
end

function MensHub:splitPlayerName(playerName)
    local cleanName = playerName:gsub("^%a%.[ ]*", "")

    local names = {}
    for word in cleanName:gmatch("%S+") do
        table.insert(names, word)
    end

    return {
        fullName = cleanName,                 -- Name Complete
        firstName = names[1] or "",           -- 1st name
        lastName = table.concat(names, " ", 2) -- 2nd name
    }
end

function MensHub:generateRatingRange(currentRating)
    local minRange = math.max(1, currentRating - 3)
    local maxRange = currentRating + 5
    return minRange .. "-" .. maxRange
end

function MensHub:generateRandomStats(currentStats, teamCategory)
    if teamCategory == "big" then
        return currentStats
    elseif teamCategory == "mid" then
        local randomStats = {}
        for i = 1, 6 do
            local stat = currentStats[i] or 70
            local minStat = math.max(1, stat - 6)
            local maxStat = math.min(99, stat + 6)
            randomStats[i] = minStat .. "-" .. maxStat
        end
        return randomStats
    else
        return {nil, nil, nil, nil, nil, nil}
    end
end

function MensHub:publishSelectedPlayerInfo()
  if not selectedPlayerIndex or selectedPlayerIndex > #playerListData then
    self:clearSelectedPlayerInfo()
    return
  end
  
  local playerData = playerListData[selectedPlayerIndex]
  if not playerData then return end
  
  local player = playerData.data
  
  local nameParts = self:splitPlayerName(player.playerName)
  
  local teamCategory = self:getTeamCategory(player.teamID)
  local scoutingPercentage = self:generateScoutingPercentage(teamCategory, player.teamID, player.CARD_ID)
  local scoutingMessage = self:getScoutingMessage(player.playerName, teamCategory, scoutingPercentage)
  local scoutingMs = self:getAdvertasingMsg(player.playerName, teamCategory, scoutingPercentage)
  
  self.im.Publish("bnd_selected_player_head", {
    name = "$Head",
    id = player.CARD_ID
  })
  self.im.Publish("bnd_selected_player_position", player.position)
  self.im.Publish("bnd_selected_player_name", player.playerName)
  self.im.Publish("bnd_selected_player_first_name", nameParts.fullName)
  self.im.Publish("bnd_selected_player_last_name", nameParts.lastName)
  
  if teamCategory == "big" then
    self.im.Publish("bnd_selected_player_rating", player.rating)
    self.im.Publish("bnd_rating_range", (player.rating + 3))
  elseif teamCategory == "mid" then
    self.im.Publish("bnd_selected_player_rating", "?")
    self.im.Publish("bnd_rating_range", self:generateRatingRange(player.rating))
  else
    self.im.Publish("bnd_selected_player_rating", "?")
    self.im.Publish("bnd_rating_range", "?")
  end
  
  local playerAge = GetPlayerAge(player.CARD_ID) or 25
  self.im.Publish("bnd_player_age", playerAge)
  
  self.im.Publish("bnd_selected_player_nationality", {
    name = "$Flag128x128",
    id = player.nationalityID
  })
  self.im.Publish("bnd_selected_player_team", {
    name = "$Crest",
    id = player.teamID
  })
  
  local teamNameBinding = "bnd_team_name_3"
  local localizedTeamName = self.loc.LocalizeString("TeamName_Abbr3_" .. player.teamID)
  self.im.Publish(teamNameBinding, localizedTeamName)
  
  self.im.Publish("bnd_selected_player_scouting_msg", scoutingMessage)
  self.im.Publish("bnd_selected_player_advertasing_msg", scoutingMs)
  self.im.Publish("bnd_scouting_percentage", "" .. scoutingPercentage .. "%")
  
  local statsToShow = self:generateRandomStats(
    {player.stat1 or 0, player.stat2 or 0, player.stat3 or 0, 
     player.stat4 or 0, player.stat5 or 0, player.stat6 or 0},
    teamCategory
  )
  
  for i = 1, 6 do
    self.im.Publish("bnd_selected_player_stat_" .. i, statsToShow[i])
  end
  
  local statLabels = player.position == "GK" and 
    {"Diving", "Handling", "Kicking", "Reflexes", "Speed", "Positioning"} or
    {"Pace", "Shooting", "Passing", "Dribbling", "Defending", "Physical"}
  
  for i = 1, 6 do
    self.im.Publish("bnd_selected_player_stat_label_" .. i, statLabels[i])
  end
end

function MensHub:selectPlayer(playerSlot)
  if playerSlot < 1 or playerSlot > playersPerPage then return end
  
  local playerData = playerListData[playerSlot]
  if not playerData then return end
  
  selectedPlayerIndex = playerSlot
  
  self:publishPlayerRows()
  self:publishSelectedPlayerInfo()
  
  print("Jugador seleccionado: " .. playerData.data.playerName)
end

function MensHub:scrollPlayers(direction)
    local maxPages = math.ceil(#allPlayersData / playersPerPage)
    local newIndex = currentPlayerIndex + direction

    if newIndex >= 1 and newIndex <= maxPages then
        currentPlayerIndex = newIndex
        self:updatePlayerList()
        self:publishPlayerRows()

        self:HideSelections()
        self.im.Publish(BND_TAB1_VISIBLE, true)

        if #playerListData > 0 then
            selectedPlayerIndex = 1
            self:publishPlayerRows()
            self:publishSelectedPlayerInfo()
        else
            selectedPlayerIndex = nil
            self:clearSelectedPlayerInfo()
        end

        print("P��gina actual: " .. currentPlayerIndex .. " de " .. maxPages)
    end
end

function MensHub:addToHub(data)
    if not selectedPlayerIndex or selectedPlayerIndex > #playerListData then
        self:showMessage("PLAYER SELECTION REQUIRED", "Select a player before taking any action.")
        return
    end

    local playerData = playerListData[selectedPlayerIndex]
    if not playerData then return end

    local player = playerData.data

    for i = 1, 10 do
        local existingSlot = _G["SLOTPL" .. i]
        if existingSlot == player.CARD_ID then
            self:showMessage("DUPLICATE PLAYER", player.playerName .. " is already in the Hub.")
            print("[HUB] El jugador " .. player.playerName .. " ya est�� en el hub (slot " .. i .. ").")
            return
        end
    end

    local availableSlot = self:findAvailableHubSlot()

    if availableSlot then
        self:assignPlayerToHubSlot(player, availableSlot)
        self:showMessage("PLAYER ADDED", player.playerName .. " successfully added to Hub.")
        print("[HUB] Jugador " .. player.playerName .. " agregado al slot " .. availableSlot)
    else
        self:showMessage("HUB CAPACITY REACHED", "No more slots available in the Hub.")
        print("[HUB] No hay m��s espacio disponible en el hub.")
    end
end

function MensHub:findAvailableHubSlot()
  if not SLOTPL1 then return 1
  elseif not SLOTPL2 then return 2
  elseif not SLOTPL3 then return 3
  elseif not SLOTPL4 then return 4
  elseif not SLOTPL5 then return 5
  elseif not SLOTPL6 then return 6
  elseif not SLOTPL7 then return 7
  elseif not SLOTPL8 then return 8
  elseif not SLOTPL9 then return 9
  elseif not SLOTPL10 then return 10
  else return nil end
end

function MensHub:assignPlayerToHubSlot(player, slot)
  local slotVar = "SLOTPL" .. slot
  local teamVar = "SLOTTM" .. slot
  
  _G[slotVar] = player.CARD_ID
  _G[teamVar] = player.teamID
  
  print("Jugador " .. player.playerName .. " asignado al slot " .. slot)
end

function MensHub:showMessage(title, message)
  local buttonOk = {
    icon = "$FooterIconYes",
    label = "Advance",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  
  local popupData = {
    title = title,
    message = message,
    buttons = {buttonOk}
  }
  
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function MensHub:clearPlayerSlot(playerSlot)
  self.im.Publish("bnd_player_" .. playerSlot, { name = "$Head", id = nil })
  self.im.Publish("bnd_player_name_" .. playerSlot, nil)
  self.im.Publish("bnd_player_country_" .. playerSlot, nil)
  self.im.Publish("bnd_player_position_" .. playerSlot, nil)
  self.im.Publish("bnd_player_crest_" .. playerSlot, nil)
  self.im.Publish("bnd_player_rating_" .. playerSlot, nil)
  self.im.Publish("bnd_player_age_" .. playerSlot, nil)
  self.im.Publish("bnd_player_bg_" .. playerSlot, nil)
end

function MensHub:clearSelectedPlayerInfo()
  self.im.Publish("bnd_selected_player_head11", nil)
  self.im.Publish("bnd_selected_player_positio11n", nil)
  self.im.Publish("bnd_selected_player_rating11", nil)
  self.im.Publish("bnd_selected_player_nationality1", nil)
  self.im.Publish("bnd_selected_player_team1", nil)
  
  for i = 1, 6 do
    self.im.Publish("bnd_selected_player_stat1_" .. i, nil)
    self.im.Publish("bnd_selected_player_stat_label1_" .. i, nil)
  end
end

function MensHub:HideSelections()
  self.im.Publish(BND_TAB1_VISIBLE, false)
  self.im.Publish(BND_TAB2_VISIBLE, false)
  self.im.Publish(BND_TAB3_VISIBLE, false)
  self.im.Publish(BND_TAB4_VISIBLE, false)
  self.im.Publish(BND_TAB5_VISIBLE, false)
  self.im.Publish(BND_TAB6_VISIBLE, false)
  self.im.Publish(BND_TAB7_VISIBLE, false)
  self.im.Publish(BND_TAB8_VISIBLE, false)
end

function MensHub:finalize()
  self.im.Unsubscribe(BND_TAB1_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_VISIBLE)
  self.im.Unsubscribe(BND_TAB3_VISIBLE)
  self.im.Unsubscribe(BND_TAB4_VISIBLE)
  self.im.Unsubscribe(BND_TAB5_VISIBLE)
  self.im.Unsubscribe(BND_TAB6_VISIBLE)
  self.im.Unsubscribe(BND_TAB7_VISIBLE)
  self.im.Unsubscribe(BND_TAB8_VISIBLE)
  self.im.UnregisterAction(ACT_MVNPROD)
  self.im.Unsubscribe("bnd_player3d")
  
  for i = 1, playersPerPage do
    self.im.Unsubscribe("bnd_player_" .. i)
    self.im.Unsubscribe("bnd_player_name_" .. i)
    self.im.Unsubscribe("bnd_player_country_" .. i)
    self.im.Unsubscribe("bnd_player_position_" .. i)
    self.im.Unsubscribe("bnd_player_crest_" .. i)
    self.im.Unsubscribe("bnd_player_rating_" .. i)
    self.im.UnregisterAction("act_player_" .. i)
  end
  
  self.im.Unsubscribe(BND_PLAYER_LIST)
  self.im.Unsubscribe("bnd_selected_player_info")
  self.im.UnregisterAction(ACT_SCROLL_DOWN)
  self.im.UnregisterAction(ACT_SCROLL_UP)
  self.im.UnregisterAction(ACT_ADVANCE)
  
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end

return MensHub
-- New Custom Menu By MVNPROD --