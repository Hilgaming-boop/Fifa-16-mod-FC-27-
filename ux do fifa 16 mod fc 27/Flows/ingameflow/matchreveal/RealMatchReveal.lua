-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

local RealMatchReveal = {}

weatherRandom = 0
cameraIndex = 0
homeTeamlineupData = nil
awayTeamlineupData = nil


leagueIDs = {
  Algeria = 2262,
  Afc = 365,
  Argentina = 353,
  AsianCupU23 = 2264,
  Belgium = 4,
  Brazil = 7,
  Classic = 1245,
  Classic2 = 1246,
  ChampionshipEfl = 14,
  Colombia  = 336,
  Croatia = 317,
  CzechRepublic = 319,
  D1Arkema = 2218,
  Denmark = 1,
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
  LigaF = 2222,
  Malaysia = 2237,
  Mexico = 341,
  Morocco =  2250,
  Netherlands = 10,
  Portugal = 308,
  PegadaianLiga2 = 2254,
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

AlgeriaTeams = nil
AfcTeams = nil
ArgentinaTeams = nil
AsianCupU23Teams = nil
BelgiumTeams = nil
BrazilTeams = nil
ClassicTeams = nil
Classic2Teams = nil
ChampionshipEflTeams = nil
ColombiaTeams = nil
CroatiaTeams = nil
CzechRepublicTeams = nil
D1ArkemaTeams = nil
DenmarkTeams = nil
EcuadorTeams = nil
EgyptTeams = nil
EnglandTeams = nil
FranceTeams = nil
France2Teams = nil
GermanyTeams = nil
Germany2Teams = nil
IndonesiaTeams = nil
InternationalTeams = nil
International2Teams = nil
ItalyTeams = nil
JapanTeams = nil
KoreaRepublicTeams = nil
LeagueOneEflTeams = nil
MalaysiaTeams = nil
MexicoTeams = nil
MoroccoTeams = nil
NetherlandsTeams = nil
PortugalTeams = nil
PegadaianLiga2Teams = nil
RestOfWorldTeams = nil
RestOfWorld2Teams = nil
RusiaTeams = nil
SaudiArabiaTeams = nil
ScotlandTeams = nil
SouthAfricaTeams = nil
SpainTeams = nil
Spain2Teams = nil
SwitzerlandTeams = nil
ThailandTeams = nil
TurkeyTeams = nil
UefaTeams = nil
UefaUelTeams = nil
UefaWomensTeams = nil
UkraineTeams = nil
UnitedStatesTeams = nil
USANWSLTeams = nil
VanaramaFootballLeagueTeams = nil
VietnamTeams = nil 
WomensSuperLeagueTeams = nil

local EAFCInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpandes", 
  bnd_home_openAnim = {
    name = "$IconMatchReveal",
    id = 0
  },
  bnd_home_openAnim_left = -310,
  bnd_home_openAnim_bottom = -200,
  bnd_home_openAnim_width = 790,
  bnd_home_openAnim_height = 320,
  bnd_shadow_visible = false,
  bnd_icon = {
    name = "$Icon",
    id = 0
  },
  bnd_icon_left = 30,
  bnd_icon_top = -30,
  bnd_icon_width = 400,
  bnd_icon_height = 150,  
  bnd_home_stadium_bg = {
    name = "$StadiumBackground",
    id = 0
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 400,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = -1900000000,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 90,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -600,
  bnd_home_team_name_top = 80,
  bnd_team_name_size = 0,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -240,
  bnd_away_team_name_top = 80,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 888,
  bnd_home_team_crest_bottom = -250,
  bnd_team_crest_width = 50,
  bnd_team_crest_height = 50,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = 830,
  bnd_away_team_crest_bottom = -250,
  bnd_match_type = "STADIUM",
  bnd_match_type_top = 160,
  bnd_match_type_left = -868,
  bnd_match_type_fontColor = "0x000000",
  bnd_match_type_size = 14,
  bnd_match_vs = "",
  bnd_match_vs_bottom = 120,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 5,
  bnd_match_stadium_bottom = -160,
  bnd_match_stadium_right = 863,
  bnd_stadium_textAlignH = "LEFT",
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_size = 14,
  bnd_stadium_title = "",
  bnd_stadium_autoScroll = true,
  bnd_stadium_width = 90,
  bnd_stadium_title_fontColor = "0x000000",
  bnd_stadium_title_size = 14,
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logo_alignV = "BOTTOM",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 35,
  bnd_logo_height = 35,
  bnd_logo_left = 0,
  bnd_logo_right = 1335,
  bnd_logo_top = 0,
  bnd_logo_bottom = 190,
  
  bnd_logo2 = {
    name = "$SimMatchIcon4Off",
    id = 0
  },
  bnd_logo2_alignV = "TOP",
  bnd_logo2_alignH = "LEFT",
  bnd_logo2_width = 45,
  bnd_logo2_height = 45,
  bnd_logo2_left = 1135,
  bnd_logo2_right = 0,
  bnd_logo2_top = 570,
  bnd_logo2_bottom = 0,

  bnd_live_logo = {
    name = "$LiveLogo",
    id = 0
  },  
  bnd_title_text = "Loading.......",
  bnd_title_text_left = 230,
  bnd_title_text_top = 270,
}
SaudiArabiaInfo = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$SPL", 
  bnd_home_openAnim = {
    name = "$Bg_EAFC",
    id = 0
  },
  bnd_home_openAnim_left = -50,
  bnd_home_openAnim_bottom = -20,
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$StadiumBackground",
    id = 0
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 250,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = -190,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "Loading . . . . . . .",
  bnd_loading_text_left = 90,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -600,
  bnd_home_team_name_top = 80,
  bnd_team_name_size = 0,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -240,
  bnd_away_team_name_top = 80,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 920,
  bnd_home_team_crest_bottom = -230,
  bnd_team_crest_width = 70,
  bnd_team_crest_height = 70,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = 800,
  bnd_away_team_crest_bottom = -230,
  bnd_match_type = "",
  bnd_match_type_top = 288,
  bnd_match_type_left = -860,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_type_size = 0,
  bnd_match_vs = "",
  bnd_match_vs_bottom = 120,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 5,
  bnd_match_stadium_bottom = -270,
  bnd_match_stadium_right = 860,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_size = 13,
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 350
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 70,
  bnd_logo_height = 70,
  bnd_logo_left = 0,
  bnd_logo_right = 1240,
  bnd_logo_top = 525,
  bnd_logo_bottom = 0
}
local ThailandInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_home_openAnim = {
    name = "$Bg_Thailand",
    id = 0
  },
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$StadiumBackground",
    id = 0
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 250,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = -190,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "Loading . . . . . . .",
  bnd_loading_text_left = 90,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -600,
  bnd_home_team_name_top = -85,
  bnd_team_name_size = 30,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -450,
  bnd_away_team_name_top = -12,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 765,
  bnd_home_team_crest_bottom = 82,
  bnd_team_crest_width = 65,
  bnd_team_crest_height = 65,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = 270,
  bnd_away_team_crest_bottom = 10,
  bnd_match_type = "",
  bnd_match_type_top = 285,
  bnd_match_type_left = -840,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_type_size = 18,
  bnd_match_vs = "",
  bnd_match_vs_bottom = 120,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 5,
  bnd_match_stadium_bottom = -16,
  bnd_match_stadium_right = 390,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_size = 18,
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 2252
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = 985,
  bnd_logo_top = 110,
  bnd_logo_bottom = 0
}
local UCLInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$UCL-Regular",
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$bg_uefa_match_hub"
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 260,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = 810,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "Loading . . . . . . .",
  bnd_loading_text_left = -950,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_home_team_name_fontColor = "0xffffff",
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_away_team_name_fontColor = "0xffffff",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_fontColor = "0xffffff",
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 2236
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_left = 70,
  bnd_logo_right = 0,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local WorldCupInfo = {
  bnd_shadow_visible = false,	
  bnd_fontFace = "$Qatar2022Arabic",
  bnd_bg = {
    name = "$bg_WcQatar_match_hub",
  },
  bnd_home_stadium_bg = {
    name = "$StadiumBackground",
    id = 0
  },
bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 400,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = -1900000000,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 90,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -600,
  bnd_home_team_name_top = 80,
  bnd_team_name_size = 0,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -250,
  bnd_away_team_name_top = 80,
  bnd_home_team_crest = {
    name = "$CrestWorldCup2026",
    id = 0
  },
  bnd_home_team_crest_right = 918,
  bnd_home_team_crest_bottom = -220,
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_away_team_crest = {
    name = "$CrestWorldCup2026",
    id = 0
  },
  bnd_away_team_crest_right = 830,
  bnd_away_team_crest_bottom = -220,
  bnd_match_type = "FIFA WORLD CUP 2026",
  bnd_match_type_top = 270,
  bnd_match_type_left = -868,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_type_size = 15,
  bnd_match_vs = "V",
  bnd_match_vs_bottom = 120,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 5,
  bnd_match_stadium_bottom = -270,
  bnd_match_stadium_right = 863,
  bnd_stadium_textAlignH = "LEFT",
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_size = 15,
  bnd_stadium_title = "",
  bnd_stadium_title_fontColor = "0xffffff",
  bnd_stadium_title_size = 15,
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID2"
  },
  bnd_logo_alignV = "BOTTOM",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 105,
  bnd_logo_height = 105,
  bnd_logo_left = 0,
  bnd_logo_right = 1250,
  bnd_logo_top = 0,
  bnd_logo_bottom = 500,
  
  bnd_logo2 = {
    name = "$SimMatchIcon4Off",
    id = 0
  },
  bnd_logo2_alignV = "TOP",
  bnd_logo2_alignH = "LEFT",
  bnd_logo2_width = 45,
  bnd_logo2_height = 45,
  bnd_logo2_left = 1135,
  bnd_logo2_right = 0,
  bnd_logo2_top = 570,
  bnd_logo2_bottom = 0,

  bnd_live_logo = {
    name = "$LiveLogo",
    id = 23
  },  
  bnd_title_text = "Loading.......",
  bnd_title_text_left = 230,
  bnd_title_text_top = 270,
}

local UefaUelInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-CondBold",
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_uefauel_match_hub"
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 350,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 2000000000000,
  bnd_loadingIcon_width = 0,
  bnd_loadingIcon_height = 0,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -30,
  bnd_home_team_name_top = 200,
  bnd_home_team_name_fontColor = "0xF96D20",
  bnd_team_name_size = 30,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -30,
  bnd_away_team_name_top = 250,
  bnd_away_team_name_fontColor = "0xF96D20",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 230,
  bnd_home_team_crest_bottom = -50,
  bnd_team_crest_width = 138,
  bnd_team_crest_height = 138,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -170,
  bnd_away_team_crest_bottom = -50,
  bnd_match_type = "UEFA Europa League",
  bnd_match_type_top = -60,
  bnd_match_type_fontColor = "0xF96D20",
  bnd_match_type_left = -30,
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = -50,
  bnd_match_vs_right = 30,
  bnd_match_vs_size = 30,
  bnd_match_vs_fontColor = "0xF96D20",
  bnd_match_stadium_bottom = -1400000000,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xF96D20",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID2"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = 310,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}
local PialaIndonesiaInfo = {
  bnd_forceCaps = true,
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$bg_pialaindonesia_match_hub"
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 350,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 80,
  bnd_loadingIcon_height = 80,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_home_team_name_fontColor = "0xffffff",
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_away_team_name_fontColor = "0xffffff",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_fontColor = "0xffffff",
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID4"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_left = 70,
  bnd_logo_right = 0,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local WcWomenInfo = { 
  bnd_fontFace = "$FWWC2023",
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_Wcwomen_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 2000000000000,
  bnd_loadingIcon_width = 0,
  bnd_loadingIcon_height = 0,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = 0,
  bnd_home_team_name_top = 120,
  bnd_home_team_name_fontColor = "0x01222F",
  bnd_team_name_size = 30,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 0,
  bnd_away_team_name_top = 150,
  bnd_away_team_name_fontColor = "0x01222F",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = -30,
  bnd_team_crest_width = 138,
  bnd_team_crest_height = 138,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = -30,
  bnd_match_type = "FIFA Women's World Cup",
  bnd_match_type_top = -130,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0x01222F",
  bnd_match_vs = "",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -1400000000,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0x77E0DF",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID2"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = 310,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local UclWomenInfo = {
  bnd_forceCaps = true,
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$bg_uclwomen_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 80,
  bnd_loadingIcon_height = 80,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_home_team_name_fontColor = "0xffffff",
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_away_team_name_fontColor = "0xffffff",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_fontColor = "0xffffff",
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "Stadium",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = 700000000,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local FaCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_facup_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "EMIRATES FA CUP",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "Stadium",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = -100,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local UeclInfo = {
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_uecl_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "UEFA Conference League",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "Stadium",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = -100,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local AsianCupInfo = {
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_asiancup_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_home_team_crest = {
    name = "$AsianCupCrest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$AsianCupCrest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "AFC ASIAN CUP QATAR 2023™",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "Stadium",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID9"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = -100,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local KingSaudiCupInfo = {
  bnd_forceCaps = true,
  bnd_home_openAnim = {
    name = "$Background_Intro_CupID10",
    id = 0
  },
  bnd_home_openAnim_height = 720,
  bnd_home_openAnim_width = 1600,
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$StadiumBackground",
    id = 0
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 250,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = -190,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "Loading . . . . . . .",
  bnd_loading_text_left = 90,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -700,
  bnd_home_team_name_top = -95,
  bnd_team_name_size = 30,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -450,
  bnd_away_team_name_top = -12,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 895,
  bnd_home_team_crest_bottom = 105,
  bnd_team_crest_width = 65,
  bnd_team_crest_height = 65,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = 240,
  bnd_away_team_crest_bottom = 15,
  bnd_match_type = "",
  bnd_match_type_top = 285,
  bnd_match_type_left = -840,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_type_size = 18,
  bnd_match_vs = "",
  bnd_match_vs_bottom = 120,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 5,
  bnd_match_stadium_bottom = -35,
  bnd_match_stadium_right = 400,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_size = 15,
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2252
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = 985,
  bnd_logo_top = 110,
  bnd_logo_bottom = 0
}
EuroCupInfo = {
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_eurocup_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_home_team_crest = {
    name = "$EuroCupCrest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$EuroCupCrest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "UEFA EURO GERMANY",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "Stadium",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID11"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = -100,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local UsaOpenCupInfo = {
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_usaopencup_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "U.S.A OPEN CUP",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "Stadium",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = -100,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}
local CopaDelReyInfo = {
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_copadelrey_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "Estadio",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo1",
    id = 0
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = -100,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}

local CoppaItaliaInfo = { 
  bnd_forceCaps = true,
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_coppaitalia_match_hub"
  },
  bnd_match_info_alignH = "CENTER",
  bnd_match_info_right = 0,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20000000000,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -335,
  bnd_home_team_name_top = 160,
  bnd_team_name_size = 35,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 355,
  bnd_away_team_name_top = 160,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 335,
  bnd_home_team_crest_bottom = 5,
  bnd_team_crest_width = 170,
  bnd_team_crest_height = 170,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -355,
  bnd_away_team_crest_bottom = 5,
  bnd_match_type = "",
  bnd_match_type_top = -180,
  bnd_match_type_left = 10,
  bnd_match_vs = "",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = -10,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo1",
    id = 0
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_width = 120,
  bnd_logo_height = 110,
  bnd_logo_left = 60,
  bnd_logo_right = 0,
  bnd_logo_top = 30,
  bnd_logo_bottom = 0
}

local DfbPokalInfo = {
  bnd_forceCaps = true,
  bnd_home_openAnim = {
    name = "$Background_Intro_CupID16",
    id = 0
  },
  bnd_home_openAnim_height = 640,
  bnd_home_openAnim_width = 1350,
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$StadiumBackground",
    id = 0
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 250,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = -150,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "Loading . . . . . . .",
  bnd_loading_text_left = 60,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -655,
  bnd_home_team_name_top = 160,
  bnd_home_team_name_fontColor = "0x000000",
  bnd_team_name_size = 30,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -210,
  bnd_away_team_name_top = 160,
  bnd_away_team_name_fontColor = "0x000000",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 650,
  bnd_home_team_crest_bottom = 25,
  bnd_team_crest_width = 180,
  bnd_team_crest_height = 180,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = 200,
  bnd_away_team_crest_bottom = 25,
  bnd_match_type = "",
  bnd_match_type_top = 285,
  bnd_match_type_left = -840,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_type_size = 18,
  bnd_match_vs = "",
  bnd_match_vs_bottom = 120,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 5,
  bnd_match_stadium_bottom = -200,
  bnd_match_stadium_right = 430,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_size = 20,
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID17_1"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = 640,
  bnd_logo_top = 110,
  bnd_logo_bottom = 0
}
local ClassicCupInfo = {
   bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpandes", 
  bnd_home_openAnim = {
    name = "$IconMatchRevealClassic",
    id = 0
  },
  bnd_home_openAnim_left = -310,
  bnd_home_openAnim_bottom = -200,
  bnd_home_openAnim_width = 790,
  bnd_home_openAnim_height = 320,
  bnd_shadow_visible = false,
  bnd_icon = {
    name = "$IconClassic",
    id = 0
  },
  bnd_icon_left = 30,
  bnd_icon_top = -30,
  bnd_icon_width = 400,
  bnd_icon_height = 150,  
  bnd_home_stadium_bg = {
    name = "$StadiumBackground",
    id = 0
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 400,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = -1900000000,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 90,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -600,
  bnd_home_team_name_top = 80,
  bnd_team_name_size = 0,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -240,
  bnd_away_team_name_top = 80,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 888,
  bnd_home_team_crest_bottom = -250,
  bnd_team_crest_width = 50,
  bnd_team_crest_height = 50,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = 830,
  bnd_away_team_crest_bottom = -250,
  bnd_match_type = "STADIUM",
  bnd_match_type_top = 160,
  bnd_match_type_left = -868,
  bnd_match_type_fontColor = "0x000000",
  bnd_match_type_size = 14,
  bnd_match_vs = "",
  bnd_match_vs_bottom = 120,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 5,
  bnd_match_stadium_bottom = -160,
  bnd_match_stadium_right = 863,
  bnd_stadium_textAlignH = "LEFT",
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_size = 14,
  bnd_stadium_title = "",
  bnd_stadium_autoScroll = true,
  bnd_stadium_width = 90,
  bnd_stadium_title_fontColor = "0x000000",
  bnd_stadium_title_size = 14,
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID18"
  },
  bnd_logo_alignV = "BOTTOM",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 35,
  bnd_logo_height = 35,
  bnd_logo_left = 0,
  bnd_logo_right = 1335,
  bnd_logo_top = 0,
  bnd_logo_bottom = 190,
  
  bnd_logo2 = {
    name = "$SimMatchIcon4Off",
    id = 0
  },
  bnd_logo2_alignV = "TOP",
  bnd_logo2_alignH = "LEFT",
  bnd_logo2_width = 45,
  bnd_logo2_height = 45,
  bnd_logo2_left = 1135,
  bnd_logo2_right = 0,
  bnd_logo2_top = 570,
  bnd_logo2_bottom = 0,

  bnd_live_logo = {
    name = "$LiveLogo",
    id = 0
  },  
  bnd_title_text = "Loading.......",
  bnd_title_text_left = 230,
  bnd_title_text_top = 270,
}

local CoupeDeFranceInfo = {
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_CoupeDeFrance_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_home_team_name_fontColor = "0x071A31",
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_away_team_name_fontColor = "0x071A31",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "Coupe De France",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0x071A31",
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_vs_fontColor = "0x071A31",
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0x071A31",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = -100,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}
local FcwcInfo = {
  bnd_forceCaps = true,
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$bg_fcwc_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 300,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_home_team_name_fontColor = "0xFFFFFF",
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_away_team_name_fontColor = "0xFFFFFF",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0xFFFFFF",
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_fontColor = "0xFFFFFF",
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xFFFFFF",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID18"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_left = 90,
  bnd_logo_right = 0,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}
local LibertadoresInfo = {
  bnd_forceCaps = true,
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$bg_libertadores_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 80,
  bnd_loadingIcon_height = 80,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_home_team_name_fontColor = "0x000000",
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_away_team_name_fontColor = "0x000000",
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0x000000",
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_fontColor = "0x000000",
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_title = "Stadium",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID19"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = 70,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}
local UefaNationsInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_shadow_visible = true,
  bnd_home_stadium_bg = {
    name = "$bg_uefanations_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 595,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 2111110,
  bnd_loadingIcon_width = 0,
  bnd_loadingIcon_height = 0,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -130,
  bnd_home_team_name_top = 100,
  bnd_home_team_name_fontColor = "0x000000",
  bnd_team_name_size = 15,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 130,
  bnd_away_team_name_top = 100,
  bnd_away_team_name_fontColor = "0x000000",
  bnd_home_team_crest = {
    name = "$NationalCrest",
    id = 0
  },
  bnd_home_team_crest_right = 130,
  bnd_home_team_crest_bottom = 20,
  bnd_team_crest_width = 150,
  bnd_team_crest_height = 145,
  bnd_away_team_crest = {
    name = "$NationalCrest",
    id = 0
  },
  bnd_away_team_crest_right = -130,
  bnd_away_team_crest_bottom = 20,
  bnd_match_type = "",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0x000000",
  bnd_match_vs = "",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_fontColor = "0x000000",
  bnd_match_vs_size = 28,
  bnd_match_stadium_bottom = -210,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID21"
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = 70,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}
local CopaAmericaInfo = {
  bnd_shadow_visible = false,
  bnd_home_stadium_bg = {
    name = "$bg_CopaAmerica_match_hub"
  },
  bnd_match_info_alignH = "LEFT",
  bnd_match_info_right = 0,
  bnd_match_info_left = 350,
  bnd_loadingIcon_right = 0,
  bnd_loadingIcon_bottom = 20,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 0,
  bnd_loading_text_top = 0,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -120,
  bnd_home_team_name_top = 30,
  bnd_home_team_name_fontColor = "0xffffff",
  bnd_team_name_size = 25,
  bnd_away_team_name = "",
  bnd_away_team_name_left = 120,
  bnd_away_team_name_top = 30,
  bnd_away_team_name_fontColor = "0xffffff",
  bnd_home_team_crest = {
    name = "$CopaAmerikaCrest",
    id = 0
  },
  bnd_home_team_crest_right = 120,
  bnd_home_team_crest_bottom = 80,
  bnd_team_crest_width = 128,
  bnd_team_crest_height = 128,
  bnd_away_team_crest = {
    name = "$CopaAmerikaCrest",
    id = 0
  },
  bnd_away_team_crest_right = -120,
  bnd_away_team_crest_bottom = 80,
  bnd_match_type = "Copa America",
  bnd_match_type_top = -230,
  bnd_match_type_left = 0,
  bnd_match_type_fontColor = "0xffffff",
  bnd_match_vs = "VS",
  bnd_match_vs_bottom = 80,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 28,
  bnd_match_vs_fontColor = "0xffffff",
  bnd_match_stadium_bottom = -140,
  bnd_match_stadium_right = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_title = "",
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 76,
  bnd_logo_height = 80,
  bnd_logo_left = 0,
  bnd_logo_right = -100,
  bnd_logo_top = 50,
  bnd_logo_bottom = 0
}
local AseanChampionshipInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpandes", 
  bnd_home_openAnim = {
    name = "$IconMatchReveal",
    id = 0
  },
  bnd_home_openAnim_left = -310,
  bnd_home_openAnim_bottom = -200,
  bnd_home_openAnim_width = 790,
  bnd_home_openAnim_height = 320,
  bnd_shadow_visible = false,
  bnd_icon = {
    name = "$Icon",
    id = 0
  },
  bnd_icon_left = 30,
  bnd_icon_top = -30,
  bnd_icon_width = 400,
  bnd_icon_height = 150,  
  bnd_home_stadium_bg = {
    name = "$StadiumBackground",
    id = 0
  },
  bnd_match_info_alignH = "RIGHT",
  bnd_match_info_right = 400,
  bnd_match_info_left = 0,
  bnd_loadingIcon_right = -1900000000,
  bnd_loadingIcon_bottom = 10,
  bnd_loadingIcon_width = 40,
  bnd_loadingIcon_height = 40,
  bnd_loading_text = "",
  bnd_loading_text_left = 90,
  bnd_loading_text_top = 290,
  bnd_home_team_name = "",
  bnd_home_team_name_left = -600,
  bnd_home_team_name_top = 80,
  bnd_team_name_size = 0,
  bnd_away_team_name = "",
  bnd_away_team_name_left = -240,
  bnd_away_team_name_top = 80,
  bnd_home_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_home_team_crest_right = 888,
  bnd_home_team_crest_bottom = -250,
  bnd_team_crest_width = 50,
  bnd_team_crest_height = 50,
  bnd_away_team_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_away_team_crest_right = 830,
  bnd_away_team_crest_bottom = -250,
  bnd_match_type = "STADIUM",
  bnd_match_type_top = 160,
  bnd_match_type_left = -868,
  bnd_match_type_fontColor = "0x000000",
  bnd_match_type_size = 14,
  bnd_match_vs = "",
  bnd_match_vs_bottom = 120,
  bnd_match_vs_right = 0,
  bnd_match_vs_size = 5,
  bnd_match_stadium_bottom = -160,
  bnd_match_stadium_right = 863,
  bnd_stadium_textAlignH = "LEFT",
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_size = 14,
  bnd_stadium_title = "",
  bnd_stadium_autoScroll = true,
  bnd_stadium_width = 90,
  bnd_stadium_title_fontColor = "0x000000",
  bnd_stadium_title_size = 14,
  bnd_stadium = "",

  bnd_logo = {
    name = "$LeagueLogo",
    id = 27
  },
  bnd_logo_alignV = "BOTTOM",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_width = 35,
  bnd_logo_height = 35,
  bnd_logo_left = 0,
  bnd_logo_right = 1335,
  bnd_logo_top = 0,
  bnd_logo_bottom = 190,
  
  bnd_logo2 = {
    name = "$SimMatchIcon4",
    id = 0
  },
  bnd_logo2_alignV = "TOP",
  bnd_logo2_alignH = "LEFT",
  bnd_logo2_width = 45,
  bnd_logo2_height = 45,
  bnd_logo2_left = 1135,
  bnd_logo2_right = 0,
  bnd_logo2_top = 570,
  bnd_logo2_bottom = 0,

  bnd_live_logo = {
    name = "$LiveLogo",
    id = 0
  },  
  bnd_title_text = "Hold for Full Match Intro",
  bnd_title_text_left = 230,
  bnd_title_text_top = 270,
}
function RealMatchReveal:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    matchInfo = o.api("MatchInfoService"),
    userPlate = o.api("UserPlateService"),
    settingsService = o.api("SettingsService"),
    gameSetupService = o.api("GameSetupService"),
    gameStateService = o.api("GameStateService"),
    EventManService = o.api("EventManagerService"),
    socialService = o.api("SocialService"),
    TeamService = o.api("TeamService"),
    SquadManagementService = o.api("SquadMgtService")
  }

  weatherRandom = currentMatchWeather
  if currentMatchWeather == 1 then
    weatherRandom = math.random(2, 8)
  end
  
  
  o.currentdata = nil

  AlgeriaTeams = o.services.TeamService.GetTeams(leagueIDs.Algeria, 0, 0, true)
  AfcTeams = o.services.TeamService.GetTeams(leagueIDs.Afc, 0, 0, true)
  ArgentinaTeams = o.services.TeamService.GetTeams(leagueIDs.Argentina, 0, 0, true)
  AsianCupU23Teams = o.services.TeamService.GetTeams(leagueIDs.AsianCupU23, 0, 0, true)
  BelgiumTeams = o.services.TeamService.GetTeams(leagueIDs.Belgium, 0, 0, true)
  BrazilTeams = o.services.TeamService.GetTeams(leagueIDs.Brazil, 0, 0, true)
  ClassicTeams = o.services.TeamService.GetTeams(leagueIDs.Classic, 0, 0, true)
  Classic2Teams = o.services.TeamService.GetTeams(leagueIDs.Classic2, 0, 0, true)
  ChampionshipEflTeams = o.services.TeamService.GetTeams(leagueIDs.ChampionshipEfl, 0, 0, true)
  ColombiaTeams = o.services.TeamService.GetTeams(leagueIDs.Colombia, 0, 0, true)
  CroatiaTeams = o.services.TeamService.GetTeams(leagueIDs.Croatia, 0, 0, true)
  CzechRepublicTeams = o.services.TeamService.GetTeams(leagueIDs.CzechRepublic, 0, 0, true)
  D1ArkemaTeams = o.services.TeamService.GetTeams(leagueIDs.D1Arkema, 0, 0, true)
  DenmarkTeams = o.services.TeamService.GetTeams(leagueIDs.Denmark, 0, 0, true)
  EcuadorTeams = o.services.TeamService.GetTeams(leagueIDs.Ecuador, 0, 0, true)
  EgyptTeams = o.services.TeamService.GetTeams(leagueIDs.Egypt, 0, 0, true)
  EnglandTeams = o.services.TeamService.GetTeams(leagueIDs.England, 0, 0, true)
  FranceTeams = o.services.TeamService.GetTeams(leagueIDs.France, 0, 0, true)
  France2Teams = o.services.TeamService.GetTeams(leagueIDs.France2, 0, 0, true)
  GermanyTeams = o.services.TeamService.GetTeams(leagueIDs.Germany, 0, 0, true)
  Germany2Teams = o.services.TeamService.GetTeams(leagueIDs.Germany2, 0, 0, true)
  IndonesiaTeams = o.services.TeamService.GetTeams(leagueIDs.Indonesia, 0, 0, true)
  InternationalTeams = o.services.TeamService.GetTeams(leagueIDs.International, 0, 0, true)
  International2Teams = o.services.TeamService.GetTeams(leagueIDs.International2, 0, 0, true)
  ItalyTeams = o.services.TeamService.GetTeams(leagueIDs.Italy, 0, 0, true)
  JapanTeams = o.services.TeamService.GetTeams(leagueIDs.Japan, 0, 0, true)
  KoreaRepublicTeams = o.services.TeamService.GetTeams(leagueIDs.KoreaRepublic, 0, 0, true)
  LeagueOneEflTeams = o.services.TeamService.GetTeams(leagueIDs.LeagueOneEfl, 0, 0, true)
  LigaFTeams = o.services.TeamService.GetTeams(leagueIDs.LigaF, 0, 0, true)
  MalaysiaTeams = o.services.TeamService.GetTeams(leagueIDs.Malaysia, 0, 0, true)
  MexicoTeams = o.services.TeamService.GetTeams(leagueIDs.Mexico, 0, 0, true)
  MoroccoTeams = o.services.TeamService.GetTeams(leagueIDs.Morocco, 0, 0, true)
  NetherlandsTeams = o.services.TeamService.GetTeams(leagueIDs.Netherlands, 0, 0, true)
  PortugalTeams = o.services.TeamService.GetTeams(leagueIDs.Portugal, 0, 0, true)
  PegadaianLiga2Teams = o.services.TeamService.GetTeams(leagueIDs.PegadaianLiga2, 0, 0, true)
  RestOfWorldTeams = o.services.TeamService.GetTeams(leagueIDs.RestOfWorld, 0, 0, true)
  RestOfWorld2Teams = o.services.TeamService.GetTeams(leagueIDs.RestOfWorld2, 0, 0, true)
  RusiaTeams = o.services.TeamService.GetTeams(leagueIDs.Rusia, 0, 0, true)
  SaudiArabiaTeams = o.services.TeamService.GetTeams(leagueIDs.SaudiArabia, 0, 0, true)
  ScotlandTeams = o.services.TeamService.GetTeams(leagueIDs.Scotland, 0, 0, true)
  SouthAfricaTeams = o.services.TeamService.GetTeams(leagueIDs.SouthAfrica, 0, 0, true)
  SpainTeams = o.services.TeamService.GetTeams(leagueIDs.Spain, 0, 0, true)
  Spain2Teams = o.services.TeamService.GetTeams(leagueIDs.Spain2, 0, 0, true)
  SwitzerlandTeams = o.services.TeamService.GetTeams(leagueIDs.Switzerland, 0, 0, true)
  ThailandTeams = o.services.TeamService.GetTeams(leagueIDs.Thailand, 0, 0, true)
  TurkeyTeams = o.services.TeamService.GetTeams(leagueIDs.Turkey, 0, 0, true)
  UefaTeams = o.services.TeamService.GetTeams(leagueIDs.Uefa, 0, 0, true)
  UefaUelTeams = o.services.TeamService.GetTeams(leagueIDs.UefaUel, 0, 0, true)
  UefaWomensTeams = o.services.TeamService.GetTeams(leagueIDs.UefaWomens, 0, 0, true)
  UkraineTeams = o.services.TeamService.GetTeams(leagueIDs.Ukraine, 0, 0, true)
  UnitedStatesTeams = o.services.TeamService.GetTeams(leagueIDs.UnitedStates, 0, 0, true)
  USANWSLTeams = o.services.TeamService.GetTeams(leagueIDs.USANWSL, 0, 0, true)
  VanaramaFootballLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.VanaramaFootballLeague, 0, 0, true)
  VietnamTeams = o.services.TeamService.GetTeams(leagueIDs.Vietnam, 0, 0, true)
  WomensSuperLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.WomensSuperLeague, 0, 0, true)

  o.currentOptions = o.services.settingsService.GetCurrentOptions()
  o.TeamsData = o.services.matchInfo.GetMatchTeams()

  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      o.currentdata = UCLInfo
      o.currentdata.bnd_match_type = "Match Day"
     elseif currentCupData.cupIndex == 2 then
      o.currentdata = WorldCupInfo
     elseif currentCupData.cupIndex == 3 then
      o.currentdata = UefaUelInfo
     elseif currentCupData.cupIndex == 4 then
      o.currentdata = PialaIndonesiaInfo
      o.currentdata.bnd_match_type = "Piala Indonesia "
      elseif currentCupData.cupIndex == 5 then
      o.currentdata = WcWomenInfo
      elseif currentCupData.cupIndex == 6 then
      o.currentdata = UclWomenInfo
      o.currentdata.bnd_match_type = "UEFA Women's Champions League"
      elseif currentCupData.cupIndex == 7 then
      o.currentdata = FaCupInfo
      elseif currentCupData.cupIndex == 8 then
      o.currentdata = UeclInfo
      elseif currentCupData.cupIndex == 9 then
      o.currentdata = AsianCupInfo
      elseif currentCupData.cupIndex == 10 then
      o.currentdata = KingSaudiCupInfo
      elseif currentCupData.cupIndex == 11 then
      o.currentdata = EuroCupInfo
      elseif currentCupData.cupIndex == 12 then
      o.currentdata = UsaOpenCupInfo
      elseif currentCupData.cupIndex == 13 then
      o.currentdata = CopaAmericaInfo
      elseif currentCupData.cupIndex == 14 then
      o.currentdata = CopaDelReyInfo
      o.currentdata.bnd_match_type = "Copa De Espana"
      elseif currentCupData.cupIndex == 15 then
      o.currentdata = CoppaItaliaInfo
      o.currentdata.bnd_match_type = "COPPA ITALIA"
      elseif currentCupData.cupIndex == 16 then
      o.currentdata = DfbPokalInfo
      elseif currentCupData.cupIndex == 17 then
      o.currentdata = CoupeDeFranceInfo
      elseif currentCupData.cupIndex == 18 then
      o.currentdata = FcwcInfo
      o.currentdata.bnd_match_type = "FIFA Club World Cup"
      elseif currentCupData.cupIndex == 19 then
      o.currentdata = LibertadoresInfo
      o.currentdata.bnd_match_type = "Libertadores"
      elseif currentCupData.cupIndex == 20 then
      o.currentdata = UefaNationsInfo
    end
  elseif currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      o.currentdata = UCLInfo
      o.currentdata.bnd_match_type = "Match Day"
     elseif currentTourData.tourIndex == 2 then
      o.currentdata = WorldCupInfo
     elseif currentTourData.tourIndex == 3 then
      o.currentdata = UefaUelInfo
     elseif currentTourData.tourIndex == 29 then
      o.currentdata = PialaIndonesiaInfo
     elseif currentTourData.tourIndex == 26 then
      o.currentdata = EAFCInfo     
      o.currentdata.bnd_logo.id = 26
      o.currentdata.bnd_logo_top = 517                 
     elseif currentTourData.tourIndex == 27 then
      o.currentdata = AseanChampionshipInfo      
      elseif currentTourData.tourIndex == 35 then
      o.currentdata = WcWomenInfo
      elseif currentTourData.tourIndex == 16 then
      o.currentdata = UclWomenInfo      
      o.currentdata.bnd_match_type = "UEFA Women's Champions League"
      elseif currentTourData.tourIndex == 9 then
      o.currentdata = FaCupInfo
      elseif currentTourData.tourIndex == 17 then
      o.currentdata = UeclInfo
      elseif currentTourData.tourIndex == 34 then
      o.currentdata = AsianCupInfo
      elseif currentTourData.tourIndex == 50 then
      o.currentdata = KingSaudiCupInfo
      elseif currentTourData.tourIndex == 6 then
      o.currentdata = EuroCupInfo
      elseif currentTourData.tourIndex == 13 then
      o.currentdata = UsaOpenCupInfo
      elseif currentTourData.tourIndex == 25 then
      o.currentdata = CopaAmericaInfo
      elseif currentTourData.tourIndex == 10 then
      o.currentdata = CopaDelReyInfo
      o.currentdata.bnd_match_type = "Copa De Espana"
      elseif currentTourData.tourIndex == 11 then
      o.currentdata = CoppaItaliaInfo
      o.currentdata.bnd_match_type = "COPPA ITALIA"
      elseif currentTourData.tourIndex == 7 then
      o.currentdata = DfbPokalInfo
      elseif currentTourData.tourIndex == 18 then
      o.currentdata = CoupeDeFranceInfo
      elseif currentTourData.tourIndex == 15 then
      o.currentdata = FcwcInfo
      o.currentdata.bnd_match_type = "FIFA Club World Cup"
      elseif currentTourData.tourIndex == 4 then
      o.currentdata = LibertadoresInfo
      o.currentdata.bnd_match_type = "Libertadores"
      elseif currentTourData.tourIndex == 22 then
      o.currentdata = ClassicCupInfo
      o.currentdata.bnd_logo.id = 1245
      o.currentdata.bnd_logo_top = 517          
      elseif currentTourData.tourIndex == 28 then
      o.currentdata = UefaNationsInfo
      elseif currentTourData.tourIndex == 24 then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "CupID24"
      o.currentdata.bnd_logo_top = 517
      elseif currentTourData.tourIndex == 31 then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "CupID31"
      o.currentdata.bnd_logo_top = 517         
      elseif currentTourData.tourIndex == 50 then
      o.currentdata = KingSaudiCupInfo 
      elseif currentTourData.tourIndex == 21 then
      o.currentdata = EAFCInfo      
      o.currentdata.bnd_logo.id = "CupID21"
      o.currentdata.bnd_logo_top = 517      
    else 
      o.currentdata = EAFCInfo    
    end    
  else
    o.currentdata = EAFCInfo
    if o:isInTable(o.TeamsData[1], AfcTeams) and o:isInTable(o.TeamsData[2], AfcTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "CupID9_1"
      o.currentdata.bnd_logo_top = 517
  elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 353
      o.currentdata.bnd_logo_top = 517
   elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 4
      o.currentdata.bnd_logo_top = 517
   elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 7
      o.currentdata.bnd_logo_top = 517
   elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
      o.currentdata = ClassicCupInfo
      o.currentdata.bnd_logo.id = 1245
      o.currentdata.bnd_logo_top = 517
   elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 1245
      o.currentdata.bnd_logo_top = 517
   elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 14
      o.currentdata.bnd_logo_top = 517
   elseif o:isInTable(o.TeamsData[1], ColombiaTeams) and o:isInTable(o.TeamsData[2], ColombiaTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 336
   elseif o:isInTable(o.TeamsData[1], CroatiaTeams) and o:isInTable(o.TeamsData[2], CroatiaTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 317
   elseif o:isInTable(o.TeamsData[1], CzechRepublicTeams) and o:isInTable(o.TeamsData[2], CzechRepublicTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 319
   elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2218
   elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 1
    elseif o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 2018
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2231
      o.currentdata.bnd_logo_top = 517
     elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "13_1"
      o.currentdata.bnd_logo_top = 517
      o.currentdata.bnd_live_logo.id = 1   
      elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "16_1"
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "17_1"
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 19
      o.currentdata.bnd_logo_top = 517
      o.currentdata.bnd_live_logo.id = 4            
      elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 20
      o.currentdata.bnd_logo_top = 517
      o.currentdata.bnd_live_logo.id = 4      
      elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "2235_1"
      o.currentdata.bnd_logo_top = 517
      o.currentdata.bnd_live_logo.id = 8            
      elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 78
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2136
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "31_1"
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 349
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 83
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 60
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2222
      elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2237
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "341_1"
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2250
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 10
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "308_1"
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2254
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 76
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 76
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], RusiaTeams) and o:isInTable(o.TeamsData[2], RusiaTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 67
      elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_live_logo.id = 605
      elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 50
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 347
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "53_1"
      o.currentdata.bnd_logo_top = 517
      o.currentdata.bnd_live_logo.id = 2      
      elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "54_1"
      o.currentdata.bnd_logo_top = 517
      o.currentdata.bnd_live_logo.id = 2            
      elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 189
      elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
      o.currentdata = ThailandInfo
      elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 68
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "2236_1"
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "2238_1"
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = "2240_1"
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], UkraineTeams) and o:isInTable(o.TeamsData[2], UkraineTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 332
     elseif o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 39
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USANWSLTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2221
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], VanaramaFootballLeagueTeams) and o:isInTable(o.TeamsData[2], VanaramaFootballLeagueTeams) then
      o.currentdata = DenmarkInfo
      o.currentdata.bnd_logo.id = 62
      elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2260
      o.currentdata.bnd_logo_top = 517
      elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_logo.id = 2216
      o.currentdata.bnd_logo_top = 517
    else 
      o.currentdata.bnd_match_type = "STADIUM"
    end
  end

  o.currentdata.bnd_stadium = o.currentOptions.stadium
  o.currentdata.bnd_home_team_crest.id = o.TeamsData[1].assetId
  o.currentdata.bnd_away_team_crest.id = o.TeamsData[2].assetId
  o.currentdata.bnd_home_team_name = o.TeamsData[1].teamName
  o.currentdata.bnd_away_team_name = o.TeamsData[2].teamName
  o.currentdata.bnd_home_stadium_bg.id = o:GetStadiumID()

  local controllerId = o.services.gameStateService.GetPreferedControllerId()
  o.customizationOptions = o.services.settingsService.GetCustomizationOptions(controllerId)
  o:initCameraData(o.customizationOptions[6].data)

  homeTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(0, o.TeamsData[1].assetId, 0)
  awayTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(1, o.TeamsData[2].assetId, 0)

  for k,v in pairs(o.currentdata) do
    o.im.Subscribe(k, function()
      o.im.Publish(k, v)
    end)
  end
  
  
  return o
end

function RealMatchReveal:initCameraData(cameraData)
  cameraIndex = cameraData.currentValue
end


function RealMatchReveal:GetStadiumID()
  if self.currentOptions.stadium == "Old Trafford" then -- Manchester United 
    return 1
   elseif self.currentOptions.stadium == "Santiago Bernabéu" then -- Real Madrid 
    return 2
   elseif self.currentOptions.stadium == "Diego Armando Maradona Stadium" then -- Napoli
    return 4
   elseif self.currentOptions.stadium == "San Siro" then -- Ac Milan
    return 5
    elseif self.currentOptions.stadium == "Camp Nou" then -- Barcelona 
    return 6
    elseif self.currentOptions.stadium == "Signal Iduna Park" then -- Borussia Dortmund 
    return 9
    elseif self.currentOptions.stadium == "Estadio Mestalla" then -- Valencia 
    return 10
    elseif self.currentOptions.stadium == "Anfield" then -- Liverpool 
    return 13
    elseif self.currentOptions.stadium == "Parc des Princes" then -- PSG
    return 14
    elseif self.currentOptions.stadium == "Amsterdam Arena" then -- Ajax Amsterdam 
    return 15
    elseif self.currentOptions.stadium == "Louis II Stadium" then -- As Monaco 
    return 26
    elseif self.currentOptions.stadium == "Stamford Bridge" then -- Chelsea 
    return 28
    elseif self.currentOptions.stadium == "Gelora Bung Karno" then -- Timnas Indonesia 
    return 29
    elseif self.currentOptions.stadium == "King Abdullah Sports City" then -- Ittihad 
    return 30
    elseif self.currentOptions.stadium == "Olimpiade London" then -- West Ham 
    return 32
    elseif self.currentOptions.stadium == "Union Park Stadium" then  
    return 33
    elseif self.currentOptions.stadium == "Estádio da Luz" then -- SL Benfica 
    return 34
    elseif self.currentOptions.stadium == "Ramón Sánchez Pizjuán" then -- Sevilla
    return 35
    elseif self.currentOptions.stadium == "Gtech Community Stadium" then -- Brentford Fc
    return 41
    elseif self.currentOptions.stadium == "BayArena" then -- Leverkusen 
    return 42
    elseif self.currentOptions.stadium == "Jakarta International Stadium" then -- Persija 
    return 100
    elseif self.currentOptions.stadium == "Estadio Azteca" then -- Timnas Meksiko 
    return 104
    elseif self.currentOptions.stadium == "Stadio Gewiss" then -- Atalanta 
    return 113
    elseif self.currentOptions.stadium == "King Power Stadium" then -- Leicester city 
    return 115
    elseif self.currentOptions.stadium == "White Hart Lane" then -- Tottenham Hotspurs 
    return 116
    elseif self.currentOptions.stadium == "Bukit Jalil National Stadium" then -- Timnas Malaysia 
    return 135
    elseif self.currentOptions.stadium == "Allianz Arena" then -- Bayer Munchen 
    return 137
    elseif self.currentOptions.stadium == "Beijing National Stadium" then -- Timnas China
    return 147
    elseif self.currentOptions.stadium == "Olympiastadion" then -- Hertha BSC
    return 149
    elseif self.currentOptions.stadium == "Atatürk Olympic Stadium" then -- Turkey & Galatasaray 
    return 153
    elseif self.currentOptions.stadium == "Wembley Stadium" then -- Timnas England 
    return 155
    elseif self.currentOptions.stadium == "Emirates Stadium" then -- Arsenal 
    return 156
    elseif self.currentOptions.stadium == "Stadio Olimpico" then
    return 157
    elseif self.currentOptions.stadium == "estádio do morumbi" then -- Brazil & San Paulo 
    return 158
    elseif self.currentOptions.stadium == "Estádio do Dragão" then
    return 172
    elseif self.currentOptions.stadium == "Craven Cottage" then -- Fulham
    return 174
    elseif self.currentOptions.stadium == "Akyazi Arena Stadium" then -- Tranzonspor
    return 175
    elseif self.currentOptions.stadium == "Waldstadion" then
    return 176
    elseif self.currentOptions.stadium == "Selhurst Park" then -- Crystal Palace
    return 177
    elseif self.currentOptions.stadium == "Giuseppe Meazza" then -- Inter Milan 
    return 178
    elseif self.currentOptions.stadium == "St. James' Park" then -- Newcastle 
    return 179
    elseif self.currentOptions.stadium == "Ivy Lane" then
    return 180
    elseif self.currentOptions.stadium == "Stade Velodrome" then -- Olympique Marseille 
    return 181
    elseif self.currentOptions.stadium == "Vitality Stadium" then -- AFC Bournemouth 
    return 182
    elseif self.currentOptions.stadium == "Civitas Metropolitano" then -- Atletico Madrid 
    return 183
    elseif self.currentOptions.stadium == "Stadium Australia" then -- Australia 
    return 192
    elseif self.currentOptions.stadium == "Red Bull Arena" then -- RB Leipzig 
    return 193
    elseif self.currentOptions.stadium == "Mercedez-Benz Stadium" then -- Atalanta BC
    return 194
    elseif self.currentOptions.stadium == "Stadion Olympik" then 
    return 195
    elseif self.currentOptions.stadium == "Mrsool Park Stadium" then -- Al Nasr 
    return 196
    elseif self.currentOptions.stadium == "DRV PNK Stadium" then -- Inter Miami
    return 197
    elseif self.currentOptions.stadium == "Estadio Benito Villamarin" then -- Real Betis
    return 211
    elseif self.currentOptions.stadium == "The Amex Stadium" then -- Brighton 
    return 212
    elseif self.currentOptions.stadium == "Villa Park" then -- Aston Villa 
    return 225
    elseif self.currentOptions.stadium == "Elland Road" then -- Leeds United 
    return 228
    elseif self.currentOptions.stadium == "Khalifa Internasional Stadium" then -- National Qatar
    return 229
    elseif self.currentOptions.stadium == "Etihad Stadium" then -- Manchester City 
    return 246
    elseif self.currentOptions.stadium == "Juventus Stadium" then -- Juventus 
    return 247
    elseif self.currentOptions.stadium == "Bc Place Stadium" then 
    return 248
    elseif self.currentOptions.stadium == "Molton Road" then 
    return 249
    elseif self.currentOptions.stadium == "Stadion Maracanã" then -- Fluminense & Flamengo 
    return 260
    elseif self.currentOptions.stadium == "Groupama Stadium" then -- Olympique Lyonnais 
    return 261
    elseif self.currentOptions.stadium == "King Fahd Stadium" then -- Al Hilal & Al Shabaab 
    return 262
    elseif self.currentOptions.stadium == "La Bombonera" then -- Boca Junior & Timnas Argentina 
    return 264
    elseif self.currentOptions.stadium == "Goodison Park" then -- Everton 
    return 265
    elseif self.currentOptions.stadium == "Carrow Road" then -- Norwich City 
    return 276
    elseif self.currentOptions.stadium == "City Ground" then -- Nottingham Forest 
    return 325
    elseif self.currentOptions.stadium == "Stadion Molineux" then -- Wolverhampton Wanderers 
    return 326
    elseif self.currentOptions.stadium == "Estadio Casablanca" then -- LDU Quito & Ecuador 
    return 327
    elseif self.currentOptions.stadium == "Turf Moor" then -- Burnley 
    return 329
    elseif self.currentOptions.stadium == "Stadion St Mary's" then -- Southampton 
    return 330
    elseif self.currentOptions.stadium == "Stadion An Der Alten Försterei" then -- Union Berlin 
    return 331
    elseif self.currentOptions.stadium == "Veltins Arena" then -- Fc Schalke 04
    return 332
    elseif self.currentOptions.stadium == "Bramall Lane" then -- Sheffield United 
    return 333
    elseif self.currentOptions.stadium == "Gelora Bandung Lautan Api" then -- Persib Bandung
    return 178  
  else
    return 0
  end
end

function RealMatchReveal:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end



function RealMatchReveal:finalize()
  for k,v in pairs(EAFCInfo) do
    self.im.Unsubscribe(k)
  end
end
return RealMatchReveal
