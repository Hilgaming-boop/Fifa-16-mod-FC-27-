-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

local ScoreClock = {}

local OverlaysIdContainer, OverlayParam, eventmanager, TableUtil = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

DfbPokalTeamsData = {
  { teamid = 10029, homeColor ="0x204390" , awayColor = "0xcec29a",homeFontColor = "0xcec29a", awayFontColor = "0x204390"},  
  { teamid = 111235, homeColor = "0xD72228", awayColor ="0x325EA4",homeFontColor = "0x303F7E", awayFontColor = "0x353544"},  
  { teamid = 31, homeColor = "0xE0E0E0", awayColor = "0xE01820",homeFontColor = "0xE01820", awayFontColor = "0xE0E0E0" },
  { teamid = 169, homeColor = "0xD01818", awayColor = "0xD8D8D8",homeFontColor = "0xD8D8D8", awayFontColor = "0xD01818"},
  { teamid = 32, homeColor = "0xB81020", awayColor = "0x101010",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},
  { teamid = 22, homeColor = "0xF8D000", awayColor ="0x101010",homeFontColor = "0x101010", awayFontColor = "0xF8D000"},
  { teamid = 23, homeColor = "0xE0E0E0", awayColor ="0x30B060",homeFontColor = "0x30B060", awayFontColor = "0xE0E0E0"},
  { teamid = 1824, homeColor = "0xd1d1d0" , awayColor = "0x363535",homeFontColor ="0x363535" , awayFontColor ="0xd1d1d0" },  
  { teamid = 100409, homeColor = "0xaa2327", awayColor ="0xd2d1d0",homeFontColor = "0xd2d1d0", awayFontColor = "0xaa2327"},	
  { teamid = 21, homeColor = "0xB80018", awayColor = "0xE0E0E0", homeFontColor = "0xE0E0E0", awayFontColor = "0xB80018" },
  { teamid = 112172, homeColor = "0xf9f8f8", awayColor ="0xa51b21",homeFontColor = "0xa51b21", awayFontColor = "0xf9f8f8"},  
  { teamid = 25, homeColor = "0x9c2225", awayColor ="0x3e4041",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},  
  { teamid = 110502, homeColor ="0x242948" , awayColor ="0xD2D1D0",homeFontColor = "0xD2D1D0", awayFontColor ="0x242948" },
  { teamid = 1831, homeColor ="0xbc1e20" , awayColor ="0xd5cbbb",homeFontColor = "0xd5cbbb", awayFontColor ="0xbc1e20" },  
  { teamid = 36, homeColor = "0xd3d4d3", awayColor ="0xc62432",homeFontColor ="0xc62432" , awayFontColor = "0xd3d4d3"},
  { teamid = 160, homeColor ="0x1d3552" , awayColor ="0x65a7d4",homeFontColor = "0xE0E0E0", awayFontColor ="0x202838" },
  { teamid = 175, homeColor = "0x50A830", awayColor ="0x383C3D",homeFontColor = "0xE0E0E0", awayFontColor = "0x50A830"},
  { teamid = 38, homeColor = "0x289880", awayColor ="0xE1B5AD",homeFontColor ="0xE0E0E0" , awayFontColor = "0x289880"},
  { teamid = 110588, homeColor = "0x0D3362", awayColor ="0x0F0F0F",homeFontColor = "0x0F0F0F", awayFontColor = "0x0D3362"},
  { teamid = 171, homeColor = "0x3D181F", awayColor = "0xDFD5D3", homeFontColor = "0xDFD5D3", awayFontColor = "0x3D181F" },
  { teamid = 110500, homeColor = "0xFFE313", awayColor = "0x2D64B7", homeFontColor = "0x2D64B7", awayFontColor = "0xFFE313"},
  { teamid = 34, homeColor = "0x2838A0", awayColor = "0xD8D8D8",homeFontColor = "0xE0E0E0", awayFontColor = "0x2838A0"},
  { teamid = 110329, homeColor = "0x4B3A33", awayColor = "0xE3E2E0", homeFontColor = "0xE3E2E0", awayFontColor = "0x4B3A33"},
  { teamid = 110636, homeColor = "0x891321", awayColor ="0xFFFFFD",homeFontColor = "0xFFFFFD", awayFontColor = "0x891321"},
  { teamid = 165, homeColor = "0x61D386" , awayColor ="0x000000",homeFontColor = "0x000000", awayFontColor = "0x61D386"},
  { teamid = 485, homeColor = "0x5F1A1D", awayColor = "0x202221", homeFontColor = "0x202221", awayFontColor = "0x5F1A1D" },
  { teamid = 27, homeColor ="0x1D4382", awayColor = "0xC3C2C1", homeFontColor = "0xC3C2C1", awayFontColor = "0x1D4382"},
  { teamid = 166, homeColor = "0x284090" , awayColor ="0x182038",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},  
  { teamid = 29, homeColor ="0xB80018", awayColor = "0xC3C2C1", homeFontColor = "0xC3C2C1", awayFontColor = "0xB80018"},
  { teamid = 1832, homeColor = "0x284390", awayColor = "0xF3E8E6", homeFontColor = "0xF3E8E6", awayFontColor = "0x284390" },
  { teamid = 580, homeColor = "0x891321", awayColor ="0xFFFFFD",homeFontColor = "0xFFFFFD", awayFontColor = "0x891321"},
  { teamid = 492, homeColor = "0x3D181F", awayColor = "0xDFD5D3", homeFontColor = "0xDFD5D3", awayFontColor = "0x3D181F" },
}
UCLTeamsData = {
   { teamid = 1, homeColor = "0xc82727", awayColor = "0xCDCD38", homeFontColor = "0xCDCD38", awayFontColor = "0xc82727" },
   { teamid = 10, homeColor = "0x669dc9", awayColor = "0x292928",homeFontColor = "0xE0E0E0", awayFontColor = "0x2838A0"},
   { teamid = 11, homeColor = "0xb7243b", awayColor ="0xd8d8d6",homeFontColor ="0xE0E0E0" , awayFontColor = "0x289880"},
   { teamid = 13, homeColor = "0xd7d6d5" , awayColor ="0x252845",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},
   { teamid = 21, homeColor = "0xB80018", awayColor = "0xE0E0E0", homeFontColor = "0xE0E0E0", awayFontColor = "0xB80018" },
   { teamid = 22, homeColor = "0xF8D000", awayColor ="0x101010",homeFontColor = "0x101010", awayFontColor = "0xF8D000"},
   { teamid = 44, homeColor = "0x2B40DB", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x2B40DB"},
   { teamid = 46, homeColor = "0x79B8E8", awayColor ="0x000000",homeFontColor = "0x000000", awayFontColor = "0x79B8E8"},
   { teamid = 47, homeColor = "0xB92C30", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0xB92C30"},
   { teamid = 48, homeColor = "0x3798FD", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x3798FD"},
   { teamid = 64, homeColor = "0xFED720", awayColor ="0x156E4E",homeFontColor = "0x156E4E", awayFontColor = "0xFED720"},
   { teamid = 73, homeColor = "0x2A2A44", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x2A2A44"},
   { teamid = 78, homeColor = "0x255033", awayColor ="0x000000",homeFontColor = "0x000000", awayFontColor = "0x255033"},
   { teamid = 191, homeColor = "0xffffff", awayColor ="0x2a2a44",homeFontColor = "0x2a2a44", awayFontColor = "0xffffff"},
   { teamid = 234, homeColor = "0xD51F28", awayColor ="0xD0B020",homeFontColor = "0xD0B020", awayFontColor = "0xD51F28"},
   { teamid = 236, homeColor = "0x204888", awayColor ="0xD0CB70",homeFontColor = "0xD0CB70", awayFontColor = "0x204888"},
   { teamid = 240, homeColor = "0x7C090F", awayColor = "0x18368C", homeFontColor = "0x18368C", awayFontColor = "0x7C090F" },
   { teamid = 241, homeColor = "0x22229B", awayColor = "0x73EFEF", homeFontColor = "0x73EFEF", awayFontColor = "0x22229B"},
   { teamid = 243, homeColor = "0xDFDFDB", awayColor = "0x5C6182", homeFontColor = "0x5C6182", awayFontColor = "0xDFDFDB" },
   { teamid = 246, homeColor = "0xB91F27", awayColor = "0x8BB6D8", homeFontColor = "0x8BB6D8", awayFontColor = "0x0xB91F27" },
   { teamid = 457, homeColor = "0x375289", awayColor = "0x3C3C3B", homeFontColor = "0x3C3C3B", AwayFontColor = "0x375289" },
   { teamid = 481, homeColor = "0xE6E5E4", awayColor ="0x84262F",  homeFontColor = "0x84262F", AwayFontColor = "0xE6E5E4" },
   { teamid = 1831, homeColor ="0xbc1e20" , awayColor ="0xd5cbbb",homeFontColor = "0xd5cbbb", awayFontColor ="0xbc1e20" },
   { teamid = 101059, homeColor ="0xFB7A12" , awayColor ="0x49503E",homeFontColor = "0x49503E", awayFontColor ="0xFB7A12" },  
   { teamid = 112172, homeColor ="0xffffff" , awayColor ="0xFA4866",homeFontColor = "0xFA4866", awayFontColor ="0xffffff" },  
}
FcWcTeamsData = {
   { teamid = 10, homeColor = "0x669dc9", awayColor = "0x292928",homeFontColor = "0xE0E0E0", awayFontColor = "0x2838A0"},
   { teamid = 11, homeColor = "0xb7243b", awayColor ="0xd8d8d6",homeFontColor ="0xE0E0E0" , awayFontColor = "0x289880"},
   { teamid = 243, homeColor = "0xDFDFDB", awayColor = "0x5C6182", homeFontColor = "0x5C6182", awayFontColor = "0xDFDFDB" },
   { teamid = 567, homeColor = "0x205B4B", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 605, homeColor = "0x1858B0", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 607, homeColor = "0xE0D420", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1877, homeColor = "0x3B5795", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"}, 
   { teamid = 112139, homeColor = "0xD0BC18", awayColor = "0x184058", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 112893, homeColor = "0xC5A0B5", awayColor = "0x252725", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
}
EuroCupTeamsData = {
   { teamid = 1318, homeColor = "0x93353B", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1319, homeColor = "0x8F0215", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1322, homeColor = "0x93353B", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1325, homeColor = "0x93353B", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1327, homeColor = "0x8F0215", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1328, homeColor = "0xffffff", awayColor = "0x2B2833", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1330, homeColor = "0x8F0215", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1331, homeColor = "0x93353B", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1334, homeColor = "0xffffff", awayColor = "0x33579D", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1335, homeColor = "0x353C50", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1337, homeColor = "0x282828", awayColor = "0x3B2B2D", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1338, homeColor = "0xffffff", awayColor = "0x066FB9", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1341, homeColor = "0x066FB9", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1343, homeColor = "0x2073BD", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1352, homeColor = "0xB3292D", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1353, homeColor = "0xffffff", awayColor = "0x93353B", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1354, homeColor = "0x93353B", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1355, homeColor = "0x1D834B", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1356, homeColor = "0xD0AB20", awayColor = "0xBD2D28", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1357, homeColor = "0x622135", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1359, homeColor = "0x303743", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1360, homeColor = "0x0067A6", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1361, homeColor = "0xffffff", awayColor = "0x0456BE", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1362, homeColor = "0xB3282D", awayColor = "0x7DABD5", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1363, homeColor = "0xEBBD35", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1365, homeColor = "0xffffff", awayColor = "0xD2001E", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1366, homeColor = "0xEDE12B", awayColor = "0x3869C0", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1367, homeColor = "0x93353B", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 1886, homeColor = "0x9D212D", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 105013, homeColor = "0x0547B4", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 105022, homeColor = "0xF03430", awayColor = "0xffffff", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
   { teamid = 105035, homeColor = "0xDB9F30", awayColor = "0x2B315B", homeFontColor = "0x202B47", awayFontColor ="0xCD1539"},
}
AfcCupTeamsData = {
   { teamid = 113217, homeColor = "0xB3081D", awayColor = "0x000000", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
   { teamid = 155607, homeColor = "0xffffff", awayColor ="0xBF0B0C",homeFontColor = "0x000000", awayFontColor = "0xffffff"},
   { teamid = 150601, homeColor = "0x020070", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
   { teamid = 112096, homeColor = "0x1B8362", awayColor = "0xBA0D17", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
   { teamid = 155602, homeColor = "0x0A49B3", awayColor ="0xC1CBD5",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
   { teamid = 115617, homeColor ="0xD5032C" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
   { teamid = 155603, homeColor = "0xCD252B", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
   { teamid = 112572, homeColor = "0xffffff", awayColor = "0x757376", homeFontColor = "0x000000", awayFontColor = "0xffffff" },
   { teamid = 111674, homeColor = "0xffffff", awayColor = "0x000000", homeFontColor = "0x000000", awayFontColor = "0xffffff" },
   { teamid = 115616, homeColor ="0xC50005" , awayColor ="0x18271A",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
   { teamid = 150600, homeColor = "0x062655", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
   { teamid = 112139, homeColor = "0xF1F411", awayColor = "0x2F4256", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
   { teamid = 605, homeColor = "0x0747B9", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
   { teamid = 607, homeColor = "0xF7FA14", awayColor = "0x000000", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
   { teamid = 150630, homeColor ="0x2A1A5F" , awayColor ="0xE1DE41",homeFontColor = "0xD9AE15", awayFontColor ="0x815CA3"},
   { teamid = 115618, homeColor ="0x252B91" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
}
	
local EAFCScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 60,
  bnd_top = 38,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 30,
  bnd_logo_width = 161,
  bnd_logo_top = -45,
  bnd_logo_left = -107,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 0
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 29,
  bnd_homeRect_top = 0.5,
  bnd_homeRect_left = -108,
  bnd_homeRect_width = 5,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 29,
  bnd_awayRect_top = 0.5,
  bnd_awayRect_right = -108,
  bnd_awayRect_width = 5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 80,
  bnd_homeBg_left = -68,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 0
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 77,
  bnd_awayBg_right = -68,
  bnd_awayBg_top = 50,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away2",
    id = 0
  },
  bnd_scoreBg_width = 25,
  bnd_scoreBg_height = 61,
  bnd_scoreBg_right = 15,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 0
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -57,
  bnd_homeName_top = -15,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = 57,
  bnd_awayName_top = 15,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0x000000",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -90,
  bnd_homeCrest_top = -15,
  bnd_homeCrest_width = 25,
  bnd_homeCrest_height = 25,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = 90,
  bnd_awayCrest_top = 15,
  bnd_awayCrest_width = 25,
  bnd_awayCrest_height = 25,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -15,
  bnd_homeScore_left = -16.5,
  bnd_homeScore_fontSize = 21,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 15,
  bnd_awayScore_right = 16,
  bnd_awayScore_fontSize = 21,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "PLAYMATCH",
  bnd_score_top = -42.5,
  bnd_score_left = -140,
  bnd_score_fontSize = 16,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 80,
  bnd_time_height = 30,
  bnd_time_top = -15,
  bnd_time_left = 32,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 0
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 0,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 40,
  bnd_extraTime_height = 28,
  bnd_extraTime_top = 14,
  bnd_extraTime_left = 32,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 0
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0x000000",

  bnd_stat_visible = false,
  bnd_stat_width = 33,
  bnd_stat_height = 61,
  bnd_stat_top = 0,
  bnd_stat_left = 215,
  bnd_stat_color = "0x00FC7F",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 14,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = -15,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 0,
  bnd_away_stat_text_top = 15,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 5,
  bnd_stat_text_fontColor = "0x000000",
  bnd_stat_text = ""
}

-------------------------------------------
--- Scorebroad Turnamen ---
-------------------------------------------
local UCLScore = {
  bnd_text_bold = false,
  bnd_fontFace = "$Font_Ucl", 
  bnd_width = 420,
  bnd_height = 28,
  bnd_top = 40,
  bnd_left = 105,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_top = 0,
  bnd_logo_left = 0,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 2236
  },
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 28.5,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = -110,
  bnd_homeRect_width = 5,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 28.5,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = -110,
  bnd_awayRect_width = 5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 80,
  bnd_homeBg_left = -70,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 2236
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 80,
  bnd_awayBg_right = -70,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 2236
  },
  bnd_scoreBg_width = 90,
  bnd_scoreBg_height = 28.5,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 2236
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -70,
  bnd_homeName_top = 2,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_right = -70,
  bnd_awayName_top = 2,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -2020,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -2020,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 2,
  bnd_homeScore_left = -19.5,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0xFFFFFF",

  bnd_awayScore_text = "",
  bnd_awayScore_top = 2,
  bnd_awayScore_right = -15,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0xFFFFFF",

  bnd_score_text = "-",
  bnd_score_top = 0.5,
  bnd_score_left = -3000,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0x221B68",

  bnd_time_width = 90,
  bnd_time_height = 27,
  bnd_time_top = 0,
  bnd_time_left = 15,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 2236
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_left = 10,
  bnd_time_text_top = 2,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 90,
  bnd_extraTime_height = 27,
  bnd_extraTime_top = 28,
  bnd_extraTime_left = 15,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2236
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_text_left = 2,
  bnd_extraTime_text_top = 2,
  
  bnd_stat_visible = false,
  bnd_stat_width = 225,
  bnd_stat_height = 50,
  bnd_stat_top = 40,
  bnd_stat_left = 107,
  bnd_stat_color = "0xffffff",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local WorldCupScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Qatar2022Arabic",
  bnd_width = 420,
  bnd_height = 30,
  bnd_top = 38,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 180,
  bnd_logo_width = 220,
  bnd_logo_top = -20,
  bnd_logo_left = 0,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID2"
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 77,
  bnd_homeBg_left = -68,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID2"
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 77,
  bnd_awayBg_right = -68,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = "CupID2"
  },
  bnd_scoreBg_width = 60,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = "CupID2"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -70,
  bnd_homeName_top = 2,
  bnd_homeName_fontSize = 18,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = -68,
  bnd_awayName_top = 2,
  bnd_awayName_fontSize = 18,
  bnd_awayName_fontColor = "0x000000",

  bnd_homeCrest = {
    name = "$NationalCrest",
    id = 0
  },
  bnd_homeCrest_left = -108,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$NationalCrest",
    id = 0
  },
  bnd_awayCrest_right = -108,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 2,
  bnd_homeScore_left = -17.5,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 2,
  bnd_awayScore_right = -17,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "-",
  bnd_score_top = 1,
  bnd_score_left = 0,
  bnd_score_fontSize = 18,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 80,
  bnd_time_height = 30,
  bnd_time_top = 0,
  bnd_time_left = 16,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID2"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 2,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 40,
  bnd_extraTime_height = 28,
  bnd_extraTime_top = 27,
  bnd_extraTime_left = 16,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID2"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_text_top = 2,
  bnd_extraTime_text_left = 0,
  bnd_extraTime_fontColor = "0x1AD7AD",

  bnd_stat_visible = false,
  bnd_stat_width = 220,
  bnd_stat_height = 50,
  bnd_stat_top = 41,
  bnd_stat_left = 110,
  bnd_stat_color = "0x3D031E",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 17,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 17,
  bnd_stat_text = ""
}
local UCLUelScore = {
    bnd_text_bold = false,
    bnd_width = 150,
    bnd_height = 25,
    bnd_top = 38,
    bnd_left = 400,
    bnd_scoreboard_width = 500,
    bnd_logo_inside_visible = false,
    bnd_logo_outside_visible = false,
    bnd_logo_height = 60,
    bnd_logo_width = 60,
    bnd_logo_top = 0,
    bnd_logo_left = -200,
    bnd_logo_image = {
      name = "$ScoreBoard_Logo",
      id = 2238
    },
    bnd_homeRect_visible = false,
    bnd_homeRect_color = "",
    bnd_homeRect_height = 25,
    bnd_homeRect_top = 0,
    bnd_homeRect_left = -38,
    bnd_homeRect_width = 3,
    bnd_awayRect_visible = false,
    bnd_awayRect_color = "",
    bnd_awayRect_height = 25,
    bnd_awayRect_top = 0,
    bnd_awayRect_right = -35,
    bnd_awayRect_width = 3,

    bnd_homeBg_visible = true,
    bnd_homeBg_width = 80,
    bnd_homeBg_left = -70,
    bnd_homeBg_image = {
      name = "$ScoreBoard_Home",
      id = "CupID3"
    },
    bnd_awayBg_visible = true,
    bnd_awayBg_width = 80,
    bnd_awayBg_right = -70,
    bnd_awayBg_image = {
      name = "$ScoreBoard_Away",
      id = "CupId3"
    },
    bnd_scoreBg_width = 90,
    bnd_scoreBg_height = 25,
    bnd_scoreBg_right = 0,
    bnd_scoreBg_image = {
      name = "$ScoreBoard_Score",
      id = "CupId3"
    },
    bnd_homeName_text = "",
    bnd_homeName_left = -80,
    bnd_homeName_top = 0,
    bnd_homeName_fontSize = 23,
    bnd_homeName_fontColor = "0xFFFFFF",
    bnd_awayName_text = "",
    bnd_awayName_right = -80,
    bnd_awayName_top = 0,
    bnd_awayName_fontSize = 23,
    bnd_awayName_fontColor = "0xFFFFFF",
    bnd_homeCrest = {
      name = "$Crest",
      id = 0
    },
    bnd_homeCrest_left = -2020,
    bnd_homeCrest_width = 30,
    bnd_homeCrest_height = 30,
    bnd_awayCrest = {
      name = "$Crest",
      id = 0
    },
    bnd_awayCrest_right = -2020,
    bnd_awayCrest_width = 30,
    bnd_awayCrest_height = 30,
    bnd_homeScore_text = "",
    bnd_homeScore_top = 0,
    bnd_homeScore_left = -20.5,
    bnd_homeScore_fontSize = 23,
    bnd_homeScore_fontColor = "0x1E1E1E",
    bnd_awayScore_text = "",
    bnd_awayScore_top = 0,
    bnd_awayScore_right = -15,
    bnd_awayScore_fontSize = 23,
    bnd_awayScore_fontColor = "0x1E1E1E",
    bnd_score_text = "-",
    bnd_score_top = 1.25,
    bnd_score_left = -15000,
    bnd_score_fontSize = 20,
    bnd_score_fontColor = "0x34003A",

    bnd_time_width = 100,
    bnd_time_height = 27,
    bnd_time_top = 1,
    bnd_time_left = -310,
    bnd_timeBg_image = {
      name = "$ScoreBoard_Time",
      id = "CupID3"
    },
    bnd_time_text = "",
    bnd_time_fontSize = 23,
    bnd_time_fontColor = "0xffffff",
    bnd_time_text_top = 0,
    bnd_time_text_left = 10,
    bnd_extraTime_visible = false,
    bnd_extraTime_width = 70,
    bnd_extraTime_height = 26,
    bnd_extraTime_top = 28,
    bnd_extraTime_left = -280,
    bnd_extraTimeBg_image = {
      name = "$ScoreBoard_ExtraTime",
      id = 2238
    },
    bnd_extraTime_text = "",
    bnd_extraTime_fontSize = 23,
    bnd_extraTime_fontColor = "0xffffff",

   bnd_stat_visible = false,
   bnd_stat_width = 218,
   bnd_stat_height = 50,
   bnd_stat_top = 40,
   bnd_stat_left = -207,
   bnd_stat_color = "0x1F2120",
   bnd_home_stat_text = "",
   bnd_stat_fontSize = 20,
   bnd_stat_fontColor = "0xffffff",
   bnd_home_stat_text_left = -80,
   bnd_home_stat_text_top = 0,
   bnd_away_stat_text = "",
   bnd_away_stat_text_left = 80,
   bnd_away_stat_text_top = 0,
   bnd_stat_text_left = 0,
   bnd_stat_text_top = 0,
   bnd_stat_text_fontSize = 18,
   bnd_stat_text = ""
}
local PialaIndonesiaScore = {
  bnd_text_bold = false,
  bnd_width = 150,
  bnd_height = 26,
  bnd_top = 40,
  bnd_left = 700,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 49,
  bnd_logo_width = 49,
  bnd_logo_top = 0,
  bnd_logo_left = 0,
  bnd_logo_image = {
    name = "$LeagueLogo",
    id = "CupID4"
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 25,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = -38,
  bnd_homeRect_width = 3,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 25,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = -35,
  bnd_awayRect_width = 3,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 80,
  bnd_homeBg_left = -70,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID4"
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 80,
  bnd_awayBg_right = -70,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = "CupID4"
  },
  bnd_scoreBg_width = 90,
  bnd_scoreBg_height = 26,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = "CupID4"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -75,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = -75,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0x000000",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -2020,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -2020,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = -31.5,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0xffffff",

  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_right = -31,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "-",
  bnd_score_top = 0.5,
  bnd_score_left = -3000,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "",

  bnd_time_width = 70,
  bnd_time_height = 26,
  bnd_time_top = 25,
  bnd_time_left = -160,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID4"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_left = 0,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 30,
  bnd_extraTime_height = 26,
  bnd_extraTime_top = 25,
  bnd_extraTime_left = -95,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID4"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xffffff",

  bnd_stat_visible = false,
  bnd_stat_width = 221,
  bnd_stat_height = 50,
  bnd_stat_top = 40,
  bnd_stat_left = -161,
  bnd_stat_color = "0x3471B2",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 10,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local WorldCupWomensScore = {
  bnd_fontFace = "$FWWC2023Bold",
  bnd_text_bold = false,
  bnd_width = 380,
  bnd_height = 38,
  bnd_top = 38,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 180,
  bnd_logo_width = 219,
  bnd_logo_top = -20,
  bnd_logo_left = 50,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID5"
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 100,
  bnd_homeBg_left = -20,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID5"
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 100,
  bnd_awayBg_right = -120,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = "CupID5"
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 38,
  bnd_scoreBg_right = -50,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = "CupID5"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -5,
  bnd_homeName_top = 0.5,
  bnd_homeName_fontSize = 17,
  bnd_homeName_fontColor = "0x1E1E1E",
  bnd_awayName_text = "",
  bnd_awayName_right = -104,
  bnd_awayName_top = 0.5,
  bnd_awayName_fontSize = 17,
  bnd_awayName_fontColor = "0x1E1E1E",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -42,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -143,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = 33.5,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0xFFFFFF",

  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_right = -68,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0xFFFFFF",

  bnd_score_text = "-",
  bnd_score_top = 0,
  bnd_score_left = 50,
  bnd_score_fontSize = 12,
  bnd_score_fontColor = "0xFFFFFF",

  bnd_time_width = 100,
  bnd_time_height = 38,
  bnd_time_top = 0,
  bnd_time_left = 30,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID5"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_left = 0,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 40,
  bnd_extraTime_height = 38,
  bnd_extraTime_top = 29,
  bnd_extraTime_left = 37,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID5"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",

  bnd_stat_visible = false,
  bnd_stat_width = 218,
  bnd_stat_height = 50,
  bnd_stat_top = 41,
  bnd_stat_left = 121,
  bnd_stat_color = "0x275759",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 18,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local UCLWomensScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 28,
  bnd_top = 40,
  bnd_left = 105,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_top = 0,
  bnd_logo_left = 0,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID1"
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 80,
  bnd_homeBg_left = -70,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 2240
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 80,
  bnd_awayBg_right = -70,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 2240
  },
  bnd_scoreBg_width = 90,
  bnd_scoreBg_height = 28,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 2240
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -70,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_right = -70,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -2020,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -2020,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = -19.5,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0xFFFFFF",

  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_right = -15,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0xFFFFFF",

  bnd_score_text = "-",
  bnd_score_top = 0.5,
  bnd_score_left = -3000,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0x221B68",

  bnd_time_width = 90,
  bnd_time_height = 27,
  bnd_time_top = 0,
  bnd_time_left = 28,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 2240
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0x559CCA",
  bnd_time_text_left = 10,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 90,
  bnd_extraTime_height = 27,
  bnd_extraTime_top = 28,
  bnd_extraTime_left = 28,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2240
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 22,
  bnd_extraTime_fontColor = "0x559CCA",

  bnd_stat_visible = false,
  bnd_stat_width = 210,
  bnd_stat_height = 50,
  bnd_stat_top = 40,
  bnd_stat_left = 114,
  bnd_stat_color = "0xffffff",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local UCLEuropeScore = {
    bnd_text_bold = false,
    bnd_width = 150,
    bnd_height = 25,
    bnd_top = 38,
    bnd_left = 400,
    bnd_scoreboard_width = 500,
    bnd_logo_inside_visible = false,
    bnd_logo_outside_visible = true,
    bnd_logo_height = 60,
    bnd_logo_width = 60,
    bnd_logo_top = 0,
    bnd_logo_left = -200,
    bnd_logo_image = {
      name = "$ScoreBoard_Logo",
      id = "CupID8"
    },
    bnd_homeRect_visible = true,
    bnd_homeRect_color = "",
    bnd_homeRect_height = 25,
    bnd_homeRect_top = 0,
    bnd_homeRect_left = -38,
    bnd_homeRect_width = 3,
    bnd_awayRect_visible = true,
    bnd_awayRect_color = "",
    bnd_awayRect_height = 25,
    bnd_awayRect_top = 0,
    bnd_awayRect_right = -35,
    bnd_awayRect_width = 3,

    bnd_homeBg_visible = true,
    bnd_homeBg_width = 80,
    bnd_homeBg_left = -70,
    bnd_homeBg_image = {
      name = "$ScoreBoard_Home",
      id = "CupID8"
    },
    bnd_awayBg_visible = true,
    bnd_awayBg_width = 80,
    bnd_awayBg_right = -70,
    bnd_awayBg_image = {
      name = "$ScoreBoard_Away",
      id = "CupID8"
    },
    bnd_scoreBg_width = 90,
    bnd_scoreBg_height = 25,
    bnd_scoreBg_right = 0,
    bnd_scoreBg_image = {
      name = "$ScoreBoard_Score",
      id = "CupID8"
    },
    bnd_homeName_text = "",
    bnd_homeName_left = -70,
    bnd_homeName_top = 0,
    bnd_homeName_fontSize = 23,
    bnd_homeName_fontColor = "0xFFFFFF",
    bnd_awayName_text = "",
    bnd_awayName_right = -70,
    bnd_awayName_top = 0,
    bnd_awayName_fontSize = 23,
    bnd_awayName_fontColor = "0xFFFFFF",
    bnd_homeCrest = {
      name = "$Crest",
      id = 0
    },
    bnd_homeCrest_left = -2020,
    bnd_homeCrest_width = 30,
    bnd_homeCrest_height = 30,
    bnd_awayCrest = {
      name = "$Crest",
      id = 0
    },
    bnd_awayCrest_right = -2020,
    bnd_awayCrest_width = 30,
    bnd_awayCrest_height = 30,
    bnd_homeScore_text = "",
    bnd_homeScore_top = 0,
    bnd_homeScore_left = -20.5,
    bnd_homeScore_fontSize = 23,
    bnd_homeScore_fontColor = "0x1E1E1E",
    bnd_awayScore_text = "",
    bnd_awayScore_top = 0,
    bnd_awayScore_right = -15,
    bnd_awayScore_fontSize = 23,
    bnd_awayScore_fontColor = "0x1E1E1E",
    bnd_score_text = "-",
    bnd_score_top = 1.25,
    bnd_score_left = -15000,
    bnd_score_fontSize = 20,
    bnd_score_fontColor = "0x34003A",

    bnd_time_width = 70,
    bnd_time_height = 27,
    bnd_time_top = 1,
    bnd_time_left = -280,
    bnd_timeBg_image = {
      name = "$ScoreBoard_Time",
      id = "CupID8"
    },
    bnd_time_text = "",
    bnd_time_fontSize = 23,
    bnd_time_fontColor = "0xffffff",
    bnd_time_text_top = 0,
    bnd_time_text_left = 0,
    bnd_extraTime_visible = false,
    bnd_extraTime_width = 70,
    bnd_extraTime_height = 26,
    bnd_extraTime_top = 28,
    bnd_extraTime_left = -280,
    bnd_extraTimeBg_image = {
      name = "$ScoreBoard_ExtraTime",
      id = "CupID8"
    },
    bnd_extraTime_text = "",
    bnd_extraTime_fontSize = 23,
    bnd_extraTime_fontColor = "0xffffff",

   bnd_stat_visible = false,
   bnd_stat_width = 218,
   bnd_stat_height = 50,
   bnd_stat_top = 40,
   bnd_stat_left = -207,
   bnd_stat_color = "0x1F2120",
   bnd_home_stat_text = "",
   bnd_stat_fontSize = 20,
   bnd_stat_fontColor = "0xffffff",
   bnd_home_stat_text_left = -80,
   bnd_home_stat_text_top = 0,
   bnd_away_stat_text = "",
   bnd_away_stat_text_left = 80,
   bnd_away_stat_text_top = 0,
   bnd_stat_text_left = 0,
   bnd_stat_text_top = 0,
   bnd_stat_text_fontSize = 18,
   bnd_stat_text = ""
}
local AsianCupScore = {
  bnd_text_bold = true,
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 55,
  bnd_left = 90,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 50,
  bnd_logo_width = 280,
  bnd_logo_top = -10,
  bnd_logo_left = -60,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID9"
  },
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 240,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_HomeX",
    id = "CupID1"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = "CupID1"
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_ScoreX",
    id = "CupID1"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -87,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 22,
  bnd_homeName_fontColor = "0x31146B",
  bnd_awayName_text = "",
  bnd_awayName_right = -48,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 22,
  bnd_awayName_fontColor = "0x31146B",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -12500,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -12500,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 1,
  bnd_homeScore_left = -38.7,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0x94DF2A",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = 1.7,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0x94DF2A",

  bnd_score_text = "•",
  bnd_score_top = 1,
  bnd_score_left = -20,
  bnd_score_fontSize = 12,
  bnd_score_fontColor = "0x94DF2A",

  bnd_time_width = 116,
  bnd_time_height = 34,
  bnd_time_top = 0,
  bnd_time_left = -14,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = "CupID1"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 22,
  bnd_time_fontColor = "0x94DF2A",
  bnd_time_text_top = 1,
  bnd_time_text_left = 15,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 77,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 30,
  bnd_extraTime_left = 21,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID9"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 22,
  bnd_extraTime_fontColor = "0x2D075E",
  bnd_stat_visible = false,
  bnd_stat_width = 202,
  bnd_stat_height = 40,
  bnd_stat_top = 38,
  bnd_stat_left = 98,
  bnd_stat_color = "0x2D075E",
  bnd_stat_alpha = 0.9,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0x94DF2A",
  bnd_home_stat_text_left = -60,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 60,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local FACupScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_text_bold = true,
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 55,
  bnd_left = 90,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 90,
  bnd_logo_width = 250,
  bnd_logo_top = -10,
  bnd_logo_left = -80,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID7"
  },
  
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "0xBF0D19",
  bnd_homeRect_height = 26.5,
  bnd_homeRect_top = 9,
  bnd_homeRect_left = -200,
  bnd_homeRect_width = 5,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "0x669dc9",
  bnd_awayRect_height = 26.5,
  bnd_awayRect_top = 9,
  bnd_awayRect_right = -38,
  bnd_awayRect_width = 5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 240,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_HomeX",
    id = "CupID1"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = "CupID1"
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_ScoreX",
    id = "CupID1"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -175,
  bnd_homeName_top = 10,
  bnd_homeName_fontSize = 19,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = -11,
  bnd_awayName_top = 10,
  bnd_awayName_fontSize = 19,
  bnd_awayName_fontColor = "0x000000",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -12500,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -12500,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 10,
  bnd_homeScore_left = -135,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 10,
  bnd_awayScore_right = 29,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "",
  bnd_score_top = 0,
  bnd_score_left = -80,
  bnd_score_fontSize = 12,
  bnd_score_fontColor = "0x000000",

  bnd_time_width = 116,
  bnd_time_height = 34,
  bnd_time_top = 0,
  bnd_time_left = -14,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = "CupID1"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 23,
  bnd_time_text_left = 95,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 80,
  bnd_extraTime_height = 24,
  bnd_extraTime_top = 45,
  bnd_extraTime_left = 99,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 0
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x000000",
  bnd_stat_visible = false,
  bnd_stat_width = 241.5,
  bnd_stat_height = 50,
  bnd_stat_top = 49,
  bnd_stat_left = 18,
  bnd_stat_color = "0xffffff",
  bnd_stat_alpha = 0.8,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 18,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 7,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 7,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 7,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local KingSaudiCupScore = {
  bnd_text_bold = true,
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 46,
  bnd_left = 90,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 33,
  bnd_logo_width = 370,
  bnd_logo_top = 0,
  bnd_logo_left = -40,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID10"
  },
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 240,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_HomeX",
    id = "CupID1"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = "CupID1"
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_ScoreX",
    id = "CupID1"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -60,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -73,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -12500,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -12500,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 1,
  bnd_homeScore_left = -111,
  bnd_homeScore_fontSize = 25,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = -123,
  bnd_awayScore_fontSize = 25,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "",
  bnd_score_top = 0,
  bnd_score_left = -80,
  bnd_score_fontSize = 12,
  bnd_score_fontColor = "0x000000",

  bnd_time_width = 116,
  bnd_time_height = 34,
  bnd_time_top = 0,
  bnd_time_left = -14,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = "CupID1"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 0,
  bnd_time_text_left = 184,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 58,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = -23,
  bnd_extraTime_left = 200,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 53
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_stat_visible = false,
  bnd_stat_width = 277,
  bnd_stat_height = 50,
  bnd_stat_top = 39,
  bnd_stat_left = 87,
  bnd_stat_color = "0x000000",
  bnd_stat_alpha = 0.7,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local EuroCupScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 30,
  bnd_top = 38,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 85,
  bnd_logo_width = 85,
  bnd_logo_top = 0,
  bnd_logo_left = -210,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID11"
  },
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 26.1,
  bnd_homeRect_top = -1.2,
  bnd_homeRect_left = -107,
  bnd_homeRect_width = 8,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 26.1,
  bnd_awayRect_top = -1.5,
  bnd_awayRect_right = -106,
  bnd_awayRect_width = 8,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 80,
  bnd_homeBg_left = -70,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID11"
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 80,
  bnd_awayBg_right = -70,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = "CupID11"
  },
  bnd_scoreBg_width = 62,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = "CupID11"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -70,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -68,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -1000000000008,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -10000000000008,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = -17.5,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_right = -17,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "-",
  bnd_score_top = -1.5,
  bnd_score_left = 0,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 80,
  bnd_time_height = 30,
  bnd_time_top = 0,
  bnd_time_left = 30,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID11"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 0,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 40,
  bnd_extraTime_height = 28,
  bnd_extraTime_top = 30,
  bnd_extraTime_left = 30,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID11"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xffffff",

  bnd_stat_visible = false,
  bnd_stat_width = 220,
  bnd_stat_height = 50,
  bnd_stat_top = 41,
  bnd_stat_left = 110,
  bnd_stat_color = "0x3D031E",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local UsaOpenCupScore = {
  bnd_text_bold = true,
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 55,
  bnd_left = 90,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 50,
  bnd_logo_width = 280,
  bnd_logo_top = -10,
  bnd_logo_left = -60,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID12"
  },
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 240,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_HomeX",
    id = "CupID1"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = "CupID1"
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_ScoreX",
    id = "CupID1"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -135,
  bnd_homeName_top = -12,
  bnd_homeName_fontSize = 22,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = 15,
  bnd_awayName_top = -12,
  bnd_awayName_fontSize = 22,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -12500,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -12500,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -12,
  bnd_homeScore_left = -90.7,
  bnd_homeScore_fontSize = 22,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -12,
  bnd_awayScore_right = 60.7,
  bnd_awayScore_fontSize = 22,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "-",
  bnd_score_top = -12,
  bnd_score_left = -76,
  bnd_score_fontSize = 15,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 116,
  bnd_time_height = 34,
  bnd_time_top = -12,
  bnd_time_left = 195,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = "CupID1"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 22,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 2,
  bnd_time_text_left = 15,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 22,
  bnd_extraTime_top = -11,
  bnd_extraTime_left = 300,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 0
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 22,
  bnd_extraTime_fontColor = "0x000000",
  
  bnd_stat_visible = false,
  bnd_stat_width = 190,
  bnd_stat_height = 35,
  bnd_stat_top = 20,
  bnd_stat_left = 50,
  bnd_stat_color = "0xC6142E",
  bnd_stat_alpha = 0.9,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -60,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 60,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local AfcCupScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 60,
  bnd_top = 40,
  bnd_left = 150,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 85,
  bnd_logo_width = 130,
  bnd_logo_top = -0.5,
  bnd_logo_left = -210,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID13"
  },
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27,
  bnd_homeRect_top = -25,
  bnd_homeRect_left = -209,
  bnd_homeRect_width = 32,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27,
  bnd_awayRect_top = 2,
  bnd_awayRect_right = 209,
  bnd_awayRect_width = 32,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 170,
  bnd_homeBg_left = -110,
  bnd_homeBg_top = -24,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID13"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = 150,
  bnd_awayBg_height = 60,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away1",
    id = 350
  },
  bnd_scoreBg_width = 35,
  bnd_scoreBg_height = 32,
  bnd_scoreBg_right = 105,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score1",
    id = "CupID13"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -170,
  bnd_homeName_top = -25,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = 170,
  bnd_awayName_top = 2,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0x000000",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -2100000000002,
  bnd_homeCrest_top = -14,
  bnd_homeCrest_width = 25,
  bnd_homeCrest_height = 25,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = 21000000000002,
  bnd_awayCrest_top = 14,
  bnd_awayCrest_width = 25,
  bnd_awayCrest_height = 25,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -25,
  bnd_homeScore_left = -210,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0xffffff",

  bnd_awayScore_text = "",
  bnd_awayScore_top = 2,
  bnd_awayScore_right = 210,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "-",
  bnd_score_top = 0.5,
  bnd_score_left = -3000,
  bnd_score_fontSize = 16,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 75,
  bnd_time_height = 31,
  bnd_time_top = 26,
  bnd_time_left = -12,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID13"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 16,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_left = 0,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 55,
  bnd_extraTime_height = 31,
  bnd_extraTime_top = 26,
  bnd_extraTime_left = 48,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID13"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0x000000",
  
  bnd_stat_visible = false,
  bnd_stat_width = 45,
  bnd_stat_height = 77,
  bnd_stat_top = 0,
  bnd_stat_left = -96,
  bnd_stat_color = "0xF6DB06",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 18,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = -20,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 0,
  bnd_away_stat_text_top = 21,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}
local CopaDelReyScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 30,
  bnd_top = 35,
  bnd_left = 25,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 34,
  bnd_logo_width = 34,
  bnd_logo_top = 0,
  bnd_logo_left = -136,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID14"
  },
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 3,
  bnd_homeRect_top = 16,
  bnd_homeRect_left = -75,
  bnd_homeRect_width = 80,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 3,
  bnd_awayRect_top = 16,
  bnd_awayRect_right = -85,
  bnd_awayRect_width = 80,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 270,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID14"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_height = 30,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away1",
    id = 0
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score1",
    id = 0
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -85,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -91,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -12500,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -12500,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 1,
  bnd_homeScore_left = -21,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = -28,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "-",
  bnd_score_top = 0,
  bnd_score_left = 5,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 100,
  bnd_time_height = 30,
  bnd_time_top = 0,
  bnd_time_left = 342,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID14"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 19,
  bnd_time_fontColor = "0x101010",
  bnd_time_text_top = 0,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 80,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 0,
  bnd_extraTime_left = 380,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime1",
    id = "CupID14"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 19,
  bnd_extraTime_fontColor = "0x101010",
  
  bnd_stat_visible = false,
  bnd_stat_width = 250,
  bnd_stat_height = 50,
  bnd_stat_top = 41,
  bnd_stat_left = 100,
  bnd_stat_color = "0x000000",
  bnd_stat_alpha = 0.7,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local AfricaCupScore = {
  bnd_text_bold = true,
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 55,
  bnd_left = 110,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 80,
  bnd_logo_width = 250,
  bnd_logo_top = -30,
  bnd_logo_left = -80,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID15"
  },
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 240,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_HomeX",
    id = "CupID1"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = "CupID1"
  },
  bnd_scoreBg_width = 50,
  bnd_scoreBg_height = 40,
  bnd_scoreBg_right = 265,
  bnd_scoreBg_top = -14,
  bnd_scoreBg_image = {
    name = "$Leaguelogo",
    id = "CupID15_1"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -175,
  bnd_homeName_top = -9,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -11,
  bnd_awayName_top = -9,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$AfconCrest",
    id = 0
  },
  bnd_homeCrest_left = -220,
  bnd_homeCrest_width = 48,
  bnd_homeCrest_height = 48,
  bnd_homeCrest_top = -9,
  bnd_awayCrest = {
    name = "$AfconCrest",
    id = 0
  },
  bnd_awayCrest_right = -55,
  bnd_awayCrest_width = 48,
  bnd_awayCrest_height = 48,
  bnd_awayCrest_top = -8,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -9,
  bnd_homeScore_left = -105,
  bnd_homeScore_fontSize = 22,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -9,
  bnd_awayScore_right = 59,
  bnd_awayScore_fontSize = 22,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "",
  bnd_score_top = 0,
  bnd_score_left = -80,
  bnd_score_fontSize = 12,
  bnd_score_fontColor = "0x000000",

  bnd_time_width = 103,
  bnd_time_height = 33,
  bnd_time_top = 18,
  bnd_time_left = 88,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 319
  },
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 1,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 82,
  bnd_extraTime_height = 24,
  bnd_extraTime_top = 43,
  bnd_extraTime_left = 100,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID15"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_stat_visible = false,
  bnd_stat_width = 238.5,
  bnd_stat_height = 60,
  bnd_stat_top = 35,
  bnd_stat_left = 20,
  bnd_stat_color = "0x0C5236",
  bnd_stat_alpha = 0.8,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 18,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 15,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local CoppaItaliaScore = {
  bnd_text_bold = false,
  bnd_fontFace = "$SerieA", 
  bnd_width = 420,
  bnd_height = 30,
  bnd_top = 38,
  bnd_left = -15,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_top = 0,
  bnd_logo_left = 0,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 31
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 130,
  bnd_homeBg_left = -80,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID16"
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 130,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = "CupID16"
  },
  bnd_scoreBg_width = 110,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = "CupID16"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -95,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_right = -95,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -2020,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -2020,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 1,
  bnd_homeScore_left = -22.5,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0x221B68",

  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = -19,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0x221B68",

  bnd_score_text = "-",
  bnd_score_top = 0.5,
  bnd_score_left = -3,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0x221B68",

  bnd_time_width = 95,
  bnd_time_height = 30,
  bnd_time_top = 0,
  bnd_time_left = 365,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID16"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0x221B68",
  bnd_time_text_left = -4,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 65,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 0,
  bnd_extraTime_left = 444,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID16"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xFFFFFF",

  bnd_stat_visible = false,
  bnd_stat_width = 290,
  bnd_stat_height = 40,
  bnd_stat_top = 37,
  bnd_stat_left = 75,
  bnd_stat_color = "0xAA2C1D",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -90,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 90,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local DfbPokalScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 43,
  bnd_top = 35,
  bnd_left = 90,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 25,
  bnd_logo_width = 125,
  bnd_logo_top = -25,
  bnd_logo_left = 0,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 0
  },
  
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 25,
  bnd_homeRect_top = -1,
  bnd_homeRect_left = -120,
  bnd_homeRect_width = 6,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 25,
  bnd_awayRect_top = -1,
  bnd_awayRect_right = -145,
  bnd_awayRect_width = 6,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 265,
  bnd_homeBg_left = 15,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID17"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 130,
  bnd_awayBg_height = 4,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away1",
    id = 0
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score1",
    id = 0
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -65,
  bnd_homeName_top = -1,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = -90,
  bnd_awayName_top = -1,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0x000000",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -12500,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -12500,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -1,
  bnd_homeScore_left = 0,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -1,
  bnd_awayScore_right = -27,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x000000",

  bnd_score_text = "",
  bnd_score_top = 0,
  bnd_score_left = -1,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0x000000",

  bnd_time_width = 115,
  bnd_time_height = 32,
  bnd_time_top = -4,
  bnd_time_left = -25,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID17"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 3,
  bnd_time_text_left = 15,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 90,
  bnd_extraTime_height = 27,
  bnd_extraTime_top = 27,
  bnd_extraTime_left = 0,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 0
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0x000000",
  bnd_stat_visible = false,
  bnd_stat_width = 270,
  bnd_stat_height = 40,
  bnd_stat_top = 35,
  bnd_stat_left = 98,
  bnd_stat_color = "0xD2D7D1",
  bnd_stat_alpha = 0.7,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = -75,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local ClassicCupScore = {
  bnd_text_bold = false,
  bnd_width = 375,
  bnd_height = 40,
  bnd_top = 38,
  bnd_left = 69,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 140,
  bnd_logo_width = 230,
  bnd_logo_top = -35,
  bnd_logo_left = 47,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID18"
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 100,
  bnd_homeBg_left = -22,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID18"
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 100,
  bnd_awayBg_right = -110,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = "CupID18"
  },
  bnd_scoreBg_width = 82,
  bnd_scoreBg_height = 40,
  bnd_scoreBg_right = -41,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = "CupID18"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -90,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -40,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -125,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 1,
  bnd_homeScore_left = 24.5,
  bnd_homeScore_fontSize = 25,
  bnd_homeScore_fontColor = "0xFFB700",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = -53,
  bnd_awayScore_fontSize = 25,
  bnd_awayScore_fontColor = "0xFFB700",

  bnd_score_text = "-",
  bnd_score_top = -1.5,
  bnd_score_left = 39,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0xFFB700",

  bnd_time_width = 100,
  bnd_time_height = 42,
  bnd_time_top = -2,
  bnd_time_left = 30,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID18"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 3,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 100,
  bnd_extraTime_height = 42,
  bnd_extraTime_top = 30,
  bnd_extraTime_left = 40,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID18"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xffffff",
  
  bnd_stat_visible = false,
  bnd_stat_width = 206,
  bnd_stat_height = 40,
  bnd_stat_top = 36,
  bnd_stat_left = 118,
  bnd_stat_color = "0x8B0000",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local CoupeDeFranceScore = {
  bnd_text_bold = false,
  bnd_width = 360,
  bnd_height = 60,
  bnd_top = 25,
  bnd_left = -30,
  bnd_scoreboard_width = 200,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 65,
  bnd_logo_width = 54,
  bnd_logo_top = -1112,
  bnd_logo_left = -2,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo1",
    id = "CupID19"
  },

  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27,
  bnd_homeRect_top = 1119,
  bnd_homeRect_left = -117,
  bnd_homeRect_width = 5,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27,
  bnd_awayRect_top = 1119,
  bnd_awayRect_right = -80,
  bnd_awayRect_width = 5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 178,
  bnd_homeBg_left = -40,
  bnd_homeBg_top = -1,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID19"
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 200,
  bnd_awayBg_right = -92,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = "CupID19"
  },
  bnd_scoreBg_width = 50,
  bnd_scoreBg_height = 72,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score1",
    id = "CupID19"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -75,
  bnd_homeName_top = 14,
  bnd_homeName_fontSize = 24,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -50,
  bnd_awayName_top = 14,
  bnd_awayName_fontSize = 24,
  bnd_awayName_fontColor = "0xffffff",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -2020,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -2020,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,
  bnd_homeScore_text = "",
  bnd_homeScore_top = 15,
  bnd_homeScore_left = -33.5,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 15,
  bnd_awayScore_right = 3,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text = "-",
  bnd_score_top = 15,
  bnd_score_left = -18,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0x000000",
  bnd_time_width = 140,
  bnd_time_height = 47,
  bnd_time_top = 6,
  bnd_time_left = 325,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID19"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 25,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 9,
  bnd_time_text_left = -20,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 31,
  bnd_extraTime_top = 15,
  bnd_extraTime_left = 396,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID19"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0xffffff",
  
  bnd_stat_visible = false,
  bnd_stat_width = 192,
  bnd_stat_height = 60,
  bnd_stat_top = 55,
  bnd_stat_left = 150,
  bnd_stat_color = "0x1A8EC4",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 25,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local FcWcScore = {
  bnd_text_bold = true,
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 46,
  bnd_left = 90,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 45,
  bnd_logo_width = 380,
  bnd_logo_top = 0,
  bnd_logo_left = -40,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID20"
  },
  
  bnd_homeRect_visible = true,
    bnd_homeRect_color = "",
    bnd_homeRect_height = 15,
    bnd_homeRect_top = 0,
    bnd_homeRect_left = -103,
    bnd_homeRect_width = 15,
    bnd_awayRect_visible = true,
    bnd_awayRect_color = "",
    bnd_awayRect_height = 15,
    bnd_awayRect_top = 0,
    bnd_awayRect_right = -105,
    bnd_awayRect_width = 15,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 240,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_HomeX",
    id = "CupID1"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = "CupID1"
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_ScoreX",
    id = "CupID1"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -66,
  bnd_homeName_top = -2,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -70,
  bnd_awayName_top = -2,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -125,
  bnd_homeCrest_width = 17,
  bnd_homeCrest_height = 17,
  bnd_homeCrest_top = -1,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -130,
  bnd_awayCrest_width = 17,
  bnd_awayCrest_height = 17,
  bnd_awayCrest_top = -1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -2,
  bnd_homeScore_left = -25,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -2,
  bnd_awayScore_right = -30,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "",
  bnd_score_top = 0,
  bnd_score_left = -80,
  bnd_score_fontSize = 12,
  bnd_score_fontColor = "0x000000",

  bnd_time_width = 116,
  bnd_time_height = 34,
  bnd_time_top = -1,
  bnd_time_left = -14,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = "CupID1"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 22,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = -1,
  bnd_time_text_left = -5,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 104,
  bnd_extraTime_height = 26,
  bnd_extraTime_top = 26,
  bnd_extraTime_left = -14,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID20"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 22,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_stat_visible = false,
  bnd_stat_width = 283,
  bnd_stat_height = 50,
  bnd_stat_top = 39,
  bnd_stat_left = 87,
  bnd_stat_color = "0x5E0E93",
  bnd_stat_alpha = 0.7,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local CopaLibertadoresScore = {
  bnd_text_bold = false,
  bnd_width = 380,
  bnd_height = 38,
  bnd_top = 38,
  bnd_left = -15,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 180,
  bnd_logo_width = 219,
  bnd_logo_top = -1120,
  bnd_logo_left = 50,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID21"
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 100,
  bnd_homeBg_left = -20,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID21"
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 100,
  bnd_awayBg_right = -120,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = "CupID21"
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 38,
  bnd_scoreBg_right = -50,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = "CupID21"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -20,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0x1E1E1E",
  bnd_awayName_text = "",
  bnd_awayName_right = -120,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0x1E1E1E",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -2020,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -2020,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 1,
  bnd_homeScore_left = 30.5,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0xFFFFFF",

  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = -70,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0xFFFFFF",

  bnd_score_text = "",
  bnd_score_top = -1.5,
  bnd_score_left = 50,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0xFFFFFF",

  bnd_time_width = 80,
  bnd_time_height = 39,
  bnd_time_top = 0,
  bnd_time_left = 320,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID21"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_left = 0,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 60,
  bnd_extraTime_height = 39,
  bnd_extraTime_top = 0,
  bnd_extraTime_left = 380,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID21"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_stat_visible = true,
  bnd_stat_width = 200,
  bnd_stat_height = 50,
  bnd_stat_top = 39,
  bnd_stat_left = 130,
  bnd_stat_color = "0x000000",
  bnd_stat_alpha = 0.7,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local UefaNationsScore = {
  bnd_text_bold = true,
  bnd_fontFace = "$UEFANations-Bold", 
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 55,
  bnd_left = 90,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 50,
  bnd_logo_width = 280,
  bnd_logo_top = -10,
  bnd_logo_left = -60,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "CupID22"
  },
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 0,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 0,
  bnd_awayRect_width = 0,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 240,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_HomeX",
    id = "CupID1"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = "CupID1"
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_ScoreX",
    id = "CupID1"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -75,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 18,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = -31,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 18,
  bnd_awayName_fontColor = "0x000000",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -12500,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -12500,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = -35.7,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_right = 4.7,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x000000",

  bnd_score_text = "-",
  bnd_score_top = -1,
  bnd_score_left = -20,
  bnd_score_fontSize = 15,
  bnd_score_fontColor = "0x000000",

  bnd_time_width = 116,
  bnd_time_height = 34,
  bnd_time_top = 0,
  bnd_time_left = -14,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = "CupID1"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 0,
  bnd_time_text_left = 15,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 77,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 30,
  bnd_extraTime_left = 21,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = "CupID22"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_stat_visible = false,
  bnd_stat_width = 202,
  bnd_stat_height = 40,
  bnd_stat_top = 30,
  bnd_stat_left = 98,
  bnd_stat_color = "0x293949",
  bnd_stat_alpha = 0.9,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -60,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 60,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local CopaAmericaScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 30,
  bnd_top = 33,
  bnd_left = -15,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 0,
  bnd_logo_width = 0,
  bnd_logo_top = 0,
  bnd_logo_left = -136,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo1",
    id = 0
  },
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 3,
  bnd_homeRect_top = 16,
  bnd_homeRect_left = -75,
  bnd_homeRect_width = 80,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 3,
  bnd_awayRect_top = 16,
  bnd_awayRect_right = -85,
  bnd_awayRect_width = 80,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 260,
  bnd_homeBg_left = 5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = "CupID23"
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_height = 30,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away1",
    id = 2298
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score1",
    id = 2298
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -80,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -86,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -12500,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -12500,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 1,
  bnd_homeScore_left = -26,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = -33,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "-",
  bnd_score_top = 0,
  bnd_score_left = 5,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 100,
  bnd_time_height = 30,
  bnd_time_top = 0,
  bnd_time_left = 340,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = "CupID23"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 19,
  bnd_time_fontColor = "0x101010",
  bnd_time_text_top = 0,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 80,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 0,
  bnd_extraTime_left = 380,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime1",
    id = "CupID23"
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0x000000",
  bnd_stat_visible = false,
  bnd_stat_width = 240,
  bnd_stat_height = 50,
  bnd_stat_top = 41,
  bnd_stat_left = 105,
  bnd_stat_color = "0x000000",
  bnd_stat_alpha = 0.7,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 15,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local CarabaoCupScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 60,
  bnd_top = 38,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 30,
  bnd_logo_width = 161,
  bnd_logo_top = -45,
  bnd_logo_left = -107,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 0
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 29,
  bnd_homeRect_top = 0.5,
  bnd_homeRect_left = -108,
  bnd_homeRect_width = 5,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 29,
  bnd_awayRect_top = 0.5,
  bnd_awayRect_right = -108,
  bnd_awayRect_width = 5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 80,
  bnd_homeBg_left = -68,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 0
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 77,
  bnd_awayBg_right = -68,
  bnd_awayBg_top = 50,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away2",
    id = 0
  },
  bnd_scoreBg_width = 25,
  bnd_scoreBg_height = 61,
  bnd_scoreBg_right = 15,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 0
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -57,
  bnd_homeName_top = -15,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = 57,
  bnd_awayName_top = 15,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0x000000",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -90,
  bnd_homeCrest_top = -15,
  bnd_homeCrest_width = 25,
  bnd_homeCrest_height = 25,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = 90,
  bnd_awayCrest_top = 15,
  bnd_awayCrest_width = 25,
  bnd_awayCrest_height = 25,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -15,
  bnd_homeScore_left = -16.5,
  bnd_homeScore_fontSize = 21,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 15,
  bnd_awayScore_right = 16,
  bnd_awayScore_fontSize = 21,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "CARABAO CUP",
  bnd_score_top = -44.5,
  bnd_score_left = -130,
  bnd_score_fontSize = 16,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 80,
  bnd_time_height = 30,
  bnd_time_top = -15,
  bnd_time_left = 32,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 0
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 0,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 80,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 14.5,
  bnd_extraTime_left = 32,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 0
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0x000000",

  bnd_stat_visible = false,
  bnd_stat_width = 33,
  bnd_stat_height = 61,
  bnd_stat_top = 0,
  bnd_stat_left = 215,
  bnd_stat_color = "0x00FC7F",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 15,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = -15,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 0,
  bnd_away_stat_text_top = 15,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text_fontColor = "0x000000",
  bnd_stat_text = ""
}
function ScoreClock:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    MatchInfoService = o.api("MatchInfoService"),
    EventManagerService = o.api("EventManagerService"),
    GameSetupService = o.api("GameSetupService"),
    OverlayService = o.api("OverlayService"),
    TeamService = o.api("TeamService")
  }
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)
  
  o.visible = false
  
  local HOMETEAM = 0
  local AWAYTEAM = 1
  o.statType = {
    possession = {
      label = "POS",
      value = 4
    },
    Shots = {
      label = "SHOTS",
      value = 2
    },
    tackle = {
      label = "TACKLE",
      value = 5
    }

  }
  local currentScoreBoard
  
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  self.homeScore = o.services.OverlayService.GetCurrentScore(HOMETEAM)
  self.awayScore = o.services.OverlayService.GetCurrentScore(AWAYTEAM)
  

  o.statVisible = false
  o.homeStat = "0%"
  o.awayStat = "0%"

  o.facts = nil

  liveLogo = {
    name = "$LiveLogo",
    id = 0
  }
  
  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
       currentScoreBoard = UCLScore
       local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, UCLTeamsData)
       local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, UCLTeamsData)
       currentScoreBoard.bnd_homeRect_color = homeColorList[1]
       currentScoreBoard.bnd_awayRect_color = awayColorList[1]
       liveLogo.id = 22
     elseif currentCupData.cupIndex == 2 then
       currentScoreBoard = WorldCupScore
        liveLogo.id = 24
   elseif currentCupData.cupIndex == 3 then
      currentScoreBoard = UCLUelScore
      liveLogo.id = 22
     elseif currentCupData.cupIndex == 4 then
      currentScoreBoard = PialaIndonesiaScore
      liveLogo.id = 25
    elseif currentCupData.cupIndex == 5 then
      currentScoreBoard = WorldCupWomensScore
      liveLogo.id = 26
    elseif currentCupData.cupIndex == 6 then
       currentScoreBoard = UCLWomensScore
        liveLogo.id = 18
    elseif currentCupData.cupIndex == 7 then
       currentScoreBoard = FACupScore
        liveLogo.id = 27
    elseif currentCupData.cupIndex == 8 then
       currentScoreBoard = UCLEuropeScore
        liveLogo.id = 22
     elseif currentCupData.cupIndex == 9 then
       currentScoreBoard = AsianCupScore
        liveLogo.id = 1
      elseif currentCupData.cupIndex == 10 then
       currentScoreBoard = KingSaudiCupScore
        liveLogo.id = 38
      elseif currentCupData.cupIndex == 11 then
      currentScoreBoard = EuroCupScore
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, EuroCupTeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, EuroCupTeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
      liveLogo.id = 22
     elseif currentCupData.cupIndex == 12 then
       currentScoreBoard = UsaOpenCupScore
        liveLogo.id = 29
    elseif currentCupData.cupIndex == 13 then
      currentScoreBoard = AfcCupScore
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, AfcCupTeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, AfcCupTeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_homeScore_fontColor = homeColorList[2]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
      currentScoreBoard.bnd_awayScore_fontColor = awayColorList[2]
       liveLogo.id = 28
    elseif currentCupData.cupIndex == 14 then
      currentScoreBoard = CopaDelReyScore
       liveLogo.id = 30
    elseif currentCupData.cupIndex == 15 then
      currentScoreBoard = AfricaCupScore
       liveLogo.id = 32
    elseif currentCupData.cupIndex == 16 then
      currentScoreBoard = CoppaItaliaScore
       liveLogo.id = 31
    elseif currentCupData.cupIndex == 17 then
      currentScoreBoard = DfbPokalScore
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, DfbPokalTeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, DfbPokalTeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
       liveLogo.id = 33
    elseif currentCupData.cupIndex == 18 then
       currentScoreBoard = ClassicCupScore 
    liveLogo.id = 34
    elseif currentCupData.cupIndex == 19 then
       currentScoreBoard = CoupeDeFranceScore 
    liveLogo.id = 35
   elseif currentCupData.cupIndex == 20 then
      currentScoreBoard = FcWcScore
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, FcWcTeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, FcWcTeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
      liveLogo.id = 36
      elseif currentCupData.cupIndex == 21 then
      currentScoreBoard = CopaLibertadoresScore 
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 22 then
      currentScoreBoard = UefaNationsScore 
      liveLogo.id = 22
      elseif currentCupData.cupIndex == 23 then
      currentScoreBoard = CopaAmericaScore 
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 24 then
      currentScoreBoard = CarabaoCupScore 
      liveLogo.id = 0
   else 
    currentScoreBoard = EAFCScore
    liveLogo.id = 0
  end
  end

  

  currentScoreBoard.bnd_homeCrest.id = o.TeamsData[1].assetId
  currentScoreBoard.bnd_awayCrest.id = o.TeamsData[2].assetId

  currentScoreBoard.bnd_homeName_text = o.services.GameSetupService.GetTeamShortName(HOMETEAM)
  currentScoreBoard.bnd_awayName_text = o.services.GameSetupService.GetTeamShortName(AWAYTEAM)

  o.im.Subscribe("bnd_visible", function()
    o:publishVisible()
  end)
  
   for k,v in pairs(currentScoreBoard) do
    o.im.Subscribe(k, function()
      if k == "bnd_homeScore_text" then
        o:publishScoreHome()
      elseif k == "bnd_awayScore_text" then
        o:publishScoreAway()
      elseif k == "bnd_time_text" then
        o:publishTime()
      elseif k == "bnd_extraTime_visible" then
        o:publishExtraTimeVisibility(false)
      elseif k == "bnd_extraTime_text" then
        o:publishExtraTime()
      elseif k == "bnd_home_stat_text" or k == "bnd_away_stat_text" then
        o:publishStat()
      else
        o.im.Publish(k, v)
      end
    end)
  end

 
  
  o.im.Subscribe("bnd_live_logo", function()
    o.im.Publish("bnd_live_logo", liveLogo)
  end)

  return o
end



-----------------------------------------------------------------------------------------------------------
function ScoreClock:publishScoreHome()
  self.im.Publish("bnd_homeScore_text", tostring(self.homeScore))
end
function ScoreClock:publishScoreAway()
  self.im.Publish("bnd_awayScore_text", tostring(self.awayScore))
end
function ScoreClock:publishTime()
  if self.gameTime ~= "" and self.gameTime ~= nil then
    self.im.Publish("bnd_time_text", tostring(self.gameTime))
  end
end
function ScoreClock:publishExtraTime()
  if self.gameExtraTime ~= "" and self.gameExtraTime ~= nil then
    self.im.Publish("bnd_extraTime_text", tostring(self.gameExtraTime))
  end
end

function ScoreClock:publishStat()
  local statTypeLabel = ""
  local statTypeValue = 0
  if self.gameTime ~= "" and self.gameTime ~= nil then
    local gameTime = string.sub(self.gameTime, 1, string.find(self.gameTime, ":") - 1)
    if (gameTime + 0 > 30 and gameTime + 0 < 35) or (gameTime + 0 > 60 and gameTime + 0 < 65) then
      statTypeLabel = self.statType.possession.label
      statTypeValue = self.statType.possession.value
    elseif (gameTime + 0 > 20 and gameTime + 0 < 25) or (gameTime + 0 > 50 and gameTime + 0 < 55) then
      statTypeLabel = self.statType.Shots.label
      statTypeValue = self.statType.Shots.value
    elseif (gameTime + 0 > 40 and gameTime + 0 < 45) or (gameTime + 0 > 70 and gameTime + 0 < 75) then
      statTypeLabel = self.statType.tackle.label
      statTypeValue = self.statType.tackle.value
    else
      self.facts = nil
      self.statVisible = false
    end
    if statTypeValue > 0 then
      if self.facts == nil then
        self.facts = self:getMatchFacts()
      end
      self.homeStat = self.facts[statTypeValue].data.value
      self.awayStat = self.facts[statTypeValue].data.valueRight
      self.statVisible = true
    end
    -- self.statVisible = true
    self.im.Publish("bnd_stat_text", statTypeLabel)
    self.im.Publish("bnd_stat_visible", self.statVisible)
    self.im.Publish("bnd_home_stat_text", tostring(self.homeStat))
    self.im.Publish("bnd_away_stat_text", tostring(self.awayStat))
  end
end


function ScoreClock:getMatchFacts()
  local facts = self.services.MatchInfoService.GetMatchFacts(true)
  local o = facts.homeData
  for i, v in ipairs(o) do
    v.data.valueRight = facts.awayData[i].data.value
  end
  return o
end
-----------------------------------------------------------------------------------------------------------

function ScoreClock:handleEvent(eventType, data)
  if eventType == EventTypes.OverlayTypeGumby then
    self:updateGameTime(data.subtype, data.hideshow, data.subtypestr, data.msg)
  elseif eventType == EventTypes.OverlayTypeGoal or eventType == EventTypes.OverlayTypeMatchEvents then
    self:updateGameScore(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function ScoreClock:updateGameTime(subtype, hideshow, subtypestr, msg)
  local params = OverlayParam.split(msg, "|")
  self.gameTime = ""
  self.gameExtraTime = ""
  if #params == 3 then
    if string.find(params[1], ":") then
      self.gameExtraTime = params[3]
      self:publishExtraTime()
      self:publishExtraTimeVisibility(true)
    end
    self.gameTime = params[1]
    self:publishTime()
    self:publishStat()
  elseif #params == 4 then
    self.im.Publish(bndAlpha, params[1] / 100)
  elseif params and table.getn(params) > 0 then
    if string.find(params[1], ":") then
      self.gameTime = params[1]
    end
    if params[1] == "" then
      self:publishExtraTimeVisibility(false)
    end
    self:publishTime()
    self:publishStat()
  end
  self.visible = hideshow == "SHOW" or hideshow == "UPDATE"
  self:publishVisible()
end

function ScoreClock:updateGameScore(subtype, hideshow, subtypestr, msg)
  if hideshow ~= "HIDE" then
    local params = OverlayParam.split(msg, "|")
    if params and table.getn(params) >= 6 then
      self.homeScore = params[5]
      self.awayScore = params[6]
      self:publishScoreHome()
      self:publishScoreAway()
    end
  end
end

function ScoreClock:publishExtraTimeVisibility(visible)
  self.im.Publish("bnd_extraTime_visible", visible)
end

function ScoreClock:publishVisible()
  self.im.Publish("bnd_visible", self.visible)
end

function ScoreClock:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function ScoreClock:getTeamHomeColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.homeColor
      result[2] = v.homeFontColor
    end
  end
  return result
end

function ScoreClock:getTeamAwayColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.awayColor
      result[2] = v.awayFontColor
    end
  end
  return result
end
    
function ScoreClock:finalize()
  for k,v in pairs(EAFCScore) do
    self.im.Unsubscribe(k)
  end
  self.im.Unsubscribe("bnd_live_logo")
  self.im.Unsubscribe("bnd_visible")
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return ScoreClock