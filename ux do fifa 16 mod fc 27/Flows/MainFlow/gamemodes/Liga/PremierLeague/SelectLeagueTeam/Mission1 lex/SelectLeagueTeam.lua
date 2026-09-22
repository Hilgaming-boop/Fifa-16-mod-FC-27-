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
local BND_TEAM_CREST_HOME_KIT = "bnd_team_crest_home_kit"
local BND_TEAM_CREST_AWAY_KIT = "bnd_team_crest_away_kit"
local BND_TEAM_CREST_INFO = "bnd_team_crest_info"
local BND_TEAM_CREST_STD = "bnd_team_crest_std"
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
local ACT_NEXT_TEAM = "act_nextteam"
local ACT_PREV_TEAM = "act_prevteam"
local ACT_NEXT_LEAGUE = "act_nextleague"
local ACT_PREV_LEAGUE = "act_prevleague"
local BND_CURRENT_LEAGUE_NAME = "bnd_current_league_name"
local BND_NATION_LEAGUE_NAME = "bnd_nation_league_name"
local BND_CURRENT_TEAM_NAME = "bnd_current_team_name"
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
currentMode = 2
currentSelectedLeagueID = nil
local BND_STADIUM_NAME = "bnd_stadium_name"
local BND_CLUB_WORTH = "bnd_club_worth"
local BND_TRANSFER_BUDGET = "bnd_transfer_budget"
local BND_TEAM_INFO = "bnd_team_info"
local BND_FINANCIAL = "bnd_financial"
local BND_FANBASE = "bnd_fanbase"
local BND_YOUTH = "bnd_youth"
local BND_CLUB_FOUNDED = "bnd_club_founded"
local TEAM_INFORMATION = {
    -- Premier League
-- Premier League
[1] = "13           14             0",
[2] = "7              8              1",
[5] = "6             17             2",
[7] = "9              5              0",
[9] = "19          13              6",
[10] = "10          6             1",
[11] = "20         12           3",
[13] = "4            6            0",
[14] = "1            4            2",
[17] = "0            1            0",
[18] = "2            8            0",
[19] = "0            3            0",
[94] = "1            1            1",
[95] = "1            1            0",
[110] = "3            4            0",
[144] = "0            0            0",
[1799] = "0            0            0",
[1808] = "0            0            0",
[1925] = "0            0            0",
[1943] = "0            0            0",

-- Ligue 1
[57] = "1            4            0",
[64] = "1            1            0",
[65] = "4            6            0",
[66] = "7            5            0",
[69] = "8            5            0",
[70] = "1            2            0",
[71] = "8            4            0",
[72] = "4            3            0",
[73] = "12            14            0",
[74] = "0            3            0",
[76] = "1            4            0",
[219] = "9            10            1",
[378] = "0            3            0",
[379] = "6            2            0",
[1530] = "0            1            0",
[1738] = "1            1            0",
[1809] = "0            1            0",
[1819] = "10            6            0",

-- Bundesliga
[21] = "32            20            6",
[22] = "8            5            1",
[23] = "5            3            0",
[25] = "0            1            0",
[32] = "1            1            0",
[36] = "5            3            0",
[38] = "4            6            1",
[160] = "0            1            0",
[169] = "0            1            0",
[175] = "1            1            0",
[576] = "0            0            0",
[1824] = "1            5            0",
[1831] = "0            1            0",
[10029] = "0            1            0",
[100409] = "0            1            0",
[110329] = "0            1            0",
[111235] = "0            0            0",
[112172] = "0            2            0",

-- Serie A
[44] = "0            6            0",
[46] = "7            7            0",
[47] = "1            1            0",
[48] = "0            0            0",
[50] = "2            6            0",
[52] = "9            1            0",
[53] = "19            9            3",
[54] = "36            14            2",
[55] = "2            7            0",
[56] = "19            5            7",
[61] = "3            6            0",
[63] = "3            9            0",
[67] = "7            5            0",
[68] = "0            0            0",
[81] = "1            3            0",
[1889] = "0            0            0",
[110988] = "0            0            0",
[111974] = "0            0            0",
[112260] = "0            1            0",
[112849] = "0            1            0",

-- LaLiga
[240] = "11            10            3",
[241] = "28            32            6",
[589] = "1            6            1",
[243] = "36            20            15",
[448] = "8            24            0",
[449] = "1            3            0",
[450] = "0            0            0",
[452] = "0            4            0",
[453] = "0            1            0",
[457] = "2            3            0",
[461] = "6            8            0",
[462] = "0            1            0",
[463] = "0            1            0",
[472] = "0            2            0",
[479] = "0            1            0",
[480] = "0            1            0",
[481] = "1            5            0",
[483] = "0            1            0",
[1860] = "0            0            0",
[100888] = "0            0            0",
[110062] = "0            0            0",
}

local CLUB_FOUNDED = {
[1] = "1886",
[2] = "1874",
[5] = "1905",
[7] = "1878",
[9] = "1892",
[10] = "1880",
[11] = "1878",
[13] = "1892",
[14] = "1865",
[17] = "1885",
[18] = "1882",
[19] = "1895",
[21] = "1900",
[22] = "1909",
[23] = "1900",
[25] = "1904",
[32] = "1904",
[36] = "1893",
[38] = "1899",
[39] = "1903",
[44] = "1907",
[45] = "1899",
[46] = "1909",
[47] = "1920",
[48] = "1920",
[50] = "1926",
[52] = "1893",
[54] = "1897",
[55] = "1900",
[57] = "1905",
[64] = "1906",
[65] = "1944",
[66] = "1950",
[69] = "1924",
[70] = "1919",
[71] = "1943",
[72] = "1904",
[73] = "1970",
[74] = "1901",
[76] = "1906",
[94] = "1878",
[95] = "1884",
[110] = "1877",
[144] = "1879",
[160] = "1848",
[169] = "1905",
[175] = "1945",
[1799] = "1905",
[1808] = "1901",
[1809] = "1970",
[1819] = "1919",
[1824] = "1899",
[1831] = "1966",
[1860] = "1983",
[189] = "1899",
[1925] = "1889",
[1943] = "1899",
[205] = "1893",
[206] = "1899",
[219] = "1899",
[240] = "1903",
[241] = "1899",
[589] = "1906",
[243] = "1902",
[347] = "1923",
[378] = "1950",
[379] = "1931",
[448] = "1898",
[449] = "1907",
[450] = "1923",
[452] = "1900",
[453] = "1916",
[457] = "1909",
[461] = "1919",
[462] = "1928",
[463] = "1921",
[472] = "1949",
[479] = "1920",
[480] = "1924",
[481] = "1890",
[483] = "1923",
[576] = "1900",
[10029] = "1899",
[100409] = "1907",
[100888] = "1928",
[110062] = "1930",
[110329] = "1910",
[110374] = "1926",
[110556] = "1903",
[111235] = "1846",
[111811] = "1908",
[112172] = "2009"
}

local FINANCIAL = {
[1] = "Low",
[2] = "Very High",
[5] = "Very High",
[7] = "Very Low",
[9] = "High",
[10] = "High",
[11] = "High",
[13] = "Medium",
[14] = "Very Low",
[17] = "Low",
[18] = "Low",
[19] = "Medium",
[21] = "Medium",
[22] = "Very High",
[23] = "High",
[25] = "Medium",
[32] = "High",
[36] = "Low",
[38] = "Medium",
[39] = "High",
[44] = "Very Low",
[45] = "Very High",
[46] = "Very Low",
[47] = "High",
[48] = "Medium",
[50] = "Medium",
[52] = "Very High",
[54] = "Low",
[55] = "Very Low",
[57] = "Medium",
[64] = "Very Low",
[65] = "Very Low",
[66] = "Medium",
[69] = "High",
[70] = "Medium",
[71] = "Very Low",
[72] = "Medium",
[73] = "Medium",
[74] = "Very High",
[76] = "Low",
[94] = "Medium",
[95] = "Medium",
[110] = "Very Low",
[144] = "Medium",
[160] = "Medium",
[169] = "High",
[175] = "Medium",
[1799] = "Very Low",
[1808] = "High",
[1809] = "Very Low",
[1819] = "Medium",
[1824] = "Very Low",
[1831] = "Very High",
[1860] = "Very Low",
[189] = "Very High",
[1925] = "Very High",
[1943] = "Medium",
[205] = "Low",
[206] = "High",
[219] = "Low",
[240] = "Very High",
[241] = "Very High",
[589] = "Medium",
[243] = "High",
[347] = "Very Low",
[378] = "Low",
[379] = "Very Low",
[448] = "High",
[449] = "Medium",
[450] = "Medium",
[452] = "Very Low",
[453] = "High",
[457] = "High",
[461] = "Low",
[462] = "Low",
[463] = "Medium",
[472] = "Low",
[479] = "High",
[480] = "Medium",
[481] = "Low",
[483] = "Low",
[576] = "Low",
[10029] = "Medium",
[100409] = "High",
[100888] = "Low",
[110062] = "Low",
[110329] = "Very Low",
[110374] = "Very High",
[110556] = "Medium",
[111235] = "Medium",
[111811] = "High",
[112172] = "Very High"
}

local FANBASE_DEVOTION = {
[1] = "Medium",
[2] = "Very High",
[5] = "Very High",
[7] = "Low",
[9] = "Very High",
[10] = "Very High",
[11] = "Very High",
[13] = "High",
[14] = "Low",
[17] = "Medium",
[18] = "Medium",
[19] = "High",
[21] = "High",
[22] = "Very High",
[23] = "High",
[25] = "Medium",
[32] = "High",
[36] = "Medium",
[38] = "High",
[39] = "High",
[44] = "Low",
[45] = "Very High",
[46] = "Medium",
[47] = "High",
[48] = "Medium",
[50] = "Medium",
[52] = "Very High",
[54] = "High",
[55] = "Medium",
[57] = "High",
[64] = "Medium",
[65] = "Medium",
[66] = "Very High",
[69] = "High",
[70] = "Medium",
[71] = "Medium",
[72] = "High",
[73] = "Very High",
[74] = "Very High",
[76] = "Medium",
[94] = "High",
[95] = "Medium",
[110] = "Medium",
[144] = "High",
[160] = "Medium",
[169] = "High",
[175] = "Medium",
[1799] = "Low",
[1808] = "High",
[1809] = "Medium",
[1819] = "High",
[1824] = "Medium",
[1831] = "Very High",
[1860] = "Low",
[189] = "Very High",
[1925] = "High",
[1943] = "Medium",
[205] = "Medium",
[206] = "High",
[219] = "Medium",
[240] = "Very High",
[241] = "Very High",
[589] = "High",
[243] = "Very High",
[347] = "Low",
[378] = "Medium",
[379] = "Low",
[448] = "High",
[449] = "Medium",
[450] = "Medium",
[452] = "Low",
[453] = "High",
[457] = "High",
[461] = "Medium",
[462] = "Medium",
[463] = "Medium",
[472] = "Medium",
[479] = "High",
[480] = "Medium",
[481] = "Medium",
[483] = "Medium",
[576] = "Medium",
[10029] = "High",
[100409] = "High",
[100888] = "Medium",
[110062] = "Medium",
[110329] = "Low",
[110374] = "Very High",
[110556] = "Medium",
[111235] = "Medium",
[111811] = "High",
[112172] = "Very High"
}

local YOUTH_FACILITIES = {
[1] = "High",
[2] = "High",
[5] = "Very High",
[7] = "Medium",
[9] = "Very High",
[10] = "Very High",
[11] = "Very High",
[13] = "High",
[14] = "Medium",
[17] = "Medium",
[18] = "High",
[19] = "High",
[21] = "High",
[22] = "Very High",
[23] = "High",
[25] = "Medium",
[32] = "High",
[36] = "Medium",
[38] = "High",
[39] = "High",
[44] = "Medium",
[45] = "Very High",
[46] = "Medium",
[47] = "High",
[48] = "Medium",
[50] = "Medium",
[52] = "Very High",
[54] = "High",
[55] = "Medium",
[57] = "High",
[64] = "Medium",
[65] = "Medium",
[66] = "Very High",
[69] = "High",
[70] = "Medium",
[71] = "Medium",
[72] = "High",
[73] = "Very High",
[74] = "Very High",
[76] = "Medium",
[94] = "High",
[95] = "Medium",
[110] = "Medium",
[144] = "High",
[160] = "Medium",
[169] = "High",
[175] = "Medium",
[1799] = "Medium",
[1808] = "High",
[1809] = "Medium",
[1819] = "High",
[1824] = "Medium",
[1831] = "Very High",
[1860] = "Medium",
[189] = "Very High",
[1925] = "High",
[1943] = "Medium",
[205] = "Medium",
[206] = "High",
[219] = "Medium",
[240] = "Very High",
[241] = "Very High",
[589] = "Medium",
[243] = "Very High",
[347] = "Medium",
[378] = "Medium",
[379] = "Medium",
[448] = "High",
[449] = "Medium",
[450] = "Medium",
[452] = "Medium",
[453] = "High",
[457] = "High",
[461] = "Medium",
[462] = "Medium",
[463] = "Medium",
[472] = "Medium",
[479] = "High",
[480] = "Medium",
[481] = "Medium",
[483] = "Medium",
[576] = "Medium",
[10029] = "High",
[100409] = "High",
[100888] = "Medium",
[110062] = "Medium",
[110329] = "Medium",
[110374] = "Very High",
[110556] = "Medium",
[111235] = "Medium",
[111811] = "High",
[112172] = "Very High"
}

local STADIUM_NAMES = {
    [1] = "Emirates Stadium",
[2] = "Villa Park",
[5] = "Stamford Bridge",
[7] = "Goodison Park",
[9] = "Anfield",
[10] = "Etihad Stadium",
[11] = "Old Trafford",
[13] = "St. James' Park",
[14] = "City Ground",
[17] = "St. Mary's Stadium",
[18] = "Tottenham Hotspur Stadium",
[19] = "London Stadium",
[21] = "Allianz Arena",
[22] = "Signal Iduna Park",
[23] = "Borussia-Park",
[25] = "Europa-Park Stadion",
[32] = "BayArena",
[36] = "MHPArena",
[38] = "Weserstadion",
[39] = "Gewiss Stadium",
[45] = "Allianz Stadium",
[48] = "Stadio Diego Armando Maradona",
[50] = "Stadio Ennio Tardini",
[54] = "Stadio Olimpico Grande Torino",
[55] = "Dacia Arena",
[57] = "Stade de l'Abbé-Deschamps",
[64] = "Stade Bollaert-Delelis",
[65] = "Stade Pierre-Mauroy",
[66] = "Groupama Stadium",
[69] = "Stade Louis II",
[70] = "Stade de la Mosson",
[71] = "Stade de la Beaujoire",
[72] = "Allianz Riviera",
[73] = "Parc des Princes",
[74] = "Roazhon Park",
[76] = "Stade de la Meinau",
[94] = "Portman Road",
[95] = "King Power Stadium",
[110] = "Molineux Stadium",
[144] = "Craven Cottage",
[160] = "Vonovia Ruhrstadion",
[169] = "Mewa Arena",
[175] = "Volkswagen Arena",
[189] = "Stadio Renato Dall'Ara",
[205] = "Stadio Pier Luigi Penzo",
[206] = "Stadio Marcantonio Bentegodi",
[219] = "Stade Vélodrome",
[240] = "Civitas Metropolitano",
[241] = "Spotify Camp Nou",
[589] = "Estadio Municipal De Riazor",
[243] = "Santiago Bernabéu",
[244] = "Nuevo Estadio de Vallecas",
[347] = "Stadio Via del Mare",
[378] = "Stade Francis-Le Blé",
[379] = "Stade Auguste-Delaune",
[450] = "Abanca-Balaídos",
[448] = "San Mamés",
[449] = "Estadio Benito Villamarín",
[452] = "Stage Front Stadium",
[453] = "Estadi Mallorca Son Moix",
[457] = "Reale Arena",
[461] = "Mestalla",
[462] = "Estadio José Zorrilla",
[463] = "Mendizorroza",
[472] = "Estadio de Gran Canaria",
[479] = "El Sadar",
[481] = "Ramón Sánchez Pizjuán",
[576] = "Holstein-Stadion",
[1799] = "Selhurst Park",
[1808] = "Falmer Stadium",
[1819] = "Stade Geoffroy-Guichard",
[1824] = "Deutsche Bank Park",
[1831] = "Stadion An der Alten Försterei",
[1842] = "Unipol Domus",
[1860] = "Coliseum Alfonso Pérez",
[1925] = "Gtech Community Stadium",
[1943] = "Vitality Stadium",
[10029] = "PreZero Arena",
[100409] = "WWK Arena",
[100888] = "Estadio Municipal de Butarque",
[110062] = "Estadi Montilivi",
[110329] = "Millerntor-Stadion",
[110374] = "Stadio Artemio Franchi",
[110556] = "Stadio Luigi Ferraris",
[111235] = "Voith-Arena",
[111811] = "U-Power Stadium",
[112172] = "Red Bull Arena",
[1745] = "Stadio Giuseppe Sinigaglia",
[1746] = "Stadio Carlo Castellani",
[1809] = "Stadium de Toulouse",
[1738] = "Stade Océane",
[1530] = "Stade Raymond Kopa"
}

local CLUB_WORTH = {
    [1] = "850,000,000",
[2] = "600,000,000",
[5] = "880,000,000",
[7] = "430,000,000",
[9] = "870,000,000",
[10] = "900,000,000",
[11] = "880,000,000",
[13] = "740,000,000",
[14] = "300,000,000",
[17] = "250,000,000",
[18] = "820,000,000",
[19] = "600,000,000",
[94] = "120,000,000",
[95] = "350,000,000",
[110] = "280,000,000",
[144] = "350,000,000",
[1799] = "330,000,000",
[1808] = "420,000,000",
[1925] = "400,000,000",
[1943] = "300,000,000",
[57] = "120,000,000",
[64] = "280,000,000",
[65] = "350,000,000",
[66] = "400,000,000",
[69] = "450,000,000",
[70] = "180,000,000",
[71] = "220,000,000",
[72] = "320,000,000",
[73] = "900,000,000",
[74] = "380,000,000",
[76] = "240,000,000",
[219] = "480,000,000",
[378] = "200,000,000",
[379] = "230,000,000",
[1530] = "100,000,000",
[1738] = "160,000,000",
[1809] = "220,000,000",
[1819] = "250,000,000",
[21] = "900,000,000",
[22] = "850,000,000",
[23] = "400,000,000",
[25] = "350,000,000",
[32] = "880,000,000",
[36] = "700,000,000",
[38] = "300,000,000",
[160] = "180,000,000",
[169] = "250,000,000",
[175] = "450,000,000",
[576] = "120,000,000",
[1824] = "600,000,000",
[1831] = "400,000,000",
[10029] = "420,000,000",
[100409] = "300,000,000",
[110329] = "180,000,000",
[111235] = "160,000,000",
[112172] = "880,000,000",
[39] = "550,000,000",
[44] = "880,000,000",
[45] = "850,000,000",
[46] = "650,000,000",
[47] = "870,000,000",
[48] = "800,000,000",
[50] = "250,000,000",
[52] = "750,000,000",
[54] = "320,000,000",
[55] = "300,000,000",
[189] = "450,000,000",
[205] = "180,000,000",
[206] = "220,000,000",
[347] = "250,000,000",
[1745] = "230,000,000",
[1746] = "200,000,000",
[1842] = "250,000,000",
[110374] = "600,000,000",
[110556] = "270,000,000",
[111811] = "320,000,000",
[240] = "880,000,000",
[241] = "900,000,000",
[589] = "38,750,000",
[243] = "900,000,000",
[448] = "500,000,000",
[449] = "400,000,000",
[450] = "300,000,000",
[452] = "280,000,000",
[453] = "350,000,000",
[457] = "600,000,000",
[461] = "450,000,000",
[462] = "220,000,000",
[463] = "240,000,000",
[472] = "300,000,000",
[479] = "320,000,000",
[480] = "300,000,000",
[481] = "650,000,000",
[483] = "550,000,000",
[1860] = "320,000,000",
[100888] = "240,000,000",
[110062] = "400,000,000"
}

local TRANSFER_BUDGET = {
    [1] = "150,000,000",
[2] = "90,000,000",
[5] = "160,000,000",
[7] = "35,000,000",
[9] = "150,000,000",
[10] = "200,000,000",
[11] = "180,000,000",
[13] = "120,000,000",
[14] = "25,000,000",
[17] = "20,000,000",
[18] = "120,000,000",
[19] = "70,000,000",
[94] = "12,000,000",
[95] = "45,000,000",
[110] = "40,000,000",
[144] = "50,000,000",
[1799] = "50,000,000",
[1808] = "60,000,000",
[1925] = "55,000,000",
[1943] = "45,000,000",
[57] = "10,000,000",
[64] = "25,000,000",
[65] = "35,000,000",
[66] = "40,000,000",
[69] = "60,000,000",
[70] = "15,000,000",
[71] = "20,000,000",
[72] = "35,000,000",
[73] = "180,000,000",
[74] = "45,000,000",
[76] = "25,000,000",
[219] = "55,000,000",
[378] = "18,000,000",
[379] = "22,000,000",
[1530] = "8,000,000",
[1738] = "12,000,000",
[1809] = "20,000,000",
[1819] = "15,000,000",
[21] = "160,000,000",
[22] = "120,000,000",
[23] = "45,000,000",
[25] = "40,000,000",
[32] = "130,000,000",
[36] = "90,000,000",
[38] = "35,000,000",
[160] = "20,000,000",
[169] = "25,000,000",
[175] = "50,000,000",
[576] = "12,000,000",
[1824] = "60,000,000",
[1831] = "45,000,000",
[10029] = "50,000,000",
[100409] = "35,000,000",
[110329] = "18,000,000",
[111235] = "15,000,000",
[112172] = "110,000,000",
[39] = "60,000,000",
[44] = "100,000,000",
[45] = "90,000,000",
[46] = "70,000,000",
[47] = "95,000,000",
[48] = "80,000,000",
[50] = "20,000,000",
[52] = "70,000,000",
[54] = "30,000,000",
[55] = "25,000,000",
[189] = "40,000,000",
[205] = "15,000,000",
[206] = "20,000,000",
[347] = "25,000,000",
[1745] = "30,000,000",
[1746] = "20,000,000",
[1842] = "25,000,000",
[110374] = "50,000,000",
[110556] = "28,000,000",
[111811] = "35,000,000",
[240] = "95,000,000",
[241] = "100,000,000",
[589] = "82,000,000",
[243] = "180,000,000",
[448] = "45,000,000",
[449] = "40,000,000",
[450] = "25,000,000",
[452] = "20,000,000",
[453] = "30,000,000",
[457] = "55,000,000",
[461] = "35,000,000",
[462] = "20,000,000",
[463] = "22,000,000",
[472] = "25,000,000",
[479] = "30,000,000",
[480] = "28,000,000",
[481] = "60,000,000",
[483] = "50,000,000",
[1860] = "30,000,000",
[100888] = "20,000,000",
[110062] = "40,000,000"
}

-- Función para obtener información del equipo
function SelectLeagueTeam:getTeamInfo(teamId)
    return TEAM_INFORMATION[teamId] or "0            0            0"
end

function SelectLeagueTeam:getFounded(teamId)
    return CLUB_FOUNDED[teamId] or "1898"
end

-- Función para obtener información del equipo
function SelectLeagueTeam:getStadiumName(teamId)
    return STADIUM_NAMES[teamId] or "Olympic Stadium"
end

-- Funcion para obtener valor del club
function SelectLeagueTeam:getClubWorth(teamId)
    return CLUB_WORTH[teamId] or "355,000,000"
end

-- Funcion para obtener presupuesto
function SelectLeagueTeam:getTransfer(teamId)
    return TRANSFER_BUDGET[teamId] or "65,000,000"
end

function SelectLeagueTeam:getFinancial(teamId)
    return FINANCIAL[teamId] or "Medium"
end

function SelectLeagueTeam:getYouth(teamId)
    return YOUTH_FACILITIES[teamId] or "Low"
end

function SelectLeagueTeam:getFanbase(teamId)
    return FANBASE_DEVOTION[teamId] or "Low"
end

local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local LOGIN_STATUS = FUTLoginManager.FeCards.LoginStatus
local TERMINATION_REASON = SKUEnums.fifaids.TerminationReason
local NUM_COLUMNS = 4
missionmode = "ER"
ligaId = 1

local EXCLUDED_TEAMS = {
[113044] = true,
[112965] = true,
[112764] = true,
[111711] = true,
[111710] = true,
[111706] = true,
[110953] = true,
[110711] = true,
[110827] = true,
[15012] = true,
[110404] = true,
[110242] = true,
[101084] = true,
[1952] = true,
[1936] = true,
[1919] = true,
[1807] = true,
[121] = true,
[97] = true,
[92] = true
}

-- Función para verificar si un equipo está excluido
local function isTeamExcluded(teamID)
    return EXCLUDED_TEAMS[teamID] == true
end

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
        GameState = o.api("GameStateService"),
        BrowserService = o.api("BrowserService"),
        MiscService = o.api("MiscService")
    }
    o.isDeterminationPackKillSwitchOn = o.services.GameStateService.IsDeterminationPackKillSwitchOn()
    o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
        o:_handleEvent(...)
    end)
    local defaultData = o.services.CountryService.GetDefaultTeamForRegion()
    o.currentCountryID = -1
    o.currentLeagueID = 13
    o.currentTeamID = 5
    o.favoritePlayerID = -1
    o.countryIndex = 1
    o.leagueIndex = 1
    o.teamIndex = 1
    o.currentTeamName = ""
    o:getLeagues()
    o:registerLeagueBindings()
    o:registerTeamBindings()
    
    o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5 }
    
    -- Configuración de suscripciones
    o.im.Subscribe(BND_TEAM_CREST, function() o:publishTeamCrest(o.currentTeamID) end)
    o.im.Subscribe(BND_TEAM_CREST_HOME_KIT, function() o:publishTeamCrestHomeKit(o.currentTeamID) end)
    o.im.Subscribe(BND_TEAM_CREST_AWAY_KIT, function() o:publishTeamCrestAwayKit(o.currentTeamID) end)
    o.im.Subscribe(BND_TEAM_CREST_INFO, function() o:publishTeamCrestInfo(o.currentTeamID) end)
    o.im.Subscribe(BND_TEAM_CREST_STD, function() o:publishTeamCrestStd(o.currentTeamID) end)
    o.im.Subscribe(BND_LEAGUE_CREST, function() o:publishLeagueCrest() end)
    o.im.Subscribe(BND_DETERMINED_PACK_VISIBILITY, function()
        o.im.Publish(BND_DETERMINED_PACK_VISIBILITY, not o.isDeterminationPackKillSwitchOn)
    end)
    o.im.Subscribe(BND_CURRENT_TEAM_NAME, function() o:publishCurrentTeamName() end)
    o.im.Subscribe(BND_CURRENT_LEAGUE_NAME, function()
    if o.currentLeagueID then
        local leagueInfo = self.loc.LocalizeString("LeagueName_Abbr15_" .. o.currentLeagueID)
        o.im.Publish(BND_CURRENT_LEAGUE_NAME, leagueInfo and leagueInfo.name or "")
    end
end)
    o.im.Subscribe(BND_NATION_LEAGUE_NAME, function()
    o:publishLeagueName(o.currentLeagueID)
end)
    o.im.Subscribe(BND_REGULAR_BG_VISIBILITY, function()
        o.im.Publish(BND_REGULAR_BG_VISIBILITY, o.isDeterminationPackKillSwitchOn)
    end)
    o.im.Subscribe(BND_LEAGUE_LIST_INDEX, function() o:publishLeagueIndex() end)
    o.im.Subscribe(BND_LEAGUE_LIST_TOGGLE, function() o:publishLeagueToggle() end)
    o.im.Subscribe(BND_TEAM_LIST_INDEX, function() o:publishTeamIndex() end)
    o.im.Subscribe(BND_TEAM_LIST_TOGGLE, function() o:publishTeamToggle() end)
    o.im.Subscribe(BND_TEAM_STAR_RATING, function() o:publishTeamStarRating() end)
    o.im.Subscribe(BND_TEAM_RATING, function() o:publishTeamRating() end)
    o.im.Subscribe(BND_TEAM_INFO, function()
    if o.currentTeamID then
        o.im.Publish(BND_TEAM_INFO, o:getTeamInfo(o.currentTeamID))
    end
end)
    o.im.Subscribe(BND_STADIUM_NAME, function()
    if o.currentTeamID then
        o.im.Publish(BND_STADIUM_NAME, o:getStadiumName(o.currentTeamID))
    end
end)
o.im.Subscribe(BND_CLUB_WORTH, function()
    if o.currentTeamID then
        o.im.Publish(BND_CLUB_WORTH, o:getClubWorth(o.currentTeamID))
    end
end)
o.im.Subscribe(BND_TRANSFER_BUDGET, function()
    if o.currentTeamID then
        o.im.Publish(BND_TRANSFER_BUDGET, o:getTransfer(o.currentTeamID))
    end
end)
o.im.Subscribe(BND_FINANCIAL, function()
    if o.currentTeamID then
        o.im.Publish(BND_FINANCIAL, o:getFinancial(o.currentTeamID))
    end
end)
o.im.Subscribe(BND_YOUTH, function()
    if o.currentTeamID then
        o.im.Publish(BND_YOUTH, o:getYouth(o.currentTeamID))
    end
end)
o.im.Subscribe(BND_CLUB_FOUNDED, function()
    if o.currentTeamID then
        o.im.Publish(BND_CLUB_FOUNDED, o:getFounded(o.currentTeamID))
    end
end)
o.im.Subscribe(BND_FANBASE, function()
    if o.currentTeamID then
        o.im.Publish(BND_FANBASE, o:getFanbase(o.currentTeamID))
    end
end)
    
    -- Configuración de pestañas
    o.im.Subscribe(BND_TAB1_VISIBLE, function() end)
    o.im.Subscribe(BND_TAB2_VISIBLE, function() end)
    o.im.Subscribe(BND_TAB3_VISIBLE, function() end)
    o.im.Subscribe(BND_TAB4_VISIBLE, function() end)
    o.im.Subscribe(BND_TAB5_VISIBLE, function() end)
    
    o:HideSelections()
    o.im.Publish(BND_TAB1_VISIBLE, true)
    
    o.defaultCellData = {
        label = "",
        image = {},
        id = -1
    }
    o.im.Subscribe(BND_DEFAULT_CELL_DATA, function()
        o.im.Publish(BND_DEFAULT_CELL_DATA, o.defaultCellData)
    end)
    
    -- Configuración de acciones
    o.im.RegisterAction(ACT_CONFIRM, function(actionName, data)
        o.im.ChangeActionState(ACT_SELECT_LEAGUE, o.im.GetActionState("INVALID"))
        o.im.ChangeActionState(ACT_SELECT_TEAM, o.im.GetActionState("INVALID"))
        o.im.ChangeActionState(ACT_SELECTOR_CANCEL, o.im.GetActionState("INVALID"))
        o.im.ChangeActionState(ACT_CHANGE, o.im.GetActionState("INVALID"))
        o.im.ChangeActionState(ACT_CONFIRM, o.im.GetActionState("INVALID"))
        o.services.FUTUserInfoService.SetUserFavoriteTeam(o.currentTeamID)
    end)
    
    o.im.RegisterAction(ACT_SELECTOR_CANCEL, function() o:onSelectorCancel() end)
    o.im.RegisterAction(ACT_NEXT_TEAM, function() o:nextTeam() end)
    o.im.RegisterAction(ACT_PREV_TEAM, function() o:prevTeam() end)
    o.im.RegisterAction(ACT_NEXT_LEAGUE, function() o:nextLeague() end)
    o.im.RegisterAction(ACT_PREV_LEAGUE, function() o:prevLeague() end)
    
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

function SelectLeagueTeam:HideSelections()
    self.im.Publish(BND_TAB1_VISIBLE, false)
    self.im.Publish(BND_TAB2_VISIBLE, false)
    self.im.Publish(BND_TAB3_VISIBLE, false)
    self.im.Publish(BND_TAB4_VISIBLE, false)
    self.im.Publish(BND_TAB5_VISIBLE, false)
end

function SelectLeagueTeam:publishLeagueName(leagueID)
    if not self.leagueDatabase then
        self:initLeagueDatabase()
    end

    local selectedLeagueID = leagueID or self.currentLeagueID  
    if not selectedLeagueID or selectedLeagueID == -1 then  
        self.im.Publish(BND_LEAGUE_NAME, "")  
        self.im.Publish(BND_NATION_LEAGUE_NAME, "")  
        return  
    end  

    local data = self.leagueDatabase[selectedLeagueID]  
    if not data then  
        self.im.Publish(BND_LEAGUE_NAME, "Unknown League")  
        self.im.Publish(BND_NATION_LEAGUE_NAME, "Unknown Nation")  
        return  
    end  

    self.im.Publish(BND_LEAGUE_NAME, data.league)  
    self.im.Publish(BND_NATION_LEAGUE_NAME, data.nation)  

    -- Debug log
    print(string.format("Published league: %s | Nation: %s", data.league, data.nation))
end

function SelectLeagueTeam:initLeagueDatabase()
    self.leagueDatabase = {
        -- 🔹 Big 5 Eropa + lain (2025/26)
[4]    = { league = "Belgian Pro League", nation = "Belgium" },
[7]    = { league = "Brazil Serie A", nation = "Brazil" },
[10]   = { league = "Eredivisie", nation = "Netherlands" },
[13]   = { league = "Premier League", nation = "England" },
[14]   = { league = "EFL Championship", nation = "England" },
[16]   = { league = "Ligue 1 McDonald's", nation = "France" },
[17]   = { league = "Ligue 2", nation = "France" },
[19]   = { league = "Bundesliga", nation = "Germany" },
[20]   = { league = "2. Bundesliga", nation = "Germany" },
[31]   = { league = "Serie A", nation = "Italy" },
[32]   = { league = "Serie B", nation = "Italy" },
[39]   = { league = "Major League Soccer", nation = "USA" },
[50]   = { league = "Scottish Premiership", nation = "Scotland" },
[53]   = { league = "LaLiga EA Sports", nation = "Spain" },
[54]   = { league = "LaLiga Hypermotion", nation = "Spain" },
[60]   = { league = "EFL League One", nation = "England" },
[68]   = { league = "Trendyol Süper Lig", nation = "Turkey" },
[76]   = { league = "Rest of World", nation = "Various" },
[77]   = { league = "Rest of World (2)", nation = "Various" },
[78]   = { league = "International", nation = "FIFA" },
[308]  = { league = "Liga Portugal Betclic", nation = "Portugal" },
[341]  = { league = "Liga BBVA MX", nation = "Mexico" },
[347]  = { league = "SA Premier Division", nation = "South Africa" },
[350]  = { league = "Roshn Saudi League", nation = "Saudi Arabia" },
[353]  = { league = "Liga Profesional", nation = "Argentina" },
[365]  = { league = "AFC", nation = "Asia" },
[1245] = { league = "Classic Team", nation = "Special" },
[1246] = { league = "Classic Internasional", nation = "Special" },
[2136] = { league = "International Women", nation = "FIFA" },
[2216] = { league = "Barclays WSL", nation = "England" },  -- singkatan dari Women's Super League
[2218] = { league = "D1 Arkema", nation = "France" },
[2221] = { league = "NWSL", nation = "USA" },
[2222] = { league = "Liga F", nation = "Spain" },
[2231] = { league = "Egyptian Premier League", nation = "Egypt" },
[2235] = { league = "BRI Super League", nation = "Indonesia" },
[2236] = { league = "UEFA Champions League", nation = "Europe" },
[2237] = { league = "Liga Super Malaysia", nation = "Malaysia" },
[2238] = { league = "UEFA Europa League", nation = "Europe" },
[2240] = { league = "UWCL", nation = "Europe" },  -- singkatan dari UEFA Women's Champions League
[2250] = { league = "Botola Pro Inwi", nation = "Morocco" },
[2252] = { league = "Thai League 1", nation = "Thailand" },
[2254] = { league = "Pegadaian Championship", nation = "Indonesia" },
[2260] = { league = "V.League 1", nation = "Vietnam" },
[349]  = { league = "Meiji Yasuda J1", nation = "Japan" }, -- singkatan dari Meiji Yasuda J1 League
[83]   = { league = "Hana Bank K1", nation = "South Korea" }, -- singkatan dari Hana Bank K League 1
[2149] = { league = "Indian Super League", nation = "India" },
[66]   = { league = "PKO Ekstraklasa", nation = "Poland" },
[351]  = { league = "Isuzu UTE A-League", nation = "Australia" },
[2012] = { league = "China Super League", nation = "China" },
[2215] = { league = "Google Pixel Frauen", nation = "Germany" }, -- singkatan dari Frauen-Bundesliga
[2034] = { league = "Ligue 1", nation = "Algeria" },
[1114] = { league = "Singapore Premier", nation = "Singapore" },
[1115] = { league = "Qatar Stars League", nation = "Qatar" },
[2255] = { league = "Liga Nusantara", nation = "Indonesia" },
[1117] = { league = "Uzbekistan SL", nation = "Uzbekistan" },
[1107] = { league = "HK Premier League", nation = "Hong Kong" },
[1170] = { league = "Cambodia PL", nation = "Cambodia" },
[1407] = { league = "Bangladesh PL", nation = "Bangladesh" },
[2013] = { league = "UAE Pro League", nation = "UAE" },
[1171] = { league = "Myanmar NL", nation = "Myanmar" },
[1172] = { league = "Laos League 1", nation = "Laos" },
[67]   = { league = "Russian Premier League", nation = "Russia" },
[336]  = { league = "Categoría Primera A", nation = "Colombia" },
[1]    = { league = "Superligaen", nation = "Denmark" },
[335]  = { league = "Primera División Chile", nation = "Chile" },
[56]   = { league = "Allsvenskan", nation = "Sweden" },
[2264] = { league = "ASEAN U23 Champ", nation = "ASEAN" }, -- singkatan
[338]  = { league = "Primera División Uru", nation = "Uruguay" },
[189]  = { league = "Swiss Super League", nation = "Switzerland" },
[65]   = { league = "Ireland Premier", nation = "Ireland" },
[80]   = { league = "Austrian Bundesliga", nation = "Austria" },
[2261] = { league = "National Team", nation = "International" },
    }
end

function SelectLeagueTeam:_juiceSelectLeagueTeam(currentTeamID)
    self.currentTeamID = currentTeamID
    self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(self.currentTeamID)
    self.services.FUTUserInfoService.SetUserFavoriteTeam(self.currentTeamID)
end

function SelectLeagueTeam:getLeagues()
    local leagueNames = {}
    self.leagueIDs = {
        13, 14, 16, 19, 20, 31, 39, 41, 50, 53, 56, 66, 67, 68, 83, 308, 335, 336, 341, 350, 351, 353, 84, 14, 17, 32, 54, 61, 65, 60, 2216, 2218, 2222, 2215, 2136, 2226, 2236, 2238, 2235, 2254
    }
    local alternateBG = false
    for i = 1, #self.leagueIDs do
        table.insert(leagueNames, {
            label = self.leagueIDs[i],
            image = { name = "$LeagueActive", id = self.leagueIDs[i] },
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

function SelectLeagueTeam:getTeams()
    local teamNames = {}
    local teamIDs = self.services.TeamService.GetTeams(self.currentLeagueID, 0, 0, false)
    self.teamsData = {}

    local alternateBG = false

    for _, teamData in ipairs(teamIDs) do
        -- Excluir el equipo 100888
        if not isTeamExcluded(teamData.id) and teamData.id ~= 100888 then
            local teamInfo = {
                id = teamData.id,
                name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamData.id),
                starRating = teamData.starRating or 0,
                offense = teamData.offense or 0,
                midfield = teamData.midfield or 0,
                defense = teamData.defense or 0
            }

            table.insert(self.teamsData, teamInfo)
            table.insert(teamNames, {
                label = teamInfo.name,
                image = { name = "$Crest", id = teamInfo.id },
                id = #self.teamsData,
                selected = self.currentTeamID == teamInfo.id or (self.currentTeamID == 0 and #self.teamsData == 1),
                alternateBackground = alternateBG,
                stars = teamInfo.starRating
            })
            
            if self.currentTeamID == teamInfo.id or (self.currentTeamID == 0 and #self.teamsData == 1) then
                self.currentTeamID = teamInfo.id
                self.teamIndex = #self.teamsData
                currentSelectedTeamID = teamInfo.id
            end

            if #self.teamsData % NUM_COLUMNS ~= 0 then
                alternateBG = not alternateBG
            end
        end
    end

    -- Agregar el equipo 589 si estamos en la liga 53
    if self.currentLeagueID == 1222 then
        local team242Info = {
            id = 589,
            name = self.loc.LocalizeString("TeamName_Abbr15_242"),
            starRating = 4, -- Ajusta según sea necesario
            offense = 75,   -- Ajusta según sea necesario
            midfield = 72,  -- Ajusta según sea necesario
            defense = 78    -- Ajusta según sea necesario
        }

        table.insert(self.teamsData, team242Info)
        table.insert(teamNames, {
            label = team242Info.name,
            image = { name = "$Crest", id = 589 },
            id = #self.teamsData,
            selected = self.currentTeamID == 589,
            alternateBackground = alternateBG,
            stars = team242Info.starRating
        })

        if self.currentTeamID == 589 then
            self.teamIndex = #self.teamsData
        end

        if #self.teamsData % NUM_COLUMNS ~= 0 then
            alternateBG = not alternateBG
        end
    end

    if not LigaGrouping[ligaId] then
        TeamList = {}
        for _, teamData in ipairs(teamIDs) do
            if not isTeamExcluded(teamData.id) and teamData.id ~= 100888 then
                table.insert(TeamList, teamData.id)
            end
        end
        
        -- Agregar equipo 589 a TeamList si estamos en liga 53
        if self.currentLeagueID == 1222 then
            table.insert(TeamList, 589)
        end
    end

    if #self.teamsData > 0 then
        self.teamIndex = math.min(self.teamIndex, #self.teamsData)
        self.currentTeamID = self.teamsData[self.teamIndex].id
        self.currentTeamName = self.teamsData[self.teamIndex].name
        self.im.Publish(BND_CURRENT_TEAM_NAME, self.currentTeamName)
        self.im.Refresh(BND_SELECTED_TEAM_NAME)
        
        self:publishTeamCrest(self.currentTeamID)
        self:publishTeamCrestHomeKit(self.currentTeamID)
        self:publishTeamCrestAwayKit(self.currentTeamID)
        self:publishTeamCrestInfo(self.currentTeamID)
        self:publishTeamCrestStd(self.currentTeamID)
        self:publishTeamStarRating()
        self:publishTeamRating()
    else
        self.currentTeamName = ""
        self.im.Publish(BND_CURRENT_TEAM_NAME, self.currentTeamName)
    end

    self:setSelectedTeamIndex(self.teamIndex)
    self.teamsDataToPublish = { index = self.teamIndex, data = teamNames }
    self.im.Refresh(BND_TEAM_LIST)
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
    
    if self.teamsData and #self.teamsData > 0 then
        self.currentTeamName = self.teamsData[1].name
        self.im.Publish(BND_CURRENT_TEAM_NAME, self.currentTeamName)
        self.im.Refresh(BND_SELECTED_TEAM_NAME)
    end
end

function SelectLeagueTeam:setSelectedLeagueIndexHelper(index)
    if self.leagueIndex ~= index then
        self.leagueIndex = index
        self.currentLeagueID = self.leagueIDs[index]
        currentSelectedLeagueID = self.currentLeagueID
        self.im.Refresh(BND_SELECTED_LEAGUE_NAME)
        self.im.Refresh(BND_CURRENT_LEAGUE_NAME)
        self.im.Refresh(BND_NATION_LEAGUE_NAME)
        
        -- Refresh de TODOS los bindings de información del equipo
        self.im.Refresh(BND_STADIUM_NAME)
        self.im.Refresh(BND_CLUB_WORTH)
        self.im.Refresh(BND_TRANSFER_BUDGET)
        self.im.Refresh(BND_FINANCIAL)
        self.im.Refresh(BND_TEAM_INFO)
        self.im.Refresh(BND_CLUB_FOUNDED)
        self.im.Refresh(BND_YOUTH)
        self.im.Refresh(BND_FANBASE)
        
        self.currentTeamID = 0
        self.teamIndex = 1
        self.im.Refresh(BND_SELECTED_TEAM_NAME)
        self.im.Refresh(BND_SELECTED_LEAGUE_NAME)
    end
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
    self:publishTeamCrest(self.currentTeamID)
    self:publishTeamCrestHomeKit(self.currentTeamID)
    self:publishTeamCrestAwayKit(self.currentTeamID)
    self:publishTeamCrestInfo(self.currentTeamID)
    self:publishTeamCrestStd(self.currentTeamID)
end

function SelectLeagueTeam:setSelectedTeamIndexHelper(index)
    if self.teamIndex ~= index then
        self.teamIndex = index
        self.currentTeamID = self.teamsData[index].id
        self.currentTeamName = self.teamsData[index].name
        self.im.Publish(BND_TEAM_INFO, self:getTeamInfo(self.currentTeamID))
        self.im.Publish(BND_CLUB_FOUNDED, self:getFounded(self.currentTeamID))
        self.im.Publish(BND_FINANCIAL, self:getFinancial(self.currentTeamID))
        self.im.Publish(BND_YOUTH, self:getYouth(self.currentTeamID))
        self.im.Publish(BND_FANBASE, self:getFanbase(self.currentTeamID))
        self.im.Publish(BND_STADIUM_NAME, self:getStadiumName(self.currentTeamID))
        self.im.Publish(BND_CLUB_WORTH, self:getClubWorth(self.currentTeamID))
        self.im.Publish(BND_TRANSFER_BUDGET, self:getTransfer(self.currentTeamID))
        self.im.Publish(BND_CURRENT_TEAM_NAME, self.currentTeamName)
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
            clickEvents = { "evt_hide_popup" },
            clickCallback = function() self:_enableScreen() end
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
                clickEvents = { "evt_hide_popup" },
                clickCallback = function() self:_enableScreen() end
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

function SelectLeagueTeam:publishCurrentTeamName()
    if self.currentTeamID and self.teamsData and self.teamIndex then
        if self.teamIndex > 0 and self.teamIndex <= #self.teamsData then
            self.currentTeamName = self.teamsData[self.teamIndex].name
            self.im.Publish(BND_CURRENT_TEAM_NAME, self.currentTeamName)
            return true
        end
    end
    return false
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

function SelectLeagueTeam:publishTeamCrest(teamid)
    if not LigaGrouping[ligaId] then
        currentSelectedTeamID = self.currentTeamID 
        local selectedTeamID = teamid or self.currentTeamID 

        self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(selectedTeamID)
        local teamCrest = {
            name = "$Crest",
            id = selectedTeamID
        }

        self.im.Publish(BND_TEAM_CREST, teamCrest)

        self:publishTeamStarRating()
        self:publishLeagueToggle()
        self:publishTeamRating()
    else
        self.favoritePlayerID = -1
    end
end

function SelectLeagueTeam:publishTeamCrestHomeKit(teamid)
    if not LigaGrouping[ligaId] then
        currentSelectedTeamID = self.currentTeamID 
        local selectedTeamID = teamid or self.currentTeamID 

        self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(selectedTeamID)
        local teamCresthomekit = {
            name = "$HomeKit",
            id = selectedTeamID
        }

        self.im.Publish(BND_TEAM_CREST_HOME_KIT, teamCresthomekit)

        self:publishTeamStarRating()
        self:publishLeagueToggle()
        self:publishTeamRating()
    else
        self.favoritePlayerID = -1
    end
end

function SelectLeagueTeam:publishTeamCrestAwayKit(teamid)
    if not LigaGrouping[ligaId] then
        currentSelectedTeamID = self.currentTeamID 
        local selectedTeamID = teamid or self.currentTeamID 

        self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(selectedTeamID)
        local teamCrestawaykit = {
            name = "$AwayKit",
            id = selectedTeamID
        }

        self.im.Publish(BND_TEAM_CREST_AWAY_KIT, teamCrestawaykit)

        self:publishTeamStarRating()
        self:publishLeagueToggle()
        self:publishTeamRating()
    else
        self.favoritePlayerID = -1
    end
end

function SelectLeagueTeam:publishTeamCrestInfo(teamid)
    if not LigaGrouping[ligaId] then
        currentSelectedTeamID = self.currentTeamID 
        local selectedTeamID = teamid or self.currentTeamID 

        self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(selectedTeamID)
        local teamCrestinfo = {
            name = "$ClubInfo",
            id = selectedTeamID
        }

        self.im.Publish(BND_TEAM_CREST_INFO, teamCrestinfo)

        self:publishTeamStarRating()
        self:publishLeagueToggle()
        self:publishTeamRating()
    else
        self.favoritePlayerID = -1
    end
end

function SelectLeagueTeam:publishTeamCrestStd(teamid)
    if not LigaGrouping[ligaId] then
        currentSelectedTeamID = self.currentTeamID 
        local selectedTeamID = teamid or self.currentTeamID 

        self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(selectedTeamID)
        local teamCreststd = {
            name = "$ClubStd",
            id = selectedTeamID
        }

        self.im.Publish(BND_TEAM_CREST_STD, teamCreststd)

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
            styles = { "TF_SELECT_FAVORITE_LEAGUE_TOGGLE" }
        })
    end
    self.im.Publish(BND_LEAGUE_LIST_TOGGLE, {
        data = leagueData,
        index = self.leagueIndex - 1
    })
end

function SelectLeagueTeam:publishTeamToggle()
    local teamData = {}
    for i, team in ipairs(self.teamsData) do
        table.insert(teamData, {
            name = team.name,
            assetid = team.id, 
            id = i,
            styles = { "TF_SELECT_FAVORITE_TEAM_TOGGLE" }
        })
    end

    self.im.Publish(BND_TEAM_LIST_TOGGLE, {
        data = teamData,
        index = self.teamIndex - 1
    })
end

function SelectLeagueTeam:publishTeamIndex()
    self:publishTeamCrest(self.currentTeamID)
    self:publishTeamCrestAwayKit(self.currentTeamID)
    self:publishTeamCrestInfo(self.currentTeamID)
    self:publishTeamCrestStd(self.currentTeamID)
    self:publishTeamCrestHomeKit(self.currentTeamID)
    self.im.Publish(BND_TEAM_LIST_INDEX, self.teamIndex)
    self:publishTeamName(self.currentTeamID)
    self:publishLeagueName(self.currentLeagueID)
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

function SelectLeagueTeam:nextTeam()
    if #self.teamsData == 0 then return end
    
    local nextIndex = self.teamIndex + 1
    if nextIndex > #self.teamsData then
        nextIndex = 1
    end
    self:setSelectedTeamIndex(nextIndex)
end

function SelectLeagueTeam:prevTeam()
    if #self.teamsData == 0 then return end
    
    local prevIndex = self.teamIndex - 1
    if prevIndex < 1 then
        prevIndex = #self.teamsData
    end
    self:setSelectedTeamIndex(prevIndex)
end

function SelectLeagueTeam:nextLeague()
    if #self.leagueIDs == 0 then return end
    
    local nextIndex = self.leagueIndex + 1
    if nextIndex > #self.leagueIDs then
        nextIndex = 1
    end
    self:setSelectedLeagueIndex(nextIndex)
    
    self:publishCurrentTeamName()
end

function SelectLeagueTeam:prevLeague()
    if #self.leagueIDs == 0 then return end
    
    local prevIndex = self.leagueIndex - 1
    if prevIndex < 1 then
        prevIndex = #self.leagueIDs
    end
    self:setSelectedLeagueIndex(prevIndex)
    
    self:publishCurrentTeamName()
end

function SelectLeagueTeam:finalize()
    self.im.Unsubscribe(BND_TAB1_VISIBLE)
    self.im.Unsubscribe(BND_TAB2_VISIBLE)
    self.im.Unsubscribe(BND_TAB3_VISIBLE)
    self.im.Unsubscribe(BND_TAB4_VISIBLE)
    self.im.Unsubscribe(BND_TAB5_VISIBLE)
    self.im.UnregisterAction(ACT_MVNPROD)
    
    self.im.Unsubscribe(BND_LEAGUE_LIST)
    self.im.Unsubscribe(BND_SELECTED_LEAGUE_NAME)
    self.im.Unsubscribe(BND_LEAGUE_OVERLAY_VISIBLE)
    self.im.Unsubscribe(BND_TEAM_LIST)
    self.im.Unsubscribe(BND_SELECTED_TEAM_NAME)
    self.im.Unsubscribe(BND_TEAM_OVERLAY_VISIBLE)
    self.im.Unsubscribe(BND_TEAM_CREST)
    self.im.Unsubscribe(BND_TEAM_CREST_HOME_KIT)
    self.im.Unsubscribe(BND_TEAM_CREST_AWAY_KIT)
    self.im.Unsubscribe(BND_TEAM_CREST_INFO)
    self.im.Unsubscribe(BND_TEAM_CREST_STD)
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