-- MOD BY MOUNTSA
local TeamSelect = {}

-- Constants
local BND_TOUR_NAME = "bnd_tour_name"
local BND_TOUR_LOGO = "bnd_tour_logo"
local BND_BG_TOUR = "bnd_bg_tour" 
local BND_TEAM_CREST = "bnd_team_crest"
local BND_TEAM_NAME = "bnd_team_name" 
local BND_TEAM_KIT_HOME = "bnd_team_kit_home"
local BND_TEAM_KIT_AWAY = "bnd_team_kit_away"
local BND_TEAM_RATING = "bnd_team_rating"
local BND_TEAM_STAR_RATING = "bnd_rating_star_team" 
local BND_TEAM_OVERALL = "bnd_rating_team"  
local BND_GROUP_NAME = "bnd_group_name"
local BND_TEAM_FLAG = "bnd_flag_team"
local BND_COLOR_CUPID = "bnd_color_tourid"
local BND_COLOR_TOUR2 = "bnd_color_tour2"
local BND_CUP_LABEL = "bnd_tour_label"
local BND_CUP_BG = "bnd_tour_bg"
local BND_TROPHY = "bnd_trophy"
local BND_TEAM_LIST = "bnd_team_list"
local ACT_TEAM_SELECT = "act_team_select"
local ACT_SELECT_TEAM = "act_select_team"
local ACT_RANDOM_TEAMS = "act_random"
local ACT_CHANGE_TEAM = "act_change_team"
local BND_TEAM_NAMES = {}
local BND_TEAM_LOGOS = {}
local ACT_TABS = {}
local BND_VISIBLE_TABS = {} -- Tambahkan ini

for i = 1, 32 do
    BND_TEAM_NAMES[i] = "bnd_name_team" .. i
    BND_TEAM_LOGOS[i] = "bnd_logo_team" .. i
    ACT_TABS[i] = "act_tab_team" .. i
    BND_VISIBLE_TABS[i] = "bnd_visible_team" .. i -- Tambahkan ini
end

-- Tournament configuration
local tournamentConfig = {
    useUCLStyle = true,
    teamsPerGroup = 4
}

local tourIdToNameMap = {
    [6]  = "UEFA Euro",
    [13] = "US Open Tour",
    [19] = "Copa Argentina",
    [26] = "Africa Cup Of Nations",
    [28] = "UEFA Nations League",
    [34] = "AFC Asian Cup 2027",
    default = "Custom Tournament"
}

local tourIdToColorMap = {
    [6]  = "0x000351",
    [13] = "0x1A1A1A",
    [19] = "0x1A1A1A",
    [26] = "0x550002",
    [28] = "0x19253B",
    [34] = "0x002D04",
    default = "0x1A1A1A"
}

local tourIdToColorMap2 = {
    [6]  = "0x000592",
    [13] = "0x282A30",
    [19] = "0x282A30",
    [25] = "0x002E88",
    [26] = "0x7A0002",
    [28] = "0x293C61",
    [34] = "0x00630C",
    default = "0x333333"
}

local tourIdToRefereeNameMap = {
    [6]  = "Danny Makkelie",
    [13] = "Ismail Elfath",
    [19] = "Fernando Rapallini",
    [26] = "Tobias Stieler",
    [28] = "Artur Soares Dias",
    [34] = "Michael Oliver",
    default = "Default Referee"
}

local teamToCountryMap = {
    [1] = 14, [2] = 14, [3] = 14, [5] = 14, [7] = 14, [8] = 14, [9] = 14, [10] = 14, [11] = 14, [12] = 14,
    [13] = 13, [14] = 14, [15] = 14, [18] = 14, [19] = 14, [20] = 14, [21] = 21, [22] = 21, [23] = 21, [25] = 21,
    [27] = 27, [28] = 21, [29] = 21, [31] = 21, [32] = 21, [34] = 21, [36] = 21, [37] = 37, [38] = 21, [39] = 27,
    [42] = 42, [43] = 43, [44] = 27, [45] = 27, [47] = 27, [48] = 27, [49] = 49, [51] = 51, [52] = 27, [53] = 53,
    [55] = 27, [56] = 56, [57] = 18, [58] = 18, [59] = 59, [60] = 60, [61] = 61, [70] = 70, [72] = 72, [76] = 76,
    [78] = 78, [80] = 80, [81] = 81, [82] = 82, [83] = 83, [85] = 85, [87] = 87, [92] = 92, [95] = 95, [97] = 14,
    [98] = 98, [99] = 99, [101] = 101, [103] = 103, [104] = 104, [108] = 108, [110] = 110, [111] = 111, [115] = 115, [116] = 116,
    [117] = 117, [118] = 118, [119] = 119, [129] = 129, [130] = 130, [133] = 133, [136] = 136, [140] = 140, [143] = 143, [147] = 147,
    [150] = 150, [155] = 155, [158] = 158, [159] = 159, [160] = 160, [161] = 161, [162] = 162, [163] = 163, [164] = 164, [167] = 167,
    [169] = 169, [171] = 171, [173] = 173, [178] = 178, [180] = 180, [182] = 182, [183] = 183, [186] = 186, [187] = 187, [188] = 188,
    [190] = 190, [191] = 191, [192] = 192, [195] = 195, [214] = 214, [687] = 95, [688] = 95, [689] = 95, [691] = 95, [693] = 95,
    [694] = 95, [695] = 95, [696] = 95, [697] = 95, [698] = 95, [974] = 167, [1013] = 52, [1318] = 14, [1319] = 1, [1322] = 14,
    [1325] = 7, [1328] = 10, [1330] = 12, [1331] = 13, [1335] = 18, [1336] = 20, [1337] = 21, [1343] = 27, [1353] = 37, [1354] = 38,
    [1356] = 39, [1359] = 42, [1360] = 43, [1361] = 44, [1362] = 45, [1364] = 47, [1365] = 48, [1366] = 49, [1369] = 52, [1370] = 54,
    [1375] = 58, [1377] = 60, [1383] = 72, [1386] = 83, [1387] = 95, [1391] = 140, [1393] = 133, [1395] = 103, [1411] = 163, [1413] = 155,
    [1415] = 195, [1473] = 167, [1667] = 136, [1876] = 52, [1877] = 52, [1886] = 23, [101112] = 70, [105035] = 34, [110082] = 51, [110093] = 52,
    [110395] = 52, [110396] = 52, [110404] = 52, [110580] = 52, [110953] = 52, [111019] = 52, [111020] = 52, [111022] = 52, [111065] = 95, [111099] = 140,
    [111108] = 59, [111109] = 56, [111111] = 129, [111112] = 108, [111113] = 78, [111114] = 183, [111115] = 161, [111130] = 111, [111138] = 95, [111139] = 70,
    [111140] = 95, [111144] = 95, [111391] = 150, [111448] = 97, [111449] = 98, [111450] = 99, [111451] = 53, [111453] = 101, [111455] = 70, [111456] = 104,
    [111459] = 55, [111461] = 115, [111462] = 117, [111463] = 118, [111464] = 158, [111465] = 57, [111466] = 159, [111472] = 130, [111475] = 87, [111481] = 82,
    [111485] = 191, [111487] = 61, [111488] = 192, [111489] = 147, [111510] = 160, [111512] = 162, [111513] = 164, [111514] = 169, [111516] = 171, [111518] = 173,
    [111523] = 178, [111525] = 180, [111527] = 182, [111530] = 186, [111532] = 187, [111533] = 188, [111536] = 190, [111545] = 110, [111546] = 76, [111548] = 81,
    [111550] = 121, [111651] = 70, [111706] = 52, [111708] = 52, [111710] = 52, [111711] = 52, [111715] = 52, [111716] = 52, [111928] = 95, [112037] = 214,
    [112044] = 116, [112046] = 119, [112048] = 80, [112054] = 85, [112060] = 92, [112062] = 143, [112134] = 95, [112606] = 95, [112670] = 52, [112689] = 52,
    [112713] = 52, [112828] = 95, [112885] = 95, [112893] = 95, [112965] = 52, [112996] = 95, [113018] = 95, [113044] = 52, [113149] = 95, [114161] = 95,
    [114162] = 95, [114640] = 95, [115243] = 95, [115472] = 52
}

local function getFlagIdByTeamId(teamId)
    return teamToCountryMap[teamId] or 0
end

-- Initialize global tables if they don't exist
GroupStandings = GroupStandings or {}
QuickTourGrouping = QuickTourGrouping or {}
currentTourInfo = currentTourInfo or {}
currentTourData = currentTourData or {}
TeamPlayerCache = TeamPlayerCache or {}
TournamentStats = TournamentStats or {}
GroupStageTeams = GroupStageTeams or {}
GOALS = GOALS or {}

local TeamDatabase = {
    [6] = {1337, 1359, 1886, 1364, 1362, 1328, 1343, 1319, 1318, 1331, 1361, 110082, 1335, 105035, 1322, 1353, 1325, 1360, 1356, 1366, 1354, 1365, 1336, 1330},
    [13] = { 687,688,689,691,693,694,695,696,697,698,101112,111065,111138,111139,111140,111144,111651,111928,112134,112606,112828,112885,112893,112996,113018,113149,114161,114162,114640,115243 },
    [19] = { 1013,1876,1877,101083,101084,101085,101088,110093,110395,110396,110404,110580,110953,111019,111020,111022,111706,111708,111710,111711,111715,111716,112670,112689,112713,112965,113044,115472 },
    [25] = {1369, 111451, 1370, 111455, 111459, 111109, 1383, 112054, 111465,111546,111462, 111113, 112048, 111548, 111481, 1386, 1393, 111475,1375,111108,112060, 1387, 1377, 111487},
    [26] = {111111,111448,111449,111450,111453,1395,111456,112037,111112,111545,111130,111461,112044,111462,111463,112046,111550,111472,1393,1667,111099,112062,1391,111489},
    [28] = {1337, 1359, 1886, 1364, 1362, 1328, 1343, 1319, 1318, 1331, 1361, 110082, 1335, 105035, 1322, 1353, 1325, 1360, 1356, 1366, 1354, 1365, 1336, 1330},
    [34] = {111527, 1413, 111532, 111516, 1415, 111485, 111530, 111466, 111115, 111536, 111464, 111525, 1411, 111512, 111488, 111510, 974, 111518, 111513, 111391, 111114, 111533, 111523, 111514}
}
-- Local variables
local TeamList, TeamListData = {}, {}

-- Helper functions
local function removeDuplicates(array)
    local seen, result = {}, {}
    for _, v in ipairs(array) do
        if not seen[v] then
            table.insert(result, v)
            seen[v] = true
        end
    end
    return result
end

local function shuffleArray(array)
    math.randomseed(os.time())
    for i = #array, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
    end
end

local function initTeamList()
    local settings = GlobalTournamentSettings or {}
    local tourId = settings.tourId or 1
    local teamCount = 24 -- Diatur menjadi 24 tim
    
    local potentialTeams = TeamDatabase[tourId] or TeamDatabase[1]
    local uniqueTeams = removeDuplicates(potentialTeams)
    
    -- HAPUS ATAU KOMENTARI BARIS INI:
    -- shuffleArray(uniqueTeams) 
    
    TeamList = {}
    for i = 1, math.min(teamCount, #uniqueTeams) do
        table.insert(TeamList, uniqueTeams[i])
    end
end

local function InitializeTournamentStats(tourId)
    if not TournamentStats[tourId] then
        print("📊 Initializing new statistics structure for Tour ID: " .. tourId)
        TournamentStats[tourId] = {
            Goals = {},
            Assists = {},
            YellowCards = {},
            RedCards = {},
            Appearances = {}
        }
    end
end

function TeamSelect:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.im = init.im
    o.nav = init.nav
    o.loc = init.loc
    o.api = init.api
    
    -- Konstanta Binding
    local BND_TEAM_RATING = "bnd_team_rating"
    local BND_TEAM_OVERALL = "bnd_rating_team" 
    local BND_TEAM_STAR_RATING = "bnd_rating_star_team"
    local BND_GROUP_NAME = "bnd_group_name" 
    
    -- Initialize tournament data
    local tourId = GlobalTournamentSettings.tourId or 1
    o.tourData = {
        name = tourIdToNameMap[tourId] or tourIdToNameMap.default,
        color = tourIdToColorMap[tourId] or tourIdToColorMap.default,
        referee = tourIdToRefereeNameMap[tourId] or tourIdToRefereeNameMap.default,
        tourId = tourId,
        tourBg = { name = "$Bg_Tour", id = tourId },
        tourlogo = { name = "$TourLogo", id = tourId },
        trophy = { name = "$TourTrophy", id = tourId }
    }
    
    -- Initialize services
    o.services = {
        SquadManagementService = o.api("SquadMgtService"),
        AudioService = o.api("AudioService")
    }
    o.visible = false
    
    -- Status Seleksi & Swap
    o.currentSelectedIdx = 1
    o.swapSourceIdx = nil 

    -- ==========================================================
    -- HELPER: UPDATE TAB VISIBILITY (DIPERBARUI)
    -- ==========================================================
    local function updateTabVisibility(selectedIdx)
        for i = 1, 32 do
            -- Tetap visible jika dia tim yang dipilih saat ini 
            -- ATAU dia adalah tim sumber yang sedang menunggu swap
            local isVisible = (i == selectedIdx) or (i == o.swapSourceIdx)
            o.im.Publish("bnd_visible_team" .. i, isVisible)
        end
    end

    -- ==========================================================
    -- HELPER: UPDATE VISUAL DETAIL
    -- ==========================================================
    local function updateTeamVisualsByIndex(idx)
        if TeamListData[idx] then
            local team = TeamListData[idx]
            local teamId = team.assetId
            
            o.im.Publish(BND_TEAM_CREST, { name = "$Crest", id = teamId })
            
            local flagId = getFlagIdByTeamId(teamId)
            o.im.Publish("bnd_flag_team", { name = "$Flag128x128", id = flagId })
            
            local localizedName = o.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
            o.im.Publish("bnd_team_name", localizedName)

            o.im.Publish("bnd_team_kit_home", { name = "$HomeKit", id = teamId })
            o.im.Publish("bnd_team_kit_away", { name = "$AwayKit", id = teamId })

            o.im.Publish(BND_TEAM_OVERALL, team.rating or 0)

            o.im.Publish(BND_TEAM_RATING, {
                attackValue = team.offense or 0,
                middleValue = team.midfield or 0,
                defenseValue = team.defense or 0,
                attackLabel = o.loc.LocalizeString("LTXT_CMN_ATT"),
                middleLabel = o.loc.LocalizeString("LTXT_CMN_MID"),
                defenseLabel = o.loc.LocalizeString("LTXT_CMN_DEF")
            })

            o.im.Publish(BND_TEAM_STAR_RATING, team.starRating or 0)

            local groupIndex = math.ceil(idx / 4)
            local groupLetter = string.char(64 + groupIndex) 
            o.im.Publish(BND_GROUP_NAME, "Group " .. groupLetter)
        end
    end

    -- ==========================================================
    -- LOGIKA SWAP (TUKAR TIM)
    -- ==========================================================
    o.im.RegisterAction("act_change_team", function()
        if o.swapSourceIdx == nil then
            -- --- KLIK PERTAMA ---
            o.services.AudioService.PlaySoundById("act_move_to_club", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })
            
            o.swapSourceIdx = o.currentSelectedIdx
            updateTabVisibility(o.currentSelectedIdx)
            print("🔄 Swap Source Locked: Team " .. o.swapSourceIdx)
        else
            -- --- KLIK KEDUA ---
            o.services.AudioService.PlaySoundById("act_home_kit_next", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })

            local source = o.swapSourceIdx
            local target = o.currentSelectedIdx

            if source ~= target then
                print("🔄 Swapping Team " .. source .. " with Team " .. target)
                
                -- Tukar posisi ID di TeamList
                local tempId = TeamList[source]
                TeamList[source] = TeamList[target]
                TeamList[target] = tempId

                -- Refresh Data & Grouping
                o:Init()
                o:InitGrouping()
                o:publishTeamRows()

                -- Refresh 32 logo di UI
                for i = 1, 32 do
                    if TeamListData[i] then
                        local tId = TeamListData[i].assetId
                        o.im.Publish("bnd_logo_team" .. i, { name = "$Crest", id = tId })
                        o.im.Publish("bnd_name_team" .. i, o.loc.LocalizeString("TeamName_Abbr15_" .. tId))
                    end
                end
                
                -- Refresh visual tim yang aktif sekarang
                updateTeamVisualsByIndex(target)
            end
            
            -- Reset status swap dan update visibilitas (menghilangkan highlight tim sumber)
            o.swapSourceIdx = nil
            updateTabVisibility(o.currentSelectedIdx)
        end
    end)
    
    -- Subscriptions untuk tour settings
    o.im.Subscribe("bnd_color_tour", function()
        local settings = GlobalTournamentSettings or {}
        local currentTourId = settings.tourId or 1
        local tourColor = tourIdToColorMap[currentTourId] or tourIdToColorMap.default
        o.im.Publish("bnd_color_tour", tourColor)
    end)
    
    o.im.Subscribe("bnd_color_tour2", function()
        local settings = GlobalTournamentSettings or {}
        local currentTourId = settings.tourId or 1
        local tourColor2 = tourIdToColorMap2[currentTourId] or tourIdToColorMap2.default
        o.im.Publish("bnd_color_tour2", tourColor2)
    end)
    
    o.im.Subscribe("bnd_bg_tour", function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        o.im.Publish("bnd_bg_tour", { name = "$Bg_Cup", id = currentTourId })
    end)
    
    o.im.Subscribe("bnd_tour_logo", function()
        local settings = GlobalTournamentSettings or {}
        local currentTourId = settings.tourId or 1
        o.im.Publish("bnd_tour_logo", { name = "$CupLogo", id = currentTourId })
    end)
    
    o.im.Subscribe("bnd_tour_name", function()
        local settings = GlobalTournamentSettings or {}
        local currentTourId = settings.tourId or 1
        local tourName = tourIdToNameMap[currentTourId] or tourIdToNameMap.default
        o.im.Publish("bnd_tour_name", tourName)
    end)

    -- ==========================================================
    -- INITIAL BINDINGS (32 TEAMS)
    -- ==========================================================
    for i = 1, 32 do
        o.im.Subscribe("bnd_logo_team" .. i, function()
            if TeamListData[i] then
                o.im.Publish("bnd_logo_team" .. i, { name = "$Crest", id = TeamListData[i].assetId })
            end
        end)

        o.im.Subscribe("bnd_name_team" .. i, function()
            if TeamListData[i] then
                local teamId = TeamListData[i].assetId
                local name = o.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
                o.im.Publish("bnd_name_team" .. i, name)
            end
        end)

        o.im.Subscribe("bnd_visible_team" .. i, function()
            local isVisible = (i == o.currentSelectedIdx) or (i == o.swapSourceIdx)
            o.im.Publish("bnd_visible_team" .. i, isVisible)
        end)
    end

    -- Default details
    o.im.Subscribe(BND_TEAM_RATING, function() updateTeamVisualsByIndex(1) end)
    o.im.Subscribe(BND_TEAM_OVERALL, function()
        if TeamListData[1] then o.im.Publish(BND_TEAM_OVERALL, TeamListData[1].rating or 0) end
    end)
    o.im.Subscribe(BND_TEAM_STAR_RATING, function()
        if TeamListData[1] then o.im.Publish(BND_TEAM_STAR_RATING, TeamListData[1].starRating or 0) end
    end)
    o.im.Subscribe(BND_GROUP_NAME, function()
        if TeamListData[1] then o.im.Publish(BND_GROUP_NAME, "Group A") end
    end)
    o.im.Subscribe(BND_TEAM_CREST, function()
        if TeamListData[1] then o.im.Publish(BND_TEAM_CREST, { name = "$Crest", id = TeamListData[1].assetId }) end
    end)
    o.im.Subscribe("bnd_team_name", function()
        if TeamListData[1] then
            local initialName = o.loc.LocalizeString("TeamName_Abbr15_" .. TeamListData[1].assetId)
            o.im.Publish("bnd_team_name", initialName)
        end
    end)
    o.im.Subscribe("bnd_team_kit_home", function()
        if TeamListData[1] then o.im.Publish("bnd_team_kit_home", { name = "$HomeKit", id = TeamListData[1].assetId }) end
    end)
    o.im.Subscribe("bnd_team_kit_away", function()
        if TeamListData[1] then o.im.Publish("bnd_team_kit_away", { name = "$AwayKit", id = TeamListData[1].assetId }) end
    end)
    
    o.im.Subscribe("bnd_flag_team", function()
        if TeamListData[1] then
            local teamId = TeamListData[1].assetId
            local flagId = getFlagIdByTeamId(teamId)
            o.im.Publish("bnd_flag_team", { name = "$Flag128x128", id = flagId })
        end
    end)
    
    o.im.Publish(BND_CUP_NAME, o.tourData.name)
    o.im.Publish(BND_COLOR_CUPID, o.tourData.color)
    o.im.Publish("bnd_referee_name", o.tourData.referee)
    o.im.Publish(BND_CUP_BG, o.tourData.tourBg)
    o.im.Publish(BND_CUP_LOGO, o.tourData.tourlogo)
    o.im.Publish(BND_TROPHY, o.tourData.trophy)
    
    GlobalTourData = o.tourData
    
    o.im.Subscribe("bnd_visible", function() o:publishVisible() end)
    o.im.Subscribe("bnd_loading_visible", function() o:publishVisible() end)
    
    -- ==========================================================
    -- ACTIONS
    -- ==========================================================
    o.im.RegisterAction("act_select_team", function()
        if TeamListData[o.currentSelectedIdx] then
            o:StartQuickTour({ id = o.currentSelectedIdx - 1 })
        end
    end)

    for i = 1, 32 do
        o.im.RegisterAction("act_tab_team" .. i, function() 
            o.services.AudioService.PlaySoundById("act_move_to_club", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })
            o.currentSelectedIdx = i
            updateTeamVisualsByIndex(i)
            updateTabVisibility(i)
        end)
    end

    GroupStandings[tourId] = GroupStandings[tourId] or {}
    QuickTourGrouping[tourId] = QuickTourGrouping[tourId] or {}

    initTeamList()
    o:cacheAllTeamPlayers()
    InitializeTournamentStats(tourId)
    
    if currentTourInfo[tourId] and currentTourInfo[tourId].homeID ~= 0 then
        o.nav.Event(nil, "evt_team_select")
    else
        o.visible = true
        o:publishVisible()
        o:Init()
        o:InitGrouping()
        o.im.Subscribe(BND_TEAM_LIST, function() o:publishTeamRows() end)
        
        if TeamListData[1] then
            updateTeamVisualsByIndex(1)
            updateTabVisibility(1)
        end

        o.im.RegisterAction(ACT_TEAM_SELECT, function(_, data)
           if data then o:StartQuickTour(data) end
        end)
        
        o.im.RegisterAction(ACT_RANDOM_TEAMS, function()
            o.services.AudioService.PlaySoundById("act_home_kit_next", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })
            o:RandomizeTeams()
            updateTeamVisualsByIndex(1)
            updateTabVisibility(1)
        end)
    end
    
    return o
end

function TeamSelect:publishVisible()
    self.im.Publish("bnd_visible", self.visible)
    self.im.Publish("bnd_loading_visible", not self.visible)
end

function TeamSelect:publishTeamRows()
    -- Tabel konfigurasi posisi grup
    local groupMapping = {
        [1] = "Group A",
        [5] = "Group B",
        [9] = "Group C",
        [13] = "Group D",
        [17] = "Group E",
        [21] = "Group F",
        [25] = "Group G",
        [29] = "Group H"
    }

    for i, team in ipairs(TeamListData) do
        -- Ambil teks grup berdasarkan baris i, jika tidak ada maka string kosong
        local groupLabel = groupMapping[i] or ""

        team.data = {
            GroupName = groupLabel, 
            TeamCrest = { name = "$Crest", id = team.assetId },
            TeamName = team.teamName,
            Rating = team.rating,
            clickAction = team.clickAction,
            FontColor = "0xffffff",
            TeamNameFontColor = "0xffffff",
            Icon = { name = "$IconMatchBall", id = 2 }
        }
    end
    self.im.Publish(BND_TEAM_LIST, TeamListData)
end

function TeamSelect:Init()
    TeamListData = {}
    for _, id in ipairs(TeamList) do
        local info = self.services.SquadManagementService.GetTeamInfo(id)
        
        local starRating = info.starRating or 0 
        
        --- MODIFIKASI DISINI ---
        -- Mengambil nilai overall langsung dari TeamInfo (seperti TeamManagementModel)
        -- Jika info.overall nil, kita beri default 0
        local ratingPuluhan = info.overall or 0
        --------------------------

        if ratingPuluhan > 99 then ratingPuluhan = 99 end

        table.insert(TeamListData, {
            assetId = id,
            clickAction = ACT_TEAM_SELECT,
            teamName = self.loc.LocalizeString("TeamName_Abbr15_" .. id),
            shortTeamName = self.loc.LocalizeString("TeamName_Abbr3_" .. id),
            rating = ratingPuluhan, 
            starRating = starRating,
            -- Data rating detail tetap diambil dari info
            offense = info.offense or 70,
            midfield = info.midfield or 70,
            defense = info.defense or 70,
            data = {}
        })
    end
end

function TeamSelect:InitGrouping()
    local tourId = GlobalTournamentSettings.tourId or 1
    
    -- ===============================
    -- KONFIGURASI TURNAMEN
    -- ===============================
    tournamentConfig.teamsPerGroup = 4
    local totalGroups = 6

    currentTourInfo[tourId] = {
        tourIndex = tourId,
        homeID = 0,
        stage = "GROUP",
        totalMatches = 0
    }

    -- ===============================
    -- DISTRIBUSI TIM KE GRUP
    -- ===============================
    local groupList = {}

    for g = 1, totalGroups do
        groupList[g] = {}

        for i = 1, 4 do
            local index = (g-1) * 4 + i
            if TeamList[index] then
                table.insert(groupList[g], TeamList[index])
            end
        end
    end

    -- ===============================
    -- ROUND ROBIN BASE PAIRS
    -- ===============================
    local basePairs = {
        {1,2},
        {3,4},
        {1,3},
        {2,4},
        {1,4},
        {2,3}
    }

    -- shuffle helper
    local function shuffle(t)
        for i = #t, 2, -1 do
            local j = math.random(i)
            t[i], t[j] = t[j], t[i]
        end
    end

    -- ===============================
    -- GENERATE FIXTURE (RANDOM FAIR)
    -- ===============================
    local fixtureList = {}

    for gIndex, group in ipairs(groupList) do
        local groupLetter = string.char(64 + gIndex)

        local homeCount = {0,0,0,0}
        local awayCount = {0,0,0,0}

        local pairs = {}
        for i,v in ipairs(basePairs) do
            pairs[i] = {v[1], v[2]}
        end

        shuffle(pairs)

        for matchNum, pair in ipairs(pairs) do
            local a = pair[1]
            local b = pair[2]

            local option1_ok =
                homeCount[a] < 2 and awayCount[b] < 2

            local option2_ok =
                homeCount[b] < 2 and awayCount[a] < 2

            local homeIdx, awayIdx

            if option1_ok and option2_ok then
                if math.random() < 0.5 then
                    homeIdx, awayIdx = a, b
                else
                    homeIdx, awayIdx = b, a
                end
            elseif option1_ok then
                homeIdx, awayIdx = a, b
            else
                homeIdx, awayIdx = b, a
            end

            homeCount[homeIdx] = homeCount[homeIdx] + 1
            awayCount[awayIdx] = awayCount[awayIdx] + 1

            if group[homeIdx] and group[awayIdx] then
                table.insert(fixtureList, {
                    group[homeIdx],
                    group[awayIdx],
                    0,
                    0,
                    false,
                    0,
                    false,
                    true,
                    groupLetter,
                    matchNum
                })
            end
        end
    end

    -- ===============================
    -- SIMPAN DATA
    -- ===============================
    GroupStageTeams[tourId] = groupList
    QuickTourGrouping[tourId] = fixtureList
    currentTourInfo[tourId].totalGroupMatches = #fixtureList

    print("✅ Grouping Initialized: Random Fair Home/Away (24 Teams, 6 Groups)")
end

function TeamSelect:RandomizeTeams()
    -- 1. Acak ulang urutan TeamList yang sudah ada
    shuffleArray(TeamList)
    
    -- 2. Re-inisialisasi data tampilan berdasarkan urutan TeamList yang baru
    self:Init()
    
    -- 3. Inisialisasi ulang grup agar jadwal pertandingan mengikuti urutan tim baru
    self:InitGrouping()
    
    -- 4. Publish ulang ke UI agar daftar tim di layar berubah
    self:publishTeamRows()

    -- 5. Reset indeks pilihan ke Tim ke-1 hasil acakan baru
    self.currentSelectedIdx = 1
    
    -- ==========================================================
    -- UPDATE STATIS & VISIBILITAS UNTUK SEMUA 32 TIM
    -- ==========================================================
    for i = 1, 32 do
        if TeamListData[i] then
            local tId = TeamListData[i].assetId
            
            -- Update Logo Tim ke-i
            self.im.Publish("bnd_logo_team" .. i, { 
                name = "$Crest", 
                id = tId 
            })

            -- Update Nama Tim ke-i
            local localizedName = self.loc.LocalizeString("TeamName_Abbr15_" .. tId)
            self.im.Publish("bnd_name_team" .. i, localizedName)
        end

        -- LOGIKA BARU: Reset visibilitas tab. 
        -- Team 1 jadi TRUE, lainnya jadi FALSE
        self.im.Publish("bnd_visible_team" .. i, i == 1)
    end
    -- ==========================================================

    if TeamListData[1] then
        local team = TeamListData[1]
        local teamId = team.assetId
        
        -- Update Crest Utama (Visual Area Tengah/Detail)
        self.im.Publish("bnd_team_crest", { 
            name = "$Crest", 
            id = teamId 
        })
        
        local flagId = getFlagIdByTeamId(teamId)
        self.im.Publish("bnd_flag_team", { name = "$Flag128x128", id = flagId })
        
        -- Update Nama Tim Utama (Visual Detail)
        local mainName = self.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
        self.im.Publish("bnd_team_name", mainName)

        -- Update Kit Home & Away secara visual
        self.im.Publish("bnd_team_kit_home", { 
            name = "$HomeKit", 
            id = teamId 
        })
        self.im.Publish("bnd_team_kit_away", { 
            name = "$AwayKit", 
            id = teamId 
        })

        -- UPDATE NAMA GRUP (Indeks 1 selalu Group A setelah pengacakan)
        self.im.Publish("bnd_group_name", "Group A")

        -- Tambahan: UPDATE RATING OVERALL (Angka Utama) UNTUK HASIL RANDOM
        self.im.Publish("bnd_rating_team", team.rating or 0)

        -- 6. UPDATE RATING DETAIL (ATT MID DEF) UNTUK HASIL RANDOM
        self.im.Publish("bnd_team_rating", {
            attackValue = team.offense or 0,
            middleValue = team.midfield or 0,
            defenseValue = team.defense or 0,
            attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
            middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
            defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
        })

        -- 7. UPDATE RATING BINTANG UNTUK HASIL RANDOM
        self.im.Publish("bnd_rating_star_team", team.starRating or 0)
        
        -- Reset visual Tab ke Tab 1 (jika fungsi ini ada di script asli Anda)
        if self.HideSelections then
            self:HideSelections()
        end
    end
    
    print("🎲 Teams re-shuffled: All 32 Logos, Names, Group & Visibility Reset to Team 1.")
end

function TeamSelect:StartQuickTour(data)
    local tourId = GlobalTournamentSettings.tourId or 1
    local teamIndex = data.id + 1
    local selectedID = TeamListData[teamIndex].assetId
    
    -- Update current tour info
    currentTourInfo[tourId] = currentTourInfo[tourId] or {}
    currentTourInfo[tourId].homeID = selectedID
    currentTourInfo[tourId].referee = self.tourData.referee
    
    currentTourData = {
        matchIndex = 0,
        tourIndex = tourId,
        homeID = selectedID,
        awayID = 0
    }

    -- Determine tournament type and prepare popup message
    local isGroupStage = (#TeamList == 24)
    currentTourInfo[tourId].stage = isGroupStage and "GROUP" or "KNOCKOUT"
    
    local popupTitle = isGroupStage and "GROUP STAGE" or "KNOCKOUT"
    local tournamentName = self.tourData.name
    local teamName = TeamListData[teamIndex].teamName
    
    local popupMessage
    if isGroupStage then
        -- Find group information for the selected team
        local groupLabel = ""
        for g, group in ipairs(GroupStageTeams[tourId] or {}) do
            for _, teamID in ipairs(group) do
                if teamID == selectedID then
                    groupLabel = "Group " .. string.char(64 + g)
                    break
                end
            end
            if groupLabel ~= "" then break end
        end
        
        currentTourInfo[tourId].groupIndex = groupLabel:sub(-1):byte() - 64 -- Convert 'A' to 1, etc.
        currentTourInfo[tourId].groupLabel = groupLabel
        
        popupMessage = string.format(
            "%s\n%s\n%s\n%s",
            tournamentName,
            teamName,
            groupLabel,
            "Ready To Begin Your Journey?"
        )
    else
        -- Knockout stage information
        currentTourInfo[tourId].groupIndex = 0
        currentTourInfo[tourId].groupLabel = "Round of 16"
        
        popupMessage = string.format(
            "%s\n%s\n%s\n%s",
            tournamentName,
            teamName,
            "Round Of 16",
            "Ready To Begin Your KNOCKOUT Challenge?"
        )
    end

    -- Show confirmation popup
    local popupData = {
        title = popupTitle,
        message = popupMessage,
        buttons = {
            { 
				label = "Cancel",
                icon = "$FooterIconNo", 
                label = "Cancel", 
                clickEvents = { "evt_hide_popup" } 
            },
            { 
				label = "Confirm",
                icon = "$FooterIconYes", 
                label = "Confirm", 
                clickEvents = { "evt_team_select", "evt_hide_popup" } 
            }
        }
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamSelect:cacheAllTeamPlayers()
    local tourId = GlobalTournamentSettings.tourId or 1
    print("⏳ Caching player data for all teams...")
    
    TeamPlayerCache[tourId] = TeamPlayerCache[tourId] or {}
 
    for i, teamID in ipairs(TeamList) do
        if not TeamPlayerCache[tourId][teamID] then
            local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)
            TeamPlayerCache[tourId][teamID] = players
            print(string.format("   (%d/%d) Cached team %d", i, #TeamList, teamID))
        end
    end
    
    GOALS[tourId] = GOALS[tourId] or {}
    print("✅ Player caching completed for " .. #TeamList .. " teams.")
end

function TeamSelect:finalize()
    -- Unsubscribe dari semua event binding utama
    self.im.Unsubscribe("bnd_visible")
    self.im.Unsubscribe("bnd_loading_visible")
    self.im.Unsubscribe(BND_TEAM_LIST)
    self.im.Unsubscribe("bnd_tour_logo")
    self.im.Unsubscribe("bnd_bg_tour")
    self.im.Unsubscribe("bnd_tour_name")
    self.im.Unsubscribe("bnd_color_tour")
    self.im.Unsubscribe("bnd_color_tour2")
    self.im.Unsubscribe(BND_CUP_LABEL)
    self.im.Unsubscribe(BND_CUP_BG)
    self.im.Unsubscribe(BND_TROPHY)
    self.im.Unsubscribe(BND_TEAM_CREST)
    self.im.Unsubscribe("bnd_team_name") 
    self.im.Unsubscribe("bnd_team_kit_home")
    self.im.Unsubscribe("bnd_team_kit_away") 
    self.im.Unsubscribe(BND_TEAM_RATING)
    self.im.Unsubscribe("bnd_rating_star_team")
    self.im.Unsubscribe("bnd_rating_team")
    self.im.Unsubscribe(BND_GROUP_NAME)
    self.im.Unsubscribe("bnd_flag_team")

    -- Unregister action global
    self.im.UnregisterAction(ACT_TEAM_SELECT)
    self.im.UnregisterAction(ACT_SELECT_TEAM)
    self.im.UnregisterAction(ACT_RANDOM_TEAMS)
    self.im.UnregisterAction("act_change_team")

    for i = 1, 32 do
        self.im.Unsubscribe("bnd_logo_team" .. i)
        self.im.Unsubscribe("bnd_name_team" .. i)
        -- Tambahkan ini:
        self.im.Unsubscribe("bnd_visible_team" .. i)
        
        self.im.UnregisterAction("act_tab_team" .. i)
    end
    
    print("✅ TeamSelect Finalized: All 32 team subscriptions and actions cleared.")
end

return TeamSelect

