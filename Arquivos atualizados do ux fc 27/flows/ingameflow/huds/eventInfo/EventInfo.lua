
-- New Custom EventInfo By MVNPROD --

local EventInfo = {}
local OverlaysIdContainer, OverlayParam, eventmanager = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

local BND_VISIBLE = "bnd_visible"
local BND_NATIONALIZATION = "bnd_nationalization"
local BND_DATA = "bnd_data"
local BND_ALPHA = "bnd_alpha"
local beforeHomeScore = 0
local beforeAwayScore = 0
local nowHomeScore = 0
local nowAwayScore = 0

local goalStatistics = {}
--local isinitialized = 0
local initialized = false

local leagueIDs = {
  
  PremierLeague = 13,
  
  Ligue1 = 16,
  Bundesliga1 = 19,
  SerieA = 31,
  Laliga = 53,
  
  BRILiga1 = 2235,
  
  ChampionshipLiga2 = 2254,
  UCL = 2236
}

EAFCInfo = { -- 350x70
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansExpanded", 
  bnd_forceCaps = true,
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 80,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 0     
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 300,
  bnd_background_height = 250,  
  bnd_background_top = -50,
  bnd_background_left = 20,   
  -- Avatar
  bnd_bg_avatar_color_alpha = 0,
  bnd_bg_avatar_color = "0x00E675",
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_width = 120,
  bnd_goal_player_avatar_height = 120,
  bnd_goal_player_avatar_top = -30,
  bnd_goal_player_avatar_bottom = 20,
  bnd_goal_player_avatar_left = 80,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 30,
  bnd_team_crest_height = 30,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -136,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 4,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0x000000",
  bnd_goal_player_name_fontSize = 10,
  bnd_goal_player_name_alignV = "BOTTOM",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = 0,
  bnd_goal_player_name_bottom = 15,
  bnd_goal_player_name_left = 72,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0x000000",
  bnd_goal_player_level_fontSize = 0,
  bnd_goal_player_level_alignV = "CENTER",
  bnd_goal_player_level_alignH = "CENTER",
  bnd_goal_player_level_top = -90,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 0,
  bnd_goal_player_level_right = -20,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0x000000",
  bnd_goal_player_count_fontSize = 13,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "CENTER",
  bnd_goal_player_count_top = -20,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 0,
  bnd_goal_player_count_right = -20,
  -- shoot
  bnd_goal_player_desc_fontColor = "0x000000",
  bnd_goal_player_desc_fontSize = 11,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = 0,
  bnd_goal_player_desc_bottom = 70,
  bnd_goal_player_desc_left = 190,
  bnd_goal_player_desc_right = -65,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0x000000",
  bnd_goal_type_fontSize = 13,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = 0,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 190,
  bnd_goal_type_right = -30,
  
  bnd_goal_time_fontColor = "0x39003E",
  bnd_goal_time_fontSize = 13,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "CENTER",
  bnd_goal_time_top = -90,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 0,
  bnd_goal_time_right = -20,
  -- TeamName
  bnd_goal_team_name_fontColor = "0xFF4942",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0
}


EASPORTSInfo = { -- 350x70
  bnd_fontFace = "$Epl",
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = "CupID14"    
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 320,
  bnd_background_height = 320,  
  bnd_background_top = -25,
  bnd_background_left = 20,   
  -- Avatar
  bnd_bg_avatar_color_alpha = 0,
  bnd_bg_avatar_color = "0x00E675",
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_width = 80,
  bnd_goal_player_avatar_height = 80,
  bnd_goal_player_avatar_top = 20,
  bnd_goal_player_avatar_bottom = 45,
  bnd_goal_player_avatar_left = 257,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 75,
  bnd_team_crest_height = 75,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -25,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 30,
  bnd_team_crest_right = 0,
  -- Crest1
  bnd_bg_crest1_color = "",
  bnd_bg_crest1_color_alpha = 0,
  bnd_team1_crest_width = 27,
  bnd_team1_crest_height = 27,
  bnd_team1_crest_alignV = "CENTER",
  bnd_team1_crest_alignH = "LEFT",
  bnd_team1_crest_top = -70,
  bnd_team1_crest_bottom = 0,
  bnd_team1_crest_left = 1000000000000000000000,
  bnd_team1_crest_right = 0,  
  -- TeamName
  bnd_goal_team_name_fontColor = "0xc82727",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "BOTTOM",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = 0,
  bnd_goal_team_name_bottom = 100,
  bnd_goal_team_name_left = 160,
  bnd_goal_team_name_right = 0,    
  -- Name
  bnd_goal_player_name_fontColor = "0xDFFF00",
  bnd_goal_player_name_fontSize = 20,
  bnd_goal_player_name_alignV = "BOTTOM",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = 10,
  bnd_goal_player_name_bottom = 35,
  bnd_goal_player_name_left = 130,
  bnd_goal_player_name_right = 0,
  -- Level
  bnd_goal_player_level_fontColor = "0xffffff",
  bnd_goal_player_level_fontSize = 0,
  bnd_goal_player_level_alignV = "CENTER",
  bnd_goal_player_level_alignH = "CENTER",
  bnd_goal_player_level_top = -100,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 0,
  bnd_goal_player_level_right = 100,
  -- Count
  bnd_goal_player_count_fontColor = "0x080838",
  bnd_goal_player_count_fontSize = 14,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = -43,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 230,
  bnd_goal_player_count_right = 0,
  -- PlayerDesc
  bnd_goal_player_desc_fontColor = "0x080838",
  bnd_goal_player_desc_fontSize = 13,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -65,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 120,
  bnd_goal_player_desc_right = 0,
  -- Type
  bnd_goal_type_fontColor = "0x080838",
  bnd_goal_type_fontSize = 12,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = -43,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 120,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontFace = "$Epl",
  bnd_goal_time_fontColor = "0x080838",
  bnd_goal_time_fontSize = 14,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -65,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 230,
  bnd_goal_time_right = 0
}

PremierLeagueInfo = { -- 350x70
  bnd_fontFace = "$Epl",
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 13     
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 270,
  bnd_background_height = 130,  
  bnd_background_top = -15,
  bnd_background_left = 20,   
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0xffffff",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 0.1,
  bnd_bg1_color_height = 0.1,
  bnd_bg1_color_left = 130,
  bnd_bg1_color_top = 17,
  bnd_cornerRaduis = 8,
  bnd_bg2_color = "0x39003E",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 0.1,
  bnd_bg2_color_height = 0.1,
  bnd_bg2_color_left = 30,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color_alpha = 0,
  bnd_bg_avatar_color = "0x00E675",
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_width = 60,
  bnd_goal_player_avatar_height = 60,
  bnd_goal_player_avatar_top = -30,
  bnd_goal_player_avatar_bottom = 20,
  bnd_goal_player_avatar_left = 210,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x04F377",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 70,
  bnd_team_crest_height = 70,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = 20,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 0,
  bnd_team_crest_right = 0,
  bnd_team_crest_image = {
    name = "$Crest",
    id = 0
  },
  -- Name
  bnd_goal_player_name_fontColor = "0xf5f5f5",
  bnd_goal_player_name_fontSize = 16,
  bnd_goal_player_name_alignV = "BOTTOM",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = 0,
  bnd_goal_player_name_bottom = 6,
  bnd_goal_player_name_left = 75,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0x151515",
  bnd_goal_player_level_fontSize = 0,
  bnd_goal_player_level_alignV = "TOP",
  bnd_goal_player_level_alignH = "CENTER",
  bnd_goal_player_level_top = 0,
  bnd_goal_player_level_bottom = 10,
  bnd_goal_player_level_left = 0,
  bnd_goal_player_level_right = -20,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0x39003E",
  bnd_goal_player_count_fontSize = 14,
  bnd_goal_player_count_alignV = "TOP",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = 0,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 190,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0x39003E",
  bnd_goal_player_desc_fontSize = 12,
  bnd_goal_player_desc_alignV = "TOP",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -25,
  bnd_goal_player_desc_bottom = 40,
  bnd_goal_player_desc_left = 100,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0x39003E",
  bnd_goal_type_fontSize = 13,
  bnd_goal_type_alignV = "TOP",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = 0,
  bnd_goal_type_bottom = 20,
  bnd_goal_type_left = 100,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0x151515",
  bnd_goal_time_fontSize = 13,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -50,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 190,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0xFF4942",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0
}

LALIGAInfo = { -- 350x70
  bnd_fontFace = "$LaLiga",
  
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 80,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 53     
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 270,
  bnd_background_height = 250,  
  bnd_background_top = -50,
  bnd_background_left = 20,   
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0xffffff",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 120,
  bnd_bg1_color_height = 1,
  bnd_bg1_color_left = 1,
  bnd_bg1_color_top = 0,
  
  bnd_bg2_color = "0x39003E",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 1,
  bnd_bg2_color_height = 1,
  bnd_bg2_color_left = 0,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color = "0x000000",
  bnd_bg_avatar_color_alpha = 0,
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_top = -40,
  bnd_goal_player_avatar_bottom = 0,
  bnd_goal_player_avatar_left = 35,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x000000",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 30,
  bnd_team_crest_height = 30,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -80,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 5,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0x000000",
  bnd_goal_player_name_fontSize = 15,
  bnd_goal_player_name_alignV = "CENTER",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = -65,
  bnd_goal_player_name_bottom = 0,
  bnd_goal_player_name_left = 125,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0xFF4942",
  bnd_goal_player_level_fontSize = 50,
  bnd_goal_player_level_alignV = "TOP",
  bnd_goal_player_level_alignH = "LEFT",
  bnd_goal_player_level_top = -15,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 125,
  bnd_goal_player_level_right = 0,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0x000000",
  bnd_goal_player_count_fontSize = 15,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = -35,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 230,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0xFF4942",
  bnd_goal_player_desc_fontSize = 13,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -80,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 230,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0xFF4942",
  bnd_goal_type_fontSize = 13,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = -50,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 230,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0x000000",
  bnd_goal_time_fontSize = 15,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -65,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 230,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0xFF4942",
  bnd_goal_team_name_fontSize = 10,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0,
}

BUNDESLIGAInfo = { -- 350x70
  bnd_fontFace = "$Bundesliga",
  
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 80,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 19     
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 430,
  bnd_background_height = 140,  
  bnd_background_top = 0,
  bnd_background_left = -160,   
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0xffffff",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 120,
  bnd_bg1_color_height = 1,
  bnd_bg1_color_left = 1,
  bnd_bg1_color_top = 0,
  
  bnd_bg2_color = "0x39003E",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 1,
  bnd_bg2_color_height = 1,
  bnd_bg2_color_left = 0,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color = "0x000000",
  bnd_bg_avatar_color_alpha = 0,
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_top = -47,
  bnd_goal_player_avatar_bottom = 0,
  bnd_goal_player_avatar_left = 149,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x000000",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 23,
  bnd_team_crest_height = 23,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = 0,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 5,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0xBABDB9",
  bnd_goal_player_name_fontSize = 15,
  bnd_goal_player_name_alignV = "CENTER",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = 0,
  bnd_goal_player_name_bottom = 0,
  bnd_goal_player_name_left = 70,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0xFF4942",
  bnd_goal_player_level_fontSize = 0,
  bnd_goal_player_level_alignV = "TOP",
  bnd_goal_player_level_alignH = "LEFT",
  bnd_goal_player_level_top = -15,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 125,
  bnd_goal_player_level_right = 0,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0xBABDB9",
  bnd_goal_player_count_fontSize = 15,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = -27,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 125,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0xBABDB9",
  bnd_goal_player_desc_fontSize = 13,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -55,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 20,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0xBABDB9",
  bnd_goal_type_fontSize = 13,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = -27,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 20,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0xBABDB9",
  bnd_goal_time_fontSize = 15,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -55,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 125,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0xFF4942",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0,
}

LIGUE1Info = { -- 350x70
  bnd_fontFace = "$Ligue1",
  
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 80,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 16     
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 430,
  bnd_background_height = 140,  
  bnd_background_top = 0,
  bnd_background_left = -160,   
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0xffffff",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 120,
  bnd_bg1_color_height = 1,
  bnd_bg1_color_left = 1,
  bnd_bg1_color_top = 0,
  
  bnd_bg2_color = "0x39003E",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 1,
  bnd_bg2_color_height = 1,
  bnd_bg2_color_left = 0,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color = "0x000000",
  bnd_bg_avatar_color_alpha = 0,
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_top = -63,
  bnd_goal_player_avatar_bottom = 0,
  bnd_goal_player_avatar_left = 40,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x000000",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 35,
  bnd_team_crest_height = 35,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = 0,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 5,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0xB3B8BB",
  bnd_goal_player_name_fontSize = 15,
  bnd_goal_player_name_alignV = "CENTER",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = -40,
  bnd_goal_player_name_bottom = 0,
  bnd_goal_player_name_left = 100,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0xB3B8BB",
  bnd_goal_player_level_fontSize = 30,
  bnd_goal_player_level_alignV = "CENTER",
  bnd_goal_player_level_alignH = "LEFT",
  bnd_goal_player_level_top = -40,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 10,
  bnd_goal_player_level_right = 0,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0xB3B8BB",
  bnd_goal_player_count_fontSize = 15,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = 10,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 175,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0xB3B8BB",
  bnd_goal_player_desc_fontSize = 13,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -10,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 70,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0xB3B8BB",
  bnd_goal_type_fontSize = 13,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = 10,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 70,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0xB3B8BB",
  bnd_goal_time_fontSize = 15,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -10,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 175,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0xFF4942",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0,
}

SERIEAInfo = { -- 350x70
  bnd_fontFace = "$SerieA",
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 75,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 31     
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 430,
  bnd_background_height = 140,  
  bnd_background_top = -50,
  bnd_background_left = -120,   
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0x02215D",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 200,
  bnd_bg1_color_height = 50,
  bnd_bg1_color_left = 50,
  bnd_bg1_color_top = 20,
  
  bnd_bg2_color = "0xffffff",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 0.1,
  bnd_bg2_color_height = 0.1,
  bnd_bg2_color_left = 0,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color = "0x085EFF",
  bnd_bg_avatar_color_alpha = 0,
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_top = -50,
  bnd_goal_player_avatar_bottom = 0,
  bnd_goal_player_avatar_left = 70,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x085EFF",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 20,
  bnd_team_crest_height = 20,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -95,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 35,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0xFFFFFF",
  bnd_goal_player_name_fontSize = 15,
  bnd_goal_player_name_alignV = "CENTER",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = 2,
  bnd_goal_player_name_bottom = 0,
  bnd_goal_player_name_left = 60,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0x04D4D4",
  bnd_goal_player_level_fontSize = 30,
  bnd_goal_player_level_alignV = "CENTER",
  bnd_goal_player_level_alignH = "LEFT",
  bnd_goal_player_level_top = -25,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 60,
  bnd_goal_player_level_right = 0,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0x142141",
  bnd_goal_player_count_fontSize = 22,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = -40,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 155,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0x142141",
  bnd_goal_player_desc_fontSize = 18,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -70,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 155,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0x142141",
  bnd_goal_type_fontSize = 18,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = -20,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 155,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0x142141",
  bnd_goal_time_fontSize = 22,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -90,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 155,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0xFF4942",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0
}

UCLInfo = { -- 350x70
  bnd_fontFace = "$Font_Ucl",
  
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 80,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 2236    
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 470,
  bnd_background_height = 70,  
  bnd_background_top = 0,
  bnd_background_left = 400,   
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0xffffff",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 120,
  bnd_bg1_color_height = 1,
  bnd_bg1_color_left = 1,
  bnd_bg1_color_top = 0,
  
  bnd_bg2_color = "0x39003E",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 1,
  bnd_bg2_color_height = 1,
  bnd_bg2_color_left = 0,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color = "0x000000",
  bnd_bg_avatar_color_alpha = 0,
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_top = -10,
  bnd_goal_player_avatar_bottom = 0,
  bnd_goal_player_avatar_left = 790,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x000000",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 65,
  bnd_team_crest_height = 65,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -6,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 370,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0xFFFFFF",
  bnd_goal_player_name_fontSize = 20,
  bnd_goal_player_name_alignV = "20",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = 9,
  bnd_goal_player_name_bottom = 0,
  bnd_goal_player_name_left = 570,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0xFFFFFF",
  bnd_goal_player_level_fontSize = 20,
  bnd_goal_player_level_alignV = "TOP",
  bnd_goal_player_level_alignH = "LEFT",
  bnd_goal_player_level_top = 9,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 530,
  bnd_goal_player_level_right = 0,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0xFFFFFF",
  bnd_goal_player_count_fontSize = 20,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = 19,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 695,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0xFFFFFF",
  bnd_goal_player_desc_fontSize = 20,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = 19,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 510,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0xFFFFFF",
  bnd_goal_type_fontSize = 20,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = 19,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 630,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0xFFFFFF",
  bnd_goal_time_fontSize = 20,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = 19,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 580,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0xFF4942",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0,
}

BRILiga1Info = { -- 350x70
  bnd_fontFace = "$Liga1",
  
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 80,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 2235   
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 270,
  bnd_background_height = 250,  
  bnd_background_top = -50,
  bnd_background_left = 20,   
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0xffffff",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 120,
  bnd_bg1_color_height = 1,
  bnd_bg1_color_left = 1,
  bnd_bg1_color_top = 0,
  
  bnd_bg2_color = "0x39003E",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 1,
  bnd_bg2_color_height = 1,
  bnd_bg2_color_left = 0,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color = "0x000000",
  bnd_bg_avatar_color_alpha = 0,
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_top = -40,
  bnd_goal_player_avatar_bottom = 0,
  bnd_goal_player_avatar_left = 35,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x000000",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 28,
  bnd_team_crest_height = 28,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -13,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 207,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0x292C7B",
  bnd_goal_player_name_fontSize = 12,
  bnd_goal_player_name_alignV = "CENTER",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = -65,
  bnd_goal_player_name_bottom = 0,
  bnd_goal_player_name_left = 125,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0x292C7B",
  bnd_goal_player_level_fontSize = 50,
  bnd_goal_player_level_alignV = "TOP",
  bnd_goal_player_level_alignH = "LEFT",
  bnd_goal_player_level_top = -25,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 125,
  bnd_goal_player_level_right = 0,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0x292C7B",
  bnd_goal_player_count_fontSize = 15,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = -35,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 230,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0x292C7B",
  bnd_goal_player_desc_fontSize = 13,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -80,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 230,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0x292C7B",
  bnd_goal_type_fontSize = 13,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = -50,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 230,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0x292C7B",
  bnd_goal_time_fontSize = 15,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -65,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 230,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0x292C7B",
  bnd_goal_team_name_fontSize = 10,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0,
}
AfrikaCupInfo = { -- 350x70
  bnd_fontFace = "$Epl",
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = "CupID26"
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 320,
  bnd_background_height = 320,  
  bnd_background_top = -25,
  bnd_background_left = 20,   
  -- Avatar
  bnd_bg_avatar_color_alpha = 0,
  bnd_bg_avatar_color = "0x00E675",
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_width = 80,
  bnd_goal_player_avatar_height = 80,
  bnd_goal_player_avatar_top = 20,
  bnd_goal_player_avatar_bottom = 45,
  bnd_goal_player_avatar_left = 257,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 75,
  bnd_team_crest_height = 75,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -25,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 30,
  bnd_team_crest_right = 0,
  -- Crest1
  bnd_bg_crest1_color = "",
  bnd_bg_crest1_color_alpha = 0,
  bnd_team1_crest_width = 27,
  bnd_team1_crest_height = 27,
  bnd_team1_crest_alignV = "CENTER",
  bnd_team1_crest_alignH = "LEFT",
  bnd_team1_crest_top = -70,
  bnd_team1_crest_bottom = 0,
  bnd_team1_crest_left = 1000000000000000000000,
  bnd_team1_crest_right = 0,  
  -- TeamName
  bnd_goal_team_name_fontColor = "0xc82727",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "BOTTOM",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = 0,
  bnd_goal_team_name_bottom = 100,
  bnd_goal_team_name_left = 160,
  bnd_goal_team_name_right = 0,    
  -- Name
  bnd_goal_player_name_fontColor = "0x860000",
  bnd_goal_player_name_fontSize = 20,
  bnd_goal_player_name_alignV = "BOTTOM",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = 10,
  bnd_goal_player_name_bottom = 35,
  bnd_goal_player_name_left = 130,
  bnd_goal_player_name_right = 0,
  -- Level
  bnd_goal_player_level_fontColor = "0x860000",
  bnd_goal_player_level_fontSize = 0,
  bnd_goal_player_level_alignV = "CENTER",
  bnd_goal_player_level_alignH = "CENTER",
  bnd_goal_player_level_top = -100,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 0,
  bnd_goal_player_level_right = 100,
  -- Count
  bnd_goal_player_count_fontColor = "0x860000",
  bnd_goal_player_count_fontSize = 14,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = -43,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 230,
  bnd_goal_player_count_right = 0,
  -- PlayerDesc
  bnd_goal_player_desc_fontColor = "0x860000",
  bnd_goal_player_desc_fontSize = 13,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -65,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 120,
  bnd_goal_player_desc_right = 0,
  -- Type
  bnd_goal_type_fontColor = "0x860000",
  bnd_goal_type_fontSize = 12,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = -43,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 120,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontFace = "$Epl",
  bnd_goal_time_fontColor = "0x860000",
  bnd_goal_time_fontSize = 14,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -65,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 230,
  bnd_goal_time_right = 0
}
AseanChampionshipInfo = { -- 350x70
  bnd_fontFace = "$Epl",
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = "CupID27"    
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 320,
  bnd_background_height = 320,  
  bnd_background_top = -25,
  bnd_background_left = 20,   
  -- Avatar
  bnd_bg_avatar_color_alpha = 0,
  bnd_bg_avatar_color = "0x00E675",
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_width = 80,
  bnd_goal_player_avatar_height = 80,
  bnd_goal_player_avatar_top = 20,
  bnd_goal_player_avatar_bottom = 45,
  bnd_goal_player_avatar_left = 257,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 75,
  bnd_team_crest_height = 75,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -25,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 30,
  bnd_team_crest_right = 0,
  -- Crest1
  bnd_bg_crest1_color = "",
  bnd_bg_crest1_color_alpha = 0,
  bnd_team1_crest_width = 27,
  bnd_team1_crest_height = 27,
  bnd_team1_crest_alignV = "CENTER",
  bnd_team1_crest_alignH = "LEFT",
  bnd_team1_crest_top = -70,
  bnd_team1_crest_bottom = 0,
  bnd_team1_crest_left = 1000000000000000000000,
  bnd_team1_crest_right = 0,  
  -- TeamName
  bnd_goal_team_name_fontColor = "0xc82727",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "BOTTOM",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = 0,
  bnd_goal_team_name_bottom = 100,
  bnd_goal_team_name_left = 160,
  bnd_goal_team_name_right = 0,    
  -- Name
  bnd_goal_player_name_fontColor = "0xffffff",
  bnd_goal_player_name_fontSize = 20,
  bnd_goal_player_name_alignV = "BOTTOM",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = 10,
  bnd_goal_player_name_bottom = 35,
  bnd_goal_player_name_left = 130,
  bnd_goal_player_name_right = 0,
  -- Level
  bnd_goal_player_level_fontColor = "0xffffff",
  bnd_goal_player_level_fontSize = 0,
  bnd_goal_player_level_alignV = "CENTER",
  bnd_goal_player_level_alignH = "CENTER",
  bnd_goal_player_level_top = -100,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 0,
  bnd_goal_player_level_right = 100,
  -- Count
  bnd_goal_player_count_fontColor = "0xffffff",
  bnd_goal_player_count_fontSize = 14,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = -43,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 230,
  bnd_goal_player_count_right = 0,
  -- PlayerDesc
  bnd_goal_player_desc_fontColor = "0xffffff",
  bnd_goal_player_desc_fontSize = 13,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -65,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 120,
  bnd_goal_player_desc_right = 0,
  -- Type
  bnd_goal_type_fontColor = "0xffffff",
  bnd_goal_type_fontSize = 12,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = -43,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 120,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontFace = "$Epl",
  bnd_goal_time_fontColor = "0xffffff",
  bnd_goal_time_fontSize = 14,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -65,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 230,
  bnd_goal_time_right = 0
}
ChampionshipLiga2Info = { -- 350x70
  bnd_fontFace = "$Liga1",
  
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 80,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = 2254 
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 270,
  bnd_background_height = 250,  
  bnd_background_top = -50,
  bnd_background_left = 20,   
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0xffffff",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 120,
  bnd_bg1_color_height = 1,
  bnd_bg1_color_left = 1,
  bnd_bg1_color_top = 0,
  
  bnd_bg2_color = "0x39003E",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 1,
  bnd_bg2_color_height = 1,
  bnd_bg2_color_left = 0,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color = "0x000000",
  bnd_bg_avatar_color_alpha = 0,
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_top = -40,
  bnd_goal_player_avatar_bottom = 0,
  bnd_goal_player_avatar_left = 35,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x000000",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 30,
  bnd_team_crest_height = 30,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -80,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 5,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0x06554A",
  bnd_goal_player_name_fontSize = 12,
  bnd_goal_player_name_alignV = "CENTER",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = -65,
  bnd_goal_player_name_bottom = 0,
  bnd_goal_player_name_left = 125,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0x06554A",
  bnd_goal_player_level_fontSize = 50,
  bnd_goal_player_level_alignV = "TOP",
  bnd_goal_player_level_alignH = "LEFT",
  bnd_goal_player_level_top = -25,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 125,
  bnd_goal_player_level_right = 0,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0x06554A",
  bnd_goal_player_count_fontSize = 15,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = -35,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 230,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0x06554A",
  bnd_goal_player_desc_fontSize = 13,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = -80,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 230,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0x06554A",
  bnd_goal_type_fontSize = 13,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = -50,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 230,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0x06554A",
  bnd_goal_time_fontSize = 15,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = -65,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 230,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0x06554A",
  bnd_goal_team_name_fontSize = 10,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0,
}

WC26Info = { -- 350x70
  bnd_fontFace = "$WC26",
  
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 80,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_background = {
    name = "$BackroundGoal",  
    id = "CupID2"
 },
  bnd_background_alignV = "CENTER",
  bnd_background_alignH = "LEFT",
  bnd_background_width = 430,
  bnd_background_height = 140,  
  bnd_background_top = 0,
  bnd_background_left = 400,   
  -- Posisi
  bnd_eventinfo_alignV = "BOTTOM",
  bnd_eventinfo_alignH = "LEFT",
  bnd_eventinfo_bottom = 65,
  bnd_eventinfo_left = 80,
  -- Background
  bnd_bg1_color_alpha = 0,
  bnd_bg1_color = "0xffffff",
  bnd_bg1_color_alignH = "LEFT",
  bnd_bg1_color_width = 120,
  bnd_bg1_color_height = 1,
  bnd_bg1_color_left = 1,
  bnd_bg1_color_top = 0,
  
  bnd_bg2_color = "0x39003E",
  bnd_bg2_color_alignH = "LEFT",
  bnd_bg2_color_width = 1,
  bnd_bg2_color_height = 1,
  bnd_bg2_color_left = 0,
  bnd_bg2_color_bottom = 0,
  -- Avatar
  bnd_bg_avatar_color = "0x000000",
  bnd_bg_avatar_color_alpha = 0,
  bnd_goal_player_avatar_alignV = "CENTER",
  bnd_goal_player_avatar_alignH = "LEFT",
  bnd_goal_player_avatar_top = -10,
  bnd_goal_player_avatar_bottom = 0,
  bnd_goal_player_avatar_left = 740,
  bnd_goal_player_avatar_right = 0,
  -- Crest
  bnd_bg_crest_color = "0x000000",
  bnd_bg_crest_color_alpha = 0,
  bnd_team_crest_width = 65,
  bnd_team_crest_height = 65,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_top = -6,
  bnd_team_crest_bottom = 0,
  bnd_team_crest_left = 420,
  bnd_team_crest_right = 0,
  -- Name
  bnd_goal_player_name_fontColor = "0xFFFFFF",
  bnd_goal_player_name_fontSize = 25,
  bnd_goal_player_name_alignV = "CENTER",
  bnd_goal_player_name_alignH = "LEFT",
  bnd_goal_player_name_top = -21,
  bnd_goal_player_name_bottom = 0,
  bnd_goal_player_name_left = 570,
  bnd_goal_player_name_right = 0,
  -- nopung
  bnd_goal_player_level_fontColor = "0xFFFFFF",
  bnd_goal_player_level_fontSize = 25,
  bnd_goal_player_level_alignV = "CENTER",
  bnd_goal_player_level_alignH = "LEFT",
  bnd_goal_player_level_top = -21,
  bnd_goal_player_level_bottom = 0,
  bnd_goal_player_level_left = 530,
  bnd_goal_player_level_right = 0,
  -- jumal goal
  bnd_goal_player_count_fontColor = "0xFFFFFF",
  bnd_goal_player_count_fontSize = 25,
  bnd_goal_player_count_alignV = "CENTER",
  bnd_goal_player_count_alignH = "LEFT",
  bnd_goal_player_count_top = 10,
  bnd_goal_player_count_bottom = 0,
  bnd_goal_player_count_left = 695,
  bnd_goal_player_count_right = 0,
  -- shoot
  bnd_goal_player_desc_fontColor = "0xFFFFFF",
  bnd_goal_player_desc_fontSize = 25,
  bnd_goal_player_desc_alignV = "CENTER",
  bnd_goal_player_desc_alignH = "LEFT",
  bnd_goal_player_desc_top = 10,
  bnd_goal_player_desc_bottom = 0,
  bnd_goal_player_desc_left = 510,
  bnd_goal_player_desc_right = 0,
  -- Goall/INJURY YELLOW & RED CARD 
  bnd_goal_type_fontColor = "0xFFFFFF",
  bnd_goal_type_fontSize = 25,
  bnd_goal_type_alignV = "CENTER",
  bnd_goal_type_alignH = "LEFT",
  bnd_goal_type_top = 10,
  bnd_goal_type_bottom = 0,
  bnd_goal_type_left = 630,
  bnd_goal_type_right = 0,
  -- Time
  bnd_goal_time_fontColor = "0xFFFFFF",
  bnd_goal_time_fontSize = 25,
  bnd_goal_time_alignV = "CENTER",
  bnd_goal_time_alignH = "LEFT",
  bnd_goal_time_top = 10,
  bnd_goal_time_bottom = 0,
  bnd_goal_time_left = 580,
  bnd_goal_time_right = 0,
  -- TeamName
  bnd_goal_team_name_fontColor = "0xFF4942",
  bnd_goal_team_name_fontSize = 0,
  bnd_goal_team_name_alignV = "CENTER",
  bnd_goal_team_name_alignH = "LEFT",
  bnd_goal_team_name_top = -80,
  bnd_goal_team_name_bottom = 0,
  bnd_goal_team_name_left = 125,
  bnd_goal_team_name_right = 0,
}

function EventInfo:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.nationalization = 2
  o.services = {
    EventManagerService = o.api("EventManagerService"),
    SquadManagementService = o.api("SquadMgtService"),
    MatchInfoService = o.api("MatchInfoService"),
    TeamService = o.api("TeamService")
  }
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
  o:handleEvent(...)
  end)
  
  homeTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(HOMETEAM, o.TeamsData[1].assetId, 0)
  awayTeamlineupData = o.services.SquadManagementService.GetCurrentPlayerLineup(AWAYTEAM, o.TeamsData[2].assetId, 0)
  
  local PremierLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.PremierLeague, 0, 0, true)
  local Ligue1Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue1, 0, 0, true)
  local Bundesliga1Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga1, 0, 0, true)
  local SerieATeams = o.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local LaligaTeams = o.services.TeamService.GetTeams(leagueIDs.Laliga, 0, 0, true)
  local BRILiga1Teams = o.services.TeamService.GetTeams(leagueIDs.BRILiga1, 0, 0, true)
  
  local ChampionshipLiga2 = o.services.TeamService.GetTeams(leagueIDs.ChampionshipLiga2, 0, 0, true)
  local UCLTeams = o.services.TeamService.GetTeams(leagueIDs.UCL, 0, 0, true)

  local HOMETEAM = 0
  local AWAYTEAM = 1
  o.currentdata = nil
  
if currentCupData and currentCupData.cupIndex and currentCupData.cupIndex > 0 then
  -- CUP
  if currentCupData.cupIndex == 1 then
    o.currentdata = UCLInfo
      elseif currentCupData.cupIndex == 26 then
    o.currentdata = AfrikaCupInfo
      elseif currentCupData.cupIndex == 27 then
    o.currentdata = AseanChampionshipInfo
     elseif currentCupData.cupIndex == 14 then
    o.currentdata = EASPORTSInfo

    elseif currentCupData.cupIndex >= 2 and currentCupData.cupIndex <= 34 then
    o.currentdata = EAFCInfo
     
  elseif currentCupData.cupIndex == 40 then
    o.currentdata = LALIGAInfo
  elseif currentCupData.cupIndex == 41 then
    o.currentdata = UCLInfo
  elseif currentCupData.cupIndex == 42 then
    o.currentdata = PREMIERLEAGUEInfo
  elseif currentCupData.cupIndex == 43 then
    o.currentdata = LIGUE1Info
  else
    o.currentdata = EAFCInfo
  end

elseif currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
  -- TOUR
  if currentTourData.tourIndex == 1 then
    o.currentdata = UCLInfo
    elseif currentTourData.tourIndex == 35 then
    o.currentdata = UCLInfo
    elseif currentTourData.tourIndex == 26 then
    o.currentdata = AfrikaCupInfo
    elseif currentTourData.tourIndex == 27 then
    o.currentdata = AseanChampionshipInfo
    elseif currentTourData.tourIndex == 14 then
    o.currentdata = EASPORTSInfo
        
    elseif currentTourData.tourIndex >= 2 and currentTourData.tourIndex <= 34 then
    o.currentdata = WC26Info
  elseif currentTourData.tourIndex == 40 then
    o.currentdata = LALIGAInfo
  elseif currentTourData.tourIndex == 41 then
    o.currentdata = UCLInfo
  elseif currentTourData.tourIndex == 42 then
    o.currentdata = PREMIERLEAGUEInfo
  elseif currentTourData.tourIndex == 43 then
    o.currentdata = LIGUE1Info
  else
    o.currentdata = EAFCInfo
  end

else
  -- LEAGUE / FRIENDLY
  if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
    o.currentdata = PremierLeagueInfo 
  elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
    o.currentdata = LIGUE1Info
  elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
    o.currentdata = BUNDESLIGAInfo
  elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    o.currentdata = ClassicInfo
  elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
    o.currentdata = SERIEAInfo
  elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
    o.currentdata = LALIGAInfo
  elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
    o.currentdata = BRILiga1Info
    
  elseif o:isInTable(o.TeamsData[1], ChampionshipLiga2Teams) and o:isInTable(o.TeamsData[2], ChampionshipLiga2Teams) then
    o.currentdata = ChampionshipLiga2Info
  elseif o:isInTable(o.TeamsData[1], UCLTeams) and o:isInTable(o.TeamsData[2], UCLTeams) then
    o.currentdata = UCLInfo
  else
    o.currentdata = EAFCInfo
  end
end
  
  o.isinitialized = 0
  
  local facts = o:getMatchFacts()
  nowHomeScore = facts[1].data.value + 0
  nowAwayScore = facts[1].data.valueRight + 0

  teamCrest = {
    name = "$Crest",
    id = 0
  }
  playerAvatar = {
    name = "$Head",
    id = 0
  }
   teamCrest = {
    name = "$Crest",
    id = 0
  }
  
  o.im.Subscribe(BND_NATIONALIZATION, function()
  end)
  o.im.Subscribe(BND_VISIBLE, function()
    o.im.Publish(BND_VISIBLE, false)
  end)
  o.im.Subscribe("bnd_player_visible", function()
    o.im.Publish("bnd_player_visible", false)
  end)
  o.im.Subscribe(BND_ALPHA, function()
  end)
  o.im.Subscribe(BND_DATA, function()
  end)
  o.im.Subscribe("bnd_text", function()
  end)
  o.im.Subscribe("bnd_team_crest", function()
  end)
  o.im.Subscribe("bnd_goal_player_avatar", function()
  end)
  o.im.Subscribe("bnd_goal_player_name", function()
  end)
  o.im.Subscribe("bnd_goal_team_name", function()
  end)
  o.im.Subscribe("bnd_goal_player_level", function()
  end)
  o.im.Subscribe("bnd_goal_player_count", function()
  end)
  o.im.Subscribe("bnd_goal_player_desc", function()
  end)
  o.im.Subscribe("bnd_goal_time", function()
  end)
  o.im.Subscribe("bnd_goal_type", function()
  end)
  o.im.Subscribe("bnd_goal_desc", function()
  end)
  
    for k,v in pairs(o.currentdata) do
    o.im.Subscribe(k, function()
      o.im.Publish(k, v)
    end)
  end
  
  return o
end

function EventInfo:handleEvent(eventType, data)
  if eventType == EventTypes.OverlayTypeIngameCardInjury then
    self:updateEventInfo(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
  if eventType == EventTypes.OverlayTypeGoal then
    self:updateGoalScored(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function EventInfo:updateEventInfo(subtype, hideshow, subtypestr, msg)
  local params = OverlayParam.split(msg, "|")
  if hideshow == "SHOW" then
    if initialized == false then
      self.im.Publish(BND_NATIONALIZATION, self.nationalization)
      initialized = true
    end
    if params and table.getn(params) > 0 then
      self.im.Publish(BND_VISIBLE, true)
      local bottomText = ""
      local showBottomText = false
      if #params == 7 then
        bottomText = params[7]
        showBottomText = true
      end
      local eventInfo = {
        team = params[3],
        kitNumber = params[5],
        playerName = params[6],
        teamName = params[2],
        bottomText = bottomText,
        showBottomText = showBottomText,
        iconType = params[4] + 0
      }
      
      local teamName = ""
      if teamside == 0 then
       teamName = params[2] or "HOME"   -- home team full name
      else
        teamName = params[4] or "AWAY"   -- away team full name
     end
     
      teamCrest.id = params[2] + 0
      self.im.Publish("bnd_team_crest", teamCrest)
      playerAvatar.id = params[2] + 0
      self.im.Publish("bnd_goal_team_name", teamName)
      self.im.Publish("bnd_goal_player_avatar", playerAvatar)
      
      local eventdesc = ""
      local eventtype = params[4] + 0
      local playerName = params[6]
      local teamSide = 0

      -- 🟢 Tentukan sisi tim (home / away)
      if tostring(params[3]) == tostring(self.TeamsData[1].name) then
        teamSide = 0
      else
        teamSide = 1
      end

      -- 🟢 Ambil data pemain untuk dapat assetId avatar
      local playerInfo = self:getPlayerInfo(teamSide, params[2] + 0, playerName, false)
            playerAvatar.id = playerInfo.assetId
      self.im.Publish("bnd_goal_player_avatar", playerAvatar)

      -- 🟢 Deskripsi event (injury / card)
     if eventtype == 0 then 
            eventdesc = "Injured"
     elseif eventtype == 1 then
            eventdesc = "Yellow Card"
     elseif eventtype == 2 then
            eventdesc = "Red Card"
     elseif eventtype == 3 then
            eventdesc = "Second Yellow"
     end

      self.im.Publish("bnd_goal_type", eventdesc)
      self.im.Publish("bnd_goal_player_name", playerInfo.playerName)
      self.im.Publish("bnd_goal_team_name", teamName)     
      self.im.Publish(BND_DATA, eventInfo)
    end
  elseif hideshow == "UPDATE" then
    self.im.Publish(BND_ALPHA, params[1] / 100)
  else
    self.im.Publish(BND_VISIBLE, false)
  end
end

function EventInfo:addDaysToDate(dateStr, daysToAdd)
    local d, m, y = dateStr:match("(%d%d)/(%d%d)/(%d%d)")
    local timestamp = os.time({ day = tonumber(d), month = tonumber(m), year = 2000 + tonumber(y) })  
    local newTimestamp = timestamp + (daysToAdd * 86400)  -- Add days in seconds
    local newDate = os.date("%d/%m/%y", newTimestamp)  
    return newDate
end

function EventInfo:updateGoalScored(subtype, hideshow, subtypestr, msg)

    if hideshow ~= "HIDE" then
        
        if initialized == false then
            self.im.Publish(BND_NATIONALIZATION, self.nationalization)
            initialized = true
        end

        local params = OverlayParam.split(msg, "|")
        if not params or #params == 0 then return end

        self.isinitialized = self.isinitialized + 1

        if self.isinitialized == 1 then
            beforeHomeScore = nowHomeScore
            beforeAwayScore = nowAwayScore
        end

        local goalScored = {
            kitNumber = "",
            bottomText = "",
            showBottomText = false,
            iconType = params[13] + 0,
            playerName = params[14],
            team = params[15]
        }

        nowHomeScore = params[5] + 0
        nowAwayScore = params[6] + 0

        local isOg = string.find(goalScored.playerName, "(OG)")
        local isPenalty = string.find(goalScored.playerName, "(Pen)")
        local currentTime = string.gsub(params[7], "%'", " ")

        local teamside = 0

        if nowHomeScore > beforeHomeScore then
            teamCrest.id = params[1] + 0
            teamside = 0
            if isOg then teamCrest.id = params[3] + 0 end
        elseif nowAwayScore > beforeAwayScore then
            teamCrest.id = params[3] + 0
            teamside = 1
            if isOg then teamCrest.id = params[1] + 0 end
        end

        self.im.Publish("bnd_team_crest", teamCrest)
        self.im.Publish("bnd_goal_desc", "Time : ")

        local playerName = goalScored.playerName
        local playerInfo = self:getPlayerInfo(teamside, teamCrest.id, playerName, isOg)
        playerAvatar.id = playerInfo.assetId

        ---------------------------------------------------
        -- 🛠 FIX: Mencegah double count goal
        ---------------------------------------------------
        if not ProcessedGoals then ProcessedGoals = {} end

        local goalKey = tostring(playerInfo.assetId) .. "_" .. tostring(params[7]) .. "_" .. tostring(params[5]) .. "_" .. tostring(params[6])

        if not ProcessedGoals[goalKey] then
            ProcessedGoals[goalKey] = true

            -- TournamentStats
            local tourId = GlobalTournamentSettings and GlobalTournamentSettings.tourId 
                           or (currentTourData and currentTourData.tourIndex)

            if tourId then
                if not TournamentStats[tourId] then
                    TournamentStats[tourId] = { Goals = {} }
                end
                if not TournamentStats[tourId].Goals[playerInfo.assetId] then
                    TournamentStats[tourId].Goals[playerInfo.assetId] = 0
                end

                TournamentStats[tourId].Goals[playerInfo.assetId] =
                    TournamentStats[tourId].Goals[playerInfo.assetId] + 1
            end

            -- Global GOALS
            if not GOALS then GOALS = {} end
            if not GOALS[playerInfo.assetId] then GOALS[playerInfo.assetId] = 0 end
            GOALS[playerInfo.assetId] = GOALS[playerInfo.assetId] + 1
        end
        ---------------------------------------------------

        -- Statistik internal (UI saja)
        if self.isinitialized == 1 then
            if goalStatistics[playerInfo.assetId] then
                goalStatistics[playerInfo.assetId] = goalStatistics[playerInfo.assetId] + 1
            else
                goalStatistics[playerInfo.assetId] = 1
            end
        end

        local goals = goalStatistics[playerInfo.assetId] or 0
local goalDesc = ""

if goals == 1 then
  goalDesc = "SHOOT"
elseif goals == 2 then
  goalDesc = "BRACE"
elseif goals == 3 then
  goalDesc = "HATTRICK"
elseif goals == 4 then
  goalDesc = "QUATTRICK"
elseif goals == 5 then
  goalDesc = "FIVE GOALS"
elseif goals > 5 then
  goalDesc = tostring(goals) .. " GOALS"
end

        local goalType = ""
      if isOg then 
        goalType = "OWN GOAL"
      elseif isPenalty then
        goalType = "PENALTY"
      else
        goalType = "GOALS"
      end

        local teamName = (teamside == 0) and (params[2] or "HOME") or (params[4] or "AWAY")

        self.im.Publish("bnd_goal_player_name", string.gsub(playerInfo.playerName, "%b()", " "))
        self.im.Publish("bnd_goal_team_name", teamName)
        self.im.Publish("bnd_goal_player_avatar", playerAvatar)
        self.im.Publish("bnd_goal_player_level", ""..playerInfo.level)

        if currentTime + 0 > 90 then
            self.im.Publish("bnd_goal_player_desc", " ")
        else
            self.im.Publish("bnd_goal_player_desc", goalDesc)
        end

        if playerShots == nil then playerShots = {} end
        local playerId = tostring(playerInfo.assetId)

        if playerShots[playerId] == nil then playerShots[playerId] = 0 end
        playerShots[playerId] = playerShots[playerId] + 1

        self.im.Publish("bnd_goal_time", currentTime)
        self.im.Publish("bnd_goal_type", goalType)
        self.im.Publish("bnd_goal_player_count", ""..(goalStatistics[playerInfo.assetId] or 1))
        self.im.Publish(BND_VISIBLE, true)

        if playerInfo.assetId == 0 then
            self.im.Publish("bnd_player_visible", false)
        else
            self.im.Publish("bnd_player_visible", true)
        end

        self.im.Publish(BND_DATA, goalScored)

    else
        
        self.im.Publish(BND_VISIBLE, false)
        self.im.Publish("bnd_player_visible", false)

        if self.isinitialized >= 2 then
            self.isinitialized = 0
        end
    end
end

function EventInfo:split(str, delimiter)
  local index = {}
  local oid = {}
  for k = 1,string.len(str) do
    if string.sub(str,k,k) == delimiter then
      table.insert(index,k)
    end
  end

  table.insert(oid,string.sub(str,1,index[1]-1))
    for k=1,#index-1 do
      table.insert(oid,string.sub(str,index[k]+1,index[k+1]-1))
    end
  table.insert(oid,string.sub(str,index[#index]+1,string.len(str)))
  return oid
end

function EventInfo:getPlayerInfo(teamSide, teamID, playername, isOg)
  local count = 0
  local specialString = false
  local playerInfo = {
    assetId = 0,
    level = 0,
    playerName = playername
  }
  local teamlineupData = nil
  if isOg then 
    if teamSide == 0 then
       teamSide = 1
    else
       teamSide = 0
    end
  end
  
  if teamSide == 0 then
    teamlineupData = homeTeamlineupData
  else
    teamlineupData = awayTeamlineupData
  end
  if string.find(playername, "-") or string.find(playername, "%.") then
    specialString = true
    --count = 0
  end
 
  if specialString == false then
    count = 0
    playerInfo.playerName =  string.gsub(playername, "%b()", " ")
    playerInfo.playerName =  string.gsub(playerInfo.playerName, "^%s*(.-)%s*$", "%1")
  end
  
  for _FORV_6_ = 1, table.getn(teamlineupData) do
    if specialString == true then
       if string.find(playername, teamlineupData[_FORV_6_].playerName,1,true) then 
        if count == 0 then
          count = count + 1
          playerInfo.assetId = teamlineupData[_FORV_6_].CARD_ID
          playerInfo.level = teamlineupData[_FORV_6_].jerseyNumber
          playerInfo.playerName = teamlineupData[_FORV_6_].playerName
        end
      end
    else
    if string.find(playerInfo.playerName, teamlineupData[_FORV_6_].playerName,1,true) and playerInfo.playerName == teamlineupData[_FORV_6_].playerName then
      if count == 0 then
       count = count + 1
       playerInfo.assetId = teamlineupData[_FORV_6_].CARD_ID
       playerInfo.level = teamlineupData[_FORV_6_].jerseyNumber
       playerInfo.playerName = teamlineupData[_FORV_6_].playerName
      end
    end
    end
  end
  return playerInfo
end

function EventInfo:k_include(tab, value)
  for k,v in pairs(tab) do
    if k == value then
        return true
    end
  end
  return false
end

function EventInfo:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function EventInfo:getMatchFacts()
  local facts = self.services.MatchInfoService.GetMatchFacts(true)
  local o = facts.homeData
  for i, v in ipairs(o) do
    v.data.valueRight = facts.awayData[i].data.value
  end
  return o
end

function EventInfo:finalize()
  self.im.Unsubscribe(BND_VISIBLE)
  self.im.Unsubscribe(BND_ALPHA)
  self.im.Unsubscribe(BND_DATA)
  self.im.Unsubscribe(BND_NATIONALIZATION)
  self.im.Unsubscribe("bnd_text")
  self.im.Unsubscribe("bnd_team_crest")
  self.im.Unsubscribe("bnd_goal_player_avatar")
  self.im.Unsubscribe("bnd_goal_player_name")
  self.im.Unsubscribe("bnd_goal_team_name")
  self.im.Unsubscribe("bnd_goal_player_level")
  self.im.Unsubscribe("bnd_goal_player_desc")
  self.im.Unsubscribe("bnd_goal_player_count")
  self.im.Unsubscribe("bnd_player_visible")
  self.im.Unsubscribe("bnd_goal_time")
  self.im.Unsubscribe("bnd_goal_type")
  self.im.Unsubscribe("bnd_goal_desc")
  for k,v in pairs(EAFCInfo) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
  
end

return EventInfo

-- Thanks : Ma'ruf Id & Laosiji --
-- And All Modder --
-- EventInfo All League ( @mvnprodreal ) --