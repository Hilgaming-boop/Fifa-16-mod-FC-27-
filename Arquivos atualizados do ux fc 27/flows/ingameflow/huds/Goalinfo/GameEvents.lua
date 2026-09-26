-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

print("GameEvents.lua")
local GameEvents = {}
local OverlaysIdContainer, OverlayParam, eventmanager = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes
local BND_VISIBLE = "bnd_visible"
local BND_VISIBLE = "bnd_visible"
local BND_SCALE_X = "bnd_scale_x"
local BND_SCALE_Y = "bnd_scale_y"
local BND_ALPHA = "bnd_alpha"

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
   Italy2 = 32,   
   Japan = 349,
   KoreaRepublic = 83,
   LeagueOneEfl = 60,
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
IndonesiaTeamsData = {
  { teamid = 155600, homeColor = "0x1E42A0", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xC9A867" },
  { teamid = 155601, homeColor = "0xC41D18", awayColor = "0xD8E6D8", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155602, homeColor = "0x0333AC", awayColor = "0xF7F8F6", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155603, homeColor = "0xE72629", awayColor = "0xffffff", homeFontColor = "0xFDD05D", awayFontColor = "0x000000" },
  { teamid = 155604, homeColor = "0x046333", awayColor = "0xFF0505", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 155605, homeColor = "0x1C1AEE", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x1C1AEE" },
  { teamid = 155606, homeColor = "0xE15C2D", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155607, homeColor = "0xC41D18", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155610, homeColor = "0xF2E705", awayColor = "0x000000", homeFontColor = "0x000000", awayFontColor = "0xffffff" },
  { teamid = 155611, homeColor = "0x000000", awayColor = "0xCE841F", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 155612, homeColor = "0x4F149F", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155614, homeColor = "0xBC0202", awayColor = "0x000000", homeFontColor = "0xffffff", awayFontColor = "0xffffff" },
  { teamid = 155615, homeColor = "0x1B9959", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155616, homeColor = "0xBA0505", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155617, homeColor = "0x402966", awayColor = "0xFFE0DE", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155618, homeColor = "0x9E282A", awayColor = "0xBE9B28", homeFontColor = "0xffffff", awayFontColor = "0x1B9959" },
  { teamid = 155620, homeColor = "0x6AA5B0", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x6AA5B0" },
  { teamid = 155621, homeColor = "0xC4281B", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xC4281B" },
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


bndList = {
  "bnd_homename_text",
  "bnd_homecrest",
  "bnd_awayname_text",
  "bnd_awaycrest",
  "bnd_score_text",
  "bnd_homescore_text",
  "bnd_awayscore_text",
  "bnd_homeScore_text",
  "bnd_awayScore_text",
  "bnd_homemessage_text",
  "bnd_awaymessage_text",
  "bnd_title_text"
}

EAFCInfo = {
  bnd_fontFace = "$Epl",
  bnd_short_name_visible = true,
  bnd_text_bold = true,
  bnd_background_show = true,
  bnd_background_height = 170,
  bnd_background_width = 870,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = -25,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 1,

  bnd_event_height = 50,
  bnd_event_width = 800,
  bnd_event_top = -48,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 50,
  bnd_homename_width = 300,
  bnd_homename_color = "0x000000",
  bnd_homename_left = 0,
  bnd_homename_text_left = 40,
  bnd_awayname_text_right = 40,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 50,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x000000",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 250,
  bnd_score_right = -40,
  bnd_score_left = -40,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -48,
  bnd_homecrest_left = -75,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -48,
  bnd_awaycrest_right = -65,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 20,
  bnd_message_width = 250,
  bnd_homemessage_top = -25,
  bnd_homemessage_left = -210,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -25,
  bnd_awaymessage_left = 210,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 50,
  bnd_logo_width = 50,
  bnd_logo_top = -115,
  bnd_logo_left = 0,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logowidth = 50,
  bnd_logoheight = 50,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -75,
  bnd_title_left = -10,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 15,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
AlgeriaInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -70,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2262
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "LIGUE 1 PROFESSIONNELLE",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
AfcInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = " CupID4"
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x94DF2A",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x31146B",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x31146B",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "•",
  bnd_score_visible = false,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -30,
  bnd_score_left = -30,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -90,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -90,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = -35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x270551",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
AsianCupU23Info = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 2264
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = 0,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = 0,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 39,
  bnd_event_width = 800,
  bnd_event_top = -54,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 325,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 15,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 15,
  bnd_awayname_height = 0,
  bnd_awayname_width = 325,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 0,
  bnd_score_right = -30,
  bnd_score_left = -30,
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -55,
  bnd_homecrest_left = -105,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 61,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -55,
  bnd_awaycrest_right = -105,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 61,
  bnd_awaycrest_width = 60,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = -36,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 14,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -36,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -36,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0x000000",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 14,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
DenmarkInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -65,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "1_1"
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "3F SUPER LIGA",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
EcuadorInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -65,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2018
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "Ecuador Serie-A",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
D1ArkemaInfo = {
  bnd_background_show = true,
  bnd_background_height = 95,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = 2218
  },
  bnd_background_bottom = 46,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 50,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 50,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 5,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,

  bnd_awayname_text_left = 150,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "LEFT",
  bnd_awayname_right = 35,
  bnd_awayname_height = 50,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_name_text_top = 0,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 160,
  bnd_score_right = -105,
  bnd_score_left = -130,
  bnd_score_color = "0xffffff",
  bnd_score_fontSize = 38,
  bnd_score_text_top = 0,

  bnd_crest_height = 90,
  bnd_crest_width = 90,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -100,
  bnd_homecrest_left = 105,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 42,
  bnd_homecrest_width = 42,

  bnd_awaycrest_top = -100,
  bnd_awaycrest_right = 130,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 42,
  bnd_awaycrest_width = 42,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

   bnd_message_height = 28,
  bnd_message_width = 303,
  bnd_homemessage_top = 38,
  bnd_homemessage_left = -249,
  bnd_homemessage_color = "0x6772B2",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 15,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 290,
  bnd_message_width = 303,
  bnd_awaymessage_top = 38,
  bnd_awaymessage_left = 249,
  bnd_awaymessage_color = "0x6772B2",
  bnd_awaymessage_text = "",
 
  
  bnd_logo_height = 36,
  bnd_logo_width = 300,
  bnd_logo_top = -30,
  bnd_logo_left = -15,
  bnd_logo_color_visible = true,
  bnd_logo_color = "",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 265,
  bnd_logoheight = 35,
  
  bnd_title_height = 35,
  bnd_title_width = 100,
  bnd_title_top = 60,
  bnd_title_left = -10,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
EnglandInfo = {
  bnd_fontFace = "$Epl", 
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background = {
    name = "$GameEvent",
    id = 13
  },
  bnd_background_bottom = 0,
  bnd_color_alpha = 0,
  bnd_home_rect_left = 0,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = 0,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 75,
  bnd_name_text_top = 0,
  bnd_score_text_top = -2,

  bnd_event_height = 50,
  bnd_event_width = 800,
  bnd_event_top = -50,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_height = 20,
  bnd_homename_width = 420,
  bnd_homename_color = "0xffffff",
  bnd_homename_left = -20,
  bnd_homename_text_left = -30,
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_text_right = -30,
  bnd_awayname_text = "",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = -20,
  bnd_awayname_height = 20,
  bnd_awayname_width = 420,
  bnd_awayname_color = "0xffffff",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_text = "",
  bnd_score_height = 0,
  bnd_score_width = 0,
  bnd_score_right = -55,
  bnd_score_left = -55,
  bnd_score_color = "",
  bnd_crest_color_visible = false,
  bnd_crest_height = 85,
  bnd_crest_width = 85,
  bnd_homecrest_top = -40,
  bnd_homecrest_left = -100,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 85,
  bnd_homecrest_width = 85,
  bnd_awaycrest_top = -40,
  bnd_awaycrest_right = -100,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg_height = 0,
  bnd_score_bg_width = 0,
  bnd_score_bg_top = -5,
  bnd_score_bg_left = 0,
  bnd_score_bg_color_visible = false,
  bnd_score_bg_color = "",
  bnd_score_bg = {
    name = "$LeagueLogo",
    id = 133
  },
  bnd_score_bg_visible = true,
 
  bnd_scorebgwidth = 210,
  bnd_scorebgheight = 103,  

  bnd_message_height = 30,
  bnd_message_width = 370,
  bnd_homemessage_top = 40,
  bnd_homemessage_left = -230,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_text = "",
  bnd_homemessage_text_left = 40,
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0x460240",
  bnd_message_text_width = 300,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 40,
  bnd_awaymessage_left = 230,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_text = "",
  bnd_awaymessage_text_right = 350,
 
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 40,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x460240",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 15,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
FranceInfo = {
  bnd_fontFace = "$Ligue1", 
  bnd_background_show = true,
  bnd_background_height = 115,
  bnd_background_width = 850,
  bnd_background = {
    name = "$GameEvent",
    id = 16
  },
  bnd_background_bottom = 33,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 50,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -77,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 50,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,

  bnd_awayname_text_left = 150,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "LEFT",
  bnd_awayname_right = 100,
  bnd_awayname_height = 50,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_name_text_top = 0,

  bnd_score_text = "",
  bnd_score_visible = false, 
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 160,
  bnd_score_right = 0,
  bnd_score_left = 0,
  bnd_score_color = "0x061329",
  bnd_score_fontSize = 20,
  bnd_score_text_top = 0,

  bnd_crest_height = 90,
  bnd_crest_width = 90,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -81,
  bnd_homecrest_left = 235,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -81,
  bnd_awaycrest_right = 230,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 0,
  bnd_message_width = 290,
  bnd_homemessage_top = -38.5,
  bnd_homemessage_left = -230,
  bnd_homemessage_color = "0x6F0936",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 14,
  bnd_message_fontColor = "0xffffff",

  bnd_awaymessage_right = 275,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -38.5,
  bnd_awaymessage_left = 260,
  bnd_awaymessage_color = "0x6F0936",
  bnd_awaymessage_text = "",
 
  
  bnd_logo_height = 36,
  bnd_logo_width = 300,
  bnd_logo_top = -30,
  bnd_logo_left = -15,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2236
  },
  bnd_logowidth = 265,
  bnd_logoheight = 35,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x6F0936",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
France2Info = {
  bnd_fontFace = "$Ligue1", 
  bnd_background_show = true,
  bnd_background_height = 115,
  bnd_background_width = 850,
  bnd_background = {
    name = "$GameEvent",
    id = 17
  },
  bnd_background_bottom = 33,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 50,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -77,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 50,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,

  bnd_awayname_text_left = 150,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "LEFT",
  bnd_awayname_right = 100,
  bnd_awayname_height = 50,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_name_text_top = 0,

  bnd_score_text = "",
  bnd_score_visible = false, 
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 160,
  bnd_score_right = 0,
  bnd_score_left = 0,
  bnd_score_color = "0x061329",
  bnd_score_fontSize = 20,
  bnd_score_text_top = 0,

  bnd_crest_height = 90,
  bnd_crest_width = 90,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -81,
  bnd_homecrest_left = 235,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -81,
  bnd_awaycrest_right = 230,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 0,
  bnd_message_width = 290,
  bnd_homemessage_top = -38.5,
  bnd_homemessage_left = -230,
  bnd_homemessage_color = "0x6F0936",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 14,
  bnd_message_fontColor = "0xffffff",

  bnd_awaymessage_right = 275,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -38.5,
  bnd_awaymessage_left = 260,
  bnd_awaymessage_color = "0x6F0936",
  bnd_awaymessage_text = "",
 
  
  bnd_logo_height = 36,
  bnd_logo_width = 300,
  bnd_logo_top = -30,
  bnd_logo_left = -15,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2236
  },
  bnd_logowidth = 265,
  bnd_logoheight = 35,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x6F0936",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
GermanyInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Bundesliga",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 19
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 19
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
Germany2Info = {
  bnd_fontFace = "$Bundesliga", 
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 0,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 50,
  bnd_event_width = 600,
  bnd_event_top = -50,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 24,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_height = 50,
  bnd_homename_width = 420,
  bnd_homename_color = "0x38003d",
  bnd_homename_left = -170,
  bnd_homename_text_left = 0,
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = -170,
  bnd_awayname_height = 50,
  bnd_awayname_width = 420,
  bnd_awayname_color = "0x38003d",
  bnd_score_visible = false,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_text = "",
  bnd_score_height = 60,
  bnd_score_width = 100,
  bnd_score_right = 0,
  bnd_score_left = 0,
  bnd_score_color = "0x2e2b2e",
  bnd_crest_color_visible = true,
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_homecrest_top = -65,
  bnd_homecrest_left = -130,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -65,
  bnd_awaycrest_right = -130,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 400,
  bnd_homemessage_top = -40,
  bnd_homemessage_left = -205,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_text = "",
  bnd_homemessage_text_left = 10,
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0x38003d",
  bnd_message_text_width = 340,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = -40,
  bnd_awaymessage_left = 205,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_text = "",
  bnd_awaymessage_text_right = 350,

  bnd_logo_height = 50,
  bnd_logo_width = 80,
  bnd_logo_top = -10500,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "13_white"
  },
  bnd_logowidth = 34,
  bnd_logoheight = 40,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -40,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0x2e2b2e",
  bnd_title_fontSize = 20,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
IndonesiaInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 3
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2235
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
ItalyInfo = {
  bnd_background_show = true,
  bnd_background_height = 120,
  bnd_background_width = 760,
  bnd_background = {
    name = "$GameEvent",
    id = 31
  },
  bnd_background_bottom = -16,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -60,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x061329",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x04259A",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 200,
  bnd_score_right = -43,
  bnd_score_left = -50,
  bnd_score_color = "0x061329",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = 210,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 50,
  bnd_homecrest_width = 50,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = 210,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 50,
  bnd_awaycrest_width = 50,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 24,
  bnd_message_width = 280,
  bnd_homemessage_top = 61,
  bnd_homemessage_left = -200,
  bnd_homemessage_color = "0x03215D",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 14,
  bnd_message_fontColor = "0xffffff",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 61,
  bnd_awaymessage_left = 200,
  bnd_awaymessage_color = "0x03215D",
  bnd_awaymessage_text = "",

  
  bnd_logo_height = 0,
  bnd_logo_width = 0,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x04259A",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 0,
  bnd_logoheight = 0,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_top = -105,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x04259A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
JapanInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 100,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 349
  },
  bnd_background_bottom = 2,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = -3,
  bnd_score_text_top = -3,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -47,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -25,
  bnd_score_left = -30,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = -40,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -40,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -40,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0x000000",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
LeagueOneEflInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -65,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 60
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "football league 1",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
LigaFInfo = {
  bnd_forceCaps = true, 
  bnd_background_show = true,
  bnd_background_height = 95,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = 2222
  },
  bnd_background_bottom = 46,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 50,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -83,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 23,
  bnd_event_fontColor = "0x00295F",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 50,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,

  bnd_awayname_text_left = 150,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "LEFT",
  bnd_awayname_right = 100,
  bnd_awayname_height = 50,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_name_text_top = 0,

  bnd_score_text = "",
  bnd_score_visible = false, 
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 160,
  bnd_score_right = 0,
  bnd_score_left = 0,
  bnd_score_color = "0xffffff",
  bnd_score_fontSize = 28,
  bnd_score_text_top = 0,

  bnd_crest_height = 90,
  bnd_crest_width = 90,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -75,
  bnd_homecrest_left = -108,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,

  bnd_awaycrest_top = -75,
  bnd_awaycrest_right = -108,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 0,
  bnd_message_width = 290,
  bnd_homemessage_top = 25,
  bnd_homemessage_left = -190,
  bnd_homemessage_color = "0x6F0936",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 14,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 275,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 25,
  bnd_awaymessage_left = 195,
  bnd_awaymessage_color = "0x6F0936",
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 36,
  bnd_logo_width = 300,
  bnd_logo_top = -30,
  bnd_logo_left = -15,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2236
  },
  bnd_logowidth = 265,
  bnd_logoheight = 35,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 28,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x6F0936",
  bnd_title_fontColor = "0x00295F",
  bnd_title_fontSize = 15,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
MalaysiaInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Malaysia",
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 2237
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -48,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x0004DF",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x06F0EF",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x06F0EF",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -65,
  bnd_score_left = -65,
  bnd_score_color = "0x0004DF",
  bnd_crest_height = 84.5,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -75,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 95,
  bnd_homecrest_width = 95,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -75,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 95,
  bnd_awaycrest_width = 95,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = -40,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0x0004DF",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -40,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 30,
  bnd_logo_width = 35,
  bnd_logo_top = -45,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "39_1"
  },
  bnd_logowidth = 50,
  bnd_logoheight = 50,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -90,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x0004DF",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
PegadaianLiga2Info = { 
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 100,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 2,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = -3,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -47,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0xAEDE26",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -30,
  bnd_score_left = -30,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = -40,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -40,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -40,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xAEDE26",
  bnd_title_fontColor = "0x0D6046",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
RusiaInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -65,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 67
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "Rusia League",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
SaudiArabiaInfo = {
  bnd_forceCaps = true,  
  bnd_fontFace = "$SPL",  
  bnd_background_show = true,
  bnd_background_height = 130,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = 350
  },
  bnd_background_bottom = -1,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 35,
  bnd_name_text_top = -5,
  bnd_score_text_top = -5,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 30,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xFFFFFF",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xFFFFFF",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -54,
  bnd_score_left = -55,
  bnd_score_color = "0x000000",
  bnd_crest_height = 85,
  bnd_crest_width = 80,
  bnd_crest_color_visible = true,
  bnd_homecrest_top = -74,
  bnd_homecrest_left = -80,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 50,
  bnd_homecrest_width = 50,
  bnd_awaycrest_top = -74,
  bnd_awaycrest_right = -80,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 50,
  bnd_awaycrest_width = 50,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 30,
  bnd_message_width = 370,
  bnd_homemessage_top = -49,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xE4E6E5",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -49,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xE4E6E5",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 350
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -49,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0x000000",
  bnd_title_fontColor = "0xE4E6E5",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
SpainInfo = {
  bnd_fontFace = "$LaLiga", 
  bnd_background_show = true,
  bnd_background_height = 160,
  bnd_background_width = 1024,
  bnd_background = {
    name = "$GameEvent",
    id = 53
  },
  bnd_background_bottom = 0,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 0,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 0,
  bnd_homename_text_left = 10,
  bnd_homename_text_right = 150,
  bnd_awayname_text_left = 150,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "LEFT",
  bnd_awayname_right = 10,
  bnd_awayname_height = 0,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_name_text_top = 17,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 160,
  bnd_score_right = -115,
  bnd_score_left = -115,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 60,
  bnd_score_text_top = 12,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -90,
  bnd_homecrest_left = 130,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_homecrest_height = 55,
  bnd_homecrest_width = 55,

  bnd_awaycrest_top = -90,
  bnd_awaycrest_right = 130,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_awaycrest_height = 55,
  bnd_awaycrest_width = 55,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 30,
  bnd_message_width = 325,
  bnd_homemessage_top = 64,
  bnd_homemessage_left = -250,
  bnd_homemessage_color = "0x142516",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 296,
  bnd_message_text_width = 290,
  bnd_awaymessage_top = 64,
  bnd_awaymessage_left = 250,
  bnd_awaymessage_color = "0x142516",
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 36,
  bnd_logo_width = 300,
  bnd_logo_top = -131,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "x"
  },
  bnd_logowidth = 265,
  bnd_logoheight = 35,
  
  bnd_title_height = 30,
  bnd_title_width = 180,
  bnd_title_top = 64,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x142516",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
Spain2Info = {
  bnd_fontFace = "$LaLiga", 
  bnd_background_show = true,
  bnd_background_height = 95,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = 54
  },
  bnd_background_bottom = 46,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 50,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0x000000",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x1E3B41",
  bnd_homename_height = 50,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 5,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,

  bnd_awayname_text_left = 150,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x1E3B41",
  bnd_awayname_alignH = "LEFT",
  bnd_awayname_right = 35,
  bnd_awayname_height = 50,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_name_text_top = 0,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 160,
  bnd_score_right = -105,
  bnd_score_left = -130,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 38,
  bnd_score_text_top = 0,

  bnd_crest_height = 90,
  bnd_crest_width = 90,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -100,
  bnd_homecrest_left = 105,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_homecrest_height = 42,
  bnd_homecrest_width = 42,

  bnd_awaycrest_top = -100,
  bnd_awaycrest_right = 130,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_awaycrest_height = 42,
  bnd_awaycrest_width = 42,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

   bnd_message_height = 0,
  bnd_message_width = 303,
  bnd_homemessage_top = 40,
  bnd_homemessage_left = -249,
  bnd_homemessage_color = "",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 20,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 290,
  bnd_message_width = 303,
  bnd_awaymessage_top = 40,
  bnd_awaymessage_left = 249,
  bnd_awaymessage_color = "",
  bnd_awaymessage_text = "",
 
  
  bnd_logo_height = 36,
  bnd_logo_width = 300,
  bnd_logo_top = -30,
  bnd_logo_left = -15,
  bnd_logo_color_visible = true,
  bnd_logo_color = "",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 265,
  bnd_logoheight = 35,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = 40,
  bnd_title_left = -15,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 20,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
SwitzerlandInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -70,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 189
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "RAIFFEISEN SL",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
ThailandInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 180,
  bnd_background_width = 1200,
  bnd_background = {
    name = "$GameEvent",
    id = 2252
  },
  bnd_background_bottom = -50,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 4,
  bnd_score_text_top = 5,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 30,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x636363",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 0,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x636363",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 0,
  bnd_score_right = -40,
  bnd_score_left = -50,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -47,
  bnd_homecrest_left = -210,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 50,
  bnd_homecrest_width = 50,
  bnd_awaycrest_top = -47,
  bnd_awaycrest_right = -185,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 50,
  bnd_awaycrest_width = 50,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = 50,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 50,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 90,
  bnd_logo_width = 370,
  bnd_logo_top = -70,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID7_1"
  },
  bnd_logowidth = 95,
  bnd_logoheight = 80,
  
  bnd_title_height = 0,
  bnd_title_width = 167,
  bnd_title_top = 10,
  bnd_title_left = -5,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0x0000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
UefaInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$UCL-Regular", 
  bnd_background_show = true,
  bnd_background_height = 160,
  bnd_background_width = 1024,
  bnd_background = {
    name = "$GameEvent",
    id = 2236
  },
  bnd_background_bottom = -30,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 30,
  bnd_name_text_top = -3,
  bnd_score_text_top = -3,

  bnd_event_height = 50,
  bnd_event_width = 800,
  bnd_event_top = -45,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 80,
  bnd_homename_width = 300,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 80,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x061329",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 80,
  bnd_score_width = 200,
  bnd_score_right = -22,
  bnd_score_left = -22,
  bnd_score_color = "0xffffff",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -160,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -160,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 50,
  bnd_message_width = 400,
  bnd_homemessage_top = -55,
  bnd_homemessage_left = -200,
  bnd_homemessage_color = "0x041750",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 350,
  bnd_message_text_width = 350,
  bnd_awaymessage_top = -55,
  bnd_awaymessage_left = 200,
  bnd_awaymessage_color = "0x041750",
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -490000,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "x"
  },
  bnd_logowidth = 70,
  bnd_logoheight = 70,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -65,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x153454",
  bnd_title_fontColor = "0x57e8e0",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
UefaUelInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_background_show = true,
  bnd_background_height = 160,
  bnd_background_width = 1024,
  bnd_background = {
    name = "$GameEvent",
    id = 2238
  },
  bnd_background_bottom = -30,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 30,
  bnd_score_color = "0x2B2B2D",
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 50,
  bnd_event_width = 800,
  bnd_event_top = -50,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 80,
  bnd_homename_width = 300,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 80,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x061329",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 20,
  bnd_score_width = 20,
  bnd_score_right = -38,
  bnd_score_left = -38,
  bnd_crest_height = 130,
  bnd_crest_width = 130,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -30,
  bnd_homecrest_left = -180,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 120,
  bnd_homecrest_width = 120,
  bnd_awaycrest_top = -30,
  bnd_awaycrest_right = -180,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 120,
  bnd_awaycrest_width = 120,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 50,
  bnd_message_width = 400,
  bnd_homemessage_top = -53,
  bnd_homemessage_left = -200,
  bnd_homemessage_color = "0x2A2A2A",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 350,
  bnd_message_text_width = 350,
  bnd_awaymessage_top = -53,
  bnd_awaymessage_left = 200,
  bnd_awaymessage_color = "0x2A2A2A",
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -490000,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "x"
  },
  bnd_logowidth = 70,
  bnd_logoheight = 70,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -55,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x153454",
  bnd_title_fontColor = "0x57e8e0",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
UefaWomensInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 1
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2240
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
UkraineInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -70,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 332
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "UKRAYINA LIHA",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
UnitedStatesInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -50,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -70,
  bnd_score_left = -70,
  bnd_score_color = "0x000000",
  bnd_crest_height = 84.5,
  bnd_crest_width = 80,
  bnd_crest_color_visible = true,
  bnd_homecrest_top = -64,
  bnd_homecrest_left = -90,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -64,
  bnd_awaycrest_right = -90,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = -40,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -40,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 30,
  bnd_logo_width = 35,
  bnd_logo_top = -45,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 39
  },
  bnd_logowidth = 50,
  bnd_logoheight = 50,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -40,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 20,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
USANWSLInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -50,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -70,
  bnd_score_left = -70,
  bnd_score_color = "0x000000",
  bnd_crest_height = 84.5,
  bnd_crest_width = 80,
  bnd_crest_color_visible = true,
  bnd_homecrest_top = -64,
  bnd_homecrest_left = -90,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -64,
  bnd_awaycrest_right = -90,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = -40,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -40,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 30,
  bnd_logo_width = 35,
  bnd_logo_top = -45,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2221
  },
  bnd_logowidth = 50,
  bnd_logoheight = 50,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -40,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 20,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
VanaramaFootballLeagueInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -70,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 62
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "England Nations League",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
VietnamInfo = { 
  bnd_forceCaps = true,  
  bnd_fontFace = "$Epl",
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 2260
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 55,
  bnd_name_text_top = -2,
  bnd_score_text_top = -5,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -55,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "•",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -70,
  bnd_score_left = -70,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -90,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 90,
  bnd_homecrest_width = 90,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -90,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 90,
  bnd_awaycrest_width = 90,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = 31,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 14,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 31,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = 31,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
WomensSuperLeagueInfo = {
  bnd_fontFace = "$Epl",
  bnd_short_name_visible = true,
  bnd_text_bold = true,
  bnd_background_show = true,
  bnd_background_height = 170,
  bnd_background_width = 870,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = -25,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 1,

  bnd_event_height = 50,
  bnd_event_width = 800,
  bnd_event_top = -48,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 50,
  bnd_homename_width = 300,
  bnd_homename_color = "0x000000",
  bnd_homename_left = 0,
  bnd_homename_text_left = 40,
  bnd_awayname_text_right = 40,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 50,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x000000",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 250,
  bnd_score_right = -40,
  bnd_score_left = -40,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -48,
  bnd_homecrest_left = -75,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -48,
  bnd_awaycrest_right = -65,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 20,
  bnd_message_width = 250,
  bnd_homemessage_top = -25,
  bnd_homemessage_left = -210,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -25,
  bnd_awaymessage_left = 210,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 50,
  bnd_logo_width = 50,
  bnd_logo_top = -115,
  bnd_logo_left = 0,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogox",
    id = "0" 
  },
  bnd_logowidth = 50,
  bnd_logoheight = 50,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -75,
  bnd_title_left = -10,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 15,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
PialaIndonesiaInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = "CupID4"
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -48,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -65,
  bnd_score_left = -65,
  bnd_score_color = "0x000000",
  bnd_crest_height = 84.5,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -75,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 95,
  bnd_homecrest_width = 95,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -75,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 95,
  bnd_awaycrest_width = 95,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = -40,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -40,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 30,
  bnd_logo_width = 35,
  bnd_logo_top = -45,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "39_1"
  },
  bnd_logowidth = 50,
  bnd_logoheight = 50,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -90,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
WorldCupWomensInfo = {
  bnd_fontFace = "$FWWC2023Bold",
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 0,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,

  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 20,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 60,
  bnd_event_width = 600,
  bnd_event_top = -60,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 260,
  bnd_homename_color = "0xC5C8B7",
  bnd_homename_left = 0,
  bnd_homename_text_left = 0,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 60,
  bnd_awayname_width = 260,
  bnd_awayname_color = "0xC5C8B7",
  bnd_score_visible = false,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_text = "",
  bnd_score_height = 60,
  bnd_score_width = 80,
  bnd_score_color = "0x385D66",
  bnd_score_right = 0,
  bnd_score_left = 0,
  bnd_crest_color_visible = true,
  bnd_crest_height = 60,
  bnd_crest_width = 60,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = 0,
  bnd_homecrest_color = "0xC5C8B7",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 56,
  bnd_homecrest_width = 56,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = 0,
  bnd_awaycrest_color = "0xC5C8B7",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 56,
  bnd_awaycrest_width = 56,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 20,
  bnd_message_width = 310,
  bnd_homemessage_top = 40,
  bnd_homemessage_left = -193,
  bnd_homemessage_color = "0x3B9885",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 235,
  bnd_message_text_width = 280,
  bnd_awaymessage_top = 40,
  bnd_awaymessage_left = 192,
  bnd_awaymessage_color = "0x3B9885",
  bnd_awaymessage_text = "",

  bnd_logo_height = 50,
  bnd_logo_width = 90,
  bnd_logo_top = -15,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "",
  bnd_logo = {
    name = "$",
    id = 353
  },
  bnd_logowidth = 40,
  bnd_logoheight = 40,
  
  bnd_title_height = 20,
  bnd_title_width = 250,
  bnd_title_top = -39,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x306575",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 10,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
FaCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 19
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID9"
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
UefaEuropeInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 1
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x28992D",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x287800",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2278
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
AsianCupInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 3
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x94DF2A",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x31146B",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x31146B",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "•",
  bnd_score_visible = false,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -30,
  bnd_score_left = -30,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -90,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -90,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = -35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 366
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x270551",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
KingSaudiCupInfo = {
  bnd_background_show = true,
  bnd_background_height = 95,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = 3
  },
  bnd_background_bottom = 46,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 50,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 50,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 50,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,

  bnd_awayname_text_left = 150,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "LEFT",
  bnd_awayname_right = 50,
  bnd_awayname_height = 50,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_name_text_top = 15,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 160,
  bnd_score_right = -60,
  bnd_score_left = -80,
  bnd_score_color = "0xffffff",
  bnd_score_fontSize = 40,
  bnd_score_text_top = 15,

  bnd_crest_height = 90,
  bnd_crest_width = 90,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -90,
  bnd_homecrest_left = -108,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,

  bnd_awaycrest_top = -85,
  bnd_awaycrest_right = -108,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

   bnd_message_height = 20,
  bnd_message_width = 280,
  bnd_homemessage_top = -17,
  bnd_homemessage_left = -240,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 15,
  bnd_message_fontColor = "0xFDE5A1",
  bnd_awaymessage_right = 275,
  bnd_message_text_width = 290,
  bnd_awaymessage_top = -17,
  bnd_awaymessage_left = 240,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_text = "",
 
  bnd_logo_height = 36,
  bnd_logo_width = 300,
  bnd_logo_top = -30,
  bnd_logo_left = -15,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logowidth = 265,
  bnd_logoheight = 35,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -17,
  bnd_title_left = -10,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 16,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
EuroCupInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 2239
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -48,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x030E2A",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -65,
  bnd_score_left = -65,
  bnd_score_color = "0xffffff",
  bnd_crest_height = 84.5,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -75,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 95,
  bnd_homecrest_width = 95,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -75,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 95,
  bnd_awaycrest_width = 95,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = -40,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -40,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 30,
  bnd_logo_width = 35,
  bnd_logo_top = -45,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "0"
  },
  bnd_logowidth = 50,
  bnd_logoheight = 50,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -90,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
UsaOpenCupInfo = {
  bnd_background_show = true,
  bnd_background_height = 95,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 46,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 50,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 50,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 50,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,

  bnd_awayname_text_left = 150,
  bnd_awayname_text_right = 0,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "LEFT",
  bnd_awayname_right = 50,
  bnd_awayname_height = 50,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_name_text_top = 15,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 160,
  bnd_score_right = -70,
  bnd_score_left = -90,
  bnd_score_color = "0xffffff",
  bnd_score_fontSize = 40,
  bnd_score_text_top = 15,

  bnd_crest_height = 90,
  bnd_crest_width = 90,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -90,
  bnd_homecrest_left = -108,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,

  bnd_awaycrest_top = -85,
  bnd_awaycrest_right = -108,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

   bnd_message_height = 19,
  bnd_message_width = 280,
  bnd_homemessage_top = -18,
  bnd_homemessage_left = -240,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 15,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 290,
  bnd_message_text_width = 290,
  bnd_awaymessage_top = -18,
  bnd_awaymessage_left = 240,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_text = "",
 
  
  bnd_logo_height = 36,
  bnd_logo_width = 300,
  bnd_logo_top = -30,
  bnd_logo_left = -15,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logowidth = 265,
  bnd_logoheight = 35,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -16,
  bnd_title_left = -10,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 16,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
CopaAmericaInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 2298
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 30,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -55,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x0B2D6A",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -30,
  bnd_score_left = -25,
  bnd_score_color = "0x0C5236",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -90,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -90,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$CopaAmerikaCrest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 25,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -150,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0x0B2D6A",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$",
    id = 0
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -38,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x0B2D6A",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
WC26Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansMedium", 
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 130,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = "CupID2"
  },
  bnd_background_bottom = 0,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 50,
  bnd_name_text_top = -3,
  bnd_score_text_top = -3,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -55,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 27,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xFFFFFF",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = -10,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xFFFFFF",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = -10,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -53,
  bnd_score_left = -55,
  bnd_score_color = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -63,
  bnd_homecrest_left = -50,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$CrestWorldCup2026",
    id = 0
  },
  bnd_homecrest_height = 50,
  bnd_homecrest_width = 50,
  bnd_awaycrest_top = -63,
  bnd_awaycrest_right = -50,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$CrestWorldCup2026",
    id = 0
  },
  bnd_awaycrest_height = 50,
  bnd_awaycrest_width = 50,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 370,
  bnd_homemessage_top = -50,
  bnd_homemessage_left = -155,
  bnd_homemessage_color = "0x117BDD",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 15,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -50,
  bnd_awaymessage_left = 145,
  bnd_awaymessage_color = "0x117BDD",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -60,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "0_ea_dark"
  },
  bnd_logowidth = 60,
  bnd_logoheight = 55,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -53,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x117BDD",
  bnd_title_fontColor = "0xFFFFFF",
  bnd_title_fontSize = 16,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
CopaDelReyInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 19
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID5"
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
AfrikaCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie", 
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 130,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = "CupID26"
  },
  bnd_background_bottom = 0,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 45,
  bnd_name_text_top = -10,
  bnd_score_text_top = -12,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -48,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0x860000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 22,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -63,
  bnd_score_left = -60,
  bnd_score_color = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -59,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -58,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 370,
  bnd_homemessage_top = -42,
  bnd_homemessage_left = -100,
  bnd_homemessage_color = "0x117BDD",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 15,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 240,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -42,
  bnd_awaymessage_left = 190,
  bnd_awaymessage_color = "0x117BDD",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -60,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logowidth = 60,
  bnd_logoheight = 55,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 3,
  bnd_title_text = "",
  bnd_title_color = "0x117BDD",
  bnd_title_fontColor = "0xFFFFFF",
  bnd_title_fontSize = 16,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
CoppaItaliaInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 19
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID6"
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
DfbPokalInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 1
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogox",
    id = "0" 
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
ClassicInfo = {
  bnd_fontFace = "$Epl",
  bnd_short_name_visible = true,
  bnd_text_bold = true,
  bnd_background_show = true,
  bnd_background_height = 170,
  bnd_background_width = 870,
  bnd_background = {
    name = "$GameEvent",
    id = 2277
  },
  bnd_background_bottom = -25,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 40,
  bnd_name_text_top = 0,
  bnd_score_text_top = 1,

  bnd_event_height = 50,
  bnd_event_width = 800,
  bnd_event_top = -48,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 50,
  bnd_homename_width = 300,
  bnd_homename_color = "0x000000",
  bnd_homename_left = 0,
  bnd_homename_text_left = 40,
  bnd_awayname_text_right = 40,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 50,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0xffffff",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 50,
  bnd_score_width = 250,
  bnd_score_right = -40,
  bnd_score_left = -40,
  bnd_score_color = "0xffffff",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -48,
  bnd_homecrest_left = -75,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -48,
  bnd_awaycrest_right = -65,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 20,
  bnd_message_width = 250,
  bnd_homemessage_top = -25,
  bnd_homemessage_left = -210,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -25,
  bnd_awaymessage_left = 210,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 50,
  bnd_logo_width = 50,
  bnd_logo_top = -115,
  bnd_logo_left = 0,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 1245
  },
  bnd_logowidth = 50,
  bnd_logoheight = 50,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -75,
  bnd_title_left = -10,
  bnd_title_text = "",
  bnd_title_color = "0xffffff",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 15,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
CoupeDeFranceInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 1
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2200
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
FcwcInfo = {
  bnd_background_show = true,
  bnd_background_height = 100,
  bnd_background_width = 750,
  bnd_background = {
    name = "$GameEvent",
    id = 2209
  },
  bnd_background_bottom = 25,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 30,
  bnd_name_text_top = -25,
  bnd_score_text_top = -25,

  bnd_event_height = 50,
  bnd_event_width = 800,
  bnd_event_top = -50,
  bnd_event_left = 1,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x000000",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xffffff",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "",
  bnd_homename_left = 0,
  bnd_homename_text_left = 30,
  bnd_awayname_text_right = 30,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xffffff",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 0,
  bnd_score_right = -20,
  bnd_score_left = -22.5,
  bnd_score_color = "",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -75,
  bnd_homecrest_left = -55,
  bnd_homecrest_color = "",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 45,
  bnd_homecrest_width = 45,
  bnd_awaycrest_top = -75,
  bnd_awaycrest_right = -55,
  bnd_awaycrest_color = "",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 45,
  bnd_awaycrest_width = 45,
  
  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 0,
  bnd_message_width = 300,
  bnd_homemessage_top = -65,
  bnd_homemessage_left = -170,
  bnd_homemessage_color = "",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 15,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 265,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -65,
  bnd_awaymessage_left = 170,
  bnd_awaymessage_color = "",
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -490000,
  bnd_logo_left = 0,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_color_visible = false,
  bnd_logo_color = "",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2365
  },
  bnd_logowidth = 70,
  bnd_logoheight = 70,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -65,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 17,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
CopaLibertadoresInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 94,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 2237
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 8,
  bnd_score_text_top = 7,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -90,
  bnd_score_left = -90,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -50,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -50,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,

  bnd_message_height = 30,
  bnd_message_width = 350,
  bnd_homemessage_top = 35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0xffffff",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = 35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0xffffff",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 80,
  bnd_logo_width = 370,
  bnd_logo_top = -80,
  bnd_logo_left = 2,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 3
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = 35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "0xA8222A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
UefaNationsInfo = {
  bnd_forceCaps = true,  
  bnd_fontFace = "$UEFANations-Bold", 
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 780,
  bnd_background = {
    name = "$GameEvent",
    id = 3
  },
  bnd_background_bottom = 10,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 33,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -53,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0xffffff",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0x00000",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  bnd_score_text = "-",
  bnd_score_visible = false,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -30,
  bnd_score_left = -30,
  bnd_score_color = "0x000000",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -90,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -90,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 80,
  bnd_awaycrest_width = 80,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 350,
  bnd_homemessage_top = -35,
  bnd_homemessage_left = -165,
  bnd_homemessage_color = "0x000000",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -35,
  bnd_awaymessage_left = 165,
  bnd_awaymessage_color = "0x000000",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -49,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogox",
    id = "0"
  },
  bnd_logowidth = 45,
  bnd_logoheight = 60,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 2,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 18,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
CarabaoCupInfo = {
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 950,
  bnd_background_left = -60,
  bnd_background = {
    name = "$GameEvent",
    id = 0
  },
  bnd_background_bottom = 17,
  bnd_color_alpha = 1,
  bnd_home_rect_left = -5000,
  bnd_home_rect_top = 45,
  bnd_away_rect_left = 5000,
  bnd_away_rect_top = 45,

  bnd_event_height = 50,
  bnd_event_width = 1024,
  bnd_event_top = -100,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_awayname_text = "",
  bnd_event_fontSize = 28,
  bnd_event_fontColor = "0xffffff",

  bnd_homename_alignH = "RIGHT",
  bnd_homename_text_fontColor = "0x000000",
  bnd_homename_height = 60,
  bnd_homename_width = 400,
  bnd_homename_color = "0x061329",
  bnd_homename_left = 100,
  bnd_homename_text_left = 0,
  bnd_homename_text_right = 150,
 bnd_homename_text_top = 5, 

  bnd_awayname_alignH = "RIGHT",
  bnd_awayname_text_fontColor = "0x000000",
  bnd_awayname_height = 60,
  bnd_awayname_width = 400,
  bnd_awayname_color = "0x061329",
  bnd_awayname_left = 100,
  bnd_awayname_text_left = 0,
  bnd_awayname_text_right = 675,
  bnd_awayname_text_top = 55,

  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 60,
  bnd_score_width = 160,
  bnd_score_right = 33,
  bnd_score_left = -33,
  bnd_score_color = "0x000000",
  bnd_score_fontSize = 35,
  bnd_awayScore_text_top = 50,

  bnd_crest_height = 64,
  bnd_crest_width = 64,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -95,
  bnd_homecrest_left = -85,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,

  bnd_awaycrest_top = -45,
  bnd_awaycrest_right = 720,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = true,

  bnd_message_height = 50,
  bnd_message_width = 305,
  bnd_homemessage_top = 5,
  bnd_homemessage_left = 150,
  bnd_homemessage_color = "0x00FC7F",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 53,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x00FC7F",
  bnd_awaymessage_text = "",
 
  bnd_logo_color_visible = false,
  bnd_logo_height = 40,
  bnd_logo_width = 300,
  bnd_logo_top = -65,
  bnd_logo_left =-490,
  bnd_logo_color = "0x000000",
  bnd_logo = {
    name = "$LeagueLogox",
    id = "0"
  },
  bnd_logowidth = 65,
  bnd_logoheight = 65,
  
  bnd_NameLiga_height = 30,
  bnd_NameLiga_width = 150,
  bnd_NameLiga_top = -138,
  bnd_NameLiga_left = -340,
  bnd_NameLiga_text = "Carabao Cup",
  bnd_NameLiga_color = "0x2B2A29",
  bnd_NameLiga_fontColor = "0xffffff",
  bnd_NameLiga_fontSize = 23,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -35,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xC1C2BC",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 0,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
AseanChampionshipInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Extended-Heavy", 
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 130,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = 2267
  },
  bnd_background_bottom = 0,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 60,
  bnd_name_text_top = -10,
  bnd_score_text_top = -11,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -63,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 18,
  bnd_event_fontColor = "0xFFFFFF",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xFFFFFF",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 20,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xFFFFFF",
  bnd_awayname_alignH = "CENTER",
  bnd_awayname_right = 0,
  bnd_awayname_height = 0,
  bnd_awayname_width = 300,
  bnd_awayname_color = "0x044C7C",
  
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -53,
  bnd_score_left = -59,
  bnd_score_color = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -75,
  bnd_homecrest_left = -60,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,
  bnd_awaycrest_top = -75,
  bnd_awaycrest_right = -58,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 40,
  bnd_awaycrest_width = 40,

  bnd_score_bg = {
    name = "$",
    id = 0
  },
  bnd_score_bg_visible = false,


  bnd_message_height = 0,
  bnd_message_width = 370,
  bnd_homemessage_top = -48,
  bnd_homemessage_left = -140,
  bnd_homemessage_color = "0x117BDD",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 12,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 240,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -48,
  bnd_awaymessage_left = 150,
  bnd_awaymessage_color = "0x117BDD",
  bnd_awaymessage_color_alpha = 0.5,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 70,
  bnd_logo_width = 70,
  bnd_logo_top = -60,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x044C7C",
  bnd_logo = {
    name = "$LeagueLogo",
    id = 2211
  },
  bnd_logowidth = 60,
  bnd_logoheight = 55,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = 21,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x117BDD",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
function GameEvents:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.nationalization = 2
  o.services = {
    EventManagerService = o.api("EventManagerService"),
    MatchInfoService = o.api("MatchInfoService"),
    SquadManagementService = o.api("SquadMgtService"),
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
  local AustriaTeams = o.services.TeamService.GetTeams(leagueIDs.Austria, 0, 0, true)
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
  local Italy2Teams = o.services.TeamService.GetTeams(leagueIDs.Italy2, 0, 0, true)    
  local JapanTeams = o.services.TeamService.GetTeams(leagueIDs.Japan, 0, 0, true)
  local KoreaRepublicTeams = o.services.TeamService.GetTeams(leagueIDs.KoreaRepublic, 0, 0, true)
  local LeagueOneEflTeams = o.services.TeamService.GetTeams(leagueIDs.LeagueOneEfl, 0, 0, true)
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




  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
    o:handleEvent(...)
  end
  )

  o.currentdata = nil
  o.pendingGameEvent = false
  o.pendingEventData = nil
  o.lastGameTime = nil
  o.wasTimeStopped = false  
o.pendingDisplayStartTime = nil
o.pendingDisplayDuration = 4
o.pendingReadyToShow = false
 o.animating = false

if currentCupData and currentCupData.cupIndex and currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      o.currentdata = UefaInfo
    elseif currentCupData.cupIndex == 2 then
      o.currentdata = WC26Info
    elseif currentCupData.cupIndex == 3 then
      o.currentdata = UefaUelInfo
    elseif currentCupData.cupIndex == 2235 then
      o.currentdata = IndonesiaInfo
    elseif currentCupData.cupIndex == 5 then
      o.currentdata = WorldCupWomensInfo
    elseif currentCupData.cupIndex == 2240 then
      o.currentdata = UefaWomensInfo
    elseif currentCupData.cupIndex == 7 then
      o.currentdata = FaCupInfo
    elseif currentCupData.cupIndex == 8 then
      o.currentdata = UefaEuropeInfo
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
    elseif currentCupData.cupIndex == 15 then
      o.currentdata = CoppaItaliaInfo
    elseif currentCupData.cupIndex == 16 then
      o.currentdata = DfbPokalInfo
    elseif currentCupData.cupIndex == 17 then
      o.currentdata = CoupeDeFranceInfo
    elseif currentCupData.cupIndex == 18 then
      o.currentdata = FcwcInfo
    elseif currentCupData.cupIndex == 2237 then
      o.currentdata = CopaLibertadoresInfo
      elseif currentCupData.cupIndex == 26 then
      o.currentdata = AfrikaCupInfo
    elseif currentCupData.cupIndex == 20 then
      o.currentdata = UefaNationsInfo
    end
elseif currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      o.currentdata = UefaInfo
    elseif currentTourData.tourIndex == 2 then
      o.currentdata = WC26Info
    elseif currentTourData.tourIndex == 3 then
      o.currentdata = UefaUelInfo
    elseif currentTourData.tourIndex == 35 then
      o.currentdata = WorldCupWomensInfo
    elseif currentTourData.tourIndex == 2240 then
      o.currentdata = UefaWomensInfo      
    elseif currentTourData.tourIndex == 2235 then
      o.currentdata = IndonesiaInfo
    elseif currentTourData.tourIndex == 26 then
      o.currentdata = AfrikaCupInfo            
    elseif currentTourData.tourIndex == 27 then
      o.currentdata = AseanChampionshipInfo      
    elseif currentTourData.tourIndex == 9 then
      o.currentdata = FaCupInfo
    elseif currentTourData.tourIndex == 17 then
      o.currentdata = UefaEuropeInfo
     elseif currentTourData.tourIndex == 34 then
      o.currentdata = AsianCupInfo
    elseif currentTourData.tourIndex == 6 then
      o.currentdata = EuroCupInfo
    elseif currentTourData.tourIndex == 13 then
      o.currentdata = UsaOpenCupInfo
    elseif currentTourData.tourIndex == 25 then
      o.currentdata = CopaAmericaInfo
    elseif currentTourData.tourIndex == 10 then
      o.currentdata = CopaDelReyInfo
    elseif currentTourData.tourIndex == 11 then
      o.currentdata = CoppaItaliaInfo
    elseif currentTourData.tourIndex == 7 then
      o.currentdata = DfbPokalInfo
    elseif currentTourData.tourIndex == 18 then
      o.currentdata = CoupeDeFranceInfo
    elseif currentTourData.tourIndex == 15 then
      o.currentdata = FcwcInfo
    elseif currentTourData.tourIndex == 2237 then
      o.currentdata = CopaLibertadoresInfo
    elseif currentTourData.tourIndex == 50 then
      o.currentdata = KingSaudiCupInfo      
    elseif currentTourData.tourIndex == 22 then
      o.currentdata = ClassicInfo        
    o.currentdata.bnd_logo_top = -43   
    elseif currentTourData.tourIndex == 28 then
      o.currentdata = UefaNationsInfo
    elseif currentTourData.tourIndex == 24 then
      o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = "CupID24"
    o.currentdata.bnd_logo_top = -43   
    elseif currentTourData.tourIndex == 31 then
      o.currentdata = EAFCInfo          
    o.currentdata.bnd_logo.id = "CupID31"
    o.currentdata.bnd_logo_top = -43   
    elseif currentTourData.tourIndex == 21 then
      o.currentdata = EAFCInfo      
    o.currentdata.bnd_logo.id = "CupID21"
    o.currentdata.bnd_logo_top = -43   
  else 
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_logo.id = "0_ea_dark"       
    end        
  else
     if o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
    o.currentdata = AlgeriaInfo
elseif o:isInTable(o.TeamsData[1], AfcTeams) and o:isInTable(o.TeamsData[2], AfcTeams) then
    o.currentdata = AfcInfo
elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = "353_1"
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "LPF"
 elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
    o.currentdata = AsianCupU23Info
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, AsianCupU23TeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, AsianCupU23TeamsData)
    o.currentdata.bnd_homename_color = homeColorList[1]
    o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
    o.currentdata.bnd_homecrest_color = homeColorList[1]
    o.currentdata.bnd_awayname_color = awayColorList[1]
    o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]
    o.currentdata.bnd_awaycrest_color = awayColorList[1]
 elseif o:isInTable(o.TeamsData[1], AustriaTeams) and o:isInTable(o.TeamsData[2], AustriaTeams) then
    o.currentdata = AustriaInfo
 elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 4
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "Jupiter Pro League"
 elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = "7_1"
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "Brasileiro Serie-A"
 elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 1245
    o.currentdata.bnd_logo_top = -43   
 elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    o.currentdata = ClassicInfo
 elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 14
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "FL CHAMPIONSHIP"
 elseif  o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    o.currentdata = D1ArkemaInfo
  elseif  o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    o.currentdata = DenmarkInfo
  elseif  o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    o.currentdata = EcuadorInfo
  elseif  o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = "2231_1"
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "EPL NILE"
  elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    o.currentdata = EnglandInfo
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, EnglandTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, EnglandTeamsData)
    o.currentdata.bnd_homename_color = homeColorList[1]
    o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
    o.currentdata.bnd_homecrest_color = homeColorList[1]
    o.currentdata.bnd_awayname_color = awayColorList[1]
    o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]
    o.currentdata.bnd_awaycrest_color = awayColorList[1]
  elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    o.currentdata = FranceInfo
  elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    o.currentdata = France2Info
  elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    o.currentdata = GermanyInfo
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, GermanyTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, GermanyTeamsData)
    o.currentdata.bnd_homename_color = homeColorList[1]
    o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
    o.currentdata.bnd_homecrest_color = homeColorList[1]
    o.currentdata.bnd_awayname_color = awayColorList[1]
    o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]
    o.currentdata.bnd_awaycrest_color = awayColorList[1]
  elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
    o.currentdata = Germany2Info
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Germany2TeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Germany2TeamsData)
    o.currentdata.bnd_homename_color = homeColorList[1]
    o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
    o.currentdata.bnd_homecrest_color = homeColorList[1]
    o.currentdata.bnd_awayname_color = awayColorList[1]
    o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]
    o.currentdata.bnd_awaycrest_color = awayColorList[1]
  elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
    o.currentdata = IndonesiaInfo
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, IndonesiaTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, IndonesiaTeamsData)
    o.currentdata.bnd_homename_color = homeColorList[1]

    o.currentdata.bnd_homename_text_fontColor = homeColorList[2]

    o.currentdata.bnd_homecrest_color = homeColorList[1]

    o.currentdata.bnd_homeScore_text_fontColor = homeColorList[2]

    o.currentdata.bnd_awayname_color = awayColorList[1]

    o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]

    o.currentdata.bnd_awaycrest_color = awayColorList[1]

    o.currentdata.bnd_awayScore_text_fontColor = awayColorList[2]
    o.currentdata.bnd_awaycrest_color = awayColorList[1]
  elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 78
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "MEN'S NATIONAL"
  elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 2136
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "WOMEN'S NATIONAL"
  elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    o.currentdata = ItalyInfo
 elseif o:isInTable(o.TeamsData[1], Italy2Teams) and o:isInTable(o.TeamsData[2], Italy2Teams) then
    o.currentdata = EAFCInfo        
 elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
    o.currentdata = JapanInfo
 elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = "83_1"
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "K LEAGUE 1"
 elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 60
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "LEAGUE ONE"
 elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    o.currentdata = LigaFInfo
 elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    o.currentdata = MalaysiaInfo
  elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 341
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "LIGA MX"
  elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 2250
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "Botola Pro Inwi"
  elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = "10_1"
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "Eredivisie"
  elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    o.currentdata = PegadaianLiga2Info
  elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 308
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "Liga Portugal"
  elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 76
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "Rest Of World"
  elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 76
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "Rest Of World 2"
  elseif o:isInTable(o.TeamsData[1], RusiaTeams) and o:isInTable(o.TeamsData[2], RusiaTeams) then
    o.currentdata = RusiaInfo
  elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    o.currentdata = SaudiArabiaInfo
  elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = "50_1"
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "SCOTTISH PREM"
  elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 347
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "South African Fl"
  elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    o.currentdata = SpainInfo
  elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    o.currentdata = Spain2Info
  elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    o.currentdata = SwitzerlandInfo
  elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
    o.currentdata = ThailandInfo
  elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo.id = 347
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_NameLiga_text = "Süper Lig"
  elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    o.currentdata = UefaInfo
  elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    o.currentdata = UefaUelInfo
  elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
    o.currentdata = UefaWomensInfo
  elseif o:isInTable(o.TeamsData[1], UkraineTeams) and o:isInTable(o.TeamsData[2], UkraineTeams) then
    o.currentdata = UkraineInfo
  elseif o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
    o.currentdata = UnitedStatesInfo
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, UnitedStatesTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, UnitedStatesTeamsData)
    o.currentdata.bnd_homecrest_color = homeColorList[1]
    o.currentdata.bnd_awaycrest_color = awayColorList[1]
  elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USANWSLTeams) then
    o.currentdata = USANWSLInfo
  elseif o:isInTable(o.TeamsData[1], VanaramaFootballLeagueTeams) and o:isInTable(o.TeamsData[2], VanaramaFootballLeagueTeams) then
    o.currentdata = VanaramaFootballLeagueInfo
  elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
    o.currentdata = VietnamInfo
  elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
    o.currentdata = WomensSuperLeagueInfo
     local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, WomensSuperLeagueTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, WomensSuperLeagueTeamsData)
    o.currentdata.bnd_homename_color = homeColorList[1]
    o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
    o.currentdata.bnd_homecrest_color = homeColorList[1]
    o.currentdata.bnd_homeScore_text_fontColor = homeColorList[2]
    o.currentdata.bnd_awayname_color = awayColorList[1]
    o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]
    o.currentdata.bnd_awaycrest_color = awayColorList[1]
    o.currentdata.bnd_awayScore_text_fontColor = awayColorList[2]
  else 
    o.currentdata = EAFCInfo
    o.currentdata.bnd_logo_top = -43   
    o.currentdata.bnd_logo.id = "0_ea_dark"   
  end
  end
 

  --o.im.Subscribe(BND_NATIONALIZATION, function()
 -- end
--  )
  o.im.Subscribe(BND_VISIBLE, function()
     o.im.Publish(BND_VISIBLE, false)
  end
  )
o.im.Subscribe(BND_SCALE_X, function()
    o.im.Publish(BND_SCALE_X, o.animScaleX)
end)

o.im.Subscribe(BND_SCALE_Y, function()
    o.im.Publish(BND_SCALE_Y, o.animScaleY)
end)

  for k,v in pairs(o.currentdata) do
    o.im.Subscribe(k, function()
      if o:isInArray(k, bndList) then
        o:_publishEventInfo()
     else
        o.im.Publish(k, v)
     end
    end)
  end
  return o
end

function GameEvents:handleEvent(eventType, data)
if eventType == EventTypes.OverlayTypeGumby then
    self:updateClock(data.msg)
elseif eventType == EventTypes.OverlayTypeGoal then
        self:updateGameEvents(
            data.subtype,
            data.hideshow,
            data.subtypestr,
            data.msg
        )
    end
end

function GameEvents:updateClock(msg)
local params = OverlayParam.split(msg, "|")
if not params or not params[1] then
return
end
local currentGameTime = params[1]  
self.currentGameTime = currentGameTime  
if not string.find(currentGameTime, ":") then  
    return  
end  
if not self.lastGameTime then  
    self.lastGameTime = currentGameTime  
    return  
end  
local isTimeStopped = (currentGameTime == self.lastGameTime)  
-- DETEKSI REPLAY SELESAI  
if self.wasTimeStopped and not isTimeStopped then  
    if self.pendingGameEvent and self.pendingIsGoal then  
        self.pendingReadyToShow = true  
        self.pendingDisplayStartTime = os.time()  
    end  
end  
self.wasTimeStopped = isTimeStopped  
self.lastGameTime = currentGameTime  
if self.pendingReadyToShow and self.pendingDisplayStartTime then  
    local elapsed = os.time() - self.pendingDisplayStartTime  
    if elapsed >= (self.pendingDisplayDuration or 3) then  
        self.pendingReadyToShow = false  
        self.pendingDisplayStartTime = nil  
        if self.pendingGameEvent then  
            self.pendingGameEvent = false  
            self.pendingIsGoal = false  
            self.im.Publish(BND_VISIBLE, true)  
            self:_publishEventInfo()  
            print("Game Event shown after delay (post replay)")  
        end  
    end  
end  

if self.animating then

    local diff = self.animTarget - self.animScaleX

    local speed = 0.18

    if self.isHiding then
        speed = 0.22
    end

    local step = diff * speed

    local maxStep = 0.08
    if step >  maxStep then step =  maxStep end
    if step < -maxStep then step = -maxStep end

    self.animScaleX = self.animScaleX + step

    -- stop condition lebih stabil
    if math.abs(diff) < 0.002 then
        self.animScaleX = self.animTarget
        self.animating = false

        if self.isHiding then
            self.isHiding = false
            self.im.Publish(BND_VISIBLE, false)
        end
    end

    self.im.Publish(BND_SCALE_X, self.animScaleX)
    self.im.Publish(BND_SCALE_Y, self.animScaleY)

    local startOffsetY = 70
    local posY = startOffsetY * (1 - self.animScaleX)
    self.im.Publish(BND_POS_Y, posY)
end
end

function GameEvents:checkPendingDisplayTimeout()
if not self.pendingDisplayStartTime then
return
end
local elapsed = os.time() - self.pendingDisplayStartTime  
if self.pendingReadyToShow and elapsed >= self.pendingDisplayDuration then  
    self.pendingReadyToShow = false  
    self.pendingDisplayStartTime = nil  
    if self.pendingGameEvent then  
        self.pendingGameEvent = false  
        self.pendingIsGoal = false  
        self.im.Publish(BND_VISIBLE, true)  
        self:_publishEventInfo()  
        print("Game Event shown after delay (fixed stable)")  
    end  
 end
end

function GameEvents:updateGameEvents(subtype, hideshow, subtypestr, msg)
    print("updateGameEvents " .. msg)

    local now = os.clock()
    if self.lastEventPublish and (now - self.lastEventPublish) < 0.1 then
        return
    end
    self.lastEventPublish = now

    if hideshow == "SHOW" then

        local params = OverlayParam.split(msg, "|")
        if params and table.getn(params) > 0 then

            self.pendingGameEvent = true
            self.pendingReadyToShow = true
            self.im.Publish(BND_SCALE_X, 0)
            self.im.Publish(BND_SCALE_Y, 0)            
            self.pendingDisplayStartTime = os.time()


            self.pendingEventData = {
                subtype = subtype,
                hideshow = hideshow,
                subtypestr = subtypestr,
                msg = msg
            }

            self.pendingIsGoal =
                (subtype == EventTypes.Goal
                or subtypestr == "GOAL"
                or subtypestr == "OWNGOAL"
                or subtypestr == "OG")

            self.isHiding = false
            self.animScaleX = 0
            self.animScaleY = 0.75
            self.animTarget = 0.75
            self.animating = true

            local index = 12
            self.arrEvents = {}
            local homeMsg = ""
            local awayMsg = ""

            local lng = (#params - 11) / 4

            for i = 1, lng do
                self.arrEvents[i] = {}

                self.arrEvents[i].side = params[index]
                index = index + 1

                self.arrEvents[i].icon = params[index]
                index = index + 1

                self.arrEvents[i].label = params[index]
                index = index + 1

                self.arrEvents[i].teamAbbr = params[index]
                index = index + 1

                local label = self.arrEvents[i].label

                if self.arrEvents[i].icon + 0 > 3 then
                    if self.arrEvents[i].side == "0" then
                        homeMsg = homeMsg .. " " .. label
                    else
                        awayMsg = awayMsg .. " " .. label
                    end
                end
            end

            if self.currentdata.bnd_score_visible == true then
                self.homeScore = params[5]
                self.awayScore = params[6]
            else
                self.score = params[5] .. " - " .. params[6]
            end

            local gameevents = {
                homeTeamId = params[1] + 0,
                homeTeam = params[2],
                awayTeamId = params[3] + 0,
                awayTeam = params[4],
                score = self.score,
                message = params[7],
                aggMessage = params[8],
                events = self.arrEvents
            }

            self.currentdata.bnd_homemessage_visible = (homeMsg ~= "")
            self.currentdata.bnd_awaymessage_visible = (awayMsg ~= "")

            self.currentdata.bnd_homename_text = gameevents.homeTeam
            self.currentdata.bnd_homecrest.id = gameevents.homeTeamId
            self.currentdata.bnd_awayname_text = gameevents.awayTeam
            self.currentdata.bnd_awaycrest.id = gameevents.awayTeamId

            if self.currentdata.bnd_score_visible == true then
                self.currentdata.bnd_homeScore_text = self.homeScore
                self.currentdata.bnd_awayScore_text = self.awayScore
            else
                self.currentdata.bnd_score_text = self.score
            end

            if self.currentGameTime and self.currentGameTime ~= "" then
                self.currentdata.bnd_title_text = self.currentGameTime
            else
                self.currentdata.bnd_title_text = gameevents.message
            end

            self.currentdata.bnd_homemessage_text = homeMsg
            self.currentdata.bnd_awaymessage_text = awayMsg
        end

    else
        self.isHiding = true
        self.animTarget = 0
        self.animating = true
    end

    self:_publishEventInfo()
end


function GameEvents:_publishEventInfo()
  self.im.Publish("bnd_homemessage_visible", self.currentdata.bnd_homemessage_visible)
  self.im.Publish("bnd_awaymessage_visible", self.currentdata.bnd_awaymessage_visible)
  self.im.Publish("bnd_homename_text", self.currentdata.bnd_homename_text)
  self.im.Publish("bnd_homecrest", self.currentdata.bnd_homecrest)
  self.im.Publish("bnd_awayname_text", self.currentdata.bnd_awayname_text)
  self.im.Publish("bnd_awaycrest", self.currentdata.bnd_awaycrest)
  self.im.Publish("bnd_score_text", self.currentdata.bnd_score_text)
  self.im.Publish("bnd_homeScore_text", self.currentdata.bnd_homeScore_text)
  self.im.Publish("bnd_awayScore_text", self.currentdata.bnd_awayScore_text)
  self.im.Publish("bnd_homemessage_text", self.currentdata.bnd_homemessage_text)
  self.im.Publish("bnd_awaymessage_text", self.currentdata.bnd_awaymessage_text)
  self.im.Publish("bnd_title_text", self.currentdata.bnd_title_text)
end

function GameEvents:getTeamHomeColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.homeColor
      result[2] = v.homeFontColor
    end
  end
  return result
end

function GameEvents:getTeamAwayColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.awayColor
      result[2] = v.awayFontColor
    end
  end
  return result
end

function GameEvents:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function GameEvents:isInArray(value, tbl) 
  for k,v in pairs(tbl) do
    if tostring(v) == tostring(value) then
    return true
    end
  end
  return false
end

function GameEvents:getPlayerInfo(teamSide, playername, isOg)
  local flag = false
  local teamlineupData
  if teamSide == 0 then
    teamlineupData = homeTeamlineupData
  else 
    teamlineupData = awayTeamlineupData
  end
  if string.find(playername, "-") then
    playername = string.gsub(playername, "%-", " ")
  end
  for _FORV_6_ = 1, table.getn(teamlineupData) do
    if string.find(playername, teamlineupData[_FORV_6_].playerName,1,true) then
      flag = true
    end
  end
  if flag and isOg then
    flag = false
  elseif not flag and isOg then
    flag = true
  end
  return flag
end


function GameEvents:finalize()
 -- self.im.Unsubscribe(BND_GAME_EVENT_INFO)
  self.im.Unsubscribe(BND_VISIBLE)
  --self.im.Unsubscribe(BND_NATIONALIZATION)
  for k,v in pairs(EnglandInfo) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end

return GameEvents
