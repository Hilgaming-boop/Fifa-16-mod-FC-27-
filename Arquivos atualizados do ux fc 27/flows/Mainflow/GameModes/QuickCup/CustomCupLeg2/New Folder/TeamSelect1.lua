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
local ACT_CHANGE_TEAM = "act_change_team" -- Tambahkan
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
    [2]  = "FIFA World Cup 2026",
    [7]  = "Dfb Pokal",
    [9]  = "The Emirates FA Cup",
    [10] = "Copa del Rey",
    [11] = "Coppa Italia",
    [14] = "EA Sports Cup",
    [15] = "FIFA Club World Cup",
    [16] = "UEFA Women CL",
    [18] = "Coupe de France",
    [29] = "Kratingdaeng Piala Indonesia",
    [30] = "ALL STAR CUP",
    [33] = "Leagues Cup",
    default = "Custom Tournament"
}

local tourIdToColorMap = {
    [2]  = "0x000E34",
    [7]  = "0x1A1A1A",
    [9]  = "0x1A1A1A",
    [10] = "0x131244",
    [11] = "0x5C0103",
    [14] = "0x1A1A1A",
    [15] = "0x022E01",
    [16] = "0x1A1A1A",
    [18] = "0x1A1A1A",
    [29] = "0x0E3353",
    [30] = "0x1A1A1A",
    [33] = "0x1A1A1A",
    default = "0x1A1A1A"
}

local tourIdToColorMap2 = {
    [2]  = "0x1997BB",
    [7]  = "0x282A30",
    [9]  = "0x282A30",
    [10] = "0x78000B",
    [11] = "0x930205",
    [14] = "0x282A30",
    [15] = "0x056001",
    [16] = "0x282A30",
    [18] = "0x282A30",
    [29] = "0x175081",
    [30] = "0x282A30",
    [33] = "0x282A30",
    default = "0x282A30"
}

local tourIdToRefereeNameMap = {
    [2]  = "Daniele Orsato",
    [7]  = "Felix Zwayer",
    [9]  = "Michael Oliver",
    [10] = "Antonio Mateu Lahoz",
    [11] = "Massimiliano Irrati",
    [14] = "Yamashita Yoshimi",
    [15] = "Abdulrahman Al-Jassim",
    [16] = "Stéphanie Frappart",
    [18] = "Clément Turpin",
    [29] = "Luiz Flávio de Oliveira",
    [30] = "Bruno Arleu de Araujo",
    [33] = "Jean Pierre Goncalves",
    default = "Default Referee"
}

local teamToCountryMap = {
    [1] = 14, [2] = 14, [3] = 14, [5] = 14, [7] = 14, [8] = 14, [9] = 14, [10] = 14, [11] = 14, [12] = 14,
    [13] = 13, [14] = 14, [15] = 14, [18] = 14, [19] = 14, [21] = 21, [22] = 21, [23] = 21, [25] = 21, [28] = 21,
    [29] = 21, [31] = 21, [32] = 21, [34] = 21, [36] = 21, [38] = 21, [39] = 27, [44] = 27, [45] = 27, [46] = 27,
    [47] = 27, [48] = 27, [50] = 27, [52] = 27, [54] = 27, [55] = 27, [57] = 18, [58] = 18, [62] = 18, [64] = 18,
    [65] = 18, [66] = 18, [67] = 18, [68] = 18, [69] = 18, [71] = 18, [72] = 18, [73] = 18, [74] = 18, [76] = 18,
    [97] = 14, [106] = 14, [109] = 14, [110] = 14, [144] = 14, [160] = 160, [165] = 21, [166] = 21, [169] = 21, [171] = 21,
    [175] = 21, [189] = 27, [191] = 10, [205] = 27, [206] = 27, [210] = 18, [217] = 18, [219] = 18, [234] = 38, [236] = 38,
    [240] = 45, [241] = 45, [243] = 45, [244] = 45, [294] = 18, [347] = 27, [378] = 18, [379] = 18, [383] = 54, [448] = 45,
    [449] = 45, [450] = 45, [452] = 45, [453] = 45, [456] = 45, [457] = 45, [459] = 45, [461] = 45, [462] = 45, [463] = 45,
    [467] = 45, [472] = 45, [479] = 45, [480] = 45, [481] = 45, [483] = 45, [485] = 21, [517] = 54, [531] = 21, [567] = 54,
    [573] = 45, [580] = 21, [598] = 54, [605] = 183, [614] = 18, [687] = 95, [688] = 95, [689] = 95, [691] = 95, [693] = 95,
    [694] = 95, [695] = 95, [696] = 95, [697] = 95, [698] = 95, [974] = 167, [1032] = 83, [1043] = 54, [1053] = 54, [1318] = 14,
    [1325] = 7, [1328] = 10, [1331] = 13, [1335] = 18, [1337] = 21, [1353] = 37, [1354] = 38, [1362] = 45, [1364] = 47, [1367] = 50,
    [1369] = 52, [1370] = 54, [1377] = 60, [1383] = 72, [1386] = 83, [1387] = 95, [1395] = 103, [1411] = 163, [1415] = 195, [1473] = 167,
    [1530] = 18, [1667] = 136, [1738] = 18, [1744] = 27, [1745] = 27, [1746] = 27, [1794] = 14, [1795] = 14, [1796] = 14, [1799] = 14,
    [1800] = 14, [1805] = 18, [1806] = 14, [1807] = 14, [1808] = 14, [1809] = 18, [1814] = 18, [1815] = 18, [1816] = 18, [1824] = 21,
    [1831] = 21, [1832] = 21, [1837] = 27, [1842] = 27, [1843] = 27, [1848] = 27, [1854] = 45, [1860] = 45, [1861] = 45, [1876] = 52,
    [1877] = 52, [1878] = 83, [1879] = 83, [1880] = 83, [1881] = 83, [1882] = 83, [1919] = 14, [1925] = 14, [1943] = 14, [1952] = 14,
    [1960] = 14, [1968] = 45, [1970] = 83, [10029] = 21, [10030] = 21, [10846] = 45, [100409] = 21, [100888] = 45, [101112] = 70, [101114] = 83,
    [101121] = 83, [105035] = 34, [110062] = 45, [110069] = 45, [110082] = 51, [110144] = 83, [110147] = 83, [110150] = 83, [110152] = 83, [110321] = 18,
    [110329] = 21, [110374] = 27, [110500] = 21, [110502] = 21, [110556] = 27, [110588] = 21, [110636] = 21, [110738] = 27, [110740] = 27, [110781] = 83,
    [110827] = 45, [110832] = 45, [110839] = 45, [110908] = 27, [110915] = 27, [110935] = 140, [111065] = 95, [111111] = 129, [111114] = 183, [111115] = 161,
    [111138] = 95, [111139] = 95, [111140] = 95, [111144] = 95, [111235] = 21, [111273] = 18, [111353] = 145, [111433] = 27, [111434] = 27, [111455] = 70,
    [111462] = 117, [111465] = 57, [111499] = 129, [111510] = 160, [111527] = 182, [111575] = 163, [111596] = 75, [111651] = 70, [111657] = 27, [111659] = 18,
    [111678] = 83, [111701] = 190, [111811] = 27, [111817] = 18, [111928] = 95, [111974] = 27, [112124] = 27, [112134] = 95, [112139] = 183, [112172] = 21,
    [112190] = 75, [112540] = 155, [112606] = 95, [112678] = 83, [112828] = 95, [112885] = 95, [112893] = 95, [112996] = 95, [113018] = 95, [113134] = 83,
    [113149] = 95, [114161] = 95, [114162] = 95, [114424] = 75, [114425] = 75, [114426] = 75, [114427] = 75, [114428] = 75, [114429] = 75, [114430] = 75,
    [114640] = 95, [114899] = 83, [115701] = 75, [121439] = 95, [150735] = 49, [155450] = 49, [155600] = 160, [155601] = 160, [155602] = 160, [155603] = 160,
    [155604] = 160, [155605] = 160, [155606] = 160, [155607] = 160, [155608] = 160, [155609] = 160, [155610] = 160, [155611] = 160, [155612] = 160, [155613] = 160,
    [155614] = 160, [155615] = 160, [155616] = 160, [155617] = 160, [155618] = 160, [155619] = 160, [155620] = 160, [155621] = 160, [155622] = 160, [155623] = 160,
    [155624] = 160, [155625] = 160, [155627] = 160, [155628] = 160, [155629] = 160, [155630] = 160, [155632] = 160, [155633] = 160, [155638] = 160
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

    [2] = { 111527, 111465, 1667, 105035, 1318, 111115, 1387, 1367, 1369, 111114, 1386, 1353, 1335, 1415, 1331, 111510, 1362, 1383, 1337, 1411, 1325, 111455, 111111, 1328, 1370, 110082, 1364, 1393, 1354, 111462, 1377, 974 },

    [7] = { 175,38,112172,23,36,32,1831,21,100409,1824,25,111235,22,110329,10029,169,31,28,580,165,110500,10030,1832,34,485,166,171,110636,29,531,110588,110502,160 },

    [9] = { 13,1925,14,110,18,19,5,2,10,144,1,11,1799,1943,1808,7,9,8,1796,106,15,97,1800,1919,109,1960,1952,1807,1794,1806,12,3,1795 },

    [10] = { 1860,449,457,243,461,240,241,453,448,450,483,110062,481,479,463,480,452,110827,472,100888,462,467,456,1861,110839,1854,459,110069,573,10846,244,110832,1968 },

    [11] = { 52,46,347,55,1842,110556,206,110374,39,48,44,54,45,189,50,1745,47,110738,111974,111434,1746,205,111811,1744,1837,1843,1848,110740,110908,110915,111433,111657,112124 },

    [14] = { 1,5,9,10,11,21,44,45,47,73,241,243,155602,155603,112139,605,111575,112540,150735,111499,110935,155450,111353,112893,1879,1032,111144,111651,567,1877,1876,1043,598,1053 },

    [15] = { 5,10,243,44,45,21,22,73,236,234,240,191,383,1043,567,517,1876,1877,1032,111144,110147,112996,605,111575,1473,111701,150735,111499,110935,112893,241,9,1 },

    [16] = { 116280,116282,121358,121359,121360,121361,121362,121363,116010,115995,116034,116325,116017,115996,116009,116326,116044,122370,116015,116004,116042,116038,115998,116343,116002,116001,122176,116033,116041,116386,121720,122629 },

    [18] = { 65,69,76,219,73,66,64,74,1738,72,71,1530,57,378,1809,217,111817,68,379,210,62,294,1816,111659,1815,115494,58,110321,1814,1805,614,67,111273 },

    [29] = { 155606,155603,155611,155604,155614,155607,155601,155600,155612,155617,155616,155620,155621,155618,155602,155624,155609,155630,155622,155619,155623,155625,155615,155610,155605,155632,155633,155638,155613,155608,155628,155629,155627 },

    [30] = { 112190,111575,114430,114428,114424,115701,114426,114425,111596,114427,114429,133333,115655,132630,126989,115654,126990,127890,127889,128402,128403,114815,128406,128404,111205,128407,114421,114419,114422,115510,126992,126991,126985 },

    [33] = { 111140,114161,697,114640,111928,693,688,112828,694,691,113149,112893,114162,112885,687,112134,101112,112996,112606,111651,698,111065,696,689,111139,111138,695,111144,113018,121439,101121,1878,111678,110781,110147,1032,101114,110150,1879,112678,1881,1880,114899,110152,110144,1882,113134,1970 }

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
    local teamCount = settings.teamCount or 32
    
    -- Ambil tim potensial dari database berdasarkan Tour ID
    local potentialTeams = TeamDatabase[tourId] or TeamDatabase[1]
    
    -- Hapus duplikat tanpa mengacak urutan asli dari database
    local uniqueTeams = removeDuplicates(potentialTeams)
    
    -- Pilih jumlah tim yang dibutuhkan sesuai urutan di TeamDatabase
    TeamList = {}
    for i = 1, math.min(teamCount, #uniqueTeams) do
        table.insert(TeamList, uniqueTeams[i])
    end
    
    print(string.format("✅ Tournament team list created using Database order for Tour ID %d", tourId))
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
    tournamentConfig.totalTeams = 32
    tournamentConfig.totalGroups = 8
    tournamentConfig.teamsPerGroup = 4
    tournamentConfig.qualifyPerGroup = 2

    currentTourInfo[tourId] = {
        tourIndex = tourId,
        homeID = 0,
        stage = "GROUP",
        totalMatches = 0,
        totalGroupMatches = 0
    }

    -- ===============================
    -- BUAT GRUP
    -- ===============================
    local groupList = {}

    for g = 1, tournamentConfig.totalGroups do
        groupList[g] = {}

        for i = 1, tournamentConfig.teamsPerGroup do
            local index = (g - 1) * tournamentConfig.teamsPerGroup + i
            if TeamList[index] then
                table.insert(groupList[g], TeamList[index])
            end
        end
    end

    -- ===============================
    -- ROUND ROBIN PAIRS
    -- ===============================
    local basePairs = {
        {1,2},
        {3,4},
        {1,3},
        {2,4},
        {1,4},
        {2,3}
    }

    -- random helper
    local function shuffle(t)
        for i = #t, 2, -1 do
            local j = math.random(i)
            t[i], t[j] = t[j], t[i]
        end
    end

    -- ===============================
    -- GENERATE FIXTURES (RANDOM FAIR)
    -- ===============================
    local fixtureList = {}

    for gIndex, group in ipairs(groupList) do

        -- track home/away count
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

            table.insert(fixtureList, {
                group[homeIdx],
                group[awayIdx],
                0, 0,
                false,
                0,
                false,
                true,
                string.char(64 + gIndex),
                matchNum
            })
        end
    end

    -- ===============================
    -- SIMPAN DATA
    -- ===============================
    GroupStageTeams[tourId] = groupList
    QuickTourGrouping[tourId] = fixtureList
    currentTourInfo[tourId].totalGroupMatches = #fixtureList

    print("✅ Group Stage Created (Random Fair Home/Away)")
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
    local isGroupStage = (#TeamList == 32)
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

