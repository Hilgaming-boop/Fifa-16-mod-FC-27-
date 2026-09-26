-- REMOD MOUNTSA ( SUPPORT GROUP STAGE ) --
local ScoreClock = {}
local OverlaysIdContainer, OverlayParam, eventmanager, TableUtil = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes
local bndShowHUDVisible = "bnd_show_hud_visible"
local bndHideHUDVisible = "bnd_hide_hud_visible"
local bndNibsOnSideVisible = "bnd_nibs_on_side_visible"
local bndNibsOnCenterVisible = "bnd_nibs_on_center_visible"
local bndNibsOnSingleVisible = "bnd_nibs_on_single_visible"

local leagueIDs = {
  
  Brazil = 7,
  BelgiumProLeague = 4,
  Eredivisie = 10,
  internasional = 78,
  TurkeySuperLig  = 68,
  PremierLeague = 13,
  ChampionshipEfl = 14,
  LeagueOneEfl = 60,
  Ligue1 = 16,
  Bundesliga1 = 19,
  SerieA = 31,
  SerieB = 32,
  MLS = 39,
  Laliga = 53,
  LaligaHypermotion = 54,
  Mexico = 341,
  Malaysia = 2237,
  Portugal = 308,
  Argentina = 353,
  BRILiga1 = 2235,
  SaudiArabia = 350,
  ChampionshipLiga2 = 2254,
  UCL = 2236,
  Uwcl = 2240
}

PremierLeagueTeamsData = {
  { teamid = 1, homeColor = "0x9d1a27", awayColor = "0x001f4d", homeFontColor = "0xE0E0E0", awayFontColor = "0xC0C0C0" },  -- Arsenal: home merah + putih detail, away navy (“Night Indigo”) dengan lightning motif 0
  { teamid = 2, homeColor = "0x7A263A", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0x7A263A" },  -- Aston Villa, (home warna tradisional claret, away putih)
  { teamid = 5, homeColor = "0x034694", awayColor = "0x152238", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" },  -- Chelsea, home royal biru, tebakan away biru gelap
  { teamid = 7, homeColor = "0x003399", awayColor = "0xFF4040", homeFontColor = "0xFFFFFF", awayFontColor = "0x152238" },  -- Everton, home biru tua, away merah cerah (perkiraan)
  { teamid = 8, homeColor = "0xFFFFFF", awayColor = "0x0057B8", homeFontColor = "0x0057B8", awayFontColor = "0xFFFFFF" },  -- Leeds United, home putih, away biru
  { teamid = 9, homeColor = "0xC8102E", awayColor = "0x001F3B", homeFontColor = "0xFFFFFF", awayFontColor = "0xE0E0E0" },  -- Liverpool, home merah, away biru gelap
  { teamid = 10, homeColor = "0x80C6E7", awayColor = "0x000000", homeFontColor = "0x00285E", awayFontColor = "0xFFFFFF" },  -- Manchester City, home sky blue + putih, away hitam 1
  { teamid = 11, homeColor = "0xDA291C", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xDA291C" },  -- Manchester United, home merah, away putih (perkiraan)
  { teamid = 13, homeColor = "0x000000", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0x000000" },  -- Newcastle United, home hitam-putih stripe (gunakan hitam dominan), away putih
  { teamid = 14, homeColor = "0xDD1D21", awayColor = "0x004225", homeFontColor = "0xFFFFFF", awayFontColor = "0xE0E0E0" },  -- Nottingham Forest, home merah, away hijau gelap (perkiraan)
  { teamid = 18, homeColor = "0x132257", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0x132257" },  -- Tottenham Hotspur, home navy gelap (perkiraan), away putih
  { teamid = 19, homeColor = "0x60223B", awayColor = "0x1C1C1C", homeFontColor = "0xFFFFFF", awayFontColor = "0xE0E0E0" },  -- West Ham United, home claret/maroon, away hitam gelap (perkiraan)
  { teamid = 106, homeColor = "0xE31B23", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xE31B23" },  -- Sunderland, home merah, away putih
  { teamid = 110, homeColor = "0xFDB913", awayColor = "0x1C1C1C", homeFontColor = "0x000000", awayFontColor = "0xE0E0E0" },  -- Wolves, home emas / kuning tua, away hitam gelap
  { teamid = 144, homeColor = "0xFFFFFF", awayColor = "0x000000", homeFontColor = "0x000000", awayFontColor = "0xFFFFFF" },  -- Fulham, home putih, away hitam
  { teamid = 1796, homeColor = "0x6A003A", awayColor = "0xE3E3E3", homeFontColor = "0xE0E0E0", awayFontColor = "0x000000" },  -- Burnley, home claret gelap, away abu-abu terang (perkiraan)
  { teamid = 1799, homeColor = "0x1B458F", awayColor = "0xA7C6ED", homeFontColor = "0xFFFFFF", awayFontColor = "0x1B458F" },  -- Crystal Palace, home biru gelap, away biru muda
  { teamid = 1808, homeColor = "0x0057B8", awayColor = "0xFFCD00", homeFontColor = "0xFFFFFF", awayFontColor = "0x000000" },  -- Brighton & Hove Albion, home biru, away kuning emas (perkiraan)
  { teamid = 1925, homeColor = "0xE30613", awayColor = "0x000000", homeFontColor = "0xFFFFFF", awayFontColor = "0xE0E0E0" },  -- Brentford, home merah, away hitam
  { teamid = 1943, homeColor = "0xDA291C", awayColor = "0x1C1C1C", homeFontColor = "0xFFFFFF", awayFontColor = "0xE0E0E0" },   -- AFC Bournemouth, home merah, away hitam (perkiraan)
  { teamid = 126987, homeColor = "0xFFFFFF", awayColor = "0x000000", homeFontColor = "0x000000", awayFontColor = "0xFFFFFF" }   -- BHUTONK FC 
}

Bundesliga1TeamsData = {
  { teamid = 21, homeColor = "0xB80018", awayColor = "0xE0E0E0", homeFontColor = "0xE0E0E0", awayFontColor = "0xB80018" },
  { teamid = 22, homeColor = "0xF8D000", awayColor ="0x101010",homeFontColor = "0x101010", awayFontColor = "0xF8D000"},
  { teamid = 23, homeColor = "0xE0E0E0", awayColor ="0x30B060",homeFontColor = "0x30B060", awayFontColor = "0xE0E0E0"},
  { teamid = 25, homeColor = "0x9c2225", awayColor ="0x3e4041",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},   
  { teamid = 28, homeColor = "0xD0CFCE", awayColor = "0x313447", homeFontColor = "0x313447", awayFontColor = "0xD0CFCE"},
  { teamid = 31, homeColor = "0xE0E0E0", awayColor = "0xE01820",homeFontColor = "0xE01820", awayFontColor = "0xE0E0E0" },
  { teamid = 32, homeColor = "0xB81020", awayColor = "0x101010",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0"},
  { teamid = 36, homeColor = "0xd3d4d3", awayColor ="0xc62432",homeFontColor ="0xc62432" , awayFontColor = "0xd3d4d3"},
  { teamid = 38, homeColor = "0x289880", awayColor ="0xE1B5AD",homeFontColor ="0xE0E0E0" , awayFontColor = "0x289880"},
  { teamid = 160, homeColor ="0x1d3552" , awayColor ="0x65a7d4",homeFontColor = "0xE0E0E0", awayFontColor ="0x202838" }, 
  { teamid = 169, homeColor = "0xD01818", awayColor = "0xD8D8D8",homeFontColor = "0xD8D8D8", awayFontColor = "0xD01818"},
  { teamid = 175, homeColor = "0x50A830", awayColor ="0x383C3D",homeFontColor = "0xE0E0E0", awayFontColor = "0x50A830"},
  { teamid = 1824, homeColor ="0xD7D7D5" , awayColor ="0x323231",homeFontColor = "0x323231", awayFontColor ="0xD7D7D5" },  
  { teamid = 1831, homeColor ="0xbc1e20" , awayColor ="0xd5cbbb",homeFontColor = "0xd5cbbb", awayFontColor ="0xbc1e20" },  
  { teamid = 10029, homeColor ="0x204390" , awayColor = "0xcec29a",homeFontColor = "0xcec29a", awayFontColor = "0x204390"},  
  { teamid = 100409, homeColor = "0xaa2327", awayColor ="0xd2d1d0",homeFontColor = "0xd2d1d0", awayFontColor = "0xaa2327"}, 
  { teamid = 112172, homeColor = "0xf9f8f8", awayColor ="0xa51b21",homeFontColor = "0xa51b21", awayFontColor = "0xf9f8f8"},   
  { teamid = 111235, homeColor = "0xC7181D", awayColor = "0x2958A0",homeFontColor = "0x2958A0", awayFontColor = "0xC7181D"},
  { teamid = 110502, homeColor = "0xD0CFCE", awatColor = "0x313447", homeFontColor = "0x313447", awayFontColor = "0xD0CFCE"}
}

Bundesliga2TeamsData = {
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

BRILiga1TeamsData = {
  { teamid = 155600, homeColor = "0x0841B3", awayColor = "0xD7DADE", homeFontColor = "0xffffff", awayFontColor = "0xED0C0E" },
  { teamid = 155601, homeColor = "0x800202", awayColor = "0xfffffff", homeFontColor = "0xffffff", awayFontColor = "0x800202" },
  { teamid = 155602, homeColor = "0x0D41A5", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x0D41A5" },
  { teamid = 155603, homeColor = "0xE72629", awayColor = "0xffffff", homeFontColor = "0xFDD05D", awayFontColor = "0x000000" },
  { teamid = 155604, homeColor = "0x01712C", awayColor = "0xFFFB01", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155606, homeColor = "0x8E1502", awayColor = "0x000000", homeFontColor = "0xfffffff", awayFontColor = "0xfffffff" },
  { teamid = 155607, homeColor = "0xB00101", awayColor = "0xffffff", homeFontColor = "0xfffffff", awayFontColor = "0x000000" }, 
  { teamid = 155609, homeColor = "0xC19823", awayColor = "0xffffff", homeFontColor = "0x000000", awayFontColor = "0xC19823" },
  { teamid = 155611, homeColor = "0x000000", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155612, homeColor = "0x7F46A6", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155614, homeColor = "0xC40505", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155616, homeColor = "0xA40101", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xA40101" },
  { teamid = 155617, homeColor = "0x1F0454", awayColor = "0xffffff", homeFontColor = "0xFFD454", awayFontColor = "0x1F0454" },
  { teamid = 155618, homeColor = "0xCA0303", awayColor = "0xF5D401", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
  { teamid = 155620, homeColor = "0x025E01", awayColor = "0xBEB307", homeFontColor = "0xffffff", awayFontColor = "0x025E01" },
  { teamid = 155621, homeColor = "0xCA0101", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xCA0101" },
  { teamid = 155624, homeColor = "0x163F90", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x163F90" },
  { teamid = 155630, homeColor = "0xC60101", awayColor = "0xffffff", homeFontColor = "0xfffffff", awayFontColor = "0xC60101" }
}

SaudiArabiaTeamsData = {
  { teamid = 605, homeColor = "0x000080", awayColor = "0x000080", homeFontColor = "0xc82727", awayFontColor = "0x875636" },
  { teamid = 607, homeColor = "0xE2BA00", awayColor = "0xE2BA00", homeFontColor = "0xc82727", awayFontColor = "0x0000ff" },
  { teamid = 111674, homeColor = "0x0D41A5", awayColor = "0xc82727", homeFontColor = "0xc82727", awayFontColor = "0x0D41A5" },
  { teamid = 112096, homeColor = "0xE72629", awayColor = "0xc82727", homeFontColor = "0xFDD05D", awayFontColor = "0x197FC5" },
  { teamid = 112139, homeColor = "0xE2BA00", awayColor = "0x197FC5", homeFontColor = "0xE2BA00", awayFontColor = "0x197FC5" },
  { teamid = 112387, homeColor = "0x8E1502", awayColor = "0x197FC5", homeFontColor = "0x875636", awayFontColor = "0x00009E" },
  { teamid = 112391, homeColor = "0xB00101", awayColor = "0x875636", homeFontColor = "0x00009E", awayFontColor = "0x197FC5" }, 
  { teamid = 112393, homeColor = "0xC19823", awayColor = "0xc82727", homeFontColor = "0x197FC5", awayFontColor = "0xC19823" },
  { teamid = 112883, homeColor = "0x000000", awayColor = "0xc82727", homeFontColor = "0x34434e", awayFontColor = "0x197FC5" },
  { teamid = 113037, homeColor = "0x7F46A6", awayColor = "0xc82727", homeFontColor = "0x34434e", awayFontColor = "0x197FC5" },
  { teamid = 113057, homeColor = "0xC40505", awayColor = "0x875636", homeFontColor = "0xc82727", awayFontColor = "0x197FC5" },
  { teamid = 113060, homeColor = "0xA40101", awayColor = "0x875636", homeFontColor = "0x875636", awayFontColor = "0xA40101" },
  { teamid = 155617, homeColor = "0x1F0454", awayColor = "0xc82727", homeFontColor = "0xFFD454", awayFontColor = "0x1F0454" },
  { teamid = 113222, homeColor = "0xCA0303", awayColor = "0xF5D401", homeFontColor = "0x34434e", awayFontColor = "0x197FC5" },
  { teamid = 115892, homeColor = "0x025E01", awayColor = "0xBEB307", homeFontColor = "0xc82727", awayFontColor = "0x025E01" },
  { teamid = 121735, homeColor = "0xCA0101", awayColor = "0xc82727", homeFontColor = "0x875636", awayFontColor = "0xCA0101" },
  { teamid = 155624, homeColor = "0x163F90", awayColor = "0x34434e", homeFontColor = "0xc82727", awayFontColor = "0x163F90" },
  { teamid = 121798, homeColor = "0xC60101", awayColor = "0x00009E", homeFontColor = "0x34434e", awayFontColor = "0xC60101" },
  { teamid = 112390, homeColor = "0x197FC5", awayColor = "0x734203", homeFontColor = "0x34434e", awayFontColor = "0xC60101" }
}

ChampionshipLiga2TeamsData = { 
  { teamid = 155605, homeColor = "0x134BBA", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155610, homeColor = "0xFBDF4B", awayColor ="0x000000",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 155615, homeColor = "0x01830B", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155619, homeColor = "0xDBD058", awayColor ="0x000000",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 155622, homeColor = "0xAD0101", awayColor ="0x000000",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 155623, homeColor = "0x025A10", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155625, homeColor = "0x39CFF7", awayColor ="0x1D1D1D",homeFontColor = "0x000000", awayFontColor = "0xffffff"},
  { teamid = 155631, homeColor = "0x102040", awayColor ="0xF18300",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155632, homeColor = "0x000000", awayColor ="0x0D5F18",homeFontColor = "0xffffff", awayFontColor = "0xffffff"},
  { teamid = 155633, homeColor = "0xEB7916", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155634, homeColor = "0x000000", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155635, homeColor = "0x1E65F5", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155636, homeColor = "0xDE0101", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155637, homeColor = "0x03063E", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155638, homeColor = "0xA10101", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155639, homeColor = "0x1D1B7F", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155640, homeColor = "0x2328B5", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155641, homeColor = "0x1A1181", awayColor ="0xffffff",homeFontColor = "0xffffff", awayFontColor = "0x000000"},
  { teamid = 155642, homeColor = "0xffffff", awayColor ="0x10246C",homeFontColor = "0x000000", awayFontColor = "0xFFBC3A"}
}
 
 WC26TeamsData = {
  { teamid = 1370, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Brazil
  { teamid = 1337, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Germany
  { teamid = 1369, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Argentina
  { teamid = 1343, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Italy
  { teamid = 1335, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- France
  { teamid = 1318, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- England
  { teamid = 1362, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Spain
  { teamid = 105035, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Netherlands
  { teamid = 1354, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Portugal
  { teamid = 1325, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Belgium
  { teamid = 1377, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Uruguay
  { teamid = 1328, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Croatia
  { teamid = 1364, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Switzerland
  { teamid = 1363, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Sweden
  { teamid = 1331, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Denmark
  { teamid = 110082, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Serbia
  { teamid = 1353, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Poland
  { teamid = 1386, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Mexico
  { teamid = 1387, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- USA
  { teamid = 1411, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Japan
  { teamid = 974, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Korea Republic
  { teamid = 111115, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- IR Iran
  { teamid = 111114, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Saudi Arabia
  { teamid = 1415, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Australia
  { teamid = 111111, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Morocco
  { teamid = 1667, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Senegal
  { teamid = 1393, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Nigeria
  { teamid = 1395, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Cameroon
  { teamid = 111462, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Ghana
  { teamid = 111112, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Côte d'Ivoire
  { teamid = 1391, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Tunisia
  { teamid = 111109, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Colombia
  { teamid = 111459, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Chile
  { teamid = 111465, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Ecuador
  { teamid = 1375, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Paraguay
  { teamid = 111510, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Indonesia
  { teamid = 1365, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Turkey
  { teamid = 1366, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Ukraine
  { teamid = 1367, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Wales
  { teamid = 111512, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Iraq
  { teamid = 111533, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Thailand
  { teamid = 111506, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Timor Leste
  { teamid = 111505, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Cambodia
  { teamid = 111513, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Jordan
  { teamid = 111487, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Venezuela
  { teamid = 111391, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Bahrain
  { teamid = 111523, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Oman
  { teamid = 111449, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Angola
  { teamid = 111514, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Kyrgyzstan
  { teamid = 111536, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- UAE
  { teamid = 111532, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Tajikistan
  { teamid = 111456, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Cape Verde
  { teamid = 1357, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Russia
  { teamid = 111464, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Hongkong
  { teamid = 111515, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Laos
  { teamid = 1330, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Czech Republic
  { teamid = 1360, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Slovakia
  { teamid = 1359, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Scotland
  { teamid = 1356, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Romania
  { teamid = 1886, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Hungary
  { teamid = 111521, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Myanmar
  { teamid = 111473, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- New Zealand
  { teamid = 111466, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- India
  { teamid = 111455, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Canada
  { teamid = 111451, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Bolivia
  { teamid = 111448, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Algeria
  { teamid = 111130, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Egypt
  { teamid = 111108, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Peru
  { teamid = 111099, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- South Africa
  { teamid = 110081, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Northern Ireland
  { teamid = 105022, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- North Macedonia
  { teamid = 111527, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Qatar
  { teamid = 111461, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Gabon
  { teamid = 111475, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Panama
  { teamid = 111525, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Palestine
  { teamid = 111453, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Burkina Faso
  { teamid = 111528, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Singapore
  { teamid = 111504, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Brunei Darussalam
  { teamid = 1361, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Slovenia
  { teamid = 111526, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Philippines
  { teamid = 1319, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Albania
  { teamid = 105013, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Bosnia-Herzegovina
  { teamid = 1413, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- China PR
  { teamid = 1327, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Bulgaria
  { teamid = 1322, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Austria
  { teamid = 1334, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Finland
  { teamid = 1352, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Norway
  { teamid = 111518, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Malaysia
  { teamid = 112048, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Haiti
  { teamid = 111545, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- DR Congo
  { teamid = 111485, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Uzbekistan
  { teamid = 111489, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Zambia
  { teamid = 111550, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Mali
  { teamid = 111488, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Vietnam
  { teamid = 1355, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Republic of Ireland
  { teamid = 111530, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Syria
  { teamid = 1336, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Georgia
  { teamid = 111481, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Jamaica
  { teamid = 112062, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Tanzania
  { teamid = 112044, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Gambia
  { teamid = 111483, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Togo
  { teamid = 112046, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Guinea-Bissau
  { teamid = 112049, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Madagascar
  { teamid = 111472, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Mozambique
  { teamid = 111392, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Kuwait
  { teamid = 111549, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Korea DPR
  { teamid = 112054, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Curacao
  { teamid = 112060, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Suriname
  { teamid = 111740, homeColor = "0xFF0000", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Montenegro
  { teamid = 111463, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Guinea
  { teamid = 105042, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- San Marino
  { teamid = 111516, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Lebanon
  { teamid = 111502, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Bangladesh
  { teamid = 111486, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Vanuatu
  { teamid = 111537, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Tahiti
  { teamid = 112486, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Papua New Guinea
  { teamid = 112063, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Tonga
  { teamid = 111547, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Fiji
  { teamid = 111548, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Honduras
  { teamid = 111546, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- El Salvador
  { teamid = 111524, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Pakistan
  { teamid = 112067, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Yemen
  { teamid = 1321, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Armenia
  { teamid = 114639, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Kosovo
  { teamid = 1349, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Malta
  { teamid = 1323, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Azerbaijan
  { teamid = 1333, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Faroe Islands
  { teamid = 111450, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Benin
  { teamid = 111555, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }, -- Uganda
  { teamid = 111113, homeColor = "0xFFFFFF", awayColor = "0xFFFFFF", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" }  -- Guatemala
}

local EAFCScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpanded", 
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 130,
  bnd_scoreboard_width = 195,
  bnd_scoreboard_top = 15,
  bnd_scoreboard_left = -30,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 0 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 12,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 9,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 0,
  
  bnd_homeName_text = "",
  bnd_homeName_left = 85,
  bnd_homeName_top = -10,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 85,
  bnd_awayName_top = 20,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "LEFT",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_homeCrest_left = 145,
  bnd_homeCrest_Top = -10,
  bnd_homeCrest_width = 23,
  bnd_homeCrest_height = 23,
  bnd_awayCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest_left = 145,
  bnd_awayCrest_top = 18,
  bnd_awayCrest_width = 23,
  bnd_awayCrest_height = 23,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -10,
  bnd_homeScore_left = 40,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 20,
  bnd_awayScore_left = 40,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 13,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 43,
  bnd_time_text_left = 85,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0},
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x04F377", 
  bnd_extraTime_width = 0,
  bnd_extraTime_height = 0,
  bnd_extraTime_top = 43,
  bnd_extraTime_left = 160,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 13,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 220,
  bnd_stat_height = 72,
  bnd_stat_top = 15,
  bnd_stat_left = 210,
  bnd_stat_color = "0x1CDC6B",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 5,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 25,
  bnd_homeStatCrest_height = 25,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 190,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 25,
  bnd_awayStatCrest_height = 25,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0x000000",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -65,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 55,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0x151515",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "CENTER",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0x000000",
  bnd_stat_text_left = -5,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 8,
  bnd_stat_text = ""
  }

local PREMIERLEAGUEScore = {
  bnd_text_bold = true,
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl",
  bnd_scoreboard_inside_visible = false,
  bnd_scoreboard_outside_visible = true,
  bnd_scoreboard_height = 100,
  bnd_scoreboard_width = 300,
  bnd_scoreboard_top = 0,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 13 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 12,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_cornerRaduis = 8,
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -90,
  bnd_homeName_top = 3,
  bnd_homeName_fontSize = 25,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 90,
  bnd_awayName_top = 3,
  bnd_awayName_fontSize = 25,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",

  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 20,
  bnd_goalAnimation_top = 2,
  bnd_goalAnimation_width = 260,
  bnd_goalAnimation_height = 38,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 0,
  bnd_homeCrest_Top = -200,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 0,
  bnd_awayCrest_top = -200,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 1,
  bnd_homeScore_left = -30,
  bnd_homeScore_fontSize = 40,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 1,
  bnd_awayScore_left = 30,
  bnd_awayScore_fontSize = 40,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",

  bnd_time_text = "",
  bnd_time_fontSize = 14,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 26.5,
  bnd_time_text_left = 0,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTime", id = 13 },
  bnd_extraTime_color_show = false,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 160,
  bnd_extraTime_height = 23,
  bnd_extraTime_top = 43,
  bnd_extraTime_left = 1,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 14,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,

  bnd_stat_width = 200,
  bnd_stat_height = 70,
  bnd_stat_top = 40,
  bnd_stat_left = 0,
  bnd_stat_color = "0xFFFFFF",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 0,
  
  bnd_stat_image = { name = "$Statistik", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  -- 🔹 Nama tim di stat board
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 15,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 15,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0x38003D",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = 48,
  bnd_home_stat_text_top = 10,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 48,
  bnd_away_stat_text_top = 35,
  
  bnd_stat_bgtext_color = "0x000000",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "CENTER",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 67,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local ChampionshipEflScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 140,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 14 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = 10,
  bnd_homeName_top = 5,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 110,
  bnd_awayName_top = 5,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -20,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0x000000",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0x000000",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 4,
  bnd_homeScore_left = 50,
  bnd_homeScore_fontSize = 25,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 4,
  bnd_awayScore_left = 76,
  bnd_awayScore_fontSize = 25,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 5,
  bnd_time_text_left = -47,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x000000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = -85,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 205,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 97,
  bnd_stat_color = "0x212121",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local LeagueOneEflScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 280,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 60 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_cornerRaduis = 5,
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 30,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -58,
  bnd_homeRect_width = 122,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 30,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 60,
  bnd_awayRect_width = 115,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -95,
  bnd_homeName_top = 35,
  bnd_homeName_fontSize = 18,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 30,
  bnd_awayName_top = 35,
  bnd_awayName_fontSize = 18,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 41,
  bnd_homeCrest_Top = 6,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 169,
  bnd_awayCrest_top = 6,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 5,
  bnd_homeScore_left = -48,
  bnd_homeScore_fontSize = 35,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 5,
  bnd_awayScore_left = -15,
  bnd_awayScore_fontSize = 35,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 22,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 35,
  bnd_time_text_left = -32,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = 100,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 202,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 15,
  bnd_stat_color = "0x212121",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local LALIGAScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 80,
  bnd_scoreboard_width = 160,
  bnd_scoreboard_top = 10,
  bnd_scoreboard_left = -20,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 53 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0.000000001,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 0.000000001,
  
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0.000000001,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 0.000000001,
  
  bnd_homeName_text = "",
  bnd_homeName_left = 69,
  bnd_homeName_top = -13,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 69,
  bnd_awayName_top = 14,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "LEFT",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 160,
  bnd_goalAnimation_top = 10,
  bnd_goalAnimation_width = 230,
  bnd_goalAnimation_height = 78,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$CrestAnim_Laliga", id = 0 },
  bnd_homeCrest_left = 120,
  bnd_homeCrest_Top = -10,
  bnd_homeCrest_width = 28,
  bnd_homeCrest_height = 28,
  bnd_awayCrest = { name = "$CrestAnim_Laliga", id = 0 },
  bnd_awayCrest_left = 120,
  bnd_awayCrest_top = 27,
  bnd_awayCrest_width = 28,
  bnd_awayCrest_height = 28,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -10,
  bnd_homeScore_left = 175,
  bnd_homeScore_fontSize = 25,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 29,
  bnd_awayScore_left = 175,
  bnd_awayScore_fontSize = 25,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "LEFT",
  
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 30,
  bnd_time_text_left = 65,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0},
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xFFFFFF", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 35,
  bnd_extraTime_top = 30,
  bnd_extraTime_left = 60,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 100,
  bnd_stat_height = 50.8,
  bnd_stat_top = 10,
  bnd_stat_left = 205,
  bnd_stat_color = "0x000000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 0,
  
  bnd_stat_image = { name = "$Statistik", id = 53 },
  bnd_stat_image_left = 0,
  bnd_stat_image_top = 0,
  bnd_stat_image_width = 220,
  bnd_stat_image_height = 77,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 25,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = 85,
  bnd_home_stat_text_top = -20,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 85,
  bnd_away_stat_text_top = 20,
  
  bnd_stat_bgtext_color = "0xffffff",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "CENTER",
  bnd_stat_bgtext_color_width = 0.1,
  bnd_stat_bgtext_color_height = 0.1,
  bnd_stat_fontColor = "0xffffff",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
}
local LaligaHypermotionScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 80,
  bnd_scoreboard_width = 160,
  bnd_scoreboard_top = 10,
  bnd_scoreboard_left = -20,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 54 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0.000000001,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 0.000000001,
  
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0.000000001,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 0.000000001,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -17,
  bnd_homeName_top = -10,
  bnd_homeName_fontSize = 17,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = -17,
  bnd_awayName_top = 27,
  bnd_awayName_fontSize = 17,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 160,
  bnd_goalAnimation_top = 10,
  bnd_goalAnimation_width = 230,
  bnd_goalAnimation_height = 78,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crestx", id = 0 },
  bnd_homeCrest_left = 120,
  bnd_homeCrest_Top = -10,
  bnd_homeCrest_width = 28,
  bnd_homeCrest_height = 28,
  bnd_awayCrest = { name = "$Crestx", id = 0 },
  bnd_awayCrest_left = 120,
  bnd_awayCrest_top = 27,
  bnd_awayCrest_width = 28,
  bnd_awayCrest_height = 28,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -10,
  bnd_homeScore_left = 175,
  bnd_homeScore_fontSize = 25,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 29,
  bnd_awayScore_left = 175,
  bnd_awayScore_fontSize = 25,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "LEFT",
  
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 30,
  bnd_time_text_left = -70,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0},
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xFFFFFF", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 35,
  bnd_extraTime_top = 30,
  bnd_extraTime_left = -10,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 100,
  bnd_stat_height = 50.8,
  bnd_stat_top = 10,
  bnd_stat_left = 205,
  bnd_stat_color = "0x000000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 0,
  
  bnd_stat_image = { name = "$Statistik", id = 54 },
  bnd_stat_image_left = 0,
  bnd_stat_image_top = 0,
  bnd_stat_image_width = 220,
  bnd_stat_image_height = 77,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 25,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = 85,
  bnd_home_stat_text_top = -20,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 85,
  bnd_away_stat_text_top = 20,
  
  bnd_stat_bgtext_color = "0xffffff",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "CENTER",
  bnd_stat_bgtext_color_width = 0.1,
  bnd_stat_bgtext_color_height = 0.1,
  bnd_stat_fontColor = "0xffffff",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 18,
  bnd_stat_text = ""
  }
  
local BUNDESLIGA1Score= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$KnulExtraBold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 100,
  bnd_scoreboard_width = 300,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 19 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 50.9,
  bnd_homeRect_top = 0.5,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 40,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 50.9,
  bnd_awayRect_top = 0.5,
  bnd_awayRect_left = -25,
  bnd_awayRect_width = 40,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -65,
  bnd_homeName_top = -15,
  bnd_homeName_fontSize = 14,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = -25,
  bnd_awayName_top = -15,
  bnd_awayName_fontSize = 14,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 21,
  bnd_goalAnimation_top = 4,
  bnd_goalAnimation_width = 132,
  bnd_goalAnimation_height = 128,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 72,
  bnd_homeCrest_Top = -1000,
  bnd_homeCrest_width = 18,
  bnd_homeCrest_height = 18,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 72,
  bnd_awayCrest_top = -1000,
  bnd_awayCrest_width = 18,
  bnd_awayCrest_height = 18,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 7,
  bnd_homeScore_left = -65,
  bnd_homeScore_fontSize = 30,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 7,
  bnd_awayScore_left = -25,
  bnd_awayScore_fontSize = 30,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 13,
  bnd_time_fontColor = "0xf5f5f5",
  bnd_time_text_top = -16.4,
  bnd_time_text_left = 30,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0},
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xFFFFFF", 
  bnd_extraTime_width = 40,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 9,
  bnd_extraTime_left = 24,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 120,
  bnd_stat_height = 19,
  bnd_stat_top = 38,
  bnd_stat_left = 24,
  bnd_stat_color = "0xf5f5f5",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 13,
  bnd_stat_h_a_fontColor = "0x000000",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = 0,
  bnd_home_stat_text_top = 1,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 40,
  bnd_away_stat_text_top = 1,
  
  bnd_stat_bgtext_color = "0x000000",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0x000000",
  bnd_stat_text_left = -40,
  bnd_stat_text_top = 1,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local LIGUE1Score = {
  bnd_text_bold = true,
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 105,
  bnd_scoreboard_width = 160,
  bnd_scoreboard_top = 10,
  bnd_scoreboard_left = -7,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 16 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = 140,
  bnd_homeName_top = -20,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 140,
  bnd_awayName_top = 12,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "LEFT",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 75,
  bnd_goalAnimation_top = 24,
  bnd_goalAnimation_width = 250,
  bnd_goalAnimation_height = 170,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 72,
  bnd_homeCrest_Top = -1000,
  bnd_homeCrest_width = 18,
  bnd_homeCrest_height = 18,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 72,
  bnd_awayCrest_top = -1000,
  bnd_awayCrest_width = 18,
  bnd_awayCrest_height = 18,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -20,
  bnd_homeScore_left = 45,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 12,
  bnd_awayScore_left = 45,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0x1F1F1F",
  bnd_time_text_top = 42,
  bnd_time_text_left = -55,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0},
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x085EFF",
  bnd_extraTime_width = 60,
  bnd_extraTime_height = 28,
  bnd_extraTime_top = 42,
  bnd_extraTime_left = 8,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 20,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 100,
  bnd_stat_height = 56.3,
  bnd_stat_top = -30,
  bnd_stat_left = 100,
  bnd_stat_color = "0x565656",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 0,
  
  bnd_stat_image = { name = "$Statistik", id = 16 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 27,
  bnd_stat_image_width = 220,
  bnd_stat_image_height = 65,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -10,
  bnd_homeStatName_top = 42,
  bnd_homeStatName_fontSize = 15,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = 100,
  bnd_awayStatName_top = 42,
  bnd_awayStatName_fontSize = 15,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -10,
  bnd_home_stat_text_top = 10,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 100,
  bnd_away_stat_text_top = 10,
  
  bnd_stat_bgtext_color = "0x085EFF",
  bnd_stat_bgtext_color_alignV = "BOTTOM",
  bnd_stat_bgtext_color_alignH = "CENTER",
  bnd_stat_bgtext_color_width = 0.0001,
  bnd_stat_bgtext_color_height = 0.0001,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 45,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local SERIEAScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Title_Original",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 70,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 31 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -18,
  bnd_homeName_top = 6,
  bnd_homeName_fontSize = 18,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 105,
  bnd_awayName_top = 6,
  bnd_awayName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 75,
  bnd_goalAnimation_top = 7,
  bnd_goalAnimation_width = 250,
  bnd_goalAnimation_height = 101,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 6,
  bnd_homeScore_left = 32,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x02215D",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 6,
  bnd_awayScore_left = 60,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x02215D",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x02215D",
  bnd_time_text_top = 6,
  bnd_time_text_left = -85,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTime", id = 31 },
  bnd_extraTime_color_show = false,
  bnd_extraTime_color = "0x241A7A", 
  bnd_extraTime_width = 74,
  bnd_extraTime_height = 33,
  bnd_extraTime_top = 6,
  bnd_extraTime_left = 172,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 208,
  bnd_stat_height = 0.0001,
  bnd_stat_top = 37,
  bnd_stat_left = 40,
  bnd_stat_color = "0x02215D",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistik", id = 31 },
  bnd_stat_image_left = 27,
  bnd_stat_image_top = 0,
  bnd_stat_image_width = 300,
  bnd_stat_image_height = 80,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 16,
  bnd_stat_h_a_fontColor = "0x02215D",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -35,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 95,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 70,
  bnd_stat_bgtext_color_height = 0.00001,
  bnd_stat_fontColor = "0x02215D",
  bnd_stat_text_left = 30,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 16,
  bnd_stat_text = ""
}
  local SERIEBScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Title_Original",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 100,
  bnd_scoreboard_width = 300,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 32 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -25,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 65,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = 8,
  bnd_homeScore_fontSize = 15,
  bnd_homeScore_fontColor = "0x02215D",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_left = 29.3,
  bnd_awayScore_fontSize = 15,
  bnd_awayScore_fontColor = "0x02215D",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0x02215D",
  bnd_time_text_top = 0,
  bnd_time_text_left = 55,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTime", id = 31 },
  bnd_extraTime_color_show = false,
  bnd_extraTime_color = "0x241A7A", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 30,
  bnd_extraTime_top = 0,
  bnd_extraTime_left = 232,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 208,
  bnd_stat_height = 20,
  bnd_stat_top = 23.5,
  bnd_stat_left = 26,
  bnd_stat_color = "0x02215D",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -10,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 80,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 70,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0x02215D",
  bnd_stat_text_left = -70,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local EredivisieScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 280,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 10 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -95,
  bnd_homeName_top = 5,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 30,
  bnd_awayName_top = 5,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 5,
  bnd_homeScore_left = -48,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 5,
  bnd_awayScore_left = -15,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 5,
  bnd_time_text_left = 100,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = 100,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 202,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 15,
  bnd_stat_color = "0x212121",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local internasionalScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpanded", 
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 230,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 70,
  bnd_scoreboard_left = -30,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 78 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 12,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 9,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 0,
  
  bnd_homeName_text = "",
  bnd_homeName_left = 120,
  bnd_homeName_top = -10,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 120,
  bnd_awayName_top = 22,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "LEFT",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_homeCrest_left = 145,
  bnd_homeCrest_Top = -10,
  bnd_homeCrest_width = 23,
  bnd_homeCrest_height = 23,
  bnd_awayCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_awayCrest_left = 145,
  bnd_awayCrest_top = 18,
  bnd_awayCrest_width = 23,
  bnd_awayCrest_height = 23,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -10,
  bnd_homeScore_left = 35,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 22,
  bnd_awayScore_left = 35,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = -10,
  bnd_time_text_left = 30,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0},
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x04F377", 
  bnd_extraTime_width = 0,
  bnd_extraTime_height = 0,
  bnd_extraTime_top = 43,
  bnd_extraTime_left = 160,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 13,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 215,
  bnd_stat_height = 65,
  bnd_stat_top = 10,
  bnd_stat_left = 210,
  bnd_stat_color = "0xdc143c",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_homeStatCrest_left = 5,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 25,
  bnd_homeStatCrest_height = 25,

  bnd_awayStatCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_awayStatCrest_left = 190,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 25,
  bnd_awayStatCrest_height = 25,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -65,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 55,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0x151515",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "CENTER",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = -5,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 8,
  bnd_stat_text = ""
}

local TurkeySuperLigScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpanded",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 97,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 30,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 68 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 3,
  bnd_homeName_fontSize = 11,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 100,
  bnd_awayName_top = 3,
  bnd_awayName_fontSize = 11,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 3,
  bnd_homeScore_left = 37,
  bnd_homeScore_fontSize = 15,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 3,
  bnd_awayScore_left = 60,
  bnd_awayScore_fontSize = 15,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 10,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 2,
  bnd_time_text_left = -75,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,

  bnd_stat_width = 208,
  bnd_stat_height = 40,
  bnd_stat_top = 28,
  bnd_stat_left = 59,
  bnd_stat_color = "0x990000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local BelgiumProLeagueScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansRegular",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 280,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 4 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -98,
  bnd_homeName_top = 7,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 30,
  bnd_awayName_top = 7,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 7,
  bnd_homeScore_left = -57,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x16002C",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 7,
  bnd_awayScore_left = -10,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x16002C",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x16002C",
  bnd_time_text_top = 7,
  bnd_time_text_left = 98,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x16002C", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 7,
  bnd_extraTime_left = 98,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 193,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 21,
  bnd_stat_color = "0x16002C",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local PortugalScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpanded", 
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 130,
  bnd_scoreboard_width = 195,
  bnd_scoreboard_top = 15,
  bnd_scoreboard_left = -30,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 308 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 12,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 9,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 0,
  
  bnd_homeName_text = "",
  bnd_homeName_left = 120,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 120,
  bnd_awayName_top = 35,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "LEFT",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_homeCrest_left = 145,
  bnd_homeCrest_Top = -10,
  bnd_homeCrest_width = 23,
  bnd_homeCrest_height = 23,
  bnd_awayCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_awayCrest_left = 145,
  bnd_awayCrest_top = 18,
  bnd_awayCrest_width = 23,
  bnd_awayCrest_height = 23,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = 35,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 35,
  bnd_awayScore_left = 35,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 13,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 43,
  bnd_time_text_left = 50,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0},
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x04F377", 
  bnd_extraTime_width = 0,
  bnd_extraTime_height = 0,
  bnd_extraTime_top = 43,
  bnd_extraTime_left = 160,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 13,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 220,
  bnd_stat_height = 72,
  bnd_stat_top = 15,
  bnd_stat_left = 210,
  bnd_stat_color = "0x1CDC6B",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_homeStatCrest_left = 5,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 25,
  bnd_homeStatCrest_height = 25,

  bnd_awayStatCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_awayStatCrest_left = 190,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 25,
  bnd_awayStatCrest_height = 25,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0x000000",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -65,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 55,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0x151515",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "CENTER",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0x000000",
  bnd_stat_text_left = -5,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 8,
  bnd_stat_text = ""
}

local MLSScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 140,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 39 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -25,
  bnd_homeName_top = 5,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 90,
  bnd_awayName_top = 5,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 5,
  bnd_homeScore_left = 10,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 5,
  bnd_awayScore_left = 50,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 5,
  bnd_time_text_left = -118,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x000000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = -118,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 210,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 90,
  bnd_stat_color = "0x000000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local ArgentinaScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 140,
  bnd_scoreboard_width = 350,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 353 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -95,
  bnd_homeName_top = 5,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 15,
  bnd_awayName_top = 5,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = -15,
  bnd_homeCrest_Top = 5,
  bnd_homeCrest_width = 20,
  bnd_homeCrest_height = 20,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 220,
  bnd_awayCrest_top = 5,
  bnd_awayCrest_width = 20,
  bnd_awayCrest_height = 20,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 5,
  bnd_homeScore_left = -55,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 5,
  bnd_awayScore_left = -20,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0x010046",
  bnd_time_text_top = 5,
  bnd_time_text_left = 135,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xADB6B7", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = 135,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x010046",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 183,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 21,
  bnd_stat_color = "0x0F1F21",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local MexicoScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansMedium",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 341 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -85,
  bnd_homeName_top = 7,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0x72F06B",
  bnd_awayName_text = "",
  bnd_awayName_left = 43,
  bnd_awayName_top = 7,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0x72F06B",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 7,
  bnd_homeScore_left = -40,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x042430",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 7,
  bnd_awayScore_left = -5,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x042430",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x042430",
  bnd_time_text_top = 7,
  bnd_time_text_left = 120,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x72F06B", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = 120,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x042430",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 198,
  bnd_stat_height = 35,
  bnd_stat_top = 43,
  bnd_stat_left = 30,
  bnd_stat_color = "0x042430",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0x72F06B",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0x72F06B",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local MalaysiaScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 90,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "2237" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_alpha = 0.9,
  bnd_homeName_left = -114,
  bnd_homeName_top = 10,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 52,
  bnd_awayName_top = 10,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",
  bnd_name_text_alpha = 1,
  
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 10,
  bnd_homeCrest_Top = 6,
  bnd_homeCrest_width = 37,
  bnd_homeCrest_height = 37,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 186,
  bnd_awayCrest_top = 6,
  bnd_awayCrest_width = 37, 
  bnd_awayCrest_height = 37,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 8,
  bnd_homeScore_left = -70,
  bnd_homeScore_fontSize = 33,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 8,
  bnd_awayScore_left = -3,
  bnd_awayScore_fontSize = 33,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 32,
  bnd_time_text_left = -37,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 203,
  bnd_stat_height = 50,
  bnd_stat_top = 45,
  bnd_stat_left = 15,
  bnd_stat_color = "0x8B0000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local BrazilScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansRegular",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 100,
  bnd_scoreboard_width = 280,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 7 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -98,
  bnd_homeName_top = 7,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 30,
  bnd_awayName_top = 7,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 7,
  bnd_homeScore_left = -67,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 7,
  bnd_awayScore_left = 0,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 7,
  bnd_time_text_left = 96,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x0A1A36", 
  bnd_extraTime_width = 52,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 7,
  bnd_extraTime_left = 96,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 185,
  bnd_stat_height = 35,
  bnd_stat_top = 38,
  bnd_stat_left = 21,
  bnd_stat_color = "0x16002C",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}
local CWCScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$LaLiga",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 43,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 0,
  bnd_scoreboard_left = 20,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 22100 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 130,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 85,
  bnd_homeCrest_Top = 0,
  bnd_homeCrest_width = 27,
  bnd_homeCrest_height = 27,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 307,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 27,
  bnd_awayCrest_height = 27,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = 25,
  bnd_homeScore_fontSize = 45,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_left = 98,
  bnd_awayScore_fontSize = 45,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 0,
  bnd_time_text_left = 40,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 55,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 25,
  bnd_extraTime_left = 30,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 240,
  bnd_stat_height = 30,
  bnd_stat_top = 23.5,
  bnd_stat_left = 90,
  bnd_stat_color = "0x000000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -100,
  bnd_home_stat_text_top = 5,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 90,
  bnd_away_stat_text_top = 5,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = -5,
  bnd_stat_text_top = 5,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local BRILIGA1Score = {
  bnd_text_bold = true,
  bnd_forceCaps = true,
  bnd_fontFace = "$Liga1",
  bnd_scoreboard_inside_visible = false,
  bnd_scoreboard_outside_visible = true,
  bnd_scoreboard_height = 55,
  bnd_scoreboard_width = 240,
  bnd_scoreboard_top = 9,
  bnd_scoreboard_left = 2,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 2235 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 12,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_cornerRaduis = 5,
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 30,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -58,
  bnd_homeRect_width = 90,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 30,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 60,
  bnd_awayRect_width = 90,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -70,
  bnd_homeName_top = 3,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 70,
  bnd_awayName_top = 3,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",

  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 38,
  bnd_goalAnimation_top = 1,
  bnd_goalAnimation_width = 284,
  bnd_goalAnimation_height = 92,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 0,
  bnd_homeCrest_Top = -200,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 0,
  bnd_awayCrest_top = -200,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = -30,
  bnd_homeScore_fontSize = 40,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_left = 30,
  bnd_awayScore_fontSize = 40,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",

  bnd_time_text = "",
  bnd_time_fontSize = 16,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 26.5,
  bnd_time_text_left = 1,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTime", id = 2235 },
  bnd_extraTime_color_show = false,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 55,
  bnd_extraTime_height = 21,
  bnd_extraTime_top = 26,
  bnd_extraTime_left = 37,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 14,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,

  bnd_stat_width = 200,
  bnd_stat_height = 70,
  bnd_stat_top = 40,
  bnd_stat_left = 0,
  bnd_stat_color = "0xFFFFFF",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 0,
  
  bnd_stat_image = { name = "$Statistik", id = 2235 },
  bnd_stat_image_left = -34,
  bnd_stat_image_top = 35,
  bnd_stat_image_width = 270,
  bnd_stat_image_height = 140,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 23,
  bnd_homeStatCrest_top = -13,
  bnd_homeStatCrest_width = 20,
  bnd_homeStatCrest_height = 20,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 160,
  bnd_awayStatCrest_top = -13,
  bnd_awayStatCrest_width = 20,
  bnd_awayStatCrest_height = 20,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 12,
  bnd_stat_h_a_fontColor = "0x38003D",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -67,
  bnd_home_stat_text_top = 10,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 67,
  bnd_away_stat_text_top = 10,
  
  bnd_stat_bgtext_color = "0x000000",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0x38003D",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 12,
  bnd_stat_text = ""

}
local SaudiArabiaScore = {
  bnd_text_bold = true,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansRegular",
  bnd_scoreboard_inside_visible = false,
  bnd_scoreboard_outside_visible = true,
  bnd_scoreboard_height = 55,
  bnd_scoreboard_width = 240,
  bnd_scoreboard_top = 9,
  bnd_scoreboard_left = 2,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 350 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 12,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_cornerRaduis = 5,
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 30,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -58,
  bnd_homeRect_width = 122,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 30,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 60,
  bnd_awayRect_width = 115,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -70,
  bnd_homeName_top = 3,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 70,
  bnd_awayName_top = 3,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 21,
  bnd_goalAnimation_top = -1,
  bnd_goalAnimation_width = 250,
  bnd_goalAnimation_height = 101,
  bnd_goalAnimation_visible = false,
    
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = 2,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 234,
  bnd_awayCrest_top = 2,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 2,
  bnd_homeScore_left = -32,
  bnd_homeScore_fontSize = 38,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 2,
  bnd_awayScore_left = 34,
  bnd_awayScore_fontSize = 38,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",

  bnd_time_text = "",
  bnd_time_fontSize = 16,
  bnd_time_fontColor = "0xffffff",
  bnd_time_text_top = 26.5,
  bnd_time_text_left = 1,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTime", id = 2235 },
  bnd_extraTime_color_show = false,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 55,
  bnd_extraTime_height = 21,
  bnd_extraTime_top = 26,
  bnd_extraTime_left = 37,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 14,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,

  bnd_stat_width = 200,
  bnd_stat_height = 70,
  bnd_stat_top = 40,
  bnd_stat_left = 0,
  bnd_stat_color = "0xFFFFFF",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 0,
  
  bnd_stat_image = { name = "$Statistik", id = 2235 },
  bnd_stat_image_left = -34,
  bnd_stat_image_top = 35,
  bnd_stat_image_width = 270,
  bnd_stat_image_height = 140,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 23,
  bnd_homeStatCrest_top = -13,
  bnd_homeStatCrest_width = 20,
  bnd_homeStatCrest_height = 20,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 160,
  bnd_awayStatCrest_top = -13,
  bnd_awayStatCrest_width = 20,
  bnd_awayStatCrest_height = 20,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 12,
  bnd_stat_h_a_fontColor = "0x38003D",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -67,
  bnd_home_stat_text_top = 10,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 67,
  bnd_away_stat_text_top = 10,
  
  bnd_stat_bgtext_color = "0x000000",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0x38003D",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 12,
  bnd_stat_text = ""
}

local ChampionshipLiga2Score = {
  bnd_text_bold = true,
  bnd_forceCaps = true,
  bnd_fontFace = "$Liga1",
  bnd_scoreboard_inside_visible = false,
  bnd_scoreboard_outside_visible = true,
  bnd_scoreboard_height = 55,
  bnd_scoreboard_width = 240,
  bnd_scoreboard_top = 9,
  bnd_scoreboard_left = 2,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 2254 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 12,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_cornerRaduis = 0,
  bnd_homeRect_visible = true,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 30,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -53,
  bnd_homeRect_width = 110,
  bnd_awayRect_visible = true,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 30,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 58,
  bnd_awayRect_width = 110,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -70,
  bnd_homeName_top = 3,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 70,
  bnd_awayName_top = 3,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",

  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 0,
  bnd_homeCrest_Top = -200,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 0,
  bnd_awayCrest_top = -200,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = -30,
  bnd_homeScore_fontSize = 40,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_left = 30,
  bnd_awayScore_fontSize = 40,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",

  bnd_time_text = "",
  bnd_time_fontSize = 16,
  bnd_time_fontColor = "0x06554A",
  bnd_time_text_top = 26.5,
  bnd_time_text_left = 0,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTime", id = 2235 },
  bnd_extraTime_color_show = false,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 120,
  bnd_extraTime_height = 21,
  bnd_extraTime_top = 27,
  bnd_extraTime_left = 58,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 14,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,

  bnd_stat_width = 200,
  bnd_stat_height = 70,
  bnd_stat_top = 40,
  bnd_stat_left = 0,
  bnd_stat_color = "0x06554A",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistik", id = 2254 },
  bnd_stat_image_left = -34,
  bnd_stat_image_top = 35,
  bnd_stat_image_width = 270,
  bnd_stat_image_height = 140,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 23,
  bnd_homeStatCrest_top = -13,
  bnd_homeStatCrest_width = 20,
  bnd_homeStatCrest_height = 20,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 160,
  bnd_awayStatCrest_top = -13,
  bnd_awayStatCrest_width = 20,
  bnd_awayStatCrest_height = 20,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x72C042",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x72C042",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 12,
  bnd_stat_h_a_fontColor = "0x72C042",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -67,
  bnd_home_stat_text_top = 10,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 67,
  bnd_away_stat_text_top = 10,
  
  bnd_stat_bgtext_color = "0x000000",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0x72C042",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 12,
  bnd_stat_text = ""
}

local UCLScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$UCL-Regular",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 110,
  bnd_scoreboard_width = 340,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 2236 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0.000001,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 0.000001,
  
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0.000001,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 0.000001,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -15,
  bnd_homeName_top = -1,
  bnd_homeName_fontSize = 23,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 133,
  bnd_awayName_top = -1,
  bnd_awayName_fontSize = 23,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 105,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 210,
  bnd_goalAnimation_height = 30,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 0.1,
  bnd_homeCrest_height = 0.1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 0.1,
  bnd_awayCrest_height = 0.1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -1,
  bnd_homeScore_left = 42,
  bnd_homeScore_fontSize = 23,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -1,
  bnd_awayScore_left = 77,
  bnd_awayScore_fontSize = 23,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 21,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = -1,
  bnd_time_text_left = -80,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x001855", 
  bnd_extraTime_width = 55,
  bnd_extraTime_height = 28,
  bnd_extraTime_top = 28,
  bnd_extraTime_left = -115,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 184.2,
  bnd_stat_height = 25,
  bnd_stat_top = 23.5,
  bnd_stat_left = 0,
  bnd_stat_color = "0x091C94",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 0,
  
  bnd_stat_image = { name = "$Statistik", id = 2236 },
  bnd_stat_image_left = 12,
  bnd_stat_image_top = 33,
  bnd_stat_image_width = 280,
  bnd_stat_image_height = 100,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -10,
  bnd_homeStatName_top = 5,
  bnd_homeStatName_fontSize = 15,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -10,
  bnd_awayStatName_top = 23,
  bnd_awayStatName_fontSize = 15,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = 130,
  bnd_home_stat_text_top = 5,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 130,
  bnd_away_stat_text_top = 23,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 63,
  bnd_stat_text_top = 45,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local ACLTwoScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBoldIta",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 130,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID31" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 115,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -110,
  bnd_homeName2_top = 12, 
  bnd_homeName2_fontSize = 15,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 110,   
  bnd_awayName2_top = 12,
  bnd_awayName2_fontSize = 15,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 12,
  bnd_homeScore_left = -25,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 12,
  bnd_awayScore_left = 20,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = -15,
  bnd_time_text_left = -2,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x060C3D", 
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 25,
  bnd_extraTime_top = -13,
  bnd_extraTime_left = 50,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 329,
  bnd_stat_height = 40,
  bnd_stat_top = 45,
  bnd_stat_left = -15,
  bnd_stat_color = "0x060C3D",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -110,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 110,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local ACLTwoScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBoldIta",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 130,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID31" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 115,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -110,
  bnd_homeName2_top = 12, 
  bnd_homeName2_fontSize = 15,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 110,   
  bnd_awayName2_top = 12,
  bnd_awayName2_fontSize = 15,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 12,
  bnd_homeScore_left = -25,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 12,
  bnd_awayScore_left = 20,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = -15,
  bnd_time_text_left = -2,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x060C3D", 
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 25,
  bnd_extraTime_top = -13,
  bnd_extraTime_left = 50,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 329,
  bnd_stat_height = 40,
  bnd_stat_top = 45,
  bnd_stat_left = -15,
  bnd_stat_color = "0x060C3D",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -110,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 110,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local ACLchllanggehScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBoldIta",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 130,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID21" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 115,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -110,
  bnd_homeName2_top = 12, 
  bnd_homeName2_fontSize = 15,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 110,   
  bnd_awayName2_top = 12,
  bnd_awayName2_fontSize = 15,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 12,
  bnd_homeScore_left = -25,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 12,
  bnd_awayScore_left = 20,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = -17,
  bnd_time_text_left = -2,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x060C3D", 
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 25,
  bnd_extraTime_top = -13,
  bnd_extraTime_left = 50,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 329,
  bnd_stat_height = 40,
  bnd_stat_top = 45,
  bnd_stat_left = -15,
  bnd_stat_color = "0x060C3D",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -110,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 110,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local PialaindoScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBoldIta",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 130,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID29" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 115,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -110,
  bnd_homeName2_top = 12, 
  bnd_homeName2_fontSize = 15,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 110,   
  bnd_awayName2_top = 12,
  bnd_awayName2_fontSize = 15,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 12,
  bnd_homeScore_left = -25,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 12,
  bnd_awayScore_left = 20,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = -17,
  bnd_time_text_left = -2,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x060C3D", 
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 25,
  bnd_extraTime_top = -13,
  bnd_extraTime_left = 50,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 329,
  bnd_stat_height = 40,
  bnd_stat_top = 45,
  bnd_stat_left = -15,
  bnd_stat_color = "0x060C3D",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -110,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 110,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local ACLElitScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBoldIta",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 130,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID24" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 0,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 115,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 0,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -110,
  bnd_homeName2_top = 12, 
  bnd_homeName2_fontSize = 15,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 110,   
  bnd_awayName2_top = 12,
  bnd_awayName2_fontSize = 15,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 12,
  bnd_homeScore_left = -27,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0x23092C",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 12,
  bnd_awayScore_left = 20,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0x23092C",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = -15,
  bnd_time_text_left = 0,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x060C3D", 
  bnd_extraTime_width = 45,
  bnd_extraTime_height = 25,
  bnd_extraTime_top = -13,
  bnd_extraTime_left = 50,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 330,
  bnd_stat_height = 40,
  bnd_stat_top = 45,
  bnd_stat_left = -15,
  bnd_stat_color = "0x23092C",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -110,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 110,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local EASPORTSScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Timer",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID14" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -125,
  bnd_homeName_top = 5,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xDFFF00",
  bnd_awayName_text = "",
  bnd_awayName_left = 0,
  bnd_awayName_top = 5,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xDFFF00",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 4,
  bnd_homeScore_left = -77,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x080838",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 4,
  bnd_awayScore_left = -49,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x080838",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x080838",
  bnd_time_text_top = 5,
  bnd_time_text_left = 68,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xE0218A", 
  bnd_extraTime_width = 65,
  bnd_extraTime_height = 28,
  bnd_extraTime_top = 34,
  bnd_extraTime_left = 70,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 18,
  bnd_extraTime_fontColor = "0x080838",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 200,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = -11,
  bnd_stat_color = "0xDFFF00",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0x080838",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0x080838",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0x080838",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local WC26Score = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansMedium",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 350,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID2" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -32,
  bnd_homeName_top = 6,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 97,
  bnd_awayName_top = 6,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 35,
  bnd_goalAnimation_top = 5,
  bnd_goalAnimation_width = 305,
  bnd_goalAnimation_height = 54,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$CrestNational", id = 0 },
  bnd_homeCrest_left = 58,
  bnd_homeCrest_Top = 5,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 20,
  bnd_awayCrest = { name = "$CrestNational", id = 0 },
  bnd_awayCrest_left = 282,
  bnd_awayCrest_top = 5,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 20,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 8,
  bnd_homeScore_left = 6,
  bnd_homeScore_fontSize = 25,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 8,
  bnd_awayScore_left = 60,
  bnd_awayScore_fontSize = 25,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 7,
  bnd_time_text_left = -135,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTime", id = 365 },
  bnd_extraTime_color_show = false,
  bnd_extraTime_width = 65,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 32,
  bnd_extraTime_left = -134,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 208,
  bnd_stat_height = 0,
  bnd_stat_top = 35,
  bnd_stat_left = 7,
  bnd_stat_color = "0x000000",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistik", id = "CupID2" },
  bnd_stat_image_left = -34,
  bnd_stat_image_top = 23,
  bnd_stat_image_width = 339,
  bnd_stat_image_height = 100,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$CrestWorldCup2026", id = 0 },
  bnd_homeStatCrest_left = 45,
  bnd_homeStatCrest_top = 460,
  bnd_homeStatCrest_width = 000.1,
  bnd_homeStatCrest_height = 000.1,

  bnd_awayStatCrest = { name = "$CrestWorldCup2026", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 460,
  bnd_awayStatCrest_width = 000.1,
  bnd_awayStatCrest_height = 000.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = 0,
  bnd_homeStatName_top = 462,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = 77,
  bnd_awayStatName_top = 462,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -45,
  bnd_home_stat_text_top = 10,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 95,
  bnd_away_stat_text_top = 10,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 15,
  bnd_stat_fontColor = "0x06E7E0",
  bnd_stat_text_left = 25,
  bnd_stat_text_top = 42,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local AsianCupScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Qatar2022Arabic",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 50,
  bnd_scoreboard_width = 320,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID34" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 10,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 10,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -30,
  bnd_homeName_top = 15,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0x00FF00",
  bnd_awayName_text = "",
  bnd_awayName_left = 115,
  bnd_awayName_top = 15,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0x00FF00",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -110,
  bnd_homeName2_top = 12, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 110,   
  bnd_awayName2_top = 12,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 15,
  bnd_homeScore_left = 25,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 15,
  bnd_awayScore_left = 65,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 20,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 15,
  bnd_time_text_left = -115,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x1C004E", 
  bnd_extraTime_width = 90,
  bnd_extraTime_height = 40,
  bnd_extraTime_top = 50,
  bnd_extraTime_left = -115,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xE3F000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 230,
  bnd_stat_height = 40,
  bnd_stat_top = 50,
  bnd_stat_left = 43,
  bnd_stat_color = "0x1C004E",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -50,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -50,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xE3F000",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -90,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 90,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xE3F000",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local AfrikaCupScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 105,
  bnd_scoreboard_width = 280,
  bnd_scoreboard_top = 18,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID26" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_cornerRaduis = 8,
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -79,
  bnd_homeName_top = 15,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 79,
  bnd_awayName_top = 15,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 10,
  bnd_homeCrest_Top = 15,
  bnd_homeCrest_width = 30,
  bnd_homeCrest_height = 30,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 270,
  bnd_awayCrest_top = 15,
  bnd_awayCrest_width = 30,
  bnd_awayCrest_height = 30,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 15,
  bnd_homeScore_left = -26,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x860000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 15,
  bnd_awayScore_left = 22,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x860000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 13,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 37,
  bnd_time_text_left = -1,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x04F377", 
  bnd_extraTime_width = 25,
  bnd_extraTime_height = 17,
  bnd_extraTime_top = 37,
  bnd_extraTime_left = 35,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 240,
  bnd_stat_height = 65,
  bnd_stat_top = 48,
  bnd_stat_left = 0,
  bnd_stat_color = "0xFFFFFF",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0x860000",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -90,
  bnd_home_stat_text_top = 15,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 90,
  bnd_away_stat_text_top = 15,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0x860000",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 15,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local UELScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 140,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID3" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -25,
  bnd_homeName_top = 5,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 118,
  bnd_awayName_top = 5,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 5,
  bnd_homeScore_left = 30,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 5,
  bnd_awayScore_left = 63,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 5,
  bnd_time_text_left = -85,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x000000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = -85,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 205,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 97,
  bnd_stat_color = "0x212121",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}
local UecScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 95,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID17" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -28,
  bnd_homeName_top = 18,
  bnd_homeName_fontSize = 18,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 118,
  bnd_awayName_top = 18,
  bnd_awayName_fontSize = 18,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 18,
  bnd_homeScore_left = 27,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 18,
  bnd_awayScore_left = 63,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 17,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 18,
  bnd_time_text_left = -90,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x000000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = -85,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xffffff",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 205,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 97,
  bnd_stat_color = "0x212121",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local EuroScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$FONT_CRUYFFSANSBOLD",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID6" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -3,
  bnd_homeName_top = 7,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 130,
  bnd_awayName_top = 7,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 7,
  bnd_homeScore_left = 45,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x242323",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 7,
  bnd_awayScore_left = 85,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x242323",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 7,
  bnd_time_text_left = -80,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x023CDE", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = -80,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 198,
  bnd_stat_height = 35,
  bnd_stat_top = 33,
  bnd_stat_left = 115,
  bnd_stat_color = "0x023CDE",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local CopaAmericaScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$UEFANations-Bold",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 280,
  bnd_scoreboard_top = 15,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID25" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_cornerRaduis = 8,
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -95,
  bnd_homeName_top = -3,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 95,
  bnd_awayName_top = -3,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -3,
  bnd_homeScore_left = -45,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x00B2C70",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -3,
  bnd_awayScore_left = 43,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x00B2C70",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x00B2C70",
  bnd_time_text_top = 32,
  bnd_time_text_left = 0,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 32,
  bnd_extraTime_left = 0,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x00B2C70",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 240,
  bnd_stat_height = 95,
  bnd_stat_top = 35,
  bnd_stat_left = 0,
  bnd_stat_color = "0x00B2C70",
  bnd_stats_alignH = "CENTER",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 15,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -90,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 90,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 30,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local AseanChampionshipScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 90,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID27" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -124,
  bnd_homeName_top = 8,
  bnd_homeName_fontSize = 20,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 52,
  bnd_awayName_top = 8,
  bnd_awayName_fontSize = 20,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 8,
  bnd_homeScore_left = -70,
  bnd_homeScore_fontSize = 33,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 8,
  bnd_awayScore_left = -3,
  bnd_awayScore_fontSize = 33,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 32,
  bnd_time_text_left = -108,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 203,
  bnd_stat_height = 50,
  bnd_stat_top = 45,
  bnd_stat_left = 15,
  bnd_stat_color = "0x8B0000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local ShoopeScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 90,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID12" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -100,
  bnd_homeName_top = 8,
  bnd_homeName_fontSize = 30,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 85,
  bnd_awayName_top = 8,
  bnd_awayName_fontSize = 30,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 8,
  bnd_homeScore_left = -45,
  bnd_homeScore_fontSize = 33,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 8,
  bnd_awayScore_left = 40,
  bnd_awayScore_fontSize = 33,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0xFF7F00",
  bnd_time_text_top = 32,
  bnd_time_text_left = -5,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 203,
  bnd_stat_height = 50,
  bnd_stat_top = 45,
  bnd_stat_left = 45,
  bnd_stat_color = "0xFF7F00",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,
  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local SeagamesScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpanded",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 285,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 100,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID23" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -75,
  bnd_homeName_top = -2,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 75,
  bnd_awayName_top = -2,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,

  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 27,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 23,
  bnd_homeCrest_height = 23,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 251,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 23,
  bnd_awayCrest_height = 23,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -3,
  bnd_homeScore_left = -27,
  bnd_homeScore_fontSize = 25,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -3,
  bnd_awayScore_left = 28,
  bnd_awayScore_fontSize = 25,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 13,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = -25,
  bnd_time_text_left = 0,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 203,
  bnd_stat_height = 50,
  bnd_stat_top = 45,
  bnd_stat_left = 45,
  bnd_stat_color = "0xFF7F00",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,
  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local DfblokalScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 100,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 25,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID7" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -2,
  bnd_homeName_top = 18,
  bnd_homeName_fontSize = 16,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 105,
  bnd_awayName_top = 18,
  bnd_awayName_fontSize = 16,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 18,
  bnd_homeScore_left = 45,
  bnd_homeScore_fontSize = 15,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 18,
  bnd_awayScore_left = 63,
  bnd_awayScore_fontSize = 15,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 17,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 18,
  bnd_time_text_left = -90,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,

  bnd_stat_width = 208,
  bnd_stat_height = 40,
  bnd_stat_top = 470,
  bnd_stat_left = 40,
  bnd_stat_color = "0x66FF66",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local NationsScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpanded",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 200,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 45,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID28" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -2,
  bnd_homeName_top = 10,
  bnd_homeName_fontSize = 16,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 105,
  bnd_awayName_top = 10,
  bnd_awayName_fontSize = 16,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 10,
  bnd_homeScore_left = 40,
  bnd_homeScore_fontSize = 15,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 10,
  bnd_awayScore_left = 63,
  bnd_awayScore_fontSize = 15,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 17,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 10,
  bnd_time_text_left = -90,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,

  bnd_stat_width = 208,
  bnd_stat_height = 40,
  bnd_stat_top = 470,
  bnd_stat_left = 40,
  bnd_stat_color = "0x66FF66",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local FacupScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 90,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 25,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID9" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -120,
  bnd_homeName_top = 43,
  bnd_homeName_fontSize = 25,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 120,
  bnd_awayName_top = 43,
  bnd_awayName_fontSize = 25,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 43,
  bnd_homeScore_left = -66,
  bnd_homeScore_fontSize = 20,
  bnd_homeScore_fontColor = "0xffffff",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 43,
  bnd_awayScore_left = 63,
  bnd_awayScore_fontSize = 20,
  bnd_awayScore_fontColor = "0xffffff",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 23,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 57,
  bnd_time_text_left = -0,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,

  bnd_stat_width = 208,
  bnd_stat_height = 40,
  bnd_stat_top = 470,
  bnd_stat_left = 40,
  bnd_stat_color = "0x66FF66",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local CopadelreyScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 70,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 25,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID10" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -110,
  bnd_homeName_top = 5,
  bnd_homeName_fontSize = 16,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 50,
  bnd_awayName_top = 5,
  bnd_awayName_fontSize = 16,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = -3,
  bnd_goalAnimation_top = 6,
  bnd_goalAnimation_width = 250,
  bnd_goalAnimation_height = 29,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$CrestAnim_Laliga", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$CrestAnim_Laliga", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 8,
  bnd_homeScore_left = -60,
  bnd_homeScore_fontSize = 15,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 8,
  bnd_awayScore_left = -10,
  bnd_awayScore_fontSize = 15,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 17,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 5,
  bnd_time_text_left = 120,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,

  bnd_stat_width = 208,
  bnd_stat_height = 40,
  bnd_stat_top = 470,
  bnd_stat_left = 40,
  bnd_stat_color = "0x990000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
  local CopaFranceScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 155,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 25,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID18" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -110,
  bnd_homeName_top = -3,
  bnd_homeName_fontSize = 16,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 50,
  bnd_awayName_top = -3,
  bnd_awayName_fontSize = 16,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -6,
  bnd_homeScore_left = -40,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = -6,
  bnd_awayScore_left = -14,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 17,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = -3,
  bnd_time_text_left = 125,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,

  bnd_stat_width = 208,
  bnd_stat_height = 40,
  bnd_stat_top = 470,
  bnd_stat_left = 40,
  bnd_stat_color = "0x0066FF",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}
local CoppaitaliaScore = {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 97,
  bnd_scoreboard_width = 310,
  bnd_scoreboard_top = 30,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID11" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -10,
  bnd_homeName_top = 3,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 100,
  bnd_awayName_top = 3,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 2,
  bnd_homeScore_left = 37,
  bnd_homeScore_fontSize = 15,
  bnd_homeScore_fontColor = "0x990000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 2,
  bnd_awayScore_left = 60,
  bnd_awayScore_fontSize = 15,
  bnd_awayScore_fontColor = "0x990000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 17,
  bnd_time_fontColor = "0x990000",
  bnd_time_text_top = 2,
  bnd_time_text_left = -75,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x800000", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 15,
  bnd_extraTime_top = 31,
  bnd_extraTime_left = -108,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,

  bnd_stat_width = 208,
  bnd_stat_height = 40,
  bnd_stat_top = 28,
  bnd_stat_left = 59,
  bnd_stat_color = "0x990000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 10,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 10,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 17,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0xFFFFFF",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 17,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0xFFFFFF",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 20,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 9,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 9,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 10,
  bnd_stat_text_fontSize = 15,
  bnd_stat_text = ""
}

local LibertadoresScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansMedium",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID4" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -87,
  bnd_homeName_top = 7,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 53,
  bnd_awayName_top = 7,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 7,
  bnd_homeScore_left = -32,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 7,
  bnd_awayScore_left = -5,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 7,
  bnd_time_text_left = 120,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xD7BA66", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = 120,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 208,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 30,
  bnd_stat_color = "0x000000",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}
local CoupedeFranceScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 100,
  bnd_scoreboard_width = 300,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID18" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -52,
  bnd_homeName_top = 0,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 114,
  bnd_awayName_top = 0,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 0,
  bnd_homeScore_left = -4,
  bnd_homeScore_fontSize = 17,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 0,
  bnd_awayScore_left = 66,
  bnd_awayScore_fontSize = 17,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 15,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 0,
  bnd_time_text_left = 17,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xffffff", 
  bnd_extraTime_width = 40,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 0,
  bnd_extraTime_left = 17,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 17,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 225,
  bnd_stat_height = 25,
  bnd_stat_top = 23.5,
  bnd_stat_left = 68,
  bnd_stat_color = "0x091C94",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 0.8,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xffffff",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -80,
  bnd_home_stat_text_top = 3,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 83,
  bnd_away_stat_text_top = 3,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 2,
  bnd_stat_text_top = 3,
  bnd_stat_text_fontSize = 10,
  bnd_stat_text = ""
}

local UWCLScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpanded", 
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 130,
  bnd_scoreboard_width = 195,
  bnd_scoreboard_top = 15,
  bnd_scoreboard_left = -30,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = 0 },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 12,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 9,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 0,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 0,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 0,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 0,
  
  bnd_homeName_text = "",
  bnd_homeName_left = 85,
  bnd_homeName_top = -10,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0x000000",
  bnd_awayName_text = "",
  bnd_awayName_left = 85,
  bnd_awayName_top = 20,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0x000000",
  bnd_name_text_alignH = "LEFT",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_homeCrest_left = 145,
  bnd_homeCrest_Top = -10,
  bnd_homeCrest_width = 23,
  bnd_homeCrest_height = 23,
  bnd_awayCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest_left = 145,
  bnd_awayCrest_top = 18,
  bnd_awayCrest_width = 23,
  bnd_awayCrest_height = 23,

  bnd_homeScore_text = "",
  bnd_homeScore_top = -10,
  bnd_homeScore_left = 40,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0x000000",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 20,
  bnd_awayScore_left = 40,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0x000000",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 13,
  bnd_time_fontColor = "0xFFFFFF",
  bnd_time_text_top = 43,
  bnd_time_text_left = 85,
  bnd_time_text_alignH = "LEFT",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0},
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0x04F377", 
  bnd_extraTime_width = 0,
  bnd_extraTime_height = 0,
  bnd_extraTime_top = 43,
  bnd_extraTime_left = 160,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 13,
  bnd_extraTime_fontColor = "0xFFFFFF",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 220,
  bnd_stat_height = 72,
  bnd_stat_top = 15,
  bnd_stat_left = 210,
  bnd_stat_color = "0x1CDC6B",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 5,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 25,
  bnd_homeStatCrest_height = 25,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 190,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 25,
  bnd_awayStatCrest_height = 25,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0x000000",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -65,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 55,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0x151515",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "CENTER",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 0,
  bnd_stat_fontColor = "0x000000",
  bnd_stat_text_left = -5,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 8,
  bnd_stat_text = ""
  }

local SudamericanaScore= {
  bnd_text_bold = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansMedium",
  bnd_scoreboard_inside_visible = true,
  bnd_scoreboard_outside_visible = false,
  bnd_scoreboard_height = 120,
  bnd_scoreboard_width = 330,
  bnd_scoreboard_top = 5,
  bnd_scoreboard_left = 0,
  bnd_scoreboard_image = { name = "$ScoreBoard", id = "CupID8" },
  
  bnd_matchinfo_text = "",
  bnd_matchinfo_fontSize = 0,
  bnd_matchinfo_fontColor = "0xFFFFFF",
  bnd_matchinfo_top = 8,
  bnd_matchinfo_left = 11,
  
  bnd_homeRect_visible = false,
  bnd_homeRect_color = "",
  bnd_homeRect_height = 27.5,
  bnd_homeRect_top = 2,
  bnd_homeRect_left = -65,
  bnd_homeRect_width = 130,
  bnd_awayRect_visible = false,
  bnd_awayRect_color = "",
  bnd_awayRect_height = 27.5,
  bnd_awayRect_top = 2,
  bnd_awayRect_left = 65,
  bnd_awayRect_width = 130,
  
  bnd_homeName_text = "",
  bnd_homeName_left = -87,
  bnd_homeName_top = 7,
  bnd_homeName_fontSize = 15,
  bnd_homeName_fontColor = "0xFFFFFF",
  bnd_awayName_text = "",
  bnd_awayName_left = 53,
  bnd_awayName_top = 7,
  bnd_awayName_fontSize = 15,
  bnd_awayName_fontColor = "0xFFFFFF",
  bnd_name_text_alignH = "CENTER",
  
  
  bnd_homeName2_text = "",
  bnd_homeName2_left = -10,
  bnd_homeName2_top = 10, 
  bnd_homeName2_fontSize = 0,
  bnd_homeName2_fontColor = "0xFFFFFF",
  bnd_homeName2_alignH = "CENTER",

  bnd_awayName2_text = "",
  bnd_awayName2_left = 90,   
  bnd_awayName2_top = 10,
  bnd_awayName2_fontSize = 0,
  bnd_awayName2_fontColor = "0xFFFFFF",
  bnd_awayName2_alignH = "CENTER",
  
  bnd_goalAnimation = { name = "$GoalAnimation", id = 0 },
  bnd_goalAnimation_left = 0,
  bnd_goalAnimation_top = 0,
  bnd_goalAnimation_width = 0.1,
  bnd_goalAnimation_height = 0.1,
  bnd_goalAnimation_visible = false,
  
  bnd_homeCrest = { name = "$Crest", id = 0 },
  bnd_homeCrest_left = 32,
  bnd_homeCrest_Top = -2,
  bnd_homeCrest_width = 1,
  bnd_homeCrest_height = 1,
  bnd_awayCrest = { name = "$Crest", id = 0 },
  bnd_awayCrest_left = 157,
  bnd_awayCrest_top = -2,
  bnd_awayCrest_width = 1,
  bnd_awayCrest_height = 1,

  bnd_homeScore_text = "",
  bnd_homeScore_top = 7,
  bnd_homeScore_left = -32,
  bnd_homeScore_fontSize = 18,
  bnd_homeScore_fontColor = "0xFFFFFF",
  bnd_awayScore_text = "",
  bnd_awayScore_top = 7,
  bnd_awayScore_left = -5,
  bnd_awayScore_fontSize = 18,
  bnd_awayScore_fontColor = "0xFFFFFF",
  bnd_score_text_alignH = "CENTER",
  
  bnd_time_text = "",
  bnd_time_fontSize = 18,
  bnd_time_fontColor = "0x000000",
  bnd_time_text_top = 7,
  bnd_time_text_left = 120,
  bnd_time_text_alignH = "CENTER",
  
  bnd_extratime_image = { name = "$ExtraTimeX", id = 0 },
  bnd_extraTime_color_show = true,
  bnd_extraTime_color = "0xD7BA66", 
  bnd_extraTime_width = 50,
  bnd_extraTime_height = 20,
  bnd_extraTime_top = 5,
  bnd_extraTime_left = 120,
  bnd_extraTime_text = "",
  bnd_extraTime_fontSize = 15,
  bnd_extraTime_fontColor = "0x000000",
  bnd_extraTime_visible = false,
  
  bnd_stat_width = 208,
  bnd_stat_height = 35,
  bnd_stat_top = 35,
  bnd_stat_left = 30,
  bnd_stat_color = "0x010D3D",
  bnd_stats_alignH = "LEFT",
  bnd_stat_visible = false,
  bnd_stat_color_alpha = 1,
  
  bnd_stat_image = { name = "$Statistikx", id = 13 },
  bnd_stat_image_left = 18,
  bnd_stat_image_top = 30,
  bnd_stat_image_width = 150,
  bnd_stat_image_height = 150,
  bnd_stat_image_visible = true,
  
  bnd_homeStatCrest = { name = "$Crest", id = 0 },
  bnd_homeStatCrest_left = 15,
  bnd_homeStatCrest_top = 0,
  bnd_homeStatCrest_width = 0.1,
  bnd_homeStatCrest_height = 0.1,

  bnd_awayStatCrest = { name = "$Crest", id = 0 },
  bnd_awayStatCrest_left = 215,
  bnd_awayStatCrest_top = 0,
  bnd_awayStatCrest_width = 0.1,
  bnd_awayStatCrest_height = 0.1,
  
  
  bnd_homeStatName_text = "",
  bnd_homeStatName_left = -58,
  bnd_homeStatName_top = 10,
  bnd_homeStatName_fontSize = 0,
  bnd_homeStatName_fontColor = "0x38003D",

  bnd_awayStatName_text = "",
  bnd_awayStatName_left = -58,
  bnd_awayStatName_top = 35,
  bnd_awayStatName_fontSize = 0,
  bnd_awayStatName_fontColor = "0x38003D",

  bnd_stat_name_text_alignH = "CENTER",
  
  bnd_stat_fontSize = 10,
  bnd_stat_h_a_fontColor = "0xFFFFFF",
  bnd_home_stat_text = "",
  bnd_home_stat_text_left = -70,
  bnd_home_stat_text_top = 0,
  bnd_away_stat_text = "",
  bnd_away_stat_text_left = 70,
  bnd_away_stat_text_top = 0,
  
  bnd_stat_bgtext_color = "0xFFFFFF",
  bnd_stat_bgtext_color_alignV = "CENTER",
  bnd_stat_bgtext_color_alignH = "LEFT",
  bnd_stat_bgtext_color_width = 0,
  bnd_stat_bgtext_color_height = 20,
  bnd_stat_fontColor = "0xFFFFFF",
  bnd_stat_text_left = 0,
  bnd_stat_text_top = 0,
  bnd_stat_text_fontSize = 10,
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
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
  o:handleEvent(...) end)
  
  o.visible = false
  o.statVisible = false
  o.homeStat = "0%"
  o.awayStat = "0%"
  o.facts = nil
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
    },
    Chemistry = {
      label = "CHMSTRY",
      value = 4
    }
  }
  
  liveLogo = {
    name = "$LiveLogo",
    id = 0
  }
  
  local HOMETEAM = 0
  local AWAYTEAM = 1
  local currentScoreBoard
  
  self.homeScore = o.services.OverlayService.GetCurrentScore(HOMETEAM)
  self.awayScore = o.services.OverlayService.GetCurrentScore(AWAYTEAM)
  
  local BelgiumProLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.BelgiumProLeague, 0, 0, true)
  local TurkeySuperLigTeams = o.services.TeamService.GetTeams(leagueIDs.TurkeySuperLig, 0, 0, true)
  local BrazilTeams = o.services.TeamService.GetTeams(leagueIDs.Brazil, 0, 0, true)
  local EredivisieTeams = o.services.TeamService.GetTeams(leagueIDs.Eredivisie, 0, 0, true)
  local internasionalTeams = o.services.TeamService.GetTeams(leagueIDs.internasional, 0, 0, true)
  local PremierLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.PremierLeague, 0, 0, true)
  local ChampionshipEflTeams = o.services.TeamService.GetTeams(leagueIDs.ChampionshipEfl, 0, 0, true)
  local LeagueOneEflTeams = o.services.TeamService.GetTeams(leagueIDs.LeagueOneEfl, 0, 0, true)
  local Ligue1Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue1, 0, 0, true)
  local Bundesliga1Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga1, 0, 0, true)
  local SerieATeams = o.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local SerieBTeams = o.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local MLSTeams = o.services.TeamService.GetTeams(leagueIDs.MLS, 0, 0, true)
  local LaligaTeams = o.services.TeamService.GetTeams(leagueIDs.Laliga, 0, 0, true)
  local PortugalTeams = o.services.TeamService.GetTeams(leagueIDs.Portugal, 0, 0, true)
  local MexicoTeams = o.services.TeamService.GetTeams(leagueIDs.Mexico, 0, 0, true)
  local MalaysiaTeams = o.services.TeamService.GetTeams(leagueIDs.Malaysia, 0, 0, true)
  local ArgentinaTeams = o.services.TeamService.GetTeams(leagueIDs.Argentina, 0, 0, true)
  local BRILiga1Teams = o.services.TeamService.GetTeams(leagueIDs.BRILiga1, 0, 0, true)
  local SaudiArabiaTeams = o.services.TeamService.GetTeams(leagueIDs.SaudiArabia, 0, 0, true)
  local ChampionshipLiga2 = o.services.TeamService.GetTeams(leagueIDs.ChampionshipLiga2, 0, 0, true)
  local UCLTeams = o.services.TeamService.GetTeams(leagueIDs.UCL, 0, 0, true)
  

  local matchType = "friendly"

if currentCupData and currentCupData.cupIndex > 0 then
    matchType = "cup"
    if currentCupData.cupIndex == 1 then
      currentScoreBoard = UCLScore
      liveLogo.id = 2239
    elseif currentCupData.cupIndex == 15 then
      currentScoreBoard = CWCScore
      liveLogo.id = 122
    elseif currentCupData.cupIndex >= 2 and currentCupData.cupIndex <= 34 then
      currentScoreBoard = EAFCScore
      liveLogo.id = currentCupData.cupIndex
    end

  elseif currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
    matchType = "tournament"
    if currentTourData.tourIndex == 1 then
      currentScoreBoard = UCLScore
      liveLogo.id = 2239
    elseif currentTourData.tourIndex == 2 then
      currentScoreBoard = WC26Score
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, WC26TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, WC26TeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
      currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
      liveLogo.id = 365
    elseif currentTourData.tourIndex == 3 then
      currentScoreBoard = UELScore
      liveLogo.id = 55
    elseif currentTourData.tourIndex == 17 then
      currentScoreBoard = UecScore
      liveLogo.id = 211
          elseif currentTourData.tourIndex == 26 then
      currentScoreBoard = AfrikaCupScore
      liveLogo.id = 44
    elseif currentTourData.tourIndex == 4 then
      currentScoreBoard = LibertadoresScore
      liveLogo.id = 0
    elseif currentTourData.tourIndex == 6 then
      currentScoreBoard = EuroScore
      liveLogo.id = 1
    elseif currentTourData.tourIndex == 8 then
      currentScoreBoard = SudamericanaScore
      liveLogo.id = 4
    
      elseif currentTourData.tourIndex == 14 then
      currentScoreBoard = EASPORTSScore
      liveLogo.id = 0
      
    elseif currentTourData.tourIndex == 15 then
      currentScoreBoard = CWCScore
      liveLogo.id = 122
        
    elseif currentTourData.tourIndex == 25 then
      currentScoreBoard = CopaAmericaScore
      liveLogo.id = 0
      
    elseif currentTourData.tourIndex == 24 then
      currentScoreBoard = ACLElitScore
      liveLogo.id = 605
    elseif currentTourData.tourIndex == 31 then
      currentScoreBoard = ACLTwoScore
      liveLogo.id = 605
   elseif currentTourData.tourIndex == 21 then
      currentScoreBoard = ACLchllanggehScore
      liveLogo.id = 605
   elseif currentTourData.tourIndex == 29 then
      currentScoreBoard = PialaindoScore
      liveLogo.id = 0
           elseif currentTourData.tourIndex == 27 then
      currentScoreBoard = AseanChampionshipScore
           elseif currentTourData.tourIndex == 12 then
      currentScoreBoard = ShoopeScore
           elseif currentTourData.tourIndex == 23 then
      currentScoreBoard = SeagamesScore
           elseif currentTourData.tourIndex == 7 then
      currentScoreBoard = DfblokalScore
           elseif currentTourData.tourIndex == 28 then
      currentScoreBoard = NationsScore
           elseif currentTourData.tourIndex == 9 then
      currentScoreBoard = FacupScore
           elseif currentTourData.tourIndex == 10 then
      currentScoreBoard = CopadelreyScore
           elseif currentTourData.tourIndex == 18 then
      currentScoreBoard = CopaFranceScore
           elseif currentTourData.tourIndex == 11 then
      currentScoreBoard = CoppaitaliaScore
    elseif currentTourData.tourIndex == 34 then
      currentScoreBoard = AsianCupScore
      liveLogo.id = 5
    elseif currentTourData.tourIndex >= 2 and currentTourData.tourIndex <= 34 then
      currentScoreBoard = EAFCScore
      liveLogo.id = currentTourData.tourIndex
    end

  else
    matchType = "league"
    if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
      currentScoreBoard = PREMIERLEAGUEScore
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, PremierLeagueTeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, PremierLeagueTeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
      currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
      liveLogo.id = 90
      elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    currentScoreBoard = ChampionshipEflScore 
    liveLogo.id = 16
     elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    currentScoreBoard = LeagueOneEflScore
    liveLogo.id = 2
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      currentScoreBoard = LIGUE1Score
      o.statType.possession.label = "POSSESSION"
      o.statType.Chemistry.label = "CHEMISTRY"
      liveLogo.id = 77
    elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
      currentScoreBoard = BUNDESLIGA1Score
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Bundesliga1TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Bundesliga1TeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
      currentScoreBoard.bnd_homeScore_fontColor = homeColorList[2]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
      currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
      currentScoreBoard.bnd_awayScore_fontColor = awayColorList[2]
      liveLogo.id = 100
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
      currentScoreBoard = SERIEAScore
      liveLogo.id = 99
   elseif o:isInTable(o.TeamsData[1], SerieBTeams) and o:isInTable(o.TeamsData[2], SerieBTeams) then
      currentScoreBoard = SERIEBScore
      liveLogo.id = 2
    elseif o:isInTable(o.TeamsData[1], EredivisieTeams) and o:isInTable(o.TeamsData[2], EredivisieTeams) then
      currentScoreBoard = EredivisieScore
      liveLogo.id = 400
    elseif o:isInTable(o.TeamsData[1], TurkeySuperLigTeams) and o:isInTable(o.TeamsData[2], TurkeySuperLigTeams) then
      currentScoreBoard = TurkeySuperLigScore
      liveLogo.id = 401
    elseif o:isInTable(o.TeamsData[1], BelgiumProLeagueTeams) and o:isInTable(o.TeamsData[2], BelgiumProLeagueTeams) then
      currentScoreBoard = BelgiumProLeagueScore
      liveLogo.id = 402
    elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
      currentScoreBoard = PortugalScore
      liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], MLSTeams) and o:isInTable(o.TeamsData[2], MLSTeams) then
      currentScoreBoard = MLSScore
      liveLogo.id = 224
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
      currentScoreBoard = BrazilScore
      liveLogo.id = 403
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
      currentScoreBoard = ArgentinaScore
      liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
      currentScoreBoard = MexicoScore
      liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
      currentScoreBoard = MalaysiaScore    
      liveLogo.id = 0
    elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
      currentScoreBoard = BRILIGA1Score
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, BRILiga1TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, BRILiga1TeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
      currentScoreBoard.bnd_homeScore_fontColor = homeColorList[2]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
      currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
      currentScoreBoard.bnd_awayScore_fontColor = awayColorList[2]
      liveLogo.id = 19

     elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    currentScoreBoard = SaudiArabiaScore
    local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, SaudiArabiaTeamsData)
    local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, SaudiArabiaTeamsData)
    currentScoreBoard.bnd_homeRect_color = homeColorList[1]
    currentScoreBoard.bnd_awayRect_color = awayColorList[1]
    liveLogo.id = 350
          
    elseif o:isInTable(o.TeamsData[1], ChampionshipLiga2Teams) and o:isInTable(o.TeamsData[2], ChampionshipLiga2Teams) then
      currentScoreBoard = ChampionshipLiga2Score
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, ChampionshipLiga2TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, ChampionshipLiga2TeamsData)
      currentScoreBoard.bnd_homeRect_color = homeColorList[1]
      currentScoreBoard.bnd_homeName_fontColor = homeColorList[2]
      currentScoreBoard.bnd_homeScore_fontColor = homeColorList[2]
      currentScoreBoard.bnd_awayRect_color = awayColorList[1]
      currentScoreBoard.bnd_awayName_fontColor = awayColorList[2]
      currentScoreBoard.bnd_awayScore_fontColor = awayColorList[2]
      liveLogo.id = 2
    elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
      currentScoreBoard = LALIGAScore
      o.statType.possession.label = "POSSESSION"
      o.statType.Chemistry.label = "CHEMISTRY"
      liveLogo.id = 98
      elseif o:isInTable(o.TeamsData[1], LaligaHypermotionTeams) and o:isInTable(o.TeamsData[2], LaligaHypermotionTeams) then
      currentScoreBoard = LaligaHypermotionScore
      o.statType.possession.label = "POSSESSION"
      o.statType.Chemistry.label = "CHEMISTRY"
      liveLogo.id = 555
      
          
    elseif o:isInTable(o.TeamsData[1], UCLTeams) and o:isInTable(o.TeamsData[2], UCLTeams) then
      currentScoreBoard = UCLScore
      liveLogo.id = 2239
    else
      currentScoreBoard = EAFCScore
      o.statType.possession.label = "POS"
      liveLogo.id = 0
    end
    
    currentScoreBoard.bnd_tournamentName_visible = false
    currentScoreBoard.bnd_tournamentRound_visible = false
  end

    currentScoreBoard.bnd_homeCrest.id = o.TeamsData[1].assetId
    currentScoreBoard.bnd_awayCrest.id = o.TeamsData[2].assetId
    currentScoreBoard.bnd_goalAnimation = { name = "", id = 0 }
    currentScoreBoard.bnd_goalAnimation_visible = false
    currentScoreBoard.bnd_homeName_text = o.services.GameSetupService.GetTeamShortName(HOMETEAM)
    currentScoreBoard.bnd_awayName_text = o.services.GameSetupService.GetTeamShortName(AWAYTEAM)

   o.currentLeagueType = "default"

if currentScoreBoard == PREMIERLEAGUEScore then
    o.currentLeagueType = "epl"
elseif currentScoreBoard == LALIGAScore then
    o.currentLeagueType = "laliga"
    elseif currentScoreBoard == LALIGAHYPERMOTIONScore then
    o.currentLeagueType = "LaligaHypermotion"
elseif currentScoreBoard == UCLScore then
    o.currentLeagueType = "ucl"
    elseif currentScoreBoard == BRILIGA1Score then
    o.currentLeagueType = "briliga1"
    elseif currentScoreBoard == fwc26Score then
    o.currentLeagueType = "pildun"
    elseif currentScoreBoard == ClubWorldCupScore then
    o.currentLeagueType = "cwc"
    elseif currentScoreBoard == BUNDESLIGA1Score then
    o.currentLeagueType = "bundesliga"
    elseif currentScoreBoard == LIGUE1Score then
    o.currentLeagueType = "ligue1"
    elseif currentScoreBoard == SERIEAScore then
    o.currentLeagueType = "seriea"
    elseif currentScoreBoard == PokalScore then
    o.currentLeagueType = "pokal"
    elseif currentScoreBoard == WC26Score then
    o.currentLeagueType = "WC26"
    elseif currentScoreBoard == SAUDIARABIAScore then
    o.currentLeagueType = "SaudiArabia"
end

  local function getFirstWord(name)
      return string.match(name, "^[^%s]+") or name
  end

  if #o.TeamsData[1].teamName > 10 then
      currentScoreBoard.bnd_homeName2_text = getFirstWord(o.TeamsData[1].teamName)
  else
     currentScoreBoard.bnd_homeName2_text = o.TeamsData[1].teamName
  end

  if #o.TeamsData[2].teamName > 10 then
     currentScoreBoard.bnd_awayName2_text = getFirstWord(o.TeamsData[2].teamName)
  else
     currentScoreBoard.bnd_awayName2_text = o.TeamsData[2].teamName
  end

     currentScoreBoard.bnd_homeStatCrest.id = o.TeamsData[1].assetId
     currentScoreBoard.bnd_awayStatCrest.id = o.TeamsData[2].assetId
     currentScoreBoard.bnd_homeStatName_text = o.services.GameSetupService.GetTeamShortName(HOMETEAM)
     currentScoreBoard.bnd_awayStatName_text = o.services.GameSetupService.GetTeamShortName(AWAYTEAM)

  HudOption = currentHudOption
  if currentHudOption == 0 then
  end
  o.im.Subscribe(bndShowHUDVisible, function()
    if HudOption == 0 then
      o.im.Publish(bndShowHUDVisible, true)
    else 
      o.im.Publish(bndShowHUDVisible, false)
    end
  end
  )
  o.im.Subscribe(bndHideHUDVisible, function()
    if HudOption == 1 then
      o.im.Publish(bndHideHUDVisible, true)
    else 
      o.im.Publish(bndHideHUDVisible, false)
    end
  end
  )
  
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
      elseif k == "bnd_homeName2_text" then
        o.im.Publish(k, currentScoreBoard.bnd_homeName2_text)
      elseif k == "bnd_awayName2_text" then
        o.im.Publish(k, currentScoreBoard.bnd_awayName2_text)
      elseif k == "bnd_extraTime_visible" then
        o:publishExtraTimeVisibility(false)
      elseif k == "bnd_extraTime_text" then
        o:publishExtraTime()
      elseif k == "bnd_home_stat_text" or k == "bnd_away_stat_text" then
        o:publishStat()
      elseif k == "bnd_tournamentName_text" then
        o:publishTournamentName()
      elseif k == "bnd_tournamentRound_text" then
        o:publishTournamentRound()
      elseif k == "bnd_homeStatCrest" or k == "bnd_awayStatCrest" then
        o.im.Publish(k, v)
      elseif k == "bnd_homeStatName_text" or k == "bnd_awayStatName_text" then
        o.im.Publish(k, v)
      elseif k == "bnd_stat_image" then
        o.im.Publish(k, v)
      else
        o.im.Publish(k, v)
      end
    end)
  end

  playernibOption = currentPlayernibOption
  if currentPlayernibOption == 0 then
  end
  o.im.Subscribe(bndNibsOnSideVisible, function()
    if playernibOption == 0 then
      o.im.Publish(bndNibsOnSideVisible, true)
    else 
      o.im.Publish(bndNibsOnSideVisible, false)
    end
  end
  )
  o.im.Subscribe(bndNibsOnCenterVisible, function()
    if playernibOption == 1 then
      o.im.Publish(bndNibsOnCenterVisible, true)
    else 
      o.im.Publish(bndNibsOnCenterVisible, false)
    end
  end
  )
  o.im.Subscribe(bndNibsOnSingleVisible, function()
    if playernibOption == 2 then
      o.currentLeague = EAFCSingle
      o.im.Publish(bndNibsOnSingleVisible, true)
    else 
      o.im.Publish(bndNibsOnSingleVisible, false)
    end
  end
  )
  
  o.im.Subscribe("bnd_live_logo", function()
    o.im.Publish("bnd_live_logo", liveLogo)
  end)

  return o
end

function ScoreClock:getTournamentScoreboardBasedOnTeams()
  local PremierLeagueTeams = self.services.TeamService.GetTeams(leagueIDs.PremierLeague, 0, 0, true)
  local Ligue1Teams = self.services.TeamService.GetTeams(leagueIDs.Ligue1, 0, 0, true)
  local Bundesliga1Teams = self.services.TeamService.GetTeams(leagueIDs.Bundesliga1, 0, 0, true)
  local SerieATeams = self.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local LaligaTeams = self.services.TeamService.GetTeams(leagueIDs.Laliga, 0, 0, true)
  
  if self:isInTable(self.TeamsData[1], PremierLeagueTeams) and self:isInTable(self.TeamsData[2], PremierLeagueTeams) then
    return PREMIERLEAGUEScore
  elseif self:isInTable(self.TeamsData[1], Ligue1Teams) and self:isInTable(self.TeamsData[2], Ligue1Teams) then
    return LIGUE1Score
  elseif self:isInTable(self.TeamsData[1], Bundesliga1Teams) and self:isInTable(self.TeamsData[2], Bundesliga1Teams) then
    return BUNDESLIGA1Score
  elseif self:isInTable(self.TeamsData[1], SerieATeams) and self:isInTable(self.TeamsData[2], SerieATeams) then
    return SERIEAScore
  elseif self:isInTable(self.TeamsData[1], LaligaTeams) and self:isInTable(self.TeamsData[2], LaligaTeams) then
    return LALIGAScore
  else
    return EAFCScore
  end
end

function ScoreClock:publishTournamentName()
  if currentTourData and currentTourData.tourName then
    self.im.Publish("bnd_tournamentName_text", string.upper(currentTourData.tourName))
  end
end

function ScoreClock:publishTournamentRound()
  if currentTourData and currentTourData.roundName and currentTourData.roundName ~= "" then
    self.im.Publish("bnd_tournamentRound_text", string.upper(currentTourData.roundName))
  end
end

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
    elseif (gameTime + 0 > 10 and gameTime + 0 < 15) or (gameTime + 0 > 80 and gameTime + 0 < 85) then
      statTypeLabel = self.statType.Chemistry.label
      statTypeValue = self.statType.Chemistry.value
    elseif (gameTime + 0 > 2 and gameTime + 0 < 15) or (gameTime + 0 > 80 and gameTime + 0 < 85) then
      self.im.Publish("bnd_homeScore_text", tostring(self.homeScore))
      LALIGAScore.bnd_scoreboard_height = 600
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

function ScoreClock:triggerGoalAnimation(teamIndex)

    local goalAsset = "$GoalAnimation"

    if self.currentLeagueType == "epl" then
        goalAsset = "$GoalAnimationEPL"
    elseif self.currentLeagueType == "laliga" then
        goalAsset = "$GoalAnimationLaLiga"
        elseif self.currentLeagueType == "LaligaHypermotion" then
        goalAsset = "$GoalAnimationLaLiga"
    elseif self.currentLeagueType == "ucl" then
        goalAsset = "$GoalAnimationUcl"
    elseif self.currentLeagueType == "briliga1" then
        goalAsset = "$GoalAnimationBRILiga1"
        elseif self.currentLeagueType == "pildun" then
        goalAsset = "$GoalAnimationpildun"
    elseif self.currentLeagueType == "cup" then
        goalAsset = "$GoalAnimationcup"
    elseif self.currentLeagueType == "cwc" then
        goalAsset = "$GoalAnimationcwc"
    elseif self.currentLeagueType == "bundesliga" then
        goalAsset = "$GoalAnimationbundesliga"
    elseif self.currentLeagueType == "ligue1" then
        goalAsset = "$GoalAnimationligue1"
    elseif self.currentLeagueType == "seriea" then
        goalAsset = "$GoalAnimationseriea"
    elseif self.currentLeagueType == "pokal" then
        goalAsset = "$GoalAnimationpokal"
        elseif self.currentLeagueType == "WC26" then
        goalAsset = "$GoalAnimationWC26"
        elseif self.currentLeagueType == "SaudiArabia" then
        goalAsset = "$GoalAnimationLaLiga"
    end

    self.im.Publish("bnd_goalAnimation", {
        id = self.TeamsData[teamIndex].assetId,
        name = goalAsset
    })

    self.im.Publish("bnd_goalAnimation_visible", true)
    self.goalHideTime = os.clock() + 10
end

function ScoreClock:update()
    if self.goalHideTime and os.clock() > self.goalHideTime then
        self.im.Publish("bnd_goalAnimation", { id = 0, name = "" })
        self.im.Publish("bnd_goalAnimation_visible", false)
        self.goalHideTime = nil
    end
end

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

        if params and #params >= 6 then
            local oldHome = tonumber(self.homeScore) or 0
            local oldAway = tonumber(self.awayScore) or 0

            self.homeScore = tonumber(params[5]) or 0
            self.awayScore = tonumber(params[6]) or 0

            self.im.Publish("bnd_homeScore_text", tostring(self.homeScore))
            self.im.Publish("bnd_awayScore_text", tostring(self.awayScore))

            local goalScored = false

            if self.homeScore > oldHome then
                self:triggerGoalAnimation(1)
                goalScored = true
            end

            if self.awayScore > oldAway then
                self:triggerGoalAnimation(2)
                goalScored = true
            end
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
  self.im.Unsubscribe("bnd_live_logo")
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe(bndShowHUDVisible)
  self.im.Unsubscribe(bndHideHUDVisible)
  self.im.Unsubscribe(bndNibsOnSideVisible)
  self.im.Unsubscribe(bndNibsOnCenterVisible)
  self.im.Unsubscribe(bndNibsOnSingleVisible)
  for k,v in pairs(EAFCScore) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return ScoreClock

-- Thanks : Ma'ruf Id & Laosiji --
-- And All Modder --
-- REMOD MOUNTSA ( SUPPORT GROUP STAGE ) --