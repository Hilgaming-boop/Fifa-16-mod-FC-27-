-- Modified By MVNPROD Youtube Channel --
local Timer = ...
local TeamRoster = {}

local BND_TAB1_VISIBLE = "bnd_tab1_visible"
local BND_TAB2_VISIBLE = "bnd_tab2_visible"
local BND_TAB3_VISIBLE = "bnd_tab3_visible"
local BND_TAB4_VISIBLE = "bnd_tab4_visible"
local BND_TAB5_VISIBLE = "bnd_tab5_visible"
local ACT_MVNPROD = "act_mvnprod"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5

local bndPlayerList = "bnd_player_list"
local ACT_PLAYER_SELECT = "act_player_select"
local ACT_HIDE = "act_hide"
local ACT_RELEASE = "act_release"
local ACT_RENEWAL = "act_renewal"
local ACT_BLOCK = "act_block"
local ACT_TOGGLE = "act_toggle"
local BND_PLAYER_AGE = "bnd_player_age"
local bndBackgroundCareer = "bnd_background_career"
local bndTableCareer = "bnd_table_career"
local ACT_SELL = "act_sell"

local PlayerListData = {}
local teamPlayers = {}
local playerData
local statsubs = {"gs", "cs", "yc", "rc"}
local toggle = false
local MAX_VALUE = 200000000
local MIN_VALUE = 500000

local function getPlayerStatus(age, rating, index)
    if index <= 11 then  -- Titulares
        if rating >= 85 then
            return "Crucial"
        elseif rating >= 80 then
            return "Important"
        elseif rating >= 75 then
            return "Sporadic"
        else
            return "Rotation"
        end
    elseif index <= 18 then  -- Suplentes
        if age <= 20 and rating >= 75 then
            return "Prospect"
        else
            return "Rotation"
        end
    elseif index <= 23 then  -- Reservas
        if age <= 20 and rating >= 75 then
            return "Prospect"
        elseif rating >= 75 then
            return "Sporadic"
        else
            return "Rotation"
        end
    else  -- Reservas
        if age <= 20 then
            return "Prospect"
        else
            if age >= 25 and rating <= 76 then
                return "Reserve"
            else
                return "Reserve"
            end
        end
    end
end

local function getPlayerMood(rating, index)
    if index <= 11 then  
        if rating >= 85 then
            return "$Happy"
        elseif rating >= 80 then
            return "$Happy" 
        else
            return "$Happy"
        end
    elseif index <= 18 then 
        if rating >= 80 then
            return "$Neutral"
        else
            return "$Neutral"
        end
    elseif index <= 23 then
        if rating >= 75 then
            return "$Neutral"  
        else
            return "$Sad"  
        end
    else 
        if rating >= 70 then
            return "$Sad"
        else
            return "$Sad"
        end
    end
end

local function calculateTransferValue(age, rating, position)
    local baseValue = 15000000
    local ageFactor = (age >= 16 and age <= 20) and 2.5 or (age > 21 and age <= 23) and 2.0 or 
                     (age > 23 and age <= 28) and 1.6 or (age > 28 and age <= 32) and 1.2 or 0.7
    local ratingFactor = (rating >= 90) and 2.8 or (rating >= 85) and 2.3 or 
                        (rating >= 80) and 1.8 or (rating >= 75) and 1.4 or 1.0
    local positionMultipliers = {
        ["GK"] = 1.0, ["LB"] = 1.2, ["RB"] = 1.2, ["CB"] = 1.5, ["RCB"] = 1.5, ["LCB"] = 1.3,
        ["LWB"] = 1.4, ["RWB"] = 1.4, ["RM"] = 1.4, ["LM"] = 1.4, ["CDM"] = 1.3, ["RDM"] = 1.3,
        ["CM"] = 1.5, ["CAM"] = 1.6, ["RW"] = 2.0, ["LW"] = 2.0, ["ST"] = 2.1, ["CF"] = 2.1, ["RF"] = 1.8, ["LF"] = 1.8
    }
    local positionFactor = positionMultipliers[position] or 1.0
    return math.max(MIN_VALUE, math.min(baseValue * ageFactor * ratingFactor * positionFactor, MAX_VALUE))
end

function computeTransferValue(age, rating, position, index, replacementCount, daysLeft)
    local baseValue = calculateTransferValue(age, rating, position)
    
    local adjustedValue = baseValue
    if index > 11 then
        adjustedValue = adjustedValue * (0.9 - (0.1 * (index - 11)))
    end
    
    if daysLeft <= 7 then
        adjustedValue = adjustedValue * (0.9 + (0.1 * daysLeft / 7))
    end
    
    return math.max(MIN_VALUE, adjustedValue)
end

TeamID = 0

function TeamRoster:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = {
        SquadManagementService = o.api("SquadMgtService"),
        gameSetup = o.api("GameSetupService"),
        EventManagerService = o.api("EventManagerService"),
        BrowserService = o.api("BrowserService"),
        MiscService = o.api("MiscService")
    }
    
    o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
        o:handleEvent(...)
    end)
    o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5 }
    
    o.im.Subscribe(BND_TAB1_VISIBLE, function() end)
    o.im.Subscribe(BND_TAB2_VISIBLE, function() end)
    o.im.Subscribe(BND_TAB3_VISIBLE, function() end)
    o.im.Subscribe(BND_TAB4_VISIBLE, function() end)
    o.im.Subscribe(BND_TAB5_VISIBLE, function() end)
    
    o:HideSelections()
    o.im.Publish(BND_TAB1_VISIBLE, true)
    
    o.im.RegisterAction(ACT_MVNPROD, function(actionName, data)
        o:HideSelections()
        if o.buttonsID[data.buttonID + 1] == TAB1 then
            o.im.Publish(BND_TAB1_VISIBLE, true)
        elseif o.buttonsID[data.buttonID + 1] == TAB2 then
            o.im.Publish(BND_TAB2_VISIBLE, true)
        elseif o.buttonsID[data.buttonID + 1] == TAB3 then
            o.im.Publish(BND_TAB3_VISIBLE, true)
        elseif o.buttonsID[data.buttonID + 1] == TAB4 then
            o.im.Publish(BND_TAB4_VISIBLE, true)
        elseif o.buttonsID[data.buttonID + 1] == TAB5 then
            o.im.Publish(BND_TAB5_VISIBLE, true)
        end
    end)
    
    TeamID = currentSelectedTeamID
    o.visible = true
    o.rowvisible = true
    o.panelvisible = false
    o.statvisible = false
    o.infovisible = true
    o.currentIndex = 0
    o.oldIndex = -1
    
    o.im.Subscribe("bnd_visible", function()
        o:publishVisible()
    end)
    o.im.Subscribe("bnd_loading_visible", function()
        o:publishVisible()
    end)
    o.im.Subscribe("bnd_rowvisible", function()
        o:publishVisible()
    end)
    o.im.Subscribe("bnd_panelvisible", function()
        o:publishVisible()
    end)
    o.im.Subscribe("bnd_panelanim", function()
        o:publishVisible()
    end)
    o.im.Subscribe("bnd_plstat_visible", function()
        o:publishVisible()
    end)
    o.im.Subscribe("bnd_plinfo_visible", function()
        o:publishVisible()
    end)
-- 🔹 O.IM SUBSCRIBE EVENT
o.im.Subscribe("bnd_leaguebackground", function()
  local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_leaguebackground", bg)
end)
o.im.Subscribe("bnd_standings_career", function()
  local st = getLeagueStandingsByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_standings_career", st)
end)
o.im.Subscribe("bnd_tab_color", function()
  local c = getLeagueTabColorByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_tab_color", c)
end)
    o.im.Subscribe("bnd_team_crest", function()
        o.im.Publish("bnd_team_crest", {
            name = "$Crest",
            id = TeamID
        })
    end)
    o.im.Subscribe("bnd_kit_home", function()
        o.im.Publish("bnd_kit_home", {
            name = "$HomeKit",
            id = TeamID
        })
    end)
    o.im.Subscribe(bndBackgroundCareer, function()  
  local currentLeague = o:getCurrentLeague()
    o.im.Publish(bndBackgroundCareer, {name = "$CareerTable", id = currentLeague})
  end)
  
  o.im.Subscribe(bndTableCareer, function()  
  local currentLeague = o:getCurrentLeague()
    o.im.Publish(bndTableCareer, {name = "$BgTable", id = currentLeague})
  end)
    o.im.Subscribe("bnd_team_name", function()
        o.im.Publish("bnd_team_name", o.loc.LocalizeString("TeamName_Abbr15_"..TeamID))
    end)
    o.im.Subscribe("bnd_player_avatar", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_name", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_ID", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_mood", function()
        o:publishPlayerMood()
    end)
    o.im.Subscribe(BND_PLAYER_AGE, function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_status", function()
        o:publishPlayerRole()
    end)
    o.im.Subscribe("bnd_player_position", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_value", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_fitness", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_suspstatus", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_country", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_rating", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_number", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_3d_player", function()
        o:publishPlayerInfo()
    end)

    for i = 1, 6 do
        o.im.Subscribe("bnd_player_stat"..i, function()
            o:publishPlayerInfo()
        end)
    end
        
    for i = 1, 4 do
        o.im.Subscribe("bnd_friendly".. statsubs[i], function()
            o:publishPlayerInfo()
        end)
    end
    for i = 1, 4 do
        o.im.Subscribe("bnd_dom".. statsubs[i], function()
            o:publishPlayerInfo()
        end)
    end
    for i = 1, 4 do
        o.im.Subscribe("bnd_total".. statsubs[i], function()
            o:publishPlayerInfo()
        end)
    end

    o:Init()
    o.im.Subscribe(bndPlayerList, function()
        o:publishPlayerRows()
    end)
    o.im.RegisterAction(ACT_PLAYER_SELECT, function(actionName, data)
        if data then
            o:publishPlayerDetail(data)
        end
    end)
    o.im.RegisterAction(ACT_HIDE, function(actionName, data)
        o:hidePanel()
    end)
    o.im.RegisterAction(ACT_RELEASE, function(actionName, data)
        o:releasePlayer()
    end)
    o.im.RegisterAction(ACT_SELL, function(actionName, data)
        if playerData then
            o:processSale()
        else
            print("Error: No player selected to sell")
        end
    end)
    o.im.RegisterAction(ACT_TOGGLE, function(actionName, data)
        o:toggleView()
    end)
    o.im.RegisterAction(ACT_RENEWAL, function(actionName, data)
        if playerData then
            o:processRenewal()
        else
            print("Error: No player selected for renewal")
        end
    end)
    o.im.RegisterAction(ACT_BLOCK, function(actionName, data)
        if playerData then
            o:showBlockPopup()
        else
            print("Error: No player selected to block")
        end
    end)
    
    return o
end

function TeamRoster:getCurrentLeague()
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

function TeamRoster:HideSelections()
    self.im.Publish(BND_TAB1_VISIBLE, false)
    self.im.Publish(BND_TAB2_VISIBLE, false)
    self.im.Publish(BND_TAB3_VISIBLE, false)
    self.im.Publish(BND_TAB4_VISIBLE, false)
    self.im.Publish(BND_TAB5_VISIBLE, false)
end

function TeamRoster:publishVisible()
    self.im.Publish("bnd_visible", self.visible)
    if self.panelvisible then
        self.im.Publish("bnd_rowvisible", false)
    else
        self.im.Publish("bnd_rowvisible", self.rowvisible)
    end
    self.im.Publish("bnd_panelvisible", self.panelvisible)
    self.im.Publish("bnd_panelanim", 0.0)
    self.im.Publish("bnd_plstat_visible", self.statvisible)
    self.im.Publish("bnd_plinfo_visible", self.infovisible)
    self.im.Publish("bnd_loading_visible", not self.visible)

    if self.panelvisible then
        local animValues = {0.1, 0.3, 0.4, 0.6, 0.7, 0.8, 1.0}

        local function setNextAnim(index)
            if index > #animValues then
                print("[TeamRoster]: Animation sequence completed")
                self.panelAnimTimer = nil
                return
            end

            local value = animValues[index]
            local delay = 0.05

            self.panelAnimTimer = Timer:new({
                id = "panelAnimTimer_" .. index,
                interval = delay,
                reps = 1,
                onTimerComplete = function(id, repsCount)
                    print(string.format("[TeamRoster]: Timer completed, setting bnd_panelanim to %.1f", value))
                    self.im.Publish("bnd_panelanim", value)
                    setNextAnim(index + 1)
                end
            })
            self.panelAnimTimer:start()
            print(string.format("[TeamRoster]: Started %d-second timer to set bnd_panelanim to %.1f", delay, value))
        end

        setNextAnim(1)
    end
end

function TeamRoster:publishPlayerInfo(data)
    local suspStatus = "Match Fit"
    local fitnessStatus = "Ok"
    local plgoals = 0
    local plcleansheets = 0
    local plyellowcard = 0
    local plredcard = 0
    if data then 
        self.im.Publish("bnd_player_avatar", {
            name = "$Head",
            id = data.CARD_ID
        })
        self.im.Publish("bnd_player_name", data.playerName)
        self.im.Publish("bnd_player_ID", data.CARD_ID)
        self.im.Publish("bnd_player_position", data.position)
        self.im.Publish("bnd_player_country", {
            name = "$Flag128x128",
            id = data.nationalityID
        })
        if isSuspended[data.playerName] == 2 then
            fitnessStatus = "Injured. Back (" .. injuryRecoveryDate[data.playerName] .. ")"
        elseif isSuspended[data.playerName] == 1 then
            suspStatus = "Red Carded"
        end
        local playerInfo = getPlayerInfo(data.CARD_ID, currentSelectedTeamID)
        local Index = playerInfo and playerInfo.index
        local repCount = playerReplacementCount(currentSelectedTeamID, data.position)
        local days = daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
        local playervalue, minvalue = computeTransferValue(GetPlayerAge(data.CARD_ID), data.rating, data.position, Index, repCount, days)
        self.im.Publish("bnd_value", "$" .. self.loc.LocalizeInteger(playervalue))
        local playerAge = GetPlayerAge(data.CARD_ID) or 25
        self.im.Publish(BND_PLAYER_AGE, playerAge)
        self.im.Publish("bnd_suspstatus", suspStatus)
        self.im.Publish("bnd_fitness", fitnessStatus)
        self.im.Publish("bnd_player_rating", data.rating)
        self.im.Publish("bnd_player_number", data.jerseyNumber)
        self.im.Publish("bnd_3d_player", {
            name = "$PLAYER_ID",
            id = data.CARD_ID
        })
        for i = 1, 6 do
            self.im.Publish("bnd_player_stat"..i, data["stat"..i])
        end
        plgoals = GOALS[data.CARD_ID] or 0
        plcleansheets = 0
        plyellowcard = yellowCardRecords[data.playerName] or 0
        plredcard = redCardRecords[data.playerName] or 0
        local stats = {plgoals, plcleansheets, plyellowcard, plredcard}
        for i = 1, 4 do
            self.im.Publish("bnd_dom" .. statsubs[i], stats[i])
            self.im.Publish("bnd_friendly" .. statsubs[i], 0)
            self.im.Publish("bnd_total" .. statsubs[i], stats[i])
        end
    end
end

function TeamRoster:Init()
    local teamInfo = self.services.SquadManagementService.GetTeamInfo(TeamID)
    local teamLineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, TeamID, 0)
    do
        do
            for _FORV_16_ = 1, table.getn(teamLineup) do
                local obj = {
                    assetId = teamLineup[_FORV_16_].CARD_ID,
                    clickAction = "act_player_select",
                    playerInfo = teamLineup[_FORV_16_],
                    data = {}
                }
                table.insert(PlayerListData, obj)
            end
        end
    end
end

function TeamRoster:publishPlayerRows()
    for i, v in ipairs(PlayerListData) do
        local playerInfo = v.playerInfo or {}
        local age = GetPlayerAge(v.assetId) or 25
        local rating = playerInfo.rating or 70
        
        v.data = v.data or {}
        v.data.PlayerStatus = getPlayerStatus(age, rating, i)  
        v.data.PlayerMood = getPlayerMood(rating, i)
        
        v.data.PlayerAvatar = {
            name = "$Head",
            id = v.assetId
        }
        v.data.PlayerName = playerInfo.playerName or "Unknown"
        v.data.Rating = rating
        v.data.clickAction = v.clickAction or "act_player_select"
        v.data.Jersey = playerInfo.jerseyNumber or 0
        v.data.FontColor = "0xffffff"
        v.data.Position = playerInfo.position or "ST"
    end
    
    self.im.Publish(bndPlayerList, PlayerListData)
    self.visible = true
    self:publishVisible()
    self:publishPlayerDetail({id = 0})
end

function TeamRoster:publishPlayerDetail(data)
    local playerIndex = data.id + 1
    self.oldIndex = self.currentIndex
    self.currentIndex = playerIndex
    if self.oldIndex == self.currentIndex then
        self.panelvisible = true
        self.im.Publish("bnd_panelvisible", self.panelvisible)
        self.im.Publish("bnd_rowvisible", false)
        self:publishVisible()
    end
    playerData = PlayerListData[playerIndex].playerInfo    
    self:publishPlayerInfo(playerData)
    self:publishPlayerRole()  -- Publica el estado
    self:publishPlayerMood()  -- Publica el ánimo
end

function TeamRoster:hidePanel()
    self.panelvisible = false
    self.im.Publish("bnd_panelvisible", self.panelvisible)
    self.im.Publish("bnd_rowvisible", true)
    self:publishVisible()
    playerData = nil
end

function TeamRoster:toggleView()
    if toggle == false then
        self.im.Publish("bnd_plinfo_visible", true)
        self.im.Publish("bnd_plstat_visible", true)
        toggle = true
    else
        self.im.Publish("bnd_plinfo_visible", true)
        self.im.Publish("bnd_plstat_visible", false)
        toggle = false
    end
end

function TeamRoster:releasePlayer()
    self:showReleasePopup()
    
    Timer:new({
        interval = 0.1,
        reps = 1,
        onTimerComplete = function()
            releasePlayer(playerData.CARD_ID, currentSelectedTeamID)
            PlayerListData = {}
            self:Init()
            self:publishPlayerRows()
            self.panelvisible = false 
            self.im.Publish("bnd_panelvisible", self.panelvisible)
            self.im.Publish("bnd_rowvisible", true)
            self:publishVisible()
        end
    }):start()
end

function TeamRoster:publishPlayerRole()
    if not playerData then 
        self.im.Publish("bnd_player_status", "")
        return 
    end
    
    local age = GetPlayerAge(playerData.CARD_ID) or 25
    local rating = playerData.rating or 70
    local playerInfo = getPlayerInfo(playerData.CARD_ID, currentSelectedTeamID) or {}
    local index = playerInfo.index or 0
    
    local status = getPlayerStatus(age, rating, index)
    self.im.Publish("bnd_player_status", status)
end

function TeamRoster:publishPlayerMood()
    if not playerData then 
        self.im.Publish("bnd_player_mood", "")
        return 
    end
    
    local rating = playerData.rating or 70
    local playerInfo = getPlayerInfo(playerData.CARD_ID, currentSelectedTeamID) or {}
    local index = playerInfo.index or 0
    
    local mood = getPlayerMood(rating, index)
    self.im.Publish("bnd_player_mood", mood)
end

function TeamRoster:update(elapsedTime)
    if self.panelAnimTimer then
        self.panelAnimTimer:update(elapsedTime)
    end
end

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
        "evt_hide_popup"
    }
}

function TeamRoster:showReleasePopup()
    local customButtonYes = {
        icon = "$FooterIconYes",
        label = "Release",
        clickEvents = {
            "evt_hide_popup",
            "evt_release_player"
        }
    }
    
    local popupData = {
        title = "RELEASE PLAYER",
        message = "Are you sure you want to release " .. (playerData and playerData.playerName or "this player") .. "?",
        buttons = {buttonNo, customButtonYes}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamRoster:processSale()
    local playerInfo = getPlayerInfo(playerData.CARD_ID, currentSelectedTeamID)
    local age = GetPlayerAge(playerData.CARD_ID)
    local rating = playerData.rating
    local position = playerData.position
    local index = playerInfo and playerInfo.index or 0
    local repCount = playerReplacementCount(currentSelectedTeamID, position)
    local days = daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
    
    local soldPlayerValue = computeTransferValue(age, rating, position, index, repCount, days)
    local soldPlayerName = playerData.playerName
    
    releasePlayer(playerData.CARD_ID, currentSelectedTeamID)
    PlayerListData = {}
    self:Init()
    playerData = nil
    self.currentIndex = 0
    self.oldIndex = -1
    
    self:publishPlayerRows()
    GLOBAL_FUNDS = (GLOBAL_FUNDS or 0) + soldPlayerValue
    self:hidePanel()
    
    local popupData = {
        title = "PLAYER SOLD",
        message = string.format("%s sold for €%s. \n New budget: €%s",
            soldPlayerName,
            self.loc.LocalizeInteger(soldPlayerValue),
            self.loc.LocalizeInteger(GLOBAL_FUNDS)),
        buttons = {{
            icon = "$FooterIconYes",
            label = "Done",
            clickEvents = {"evt_hide_popup"}
        }}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamRoster:showSaleConfirmation()
    local playerValue = computeTransferValue(
        GetPlayerAge(playerData.CARD_ID),
        playerData.rating,
        playerData.position,
        getPlayerInfo(playerData.CARD_ID, currentSelectedTeamID).index,
        playerReplacementCount(currentSelectedTeamID, playerData.position),
        daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
    )

    local customButtonYes = {
        icon = "$FooterIconYes",
        label = "Sell",
        clickEvents = {
            "evt_hide_popup",
            "act_sell"
        }
    }

    local popupData = {
        title = "CONFIRM SALE",
        message = string.format("Sell %s for €%s?\nCurrent budget: €%s",
            playerData.playerName,
            self.loc.LocalizeInteger(playerValue),
            self.loc.LocalizeInteger(GLOBAL_FUNDS)),
        buttons = {buttonNo, customButtonYes}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamRoster:processRenewal()
    local playerValue = computeTransferValue(
        GetPlayerAge(playerData.CARD_ID), 
        playerData.rating, 
        playerData.position,
        getPlayerInfo(playerData.CARD_ID, currentSelectedTeamID).index,
        playerReplacementCount(currentSelectedTeamID, playerData.position),
        daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
    )
    playerValue = math.max(500000, playerValue)
    local renewalValue = math.floor(playerValue * 0.009)

    if GLOBAL_FUNDS >= renewalValue then
        GLOBAL_FUNDS = GLOBAL_FUNDS - renewalValue
        print(string.format("[TeamRoster]: Renewal processed. €%s deducted from GLOBAL_FUNDS.", self.loc.LocalizeInteger(renewalValue)))

        local buttonYes = {
            icon = "$FooterIconYes",
            label = "Done",
            clickEvents = {"evt_hide_popup"}
        }
        local popupData = {
            title = "RENEWAL SUCCESSFUL",
            message = string.format("Contract Renewed \n A new deal has been signed with %s. \n €%s has been deducted from your transfer budget.", 
                playerData.playerName, 
                self.loc.LocalizeInteger(renewalValue)),
            buttons = {buttonYes}
        }
        self.nav.Event(nil, "evt_show_popup", popupData)
    else
        local buttonYes = {
            icon = "$FooterIconNo",
            label = "Close",
            clickEvents = {"evt_hide_popup"}
        }
        local popupData = {
            title = "RENEWAL FAILED",
            message = string.format("Contract Renewal Failed \n Not enough funds to renew %s's contract. \n Required: €%s | Available: €%s", 
                playerData.playerName, 
                self.loc.LocalizeInteger(renewalValue),
                self.loc.LocalizeInteger(GLOBAL_FUNDS)),
            buttons = {buttonYes}
        }
        self.nav.Event(nil, "evt_show_popup", popupData)
    end
end

function TeamRoster:showRenewalPopup()
    local customButtonYes = {
        icon = "$FooterIconYes",
        label = "Renew",
        clickEvents = {
            "evt_hide_popup",
            "act_renewal"
        }
    }
    
    local playerValue = computeTransferValue(
        GetPlayerAge(playerData.CARD_ID), 
        playerData.rating, 
        playerData.position,
        getPlayerInfo(playerData.CARD_ID, currentSelectedTeamID).index,
        playerReplacementCount(currentSelectedTeamID, playerData.position),
        daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
    )
    local renewalValue = math.floor(playerValue * 0.009)
    
    local popupData = {
        title = "CONTRACT RENEWAL",
        message = string.format("Renew %s's contract for €%s?\nCurrent budget: €%s", 
            playerData.playerName, 
            self.loc.LocalizeInteger(renewalValue),
            self.loc.LocalizeInteger(GLOBAL_FUNDS)),
        buttons = {buttonNo, customButtonYes}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamRoster:showBlockPopup()
    local customButtonYes = {
        icon = "$FooterIconYes",
        label = "Block",
        clickEvents = {
            "evt_hide_popup",
            "evt_block_transfer"
        }
    }
    
    local popupData = {
        title = "BLOCK TRANSFER",
        message = string.format("Block transfer offers for %s?\nThis will reject all incoming offers automatically.", 
            playerData.playerName),
        buttons = {buttonNo, customButtonYes}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamRoster:finalize()
    self.im.Unsubscribe(BND_TAB1_VISIBLE)
    self.im.Unsubscribe(BND_TAB2_VISIBLE)
    self.im.Unsubscribe(BND_TAB3_VISIBLE)
    self.im.Unsubscribe(BND_TAB4_VISIBLE)
    self.im.Unsubscribe(BND_TAB5_VISIBLE)
    self.im.UnregisterAction(ACT_MVNPROD)
    
    if self.panelAnimTimer then
        self.panelAnimTimer:finalize()
        self.panelAnimTimer = nil
        print("[TeamRoster]: Panel anim timer finalized")
    end
    self.im.Unsubscribe("bnd_visible")
    self.im.Unsubscribe("bnd_loading_visible")
    self.im.Unsubscribe("bnd_team_crest")
    self.im.Unsubscribe("bnd_team_name")
    self.im.Unsubscribe("bnd_player_name")
    self.im.Unsubscribe("bnd_player_avatar")
    self.im.Unsubscribe("bnd_player_ID")
    self.im.Unsubscribe("bnd_player_status")
    self.im.Unsubscribe("bnd_player_mood")
    self.im.Unsubscribe("bnd_player_position")
    self.im.Unsubscribe("bnd_player_country")
    self.im.Unsubscribe("bnd_player_rating")
    self.im.Unsubscribe("bnd_player_number")
    self.im.Unsubscribe("bnd_3d_player")
    for i = 1, 6 do
        self.im.Unsubscribe("bnd_player_stat"..i)
    end
    self.im.Unsubscribe(bndPlayerList)
    self.im.UnregisterAction(ACT_PLAYER_SELECT)
    self.im.Unsubscribe(BND_PLAYER_AGE)
    self.im.UnregisterAction(ACT_RENEWAL)
    self.im.UnregisterAction(ACT_BLOCK)
    self.im.UnregisterAction(ACT_SELL)
    self.im.UnregisterAction(ACT_HIDE)
    self.im.UnregisterAction(ACT_RELEASE)
    self.im.UnregisterAction(ACT_TOGGLE)
end

return TeamRoster