-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

local PlayerNIB = {}
local OverlayParam, EventManager, TableUtil = ...
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local STATE_INACTIVE = "HIDE"
local STATE_UPDATE = "UPDATE"
local STATE_ACTIVE = "SHOW"
local SIDE_HOME = 0
local SIDE_AWAY = 1
local BND_ALPHA = "bnd_alpha"
local BND_STAMINA = "bnd_stamina"
local BND_PLAYER_INFO = "bnd_player_info"
local BND_ACTIVE = "bnd_active"
local bndHomeCrest = "bnd_home_team_crest"
local bndAwayCrest = "bnd_away_team_crest"
local bndRainVisible = "bnd_rain_visible"
local bndSnowVisible = "bnd_snow_visible"
local bndNibsOnSideVisible = "bnd_nibs_on_side_visible"
local bndNibsOnCenterVisible = "bnd_nibs_on_center_visible"
local bndNibsOnSingleVisible = "bnd_nibs_on_single_visible"
local bndNibsOffVisible = "bnd_nibs_off_visible"
local bndWeather = "bnd_weather_type"

local ACT_CAMERA_CHANGE = "act_camera_change"

local leagueIDs = {
   Algeria = 2262,
   Afc = 365,
   Argentina = 353,
   AsianCupU23 = 2264,
   Australia = 351,
   Austria = 80,
   Belgium = 4,
   Brazil = 7,
   Classic = 1245,
   Classic2 = 1246,
   ChampionshipEfl = 14,
   Denmark = 1,
   D1Arkema = 2218,
   Ecuador = 2018,
   Egypt = 2231,
   England = 13,
   France = 16,
   France2 = 17,
   Germany = 19,
   Germany2 = 20,
   Indonesia = 2235,
   International = 78,
   International2 = 2136,
   Italy = 31,
   Japan = 349,
   KoreaRepublic = 83,
   LeagueOneEfl = 60,
   LeagueTwoEfl = 61,
   LigaF = 2222,
   Malaysia = 2237,
   Marocco = 2250,
   Mexico = 341,
   Netherlands = 10,
   PegadaianLiga2 = 2254,
   Portugal = 308,
   RestOfWorld = 76,
   RestOfWorld2 = 77,
   Rusia = 67,
   SaudiArabia = 350,
   Scotland = 50,
   SouthAfrica = 347,
   Spain = 53,
   Spain2 = 54,
   Sweden = 56,
   Switzerland = 189,
   Thailand = 2252,
   Turkey = 68,
   Uefa = 2236,
   UefaUel = 2238,
   UefaWomens = 2240,
   Ukraine = 332,
   UnitedStates = 39,
   USANWSL = 2221,
   VanaramaFootballLeague = 62,
   Vietnam = 2260,
   WomensSuperLeague = 2216
}

GermanyTeamsData = {
  { teamid = 21, homeColor = "0xB80018", awayColor = "0xE0E0E0", homeFontColor = "0xE0E0E0", awayFontColor = "0xB80018" },
  { teamid = 22, homeColor = "0xF8D000", awayColor ="0x101010",homeFontColor = "0x101010", awayFontColor = "0xF8D000"},
  { teamid = 23, homeColor = "0xE0E0E0", awayColor ="0x30B060",homeFontColor = "0x30B060", awayFontColor = "0xE0E0E0"},
  { teamid = 32, homeColor = "0xB81020", awayColor = "0x101010",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},
  { teamid = 34, homeColor = "0x2838A0", awayColor = "0xD8D8D8",homeFontColor = "0xE0E0E0", awayFontColor = "0x2838A0"},
  { teamid = 36, homeColor = "0xd3d4d3", awayColor ="0xc62432",homeFontColor ="0xc62432" , awayFontColor = "0xd3d4d3"},
  { teamid = 38, homeColor = "0x289880", awayColor ="0xE1B5AD",homeFontColor ="0xE0E0E0" , awayFontColor = "0x289880"},
  { teamid = 166, homeColor = "0x284090" , awayColor ="0x182038",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},
  { teamid = 169, homeColor = "0xD01818", awayColor = "0xD8D8D8",homeFontColor = "0xD8D8D8", awayFontColor = "0xD01818"},
  { teamid = 175, homeColor = "0x50A830", awayColor ="0x383C3D",homeFontColor = "0xE0E0E0", awayFontColor = "0x50A830"},
  { teamid = 1824, homeColor = "0xd1d1d0" , awayColor = "0x363535",homeFontColor ="0x363535" , awayFontColor ="0xd1d1d0" },  
  { teamid = 576, homeColor = "0x355E9B", awayColor = "0xD4D4D2", homeFontColor = "0xD4D4D2", awayFontColor = "0x355E9B" },
  { teamid = 10029, homeColor ="0x204390" , awayColor = "0xcec29a",homeFontColor = "0xcec29a", awayFontColor = "0x204390"},  
  { teamid = 100409, homeColor = "0xaa2327", awayColor ="0xd2d1d0",homeFontColor = "0xd2d1d0", awayFontColor = "0xaa2327"},  
  { teamid = 112172, homeColor = "0xf9f8f8", awayColor ="0xa51b21",homeFontColor = "0xa51b21", awayFontColor = "0xf9f8f8"},  
  { teamid = 25, homeColor = "0x9c2225", awayColor ="0x3e4041",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},  
  { teamid = 1831, homeColor ="0xbc1e20" , awayColor ="0xd5cbbb",homeFontColor = "0xd5cbbb", awayFontColor ="0xbc1e20" },  
  { teamid = 160, homeColor ="0x1d3552" , awayColor ="0x65a7d4",homeFontColor = "0xE0E0E0", awayFontColor ="0x202838" },
  { teamid = 111235, homeColor = "0xD72228", awayColor ="0x325EA4",homeFontColor = "0x303F7E", awayFontColor = "0x353544"},  
  { teamid = 110329, homeColor = "0x4B3A33", awayColor = "0xE3E2E0", homeFontColor = "0xE3E2E0", awayFontColor = "0x4B3A33"},
}
Germany2TeamsData = {
  { teamid = 27, homeColor ="0x1D4382", awayColor = "0xC3C2C1", homeFontColor = "0xC3C2C1", awayFontColor = "0x1D4382"},
  { teamid = 29, homeColor ="0xB80018", awayColor = "0xC3C2C1", homeFontColor = "0xC3C2C1", awayFontColor = "0xB80018"},
  { teamid = 34, homeColor = "0x2838A0", awayColor = "0xD8D8D8",homeFontColor = "0xE0E0E0", awayFontColor = "0x2838A0"},
  { teamid = 159, homeColor = "0x2838A0", awayColor = "0xD8D8D8",homeFontColor = "0xE0E0E0", awayFontColor = "0x2838A0"},
  { teamid = 165, homeColor = "0x61D386" , awayColor ="0x000000",homeFontColor = "0x000000", awayFontColor = "0x61D386"},
  { teamid = 166, homeColor = "0x284090" , awayColor ="0x182038",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},
  { teamid = 171, homeColor = "0x3D181F", awayColor = "0xDFD5D3", homeFontColor = "0xDFD5D3", awayFontColor = "0x3D181F" },
  { teamid = 485, homeColor = "0x5F1A1D", awayColor = "0x202221", homeFontColor = "0x202221", awayFontColor = "0x5F1A1D" },
  { teamid = 543, homeColor = "0xD9D8D7", awayColor = "0xBD3640", homeFontColor = "0xBD3640", awayFontColor = "0xD9D8D7" },
  { teamid = 31, homeColor = "0xE0E0E0", awayColor = "0xE01820",homeFontColor = "0xE01820", awayFontColor = "0xE0E0E0" },
  { teamid = 1832, homeColor = "0x284390", awayColor = "0xF3E8E6", homeFontColor = "0xF3E8E6", awayFontColor = "0x284390" },
  { teamid = 10030, homeColor = "0x2F519B", awayColor = "0xEC242E", homeFontColor = "0xEC242E", awayFontColor = "0x2F519B" },
  { teamid = 110178, homeColor = "0xFEFEFE", awayColor ="0x1B1B1B", homeFontColor = "0x1B1B1B", awayFontColor = "0xFEFEFE"},
  { teamid = 110502, homeColor ="0x242948" , awayColor ="0xD2D1D0",homeFontColor = "0xD2D1D0", awayFontColor ="0x242948" },
  { teamid = 110500, homeColor = "0xFFE313", awayColor = "0x2D64B7", homeFontColor = "0x2D64B7", awayFontColor = "0xFFE313"},
  { teamid = 110588, homeColor = "0x0D3362", awayColor ="0x0F0F0F",homeFontColor = "0x0F0F0F", awayFontColor = "0x0D3362"},
  { teamid = 110636, homeColor = "0x891321", awayColor ="0xFFFFFD",homeFontColor = "0xFFFFFD", awayFontColor = "0x891321"},
}
SaudiArabiaTeamsData = { 
{ teamid = 605, homeColor = "0x0747B9", awayColor = "0xffffff", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 607, homeColor = "0xF7FA14", awayColor = "0xffffff", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 111674, homeColor = "0xffffff", awayColor = "0x000000", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112096, homeColor = "0x1B8362", awayColor = "0xBA0D17", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112139, homeColor = "0xF1F411", awayColor = "0x2F4256", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112192, homeColor = "0x383030", awayColor = "0xffffff", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112387, homeColor = "0xffffff", awayColor = "0x136145", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112390, homeColor = "0x233B7B", awayColor = "0xffffff", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112393, homeColor = "0xE3CD20", awayColor = "0x000000", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112408, homeColor = "0xBB2528", awayColor = "0xffffff", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112572, homeColor = "0xffffff", awayColor = "0x757376", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112883, homeColor = "0xE5CF20", awayColor = "0x204C28", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 112990, homeColor = "0x74B8D8", awayColor = "0xffffff", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 113037, homeColor = "0xC02820", awayColor = "0xCBCCC5", homeFontColor = "0x303030", awayFontColor = "0x000000" },
{ teamid = 113057, homeColor = "0xE3412A", awayColor = "0x1B2342", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 113058, homeColor = "0x5AADED", awayColor = "0xBD1E32", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 113060, homeColor = "0xCBCCC5", awayColor = "0x203448", homeFontColor = "0x000000", awayFontColor = "0xffffff" },
{ teamid = 113217, homeColor = "0xB3081D", awayColor = "0x000000", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 113222, homeColor = "0xD8D848", awayColor = "0x303850", homeFontColor = "0x202068", awayFontColor = "0xffffff" },
{ teamid = 113345, homeColor = "0x2B3A5B", awayColor = "0x911A40", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
}
EAFCSingle = {
  bnd_stamina_inner_bg = "0x00b2c3", bnd_stamina_outside_bg = "0x555555", bnd_stamina_width = 300, bnd_stamina_short_width = 0, bnd_stamina_bottom = 52,
  bnd_player_number = "", bnd_player_name = "", bnd_player_info_left = -223, bnd_player_number_color = "0xfffff", bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = { name = "$", id = 0 }, bnd_away_team_crest = { name = "$", id = 0 }, bnd_player_head = { name = "$Head", id = 0 }
}
EAFC = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 15,
  bnd_crest_bottom = 8,
  bnd_crest_height = 42,
  bnd_crest_width = 42,
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_alpha = 0,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x000000",
  bnd_bg_alpha = 0.35,  
  bnd_stamina_inner_bg = "0x00b2c3",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 46,
  bnd_player_number_bottom = -2,
  bnd_player_name_bottom = -2,
  bnd_player_number_fontSize = 13,
  bnd_player_name_fontSize = 13,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

AseanChampionshipInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 15,
  bnd_crest_bottom = 8,
  bnd_crest_height = 42,
  bnd_crest_width = 42,
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_alpha = 0,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x740007",
  bnd_stamina_inner_bg = "0xffffff",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 46,
  bnd_player_number_bottom = -2,
  bnd_player_name_bottom = -2,
  bnd_player_number_fontSize = 13,
  bnd_player_name_fontSize = 13,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

AfrikaCupNationInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 15,
  bnd_crest_bottom = 8,
  bnd_crest_height = 42,
  bnd_crest_width = 42,
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_alpha = 0,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0xB90919",
  bnd_stamina_inner_bg = "0x00D903",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 46,
  bnd_player_number_bottom = -2,
  bnd_player_name_bottom = -2,
  bnd_player_number_fontSize = 13,
  bnd_player_name_fontSize = 13,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

AfcLeague = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x2D065F",
  bnd_away_crest_bg = "0x2D065F",
  bnd_bg = "0x2D065F",
  bnd_stamina_inner_bg = "0x94DF2A",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0x94DF2A",
  bnd_player_name_color = "0x94DF2A",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}
AsianCupU23League= {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xFCDD10",
  bnd_away_crest_bg = "0xFCDD10",
  bnd_bg = "0xffffff",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xc20003",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0x000000",
  bnd_player_name_color = "0x000000",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

EnglandLeague = {
  bnd_fontFace = "$Epl", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x2F0B3A",
  bnd_stamina_inner_bg = "0x2b8ebf",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_bottom = 0,
  bnd_player_name_bottom = 0,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

FranceLeague= {
  bnd_fontFace = "$Ligue1", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x304FFF",
  bnd_away_crest_bg = "0x304FFF",
  bnd_bg = "0x304FFF",
  bnd_stamina_inner_bg = "0x2b8ebf",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_bottom = -4,
  bnd_player_name_bottom = -4,
  bnd_player_number_fontSize = 13,
  bnd_player_name_fontSize = 13,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

France2League= {
  bnd_fontFace = "$Ligue1", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x02FFCE",
  bnd_away_crest_bg = "0x02FFCE",
  bnd_bg = "0x02FFCE",
  bnd_stamina_inner_bg = "0x2b8ebf",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_bottom = -4,
  bnd_player_name_bottom = -4,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,
  bnd_player_number_color = "0x000000",
  bnd_player_name_color = "0x000000",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

GermanyLeague= {
  bnd_fontFace = "$Bundesliga", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "",
  bnd_away_crest_bg = "",
  bnd_bg = "0xdedade",
  bnd_stamina_inner_bg = "0x2b8ebf",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x130f13",
  bnd_player_name_color = "0x130f13",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

Germany2League= {
  bnd_fontFace = "$Bundesliga", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "",
  bnd_away_crest_bg = "",
  bnd_bg = "0xdedade",
  bnd_stamina_inner_bg = "0x2b8ebf",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x130f13",
  bnd_player_name_color = "0x130f13",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}


IndonesiaLeague= {
  bnd_fontFace = "$Liga1",
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x00519D",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

ItalyLeague= {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x0F2D61",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

JapanLeague= {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x000000",
  bnd_away_crest_bg = "0x000000",
  bnd_bg = "0x000000",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

LigaFLeague= {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x032A6F",
  bnd_away_crest_bg = "0x032A6F",
  bnd_bg = "0x032A6F",
  bnd_stamina_inner_bg = "0x14FEB7",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x14FEB7",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

MalaysiaLeague= {
  bnd_forceCaps = true,
  bnd_fontFace = "$Malaysia",
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x131262",
  bnd_stamina_inner_bg = "0x16FEC2",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x16FEC2",
  bnd_player_name_color = "0x16FEC2",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

PegadaianLiga2League= {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xAEDE26",
  bnd_away_crest_bg = "0xAEDE26",
  bnd_bg = "0x0D6046",
  bnd_stamina_inner_bg = "0xAEDE26",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

SaudiArabiaLeague= {
  bnd_forceCaps = true,  
  bnd_fontFace = "$SPL",  
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "",
  bnd_away_crest_bg = "",
  bnd_bg = "0xdedade",
  bnd_stamina_inner_bg = "0x2b8ebf",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x130f13",
  bnd_player_name_color = "0x130f13",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

SpainLeague= {
  bnd_fontFace = "$LaLiga", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x000000",
  bnd_away_crest_bg = "0x000000",
  bnd_bg = "0xffffff",
  bnd_stamina_inner_bg = "0xFD4A45",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 17,
  bnd_player_name_fontSize = 17,  
  bnd_player_number_color = "0xFD4A45",
  bnd_player_name_color = "0x000000",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

Spain2League= {
  bnd_fontFace = "$LaLiga", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x000000",
  bnd_away_crest_bg = "0x000000",
  bnd_bg = "0xffffff",
  bnd_stamina_inner_bg = "0x04D4D4",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 17,
  bnd_player_name_fontSize = 17, 
  bnd_player_number_color = "0x04D4D4",
  bnd_player_name_color = "0x000000",
  bnd_home_team_crest = {
      name = "$LaLigaTeamCrest",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$LaLigaTeamCrest",
      id = 0
  }
}

UefaLeague = {
  bnd_fontFace = "$UCL-Regular", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 15,
  bnd_crest_bottom = 8,
  bnd_crest_height = 42,
  bnd_crest_width = 42,
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_alpha = 0,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x0e36b5",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 46,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_number_bottom = 0,
  bnd_player_name_bottom = 0,
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

ThailandLeague = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0xFE0000",
  bnd_stamina_inner_bg = "0x00b2c3",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

WomensSuperLeague = {
  bnd_forceCaps = true, 
  bnd_fontFace = "$Epl",
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x1D0F33",
  bnd_stamina_inner_bg = "0x2b8ebf",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_bottom = 0,
  bnd_player_name_bottom = 0,
  bnd_player_number_fontSize = 17,
  bnd_player_name_fontSize = 17,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

UefaUelLeague = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-CondBold",
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 15,
  bnd_crest_bottom = 8,
  bnd_crest_height = 42,
  bnd_crest_width = 42,
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_alpha = 0,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x1F2120",
  bnd_stamina_inner_bg = "0xF96D20",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 46,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xF96D20",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

UefaWomensLeague = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 15,
  bnd_crest_bottom = 8,
  bnd_crest_height = 42,
  bnd_crest_width = 42,
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_alpha = 0,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x3471B2",
  bnd_stamina_inner_bg = "0x10DA15",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 46,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

UnitedStatesLeague= {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x1e1e1e",
  bnd_stamina_inner_bg = "0xAEDE26",
  bnd_stamina_outside_bg = "0xb9d2e2",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

WorldCup = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Qatar2022Arabic",
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x14C4A1",
  bnd_away_crest_bg = "0x14C4A1",
  bnd_bg = "0x3D031E",
  bnd_stamina_inner_bg = "0x64a4ed",
  bnd_stamina_outside_bg = "0x525534",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_bottom = -4,
  bnd_player_name_bottom = -4,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,
  bnd_player_number_color = "0x16D9B2",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$NationalCrest",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$NationalCrest",
      id = 0
  }
}

PialaIndonesia = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x3471B2",
  bnd_stamina_inner_bg = "0x10DA15",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

WcWomen = {
  bnd_fontFace = "$FWWC2023Bold",
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xF4F4DC",
  bnd_away_crest_bg = "0xF4F4DC",
  bnd_bg = "0x275759",
  bnd_stamina_inner_bg = "0x64a4ed",
  bnd_stamina_outside_bg = "0x525534",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_number_bottom = 0,
  bnd_player_name_bottom = 0,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

FaCup = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0xBF0D19",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_number_bottom = -4,
  bnd_player_name_bottom = -4,
  bnd_player_number_fontSize = 13,
  bnd_player_name_fontSize = 13,
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

Uecl = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 15,
  bnd_crest_bottom = 8,
  bnd_crest_height = 42,
  bnd_crest_width = 42,
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_alpha = 0,
  bnd_crest_bg = "",
  bnd_away_crest_bg = "",
  bnd_bg = "0x1F2120",
  bnd_stamina_inner_bg = "0x1DBB05",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 46,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x1DBB05",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

AsianCup = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x2D065F",
  bnd_away_crest_bg = "0x2D065F",
  bnd_bg = "0x2D065F",
  bnd_stamina_inner_bg = "0x94DF2A",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x94DF2A",
  bnd_player_name_color = "0x94DF2A",
  bnd_home_team_crest = {
      name = "$AsianCupCrest",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$AsianCupCrest",
      id = 0
  }
}

KingSaudiCup = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x000000",
  bnd_away_crest_bg = "0x000000",
  bnd_bg = "0x17573B",
  bnd_stamina_inner_bg = "0xFBDE98",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xFBDE98",
  bnd_player_name_color = "0xFBDE98",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

EuroCup = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xfffffff",
  bnd_away_crest_bg = "0xfffffff",
  bnd_bg = "0x1B38D2",
  bnd_stamina_inner_bg = "0xDDC100",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xDDC100",
  bnd_player_name_color = "0xfffffff",
  bnd_home_team_crest = {
      name = "$EuroCupCrest",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$EuroCupCrest",
      id = 0
  }
}

UsaOpenCup = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x1A2237",
  bnd_away_crest_bg = "0x1A2237",
  bnd_bg = "0xD5093A",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xfffffff",
  bnd_player_name_color = "0xfffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

CopaAmerica = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x0B2D6A",
  bnd_stamina_inner_bg = "0xffffff",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$CopaAmerikaCrest",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$CopaAmerikaCrest",
      id = 0
  }
}

CopaDelRey = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xE60035",
  bnd_away_crest_bg = "0xE60035",
  bnd_bg = "0x000000",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

AfricaCup = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xffffff",
  bnd_away_crest_bg = "0xffffff",
  bnd_bg = "0x064534",
  bnd_stamina_inner_bg = "0xFC7824",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xFC7824",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$AfconCrest",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$AfconCrest",
      id = 0
  }
}

CoppaItalia = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xaa2c1d",
  bnd_away_crest_bg = "0xaa2c1d",
  bnd_bg = "0xaa2c1d",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

DfbPokal = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x089655",
  bnd_away_crest_bg = "0x089655",
  bnd_bg = "0xD2D7D1",
  bnd_stamina_inner_bg = "0x0da0cc",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x089655",
  bnd_player_name_color = "0x000000",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

ClassicLeague = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x6C0016",
  bnd_away_crest_bg = "0x6C0016",
  bnd_bg = "0x000000",
  bnd_stamina_inner_bg = "0x22C1A3",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xFFFFFF",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

CoupeDeFrance = {
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x071A31",
  bnd_away_crest_bg = "0x071A31",
  bnd_bg = "0x071A31",
  bnd_stamina_inner_bg = "0x1A8EC4",
  bnd_stamina_outside_bg = "0xffffff",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x1A8EC4",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

FcWc = {
  bnd_fontFace = "$CruyffSans-Medium",	
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0xD0950B",
  bnd_away_crest_bg = "0xD0950B",
  bnd_bg = "0x000000",
  bnd_stamina_inner_bg = "0xD0950B",
  bnd_stamina_outside_bg = "0xFFFFFF",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = {
      name = "$Crest64x64",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$Crest64x64",
      id = 0
  }
}

UefaNations = {
  bnd_fontFace = "$UEFANations-Bold",
  bnd_crestBg_left = -357,
  bnd_crestBg_bottom = 10.5,
  bnd_crest_bottom = 12.5,
  bnd_crest_height = 33,
  bnd_crest_width = 33,
  bnd_crestBg_width = 38,
  bnd_crestBg_height = 38,
  bnd_crestBg_alpha = 1,
  bnd_crest_bg = "0x253242",
  bnd_away_crest_bg = "0x253242",
  bnd_bg = "0xF9FDFD",
  bnd_stamina_inner_bg = "0x253242",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 213,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 45,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_fontSize = 15,
  bnd_player_name_fontSize = 15,  
  bnd_player_number_color = "0x253242",
  bnd_player_name_color = "0x253242",
  bnd_home_team_crest = {
      name = "$NationalCrest",
      id = 0
  },
  bnd_away_team_crest = {
      name = "$NationalCrest",
      id = 0
  }
}
function PlayerNIB:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    GameStateService = o.api("GameStateService"),
    matchInfo = o.api("MatchInfoService"),
    userPlate = o.api("UserPlateService"),
    settingsService = o.api("SettingsService"),
    gameSetupService = o.api("GameSetupService"),
    EventManagerService = o.api("EventManagerService"),
    TeamService = o.api("TeamService")
  }
  o.side = o.data and o.data.side or SIDE_HOME

  o.cameraIndex = cameraIndex

  o.currentLeague = {}
  o.TeamsData = o.services.matchInfo.GetMatchTeams()
  
  local AlgeriaTeams = o.services.TeamService.GetTeams(leagueIDs.Algeria, 0, 0, true)
  local AfcTeams = o.services.TeamService.GetTeams(leagueIDs.Afc, 0, 0, true)
  local ArgentinaTeams = o.services.TeamService.GetTeams(leagueIDs.Argentina, 0, 0, true)
  local AsianCupU23Teams = o.services.TeamService.GetTeams(leagueIDs.AsianCupU23, 0, 0, true)
  local BelgiumTeams = o.services.TeamService.GetTeams(leagueIDs.Belgium, 0, 0, true)
  local BrazilTeams = o.services.TeamService.GetTeams(leagueIDs.Brazil, 0, 0, true)
  local ClassicTeams = o.services.TeamService.GetTeams(leagueIDs.Classic, 0, 0, true)
  local Classic2Teams = o.services.TeamService.GetTeams(leagueIDs.Classic2, 0, 0, true)
  local ChampionshipEflTeams = o.services.TeamService.GetTeams(leagueIDs.ChampionshipEfl, 0, 0, true)
  local DenmarkTeams = o.services.TeamService.GetTeams(leagueIDs.Denmark, 0, 0, true)
  local D1ArkemaTeams = o.services.TeamService.GetTeams(leagueIDs.D1Arkema, 0, 0, true)
  local EcuadorTeams = o.services.TeamService.GetTeams(leagueIDs.Ecuador, 0, 0, true)
  local EgyptTeams = o.services.TeamService.GetTeams(leagueIDs.Egypt, 0, 0, true)
  local EnglandTeams = o.services.TeamService.GetTeams(leagueIDs.England, 0, 0, true)
  local FranceTeams = o.services.TeamService.GetTeams(leagueIDs.France, 0, 0, true)
  local France2Teams = o.services.TeamService.GetTeams(leagueIDs.France2, 0, 0, true)
  local GermanyTeams = o.services.TeamService.GetTeams(leagueIDs.Germany, 0, 0, true)
  local Germany2Teams = o.services.TeamService.GetTeams(leagueIDs.Germany2, 0, 0, true)
  local IndonesiaTeams = o.services.TeamService.GetTeams(leagueIDs.Indonesia, 0, 0, true)
  local InternationalTeams = o.services.TeamService.GetTeams(leagueIDs.International, 0, 0, true)
  local International2Teams = o.services.TeamService.GetTeams(leagueIDs.International2, 0, 0, true)
  local ItalyTeams = o.services.TeamService.GetTeams(leagueIDs.Italy, 0, 0, true)
  local JapanTeams = o.services.TeamService.GetTeams(leagueIDs.Japan, 0, 0, true)
  local KoreaRepublicTeams = o.services.TeamService.GetTeams(leagueIDs.KoreaRepublic, 0, 0, true)
  local LeagueOneEflTeams = o.services.TeamService.GetTeams(leagueIDs.LeagueOneEfl, 0, 0, true)
  local LeagueTwoEflTeams = o.services.TeamService.GetTeams(leagueIDs.LeagueTwoEfl, 0, 0, true)
  local LigaFTeams = o.services.TeamService.GetTeams(leagueIDs.LigaF, 0, 0, true)
  local MalaysiaTeams = o.services.TeamService.GetTeams(leagueIDs.Malaysia, 0, 0, true)
  local MexicoTeams = o.services.TeamService.GetTeams(leagueIDs.Mexico, 0, 0, true)
  local MoroccoTeams = o.services.TeamService.GetTeams(leagueIDs.Morocco, 0, 0, true)
  local NetherlandsTeams = o.services.TeamService.GetTeams(leagueIDs.Netherlands, 0, 0, true)
  local PegadaianLiga2Teams = o.services.TeamService.GetTeams(leagueIDs.PegadaianLiga2, 0, 0, true)
  local PortugalTeams = o.services.TeamService.GetTeams(leagueIDs.Portugal, 0, 0, true)
  local RestOfWorldTeams = o.services.TeamService.GetTeams(leagueIDs.RestOfWorld, 0, 0, true)
  local RestOfWorld2Teams = o.services.TeamService.GetTeams(leagueIDs.RestOfWorld2, 0, 0, true)
  local RusiaTeams = o.services.TeamService.GetTeams(leagueIDs.Rusia, 0, 0, true)
  local SaudiArabiaTeams = o.services.TeamService.GetTeams(leagueIDs.SaudiArabia, 0, 0, true)
  local ScotlandTeams = o.services.TeamService.GetTeams(leagueIDs.Scotland, 0, 0, true)
  local SouthAfricaTeams = o.services.TeamService.GetTeams(leagueIDs.SouthAfrica, 0, 0, true)
  local SpainTeams = o.services.TeamService.GetTeams(leagueIDs.Spain, 0, 0, true)
  local Spain2Teams = o.services.TeamService.GetTeams(leagueIDs.Spain2, 0, 0, true)
  local SwedenTeams = o.services.TeamService.GetTeams(leagueIDs.Sweden, 0, 0, true)
  local SwitzerlandTeams = o.services.TeamService.GetTeams(leagueIDs.Switzerland, 0, 0, true)
  local ThailandTeams = o.services.TeamService.GetTeams(leagueIDs.Thailand, 0, 0, true)
  local TurkeyTeams = o.services.TeamService.GetTeams(leagueIDs.Turkey, 0, 0, true)
  local UefaTeams = o.services.TeamService.GetTeams(leagueIDs.Uefa, 0, 0, true)
  local UefaUelTeams = o.services.TeamService.GetTeams(leagueIDs.UefaUel, 0, 0, true)
  local UefaWomensTeams = o.services.TeamService.GetTeams(leagueIDs.UefaWomens, 0, 0, true)
  local UkraineTeams = o.services.TeamService.GetTeams(leagueIDs.Ukraine, 0, 0, true)
  local UnitedStatesTeams = o.services.TeamService.GetTeams(leagueIDs.UnitedStates, 0, 0, true)
  local USANWSLTeams = o.services.TeamService.GetTeams(leagueIDs.USANWSL, 0, 0, true)
  local VanaramaFootballLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.VanaramaFootballLeague, 0, 0, true)
  local VietnamTeams = o.services.TeamService.GetTeams(leagueIDs.Vietnam, 0, 0, true)
  local WomensSuperLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.WomensSuperLeague, 0, 0, true)
  
  -- [1] BACA SESSIONVARS LEBIH DULU
  local league = nil
  if sessionVars and type(sessionVars.get) == "function" then
      league = sessionVars.get("currentUserLeagueID")
  end

  if league then
      if league == 13 then o.currentLeague = EnglandLeague
      elseif league == 16 then o.currentLeague = FranceLeague
      elseif league == 17 then o.currentLeague = France2League
      elseif league == 19 then o.currentLeague = GermanyLeague
      elseif league == 20 then o.currentLeague = Germany2League
      elseif league == 31 then o.currentLeague = ItalyLeague
      elseif league == 53 then o.currentLeague = SpainLeague
      elseif league == 54 then o.currentLeague = Spain2League
      elseif league == 2235 then o.currentLeague = IndonesiaLeague
      elseif league == 2254 then o.currentLeague = PegadaianLiga2League
      elseif league == 350 then o.currentLeague = SaudiArabiaLeague
      elseif league == 39 or league == 2221 then o.currentLeague = UnitedStatesLeague
      elseif league == 349 then o.currentLeague = JapanLeague
      elseif league == 2222 then o.currentLeague = LigaFLeague
      elseif league == 2237 then o.currentLeague = MalaysiaLeague
      elseif league == 2252 then o.currentLeague = ThailandLeague
      elseif league == 2236 then o.currentLeague = UefaLeague
      elseif league == 2238 then o.currentLeague = UefaUelLeague
      elseif league == 2240 then o.currentLeague = UefaWomensLeague
      elseif league == 365 then o.currentLeague = AfcLeague
      elseif league == 2264 then o.currentLeague = AsianCupU23League
      elseif league == 1245 or league == 1246 then o.currentLeague = ClassicLeague
      else o.currentLeague = EAFC
      end
      
  -- [2] CEK CUP SECARA AMAN (Cegah Crash)
  elseif currentCupData and currentCupData.cupIndex and currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      o.currentLeague = UefaLeague
    elseif currentCupData.cupIndex == 2 then
      o.currentLeague = WorldCup
    elseif currentCupData.cupIndex == 3 then
      o.currentLeague = UefaUelLeague
    elseif currentCupData.cupIndex == 4 then
      o.currentLeague = PialaIndonesia 
    elseif currentCupData.cupIndex == 5 then
      o.currentLeague = WcWomen
    elseif currentCupData.cupIndex == 6 then
      o.currentLeague = UefaWomensLeague
    elseif currentCupData.cupIndex == 7 then
      o.currentLeague = FaCup
    elseif currentCupData.cupIndex == 8 then
      o.currentLeague = Uecl
    elseif currentCupData.cupIndex == 9 then
      o.currentLeague = AsianCup
    elseif currentCupData.cupIndex == 10 then
      o.currentLeague = KingSaudiCup
    elseif currentCupData.cupIndex == 11 then
      o.currentLeague = EuroCup
    elseif currentCupData.cupIndex == 12 then
      o.currentLeague = UsaOpenCup
    elseif currentCupData.cupIndex == 13 then
      o.currentLeague = CopaAmerica
    elseif currentCupData.cupIndex == 14 then
      o.currentLeague = CopaDelRey
    elseif currentCupData.cupIndex == 15 then
      o.currentLeague = CoppaItalia
    elseif currentCupData.cupIndex == 16 then
      o.currentLeague = DfbPokal
    elseif currentCupData.cupIndex == 17 then
      o.currentLeague = CoupeDeFrance
    elseif currentCupData.cupIndex == 18 then
      o.currentLeague = FcWc 
    elseif currentCupData.cupIndex == 19 then
      o.currentLeague = EAFC
    elseif currentCupData.cupIndex == 20 then
      o.currentLeague = UefaNations 
    end
    
  -- [3] CEK TOUR SECARA AMAN (Cegah Crash & Fix Typo)
  elseif currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      o.currentLeague = UefaLeague
    elseif currentTourData.tourIndex == 2 then
      o.currentLeague = WorldCup
    elseif currentTourData.tourIndex == 3 then
      o.currentLeague = UefaUelLeague
    elseif currentTourData.tourIndex == 29 then
      o.currentLeague = PialaIndonesia
    elseif currentTourData.tourIndex == 26 then
      o.currentLeague = AfrikaCupNationInfo           
    elseif currentTourData.tourIndex == 27 then
      o.currentLeague = AseanChampionshipInfo      
    elseif currentTourData.tourIndex == 16 then
      o.currentLeague = UefaWomensLeague
    elseif currentTourData.tourIndex == 35 then
      o.currentLeague = WcWomen -- FIXED: Sebelumnya WCWomens (bikin crash)
    elseif currentTourData.tourIndex == 9 then
      o.currentLeague = FaCup
    elseif currentTourData.tourIndex == 17 then
      o.currentLeague = Uecl
    elseif currentTourData.tourIndex == 34 then
      o.currentLeague = AsianCup
    elseif currentTourData.tourIndex == 6 then
      o.currentLeague = EuroCup
    elseif currentTourData.tourIndex == 13 then
      o.currentLeague = UsaOpenCup
    elseif currentTourData.tourIndex == 25 then
      o.currentLeague = CopaAmerica
    elseif currentTourData.tourIndex == 10 then
      o.currentLeague = CopaDelRey
    elseif currentTourData.tourIndex == 11 then
      o.currentLeague = CoppaItalia
    elseif currentTourData.tourIndex == 7 then
      o.currentLeague = DfbPokal
    elseif currentTourData.tourIndex == 18 then
      o.currentLeague = CoupeDeFrance
    elseif currentTourData.tourIndex == 15 then
      o.currentLeague = FcWc
    elseif currentTourData.tourIndex == 4 then
      o.currentLeague = EAFC -- FIXED: Sebelumnya CopaLibertadores tidak ada datanya
    elseif currentTourData.tourIndex == 22 then
      o.currentLeague = EAFC      
    elseif currentTourData.tourIndex == 28 then
      o.currentLeague = UefaNations
    elseif currentTourData.tourIndex == 50 then
      o.currentLeague = KingSaudiCup     
    elseif currentTourData.tourIndex == 24 or currentTourData.tourIndex == 31 or currentTourData.tourIndex == 21 then
      o.currentLeague = EAFC    
    else 
      o.currentLeague = EAFC     
    end          
  
  -- [4] FALLBACK TERAKHIR (In-game Match)
  else
      if o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], AfcTeams) and o:isInTable(o.TeamsData[2], AfcTeams) then
        o.currentLeague = AfcLeague
      elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
        o.currentLeague = AsianCupU23League
      elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
        o.currentLeague = ClassicLeague
      elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
        o.currentLeague = ClassicLeague
      elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
        o.currentLeague = EnglandLeague
      elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
        o.currentLeague = FranceLeague
      elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
        o.currentLeague = France2League
      elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
        o.currentLeague = GermanyLeague
        local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, GermanyTeamsData)
        local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, GermanyTeamsData)
        o.currentLeague.bnd_crest_bg = homeColorList[1]
        o.currentLeague.bnd_away_crest_bg = awayColorList[1]
      elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
        o.currentLeague = Germany2League
        local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Germany2TeamsData)
        local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Germany2TeamsData)
        o.currentLeague.bnd_crest_bg = homeColorList[1]
        o.currentLeague.bnd_away_crest_bg = awayColorList[1]
      elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
        o.currentLeague = IndonesiaLeague
      elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
        o.currentLeague = ItalyLeague
      elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
        o.currentLeague = JapanLeague
      elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
        o.currentLeague = LigaFLeague
      elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
        o.currentLeague = MalaysiaLeague
      elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
        o.currentLeague = PegadaianLiga2League
      elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], RusiaTeams) and o:isInTable(o.TeamsData[2], RusiaTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
        o.currentLeague = SaudiArabiaLeague
        local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, SaudiArabiaTeamsData)
        local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, SaudiArabiaTeamsData)
        o.currentLeague.bnd_crest_bg = homeColorList[1]
        o.currentLeague.bnd_away_crest_bg = awayColorList[1]
      elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
        o.currentLeague = SpainLeague
      elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
        o.currentLeague = Spain2League
      elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
        o.currentLeague = ThailandLeague
      elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
        o.currentLeague = UefaLeague
      elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
        o.currentLeague = UefaUelLeague
      elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
        o.currentLeague = UefaWomensLeague
      elseif o:isInTable(o.TeamsData[1], UkraineTeams) and o:isInTable(o.TeamsData[2], UkraineTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
        o.currentLeague = UnitedStatesLeague
      elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USANWSLTeams) then
        o.currentLeague = UnitedStatesLeague
      elseif o:isInTable(o.TeamsData[1], VanaramaFootballLeagueTeams) and o:isInTable(o.TeamsData[2], VanaramaFootballLeagueTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
        o.currentLeague = EAFC
      elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
        o.currentLeague = WomensSuperLeague
      else 
        o.currentLeague = EAFC
      end
  end

  o.im.Subscribe(BND_ACTIVE, function()
    o:_publishActivity()
  end
  )
  o.im.Subscribe(BND_ALPHA, function()
    o:_publishAlpha()
  end
  )
  o.im.Subscribe(BND_PLAYER_INFO, function()
    o:_publishPlayerInfo()
  end
  )
  o.im.Subscribe(BND_STAMINA, function()
    o:_publishStamina()
  end
  )
  
  o.currentLeague.bnd_home_team_crest.id = o.TeamsData[1].assetId
  o.currentLeague.bnd_away_team_crest.id = o.TeamsData[2].assetId

  for k,v in pairs(o.currentLeague) do
    o.im.Subscribe(k, function()
      if k == "bnd_stamina_width" or k == "bnd_stamina_short_width" then
        o:_publishStamina()
      elseif k == "bnd_player_number" or k == "bnd_player_name" then
        o:_publishPlayerInfo()
      else
        o.im.Publish(k, v)
      end
    end)
  end

  weatherType = {
     name = "$Weather",
     id = 0
  }
  random = currentMatchWeather
  if currentMatchWeather == 1 then
    random = math.random(2, 8)
  end

  o.im.Subscribe(bndRainVisible, function()
    if random == 6 then
      o.im.Publish(bndRainVisible, true)
    else 
      o.im.Publish(bndRainVisible, false)
    end
  end
  )
  o.im.Subscribe(bndSnowVisible, function()
    if random == 8 then
      o.im.Publish(bndSnowVisible, true)
    else 
      o.im.Publish(bndSnowVisible, false)
    end
  end
  )
  o.im.Subscribe(bndWeather, function()
    if random == 3 then
       weatherType.id = 1
      o.im.Publish(bndWeather, weatherType)
    elseif random == 4 then
       weatherType.id = 2
    o.im.Publish(bndWeather, weatherType)
    elseif random == 5 or random == 6 then
       weatherType.id = 4
       o.im.Publish(bndWeather, weatherType)
    elseif random == 7 or random == 8 then
       weatherType.id = 3
      o.im.Publish(bndWeather, weatherType)
    else
       weatherType.id = 0
       o.im.Publish(bndWeather, weatherType)
    end
    o.im.Publish(bndWeather, weatherType)
  end
  )
  o.statsPL= {
    name = "$Stats_Playernib",
    id = 0
  }
  math.randomseed(os.clock() * 132 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(3)
  
  o.im.Subscribe("bnd_statsPL", function()
    o.statsPL.id = random2
    o.im.Publish("bnd_statsPL", o.statsPL)
  end)
  
  o.isUserHome = o.services.gameSetupService.IsHostTeam()
  
  o:setState(STATE_INACTIVE)
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end
  )
  
  o.im.RegisterAction("act_camera_change", function(actionName)
    o:_updateCamera()
    
  end)  

  playernibOption = currentPlayernibOption
  o.im.Subscribe(bndNibsOnSideVisible, function() o.im.Publish(bndNibsOnSideVisible, playernibOption == 0) end)
  o.im.Subscribe(bndNibsOnCenterVisible, function() o.im.Publish(bndNibsOnCenterVisible, playernibOption == 1) end)
  o.im.Subscribe(bndNibsOnSingleVisible, function() if playernibOption == 2 then o.currentLeague = EAFCSingle end; o.im.Publish(bndNibsOnSingleVisible, playernibOption == 2) end)
  o.im.Subscribe(bndNibsOffVisible, function() o.im.Publish(bndNibsOffVisible, playernibOption == 3) end)  
  return o
end


function PlayerNIB:setState(state)
  self.state = state or STATE_INACTIVE
  self:_publishActivity()
end

function PlayerNIB:getPlayerInfo(params)
  return {
    name = params[9],
    number = params[12]
  }
end

function PlayerNIB:getStamina(params)
  return {
    stamina = tonumber(params[1]),
    shortStamina = tonumber(params[2])
  }
end

function PlayerNIB:_onPlayerNIBUpdate(subtype, hideshow, subtypestr, msg)
  self:setState(hideshow)
  if self.state ~= STATE_INACTIVE and msg ~= nil and msg ~= "" then
    local params = OverlayParam.split(msg, "|")
    if table.getn(params) == 1 then
      if tonumber(params[1]) ~= nil then
        local alpha = tonumber(params[1]) / 100
        self:_publishAlpha(alpha)
      end
    elseif table.getn(params) == 2 then
    elseif table.getn(params) == 3 then
    elseif table.getn(params) == 8 then
      self.stamina = self:getStamina(params)
      self:_publishStamina()
    elseif table.getn(params) == 10 then
      self.stamina = self:getStamina(params)
      self:_publishStamina()
    elseif table.getn(params) == 16 then
      self.playerInfo = self:getPlayerInfo(params)
      self.stamina = self:getStamina(params)
      self:_publishPlayerInfo()
      self:_publishStamina()
    elseif table.getn(params) == 17 then
      self.playerInfo = self:getPlayerInfo(params)
      self.stamina = self:getStamina(params)
      self:_publishPlayerInfo()
      self:_publishStamina()
    end
  end
end

function PlayerNIB:_publishActivity()
  self.im.Publish(BND_ACTIVE, self.state ~= STATE_INACTIVE)
end

function PlayerNIB:_publishAlpha(alpha)
  self.im.Publish(BND_ALPHA, alpha or 1)
end

function PlayerNIB:_publishPlayerInfo()
  if self.playerInfo == nil then
    return
  end
  self.im.Publish(BND_PLAYER_INFO, self.playerInfo)
 self.im.Publish("bnd_player_number", tostring(self.playerInfo["number"]))
 self.im.Publish("bnd_player_name", self.playerInfo["name"])
end

function PlayerNIB:_publishStamina()
  if self.stamina == nil then
    return
  end
  self.im.Publish(BND_STAMINA, self.stamina)
  self.im.Publish("bnd_stamina_width", self.currentLeague.bnd_stamina_width)
  local r0 = self.stamina["shortStamina"] / self.stamina["stamina"]
  local r1 = self.currentLeague.bnd_stamina_width * r0
  self.im.Publish("bnd_stamina_short_width", r1)
end


function PlayerNIB:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.OverlayTypeNIBBL and self.side == SIDE_HOME or eventType == EVENT_TYPES.OverlayTypeNIBBR and self.side == SIDE_AWAY then
    self:_onPlayerNIBUpdate(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function PlayerNIB:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function PlayerNIB:getTeamHomeColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.homeColor
      result[2] = v.homeFontColor
    end
  end
  return result
end

function PlayerNIB:getTeamAwayColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.awayColor
      result[2] = v.awayFontColor
    end
  end
  return result
end

function PlayerNIB:_updateCamera()
  if self.cameraIndex >= 7 then
    self.cameraIndex = 0
  else
    self.cameraIndex = self.cameraIndex + 1
  end
  self.services.settingsService.SaveCameraValue(self.cameraIndex)
end

function PlayerNIB:finalize()
  self.im.Unsubscribe(BND_ACTIVE)
  self.im.Unsubscribe(BND_ALPHA)
  self.im.Unsubscribe(BND_PLAYER_INFO)
  self.im.Unsubscribe(BND_STAMINA)
  self.im.Unsubscribe(bndHomeCrest)
  self.im.Unsubscribe(bndAwayCrest)
  self.im.Unsubscribe(bndRainVisible)
  self.im.Unsubscribe(bndSnowVisible)
  self.im.Unsubscribe(bndWeather)
  self.im.Unsubscribe(bndNibsOnSideVisible)
  self.im.Unsubscribe(bndNibsOnCenterVisible)
  self.im.Unsubscribe(bndNibsOnSingleVisible)
  self.im.Unsubscribe(bndNibsOffVisible)  
  self.im.Unsubscribe("bnd_statsPL")
  for k,v in pairs(EnglandLeague) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return PlayerNIB
