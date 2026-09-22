-- Thanks : Ma'ruf Id & Laosiji --
-- mvnprod.official --
-- talamlegit.official - Patch Mod EAFC24 --

local Starting11 = {}
local TableUtil, FormationModel, OverlaysIdContainer, OverlayParam, eventmanager = ...
local OVERLAY_TYPES = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

local leagueIDs = {
   Algeria = 2262,
   afc = 365,
   Argentina = 353,
   AsianCupU23 = 2264,
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
   Mexico = 341,
   Morocco = 2250,
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

AlgeriaInfo = { 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 0
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0x1AFE68",
  bnd_player_number_fontColor = "0x151515",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x151515",
  --TeamCrest
  bnd_team_crest_width = 170,
  bnd_team_crest_height = 170,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 65,
  bnd_team_crest_top = 35,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xF5F5F5",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 280,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xF5F5F5",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 130,
  bnd_team_formation_top = 435,
  --Subt
  bnd_posisi_sub_left = -450,
  bnd_posisi_sub_top = -10,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x151515",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x151515",
  bnd_playergksub_fontColor = "0x151515",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2262
  },
  bnd_logo_width = 60,
  bnd_logo_height = 60,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
afcInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_forceCaps = true,
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 20,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID9"
  },
  bnd_formation_left = 200,
  bnd_formation_top = 34,
  bnd_bg_number_color = "0x2D065F",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xffffff",
  bnd_player_name_fontColor = "0x2D065F",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 220,
  bnd_team_crest_top = 45,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 120,
  bnd_team_name_top = 400,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x94DF2A",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 430,
  bnd_team_formation_top = 37,
  --Subt
  bnd_posisi_sub_left = -480,
  bnd_posisi_sub_top = -120,
  bnd_text_sub = "SUBTITUTES ",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = -40,
  bnd_playersub_fontSize = 17,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = -30,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -40,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID9_1"
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0
}
AsianCupU23Info = {
  bnd_forceCaps = true,
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = -5,
  bnd_field = {
    name = "$FieldTeams",
    id = 2264
  },
  bnd_formation_left = 135,
  bnd_formation_top = 60,
  bnd_bg_number_color = "0xFCDD10",
  bnd_player_number_fontColor = "0x31146B",
  bnd_bg_name_color = "0xffffff",
  bnd_player_name_fontColor = "0x000000",
  --TeamCrest
  bnd_team_crest_width = 98,
  bnd_team_crest_height = 98,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = -50,
  bnd_team_crest_right = 205,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 900,
  bnd_team_name_color_height = 60,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0xC2071C",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 50,
  bnd_team_name_top = -20,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x31146B",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 290,
  bnd_team_formation_top = 40,
  --Subt
  bnd_posisi_sub_left = -475,
  bnd_posisi_sub_top = -165,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 200,
  bnd_team_crest2_height = 200,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 30,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -15,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2264
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 25,
  bnd_logo_bottom = 0
}
ClassicInfo = {
  bnd_team_crest3_show = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl", 
  bnd_field_width = 1400,
  bnd_field_height = 640,
  bnd_field_left = 60,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 1245
  },
  bnd_formation_left = -85,
  bnd_formation_top = 40,
  bnd_bg_number_color = "0x22C1A3",
  bnd_player_number_fontCOLOR = "0x000000",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x132041",
  --TeamCrest
  bnd_team_crest_width = 45,
  bnd_team_crest_height = 45,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 864,
  bnd_team_crest_top = 68,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 910,
  bnd_team_name_top = 75,
  --TeamFormation
  bnd_team_name_multiline = true,
  bnd_team_name_width = 210,     
  bnd_team_name_color = "0x000000",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = 380,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 19,
  bnd_team_formation_fontColor = "0x000000",
  bnd_team_formation_alignV = "CENTER",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 380,
  bnd_team_formation_top = 240,
  --Subt
  bnd_posisi_sub_left = 340,
  bnd_posisi_sub_top = -60,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 14,
  bnd_text_sub_fontColor = "0x000000",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 14,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0xD0950B",
  --Coach/Manager
  bnd_team_crest2_width = 175,
  bnd_team_crest2_height = 175,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 700,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -27,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 1245
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -300,
  bnd_title_top = -230,
  bnd_text_title = "CLASSIC TEAM",
  bnd_text_title_fontSize = 25,
  bnd_text_title_fontColor = "0xFFFFFF",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}
D1ArkemaInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 2218
  },
  bnd_formation_left = 135,
  bnd_formation_top = 35,
  bnd_formation_scaleX = 0.8,
  bnd_formation_scaleY = 0.8,
  bnd_bg_number_color = "0x061A3E",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xffffff",
  bnd_player_name_fontColor = "0x061A3E",
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 40,
  bnd_team_crest_right = 25,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 280,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 280,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -475,
  bnd_posisi_sub_top = -160,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 5,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 200,
  bnd_team_crest2_height = 200,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2218
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = -35,
  bnd_logo_top = -30,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0
}
EAFCInfo = {
  bnd_team_crest3_show = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl", 
  bnd_field_width = 1400,
  bnd_field_height = 640,
  bnd_field_left = 60,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 0
  },
  bnd_formation_left = -85,
  bnd_formation_top = 70,
  bnd_bg_number_color = "0x00FF6D",
  bnd_player_number_fontCOLOR = "0x000000",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x132041",
  --TeamCrest
  bnd_team_crest_width = 45,
  bnd_team_crest_height = 45,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 864,
  bnd_team_crest_top = 68,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 910,
  bnd_team_name_top = 85,
  --TeamFormation
  bnd_team_name_multiline = true,
  bnd_team_name_width = 210,     
  bnd_team_name_color = "0x000000",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = 380,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 19,
  bnd_team_formation_fontColor = "0x000000",
  bnd_team_formation_alignV = "CENTER",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 380,
  bnd_team_formation_top = 240,
  --Subt
  bnd_posisi_sub_left = 340,
  bnd_posisi_sub_top = -60,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 14,
  bnd_text_sub_fontColor = "0x000000",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 14,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0xD0950B",
  --Coach/Manager
  bnd_team_crest2_width = 175,
  bnd_team_crest2_height = 175,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 700,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -27,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "0_1"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -300,
  bnd_title_top = -230,
  bnd_text_title = "FRIENDLY",
  bnd_text_title_fontSize = 25,
  bnd_text_title_fontColor = "0xFFFFFF",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}
EnglandInfo = { 
  bnd_fontFace = "$Epl",
  bnd_field_width = 1500,
  bnd_field_height = 708,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 13
  },
  bnd_formation_left = -153,
  bnd_formation_top = 60,
  bnd_bg_number_color = "0x39003E",
  bnd_player_number_fontColor = "0xF5F5F5",
  bnd_bg_name_color = "0x39003E",
  bnd_player_name_fontColor = "0xF5F5F5",
  --TeamCrest
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 150,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 60,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontColor = "0x39003E",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = -100,
  bnd_team_name_top = -50,
  --TeamFormation
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0x39003E",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 600,
  bnd_team_formation_top = -58,
  --Subt
  bnd_posisi_sub_left = 380,
  bnd_posisi_sub_top = 0,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xF5F5F5",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 4,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xF5F5F5",
  bnd_playergksub_fontColor = "0xF5F5F5",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
FranceInfo = {
  bnd_fontFace = "$Ligue1",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 16
  },
  bnd_formation_left = -115,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0x575757",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x575757",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 55,
  bnd_team_crest_height = 55,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 325,
  bnd_team_crest_top = -40,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 400,
  bnd_team_name_top = -20,
  --TeamFormation
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xFFFFFF",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 890,
  bnd_team_formation_top = -20,
  --Subt
  bnd_posisi_sub_left = 335,
  bnd_posisi_sub_top = -165,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xFFFFFF",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 200,
  bnd_team_crest2_height = 200,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = -20,
  bnd_team_crest2_bottom = 20,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 16
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 230,
  bnd_logo_bottom = 0
}
France2Info = {
  bnd_fontFace = "$Ligue1",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 17
  },
  bnd_formation_left = -115,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0x575757",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x575757",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 55,
  bnd_team_crest_height = 55,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 325,
  bnd_team_crest_top = -40,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 400,
  bnd_team_name_top = -20,
  --TeamFormation
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xFFFFFF",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 890,
  bnd_team_formation_top = -20,
  --Subt
  bnd_posisi_sub_left = 335,
  bnd_posisi_sub_top = -165,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xFFFFFF",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 200,
  bnd_team_crest2_height = 200,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = -20,
  bnd_team_crest2_bottom = 20,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 16
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 230,
  bnd_logo_bottom = 0
}
GermanyInfo = {
  bnd_fontFace = "$Bundesliga",
  bnd_field_width = 1500,
  bnd_field_height = 708,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 19
  },
  bnd_formation_left = -83,
  bnd_formation_top = 40,
  bnd_bg_number_color = "0xD10214",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x333333",
  --TeamCrest
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 150,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 60,
  bnd_team_crest_right = 75,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 150,
  bnd_team_name_top = 50,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 630,
  bnd_team_formation_top = 52,
  --Subt
  bnd_posisi_sub_left = 305,
  bnd_posisi_sub_top = -5,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xFFFFFF",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 4,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 19
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
Germany2Info = {
  bnd_fontFace = "$Bundesliga",
  bnd_field_width = 1500,
  bnd_field_height = 708,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 20
  },
  bnd_formation_left = -83,
  bnd_formation_top = 40,
  bnd_bg_number_color = "0xD10214",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x333333",
  --TeamCrest
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 150,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 60,
  bnd_team_crest_right = 75,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 150,
  bnd_team_name_top = 50,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 630,
  bnd_team_formation_top = 52,
  --Subt
  bnd_posisi_sub_left = 305,
  bnd_posisi_sub_top = -5,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xFFFFFF",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 4,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 20
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
IndonesiaInfo = {
  bnd_fontFace = "$Liga1",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 20,
  bnd_field = {
    name = "$FieldTeams",
    id = 2235
  },
  bnd_formation_left = 117,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0xffffff",
  bnd_player_number_fontColor = "0x000000",
  bnd_bg_name_color = "0x00519D",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 188,
  bnd_team_crest_top = 45,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 310,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 310,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -550,
  bnd_posisi_sub_top = -100,
  bnd_text_sub = "SUBTITUTES :",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = -40,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 180,
  bnd_team_crest2_height = 180,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = -15,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -70,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -485,
  bnd_title_top = 205,
  bnd_text_title = "",
  bnd_text_title_fontSize = 20,
  bnd_text_title_fontColor = "0xffffff",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}
ItalyInfo = {
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 40,
  bnd_field = {
    name = "$FieldTeams",
    id = 31
  },
  bnd_formation_left = -115,
  bnd_formation_top = 40,
  bnd_bg_number_color = "0x007EFF",
  bnd_player_number_fontColor = "0x000000",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x132041",
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 115,
  bnd_team_crest_right = 200,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 780,
  bnd_team_name_top = 85,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 780,
  bnd_team_formation_top = 205,
  --Subt
  bnd_posisi_sub_left = 255,
  bnd_posisi_sub_top = 0,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 17,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 13,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xD4D900",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 115,
  bnd_team_crest2_right = 160,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
JapanInfo = {
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 349
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0xF5F5F5",
  bnd_player_number_fontColor = "0x151515",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x151515",
  --TeamCrest
  bnd_team_crest_width = 170,
  bnd_team_crest_height = 170,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 65,
  bnd_team_crest_top = 35,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0xF5F5F5",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 285,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xF5F5F5",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 130,
  bnd_team_formation_top = 435,
  --Subt
  bnd_posisi_sub_left = -450,
  bnd_posisi_sub_top = -10,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x151515",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x151515",
  bnd_playergksub_fontColor = "0x151515",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 349
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 7,
  bnd_logo_bottom = 0
}
SaudiArabiaInfo = {
  bnd_fontFace = "$SPL",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 350
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0x253242",
  bnd_player_number_fontColor = "0xF9FDFD",
  bnd_bg_name_color = "0x253242",
  bnd_player_name_fontColor = "0xF9FDFD",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 95,
  bnd_team_crest_top = 65,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472B",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0x253242",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "CENTER",
  bnd_team_name_left = -90,
  bnd_team_name_top = 447,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x253242",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 400,
  bnd_team_formation_top = 447,
  --Subt
  bnd_posisi_sub_left = -470,
  bnd_posisi_sub_top = -30,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xF9FDFD",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xF9FDFD",
  bnd_playergksub_fontColor = "0xF9FDFD",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = "350_2"
  },
  bnd_logo_width = 70,
  bnd_logo_height = 70,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
SpainInfo = {
  bnd_team_crest3_show = true,
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 53
  },
  bnd_formation_left = -175,
  bnd_formation_top = 60,
  bnd_bg_number_color = "",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 150,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = -1111111000,
  bnd_team_crest_top = 0,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_crest3_width = 65,
  bnd_team_crest3_height = 65,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 45,
  bnd_team_crest3_top = 13,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xF5F5F5",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 280,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xF5F5F5",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 200,
  bnd_team_formation_top = 435,
  --Subt
  bnd_posisi_sub_left = 180,
  bnd_posisi_sub_top = -100,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0x151515",
  bnd_text_sub_left = 40,
  bnd_text_sub_top = -30,
  bnd_playersub_fontSize = 25,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 180,
  bnd_team_crest2_height = 180,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_lefl = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 50,
  bnd_team_crest2_bottom = -45,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 53
  },
  bnd_logo_width = 120,
  bnd_logo_height = 30,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = 800,
  bnd_logo_top = 30,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0
}
Spain2Info = {
  bnd_team_crest3_show = true,
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = -5,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 54
  },
  bnd_formation_left = -175,
  bnd_formation_top = 60,
  bnd_bg_number_color = "",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 150,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = -1111111000,
  bnd_team_crest_top = 0,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_crest3_width = 65,
  bnd_team_crest3_height = 65,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 45,
  bnd_team_crest3_top = 13,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xF5F5F5",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 280,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 0,
  bnd_team_formation_fontColor = "0xF5F5F5",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 130,
  bnd_team_formation_top = 435,
  --Subt
  bnd_posisi_sub_left = 180,
  bnd_posisi_sub_top = -100,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0x151515",
  bnd_text_sub_left = 40,
  bnd_text_sub_top = -30,
  bnd_playersub_fontSize = 25,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 54
  },
  bnd_logo_width = 120,
  bnd_logo_height = 30,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = 800,
  bnd_logo_top = 30,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0
}
LigaFInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 2222
  },
  bnd_formation_left = -100,
  bnd_formation_top = -65,
  bnd_bg_number_color = "0x2C6ADB",
  bnd_player_number_fontColor = "0xFFFFFF",
  bnd_bg_name_color = "0xFFFFFF",
  bnd_player_name_fontColor = "0x000000",
  --TeamCrest
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 150,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 35,
  bnd_team_crest_right = 60,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 25,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 130,
  bnd_team_name_top = 400,
  --TeamFormation
  bnd_team_formation_fontSize = 17,
  bnd_team_formation_fontColor = "0x000000",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 131,
  bnd_team_formation_top = 430,
  --Subt
  bnd_posisi_sub_left = 320,
  bnd_posisi_sub_top = -30,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xFFFFFF",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xFFFFFF",
  bnd_playergksub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 150,
  bnd_team_crest2_height = 150,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 350,
  bnd_team_crest2_bottom = -25,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2222_1"
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "BOTTOM",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 0,
  bnd_logo_right = 320,
  bnd_logo_bottom = 10
}
MalaysiaInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Malaysia",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 28,
  bnd_field = {
    name = "$FieldTeams",
    id = 2237
  },
  bnd_formation_left = 86,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0x16FEC2",
  bnd_player_number_fontColor = "0x12126A",
  bnd_bg_name_color = "0x12126A",
  bnd_player_name_fontColor = "0x16FEC2",
  --TeamCrest
  bnd_team_crest_width = 180,
  bnd_team_crest_height = 180,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 80,
  bnd_team_crest_top = 10,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0x16FEC2",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 450,
  bnd_team_name_top = -10,
  --TeamFormation
  bnd_team_formation_fontSize = 30,
  bnd_team_formation_fontColor = "0x16FEC2",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 120,
  bnd_team_formation_top = 400,
  --Subt
  bnd_posisi_sub_left = 410,
  bnd_posisi_sub_top = -140,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x16FEC2",
  bnd_text_sub_left = -20,
  bnd_text_sub_top = -10,
  bnd_playersub_fontSize = 16,
  bnd_playersub_fontColor = "0x16FEC2",
  bnd_playergksub_fontColor = "0x16FEC2",
  --Coach/Manager
  bnd_team_crest2_width = 190,
  bnd_team_crest2_height = 190,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 100,
  bnd_team_crest2_top = 280,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 53
  },
  bnd_logo_width = 135,
  bnd_logo_height = 30,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 25,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -440,
  bnd_title_top = 120,
  bnd_text_title = "HEAD COACH",
  bnd_text_title_fontSize = 15,
  bnd_text_title_fontColor = "0x16FEC2",
  bnd_text_title_left = 40,
  bnd_text_title_top = -40
}
NetherlandsInfo = {
  bnd_fontFace = "$Eredivisie",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 10
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0x5C5C5C",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x5C5C5C",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 160,
  bnd_team_crest_height = 160,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 65,
  bnd_team_crest_top = 35,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0x5C5C5C",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 120,
  bnd_team_name_top = 200,
  --TeamFormation
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xF5F5F5",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 130,
  bnd_team_formation_top = 435,
  --Subt
  bnd_posisi_sub_left = -480,
  bnd_posisi_sub_top = 15,
  bnd_text_sub = "Subtitution",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "0_1"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
PegadaianLiga2Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 20,
  bnd_field = {
    name = "$FieldTeams",
    id = 2254
  },
  bnd_formation_left = 135,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0xAED328",
  bnd_player_number_fontColor = "0x07472B",
  bnd_bg_name_color = "0x07472B",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 45,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472B",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0x07472B",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 140,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 30,
  bnd_team_formation_fontColor = "0x07472B",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 620,
  bnd_team_formation_top = 35,
  --Subt
  bnd_posisi_sub_left = -500,
  bnd_posisi_sub_top = -85,
  bnd_text_sub = "SUBTITUTES ",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 80,
  bnd_text_sub_top = -40,
  bnd_playersub_fontSize = 17,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -105,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -470,
  bnd_title_top = 207,
  bnd_text_title = "HEAD COACH",
  bnd_text_title_fontSize = 22,
  bnd_text_title_fontColor = "0x07472B",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}
ThailandInfo = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 2252
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0xFE0000",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x3C3C3C",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 140,
  bnd_team_crest_height = 140,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 90,
  bnd_team_crest_top = 35,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xF5F5F5",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 90,
  bnd_team_name_top = 200,
  --TeamFormation
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = 0,
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0x000000",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 130,
  bnd_team_formation_top = 440,
  --Subt
  bnd_posisi_sub_left = -475,
  bnd_posisi_sub_top = 0,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 15,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2252
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = -15,
  bnd_logo_bottom = 0
}
UnitedStatesInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_field_width = 1500,
  bnd_field_height = 708,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 39
  },
  bnd_formation_left = -83,
  bnd_formation_top = 40,
  bnd_bg_number_color = "0x1E1E1E",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x1E1E1E",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 150,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 60,
  bnd_team_crest_right = 75,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472B",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 150,
  bnd_team_name_top = 48,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 630,
  bnd_team_formation_top = 50,
  --Subt
  bnd_posisi_sub_left = 315,
  bnd_posisi_sub_top = -5,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xFFFFFF",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 5,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 39
  },
  bnd_logo_width = 60,
  bnd_logo_height = 60,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = 20,
  bnd_logo_top = 0,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0
}
VietnamInfo = {
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 2260
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0xDEDEDE",
  bnd_player_number_fontColor = "0x000000",
  bnd_bg_name_color = "0xDEDEDE",
  bnd_player_name_fontColor = "0x000000",
  --TeamCrest
  bnd_team_crest_width = 170,
  bnd_team_crest_height = 170,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 65,
  bnd_team_crest_top = 35,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xF5F5F5",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 280,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xF5F5F5",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 130,
  bnd_team_formation_top = 435,
  --Subt
  bnd_posisi_sub_left = -450,
  bnd_posisi_sub_top = -10,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "0_1"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
WomensSuperLeagueInfo = {
  bnd_team_crest3_show = false,
  bnd_forceCaps = true, 
  bnd_fontFace = "$Epl",
  bnd_field_width = 1500,
  bnd_field_height = 708,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 2216
  },
  bnd_formation_left = 0,
  bnd_formation_top = 40,
  bnd_formation_scaleX = 0.8,
  bnd_formation_scaleY = 0.8,
  bnd_bg_number_color = "0x1f0f37",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x1f0f37",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 35,
  bnd_team_crest_height = 35,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 195,
  bnd_team_crest_top = -20,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472B",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 250,
  bnd_team_name_top = -20,
  --TeamFormation
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_formation_fontSize = 0,
  bnd_team_formation_fontColor = "0x1D0F33",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 630,
  bnd_team_formation_top = 58,
  --Subt
  bnd_posisi_sub_left = 380,
  bnd_posisi_sub_top = 0,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 0,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 4,
  bnd_playersub_fontSize = 0,
  bnd_playersub_fontColor = "0xF5F5F5",
  bnd_playergksub_fontColor = "0xF5F5F5",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2216
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
---------------------------------------
-- Starting11 Turnamen --
---------------------------------------

UCLInfo = {
  bnd_team_crest3_show = false,
  bnd_fontFace = "$UCL-Regular",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 2236
  },
  bnd_formation_left = -130,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0xf5f5f5",
  bnd_player_number_fontColor = "0x1e1e1e",
  bnd_bg_name_color = "0xf5f5f5",
  bnd_player_name_fontColor = "0x1e1e1e",
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 25,
  bnd_team_crest_top = 40,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xf5f5f5",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 110,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xf5f5f5",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 110,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = 355,
  bnd_posisi_sub_top = -165,
  bnd_text_sub = "SUBTITUTION ",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = -50,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2236
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 230,
  bnd_logo_bottom = 0
}
UELInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-CondBold",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 2238
  },
  bnd_formation_left = 135,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0xE14711",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xffffff",
  bnd_player_name_fontColor = "0x000000",
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 40,
  bnd_team_crest_right = 25,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 280,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 280,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -475,
  bnd_posisi_sub_top = -165,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2238_1"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = -35,
  bnd_logo_top = -30,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0
}
PialaIndonesiaInfo = {
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 20,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID4"
  },
  bnd_formation_left = 135,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0x3471B2",
  bnd_player_number_fontColor = "0xD8DF3A",
  bnd_bg_name_color = "0x3471B2",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 188,
  bnd_team_crest_top = 45,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 310,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 310,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -550,
  bnd_posisi_sub_top = -140,
  bnd_text_sub = "SUBTITUTES ",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x000000",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = -40,
  bnd_playersub_fontSize = 17,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = -30,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -40,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0
}
WorldCupWomensInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$FWWC2023Bold", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID5"
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0x275759",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x275759",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 95,
  bnd_team_crest_top = 65,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472B",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "CENTER",
  bnd_team_name_left = -90,
  bnd_team_name_top = 447,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 400,
  bnd_team_formation_top = 447,
  --Subt
  bnd_posisi_sub_left = -470,
  bnd_posisi_sub_top = -10,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0x275759",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x275759",
  bnd_playergksub_fontColor = "0x275759",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID5"
  },
  bnd_logo_width = 70,
  bnd_logo_height = 70,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
UefaWomensInfo = { 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 2240
  },
  bnd_formation_left = -130,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0x0872D2",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xffffff",
  bnd_player_name_fontColor = "0x1e1e1e",
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 25,
  bnd_team_crest_top = 40,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = 0,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xFFFFFF",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 110,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xFFFFFF",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 111,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = 355,
  bnd_posisi_sub_top = -165,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xFFFFFF",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xFFFFFF",
  bnd_playergksub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = -20,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2240
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 240,
  bnd_logo_bottom = 0
}
WorldCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Qatar2022Arabic", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID2"
  },
  bnd_formation_left = 180,
  bnd_formation_top = 20,
  bnd_bg_number_color = "0x000000",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x000000",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 95,
  bnd_team_crest_top = 95,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -20,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xF5F5F5",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "CENTER",
  bnd_team_name_left = -70,
  bnd_team_name_top = 4,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x02C7B3",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 400,
  bnd_team_formation_top = 447,
  --Subt
  bnd_posisi_sub_left = -450,
  bnd_posisi_sub_top = -35,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$",
    id = "CupID2"
  },
  bnd_logo_width = 70,
  bnd_logo_height = 70,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
FaCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold", 
  bnd_field_width = 1500,
  bnd_field_height = 708,
  bnd_field_left = 0,
  bnd_field_top = -10,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID7"
  },
  bnd_formation_left = -83,
  bnd_formation_top = 30,
  bnd_bg_number_color = "0xFFFFFF",
  bnd_player_number_fontColor = "0x151515",
  bnd_bg_name_color = "0xFFFFFF",
  bnd_player_name_fontColor = "0x151515",
  --TeamCrest
  bnd_team_crest_width = 120,
  bnd_team_crest_height = 120,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 80,
  bnd_team_crest_right = 155,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472B",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontColor = "0x151515",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 150,
  bnd_team_name_top = 6,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 150,
  bnd_team_formation_top = 65,
  --Subt
  bnd_posisi_sub_left = 230,
  bnd_posisi_sub_top = -15,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 21,
  bnd_text_sub_fontColor = "0xFFFFFF",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 4,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xFFFFFF",
  bnd_playergksub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 0
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
UefaEuropeInfo = {
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID8"
  },
  bnd_formation_left = -115,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0x00BF0C",
  bnd_player_number_fontColor = "0xFFFFFF",
  bnd_bg_name_color = "0xFFFFFF",
  bnd_player_name_fontColor = "0x000000",
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 30,
  bnd_team_crest_right = 250,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = 0,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0x00BF0C",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 30,
  bnd_team_name_top = 25,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xFFFFFF",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 31,
  bnd_team_formation_top = 60,
  --Subt
  bnd_posisi_sub_left = 355,
  bnd_posisi_sub_top = -165,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x00BF0C",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xFFFFFF",
  bnd_playergksub_fontColor = "0x00BF0C",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = -20,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2238
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 230,
  bnd_logo_bottom = 0
}
AsianCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 20,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID9"
  },
  bnd_formation_left = 200,
  bnd_formation_top = 34,
  bnd_bg_number_color = "0x2D065F",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xffffff",
  bnd_player_name_fontColor = "0x2D065F",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 220,
  bnd_team_crest_top = 45,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 120,
  bnd_team_name_top = 400,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x94DF2A",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 430,
  bnd_team_formation_top = 37,
  --Subt
  bnd_posisi_sub_left = -480,
  bnd_posisi_sub_top = -120,
  bnd_text_sub = "SUBTITUTES ",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = -40,
  bnd_playersub_fontSize = 17,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = -30,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -40,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID9_1"
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0
}
KingSaudiCupInfo = {
  bnd_forceCaps = true,
  bnd_field_width = 1500,
  bnd_field_height = 708,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID10"
  },
  bnd_formation_left = -83,
  bnd_formation_top = 30,
  bnd_bg_number_color = "0xFFFFFF",
  bnd_player_number_fontColor = "0x151515",
  bnd_bg_name_color = "0xFFFFFF",
  bnd_player_name_fontColor = "0x151515",
  --TeamCrest
  bnd_team_crest_width = 120,
  bnd_team_crest_height = 120,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 80,
  bnd_team_crest_right = 155,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontColor = "0x151515",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 150,
  bnd_team_name_top = 7,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 150,
  bnd_team_formation_top = 65,
  --Subt
  bnd_posisi_sub_left = 240,
  bnd_posisi_sub_top = -15,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xFFFFFF",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 4,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xFFFFFF",
  bnd_playergksub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 0
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
EuroCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$KnulExtraBold",
  bnd_field_width = 1542,
  bnd_field_height = 718,
  bnd_field_left = -17,
  bnd_field_top = -45,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID11"
  },
  bnd_formation_left = 150,
  bnd_formation_top = 20,
  bnd_bg_number_color = "0xffffff",
  bnd_player_number_fontColor = "0x000000",
  bnd_bg_name_color = "0xffffff",
  bnd_player_name_fontColor = "0x000000",
  --TeamCrest
  bnd_team_crest_width = 180,
  bnd_team_crest_height = 180,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 155,
  bnd_team_crest_top = 400000000,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 380,
  bnd_team_name_top = -60,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xDDC100",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 400,
  bnd_team_formation_top = -10,
  --Subt
  bnd_posisi_sub_left = -500,
  bnd_posisi_sub_top = -195,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xDDC100",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 4,
  bnd_playersub_fontSize = 16,
  bnd_playersub_fontColor = "0xFFFFFF",
  bnd_playergksub_fontColor = "0xDDC100",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 0
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -70,
  bnd_title_top = 215,
  bnd_text_title = "EURO2024.com",
  bnd_text_title_fontSize = 15,
  bnd_text_title_fontColor = "0xffffff",
  bnd_text_title_left = -64,
  bnd_text_title_top = 0
}
UsaOpenCupInfo = {
  bnd_field_width = 1500,
  bnd_field_height = 708,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID12"
  },
  bnd_formation_left = -83,
  bnd_formation_top = 40,
  bnd_bg_number_color = "0xD10214",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x333333",
  --TeamCrest
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 150,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 60,
  bnd_team_crest_right = 75,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 27,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 150,
  bnd_team_name_top = 50,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 630,
  bnd_team_formation_top = 52,
  --Subt
  bnd_posisi_sub_left = 305,
  bnd_posisi_sub_top = -5,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xFFFFFF",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 4,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 28,
  bnd_team_crest2_right = 168,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 19
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
CopaAmerikaInfo = {
  bnd_forceCaps = true,   
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID13"
  },
  bnd_formation_left = 240,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0x0B2D6A",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x0B2D6A",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 70,
  bnd_team_crest_height = 70,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 20,
  bnd_team_crest_top = 20,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -220,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0x0B2D6A",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 135,
  bnd_team_name_top = 40,
  --TeamFormation
  bnd_team_formation_fontSize = 0,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 280,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -475,
  bnd_posisi_sub_top = -135,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID23"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = -35,
  bnd_logo_top = -30,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0
}
CopaDelReyInfo = {
  bnd_team_crest3_show = true,
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 80,
  bnd_field_top = 20,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID14"
  },
  bnd_formation_left = 50,
  bnd_formation_top = 38,
  bnd_bg_number_color = "0xE60035",
  bnd_player_number_fontColor = "0x000000",
  bnd_bg_name_color = "0x1F1831",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 35,
  bnd_team_crest_top = 40000000000005,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_crest3_width = 90,
  bnd_team_crest3_height = 90,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 35,
  bnd_team_crest3_top = 45,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x113A6F",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 260,
  bnd_team_name_top = 42,
  --TeamFormation
  bnd_team_formation_fontSize = 0,
  bnd_team_formation_fontColor = "0xE60035",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 310,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -550,
  bnd_posisi_sub_top = -140,
  bnd_text_sub = "SUBTITUTES ",
  bnd_text_sub_fontSize = 0,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = -40,
  bnd_playersub_fontSize = 0,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = -30,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -40,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0
}
CoppaItaliaInfo = {
  bnd_fontFace = "$Default",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 40,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID15"
  },
  bnd_formation_left = -115,
  bnd_formation_top = 40,
  bnd_bg_number_color = "0xAA1100",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0xF5F5F5",
  bnd_player_name_fontColor = "0x132041",
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 115,
  bnd_team_crest_right = 200,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 780,
  bnd_team_name_top = 85,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 780,
  bnd_team_formation_top = 205,
  --Subt
  bnd_posisi_sub_left = 255,
  bnd_posisi_sub_top = 0,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 17,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 13,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xD4D900",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 115,
  bnd_team_crest2_right = 160,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2231
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "CENTER",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 5,
  bnd_logo_right = 205,
  bnd_logo_bottom = 0
}
DfbPokalInfo = {
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID16"
  },
  bnd_formation_left = 135,
  bnd_formation_top = 35,
  bnd_bg_number_color = "0x05BB6A",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x05BB6A",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 170,
  bnd_team_crest_height = 170,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 45,
  bnd_team_crest_top = 35,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 280,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 280,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -470,
  bnd_posisi_sub_top = -10,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x000000",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID_16"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
CoupeDeFranceInfo = {
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID17"
  },
  bnd_formation_left = 135,
  bnd_formation_top = 35,
  bnd_bg_number_color = "0x071A31",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x071A31",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 170,
  bnd_team_crest_height = 170,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 45,
  bnd_team_crest_top = 35,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xffffff",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 280,
  bnd_team_name_top = 35,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 280,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -470,
  bnd_posisi_sub_top = -10,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x000000",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID_16"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 40,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
FcWcInfo = {
  bnd_team_crest3_show = false,	
  bnd_fontFace = "$DINPro-Bold",	
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID18"
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0xCDA31F",
  bnd_player_number_fontColor = "0x000000",
  bnd_bg_name_color = "0x000000",
  bnd_player_name_fontColor = "0xFFFFFF",
  --TeamCrest
  bnd_team_crest_width = 40,
  bnd_team_crest_height = 40,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 65,
  bnd_team_crest_top = 0,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0xFFFFFF",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0xFFFFFF",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 105,
  bnd_team_name_top = 10,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xFFFFFF",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 400,
  bnd_team_formation_top = 10,
  --Subt
  bnd_posisi_sub_left = -450,
  bnd_posisi_sub_top = -150,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xCDA31F",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID18"
  },
  bnd_logo_width = 70,
  bnd_logo_height = 70,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
CopaLibertadoresInfo = {
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID19"
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0xEDC261",
  bnd_player_number_fontColor = "0x000000",
  bnd_bg_name_color = "0x986B2A",
  bnd_player_name_fontColor = "0x000000",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 95,
  bnd_team_crest_top = 65,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472B",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "CENTER",
  bnd_team_name_left = -90,
  bnd_team_name_top = 447,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x000000",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 400,
  bnd_team_formation_top = 447,
  --Subt
  bnd_posisi_sub_left = -470,
  bnd_posisi_sub_top = -30,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0x000000",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID19"
  },
  bnd_logo_width = 70,
  bnd_logo_height = 70,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
UefaNationsInfo = { 
  bnd_fontFace = "$UEFANations-Bold",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = "CupID20"
  },
  bnd_formation_left = 133,
  bnd_formation_top = -1,
  bnd_bg_number_color = "0x253242",
  bnd_player_number_fontColor = "0xF9FDFD",
  bnd_bg_name_color = "0x253242",
  bnd_player_name_fontColor = "0xF9FDFD",
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 95,
  bnd_team_crest_top = 65,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "0x07472B",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0x253242",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "CENTER",
  bnd_team_name_left = -90,
  bnd_team_name_top = 447,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x253242",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 400,
  bnd_team_formation_top = 447,
  --Subt
  bnd_posisi_sub_left = -470,
  bnd_posisi_sub_top = -30,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xF9FDFD",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xF9FDFD",
  bnd_playergksub_fontColor = "0xF9FDFD",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 38,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -5,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID20"
  },
  bnd_logo_width = 70,
  bnd_logo_height = 70,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 25,
  bnd_logo_right = 5,
  bnd_logo_bottom = 0
}
AseanChampionshipInfo = {
  bnd_fontFace = "$Liga1",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 27
  },
  bnd_formation_left = 117,
  bnd_formation_top = 0,
  bnd_bg_number_color = "0xffffff",
  bnd_player_number_fontColor = "0xc82727",
  bnd_bg_name_color = "0xc82727",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 230,
  bnd_team_crest_height = 230,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = -10,
  bnd_team_crest_top = 170,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -1500000,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 310,
  bnd_team_name_top = 45,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 310,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -480,
  bnd_posisi_sub_top = -30,
  bnd_text_sub = "SUBTITUTES :",
  bnd_text_sub_fontSize = 0,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = -10,
  bnd_text_sub_top = 0,
  bnd_playersub_fontSize = 0,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 150,
  bnd_team_crest2_height = 150,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 6000000000,
  bnd_team_crest2_top = -60,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -70,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0
}
AfrikaCupInfo = {
  bnd_fontFace = "$Liga1",
  bnd_field_width = 1430,
  bnd_field_height = 660,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$FieldTeams",
    id = 26
  },
  bnd_formation_left = 240,
  bnd_formation_top = 20,
  bnd_bg_number_color = "0x860000",
  bnd_player_number_fontColor = "0xffffff",
  bnd_bg_name_color = "0x860000",
  bnd_player_name_fontColor = "0xffffff",
  --TeamCrest
  bnd_team_crest_width = 65,
  bnd_team_crest_height = 65,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 200,
  bnd_team_crest_top = 446,
  bnd_team_crest_right = 100,
  bnd_team_crest_bottom = 0,
  
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 50,
  bnd_team_name_color_height = 50,
  bnd_team_name_color_left = 550000000000,
  bnd_team_name_color_top = 0,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 440,
  bnd_team_name_top = 455,
  --TeamFormation
  bnd_team_formation_fontSize = 30,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 710,
  bnd_team_formation_top = 460,
  --Subt
  bnd_posisi_sub_left = -470,
  bnd_posisi_sub_top = -100,
  bnd_text_sub = "SUBTITUTES :",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 0,
  bnd_playersub_fontSize = 20,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 60,
  bnd_team_crest2_top = -60,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -70,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -485,
  bnd_title_top = 205,
  bnd_text_title = "",
  bnd_text_title_fontSize = 20,
  bnd_text_title_fontColor = "0xffffff",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}
function Starting11:new(init)
  print("[Starting11]: new()")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    TacticsService = o.api("TacticsService"),
    SquadManagementService = o.api("SquadMgtService"),
    eventManService = o.api("EventManagerService"),
    MatchInfoService = o.api("MatchInfoService"),
    OverlayService = o.api("OverlayService"),
    TeamService = o.api("TeamService")
  }
  o.handlerId = o.services.eventManService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)

  
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  
  local AlgeriaTeams = o.services.TeamService.GetTeams(leagueIDs.Algeria, 0, 0, true)
  local afcTeams = o.services.TeamService.GetTeams(leagueIDs.afc, 0, 0, true)
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
  
  local currentdata = nil
  
  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      currentdata = UCLInfo
      elseif currentCupData.cupIndex == 2 then
      currentdata = WorldCupInfo
      elseif currentCupData.cupIndex == 3 then
      currentdata = UELInfo
      elseif currentCupData.cupIndex == 4 then
      currentdata = PialaIndonesiaInfo
      elseif currentCupData.cupIndex == 5 then
      currentdata = WorldCupWomensInfo
      elseif currentCupData.cupIndex == 6 then
      currentdata = UefaWomensInfo
      elseif currentCupData.cupIndex == 7 then
      currentdata = FaCupInfo
      elseif currentCupData.cupIndex == 8 then
      currentdata = UefaEuropeInfo
      elseif currentCupData.cupIndex == 9 then
      currentdata = AsianCupInfo
      elseif currentCupData.cupIndex == 10 then
      currentdata = KingSaudiCupInfo
      elseif currentCupData.cupIndex == 11 then
      currentdata = EuroCupInfo
      elseif currentCupData.cupIndex == 12 then
      currentdata = UsaOpenCupInfo
      elseif currentCupData.cupIndex == 13 then
      currentdata = CopaAmerikaInfo
      elseif currentCupData.cupIndex == 14 then
      currentdata = CopaDelReyInfo
      elseif currentCupData.cupIndex == 15 then
      currentdata = CoppaItaliaInfo
      elseif currentCupData.cupIndex == 16 then
      currentdata = DfbPokalInfo
      elseif currentCupData.cupIndex == 17 then
      currentdata = CoupeDeFranceInfo
      elseif currentCupData.cupIndex == 18 then
      currentdata = FcWcInfo
      elseif currentCupData.cupIndex == 19 then
      currentdata = CopaLibertadoresInfo
      elseif currentCupData.cupIndex == 20 then
      currentdata = UefaNationsInfo
    end
  elseif currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      currentdata = UCLInfo
      elseif currentTourData.tourIndex == 2 then
      currentdata = WorldCupInfo
      elseif currentTourData.tourIndex == 3 then
      currentdata = UELInfo
      elseif currentTourData.tourIndex == 29 then
      currentdata = PialaIndonesiaInfo
      elseif currentTourData.tourIndex == 35 then
      currentdata = WorldCupWomensInfo
      elseif currentTourData.tourIndex == 16 then
      currentdata = UefaWomensInfo      
      elseif currentTourData.tourIndex == 9 then
      currentdata = FaCupInfo
      elseif currentTourData.tourIndex == 17 then
      currentdata = UefaEuropeInfo
      elseif currentTourData.tourIndex == 34 then
      currentdata = AsianCupInfo
      elseif currentTourData.tourIndex == 6 then
      currentdata = EuroCupInfo
      elseif currentTourData.tourIndex == 13 then
      currentdata = UsaOpenCupInfo
      elseif currentTourData.tourIndex == 25 then
      currentdata = CopaAmerikaInfo
      elseif currentTourData.tourIndex == 26 then
      currentdata = AfrikaCupInfo      
      elseif currentTourData.tourIndex == 27 then
      currentdata = AseanChampionshipInfo      
      elseif currentTourData.tourIndex == 10 then
      currentdata = CopaDelReyInfo
      elseif currentTourData.tourIndex == 11 then
      currentdata = CoppaItaliaInfo
      elseif currentTourData.tourIndex == 7 then
      currentdata = DfbPokalInfo
      elseif currentTourData.tourIndex == 18 then
      currentdata = CoupeDeFranceInfo
      elseif currentTourData.tourIndex == 15 then
      currentdata = FcWcInfo
      elseif currentTourData.tourIndex == 4 then
      currentdata = CopaLibertadoresInfo
      elseif currentTourData.tourIndex == 50 then
      currentdata = KingSaudiCupInfo      
      elseif currentTourData.tourIndex == 22 then
      currentdata = ClassicInfo   
    currentdata.bnd_logo.id = 1245
    currentdata.bnd_text_title = "Classic Tour"
    currentdata.bnd_text_title_left = -105   
      elseif currentTourData.tourIndex == 28 then
      currentdata = UefaNationsInfo
      elseif currentTourData.tourIndex == 24 then
      currentdata = EAFCInfo
    currentdata.bnd_text_title = "ACL Elit" 
    currentdata.bnd_text_title_left = -105        
      elseif currentTourData.tourIndex == 31 then
      currentdata = EAFCInfo   
    currentdata.bnd_text_title = "ACL Two"  
    currentdata.bnd_text_title_left = -105       
      elseif currentTourData.tourIndex == 21 then
      currentdata = EAFCInfo      
    currentdata.bnd_text_title = "ACL"   
    currentdata.bnd_text_title_left = -105      
  else 
    currentdata = EAFCInfo      
    end    
  else
  if o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
    currentdata = AlgeriaInfo
    elseif o:isInTable(o.TeamsData[1], afcTeams) and o:isInTable(o.TeamsData[2], afcTeams) then
    currentdata = afcInfo
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 353
    currentdata.bnd_text_title = "LPF"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
    currentdata = AsianCupU23Info
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 4
    currentdata.bnd_text_title = "Jupiter Pro League"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = "7_1"
    currentdata.bnd_text_title = "Brasileiro Serie-A"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    currentdata = ClassicInfo
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    currentdata = ClassicInfo
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 14
    currentdata.bnd_text_title = "FL CHAMPIONSHIP"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = "1_1"
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    currentdata = D1ArkemaInfo
    elseif  o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 2018
    elseif  o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = "2231_1"
    currentdata.bnd_text_title = "EPL NILE"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    currentdata = EnglandInfo
    elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    currentdata = FranceInfo
    elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    currentdata = France2Info
    elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    currentdata = GermanyInfo
    elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
    currentdata = Germany2Info
    elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
    currentdata = IndonesiaInfo
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 78
    currentdata.bnd_text_title = "MEN'S NATIONAL"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 2136
    currentdata.bnd_text_title = "WOMEN'S NATIONAL"
    currentdata.bnd_text_title_left = -110
    elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    currentdata = ItalyInfo
    elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
    currentdata = JapanInfo
    elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 83
    currentdata.bnd_text_title = "K LEAGUE 1"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 60
    currentdata.bnd_text_title = "LEAGUE ONE"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 61
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    currentdata = LigaFInfo
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    currentdata = MalaysiaInfo
    elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 341
    currentdata.bnd_text_title = "LIGA MX"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 2250
    currentdata.bnd_text_title = "Botola Pro Inwi"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    currentdata = NetherlandsInfo
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    currentdata = PegadaianLiga2Info
    elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = "308_1"
    currentdata.bnd_text_title = "Liga Portugal"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 76
    currentdata.bnd_text_title = "Rest Of World"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 76
    currentdata.bnd_text_title = "Rest Of World 2"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    currentdata = SaudiArabiaInfo
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 50
    currentdata.bnd_text_title = "SCOTTISH PREM"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 347
    currentdata.bnd_text_title = "South African Fl"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    currentdata = SpainInfo
    elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    currentdata = Spain2Info
    elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 189
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
    currentdata = ThailandInfo
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 68
    currentdata.bnd_text_title = "Süper Lig"
    currentdata.bnd_text_title_left = -105
    elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    currentdata = UCLInfo
    elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    currentdata = UELInfo
    elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
    currentdata = UefaWomensInfo
    elseif o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
    currentdata = UnitedStatesInfo
    elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USANWSLTeams) then
    currentdata = UnitedStatesInfo
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
    currentdata = VietnamInfo
    elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
    currentdata = WomensSuperLeagueInfo
  else 
    currentdata = EAFCInfo
  end
  end


  o.gamemode = o.data.gamemode or "real"
  o.flow = o.data.flow or "offline"
  o.playerLineup = nil
  o.isActive = false
  o.isVisible = false
  o.models = {
    FormationModel = FormationModel:new({
      im = o.im,
      api = o.api,
      nav = o.nav,
      loc = o.loc,
      gamemode = o.gamemode
    })
  }
  o.bndList = {
    bnd_player1_name = "",
    bnd_player2_name = "",
    bnd_player3_name = "",
    bnd_player4_name = "",
    bnd_player5_name = "",
    bnd_player6_name = "",
    bnd_player7_name = "",
    bnd_player8_name = "",
    bnd_player9_name = "",
    bnd_player10_name = "",
    bnd_player11_name = "",
    bnd_player12_name = "",
    bnd_player13_name = "",
    bnd_player14_name = "",
    bnd_player15_name = "",
    bnd_player16_name = "",
    bnd_player17_name = "",
    bnd_player18_name = "",
    bnd_player1_number = "",
    bnd_player2_number = "",
    bnd_player3_number = "",
    bnd_player4_number = "",
    bnd_player5_number = "",
    bnd_player6_number = "",
    bnd_player7_number = "",
    bnd_player8_number = "",
    bnd_player9_number = "",
    bnd_player10_number = "",
    bnd_player11_number = "",
    bnd_player12_number = "",
    bnd_player13_number = "",
    bnd_player14_number = "",
    bnd_player15_number = "",
    bnd_player16_number = "",
    bnd_player17_number = "",
    bnd_player18_number = "",
    bnd_player1_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player2_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player3_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player4_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player5_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player6_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player7_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player8_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player9_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player10_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player11_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player1_bottom = 0,
    bnd_player2_bottom = 0,
    bnd_player3_bottom = 0,
    bnd_player4_bottom = 0,
    bnd_player5_bottom = 0,
    bnd_player6_bottom = 0,
    bnd_player7_bottom = 0,
    bnd_player8_bottom = 0,
    bnd_player9_bottom = 0,
    bnd_player10_bottom = 0,
    bnd_player11_bottom = 0,
    bnd_player1_left= 0,
    bnd_player2_left= 0,
    bnd_player3_left= 0,
    bnd_player4_left= 0,
    bnd_player5_left= 0,
    bnd_player6_left= 0,
    bnd_player7_left= 0,
    bnd_player8_left= 0,
    bnd_player9_left= 0,
    bnd_player10_left= 0,
    bnd_player11_left= 0
  }

  o.crest = {
    name = "$Crest",
    id = 0
  }
  o.crest2 = {
    name = "$",
    id = 0
  }
  o.crest3 = {
    name = "$LaLigaTeamCrest",
    id = 0
  }

  o.formationName = ""

  o.teamName = ""

  o.im.Subscribe("bnd_active", function()
    o:_publishActivity()
  end
  )
  o.im.Subscribe("bnd_visible", function()
    o:_publishActivity()
  end
  )
  o.im.Subscribe("bnd_team_crest", function()
    o:_publishTeamCrest()
  end
  )
  o.im.Subscribe("bnd_team_crest2", function()
    o:_publishTeamCrest2()
  end
  )
  o.im.Subscribe("bnd_team_crest3", function()
    o:_publishTeamCrest3()
  end
  )

  o.im.Subscribe("bnd_team_name", function()
    o:_publishTeamName()
  end
  )
  o.im.Subscribe("bnd_team_formation", function()
    o:_publishTeamFormation()
  end
  )
  for k,v in pairs(o.bndList) do
    o.im.Subscribe(k, function()
    end)
  end
  
  o.im.Subscribe("bnd_active", function()
    o:_publishActive()
  end)

  for k,v in pairs(currentdata) do
    o.im.Subscribe(k, function()
      o.im.Publish(k, v)
    end)
  end
  return o
end

function Starting11:handleEvent(eventType, data)
  if eventType == EventTypes.OverlayTypeIntroSequenceTeamList then
    self:updatePlayerLineup(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function Starting11:updatePlayerLineup(subtype, hideshow, subtypestr, msg)
  print("[Starting11]: updatePlayerLineup(subtype = " .. tostring(subtype) .. ", hideshow = " .. tostring(hideshow) .. ", subtypestr = " .. tostring(subtypestr) .. ", msg = " .. tostring(msg) .. ")")
  if hideshow ~= "HIDE" then
    self.isActive = true
    self.isVisible = true
    local params = OverlayParam.split(msg, "|")
    if params and table.getn(params) > 0 then
      local teamSide = tonumber(params[5])
      local teamID = tonumber(params[3])
      if teamSide == 0 then
        self.crest.id = self.TeamsData[1].assetId
      else
        self.crest.id = self.TeamsData[2].assetId
      end
      if teamSide == 0 then
        self.crest2.id = self.TeamsData[1].assetId
      else
        self.crest2.id = self.TeamsData[2].assetId
      end
      if teamSide == 0 then
        self.crest3.id = self.TeamsData[1].assetId
      else
        self.crest3.id = self.TeamsData[2].assetId
      end
      self.teamName = params[2]
      local lineup = self.services.SquadManagementService.GetCurrentPlayerLineup(teamSide, teamID, 0)
      local formationID = self.services.TacticsService.GetFormation(teamSide, teamID)
      if self.gamemode == "fut" then
        formationID = self.services.SquadManagementService.GetFUTRelativeSquadFormation(formationID)
      end
      local formation = self.models.FormationModel:getFormationInfoByID(formationID)
      local formationCoords = formation.coords
      local formationName = formation.name
      local formationPosition = formation.positions
      self.formationName = formationName
      self.playerLineup = {
        players = {},
        teamID = params[1],
        teamName = params[2],
        formationName = formationName,
        starting11Label = (""),
        subsLabel = ("")
      }
      do
        do
          for _FORV_16_ = 1, table.getn(lineup) do
            self.playerLineup.players[_FORV_16_] = {}
            self.playerLineup.players[_FORV_16_].assetId = lineup[_FORV_16_].CARD_ID
            self.playerLineup.players[_FORV_16_].name = lineup[_FORV_16_].playerName
            self.playerLineup.players[_FORV_16_].number = lineup[_FORV_16_].jerseyNumber
            self.playerLineup.players[_FORV_16_].hasYellowCard = false
            if _FORV_16_ <= 11 then
              self.playerLineup.players[_FORV_16_].coords = formationCoords[_FORV_16_]
              self.playerLineup.players[_FORV_16_].jerseyColor = "0x00FF00"
              if formationPosition[_FORV_16_] then
                self.playerLineup.players[_FORV_16_].position = {
                  xPos = 0,
                  yPos = 0
                }
                self.playerLineup.players[_FORV_16_].position.xPos = formationPosition[_FORV_16_].xPos
                self.playerLineup.players[_FORV_16_].position.yPos = formationPosition[_FORV_16_].yPos
              end
            end
          end
        end
      end
      self:_publishPlayerLineup()
      self:_publishTeamCrest()
      self:_publishTeamCrest2()
      self:_publishTeamCrest3()
      self:_publishTeamName()
      self:_publishTeamFormation()
      
    end
  else
    self.isActive = false
    self.isVisible = false
  end
  self:_publishActivity()
end

function Starting11:_publishActive()
  self.im.Publish("bnd_active", self.active)
end

function Starting11:_publishActivity()
  self.im.Publish("bnd_active", self.isActive)
  self.im.Publish("bnd_visible", self.isVisible)
end

function Starting11:_publishTeamCrest()
  self.im.Publish("bnd_team_crest", self.crest)
end

function Starting11:_publishTeamCrest2()
  self.im.Publish("bnd_team_crest2", self.crest2)
end

function Starting11:_publishTeamCrest3()
  self.im.Publish("bnd_team_crest3", self.crest3)
end

function Starting11:_publishTeamName()
  self.im.Publish("bnd_team_name", self.teamName)
end

function Starting11:_publishTeamFormation()
  self.im.Publish("bnd_team_formation", self.formationName)
end

function Starting11:_publishPlayerLineup()
  if self.playerLineup == nil then
    return
  end
  for index = 1, table.getn(self.playerLineup.players) do
    local bindingPlayer = "bnd_player"..index
    local playerAvatar = {
      name = "$Head",
      id = 0
    }
    playerAvatar.id = self.playerLineup.players[index].assetId
    local formatName = self.playerLineup.players[index].name.." "
    self.im.Publish(bindingPlayer.."_name", formatName)
    self.im.Publish(bindingPlayer.."_number", self.playerLineup.players[index].number)
    if index <= 11 then
      self.im.Publish(bindingPlayer.."_avatar", playerAvatar)
      self.im.Publish(bindingPlayer.."_left", self.playerLineup.players[index].position.xPos)
      self.im.Publish(bindingPlayer.."_bottom", self.playerLineup.players[index].position.yPos)
    end
  end
end

function Starting11:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function Starting11:finalize()
  print("[Starting11]: finalize()")
  self.models.FormationModel:finalize()
  self.im.Unsubscribe("bnd_live_logo")
  self.im.Unsubscribe("bnd_active")
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe("bnd_team_crest")
  self.im.Unsubscribe("bnd_team_crest2")
  self.im.Unsubscribe("bnd_team_crest3")
  self.im.Unsubscribe("bnd_team_name")
  self.im.Unsubscribe("bnd_team_formation")
  for k,v in pairs(self.bndList) do
    self.im.Unsubscribe(k)
  end
  self.services.eventManService.UnregisterHandler(self.handlerId)
end

return Starting11