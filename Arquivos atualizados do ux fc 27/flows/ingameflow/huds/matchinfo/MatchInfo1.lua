-- Thanks : Ma'ruf Id & Laosiji --
-- TLS 26 MatchInfo Fc26 --

local MatchInfo = {}
local OverlaysIdContainer, OverlayParam, eventmanager, TableUtil = ...
local OVERLAY_TYPES = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

local bndRainVisible = "bnd_rain_visible"
local bndSnowVisible = "bnd_snow_visible"
local bndWeather = "bnd_weather_type"
local BND_REALTIME = "bnd_realtime"

local leagueIDs = {
  PremierLeague = 13,
  Ligue1 = 16,
  Ligue2 = 17,
  Bundesliga1 = 19,
  Bundesliga2 = 20,
  SerieA = 31,
  SerieB = 32,
  Laliga = 53,
  LaligaHypermotion = 54,
  BRILiga1 = 2235,
  ChampionshipLiga2 = 2254
}

PremierLeagueTeamsData = {
  { teamid = 1, homeColor = "0x9D1A27", awayColor = "0x242A3E", homeFontColor = "0xFFFFFF", awayFontColor = "0xFDFDFD" },
  { teamid = 2, homeColor = "0x7A263A", awayColor = "0x161616", homeFontColor = "0xFFFFFF", awayFontColor = "0xDFDFDF" },
  { teamid = 5, homeColor = "0x034694", awayColor = "0xD4D4CA", homeFontColor = "0xFFFFFF", awayFontColor = "0x415A4F" },
  { teamid = 7, homeColor = "0x003399", awayColor = "0xF6F0D7", homeFontColor = "0xFFFFFF", awayFontColor = "0x474E6F" },
  { teamid = 8, homeColor = "0xFFFFFF", awayColor = "0x21458C", homeFontColor = "0x0057B8", awayFontColor = "0xC5A91C" },
  { teamid = 9, homeColor = "0xC8102E", awayColor = "0xDED6CC", homeFontColor = "0xFFFFFF", awayFontColor = "0xBE2E3B" },
  { teamid = 10, homeColor = "0x6CABDD", awayColor = "0x131313", homeFontColor = "0x00285E", awayFontColor = "0xE6E6E6" },
  { teamid = 11, homeColor = "0xDA291C", awayColor = "0xC5C5C5", homeFontColor = "0xFFFFFF", awayFontColor = "0x524061" },
  { teamid = 13, homeColor = "0x000000", awayColor = "0x0B6E45", homeFontColor = "0xFFFFFF", awayFontColor = "0xD1D1D1" },
  { teamid = 14, homeColor = "0xDD1D21", awayColor = "0xCCCABA", homeFontColor = "0xFFFFFF", awayFontColor = "0x272B39" },
  { teamid = 18, homeColor = "0xFFFFFF", awayColor = "0x1B1A1A", homeFontColor = "0x132257", awayFontColor = "0xFFFFFF" },
  { teamid = 19, homeColor = "0x60223B", awayColor = "0xD3C9BF", homeFontColor = "0xFFFFFF", awayFontColor = "0x233148" },
  { teamid = 106, homeColor = "0xE31B23", awayColor = "0x05378D", homeFontColor = "0xFFFFFF", awayFontColor = "0xE8E8E8" },
  { teamid = 110, homeColor = "0xFDB913", awayColor = "0x50C1BA", homeFontColor = "0x000000", awayFontColor = "0x181616" },
  { teamid = 144, homeColor = "0xFFFFFF", awayColor = "0x82A554", homeFontColor = "0x000000", awayFontColor = "0x121C35" },
  { teamid = 1796, homeColor = "0x6A003A", awayColor = "0x86B8C6", homeFontColor = "0xFFFFFF", awayFontColor = "0x663145" },
  { teamid = 1799, homeColor = "0x1B458F", awayColor = "0xFEFEFE", homeFontColor = "0xFFFFFF", awayFontColor = "0x182F80" },
  { teamid = 1808, homeColor = "0x0057B8", awayColor = "0x757194", homeFontColor = "0xFFFFFF", awayFontColor = "0xF8F8F5" },
  { teamid = 1925, homeColor = "0xE30613", awayColor = "0x503B34", homeFontColor = "0xFFFFFF", awayFontColor = "0xAA9567" },
  { teamid = 1943, homeColor = "0xDA291C", awayColor = "0x0E479B", homeFontColor = "0xFFFFFF", awayFontColor = "0xE3E3E3" },
  { teamid = 126987, homeColor = "0xEFEB04", awayColor = "0xE4E4E4", homeFontColor = "0x0010101", awayFontColor = "0x910D0C" }
}

Bundesliga1TeamsData = {
  { teamid = 21, homeColor = "0xB80018", awayColor = "0xE0E0E0", homeFontColor = "0xE0E0E0", awayFontColor = "0xB80018", thirdColor = "0x1C1C1C", thirdFontColor = "0xEFE4D8"},
  { teamid = 22, homeColor = "0xF4D13A", awayColor ="0xD6FF57",homeFontColor = "0x1A1A1A", awayFontColor = "0x4A4A4A", thirdColor = "0xF5C633", thirdFontColor = "0x202020"},
  { teamid = 23, homeColor = "0xE0E0E0", awayColor ="0x30B060",homeFontColor = "0x30B060", awayFontColor = "0xE0E0E0", thirdColor = "0x202020", thirdFontColor = "0xD9D9D9"},
  { teamid = 25, homeColor = "0x9c2225", awayColor ="0x3e4041",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0", thirdColor = "0xCF2424", thirdFontColor = "0xF5F5F5"},
  { teamid = 31, homeColor = "0xE0E0E0", awayColor = "0xE01820",homeFontColor = "0xE01820", awayFontColor = "0xE0E0E0" },
  { teamid = 32, homeColor = "0xB81020", awayColor = "0x101010",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0", thirdColor = "0x1D4ED8", thirdFontColor = "0xB7FFF5"},
  { teamid = 36, homeColor = "0xd3d4d3", awayColor ="0xc62432",homeFontColor ="0xc62432" , awayFontColor = "0xd3d4d3", thirdColor = "0x2A2A2A", thirdFontColor = "0xF2F2F2"},
  { teamid = 38, homeColor = "0x289880", awayColor ="0xE1B5AD",homeFontColor ="0xE0E0E0" , awayFontColor = "0x289880", thirdColor = "0x0F6A52", thirdFontColor = "0xD8B08A"},
  { teamid = 160, homeColor ="0x1d3552" , awayColor ="0x65a7d4",homeFontColor = "0xE0E0E0", awayFontColor ="0x202838" }, 
  { teamid = 169, homeColor = "0xD01818", awayColor = "0xD8D8D8",homeFontColor = "0xD8D8D8", awayFontColor = "0xD01818", thirdColor = "0xF1ECE2", thirdFontColor = "0x4A4A4A"},
  --{ teamid = 175, homeColor = "0x50A830", awayColor ="0x383C3D",homeFontColor = "0xE0E0E0", awayFontColor = "0x50A830"},
  { teamid = 1824, homeColor ="0xD7D7D5" , awayColor ="0x323231",homeFontColor = "0x323231", awayFontColor ="0xD7D7D5", thirdColor = "0x2B2B2B", thirdFontColor = "0xECECEC"},  
  { teamid = 1831, homeColor ="0xbc1e20" , awayColor ="0xd5cbbb",homeFontColor = "0xd5cbbb", awayFontColor ="0xbc1e20", thirdColor = "0x8FD3F5", thirdFontColor = "0xFFFFFF"},  
  { teamid = 10029, homeColor ="0x204390" , awayColor = "0x27B8E3",homeFontColor = "0xcec29a", awayFontColor = "0xF5F5F5", thirdColor = "0xF5F5F5", thirdFontColor = "0x1F2E5A"},  
  { teamid = 100409, homeColor = "0xaa2327", awayColor ="0xd2d1d0",homeFontColor = "0xd2d1d0", awayFontColor = "0xaa2327", thirdColor = "0x1F1F1F", thirdFontColor = "0xC8A96B"}, 
  { teamid = 112172, homeColor = "0xf9f8f8", awayColor ="0xa51b21",homeFontColor = "0xa51b21", awayFontColor = "0xf9f8f8", thirdColor = "0x6B1F1F", thirdFontColor = "0x2B2B2B"},   
  --{ teamid = 111235, homeColor = "0xC7181D", awayColor = "0x2958A0",homeFontColor = "0x2958A0", awayFontColor = "0xC7181D"},
  --{ teamid = 110502, homeColor = "0xD0CFCE", awayColor = "0x313447", homeFontColor = "0x313447", awayFontColor = "0xD0CFCE"},
  { teamid = 34, homeColor = "0x243A78", awayColor = "0xF5F5F5", homeFontColor = "0xEFEFEF", awayFontColor = "0x4A6DE3"},
  { teamid = 580, homeColor = "0xF4F4F4", awayColor = "0x1E1E1E", homeFontColor = "0x3A3A3A", awayFontColor = "0xD9D9D9"},
  { teamid = 10030, homeColor = "0x101010", awayColor = "0xEFEFEF", homeFontColor = "0x1F56B3", awayFontColor = "0x2670D9"},
  { teamid = 28, homeColor = "0xF2F2F2", awayColor = "0x2F4798", homeFontColor = "0x2F4798", awayFontColor = "0xECECEC"},
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

EAFCInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpandes", 
  bnd_background_show = true,
  bnd_background_height = 850,
  bnd_background_width = 1418,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 15,
  bnd_background = {
    name = "$MatchInfo",
    id = 0
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 0,
  bnd_label_width = 290,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -198,
  bnd_homelabel_top = -70,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 11,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 15,
  bnd_homelabel_short_top = -30,
  bnd_homelabel_short_left = -18,
  bnd_homelabel_text_fontcolor = "0x000000",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = -198,
  bnd_awaylabel_top = 60,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 11,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 15,
  bnd_awaylabel_short_top = -30,
  bnd_awaylabel_short_left = -18,
  bnd_awaylabel_text_fontcolor = "0x000000",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = 0,
  bnd_homelabel_rect_top = 0,
  bnd_awaylabel_rect_left = 0,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 255,
  bnd_crest_image_width = 115,
  bnd_crest_image_height = 115,
  bnd_homecrest_left = 350,
  bnd_homecrest_top = -60,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 350,
  bnd_awaycrest_top = 20,
  bnd_awaycrest_color = "0xF5F5F5",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 650,
  bnd_stadium_left = 0,
  bnd_stadium_top = 185,
  bnd_stadium_color = "0x151515",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = 160,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "FRIENDLY",
  bnd_title_fontSize = 0,
  bnd_title_fontColor = "0xffffff",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = -3,
  bnd_match_vs = "VS",
  bnd_vs_fontSize = 23,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = -245,
  bnd_vs_top = -20,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 0
  },
  bnd_logo_height = 50,
  bnd_logo_width = 50,
  bnd_logo_left = -318,
  bnd_logo_top = -425,
  bnd_logo_alpha = 1,
  
  bnd_stadium_icon = {
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x000000",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

PREMIERLEAGUEInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl",
  bnd_background_show = true,
  --bnd_background_height = 1920,
  --bnd_background_width = 1080,
  bnd_background_alignV = "FILL",
  bnd_background_alignH = "FILL",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 13
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 1500,
  bnd_label_width = 730,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -365,
  bnd_homelabel_top = -200,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 0,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 90,
  bnd_homelabel_text_fontcolor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 365,
  bnd_awaylabel_top = 150,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 0,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 90,
  bnd_awaylabel_text_fontcolor = "0xffffff",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = -350,
  bnd_homelabel_rect_top = 500,
  bnd_awaylabel_rect_left = 350,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 180,
  bnd_crest_image_height = 180,
  bnd_homecrest_left = -120,
  bnd_homecrest_top = 300,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 120,
  bnd_awaycrest_top = -250,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -550,
  bnd_stadium_top = 250,
  bnd_stadium_color = "0x151515",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 0,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 0,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = 0,
  bnd_title_color = "0x00fc7f",
  bnd_title_text = "",
  bnd_title_fontSize = 20,
  bnd_title_fontColor = "0x313131",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 13
  },
  bnd_logo_height = 200,
  bnd_logo_width = 200,
  bnd_logo_left = 0,
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
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0xFF4942",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

LALIGAInfo = {  
  bnd_fontFace = "$LaLiga",
  bnd_forceCaps = true,
  bnd_short_name_visible = false,
  bnd_teamLabel_visible = true,
  bnd_background_show = true,
  bnd_background_height = 600,
  bnd_background_width = 900,
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "CENTER",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 53
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -230,
  bnd_homelabel_top = 190,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 20,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0x151515",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 230,
  bnd_awaylabel_top = 190,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0x151515",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = 0,
  bnd_homelabel_rect_top = 0,
  bnd_awaylabel_rect_left = 0,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 180,
  bnd_crest_image_height = 180,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -220,
  bnd_homecrest_color = "0x000000",
  bnd_homecrest_image = {
    name = "$Crest_LaLiga",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -220,
  bnd_awaycrest_color = "0x000000",
  bnd_awaycrest_image = {
    name = "$Crest_LaLiga",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 0,
  bnd_stadium_top = 20,
  bnd_stadium_color = "0x000000",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -0.5,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = 80,
  bnd_title_color = "0x000000",
  bnd_title_text = "VIGO",
  bnd_title_fontSize = 15,
  bnd_title_fontColor = "0xFF4942",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "53_3"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 130,
  bnd_logo_left = 0,
  bnd_logo_top = 50,
  bnd_logo_alpha = 1,
  
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0xFF4942",
  bnd_realtime_top = -100,
  bnd_realtime_left = 0,
  
  bnd_match_jam = "",
  bnd_jam_fontSize = 0,
  bnd_jam_fontColor = "0x1E1E1E",
  bnd_jam_left = -3,
  bnd_jam_top = -240, 
  
  bnd_match_hari = "",
  bnd_hari_fontSize = 0,
  bnd_hari_fontColor = "0xFFFFFF",
  bnd_hari_left = 0,
  bnd_hari_top = -110, 
  
  bnd_match_vs = "Estádio",
  bnd_vs_fontSize = 18,
  bnd_vs_fontColor = "0xFF4942",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  
  bnd_match_tanggal = "",
  bnd_tanggal_fontSize = 25,
  bnd_tanggal_fontColor = "0xFF4942",
  bnd_tanggal_left = 40,
  bnd_tanggal_top = -100, 
  
  bnd_match_bulan = "",
  bnd_bulan_fontSize = 25,
  bnd_bulan_fontColor = "0xFF4942",
  bnd_bulan_left = -20,
  bnd_bulan_top = -100
}

LaligaHypermotionInfo = {
  bnd_fontFace = "$LaLiga",
  bnd_forceCaps = true,
  bnd_short_name_visible = false,
  bnd_teamLabel_visible = true,
  bnd_background_show = true,
  bnd_background_height = 700,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_alpha = 1,
  bnd_background = { name = "$MatchInfo", id = 54 },
  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_homelabel_left = -250,
  bnd_homelabel_top = 225,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 35,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0x000000",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 270,
  bnd_awaylabel_top = 225,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 35,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0x000000",
  bnd_awayLabel_alignH = "CENTER",
 
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 250,
  bnd_crest_image_height = 250,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -250,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest_LaLiga",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -250,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest_LaLiga",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 1,
  bnd_stadium_top = -5,
  bnd_stadium_color = "0x151515",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 17,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -6,
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -240,
  bnd_title_color = "0x151515",
  bnd_title_text = "08:56",
  bnd_title_fontSize = 35,
  bnd_title_fontColor = "0x151515",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = -3,
  
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0x151515",
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
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10000,
  
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

BUNDESLIGA1Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Bundesliga",
  bnd_background_show = true,
  bnd_background_height = 450,
  bnd_background_width = 1920,
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "CENTER",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 19
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 450,
  bnd_label_width = 300,
  bnd_label_text_top = 150,
  bnd_homelabel_left = -150,
  bnd_homelabel_top = 0,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 30,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 150,
  bnd_awaylabel_top = 0,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0xffffff",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = 0,
  bnd_homelabel_rect_top = 0,
  bnd_awaylabel_rect_left = 0,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 150,
  bnd_crest_image_height = 150,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = 15,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = 15,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 600,
  bnd_stadium_left = 0,
  bnd_stadium_top = -150,
  bnd_stadium_color = "0x2D2D2D",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  
  bnd_title_height = 50,
  bnd_title_width = 600,
  bnd_title_left = 0,
  bnd_title_top = -200,
  bnd_title_color = "0xf5f5f5",
  bnd_title_text = "BUNDESLIGA",
  bnd_title_fontSize = 35,
  bnd_title_fontColor = "0x000000",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 60,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 19
  },
  bnd_logo_height = 50,
  bnd_logo_width = 50,
  bnd_logo_left = 5,
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
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0xFF4942",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

BUNDESLIGA2Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Bundesliga",
  bnd_background_show = true,
  bnd_background_height = 450,
  bnd_background_width = 1920,
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "CENTER",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 19
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  bnd_label_height = 450,
  bnd_label_width = 300,
  bnd_label_text_top = 150,
  bnd_homelabel_left = -150,
  bnd_homelabel_top = 0,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 30,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 150,
  bnd_awaylabel_top = 0,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0xffffff",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = 0,
  bnd_homelabel_rect_top = 0,
  bnd_awaylabel_rect_left = 0,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 150,
  bnd_crest_image_height = 150,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = 15,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = 15,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 600,
  bnd_stadium_left = 0,
  bnd_stadium_top = -150,
  bnd_stadium_color = "0x2D2D2D",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "LEFT",
  bnd_stadium_text_left = 60,
  
  bnd_title_height = 50,
  bnd_title_width = 600,
  bnd_title_left = 0,
  bnd_title_top = -200,
  bnd_title_color = "0xf5f5f5",
  bnd_title_text = "2.BUNDESLIGA",
  bnd_title_fontSize = 35,
  bnd_title_fontColor = "0x000000",
  bnd_title_text_alignH = "LEFT",
  bnd_title_text_left = 60,
  bnd_match_vs = "",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0x000000",
  bnd_vs_left = 0,
  bnd_vs_top = 0,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 20
  },
  bnd_logo_height = 50,
  bnd_logo_width = 50,
  bnd_logo_left = 5,
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
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0xFF4942",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

LIGUE1Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Ligue1", 
  bnd_background_show = true,
  bnd_background_height = 600,
  bnd_background_width = 900,
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "CENTER",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 16
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -200,
  bnd_homelabel_top = 160,
  bnd_homelabel_color = "0xFFFFFF",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 20,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0xFFFFFF",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 200,
  bnd_awaylabel_top = 160,
  bnd_awaylabel_color = "0xFFFFFF",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0xFFFFFF",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = 0,
  bnd_homelabel_rect_top = 0,
  bnd_awaylabel_rect_left = 0,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 250,
  bnd_crest_image_height = 250,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -168,
  bnd_homecrest_color = "0x000000",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = -168,
  bnd_awaycrest_color = "0x000000",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 350,
  bnd_stadium_top = -167,
  bnd_stadium_color = "0x000000",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 18,
  bnd_stadium_fontColor = "0xFFFFFF",
  bnd_stadium_text_alignH = "RIGHT",
  bnd_stadium_text_left = -0.5,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -170,
  bnd_title_color = "0x000000",
  bnd_title_text = "",
  bnd_title_fontSize = 15,
  bnd_title_fontColor = "0x04D4D4",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 17,
  bnd_vs_fontColor = "0x04D4D4",
  bnd_vs_left = 0,
  bnd_vs_top = -10,
  bnd_logo = {
    name = "$LeagueLogo",
    id = "16_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 100,
  bnd_logo_left = -300,
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
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

Ligue2Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Ligue1_Medium", 
  bnd_background_show = true,
  bnd_background_height = 600,
  bnd_background_width = 900,
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "CENTER",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 17
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -200,
  bnd_homelabel_top = 168,
  bnd_homelabel_color = "0xFFFFFF",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 20,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 230,
  bnd_awaylabel_top = 168,
  bnd_awaylabel_color = "0xFFFFFF",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0xffffff",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = 0,
  bnd_homelabel_rect_top = 0,
  bnd_awaylabel_rect_left = 0,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 250,
  bnd_crest_image_height = 250,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -168,
  bnd_homecrest_color = "0x000000",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 20,
  bnd_awaycrest_top = -168,
  bnd_awaycrest_color = "0x000000",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 80,
  bnd_stadium_top = 100,
  bnd_stadium_color = "0x000000",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 14,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "RIGHT",
  bnd_stadium_text_left = -0.5,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -170,
  bnd_title_color = "0x000000",
  bnd_title_text = "",
  bnd_title_fontSize = 15,
  bnd_title_fontColor = "0x04D4D4",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "",
  bnd_vs_fontSize = 17,
  bnd_vs_fontColor = "0x04D4D4",
  bnd_vs_left = 0,
  bnd_vs_top = -10,
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "16_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 100,
  bnd_logo_left = -300,
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
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

SERIEAInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Seria_Bold",
  bnd_background_show = true,
  --bnd_background_height = 1920,
  --bnd_background_width = 1080,
  bnd_background_alignV = "FILL",
  bnd_background_alignH = "FILL",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 31
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -190,
  bnd_homelabel_top = 120,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 19,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_short_top = 0,
  bnd_homelabel_short_left = 0,
  bnd_homelabel_text_fontcolor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 190,
  bnd_awaylabel_top = 120,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 19,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_short_top = 0,
  bnd_awaylabel_short_left = 0,
  bnd_awaylabel_text_fontcolor = "0xffffff",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -100,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -0,
  bnd_awaycrest_top = -100,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 70,
  bnd_stadium_top = -238,
  bnd_stadium_color = "0x000000",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0x02215D",
  bnd_stadium_text_alignH = "RIGHT",
  bnd_stadium_text_left = -0.5,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -170,
  bnd_title_color = "0x000000",
  bnd_title_text = "",
  bnd_title_fontSize = 15,
  bnd_title_fontColor = "0x04D4D4",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "VS",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0x35C2DE",
  bnd_vs_left = 0,
  bnd_vs_top = 40,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 31
  },
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_left = 0,
  bnd_logo_top = 205,
  bnd_logo_alpha = 1,
  
  bnd_stadium_icon = {
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

SERIEBInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$UniversNextProBold",
  bnd_background_show = true,
  bnd_background_height = 1920,
  bnd_background_width = 1060,
  bnd_background_alignV = "FILL",
  bnd_background_alignH = "FILL",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 32
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_label_text_top = 0,
  bnd_homelabel_left = 0,
  bnd_homelabel_top = -160,
  bnd_homelabel_color = "0xFFFFFF",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 30,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 0,
  bnd_awaylabel_top = -70,
  bnd_awaylabel_color = "0xFFFFFF",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 30,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0xffffff",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = 0,
  bnd_homelabel_rect_top = 0,
  bnd_awaylabel_rect_left = 0,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 130,
  bnd_crest_image_height = 130,
  bnd_homecrest_left = -240,
  bnd_homecrest_top = 200,
  bnd_homecrest_color = "0x000000",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 210,
  bnd_awaycrest_top = 120,
  bnd_awaycrest_color = "0x000000",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 80,
  bnd_stadium_top = 190,
  bnd_stadium_color = "0x000000",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 15,
  bnd_stadium_fontColor = "0xFFFFFF",
  bnd_stadium_text_alignH = "RIGHT",
  bnd_stadium_text_left = -0.5,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -170,
  bnd_title_color = "0x000000",
  bnd_title_text = "",
  bnd_title_fontSize = 15,
  bnd_title_fontColor = "0x04D4D4",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "VS",
  bnd_vs_fontSize = 35,
  bnd_vs_fontColor = "0xFA8132",
  bnd_vs_left = 0,
  bnd_vs_top = -115,
  bnd_logo = {
    name = "$LeagueLogo",
    id = 32
  },
  bnd_logo_height = 90,
  bnd_logo_width = 90,
  bnd_logo_left = -350,
  bnd_logo_top = 60,
  bnd_logo_alpha = 1,
  
  bnd_stadium_icon = {
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

UCLInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-Bold",
  bnd_background_show = true,
  bnd_background_height = 400,
  bnd_background_width = 600,
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "CENTER",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = 2236
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 0,
  bnd_label_width = 0,
  bnd_label_text_top = 0,
  bnd_homelabel_left = 0,
  bnd_homelabel_top = -30,
  bnd_homelabel_color = "0xFFFFFF",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 0,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0xffffff",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 0,
  bnd_awaylabel_top = 80,
  bnd_awaylabel_color = "0xFFFFFF",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 0,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0xffffff",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_label_rect_height = 0,
  bnd_label_rect_width = 0,
  bnd_homelabel_rect_left = 0,
  bnd_homelabel_rect_top = 0,
  bnd_awaylabel_rect_left = 0,
  bnd_awaylabel_rect_top = 0,
  
  bnd_crest_height = 0,
  bnd_crest_width = 0,
  bnd_crest_image_width = 150,
  bnd_crest_image_height = 150,
  bnd_homecrest_left = -160,
  bnd_homecrest_top = 30,
  bnd_homecrest_color = "0x000000",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 160,
  bnd_awaycrest_top = -80,
  bnd_awaycrest_color = "0x000000",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = 0,
  bnd_stadium_top = 150,
  bnd_stadium_color = "0x000000",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 15,
  bnd_stadium_fontColor = "0xFFFFFF",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -0.5,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -170,
  bnd_title_color = "0x000000",
  bnd_title_text = "",
  bnd_title_fontSize = 0,
  bnd_title_fontColor = "0x04D4D4",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "VS",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0x35C2DE",
  bnd_vs_left = 0,
  bnd_vs_top = 25,
  bnd_logo = {
    name = "$LeagueLogoX",
    id = 0
  },
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_left = 0,
  bnd_logo_top = -50,
  bnd_logo_alpha = 1,
  
  bnd_stadium_icon = {
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}

BRILiga1Info = {
  bnd_fontFace = "$Liga1",
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = { name = "$MatchInfo", id = 2235 },
  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -200,
  bnd_homelabel_top = 100,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 20,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_short_top = 0,
  bnd_homelabel_short_left = 0,
  bnd_homelabel_text_fontcolor = "0x000000",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 200,
  bnd_awaylabel_top = 100,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_short_top = 0,
  bnd_awaylabel_short_left = 0,
  bnd_awaylabel_text_fontcolor = "0x000000",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
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
  bnd_stadium_left = 1,
  bnd_stadium_top = -160,
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
ChampionshipLiga2Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Liga1",
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 30,
  bnd_background = { name = "$MatchInfo", id = 2254 },
  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -190,
  bnd_homelabel_top = 110,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 16,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_short_top = 0,
  bnd_homelabel_short_left = 0,
  bnd_homelabel_text_fontcolor = "0x09533A",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 190,
  bnd_awaylabel_top = 110,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 16,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_short_top = 0,
  bnd_awaylabel_short_left = 0,
  bnd_awaylabel_text_fontcolor = "0x09533A",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 170,
  bnd_crest_image_height = 170,
  bnd_homecrest_left = 0,
  bnd_homecrest_top = -150,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -0,
  bnd_awaycrest_top = -150,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 110,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "Stadium",
  bnd_stadium_fontSize = 12,
  bnd_stadium_fontColor = "0x09533A",
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
    name = "$LeagueLogo",
    id = 2254
  },
  bnd_logo_height = 120,
  bnd_logo_width = 120,
  bnd_logo_left = 0,
  bnd_logo_top = -200,
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

-- MatchInfo Tournaments --

AclTwoInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_background_show = true,
  bnd_background_height = 630,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = "CupID4"
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0,
  bnd_background_stadium_alpha = 0,
  
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
  bnd_homelabel_text_fontcolor = "0xffffff",
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
  bnd_awaylabel_text_fontcolor = "0xffffff",
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
  bnd_stadium_top = 170,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 15,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 50,
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

PialaIndonesiaInfo = {  
  bnd_fontFace = "$Brasil-Sportv",
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = { name = "$MatchInfo", id = "CupID16" },
  
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 1,
  bnd_background_stadium_alpha = 1,
  
  bnd_label_height = 0,
  bnd_label_width = 360,  
  bnd_label_text_top = 0,
  bnd_homelabel_left = 56,
  bnd_homelabel_top = 10,
  bnd_homelabel_color = "0xFFFFFF",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 20,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_text_fontcolor = "0x000000",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 30,
  bnd_awaylabel_top = 80,
  bnd_awaylabel_color = "0xFFFFFF",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 20,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_text_fontcolor = "0x000000",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 70,
  bnd_crest_image_height = 70,
  bnd_homecrest_left = -60,
  bnd_homecrest_top = -80,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 40,
  bnd_awaycrest_top = -152,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 142,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 12,
  bnd_stadium_fontColor = "0x000000",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = 150,
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
  bnd_match_vs = "MATCHDAY",
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
    name = "$MatchInfo",
    id = "CupID27"
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0,
  bnd_background_stadium_alpha = 0,
  
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
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 30,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 50,
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
EASPORTSInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Seria_Bold",
  bnd_background_show = true,
  --bnd_background_height = 1920,
  --bnd_background_width = 1080,
  bnd_background_alignV = "FILL",
  bnd_background_alignH = "FILL",
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$MatchInfo",
    id = "CupID14"
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0.9,
  
  bnd_label_height = 0,
  bnd_label_width = 360,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -75,
  bnd_homelabel_top = -20,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 25,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_short_top = 0,
  bnd_homelabel_short_left = 0,
  bnd_homelabel_text_fontcolor = "0xDFFF00",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 90,
  bnd_awaylabel_top = 56,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 25,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_short_top = 0,
  bnd_awaylabel_short_left = 0,
  bnd_awaylabel_text_fontcolor = "0xDFFF00",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 0,
  bnd_crest_width = 360,
  bnd_crest_image_width = 70,
  bnd_crest_image_height = 70,
  bnd_homecrest_left = 158,
  bnd_homecrest_top = -18,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = -171,
  bnd_awaycrest_top = -18,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 0,
  bnd_stadium_width = 0,
  bnd_stadium_left = -20,
  bnd_stadium_top = 138,
  bnd_stadium_color = "0x000000",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0x080838",
  bnd_stadium_text_alignH = "RIGHT",
  bnd_stadium_text_left = -0.5,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_left = 0,
  bnd_title_top = -170,
  bnd_title_color = "0x000000",
  bnd_title_text = "",
  bnd_title_fontSize = 15,
  bnd_title_fontColor = "0x04D4D4",
  bnd_title_text_alignH = "CENTER",
  bnd_title_text_left = 0,
  bnd_match_vs = "VS",
  bnd_vs_fontSize = 0,
  bnd_vs_fontColor = "0xFFFFFF",
  bnd_vs_left = 0,
  bnd_vs_top = 40,
  bnd_logo = {
    name = "$LeagueLogox",
    id = 11
  },
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_left = 0,
  bnd_logo_top = 205,
  bnd_logo_alpha = 1,
  
  bnd_stadium_icon = {
    name = "$StadiumIcon1",
    id = 0
  },
  bnd_stadium_icon_height = 40,
  bnd_stadium_icon_width = 40,
  bnd_stadium_icon_top = 0,
  bnd_stadium_icon_left = 10,
  bnd_realtime_fontSize = 0,
  bnd_realtime_fontColor = "0x04D4D4",
  bnd_realtime_top = 0,
  bnd_realtime_left = 0
}
AfrikaCupInfo = {
  bnd_fontFace = "$Liga1",
  bnd_background_show = true,
  bnd_background_height = 500,
  bnd_background_width = 830,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 0,
  bnd_background = { name = "$MatchInfo", id = "CupID26" },
  
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
  bnd_homelabel_short_fontSize = 0,
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
  bnd_awaylabel_short_fontSize = 0,
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
WC26Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansMedium", 
  bnd_background_show = true,
  bnd_background_height = 630,
  bnd_background_width = 1050,
  bnd_background_alignH = "CENTER",
  bnd_background_alignV = "CENTER",
  bnd_background_top = 50,
  bnd_background = {
    name = "$MatchInfo",
    id = "CupID2"
  },
  bnd_background_alpha = 1,
  bnd_background_alpha_1 = 0,
  bnd_background_stadium_alpha = 0,
  
  bnd_label_height = 100,
  bnd_label_width = 300,
  bnd_label_text_top = 0,
  bnd_homelabel_left = -300,
  bnd_homelabel_top = -225,
  bnd_homelabel_color = "0x151515",
  bnd_homelabel_text = "",
  bnd_homelabel_fontSize = 25,
  bnd_homelabel_short = "",
  bnd_homelabel_short_fontSize = 0,
  bnd_homelabel_short_top = -30,
  bnd_homelabel_short_left = -18,
  bnd_homelabel_text_fontcolor = "0xFFFFFF",
  bnd_homeLabel_alignH = "CENTER",
  
  bnd_awaylabel_left = 310,
  bnd_awaylabel_top = -225,
  bnd_awaylabel_color = "0x151515",
  bnd_awaylabel_text = "",
  bnd_awaylabel_fontSize = 25,
  bnd_awaylabel_short = "",
  bnd_awaylabel_short_fontSize = 0,
  bnd_awaylabel_short_top = -30,
  bnd_awaylabel_short_left = -18,
  bnd_awaylabel_text_fontcolor = "0xFFFFFF",
  bnd_awayLabel_alignH = "CENTER",
  
  bnd_crest_height = 300,
  bnd_crest_width = 360,
  bnd_crest_image_width = 220,
  bnd_crest_image_height = 220,
  bnd_homecrest_left = -0,
  bnd_homecrest_top = 210,
  bnd_homecrest_color = "0x191c25",
  bnd_homecrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_left = 0,
  bnd_awaycrest_top = 210,
  bnd_awaycrest_color = "0x191c25",
  bnd_awaycrest_image = {
    name = "$Crest",
    id = 0
  },
  bnd_stadium_height = 50,
  bnd_stadium_width = 500,
  bnd_stadium_left = 1,
  bnd_stadium_top = 150,
  bnd_stadium_color = "0x252b39",
  bnd_stadium_text = "",
  bnd_stadium_fontSize = 20,
  bnd_stadium_fontColor = "0xffffff",
  bnd_stadium_text_alignH = "CENTER",
  bnd_stadium_text_left = -2,
  bnd_title_height = 50,
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
-- Finish

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
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.currentOptions = o.services.SettingsService.GetCurrentOptions()
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
  o:handleEvent(...) end)

  local HOMETEAM = 0
  local AWAYTEAM = 1
  local currentdata = nil
    
  local PremierLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.PremierLeague, 0, 0, true)
  local Ligue1Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue1, 0, 0, true)
  local Ligue2Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue2, 0, 0, true)
  local Bundesliga1Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga1, 0, 0, true)
  local Bundesliga2Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga2, 0, 0, true)
  local SerieATeams = o.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local SerieBTeams = o.services.TeamService.GetTeams(leagueIDs.SerieB, 0, 0, true)
  local LaligaTeams = o.services.TeamService.GetTeams(leagueIDs.Laliga, 0, 0, true)
  local LaligaHypermotionTeams = o.services.TeamService.GetTeams(leagueIDs.LaligaHypermotion, 0, 0, true)
  local BRILiga1Teams = o.services.TeamService.GetTeams(leagueIDs.BRILiga1, 0, 0, true)
  local ChampionshipLiga2Teams = o.services.TeamService.GetTeams(leagueIDs.ChampionshipLiga2, 0, 0, true)
  
  homeCrest = {
    name = "$Crest",
    id = o.TeamsData[1].assetId
  }
  awaycrest = {
    name = "$Crest",
    id = o.TeamsData[2].assetId
  }
  
  -- CUP competition
  if currentCupData and currentCupData.cupIndex and currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      currentdata = UCLInfo
    else
      currentdata = EAFCInfo
    end
  
  elseif currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      currentdata = UCLInfo
    elseif currentTourData.tourIndex == 35 then
      currentdata = UCLInfo
    elseif currentTourData.tourIndex == 14 then
      currentdata = EASPORTSInfo
    elseif currentTourData.tourIndex == 26 then
      currentdata = AfrikaCupInfo
    elseif currentTourData.tourIndex == 2 then
      currentdata = WC26Info
    elseif currentTourData.tourIndex == 27 then
      currentdata = AseanChampionshipInfo
    elseif currentTourData.tourIndex == 31 then
      currentdata = AclTwoInfo
    else
      currentdata = EAFCInfo
    end
  
  -- LEAGUE / FRIENDLY competition
  else
    if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
      currentdata = PREMIERLEAGUEInfo
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, PremierLeagueTeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, PremierLeagueTeamsData)
      currentdata.bnd_homelabel_color = homeColorList[1]
      currentdata.bnd_homelabel_text_fontcolor = homeColorList[2]
      currentdata.bnd_awaylabel_color = awayColorList[1]
      currentdata.bnd_awaylabel_text_fontcolor = awayColorList[2]
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      currentdata = LIGUE1Info
    elseif o:isInTable(o.TeamsData[1], Ligue2Teams) and o:isInTable(o.TeamsData[2], Ligue2Teams) then
      currentdata = Ligue2Info
    elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
      currentdata = BUNDESLIGA1Info
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Bundesliga1TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Bundesliga1TeamsData)
      currentdata.bnd_homelabel_color = homeColorList[1]
      currentdata.bnd_homecrest_color = homeColorList[1]
      currentdata.bnd_homelabel_text_fontcolor = homeColorList[2]
      currentdata.bnd_awaylabel_color = awayColorList[1]
      currentdata.bnd_awaycrest_color = awayColorList[1]
      currentdata.bnd_awaylabel_text_fontcolor = awayColorList[2]
    elseif o:isInTable(o.TeamsData[1], Bundesliga2Teams) and o:isInTable(o.TeamsData[2], Bundesliga2Teams) then
      currentdata = BUNDESLIGA2Info
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Bundesliga2TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Bundesliga2TeamsData)
      currentdata.bnd_homelabel_color = homeColorList[1]
      currentdata.bnd_homecrest_color = homeColorList[1]
      currentdata.bnd_homelabel_text_fontcolor = homeColorList[2]
      currentdata.bnd_awaylabel_color = awayColorList[1]
      currentdata.bnd_awaycrest_color = awayColorList[1]
      currentdata.bnd_awaylabel_text_fontcolor = awayColorList[2]
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
      currentdata = SERIEAInfo
    elseif o:isInTable(o.TeamsData[1], SerieBTeams) and o:isInTable(o.TeamsData[2], SerieBTeams) then
      currentdata = SERIEBInfo
    elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
      currentdata = LALIGAInfo
      local ClockAndTime = os.date("%H : %M") 
      local Day = os.date("%a") 
      local Date  = os.date("%d") 
      local Month  = os.date("%B")   
      currentdata.bnd_match_jam = ClockAndTime
      currentdata.bnd_match_hari = Day
      currentdata.bnd_match_tanggal = Date
      currentdata.bnd_match_bulan = Month   
    elseif o:isInTable(o.TeamsData[1], LaligaHypermotionTeams) and o:isInTable(o.TeamsData[2], LaligaHypermotionTeams) then
      currentdata = LaligaHypermotionInfo
    elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
      currentdata = BRILiga1Info
    elseif o:isInTable(o.TeamsData[1], ChampionshipLiga2Teams) and o:isInTable(o.TeamsData[2], ChampionshipLiga2Teams) then
      currentdata = ChampionshipLiga2Info
    else
      currentdata = EAFCInfo
    end
  end

  currentdata.bnd_stadium_text = o.currentOptions.stadium
  currentdata.bnd_homecrest_image.id = o.TeamsData[1].assetId
  currentdata.bnd_awaycrest_image.id = o.TeamsData[2].assetId
  currentdata.bnd_homelabel_text = o.TeamsData[1].teamName
  currentdata.bnd_awaylabel_text = o.TeamsData[2].teamName
  currentdata.bnd_homelabel_short = o.services.GameSetupService.GetTeamShortName(HOMETEAM)
  currentdata.bnd_awaylabel_short = o.services.GameSetupService.GetTeamShortName(AWAYTEAM)
  
  if o.currentOptions.stadium == "Signal Iduna Park" then
    currentdata.bnd_stadium_icon.id = 30
  end

  weatherType = {
     name = "$Weather",
     id = 0
  }
  random = currentMatchWeather
  if currentMatchWeather == 1 then
    random = math.random(2, 8)
  end

  o.im.Subscribe(bndRainVisible, function()
    if random == 6 then
      o.im.Publish(bndRainVisible, true)
    else 
      o.im.Publish(bndRainVisible, false)
    end
  end
  )
  o.im.Subscribe(bndSnowVisible, function()
    if random == 8 then
      o.im.Publish(bndSnowVisible, true)
    else 
      o.im.Publish(bndSnowVisible, false)
    end
  end
  )
  o.im.Subscribe(bndWeather, function()
    if random == 3 then
      -- Nuansa Sunset 
       weatherType.id = 1
      o.im.Publish(bndWeather, weatherType)
    elseif random == 4 then
       -- Mendung Tanpo Udan
       weatherType.id = 2
    o.im.Publish(bndWeather, weatherType)
       
    elseif random == 5 or random == 6 then
       -- Berkabut Tebal
       weatherType.id = 4
       o.im.Publish(bndWeather, weatherType)
       
    elseif random == 7 or random == 8 then
       -- Salju / Biru+VibeUCL
       weatherType.id = 3
      o.im.Publish(bndWeather, weatherType)
    else
      -- Cerah Polosan
       weatherType.id = 0
       o.im.Publish(bndWeather, weatherType)
    end
    o.im.Publish(bndWeather, weatherType)
  end
  )

  o.im.Subscribe(BND_REALTIME, function()
    local currentTime = os.date("December %d")
    local state = currentTime
    o.im.Publish(BND_REALTIME, state)
  end
  )
  
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

      if currentMatch.HomeKitIndex == 0 then

        result[1] = v.homeColor
        result[2] = v.homeFontColor

      elseif currentMatch.HomeKitIndex == 1 then

        result[1] = v.awayColor
        result[2] = v.awayFontColor

      elseif currentMatch.HomeKitIndex == 3 then

        if v.thirdColor ~= nil then
          result[1] = v.thirdColor
          result[2] = v.thirdFontColor or v.awayFontColor
        else
          result[1] = v.awayColor
          result[2] = v.awayFontColor
        end

      end

      break
    end
  end

  return result
end

function MatchInfo:getTeamAwayColor(teamid, tbl)
  local result = {}

  for k,v in pairs(tbl) do
    if v.teamid == teamid then

      if currentMatch.AwayKitIndex == 0 then

        result[1] = v.homeColor
        result[2] = v.homeFontColor

      elseif currentMatch.AwayKitIndex == 1 then

        result[1] = v.awayColor
        result[2] = v.awayFontColor

      elseif currentMatch.AwayKitIndex == 3 then

        if v.thirdColor ~= nil then
          result[1] = v.thirdColor
          result[2] = v.thirdFontColor or v.awayFontColor
        else
          result[1] = v.awayColor
          result[2] = v.awayFontColor
        end

      end

      break
    end
  end

  return result
end

function MatchInfo:finalize()
  print("[MatchInfo]: finalize()")
  self.im.Unsubscribe("bnd_active")
  self.im.Unsubscribe(bndRainVisible)
  self.im.Unsubscribe(bndSnowVisible)
  self.im.Unsubscribe(bndWeather)
  self.im.Unsubscribe(BND_REALTIME)
  for k,v in pairs(EAFCInfo) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end

return MatchInfo