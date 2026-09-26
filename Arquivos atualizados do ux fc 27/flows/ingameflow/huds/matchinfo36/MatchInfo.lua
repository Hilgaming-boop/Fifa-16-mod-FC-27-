-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

local MatchInfo = {}
local OverlaysIdContainer, OverlayParam, eventmanager, TableUtil = ...
local OVERLAY_TYPES = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

leagueIDs = {
  Algeria = 2262,
  Aff = 365,
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
  Italy2 = 32,
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
AffTeams = nil
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
Italy2Teams = nil
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
  { teamid = 1, homeColor = "0x9d1a27", awayColor = "0xBCEE68", homeFontColor = "0xFFFFFF", awayFontColor = "0x000000" },
  { teamid = 2, homeColor = "0x5c253f", awayColor ="0x80a5ca",homeFontColor = "0x80A5CA", awayFontColor = "0xF8D000"},
  { teamid = 5, homeColor = "0x1E90FF", awayColor ="0xcfcecd",homeFontColor = "0xFFFFFF", awayFontColor = "0x1E90FF"},
  { teamid = 7, homeColor = "0x1e406d", awayColor = "0xe19bc7",homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" },
  { teamid = 9, homeColor = "0x942528", awayColor = "0xFFFFFF",homeFontColor = "0xFFFFFF", awayFontColor = "0x000000"},
  { teamid = 10, homeColor = "0x669dc9", awayColor = "0xe8e8e8",homeFontColor = "0xFFFFFF", awayFontColor = "0x669dc9"},
  { teamid = 11, homeColor = "0xb7243b", awayColor ="0x363636",homeFontColor ="0xFFFFFF" , awayFontColor = "0xd8d8d6"},
  { teamid = 13, homeColor = "0xd7d6d5" , awayColor ="0x252845",homeFontColor = "0x000000", awayFontColor = "0xFFFFFF"},
  { teamid = 1796, homeColor = "0x743846", awayColor = "0xffff99",homeFontColor = "0xFFFFFF", awayFontColor = "0x000000"},
  { teamid = 18, homeColor = "0xedecea", awayColor ="0x464a7e",homeFontColor = "0x464A7E", awayFontColor = "0xFFFFFF"},
  { teamid = 19, homeColor = "0x743846" , awayColor = "0xE0E0E0",homeFontColor ="0xFFFFFF" , awayFontColor ="0x743846" },  
  { teamid = 1794, homeColor ="0xff4040" , awayColor = "0xffec8b",homeFontColor = "0xFFFFFF", awayFontColor = "0xFF4040"},  
  { teamid = 1923, homeColor = "0xff6633", awayColor ="0xc7c6ca",homeFontColor = "0xFFFFFF", awayFontColor = "0xFF6633"},  
  { teamid = 14, homeColor = "0xb51e1f", awayColor ="0x669dc9",homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF"},  
  { teamid = 110, homeColor = "0xe8ad1b", awayColor ="0xFF4040",homeFontColor = "0x000000", awayFontColor = "0xFFFFFF"},  
  { teamid = 144, homeColor ="0xe9e8e7" , awayColor ="0x7fcabf",homeFontColor = "0x000000", awayFontColor ="0xbc1e20" },  
  { teamid = 1799, homeColor ="0xd62d25" , awayColor ="0xcbcbc9",homeFontColor = "0xFFFFFF", awayFontColor ="0x202838" },
  { teamid = 1808, homeColor ="0x205da0" , awayColor ="0x98fb98",homeFontColor = "0xFFFFFF", awayFontColor ="0x202838" }, 
  { teamid = 1943, homeColor ="0xae272f" , awayColor ="0x5b669d",homeFontColor = "0xFFFFFF", awayFontColor ="0xFFFFFF" },
  { teamid = 1925, homeColor ="0xb52328" , awayColor ="0x8dabc9",homeFontColor = "0xFFFFFF", awayFontColor ="0x202838" },
}
GermanyTeamsData = {
  { teamid = 21, homeColor = "0xB80018", awayColor = "0xE0E0E0", homeFontColor = "0xE0E0E0", awayFontColor = "0xB80018" },
  { teamid = 22, homeColor = "0xF8D000", awayColor ="0x101010",homeFontColor = "0x101010", awayFontColor = "0xF8D000"},
  { teamid = 23, homeColor = "0xE0E0E0", awayColor ="0x30B060",homeFontColor = "0x30B060", awayFontColor = "0xE0E0E0"},
  { teamid = 31, homeColor = "0xE0E0E0", awayColor = "0xE01820",homeFontColor = "0xE01820", awayFontColor = "0xE0E0E0" },
  { teamid = 32, homeColor = "0xB81020", awayColor = "0x101010",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},
  { teamid = 34, homeColor = "0x2838A0", awayColor = "0xD8D8D8",homeFontColor = "0xE0E0E0", awayFontColor = "0x2838A0"},
  { teamid = 36, homeColor = "0xd3d4d3", awayColor ="0xc62432",homeFontColor ="0xc62432" , awayFontColor = "0xd3d4d3"},
  { teamid = 38, homeColor = "0x289880", awayColor ="0xE1B5AD",homeFontColor ="0xE0E0E0" , awayFontColor = "0x289880"},
  { teamid = 166, homeColor = "0x284090" , awayColor ="0x182038",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},
  { teamid = 169, homeColor = "0xD01818", awayColor = "0xD8D8D8",homeFontColor = "0xD8D8D8", awayFontColor = "0xD01818"},
  { teamid = 175, homeColor = "0x50A830", awayColor ="0x383C3D",homeFontColor = "0xE0E0E0", awayFontColor = "0x50A830"},
  { teamid = 1824, homeColor = "0xd1d1d0" , awayColor = "0x363535",homeFontColor ="0x363535" , awayFontColor ="0xd1d1d0" },  
  { teamid = 10029, homeColor ="0x204390" , awayColor = "0xcec29a",homeFontColor = "0xcec29a", awayFontColor = "0x204390"},  
  { teamid = 100409, homeColor = "0xaa2327", awayColor ="0xd2d1d0",homeFontColor = "0xd2d1d0", awayFontColor = "0xaa2327"},  
  { teamid = 112172, homeColor = "0xf9f8f8", awayColor ="0xa51b21",homeFontColor = "0xa51b21", awayFontColor = "0xf9f8f8"},  
  { teamid = 25, homeColor = "0x9c2225", awayColor ="0x3e4041",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},  
  { teamid = 1831, homeColor ="0xbc1e20" , awayColor ="0xd5cbbb",homeFontColor = "0xd5cbbb", awayFontColor ="0xbc1e20" },  
  { teamid = 160, homeColor ="0x1d3552" , awayColor ="0x65a7d4",homeFontColor = "0xE0E0E0", awayFontColor ="0x202838" },
  { teamid = 111235, homeColor = "0xD72228", awayColor ="0x325EA4",homeFontColor = "0x303F7E", awayFontColor = "0x353544"},  
  { teamid = 110502, homeColor ="0x242948" , awayColor ="0xD2D1D0",homeFontColor = "0xD2D1D0", awayFontColor ="0x242948" } 
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
  { teamid = 576, homeColor = "0x355E9B", awayColor = "0xD4D4D2", homeFontColor = "0xD4D4D2", awayFontColor = "0x355E9B" },
  { teamid = 1832, homeColor = "0x284390", awayColor = "0xF3E8E6", homeFontColor = "0xF3E8E6", awayFontColor = "0x284390" },
  { teamid = 10030, homeColor = "0x2F519B", awayColor = "0xEC242E", homeFontColor = "0xEC242E", awayFontColor = "0x2F519B" },
  { teamid = 110178, homeColor = "0xFEFEFE", awayColor ="0x1B1B1B", homeFontColor = "0x1B1B1B", awayFontColor = "0xFEFEFE"},
  { teamid = 110329, homeColor = "0x4B3A33", awayColor = "0xE3E2E0", homeFontColor = "0xE3E2E0", awayFontColor = "0x4B3A33"},
  { teamid = 110500, homeColor = "0xFFE313", awayColor = "0x2D64B7", homeFontColor = "0x2D64B7", awayFontColor = "0xFFE313"},
  { teamid = 110588, homeColor = "0x0D3362", awayColor ="0x0F0F0F",homeFontColor = "0x0F0F0F", awayFontColor = "0x0D3362"},
  { teamid = 110636, homeColor = "0x891321", awayColor ="0xFFFFFD",homeFontColor = "0xFFFFFD", awayFontColor = "0x891321"}
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
IndonesiaTeamsData = {
  { teamid = 155600, homeColor = "0x000147", awayColor = "0x000147", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 155601, homeColor = "0x430505", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x430505"},
  { teamid = 155602, homeColor = "0x0A49B3", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x0A49B3"},
  { teamid = 155603, homeColor = "0xCD252B", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0xCD252B"},
  { teamid = 155604, homeColor = "0x0D7665", awayColor ="0x0D7665",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 155605, homeColor = "0x0371DF", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x0371DF"},
  { teamid = 155606, homeColor = "0xE6802E", awayColor ="0xE6802E",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 155607, homeColor = "0xffffff", awayColor ="0xBF0B0C",homeFontColor = "0xBF0B0C", awayFontColor = "0xffffff"},
  { teamid = 155610, homeColor = "0xD8D701", awayColor ="0x222222",homeFontColor = "0x101010", awayFontColor = "0xffffff"},
  { teamid = 155611, homeColor = "0x000000", awayColor ="0x000000",homeFontColor = "0xC0885C", awayFontColor = "0xC0885C"},
  { teamid = 155612, homeColor = "0x250D60", awayColor ="0xDB9D15",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155614, homeColor = "0xB52424", awayColor ="0x1BD1CB",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155615, homeColor = "0x007547", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x007547"},
  { teamid = 155616, homeColor = "0x7B0002", awayColor ="0x7B0002",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 155617, homeColor = "0x791D9C", awayColor ="0x791D9C",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 155618, homeColor = "0xA0292B", awayColor = "0xC5A129", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
  { teamid = 155620, homeColor = "0x038DF1", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x038DF1" },
  { teamid = 155621, homeColor = "0xDA3120", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x038DF1" },
}
USANWSLTeamsData = {
	{ teamid = 116300, homeColor ="0x293C6D" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 116302, homeColor ="0x292829" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 116303, homeColor ="0x253050" , awayColor ="0xffffff",homeFontColor = "0x60344B", awayFontColor ="0x000000" },
	{ teamid = 116304, homeColor ="0x000000" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
}
VietnamTeamsData = {
	{ teamid = 150630, homeColor ="0x2A1A5F" , awayColor ="0xE1DE41",homeFontColor = "0xD9AE15", awayFontColor ="0x815CA3"},
	{ teamid = 150631, homeColor ="0x599BDA" , awayColor ="0x599BDA",homeFontColor = "0xffffff", awayFontColor ="0xfffffff"},
	{ teamid = 150632, homeColor ="0x1B263A" , awayColor ="0x0184A8",homeFontColor = "0xffffff", awayFontColor ="0xDEDB2D"},
}
WomensSuperLeagueTeamsData = {
  { teamid = 116009, homeColor = "0x9d1a27", awayColor = "0xBCEE68", homeFontColor = "0xE0E0E0", awayFontColor = "0x000000" },
  { teamid = 116015, homeColor = "0x5c253f", awayColor ="0x743846",homeFontColor = "0x80a5ca", awayFontColor = "0x80a5ca"},
  { teamid = 116013, homeColor ="0x205da0" , awayColor ="0x000000",homeFontColor = "0xE0E0E0", awayFontColor ="0x2e6930" }, 
  { teamid = 116010, homeColor = "0x034694", awayColor ="0x152238",homeFontColor = "0xffffff", awayFontColor = "0x555555"},
  { teamid = 116016, homeColor = "0x003399", awayColor = "0xff4040",homeFontColor = "0xffffff", awayFontColor = "0x152238" },
  { teamid = 116343, homeColor = "0x942528", awayColor = "0xE0E0E0",homeFontColor = "0xE0E0E0", awayFontColor = "0x000000"},
  { teamid = 116017, homeColor = "0x669dc9", awayColor = "0xE0E0E0",homeFontColor = "0xFFFFFF", awayFontColor = "0x6c3b1c"},
  { teamid = 116012, homeColor = "0xB80102", awayColor ="0x25383c",homeFontColor ="0xE0E0E0" , awayFontColor = "0xE0E0E0"},
  { teamid = 116011, homeColor = "0xedecea", awayColor ="0x464a7e",homeFontColor = "0x152238", awayFontColor = "0x848482"},
  { teamid = 116014, homeColor = "0x5c253f" , awayColor = "0xE0E0E0",homeFontColor ="0x80a5ca" , awayFontColor ="0x5c253f" },
  { teamid = 116020, homeColor = "0x2C487F" , awayColor = "0x262625",homeFontColor ="0xFFFFFF" , awayFontColor ="0xB9FFD5" }
}


UnitedStatesInfo = {
  bnd_background_show = true,
  bnd_background_height = 480,
  bnd_background_width = 902,
  bnd_background_top = 90,
  bnd_background_left = 260,
  bnd_background = {
    name = "$Background_Intro",
    id = 39
  },
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
  bnd_background_show = true,
  bnd_background_height = 480,
  bnd_background_width = 902,
  bnd_background_top = 90,
  bnd_background_left = 260,
  bnd_background = {
    name = "$Background_Intro",
    id = 39
  },
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
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 100,
  bnd_label_width = 350,
  bnd_homelabel_left = -173,
  bnd_homelabel_top = 154,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 176,
  bnd_awaylabel_top = 154,
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
  bnd_fontFace = "$Font_Ucl", 
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = 2236
  },
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -175,
  bnd_homelabel_top = 116,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 25,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 240,
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
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID2"
  },
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -210,
  bnd_homelabel_top = 110,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 20,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 110,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 140,
  bnd_crest_image_height = 140,
  bnd_homecrest_left = 5,
  bnd_homecrest_top = -160,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$NationalCrest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -160,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$NationalCrest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 30,
  bnd_stadium_top = 200,
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
    name = "$LeagueLogo",
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
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = 2238
  },
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
    id = "2238_1"
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
    name = "$LeagueLogo",
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
  bnd_background_show = true,
  bnd_background_height = 510,
  bnd_background_width = 1100,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID11"
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -190,
  bnd_homelabel_top = 163,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 28,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 230,
  bnd_awaylabel_top = 163,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 28,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -200,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$EuroCupCrest",
    id = 0
  },
  bnd_awaycrest_left = -15,
  bnd_awaycrest_top = -200,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$EuroCupCrest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 650,
  bnd_stadium_left = 20,
  bnd_stadium_top = 205,
  bnd_stadium_color = "0x749CB4",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  bnd_title_height = 0,
  bnd_title_width = 650,
  bnd_title_left = 0,
  bnd_title_top = -201,
  bnd_title_color = "0x000000",
  bnd_title_text = "UEFA EURO GERMANY",
  bnd_title_fontSize = 24,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 15,
  bnd_match_vs = "",
  bnd_vs_fontSize = 18,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -185,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID11"
  },
  bnd_logo_height = 124,
  bnd_logo_width = 124,
  bnd_logo_left = 0,
  bnd_logo_top = 180,
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
AfcCupInfo = { 
    bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 700,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID13"
    },
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -200,
    bnd_homelabel_top = 100,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 23,
    bnd_homeLabel_fontColor = "0x000000",
    bnd_awaylabel_left = 200,
    bnd_awaylabel_top = 100,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0x000000",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 140,
    bnd_crest_image_height = 140,
    bnd_homecrest_left = 0,
    bnd_homecrest_top = -110,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -110,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 160,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "Stadium",
    bnd_stadium_fontSize = 14,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 2,
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
    bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 700,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID15"
    },
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -200,
    bnd_homelabel_top = -202,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 25,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 180,
    bnd_awaylabel_top = -202,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 25,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 290,
    bnd_crest_image_width = 180,
    bnd_crest_image_height = 180,
    bnd_homecrest_left = -5,
    bnd_homecrest_top = 150,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$AfconCrest",
      id = 0
    },
    bnd_awaycrest_left = 5,
    bnd_awaycrest_top = 150,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$AfconCrest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 65,
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
CoppaItaliaInfo = {
	bnd_fontFace = "$SerieA", 
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
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 61,
    bnd_label_width = 290,
    bnd_homelabel_left = -178,
    bnd_homelabel_top = 177,
    bnd_homeLabel_color = "0xffffff",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 30,
    bnd_homeLabel_fontColor = "0xAA2C1D",
    bnd_awaylabel_left = 182,
    bnd_awaylabel_top = 177,
    bnd_awaylabel_color = "0xffffff",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 30,
    bnd_awaylabel_fontColor = "0xAA2C1D",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 255.5,
    bnd_crest_width = 255,
    bnd_crest_image_width = 160,
    bnd_crest_image_height = 160,
    bnd_homecrest_left = -17,
    bnd_homecrest_top = -158,
    bnd_homecrest_color = "0xAA2C1D",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 18,
    bnd_awaycrest_top = -158,
    bnd_awaycrest_color = "0xAA2C1D",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 50,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = -133,
    bnd_stadium_color = "0xffffff",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 28,
    bnd_stadium_fontColor = "0xAA2C1D",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 50,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -183,
    bnd_title_color = "0xAA2C1D",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "-",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0xAA2C1D",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo",
      id = "CupID16_1"
    },
    bnd_logo_height = 255.5,
    bnd_logo_width = 150,
    bnd_logo_left = 0,
    bnd_logo_top = 203,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$ScoreBoard_Score",
      id = "CupID16"
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
      id = "CupID17"
    },
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
      id = "CupID17_1"
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
ClassicCupInfo = { 
  bnd_background_show = true,
  bnd_background_height = 510,
  bnd_background_width = 1160,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID18"
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -190,
  bnd_homelabel_top = 120,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 230,
  bnd_awaylabel_top = 120,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -120,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -15,
  bnd_awaycrest_top = -120,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 650,
  bnd_stadium_left = 20,
  bnd_stadium_top = 205,
  bnd_stadium_color = "0x749CB4",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xFFB700",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  bnd_title_height = 0,
  bnd_title_width = 650,
  bnd_title_left = 0,
  bnd_title_top = -216,
  bnd_title_color = "0x000000",
  bnd_title_text = "CLASSIC CUP",
  bnd_title_fontSize = 30,
  bnd_title_fontColor = "0xFFB700",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 15,
  bnd_match_vs = "",
  bnd_vs_fontSize = 18,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -185,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID18"
  },
  bnd_logo_height = 114,
  bnd_logo_width = 114,
  bnd_logo_left = 0,
  bnd_logo_top = 195,
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

EAFCInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = "0_ea_dark"
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
AffInfo = {
    bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 800,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = 365
    },
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
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
    bnd_crest_image_width = 140,
    bnd_crest_image_height = 140,
    bnd_homecrest_left = -0,
    bnd_homecrest_top = -130,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$AffCrest",
      id = 0
    },
    bnd_awaycrest_left = 0,
    bnd_awaycrest_top = -130,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$AffCrest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 195,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 19,
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
ArgentinaInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 353
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
BelgiumInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 4
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
BrazilInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 7
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
ChampionshipEflInfo = { 
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 14
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
EgyptInfo = { 
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 2231
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
  bnd_background_height = 380,
  bnd_background_width = 800,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = -40,
  bnd_background = {
    name = "$Background_Intro",
    id = 16
  },
  bnd_background_alpha = 0.9,
  bnd_background_stadium_alpha = 1,
  bnd_background_alpha_1 = 0,
  bnd_label_height = 100,
  bnd_label_width = 300,
  bnd_homelabel_left = -220,
  bnd_homelabel_top = -180,
  bnd_homeLabel_color = "0x132041",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 220,
  bnd_awaylabel_top = 100,
  bnd_awaylabel_color = "0x132041",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 180,
  bnd_crest_width = 180,
  bnd_crest_image_width = 180,
  bnd_crest_image_height = 180,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = 150,
  bnd_homecrest_color = "0x132041",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -150,
  bnd_awaycrest_color = "0x132041",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 800,
  bnd_stadium_left = 1,
  bnd_stadium_top = 230,
  bnd_stadium_color = "0x07215c",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 30,
  bnd_title_height = 50,
  bnd_title_width = 0,
  bnd_title_left = 1,
  bnd_title_top = 23000,
  bnd_title_color = "0x06215b",
  bnd_title_text = "",
  bnd_title_fontSize = 25,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 80,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "16_1"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 168,
  bnd_logo_left = 10000,
  bnd_logo_top = 0,
  bnd_logo_alpha = 0,
  bnd_stadium_icon = {
    name = "$LeagueLogo",
    id = "16_1"
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 168,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 600,

  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
}
France2Info = {
  bnd_fontFace = "$Ligue1",
  bnd_background_show = true,
  bnd_background_height = 380,
  bnd_background_width = 800,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = -40,
  bnd_background = {
    name = "$Background_Intro",
    id = 17
  },
  bnd_background_alpha = 0.9,
  bnd_background_stadium_alpha = 1,
  bnd_background_alpha_1 = 0,
  bnd_label_height = 100,
  bnd_label_width = 300,
  bnd_homelabel_left = -220,
  bnd_homelabel_top = -180,
  bnd_homeLabel_color = "0x132041",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 40,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 220,
  bnd_awaylabel_top = 100,
  bnd_awaylabel_color = "0x132041",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 40,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 180,
  bnd_crest_width = 180,
  bnd_crest_image_width = 180,
  bnd_crest_image_height = 180,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = 150,
  bnd_homecrest_color = "0x132041",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -150,
  bnd_awaycrest_color = "0x132041",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 800,
  bnd_stadium_left = 1,
  bnd_stadium_top = 230,
  bnd_stadium_color = "0x07215c",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 30,
  bnd_title_height = 50,
  bnd_title_width = 0,
  bnd_title_left = 1,
  bnd_title_top = 23000,
  bnd_title_color = "0x06215b",
  bnd_title_text = "",
  bnd_title_fontSize = 25,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 80,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = -20000,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "17_1"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 168,
  bnd_logo_left = 10000,
  bnd_logo_top = 0,
  bnd_logo_alpha = 0,
  bnd_stadium_icon = {
    name = "$LeagueLogo",
    id = "17_1"
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 168,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 600,

  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homeLabel_rect_left = -100,
  bnd_homeLabel_rect_top = -150,

  bnd_awayLabel_rect_left = 100,
  bnd_awayLabel_rect_top = -150
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
  bnd_background_height = 470,
  bnd_background_width = 850,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 10,
  bnd_background = {
    name = "$Background_Intro",
    id = 2235
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height =50,
  bnd_label_width = 430,
  bnd_homelabel_left = -210,
  bnd_homelabel_top = 154,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 210,
  bnd_awaylabel_top = 154,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 300,
  bnd_crest_width = 430,
  bnd_crest_image_width = 160,
  bnd_crest_image_height = 160,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -160,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -160,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 700,
  bnd_stadium_left = 180,
  bnd_stadium_top = -200,
  bnd_stadium_color = "0x313131",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  bnd_title_height = 0,
  bnd_title_width = 700,
  bnd_title_left = 31,
  bnd_title_top = 210,
  bnd_title_color = "",
  bnd_title_text = "SATURDAY, MARCH 17, 2024",
  bnd_title_fontSize = 30,
  bnd_title_fontColor = "0x113A6F",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 110,
  bnd_match_vs = "Indonesian, West Java",
  bnd_vs_fontSize = 12,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -170,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2235_1"
  },
  bnd_logo_height = 250,
  bnd_logo_width = 480,
  bnd_logo_left = 75,
  bnd_logo_top = -200,
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
InternationalInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 78
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
International2Info = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 2136
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
ItalyInfo = {
  bnd_fontFace = "$SerieA", 
  bnd_background_show = true,
  bnd_background_height = FILL,
  bnd_background_width = FILL,
  bnd_background = {
    name = "$Background_Intro",
    id = 31
  },
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -235,
  bnd_homelabel_top = 195,
  bnd_homeLabel_color = "0x191c25",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 30,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 245,
  bnd_awaylabel_top = 195,
  bnd_awaylabel_color = "0x191c25",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 180,
  bnd_crest_image_height = 180,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -170,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -170,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 1,
  bnd_stadium_top = -135,
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
  bnd_vs_fontSize = 40,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -60,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 31
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


Italy2Info = {
	bnd_fontFace = "$SerieA", 
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
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 61,
    bnd_label_width = 290,
    bnd_homelabel_left = -178,
    bnd_homelabel_top = 177,
    bnd_homeLabel_color = "0xffffff",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 30,
    bnd_homeLabel_fontColor = "0x018619",
    bnd_awaylabel_left = 182,
    bnd_awaylabel_top = 177,
    bnd_awaylabel_color = "0xffffff",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 30,
    bnd_awaylabel_fontColor = "0x018619",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 255.5,
    bnd_crest_width = 255,
    bnd_crest_image_width = 160,
    bnd_crest_image_height = 160,
    bnd_homecrest_left = -17,
    bnd_homecrest_top = -158,
    bnd_homecrest_color = "0x018619",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 18,
    bnd_awaycrest_top = -158,
    bnd_awaycrest_color = "0x018619",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 50,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = -133,
    bnd_stadium_color = "0xffffff",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 28,
    bnd_stadium_fontColor = "0x018619",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 50,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -183,
    bnd_title_color = "0x018619",
    bnd_title_text = "",
    bnd_title_fontSize = 30,
    bnd_title_fontColor = "0xffffff",
    bnd_title_text_alignH = "CENTER",
    bnd_title_text_left = 0,
    bnd_match_vs = "-",
    bnd_vs_fontSize = 26,
    bnd_vs_fontColor = "0x018619",
    bnd_vs_left = -2,
    bnd_vs_top = 177,
    bnd_logo = {
      name = "$LeagueLogo",
      id = 32
    },
    bnd_logo_height = 255.5,
    bnd_logo_width = 150,
    bnd_logo_left = 0,
    bnd_logo_top = 203,
    bnd_logo_alpha = 1,
    bnd_stadium_icon = {
      name = "$ScoreBoard_Score",
      id = "32_1"
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
    name = "$LigaFCrest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = 240,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$LigaFCrest",
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
MalaysiaInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 2237
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
MexicoInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = "341_1"
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
MoroccoInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 2250
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
NetherlandsInfo = { 
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 10
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
RestOfWorldInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 76
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
ScotlandInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 50
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
SouthAfricaInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 347
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
TurkeyInfo = {
 bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 0
  },
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
    id = 68
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
UkraineInfo = {
  bnd_background_show = true,
  bnd_background_height = 550,
  bnd_background_width = 1347,
  bnd_background_top = 50,
  bnd_background = {
    name = "$Background_Intro",
    id = 1
  },
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
    id = "CupID19"
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
  bnd_background_show = true,
  bnd_background_height = 510,
  bnd_background_width = 1100,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$Background_Intro",
    id = "CupID20"
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -270,
  bnd_homelabel_top = 185,
  bnd_homeLabel_color = "0x39003E",
  bnd_homeLabel_text = "",
  bnd_homeLabel_fontSize = 25,
  bnd_homeLabel_fontColor = "0xffffff",
  bnd_awaylabel_left = 270,
  bnd_awaylabel_top = 185,
  bnd_awaylabel_color = "0x39003E",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 25,
  bnd_awaylabel_fontColor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  bnd_awayLabel_alignH = "CENTER",
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 45,
  bnd_crest_image_height = 45,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = 0,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 240,
  bnd_awaycrest_top = 0,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 650,
  bnd_stadium_left = 5,
  bnd_stadium_top = 133,
  bnd_stadium_color = "0x749CB4",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 19,
  bnd_stadium_fontColor = "0x4DF81E",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  bnd_title_height = 0,
  bnd_title_width = 650,
  bnd_title_left = 0,
  bnd_title_top = -201,
  bnd_title_color = "0x000000",
  bnd_title_text = "",
  bnd_title_fontSize = 24,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 15,
  bnd_match_vs = "",
  bnd_vs_fontSize = 18,
  bnd_vs_fontColor = "0xffffff",
  bnd_vs_left = 0,
  bnd_vs_top = -185,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID11"
  },
  bnd_logo_height = 124,
  bnd_logo_width = 124,
  bnd_logo_left = 0,
  bnd_logo_top = 180,
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
CopaLibertadoresInfo = {
    bnd_forceCaps = true,  
    bnd_background_show = true,
    bnd_background_height = 450,
    bnd_background_width = 850,
    bnd_background_alignH = "CENTER",
    bnd_background_alignV = "CENTER",
    bnd_background_top = 0,
    bnd_background = {
      name = "$Background_Intro",
      id = "CupID21"
    },
    bnd_background_alpha = 1,
    bnd_background_alpha_1 = 1,
    bnd_background_stadium_alpha = 1,
    bnd_label_height = 0,
    bnd_label_width = 290,
    bnd_homelabel_left = -170,
    bnd_homelabel_top = -145,
    bnd_homeLabel_color = "0x044C7C",
    bnd_homeLabel_text = "",
    bnd_homeLabel_fontSize = 15,
    bnd_homeLabel_fontColor = "0xffffff",
    bnd_awaylabel_left = 160,
    bnd_awaylabel_top = -145,
    bnd_awaylabel_color = "0x044C7C",
    bnd_awaylabel_text = "",
    bnd_awaylabel_fontSize = 15,
    bnd_awaylabel_fontColor = "0xffffff",
    bnd_homeLabel_alignH = "CENTER",
    bnd_awayLabel_alignH = "CENTER",
    bnd_crest_height = 0,
    bnd_crest_width = 255,
    bnd_crest_image_width = 100,
    bnd_crest_image_height = 100,
    bnd_homecrest_left = -5,
    bnd_homecrest_top = 125,
    bnd_homecrest_color = "0x586cf8",
    bnd_homecrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_awaycrest_left = 10,
    bnd_awaycrest_top = 125,
    bnd_awaycrest_color = "0x586cf8",
    bnd_awaycrest_image = {
      name = "$Crest",
      id = 0
    },
    bnd_stadium_height = 0,
    bnd_stadium_width = 650,
    bnd_stadium_left = 2,
    bnd_stadium_top = 142,
    bnd_stadium_color = "0x749CB4",
    bnd_stadium_text = "",
    bnd_stadium_fontSize = 15,
    bnd_stadium_fontColor = "0xffffff",
    bnd_stadium_text_alignH = "CENTER",
    bnd_stadium_text_left = 0,
    bnd_title_height = 0,
    bnd_title_width = 650,
    bnd_title_left = 2,
    bnd_title_top = -120.5,
    bnd_title_color = "0x044C7C",
    bnd_title_text = "Conmebol Libertadores",
    bnd_title_fontSize = 15,
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
      id = "CupID21"
    },
    bnd_logo_height = 75,
    bnd_logo_width = 70,
    bnd_logo_left = 0,
    bnd_logo_top = 150,
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
CopaAmericaInfo = { 
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
  bnd_stadium_color = "0x0C1D83",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 40,
  bnd_title_width = 510,
  bnd_title_left = 0,
  bnd_title_top = -212,
  bnd_title_color = "0xB40309",
  bnd_title_text = "Copa America",
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
    id = "CupID23"
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
  AlgeriaTeams = o.services.TeamService.GetTeams(leagueIDs.Algeria, 0, 0, true)
  AffTeams = o.services.TeamService.GetTeams(leagueIDs.Aff, 0, 0, true)
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
  Italy2Teams = o.services.TeamService.GetTeams(leagueIDs.Italy2, 0, 0, true)
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
      liveLogo.id = 22
      elseif currentCupData.cupIndex == 2 then
      currentdata = WorldCupInfo
      liveLogo.id = 24
      elseif currentCupData.cupIndex == 3 then
      currentdata = UefaUelInfo
      liveLogo.id = 22
      elseif currentCupData.cupIndex == 4 then
      currentdata = PialaIndonesiaInfo
      liveLogo.id = 25
      elseif currentCupData.cupIndex == 5 then
      currentdata = WcWomenInfo
      liveLogo.id = 26
      elseif currentCupData.cupIndex == 6 then
      currentdata = UefaWomensInfo
      liveLogo.id = 18
      elseif currentCupData.cupIndex == 7 then
      currentdata = FaCupInfo
      liveLogo.id = 27
      elseif currentCupData.cupIndex == 8 then
      currentdata = UeclInfo
      liveLogo.id = 22
      elseif currentCupData.cupIndex == 9 then
      currentdata = AsianCupInfo
      liveLogo.id = 1
      elseif currentCupData.cupIndex == 10 then
      currentdata = KingSaudiCupInfo
      liveLogo.id = 38
      elseif currentCupData.cupIndex == 11 then
      currentdata = EuroCupInfo
      liveLogo.id = 22
      elseif currentCupData.cupIndex == 12 then
      currentdata = UsaOpenCupInfo
      liveLogo.id = 29
      elseif currentCupData.cupIndex == 13 then
      currentdata = AfcCupInfo
      liveLogo.id = 28
      elseif currentCupData.cupIndex == 14 then
      currentdata = CopaDelReyInfo
      liveLogo.id = 30
      elseif currentCupData.cupIndex == 15 then
      currentdata = AfricaCupInfo
      liveLogo.id = 32
      elseif currentCupData.cupIndex == 16 then
      currentdata = CoppaItaliaInfo
      currentdata.bnd_title_text = "COPPA ITALIA"
      liveLogo.id = 31
      elseif currentCupData.cupIndex == 17 then
      currentdata = DfbPokalInfo
      liveLogo.id = 33
      elseif currentCupData.cupIndex == 18 then
      currentdata = ClassicCupInfo
      liveLogo.id = 34
      elseif currentCupData.cupIndex == 19 then
      currentdata = CoupeDeFranceInfo
      liveLogo.id = 35
      elseif currentCupData.cupIndex == 20 then
      currentdata = FcwcInfo
      liveLogo.id = 36
      elseif currentCupData.cupIndex == 21 then
      currentdata = CopaLibertadoresInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 22 then
      currentdata = UefaNationsInfo
      liveLogo.id = 22
      elseif currentCupData.cupIndex == 23 then
      currentdata = CopaAmericaInfo
      liveLogo.id = 0
      elseif currentCupData.cupIndex == 24 then
      currentdata = CarabaoCupInfo
      liveLogo.id = 0
    end
  else
     if o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
    currentdata = UnitedStatesInfo
    liveLogo.id = 23
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
    liveLogo.id = 9
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
    currentdata = VietnamInfo
    liveLogo.id = 37
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
    elseif o:isInTable(o.TeamsData[1], AffTeams) and o:isInTable(o.TeamsData[2], AffTeams) then
    currentdata = AffInfo
    liveLogo.id = 1
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
    currentdata = ArgentinaInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
    currentdata = AsianCupU23Info
    liveLogo.id = 1
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    currentdata = BelgiumInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    currentdata = BrazilInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    currentdata = ClassicCupInfo
    currentdata.bnd_title_text = "Classic"
    liveLogo.id = 34
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    currentdata = ClassicCupInfo
    currentdata.bnd_title_text = "Classic 2"
    liveLogo.id = 34
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    currentdata = ChampionshipEflInfo
    liveLogo.id = 6
    elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    currentdata = DenmarkInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    currentdata = D1ArkemaInfo
    liveLogo.id = 5
    elseif o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    currentdata = EcuadorInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    currentdata = EgyptInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    currentdata = EnglandInfo
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, EnglandTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, EnglandTeamsData)
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    liveLogo.id = 2
    elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    currentdata = FranceInfo
   liveLogo.id = 3
    elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    currentdata = France2Info
    liveLogo.id = 4
    elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    currentdata = GermanyInfo
    liveLogo.id = 11
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
    liveLogo.id = 12
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
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, IndonesiaTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, IndonesiaTeamsData)
    currentdata.bnd_homeLabel_color = homeColorList[1]
    currentdata.bnd_homecrest_color = homeColorList[1]
    currentdata.bnd_homeLabel_fontColor = homeColorList[2]
    currentdata.bnd_awaylabel_color = awayColorList[1]
    currentdata.bnd_awaycrest_color = awayColorList[1]
    currentdata.bnd_awaylabel_fontColor = awayColorList[2]
    liveLogo.id = 14
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    currentdata = InternationalInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    currentdata = International2Info
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    currentdata = ItalyInfo
    liveLogo.id = 15
    elseif o:isInTable(o.TeamsData[1], Italy2Teams) and o:isInTable(o.TeamsData[2], Italy2Teams) then
    currentdata = Italy2Info
    liveLogo.id = 16
    currentdata.bnd_title_text = "SERIE B TIM"
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    currentdata = LeagueOneEflInfo
    liveLogo.id = 7
    elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
    currentdata = LeagueTwoEflInfo
    liveLogo.id = 8
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    currentdata = LigaFInfo
    liveLogo.id = 18
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    currentdata = MalaysiaInfo
    liveLogo.id = 17
    elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    currentdata = MexicoInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    currentdata = MoroccoInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    currentdata = NetherlandsInfo
    liveLogo.id = 39
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    currentdata = PegadaianLiga2Info
    liveLogo.id = 14
    elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    currentdata = PortugalInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    currentdata = RestOfWorldInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    currentdata = RestOfWorldInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], RusiaTeams) and o:isInTable(o.TeamsData[2], RusiaTeams) then
    currentdata = RusiaInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    currentdata = SaudiArabiaInfo
    liveLogo.id = 19
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    currentdata = ScotlandInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    currentdata = SouthAfricaInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    currentdata = SpainInfo
    liveLogo.id = 20
    elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    currentdata = Spain2Info
    liveLogo.id = 21
    elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    currentdata = SwitzerlandInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
    currentdata = ThailandInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    currentdata = TurkeyInfo
    liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    currentdata = UefaInfo
    liveLogo.id = 22
    elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    currentdata = UefaUelInfo
    liveLogo.id = 22
    elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
    currentdata = UefaWomensInfo
    liveLogo.id = 18
    elseif o:isInTable(o.TeamsData[1], UkraineTeams) and o:isInTable(o.TeamsData[2], UkraineTeams) then
    currentdata = UkraineInfo
  else 
    currentdata = EAFCInfo
    liveLogo.id = 0
  end
  end

  

  currentdata.bnd_stadium_text = o.currentOptions.stadium
  currentdata.bnd_homecrest_image.id = o.TeamsData[1].assetId
  currentdata.bnd_awaycrest_image.id = o.TeamsData[2].assetId
  currentdata.bnd_homeLabel_text = o.TeamsData[1].teamName
  currentdata.bnd_awaylabel_text = o.TeamsData[2].teamName

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