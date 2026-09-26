print("GameEvents.lua")
local GameEvents = {}
local OverlaysIdContainer, OverlayParam, eventmanager = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes
local BND_VISIBLE = "bnd_visible"

local leagueIDs = {
  PremierLeague = 13,
  Ligue1 = 16,
  Bundesliga1 = 19,
  Bundesliga2 = 20,
  SerieA = 31,
  SerieB = 32,
  Laliga = 53,
  BRILiga1 = 2235,
  ChampionshipLiga2 = 2254
}

GlobalMatchResult = nil


bndList = {
  "bnd_homename_text", "bnd_homecrest", "bnd_awayname_text", "bnd_awaycrest",
  "bnd_score_text", "bnd_homeScore_text", "bnd_awayScore_text",
  "bnd_homemessage_text", "bnd_awaymessage_text", "bnd_title_text"
}


PREMIERLEAGUEInfo = {
  bnd_fontFace = "$Epl", 
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background = {
    name = "$GameEvent1",
    id = 0
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
    name = "$GameEvent1",
    id = 13
  },
  bnd_score_bg_visible = true,
 
  bnd_scorebgwidth = 210,
  bnd_scorebgheight = 103,  
  
  bnd_score_bg1_height = 0,
  bnd_score_bg1_width = 0,
  bnd_score_bg1_top = -5,
  bnd_score_bg1_left = 0,
  bnd_score_bg1_color_visible = false,
  bnd_score_bg1_color = "",
  bnd_score_bg1 = {
    name = "$GameEvent",
    id = 13
  },
  bnd_score_bg1_visible = true,
 
  bnd_scorebg1width = 210,
  bnd_scorebg1height = 103,  

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
EASPORTSInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Eredivisie", 
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 130,
  bnd_background_width = 800,
  bnd_background = {
    name = "$GameEvent",
    id = "CupID14"
  },
  bnd_background_bottom = 0,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 25,
  bnd_name_text_top = -28,
  bnd_score_text_top = -28,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -48,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 15,
  bnd_event_fontColor = "0x080838",
  bnd_homename_alignH = "CENTER",
  bnd_homename_text_fontColor = "0xDFFF00",
  bnd_homename_height = 0,
  bnd_homename_width = 300,
  bnd_homename_color = "0x044C7C",
  bnd_homename_left = 0,
  bnd_homename_text_left = 22,
  bnd_awayname_text_right = 22,
  bnd_awayname_text = "",
  bnd_awayname_text_fontColor = "0xDFFF00",
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
  bnd_score_right = -44,
  bnd_score_left = -41,
  bnd_score_color = "0x080838",
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
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,
  bnd_awaycrest_top = -60,
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
  bnd_homemessage_top = -62,
  bnd_homemessage_left = -140,
  bnd_homemessage_color = "0x117BDD",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 0,
  bnd_message_fontColor = "0x197FC5",
  bnd_awaymessage_right = 240,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -62,
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
    name = "$LeagueLogo1",
    id = "0_ea_dark"
  },
  bnd_logowidth = 60,
  bnd_logoheight = 55,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = 6,
  bnd_title_left = 58,
  bnd_title_text = "",
  bnd_title_color = "0x117BDD",
  bnd_title_fontColor = "0x080838",
  bnd_title_fontSize = 20,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
LALIGAInfo = {
  bnd_fontFace = "$LaLiga", 
  bnd_background_show = true,
  bnd_background_height = 160,
  bnd_background_width = 1024,
  bnd_background = { name = "$GameEvent", id = 53 },
  
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
  bnd_homecrest = { name = "$Crest_LaLiga", id = 0 },
  
  bnd_homecrest_height = 55,
  bnd_homecrest_width = 55,

  bnd_awaycrest_top = -90,
  bnd_awaycrest_right = 130,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = { name = "$Crest_LaLiga", id = 0 },
  
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
BUNDESLIGA1Info = {
  bnd_fontFace = "$Bundesliga",
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background = {
    name = "$Event",
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
    name = "$LeagueLogo1",
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

BUNDESLIGA2Info = {
  bnd_fontFace = "$Bundesliga",
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background = {
    name = "$Event",
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
    name = "$LeagueLogo1",
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

LIGUE1Info = {
  bnd_fontFace = "$Ligue1",
  bnd_background_show = true,
  bnd_background_height = 115,
  bnd_background_width = 850,
  bnd_background = { name = "$GameEvent", id = 16 },
  
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
SERIEAInfo = {
  bnd_fontFace = "$Seria_Bold",
  bnd_background_show = true,
  bnd_background_height = 120,
  bnd_background_width = 760,
  bnd_background = {
    name = "$GameEvent",
    id = 31
  },
  bnd_background_bottom = -12,
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
  bnd_homecrest_top = -62,
  bnd_homecrest_left = 210,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 50,
  bnd_homecrest_width = 50,
  bnd_awaycrest_top = -62,
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


  bnd_message_height = 25,
  bnd_message_width = 290,
  bnd_homemessage_top = 57,
  bnd_homemessage_left = -205,
  bnd_homemessage_color = "0x03215D",
  bnd_homemessage_text = "",
  bnd_homemessage_text_top = -7,
  bnd_message_fontSize = 14,
  bnd_message_fontColor = "0xffffff",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 57,
  bnd_awaymessage_left = 190,
  bnd_awaymessage_color = "0x03215D",
  bnd_awaymessage_text = "",
  bnd_awaymessage_text_top = -7,

  
  bnd_logo_height = 0,
  bnd_logo_width = 0,
  bnd_logo_top = -130,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x04259A",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_eafc"
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
  bnd_title_height = 0,
  bnd_title_width = 0,
  bnd_title_top = 58,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x04259A",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 12,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}
SERIEBInfo = {
  bnd_fontFace = "$UniversNextProBold",
  bnd_background_show = true,
  bnd_background_height = 120,
  bnd_background_width = 760,
  bnd_background = {
    name = "$GameEvent",
    id = 32
  },
  bnd_background_bottom = -14,
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
  bnd_event_top = -55,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 25,
  bnd_event_fontColor = "0x0B8D33",
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
  bnd_score_color = "0x0B8D33",
  bnd_crest_height = 80,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = 215,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 50,
  bnd_homecrest_width = 50,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = 200,
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
  bnd_homemessage_top = 55,
  bnd_homemessage_left = -190,
  bnd_homemessage_color = "0x0B8D33",
  bnd_homemessage_text = "",
  bnd_message_fontSize = 14,
  bnd_message_fontColor = "0xffffff",
  bnd_message_text_width = 255,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = 55,
  bnd_awaymessage_left = 190,
  bnd_awaymessage_color = "0x0B8D33",
  bnd_awaymessage_text = "",

  
  bnd_logo_height = 0,
  bnd_logo_width = 0,
  bnd_logo_top = -130,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x04259A",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_eafc"
  },
  bnd_logowidth = 95,
  bnd_logoheight = 95,
  
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

EAFCInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Extended-Heavy", 
  bnd_forceCaps = true,   
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 800,
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
  bnd_score_fontSize = 25,
  bnd_name_text_top = -10,
  bnd_score_text_top = -10,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -54,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 18,
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
  bnd_score_right = -65,
  bnd_score_left = -60,
  bnd_score_color = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -68,
  bnd_homecrest_left = -30,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 40,
  bnd_homecrest_width = 40,
  bnd_awaycrest_top = -68,
  bnd_awaycrest_right = -30,
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
  bnd_homemessage_top = -41,
  bnd_homemessage_left = -145,
  bnd_homemessage_color = "0x117BDD",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 0,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -41,
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
    name = "$LeagueLogo",
    id = "0_ea_dark"
  },
  bnd_logowidth = 60,
  bnd_logoheight = 55,
  
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -80,
  bnd_title_left = 3,
  bnd_title_text = "",
  bnd_title_color = "0x117BDD",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 16,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false
}

BRILiga1Info = {
  bnd_forceCaps = true, 
  bnd_fontFace = "$Liga1", 
  bnd_background_height = 150,
  bnd_background_width = 1200,
  bnd_background = {
    name = "$GameEvent1",
    id = 2235
  },
  bnd_background_bottom = 11,
  bnd_color_alpha = 0,
  bnd_home_rect_left = 0,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = 0,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 60,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 55,
  bnd_event_width = 800,
  bnd_event_top = -50,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
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
  bnd_score_right = -75,
  bnd_score_left = -75,
  bnd_score_color = "",
  bnd_crest_color_visible = false,
  bnd_crest_height = 55,
  bnd_crest_width = 55,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg_height = 0,
  bnd_score_bg_width = 0,
  bnd_score_bg_top = 7,
  bnd_score_bg_left = 0,
  bnd_score_bg_color_visible = false,
  bnd_score_bg_color = "",
  bnd_score_bg = {
    name = "$GameEvent",
    id = 2235
  },
  bnd_score_bg_visible = true,
 
  bnd_scorebgwidth = 1200,
  bnd_scorebgheight = 150,  
  
  bnd_score_bg1_height = 0,
  bnd_score_bg1_width = 0,
  bnd_score_bg1_top = -5,
  bnd_score_bg1_left = 0,
  bnd_score_bg1_color_visible = false,
  bnd_score_bg1_color = "",
  bnd_score_bg1 = {
    name = "$LeagueLogo",
    id = "2235_1"
  },
  bnd_score_bg1_visible = true,
 
  bnd_scorebg1width = 50,
  bnd_scorebg1height = 50,  
  
  bnd_logo_height = 0,
  bnd_logo_width = 0,
  bnd_logo_top = -135,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2235_2"
  },
  bnd_logo_visible = true,
 
  bnd_logowidth = 240,
  bnd_logoheight = 140,  

  bnd_message_height = 0,
  bnd_message_width = 370,
  bnd_homemessage_top = -38,
  bnd_homemessage_left = -230,
  bnd_homemessage_color = "0xE9E9E7",
  bnd_homemessage_text = "",
  bnd_homemessage_text_left = 40,
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0x000000",
  bnd_message_text_width = 300,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = -38,
  bnd_awaymessage_left = 230,
  bnd_awaymessage_color = "0xE9E9E7",
  bnd_awaymessage_text = "",
  bnd_awaymessage_text_right = 350,
 
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -38.5,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0xE9E9E7",
  bnd_title_fontColor = "0xffffff",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false  
}
ChampionshipLiga2Info = {
  bnd_forceCaps = true, 
  bnd_fontFace = "$Liga1", 
  bnd_background_height = 150,
  bnd_background_width = 1200,
  bnd_background = {
    name = "$GameEvent1",
    id = 2235
  },
  bnd_background_bottom = 11,
  bnd_color_alpha = 0,
  bnd_home_rect_left = 0,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = 0,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 60,
  bnd_name_text_top = 0,
  bnd_score_text_top = 0,

  bnd_event_height = 55,
  bnd_event_width = 800,
  bnd_event_top = -50,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 20,
  bnd_event_fontColor = "0x09533A",
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
  bnd_score_right = -59,
  bnd_score_left = -59,
  bnd_score_color = "",
  bnd_crest_color_visible = false,
  bnd_crest_height = 55,
  bnd_crest_width = 55,
  bnd_homecrest_top = -60,
  bnd_homecrest_left = -95,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -60,
  bnd_awaycrest_right = -95,
  bnd_awaycrest_color = "0xffffff",
  bnd_awaycrest = {
    name = "$Crest",
    id = 0
  },
  bnd_awaycrest_height = 60,
  bnd_awaycrest_width = 60,

  bnd_score_bg_height = 0,
  bnd_score_bg_width = 0,
  bnd_score_bg_top = 7,
  bnd_score_bg_left = 0,
  bnd_score_bg_color_visible = false,
  bnd_score_bg_color = "",
  bnd_score_bg = {
    name = "$GameEvent",
    id = 2254
  },
  bnd_score_bg_visible = true,
 
  bnd_scorebgwidth = 1200,
  bnd_scorebgheight = 150,  
  
  bnd_score_bg1_height = 0,
  bnd_score_bg1_width = 0,
  bnd_score_bg1_top = 0,
  bnd_score_bg1_left = 0,
  bnd_score_bg1_color_visible = false,
  bnd_score_bg1_color = "",
  bnd_score_bg1 = {
    name = "$LeagueLogo",
    id = 2254
  },
  bnd_score_bg1_visible = true,
 
  bnd_scorebg1width = 53,
  bnd_scorebg1height = 53,  
  
  bnd_logo_height = 0,
  bnd_logo_width = 0,
  bnd_logo_top = -135,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2254_1"
  },
  bnd_logo_visible = true,
 
  bnd_logowidth = 240,
  bnd_logoheight = 120,  

  bnd_message_height = 0,
  bnd_message_width = 370,
  bnd_homemessage_top = -37,
  bnd_homemessage_left = -200,
  bnd_homemessage_color = "0xE9E9E7",
  bnd_homemessage_text = "",
  bnd_homemessage_text_left = 40,
  bnd_message_fontSize = 13,
  bnd_message_fontColor = "0xAEDE26",
  bnd_message_text_width = 250,
  bnd_awaymessage_right = 260,
  bnd_awaymessage_top = -37,
  bnd_awaymessage_left = 285,
  bnd_awaymessage_color = "0xE9E9E7",
  bnd_awaymessage_text = "",
  bnd_awaymessage_text_right = 350,
 
  bnd_title_height = 0,
  bnd_title_width = 100,
  bnd_title_top = -38,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "",
  bnd_title_fontColor = "0x09533A",
  bnd_title_fontSize = 13,
  bnd_homemessage_visible = false,
  bnd_awaymessage_visible = false  
}

--GameEventsTournaments --

UCLInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$UCL-Regular",  
  bnd_background_show = true,
  bnd_background_height = 120,
  bnd_background_width = 884,
  bnd_background = {
    name = "$GameEvent",
    id = 2236
  },
  bnd_background_bottom = 20,
  
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 32,
  bnd_name_text_top = -23,
  bnd_score_text_top = -23,

  bnd_event_height = 50,
  bnd_event_width = 800,
  bnd_event_top = -45,
  bnd_event_left = 0,
  bnd_event_alpha = 0,
  bnd_homename_text = "",
  bnd_event_fontSize = 27,
  bnd_event_fontColor = "0xffffff",
  -- team name 
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
  -- score 
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
  -- crest
  bnd_homecrest_top = -70,
  bnd_homecrest_left = -130,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 80,
  bnd_homecrest_width = 80,
  
  bnd_awaycrest_top = -70,
  bnd_awaycrest_right = -130,
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
  
  -- 
  bnd_message_height = 0,
  bnd_message_width = 400,
  bnd_homemessage_top = -60,
  bnd_homemessage_left = -160,
  bnd_homemessage_color = "0x041750",
  bnd_homemessage_color_alpha = 1,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 18,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 240,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -60,
  bnd_awaymessage_left = 160,
  bnd_awaymessage_color = "0x041750",
  bnd_awaymessage_color_alpha = 1,
  bnd_awaymessage_text = "",
  
  bnd_logo_height = 100,
  bnd_logo_width = 100,
  bnd_logo_top = -10,
  bnd_logo_left = 0,
  bnd_logo_color_visible = false,
  bnd_logo_color = "0x38003d",
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2236_3"
  },
  bnd_logowidth = 140,
  bnd_logoheight = 140,
  
  bnd_title_height = 30,
  bnd_title_width = 100,
  bnd_title_top = -60,
  bnd_title_left = 0,
  bnd_title_text = "",
  bnd_title_color = "0x153454",
  bnd_title_fontColor = "0x57e8e0",
  bnd_title_fontSize = 18,
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
    id = "CupID27"
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
    name = "$LeagueLogo1",
    id = "0_ea_dark"
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
  bnd_homemessage_top = -62,
  bnd_homemessage_left = -140,
  bnd_homemessage_color = "0x117BDD",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 0,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 240,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -62,
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
    name = "$LeagueLogo1",
    id = "0_ea_dark"
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
AclTwoInfo = {
  bnd_forceCaps = true, 
  bnd_fontFace = "$DINPro-CondBoldIta", 
  bnd_background_show = true,
  bnd_background_height = 90,
  bnd_background_width = 700,
  bnd_background = {
    name = "$GameEvent",
    id = "CupID4"
  },
  bnd_background_bottom = 20,
  bnd_color_alpha = 0,
  bnd_home_rect_left = -50,
  bnd_home_rect_top = 20,
  bnd_away_rect_left = -50,
  bnd_away_rect_top = 20,
  bnd_homename_text_right = 0,
  bnd_awayname_text_left = 0,
  bnd_score_fontSize = 20,
  bnd_name_text_top = -5,
  bnd_score_text_top = -5,

  bnd_event_height = 0,
  bnd_event_width = 800,
  bnd_event_top = -54,
  bnd_event_left = 0,
  bnd_event_alpha = 1,
  bnd_homename_text = "",
  bnd_event_fontSize = 18,
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
  bnd_score_text = "",
  bnd_score_visible = true,
  bnd_homeScore_text = "",
  bnd_awayScore_text = "",
  bnd_score_height = 0,
  bnd_score_width = 200,
  bnd_score_right = -45,
  bnd_score_left = -40,
  bnd_score_color = "0xffffff",
  bnd_crest_height = 0,
  bnd_crest_width = 80,
  bnd_crest_color_visible = false,
  bnd_homecrest_top = -68,
  bnd_homecrest_left = -50,
  bnd_homecrest_color = "0xffffff",
  bnd_homecrest = {
    name = "$Crest",
    id = 0
  },
  bnd_homecrest_height = 60,
  bnd_homecrest_width = 60,
  bnd_awaycrest_top = -68,
  bnd_awaycrest_right = -50,
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
  bnd_homemessage_top = -41,
  bnd_homemessage_left = -145,
  bnd_homemessage_color = "0x117BDD",
  bnd_homemessage_color_alpha = 0.5,
  bnd_homemessage_text = "",
  bnd_message_fontSize = 16,
  bnd_message_fontColor = "0xffffff",
  bnd_awaymessage_right = 250,
  bnd_message_text_width = 250,
  bnd_awaymessage_top = -41,
  bnd_awaymessage_left = 145,
  bnd_awaymessage_color = "0x117BDD",
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
  bnd_title_top = -41,
  bnd_title_left = 3,
  bnd_title_text = "",
  bnd_title_color = "0x117BDD",
  bnd_title_fontColor = "0x000000",
  bnd_title_fontSize = 16,
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

function GameEvents:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = {
        EventManagerService = o.api("EventManagerService"),
        MatchInfoService = o.api("MatchInfoService"),
        SquadManagementService = o.api("SquadMgtService"),
        TeamService = o.api("TeamService")
    }
    local HOMETEAM = 0
    local AWAYTEAM = 1

    o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
    o.currentdata = EAFCInfo

    if not o.TeamsData or not o.TeamsData[1] or not o.TeamsData[2] then
        print("❌ [GameEvents] KRITIS: Gagal mendapatkan data tim.")
    else
        homeTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(HOMETEAM, o.TeamsData[1].assetId, 0)
        awayTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(AWAYTEAM, o.TeamsData[2].assetId, 0)
        o.handlerId = o.services.EventManagerService.RegisterHandler(function(...) o:handleEvent(...) end)
        
        local gameMode = "FRIENDLY"
        if currentCupData and currentCupData.cupIndex and currentCupData.cupIndex > 0 then
            gameMode = "CUP"
        elseif currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
            gameMode = "TOUR"
        end

if gameMode == "CUP" then
    local cupIndex = currentCupData.cupIndex
    print("🔧 [GameEvents] Mode Cup Terdeteksi! Index: " .. cupIndex)

    if cupIndex == 1 then
        o.currentdata = UCLInfo
        elseif cupIndex == 14 then
        o.currentdata = EASPORTSInfo
           elseif cupIndex == 26 then
        o.currentdata = AfrikaCupInfo
         elseif cupIndex == 27 then
        o.currentdata = AseanChampionshipInfo
    elseif cupIndex >= 2 and cupIndex <= 34 then
        o.currentdata = EAFCInfo
    else
        o.currentdata = EAFCInfo
    end

elseif gameMode == "TOUR" then
    local tourId = currentTourData.tourIndex
    print("🔧 [GameEvents] Mode Tour Terdeteksi! ID: " .. tourId)

    if tourId == 1 then
        o.currentdata = UCLInfo
    elseif tourId == 35 then
        o.currentdata = UCLInfo
    elseif tourId == 26 then
        o.currentdata = AfrikaCupInfo
    elseif tourId == 2 then
        o.currentdata = WC26Info
    elseif tourId == 27 then
        o.currentdata = AseanChampionshipInfo
    elseif tourId == 14 then
        o.currentdata = EASPORTSInfo
    elseif tourId == 31 then
        o.currentdata = AclTwoInfo
    else
        o.currentdata = EAFCInfo
    end
            
        else
  print("🔧 [GameEvents] Mode Laga Persahabatan terdeteksi.")
  local PremierLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.PremierLeague, 0, 0, true)
  local Ligue1Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue1, 0, 0, true)
  local Bundesliga1Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga1, 0, 0, true)
  local Bundesliga2Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga2, 0, 0, true)
  local SerieATeams = o.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local SerieBTeams = o.services.TeamService.GetTeams(leagueIDs.SerieB, 0, 0, true)
  local LaligaTeams = o.services.TeamService.GetTeams(leagueIDs.Laliga, 0, 0, true)
  local BRILiga1Teams = o.services.TeamService.GetTeams(leagueIDs.BRILiga1, 0, 0, true)
  local ChampionshipLiga2Teams = o.services.TeamService.GetTeams(leagueIDs.ChampionshipLiga2, 0, 0, true)
            
				
    if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
      o.currentdata = PREMIERLEAGUEInfo
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, PremierLeagueTeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, PremierLeagueTeamsData)
      o.currentdata.bnd_homename_color = homeColorList[1]
      o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
      o.currentdata.bnd_homecrest_color = homeColorList[1]
      o.currentdata.bnd_awayname_color = awayColorList[1]
      o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]
      o.currentdata.bnd_awaycrest_color = awayColorList[1]
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      o.currentdata = LIGUE1Info
    elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
      o.currentdata = BUNDESLIGA1Info
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Bundesliga1TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Bundesliga1TeamsData)
      o.currentdata.bnd_homename_color = homeColorList[1]
      o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
      o.currentdata.bnd_homecrest_color = homeColorList[1]
      o.currentdata.bnd_awayname_color = awayColorList[1]
      o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]
      o.currentdata.bnd_awaycrest_color = awayColorList[1]
    elseif o:isInTable(o.TeamsData[1], Bundesliga2Teams) and o:isInTable(o.TeamsData[2], Bundesliga2Teams) then
      o.currentdata = BUNDESLIGA2Info
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, Bundesliga2TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, Bundesliga2TeamsData)
      o.currentdata.bnd_homename_color = homeColorList[1]
      o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
      o.currentdata.bnd_homecrest_color = homeColorList[1]
      o.currentdata.bnd_awayname_color = awayColorList[1]
      o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]
      o.currentdata.bnd_awaycrest_color = awayColorList[1]
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
      o.currentdata = SERIEAInfo
    elseif o:isInTable(o.TeamsData[1], SerieBTeams) and o:isInTable(o.TeamsData[2], SerieBTeams) then
      o.currentdata = SERIEBInfo
    elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
      o.currentdata = LALIGAInfo
    elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
      o.currentdata = BRILiga1Info
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, BRILiga1TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, BRILiga1TeamsData)
      o.currentdata.bnd_homename_color = homeColorList[1]
      o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
      o.currentdata.bnd_homeScore_text_fontColor = homeColorList[2]
      o.currentdata.bnd_awayname_color = awayColorList[1]
      o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]    
      o.currentdata.bnd_awayScore_text_fontColor = awayColorList[2]
    elseif o:isInTable(o.TeamsData[1], ChampionshipLiga2Teams) and o:isInTable(o.TeamsData[2], ChampionshipLiga2Teams) then
      o.currentdata = ChampionshipLiga2Info
      local homeColorList = o:getTeamHomeColor(o.TeamsData[1].assetId, ChampionshipLiga2TeamsData)
      local awayColorList = o:getTeamAwayColor(o.TeamsData[2].assetId, ChampionshipLiga2TeamsData)
      o.currentdata.bnd_homename_color = homeColorList[1]    
      o.currentdata.bnd_homename_text_fontColor = homeColorList[2]
      o.currentdata.bnd_awayname_color = awayColorList[1]      
      o.currentdata.bnd_awayname_text_fontColor = awayColorList[2]    
    else
      o.currentdata = EAFCInfo
            end
        end
    end

    o.im.Subscribe(BND_VISIBLE, function()
     o.im.Publish(BND_VISIBLE, false)
  end
  )
  --o.im.Subscribe(BND_GAME_EVENT_INFO, function()
  --  end
  -- )

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
  if eventType == EventTypes.OverlayTypeMatchEvents then
    self:updateGameEvents(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function GameEvents:updateGameEvents(subtype, hideshow, subtypestr, msg)
  print("updateGameEvents " .. msg)
  if hideshow ~= "HIDE" then
    local params = OverlayParam.split(msg, "|")
    if params and table.getn(params) > 0 then
    --  self.im.Publish(BND_NATIONALIZATION, self.nationalization)
      self.im.Publish(BND_VISIBLE, true)
      local index = 12
      self.arrEvents = {}
      local homeMsg = ""
      local awayMsg = ""
      local lng = (#params - 11) / 4
      do
        do
          for _FORV_11_ = 1, lng do
            self.arrEvents[_FORV_11_] = {}
            self.arrEvents[_FORV_11_].side = params[index]
            index = index + 1
            self.arrEvents[_FORV_11_].icon = params[index]
            index = index + 1
            self.arrEvents[_FORV_11_].label = params[index]
            index = index + 1
            self.arrEvents[_FORV_11_].teamAbbr = params[index]
            index = index + 1
            local label = self.arrEvents[_FORV_11_].label
            -- local isOg = string.find(label, "乌龙")
            -- if self.arrEvents[_FORV_11_].icon + 0 == 0 then 
            --   label = label .. "(受伤)"
            -- elseif self.arrEvents[_FORV_11_].icon + 0 == 1 then
            --   label = label .. "(黄牌)"
            -- elseif self.arrEvents[_FORV_11_].icon + 0 == 2 then
            --   label = label .. "(红牌)"
            -- end
            if self.arrEvents[_FORV_11_].icon + 0 > 2 then
              if self.arrEvents[_FORV_11_].side == "0" then
                homeMsg = homeMsg .. " " .. label
              else
                awayMsg = awayMsg .. " " .. label
              end
            end
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
      
      if params[5]+0 == 0 then
        if self:isInTable(self.TeamsData[1], PremierLeagueTeams) and self:isInTable(self.TeamsData[2], PremierLeagueTeams) then
           self.currentdata.bnd_homemessage_visible = true
        elseif self:isInTable(self.TeamsData[1], InternationalTeams) and self:isInTable(self.TeamsData[2], InternationalTeams) then
           self.currentdata.bnd_homemessage_visible = true
        else
           self.currentdata.bnd_homemessage_visible = false
        end
      else
        self.currentdata.bnd_homemessage_visible = true
      end
      if params[6]+0 == 0 then
         if self:isInTable(self.TeamsData[1], PremierLeagueTeams) and self:isInTable(self.TeamsData[2], PremierLeagueTeams) then
           self.currentdata.bnd_awaymessage_visible = true
        elseif self:isInTable(self.TeamsData[1], InternationalTeams) and self:isInTable(self.TeamsData[2], InternationalTeams) then
          self.currentdata.bnd_awaymessage_visible = true
        else
           self.currentdata.bnd_awaymessage_visible = false
        end
        
      else
        self.currentdata.bnd_awaymessage_visible = true
      end
      
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
    --  self.currentdata.bnd_score_text = self.score
      self.currentdata.bnd_title_text = gameevents.message
      
      self.currentdata.bnd_homemessage_text = homeMsg
      self.currentdata.bnd_awaymessage_text = awayMsg
      -- self.im.Publish(BND_GAME_EVENT_INFO, gameevents)
      
    end
  else
    self.im.Publish(BND_VISIBLE, false)
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

      if currentMatch.HomeKitIndex == 0 then

        result[1] = v.homeColor
        result[2] = v.homeFontColor
        result[3] = v.homeShortsColor or v.homeColor

      elseif currentMatch.HomeKitIndex == 1 then

        result[1] = v.awayColor
        result[2] = v.awayFontColor
        result[3] = v.awayShortsColor or v.awayColor

      elseif currentMatch.HomeKitIndex == 3 then

        if v.thirdColor ~= nil then
          result[1] = v.thirdColor
          result[2] = v.thirdFontColor or v.awayFontColor
          result[3] = v.thirdShortsColor or v.thirdColor
        else
          result[1] = v.awayColor
          result[2] = v.awayFontColor
          result[3] = v.awayShortsColor or v.awayColor
        end

      end

      break
    end
  end

  return result
end

function GameEvents:getTeamAwayColor(teamid, tbl)
  local result = {}

  for k,v in pairs(tbl) do
    if v.teamid == teamid then

      if currentMatch.AwayKitIndex == 0 then

        result[1] = v.homeColor
        result[2] = v.homeFontColor
        result[3] = v.homeShortsColor or v.homeColor

      elseif currentMatch.AwayKitIndex == 1 then

        result[1] = v.awayColor
        result[2] = v.awayFontColor
        result[3] = v.awayShortsColor or v.awayColor

      elseif currentMatch.AwayKitIndex == 3 then

        if v.thirdColor ~= nil then
          result[1] = v.thirdColor
          result[2] = v.thirdFontColor or v.awayFontColor
          result[3] = v.thirdShortsColor or v.thirdColor
        else
          result[1] = v.awayColor
          result[2] = v.awayFontColor
          result[3] = v.awayShortsColor or v.awayColor
        end

      end

      break
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
  for k,v in pairs(EAFCInfo) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
end

return GameEvents