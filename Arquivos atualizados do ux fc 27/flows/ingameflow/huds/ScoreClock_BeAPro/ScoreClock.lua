-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

local ScoreClock = {}

local OverlaysIdContainer, OverlayParam, eventmanager, TableUtil = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes
  leagueIDs = {
   Algeria = 2262,
   AFF = 365,
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
   LeagueOneEfl = 60,
   LeagueTwoEfl = 61,
   LigaF = 2222,
   Malaysia = 2237,
   Mexico = 341,
   Morocco = 2250,
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

AsianCupU23TeamsData = {
  { teamid = 115512, homeColor = "0xC2071C", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xC2071C" },
  { teamid = 115514, homeColor = "0x83252E", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x83252E" },
  { teamid = 115515, homeColor = "0xC2071C", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xC2071C" },
  { teamid = 115516, homeColor = "0xD40C28", awayColor = "0x000000", homeFontColor = "0x000000", awayFontColor = "0xffffff" },
  { teamid = 115518, homeColor = "0x313462", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x313462" },
  { teamid = 115519, homeColor = "0x203388", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x203388" },
  { teamid = 115520, homeColor = "0xffffff", awayColor = "0x1D6854", homeFontColor = "0x1D6854", awayFontColor = "0xffffff" },
  { teamid = 115521, homeColor = "0x145E45", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x145E45" },
  { teamid = 115525, homeColor = "0xC2071C", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xC2071C" },
}
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
  { teamid = 1925, homeColor ="0xb52328" , awayColor ="0x8dabc9",homeFontColor = "0xFFFFFF", awayFontColor ="0x202838" } 
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
  { teamid = 110636, homeColor = "0x891321", awayColor ="0xFFFFFD",homeFontColor = "0xFFFFFD", awayFontColor = "0x891321"},
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
MalaysiaTeamsData = {
	{ teamid = 115616, homeColor ="0xC50005" , awayColor ="0x18271A",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 115617, homeColor ="0xD5032C" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 115618, homeColor ="0x252B91" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 115619, homeColor ="0xE9C402" , awayColor ="0x2A3022",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
}
NetherlandsTeamsData = {
	{ teamid = 245, homeColor ="0xCD2C33" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 246, homeColor ="0xDE2E27" , awayColor ="0x2B5D79",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
	{ teamid = 247, homeColor ="0xE23934" , awayColor ="0xD7CEC2",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 634, homeColor ="0xECCF1F" , awayColor ="0x218D69",homeFontColor = "0x269F78", awayFontColor ="0xffffff" },
	{ teamid = 645, homeColor ="0xE7472D" , awayColor ="0x2E2E2D",homeFontColor = "0x000000", awayFontColor ="0x6ECAE1" },
	{ teamid = 647, homeColor ="0xE8DC38" , awayColor ="0x202020",homeFontColor = "0x003583", awayFontColor ="0xD0B000" },
	{ teamid = 1903, homeColor ="0xBA2C2C" , awayColor ="0x242423",homeFontColor = "0xffffff", awayFontColor ="0xCBAF6C" },
	{ teamid = 1905, homeColor ="0xF9E634" , awayColor ="0x204F49",homeFontColor = "0x2687D3", awayFontColor ="0xFF612C" },
	{ teamid = 1906, homeColor ="0xD31F20" , awayColor ="0x252B35",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
	{ teamid = 1908, homeColor ="0xE01F23" , awayColor ="0x323546",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
	{ teamid = 1909, homeColor ="0xFFDB34" , awayColor ="0xffffff",homeFontColor = "0x000000", awayFontColor ="0xFFDB34" },
	{ teamid = 1910, homeColor ="0xF11F20" , awayColor ="0x2D2D2C",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
	{ teamid = 1913, homeColor ="0x1C6FCC" , awayColor ="0xD83438",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
	{ teamid = 1915, homeColor ="0x008C58" , awayColor ="0x000000",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
	{ teamid = 1971, homeColor ="0x000000" , awayColor ="0xA02838",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
	{ teamid = 100628, homeColor ="0xFF3D4E" , awayColor ="0x4D4C4B",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
	{ teamid = 100632, homeColor ="0xEDDC1D" , awayColor ="0x282928",homeFontColor = "0x000000", awayFontColor ="0xC29731" },
	{ teamid = 100646, homeColor ="0xD03038" , awayColor ="0x593577",homeFontColor = "0xffffff", awayFontColor ="0xffffff" },
}	
PegadaianLiga2TeamsData = { 
{ teamid = 155608, homeColor = "0x01212A", awayColor ="0xD0B00F",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
{ teamid = 155609, homeColor = "0xD28E0D", awayColor ="0xffffff",homeFontColor = "0x000000", awayFontColor = "0xD28E0D"},
{ teamid = 155613, homeColor = "0x3B1964", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x3B1964"},
{ teamid = 155619, homeColor = "0x6F0809", awayColor = "0xCCAE49", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
{ teamid = 155622, homeColor = "0x9C0F10", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x038DF1" },
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
SpainTeamsData = {
  { teamid = 240, homeColor = "0x910F1C", awayColor = "0x173890", homeFontColor = "0x173890", awayFontColor = "0x910F1C" },
  { teamid = 241, homeColor = "0x22229B", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x22229B"},
  { teamid = 243, homeColor = "0xDFDFDB", awayColor = "0x5C6182", homeFontColor = "0x5C6182", awayFontColor = "0xDFDFDB" },
  { teamid = 244, homeColor = "0xffffff", awayColor ="0xFCEB29", homeFontColor = "0xFCEB29", AwayFontColor = "0xffffff" },
  { teamid = 260, homeColor = "0xffffff", awayColor ="0x000000", homeFontColor = "0x000000", AwayFontColor = "0xffffff" },
  { teamid = 448, homeColor = "0xBB2A32", awayColor = "0x0F2A56", homeFontColor = "0x0F2A56", awayFontColor = "0xBB2A32" },
  { teamid = 449, homeColor = "0xffffff", awayColor = "0x1CA03D", homeFontColor = "0x1CA03D", awayFontColor = "0xffffff" },
  { teamid = 450, homeColor = "0x282827", awayColor = "0x78AFBE", homeFontColor = "0x78AFBE", awayFontColor = "0x282827" },
  { teamid = 452, homeColor = "0x2A76D1", awayColor ="0xDD2649", homeFontColor = "0xDD2649", AwayFontColor = "0x2A76D1" },
  { teamid = 453, homeColor = "0xBD2427", awayColor = "0x30302F", homeFontColor = "0x30302F", AwayFontColor = "0x30302F" },
  { teamid = 456, homeColor = "0xffffff", awayColor ="0x49BD58", homeFontColor = "0x49BD58", AwayFontColor = "0xffffff" },
  { teamid = 457, homeColor = "0x375289", awayColor = "0x3C3C3B", homeFontColor = "0x3C3C3B", AwayFontColor = "0x375289" },
  { teamid = 459, homeColor = "0xF40F12", awayColor ="0x2A3457", homeFontColor = "0x2A3457", AwayFontColor = "0xF40F12" },
  { teamid = 461, homeColor = "0xffffff", awayColor ="0xF04C10",  homeFontColor = "0xF04C10", AwayFontColor = "0xffffff" },
  { teamid = 462, homeColor = "0xffffff", awayColor ="0x53206B", homeFontColor = "0x53206B", AwayFontColor = "0xffffff" },
  { teamid = 463, homeColor = "0x11559E", awayColor ="0xffffff", homeFontColor = "0xffffff", AwayFontColor = "0x11559E" },
  { teamid = 467, homeColor = "0x11559E", awayColor ="0xffffff", homeFontColor = "0xffffff", AwayFontColor = "0x11559E" },
  { teamid = 468, homeColor = "0xffffff", awayColor ="0x147B44", homeFontColor = "0x147B44", AwayFontColor = "0xffffff" },
  { teamid = 472, homeColor = "0xE2E11D", awayColor ="0xffffff",  homeFontColor = "0xffffff", AwayFontColor = "0xE2E11D" },
  { teamid = 479, homeColor = "0x7D283B", awayColor ="0x90B6C6",  homeFontColor = "0x90B6C6", AwayFontColor = "0x7D283B" },
  { teamid = 481, homeColor = "0xE6E5E4", awayColor ="0x84262F",  homeFontColor = "0x84262F", AwayFontColor = "0xE6E5E4" },
  { teamid = 483, homeColor = "0xFADE05", awayColor ="0x9A1A38",  homeFontColor = "0x9A1A38", AwayFontColor = "0xFADE05" },
  { teamid = 480, homeColor = "0xE2E1E0", awayColor ="0xDA2C3C",  homeFontColor = "0xDA2C3C", AwayFontColor = "0xDA2C3C" },
  { teamid = 573, homeColor = "0x159FE7", awayColor ="0x532F3D", homeFontColor = "0x532F3D", AwayFontColor = "0x159FE7" },
  { teamid = 1853, homeColor = "0x7C090F", awayColor ="0x111312", homeFontColor = "0x111312", AwayFontColo  = "0x7C090F" },
  { teamid = 1854, homeColor = "0xffffff", awayColor ="0x000000", homeFontColor = "0x000000", AwayFontColor = "0xffffff" },
  { teamid = 1860, homeColor = "0x385CC0", awayColor ="0xD80400", homeFontColor = "0xD80400", AwayFontColor = "0x385CC0" },
  { teamid = 1861, homeColor = "0xC6282A", awayColor ="0x37525C", homeFontColor = "0x37525C", AwayFontColor = "0xC6282A" },
  { teamid = 1968, homeColor = "0xEBE633", awayColor ="0x000000", homeFontColor = "0x000000", AwayFontColor = "0xEBE633" },
  { teamid = 2023, homeColor = "0x263D89", awayColor ="0xC98727", homeFontColor = "0xC98727", AwayFontColor = "0x263D89" },
  { teamid = 10846, homeColor = "0xffffff", awayColor ="0x3C4F9C", homeFontColor = "0x3C4F9C", AwayFontColor = "0xffffff" },
  { teamid = 100851, homeColor = "0x000000", awayColor ="0xffffff", homeFontColor = "0xffffff", AwayFontColor = "0x000000" },
  { teamid = 100888, homeColor = "0xffffff", awayColor ="0x243757", homeFontColor = "0x243757", AwayFontColor = "0xffffff" },
  { teamid = 110832, homeColor = "0x7C101F", awayColor ="0x111312", homeFontColor = "0x111312", AwayFontColor = "0x7C101F" },
  { teamid = 110062, homeColor = "0xFF0000", awayColor ="0xBEDDEE", homeFontColor = "0xBEDDEE", AwayFontColor = "0xFF0000" },
  { teamid = 110069, homeColor = "0x8E1B2C", awayColor ="0xFFEF13", homeFontColor = "0xFFEF13", AwayFontColor = "0x8E1B2C" },
  { teamid = 110827, homeColor = "0x27314A", awayColor ="0xffffff", homeFontColor = "0xffffff", AwayFontColor = "0x27314A" },
  { teamid = 110831, homeColor = "0xFE3324", awayColor ="0x000000", homeFontColor = "0x000000", AwayFontColor = "0xFE3324" },
  { teamid = 110839, homeColor = "0x000000", awayColor ="0xffffff", homeFontColor = "0xffffff", AwayFontColor = "0x000000" },
  { teamid = 110902, homeColor = "0xFADE05", awayColor ="0x726D84",  homeFontColor = "0x726D84", AwayFontColor = "0xFADE05" },
  { teamid = 113981, homeColor = "0x77AAEB", awayColor ="0x2C2B3D",  homeFontColor = "0x2C2B3D", AwayFontColor = "0x77AAEB" },
  { teamid = 114554, homeColor = "0x256BB1", awayColor ="0xFF3648",  homeFontColor = "0xFF3648", AwayFontColor = "0x256BB1" },
}
UefaTeamsData = {
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
	{ teamid = 116300, homeColor ="0x293C6D" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 116302, homeColor ="0x292829" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
	{ teamid = 116303, homeColor ="0x253050" , awayColor ="0xffffff",homeFontColor = "0x60344B", awayFontColor ="0x000000" },
	{ teamid = 116304, homeColor ="0x000000" , awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor ="0x000000" },
}
VietnamTeamsData = {
	{ teamid = 150630, homeColor ="0x2A1A5F" , awayColor ="0xE1DE41",homeFontColor = "0xD9AE15", awayFontColor ="0x815CA3"},
	{ teamid = 150631, homeColor ="0x599BDA" , awayColor ="0x599BDA",homeFontColor = "0xffffff", awayFontColor ="0xfffffff"},
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

  bnd_score_text = "Player Career",
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
local AlgeriaScore = {
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

  bnd_score_text = "Ligue 1 Professionnelle",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
  bnd_stat_fontColor = "0xffffff",
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
local AFFScore = {
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
    id = 365
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
    id = 2236
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = 2236
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_ScoreX",
    id = 2236
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -170,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 22,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -48,
  bnd_awayName_top = 1,
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
  bnd_homeScore_top = 1,
  bnd_homeScore_left = -122.7,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = -2.7,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0x000000",

  bnd_score_text = "",
  bnd_score_top = -25,
  bnd_score_left = -100,
  bnd_score_fontSize = 15,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 116,
  bnd_time_height = 34,
  bnd_time_top = 0,
  bnd_time_left = 86,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = 2236
  },
  bnd_time_text = "",
  bnd_time_fontSize = 22,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 2,
  bnd_time_text_left = 15,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 95,
  bnd_extraTime_height = 25,
  bnd_extraTime_top = 28,
  bnd_extraTime_left = 114,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 365
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_stat_visible = false,
  bnd_stat_width = 279,
  bnd_stat_height = 40,
  bnd_stat_top = 38,
  bnd_stat_left = 20,
  bnd_stat_color = "0x000000",
  bnd_stat_alpha = 0.9,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 23,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -105,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 110,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 20,
  bnd_stat_text = ""
}
local ArgentinaScore = {
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

  bnd_score_text = "Primera División",
  bnd_score_top = -44.5,
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
local AsianCupU23Score = {
  bnd_text_bold = true,
  bnd_forceCaps = true,
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 55,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 50,
  bnd_logo_width = 280,
  bnd_logo_top = -10,
  bnd_logo_left = -60,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 2264
  },
  
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 32,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = -87,
  bnd_homeRect_width = 60,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 32,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = -48,
  bnd_awayRect_width = 60,

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
  bnd_homeName_fontSize = 25,
  bnd_homeName_fontColor = "0x31146B",
  bnd_awayName_text = "",
  bnd_awayName_right = -48,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 25,
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
  bnd_homeScore_top = 1.5,
  bnd_homeScore_left = -39.7,
  bnd_homeScore_fontSize = 19,
  bnd_homeScore_fontColor = "0x273F85",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1.5,
  bnd_awayScore_right = 1.7,
  bnd_awayScore_fontSize = 19,
  bnd_awayScore_fontColor = "0x273F85",

  bnd_score_text = "",
  bnd_score_top = 1,
  bnd_score_left = -20,
  bnd_score_fontSize = 12,
  bnd_score_fontColor = "0x94DF2A",

  bnd_time_width = 120,
  bnd_time_height = 34,
  bnd_time_top = 0,
  bnd_time_left = -14,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = "CupID1"
  },
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0x273F85",
  bnd_time_text_top = 1,
  bnd_time_text_left = 15,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = 21,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2264
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_text_top = 1,
  bnd_extraTime_fontColor = "0xFCDD10",
  
  bnd_stat_visible = false,
  bnd_stat_width = 200,
  bnd_stat_height = 40,
  bnd_stat_top = 38,
  bnd_stat_left = 100,
  bnd_stat_color = "0x273F85",
  bnd_stat_alpha = 0.9,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 15,
  bnd_stat_fontColor = "0xFCDD10",
  bnd_home_stat_text_left = -60,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 60,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local BelgiumScore = {
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

  bnd_score_text = "Jupiter Pro League",
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
local BrazilScore = {
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

  bnd_score_text = "Brasileiro Serie-A",
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
local ClassicScore = {
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
local ChampionshipEflScore = {
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

  bnd_score_text = "FL CHAMPIONSHIP",
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
local DenmarkScore = {
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

  bnd_score_text = "3F Superliga",
  bnd_score_top = -44.5,
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
local D1ArkemaScore = {
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
    name = "$ScoreBoard_Logo",
    id = 2218
  },

  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27,
  bnd_homeRect_top = 1119,
  bnd_homeRect_left = -117,
  bnd_homeRect_width = 5,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27,
  bnd_awayRect_top = 1119,
  bnd_awayRect_right = -80,
  bnd_awayRect_width = 5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 178,
  bnd_homeBg_left = -40,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 2218
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 200,
  bnd_awayBg_right = -92,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 2218
  },
  bnd_scoreBg_width = 50,
  bnd_scoreBg_height = 72,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 2218
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -85,
  bnd_homeName_top = 13,
  bnd_homeName_fontSize = 24,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -50,
  bnd_awayName_top = 13,
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
  bnd_homeScore_top = 14,
  bnd_homeScore_left = -34.5,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 14,
  bnd_awayScore_right = 2,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text = "-",
  bnd_score_top = 14,
  bnd_score_left = -18,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0x000000",
  bnd_time_width = 140,
  bnd_time_height = 46,
  bnd_time_top = 6,
  bnd_time_left = 325,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 2218
  },
  bnd_time_text = "",
  bnd_time_fontSize = 25,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 9,
  bnd_time_text_left = -20,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 29,
  bnd_extraTime_top = 15,
  bnd_extraTime_left = 394,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2218
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0xffffff",
  
  bnd_stat_visible = false,
  bnd_stat_width = 192,
  bnd_stat_height = 60,
  bnd_stat_top = 55,
  bnd_stat_left = 150,
  bnd_stat_color = "0x483D8B",
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
local EcuadorScore = {
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

  bnd_score_text = "Ecuador Serie-A",
  bnd_score_top = -44.5,
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
local EgyptScore = {
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

  bnd_score_text = "We Epl",
  bnd_score_top = -44.5,
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
local EnglandScore = {
  bnd_text_bold = false,
  bnd_fontFace = "$Epl",
  bnd_width = 420,
  bnd_height = 38,
  bnd_top = 35,
  bnd_left = -15,
  bnd_scoreboard_width = 360,
  bnd_logo1_inside_visible = false,
  bnd_logo1_outside_visible = true,
  bnd_logo1_height = 37,
  bnd_logo1_width = 32,
  bnd_logo1_top = -28,
  bnd_logo1_left = -2,
  bnd_logo1_image = {
    name = "$ScoreBoard_Logo",
    id = 13
  },
  
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 600,
  bnd_logo_width = 1790,
  bnd_logo_top = 300,
  bnd_logo_left = 490,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = "Slide"
  },

  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 25,
  bnd_homeRect_top = 0.4,
  bnd_homeRect_left = -87,
  bnd_homeRect_width = 121,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 25,
  bnd_awayRect_top = 0.4,
  bnd_awayRect_right = -52,
  bnd_awayRect_width = 121,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 1900,
  bnd_homeBg_left = 120,
  bnd_homeBg_image = {
    name = "ScoreBoard_Home1",
    id = 13
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away1",
    id = 13
  },
  bnd_scoreBg_width = 110,
  bnd_scoreBg_height = 27,
  bnd_scoreBg_right = 20,
  bnd_scoreBg_top = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 13
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -110,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 26,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -70,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 26,
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
  bnd_homeScore_top = -2.5,
  bnd_homeScore_left = -50,
  bnd_homeScore_fontSize = 42,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -2.5,
  bnd_awayScore_right = -9.7,
  bnd_awayScore_fontSize = 42,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text = "-",
  bnd_score_top = 13,
  bnd_score_left = -1.5,
  bnd_score_fontSize = 0,
  bnd_score_fontColor = "0x34003A",
  
  bnd_time_width = 90,
  bnd_time_height = 33,
  bnd_time_top = 25.5,
  bnd_time_left = 178,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 13
  },
  bnd_time_text = "",
  bnd_time_fontSize = 17,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 2,
  bnd_time_text_left = 0,
  
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 130,
  bnd_extraTime_height = 26,
  bnd_extraTime_top = 48,
  bnd_extraTime_left = 158,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 13
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 17,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_text_top = 0,
  bnd_extraTime_text_left = -2,
  
  bnd_stat_visible = false,
  bnd_stat_width = 261,
  bnd_stat_height = 50,
  bnd_stat_top = 37,
  bnd_stat_left = 92,
  bnd_stat_color = "0xefefef",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 18,
  bnd_stat_fontColor = "0x34003A",
  bnd_home_stat_text_left = -95,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 95,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 12,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local FranceScore = {
    bnd_text_bold = false,
    bnd_fontFace = "$Ligue1", 
    bnd_width = 520,
    bnd_height = 30,
    bnd_top = 35,
    bnd_left = 30,
    bnd_scoreboard_width = 500,
    bnd_logo1_inside_visible = false,
    bnd_logo1_outside_visible = true,
    bnd_logo1_height = 80,
    bnd_logo1_width = 80,
    bnd_logo1_top = 0,
    bnd_logo1_left = 195,
    bnd_logo1_image = {
      name = "$ScoreBoard_Logo",
      id = 16
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
    bnd_homeBg_width = 150,
    bnd_homeBg_left = -80,
    bnd_homeBg_image = {
      name = "$ScoreBoard_Home",
      id = 16
    },
    bnd_awayBg_visible = true,
    bnd_awayBg_width = 150,
    bnd_awayBg_right = -80,
    bnd_awayBg_image = {
      name = "$ScoreBoard_Away",
      id = 16
    },
    bnd_scoreBg_width = 150,
    bnd_scoreBg_height = 30,
    bnd_scoreBg_right = 0,
    bnd_scoreBg_image = {
      name = "$ScoreBoard_Score",
      id = 16
    },
    bnd_homeName_text = "",
    bnd_homeName_left = -90,
    bnd_homeName_top = 2,
    bnd_homeName_fontSize = 20,
    bnd_homeName_fontColor = "0xFFFFFF",
    bnd_awayName_text = "",
    bnd_awayName_right = -90,
    bnd_awayName_top = 2,
    bnd_awayName_fontSize = 20,
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
    bnd_homeScore_left = -42.5,
    bnd_homeScore_fontSize = 20,
    bnd_homeScore_fontColor = "0xCDFB0A",
    bnd_awayScore_text = "",
    bnd_awayScore_top = 2,
    bnd_awayScore_right = -40,
    bnd_awayScore_fontSize = 20,
    bnd_awayScore_fontColor = "0xCDFB0A",
    bnd_score_text = "-",
    bnd_score_top = 1.25,
    bnd_score_left = -15000,
    bnd_score_fontSize = 20,
    bnd_score_fontColor = "0x34003A",

    bnd_time_width = 90,
    bnd_time_height = 28,
    bnd_time_top = 0,
    bnd_time_left = 30,
    bnd_timeBg_image = {
      name = "$ScoreBoard_Time",
      id = 16
    },
    bnd_time_text = "",
    bnd_time_fontSize = 20,
    bnd_time_fontColor = "0x1E1E1E",
    bnd_time_text_top = 2,
    bnd_time_text_left = 0,
    bnd_extraTime_visible = false,
    bnd_extraTime_width = 50,
    bnd_extraTime_height = 30,
    bnd_extraTime_top = 30,
    bnd_extraTime_left = 30,
    bnd_extraTimeBg_image = {
      name = "$ScoreBoard_ExtraTime",
      id = 16
    },
    bnd_extraTime_text = "",
    bnd_extraTime_fontSize = 20,
    bnd_extraTime_fontColor = "0xFFFFFF",

    bnd_stat_visible = false,
    bnd_stat_width = 305,
    bnd_stat_height = 40,
    bnd_stat_top = 36,
    bnd_stat_left = 120,
    bnd_stat_color = "0x011240",
    bnd_home_stat_text = "",
    bnd_stat_fontSize = 20,
    bnd_stat_fontColor = "0xb8fa02",
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
local France2Score = {
    bnd_text_bold = false,
    bnd_fontFace = "$Ligue1", 
    bnd_width = 520,
    bnd_height = 30,
    bnd_top = 35,
    bnd_left = 30,
    bnd_scoreboard_width = 500,
    bnd_logo1_inside_visible = false,
    bnd_logo1_outside_visible = true,
    bnd_logo1_height = 80,
    bnd_logo1_width = 80,
    bnd_logo1_top = 0,
    bnd_logo1_left = 195,
    bnd_logo1_image = {
      name = "$ScoreBoard_Logo",
      id = 17
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
    bnd_homeBg_width = 150,
    bnd_homeBg_left = -80,
    bnd_homeBg_image = {
      name = "$ScoreBoard_Home",
      id = 17
    },
    bnd_awayBg_visible = true,
    bnd_awayBg_width = 150,
    bnd_awayBg_right = -80,
    bnd_awayBg_image = {
      name = "$ScoreBoard_Away",
      id = 17
    },
    bnd_scoreBg_width = 150,
    bnd_scoreBg_height = 30,
    bnd_scoreBg_right = 0,
    bnd_scoreBg_image = {
      name = "$ScoreBoard_Score",
      id = 17
    },
    bnd_homeName_text = "",
    bnd_homeName_left = -90,
    bnd_homeName_top = 2,
    bnd_homeName_fontSize = 20,
    bnd_homeName_fontColor = "0xFFFFFF",
    bnd_awayName_text = "",
    bnd_awayName_right = -90,
    bnd_awayName_top = 2,
    bnd_awayName_fontSize = 20,
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
    bnd_homeScore_left = -42.5,
    bnd_homeScore_fontSize = 20,
    bnd_homeScore_fontColor = "0x00FFD3",
    bnd_awayScore_text = "",
    bnd_awayScore_top = 2,
    bnd_awayScore_right = -40,
    bnd_awayScore_fontSize = 20,
    bnd_awayScore_fontColor = "0x00FFD3",
    bnd_score_text = "-",
    bnd_score_top = 1.25,
    bnd_score_left = -15000,
    bnd_score_fontSize = 20,
    bnd_score_fontColor = "0x34003A",

    bnd_time_width = 90,
    bnd_time_height = 28,
    bnd_time_top = 0,
    bnd_time_left = 30,
    bnd_timeBg_image = {
      name = "$ScoreBoard_Time",
      id = 17
    },
    bnd_time_text = "",
    bnd_time_fontSize = 20,
    bnd_time_fontColor = "0x1E1E1E",
    bnd_time_text_top = 2,
    bnd_time_text_left = 0,
    bnd_extraTime_visible = false,
    bnd_extraTime_width = 50,
    bnd_extraTime_height = 30,
    bnd_extraTime_top = 30,
    bnd_extraTime_left = 30,
    bnd_extraTimeBg_image = {
      name = "$ScoreBoard_ExtraTime",
      id = 17
    },
    bnd_extraTime_text = "",
    bnd_extraTime_fontSize = 20,
    bnd_extraTime_fontColor = "0xFFFFFF",

    bnd_stat_visible = false,
    bnd_stat_width = 305,
    bnd_stat_height = 40,
    bnd_stat_top = 36,
    bnd_stat_left = 120,
    bnd_stat_color = "0x011240",
    bnd_home_stat_text = "",
    bnd_stat_fontSize = 20,
    bnd_stat_fontColor = "0x00FFD3",
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
local GermanyScore = {
  bnd_text_bold = true,
  bnd_fontFace = "$Bundesliga", 
  bnd_width = 360,
  bnd_height = 70,
  bnd_top = 35,
  bnd_left = -15,
  bnd_scoreboard_width = 360,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 46,
  bnd_logo_width = 55,
  bnd_logo_top = 12,
  bnd_logo_left = -30,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 19
  },
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 70,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 25,
  bnd_homeRect_width = 55,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 70,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = -80,
  bnd_awayRect_width = 55,

  bnd_homeBg_visible = false,
  bnd_homeBg_width = 55,
  bnd_homeBg_left = 25,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 19
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 55,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 19
  },
  bnd_scoreBg_width = 150,
  bnd_scoreBg_height = 70,
  bnd_scoreBg_right = -8000,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 19
  },
  bnd_homeName_text = "",
  bnd_homeName_left = 24,
  bnd_homeName_top = -20,
  bnd_homeName_fontSize = 18,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_right = -80,
  bnd_awayName_top = -20,
  bnd_awayName_fontSize = 18,
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
  bnd_homeScore_top = 10,
  bnd_homeScore_left = 23,
  bnd_homeScore_fontSize = 30,
  bnd_homeScore_fontColor = "0xCDFB0A",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 10,
  bnd_awayScore_right = -79,
  bnd_awayScore_fontSize = 30,
  bnd_awayScore_fontColor = "0xCDFB0A",
  bnd_score_text = "-",
  bnd_score_top = 1.25,
  bnd_score_left = -15000,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0x34003A",

  bnd_time_width = 55.5,
  bnd_time_height = 24,
  bnd_time_top = -23,
  bnd_time_left = 122,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 19
  },
  bnd_time_text = "",
  bnd_time_fontSize = 14,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 0,
  bnd_time_text_left = -1,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 30,
  bnd_extraTime_height = 23,
  bnd_extraTime_top = -23.5,
  bnd_extraTime_left = 92,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 19
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 14,
  bnd_extraTime_fontColor = "0x34003a",

  bnd_stat_visible = false,
  bnd_stat_width = 165,
  bnd_stat_height = 40,
  bnd_stat_top = 60,
  bnd_stat_left = 122,
  bnd_stat_color = "0xffffff",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 18,
  bnd_stat_fontColor = "0x34003a",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 55,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = -54,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local Germany2Score = {
  bnd_text_bold = true,
  bnd_fontFace = "$Bundesliga", 
  bnd_width = 360,
  bnd_height = 70,
  bnd_top = 35,
  bnd_left = -15,
  bnd_scoreboard_width = 360,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 46,
  bnd_logo_width = 55,
  bnd_logo_top = 12,
  bnd_logo_left = -30,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 20
  },
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 70,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = 25,
  bnd_homeRect_width = 55,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 70,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = -80,
  bnd_awayRect_width = 55,

  bnd_homeBg_visible = false,
  bnd_homeBg_width = 55,
  bnd_homeBg_left = 25,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 20
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 55,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 20
  },
  bnd_scoreBg_width = 150,
  bnd_scoreBg_height = 70,
  bnd_scoreBg_right = -8000,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 20
  },
  bnd_homeName_text = "",
  bnd_homeName_left = 24,
  bnd_homeName_top = -20,
  bnd_homeName_fontSize = 18,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_right = -80,
  bnd_awayName_top = -20,
  bnd_awayName_fontSize = 18,
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
  bnd_homeScore_top = 10,
  bnd_homeScore_left = 23,
  bnd_homeScore_fontSize = 30,
  bnd_homeScore_fontColor = "0xCDFB0A",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 10,
  bnd_awayScore_right = -79,
  bnd_awayScore_fontSize = 30,
  bnd_awayScore_fontColor = "0xCDFB0A",
  bnd_score_text = "-",
  bnd_score_top = 1.25,
  bnd_score_left = -15000,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0x34003A",

  bnd_time_width = 55.5,
  bnd_time_height = 24,
  bnd_time_top = -23,
  bnd_time_left = 122,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 20
  },
  bnd_time_text = "",
  bnd_time_fontSize = 14,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 0,
  bnd_time_text_left = -1,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 30,
  bnd_extraTime_height = 23,
  bnd_extraTime_top = -23.5,
  bnd_extraTime_left = 92,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 20
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 14,
  bnd_extraTime_fontColor = "0x34003a",

  bnd_stat_visible = false,
  bnd_stat_width = 165,
  bnd_stat_height = 40,
  bnd_stat_top = 60,
  bnd_stat_left = 122,
  bnd_stat_color = "0xffffff",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 18,
  bnd_stat_fontColor = "0x34003a",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 55,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = -54,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local IndonesiaScore = {
    bnd_text_bold = false,
    bnd_forceCaps = true, 
    bnd_fontFace = "$Liga1",
    bnd_width = 150,
    bnd_height = 25,
    bnd_top = 38,
    bnd_left = 280,
    bnd_scoreboard_width = 500,
    bnd_logo_inside_visible = false,
    bnd_logo_outside_visible = true,
    bnd_logo_height = 55,
    bnd_logo_width = 115,
    bnd_logo_top = -3,
    bnd_logo_left = 1,
    bnd_logo_image = {
      name = "$LeagueLogo",
      id = "2235_2"
    },
    bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 26,
  bnd_homeRect_top = 0.4,
  bnd_homeRect_left = -60,
  bnd_homeRect_width = 95,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 26,
  bnd_awayRect_top = 0.4,
  bnd_awayRect_right = -64,
  bnd_awayRect_width = 95,

    bnd_homeBg_visible = true,
    bnd_homeBg_width = 80,
    bnd_homeBg_left = -70,
    bnd_homeBg_image = {
      name = "$ScoreBoard_Home1",
      id = 2235
    },
    bnd_awayBg_visible = true,
    bnd_awayBg_width = 80,
    bnd_awayBg_right = -70,
    bnd_awayBg_image = {
      name = "$ScoreBoard_Away1",
      id = 2235
    },
    bnd_scoreBg_width = 90,
    bnd_scoreBg_height = 25,
    bnd_scoreBg_right = 0,
    bnd_scoreBg_image = {
      name = "$ScoreBoard_Score1",
      id = 2235
    },
    bnd_homeName_text = "",
    bnd_homeName_left = -80,
    bnd_homeName_top = 0,
    bnd_homeName_fontSize = 20,
    bnd_homeName_fontColor = "0x000000",
    bnd_awayName_text = "",
    bnd_awayName_right = -70,
    bnd_awayName_top = 0,
    bnd_awayName_fontSize = 20,
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
    bnd_homeScore_top = -4,
    bnd_homeScore_left = -32, 
    bnd_homeScore_fontSize = 42,
    bnd_homeScore_fontColor = "0xffffff",
    bnd_awayScore_text = "",
    bnd_awayScore_top = -4,
    bnd_awayScore_right = -32,
    bnd_awayScore_fontSize = 42,
    bnd_awayScore_fontColor = "0xffffff",
    bnd_score_text = "-",
    bnd_score_top = 1.25,
    bnd_score_left = -15000,
    bnd_score_fontSize = 20,
    bnd_score_fontColor = "0x34003A",

    bnd_time_width = 70,
    bnd_time_height = 27,
    bnd_time_top = 1,
    bnd_time_left = 10,
    bnd_timeBg_image = {
      name = "$ScoreBoard_Time",
      id = 2235
    },
    bnd_time_text = "",
    bnd_time_fontSize = 20,
    bnd_time_fontColor = "0xffffff",
    bnd_time_text_top = 0,
    bnd_time_text_left = 0,
    bnd_extraTime_visible = false,
    bnd_extraTime_width = 35,
    bnd_extraTime_height = 27,
    bnd_extraTime_top = 1,
    bnd_extraTime_left = 80,
    bnd_extraTimeBg_image = {
      name = "$ScoreBoard_ExtraTime",
      id = 2235
    },
    bnd_extraTime_text = "",
    bnd_extraTime_fontSize = 20,
    bnd_extraTime_fontColor = "0x113A6F",

   bnd_stat_visible = false,
   bnd_stat_width = 218,
   bnd_stat_height = 35,
   bnd_stat_top = 33,
   bnd_stat_left = -207,
   bnd_stat_color = "0x113A6F",
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
local InternationalScore = {
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

  bnd_score_text = "Men's National",
  bnd_score_top = -44.5,
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
local International2Score = {
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

  bnd_score_text = "Women's National",
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
local ItalyScore = {
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
    id = 31
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 130,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 31
  },
  bnd_scoreBg_width = 110,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 31
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
    id = 31
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
    id = 31
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xFFFFFF",

  bnd_stat_visible = false,
  bnd_stat_width = 290,
  bnd_stat_height = 40,
  bnd_stat_top = 37,
  bnd_stat_left = 75,
  bnd_stat_color = "0x586cf8",
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
local Italy2Score = {
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
    id = 32
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 130,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 32
  },
  bnd_scoreBg_width = 110,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 32
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
    id = 32
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
    id = 32
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xFFFFFF",

  bnd_stat_visible = false,
  bnd_stat_width = 290,
  bnd_stat_height = 40,
  bnd_stat_top = 37,
  bnd_stat_left = 75,
  bnd_stat_color = "0xffffff",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0x000000",
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
local LeagueOneEflScore = {
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

  bnd_score_text = "FOOTBALL LEAGUE 1",
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
local LeagueTwoEflScore = {
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

  bnd_score_text = "FOOTBALL LEAGUE 2",
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
local LigaFScore = {
  bnd_text_bold = true,
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 55,
  bnd_left = 90,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 60,
  bnd_logo_width = 300,
  bnd_logo_top = -10,
  bnd_logo_left = -60,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 2222
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
    id = 2236
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_AwayX",
    id = 2236
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 34,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_ScoreX",
    id = 2236
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -135,
  bnd_homeName_top = -12,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = 15,
  bnd_awayName_top = -12,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -140,
  bnd_homeCrest_top = -20,
  bnd_homeCrest_width = 35,
  bnd_homeCrest_height = 35,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = 26,
  bnd_awayCrest_top = -20,
  bnd_awayCrest_width = 35,
  bnd_awayCrest_height = 35,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -12,
  bnd_homeScore_left = -98.7,
  bnd_homeScore_fontSize = 24,
  bnd_homeScore_fontColor = "0x00295F",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -12,
  bnd_awayScore_right = 68.7,
  bnd_awayScore_fontSize = 24,
  bnd_awayScore_fontColor = "0x00295F",

  bnd_score_text = "-",
  bnd_score_top = -12,
  bnd_score_left = -84,
  bnd_score_fontSize = 18,
  bnd_score_fontColor = "0x00295F",

  bnd_time_width = 116,
  bnd_time_height = 34,
  bnd_time_top = -12,
  bnd_time_left = 185,
  bnd_timeBg_image = {
    name = "$ScoreBoard_TimeX",
    id = 2236
  },
  bnd_time_text = "",
  bnd_time_fontSize = 22,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 2,
  bnd_time_text_left = 15,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 78,
  bnd_extraTime_height = 25,
  bnd_extraTime_top = 17,
  bnd_extraTime_left = 225,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2222
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 22,
  bnd_extraTime_fontColor = "0x00295F",
  
  bnd_stat_visible = false,
  bnd_stat_width = 165,
  bnd_stat_height = 35,
  bnd_stat_top = 22,
  bnd_stat_left = 60,
  bnd_stat_color = "0x032A6F",
  bnd_stat_alpha = 0.9,
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0x14FEB7",
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
local MalaysiaScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Malaysia",
  bnd_width = 420,
  bnd_height = 60,
  bnd_top = 40,
  bnd_left = -15,
  bnd_scoreboard_width = 360,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 49,
  bnd_logo_width = 39,
  bnd_logo_top = 0,
  bnd_logo_left = 6,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 2237
  },

  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height =  5,
  bnd_homeRect_top = 26,
  bnd_homeRect_left = -89,
  bnd_homeRect_width = 49.5,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 5,
  bnd_awayRect_top = 26,
  bnd_awayRect_right = -99,
  bnd_awayRect_width = 49.5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 80,
  bnd_homeBg_height = 170,
  bnd_homeBg_left = -85,
  bnd_homeBg_top = -5,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 2237
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 80,
  bnd_awayBg_height = 170,
  bnd_awayBg_right = -90,
  bnd_awayBg_top = -5,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 2237
  },
  bnd_scoreBg_width = 180,
  bnd_scoreBg_height = 65.5,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_top = -2.5,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 2237
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -90,
  bnd_homeName_top = 13,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0x001763",
  bnd_awayName_text = "",
  bnd_awayName_right = -98,
  bnd_awayName_top = 13,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0x001763",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -88,
  bnd_homeCrest_top = -11,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -100,
  bnd_awayCrest_top = -11,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,
  
  
  bnd_homeScore_text = "",
  bnd_homeScore_top = -1,
  bnd_homeScore_left = -44.5,
  bnd_homeScore_fontSize = 40,
  bnd_homeScore_fontColor = "0x001763",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -1,
  bnd_awayScore_right = -52,
  bnd_awayScore_fontSize = 40,
  bnd_awayScore_fontColor = "0x001763",
  bnd_score_text = "-",
  bnd_score_top = 1.25,
  bnd_score_left = -122222.5,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0x34003A",

  bnd_time_width = 100,
  bnd_time_height = 30,
  bnd_time_top = 41,
  bnd_time_left = 190,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 2237
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0x16FEC2",
  bnd_time_text_top = 1,
  bnd_time_text_left = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 41,
  bnd_extraTime_left = 270,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2237
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0x16FEC2",
  
  bnd_stat_visible = false,
  bnd_stat_width = 237,
  bnd_stat_height = 55,
  bnd_stat_top = 55,
  bnd_stat_left = 127,
  bnd_stat_color = "0xffffff",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0x0004DF",
  bnd_home_stat_text_left = -90,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 90,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 15,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local MexicoScore = {
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

  bnd_score_text = "Liga Bancomer Mx",
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
local MoroccoScore = {
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

  bnd_score_text = "Botola Pro Inwi",
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
local NetherlandsScore = {
    bnd_text_bold = false,
    bnd_forceCaps = true, 
    bnd_fontFace = "$Eredivisie", 
    bnd_width = 150,
    bnd_height = 25,
    bnd_top = 38,
    bnd_left = 280,
    bnd_scoreboard_width = 500,
    bnd_logo1_inside_visible = false,
    bnd_logo1_outside_visible = false,
    bnd_logo1_height = 55,
    bnd_logo1_width = 125,
    bnd_logo1_top = -3,
    bnd_logo1_left = 1,
    bnd_logo1_image = {
      name = "$ScoreBoard_Logo",
      id = 10
    },
    bnd_homeRect_visible = true,
    bnd_homeRect_color = "",
    bnd_homeRect_height = 26.5,
    bnd_homeRect_top = 0.7,
    bnd_homeRect_left = -68,
    bnd_homeRect_width = 80,
    bnd_awayRect_visible = true,
    bnd_awayRect_color = "",
    bnd_awayRect_height = 26.5,
    bnd_awayRect_top = 0.7,
    bnd_awayRect_right = -68,
    bnd_awayRect_width = 83,

    bnd_homeBg_visible = true,
    bnd_homeBg_width = 80,
    bnd_homeBg_left = -68,
    bnd_homeBg_image = {
      name = "$ScoreBoard_Home1",
      id = 0
    },
    bnd_awayBg_visible = true,
    bnd_awayBg_width = 80,
    bnd_awayBg_right = -70,
    bnd_awayBg_image = {
      name = "$ScoreBoard_Away1",
      id = 0
    },
    bnd_scoreBg1_height = 65,
    bnd_scoreBg1_width = 140,
    bnd_scoreBg1_top = -4,
    bnd_scoreBg1_right = 1,
    bnd_scoreBg1_image = {
      name = "$ScoreBoard_Score",
      id = 10
    },
    bnd_scoreBg_height = 52.5,
    bnd_scoreBg_width = 90,
    bnd_scoreBg_top = -3,
    bnd_scoreBg_right = 87,
    bnd_scoreBg_image = {
      name = "$ScoreBoard_Score",
      id = "10Home"
    },
    bnd_scoreBg2_height = 52.5,
    bnd_scoreBg2_width = 90,
    bnd_scoreBg2_top = -3,
    bnd_scoreBg2_right = -87,
    bnd_scoreBg2_image = {
      name = "$ScoreBoard_Score",
      id = "10Away"
    },
    bnd_homeName_text = "",
    bnd_homeName_left = -60,
    bnd_homeName_top = 0,
    bnd_homeName_fontSize = 20,
    bnd_homeName_fontColor = "0x000000",
    bnd_awayName_text = "",
    bnd_awayName_right = -60,
    bnd_awayName_top = 0,
    bnd_awayName_fontSize = 20,
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
    bnd_homeScore_left = -17, 
    bnd_homeScore_fontSize = 25,
    bnd_homeScore_fontColor = "0x000000",
    bnd_awayScore_text = "",
    bnd_awayScore_top = 0,
    bnd_awayScore_right = -15,
    bnd_awayScore_fontSize = 25,
    bnd_awayScore_fontColor = "0x000000",
    bnd_score_text = "-",
    bnd_score_top = 1.25,
    bnd_score_left = -15000,
    bnd_score_fontSize = 20,
    bnd_score_fontColor = "0x34003A",

    bnd_time_width = 70,
    bnd_time_height = 25.5,
    bnd_time_top = 1,
    bnd_time_left = 10,
    bnd_timeBg_image = {
      name = "$ScoreBoard_Time",
      id = 10
    },
    bnd_time_text = "",
    bnd_time_fontSize = 20,
    bnd_time_fontColor = "0x000000",
    bnd_time_text_top = 0,
    bnd_time_text_left = 0,
    bnd_extraTime_visible = false,
    bnd_extraTime_width = 35,
    bnd_extraTime_height = 25.5,
    bnd_extraTime_top = 1,
    bnd_extraTime_left = 80,
    bnd_extraTimeBg_image = {
      name = "$ScoreBoard_ExtraTime",
      id = 10
    },
    bnd_extraTime_text = "",
    bnd_extraTime_fontSize = 20,
    bnd_extraTime_fontColor = "0x113A6F",

   bnd_stat_visible = false,
   bnd_stat_width = 218,
   bnd_stat_height = 35,
   bnd_stat_top = 33,
   bnd_stat_left = -207,
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
local PegadaianLiga2Score = {
  bnd_fontFace = "$DINPro-CondBold",
  bnd_width = 420,
  bnd_height = 34,
  bnd_top = 55,
  bnd_left = 80,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = false,
  bnd_logo_height = 80,
  bnd_logo_width = 245,
  bnd_logo_top = -30,
  bnd_logo_left = -80,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 2254
  },
  
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 31.2,
  bnd_homeRect_top = -8,
  bnd_homeRect_left = -205,
  bnd_homeRect_width = 8,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 31.1,
  bnd_awayRect_top = -8,
  bnd_awayRect_right = -40,
  bnd_awayRect_width = 8,

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
    name = "$Leaguelogo1",
    id = "CupID15_1"
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -165,
  bnd_homeName_top = -9,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = 11,
  bnd_awayName_top = -9,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0xffffff",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -2000000020,
  bnd_homeCrest_width = 48,
  bnd_homeCrest_height = 48,
  bnd_homeCrest_top = -9,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = -50000000005,
  bnd_awayCrest_width = 48,
  bnd_awayCrest_height = 48,
  bnd_awayCrest_top = -8,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -9,
  bnd_homeScore_left = -115,
  bnd_homeScore_fontSize = 24,
  bnd_homeScore_fontColor = "0xAEDE26",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -9,
  bnd_awayScore_right = 49,
  bnd_awayScore_fontSize = 24,
  bnd_awayScore_fontColor = "0xAEDE26",

  bnd_score_text = "",
  bnd_score_top = 0,
  bnd_score_left = -80,
  bnd_score_fontSize = 12,
  bnd_score_fontColor = "0x000000",

  bnd_time_width = 190,
  bnd_time_height = 76.5,
  bnd_time_top = -28.5,
  bnd_time_left = 207,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 2254
  },
  bnd_time_text = "",
  bnd_time_fontSize = 25,
  bnd_time_fontColor = "0x0D6046",
  bnd_time_text_top = 20,
  bnd_time_text_left = 0,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 82,
  bnd_extraTime_height = 76,
  bnd_extraTime_top = -28,
  bnd_extraTime_left = 315,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2254
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_text_top = 20,
  bnd_extraTime_text_left = -3,
  bnd_stat_visible = false,
  bnd_stat_width = 252.5,
  bnd_stat_height = 50,
  bnd_stat_top = 35,
  bnd_stat_left = 12,
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
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local PortugalScore = {
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

  bnd_score_text = "Liga Portugal",
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
local RestOfWorldScore = {
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

  bnd_score_text = "Rest Of World",
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
local RestOfWorld2Score = {
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

  bnd_score_text = "Rest Of World - B",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
local RusiaScore = {
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

  bnd_score_text = "Russia League",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
local SaudiArabiaScore = {
  bnd_fontFace = "$SPL",  
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 60,
  bnd_top = 40,
  bnd_left = 150,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 60,
  bnd_logo_width = 90,
  bnd_logo_top = 0,
  bnd_logo_left = -220,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 350
  },
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27,
  bnd_homeRect_top = -14,
  bnd_homeRect_left = -212,
  bnd_homeRect_width = 32,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27,
  bnd_awayRect_top = 14,
  bnd_awayRect_right = 212,
  bnd_awayRect_width = 32,

  bnd_homeBg_visible = false,
  bnd_homeBg_width = 90,
  bnd_homeBg_left = -150,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 350
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = 150,
  bnd_awayBg_height = 60,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 350
  },
  bnd_scoreBg_width = 35,
  bnd_scoreBg_height = 32,
  bnd_scoreBg_right = 105,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 350
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -170,
  bnd_homeName_top = -14,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = 170,
  bnd_awayName_top = 14,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0x000000",
  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -212,
  bnd_homeCrest_top = -14,
  bnd_homeCrest_width = 25,
  bnd_homeCrest_height = 25,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = 212,
  bnd_awayCrest_top = 14,
  bnd_awayCrest_width = 25,
  bnd_awayCrest_height = 25,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -14,
  bnd_homeScore_left = -124,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xffffff",

  bnd_awayScore_text = "",
  bnd_awayScore_top = 14,
  bnd_awayScore_right = 124,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xffffff",

  bnd_score_text = "-",
  bnd_score_top = 0.5,
  bnd_score_left = -3000,
  bnd_score_fontSize = 16,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 80,
  bnd_time_height = 60,
  bnd_time_top = 0,
  bnd_time_left = 113,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 350
  },
  bnd_time_text = "",
  bnd_time_fontSize = 16,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_left = -5,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 39,
  bnd_extraTime_top = 8,
  bnd_extraTime_left = 175,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 350
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0xFFFFFF",
  
  bnd_stat_visible = false,
  bnd_stat_width = 45,
  bnd_stat_height = 56,
  bnd_stat_top = 0,
  bnd_stat_left = -93,
  bnd_stat_color = "0xffffff",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 18,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = -19,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 0,
  bnd_away_stat_text_top = 20,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}
local ScotlandScore = {
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

  bnd_score_text = "SCOTTISH PREM",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
local SouthAfricaScore = {
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

  bnd_score_text = "SOUTH AFRICAN FL",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
local SpainScore = {
  bnd_text_bold = false,
  bnd_fontFace = "$LaLiga", 
  bnd_width = 420,
  bnd_height = 65,
  bnd_top = 38,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 33,
  bnd_logo_width = 50,
  bnd_logo_top = -16,
  bnd_logo_left = -133,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 53
  },
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 29,
  bnd_homeRect_top = -15.5,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 5,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 29,
  bnd_awayRect_top = 20.5,
  bnd_awayRect_right = 60,
  bnd_awayRect_width = 5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 40,
  bnd_homeBg_left = -88,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 53
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 77,
  bnd_awayBg_right = -68,
  bnd_awayBg_top = 50,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away2",
    id = 0
  },
  bnd_scoreBg_width = 33,
  bnd_scoreBg_height = 65,
  bnd_scoreBg_right = 52,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 53
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -57,
  bnd_homeName_top = -15,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = 57,
  bnd_awayName_top = 15,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0x000000",

  bnd_homeCrest = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_homeCrest_left = -90,
  bnd_homeCrest_top = -15,
  bnd_homeCrest_width = 25,
  bnd_homeCrest_height = 25,
  bnd_awayCrest = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_awayCrest_right = 90,
  bnd_awayCrest_top = 15,
  bnd_awayCrest_width = 25,
  bnd_awayCrest_height = 25,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -15,
  bnd_homeScore_left = -54,
  bnd_homeScore_fontSize = 28,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 18,
  bnd_awayScore_right = 54,
  bnd_awayScore_fontSize = 28,
  bnd_awayScore_fontColor = "0x000000",

  bnd_score_text = "",
  bnd_score_top = -1.5,
  bnd_score_left = 0,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 50,
  bnd_time_height = 32,
  bnd_time_top = 17,
  bnd_time_left = 62,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 53
  },
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 0,
  bnd_time_text_left = -3,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 40,
  bnd_extraTime_height = 32,
  bnd_extraTime_top = 17,
  bnd_extraTime_left = 22,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 53
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_text_top = 0,
  bnd_extraTime_text_left = -3,
  bnd_extraTime_fontColor = "0xffffff",

  bnd_stat_visible = false,
  bnd_stat_width = 40,
  bnd_stat_height = 65,
  bnd_stat_top = 0,
  bnd_stat_left = 180,
  bnd_stat_color = "0xFD4A45",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = -16,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 0,
  bnd_away_stat_text_top = 17,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text_fontColor = "0xffffff",
  bnd_stat_text = ""
}
local Spain2Score = {
  bnd_text_bold = false,
  bnd_fontFace = "$LaLiga", 
  bnd_width = 420,
  bnd_height = 65,
  bnd_top = 38,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 33,
  bnd_logo_width = 50,
  bnd_logo_top = -16,
  bnd_logo_left = -133,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 54
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
  bnd_homeBg_width = 40,
  bnd_homeBg_left = -88,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 54
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 77,
  bnd_awayBg_right = -68,
  bnd_awayBg_top = 50,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away2",
    id = 0
  },
  bnd_scoreBg_width = 33,
  bnd_scoreBg_height = 65,
  bnd_scoreBg_right = 52,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 54
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -57,
  bnd_homeName_top = -15,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = 57,
  bnd_awayName_top = 15,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0x000000",

  bnd_homeCrest = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_homeCrest_left = -90,
  bnd_homeCrest_top = -15,
  bnd_homeCrest_width = 25,
  bnd_homeCrest_height = 25,
  bnd_awayCrest = {
    name = "$LaLigaTeamCrest",
    id = 0
  },
  bnd_awayCrest_right = 90,
  bnd_awayCrest_top = 15,
  bnd_awayCrest_width = 25,
  bnd_awayCrest_height = 25,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -15,
  bnd_homeScore_left = -54,
  bnd_homeScore_fontSize = 28,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 18,
  bnd_awayScore_right = 54,
  bnd_awayScore_fontSize = 28,
  bnd_awayScore_fontColor = "0x000000",

  bnd_score_text = "",
  bnd_score_top = -1.5,
  bnd_score_left = 0,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0xffffff",

  bnd_time_width = 50,
  bnd_time_height = 32,
  bnd_time_top = 17,
  bnd_time_left = 62,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 54
  },
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 0,
  bnd_time_text_left = -3,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 40,
  bnd_extraTime_height = 32,
  bnd_extraTime_top = 17,
  bnd_extraTime_left = 22,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 53
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_text_top = 0,
  bnd_extraTime_text_left = -3,
  bnd_extraTime_fontColor = "0xffffff",

  bnd_stat_visible = false,
  bnd_stat_width = 40,
  bnd_stat_height = 65,
  bnd_stat_top = 0,
  bnd_stat_left = 180,
  bnd_stat_color = "0x05D4DC",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = -16,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 0,
  bnd_away_stat_text_top = 17,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text_fontColor = "0x000000",
  bnd_stat_text = ""
}
local SwitzerlandScore = {
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

  bnd_score_text = "RAIFFEISEN SL",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
local ThailandScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 30,
  bnd_top = 48,
  bnd_left = -10,
  bnd_scoreboard_width = 360,
  bnd_logo_inside_visible = true,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 75,
  bnd_logo_width = 80,
  bnd_logo_top = -30,
  bnd_logo_left = -9,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 2252
  },

  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 26.5,
  bnd_homeRect_top = -1,
  bnd_homeRect_left = -100,
  bnd_homeRect_width = 5,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 26.5,
  bnd_awayRect_top = -1,
  bnd_awayRect_right = -105,
  bnd_awayRect_width = 5,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 70,
  bnd_homeBg_left = -68,
  bnd_homeBg_height = 31,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 2252
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 70,
  bnd_awayBg_right = -68,
  bnd_awayBg_height = 31,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 2252
  },
  bnd_scoreBg_width = 65,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 2252
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -75,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 22,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_right = -72,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 22,
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
  bnd_homeScore_top = -2,
  bnd_homeScore_left = -17,
  bnd_homeScore_fontSize = 22,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -2,
  bnd_awayScore_right = -17,
  bnd_awayScore_fontSize = 22,
  bnd_awayScore_fontColor = "0xffffff",
  bnd_score_text = "-",
  bnd_score_top = -2,
  bnd_score_left = -1,
  bnd_score_fontSize = 25,
  bnd_score_fontColor = "0xffffff",
  bnd_time_width = 95,
  bnd_time_height = 40,
  bnd_time_top = 25,
  bnd_time_left = 192,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 2252
  },
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = -1,
  bnd_time_text_left = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 70,
  bnd_extraTime_height = 40,
  bnd_extraTime_top = 25,
  bnd_extraTime_left = 248,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2252
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xFE0000",
  
  bnd_stat_visible = false,
  bnd_stat_width = 205,
  bnd_stat_height = 55,
  bnd_stat_top = 40,
  bnd_stat_left = 137,
  bnd_stat_color = "0xFE0000",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xffffff",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 77,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = -3,
  bnd_stat_text_top = 15,
  bnd_stat_text_fontSize = 16,
  bnd_stat_text = ""
}
local TurkeyScore = {
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

  bnd_score_text = "Süper Lig",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
local UefaScore = {
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
local UefaUelScore = {
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
      id = 2238
    },
    bnd_awayBg_visible = true,
    bnd_awayBg_width = 80,
    bnd_awayBg_right = -70,
    bnd_awayBg_image = {
      name = "$ScoreBoard_Away",
      id = 2238
    },
    bnd_scoreBg_width = 90,
    bnd_scoreBg_height = 25,
    bnd_scoreBg_right = 0,
    bnd_scoreBg_image = {
      name = "$ScoreBoard_Score",
      id = 2238
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
      id = 2238
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
local UefaWomensScore = {
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
    id = 2236
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
local UkraineScore = {
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

  bnd_score_text = "UKRAYINA LIHA",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
local UnitedStatesScore = {
  bnd_text_bold = false,
  bnd_width = 420,
  bnd_height = 38,
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
    id = 39
  },
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 24.7,
  bnd_homeRect_top = -0.5,
  bnd_homeRect_left = -45,
  bnd_homeRect_width = 20,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 24.7,
  bnd_awayRect_top = -0.5,
  bnd_awayRect_right = -178,
  bnd_awayRect_width = 20,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 113,
  bnd_homeBg_left = 8,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 39
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 113,
  bnd_awayBg_right = -123,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 39
  },
  bnd_scoreBg_width = 110,
  bnd_scoreBg_height = 38,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 39
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -11.5,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0x1E1E1E",
  bnd_awayName_text = "",
  bnd_awayName_right = -143.5,
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
  bnd_homeScore_left = 51,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0x1E1E1E",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_right = -76,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0x1E1E1E",

  bnd_score_text = "",
  bnd_score_top = -10.5,
  bnd_score_left = -2,
  bnd_score_fontSize = 23,
  bnd_score_fontColor = "0x1E1E1E",

  bnd_time_width = 84,
  bnd_time_height = 33,
  bnd_time_top = -1,
  bnd_time_left = 90.5,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 39
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_left = -4,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 83.5,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 23,
  bnd_extraTime_left = 90.5,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 39
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xffffff",
  
    bnd_stat_visible = false,
    bnd_stat_width = 243,
    bnd_stat_height = 25,
    bnd_stat_top = 25,
    bnd_stat_left = 165,
    bnd_stat_color = "0x1E1E1E",
    bnd_home_stat_text = "",
    bnd_stat_fontSize = 19,
    bnd_stat_fontColor = "0xFFFFFF",
    bnd_home_stat_text_left = -95,
    bnd_home_stat_text_top = 0,
    bnd_away_stat_text = "",
    bnd_away_stat_text_left = 95,
    bnd_away_stat_text_top = 0,
    bnd_stat_text_left = -3,
    bnd_stat_text_top = 0,
    bnd_stat_text_fontSize = 19,
    bnd_stat_text_fontColor = "0xFFFFFF",
    bnd_stat_text = ""
}
local USANWSLScore = {
  bnd_text_bold = false,
  bnd_width = 380,
  bnd_height = 38,
  bnd_top = 38,
  bnd_left = 70,
  bnd_scoreboard_width = 400,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 45,
  bnd_logo_width = 219,
  bnd_logo_top = -20,
  bnd_logo_left = -82,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 2221
  },
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 26,
  bnd_homeRect_top = 0,
  bnd_homeRect_left = -110,
  bnd_homeRect_width = 117,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 26,
  bnd_awayRect_top = 0,
  bnd_awayRect_right = 8,
  bnd_awayRect_width = 105,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 120,
  bnd_homeBg_left = -118,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home",
    id = 2221
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 120,
  bnd_awayBg_right = 11,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away",
    id = 2221
  },
  bnd_scoreBg_width = 80,
  bnd_scoreBg_height = 38,
  bnd_scoreBg_right = -50,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score1",
    id = 2221
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -110,
  bnd_homeName_top = 1,
  bnd_homeName_fontSize = 22,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_right = 10,
  bnd_awayName_top = 1,
  bnd_awayName_fontSize = 22,
  bnd_awayName_fontColor = "0xFFFFFF",

  bnd_homeCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homeCrest_left = -155,
  bnd_homeCrest_width = 27,
  bnd_homeCrest_height = 27,
  bnd_homeCrest_top = 1,
  bnd_awayCrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awayCrest_right = 40,
  bnd_awayCrest_width = 27,
  bnd_awayCrest_height = 27,
  bnd_awayCrest_top = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = -75,
  bnd_homeScore_fontSize = 25,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_right = -30,
  bnd_awayScore_fontSize = 25,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text = "",
  bnd_score_top = -2.25,
  bnd_score_left = -8.5,
  bnd_score_fontSize = 30,
  bnd_score_fontColor = "0xFFFFFF",

  bnd_time_width = 105,
  bnd_time_height = 37,
  bnd_time_top = 0,
  bnd_time_left = 207,
  bnd_timeBg_image = {
      name = "$ScoreBoard_Time",
      id = 2221
  },
  bnd_time_text = "",
  bnd_time_fontSize = 25,
  bnd_time_fontColor = "0x1E1E1E",
  bnd_time_text_top = 0,
  bnd_time_text_left = -13,
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 90,
  bnd_extraTime_height = 38,
  bnd_extraTime_top = 1,
  bnd_extraTime_left = 235,
   
  bnd_extraTimeBg_image = {
      name = "$ScoreBoard_ExtraTime",
      id = 2221
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 25,
  bnd_extraTime_fontColor = "0x1E1E1E",
  
  bnd_stat_visible = false,
  bnd_stat_width = 211,
  bnd_stat_height = 28,
  bnd_stat_top = 31,
  bnd_stat_left = 10,
  bnd_stat_color = "0x1E1E1E",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 69,
  bnd_away_stat_text_top = 1,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 20,
  bnd_stat_text_fontColor = "0xFFFFFF",
  bnd_stat_text = ""
}
local VanaramaFootballLeagueScore = {
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

  bnd_score_text = "England National League",
  bnd_score_top = -44.5,
  bnd_score_left = -120,
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
local VietnamScore = { 
  bnd_text_bold = false,
  bnd_fontFace = "$Epl",
  bnd_width = 420,
  bnd_height = 38,
  bnd_top = 35,
  bnd_left = -15,
  bnd_scoreboard_width = 360,
  bnd_logo1_inside_visible = false,
  bnd_logo1_outside_visible = true,
  bnd_logo1_height = 80,
  bnd_logo1_width = 70,
  bnd_logo1_top = -25,
  bnd_logo1_left = -2,
  bnd_logo1_image = {
    name = "$ScoreBoard_Logo",
    id = 2260
  },

  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 25,
  bnd_homeRect_top = 0.4,
  bnd_homeRect_left = -87,
  bnd_homeRect_width = 121,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 25,
  bnd_awayRect_top = 0.4,
  bnd_awayRect_right = -52,
  bnd_awayRect_width = 121,

  bnd_homeBg_visible = true,
  bnd_homeBg_width = 90,
  bnd_homeBg_left = -80,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home1",
    id = 13
  },
  bnd_awayBg_visible = true,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -80,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away1",
    id = 13
  },
  bnd_scoreBg_width = 130,
  bnd_scoreBg_height = 27,
  bnd_scoreBg_right = 20,
  bnd_scoreBg_top = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score",
    id = 2260
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -110,
  bnd_homeName_top = -0,
  bnd_homeName_fontSize = 26,
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_text = "",
  bnd_awayName_right = -70,
  bnd_awayName_top = -0,
  bnd_awayName_fontSize = 26,
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
  bnd_homeScore_top = -3.5,
  bnd_homeScore_left = -60,
  bnd_homeScore_fontSize = 45,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -3.5,
  bnd_awayScore_right = -19,
  bnd_awayScore_fontSize = 45,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text = "-",
  bnd_score_top = 13,
  bnd_score_left = -1.5,
  bnd_score_fontSize = 0,
  bnd_score_fontColor = "0x34003A",
  
  bnd_time_width = 90,
  bnd_time_height = 33,
  bnd_time_top = 24.5,
  bnd_time_left = 178,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 2260
  },
  bnd_time_text = "",
  bnd_time_fontSize = 17,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 1,
  bnd_time_text_left = 0,
  
  bnd_extraTime_visible = false,
  bnd_extraTime_width = 130,
  bnd_extraTime_height = 26,
  bnd_extraTime_top = 48,
  bnd_extraTime_left = 158,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2260
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 17,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_text_top = -2,
  bnd_extraTime_text_left = -2,
  
  bnd_stat_visible = false,
  bnd_stat_width = 261,
  bnd_stat_height = 50,
  bnd_stat_top = 37,
  bnd_stat_left = 92,
  bnd_stat_color = "0xefefef",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 22,
  bnd_stat_fontColor = "0x000000",
  bnd_home_stat_text_left = -95,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 95,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 12,
  bnd_stat_text_fontSize = 20,
  bnd_stat_text = ""
}
local WomensSuperLeagueScore = {
  bnd_text_bold = false,
  bnd_width = 280,
  bnd_height = 30,
  bnd_top = 60,
  bnd_left = 100,
  bnd_scoreboard_width = 200,
  bnd_logo_inside_visible = false,
  bnd_logo_outside_visible = true,
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_top = -15,
  bnd_logo_left = -210,
  bnd_logo_image = {
    name = "$ScoreBoard_Logo",
    id = 2216
  },

  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 30,
  bnd_homeRect_top = -15,
  bnd_homeRect_left = -140,
  bnd_homeRect_width = 110,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 30,
  bnd_awayRect_top = -15,
  bnd_awayRect_right = 30,
  bnd_awayRect_width = 112,

  bnd_homeBg_visible = false,
  bnd_homeBg_width = 90,
  bnd_homeBg_left = -65,
  bnd_homeBg_image = {
    name = "$ScoreBoard_Home1",
    id = 0
  },
  bnd_awayBg_visible = false,
  bnd_awayBg_width = 90,
  bnd_awayBg_right = -65,
  bnd_awayBg_image = {
    name = "$ScoreBoard_Away1",
    id = 0
  },
  bnd_scoreBg_width = 120,
  bnd_scoreBg_height = 30,
  bnd_scoreBg_right = 0,
  bnd_scoreBg_image = {
    name = "$ScoreBoard_Score1",
    id = 0
  },
  bnd_homeName_text = "",
  bnd_homeName_left = -160,
  bnd_homeName_top = -15,
  bnd_homeName_fontSize = 26,
  bnd_homeName_fontColor = "0xF5F5F5",
  bnd_awayName_text = "",
  bnd_awayName_right = 20,
  bnd_awayName_top = -15,
  bnd_awayName_fontSize = 26,
  bnd_awayName_fontColor = "0xF5F5F5",
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
  bnd_homeScore_top = -15,
  bnd_homeScore_left = -106,
  bnd_homeScore_fontSize = 30,
  bnd_homeScore_fontColor = "0xF5F5F5",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -15,
  bnd_awayScore_right = 70,
  bnd_awayScore_fontSize = 30,
  bnd_awayScore_fontColor = "0xF5F5F5",
  
  bnd_score_text = "",
  bnd_score_top = -1.25,
  bnd_score_left = -1.5,
  bnd_score_fontSize = 20,
  bnd_score_fontColor = "0x000000",
  
  bnd_time_width = 70,
  bnd_time_height = 30,
  bnd_time_top = -15,
  bnd_time_left = 206,
  bnd_timeBg_image = {
    name = "$ScoreBoard_Time",
    id = 2216
  },
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0xF5F5F5",
  bnd_time_text_left = 0,
  bnd_time_text_top = 0,

  bnd_extraTime_visible = false,
  bnd_extraTime_width = 70,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = -15,
  bnd_extraTime_left = 206,
  bnd_extraTimeBg_image = {
    name = "$ScoreBoard_ExtraTime",
    id = 2216
  },
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 23,
  bnd_extraTime_fontColor = "0xF5F5F5",
  
  bnd_stat_visible = false,
  bnd_stat_width = 221,
  bnd_stat_height = 30,
  bnd_stat_top = 16,
  bnd_stat_left = -14,
  bnd_stat_color = "0x1D0F33",
  bnd_home_stat_text = "",
  bnd_stat_fontSize = 15,
  bnd_stat_fontColor = "0xF5F5F5",
  bnd_home_stat_text_left = -85,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 85,
  bnd_away_stat_text_top = 0,
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
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
  local Italy2Teams = o.services.TeamService.GetTeams(leagueIDs.Italy2, 0, 0, true)
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
  
  o.statVisible = false
  o.homeStat = "0%"
  o.awayStat = "0%"

  o.facts = nil

  liveLogo = {
    name = "$LiveLogo",
    id = 0
  }

    if o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
    currentScoreBoard = AlgeriaScore
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], AFFTeams) and o:isInTable(o.TeamsData[2], AFFTeams) then
    currentScoreBoard = AFFScore
    liveLogo.id = 1
 elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
    currentScoreBoard = ArgentinaScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
    currentScoreBoard = AsianCupU23Score
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, AsianCupU23TeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, AsianCupU23TeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    liveLogo.id = 1
  elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    currentScoreBoard = BelgiumScore
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    currentScoreBoard = BrazilScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    currentScoreBoard = ClassicScore 
    liveLogo.id = 34
  elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    currentScoreBoard = ClassicScore 
    liveLogo.id = 34
  elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    currentScoreBoard = ChampionshipEflScore 
    liveLogo.id = 6
  elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    currentScoreBoard = DenmarkScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    currentScoreBoard = D1ArkemaScore 
    liveLogo.id = 5
  elseif o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    currentScoreBoard = EcuadorScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    currentScoreBoard = EgyptScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    currentScoreBoard = EnglandScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, EnglandTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, EnglandTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    liveLogo.id = 2
  elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    currentScoreBoard = FranceScore
    liveLogo.id = 3
  elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    currentScoreBoard = France2Score
    liveLogo.id = 4
  elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    currentScoreBoard = GermanyScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, GermanyTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, GermanyTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_homeScore_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    currentScoreBoard.bnd_awayScore_fontColor = awayColorList[2]
    liveLogo.id = 11
   elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
    currentScoreBoard = Germany2Score
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Germany2TeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Germany2TeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_homeScore_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    currentScoreBoard.bnd_awayScore_fontColor = awayColorList[2]
    liveLogo.id = 12
   elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
    currentScoreBoard = IndonesiaScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, IndonesiaTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, IndonesiaTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    liveLogo.id = 14
   elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    currentScoreBoard = InternationalScore
    liveLogo.id = 0
   elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    currentScoreBoard = International2Score
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    currentScoreBoard = ItalyScore
    liveLogo.id = 15
  elseif o:isInTable(o.TeamsData[1], Italy2Teams) and o:isInTable(o.TeamsData[2], Italy2Teams) then
    currentScoreBoard = Italy2Score
    liveLogo.id = 16
  elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    currentScoreBoard = LeagueOneEflScore
    liveLogo.id = 7
  elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
    currentScoreBoard = LeagueTwoEflScore
    liveLogo.id = 8
  elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    currentScoreBoard = LigaFScore
    liveLogo.id = 18
  elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    currentScoreBoard = MalaysiaScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, MalaysiaTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, MalaysiaTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    liveLogo.id = 17
  elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    currentScoreBoard = MexicoScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    currentScoreBoard = MoroccoScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    currentScoreBoard = NetherlandsScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, NetherlandsTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, NetherlandsTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    liveLogo.id = 39
 elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    currentScoreBoard = PegadaianLiga2Score
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, PegadaianLiga2TeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, PegadaianLiga2TeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    liveLogo.id = 14
 elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    currentScoreBoard = PortugalScore
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    currentScoreBoard = RestOfWorldScore
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    currentScoreBoard = RestOfWorld2Score
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], RusiaTeams) and o:isInTable(o.TeamsData[2], RusiaTeams) then
    currentScoreBoard = RusiaScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    currentScoreBoard = SaudiArabiaScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, SaudiArabiaTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, SaudiArabiaTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    liveLogo.id = 19
  elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    currentScoreBoard = ScotlandScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    currentScoreBoard = SouthAfricaScore
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    currentScoreBoard = SpainScore
    liveLogo.id = 20
 elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    currentScoreBoard = Spain2Score
    liveLogo.id = 21
 elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    currentScoreBoard = SwitzerlandScore
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
    currentScoreBoard = ThailandScore
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    currentScoreBoard = TurkeyScore
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    currentScoreBoard = UefaScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, UefaTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, UefaTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    liveLogo.id = 22
 elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    currentScoreBoard = UefaUelScore
    liveLogo.id = 22
  elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
    currentScoreBoard = UefaWomensScore
    liveLogo.id = 18
  elseif o:isInTable(o.TeamsData[1], UkraineTeams) and o:isInTable(o.TeamsData[2], UkraineTeams) then
    currentScoreBoard = UkraineScore
    liveLogo.id = 0
 elseif o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
    currentScoreBoard = UnitedStatesScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, UnitedStatesTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, UnitedStatesTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    liveLogo.id = 23
  elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USANWSLTeams) then
    currentScoreBoard = USANWSLScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, USANWSLTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, USANWSLTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_homeScore_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    currentScoreBoard.bnd_awayScore_fontColor = awayColorList[2]
    liveLogo.id = 0
  elseif o:isInTable(o.TeamsData[1], VanaramaFootballLeagueTeams) and o:isInTable(o.TeamsData[2], VanaramaFootballLeagueTeams) then
    currentScoreBoard = VanaramaFootballLeagueScore
    liveLogo.id = 9
  elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
    currentScoreBoard = VietnamScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, VietnamTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, VietnamTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    liveLogo.id = 37
  elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
    currentScoreBoard = WomensSuperLeagueScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, WomensSuperLeagueTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, WomensSuperLeagueTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
    currentScoreBoard.bnd_homeScore_fontColor = homeColorList[2]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
    currentScoreBoard.bnd_awayScore_fontColor = awayColorList[2]
    liveLogo.id = 10
  else  
    currentScoreBoard = EAFCScore
    liveLogo.id = 0
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