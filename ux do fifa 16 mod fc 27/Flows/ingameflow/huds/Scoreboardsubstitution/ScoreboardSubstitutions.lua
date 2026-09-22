-- Thanks : Ma'ruf Id & Laosiji --
-- mvnprod.official --
-- talamlegit.official - Patch Mod EAFC24 --

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
   Algeria = 2262,
   Afc = 365,
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
   UnitedStates = 39,
   USANWSL = 2221,
   Vietnam = 2260,
   WomensSuperLeague = 2216
}

AlgeriaInfo = { 
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1AFE68",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2262
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
AfcInfo = { -- 300x120
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x94DF2A",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x2D065F",
  
  bnd_bg2_color = "0x2D065F",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xCEC0D7",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xCEC0D7",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 78
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
AsianCupU23Info = { -- 300x120
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0xFCDD10",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x273F85",
  
  bnd_bghome_color = "0x273F85",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x273F85",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2264
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
ClassicInfo = { -- 300x120
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x22C1A3",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x22C1A3",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 1245
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
ChampionshipEflInfo = { 
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1AFE68",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 14
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
DenmarkInfo = { 
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1AFE68",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 1
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
D1ArkemaInfo = { -- 300x120
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg1homeaway_show = false,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x6571B1",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0xFFFFFF",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0x061A3E",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x061A3E",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2218
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
EAFCInfo = { -- 300x120
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1AFE68",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea_dark"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
EcuadorInfo = { 
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1AFE68",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2018
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
EnglandInfo = { -- 300x120
  bnd_fontFace = "$Epl",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x39003E",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x39003E",
  
  bnd_bghome_color = "0x39003E",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x39003E",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
FranceInfo = { -- 300x120
  bnd_fontFace = "$Ligue1",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x304FFF",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0xffffff",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0x1F1F1F",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1F1F1F",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 16
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
France2Info = { -- 300x120
  bnd_fontFace = "$Ligue1",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x02FFCE",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0xffffff",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0x1F1F1F",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1F1F1F",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 17
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
GermanyInfo = { -- 300x120
  bnd_fontFace = "$Bundesliga",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0xD10214",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0x333333",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x333333",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 19
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
IndonesiaInfo = { -- 300x120
  bnd_fontFace = "$Liga1",
  bnd_bg1homeaway_show = false,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x00519D",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0x00519D",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0x505050",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x505050",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
ItalyInfo = { -- 300x120
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x0F2D61",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0xFFFFFF",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0x0F2D61",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x0F2D61",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
JapanInfo = { -- 300x120
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x0000000",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0xFFFFFF",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0x000000",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x000000",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
LeagueOneEflInfo = { 
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1AFE68",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 60
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
LeagueTwoEflInfo = { 
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1AFE68",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 61
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
SaudiArabiaInfo = { -- 300x120
  bnd_fontFace = "$SPL",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x4B4B4B",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0xFFFFFF",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0xFFFFFF",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xFFFFFF",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 350
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
SpainInfo = { -- 300x120
  bnd_fontFace = "$LaLiga",
  bnd_bg1homeaway_show = true,
  bnd_home_crest_show = true,
  bnd_away_crest_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0xFF5C41",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0xFFFFFF",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x151515",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x151515",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 53
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
Spain2Info = { -- 300x120
  bnd_fontFace = "$LaLiga",
  bnd_bg1homeaway_show = true,
  bnd_home_crest_show = true,
  bnd_away_crest_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x04D4D4",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0xFFFFFF",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x151515",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x151515",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 54
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
LigaFInfo = { -- 300x120
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x1E1E1E",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0x09BFBA",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x2C6ADB",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x2C6ADB",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2222
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
MalaysiaInfo = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$Malaysia",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x0004DF",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x16FEC2",
  
  bnd_bg2_color = "0x001763",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x16FEC2",
  
  bnd_bghome_color = "0xffffff",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xffffff",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2237
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
NetherlandsInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x000000",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0x5C5C5C",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xffffff",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xffffff",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 10
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
PegadaianLiga2Info = { -- 300x120
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg1homeaway_show = false,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x07472B",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0x07472B",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xAED328",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xAED328",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
SwitzerlandInfo = {
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x151515",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x151515",
  
  bnd_bghome_color = "0x1AFE68",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1AFE68",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 189
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
ThailandInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x000000",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0xCECECE",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0xFE0000",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xFE0000",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2252
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
UefaInfo = { -- 300x120
  bnd_forceCaps = true,   
  bnd_fontFace = "$UCL-Regular", 
  bnd_bg1homeaway_show = false,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x091C94",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0x08187D",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  
  bnd_bghome_color = "0xFFFFFF",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xFFFFFF",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
UefaUelInfo = { -- 300x120
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-CondBold",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0xE14711",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0x000000",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  
  bnd_bghome_color = "0x000000",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x000000",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2238_1"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
UefaWomensInfo = { -- 300x120
  bnd_bg1homeaway_show = false,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x012652",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0x0657A0",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  
  bnd_bghome_color = "0xFFFFFF",
  bnd_bghome_width = 60,
  bnd_bghome_height = 60,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "TOP",
  bnd_bgaway_color = "0xFFFFFF",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 60,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "2240_1"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
UnitedStatesInfo = { -- 300x120
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x1E1E1E",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0xffffff",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0x1E1E1E",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x1E1E1E",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 19
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
VietnamInfo = {
  bnd_forceCaps = true,
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x3C3C3C",
  bnd_bg1_width = 150,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0x8E1026",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xDEDEDE",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xDEDEDE",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2260
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
WomensSuperLeagueInfo = { -- 300x120
  bnd_forceCaps = true, 
  bnd_fontFace = "$Epl",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x1D0F33",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xF5F5F5",
  
  bnd_bg2_color = "0xF5F5F5",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x1D0F33",
  
  bnd_bghome_color = "0x1D0F33",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x1D0F33",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
-------------------------------------------------
-- ScorebroadSubs Turnamen --
-------------------------------------------------
WorldCupInfo = { -- 300x120
  bnd_fontFace = "$Qatar2022Arabic",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x02C7B3",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0x240211",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0x240211",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x240211",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
PialaIndonesiaInfo = { -- 300x120
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0xD8DF3A",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0x3471B2",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0x3471B2",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x3471B2",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
WorldCupWomensInfo = { -- 300x120
  bnd_fontFace = "$FWWC2023Bold",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0xF4F4DC",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x275759",
  
  bnd_bg2_color = "0x275759",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0x275759",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0x275759",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
FaCupInfo = { -- 300x120
  bnd_fontFace = "$Emirates-Bold",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0xffffff",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0xA8222A",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xA8222A",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xA8222A",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 13
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
UefaEuropeInfo = {
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x00BF0C",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xFFFFFF",
  
  bnd_bg2_color = "0x000000",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  
  bnd_bghome_color = "0x000000",
  bnd_bghome_width = 60,
  bnd_bghome_height = 120,
  bnd_bghome_left = -60,
  bnd_home_crest_alignV = "BOTTOM",
  bnd_home_crest_bottom = 10,
  bnd_home_crest_height = 50,
  bnd_home_crest_width = 50,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x000000",
  bnd_bgaway_width = 60,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -60,
  bnd_away_crest_alignV = "BOTTOM",
  bnd_away_crest_bottom = 10,
  bnd_away_crest_height = 50,
  bnd_away_crest_width = 50,
  
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID8"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 5,
  bnd_logo_left = 0,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
AsianCupInfo = { -- 300x120
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x94DF2A",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x2D065F",
  
  bnd_bg2_color = "0x2D065F",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xCEC0D7",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xCEC0D7",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 78
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
KingSaudiCupInfo = { 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0xFBDE98",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0x17573B",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0x000000",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x000000",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 78
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
EuroCupInfo = { 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x1B38D2",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0x1B38D2",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xffffff",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xffffff",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 78
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
UsaOpenCupInfo = { 
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0x1A2237",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0xD5093A",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xffffff",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0xffffff",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 78
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
AfricaCupInfo = {
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0xFF7900",
  bnd_bg1_width = 300,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0x004530",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0x726C6C",
  bnd_bghome_width = 90,
  bnd_bghome_height = 120,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "CENTER",
  bnd_bgaway_color = "0x726C6C",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 120,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 78
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = 95,
  bnd_logo_left = 0,
  bnd_logo_height = 16,
  bnd_logo_width = 80
}
CoppaItaliaInfo = {
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0xAA2C1D",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0xFFFFFF",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0xAA2C1D",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xAA2C1D",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
CopaDelReyInfo = {
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x000000",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0x860000",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xD2D7D1",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xD2D7D1",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
DfbPokalInfo = {
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x05BB6A",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0xD2D7D1",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0xD2D7D1",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xD2D7D1",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
CoupeDeFranceInfo = {
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x1A8EC4",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0xffffff",
  
  bnd_bg2_color = "0x071A31",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xffffff",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xffffff",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
FcwcInfo = {
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0xCDA31F",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0x000000",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xffffff",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xffffff",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
CopaLibertadoresInfo = {
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0x986B2A",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0xEDC261",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0x000000",
  
  bnd_bghome_color = "0xEDC261",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xEDC261",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
UefaNationsInfo = { 
  bnd_fontFace = "$UEFANations-Bold",
  bnd_bg1homeaway_show = true,
  bnd_bg1home_alignH = "RIGHT",
  bnd_bg1home_alignV = "TOP",
  bnd_bg1away_alignH = "LEFT",
  bnd_bg1away_alignV = "TOP",
  bnd_bg1_color = "0xF9FDFD",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x253242",
  
  bnd_bg2_color = "0x253242",
  bnd_bg2_alignV = "BOTTOM",
  bnd_InOut_name_fontColor = "0xF9FDFD",
  
  bnd_bghome_color = "0xF9FDFD",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "BOTTOM",
  bnd_bgaway_color = "0xF9FDFD",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
CopaAmericaInfo = { -- 300x120
  bnd_bg1homeaway_show = false,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0xE0E0E0",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0x000000",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xFFFFFF",
  
  bnd_bghome_color = "0x1B1365",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "TOP",
  bnd_bgaway_color = "0xB40309",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 19
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
}
AseanChampionshipInfo = {
  bnd_bg1homeaway_show = false,
  bnd_bg1home_alignH = "LEFT",
  bnd_bg1home_alignV = "BOTTOM",
  bnd_bg1away_alignH = "RIGHT",
  bnd_bg1away_alignV = "BOTTOM",
  bnd_bg1_color = "0xffffff",
  bnd_bg1_width = 120,
  bnd_bg1_height = 30,
  bnd_textsub_fontColor = "0x000000",
  
  bnd_bg2_color = "0x8E182A",
  bnd_bg2_alignV = "TOP",
  bnd_InOut_name_fontColor = "0xffffff",
  
  bnd_bghome_color = "0xffffff",
  bnd_bghome_width = 90,
  bnd_bghome_height = 90,
  bnd_bghome_left = -90,
  bnd_home_crest_alignV = "CENTER",
  bnd_home_crest_bottom = 0,
  bnd_home_crest_height = 75,
  bnd_home_crest_width = 75,
  bnd_bghomeaway_alignV = "TOP",
  bnd_bgaway_color = "0xffffff",
  bnd_bgaway_width = 90,
  bnd_bgaway_height = 90,
  bnd_bgaway_right = -90,
  bnd_away_crest_alignV = "CENTER",
  bnd_away_crest_bottom = 0,
  bnd_away_crest_height = 75,
  bnd_away_crest_width = 75,
  
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 19
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_top = -15,
  bnd_logo_left = 330,
  bnd_logo_height = 50,
  bnd_logo_width = 50
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
  local HOMETEAM = 0
  local AWAYTEAM = 1
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  
  homeTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(HOMETEAM, o.TeamsData[1].assetId, 0)
  awayTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(AWAYTEAM, o.TeamsData[2].assetId, 0)
  
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
  
  local currentdata = nil
 
  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      currentdata = UefaInfo
    elseif currentCupData.cupIndex == 2 then
      currentdata = WorldCupInfo
    elseif currentCupData.cupIndex == 3 then
      currentdata = UefaUelInfo
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
      currentdata = CopaAmericaInfo
    elseif currentCupData.cupIndex == 14 then
      currentdata = CopaDelReyInfo
    elseif currentCupData.cupIndex == 15 then
      currentdata = CoppaItaliaInfo
    elseif currentCupData.cupIndex == 16 then
      currentdata = DfbPokalInfo
    elseif currentCupData.cupIndex == 17 then
      currentdata = CoupeDeFranceInfo
    elseif currentCupData.cupIndex == 18 then
      currentdata = FcwcInfo
    elseif currentCupData.cupIndex == 19 then
      currentdata = CopaLibertadoresInfo
    elseif currentCupData.cupIndex == 20 then
      currentdata = UefaNationsInfo
    end
  elseif currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      currentdata = UefaInfo
    elseif currentTourData.tourIndex == 2 then
      currentdata = WorldCupInfo
    elseif currentTourData.tourIndex == 3 then
      currentdata = UefaUelInfo
    elseif currentTourData.tourIndex == 29 then
      currentdata = PialaIndonesiaInfo
    elseif currentTourData.tourIndex == 27 then
      currentdata = AseanChampionshipInfo      
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
      currentdata = CopaAmericaInfo
    elseif currentTourData.tourIndex == 10 then
      currentdata = CopaDelReyInfo
    elseif currentTourData.tourIndex == 11 then
      currentdata = CoppaItaliaInfo
    elseif currentTourData.tourIndex == 7 then
      currentdata = DfbPokalInfo
    elseif currentTourData.tourIndex == 18 then
      currentdata = CoupeDeFranceInfo
    elseif currentTourData.tourIndex == 15 then
      currentdata = FcwcInfo
    elseif currentTourData.tourIndex == 4 then
      currentdata = CopaLibertadoresInfo
    elseif currentTourData.tourIndex == 50 then
      currentdata = KingSaudiCupInfo      
    elseif currentTourData.tourIndex == 22 then
      currentdata = ClassicInfo      
      currentdata.bnd_logo.id = 1245    
    elseif currentTourData.tourIndex == 28 then
      currentdata = UefaNationsInfo
    elseif currentTourData.tourIndex == 24 then
      currentdata = EAFCInfo
    elseif currentTourData.tourIndex == 31 then
      currentdata = EAFCInfo      
    elseif currentTourData.tourIndex == 21 then
      currentdata = EAFCInfo      
  else 
    currentdata = EAFCInfo      
    end    
  else
     if o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
    currentdata = AlgeriaInfo
    elseif o:isInTable(o.TeamsData[1], AfcTeams) and o:isInTable(o.TeamsData[2], AfcTeams) then
    currentdata = AfcInfo
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
     currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
     currentdata = AsianCupU23Info
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 4
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 7
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    currentdata = ClassicInfo
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    currentdata = ClassicInfo
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    currentdata = ChampionshipEflInfo
    elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    currentdata = DenmarkInfo
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    currentdata = D1ArkemaInfo
    elseif  o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    currentdata = EcuadorInfo
    elseif  o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 2231
    elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    currentdata = EnglandInfo
    elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    currentdata = FranceInfo
    elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    currentdata = France2Info
    elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    currentdata = GermanyInfo
    elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
    currentdata = GermanyInfo
    elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
    currentdata = IndonesiaInfo
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 78
    elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 2136
    elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    currentdata = ItalyInfo
    elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
    currentdata = JapanInfo
    elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 83
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    currentdata = LeagueOneEflInfo
    elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
    currentdata = LeagueTwoEflInfo
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    currentdata = LigaFInfo
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    currentdata = MalaysiaInfo
    elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = "341_1"
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 2250
    elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    currentdata = NetherlandsInfo
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    currentdata = PegadaianLiga2Info
    elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = "308_1"
    elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 76
    elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 76
    elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    currentdata = SaudiArabiaInfo
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 50
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 347
    elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    currentdata = SpainInfo
    elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    currentdata = Spain2Info
    elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    currentdata = SwitzerlandInfo
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
    currentdata = ThailandInfo
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_logo.id = 68
    elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    currentdata = UefaInfo
    elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    currentdata = UefaUelInfo
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
  
  o.handlerId = o.services.eventManService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)
  
  o.im.Subscribe(bndNationalization, function()
  end)
  o.im.Subscribe(bndVisible, function()
    o.im.Publish(bndVisible, false)
  end)
  o.im.Subscribe(bndAlpha, function()
  end)
  o.im.Subscribe(bndData, function()
  end)
  o.im.Subscribe("bnd_Inplayer_avatar", function()
  end)
  o.im.Subscribe("bnd_Inplayer_name", function()
  end)
  o.im.Subscribe("bnd_Inplayer_number", function()
  end)
  o.im.Subscribe("bnd_Outplayer_avatar", function()
  end)
  o.im.Subscribe("bnd_Outplayer_name", function()
  end)
  o.im.Subscribe("bnd_Outplayer_number", function()
  end)
  o.im.Subscribe("bnd_home_crest_show", function()
    o.im.Publish("bnd_home_crest_show", false)
  end)
  o.im.Subscribe("bnd_away_crest_show", function()
    o.im.Publish("bnd_away_crest_show", false)
  end)
  o.im.Subscribe("bnd_home_crest", function()
    o.im.Publish("bnd_home_crest", HomeTeamData.crest)
  end)
  o.im.Subscribe("bnd_away_crest", function()
    o.im.Publish("bnd_away_crest", AwayTeamData.crest)
  end)
  
    for k,v in pairs(currentdata) do
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
  if hideshow == "SHOW" then
    if initialized == false then
      self.im.Publish(bndNationalization, self.nationalization)
      initialized = true
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
      self.im.Publish("bnd_Inplayer_avatar", InplayerAvatar)
      self.im.Publish("bnd_Outplayer_avatar", OutplayerAvatar)
      self.im.Publish("bnd_Inplayer_name", InplayerInfo.playerName)
      self.im.Publish("bnd_Outplayer_name", OutplayerInfo.playerName)
      self.im.Publish("bnd_Inplayer_number", InplayerInfo.jerseyNumber.."")
      self.im.Publish("bnd_Outplayer_number", OutplayerInfo.jerseyNumber.."")
      if teamside == 0 then
        self.im.Publish("bnd_home_crest_show", true)
        self.im.Publish("bnd_away_crest_show", false)
      else
        self.im.Publish("bnd_away_crest_show", true)
        self.im.Publish("bnd_home_crest_show", false)
      end
      self.im.Publish(bndData, substitutions)
    end
  elseif hideshow == "UPDATE" then
    self.im.Publish(bndAlpha, params[1] / 100)
    if params and table.getn(params) > 1 then
      self.im.Publish(bndVisible, true)
      local subTeamId = params[2] + 0
      local teamside = 0
      if subTeamId == self.TeamsData[1].assetId then
        teamside = 0
      else
        teamside = 1
      end
      local substitutions = {
        teamName = params[3],
        inPlayer = params[4],
        outPlayer = params[5]
      }
      local InplayerInfo = self:getPlayerInfo(teamside, subTeamId, substitutions.inPlayer)
      local OutplayerInfo = self:getPlayerInfo(teamside, subTeamId, substitutions.outPlayer)
      InplayerAvatar.id = InplayerInfo.assetId
      OutplayerAvatar.id = OutplayerInfo.assetId
      self.im.Publish("bnd_Inplayer_avatar", InplayerAvatar)
      self.im.Publish("bnd_Outplayer_avatar", OutplayerAvatar)
      self.im.Publish("bnd_Inplayer_name", InplayerInfo.playerName)
      self.im.Publish("bnd_Outplayer_name", OutplayerInfo.playerName)
      self.im.Publish("bnd_Inplayer_number", InplayerInfo.jerseyNumber.."")
      self.im.Publish("bnd_Outplayer_number", OutplayerInfo.jerseyNumber.."")
      if teamside == 0 then
        self.im.Publish("bnd_home_crest_show", true)
        self.im.Publish("bnd_away_crest_show", false)
      else
        self.im.Publish("bnd_away_crest_show", true)
        self.im.Publish("bnd_home_crest_show", false)
      end
      self.im.Publish(bndData, substitutions)
    end
  else
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
      -- playerInfo.level = teamlineupData[_FORV_6_].rating
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
  
  for k,v in pairs(EAFCInfo) do
    self.im.Unsubscribe(k)
  end
  self.services.eventManService.UnregisterHandler(self.handlerId)
end
return ScoreboardSubstitutions
