
-- New Custom ScoreboardSubstitutions By MVNPROD --

local ScoreboardSubstitutions = {}
local OverlaysIdContainer, OverlayParam, eventmanager = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

local initialized = false
local bndVisible = "bnd_visible"
local bndNationalization = "bnd_nationalization"
local bndData = "bnd_data"
local bndAlpha = "bnd_alpha"

local leagueIDs = {
  PremierLeague = 13,
  ChampionshipEfl = 14,
  LeagueOneEfl = 60,
  WomenSuperLeague = 2216,
  Ligue1 = 16,
  Ligue2 = 17,
  D1Arkema = 2218,
  Bundesliga1 = 19,
  Bundesliga2 = 20,
  BRILiga1 = 2235,
  PegadaianLiga2 = 2254,
  International = 78,
  InternationalWomans = 2136,
  SerieA = 31,
  SerieB = 32,
  Korea = 83,
  Malaysia = 2237,
  LigaMX = 341,
  Morocco = 2250,
  Eredivisie = 10,
  LigaPortugal = 308,
  RestOfWolrd1 = 76,
  RestOfWolrd2 = 77,
  RoshnSaudiLeague = 350,
  Scotland = 50,
  SouthAfrica = 347,
  Laliga = 53,
  LaligaHypermotion = 54,
  LigaF = 2222,
  Thailand = 2252,
  Turkey = 68,
  Ucl = 2236,
  Uel = 2238,
  Uwcl = 2240,
  MLS = 39,
  Nwsl = 2221,
  Vietnam = 2260,
  AFC = 365,
  Argentina = 353,
  Belgium = 4,
  Brazil = 7,
  Classic = 1245,
  Classic2 = 1246,
  Egypt = 2231
}

EAFCInfo = { -- 350x100
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 0.0000001,
  bnd_bg1_height = 0.0000001,
  bnd_textsub_fontColor = "0xF5F5F5",
  bnd_fontFace = "$KnulBold",
  bnd_forceCaps = true,
  
  bnd_background_sub = { name = "$BgSub", id = 0 },
  bnd_background_sub_left = -80,
  bnd_background_sub_top = -80,
  bnd_background_sub_width = 235,
  bnd_background_sub_height = 235,
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  bnd_InOut_name_width = 70,
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 80,
  bnd_bghome_height = 80,
  bnd_bghome_left = -80,
  
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_alignH = "CENTER",
  bnd_home_crest_left = -177,
  bnd_home_crest_right = 0,
  bnd_home_crest_bottom = 0,
  bnd_home_crest_top = -175,
  bnd_home_crest_height = 25,
  bnd_home_crest_width = 25,

  bnd_Inplayer_name_left = -20,
  bnd_Inplayer_name_right = 0,
  bnd_Inplayer_name_top = -35,
  bnd_Inplayer_name_fontSize = 12,
  bnd_Inplayer_name_alignV = "CENTER",
  bnd_Inplayer_name_alignH = "CENTER",

  bnd_Outplayer_name_left = 50,
  bnd_Outplayer_name_right = 0,
  bnd_Outplayer_name_top = -35,
  bnd_Outplayer_name_fontSize = 12,
  bnd_Outplayer_name_alignV = "CENTER",
  bnd_Outplayer_name_alignH = "CENTER",
  
  bnd_Inplayer_avatar_left = 150,
  bnd_Inplayer_avatar_top = -90,
  bnd_Inplayer_avatar_width = 70,
  bnd_Inplayer_avatar_height = 70,
  
  bnd_Outplayer_avatar_left = 50,
  bnd_Outplayer_avatar_top = -90,
  bnd_Outplayer_avatar_width = 70,
  bnd_Outplayer_avatar_height = 70,
  
  bnd_Inplayer_number_left = 20,
  bnd_Inplayer_number_top = -30,
  bnd_Inplayer_number_fontSize = 0,
  
  bnd_Outplayer_number_left = -120,
  bnd_Outplayer_number_top = -30,
  bnd_Outplayer_number_fontSize = 0,
}

PREMIERLEAGUEInfo = { -- 350x100
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 0.0000001,
  bnd_bg1_height = 0.0000001,
  bnd_textsub_fontColor = "0xF5F5F5",
  bnd_fontFace = "$Epl",
  bnd_forceCaps = false,
  
  bnd_background_sub = { name = "$BgSub", id = 13 },
  bnd_background_sub_left = -50,
  bnd_background_sub_top = -30,
  bnd_background_sub_width = 320,
  bnd_background_sub_height = 110,
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  bnd_InOut_name_width = 120,
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 80,
  bnd_bghome_height = 80,
  bnd_bghome_left = -80,
  
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_alignH = "CENTER",
  bnd_home_crest_left = 0,
  bnd_home_crest_right = 0,
  bnd_home_crest_bottom = 0,
  bnd_home_crest_top = 0,
  bnd_home_crest_height = 60,
  bnd_home_crest_width = 60,

  bnd_Inplayer_name_left = 120,
  bnd_Inplayer_name_right = 0,
  bnd_Inplayer_name_top = -28,
  bnd_Inplayer_name_fontSize = 15,
  bnd_Inplayer_name_alignV = "TOP",
  bnd_Inplayer_name_alignH = "LEFT",

  bnd_Outplayer_name_left = 120,
  bnd_Outplayer_name_right = 0,
  bnd_Outplayer_name_top = -2,
  bnd_Outplayer_name_fontSize = 15,
  bnd_Outplayer_name_alignV = "TOP",
  bnd_Outplayer_name_alignH = "LEFT",
  
  bnd_Inplayer_avatar_left = 225,
  bnd_Inplayer_avatar_top = -20,
  bnd_Inplayer_avatar_width = 0.00001,
  bnd_Inplayer_avatar_height = 0.00001,
  
  bnd_Outplayer_avatar_left = 5,
  bnd_Outplayer_avatar_top = -20,
  bnd_Outplayer_avatar_width = 0.00001,
  bnd_Outplayer_avatar_height = 0.00001,
  
  bnd_Inplayer_number_left = 20,
  bnd_Inplayer_number_top = -30,
  bnd_Inplayer_number_fontSize = 0.0000001,
  
  bnd_Outplayer_number_left = -120,
  bnd_Outplayer_number_top = -30,
  bnd_Outplayer_number_fontSize = 0.000001,
}

LALIGAInfo= { -- 350x100
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 0.0000001,
  bnd_bg1_height = 0.0000001,
  bnd_textsub_fontColor = "0xF5F5F5",
  bnd_fontFace = "$LaLiga",
  bnd_forceCaps = true,
  
  bnd_background_sub = { name = "$BgSub", id = 53 },
  bnd_background_sub_left = -50,
  bnd_background_sub_top = -30,
  bnd_background_sub_width = 320,
  bnd_background_sub_height = 110,
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  bnd_InOut_name_width = 110,
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 80,
  bnd_bghome_height = 80,
  bnd_bghome_left = -80,
  
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_alignH = "CENTER",
  bnd_home_crest_left = 95,
  bnd_home_crest_right = 0,
  bnd_home_crest_bottom = 0,
  bnd_home_crest_top = 0,
  bnd_home_crest_height = 0.00001,
  bnd_home_crest_width = 0.0001,

  bnd_Inplayer_name_left = 0,
  bnd_Inplayer_name_right = 200,
  bnd_Inplayer_name_top = 30,
  bnd_Inplayer_name_fontSize = 15,
  bnd_Inplayer_name_alignV = "TOP",
  bnd_Inplayer_name_alignH = "RIGHT",

  bnd_Outplayer_name_left = 95,
  bnd_Outplayer_name_right = 0,
  bnd_Outplayer_name_top = -15,
  bnd_Outplayer_name_fontSize = 15,
  bnd_Outplayer_name_alignV = "TOP",
  bnd_Outplayer_name_alignH = "LEFT",
  
  bnd_Inplayer_avatar_left = 225,
  bnd_Inplayer_avatar_top = -20,
  bnd_Inplayer_avatar_width = 80,
  bnd_Inplayer_avatar_height = 80,
  
  bnd_Outplayer_avatar_left = 5,
  bnd_Outplayer_avatar_top = -20,
  bnd_Outplayer_avatar_width = 80,
  bnd_Outplayer_avatar_height = 80,
  
  bnd_Inplayer_number_left = 20,
  bnd_Inplayer_number_top = -30,
  bnd_Inplayer_number_fontSize = 0.0000001,
  
  bnd_Outplayer_number_left = -120,
  bnd_Outplayer_number_top = -30,
  bnd_Outplayer_number_fontSize = 0.000001,
}

BUNDESLIGA1Info= { -- 350x100
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 0.0000001,
  bnd_bg1_height = 0.0000001,
  bnd_textsub_fontColor = "0xF5F5F5",
  bnd_fontFace = "$Bundesliga",
  bnd_forceCaps = true,
  
  bnd_background_sub = { name = "$BgSub", id = 19 },
  bnd_background_sub_left = -50,
  bnd_background_sub_top = -50,
  bnd_background_sub_width = 320,
  bnd_background_sub_height = 200,
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  bnd_InOut_name_width = 100,
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 80,
  bnd_bghome_height = 80,
  bnd_bghome_left = -80,
  
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_alignH = "CENTER",
  bnd_home_crest_left = 20,
  bnd_home_crest_right = 0,
  bnd_home_crest_bottom = 0,
  bnd_home_crest_top = -80,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,

  bnd_Inplayer_name_left = 120,
  bnd_Inplayer_name_right = 0,
  bnd_Inplayer_name_top = -65,
  bnd_Inplayer_name_fontSize = 15,
  bnd_Inplayer_name_alignV = "TOP",
  bnd_Inplayer_name_alignH = "LEFT",

  bnd_Outplayer_name_left = 120,
  bnd_Outplayer_name_right = 0,
  bnd_Outplayer_name_top = -40,
  bnd_Outplayer_name_fontSize = 15,
  bnd_Outplayer_name_alignV = "TOP",
  bnd_Outplayer_name_alignH = "LEFT",
  
  bnd_Inplayer_avatar_left = 233,
  bnd_Inplayer_avatar_top = -43,
  bnd_Inplayer_avatar_width = 0.00001,
  bnd_Inplayer_avatar_height = 0.00001,
  
  bnd_Outplayer_avatar_left = 233,
  bnd_Outplayer_avatar_top = 10,
  bnd_Outplayer_avatar_width = 0.000001,
  bnd_Outplayer_avatar_height = 0.000001,
  
  bnd_Inplayer_number_left = -110,
  bnd_Inplayer_number_top = -20,
  bnd_Inplayer_number_fontSize = 0.000001,
  
  bnd_Outplayer_number_left = -110,
  bnd_Outplayer_number_top = 25,
  bnd_Outplayer_number_fontSize = 0.00001,
}

LIGUE1Info = { -- 350x100
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 0.0000001,
  bnd_bg1_height = 0.0000001,
  bnd_textsub_fontColor = "0xF5F5F5",
  bnd_fontFace = "$Ligue1",
  bnd_forceCaps = true,
  
  bnd_background_sub = { name = "$BgSub", id = 16 },
  bnd_background_sub_left = -50,
  bnd_background_sub_top = -30,
  bnd_background_sub_width = 320,
  bnd_background_sub_height = 110,
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  bnd_InOut_name_width = 100,
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 80,
  bnd_bghome_height = 80,
  bnd_bghome_left = -80,
  
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_alignH = "CENTER",
  bnd_home_crest_left = 20,
  bnd_home_crest_right = 0,
  bnd_home_crest_bottom = 0,
  bnd_home_crest_top = -30,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,

  bnd_Inplayer_name_left = 120,
  bnd_Inplayer_name_right = 0,
  bnd_Inplayer_name_top = -15,
  bnd_Inplayer_name_fontSize = 15,
  bnd_Inplayer_name_alignV = "TOP",
  bnd_Inplayer_name_alignH = "LEFT",

  bnd_Outplayer_name_left = 120,
  bnd_Outplayer_name_right = 0,
  bnd_Outplayer_name_top = 30,
  bnd_Outplayer_name_fontSize = 15,
  bnd_Outplayer_name_alignV = "TOP",
  bnd_Outplayer_name_alignH = "LEFT",
  
  bnd_Inplayer_avatar_left = 233,
  bnd_Inplayer_avatar_top = -43,
  bnd_Inplayer_avatar_width = 50,
  bnd_Inplayer_avatar_height = 50,
  
  bnd_Outplayer_avatar_left = 233,
  bnd_Outplayer_avatar_top = 10,
  bnd_Outplayer_avatar_width = 50,
  bnd_Outplayer_avatar_height = 50,
  
  bnd_Inplayer_number_left = -110,
  bnd_Inplayer_number_top = -20,
  bnd_Inplayer_number_fontSize = 25,
  
  bnd_Outplayer_number_left = -110,
  bnd_Outplayer_number_top = 25,
  bnd_Outplayer_number_fontSize = 25,
}

SERIEAInfo= { -- 350x100
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 0.0000001,
  bnd_bg1_height = 0.0000001,
  bnd_textsub_fontColor = "0xF5F5F5",
  bnd_fontFace = "$SerieA",
  bnd_forceCaps = true,
  
  bnd_background_sub = { name = "$BgSub", id = 31 },
  bnd_background_sub_left = -50,
  bnd_background_sub_top = -40,
  bnd_background_sub_width = 220,
  bnd_background_sub_height = 170,
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x3CA7C6",
  bnd_InOut_name_width = 80,
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 80,
  bnd_bghome_height = 80,
  bnd_bghome_left = -80,
  
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_alignH = "CENTER",
  bnd_home_crest_left = 95,
  bnd_home_crest_right = 0,
  bnd_home_crest_bottom = 0,
  bnd_home_crest_top = 0,
  bnd_home_crest_height = 0.00001,
  bnd_home_crest_width = 0.0001,

  bnd_Inplayer_name_left = -105,
  bnd_Inplayer_name_right = 0,
  bnd_Inplayer_name_top = 10,
  bnd_Inplayer_name_fontSize = 15,
  bnd_Inplayer_name_alignV = "TOP",
  bnd_Inplayer_name_alignH = "CENTER",

  bnd_Outplayer_name_left = 170,
  bnd_Outplayer_name_right = 0,
  bnd_Outplayer_name_top = 10,
  bnd_Outplayer_name_fontSize = 15,
  bnd_Outplayer_name_alignV = "TOP",
  bnd_Outplayer_name_alignH = "CENTER",
  
  bnd_Inplayer_avatar_left = 50,
  bnd_Inplayer_avatar_top = -110,
  bnd_Inplayer_avatar_width = 80,
  bnd_Inplayer_avatar_height = 80,
  
  bnd_Outplayer_avatar_left = 170,
  bnd_Outplayer_avatar_top = -110,
  bnd_Outplayer_avatar_width = 80,
  bnd_Outplayer_avatar_height = 80,
  
  bnd_Inplayer_number_left = -110,
  bnd_Inplayer_number_top = -20,
  bnd_Inplayer_number_fontSize = 25,
  
  bnd_Outplayer_number_left = 5,
  bnd_Outplayer_number_top = -20,
  bnd_Outplayer_number_fontSize = 25,
}

UCLInfo= { -- 350x100
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 0.0000001,
  bnd_bg1_height = 0.0000001,
  bnd_textsub_fontColor = "0xF5F5F5",
  bnd_fontFace = "$UCL-Regular",
  bnd_forceCaps = true,
  
  bnd_background_sub = { name = "$BgSub", id = 2236 },
  bnd_background_sub_left = 420,
  bnd_background_sub_top = 10,
  bnd_background_sub_width = 430,
  bnd_background_sub_height = 85,
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  bnd_InOut_name_width = 150,
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 80,
  bnd_bghome_height = 80,
  bnd_bghome_left = -80,
  
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_alignH = "CENTER",
  bnd_home_crest_left = 390,
  bnd_home_crest_right = 0,
  bnd_home_crest_bottom = 0,
  bnd_home_crest_top = -5,
  bnd_home_crest_height = 65,
  bnd_home_crest_width = 65,

  bnd_Inplayer_name_left = 540,
  bnd_Inplayer_name_right = 0,
  bnd_Inplayer_name_top = 20,
  bnd_Inplayer_name_fontSize = 18,
  bnd_Inplayer_name_alignV = "TOP",
  bnd_Inplayer_name_alignH = "LEFT",

  bnd_Outplayer_name_left = 540,
  bnd_Outplayer_name_right = 0,
  bnd_Outplayer_name_top = 60,
  bnd_Outplayer_name_fontSize = 18,
  bnd_Outplayer_name_alignV = "TOP",
  bnd_Outplayer_name_alignH = "LEFT",
  
  bnd_Inplayer_avatar_left = 233,
  bnd_Inplayer_avatar_top = -43,
  bnd_Inplayer_avatar_width = 0.0001,
  bnd_Inplayer_avatar_height = 0.0001,
  
  bnd_Outplayer_avatar_left = 233,
  bnd_Outplayer_avatar_top = 10,
  bnd_Outplayer_avatar_width = 0.0001,
  bnd_Outplayer_avatar_height = 0.0001,
  
  bnd_Inplayer_number_left = 320,
  bnd_Inplayer_number_top = 20,
  bnd_Inplayer_number_fontSize = 18,
  
  bnd_Outplayer_number_left = 320,
  bnd_Outplayer_number_top = 60,
  bnd_Outplayer_number_fontSize = 18,
}

WC26Info = { -- 350x100
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 0.0000001,
  bnd_bg1_height = 0.0000001,
  bnd_textsub_fontColor = "0xF5F5F5",
  bnd_fontFace = "$WC26",
  bnd_forceCaps = false,
  
  bnd_background_sub = { name = "$BgSub", id = "CupID2" },
  bnd_background_sub_left = -81,
  bnd_background_sub_top = 40,
  bnd_background_sub_width = 320,
  bnd_background_sub_height = 110,
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  bnd_InOut_name_width = 120,
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 80,
  bnd_bghome_height = 80,
  bnd_bghome_left = -80,
  
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_alignH = "CENTER",
  bnd_home_crest_left = 0,
  bnd_home_crest_right = 0,
  bnd_home_crest_bottom = 0,
  bnd_home_crest_top = 30,
  bnd_home_crest_height = 40,
  bnd_home_crest_width = 40,

  bnd_Inplayer_name_left = 70,
  bnd_Inplayer_name_right = 0,
  bnd_Inplayer_name_top = 65,
  bnd_Inplayer_name_fontSize = 25,
  bnd_Inplayer_name_alignV = "TOP",
  bnd_Inplayer_name_alignH = "LEFT",

  bnd_Outplayer_name_left = 70,
  bnd_Outplayer_name_right = 0,
  bnd_Outplayer_name_top = 37,
  bnd_Outplayer_name_fontSize = 25,
  bnd_Outplayer_name_alignV = "TOP",
  bnd_Outplayer_name_alignH = "LEFT",
  
  bnd_Inplayer_avatar_left = 225,
  bnd_Inplayer_avatar_top = -20,
  bnd_Inplayer_avatar_width = 0.00001,
  bnd_Inplayer_avatar_height = 0.00001,
  
  bnd_Outplayer_avatar_left = 5,
  bnd_Outplayer_avatar_top = -20,
  bnd_Outplayer_avatar_width = 0.00001,
  bnd_Outplayer_avatar_height = 0.00001,
  
  bnd_Inplayer_number_left = 20,
  bnd_Inplayer_number_top = -30,
  bnd_Inplayer_number_fontSize = 0.0000001,
  
  bnd_Outplayer_number_left = -120,
  bnd_Outplayer_number_top = -30,
  bnd_Outplayer_number_fontSize = 0.000001,
}

function ScoreboardSubstitutions:new(init)
  print("[ScoreboardSubstitutions]: new()")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.nationalization = 2
  o.services = {
    eventManService = o.api("EventManagerService"),
    SquadManagementService = o.api("SquadMgtService"),
    GameSetupService = o.api("GameSetupService"),
    MatchInfoService = o.api("MatchInfoService"),
    OverlayService = o.api("OverlayService"),
    TeamService = o.api("TeamService")
  }
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.handlerId = o.services.eventManService.RegisterHandler(function(...)
  o:handleEvent(...) end)
  
  local HOMETEAM = 0
  local AWAYTEAM = 1
  o.currentdata = nil
  
  homeTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(HOMETEAM, o.TeamsData[1].assetId, 0)
  awayTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(AWAYTEAM, o.TeamsData[2].assetId, 0)
  
  local PremierLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.PremierLeague, 0, 0, true)
  local ChampionshipEflTeams = o.services.TeamService.GetTeams(leagueIDs.ChampionshipEfl, 0, 0, true)
  local LeagueOneEflTeams = o.services.TeamService.GetTeams(leagueIDs.LeagueOneEfl, 0, 0, true)
  local WomenSuperLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.WomenSuperLeague, 0, 0, true)
  local Ligue1Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue1, 0, 0, true)
  local Ligue2Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue2, 0, 0, true)
  local D1ArkemaTeams = o.services.TeamService.GetTeams(leagueIDs.D1Arkema, 0, 0, true)
  local Bundesliga1Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga1, 0, 0, true)
  local Bundesliga2Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga2, 0, 0, true)
  local BRILiga1Teams = o.services.TeamService.GetTeams(leagueIDs.BRILiga1, 0, 0, true)
  local PegadaianLiga2Teams = o.services.TeamService.GetTeams(leagueIDs.PegadaianLiga2, 0, 0, true)
  local InternationalTeams = o.services.TeamService.GetTeams(leagueIDs.International, 0, 0, true)
  local InternationalWomansTeams = o.services.TeamService.GetTeams(leagueIDs.InternationalWomans, 0, 0, true)
  local SerieATeams = o.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local SerieBTeams = o.services.TeamService.GetTeams(leagueIDs.SerieB, 0, 0, true)
  local KoreaTeams = o.services.TeamService.GetTeams(leagueIDs.Korea, 0, 0, true)
  local MalaysiaTeams = o.services.TeamService.GetTeams(leagueIDs.Malaysia, 0, 0, true)
  local LigaMXTeams = o.services.TeamService.GetTeams(leagueIDs.LigaMX, 0, 0, true)
  local MoroccoTeams = o.services.TeamService.GetTeams(leagueIDs.Morocco, 0, 0, true)
  local EredivisieTeams = o.services.TeamService.GetTeams(leagueIDs.Eredivisie, 0, 0, true)
  local LigaPortugalTeams = o.services.TeamService.GetTeams(leagueIDs.LigaPortugal, 0, 0, true)
  local RestOfWolrd1Teams = o.services.TeamService.GetTeams(leagueIDs.RestOfWolrd1, 0, 0, true)
  local RestOfWolrd2Teams = o.services.TeamService.GetTeams(leagueIDs.RestOfWolrd2, 0, 0, true)
  local RoshnSaudiLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.RoshnSaudiLeague, 0, 0, true)
  local ScotlandTeams = o.services.TeamService.GetTeams(leagueIDs.Scotland, 0, 0, true)
  local SouthAfricaTeams = o.services.TeamService.GetTeams(leagueIDs.SouthAfrica, 0, 0, true)
  local LaligaTeams = o.services.TeamService.GetTeams(leagueIDs.Laliga, 0, 0, true)
  local LaligaHypermotionTeams = o.services.TeamService.GetTeams(leagueIDs.LaligaHypermotion, 0, 0, true)
  local LigaFTeams = o.services.TeamService.GetTeams(leagueIDs.LigaF, 0, 0, true)
  local ThailandTeams = o.services.TeamService.GetTeams(leagueIDs.Thailand, 0, 0, true)
  local TurkeyTeams = o.services.TeamService.GetTeams(leagueIDs.Turkey, 0, 0, true)
  local UclTeams = o.services.TeamService.GetTeams(leagueIDs.Ucl, 0, 0, true)
  local UelTeams = o.services.TeamService.GetTeams(leagueIDs.Uel, 0, 0, true)
  local UwclTeams = o.services.TeamService.GetTeams(leagueIDs.Uwcl, 0, 0, true)
  local MLSTeams = o.services.TeamService.GetTeams(leagueIDs.MLS, 0, 0, true)
  local NwslTeams = o.services.TeamService.GetTeams(leagueIDs.Nwsl, 0, 0, true)
  local VietnamTeams = o.services.TeamService.GetTeams(leagueIDs.Vietnam, 0, 0, true)
  local AFCTeams = o.services.TeamService.GetTeams(leagueIDs.AFC, 0, 0, true)
  local ArgentinaTeams = o.services.TeamService.GetTeams(leagueIDs.Argentina, 0, 0, true)
  local BelgiumTeams = o.services.TeamService.GetTeams(leagueIDs.Belgium, 0, 0, true)
  local BrazilTeams = o.services.TeamService.GetTeams(leagueIDs.Brazil, 0, 0, true)
  local ClassicTeams = o.services.TeamService.GetTeams(leagueIDs.Classic, 0, 0, true)
  local Classic2Teams = o.services.TeamService.GetTeams(leagueIDs.Classic2, 0, 0, true)
  local EgyptTeams = o.services.TeamService.GetTeams(leagueIDs.Egypt, 0, 0, true)
  
  -- Integrasi currentTourData dan currentCupData
  if currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      o.currentdata = UCLInfo
    elseif currentTourData.tourIndex == 35 then
      o.currentdata = UCLInfo
    elseif currentTourData.tourIndex == 2 then
      o.currentdata = WC26Info
    else
      o.currentdata = EAFCInfo
    end
    
  elseif currentCupData and currentCupData.cupIndex and currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      o.currentdata = UCLInfo
    elseif currentCupData.cupIndex == 2 then
      o.currentdata = EAFCInfo
    end
    
  else
    -- Logika Liga Berdasarkan Tim
    if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
      o.currentdata = PREMIERLEAGUEInfo
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], WomenSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomenSuperLeagueTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      o.currentdata = LIGUE1Info
    elseif o:isInTable(o.TeamsData[1], Ligue2Teams) and o:isInTable(o.TeamsData[2], Ligue2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
      o.currentdata = BUNDESLIGA1Info
    elseif o:isInTable(o.TeamsData[1], Bundesliga2Teams) and o:isInTable(o.TeamsData[2], Bundesliga2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], InternationalWomansTeams) and o:isInTable(o.TeamsData[2], InternationalWomansTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
      o.currentdata = SERIEAInfo
    elseif o:isInTable(o.TeamsData[1], SerieBTeams) and o:isInTable(o.TeamsData[2], SerieBTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], KoreaTeams) and o:isInTable(o.TeamsData[2], KoreaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LigaMXTeams) and o:isInTable(o.TeamsData[2], LigaMXTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], EredivisieTeams) and o:isInTable(o.TeamsData[2], EredivisieTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LigaPortugalTeams) and o:isInTable(o.TeamsData[2], LigaPortugalTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], RestOfWolrd1Teams) and o:isInTable(o.TeamsData[2], RestOfWolrd1Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], RestOfWolrd2Teams) and o:isInTable(o.TeamsData[2], RestOfWolrd2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], RoshnSaudiLeagueTeams) and o:isInTable(o.TeamsData[2], RoshnSaudiLeagueTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
      o.currentdata = LALIGAInfo
    elseif o:isInTable(o.TeamsData[1], LaligaHypermotionTeams) and o:isInTable(o.TeamsData[2], LaligaHypermotionTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], UclTeams) and o:isInTable(o.TeamsData[2], UclTeams) then
      o.currentdata = UCLInfo
    elseif o:isInTable(o.TeamsData[1], UelTeams) and o:isInTable(o.TeamsData[2], UelTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], UwclTeams) and o:isInTable(o.TeamsData[2], UwclTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], MLSTeams) and o:isInTable(o.TeamsData[2], MLSTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], NwslTeams) and o:isInTable(o.TeamsData[2], NwslTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], AFCTeams) and o:isInTable(o.TeamsData[2], AFCTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
      o.currentdata = EAFCInfo
    else
      o.currentdata = EAFCInfo
    end
  end

  HomeTeamData = {
    teamAssetId = o.TeamsData[1].assetId,
    shortName = o.services.GameSetupService.GetTeamShortName(HOMETEAM),
    crest = {
      name = "$Crest",
      id = o.TeamsData[1].assetId
    }
  }

  AwayTeamData = {
    teamAssetId = o.TeamsData[2].assetId,
    shortName = o.services.GameSetupService.GetTeamShortName(AWAYTEAM),
    crest = {
      name = "$Crest",
      id = o.TeamsData[2].assetId
    }
  }
  
  -- DAFTAR BINDING DINAMIS UNTUK POSISI, UKURAN & FONT (LENGKAP)
  local playerBindings = {
    "bnd_fontFace", -- PENAMBAHAN FONT FACE DI SINI
    -- Player IN
    "bnd_Inplayer_name_left", "bnd_Inplayer_name_top", "bnd_Inplayer_name_fontSize",
    "bnd_Inplayer_number_left", "bnd_Inplayer_name_right", "bnd_Inplayer_number_top", "bnd_Inplayer_number_fontSize",
    "bnd_Inplayer_avatar_width", "bnd_Inplayer_avatar_height", "bnd_Inplayer_avatar_left", "bnd_Inplayer_avatar_top",
    "bnd_Inplayer_name_alignV", "bnd_Inplayer_name_alignH",
    
    -- Player OUT
    "bnd_Outplayer_name_left", "bnd_Outplayer_name_right", "bnd_Outplayer_name_top", "bnd_Outplayer_name_fontSize",
    "bnd_Outplayer_number_left", "bnd_Outplayer_number_top", "bnd_Outplayer_number_fontSize",
    "bnd_Outplayer_avatar_width", "bnd_Outplayer_avatar_height", "bnd_Outplayer_avatar_left", "bnd_Outplayer_avatar_top",
    "bnd_Outplayer_name_alignV", "bnd_Outplayer_name_alignH",
  }

  -- TAMBAHAN: BINDING UNTUK ASSET BACKGROUND (POSISI & UKURAN)
  local bgSubBindings = {
    "bnd_background_sub",
    "bnd_background_sub_left",
    "bnd_background_sub_top",
    "bnd_background_sub_width",
    "bnd_background_sub_height"
  }

  -- Subscribe semua binding visual agar dikenali engine
  for _, name in ipairs(playerBindings) do
    o.im.Subscribe(name, function() end)
  end

  -- Subscribe binding background
  for _, name in ipairs(bgSubBindings) do
    o.im.Subscribe(name, function() end)
  end

  o.im.Subscribe(bndNationalization, function() end)
  o.im.Subscribe(bndVisible, function()
    o.im.Publish(bndVisible, false)
  end)
  o.im.Subscribe(bndAlpha, function() end)
  o.im.Subscribe(bndData, function() end)
  
  -- Subscribe Data Pemain Dasar
  o.im.Subscribe("bnd_Inplayer_avatar", function() end)
  o.im.Subscribe("bnd_Inplayer_name", function() end)
  o.im.Subscribe("bnd_Inplayer_number", function() end)
  o.im.Subscribe("bnd_Outplayer_avatar", function() end)
  o.im.Subscribe("bnd_Outplayer_name", function() end)
  o.im.Subscribe("bnd_Outplayer_number", function() end)

  -- SINKRONISASI BINDING SHOW
  o.im.Subscribe("bnd_home_crest_show", function()
    o.im.Publish("bnd_home_crest_show", false)
  end)
  o.im.Subscribe("bnd_away_crest_show", function()
    o.im.Publish("bnd_away_crest_show", false)
  end)

  -- SINKRONISASI LOGO (Crest)
  o.im.Subscribe("bnd_home_crest", function()
    o.im.Publish("bnd_home_crest", HomeTeamData.crest)
  end)
  o.im.Subscribe("bnd_away_crest", function() end)
  
  -- Auto-Subscribe semua isi tabel currentdata
  -- Ini akan otomatis mengambil bnd_fontFace jika Anda sudah menaruhnya di tabel Info liga
  for k,v in pairs(o.currentdata) do
    o.im.Subscribe(k, function()
      o.im.Publish(k, v)
    end)
  end
  
  return o
end

function ScoreboardSubstitutions:handleEvent(eventType, data)
  if eventType == EventTypes.OverlayTypeIngameSubstitution then
    self:updateScoreboardSubstitutions(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function ScoreboardSubstitutions:updateScoreboardSubstitutions(subtype, hideshow, subtypestr, msg)
  local params = OverlayParam.split(msg, "|")
  InplayerAvatar = {
    name = "$Head",
    id = 0
  }
  OutplayerAvatar = {
    name = "$Head",
    id = 0
  }

  if hideshow == "SHOW" or hideshow == "UPDATE" then
    -- Loop ini otomatis mem-publish bnd_fontFace dari currentdata ke engine
    for k, v in pairs(self.currentdata) do
       self.im.Publish(k, v)
    end

    if hideshow == "SHOW" and initialized == false then
      self.im.Publish(bndNationalization, self.nationalization)
      initialized = true
    end

    if hideshow == "UPDATE" then
      self.im.Publish(bndAlpha, params[1] / 100)
    end

    if params and table.getn(params) > 0 then
      self.im.Publish(bndVisible, true)
      local subTeamId = params[2] + 0
      local substitutions = {
        teamName = params[3],
        inPlayer = params[4],
        outPlayer = params[5]
      }
      
      local teamside = 0
      if subTeamId == self.TeamsData[1].assetId then
        teamside = 0
      else
        teamside = 1
      end
      
      local InplayerInfo = self:getPlayerInfo(teamside, subTeamId, substitutions.inPlayer)
      local OutplayerInfo = self:getPlayerInfo(teamside, subTeamId, substitutions.outPlayer)
      
      InplayerAvatar.id = InplayerInfo.assetId
      OutplayerAvatar.id = OutplayerInfo.assetId
      
      -- Publish Data Teks & Gambar
      self.im.Publish("bnd_Inplayer_avatar", InplayerAvatar)
      self.im.Publish("bnd_Outplayer_avatar", OutplayerAvatar)
      self.im.Publish("bnd_Inplayer_name", InplayerInfo.playerName)
      self.im.Publish("bnd_Outplayer_name", OutplayerInfo.playerName)
      self.im.Publish("bnd_Inplayer_number", InplayerInfo.jerseyNumber.."")
      self.im.Publish("bnd_Outplayer_number", OutplayerInfo.jerseyNumber.."")
      
      -- LOGIKA PENYATUAN LOGO
      self.im.Publish("bnd_home_crest_show", true)
      self.im.Publish("bnd_away_crest_show", false)
      
      if teamside == 0 then
        self.im.Publish("bnd_home_crest", HomeTeamData.crest)
      else
        self.im.Publish("bnd_home_crest", AwayTeamData.crest)
      end
      
      self.im.Publish(bndData, substitutions)
    end
  else
    -- HIDE
    self.im.Publish(bndVisible, false)
    self.im.Publish("bnd_home_crest_show", false)
    self.im.Publish("bnd_away_crest_show", false)
  end
end

function ScoreboardSubstitutions:getPlayerInfo(teamSide, teamID, playername)
  local playerInfo = {
    assetId = 0,
    jerseyNumber = 0,
    playerName = playername
  }
  local teamlineupData
  if teamSide == 0 then
    teamlineupData = homeTeamlineupData
  else 
    teamlineupData = awayTeamlineupData
  end
  
  if string.find(playername, "-") then
    playerInfo.playerName = string.gsub(playername, "%-", " ")
  end
  
  for _FORV_6_ = 1, table.getn(teamlineupData) do
    if string.find(playername, teamlineupData[_FORV_6_].playerName, 1, true) then
      playerInfo.assetId = teamlineupData[_FORV_6_].CARD_ID
      playerInfo.jerseyNumber = teamlineupData[_FORV_6_].jerseyNumber
      playerInfo.playerName = teamlineupData[_FORV_6_].playerName
    end
  end
  return playerInfo
end

function ScoreboardSubstitutions:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function ScoreboardSubstitutions:finalize()
  print("ScoreboardSubstitutions:finalize")
  self.services.eventManService.UnregisterHandler(self.handlerId)
  self.im.Unsubscribe(bndVisible)
  self.im.Unsubscribe(bndAlpha)
  self.im.Unsubscribe(bndData)
  self.im.Unsubscribe(bndNationalization)
  self.im.Unsubscribe("bnd_Inplayer_avatar")
  self.im.Unsubscribe("bnd_Inplayer_name")
  self.im.Unsubscribe("bnd_Inplayer_number")
  self.im.Unsubscribe("bnd_Outplayer_avatar")
  self.im.Unsubscribe("bnd_Outplayer_name")
  self.im.Unsubscribe("bnd_Outplayer_number")
  self.im.Unsubscribe("bnd_home_crest_show")
  self.im.Unsubscribe("bnd_away_crest_show")
  self.im.Unsubscribe("bnd_home_crest")
  self.im.Unsubscribe("bnd_away_crest")
  self.im.Unsubscribe("bnd_background_sub")
  self.im.Unsubscribe("bnd_background_sub_left")
  self.im.Unsubscribe("bnd_background_sub_top")
  self.im.Unsubscribe("bnd_background_sub_width")
  self.im.Unsubscribe("bnd_background_sub_height")
  self.im.Unsubscribe("bnd_fontFace") -- UNUBSCRIBE FONT FACE
  for k,v in pairs(EAFCInfo) do
    self.im.Unsubscribe(k)
  end
  self.services.eventManService.UnregisterHandler(self.handlerId)
end
return ScoreboardSubstitutions

-- Thanks : Ma'ruf Id & Laosiji --
-- And All Modder --
-- ScoreboardSubstitutions All League ( @mvnprodreal ) --