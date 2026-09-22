-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

local MatchInfo = {}
local OverlaysIdContainer, OverlayParam, eventmanager, TableUtil = ...
local OVERLAY_TYPES = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

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
  LeagueTwoEfl = 61,
  LigaF = 2222,
  Malaysia = 2237,
  Mexico = 341,
  Morocco =  2250,
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
LeagueTwoEflTeams = nil
MalaysiaTeams = nil
MexicoTeams = nil
MoroccoTeams = nil
NetherlandsTeams = nil
PegadaianLiga2Teams = nil
PortugalTeams = nil
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
UnitedStatesTeams = nil
USANWSLTeams = nil
VanaramaFootballLeagueTeams = nil
VietnamTeams = nil
WomensSuperLeagueTeams = nil

EnglandTeamsData = {
  { teamid = 1, homeColor = "0xE32636", awayColor = "0x3B444B", homeFontColor = "0xE0E0E0", awayFontColor = "0xffffff" },
  { teamid = 2, homeColor = "0x48112D", awayColor = "0x5A718E",homeFontColor = "0x80a5ca", awayFontColor = "0x000000"},
  { teamid = 5, homeColor = "0x034694", awayColor = "0x9F968C",homeFontColor = "0xffffff", awayFontColor = "0x034694"},
  { teamid = 7, homeColor = "0x345283", awayColor = "0x3D414B",homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 8, homeColor = "0x2A427F" , awayColor = "0x5D343F",homeFontColor = "0xffffff" , awayFontColor = "0xffffff" },
  { teamid = 9, homeColor = "0x992B35", awayColor = "0x434544",homeFontColor = "0xE0E0E0", awayFontColor = "0xffffff"},
  { teamid = 10, homeColor = "0x6FA4D5", awayColor = "0x7C9143",homeFontColor = "0xFFFFFF", awayFontColor = "0xffffff"},
  { teamid = 11, homeColor = "0xB32134", awayColor = "0x2E3243",homeFontColor = "0xE0E0E0" , awayFontColor = "0xffffff"},
  { teamid = 13, homeColor = "0xffffff" , awayColor = "0x313550",homeFontColor = "0x282827", awayFontColor = "0xffffff"},
  { teamid = 14, homeColor = "0x9C1D38", awayColor = "0x474759",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 17, homeColor = "0xB72232" , awayColor = "0xA2964B",homeFontColor = "0xffffff" , awayFontColor = "0xffffff" },
  { teamid = 18, homeColor = "0xedecea", awayColor = "0x8491C1",homeFontColor = "0x152238", awayFontColor = "0x000000"},
  { teamid = 19, homeColor = "0x601936" , awayColor = "0x2C2C2A",homeFontColor = "0xffffff" , awayFontColor = "0xffffff" },
  { teamid = 94, homeColor = "0x2A427F" , awayColor = "0x5D343F",homeFontColor = "0xffffff" , awayFontColor = "0xffffff" },
  { teamid = 95, homeColor = "0x374779" , awayColor = "0x9D5861",homeFontColor = "0xffffff" , awayFontColor = "0xffffff" },
  { teamid = 106, homeColor = "0xAF313A" , awayColor = "0x5B5E72",homeFontColor = "0x000000" , awayFontColor = "0xffffff" },
  { teamid = 110, homeColor = "0xBC9231", awayColor = "0x5F5134",homeFontColor = "0x000000", awayFontColor = "0xffffff"},  
  { teamid = 144, homeColor = "0xE0E0E0" , awayColor = "0x000000",homeFontColor = "0x000000", awayFontColor = "0xffffff" },  
  { teamid = 1795, homeColor = "0x9E981D" , awayColor = "0x2D2E2D",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},  
  { teamid = 1794, homeColor = "0xCA3C42" , awayColor = "0x333535",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},  
  { teamid = 1796, homeColor = "0x6F1A53", awayColor = "0xA7A6A4",homeFontColor = "0x81B6CD", awayFontColor = "0xffffff"},
  { teamid = 1923, homeColor = "0xB23B2D", awayColor = "0x282625",homeFontColor = "0xE0E0E0", awayFontColor = "0xffffff"},  
  { teamid = 1806, homeColor = "0xBC7F81", awayColor = "0x20201F",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},  
  { teamid = 1807, homeColor = "0xc9c8c7", awayColor = "0xd3d188",homeFontColor = "0xd2d1d0", awayFontColor = "0xffffff"},  
  { teamid = 1799, homeColor = "0x354C80" , awayColor = "0xBA2529",homeFontColor = "0xA2373D", awayFontColor = "0x354C80" },
  { teamid = 1808, homeColor = "0x205da0" , awayColor = "0xfcba03",homeFontColor = "0xE0E0E0", awayFontColor = "0xffffff" }, 
  { teamid = 1943, homeColor = "0xae272f" , awayColor = "0x4682B4",homeFontColor = "0x000000", awayFontColor = "0x000000" },
  { teamid = 1925, homeColor = "0xb52328" , awayColor = "0xC59AAE",homeFontColor = "0xE0E0E0", awayFontColor = "0x000000" },
  { teamid = 1951, homeColor = "0xB1942A" , awayColor = "0x878677",homeFontColor = "0xE0E0E0", awayFontColor = "0xffffff" },
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
UnitedStatesTeamsData = {
  { teamid = 687, homeColor = "0xE5D01B", awayColor = "0x303130", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 688, homeColor = "0x333533", awayColor = "0xD3D3CD", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 689, homeColor = "0xC82B2D", awayColor = "0xCDCF8D", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 691, homeColor = "0x333948", awayColor = "0xC32425", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 693, homeColor = "0x303C50", awayColor = "0xffffff", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 694, homeColor = "0x532B30", awayColor = "0x95BBCD", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 695, homeColor = "0xC5334D", awayColor = "0xC8CCC0", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 696, homeColor = "0x98ACC8", awayColor = "0x2B3543", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 697, homeColor = "0xD0D4D0", awayColor = "0x354B4D", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 698, homeColor = "0xAB372B", awayColor = "0x3B3C3D", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 101112, homeColor = "0xD0D4D0", awayColor = "0x202C38", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 111065, homeColor = "0x702B35", awayColor = "0xBDAB5D", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 111138, homeColor = "0x2D2D2D", awayColor = "0x3B3C3D", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 111139, homeColor = "0x284988", awayColor = "0x989998", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 111140, homeColor = "0x204C3B", awayColor = "0xE3C5BB", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 111144, homeColor = "0x589440", awayColor = "0x552420", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 111651, homeColor = "0x5B676D", awayColor = "0xD0D1CD", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 111928, homeColor = "0x2D3F83", awayColor = "0x9DA1A0", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 112134, homeColor = "0x1D272D", awayColor = "0xC0BCA0", homeFontColor = "0x78C3C8", awayFontColor = "0xEBE205" },
  { teamid = 112606, homeColor = "0x403C88", awayColor = "0x9D9BAB", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 112828, homeColor = "0x6889A5", awayColor = "0xCD4B33", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 112885, homeColor = "0x7B2D38", awayColor = "0x9DC3AD", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 112893, homeColor = "0xC5A0B5", awayColor = "0x252725", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 112996, homeColor = "0x252725", awayColor = "0x909775", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 113149, homeColor = "0x2D4C8D", awayColor = "0xD35F38", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 114161, homeColor = "0x209448", awayColor = "0x9BC390", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 114162, homeColor = "0xD0CC45", awayColor = "0x252725", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
  { teamid = 114640, homeColor = "0x2893D3", awayColor = "0x383148", homeFontColor = "0x000000", awayFontColor = "0xEBE205" },
}
USANWSLTeamsData = {
	{ teamid = 116300, homeColor ="0x302A36" , awayColor ="0xE4E3E2",homeFontColor = "0xD0A569", awayFontColor ="0x46558C" },
	{ teamid = 116302, homeColor ="0xD45948" , awayColor ="0x4E5C67",homeFontColor = "0xDBD87D", awayFontColor ="0x000000" },
	{ teamid = 116303, homeColor ="0x4E5D99" , awayColor ="0xDD5F69",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 116304, homeColor ="0x434347" , awayColor ="0xDDD44C",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
}
VietnamTeamsData = {
	{ teamid = 150630, homeColor ="0x2A1A5F" , awayColor ="0xE1DE41",homeFontColor = "0xD9AE15", awayFontColor ="0x815CA3"},
	{ teamid = 150631, homeColor ="0x599BDA" , awayColor ="0x599BDA",homeFontColor = "0xffffff", awayFontColor ="0xfffffff"},
	{ teamid = 150632, homeColor ="0x1B263A" , awayColor ="0x0184A8",homeFontColor = "0xffffff", awayFontColor ="0xDEDB2D"},
	{ teamid = 150633, homeColor ="0xAB0D0D" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0xAB0D0D"},
	{ teamid = 150634, homeColor ="0xE3C824" , awayColor ="0xCC1313",homeFontColor = "0x000000", awayFontColor ="0xffffff"},
}
WomensSuperLeagueTeamsData = {
  { teamid = 116009, homeColor = "0xC51C26", awayColor = "0x000000", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 116010, homeColor = "0x1F2E66", awayColor = "0xE4D0B7", homeFontColor = "0xffffff", awayFontColor = "0xE75754" },
  { teamid = 116011, homeColor = "0xffffff", awayColor = "0x7484B7", homeFontColor = "0xCD1D35", awayFontColor = "0x000000" },
  { teamid = 116012, homeColor = "0xD01F37", awayColor = "0x2C3140", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 116013, homeColor = "0x1963AF", awayColor = "0xDC9D36", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 116014, homeColor = "0x722A3D", awayColor = "0x282827", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 116015, homeColor = "0x3E212A", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x3E212A" },
  { teamid = 116016, homeColor = "0x22457D", awayColor = "0x393E44", homeFontColor = "0xffffff", awayFontColor = "0xFFE565" },
  { teamid = 116017, homeColor = "0x6798C7", awayColor = "0x303142", homeFontColor = "0xffffff", awayFontColor = "0xA1B81D" },
  { teamid = 116020, homeColor = "0x34467C", awayColor = "0x242224", homeFontColor = "0xffffff", awayFontColor = "0xBC8C72" },
  { teamid = 116343, homeColor = "0x7F2531", awayColor = "0x3C3F3D", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 121725, homeColor = "0x194580", awayColor = "0xD8B61E", homeFontColor = "0xffffff", awayFontColor = "0x194580" }
}


UnitedStatesInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_background_show = true,
  bnd_background_height = 480,
  bnd_background_width = 902,
  bnd_background_top = 90,
  bnd_background_left = 260,
  bnd_background = {
    name = "$Background_Intro",
    id = 39
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 350,
  bnd_homelabel_left = -173,
  bnd_homelabel_top = 194,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 0,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 176,
  bnd_awaylabel_top = 194,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 0,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 410,
  bnd_crest_width = 420,
  bnd_crest_image_width = 180,
  bnd_crest_image_height = 180,
  bnd_homecrest_left = 35,
  bnd_homecrest_top = -220,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 100,
  bnd_awaycrest_top = -220,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 700,
  bnd_stadium_left = 290,
  bnd_stadium_top = 233,
  bnd_stadium_color = "0x313131",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  bnd_title_height = 0,
  bnd_title_width = 700,
  bnd_title_left = 325,
  bnd_title_top = 195,
  bnd_title_color = "0xffffff",
  bnd_title_text = "Live From",
  bnd_title_fontSize = 21,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 60,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 20
  },
  bnd_logo_height = 64,
  bnd_logo_width = 64,
  bnd_logo_left = 10,
  bnd_logo_top = 0,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}


USANWSLInfo = {
  bnd_fontFace = "$DINPro-CondBold",
  bnd_background_show = true,
  bnd_background_height = 480,
  bnd_background_width = 902,
  bnd_background_top = 90,
  bnd_background_left = 260,
  bnd_background = {
    name = "$Background_Intro",
    id = 39
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 350,
  bnd_homelabel_left = -173,
  bnd_homelabel_top = 194,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 0,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 176,
  bnd_awaylabel_top = 194,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 0,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 410,
  bnd_crest_width = 420,
  bnd_crest_image_width = 180,
  bnd_crest_image_height = 180,
  bnd_homecrest_left = 35,
  bnd_homecrest_top = -220,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 100,
  bnd_awaycrest_top = -220,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 700,
  bnd_stadium_left = 290,
  bnd_stadium_top = 233,
  bnd_stadium_color = "0x313131",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  bnd_title_height = 0,
  bnd_title_width = 700,
  bnd_title_left = 325,
  bnd_title_top = 195,
  bnd_title_color = "0xffffff",
  bnd_title_text = "Live From",
  bnd_title_fontSize = 21,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 60,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 20
  },
  bnd_logo_height = 64,
  bnd_logo_width = 64,
  bnd_logo_left = 10,
  bnd_logo_top = 0,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
VanaramaFootballLeagueInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 62
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
VietnamInfo = {
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro1",
    id = 19
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 350,
  bnd_homelabel_left = -173,
  bnd_homelabel_top = 194,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 176,
  bnd_awaylabel_top = 194,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 800,
  bnd_crest_width = 710,
  bnd_crest_image_width = 190,
  bnd_crest_image_height = 190,
  bnd_homecrest_left = -180,
  bnd_homecrest_top = -199,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 180,
  bnd_awaycrest_top = -199,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 700,
  bnd_stadium_left = 1,
  bnd_stadium_top = -180,
  bnd_stadium_color = "0x313131",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  bnd_title_height = 50,
  bnd_title_width = 300,
  bnd_title_left = 1,
  bnd_title_top = 230,
  bnd_title_color = "0xffffff",
  bnd_title_text = "V. League 1 2023/2024",
  bnd_title_fontSize = 25,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 50,
  
  bnd_match_hari = "V S",
  bnd_hari_fontSize = 200 ,
  bnd_hari_fontColor = "0xffffff",
  bnd_hari_left = -3,
  bnd_hari_top = 0,
  
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2260
  },
  bnd_logo_height = 104,
  bnd_logo_width = 104,
  bnd_logo_left = 95,
  bnd_logo_top = -490,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
WomensSuperLeagueInfo = {
  bnd_forceCaps = true, 
  bnd_fontFace = "$Epl",
  bnd_background_show = false,
  bnd_background_height = 600,
  bnd_background_width = 700,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = 13
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 100,
  bnd_label_width = 350,
  bnd_homelabel_left = -173,
  bnd_homelabel_top = 154,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 25,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 176,
  bnd_awaylabel_top = 154,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 25,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 300,
  bnd_crest_width = 350,
  bnd_crest_image_width = 256,
  bnd_crest_image_height = 256,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -199,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -199,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 700,
  bnd_stadium_left = 1,
  bnd_stadium_top = -220,
  bnd_stadium_color = "0x1D0F33",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  bnd_title_height = 30,
  bnd_title_width = 300,
  bnd_title_left = 1,
  bnd_title_top = 219,
  bnd_title_color = "0xF5F5F5",
  bnd_title_text = "",
  bnd_title_fontSize = 20,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2216
  },
  bnd_logo_height = 90,
  bnd_logo_width = 90,
  bnd_logo_left = 0,
  bnd_logo_top = -240,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
UefaInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$UCL-Regular", 
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = 2236
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -230,
  bnd_homelabel_top = 116,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 25,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 200,
  bnd_awaylabel_top = 116,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 25,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 165,
  bnd_crest_image_height = 165,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -150,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -150,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 1,
  bnd_stadium_top = 200,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 10,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo",
    id = ""
  },
  bnd_logo_height = 64,
  bnd_logo_width = 64,
  bnd_logo_left = 0,
  bnd_logo_top = 26000,
  bnd_logo_alpha = 0.6,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}

WorldCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Qatar2022Arabic",
  bnd_background_show = true,
  bnd_background_height = 530,
  bnd_background_width = 850,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,   
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID2"
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -210,
  bnd_homelabel_top = -190,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 24,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = -190,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 24,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 140,
  bnd_crest_image_height = 140,
  bnd_homecrest_left = 5,
  bnd_homecrest_top = 180,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$CrestWorldCup2026",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = 180,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$CrestWorldCup2026",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 0,
  bnd_stadium_top = 130,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 15,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x3d1124",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$",
    id = "CupID2"
  },
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_left = 30,
  bnd_logo_top = 140,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}

UefaUelInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = 2238
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -185,
  bnd_homelabel_top = 80,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 35,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 240,
  bnd_awaylabel_top = 80,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 35,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 165,
  bnd_crest_image_height = 165,
  bnd_homecrest_left = -10,
  bnd_homecrest_top = -150,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -150,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left =15,
  bnd_stadium_top = 180,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 10,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2238
  },
  bnd_logo_height = 74,
  bnd_logo_width = 74,
  bnd_logo_left = 30,
  bnd_logo_top = 50,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}


PialaIndonesiaInfo = {
  bnd_background_show = true,
  bnd_background_height = 470,
  bnd_background_width = 1350,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID4"
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,   
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -250,
  bnd_homelabel_top = 120,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 20,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 250,
  bnd_awaylabel_top = 120,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 190,
  bnd_crest_image_height = 190,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -140,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -140,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 650,
  bnd_stadium_left = 0,
  bnd_stadium_top = 187,
  bnd_stadium_color = "0x749CB4",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  bnd_title_height = 0,
  bnd_title_width = 650,
  bnd_title_left = 0,
  bnd_title_top = -175,
  bnd_title_color = "0x000000",
  bnd_title_text = "",
  bnd_title_fontSize = 20,
  bnd_title_fontColor = "0xD8DF3A",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = -2,
  bnd_match_vs = "Kratingdaeng Piala Indonesia",
  bnd_vs_fontSize = 18,
  bnd_vs_fontColor = "0xD8DF3A",
  bnd_vs_left = 0,
  bnd_vs_top = -185,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID4"
  },
  bnd_logo_height = 124,
  bnd_logo_width = 124,
  bnd_logo_left = 0,
  bnd_logo_top = 190,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 0,
  bnd_stadium_icon_width = 0,
  bnd_stadium_icon_top = -2000,
  bnd_stadium_icon_left = 0,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}

WcWomenInfo = {
    bnd_fontFace = "$FWWC2023Bold",
    bnd_background_show = true,
    bnd_background_height = 500,
    bnd_background_width = 755,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID5"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,     
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 0,
    bnd_background_stadium_alpha = 0,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -230,
    bnd_homelabel_top = 80,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 230,
    bnd_awaylabel_top = 80,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 160,
    bnd_crest_image_height = 160,
    bnd_homecrest_left = -0,
    bnd_homecrest_top = -100,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -100,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = -15,
    bnd_stadium_top = 192,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 18,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo",
      id = "CupID5"
    },
    bnd_logo_height = 145,
    bnd_logo_width = 145,
    bnd_logo_left = 0,
    bnd_logo_top = 203,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}

UefaWomensInfo = {
	bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 700,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 2240
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -150,
    bnd_homelabel_top = 80,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 23,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 150,
    bnd_awaylabel_top = 80,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 23,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 150,
    bnd_crest_image_height = 150,
    bnd_homecrest_left = -0,
    bnd_homecrest_top = -130,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -130,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 130,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 19,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo",
      id = 2240
    },
    bnd_logo_height = 75,
    bnd_logo_width = 70,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}

FaCupInfo = {
    bnd_forceCaps = true,
    bnd_fontFace = "$Emirates-Bold",
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 850,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID7"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -230,
    bnd_homelabel_top = 90,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 230,
    bnd_awaylabel_top = 90,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 140,
    bnd_crest_image_height = 140,
    bnd_homecrest_left = -0,
    bnd_homecrest_top = -120,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -120,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 159,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 15,
    bnd_stadium_fontColor = "0x000000",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo",
      id = "CupID7"
    },
    bnd_logo_height = 85,
    bnd_logo_width = 80,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
UeclInfo = {
    bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 700,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID8"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -150,
    bnd_homelabel_top = 120,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 150,
    bnd_awaylabel_top = 120,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 190,
    bnd_crest_image_height = 190,
    bnd_homecrest_left = -0,
    bnd_homecrest_top = -130,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -130,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 168,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 23,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo",
      id = "CupID8"
    },
    bnd_logo_height = 80,
    bnd_logo_width = 80,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}

AsianCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID9"
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_homelabel_left = -190,
  bnd_homelabel_top = 120,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0x000000",
  bnd_awaylabel_left = 190,
  bnd_awaylabel_top = 120,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0x000000",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -160,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$AsianCupCrest",
    id = 0
  },
  bnd_awaycrest_left = -0,
  bnd_awaycrest_top = -160,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$AsianCupCrest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 170,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 500,
  bnd_title_left = 0,
  bnd_title_top = -190,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0x00ff67",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID9_1"
  },
  bnd_logo_height = 650,
  bnd_logo_width = 1320,
  bnd_logo_left = 0,
  bnd_logo_top = 180,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}

KingSaudiCupInfo = {
	bnd_forceCaps = true,
    bnd_background_show = true,
    bnd_background_height = 650,
    bnd_background_width = 1350,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID10"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -150,
    bnd_homelabel_top = -94,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = -40,
    bnd_awaylabel_top = -13,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 70,
    bnd_crest_image_height = 70,
    bnd_homecrest_left = -217,
    bnd_homecrest_top = 2,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 227,
    bnd_awaycrest_top = -2,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 48,
    bnd_stadium_top = 50,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 15,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo1",
      id = "CupID10"
    },
    bnd_logo_height = 75,
    bnd_logo_width = 75,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}

EuroCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$KnulExtraBold",
  bnd_background_show = true,
  bnd_background_width = 1542,
  bnd_background_height = 718,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = -45,
  bnd_background_left = -17,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID11"
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = 5,
  bnd_homelabel_top = -30,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 50,
  bnd_awaylabel_top = 10,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = -340,
  bnd_homecrest_top = 5,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$EuroCupCrest",
    id = 0
  },
  bnd_awaycrest_left = 330,
  bnd_awaycrest_top = -40,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$EuroCupCrest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 650,
  bnd_stadium_left = 20,
  bnd_stadium_top = 201,
  bnd_stadium_color = "0x749CB4",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xDDC100",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  bnd_title_height = 0,
  bnd_title_width = 650,
  bnd_title_left = 0,
  bnd_title_top = 235,
  bnd_title_color = "0x000000",
  bnd_title_text = "EURO2024.com",
  bnd_title_fontSize = 15,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 15,
  bnd_match_vs = "VS",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0xDDC100",
  bnd_vs_left = -60,
  bnd_vs_top = 10,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID11"
  },
  bnd_logo_height = 124,
  bnd_logo_width = 124,
  bnd_logo_left = 5,
  bnd_logo_top =-450,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 0,
  bnd_stadium_icon_width = 0,
  bnd_stadium_icon_top = -2000,
  bnd_stadium_icon_left = 0,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}

UsaOpenCupInfo = {
    bnd_forceCaps = true,
    bnd_background_show = true,
    bnd_background_height = 650,
    bnd_background_width = 1350,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID12"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -150,
    bnd_homelabel_top = -94,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = -40,
    bnd_awaylabel_top = -13,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 70,
    bnd_crest_image_height = 70,
    bnd_homecrest_left = -217,
    bnd_homecrest_top = 1,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 227,
    bnd_awaycrest_top = -2,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 48,
    bnd_stadium_top = 48,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 15,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo1",
      id = "CupID10"
    },
    bnd_logo_height = 75,
    bnd_logo_width = 75,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
CopaAmericaInfo = {
    bnd_forceCaps = true,
    bnd_background_show = true,
    bnd_background_height = 500,
    bnd_background_width = 755,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID13"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 0,
    bnd_background_stadium_alpha = 0,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -180,
    bnd_homelabel_top = 100,
    bnd_homeLabel_color = "0xFFFFFF",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 180,
    bnd_awaylabel_top = 100,
    bnd_awaylabel_color = "0xFFFFFF",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 160,
    bnd_crest_image_height = 160,
    bnd_homecrest_left = -0,
    bnd_homecrest_top = -120,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$CopaAmerikaCrest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -120,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$CopaAmerikaCrest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 0,
    bnd_stadium_top = 203,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 15,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -203,
    bnd_title_color = "0xffffff",
    bnd_title_text = "",
    bnd_title_fontSize = 23,
    bnd_title_fontColor = "0x000000",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo1",
      id = 0
    },
    bnd_logo_height = 75,
    bnd_logo_width = 75,
    bnd_logo_left = 2,
    bnd_logo_top = 155,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 250,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
CopaDelReyInfo = { 
	bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 500,
    bnd_background_width = 800,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID14"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -260,
    bnd_homelabel_top = 100,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 23,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 260,
    bnd_awaylabel_top = 100,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 150,
    bnd_crest_image_height = 150,
    bnd_homecrest_left = -0,
    bnd_homecrest_top = -115,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$LaLigaTeamCrest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -115,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$LaLigaTeamCrest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 25,
    bnd_stadium_top = -60,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 15,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 25,
    bnd_title_top = -80,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "Estadio",
    bnd_title_fontSize = 18,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo1",
      id = 2240
    },
    bnd_logo_height = 75,
    bnd_logo_width = 70,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
AfricaCupInfo = {
  bnd_fontFace = "$Liga1",
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 26
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -220,
  bnd_homelabel_top = 120,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 30,
  bnd_homelabel_short = "",
  bnd_homelabel_short_top = 20,
  bnd_homelabel_short_left = -50,
  bnd_homelabel_text_fontcolor = "0xFFFFFF",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 220,
  bnd_awaylabel_top = 120,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_top = 20,
  bnd_awaylabel_short_left = 30,
  bnd_awaylabel_text_fontcolor = "0xFFFFFF",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 2,
  bnd_homecrest_top = -130,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -0,
  bnd_awaycrest_top = -130,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 500,
  bnd_stadium_left = 0,
  bnd_stadium_top = 180,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 500,
  bnd_title_left = 0,
  bnd_title_top = 140,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "Live From",
  bnd_title_fontSize = 0,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = -169,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "2235_1"
  },
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_left = 0,
  bnd_logo_top = -140,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150,
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}
CoppaItaliaInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background_alignH = "FILL",
  bnd_background_alignV = "FILL",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID15"
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 0,
    bnd_background_stadium_alpha = 0,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = 0,
    bnd_homelabel_top = -60,
    bnd_homeLabel_color = "0xFFFFFF",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 35,
    bnd_homeLabel_fontColor = "0xFFFFFF",
    bnd_awaylabel_left = 0,
    bnd_awaylabel_top = 60,
    bnd_awaylabel_color = "0xFFFFFF",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 35,
    bnd_awaylabel_fontColor = "0xFFFFFF",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 160,
    bnd_crest_image_height = 160,
    bnd_homecrest_left = -320,
    bnd_homecrest_top = 60,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 320,
    bnd_awaycrest_top = -60,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 0,
    bnd_stadium_top = 215,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 20,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 0,
    bnd_title_top = -135,
    bnd_title_color = "0x00FFD5",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0x00FFD5",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "VS",
    bnd_vs_fontSize = 30,
    bnd_vs_fontColor = "0x00FFD5",
    bnd_vs_left = 0,
    bnd_vs_top = 0,
    bnd_logo = {
      name = "$LeagueLogo",
      id = 2231
    },
    bnd_logo_height = 0,
    bnd_logo_width = 100,
    bnd_logo_left = 0,
    bnd_logo_top = -100,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 250,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
DfbPokalInfo = { 
	bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 610,
    bnd_background_width = 1330,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID16"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -200,
    bnd_homelabel_top = 140,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 30,
    bnd_homeLabel_fontColor = "0x000000",
    bnd_awaylabel_left = 180,
    bnd_awaylabel_top = 140,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 30,
    bnd_awaylabel_fontColor = "0x000000",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 290,
    bnd_crest_image_width = 160,
    bnd_crest_image_height = 160,
    bnd_homecrest_left = -5,
    bnd_homecrest_top = -165,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 5,
    bnd_awaycrest_top = -165,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 215,
    bnd_stadium_color = "",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 20,
    bnd_stadium_fontColor = "0x000000",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo",
      id = "CupID16"
    },
    bnd_logo_height = 80,
    bnd_logo_width = 80,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
ClassicInfo = { 
    bnd_fontFace = "$timer", 
    bnd_short_name_fontFace = "$CruyffSansExpandes", 
    bnd_forceCaps = true,
    bnd_short_name_visible = true,
    bnd_teamLabel_visible = false,
    bnd_background_show = true,
    bnd_background_height = 500,
    bnd_background_width = 725,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 1245
    },
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 0,
    bnd_background_stadium_alpha = 0,
    bnd_label_height = 0,
    bnd_label_width = 0,
    ---bnd_homeLabel_multiline = true,
    ---bnd_homeLabel_width = 210,     
    bnd_homelabel_short_fontSize = 20,
    bnd_homeLabel_short_top = -40,
    bnd_homelabel_left = -200,
    bnd_homelabel_top = -50,
    bnd_homeLabel_color = "0xFFFFFF",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 13,
    bnd_homeLabel_fontColor = "0x000000",
    bnd_homelabel_short_fontcolor = "0x000000",
    ---bnd_awaylabel_multiline = true,
    ---bnd_awaylabel_width = 210,  
    bnd_awaylabel_short_fontSize = 20, 
    bnd_awaylabel_short_top = -40,
    bnd_awaylabel_left = -200,
    bnd_awaylabel_top = 100,
    bnd_awaylabel_color = "0xFFFFFF",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 13,
    bnd_awaylabel_fontColor = "0x000000",
    bnd_awaylabel_short_fontcolor = "0x000000",
    bnd_homeLabel_alignH = "LEFT",
    bnd_awaylabel_alignH = "LEFT",
    bnd_crest_height = 0,
    bnd_crest_width = 0,
    bnd_crest_image_width = 120,
    bnd_crest_image_height = 120,
    bnd_homecrest_left = 330,
    bnd_homecrest_top = -20,
    bnd_homecrest_color = "0x000000",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 330,
    bnd_awaycrest_top = 0,
    bnd_awaycrest_color = "0x000000",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 0,
    bnd_stadium_top = 130,
    bnd_stadium_color = "0x000000",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 0,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 1,
    bnd_title_width = 1,
    bnd_title_left = 0,
    bnd_title_top = -155,
    bnd_title_color = "0xffffff",
    bnd_title_text = "",
    bnd_title_fontSize = 0,
    bnd_title_fontColor = "0x000000",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 50,
    bnd_match_vs = "VS",
    bnd_vs_fontSize = 30,
    bnd_vs_fontColor = "0x000000",
    bnd_vs_left = -130,
    bnd_vs_top = 0,
    bnd_logo = {
      name = "$LeagueLogo",
      id = 0
    },
    bnd_logo_height = 40,
    bnd_logo_width = 40,
    bnd_logo_left = -100,
    bnd_logo_top = -60,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 250,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 210,
    bnd_homeLabel_rect_left = -256,
    bnd_homeLabel_rect_top = 89,
    bnd_awayLabel_rect_left = 256,
    bnd_awayLabel_rect_top = -91
}

EAFCInfo = {
    bnd_fontFace = "$timer", 
    bnd_short_name_fontFace = "$CruyffSansExpandes", 
    bnd_forceCaps = true,
    bnd_short_name_visible = true,
    bnd_teamLabel_visible = false,
    bnd_background_show = true,
    bnd_background_height = 500,
    bnd_background_width = 725,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 0
    },
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 0,
    bnd_background_stadium_alpha = 0,
    bnd_label_height = 0,
    bnd_label_width = 0,
    ---bnd_homeLabel_multiline = true,
    ---bnd_homeLabel_width = 210,     
    bnd_homelabel_short_fontSize = 20,
    bnd_homeLabel_short_top = -40,
    bnd_homelabel_left = -200,
    bnd_homelabel_top = -50,
    bnd_homeLabel_color = "0xFFFFFF",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 13,
    bnd_homeLabel_fontColor = "0x000000",
    bnd_homelabel_short_fontcolor = "0x000000",
    ---bnd_awaylabel_multiline = true,
    ---bnd_awaylabel_width = 210,  
    bnd_awaylabel_short_fontSize = 20, 
    bnd_awaylabel_short_top = -40,
    bnd_awaylabel_left = -200,
    bnd_awaylabel_top = 100,
    bnd_awaylabel_color = "0xFFFFFF",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 13,
    bnd_awaylabel_fontColor = "0x000000",
    bnd_awaylabel_short_fontcolor = "0x000000",
    bnd_homeLabel_alignH = "LEFT",
    bnd_awaylabel_alignH = "LEFT",
    bnd_crest_height = 0,
    bnd_crest_width = 0,
    bnd_crest_image_width = 120,
    bnd_crest_image_height = 120,
    bnd_homecrest_left = 330,
    bnd_homecrest_top = -20,
    bnd_homecrest_color = "0x000000",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 330,
    bnd_awaycrest_top = 0,
    bnd_awaycrest_color = "0x000000",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 0,
    bnd_stadium_top = 130,
    bnd_stadium_color = "0x000000",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 0,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 1,
    bnd_title_width = 1,
    bnd_title_left = 0,
    bnd_title_top = -155,
    bnd_title_color = "0xffffff",
    bnd_title_text = "",
    bnd_title_fontSize = 0,
    bnd_title_fontColor = "0x000000",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 50,
    bnd_match_vs = "VS",
    bnd_vs_fontSize = 30,
    bnd_vs_fontColor = "0x000000",
    bnd_vs_left = -130,
    bnd_vs_top = 0,
    bnd_logo = {
      name = "$LeagueLogo",
      id = 0
    },
    bnd_logo_height = 40,
    bnd_logo_width = 40,
    bnd_logo_left = -100,
    bnd_logo_top = -60,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 250,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 210,
    bnd_homeLabel_rect_left = -256,
    bnd_homeLabel_rect_top = 89,
    bnd_awayLabel_rect_left = 256,
    bnd_awayLabel_rect_top = -91
}

AlgeriaInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2262
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
AfcInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID9"
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_homelabel_left = -190,
  bnd_homelabel_top = 120,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0x000000",
  bnd_awaylabel_left = 190,
  bnd_awaylabel_top = 120,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0x000000",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -160,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -0,
  bnd_awaycrest_top = -160,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 170,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 500,
  bnd_title_left = 0,
  bnd_title_top = -190,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0x00ff67",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID9_1"
  },
  bnd_logo_height = 650,
  bnd_logo_width = 1320,
  bnd_logo_left = 0,
  bnd_logo_top = 180,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
AsianCupU23Info = { 
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = 2264
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_homelabel_left = -190,
  bnd_homelabel_top = 120,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0x000000",
  bnd_awaylabel_left = 190,
  bnd_awaylabel_top = 120,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0x000000",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -160,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -0,
  bnd_awaycrest_top = -160,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 170,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 500,
  bnd_title_left = 0,
  bnd_title_top = -190,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0x00ff67",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID9_1"
  },
  bnd_logo_height = 650,
  bnd_logo_width = 1320,
  bnd_logo_left = 0,
  bnd_logo_top = 180,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
DenmarkInfo = { 
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 1
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 1
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 435,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
D1ArkemaInfo = {
    bnd_forceCaps = true,
    bnd_fontFace = "$DINPro-CondBold", 
    bnd_background_show = true,
    bnd_background_height = 620,
    bnd_background_width = 850,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 2218
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 0.9,
    bnd_background_alpha_1 = 0,
    bnd_background_stadium_alpha = 0,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -190,
    bnd_homelabel_top = -268,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 20,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 190,
    bnd_awaylabel_top = -268,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 20,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 210,
    bnd_crest_image_height = 210,
    bnd_homecrest_left = 10,
    bnd_homecrest_top = 255,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = -10,
    bnd_awaycrest_top = 255,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = -3,
    bnd_stadium_top = 230,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 20,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$",
      id = 2218
    },
    bnd_logo_height = 0,
    bnd_logo_width = 150,
    bnd_logo_left = 0,
    bnd_logo_top = 203,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
EcuadorInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2018
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
EnglandInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl",
  bnd_background_show = true,
  bnd_background_height = 635,
  bnd_background_width = 1000,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = 13
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -280,
  bnd_homelabel_top = 209,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 20,
  bnd_homeLabel_fontColor = "0x39003E",
  bnd_awaylabel_left = 280,
  bnd_awaylabel_top = 209,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_fontColor = "0x39003E",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 364,
  bnd_crest_width = 360,
  bnd_crest_image_width = 256,
  bnd_crest_image_height = 256,
  
  bnd_homecrest_left = -6,
  bnd_homecrest_top = -210,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 6,
  bnd_awaycrest_top = -210,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 1,
  bnd_stadium_top = 155,
  bnd_stadium_color = "0x313131",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 10,
  bnd_stadium_fontColor = "0x410848",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 1,
  bnd_title_top = 219,
  bnd_title_color = "0xffffff",
  bnd_title_text = "",
  bnd_title_fontSize = 0,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 0
  },
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_left = 0,
  bnd_logo_top = -240,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
FranceInfo = {
  bnd_fontFace = "$Ligue1",
  bnd_background_show = true,
  bnd_background_height = 700,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background = {
    name = "$Background_Intro",
    id = 16
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -230,
  bnd_homelabel_top = 118,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 22,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 280,
  bnd_awaylabel_top = 118,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 22,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 160,
  bnd_crest_image_height = 160,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -140,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -140,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 5,
  bnd_stadium_top = 230,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 13,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -6,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 30,
  bnd_title_top = -218,
  bnd_title_color = "",
  bnd_title_text = "MATCHDAY  MATCHDAY  MATCHDAY  MATCHDAY",
  bnd_title_fontSize = 30,
  bnd_title_fontColor = "0x000000",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = -3,
  
  bnd_match_vs = "Exhibition",
  bnd_vs_fontSize = 18,
  bnd_vs_fontColor = "0xFFFFFF",
  bnd_vs_left = 10,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 53
  },
  bnd_logo_height = 34,
  bnd_logo_width = 150,
  bnd_logo_left = 0,
  bnd_logo_top = 390,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
France2Info = {
  bnd_fontFace = "$Ligue1",
  bnd_background_show = true,
  bnd_background_height = 700,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background = {
    name = "$Background_Intro",
    id = 17
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -230,
  bnd_homelabel_top = 118,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 22,
  bnd_homeLabel_fontColor = "0x000000",
  bnd_awaylabel_left = 280,
  bnd_awaylabel_top = 118,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 22,
  bnd_awaylabel_fontColor = "0x000000",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 160,
  bnd_crest_image_height = 160,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -140,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -140,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 5,
  bnd_stadium_top = 230,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 13,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -6,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 30,
  bnd_title_top = -218,
  bnd_title_color = "",
  bnd_title_text = "MATCHDAY  MATCHDAY  MATCHDAY  MATCHDAY",
  bnd_title_fontSize = 0,
  bnd_title_fontColor = "0x000000",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = -3,
  
  bnd_match_vs = "LIGUE 2 BKT",
  bnd_vs_fontSize = 18,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 10,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 53
  },
  bnd_logo_height = 34,
  bnd_logo_width = 150,
  bnd_logo_left = 0,
  bnd_logo_top = 390,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
GermanyInfo = {
  bnd_fontFace = "$Bundesliga", 
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = 19
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 100,
  bnd_label_width = 350,
  bnd_homelabel_left = -173,
  bnd_homelabel_top = 194,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 176,
  bnd_awaylabel_top = 194,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 300,
  bnd_crest_width = 350,
  bnd_crest_image_width = 256,
  bnd_crest_image_height = 256,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -199,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -199,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 700,
  bnd_stadium_left = 1,
  bnd_stadium_top = -180,
  bnd_stadium_color = "0x313131",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  bnd_title_height = 50,
  bnd_title_width = 700,
  bnd_title_left = 1,
  bnd_title_top = -230,
  bnd_title_color = "0xffffff",
  bnd_title_text = "",
  bnd_title_fontSize = 25,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 80,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 19
  },
  bnd_logo_height = 64,
  bnd_logo_width = 64,
  bnd_logo_left = 10,
  bnd_logo_top = 0,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
Germany2Info = {
  bnd_fontFace = "$Bundesliga", 
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = 19
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 100,
  bnd_label_width = 350,
  bnd_homelabel_left = -173,
  bnd_homelabel_top = 194,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 176,
  bnd_awaylabel_top = 194,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 300,
  bnd_crest_width = 350,
  bnd_crest_image_width = 256,
  bnd_crest_image_height = 256,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -199,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -199,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 700,
  bnd_stadium_left = 1,
  bnd_stadium_top = -180,
  bnd_stadium_color = "0x313131",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  bnd_title_height = 50,
  bnd_title_width = 700,
  bnd_title_left = 1,
  bnd_title_top = -230,
  bnd_title_color = "0xffffff",
  bnd_title_text = "",
  bnd_title_fontSize = 25,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 80,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 20
  },
  bnd_logo_height = 64,
  bnd_logo_width = 64,
  bnd_logo_left = 10,
  bnd_logo_top = 0,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}


Germany3Info = {
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = 19
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 100,
  bnd_label_width = 350,
  bnd_homelabel_left = -173,
  bnd_homelabel_top = 194,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 176,
  bnd_awaylabel_top = 194,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 300,
  bnd_crest_width = 350,
  bnd_crest_image_width = 256,
  bnd_crest_image_height = 256,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -199,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -199,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 700,
  bnd_stadium_left = 1,
  bnd_stadium_top = -180,
  bnd_stadium_color = "0x313131",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  bnd_title_height = 50,
  bnd_title_width = 700,
  bnd_title_left = 1,
  bnd_title_top = -230,
  bnd_title_color = "0xffffff",
  bnd_title_text = "",
  bnd_title_fontSize = 25,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 80,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2076
  },
  bnd_logo_height = 64,
  bnd_logo_width = 64,
  bnd_logo_left = 10,
  bnd_logo_top = 0,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
IndonesiaInfo = {
  bnd_fontFace = "$Liga1",
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = 2235
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_homelabel_left = -190,
  bnd_homelabel_top = 120,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 190,
  bnd_awaylabel_top = 120,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -160,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -0,
  bnd_awaycrest_top = -160,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 170,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 12,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 500,
  bnd_title_left = 0,
  bnd_title_top = 140,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "Live From",
  bnd_title_fontSize = 10,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "MATCHDAY",
  bnd_vs_fontSize = 25,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = -169,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2235_1"
  },
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_left = 0,
  bnd_logo_top = -140,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
ItalyInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 600,
  bnd_background_width = 1350,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = 31
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0,
  bnd_background_stadium_alpha = 0,

    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 100,
  bnd_label_width = 360,
  bnd_homelabel_left = 0,
  bnd_homelabel_top = -50,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 35,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 0,
  bnd_awaylabel_top = 50,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 35,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 100,
  bnd_crest_width = 100,
  bnd_crest_image_width = 150,
  bnd_crest_image_height = 150,
  bnd_homecrest_left = -250,
  bnd_homecrest_top = 50,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 250,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 500,
  bnd_stadium_left = 0,
  bnd_stadium_top = 180,
  bnd_stadium_color = "0xffffff",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 16,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 50,
  bnd_title_width = 500,
  bnd_title_left = 0,
  bnd_title_top = 1000,
  bnd_title_color = "0xffffff",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "VS",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x5376E1",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 31
  },
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_left = 0,
  bnd_logo_top = 203,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
JapanInfo = {
	bnd_forceCaps = true,
    bnd_fontFace = "$DINPro-CondBold", 
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 700,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 349
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -190,
    bnd_homelabel_top = -202,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 190,
    bnd_awaylabel_top = -202,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 290,
    bnd_crest_image_width = 140,
    bnd_crest_image_height = 140,
    bnd_homecrest_left = 0,
    bnd_homecrest_top = 180,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = 180,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 163,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 23,
    bnd_stadium_fontColor = "0x000000",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "vs",
    bnd_vs_fontSize = 25,
    bnd_vs_fontColor = "0xffffff",
    bnd_vs_left = -2,
    bnd_vs_top = -50,
    bnd_logo = {
      name = "$LeagueLogo1",
      id = "CupID8"
    },
    bnd_logo_height = 80,
    bnd_logo_width = 80,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
LeagueOneEflInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 60
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
LeagueTwoEflInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 61
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
LigaFInfo = { 
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 700,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_alpha = 1,
  bnd_background = {
    name = "$Background_Intro",
    id = 2222
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -270,
  bnd_homelabel_top = -225,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 20,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 270,
  bnd_awaylabel_top = -225,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 250,
  bnd_crest_image_height = 250,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = 240,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = 240,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 1,
  bnd_stadium_top = 186,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xf4fbc7",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -6,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -240,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 35,
  bnd_title_fontColor = "0x000000",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = -3,
  
  bnd_match_hari = "",
  bnd_hari_fontSize = 40 ,
  bnd_hari_fontColor = "0x000000",
  bnd_hari_left = -3,
  bnd_hari_top = -170,
  bnd_match_bulan = "",
  bnd_bulan_fontSize = 30,
  bnd_bulan_fontColor = "0xFFFFFF",
  bnd_bulan_left = -3,
  bnd_bulan_top = -0,
  bnd_match_tgl = "",
  bnd_tgl_fontSize = 130 ,
  bnd_tgl_fontColor = "0xFFFFFF",
  bnd_tgl_left = -3,
  bnd_tgl_top = -70,
  
  bnd_match_vs = "",
  bnd_vs_fontSize = 25,
  bnd_vs_fontColor = "0xFFFFFF",
  bnd_vs_left = -4,
  bnd_vs_top = 55,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 53
  },
  bnd_logo_height = 34,
  bnd_logo_width = 150,
  bnd_logo_left = 0,
  bnd_logo_top = 390,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
PegadaianLiga2Info = {
    bnd_forceCaps = true,  
    bnd_fontFace = "$DINPro-CondBold",
    bnd_background_show = true,
    bnd_background_height = 470,
    bnd_background_width = 850,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 10,
    bnd_background = {
      name = "$Background_Intro",
      id = 2254
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -200,
    bnd_homelabel_top = 70,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 30,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 200,
    bnd_awaylabel_top = 70,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 30,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 140,
    bnd_crest_image_height = 140,
    bnd_homecrest_left = -20,
    bnd_homecrest_top = -130,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 20,
    bnd_awaycrest_top = -130,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 175,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 19,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = -130,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "Pegadaian Liga 2 2023/2024",
    bnd_title_fontSize = 35,
    bnd_title_fontColor = "0x0D6046",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo",
      id = 2254
    },
    bnd_logo_height = 130,
    bnd_logo_width = 130,
    bnd_logo_left = 110,
    bnd_logo_top = 160,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
PortugalInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "308_1"
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
RusiaInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 67
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
SaudiArabiaInfo = {
    bnd_forceCaps = true,
    bnd_fontFace = "$SPL",  
    bnd_background_show = true,
    bnd_background_height = 650,
    bnd_background_width = 1350,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 350 
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -150,
    bnd_homelabel_top = 20,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 40,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 150,
    bnd_awaylabel_top = 20,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 40,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 110,
    bnd_crest_image_height = 110,
    bnd_homecrest_left = -227,
    bnd_homecrest_top = 0,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 225,
    bnd_awaycrest_top = 0,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 0,
    bnd_stadium_top = 130,
    bnd_stadium_color = "",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 30,
    bnd_stadium_fontColor = "0x404040",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 0,
    bnd_title_top = -95,
    bnd_title_color = "",
    bnd_title_text = "Matchday 1",
    bnd_title_fontSize = 23,
    bnd_title_fontColor = "0x404040",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo1",
      id = "CupID10"
    },
    bnd_logo_height = 75,
    bnd_logo_width = 75,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
SpainInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga", 
  bnd_background_show = true,
  bnd_background_height = 700,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_alpha = 0.9,
  bnd_background = {
    name = "$Background_Intro",
    id = 53
  },
  bnd_homelabel_short_fontSize = 0, 
  bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -270,
  bnd_homelabel_top = 225,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 45,
  bnd_homeLabel_fontColor = "0x000000",
  bnd_awaylabel_left = 270,
  bnd_awaylabel_top = 225,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 45,
  bnd_awaylabel_fontColor = "0x000000",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 250,
  bnd_crest_image_height = 250,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -250,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -250,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 1,
  bnd_stadium_top = 85,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 22,
  bnd_stadium_fontColor = "0xf4fbc7",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -6,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -240,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "08:56",
  bnd_title_fontSize = 35,
  bnd_title_fontColor = "0x000000",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = -3,
  
  bnd_match_hari = "JORNADA",
  bnd_hari_fontSize = 40 ,
  bnd_hari_fontColor = "0x000000",
  bnd_hari_left = -3,
  bnd_hari_top = -170,
  bnd_match_bulan = "ENERO",
  bnd_bulan_fontSize = 30,
  bnd_bulan_fontColor = "0xFFFFFF",
  bnd_bulan_left = -3,
  bnd_bulan_top = -0,
  bnd_match_tgl = "22",
  bnd_tgl_fontSize = 130 ,
  bnd_tgl_fontColor = "0xFFFFFF",
  bnd_tgl_left = -3,
  bnd_tgl_top = -70,
  
  bnd_match_vs = "ESTADIO",
  bnd_vs_fontSize = 25,
  bnd_vs_fontColor = "0xFFFFFF",
  bnd_vs_left = -4,
  bnd_vs_top = 55,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 53
  },
  bnd_logo_height = 34,
  bnd_logo_width = 150,
  bnd_logo_left = 0,
  bnd_logo_top = 390,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}


Spain2Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga", 
  bnd_background_show = true,
  bnd_background_height = 700,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_alpha = 0.9,
  bnd_background = {
    name = "$Background_Intro",
    id = 54
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -270,
  bnd_homelabel_top = 225,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 45,
  bnd_homeLabel_fontColor = "0x000000",
  bnd_awaylabel_left = 270,
  bnd_awaylabel_top = 225,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 45,
  bnd_awaylabel_fontColor = "0x000000",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 250,
  bnd_crest_image_height = 250,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -250,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -250,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 1,
  bnd_stadium_top = 85,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 22,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -4,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -240,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "08:56",
  bnd_title_fontSize = 35,
  bnd_title_fontColor = "0x000000",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = -3,
  
  bnd_match_hari = "JORNADA",
  bnd_hari_fontSize = 40 ,
  bnd_hari_fontColor = "0x000000",
  bnd_hari_left = -3,
  bnd_hari_top = -170,
  bnd_match_bulan = "ENERO",
  bnd_bulan_fontSize = 30,
  bnd_bulan_fontColor = "0xFFFFFF",
  bnd_bulan_left = -3,
  bnd_bulan_top = -0,
  bnd_match_tgl = "22",
  bnd_tgl_fontSize = 130 ,
  bnd_tgl_fontColor = "0xFFFFFF",
  bnd_tgl_left = -3,
  bnd_tgl_top = -70,
  
  bnd_match_vs = "ESTADIO",
  bnd_vs_fontSize = 25,
  bnd_vs_fontColor = "0xFFFFFF",
  bnd_vs_left = -4,
  bnd_vs_top = 55,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 54
  },
  bnd_logo_height = 51,
  bnd_logo_width = 230,
  bnd_logo_left = 0,
  bnd_logo_top = 390,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
SwitzerlandInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 189
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
ThailandInfo = {
    bnd_forceCaps = true,
    bnd_fontFace = "$DINPro-CondBold", 
    bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 700,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 2252
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -230,
    bnd_homelabel_top = -202,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 230,
    bnd_awaylabel_top = -202,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 290,
    bnd_crest_image_width = 140,
    bnd_crest_image_height = 140,
    bnd_homecrest_left = -5,
    bnd_homecrest_top = 180,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 5,
    bnd_awaycrest_top = 180,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 163,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 23,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo1",
      id = "CupID8"
    },
    bnd_logo_height = 80,
    bnd_logo_width = 80,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
UkraineInfo = {
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 1
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 150,
  bnd_crest_image_height = 150,
  bnd_homecrest_left = 150,
  bnd_homecrest_top = -400,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -110,
  bnd_awaycrest_top = -400,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -400,
  bnd_stadium_top = 0,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 30,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueCrest",
    id = "UKRAYINA LIHA"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 160,
  bnd_logo_left = 30,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
CoupeDeFranceInfo = { 
  bnd_forceCaps = true,
  bnd_background_show = false,
  bnd_background_height = 600,
  bnd_background_width = 750,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = 13
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 110,
  bnd_label_width = 380,
  bnd_homelabel_left = -175,
  bnd_homelabel_top = 136,
  bnd_homeLabel_color = "0x071A31",
  bnd_homeLabel_text = "",
  bnd_homeLabel_text_top = -10,
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 175,
  bnd_awaylabel_top = 136,
  bnd_awaylabel_color = "0x071A31",
  bnd_awaylabel_text = "",
  bnd_awayLabel_text_top = -10,
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 300,
  bnd_crest_width = 380,
  bnd_crest_image_width = 200,
  bnd_crest_image_height = 200,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -179,
  bnd_homecrest_color = "0x071A31",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -179,
  bnd_awaycrest_color = "0x071A31",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 30,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 205,
  bnd_stadium_color = "0x1A8EC4",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 40,
  bnd_title_width = 510,
  bnd_title_left = 0,
  bnd_title_top = -212,
  bnd_title_color = "0x1A8EC4",
  bnd_title_text = "COUPE DE FRANCE",
  bnd_title_fontSize = 30,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID17"
  },
  bnd_logo_height = 86,
  bnd_logo_width = 86,
  bnd_logo_left = 0,
  bnd_logo_top = 200,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 200,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
FcwcInfo = {
    bnd_forceCaps = true,
    bnd_short_name_visible = false,
    bnd_teamLabel_visible = true,
    bnd_background_show = true,
    bnd_background_height = 500,
    bnd_background_width = 810,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID18"
    },
     bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,   
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -230,
    bnd_homelabel_top = 90,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 230,
    bnd_awaylabel_top = 90,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 140,
    bnd_crest_image_height = 140,
    bnd_homecrest_left = -0,
    bnd_homecrest_top = -120,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -120,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 159,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 15,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -155,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "FIFA CLUB WORLD CLUB",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "Stadium",
    bnd_vs_fontSize = 17,
    bnd_vs_fontColor = "0xffffff",
    bnd_vs_left = -2,
    bnd_vs_top = 130,
    bnd_logo = {
      name = "$LeagueLogo1",
      id = 0
    },
    bnd_logo_height = 85,
    bnd_logo_width = 80,
    bnd_logo_left = 0,
    bnd_logo_top = 30,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
CopaLibertadoresInfo = {
    bnd_forceCaps = true,
    bnd_background_show = true,
    bnd_background_height = 425,
    bnd_background_width = 750,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID19"
    },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,    
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 0,
    bnd_background_stadium_alpha = 0,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -215,
    bnd_homelabel_top = -165,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 26,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 215,
    bnd_awaylabel_top = -165,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 26,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 160,
    bnd_crest_image_height = 160,
    bnd_homecrest_left = -27,
    bnd_homecrest_top = 190,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 26,
    bnd_awaycrest_top = 190,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = -10,
    bnd_stadium_top = 120,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 25,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -195,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x484ae6",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$",
      id = 21
    },
    bnd_logo_height = 0,
    bnd_logo_width = 150,
    bnd_logo_left = 0,
    bnd_logo_top = 203,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$",
      id = 0
    },
    bnd_stadium_icon_height = 61,
    bnd_stadium_icon_width = 125,
    bnd_stadium_icon_top = 310,
    bnd_stadium_icon_left = 0,
    bnd_label_rect_height = 0,
    bnd_label_rect_width = 0,
    bnd_homeLabel_rect_left = -100,
    bnd_homeLabel_rect_top = -150,

    bnd_awayLabel_rect_left = 100,
    bnd_awayLabel_rect_top = -150
}
UefaNationsInfo = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold", 
  bnd_background_show = false,
  bnd_background_height = 600,
  bnd_background_width = 750,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = 13
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 110,
  bnd_label_width = 380,
  bnd_homelabel_left = -175,
  bnd_homelabel_top = 136,
  bnd_homeLabel_color = "0x283848",
  bnd_homeLabel_text = "",
  bnd_homeLabel_text_top = -10,
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 175,
  bnd_awaylabel_top = 136,
  bnd_awaylabel_color = "0x283848",
  bnd_awaylabel_text = "",
  bnd_awayLabel_text_top = -10,
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 300,
  bnd_crest_width = 380,
  bnd_crest_image_width = 200,
  bnd_crest_image_height = 200,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -179,
  bnd_homecrest_color = "0x283848",
  bnd_homecrest_image = {
    name = "$NationalCrest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -179,
  bnd_awaycrest_color = "0x283848",
  bnd_awaycrest_image = {
    name = "$NationalCrest",
    id = 0
  },
  bnd_stadium_height = 30,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 205,
  bnd_stadium_color = "0xffffff",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 40,
  bnd_title_width = 510,
  bnd_title_left = 0,
  bnd_title_top = -212,
  bnd_title_color = "0xffffff",
  bnd_title_text = "UEFA Nations League",
  bnd_title_fontSize = 30,
  bnd_title_fontColor = "0x000000",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID22"
  },
  bnd_logo_height = 86,
  bnd_logo_width = 86,
  bnd_logo_left = 0,
  bnd_logo_top = 200,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 200,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
CarabaoCupInfo = { 
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0,  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 390,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 390,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 68,
  bnd_crest_image_height = 68,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = -193,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -603,
  bnd_awaycrest_top = -193,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -420,
  bnd_stadium_top = 251,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -229,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 30,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID24"
  },
  bnd_logo_height = 75,
  bnd_logo_width = 75,
  bnd_logo_left = -593,
  bnd_logo_top = 430,
  bnd_logo_alpha = 1,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000
}
AseanChampionshipInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_background_show = true,
  bnd_background_height = 630,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = 27
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0,
  bnd_background_stadium_alpha = 0,
 
    bnd_homelabel_short_fontSize = 0, 
    bnd_awaylabel_short_fontSize = 0, 
  bnd_label_height = 100,
  bnd_label_width = 300,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -350,
  bnd_homelabel_top = -130,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 18,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_short_top = -30,
  bnd_homelabel_short_left = -18,
  bnd_homelabel_text_fontcolor = "0xFFFFFF",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 350,
  bnd_awaylabel_top = -130,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 18,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_short_top = -30,
  bnd_awaylabel_short_left = -18,
  bnd_awaylabel_text_fontcolor = "0xFFFFFF",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 300,
  bnd_crest_width = 360,
  bnd_crest_image_width = 210,
  bnd_crest_image_height = 210,
  bnd_homecrest_left = -0,
  bnd_homecrest_top = 150,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = 150,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 239,
  bnd_stadium_color = "0xFF0700",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 30,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 50,
  bnd_title_width = 500,
  bnd_title_left = 0,
  bnd_title_top = -1990000000000,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 28,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0x00ff67",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogoX",
    id = 0
  },
  bnd_logo_height = 60,
  bnd_logo_width = 60,
  bnd_logo_left = 0,
  bnd_logo_top = 180,
  bnd_logo_alpha = 0.6,
  bnd_stadium_icon = {
    name = "$StadiumIcon",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000,
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150,
  
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0 
}
function MatchInfo:new(init)
  print("[MatchInfo]: new()")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SettingsService = o.api("SettingsService"),
    MatchInfoService = o.api("MatchInfoService"),
    EventManagerService = o.api("EventManagerService"),
    GameSetupService = o.api("GameSetupService"),
    TeamService = o.api("TeamService")
  }
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)
  
  local HOMETEAM = 0
  local AWAYTEAM = 1
  local currentdata = nil  
  
  AlgeriaTeams = o.services.TeamService.GetTeams(leagueIDs.Algeria, 0, 0, true)
  AfcTeams = o.services.TeamService.GetTeams(leagueIDs.Afc, 0, 0, true)
  ArgentinaTeams = o.services.TeamService.GetTeams(leagueIDs.Argentina, 0, 0, true)
  AsianCupU23Teams = o.services.TeamService.GetTeams(leagueIDs.AsianCupU23, 0, 0, true)
  BelgiumTeams = o.services.TeamService.GetTeams(leagueIDs.Belgium, 0, 0, true)
  BrazilTeams = o.services.TeamService.GetTeams(leagueIDs.Brazil, 0, 0, true)
  ClassicTeams = o.services.TeamService.GetTeams(leagueIDs.Classic, 0, 0, true)
  Classic2Teams = o.services.TeamService.GetTeams(leagueIDs.Classic2, 0, 0, true)
  ChampionshipEflTeams = o.services.TeamService.GetTeams(leagueIDs.ChampionshipEfl, 0, 0, true)
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
  LeagueTwoEflTeams = o.services.TeamService.GetTeams(leagueIDs.LeagueTwoEfl, 0, 0, true)
  LigaFTeams = o.services.TeamService.GetTeams(leagueIDs.LigaF, 0, 0, true)
  MalaysiaTeams = o.services.TeamService.GetTeams(leagueIDs.Malaysia, 0, 0, true)
  MexicoTeams = o.services.TeamService.GetTeams(leagueIDs.Mexico, 0, 0, true)
  MoroccoTeams = o.services.TeamService.GetTeams(leagueIDs.Morocco, 0, 0, true)
  NetherlandsTeams = o.services.TeamService.GetTeams(leagueIDs.Netherlands, 0, 0, true)
  PegadaianLiga2Teams = o.services.TeamService.GetTeams(leagueIDs.PegadaianLiga2, 0, 0, true)
  PortugalTeams = o.services.TeamService.GetTeams(leagueIDs.Portugal, 0, 0, true)
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
  UnitedStatesTeams = o.services.TeamService.GetTeams(leagueIDs.UnitedStates, 0, 0, true)
  USANWSLTeams = o.services.TeamService.GetTeams(leagueIDs.USANWSL, 0, 0, true)
  VanaramaFootballLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.VanaramaFootballLeague, 0, 0, true)
  VietnamTeams = o.services.TeamService.GetTeams(leagueIDs.Vietnam, 0, 0, true)
  WomensSuperLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.WomensSuperLeague, 0, 0, true)

  liveLogo = {
    name = "$LiveLogo",
    id = 0
  }
  o.im.Subscribe(bndDif, function()
      o.im.Publish(bndDif, o.currentOptions.difficulty)
  end)
  local currentdata = nil
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.currentOptions = o.services.SettingsService.GetCurrentOptions()
  homeCrest = {
    name = "$Crest",
    id = o.TeamsData[1].assetId
  }
  awaycrest = {
    name = "$Crest",
    id = o.TeamsData[2].assetId
  }
  
  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      currentdata = UefaInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 2 then
      currentdata = WorldCupInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 3 then
      currentdata = UefaUelInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 4 then
      currentdata = PialaIndonesiaInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 5 then
      currentdata = WcWomenInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 6 then
      currentdata = UefaWomensInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 7 then
      currentdata = FaCupInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 8 then
      currentdata = UeclInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 9 then
      currentdata = AsianCupInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 10 then
      currentdata = KingSaudiCupInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 11 then
      currentdata = EuroCupInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 12 then
      currentdata = UsaOpenCupInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 13 then
      currentdata = CopaAmericaInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 14 then
      currentdata = CopaDelReyInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 15 then
      currentdata = CoppaItaliaInfo
      currentdata.bnd_title_text = "Coppa Italia"
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 16 then
      currentdata = DfbPokalInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 17 then
      currentdata = CoupeDeFranceInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 18 then
      currentdata = FcwcInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 19 then
      currentdata = CopaLibertadoresInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 20 then
      currentdata = UefaNationsInfo
      liveLogo.id = 0
    end
  elseif currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      currentdata = UefaInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 2 then
      currentdata = WorldCupInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 3 then
      currentdata = UefaUelInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 29 then
      currentdata = PialaIndonesiaInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 9 then
      currentdata = FaCupInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 27 then
      currentdata = AseanChampionshipInfo
      liveLogo.id = 0      
      elseif currentTourData.tourIndex == 35 then
      currentdata = WcWomenInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 16 then
      currentdata = UefaWomensInfo
      liveLogo.id = 0      
      elseif currentTourData.tourIndex == 17 then
      currentdata = UeclInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 34 then
      currentdata = AsianCupInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 6 then
      currentdata = EuroCupInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 13 then
      currentdata = UsaOpenCupInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 25 then
      currentdata = CopaAmericaInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 10 then
      currentdata = CopaDelReyInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 11 then
      currentdata = CoppaItaliaInfo
      currentdata.bnd_title_text = "Coppa Italia"
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 7 then
      currentdata = DfbPokalInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 18 then
      currentdata = CoupeDeFranceInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 15 then
      currentdata = FcwcInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 4 then
      currentdata = CopaLibertadoresInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 50 then
      currentdata = KingSaudiCupInfo
      liveLogo.id = 0      
      elseif currentTourData.tourIndex == 22 then
      currentdata = ClassicInfo
      currentdata.bnd_title_text = "Classic Tour"     
    currentdata.bnd_title_left = -185     
    currentdata.bnd_logo.id = 1245
      liveLogo.id = 0      
      elseif currentTourData.tourIndex == 28 then
      currentdata = UefaNationsInfo
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 26 then
      currentdata = AfricaCupInfo
      liveLogo.id = 0            
      elseif currentTourData.tourIndex == 24 then
      currentdata = EAFCInfo
    currentdata.bnd_title_left = -185     
    currentdata.bnd_logo.id = "CupID24"   
      liveLogo.id = 0
      elseif currentTourData.tourIndex == 31 then
      currentdata = EAFCInfo
    currentdata.bnd_title_left = -185      
    currentdata.bnd_logo.id = "CupID31"           
      liveLogo.id = 0      
      elseif currentTourData.tourIndex == 21 then
      currentdata = EAFCInfo
    currentdata.bnd_title_left = -185   
    currentdata.bnd_logo.id = "CupID21"     
      liveLogo.id = 0      
      else 
      currentdata = EAFCInfo    
    currentdata.bnd_title_left = -185         
      liveLogo.id = 0        
    end    
  else
     if o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
    currentdata = UnitedStatesInfo
    liveLogo.id = 0
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, UnitedStatesTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, UnitedStatesTeamsData)
    currentdata.bnd_homeLabel_color = homeColorList[1]
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_homeLabel_fontColor = homeColorList[2]
    currentdata.bnd_awaylabel_color = awayColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    currentdata.bnd_awaylabel_fontColor = awayColorList[2]
    elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USANWSLTeams) then
    currentdata = USANWSLInfo
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, USANWSLTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, USANWSLTeamsData)
    currentdata.bnd_homeLabel_color = homeColorList[1]
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_homeLabel_fontColor = homeColorList[2]
    currentdata.bnd_awaylabel_color = awayColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    currentdata.bnd_awaylabel_fontColor = awayColorList[2]
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], VanaramaFootballLeagueTeams) and o:isInTable(o.TeamsData[2], VanaramaFootballLeagueTeams) then
    currentdata = VanaramaFootballLeagueInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
    currentdata = VietnamInfo
    liveLogo.id = 0
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, VietnamTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, VietnamTeamsData)
    currentdata.bnd_homeLabel_color = homeColorList[1]
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_homeLabel_fontColor = homeColorList[2]
    currentdata.bnd_awaylabel_color = awayColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    currentdata.bnd_awaylabel_fontColor = awayColorList[2]
    elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
    currentdata = WomensSuperLeagueInfo
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, WomensSuperLeagueTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, WomensSuperLeagueTeamsData)
    currentdata.bnd_homeLabel_color = homeColorList[1]
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_homeLabel_fontColor = homeColorList[2]
    currentdata.bnd_awaylabel_color = awayColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    currentdata.bnd_awaylabel_fontColor = awayColorList[2]
    currentdata.bnd_title_text = "Women's Super League"
    liveLogo.id = 10
    elseif o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
    currentdata = AlgeriaInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], AfcTeams) and o:isInTable(o.TeamsData[2], AfcTeams) then
    currentdata = AfcInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "LPF"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 353
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
    currentdata = AsianCupU23Info
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "Jupiter Pro League"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 4
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "Brasileiro Serie-A"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 7
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    currentdata = ClassicInfo
    currentdata.bnd_title_left = -185     
    currentdata.bnd_logo.id = 1245       
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    currentdata = ClassicInfo
    currentdata.bnd_title_left = -185             
    currentdata.bnd_title_text = "Classic 2"
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "FL CHAMPIONSHIP"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 14
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    currentdata = DenmarkInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    currentdata = D1ArkemaInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    currentdata = EcuadorInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "EPL NILE"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 2231
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    currentdata = EnglandInfo
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, EnglandTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, EnglandTeamsData)
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    currentdata = FranceInfo
   liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    currentdata = France2Info
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    currentdata = GermanyInfo
    liveLogo.id = 0
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, GermanyTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, GermanyTeamsData)
    currentdata.bnd_homeLabel_color = homeColorList[1]
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_homeLabel_fontColor = homeColorList[2]
    currentdata.bnd_awaylabel_color = awayColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    currentdata.bnd_awaylabel_fontColor = awayColorList[2]
    currentdata.bnd_title_text = "Bundesliga"
    elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
    currentdata = Germany2Info
    liveLogo.id = 0
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Germany2TeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Germany2TeamsData)
    currentdata.bnd_homeLabel_color = homeColorList[1]
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_homeLabel_fontColor = homeColorList[2]
    currentdata.bnd_awaylabel_color = awayColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    currentdata.bnd_awaylabel_fontColor = awayColorList[2]
    currentdata.bnd_title_text = "Bundesliga 2"
    elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
    currentdata = IndonesiaInfo
    liveLogo.id = 1
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "MEN'S NATIONAL"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 78
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "WOMEN'S NATIONAL"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 2136
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    currentdata = ItalyInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
    currentdata = JapanInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "K LEAGUE 1"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 83
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "LEAGUE ONE"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 60
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
    currentdata = LeagueTwoEflInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    currentdata = LigaFInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "MALAYSIA"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 2237
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "LIGA MX"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = "341_1"
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "Botola Pro Inwi"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 2250
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "Eredivisie"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 10
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    currentdata = PegadaianLiga2Info
    liveLogo.id = 1
    elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "Eredivisie"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = "308_1"
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "Rest Of World"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 76
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "Rest Of World 2"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 76
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], RusiaTeams) and o:isInTable(o.TeamsData[2], RusiaTeams) then
    currentdata = RusiaInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    currentdata = SaudiArabiaInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "SCOTTISH PREM"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 50
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "South African Fl"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 347
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    currentdata = SpainInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    currentdata = Spain2Info
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    currentdata = SwitzerlandInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
    currentdata = ThailandInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    currentdata = EAFCInfo
    currentdata.bnd_title_text = "Süper Lig"
    currentdata.bnd_title_left = -185
    currentdata.bnd_logo.id = 68
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    currentdata = UefaInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    currentdata = UefaUelInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
    currentdata = UefaWomensInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], UkraineTeams) and o:isInTable(o.TeamsData[2], UkraineTeams) then
    currentdata = UkraineInfo
    liveLogo.id = 0
  else 
    currentdata = EAFCInfo
    currentdata.bnd_title_left = -185             
    liveLogo.id = 0
  end
  end

  

  currentdata.bnd_stadium_text = o.currentOptions.stadium
  currentdata.bnd_homecrest_image.id = o.TeamsData[1].assetId
  currentdata.bnd_awaycrest_image.id = o.TeamsData[2].assetId
  currentdata.bnd_homeLabel_text = o.TeamsData[1].teamName
  currentdata.bnd_awaylabel_text = o.TeamsData[2].teamName
  currentdata.bnd_homelabel_short = o.services.GameSetupService.GetTeamShortName(HOMETEAM)
  currentdata.bnd_awaylabel_short = o.services.GameSetupService.GetTeamShortName(AWAYTEAM)  

  if o.currentOptions.stadium == "Stadion Signal Iduna Park" then
    currentdata.bnd_stadium_icon.id = 30
  end

  o.im.Subscribe("bnd_live_logo", function()
    o.im.Publish("bnd_live_logo", liveLogo)
  end)  
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

function MatchInfo:handleEvent(eventType, data)
  if eventType == EventTypes.OverlayTypeFixture then
    self:updateMatchInfo(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function MatchInfo:updateMatchInfo(subtype, hideshow, subtypestr, msg)
  print("[MatchInfo]: updateMatchInfo(subtype = " .. tostring(subtype) .. ", hideshow = " .. tostring(hideshow) .. ", subtypestr = " .. tostring(subtypestr) .. ", msg = " .. tostring(msg) .. ")")
  if hideshow ~= "HIDE" then
    local params = OverlayParam.split(msg, "|")
    self.active = true
  else
    self.active = false
  end
  self:_publishActive()
end

function MatchInfo:_publishActive()
  self.im.Publish("bnd_active", self.active)
end

function MatchInfo:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function MatchInfo:getTeamHomeColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.homeColor
      result[2] = v.homeFontColor
    end
  end
  return result
end

function MatchInfo:getTeamAwayColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.awayColor
      result[2] = v.awayFontColor
    end
  end
  return result
end

function MatchInfo:finalize()
  print("[MatchInfo]: finalize()")
  self.im.Unsubscribe("bnd_live_logo")
  self.im.Unsubscribe("bnd_active")
  for k,v in pairs(EnglandInfo) do
    self.im.Unsubscribe(k)
  end

  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end

return MatchInfo