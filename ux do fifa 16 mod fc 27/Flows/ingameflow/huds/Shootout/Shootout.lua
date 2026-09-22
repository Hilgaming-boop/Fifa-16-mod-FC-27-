-- Thanks : Ma'ruf Id & Laosiji --
-- mvnprod.official --
-- talamlegit.official - Patch Mod EAFC24 --

local Shootout = {}
local OverlayParam, EventManager, TableUtil = ...
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes

local BND_ACTIVE = "bnd_active"
local BND_SCORE = "bnd_score"
local BND_HOME_TEAM = "bnd_home_team"
local BND_AWAY_TEAM = "bnd_away_team"
local BND_SIDE = "bnd_side"
local BND_HOME_HISTORY = "bnd_home_history"
local BND_AWAY_HISTORY = "bnd_away_history"

local STATE_INACTIVE = "HIDE"
local STATE_ACTIVE = "SHOW"
local SIDE_HOME = 0
local SIDE_AWAT = 1

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

AfcScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_sb_top = 40,
  bnd_bg_color = "0x2D065F",
  bnd_strip_color = "0x94DF2A",
  bnd_bg_crest_color = "0x94DF2A",
  bnd_stripclub_color = "0x2D065F",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x94DF2A",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x94DF2A",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 1 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
AsianCupU23Score = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x273F85",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0xFCDD10",
  bnd_stripclub_color = "0x151515",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 1 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
ClassicScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_sb_top = 40,
  bnd_bg_color = "0x6C0016",
  bnd_strip_color = "0xFFB700",
  bnd_bg_crest_color = "0x000000",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFFB700",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFB700",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 34 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
D1ArkemaScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_sb_top = 40,
  bnd_bg_color = "0x483D8B",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0xffffff",
  bnd_stripclub_color = "0x000000",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 5 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
EAFCScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_sb_top = 40,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0x151515",
  bnd_bg_crest_color = "0x00FF7E",
  bnd_stripclub_color = "0x151515",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x151515",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 0 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
EnglandScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl",
  bnd_sb_top = 60,
  bnd_bg_color = "0xF5F5F5",
  bnd_strip_color = "0x39003E",
  bnd_bg_crest_color = "0x39003E",
  bnd_stripclub_color = "0xF5F5F5",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x39003E",
  bnd_homeName_fontSize = 20,
  bnd_awayName_fontColor = "0x39003E",
  bnd_awayName_fontSize = 20,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 2 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
FranceScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Ligue1",
  bnd_sb_top = 40,
  bnd_bg_color = "0x1F1F1F",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0x304FFF",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 20,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 20,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 4 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
France2Score = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Ligue1",
  bnd_sb_top = 40,
  bnd_bg_color = "0x1F1F1F",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0x02FFCE",
  bnd_stripclub_color = "0x000000",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 20,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 20,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 4 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
GermanyScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Bundesliga",
  bnd_sb_top = 40,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0xD10214",
  bnd_bg_crest_color = "0x333333",
  bnd_stripclub_color = "0xFFFFFF",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_homeName_fontSize = 20,
  bnd_awayName_fontColor = "0x151515",
  bnd_awayName_fontSize = 20,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 11 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
Germany2Score = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Bundesliga",
  bnd_sb_top = 40,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0xD10214",
  bnd_bg_crest_color = "0x333333",
  bnd_stripclub_color = "0xFFFFFF",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_homeName_fontSize = 20,
  bnd_awayName_fontColor = "0x151515",
  bnd_awayName_fontSize = 20,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 12 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
IndonesiaScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Liga1",
  bnd_sb_top = 40,
  bnd_bg_color = "0x00519D",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0x505050",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 14 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
ItalyScore = {
  bnd_forceCaps = true,
  bnd_sb_top = 40,
  bnd_bg_color = "0x0F2D61",
  bnd_strip_color = "0xFFFFFF",
  bnd_bg_crest_color = "0xFFFFFF",
  bnd_stripclub_color = "0x0F2D61",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 15 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
JapanScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_sb_top = 40,
  bnd_bg_color = "0x000000",
  bnd_strip_color = "0xFFFFFF",
  bnd_bg_crest_color = "0xFFFFFF",
  bnd_stripclub_color = "0x0000000",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 16 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
LigaFScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x032A6F",
  bnd_strip_color = "0x14FEB7",
  bnd_bg_crest_color = "0x14FEB7",
  bnd_stripclub_color = "0x032A6F",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x14FEB7",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x14FEB7",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 18 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
MalaysiaScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Malaysia",
  bnd_sb_top = 40,
  bnd_bg_color = "0x131262",
  bnd_strip_color = "0x16FEC2",
  bnd_bg_crest_color = "0x16FEC2",
  bnd_stripclub_color = "0x131262",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x16FEC2",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x16FEC2",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 17 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
NetherlandsScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_sb_top = 40,
  bnd_bg_color = "0xffffff",
  bnd_strip_color = "0x5C5C5C",
  bnd_bg_crest_color = "0x5C5C5C",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x000000",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x000000",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 39 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
PegadaianLiga2Score = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_sb_top = 40,
  bnd_bg_color = "0x07472B",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0xAED328",
  bnd_stripclub_color = "0x07472B",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 14 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
SaudiArabiaScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$SPL",
  bnd_sb_top = 40,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0x404040",
  bnd_bg_crest_color = "0x404040",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x404040",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x404040",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 19 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
SpainScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga",
  bnd_sb_top = 40,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0xFF5C41",
  bnd_bg_crest_color = "0x151515",
  bnd_stripclub_color = "0xFF5C41",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_homeName_fontSize = 20,
  bnd_awayName_fontColor = "0x151515",
  bnd_awayName_fontSize = 20,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 20 },
  bnd_homeCrest = { name = "$LaLigaTeamCrest", id = 0 },
  bnd_awayCrest = { name = "$LaLigaTeamCrest", id = 0 }
}
Spain2Score = {
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga",
  bnd_sb_top = 40,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0x04D4D4",
  bnd_bg_crest_color = "0x151515",
  bnd_stripclub_color = "0x04D4D4",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_homeName_fontSize = 20,
  bnd_awayName_fontColor = "0x151515",
  bnd_awayName_fontSize = 20,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 21 },
  bnd_homeCrest = { name = "$LaLigaTeamCrest", id = 0 },
  bnd_awayCrest = { name = "$LaLigaTeamCrest", id = 0 }
}
ThailandScore = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_sb_top = 40,
  bnd_bg_color = "0xffffff",
  bnd_strip_color = "0xFE0000",
  bnd_bg_crest_color = "0xFE0000",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFE0000",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFE0000",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 0 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
UefaScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Font_Ucl",
  bnd_sb_top = 60,
  bnd_bg_color = "0x08187D",
  bnd_strip_color = "0xFFFFFF",
  bnd_bg_crest_color = "0xFFFFFF",
  bnd_stripclub_color = "0x08187D",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 22 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
UefaUelScore = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-CondBold",
  bnd_sb_top = 40,
  bnd_bg_color = "0x000000",
  bnd_strip_color = "0xFF6833",
  bnd_bg_crest_color = "0x000000",
  bnd_stripclub_color = "0xFF6833",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 22 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
UefaWomensScore = {
  bnd_sb_top = 60,
  bnd_bg_color = "0x0657A0",
  bnd_strip_color = "0xFFFFFF",
  bnd_bg_crest_color = "0xFFFFFF",
  bnd_stripclub_color = "0x0657A0",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 18 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
UnitedStatesScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0xffffff",
  bnd_strip_color = "0x1E1E1E",
  bnd_bg_crest_color = "0x1E1E1E",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x1E1E1E",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x1E1E1E",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 23 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
USANWSLScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0xffffff",
  bnd_strip_color = "0x1E1E1E",
  bnd_bg_crest_color = "0x1E1E1E",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x1E1E1E",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x1E1E1E",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 0 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
VietnamScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl",
  bnd_sb_top = 60,
  bnd_bg_color = "0xefefef",
  bnd_strip_color = "0x000000",
  bnd_bg_crest_color = "0x8E1026",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x000000",
  bnd_homeName_fontSize = 17,
  bnd_awayName_fontColor = "0x000000",
  bnd_awayName_fontSize = 17,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 37 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
WomensSuperLeagueScore = {
  bnd_forceCaps = true, 
  bnd_fontFace = "$Epl",
  bnd_sb_top = 40,
  bnd_bg_color = "0x1D0F33",
  bnd_strip_color = "0xEA3845",
  bnd_bg_crest_color = "0x1D0F33",
  bnd_stripclub_color = "0xEA3845",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xF5F5F5",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xF5F5F5",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 10 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
-------------------------------------
-- Shootout Turnamen --
-------------------------------------
WorldCupScore = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$Qatar2022Arabic",
  bnd_sb_top = 40,
  bnd_bg_color = "0x3D031E",
  bnd_strip_color = "0x14C4A1",
  bnd_bg_crest_color = "0x14C4A1",
  bnd_stripclub_color = "0x3D031E",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 24 },
  bnd_homeCrest = { name = "$NationalCrest", id = 0 },
  bnd_awayCrest = { name = "$NationalCrest", id = 0 }
}
PialaIndonesiaScore = { 
  bnd_forceCaps = true,
  bnd_sb_top = 40,
  bnd_bg_color = "0xffffff",
  bnd_strip_color = "0x000000",
  bnd_bg_crest_color = "0x3471B2",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x000000",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x000000",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 25 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
WomenWorldCupScore = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$FWWC2023Bold",
  bnd_sb_top = 40,
  bnd_bg_color = "0x275759",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0xF4F4DC",
  bnd_stripclub_color = "0x275759",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 26 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
FaCupScore = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_sb_top = 40,
  bnd_bg_color = "0xBF0D19",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0xffffff",
  bnd_stripclub_color = "0xBF0D19",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 27 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
UefaUeclScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x1F2120",
  bnd_strip_color = "0x1DBB05",
  bnd_bg_crest_color = "0x1DBB05",
  bnd_stripclub_color = "0x1F2120",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 22 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
AsianCupScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_sb_top = 40,
  bnd_bg_color = "0x2D065F",
  bnd_strip_color = "0x94DF2A",
  bnd_bg_crest_color = "0x94DF2A",
  bnd_stripclub_color = "0x2D065F",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x94DF2A",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x94DF2A",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 1 },
  bnd_homeCrest = { name = "$AsianCupCrest", id = 0 },
  bnd_awayCrest = { name = "$AsianCupCrest", id = 0 }
}
KingSaudiCupScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x17573B",
  bnd_strip_color = "0xFBDE98",
  bnd_bg_crest_color = "0x000000",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFBDE98",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFBDE98",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 38 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
EuroCupScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0xffffff",
  bnd_strip_color = "0x1B38D2",
  bnd_bg_crest_color = "0x1B38D2",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x000000",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x000000",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 22 },
  bnd_homeCrest = { name = "$EuroCupCrest", id = 0 },
  bnd_awayCrest = { name = "$EuroCupCrest", id = 0 }
}
UsaOpenCupScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0xD5093A",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0x1A2237",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 22 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
CopaDelReyScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x000000",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0xE60035",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 30 },
  bnd_homeCrest = { name = "$LaLigaTeamCrest", id = 0 },
  bnd_awayCrest = { name = "$LaLigaTeamCrest", id = 0 }
}
AfricaCupScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x064534",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0xFC7824",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 32 },
  bnd_homeCrest = { name = "$AfconCrest", id = 0 },
  bnd_awayCrest = { name = "$AfconCrest", id = 0 }
}
CoppaItaliaScore = {
  bnd_forceCaps = true,
  bnd_sb_top = 40,
  bnd_bg_color = "0xaa2c1d",
  bnd_strip_color = "0xFFFFFF",
  bnd_bg_crest_color = "0xFFFFFF",
  bnd_stripclub_color = "0xaa2c1d",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 31 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
DfbPokalScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0xD2D7D1",
  bnd_strip_color = "0x000000",
  bnd_bg_crest_color = "0x089655",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x000000",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x000000",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 33 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
CoupeDeFranceScore = { 
  bnd_sb_top = 40,
  bnd_bg_color = "0x071A31",
  bnd_strip_color = "0x1A8EC4",
  bnd_bg_crest_color = "0x1A8EC4",
  bnd_stripclub_color = "0x071A31",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 35 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
FcWcScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x000000",
  bnd_strip_color = "0xFFFFFF",
  bnd_bg_crest_color = "0xCDA31F",
  bnd_stripclub_color = "0xFFFFFF",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 36 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
CopaLibertadoresScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0xEDC261",
  bnd_strip_color = "0x000000",
  bnd_bg_crest_color = "0x000000",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x000000",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x000000",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 36 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
UefaNationsScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_sb_top = 40,
  bnd_bg_color = "0xF9FDFD",
  bnd_strip_color = "0x253242",
  bnd_bg_crest_color = "0x253242",
  bnd_stripclub_color = "0xF9FDFD",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x253242",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0x253242",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 22 },
  bnd_homeCrest = { name = "$NationalCrest", id = 0 },
  bnd_awayCrest = { name = "$NationalCrest", id = 0 }
}
CopaAmericaScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x000000",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0xB40309",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 0 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
AseanChampionshipScore = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_sb_top = 40,
  bnd_bg_color = "0x8E182A",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0x8E182A",
  bnd_stripclub_color = "0xFF0700",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_homeName_fontSize = 18,
  bnd_awayName_fontColor = "0xffffff",
  bnd_awayName_fontSize = 18,
  --
  bnd_live_logo = { name = "$LiveLogo", id = 1 },
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest = { name = "$Crest", id = 0 }
}
function Shootout:new(init)
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

  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end)
  
  local HOMETEAM = 0
  local AWAYTEAM = 1
  
  local AlgeriaTeams = o.services.TeamService.GetTeams(leagueIDs.Algeria, 0, 0, true)
  local AFFTeams = o.services.TeamService.GetTeams(leagueIDs.AFF, 0, 0, true)
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
  
  o.currentdata = {}
  
  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      o.currentdata = UefaScore
      elseif currentCupData.cupIndex == 2 then
      o.currentdata = WorldCupScore
      elseif currentCupData.cupIndex == 3 then
      o.currentdata = UefaUelScore
      elseif currentCupData.cupIndex == 4 then
      o.currentdata = PialaIndonesiaScore
      elseif currentCupData.cupIndex == 5 then
      o.currentdata = WomenWorldCupScore
      elseif currentCupData.cupIndex == 6 then
      o.currentdata = UefaWomensScore
      elseif currentCupData.cupIndex == 7 then
      o.currentdata = FaCupScore
      elseif currentCupData.cupIndex == 8 then
      o.currentdata = UefaUeclScore
      elseif currentCupData.cupIndex == 9 then
      o.currentdata = AsianCupScore
      elseif currentCupData.cupIndex == 10 then
      o.currentdata = KingSaudiCupScore
      elseif currentCupData.cupIndex == 11 then
      o.currentdata = EuroCupScore
      elseif currentCupData.cupIndex == 12 then
      o.currentdata = UsaOpenCupScore
      elseif currentCupData.cupIndex == 13 then
      o.currentdata = CopaAmericaScore
      elseif currentCupData.cupIndex == 14 then
      o.currentdata = CopaDelReyScore
      elseif currentCupData.cupIndex == 15 then
      o.currentdata = CoppaItaliaScore
      elseif currentCupData.cupIndex == 16 then
      o.currentdata = DfbPokalScore
      elseif currentCupData.cupIndex == 17 then
      o.currentdata = CoupeDeFranceScore
      elseif currentCupData.cupIndex == 18 then
      o.currentdata = FcWcScore
      elseif currentCupData.cupIndex == 19 then
      o.currentdata = CopaLibertadoresScore
      elseif currentCupData.cupIndex == 20 then
      o.currentdata = UefaNationsScore
  end
  elseif currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      o.currentdata = UefaScore
      elseif currentTourData.tourIndex == 2 then
      o.currentdata = WorldCupScore
      elseif currentTourData.tourIndex == 3 then
      o.currentdata = UefaUelScore
      elseif currentTourData.tourIndex == 27 then
      o.currentdata = AseanChampionshipScore
      elseif currentTourData.tourIndex == 35 then
      o.currentdata = WomenWorldCupScore
      elseif currentTourData.tourIndex == 16 then
      o.currentdata = UefaWomensScore      
      elseif currentTourData.tourIndex == 9 then
      o.currentdata = FaCupScore
      elseif currentTourData.tourIndex == 17 then
      o.currentdata = UefaUeclScore
      elseif currentTourData.tourIndex == 34 then
      o.currentdata = AsianCupScore
      elseif currentTourData.tourIndex == 6 then
      o.currentdata = EuroCupScore
      elseif currentTourData.tourIndex == 13 then
      o.currentdata = UsaOpenCupScore
      elseif currentTourData.tourIndex == 25 then
      o.currentdata = CopaAmericaScore
      elseif currentTourData.tourIndex == 10 then
      o.currentdata = CopaDelReyScore
      elseif currentTourData.tourIndex == 11 then
      o.currentdata = CoppaItaliaScore
      elseif currentTourData.tourIndex == 7 then
      o.currentdata = DfbPokalScore
      elseif currentTourData.tourIndex == 18 then
      o.currentdata = CoupeDeFranceScore
      elseif currentTourData.tourIndex == 15 then
      o.currentdata = FcWcScore
      elseif currentTourData.tourIndex == 4 then
      o.currentdata = CopaLibertadoresScore
      elseif currentTourData.tourIndex == 50 then
      o.currentdata = KingSaudiCupScore      
      elseif currentTourData.tourIndex == 22 then
      o.currentdata = ClassicScore      
      elseif currentTourData.tourIndex == 28 then
      o.currentdata = UefaNationsScore
      elseif currentTourData.tourIndex == 24 then
      o.currentdata = EAFCScore
      elseif currentTourData.tourIndex == 31 then
      o.currentdata = EAFCScore      
      elseif currentTourData.tourIndex == 21 then
      o.currentdata = EAFCScore      
  else  
    o.currentdata = EAFCScore      
  end  
  else
    
  if o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], AfcTeams) and o:isInTable(o.TeamsData[2], AfcTeams) then
    o.currentdata = AfcScore
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
    o.currentdata = AsianCupU23Score
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    o.currentdata = ClassicScore
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    o.currentdata = ClassicScore
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    o.currentdata = D1ArkemaScore
    elseif o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    o.currentdata = EnglandScore
    elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    o.currentdata = FranceScore
    elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    o.currentdata = France2Score
    elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    o.currentdata = GermanyScore
    elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
    o.currentdata = Germany2Score
    elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
    o.currentdata = IndonesiaScore
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    o.currentdata = ItalyScore
    elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
    o.currentdata = JapanScore
    elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    o.currentdata = LigaFScore
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    o.currentdata = MalaysiaScore
    elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    o.currentdata = NetherlandsScore
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    o.currentdata = PegadaianLiga2Score
    elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    o.currentdata = SaudiArabiaScore
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    o.currentdata = SpainScore
    elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    o.currentdata = Spain2Score
    elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
    o.currentdata = ThailandScore
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    o.currentdata = UefaScore
    elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    o.currentdata = UefaUelScore
    elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
    o.currentdata = UefaWomensScore
    elseif o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
    o.currentdata = UnitedStatesScore
    elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USAMWSLTeams) then
    o.currentdata = USANWSLScore
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
    o.currentdata = VietnamScore
    elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
    o.currentdata = WomensSuperLeagueScore
  
  else  
    o.currentdata = EAFCScore
  end
  end
  
    o.currentdata.bnd_homeCrest.id = o.TeamsData[1].assetId
    o.currentdata.bnd_awayCrest.id = o.TeamsData[2].assetId
    o.currentdata.bnd_homeName_text = o.services.GameSetupService.GetTeamShortName(HOMETEAM)
    o.currentdata.bnd_awayName_text = o.services.GameSetupService.GetTeamShortName(AWAYTEAM)
  
  
  o.im.Subscribe(BND_ACTIVE, function()
    o:_publishActivity()
  end)
  o.im.Subscribe(BND_SCORE, function()
    o:_publishScore()
  end)
  o.im.Subscribe(BND_HOME_TEAM, function()
    o:_publishTeam()
  end)
  o.im.Subscribe(BND_AWAY_TEAM, function()
    o:_publishTeam(true)
  end)
  o.im.Subscribe(BND_SIDE, function()
    o:_publishSide()
  end)
  o.im.Subscribe(BND_HOME_HISTORY, function()
    o:_publishHistory()
  end)
  o.im.Subscribe(BND_AWAY_HISTORY, function()
    o:_publishHistory(true)
  end)
  o:setState(STATE_INACTIVE)
  
  for k,v in pairs(o.currentdata) do
    o.im.Subscribe(k, function()
      o.im.Publish(k, v)
    end)
  end
  
  return o
end
function Shootout:setState(state)
  self.state = state or STATE_INACTIVE
  self:_publishActivity()
end
function Shootout:_onShootoutUpdate(data)
  assert(data, "Overlay data is nil.")
  assert(data.hideshow, "Overlay data contains no \"hideshow\" property.")
  assert(data.msg, "Overlay data contains no \"msg\" property.")
  local params = OverlayParam.split(data.msg, "|")
  local homeTeamID = self.TeamsData[1].assetId
  local awayTeamID = self.TeamsData[2].assetId
  if self.TeamsData[1].teamId == awayTeamID then
    homeTeamID = self.TeamsData[2].assetId
    awayTeamID = self.TeamsData[1].assetId
  end
  self.homeTeam = {
    id = homeTeamID,
    name = tostring(params[2])
  }
  self.awayTeam = {
    id = awayTeamID,
    name = tostring(params[9])
  }
  self.homeHistory = {
    tonumber(params[3]),
    tonumber(params[4]),
    tonumber(params[5]),
    tonumber(params[6]),
    tonumber(params[7])
  }
  self.awayHistory = {
    tonumber(params[10]),
    tonumber(params[11]),
    tonumber(params[12]),
    tonumber(params[13]),
    tonumber(params[14])
  }
  self.side = tonumber(params[17])
  self:_publishTeam()
  self:_publishTeam(true)
  self:_publishHistory()
  self:_publishHistory(true)
  self:_publishSide()
  self:_publishScore()
  self:setState(data.hideshow)
end
function Shootout:_publishActivity()
  self.im.Publish(BND_ACTIVE, self.state ~= STATE_INACTIVE)
end
function Shootout:_publishScore()
  local matchScore = self.services.MatchInfoService.GetMatchScore()
  local homeScore = matchScore.homeShootout
  local awayScore = matchScore.awayShootout
  local shootoutScore = string.format("%s . %s", tostring(homeScore), tostring(awayScore))
  self.im.Publish(BND_SCORE, shootoutScore)
end
function Shootout:_publishTeam(isAway)
  if isAway then
    if self.awayTeam ~= nil then
      self.im.Publish(BND_AWAY_TEAM, self.awayTeam)
    end
  elseif self.homeTeam ~= nil then
    self.im.Publish(BND_HOME_TEAM, self.homeTeam)
  end
end
function Shootout:_publishSide()
  self.im.Publish(BND_SIDE, self.side or -1)
end
function Shootout:_publishHistory(isAway)
  if isAway then
    if self.awayHistory ~= nil then
      self.im.Publish(BND_AWAY_HISTORY, self.awayHistory)
    end
  elseif self.homeHistory ~= nil then
    self.im.Publish(BND_HOME_HISTORY, self.homeHistory)
  end
end
function Shootout:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.OverlayTypeShootoutHistory then
    self:_onShootoutUpdate(data)
  end
end

function Shootout:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function Shootout:finalize()
  self.im.Unsubscribe(BND_ACTIVE)
  self.im.Unsubscribe(BND_SCORE)
  self.im.Unsubscribe(BND_HOME_TEAM)
  self.im.Unsubscribe(BND_AWAY_TEAM)
  self.im.Unsubscribe(BND_SIDE)
  self.im.Unsubscribe(BND_HOME_HISTORY)
  self.im.Unsubscribe(BND_AWAY_HISTORY)
  
  for k,v in pairs(EAFCScore) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end
return Shootout