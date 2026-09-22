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
    [1] = "UEFA Champions League", [2] = "FIFA World Cup 2026", [3] = "UEFA Europa League",
    [4] = "CONMEBOL Libertadores", [5] = "Copa do Brasil", [6] = "UEFA Euro",
    [7] = "Dfb Pokal", [8] = "CONMEBOL Sudamericana", [9] = "The Emirates FA Cup",
    [10] = "Copa del Rey", [11] = "Coppa Italia", [12] = "Asean Shopee Cup",
    [13] = "US Open Tour", [14] = "EA Sports Cup", [15] = "FIFA Club World Cup",
    [16] = "UEFA Women CL", [17] = "UEFA Conference League", [18] = "Coupe de France",
    [19] = "Copa Argentina", [20] = "Copa MX", [21] = "AFC Challenge League",
    [22] = "UCL Classic", [23] = "Sea Games U-23", [24] = "AFC Champions League Elit",
    [25] = "Copa America", [26] = "Africa Cup Of Nations", [27] = "ASEAN Hyundai Cup 2026",
    [28] = "UEFA Nations League", [29] = "Kratingdaeng Piala Indonesia", [30] = "ALL STAR CUP",
    [31] = "AFC Champions League Two", [32] = "Piala Presiden", [33] = "Leagues Cup", [50] = "Saudi Arab Tour",
    [34] = "AFC Asian Cup 2023", default = "Custom Tournament"
}

local tourIdToColorMap = {
  [1]="0x000026", [2]="0x1A1A1A", [3]="0x1A1A1A", [4]="0x1A1A1A", [5]="0x1A1A1A", [6]="0x1A1A1A",
    [7]="0x1A1A1A", [8]="0x1A1A1A", [9]="0x1A1A1A", [10]="0x1A1A1A", [11]="0x1A1A1A", [12]="0x1A1A1A",
    [13]="0x1A1A1A", [14]="0x1A1A1A", [15]="0x1A1A1A", [16]="0x1A1A1A", [17]="0x1A1A1A", [18]="0x1A1A1A",
    [19]="0x1A1A1A", [20]="0x1A1A1A", [21]="0x1A1A1A", [22]="0x1A1A1A", [23]="0x1A1A1A", [24]="0x1A1A1A",
    [25]="0x1A1A1A", [26]="0x1A1A1A", [27]="0x1A1A1A", [28]="0x1A1A1A", [29]="0x1A1A1A", [30]="0x1A1A1A",
    [31]="0x1A1A1A", [32]="0x1A1A1A", [33]="0x1A1A1A", [34]="0x070A91", [50]="0x1A1A1A",
    default = "0x1A1A1A"
}

local tourIdToColorMap2 = {
    [12] = "0xC06801",
    [23] = "0x0003B7",
    [27] = "0x003CA8",
    [32] = "0xAD261A",
    default = "0x333333"
}

local tourIdToRefereeNameMap = {
    [12] = "Majed Al-Shamrani",
    [23] = "Bráulio Machado",
    [27] = "Khalid Al-Turais",
    [32] = "Andrés Matonte",
    default = "Default Referee"
}

local teamToCountryMap = {
    [23] = 21, [65] = 18, [1415] = 195, [1951] = 14, [111488] = 192, [111504] = 153, [111505] = 154, [111510] = 160, [111515] = 170,
    [111518] = 173, [111521] = 176, [111526] = 181, [111528] = 184, [111533] = 188, [111640] = 184, [111736] = 188, [111974] = 27,
    [115512] = 160, [115515] = 192, [115616] = 173, [115618] = 173, [115701] = 75, [150600] = 188, [150601] = 188, [150602] = 188, 
    [150631] = 192, [150637] = 192, [155600] = 160, [155601] = 160, [155602] = 160, [155611] = 160
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
    -- Tour 1
    [1] = {
        73, 243, 10, 21, 9, 44, 5, 22, 241, 1, 32, 240, 234, 39, 483, 45, 1824, 231, 18, 247, 245, 48, 237, 280, 266, 918, 219, 819, 69, 325, 2014, 113888, 448, 13, 111282, 110919,
    },
    -- Tour 2
    [2] = {
        1369, 1370, 1337, 1335, 1318, 1362, 1343, 1354, 105035, 1325, 1386, 1387, 111455, 1377, 1328, 1364, 1331, 1353, 1352, 1365, 111111, 1391, 1667, 1395, 1393, 1411, 974, 111115, 111114, 1415, 111465, 111109, 1383, 111462, 111527, 111510
    },
    -- Tour 3
    [3] = {
        14, 2, 52, 236, 36, 326, 189, 246, 65, 66, 72, 25, 1896, 449, 673, 78, 191, 450, 86, 1884, 393, 101078, 1516, 900, 896, 1903, 209, 211, 100761, 112372, 110468, 1874, 320, 100545, 100632, 919,
    },
    -- Tour 4
    [4] = {
        1877, 111020, 101083, 101085, 111019, 111325, 111326, 101108, 110980, 101100, 101106, 101103, 383, 1043, 1629, 1053, 568, 1048, 1041, 1035, 569, 567, 517, 598, 112716, 15029, 111013, 110968, 110969, 110989, 101099, 111010, 110981
    },
    -- Tour 5
    [5] = {
        567, 598, 383, 1043, 1048, 517, 1035, 1041, 1598, 1719, 111052, 111041, 569, 568, 112472, 1053, 111059, 111057, 130361, 269, 270, 271, 819, 822, 1443, 1447, 1516, 1786, 1788, 15006, 272, 681, 1750, 670, 229, 100087
    },
    -- Tour 6
    [6] = {
        110082, 1365, 1366, 1367, 1353, 1331, 1357, 1341, 1338, 1330, 1363, 1362, 1328, 1360, 1359, 1356, 1886, 1318, 1343, 1335, 110081, 105035, 105022, 1354, 1361, 1325, 1319, 105013, 1327, 1322, 1334, 1352, 1364
    },
    -- Tour 7
    [7] = {
        175, 38, 112172, 23, 36, 32, 1831, 21, 100409, 1824, 25, 111235, 22, 110329, 10029, 169, 31, 28, 580, 165, 110500, 10030, 1832, 34, 485, 166, 171, 110636, 29, 531, 110588, 110502, 160
    },
    -- Tour 8
    [8] = {
        567, 110395, 111020, 15029, 111711, 111706, 112908, 101099, 112965, 111010, 101106, 110968, 114615, 111011, 1041, 568, 569, 1629, 1887, 111710, 112535, 115536, 112584, 111328, 110990, 112992, 114611, 111329, 112868, 112667, 110975, 111014, 111001
    },
    -- Tour 9
    [9] = {
        13, 1925, 14, 110, 18, 19, 5, 2, 10, 144, 1, 11, 1799, 1943, 1808, 7, 9, 8, 1796, 106, 15, 97, 1800, 1919, 109, 1960, 1952, 1807, 1794, 1806, 12, 3, 1795
    },
    -- Tour 10
    [10] = {
        1860, 449, 457, 243, 461, 240, 241, 453, 448, 450, 483, 110062, 481, 479, 463, 480, 452, 110827, 472, 100888, 462, 467, 456, 1861, 110839, 1854, 459, 110069, 573, 10846, 244, 110832, 1968
    },
    -- Tour 11
    [11] = {
        52, 46, 347, 55, 1842, 110556, 206, 110374, 39, 48, 44, 54, 45, 189, 50, 1745, 47, 110738, 111974, 111434, 1746, 205, 111811, 1744, 1837, 1843, 1848, 110740, 110908, 110915, 111433, 111657, 112124
    },
    -- Tour 12
    [12] = {
        150600, 150602, 115616, 150631, 150637, 115618, 111640, 111736, 155601, 155602
    },    
    -- Tour 50
    [50] = {
  112392,112390,
  112408,111674,
  112096,112139,
  113057,112883,
  112393,113060,
  607,113037,
  605,112391,
  112387,112675,
    },
    -- Tour 13
    [13] = {
        687, 688, 689, 691, 693, 694, 695, 696, 697, 698, 101112, 111065,
        111138, 111139, 111140, 111144, 111651, 111928, 112134, 112606, 112828, 112885, 112893, 112996,
        113018, 113149, 114161, 114162, 114640, 115243,
    },
    -- Tour 14
    [14] = {
        1, 5, 9, 10, 11, 21, 44, 45, 47, 73, 241, 243, 155602, 155603, 112139, 605, 111575, 112540, 150735, 111499, 110935, 155450, 111353, 112893, 1879, 1032, 111144, 111651, 567, 1877, 1876, 1043, 598, 1053
    },
    -- Tour 15
    [15] = {
        10, 5, 243, 21, 44, 22, 73, 45, 234, 383, 1043, 567, 1876, 150735, 111499, 605, 111575, 1477, 1032, 111144, 110781, 112208, 110935, 101110, 111326, 111733, 121739, 2236, 240, 247, 245, 48, 241
    },
    -- Tour 16
    [16] = {
        116280, 116282, 121358, 121359, 121360, 121361, 121362, 121363,
    },
    -- Tour 17
    [17] = {
        110374, 1906, 101059, 918, 300, 1871, 101047, 1799, 480, 169, 76, 267, 873, 110745, 320, 100820, 264, 278, 77, 110770, 114326, 748, 711, 100325, 110751, 10032, 306, 834, 101315, 420, 417, 483, 19
    },
    -- Tour 18
    [18] = {
        65, 69, 76, 219, 73, 66, 64, 74, 1738, 72, 71, 1530, 57, 378, 1809, 217, 111817, 68, 379, 210, 62, 294, 1816, 111659, 1815, 115494, 58, 110321, 1814, 1805, 614, 67, 111273
    },
    -- Tour 19
    [19] = {
        1013, 1876, 1877, 101083, 101084, 101085, 101088, 110093, 110395, 110396, 110404, 110580,
        110953, 111019, 111020, 111022, 111706, 111708, 111710, 111711, 111715, 111716, 112670, 112689,
        112713, 112965, 113044, 115472,
    },
    -- Tour 20
    [20] = {
        1032, 1878, 1879, 1880, 1881, 1882, 1970, 101114, 101121, 110144, 110147, 110150,
        110152, 110781, 111678, 112678, 113134, 114899,
    },
    -- Tour 21
    [21] = {
        111674, 112098, 112631, 111731, 130188, 111629, 130480, 130478, 155614, 155611, 129096, 129082, 129075, 155612, 155600, 155603, 129098, 115623, 130098, 129095, 130293, 130291, 150634, 150639, 150636, 150637, 112390, 112883, 130278, 111658, 150722, 130578, 1478
    },
    -- Tour 22
    [22] = {
        127948, 127949, 127924, 128000, 127889, 111205, 128398, 128396, 114422, 114421, 127993, 127950, 128362, 128299, 128338, 128004, 128400, 127951, 128028, 114420, 128399, 128397, 128401, 127925, 128322, 127819, 127794, 128371, 127032, 128402, 128403, 128884, 128405

    },
    -- Tour 23
    [23] = {
        111504, 111505, 115512, 111515, 111518, 111521, 111526, 111528, 111533, 115515
    },
    -- Tour 24
    [24] = {
        112387, 112234, 112094, 605, 607, 111733, 130184, 110962, 150600, 116360, 112115, 115618, 130572, 112224, 130031, 113157, 982, 111727, 112098, 112540, 110955, 112100, 112812, 111736, 1473, 101146, 111730, 113197, 111396, 112258, 111090, 112090, 101142
    },
    -- Tour 25
    [25] = {
        1369, 1370, 1377, 111459, 1375, 111108, 111109, 111465, 111487, 111451, 1386, 1387, 111455, 1383, 111475, 111481, 111548, 111546, 112048, 112054, 112060, 1411, 111527, 974, 1415, 111114, 111111, 1362, 1354, 1393, 1667, 1395, 111462, 111115
    },
    -- Tour 26
    [26] = {
        111449, 111456, 1395, 1393, 1667, 1391, 111462, 111448, 111130, 111112, 111461, 111453, 111545, 111489, 111550, 111463, 112044, 111483, 112046, 112049, 111472, 111392, 111549, 111473, 111486, 111537, 112486, 112063, 111547, 111548, 111546, 111521, 111514
    },
    -- Tour 27
    [27] = {
        111533, 111488, 111510, 111518, 111526, 111528, 111521, 1415
    },
    -- Tour 28
    [28] = {
        110082, 1365, 1366, 1367, 1353, 1331, 1357, 1341, 1338, 1330, 1363, 1362, 1328, 1360, 1359, 1356, 1886, 1318, 1343, 1335, 110081, 105035, 105022, 1354, 1361, 1325, 1319, 105013, 1327, 1322, 1334, 1352, 1364
    },
    -- Tour 29
    [29] = {
        155606, 155603, 155611, 155604, 155614, 155607, 155601, 155600, 155612, 155617, 155616, 155620, 155621, 155618, 155602, 155624, 155609, 155630, 155622, 155619, 155623, 155625, 155615, 155610, 155605, 155632, 155633, 155638, 155613, 155608, 155628, 155629, 155627
    },
    -- Tour 30
    [30] = {
        111504, 111505, 115512, 111515, 111518, 111521, 111526, 111528, 111533, 115515
    },
    -- Tour 31
    [31] = {
        111736, 112093, 1474, 111768, 150602, 130288, 114604, 115616, 150631, 150637, 130181, 129054, 111640, 111637, 115650, 155602, 111727, 112139, 110961, 112099, 101142, 130152, 130156, 130185, 130025, 130184, 130180, 113146, 130026, 130163, 130025, 113298, 111633, 113729
    },
    -- Tour 32
    [32] = {
        155602, 155600, 155611, 115701, 1951, 150601, 111974, 65, 23
    },
    -- Tour 33
    [33] = {
        111140, 114161, 697, 114640, 111928, 693, 688, 112828, 694, 691, 113149, 112893, 114162, 112885, 687, 112134, 101112, 112996, 112606, 111651, 698, 111065, 696, 689, 111139, 111138, 695, 111144, 113018, 121439, 101121, 1878, 111678, 110781, 110147, 1032, 101114, 110150, 1879, 112678, 1881, 1880, 114899, 110152, 110144, 1882, 113134, 1970
    },
    -- Tour 34
    [34] = {
        111512, 111533, 111506, 111505, 111513, 111523, 111514, 111536, 111532, 111464, 111510, 111114, 111521, 111466, 111115, 111527, 111525, 111528, 111504, 111526, 1413, 974, 111518, 111485, 111488, 111530, 111392, 111549, 111516, 111502, 111524, 112067, 1415

    }
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
    local teamCount = 8 -- Paksa ke 8 tim untuk format baru
    
    local potentialTeams = TeamDatabase[tourId] or TeamDatabase[1]
    
    local uniqueTeams = removeDuplicates(potentialTeams)
    shuffleArray(uniqueTeams)
    
    TeamList = {}
    for i = 1, math.min(teamCount, #uniqueTeams) do
        table.insert(TeamList, uniqueTeams[i])
    end
    
    print(string.format("✅ Tournament team list created with %d teams for Tour ID %d", #TeamList, tourId))
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
        tourlogo = { name = "$CustomLogo", id = tourId },
        trophy = { name = "$CustomTrophy", id = tourId }
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
        o.im.Publish("bnd_tour_logo", { name = "$CustomLogo", id = currentTourId })
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

    -- KONFIGURASI TURNAMEN 8 TIM
    tournamentConfig.totalTeams = 8
    tournamentConfig.totalGroups = 2
    tournamentConfig.teamsPerGroup = 4
    tournamentConfig.qualifyPerGroup = 2 -- Juara & Runner-up -> Semifinal

    currentTourInfo[tourId] = {
        tourIndex = tourId,
        homeID = 0,
        stage = "GROUP",
        totalMatches = 0,
        totalGroupMatches = 0
    }

    -- BUAT GRUP (2 GRUP: A & B)
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

    -- JADWAL ROUND ROBIN
    local fixtureList = {}
    local singleRoundSchedule = {
        {1,2}, {3,4},
        {1,3}, {2,4},
        {1,4}, {2,3}
    }

    for gIndex, group in ipairs(groupList) do
        for matchNum, pair in ipairs(singleRoundSchedule) do
            if group[pair[1]] and group[pair[2]] then
                table.insert(fixtureList, {
                    group[pair[1]], -- home
                    group[pair[2]], -- away
                    0, 0,
                    false,
                    0,
                    false,
                    true,           -- isGroupMatch
                    string.char(64 + gIndex), -- "A" atau "B"
                    matchNum
                })
            end
        end
    end

    GroupStageTeams[tourId] = groupList
    QuickTourGrouping[tourId] = fixtureList
    currentTourInfo[tourId].totalGroupMatches = #fixtureList

    print("✅ Group Stage Created: 8 Teams | 2 Groups | Direct to Semi-Finals")
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
    local isGroupStage = (#TeamList == 8)
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

