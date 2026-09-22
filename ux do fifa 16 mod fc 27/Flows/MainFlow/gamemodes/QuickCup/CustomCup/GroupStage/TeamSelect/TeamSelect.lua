-- CustomCup By Mounsta
-- Patch Mod InisialA (SaveTur & Sistem)
-- Rober fl
-- BillzYt

local TeamSelect = {}

local BND_CUP_NAME = "bnd_tour_name"
local BND_CUP_LOGO = "bnd_tour_logo"
local BND_CUP_COLOR = "bnd_tour_color"
local BND_CUP_COLOR_TAB = "bnd_tour_color_tab"
local BND_CUP_LABEL = "bnd_tour_label"
local BND_CUP_BG = "bnd_tour_bg"
local BND_TROPHY = "bnd_trophy"
local BND_TEAM_LIST = "bnd_team_list"
local ACT_TEAM_SELECT = "act_team_select"
local ACT_SELECT_TEAM = "act_select_team"
local ACT_RANDOM_TEAMS = "act_random"
local ACT_CHANGE_TEAM = "act_change_team"
local BND_TEAM_CREST = "bnd_team_crest"
local BND_TEAM_NAME = "bnd_team_name"
local BND_TEAM_KIT_HOME = "bnd_team_kit_home"
local BND_TEAM_KIT_AWAY = "bnd_team_kit_away"
local BND_TEAM_GK_KIT = "bnd_team_gk_kit"
local BND_TEAM_RATING = "bnd_team_rating"
local BND_TEAM_OVERALL = "bnd_rating_team"
local BND_TEAM_STAR_RATING = "bnd_rating_star_team"
local BND_GROUP_NAME = "bnd_group_name"
local BND_TEAM_FLAG = "bnd_flag_team"
local BND_TEAM_NAMES = {}
local BND_TEAM_LOGOS = {}
local ACT_TABS = {}
local BND_VISIBLE_TABS = {}

for i = 1, 48 do
    BND_TEAM_NAMES[i] = "bnd_name_team" .. i
    BND_TEAM_LOGOS[i] = "bnd_logo_team" .. i
    ACT_TABS[i] = "act_tab_team" .. i
    BND_VISIBLE_TABS[i] = "bnd_visible_team" .. i
end

local tourIdToNameMap = {
    [1] = "UEFA Champions League", [2] = "FIFA World Cup 2026", [3] = "UEFA Europa League",
    [4] = "CONMEBOL Libertadores", [5] = "Copa do Brasil", [6] = "UEFA Euro",
    [7] = "Dfb Pokal", [8] = "CONMEBOL Sudamericana", [9] = "The Emirates FA Tour",
    [10] = "Copa del Rey", [11] = "Coppa Italia", [12] = "Asean Shopee Cup",
    [13] = "US Open Tour", [14] = "EA Sports Cup", [15] = "FIFA Club World Cup",
    [16] = "UEFA Women CL", [17] = "UEFA Conference League", [18] = "Coupe de France",
    [19] = "Copa Argentina", [20] = "Copa MX", [21] = "AFC Challenge League",
    [22] = "Classic Tour", [23] = "Sea Games U-23", [24] = "AFC Champions League Elit",
    [25] = "Copa America", [26] = "Africa Cup Of Nations", [27] = "ASEAN Hyundai Cup 2026",
    [28] = "UEFA Nations League", [29] = "Kratingdaeng Piala Indonesia", [30] = "ALL STAR CUP",
    [31] = "AFC Champions League Two", [32] = "Piala Presiden", [33] = "Leagues Cup",
    [34] = "AFC Asian Cup 2023", [50] = "Saudi Arab Tour", [133] = "Premier League", [144] = "Championship", [533] = "Laliga", [544] = "Segunda División", [311] = "Serie A", [322] = "Serie B", [199] = "BundesLiga", [200] = "BundesLiga 2", [166] = "Ligue 1", [177] = "League 2", [350] = "Saudi League", [2235] = "BRI Super League", [2254] = "Pegadaian Liga 2", default = "Custom Tournament"
}

local tourIdToColorMap = {
    [1]   = "0x000026", -- UCL: Dark Blue
    [2]   = "0x0051FF", -- World Cup 2026: Bright Blue
    [3]   = "0x2F0103", -- UEL: Dark Maroon
    [4]   = "0x111111", -- Libertadores: Dark Black
    [5]   = "0x003311", -- Copa do Brasil: Dark Green
    [6]   = "0x0A1128", -- Euro: Navy Blue
    [7]   = "0x1A1A1A", -- Dfb Pokal: Dark Grey
    [8]   = "0x221100", -- Sudamericana: Dark Bronze
    [9]   = "0x880000", -- FA Cup: Red
    [10]  = "0x990000", -- Copa del Rey: Red
    [11]  = "0x002266", -- Coppa Italia: Blue
    [12]  = "0xFF3300", -- Asean Shopee Cup: Orange Red
    [13]  = "0x001133", -- US Open: Dark Blue
    [14]  = "0x1A1A1A", -- EA Sports Cup: Dark Grey
    [15]  = "0x1A1A1A", -- Club World Cup: Deep Blue
    [16]  = "0x000026", -- UEFA Women CL: Dark Blue
    [17]  = "0x044508", -- UEFA Conference League: Forest Green
    [18]  = "0x002060", -- Coupe de France: Blue
    [19]  = "0x003366", -- Copa Argentina: Sky Blue Tint
    [20]  = "0x004d00", -- Copa MX: Green
    [21]  = "0x3E0118", -- AFC Challenge League: Dark Wine
    [22]  = "0x1A1A1A", -- Classic Tour: Dark Grey
    [23]  = "0xCC0000", -- Sea Games U-23: Red
    [24]  = "0x16002D", -- AFC Champions League Elit: Royal Purple
    [25]  = "0x002D62", -- Copa America: Blue
    [26]  = "0x006600", -- Africa Cup Of Nations: Green
    [27]  = "0xFF6600", -- ASEAN Hyundai Cup: Orange
    [28]  = "0x001B3A", -- UEFA Nations League: Navy
    [29]  = "0xCC0000", -- Piala Indonesia: Red
    [30]  = "0x330033", -- ALL STAR CUP: Dark Purple
    [31]  = "0x00084E", -- AFC Champions League Two: Deep Navy
    [32]  = "0xFF4500", -- Piala Presiden: Orange Red
    [33]  = "0x00A86B", -- Leagues Cup: Jade Green
    [34]  = "0x070A91", -- AFC Asian Cup: Blue
    [50]  = "0x004D1A", -- Saudi Arab Tour: Emerald Green
    [133] = "0x38003C", -- Premier League: Purple
    [144] = "0x002D35", -- Championship: Teal Dark
    [533] = "0x1A1A1A", -- Laliga: Dark Slate (Normal)
    [544] = "0x2C3539", -- Segunda División: Gunmetal
    [311] = "0x00529B", -- Serie A: Blue Azure
    [322] = "0x002244", -- Serie B: Navy Dark
    [199] = "0xD20515", -- BundesLiga: Red
    [200] = "0x101820", -- BundesLiga 2: Dark Charcoal
    [166] = "0x001435", -- Ligue 1: Dark Navy
    [177] = "0x0047AB", -- League 2: Cobalt Blue
    [350] = "0x004D1A", -- Saudi League: Green
    [2235]= "0x001464", -- BRI Super League: BRI Blue
    [2254]= "0x004D1A", -- Pegadaian Liga 2: Blue Dark
    default = "0x1A1A1A"
}

local tourIdToColorTabMap = {
    [1]   = "0xE00069", -- UCL Accent
    [2]   = "0xDB0785", -- World Cup 2026 Accent
    [3]   = "0x990009", -- UEL Accent
    [4]   = "0x282A30", -- Libertadores Accent
    [5]   = "0x006622", -- Copa do Brasil Accent
    [6]   = "0x1C2D5A", -- Euro Accent
    [7]   = "0x333333", -- Dfb Pokal Accent
    [8]   = "0x442200", -- Sudamericana Accent
    [9]   = "0xCC0000", -- FA Cup Accent
    [10]  = "0xCC0000", -- Copa del Rey Accent
    [11]  = "0x0044CC", -- Coppa Italia Accent
    [12]  = "0xFF6600", -- Asean Shopee Cup Accent
    [13]  = "0x003366", -- US Open Accent
    [14]  = "0x282A30", -- EA Sports Cup Accent
    [15]  = "0x282A30", -- Club World Cup Accent
    [16]  = "0xE00069", -- UEFA Women CL Accent
    [17]  = "0x099312", -- UEFA Conference League Accent
    [18]  = "0x004080", -- Coupe de France Accent
    [19]  = "0x0059B3", -- Copa Argentina Accent
    [20]  = "0x008000", -- Copa MX Accent
    [21]  = "0x760138", -- AFC Challenge League Accent
    [22]  = "0x282A30", -- Classic Tour Accent
    [23]  = "0xFF0000", -- Sea Games U-23 Accent
    [24]  = "0x341C5E", -- AFC Champions League Elit Accent
    [25]  = "0x0047AB", -- Copa America Accent
    [26]  = "0x009900", -- Africa Cup Of Nations Accent
    [27]  = "0xFF8000", -- ASEAN Hyundai Cup Accent
    [28]  = "0x003366", -- UEFA Nations League Accent
    [29]  = "0xFF0000", -- Piala Indonesia Accent
    [30]  = "0x660066", -- ALL STAR CUP Accent
    [31]  = "0x000B70", -- AFC Champions League Two Accent
    [32]  = "0xFF6622", -- Piala Presiden Accent
    [33]  = "0x00CC88", -- Leagues Cup Accent
    [34]  = "0x1D24CE", -- AFC Asian Cup Accent
    [50]  = "0x00802B", -- Saudi Arab Tour Accent
    [133] = "0x5A0062", -- Premier League Accent
    [144] = "0x005566", -- Championship Accent
    [533] = "0x3A3B3C", -- Laliga Accent
    [544] = "0x4D5656", -- Segunda División Accent
    [311] = "0x007ACC", -- Serie A Accent
    [322] = "0x003366", -- Serie B Accent
    [199] = "0xFF1A1A", -- BundesLiga Accent
    [200] = "0x2C3539", -- BundesLiga 2 Accent
    [166] = "0x003366", -- Ligue 1 Accent
    [177] = "0x1E90FF", -- League 2 Accent
    [350] = "0x00802B", -- Saudi League Accent
    [2235]= "0x004DFF", -- BRI Super League Accent
    [2254]= "0x00802B", -- Pegadaian Liga 2 Accent
    default = "0x282A30"
}

local tourIdToRefereeNameMap = {
    [1]  = "Clément Turpin",
    [3]  = "Carlos del Cerro",
    [4]  = "Wilmar Roldán",
    [8]  = "Facundo Tello",
    [14] = "Yamashita Yoshimi",
    [17] = "Yudi Nurcahya",
    [21] = "Christopher Beath",
    [22] = "Mark Clattenburg",
    [24] = "Orel Grinfeld",
    [30] = "Bruno Arleu de Araujo",
    [31] = "Szymon Marciniak",
    default = "Default Referee"
}

-- Mapeamento de Times para País (para bandeiras)
local teamToCountryMap = {
    --England Teams--
    [1] = 14, [2] = 14, [5] = 14, [9] = 14, [10] = 14, [13] = 14,
    [18] = 14, [7] = 14, [11] = 14, [14] = 14, [8] = 14, [106] = 14,
    [88] = 14, [3] = 14, [95] = 14, [12] = 14, [116009] = 14,
    [116010] = 14, [116011] = 14, [116012] = 14, [116013] = 14,
    [116014] = 14, [116015] = 14, [116016] = 14, [116017] = 14,
    [116020] = 14, [116343] = 14,
    
    --France Teams--
    [73] = 18, [219] = 18, [66] = 18, [69] = 18, [65] = 18,
    [64] = 18, [76] = 18, [217] = 18, [72] = 18,
    [111817] = 18, [74] = 18, [1809] = 18, [71] = 18,
    [1819] = 18, [70] = 18, [379] = 18,
    
    --Germany Teams--
    [21] = 21, [22] = 21, [25] = 21, [32] = 21, [38] = 21, [23] = 21,
    [1824] = 21, [112172] = 21, [175] = 21, [36] = 21,
    [10029] = 21, [31] = 21, [169] = 21, [171] = 21,
    [34] = 21, [110636] = 21, [166] = 21,
    
    --Netherlands
    [245] = 34, [246] = 34, [247] = 34, [1903] = 34,
    
    --Italy Teams--
    [45] = 27, [48] = 27, [50] = 27, [52] = 27, [54] = 27,
    [189] = 27, [206] = 27, [1745] = 27, [1842] = 27,
    [110374] = 27, [110556] = 27, [111434] = 27,
    [115841] = 27, [115845] = 27, [131681] = 27,
    [131682] = 27,
    
    --Scotland
    [78] = 42, [80] = 42, [86] = 42,

    --Spain Teams--
    [240] = 45, [241] = 45, [243] = 45, [448] = 45, [450] = 45, [483] = 45,
    [481] = 45, [449] = 45, [457] = 45, [461] = 45, [1860] = 45,
    [110062] = 45, [472] = 45, [1861] = 45, [467] = 45, [462] = 45,
    [110832] = 45, [116325] = 45, [116326] = 45, [116327] = 45,
    [116328] = 45, [116336] = 45, [116337] = 45,

    --Argentina Teams--
    [1013] = 52, [1876] = 52, [1877] = 52, [101083] = 52, [101085] = 52,
    [110395] = 52, [110580] = 52, [111715] = 52, [113044] = 52,

    --Brazil Teams--
    [383] = 54, [517] = 54, [568] = 54, [569] = 54, [598] = 54, [1035] = 54,
    [1041] = 54, [1043] = 54, [1053] = 54, [1629] = 54, [130361] = 54,
    [567] = 54, [1048] = 54, [111052] = 54, [111050] = 54, [111057] = 54,
    [1598] = 54, [112472] = 54,
    
    --Bolívia
    [110968] = 53, [131795] = 53, [112667] = 53,
    
    --Chile
    [15029] = 55, [110975] = 55, [112531] = 55, [111328] = 55,
    
    --Colombia
    [101099] = 56, [101100] = 56, [112992] = 56,
    
    --Equador
    [110981] = 57, [110986] = 57, [114581] = 57, [114615] = 57,
    
    --Paraguay
    [101108] = 58, [111006] = 58, [111008] = 58, [112716] = 58, 
    
    --Peru
    [111011] = 59, [111014] = 59, [114598] = 59,
    
    --Uruguay
    [101110] = 60, [111329] = 60, [115536] = 60, [112868] = 60,
    
    --Venezuela
    [114611] = 61, [110991] = 61, [110989] = 61,
    
    --Other Teams--
    [191] = 4, [209] = 4, [113888] = 5, [231] = 7, [673] = 7, [2014] = 7, [211] = 10,
    [100135] = 11, [266] = 12, [110468] = 12, [819] = 13, [1516] = 13, [280] = 22,
    [393] = 22, [1884] = 22, [1874] = 23, [100632] = 34, [918] = 36, [919] = 36,
    [234] = 38, [236] = 38, [237] = 38, [1896] = 38, [100761] = 39, [320] = 46,
    [896] = 47, [900] = 47, [325] = 48, [326] = 48, [101059] = 49, [1032] = 83,
    [110147] = 83, [111144] = 95, [112893] = 95, [112996] = 95, [112540] = 155,
    [1473] = 167, [605] = 183, [112139] = 183, [111701] = 190, [131739] = 195,
    
    --National Teams--
    [974] = 75, [1318] = 75, [1322] = 75, [1325] = 75, [1328] = 75,
    [1330] = 75, [1331] = 75, [1335] = 75, [1337] = 75, [1352] = 75,
    [1354] = 75, [1359] = 75, [1362] = 75, [1363] = 75, [1364] = 75,
    [1365] = 75, [1369] = 75, [1370] = 75, [1375] = 75, [1377] = 75,
    [1386] = 75, [1387] = 75, [1391] = 75, [1411] = 75, [1415] = 75,
    [1667] = 75, [105013] = 75, [105035] = 75, [111099] = 75,
    [111108] = 75, [111109] = 75, [111111] = 75, [111112] = 75,
    [111114] = 75, [111115] = 75, [111130] = 75, [111448] = 75,
    [111451] = 75, [111455] = 75, [111459] = 75, [111456] = 75,
    [111462] = 75, [111465] = 75, [111473] = 75, [111475] = 75,
    [111485] = 75, [111487] = 75, [111512] = 75, [111513] = 75,
    [111527] = 75, [111545] = 75, [112048] = 75, [112054] = 75,
}

local function getFlagIdByTeamId(teamId)
    return teamToCountryMap[teamId] or 0
end

GroupStandings = GroupStandings or {}
QuickTourGrouping = QuickTourGrouping or {}
currentTourInfo = currentTourInfo or {}
currentTourData = currentTourData or {}
TeamPlayerCache = TeamPlayerCache or {}
TournamentStats = TournamentStats or {}
GroupStageTeams = GroupStageTeams or {}
LeagueStandings = LeagueStandings or {}
GOALS = GOALS or {}

-- Banco de Dados de Times por Torneio
local TeamDatabase = {
    -- Tour 1
    [1] = {
        73, 243, 10, 21, 9, 44, 5, 22, 241, 1, 32, 240, 234, 39, 483, 45, 1824, 231, 18, 247, 245, 48, 237, 280, 266, 918, 219, 819, 69, 325, 2014, 113888, 448, 13, 111282, 110919,
    },
    -- Tour 2
    [2] = {
1386, 111099, 974, 1330, 111455, 105013, 111527, 1364, 1370, 111111, 112048, 1359, 1387, 1375, 1415, 1365, 1337, 112054, 111112, 111465, 105035, 1411, 1363, 1391,1354, 1325, 111130, 1369, 111473, 1362, 111456, 111114, 1377, 1335, 1667, 111512, 1352, 111448, 1322, 111513, 111545, 111485, 111109, 1318, 1328, 111462, 111475, 111510
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
        13, 1925, 14, 110, 18, 19, 5, 2, 10, 144, 1, 11, 1799, 1943, 1808, 7, 9, 8, 1796, 106, 15, 97, 1800, 1919, 109, 1960, 1952, 1807, 1794, 1806, 12, 3, 1795, 1792, 1951, 1790, 91,
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
        126990, 5, 10, 243, 44, 45, 21, 22, 73, 236, 234, 240, 191, 383, 1043, 567, 517, 1876, 1877, 1032, 111144, 110147, 112996, 605, 111575, 1473, 111701, 150735, 111499, 110935, 112893, 241, 9, 1
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
        111674,112098,112631,111731,130188,111629,130480,130478,155614,155611,129096,129082,129075,155612,155600,155603,129098,115623,130098,129095,130293,130291,150634,150639,150636,150637,112390,112883,130278,111658,150722,130578,1478
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
        605, 112094, 130184, 130185, 112139, 112090, 111836, 130025, 607, 101142, 130028, 112234, 112387, 111733, 111701, 112098, 111575, 150602, 111768, 115650, 111730, 150600, 116361, 982, 101151, 115618, 111724, 1474, 101146, 1473, 1477, 112540
    },
    -- Tour 25
    [25] = {
        1369, 1370, 1377, 111459, 1375, 111108, 111109, 111465, 111487, 111451, 1386, 1387, 111455, 1383, 111475, 111481, 111548, 111546, 112048, 112054, 112060, 1411, 111527, 974, 1415, 111114, 111111, 1362, 1354, 1393, 1667, 1395, 111462, 111115
    },
    -- Tour 26
    [26] = {
        111112, 1393, 1667, 1395, 111462, 111448, 111130, 111111, 1391, 111550, 111453, 111545, 111099, 111489, 111463, 111456, 111449, 111472, 112044, 112062, 111461, 111483, 111450, 112049
    },
    -- Tour 27
    [27] = {
        111533, 111488, 111510, 111518, 111526, 111528, 111521, 1415
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
        110961,101142,110962,130025,112099,112094,112100,130180,111727,130185,113146,112812,112139,112393,130026,113298,111768,114604,129054,150637,112093,150631,130288,130181,111736,115616,111640,155602,1474,150602,115650,111637

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
        111114, 1411, 974, 111549, 1413, 111510, 111533, 111488, 111518, 111466, 111485, 111514, 111532, 111115, 111512, 111513, 111536, 111527, 111523, 111391, 111525, 111530, 111516, 111392
    },
    -- Tour 35
    [35] = {
        131140, 113007, 112998,113997, 113006,113012, 113002, 115362, 113011, 113009, 113003, 113991, 113008, 113998, 131139, 131144

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
  112387,112675
    },
  -- 2235
   [2235] = {
 155600, 155601,155602,155603, 155604, 155605, 155606, 155607, 155610, 155611, 155612, 155614, 155615, 155616, 155617, 155618, 155620, 155621,
},
-- Women's League EPL
    [366] = {
        116009,116010,116011,116012,116013,116014,116015,116016,116017,116020,116343,122176,
    },

    -- Women's La Liga
    [377] = {
        116325,116326,116327,116328,116331,116332,116333,116334,116336,116337,121123,121125,121391,121720,121733,122629,
    },

    -- Women's Bundesliga
    [388] = {
        115995,115996,115997,115998,115999,116001,116002,116003,116004,116005,116021,121386,122533,122589,
    },

    -- Women's Ligue 1
    [399] = {
        116033,116034,116035,116036,116037,116038,116039,116040,116041,116042,116044,116386,116416,116417,121724,122370,122588,
    },

    -- Eredivisie
    [400] = {
        245,246,247,634,647,650,1903,1906,1907,1908,1910,1913,1914,1915,1971,100632,100638,100646,
    },

    -- Primeira Liga
    [411] = {
        234,236,237,717,718,744,1438,1887,1888,1891,1896,1900,10020,112513,112516,112809,114510,121463,
    },

    -- English Premier League
    [133] = {
        1,2,5,7,8,9,10,11,13,14,18,94,106,144,1799,1800,1808,1925,1943,1952
    },

    -- La Liga
    [533] = {
        240,241,242,243,448,449,450,452,456,457,461,463,468,479,480,481,483,573,1853,1860,
    },

    -- Serie A
    [311] = {
        39,44,45,46,47,48,50,52,54,55,189,205,347,1745,1842,110374,110556,111657,111811,111974,
    },

    -- Bundesliga
    [199] = {
        21,22,23,25,28,31,32,34,36,38,169,580,1824,1831,10029,10030,100409,112172,
    },

    -- Ligue 1
    [166] = {
        57,64,65,66,69,72,73,74,76,217,219,294,378,1530,1738,1739,1809,111817,
    },

    -- Saudi League
    [350] = {
        605,607,111674,112096,112139,112387,112390,112391,112393,112883,113037,113057,113060,113217,113222,115892,121735,121798,
    },

    -- BRI Super League
    [2235] = {
        155600,155601,155602,155603,155604,155606,155607,155609,155611,155612,155614,155615,155617,155621,155624,155630,155634,155640,
    },

    -- Liga Pegadaian
    [2254] = {
        155605,155610,155613,155616,155618,155620,155622,155623,155625,155631,155632,155633,155635,155637,155638,155639,155641,155642,155643,155619,
    },

    -- Women's USWL
    [644] = {
        116300,116302,116303,116304,116305,116306,116307,116308,116309,116310,116311,116312,121477,121478,
    },

    -- Efl Championsip
    [144] = {
        3,12,15,17,19,88,89,91,95,97,109,110,1790,1792,1794,1795,1796,1801,1806,1807,1919,11,1951,1960,
    },
    -- Liga Suganda
    [544] = {
        244,453,459,462,467,472,1854,1861,1867,1894,1968,10846,15012,100852,100888,110062,110069,110711,110827,110832,110839,114554,
    },

    -- SERIE B
    [322] = {
        200,206,1744,1746,1837,1843,1848,2038,110738,110740,110741,110908,110912,110915,111433,111434,112124,112493,112494,113147,
    },

    -- BUNDESLIGA 2
    [200] = {
        29,159,160,165,166,171,175,485,503,531,576,1832,110329,110500,110502,110588,110636,111235,
    },

    -- LIGUE 2
    [177] = {
        58,62,67,68,70,71,210,379,614,1805,1814,1815,1816,1819,1823,110321,111273,111276,111659,115494,122680, }
    }

local TeamList, TeamListData = {}, {}

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
    
    local potentialTeams = TeamDatabase[tourId] or TeamDatabase[1]
    local uniqueTeams = removeDuplicates(potentialTeams)
    
    TeamList = {}
    for i = 1, math.min(teamCount, #uniqueTeams) do
        table.insert(TeamList, uniqueTeams[i])
    end
    print(string.format(" Tournament team list created: %d teams for Tour ID %d", #TeamList, tourId))
end

local function InitializeTournamentStats(tourId)
    if not TournamentStats[tourId] then
        TournamentStats[tourId] = {
            Goals = {},
            Assists = {},
            YellowCards = {},
            RedCards = {},
            Appearances = {}
        }
    end
end

local function distributeMatchdaysBalanced(groupSchedules, totalGroups, teamCount)
    local fixtureList = {}
    
    local isTwoLegs = GlobalTournamentSettings and GlobalTournamentSettings.isTwoLegs or false
    
    print(string.format(" Creating synchronized distribution: %d teams", teamCount))
    
    local shuffledGroupSchedules = {}
    for gIndex = 1, totalGroups do
        shuffledGroupSchedules[gIndex] = {}
        
        for _, matchPair in ipairs(groupSchedules[gIndex]) do
            table.insert(shuffledGroupSchedules[gIndex], matchPair)
        end
        
        for i = #shuffledGroupSchedules[gIndex], 2, -1 do
            local j = math.random(i)
            shuffledGroupSchedules[gIndex][i], shuffledGroupSchedules[gIndex][j] = 
                shuffledGroupSchedules[gIndex][j], shuffledGroupSchedules[gIndex][i]
        end
    end
    
    local usedMatchesByGroup = {}
    for gIndex = 1, totalGroups do
        usedMatchesByGroup[gIndex] = {}
    end
    
    local matchesPerGroup = #shuffledGroupSchedules[1]
    local confrontosPerMatchday = 2
    local matchdaysPerGroupCalculated = math.ceil(matchesPerGroup / confrontosPerMatchday)
    
    for globalMatchday = 1, matchdaysPerGroupCalculated do
        
        local totalMatchesThisRound = 0
        
        for gIndex = 1, totalGroups do
            local schedule = shuffledGroupSchedules[gIndex]
            local groupLetter = string.char(64 + gIndex)
            
            local selectedMatches = {}
            local usedTeamsThisMatchday = {}
            
            for idx = 1, #schedule do
                if #selectedMatches < confrontosPerMatchday then
                    local match = schedule[idx]
                    local teamA, teamB = match[1], match[2]
                    
                    local matchAlreadyUsed = false
                    for _, usedIdx in ipairs(usedMatchesByGroup[gIndex]) do
                        if usedIdx == idx then
                            matchAlreadyUsed = true
                            break
                        end
                    end
                    
                    local teamAlreadyPlaying = usedTeamsThisMatchday[teamA] or usedTeamsThisMatchday[teamB]
                    local isValidMatch = (teamA ~= teamB)
                    
                    if not matchAlreadyUsed and not teamAlreadyPlaying and isValidMatch then
                        table.insert(selectedMatches, {idx = idx, match = match})
                        table.insert(usedMatchesByGroup[gIndex], idx)
                        usedTeamsThisMatchday[teamA] = true
                        usedTeamsThisMatchday[teamB] = true
                    end
                end
            end
            
            if #selectedMatches < confrontosPerMatchday then
                for idx = 1, #schedule do
                    if #selectedMatches < confrontosPerMatchday then
                        local match = schedule[idx]
                        local teamA, teamB = match[1], match[2]
                        
                        local matchAlreadyUsed = false
                        for _, usedIdx in ipairs(usedMatchesByGroup[gIndex]) do
                            if usedIdx == idx then
                                matchAlreadyUsed = true
                                break
                            end
                        end
                        
                        if not matchAlreadyUsed and teamA ~= teamB then
                            table.insert(selectedMatches, {idx = idx, match = match})
                            table.insert(usedMatchesByGroup[gIndex], idx)
                        end
                    end
                end
            end
            
            for _, selected in ipairs(selectedMatches) do
                local matchPair = selected.match
                local teamA, teamB = matchPair[1], matchPair[2]
                
                if teamA ~= teamB then
                    table.insert(fixtureList, {
                        teamA, teamB,
                        0, 0,
                        false,
                        0,
                        false,
                        true,
                        groupLetter,
                        globalMatchday
                    })
                    totalMatchesThisRound = totalMatchesThisRound + 1
                end
            end
        end
    end
    
    return fixtureList
end

local function createLeagueFixtures(teamList)
    local fixtureList = {}
    if not teamList or #teamList < 2 then return fixtureList end
    
    local workingTeams = {}
    for _, id in ipairs(teamList) do table.insert(workingTeams, id) end
    
    local numTeams = #workingTeams
    if numTeams % 2 ~= 0 then
        table.insert(workingTeams, -1)
        numTeams = numTeams + 1
    end
    
    local rounds = numTeams - 1
    local half = numTeams / 2
    
    local settings = GlobalTournamentSettings or {}
    local isTwoLegs = settings.isTwoLegs or false
    
    local secondHalfFixtures = {}
    
    -- Putaran Pertama dengan rotasi Home/Away agar adil per matchday
    for md = 1, rounds do
        for i = 1, half do
            local home = workingTeams[i]
            local away = workingTeams[numTeams - i + 1]
            
            if home and away and home ~= -1 and away ~= -1 then
                -- Tukar posisi home/away secara bergantian tiap matchday agar tidak kandang terus
                if md % 2 == 0 then
                    home, away = away, home
                end
                
                table.insert(fixtureList, {
                    home, away, 0, 0, false, 0, false, true, "LEAGUE", md
                })
                
                if isTwoLegs then
                    table.insert(secondHalfFixtures, {
                        away, home, 0, 0, false, 0, false, true, "LEAGUE", md + rounds
                    })
                end
            end
        end
        
        local fixed = workingTeams[1]
        local shifted = table.remove(workingTeams, numTeams)
        table.insert(workingTeams, 2, shifted)
        workingTeams[1] = fixed
    end
    
    if isTwoLegs then
        for _, match in ipairs(secondHalfFixtures) do
            table.insert(fixtureList, match)
        end
    end
    
    return fixtureList
end


function TeamSelect:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.im = init.im
    o.nav = init.nav
    o.loc = init.loc
    o.api = init.api
    
    local tourId = GlobalTournamentSettings.tourId or 1
    o.tourData = {
        name = tourIdToNameMap[tourId] or tourIdToNameMap.default,
        color = tourIdToColorMap[tourId] or tourIdToColorMap.default,
        colorTab = tourIdToColorTabMap[tourId] or tourIdToColorTabMap.default,
        referee = tourIdToRefereeNameMap[tourId] or tourIdToRefereeNameMap.default,
        tourId = tourId,
        tourBg = { name = "$Bg_Cup", id = tourId },
        tourlogo = { name = "$CustomLogo", id = tourId },
        trophy = { name = "$CustomTrophy", id = tourId }
    }
    
    o.services = {
        SquadManagementService = o.api("SquadMgtService"),
        AudioService = o.api("AudioService")
    }
    o.visible = false
    o.currentSelectedIdx = 1
    o.swapSourceIdx = nil
    
    o.im.Publish(BND_CUP_NAME, o.tourData.name)
    o.im.Publish(BND_CUP_COLOR, o.tourData.color)
    o.im.Publish(BND_CUP_COLOR_TAB, o.tourData.colorTab)
    o.im.Publish("bnd_referee_name", o.tourData.referee)
    o.im.Publish(BND_CUP_BG, o.tourData.tourBg)
    o.im.Publish(BND_CUP_LOGO, o.tourData.tourlogo)
    o.im.Publish(BND_TROPHY, o.tourData.trophy)
    
    GlobalTourData = o.tourData
    
    o.im.Subscribe("bnd_visible", function() o:publishVisible() end)
    o.im.Subscribe("bnd_loading_visible", function() o:publishVisible() end)

    o.im.Subscribe(BND_CUP_BG, function()
        o.im.Publish(BND_CUP_BG, o.tourData.tourBg)
    end)
    
    o.im.Subscribe(BND_CUP_LOGO, function()
        o.im.Publish(BND_CUP_LOGO, o.tourData.tourlogo)
    end)
    
    o.im.Subscribe(BND_CUP_NAME, function()
        o.im.Publish(BND_CUP_NAME, o.tourData.name)
    end)
    
    o.im.Subscribe(BND_CUP_COLOR, function()
        o.im.Publish(BND_CUP_COLOR, o.tourData.color)
    end)
    
    o.im.Subscribe(BND_CUP_COLOR_TAB, function()
        o.im.Publish(BND_CUP_COLOR_TAB, o.tourData.colorTab)
    end)

    GroupStandings[tourId] = GroupStandings[tourId] or {}
    QuickTourGrouping[tourId] = QuickTourGrouping[tourId] or {}
    LeagueStandings[tourId] = LeagueStandings[tourId] or {}

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
        
        o:setupDynamicActions()
        
        if TeamListData[1] then
            o:updateTeamVisualsByIndex(1)
        end
    end
    
    print(" TeamSelect initialized for Tour: " .. o.tourData.name)
    
    return o
end

function TeamSelect:updateTeamVisualsByIndex(idx)
    if TeamListData[idx] then
        local team = TeamListData[idx]
        local teamId = team.assetId
        
        local settings = GlobalTournamentSettings or {}
        local tourId = settings.tourId or 1
        local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
        
        self.im.Publish(BND_TEAM_CREST, { name = crestName, id = teamId })
        
        local flagId = getFlagIdByTeamId(teamId)
        self.im.Publish(BND_TEAM_FLAG, { name = "$Flag128x128", id = flagId })
        
        local localizedName = self.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
        self.im.Publish(BND_TEAM_NAME, localizedName)

        self.im.Publish(BND_TEAM_KIT_HOME, { name = "$HomeKit", id = teamId })
        self.im.Publish(BND_TEAM_KIT_AWAY, { name = "$AwayKit", id = teamId })
         self.im.Publish(BND_TEAM_GK_KIT, { name = "$GkKit", id = teamId })  

        self.im.Publish(BND_TEAM_OVERALL, team.rating or 0)

        self.im.Publish(BND_TEAM_RATING, {
            attackValue = team.offense or 0,
            middleValue = team.midfield or 0,
            defenseValue = team.defense or 0,
            attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
            middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
            defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
        })

        self.im.Publish(BND_TEAM_STAR_RATING, team.starRating or 0)

        local isLeagueMode = settings.isLeagueMode or false
        
        if isLeagueMode then
            self.im.Publish(BND_GROUP_NAME, "LEAGUE")
        else
            local teamsPerGroup = settings.teamsPerGroup or 4
            local groupIndex = math.ceil(idx / teamsPerGroup)
            local groupLetter = string.char(64 + groupIndex)
            self.im.Publish(BND_GROUP_NAME, "Group " .. groupLetter)
        end
    end
end

function TeamSelect:setupDynamicActions()
    local teamCount = #TeamList
    
    self.im.RegisterAction(ACT_TEAM_SELECT, function(_, data)
       if data then self:StartQuickTour(data) end
    end)

    self.im.RegisterAction(ACT_SELECT_TEAM, function(_, data)
        local tourData = {
            id = self.currentSelectedIdx - 1
        }
        self:StartQuickTour(tourData)
    end)

    self.im.RegisterAction(ACT_RANDOM_TEAMS, function()
        self.services.AudioService.PlaySoundById("act_home_kit_next", "root", {
            soundId = "", type = "", state = { name = "VALID", val = 0 }
        })
        self:RandomizeTeams()
    end)

    self.im.RegisterAction(ACT_CHANGE_TEAM, function()
        if self.swapSourceIdx == nil then
            self.services.AudioService.PlaySoundById("act_move_to_club", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })
            
            self.swapSourceIdx = self.currentSelectedIdx
            
            for i = 1, 48 do
                if not TeamListData[i] then
                    self.im.Publish(BND_VISIBLE_TABS[i], false)
                else
                    local isVisible = (i == self.currentSelectedIdx) or (i == self.swapSourceIdx)
                    self.im.Publish(BND_VISIBLE_TABS[i], isVisible)
                end
            end
            
        else
            self.services.AudioService.PlaySoundById("act_home_kit_next", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })

            local source = self.swapSourceIdx
            local target = self.currentSelectedIdx

            if source ~= target then
                local tempId = TeamList[source]
                TeamList[source] = TeamList[target]
                TeamList[target] = tempId

                self:Init()
                self:InitGrouping()
                self:publishTeamRows()

                for i = 1, teamCount do
                    if TeamListData[i] then
                        local tId = TeamListData[i].assetId
                        local settings = GlobalTournamentSettings or {}
                        local tourId = settings.tourId or 1
                        local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
                        
                        self.im.Publish(BND_TEAM_LOGOS[i], { name = crestName, id = tId })
                        self.im.Publish(BND_TEAM_NAMES[i], self.loc.LocalizeString("TeamName_Abbr15_" .. tId))
                    end
                end
                
                self:updateTeamVisualsByIndex(target)
            end
            
            self.swapSourceIdx = nil
            
            for i = 1, 48 do
                if not TeamListData[i] then
                    self.im.Publish(BND_VISIBLE_TABS[i], false)
                else
                    local isVisible = (i == self.currentSelectedIdx)
                    self.im.Publish(BND_VISIBLE_TABS[i], isVisible)
                end
            end
        end
    end)

    for i = 1, teamCount do
        self.im.RegisterAction(ACT_TABS[i], function()
            self.services.AudioService.PlaySoundById("act_move_to_club", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })
            self.currentSelectedIdx = i
            self:updateTeamVisualsByIndex(i)
            
            for j = 1, 48 do
                if not TeamListData[j] then
                    self.im.Publish(BND_VISIBLE_TABS[j], false)
                else
                    local isVisible = (j == i) or (j == self.swapSourceIdx)
                    self.im.Publish(BND_VISIBLE_TABS[j], isVisible)
                end
            end
        end)
    end

    for i = 1, 48 do
        self.im.Subscribe(BND_TEAM_LOGOS[i], function()
            if TeamListData[i] then
                local settings = GlobalTournamentSettings or {}
                local tourId = settings.tourId or 1
                local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
                
                self.im.Publish(BND_TEAM_LOGOS[i], { name = crestName, id = TeamListData[i].assetId })
            end
        end)
    end

    for i = 1, 48 do
        self.im.Subscribe(BND_TEAM_NAMES[i], function()
            if TeamListData[i] then
                local teamId = TeamListData[i].assetId
                local name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
                self.im.Publish(BND_TEAM_NAMES[i], name)
            end
        end)
    end

    for i = 1, 48 do
        self.im.Subscribe(BND_VISIBLE_TABS[i], function()
            if not TeamListData[i] then
                self.im.Publish(BND_VISIBLE_TABS[i], false)
                return
            end
            
            local isVisible = (i == self.currentSelectedIdx) or (i == self.swapSourceIdx)
            self.im.Publish(BND_VISIBLE_TABS[i], isVisible)
        end)
    end

    self.im.Subscribe(BND_TEAM_RATING, function() 
        if TeamListData[1] then self:updateTeamVisualsByIndex(1) end 
    end)
    
    self.im.Subscribe(BND_TEAM_OVERALL, function()
        if TeamListData[1] then 
            self.im.Publish(BND_TEAM_OVERALL, TeamListData[1].rating or 0) 
        end
    end)
    
    self.im.Subscribe(BND_TEAM_STAR_RATING, function()
        if TeamListData[1] then 
            self.im.Publish(BND_TEAM_STAR_RATING, TeamListData[1].starRating or 0) 
        end
    end)
    
    self.im.Subscribe(BND_GROUP_NAME, function()
        local settings = GlobalTournamentSettings or {}
        local isLeagueMode = settings.isLeagueMode or false
        if isLeagueMode then
            self.im.Publish(BND_GROUP_NAME, "LEAGUE")
        else
            local teamsPerGroup = settings.teamsPerGroup or 4
            local groupIndex = math.ceil(1 / teamsPerGroup)
            self.im.Publish(BND_GROUP_NAME, "Group " .. string.char(64 + groupIndex))
        end
    end)
    
    self.im.Subscribe(BND_TEAM_CREST, function()
        if TeamListData[1] then 
            local settings = GlobalTournamentSettings or {}
            local tourId = settings.tourId or 1
            local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
            
            self.im.Publish(BND_TEAM_CREST, { name = crestName, id = TeamListData[1].assetId }) 
        end
    end)
    
    self.im.Subscribe(BND_TEAM_NAME, function()
        if TeamListData[1] then
            local initialName = self.loc.LocalizeString("TeamName_Abbr15_" .. TeamListData[1].assetId)
            self.im.Publish(BND_TEAM_NAME, initialName)
        end
    end)
    
    self.im.Subscribe(BND_TEAM_KIT_HOME, function()
        if TeamListData[1] then 
            self.im.Publish(BND_TEAM_KIT_HOME, { name = "$HomeKit", id = TeamListData[1].assetId }) 
        end
    end)
    
    self.im.Subscribe(BND_TEAM_KIT_AWAY, function()
        if TeamListData[1] then 
            self.im.Publish(BND_TEAM_KIT_AWAY, { name = "$AwayKit", id = TeamListData[1].assetId }) 
        end
    end)
    self.im.Subscribe(BND_TEAM_GK_KIT, function()
        if TeamListData[1] then self.im.Publish(BND_TEAM_GK_KIT, { name = "$GkKit", id = TeamListData[1].assetId }) end
    end)    
    
    self.im.Subscribe(BND_TEAM_FLAG, function()
        if TeamListData[1] then
            local teamId = TeamListData[1].assetId
            local flagId = getFlagIdByTeamId(teamId)
            self.im.Publish(BND_TEAM_FLAG, { name = "$Flag128x128", id = flagId })
        end
    end)
end

function TeamSelect:publishVisible()
    self.im.Publish("bnd_visible", self.visible)
    self.im.Publish("bnd_loading_visible", not self.visible)
end

function TeamSelect:publishTeamRows()
    local settings = GlobalTournamentSettings or {}
    local tourId = settings.tourId or 1
    local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
    
    for _, team in ipairs(TeamListData) do
        team.data = {
            TeamCrest = { name = crestName, id = team.assetId },
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
        local ratingPuluhan = info.overall or info.starRating or 0
        
        if ratingPuluhan > 99 then ratingPuluhan = 99 end

        table.insert(TeamListData, {
            assetId = id,
            clickAction = ACT_TEAM_SELECT,
            teamName = self.loc.LocalizeString("TeamName_Abbr15_" .. id),
            shortTeamName = self.loc.LocalizeString("TeamName_Abbr3_" .. id),
            rating = ratingPuluhan,
            starRating = starRating,
            offense = info.offense or 70,
            midfield = info.midfield or 70,
            defense = info.defense or 70,
            data = {}
        })
    end
end

function TeamSelect:InitGrouping()
    local tourId = GlobalTournamentSettings.tourId or 1
    local teamCount = #TeamList
    local settings = GlobalTournamentSettings or {}
    local totalGroups = settings.totalGroups or math.ceil(teamCount / 4)
    local teamsPerGroup = settings.teamsPerGroup or 4
    local isKnockoutOnly = settings.isKnockoutOnly or false
    local isLeagueMode = settings.isLeagueMode or false
    
    local isTwoLegs = settings.isTwoLegs or false

    local isGroupStage = not isKnockoutOnly and not isLeagueMode and (teamCount >= 8)

    currentTourInfo[tourId] = {
        tourIndex = tourId,
        homeID = 0,
        stage = isLeagueMode and "LEAGUE" or (isGroupStage and "GROUP" or "KNOCKOUT"),
        isKnockoutOnly = isKnockoutOnly,
        isLeagueMode = isLeagueMode,
        totalMatches = 0
    }

    if isLeagueMode then
        local fixtureList = createLeagueFixtures(TeamList)
        
        LeagueStandings[tourId] = {}
        for _, teamId in ipairs(TeamList) do
            LeagueStandings[tourId][teamId] = {
                teamId = teamId, played = 0, wins = 0, draws = 0, losses = 0,
                goalsFor = 0, goalsAgainst = 0, points = 0
            }
        end
        
        QuickTourGrouping[tourId] = fixtureList
        GroupStageTeams[tourId] = {}
        currentTourInfo[tourId].totalLeagueMatches = #fixtureList
        
    elseif isGroupStage then
        
        local groupList = {}
        for g = 1, totalGroups do
            groupList[g] = {}
            for i = 1, teamsPerGroup do
                local index = (g - 1) * teamsPerGroup + i
                if TeamList[index] then
                    table.insert(groupList[g], TeamList[index])
                end
            end
        end

        local groupSchedules = {}
        for gIndex, group in ipairs(groupList) do
            local schedule = {}            
            if isTwoLegs then
                for i = 1, #group do
                    for j = i + 1, #group do
                        table.insert(schedule, {group[i], group[j]})
                    end
                end                
   
                for i = 1, #group do
                    for j = i + 1, #group do
                        table.insert(schedule, {group[j], group[i]})
                    end
                end
            else
                for i = 1, #group do
                    for j = i + 1, #group do
                        table.insert(schedule, {group[i], group[j]})
                    end
                end
            end
            
            groupSchedules[gIndex] = schedule
        end
        
        local fixtureList = distributeMatchdaysBalanced(groupSchedules, totalGroups, teamCount)

        GroupStageTeams[tourId] = groupList
        QuickTourGrouping[tourId] = fixtureList
        currentTourInfo[tourId].totalGroupMatches = #fixtureList
        
    else

        local fixtureList = {}
        local shuffledTeams = {}
        for _, team in ipairs(TeamList) do
            table.insert(shuffledTeams, team)
        end
        for i = #shuffledTeams, 2, -1 do
            local j = math.random(i)
            shuffledTeams[i], shuffledTeams[j] = shuffledTeams[j], shuffledTeams[i]
        end
        
        local roundName = "Quarter-Finals"
        if teamCount == 8 then 
            roundName = "Quarter-Finals"
        elseif teamCount == 16 then 
            roundName = "Round of 16"
        elseif teamCount == 32 then 
            roundName = "Round of 32"
        end

        for i = 1, teamCount/2 do
            table.insert(fixtureList, {
                shuffledTeams[i], shuffledTeams[teamCount-i+1],
                0, 0, false, 0, true, false, roundName, 1
            })
            
            if isTwoLegs then
                table.insert(fixtureList, {
                    shuffledTeams[teamCount-i+1], shuffledTeams[i],
                    0, 0, false, 0, true, false, roundName, 2
                })
            end
        end
        
        QuickTourGrouping[tourId] = fixtureList
        GroupStageTeams[tourId] = {}
        currentTourInfo[tourId].stage = "KNOCKOUT"
    end
end

function TeamSelect:RandomizeTeams()
    shuffleArray(TeamList)
    self:Init()
    self:InitGrouping()
    self:publishTeamRows()

    local teamCount = #TeamList
    self.currentSelectedIdx = 1
    
    local settings = GlobalTournamentSettings or {}
    local tourId = settings.tourId or 1
    local crestName = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"
    
    for i = 1, 48 do
        if TeamListData[i] then
            local tId = TeamListData[i].assetId
            
            self.im.Publish(BND_TEAM_LOGOS[i], { 
                name = crestName, 
                id = tId 
            })

            local localizedName = self.loc.LocalizeString("TeamName_Abbr15_" .. tId)
            self.im.Publish(BND_TEAM_NAMES[i], localizedName)
            
            self.im.Publish(BND_VISIBLE_TABS[i], i == 1)
        else
            self.im.Publish(BND_VISIBLE_TABS[i], false)
        end
    end

    if TeamListData[1] then
        local team = TeamListData[1]
        local teamId = team.assetId
        
        self.im.Publish(BND_TEAM_CREST, { 
            name = crestName, 
            id = teamId 
        })
        
        local flagId = getFlagIdByTeamId(teamId)
        self.im.Publish(BND_TEAM_FLAG, { name = "$Flag128x128", id = flagId })
        
        local mainName = self.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
        self.im.Publish(BND_TEAM_NAME, mainName)

        self.im.Publish(BND_TEAM_KIT_HOME, { 
            name = "$HomeKit", 
            id = teamId 
        })
        self.im.Publish(BND_TEAM_KIT_AWAY, { 
            name = "$AwayKit", 
            id = teamId 
        })
        self.im.Publish(BND_TEAM_GK_KIT, { 
            name = "$GkKit", 
            id = teamId 
        })        

        local isLeagueMode = settings.isLeagueMode or false
        
        if isLeagueMode then
            self.im.Publish(BND_GROUP_NAME, "LEAGUE")
        else
            local teamsPerGroup = settings.teamsPerGroup or 4
            local groupIndex = math.ceil(1 / teamsPerGroup)
            self.im.Publish(BND_GROUP_NAME, "Group " .. string.char(64 + groupIndex))
        end

        self.im.Publish(BND_TEAM_OVERALL, team.rating or 0)

        self.im.Publish(BND_TEAM_RATING, {
            attackValue = team.offense or 0,
            middleValue = team.midfield or 0,
            defenseValue = team.defense or 0,
            attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
            middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
            defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
        })

        self.im.Publish(BND_TEAM_STAR_RATING, team.starRating or 0)
    end
end

function TeamSelect:StartQuickTour(data)
    local tourId = GlobalTournamentSettings.tourId or 1
    local teamIndex = data.id + 1
    
    if not TeamListData[teamIndex] then return end
    
    local selectedID = TeamListData[teamIndex].assetId
    local settings = GlobalTournamentSettings or {}
    local isKnockoutOnly = settings.isKnockoutOnly or false
    local isLeagueMode = settings.isLeagueMode or false
    
    currentTourInfo[tourId] = currentTourInfo[tourId] or {}
    currentTourInfo[tourId].homeID = selectedID
    currentTourInfo[tourId].referee = self.tourData.referee
    currentTourInfo[tourId].isKnockoutOnly = isKnockoutOnly
    currentTourInfo[tourId].isLeagueMode = isLeagueMode
    
    currentTourData = {
        matchIndex = 0,
        tourIndex = tourId,
        homeID = selectedID,
        awayID = 0
    }

    local isGroupStage = not isKnockoutOnly and not isLeagueMode and (#TeamList >= 8)
    currentTourInfo[tourId].stage = isGroupStage and "GROUP" or (isLeagueMode and "LEAGUE" or "KNOCKOUT")
    
    local popupTitle = isLeagueMode and "LEAGUE" or (isGroupStage and "GROUP STAGE" or "KNOCKOUT")
    local tournamentName = self.tourData.name
    local teamName = TeamListData[teamIndex].teamName
    
    local popupMessage
    if isLeagueMode then
        popupMessage = string.format(
            "%s, %s, LEAGUE\nReady To Begin?",
            tournamentName, teamName
        )
        currentTourInfo[tourId].groupIndex = 0
        currentTourInfo[tourId].groupLabel = "LEAGUE"
    elseif isGroupStage then
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
        
        currentTourInfo[tourId].groupIndex = groupLabel:sub(-1):byte() - 64
        currentTourInfo[tourId].groupLabel = groupLabel
        
        popupMessage = string.format(
            "%s, %s, %s\nReady To Begin?",
            tournamentName, teamName, groupLabel
        )
    else
        local tc = #TeamList
        local knockoutLabel = "Round of 16"
        if tc == 8 then knockoutLabel = "Quarter Finals"
        elseif tc == 16 then knockoutLabel = "Quarter-Finals"
        elseif tc == 24 or tc == 32 then knockoutLabel = "Round of 32"
        elseif tc >= 48 then knockoutLabel = "Round of 32" end

        
        currentTourInfo[tourId].groupIndex = 0
        currentTourInfo[tourId].groupLabel = knockoutLabel
        
        popupMessage = string.format(
            "%s, %s, %s\nReady To Begin Your KNOCKOUT Challenge?",
            tournamentName, teamName, currentTourInfo[tourId].groupLabel
        )
    end

    local popupData = {
        title = popupTitle,
        message = popupMessage,
        buttons = {
            { 
                icon = "$FooterIconNo", 
                label = "Cancel", 
                clickEvents = { "evt_hide_popup" } 
            },
            { 
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
    
    TeamPlayerCache[tourId] = TeamPlayerCache[tourId] or {}
 
    for i, teamID in ipairs(TeamList) do
        if not TeamPlayerCache[tourId][teamID] then
            local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)
            TeamPlayerCache[tourId][teamID] = players
        end
    end
    
    GOALS[tourId] = GOALS[tourId] or {}
end

function TeamSelect:finalize()
    local tourId = GlobalTournamentSettings.tourId or 1
    local teamCount = #TeamList
    
    self.im.Unsubscribe("bnd_visible")
    self.im.Unsubscribe("bnd_loading_visible")
    self.im.Unsubscribe(BND_TEAM_LIST)
    self.im.Unsubscribe(BND_CUP_LOGO)
    self.im.Unsubscribe(BND_CUP_COLOR)
    self.im.Unsubscribe(BND_CUP_COLOR_TAB)
    self.im.Unsubscribe(BND_CUP_LABEL)
    self.im.Unsubscribe(BND_CUP_BG)
    self.im.Unsubscribe(BND_TROPHY)
    self.im.Unsubscribe(BND_TEAM_CREST)
    self.im.Unsubscribe(BND_TEAM_NAME)
    self.im.Unsubscribe(BND_TEAM_KIT_HOME)
    self.im.Unsubscribe(BND_TEAM_KIT_AWAY)
    self.im.Unsubscribe(BND_TEAM_GK_KIT)     
    self.im.Unsubscribe(BND_TEAM_RATING)
    self.im.Unsubscribe(BND_TEAM_STAR_RATING)
    self.im.Unsubscribe(BND_TEAM_OVERALL)
    self.im.Unsubscribe(BND_GROUP_NAME)
    self.im.Unsubscribe(BND_TEAM_FLAG)
    self.im.Unsubscribe(BND_CUP_NAME)
    
    self.im.UnregisterAction(ACT_TEAM_SELECT)
    self.im.UnregisterAction(ACT_SELECT_TEAM)
    self.im.UnregisterAction(ACT_RANDOM_TEAMS)
    self.im.UnregisterAction(ACT_CHANGE_TEAM)
    
    for i = 1, 48 do
        self.im.Unsubscribe(BND_TEAM_LOGOS[i])
        self.im.Unsubscribe(BND_TEAM_NAMES[i])
        self.im.Unsubscribe(BND_VISIBLE_TABS[i])
        self.im.UnregisterAction(ACT_TABS[i])
    end
end

return TeamSelect
