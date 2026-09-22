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
local BND_TEAM_GK_KIT = "bnd_team_gk_kit"
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
    [31] = "AFC Champions League Two", [32] = "Piala Presiden", [33] = "Leagues Cup",
    [34] = "AFC Asian Cup Qatar 2023™", default = "Custom Tournament"
}

local tourIdToColorMap = {
  [1]="0x000026", [2]="0x1A1A1A", [3]="0x1A1A1A", [4]="0x1A1A1A", [5]="0x1A1A1A", [6]="0x1A1A1A",
    [7]="0x1A1A1A", [8]="0x1A1A1A", [9]="0x1A1A1A", [10]="0x1A1A1A", [11]="0x1A1A1A", [12]="0x1A1A1A",
    [13]="0x1A1A1A", [14]="0x1A1A1A", [15]="0x1A1A1A", [16]="0x1A1A1A", [17]="0x1A1A1A", [18]="0x1A1A1A",
    [19]="0x1A1A1A", [20]="0x1A1A1A", [21]="0x1A1A1A", [22]="0x1A1A1A", [23]="0x1A1A1A", [24]="0x1A1A1A",
    [25]="0x1A1A1A", [26]="0x1A1A1A", [27]="0x1A1A1A", [28]="0x1A1A1A", [29]="0x1A1A1A", [30]="0x1A1A1A",
    [31]="0x1A1A1A", [32]="0x1A1A1A", [33]="0x1A1A1A", [34]="0x1A1A1A",
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
        1337, 1359, 1886, 1364, 1362, 1328, 1343, 1319, 1361, 1331, 110082, 1318, 1353, 105035, 1335, 1322, 1360, 1356, 1325, 1366, 1330, 1336, 1365, 1354
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
        5, 10, 243, 44, 45, 21, 22, 73, 236, 234, 240, 191, 383, 1043, 567, 517, 1876, 1877, 1032, 111144, 110147, 112996, 605, 111575, 1473, 111701, 150735, 111499, 110935, 112893, 241, 9, 1
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
        1369, 111451, 1370, 111455, 111459, 111109, 1383, 112054, 111465, 111546, 111462, 111113, 112048, 111548, 111481, 1386, 1393, 111475, 1375, 111108, 112060, 1387, 1377, 111487
    },
    -- Tour 26
    [26] = {
        111112, 1393, 1667, 1395, 111462, 111448, 111130, 111111, 1391, 111550, 111453, 111545, 111099, 111489, 111463, 111456, 111449, 111472, 112044, 112062, 111461, 111483, 111450, 112049
    },
    -- Tour 27
    [27] = {
        111533, 111506, 111505, 111510, 111521, 111518, 111528, 111504, 111526, 111488, 111515, 1413, 1411, 974, 111549, 111464, 111466, 1415, 111524, 111514, 111532, 111485, 111115, 111114, 111523, 111536, 111513, 111527, 111512, 111392, 111391, 111516, 111530
    },
    -- Tour 28
    [28] = {
        1337, 1359, 1886, 1364, 1362, 1328, 1343, 1319, 1361, 1331, 110082, 1318, 1353, 105035, 1335, 1322, 1360, 1356, 1325, 1366, 1330, 1336, 1365, 1354
    },
    -- Tour 29
    [29] = {
        155606, 155603, 155611, 155604, 155614, 155607, 155601, 155600, 155612, 155617, 155616, 155620, 155621, 155618, 155602, 155624, 155609, 155630, 155622, 155619, 155623, 155625, 155615, 155610, 155605, 155632, 155633, 155638, 155613, 155608, 155628, 155629, 155627
    },
    -- Tour 30
    [30] = {
        112190, 111575, 114430, 114428, 114424, 115701, 114426, 114425, 111596, 114427, 114429, 133333, 115655, 132630, 126989, 115654, 126990, 127890, 127889, 128402, 128403, 114815, 128406, 128404, 111205, 128407, 114421, 114419, 114422, 115510, 126992, 126991, 126985
    },
    -- Tour 31
    [31] = {
        111736, 112093, 1474, 111768, 150602, 130288, 114604, 115616, 150631, 150637, 130181, 129054, 111640, 111637, 115650, 155602, 111727, 112139, 110961, 112099, 101142, 130152, 130156, 130185, 130025, 130184, 130180, 113146, 130026, 130163, 130025, 113298, 111633, 113729
    },
    -- Tour 32
    [32] = {
        155600, 155601, 155602, 155603, 155604, 155605, 155606, 155607, 155608, 155609, 155610, 155611, 155612, 155613, 155614, 155615, 155616, 155617, 155618, 155619, 155620, 155621, 155622, 155623, 155624, 155625, 155626, 155627, 155628, 155629, 155630, 155631, 155632, 155633, 155634, 155635
    },
    -- Tour 33
    [33] = {
        111140, 114161, 697, 114640, 111928, 693, 688, 112828, 694, 691, 113149, 112893, 114162, 112885, 687, 112134, 101112, 112996, 112606, 111651, 698, 111065, 696, 689, 111139, 111138, 695, 111144, 113018, 121439, 101121, 1878, 111678, 110781, 110147, 1032, 101114, 110150, 1879, 112678, 1881, 1880, 114899, 110152, 110144, 1882, 113134, 1970
    },
    -- Tour 34
    [34] = {
        111114, 1411, 974, 111549, 1413, 111510, 111533, 111488, 111518, 111466, 111485, 111514, 111532, 111115, 111512, 111513, 111536, 111527, 111523, 111391, 111525, 111530, 111516, 111392

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
        tourBg = { name = "$Bg_Cup", id = tourId },
        tourlogo = { name = "$CustomLogo", id = tourId },
        trophy = { name = "$CutomTrophy", id = tourId }
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
            o.im.Publish("bnd_team_gk_kit", { name = "$GkKit", id = teamId })            
            
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
    o.im.Subscribe("bnd_team_gk_kit", function()
        if TeamListData[1] then o.im.Publish("bnd_team_gk_kit", { name = "$GkKit", id = TeamListData[1].assetId }) end
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
        self.im.Publish("bnd_team_gk_kit", { 
            name = "$GkKit", 
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
    self.im.Unsubscribe("bnd_team_gk_kit")         
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

