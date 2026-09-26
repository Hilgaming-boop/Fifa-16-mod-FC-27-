-- MOD By MounTsa
local ItemModel, TableUtil, FormationModel = ...
local MAX_STARTING = 11
local TeamManagementModel = {}
local BND_CHEMISTRY_MATRIX = "bnd_chemistry_matrix"
local BND_STARTING_11 = "bnd_starting_11"
local BND_SUBS_AND_RES = "bnd_subs_and_res"
local BND_SBS_AND_RES = "bnd_sbs_and_res"
local BND_RESERVES_ONLY = "bnd_reserves_only"
local BND_TEAM_NAME = "bnd_team_name"
local BND_TEAM_CREST = "bnd_team_crest"
local BND_TEAM_MAN = "bnd_team_man"
local BND_TEAM_RATING = "bnd_team_rating"
local BND_TEAM_RATING_LABEL = "bnd_team_rating_label"
local BND_TEAM_OVERALL = "bnd_team_overall"
local BND_PLAYER_COMPARISON_DATA = "bnd_player_comparison_data"
local ACT_ITEM_SHOW_BIO = "act_item_show_bio"
local ACT_SWAP_PLAYERS = "act_swap_players"
local ACT_COMPARE_PLAYERS = "act_compare_players"
local BND_ITEM_COLLECTION_CONTEXT_MENU_VISIBLE = "bnd_context_menu_visible"
local ACT_SWAP_WITH_INVENTORY = "act_swap_with_inventory"
local ACT_ITEM_SWAP_WITH_CLUB = "act_item_swap_with_club"
local ACT_ITEM_REMOVE_FROM_SQUAD = "act_item_remove_from_squad"
local ACT_ITEM_SEND_TO_TRADE_PILE = "act_item_send_to_trade_pile"
local ACT_ITEM_APPLY_CONSUMABLE = "act_item_apply_consumable"
local ACT_ITEM_QUICK_SELL = "act_item_quick_sell"
local ACT_ITEM_QUICK_LIST = "act_item_quick_list"
local ACT_SEND_ITEM_DATA = "act_send_item_data"
local ELIGIBLE_SQUAD_BINDING = "bnd_eligible_squad"
local BND_PLAYER_RATING = "bnd_player_rating"
local BND_PLAYER_AVATAR = "bnd_player_avatar"
local BND_ACTIVE_PLAYER_VISIBLE = "bnd_active_player_visible"
local BND_PASSIVE_PLAYER_VISIBLE = "bnd_passive_player_visible"
local attributeNames = { "POS", "PAC", "SHO", "PAS", "DRI", "DEF", "PHY" }
local NOTICE = "bnd_swap_notification"
local bndBackgroundCareer = "bnd_background_career"
local bndTableCareer = "bnd_table_career"
local BND_SWAP_LABEL1 = "bnd_swap_label1"
local BND_SWAP_LABEL2 = "bnd_swap_label2"
local BND_SWAP_LABEL3 = "bnd_swap_label3"
local BND_SWAP_LABEL4 = "bnd_swap_label4"
local BND_SWAP_LABEL5 = "bnd_swap_label5"
local BND_SWAP_LABEL6 = "bnd_swap_label6"
local BND_SWAP_LABEL8 = "bnd_swap_label8"
local BND_ACTIVE_STAT_PREFIX = "bnd_active_stat_"
local BND_PASSIVE_STAT_PREFIX = "bnd_passive_stat_"
-- Warna dalam format HEX
local BND_ACTIVE_STAT_COLOR_PREFIX = "bnd_active_stat_color_"
local BND_PASSIVE_STAT_COLOR_PREFIX = "bnd_passive_stat_color_"
local COLOR_RED = 0xFF0000     -- Merah untuk stat 50-70
local COLOR_ORANGE = 0x00FF00  -- Orange untuk stat 70-81
local COLOR_GREEN = 0x00FF00   -- Hijau untuk stat >81
local COLOR_DEFAULT = 0xFFFFFF -- Putih untuk nilai default

function TeamManagementModel:new(init)
    print("[TeamManagementModel]: new()")
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = {
        FUTSquadManagementService = o.api("FUTSquadManagementService"),
        SquadManagementService = o.api("SquadMgtService"),
        TacticsService = o.api("TacticsService"),
        GameSetupService = o.api("GameSetupService")
    }   
    o.teamID = currentSelectedTeamID
    o.models = {
        ItemModel = ItemModel:new({
            im = o.im,
            api = o.api,
            nav = o.nav,
            loc = o.loc
        }),
        FormationModel = FormationModel:new({
            im = o.im,
            api = o.api,
            nav = o.nav,
            loc = o.loc,
            teamID = o.teamID,
            gamemode = o.gamemode
        })
    }
    o.formationList = o.models.FormationModel:getFormationList()
    o.teamInfo = o.services.SquadManagementService.GetTeamInfo(o.teamID)
    o.players = o:getPlayers(o.teamID)
    o.chemistryMatrix = nil
    o.playerComparisonData = o:getPlayerComparisonData(nil, nil)
    o.eligibleSquad = 0 -- Initialize eligibleSquad
    o:checkSquadEligibility() -- Initial check

    if TMODE == 1 then
        local players = o.services.SquadManagementService.GetCurrentPlayerLineup(0, currentSelectedTeamID, 0)
        local found = false
        for _, player in ipairs(players) do
            if player.CARD_ID == GLOBAL_PLAYERIN then
                found = true
                break
            end
        end
        if found then
            SUCCESS = 1
        else
            SUCCESS = 2
        end
    end

    o.im.Subscribe(BND_CHEMISTRY_MATRIX, function()
        o:_publishChemistryMatrix()
        o:checkSquadEligibility()
    end)

    o.im.Subscribe(BND_STARTING_11, function()
        o:_publishStarting11()
        o:checkSquadEligibility()
    end)

    o.im.Subscribe(BND_SUBS_AND_RES, function()
        o:_publishSubsAndRes()
        o:checkSquadEligibility()
    end)
    
    o.im.Subscribe(BND_RES, function()
        o:_publishRes()
        o:checkSquadEligibility()
    end)
    
    o.im.Subscribe(BND_SBS_AND_RES, function()
    o:_publishSbsAndRes()
    o:checkSquadEligibility()
  end)

    o.im.Subscribe(BND_TEAM_NAME, function()
        o:_publishTeamStats(BND_TEAM_NAME)
    end)

    o.im.Subscribe(BND_TEAM_CREST, function()
        o:_publishTeamStats(BND_TEAM_CREST)
    end)

    o.im.Subscribe(BND_TEAM_MAN, function()
        o:_publishTeamStats(BND_TEAM_MAN)
    end)

    o.im.Subscribe(BND_TEAM_RATING, function()
        o:_publishTeamStats(BND_TEAM_RATING)
    end)

    o.im.Subscribe(BND_TEAM_RATING_LABEL, function()
        o:_publishTeamRatingLabel()
    end)

    o.im.Subscribe(BND_TEAM_OVERALL, function()
        o:_publishTeamStats(BND_TEAM_OVERALL)
    end)

    o.im.Subscribe(BND_ITEM_COLLECTION_CONTEXT_MENU_VISIBLE, function() end)

    o.im.Subscribe(BND_PLAYER_COMPARISON_DATA, function()
        o:_publishPlayerComparisonData()
    end)

    o.im.Subscribe(ELIGIBLE_SQUAD_BINDING, function()
        o:_publishEligibleSquad()
    end)
  o.im.Subscribe("bnd_active_player_rating", function() end)
  o.im.Subscribe("bnd_passive_player_rating", function() end)
  o.im.Subscribe("bnd_active_player_avatar", function() end)
  o.im.Subscribe("bnd_passive_player_avatar", function() end)
  o.im.Subscribe("bnd_swap1_active", function() end)
  o.im.Subscribe("bnd_table", function() end)
  o.im.Subscribe("bnd_swap2_active", function() end)
  o.im.Subscribe("bnd_swap3_active", function() end)
  o.im.Subscribe("bnd_swap1_passive", function() end)
  o.im.Subscribe("bnd_swap2_passive", function() end)
  o.im.Subscribe("bnd_swap3_passive", function() end)
  o.im.Subscribe("bnd_active_player_name", function() end)
  o.im.Subscribe("bnd_passive_player_name", function() end)
  o.im.Subscribe("bnd_active_player_position", function() end)
  o.im.Subscribe("bnd_passive_player_position", function() end)
  o.im.Subscribe("bnd_swap_notification", function() end)
  o.im.Subscribe("bnd_swap_label1", function() end)
  o.im.Subscribe("bnd_swap_label2", function() end)
  o.im.Subscribe("bnd_swap_label3", function() end)
  o.im.Subscribe("bnd_swap_label4", function() end)
  o.im.Subscribe("bnd_swap_label5", function() end)
  o.im.Subscribe("bnd_swap_label6", function() end)
  o.im.Subscribe("bnd_swap_label7", function() end)
  o.im.Subscribe("bnd_swap_label8", function() end)
  o.im.Subscribe(BND_ACTIVE_PLAYER_VISIBLE, function() end)
  o.im.Subscribe(BND_PASSIVE_PLAYER_VISIBLE, function() end)

    o.im.RegisterAction(ACT_ITEM_SHOW_BIO, function(actionName, uniqueID)
        o:showBio(uniqueID.groupID)
    end)
    
    o.im.Subscribe(bndBackgroundCareer, function()  
    local currentLeague = o:getCurrentLeague()
    o.im.Publish(bndBackgroundCareer, {name = "$BackgroundCareer", id = IDLeague})   
end)

o.im.Subscribe(bndTableCareer, function()
  local currentLeague = o:getCurrentLeague()
    o.im.Publish(bndTableCareer, {name = "$TableCareer", id = IDLeague})
  end)
  
  o.im.Subscribe("bnd_bg_pitch", function()
  local currentLeague = o:getCurrentLeague()
    o.im.Publish("bnd_bg_pitch", {name = "$PitchBg", id = IDLeague})
  end)

    o.im.RegisterAction(ACT_SWAP_PLAYERS, function(actionName, data)
        o:swapPlayersByIndex(data.activeIndex, data.passiveIndex)
        o:checkSquadEligibility()
    end)

    o.im.RegisterAction(ACT_COMPARE_PLAYERS, function(actionName, data)
        o:comparePlayers(data.activePlayer, data.passivePlayer)
    end)

    o.im.RegisterAction(ACT_SEND_ITEM_DATA, function(actionName, data)
        o:_compareData(data)
    end)
    for i = 1, 6 do
        o.im.Subscribe(BND_ACTIVE_STAT_COLOR_PREFIX..i, function() end)
        o.im.Subscribe(BND_PASSIVE_STAT_COLOR_PREFIX..i, function() end)
    end
    for i = 1, 6 do
        o.im.Subscribe(BND_ACTIVE_STAT_PREFIX..i, function() end)
        o.im.Subscribe(BND_PASSIVE_STAT_PREFIX..i, function() end)
    end
    o:clearHelp()

    return o
end

function TeamManagementModel:clearHelp()
  if newSession == "yes" then
    newSession = "no"
  end
end

function TeamManagementModel:_compareData(itemData)
    local UUID_UPPER_INDEX = 1
    local UUID_LOWER_INDEX = 2
    local CARD_TYPE_INDEX = 3
    local CARD_ID_INDEX = 4
    local POSITION_ID = 5
    local itemIds = {}
    local currentItemIndex = -1
    if self.players ~= nil then
        for i, playersList in ipairs(self.players) do
            table.insert(itemIds, {
                UUID_LOWER = playersList.UUID_LOWER,
                UUID_UPPER = playersList.UUID_UPPER,
                CARD_TYPE = playersList.CARD_TYPE,
                CARD_ID = playersList.CARD_ID,
                POS_IN_SQUAD = playersList.id
            })
        end
    end
    if self.manager ~= nil then
        table.insert(itemIds, {
            UUID_LOWER = self.manager.UUID_LOWER,
            UUID_UPPER = self.manager.UUID_UPPER,
            CARD_TYPE = self.manager.CARD_TYPE,
            CARD_ID = self.manager.CARD_ID,
            POS_IN_SQUAD = MANAGER_POSITION_INDEX
        })
    end
    currentItemIndex = itemData[POSITION_ID] - 1
    quickSellItemFunc = {
        quickSellItem = function(positionIndex)
            self:quickSellItem(positionIndex)
        end
    }
    swapWithClubFunc = {
        swapWithClub = function(positionIndex)
            self:swapWithClub(positionIndex)
        end
    }
    hideItemContextCallbackFunc = {
        hideItemContextCallback = function()
            self.im.Publish(BND_ITEM_COLLECTION_CONTEXT_MENU_VISIBLE, false)
        end
    }
    self.im.Publish(BND_ITEM_COLLECTION_CONTEXT_MENU_VISIBLE, true)
    self.nav.Event(nil, "evt_show_item_context", {
        itemIdList = itemIds,
        itemIndex = currentItemIndex,
        isSquad = true,
        squadId = self.squad.id,
        quickSellItemFunc = quickSellItemFunc,
        swapWithClubFunc = swapWithClubFunc,
        hideItemContextCallbackFunc = hideItemContextCallbackFunc
    })
end
function TeamManagementModel:_getStatColor(statValue)
    statValue = statValue or 0
    print(string.format("Getting color for stat value: %d", statValue))
    
    if statValue < 50 then
        return COLOR_DEFAULT
    elseif statValue >= 50 and statValue < 70 then
        return COLOR_RED
    elseif statValue >= 70 and statValue < 81 then
        return COLOR_ORANGE
    else
        return COLOR_GREEN
    end
end
function TeamManagementModel:getPlayers(teamID)
    print("[TeamManagementModel]: getPlayers()")
    local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)

    for index, player in ipairs(players) do
        player.type = ItemModel.TYPE_FIELD_PLAYER
        player.level = self.models.ItemModel:getItemLevelByRating(player.rating)
        if isSuspended[player.CARD_ID] == 2 then
            player.position = "INJURED."
            player.level = self.models.ItemModel:getItemLevelByRating(player.rating)
        elseif isSuspended[player.CARD_ID] == 1 then
            player.position = "RED CARD."
            player.level = self.models.ItemModel:getItemLevelByRating(player.rating)
        end
    end

    self.players = players
    self:checkSquadEligibility()
    return players
end

function TeamManagementModel:getCurrentLeague()
    if not currentSelectedTeamID then
        return 0 -- Premier League por defecto
    end
    
    -- Intentar obtener la liga del equipo actual
    local teamService = self.api("TeamService")
    if teamService and teamService.GetTeamLeague then
        local leagueID = teamService.GetTeamLeague(currentSelectedTeamID)
        if leagueID and leagueID > 0 then
            return leagueID
        end
    end
    
    -- Fallback: determinar liga basado en el ID del equipo
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
    
    return leagueMap[currentSelectedTeamID] or 0 -- Premier League por defecto
end

function TeamManagementModel:checkSquadEligibility()
    print("[TeamManagementModel]: checkSquadEligibility()")
    
    if not self.players or #self.players == 0 then
        print("[TeamManagementModel]: No players available for eligibility check")
        self.eligibleSquad = 0
        SquadElig = self.eligibleSquad
        self:_publishEligibleSquad()
        return
    end

    local hasSuspendedPlayer = false
    for i = 1, math.min(18, #self.players) do
        local player = self.players[i]
        if player and player.playerName then
            if isSuspended[player.playerName] == 1 then
                print("[TeamManagementModel]: Found suspended player " .. player.playerName .. " at index " .. i)
                hasSuspendedPlayer = true
                break
            end
        else
            print("[TeamManagementModel]: Warning: Invalid player data at index " .. i)
        end
    end

    self.eligibleSquad = hasSuspendedPlayer and 1 or 0
    SquadElig = self.eligibleSquad
    print("[TeamManagementModel]: Squad eligibility status: " .. self.eligibleSquad)
    self:_publishEligibleSquad()
end

function TeamManagementModel:_publishEligibleSquad()
    print("[TeamManagementModel]: _publishEligibleSquad() - Status: " .. self.eligibleSquad)
    self.im.Publish(ELIGIBLE_SQUAD_BINDING, {
        eligibleSquad = self.eligibleSquad,
        teamID = self.teamID,
        timestamp = os.time()
    })
end

function TeamManagementModel:comparePlayers(activePlayer, passivePlayer)
    self:clearPlayerVisibility()
    if activePlayer or passivePlayer then
        if activePlayer then
            self.im.Publish("bnd_active_player_name", activePlayer.playerName)
            self.im.Publish("bnd_active_player_position", activePlayer.position)
            self.im.Publish("bnd_active_player_rating", activePlayer.rating)
            self.im.Publish("bnd_active_player_avatar", {
                name = "$Head",
                id = activePlayer.CARD_ID or 0
            })
            self:_publishPlayerStats(activePlayer, BND_ACTIVE_STAT_PREFIX)
            self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, true)
        end
        if passivePlayer then
            self.im.Publish("bnd_passive_player_name", passivePlayer.playerName)
            self.im.Publish("bnd_passive_player_position", passivePlayer.position)
            self.im.Publish("bnd_passive_player_rating", passivePlayer.rating)
            self.im.Publish("bnd_passive_player_avatar", {
                name = "$Head",
                id = passivePlayer.CARD_ID or 0
            })
            self:_publishPlayerStats(passivePlayer, BND_PASSIVE_STAT_PREFIX)
            self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, true)
        end
    end
    self.playerComparisonData = self:getPlayerComparisonData(activePlayer, passivePlayer)
    self:_publishPlayerComparisonData()
end

function TeamManagementModel:clearPlayerVisibility()
    -- Limpiar active player
    self.im.Publish("bnd_active_player_name", "")
    self.im.Publish("bnd_active_player_position", "")
    self.im.Publish("bnd_active_player_rating", "")
    self.im.Publish("bnd_active_player_avatar", {
        name = "$Head",
        id = 0
    })
    
    -- Para passive player, mostrar "-" pero mantener invisible
    self.im.Publish("bnd_passive_player_name", "-")
    self.im.Publish("bnd_passive_player_position", "-")
    self.im.Publish("bnd_passive_player_rating", "-")
    self.im.Publish("bnd_passive_player_avatar", {
        name = "$Head",
        id = 0
    })
    
    -- Limpiar todos los stats
    for i = 1, 6 do
        self.im.Publish(BND_ACTIVE_STAT_PREFIX..i, 0)
        self.im.Publish(BND_PASSIVE_STAT_PREFIX..i, 0)
        self.im.Publish(BND_ACTIVE_STAT_COLOR_PREFIX..i, COLOR_DEFAULT)
        self.im.Publish(BND_PASSIVE_STAT_COLOR_PREFIX..i, COLOR_DEFAULT)
    end
    
    -- Ocultar ambos contenedores
    self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, false)
    self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, false)
    
    self:publishSwapAssets()
end

function TeamManagementModel:_publishPlayerStats(player, prefix)
    if not player then 
        for i = 1, 6 do
            self.im.Publish(prefix..i, 0)
            self.im.Publish(prefix.."color_"..i, COLOR_DEFAULT)
        end
        return 
    end
    for i = 1, 6 do
        local statValue = player["stat"..i] or 0
        local color = self:_getStatColor(statValue)
        print(string.format("Publishing %s stat %d: %d (color: %x)", 
              prefix, i, statValue, color))
        
        self.im.Publish(prefix..i, statValue)
        self.im.Publish(prefix.."color_"..i, color)
    end
end
function TeamManagementModel:publishSwapAssets()
  self.im.Publish("bnd_swap1_active", {
    name = "$Swap1",
    id = 0
  })
  self.im.Publish("bnd_table", {
    name = "$TableCareer",
    id = IDLeague
  })
  self.im.Publish("bnd_swap2_passive", {
    name = "$Swap2",
    id = 0
  })
  self.im.Publish("bnd_swap3_active", {
    name = "$Swap3",
    id = 0
  })
    self.im.Publish("bnd_swap_label1", "OVR")
    self.im.Publish("bnd_swap_label2", "PAC")
    self.im.Publish("bnd_swap_label3", "SHO")
    self.im.Publish("bnd_swap_label4", "PAS")
    self.im.Publish("bnd_swap_label5", "DRI")
    self.im.Publish("bnd_swap_label6", "DEF")
    self.im.Publish("bnd_swap_label7", "PHY")
    self.im.Publish("bnd_swap_label_8","POS")
    self.im.Publish("bnd_swap_notification", "Player Info Comparason")
end

function TeamManagementModel:swapPlayersByIndex(activeIndex, passiveIndex)
    print("[TeamManagementModel]: swapPlayersByIndex{" .. activeIndex .. ", " .. passiveIndex .. "}")
    if not self.players[activeIndex + 1] or not self.players[passiveIndex + 1] then
        print("Invalid swap indices")
        return
    end
    local passivePlayer = self.players[passiveIndex + 1]
    local activePlayer = self.players[activeIndex + 1]
    
    self.players[passiveIndex + 1] = activePlayer
    self.players[activeIndex + 1] = passivePlayer

    self:clearPlayerVisibility()
  self:checkSquadEligibility()
end
function TeamManagementModel:_updateAfterSwap(activeIndex, passiveIndex)
    self:clearPlayerVisibility()
    local newActivePlayer = self.players[activeIndex + 1]
    local newPassivePlayer = self.players[passiveIndex + 1]
    
    if newActivePlayer then
        self.im.Publish("bnd_active_player_name", newActivePlayer.playerName)
        self.im.Publish("bnd_active_player_position", newActivePlayer.position)
        self.im.Publish("bnd_active_player_rating", newActivePlayer.rating)
        self.im.Publish("bnd_active_player_avatar", {
            name = "$Head",
            id = newActivePlayer.CARD_ID or 0
        })
        for i = 1, 6 do
            self.im.Publish(BND_ACTIVE_STAT_PREFIX..i, newActivePlayer["stat"..i] or 0)
        end
        self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, true)
    end
    
    -- Solo mostrar passive player si existe
    if newPassivePlayer then
        self.im.Publish("bnd_passive_player_name", newPassivePlayer.playerName)
        self.im.Publish("bnd_passive_player_position", newPassivePlayer.position)
        self.im.Publish("bnd_passive_player_rating", newPassivePlayer.rating)
        self.im.Publish("bnd_passive_player_avatar", {
            name = "$Head",
            id = newPassivePlayer.CARD_ID or 0
        })
        for i = 1, 6 do
            self.im.Publish(BND_PASSIVE_STAT_PREFIX..i, newPassivePlayer["stat"..i] or "-")
        end
        self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, true)
    end
end
function TeamManagementModel:showPlayerComparison(show)
    if show then
        local activePlayer = self.currentActivePlayer
        local passivePlayer = self.currentPassivePlayer
        self:comparePlayers(activePlayer, passivePlayer)
    else
        self:clearPlayerVisibility()
    end
end

function TeamManagementModel:getPlayerComparisonData(activePlayer, passivePlayer)
  print("[TeamManagementModel: getPlayerComparisonData(activePlayer = " .. tostring(activePlayer) .. ", passivePlayer = " .. tostring(passivePlayer) .. "): Listing comparison data...")
  local comparisonData = {}
  if activePlayer == nil and passivePlayer == nil then
    comparisonData.attributes = -1
    comparisonData.activeStats = -1
    comparisonData.passiveStats = -1
  else
    assert(activePlayer, "Active player must not be nil to initiate a player comparison.")
    comparisonData.attributes = {}
    comparisonData.activeStats = {}
    comparisonData.passiveStats = {}

    local customLabels = {
      " ", 
      " ", 
      " ", 
      " ", 
      " ", 
      " "
    }
    
    for i = 1, 6 do

      comparisonData.attributes[i] = customLabels[i] -- Ganti activePlayer["label" .. i] dengan customLabels[i]
      comparisonData.activeStats[i] = activePlayer["stat" .. i]
      comparisonData.passiveStats[i] = passivePlayer["stat" .. i]
    end
  end
  TableUtil.print(comparisonData)
  return comparisonData
end

function TeamManagementModel:saveSquad()
    print("[TeamManagementModel]: saveSquad()")
    local playerIDs = {}
    for _FORV_5_ = 1, #self.players do
        playerIDs[_FORV_5_] = self.players[_FORV_5_].CARD_ID
    end
    sheets[SHEETID].players = playerIDs
    sheets[SHEETID].formationid = self.models.FormationModel:getCurrentFormationID()
    sheets[SHEETID].status = "filled"
    self.services.TacticsService.SetFormation(0, self.teamID, self.models.FormationModel:getCurrentFormationID())
    self:checkSquadEligibility()
end

function TeamManagementModel:_publishStarting11()
  if self.players == nil then return end

  local starting11 = {}
  for i = 1, MAX_STARTING do
    local p = self.players[i]
    if p then
      local copy = TableUtil.shallowcopy(p)
      
      -- ELIMINAR crest y country para que no aparezcan en la UI
      copy.country = nil
copy.nation = nil
copy.teamnation = nil
copy.clubnation = nil
copy.nationality = nil
copy.teamnationality = nil
copy.clubnationality = nil
copy.state = nil
copy.teamstate = nil
copy.clubstate = nil
copy.region = nil
copy.teamregion = nil
copy.clubregion = nil
copy.territory = nil
copy.teamterritory = nil
copy.clubterritory = nil
copy.land = nil
copy.teamland = nil
copy.clubland = nil
copy.homeland = nil
copy.teamhomeland = nil
copy.clubhomeland = nil
copy.origin = nil
copy.teamorigin = nil
copy.cluborigin = nil
copy.crest = nil
copy.teamcrest = nil
copy.clubcrest = nil
copy.badge = nil
copy.teambadge = nil
copy.clubbadge = nil
copy.logo = nil
copy.teamlogo = nil
copy.clublogo = nil
copy.emblem = nil
copy.teamemblem = nil
copy.clubemblem = nil
copy.shield = nil
copy.teamshield = nil
copy.clubshield = nil
copy.symbol = nil
copy.teamsymbol = nil
copy.clubsymbol = nil
copy.icon = nil
copy.teamicon = nil
copy.clubicon = nil
copy.mark = nil
copy.teammark = nil
copy.clubmark = nil
      
      -- Si quieres forzar un valor específico para el rating (media)
      -- Cambia 600 por el valor que desees
      
      starting11[i] = copy
    end
  end

  self.im.Publish(BND_STARTING_11, { data = starting11 })
end

function TeamManagementModel:_publishSubsAndRes()
    if self.players == nil then return end
    print("[TeamManagementModel]: _publishSubsAndRes()")
    local nSubs
    if self.teamID == currentSelectedTeamID then
        if GLOBAL_DATE_PLACEHOLDER == "16/08/24" then
            nSubs = self.services.SquadManagementService.GetNumberOfSubs()
        else
            nSubs = self.services.SquadManagementService.GetNumberOfSubs()
        end
    elseif self.teamID == 9 then
        nSubs = self.services.SquadManagementService.GetNumberOfSubs()
    else
        nSubs = self.services.SquadManagementService.GetNumberOfSubs()
    end
    local nRes = self.services.SquadManagementService.GetNumberOfReserves(self.teamID)
    local subs = {}
    local res = {}
    local subsAndRes = {}
    for i = 1, nSubs do
        subs[i] = self.players[i + MAX_STARTING]
    end
    table.insert(subsAndRes, {label = (""), data = subs})
    if nRes > 0 then
        for i = 1, nRes do
            res[i] = self.players[i + MAX_STARTING + nSubs]
        end
        table.insert(subsAndRes, {label = (""), data = res})
    end
    self.im.Publish(BND_SUBS_AND_RES, subsAndRes)
    self:checkSquadEligibility()
end

function TeamManagementModel:_publishSbsAndRes()
    if self.players == nil then return end
    print("[TeamManagementModel]: _publishSbsAndRes()")
    local nSubs
    if self.teamID == currentSelectedTeamID then
        if GLOBAL_DATE_PLACEHOLDER == "16/08/24" then
            nSubs = self.services.SquadManagementService.GetNumberOfSubs()
        else
            nSubs = self.services.SquadManagementService.GetNumberOfSubs()
        end
    elseif self.teamID == 9 then
        nSubs = self.services.SquadManagementService.GetNumberOfSubs()
    else
        nSubs = self.services.SquadManagementService.GetNumberOfSubs()
    end
    local nRes = self.services.SquadManagementService.GetNumberOfReserves(self.teamID)
    local subs = {}
    local res = {}
    local sbsAndRes = {}
    for i = 1, nSubs do
        subs[i] = self.players[i + MAX_STARTING]
    end
    table.insert(sbsAndRes, {label = (""), data = subs})
    if nRes > 0 then
        for i = 1, nRes do
            res[i] = self.players[i + MAX_STARTING + nSubs]
        end
        table.insert(sbsAndRes, {label = (""), data = res})
    end
    self.im.Publish(BND_SBS_AND_RES, sbsAndRes)
    self:checkSquadEligibility()
end

function TeamManagementModel:_publishChemistryMatrix()
    print("[TeamManagementModel]: _publishChemistryMatrix()")
    self.chemistryMatrix = self.services.FUTSquadManagementService.GetFormationLinks(self.models.FormationModel:getCurrentFormationID())
    for _FORV_4_, _FORV_5_ in ipairs(self.chemistryMatrix) do
        _FORV_5_.PLAYER_LINKSTRENGTH = -1
    end
    self.im.Publish(BND_CHEMISTRY_MATRIX, {
        formation = self.models.FormationModel:getCurrentFormation(),
        chemistryLinks = self.chemistryMatrix
    })
    self:checkSquadEligibility()
end

function TeamManagementModel:_publishTeamStats(bindingName)
    if bindingName == nil then
        self:_publishTeamStats(BND_TEAM_NAME)
        self:_publishTeamStats(BND_TEAM_CREST)
        self:_publishTeamStats(BND_TEAM_RATING)
        self:_publishTeamStats(BND_TEAM_OVERALL)
    elseif bindingName == BND_TEAM_NAME then
        self.im.Publish(BND_TEAM_NAME, self.loc.LocalizeString("TeamName_Abbr15_" .. self.teamID))
    elseif bindingName == BND_TEAM_CREST then
        self.im.Publish(BND_TEAM_CREST, {name = "$Crest", id = self.teamID})
    elseif bindingName == BND_TEAM_MAN then
        local ManagerObj = {name = "$ManagerCard", id = 0}
        ManagerObj.id = self.teamID
        self.im.Publish(BND_TEAM_MAN, ManagerObj)
    elseif bindingName == BND_TEAM_RATING then
        self.im.Publish(BND_TEAM_RATING, self.teamInfo.starRating)
    elseif bindingName == BND_TEAM_OVERALL then
        self.im.Publish(BND_TEAM_OVERALL, self.teamInfo.overall)
    else
        print("[TeamManagementModel]: _publishTeamStats(): Team stat unknown.")
    end
end

function TeamManagementModel:_publishPlayerComparisonData()
    self.im.Publish(BND_PLAYER_COMPARISON_DATA, self.playerComparisonData)
end

function TeamManagementModel:_publishTeamRatingLabel()
    local ratingLabel = ("RATING:")
    ratingLabel = ratingLabel..""..tostring(self.teamInfo.overall)
    self.im.Publish(BND_TEAM_RATING_LABEL, ratingLabel)
end

function TeamManagementModel:showBio(positionIndex)
    print("[TeamManagementModel]: showBio(" .. (positionIndex or "nil") .. ")")
    local targetPlayers = {}
    for i, v in ipairs(self.players) do
        local player = TableUtil.shallowcopy(v)
        player.type = self.models.ItemModel:toFEType(player.CARD_TYPE, player.CARD_ID)
        table.insert(targetPlayers, player)
    end

    -- Publish player info for selected index (without name)
    local selectedPlayer = self.players[positionIndex + 1]
    if selectedPlayer then
        self.im.Publish("bnd_player_rating", selectedPlayer.rating)
        self.im.Publish("bnd_player_avatar", {
            name = "$Head",
            id = selectedPlayer.CARD_ID
        })
    end

    self.nav.Event(nil, "evt_show_player_bio", {
        targetPlayers = targetPlayers,
        targetPositionIndex = positionIndex
    })
end

function TeamManagementModel:_setPlayerVisibility(activeVisible, passiveVisible)
  self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, activeVisible)
  self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, passiveVisible)
end
function TeamManagementModel:comparePlayers(activePlayer, passivePlayer)
    self:clearPlayerVisibility()
    
    -- Siempre mostrar active player si existe
    if activePlayer then
        self.im.Publish("bnd_active_player_name", activePlayer.playerName)
        self.im.Publish("bnd_active_player_position", activePlayer.position)
        self.im.Publish("bnd_active_player_rating", activePlayer.rating)
        self.im.Publish("bnd_active_player_avatar", {
            name = "$Head",
            id = activePlayer.CARD_ID or 0
        })
        self:_publishPlayerStats(activePlayer, BND_ACTIVE_STAT_PREFIX)
        self.im.Publish(BND_ACTIVE_PLAYER_VISIBLE, true)
    end
    
    -- Solo mostrar passive player si existe, sino mostrar "-"
    if passivePlayer then
        self.im.Publish("bnd_passive_player_name", passivePlayer.playerName)
        self.im.Publish("bnd_passive_player_position", passivePlayer.position)
        self.im.Publish("bnd_passive_player_rating", passivePlayer.rating)
        self.im.Publish("bnd_passive_player_avatar", {
            name = "$Head",
            id = passivePlayer.CARD_ID or 0
        })
        self:_publishPlayerStats(passivePlayer, BND_PASSIVE_STAT_PREFIX)
        self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, true)
    else
        -- Mostrar "-" cuando no hay jugador pasivo
        self.im.Publish("bnd_passive_player_name", "-")
        self.im.Publish("bnd_passive_player_position", "-")
        self.im.Publish("bnd_passive_player_rating", "-")
        self.im.Publish("bnd_passive_player_avatar", {
            name = "$Head",
            id = 0
        })
        -- Publicar stats vacíos
        for i = 1, 6 do
            self.im.Publish(BND_PASSIVE_STAT_PREFIX..i, "-")
            self.im.Publish(BND_PASSIVE_STAT_COLOR_PREFIX..i, COLOR_DEFAULT)
        end
        self.im.Publish(BND_PASSIVE_PLAYER_VISIBLE, false) -- Mantener invisible
    end
    
    self.playerComparisonData = self:getPlayerComparisonData(activePlayer, passivePlayer)
    self:_publishPlayerComparisonData()
end
function TeamManagementModel:Small()
    local buttonYes = {
        icon = "$FooterIconNo",
        label = "Close",
        clickEvents = {"evt_hide_popup"}
    }
    local popupData = {
        title = "SELECTION ERROR",
        message = "Player is injured",
        buttons = {buttonYes}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamManagementModel:finalize()
    print("[TeamManagementModel]: finalize()")
    self.models.ItemModel:finalize()
    self.models.FormationModel:finalize()
    self.im.UnregisterAction(ACT_SWAP_PLAYERS)
    self.im.UnregisterAction(ACT_COMPARE_PLAYERS)
    self.im.UnregisterAction(ACT_ITEM_SHOW_BIO)
    self.im.UnregisterAction(ACT_SEND_ITEM_DATA)    
    self.im.Unsubscribe(BND_CHEMISTRY_MATRIX)
    self.im.Unsubscribe(BND_STARTING_11)
    self.im.Unsubscribe(BND_SUBS_AND_RES)
    self.im.Unsubscribe(BND_SBS_AND_RES)
    self.im.Unsubscribe(BND_RES)
    self.im.Unsubscribe(BND_RESERVES_ONLY)
    self.im.Unsubscribe(BND_TEAM_NAME)
    self.im.Unsubscribe(BND_TEAM_CREST)
    self.im.Unsubscribe(BND_TEAM_MAN)
    self.im.Unsubscribe(BND_TEAM_RATING)
    self.im.Unsubscribe(BND_TEAM_RATING_LABEL)
    self.im.Unsubscribe(BND_TEAM_OVERALL)
    self.im.Unsubscribe(BND_PLAYER_COMPARISON_DATA)
    self.im.Unsubscribe(BND_ITEM_COLLECTION_CONTEXT_MENU_VISIBLE)
    self.im.Unsubscribe(ELIGIBLE_SQUAD_BINDING)
    self.im.Unsubscribe(BND_PLAYER_AVATAR)
    self.im.Unsubscribe(BND_PLAYER_RATING)
    self.im.Unsubscribe("bnd_active_player_rating")
    self.im.Unsubscribe("bnd_passive_player_rating")
    self.im.Unsubscribe("bnd_active_player_avatar")
    self.im.Unsubscribe("bnd_passive_player_avatar")
    self.im.Unsubscribe("bnd_swap1_active")
    self.im.Unsubscribe("bnd_table")
    self.im.Unsubscribe("bnd_swap2_active")
    self.im.Unsubscribe("bnd_swap3_active")
    self.im.Unsubscribe("bnd_swap1_passive")
    self.im.Unsubscribe("bnd_swap2_passive")
    self.im.Unsubscribe("bnd_swap3_passive")
    self.im.Unsubscribe(NOTICE)
    self.im.Unsubscribe(BND_SWAP_LABEL1)
    self.im.Unsubscribe(BND_SWAP_LABEL2)
    self.im.Unsubscribe(BND_SWAP_LABEL3)
    self.im.Unsubscribe(BND_SWAP_LABEL4)
    self.im.Unsubscribe(BND_SWAP_LABEL5)
    self.im.Unsubscribe(BND_SWAP_LABEL6)
    self.im.Unsubscribe(BND_SWAP_LABEL8)
    self.im.Unsubscribe(BND_ACTIVE_PLAYER_VISIBLE)
    self.im.Unsubscribe(BND_PASSIVE_PLAYER_VISIBLE)
    -- Check for suspended players (isSuspended = 1 or 2) in indices 1-18
    local hasSuspendedPlayer = false
    for i = 1, math.min(18, #self.players) do
        local player = self.players[i]
        if player and player.playerName and (isSuspended[player.playerName] == 1 or isSuspended[player.playerName] == 2) then
            hasSuspendedPlayer = true
            break
        end
    end
    
    -- Only call Small() if there’s a suspended player
    if hasSuspendedPlayer then
        eligibilityStatus = 1
    else
        eligibilityStatus = 0
    end
end

-- [Rest of the code remains unchanged]
return TeamManagementModel