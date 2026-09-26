
-- New Custom Playernib By MVNPROD --

local PlayerNIB = {}
local OverlayParam, EventManager, TableUtil = ...
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local STATE_INACTIVE = "HIDE"
local STATE_UPDATE = "UPDATE"
local STATE_ACTIVE = "SHOW"
local SIDE_HOME = 0
local SIDE_AWAY = 1
local BND_ALPHA = "bnd_alpha"
local BND_STAMINA = "bnd_stamina"
local BND_PLAYER_INFO = "bnd_player_info"
local BND_ACTIVE = "bnd_active"
local bndHomeCrest = "bnd_home_team_crest"
local bndAwayCrest = "bnd_away_team_crest"
local bndRainVisible = "bnd_rain_visible"
local bndSnowVisible = "bnd_snow_visible"
local bndWeather = "bnd_weather_type"
local bndNibsOnSideVisible = "bnd_nibs_on_side_visible"
local bndNibsOnCenterVisible = "bnd_nibs_on_center_visible"
local bndNibsOnSingleVisible = "bnd_nibs_on_single_visible"
local bndNibsOffVisible = "bnd_nibs_off_visible"
local ACT_CAMERA_CHANGE = "act_camera_change"

local leagueIDs = {
  PremierLeague = 13,
  ChampionshipEfl = 14,
  LeagueOneEfl = 60,
  WomenSuperLeague = 2216,
  Ligue1 = 16,
  Ligue2 = 17,
  D1Arkema = 2218,
  Bundesliga1 = 19,
  Bundesliga2 = 20,
  BRILiga1 = 2235,
  PegadaianLiga2 = 2254,
  International = 78,
  InternationalWomans = 2136,
  SerieA = 31,
  SerieB = 32,
  Korea = 83,
  Malaysia = 2237,
  LigaMX = 341,
  Morocco = 2250,
  Eredivisie = 10,
  LigaPortugal = 308,
  RestOfWolrd1 = 76,
  RestOfWolrd2 = 77,
  RoshnSaudiLeague = 350,
  Scotland = 50,
  SouthAfrica = 347,
  Laliga = 53,
  LaligaHypermotion = 54,
  LigaF = 2222,
  Thailand = 2252,
  Turkey = 68,
  Uel = 2238,
  Uwcl = 2240,
  MLS = 39,
  Nwsl = 2221,
  Vietnam = 2260,
  AFC = 365,
  Argentina = 353,
  Belgium = 4,
  Brazil = 7,
  Classic = 1245,
  Classic2 = 1246,
  Egypt = 2231
}

EAFC = {
  bnd_crest_bg = "0x39003E",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0x1E1E1E",
  bnd_bg_alpha = 0.2,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0x04F377",
  bnd_stamina_outside_bg = "0x1E1E1E",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0x99B903",
  bnd_home_team_crest = { name = "$Crest64x64", id = 0 },
  bnd_away_team_crest = { name = "$Crest64x64", id = 0 }
}

EAFCSingle = {
  --bnd_crest_bg = "0x39003E",
  --bnd_crestBg_width = 0,
  --bnd_crestBg_height = 0,
  --bnd_crestBg_bottom = 24,
  --bnd_crest_width = 25,
  --bnd_crest_height = 25,
  --bnd_crest_bottom = 26,
  --bnd_bg = "0xFFFFFF",
  --bnd_bg_bottom = -500,
  bnd_stamina_inner_bg = "0x00b2c3",
  bnd_stamina_outside_bg = "0x555555",
  bnd_stamina_width = 300,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 54,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xF4C900",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = { name = "$", id = 0 },
  bnd_away_team_crest = { name = "$", id = 0 }
}

PREMEIERLEAGUENib = {
  bnd_crest_bg = "0xffffff",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0x39003E",
  bnd_bg_alpha = 1,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0xf5f5f5",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xffffff",
  bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = { name = "$Crest64x64", id = 0 },
  bnd_away_team_crest = { name = "$Crest64x64", id = 0 }
}

LALIGANib = {
  bnd_crest_bg = "0x151515",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0xFF4942",
  bnd_bg_alpha = 1,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0xFFFFFF",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xFFFFFF",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = { name = "$Crest_LaLiga", id = 0 },
  bnd_away_team_crest = { name = "$Crest_LaLiga", id = 0 }
}

LaligaHypermotionNib = {
  bnd_crest_bg = "0x151515",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0x04D4D4",
  bnd_bg_alpha = 1,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0xFFFFFF",
  bnd_stamina_outside_bg = "0x000000",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xFFFFFF",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = { name = "$Crest_LaLiga", id = 0 },
  bnd_away_team_crest = { name = "$Crest_LaLiga", id = 0 }
}

LIGAFNib = {
  bnd_crest_bg = "0x241A7A",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 23,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0x2C6ADB",
  bnd_bg_alpha = 1,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0x09BFBA",
  bnd_stamina_outside_bg = "0xFFFFFF",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xFFFFFF",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = { name = "$Crest64x64", id = 0 },
  bnd_away_team_crest = { name = "$Crest64x64", id = 0 }
}

BUNDESLIGA1Nib = {
  bnd_crest_bg = "0x2D2D2D",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0xFFFFFF",
  bnd_bg_alpha = 1,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0xffffff",
  bnd_stamina_outside_bg = "0xc82727",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 200,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xFFFFFF",
  bnd_player_name_color = "0x151515",
  bnd_home_team_crest = { name = "$Crest64x64", id = 0 },
  bnd_away_team_crest = { name = "$Crest64x64", id = 0 }
}

LIGUE1Nib = {
  bnd_crest_bg = "0x085EFF",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0x292B2A",
  bnd_bg_alpha = 1,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0xFFFFFF",
  bnd_stamina_outside_bg = "0x292B2A",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xFFFFFF",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = { name = "$Crest64x64", id = 0 },
  bnd_away_team_crest = { name = "$Crest64x64", id = 0 }
}

ARKEMANib = {
  bnd_crest_bg = "0xFFFFFF",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0x000943",
  bnd_bg_alpha = 1,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0x2AECF4",
  bnd_stamina_outside_bg = "0x1e1e1e",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0x2AECF4",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = { name = "$Crest64x64", id = 0 },
  bnd_away_team_crest = { name = "$Crest64x64", id = 0 }
}

SERIEANib = {
  bnd_crest_bg = "0xFFFFFF",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 26,
  bnd_bg = "0x02215D",
  bnd_bg_alpha = 1,
  bnd_bg_bottom = 23,
  bnd_stamina_inner_bg = "0x04D4D4",
  bnd_stamina_outside_bg = "0x1e1e1e",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0x04D4D4",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = { name = "$Crest64x64", id = 0 },
  bnd_away_team_crest = { name = "$Crest64x64", id = 0 }
}

UCLNib = {
  bnd_crest_bg = "0xFFFFFF",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 23,
  bnd_bg = "0x091C94",
  bnd_bg_bottom = 23,
  bnd_bg_alpha = 1,
  bnd_stamina_inner_bg = "0x001653",
  bnd_stamina_outside_bg = "0x1e1e1e",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0x99D5EB",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = { name = "$Crest64x64", id = 0 },
  bnd_away_team_crest = { name = "$Crest64x64", id = 0 }
}

WC26Nib = {
  bnd_crest_bg = "0xFFFFFF",
  bnd_crestBg_width = 0,
  bnd_crestBg_height = 0,
  bnd_crestBg_bottom = 24,
  bnd_crest_width = 25,
  bnd_crest_height = 25,
  bnd_crest_bottom = 23,
  bnd_bg = "0x1E1E1E",
  bnd_bg_bottom = 23,
  bnd_bg_alpha = 1,
  bnd_stamina_inner_bg = "0x860000",
  bnd_stamina_outside_bg = "0xFFFFFF",
  bnd_stamina_width = 210,
  bnd_stamina_short_width = 0,
  bnd_stamina_bottom = 50.5,
  bnd_player_number = "",
  bnd_player_name = "",
  bnd_player_info_left = -223,
  bnd_player_number_color = "0xF7C849",
  bnd_player_name_color = "0xFFFFFF",
  bnd_home_team_crest = { name = "$Crest", id = 0 },
  bnd_away_team_crest = { name = "$Crest", id = 0 }
}

function PlayerNIB:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
  GameStateService = o.api("GameStateService"),
    matchInfo = o.api("MatchInfoService"),
    userPlate = o.api("UserPlateService"),
    settingsService = o.api("SettingsService"),
    gameSetupService = o.api("GameSetupService"),
    EventManagerService = o.api("EventManagerService"),
    TeamService = o.api("TeamService")
  }
  o.side = o.data and o.data.side or SIDE_HOME
  o.cameraIndex = cameraIndex
  o.currentLeague = nil
  o.TeamsData = o.services.matchInfo.GetMatchTeams()
  
  local PremierLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.PremierLeague, 0, 0, true)
  local ChampionshipEflTeams = o.services.TeamService.GetTeams(leagueIDs.ChampionshipEfl, 0, 0, true)
  local LeagueOneEflTeams = o.services.TeamService.GetTeams(leagueIDs.LeagueOneEfl, 0, 0, true)
  local WomenSuperLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.WomenSuperLeague, 0, 0, true)
  local Ligue1Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue1, 0, 0, true)
  local Ligue2Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue2, 0, 0, true)
  local D1ArkemaTeams = o.services.TeamService.GetTeams(leagueIDs.D1Arkema, 0, 0, true)
  local Bundesliga1Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga1, 0, 0, true)
  local Bundesliga2Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga2, 0, 0, true)
  local BRILiga1Teams = o.services.TeamService.GetTeams(leagueIDs.BRILiga1, 0, 0, true)
  local PegadaianLiga2Teams = o.services.TeamService.GetTeams(leagueIDs.PegadaianLiga2, 0, 0, true)
  local InternationalTeams = o.services.TeamService.GetTeams(leagueIDs.International, 0, 0, true)
  local InternationalWomansTeams = o.services.TeamService.GetTeams(leagueIDs.InternationalWomans, 0, 0, true)
  local SerieATeams = o.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local SerieBTeams = o.services.TeamService.GetTeams(leagueIDs.SerieB, 0, 0, true)
  local KoreaTeams = o.services.TeamService.GetTeams(leagueIDs.Korea, 0, 0, true)
  local MalaysiaTeams = o.services.TeamService.GetTeams(leagueIDs.Malaysia, 0, 0, true)
  local LigaMXTeams = o.services.TeamService.GetTeams(leagueIDs.LigaMX, 0, 0, true)
  local MoroccoTeams = o.services.TeamService.GetTeams(leagueIDs.Morocco, 0, 0, true)
  local EredivisieTeams = o.services.TeamService.GetTeams(leagueIDs.Eredivisie, 0, 0, true)
  local LigaPortugalTeams = o.services.TeamService.GetTeams(leagueIDs.LigaPortugal, 0, 0, true)
  local RestOfWolrd1Teams = o.services.TeamService.GetTeams(leagueIDs.RestOfWolrd1, 0, 0, true)
  local RestOfWolrd2Teams = o.services.TeamService.GetTeams(leagueIDs.RestOfWolrd2, 0, 0, true)
  local RoshnSaudiLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.RoshnSaudiLeague, 0, 0, true)
  local ScotlandTeams = o.services.TeamService.GetTeams(leagueIDs.Scotland, 0, 0, true)
  local SouthAfricaTeams = o.services.TeamService.GetTeams(leagueIDs.SouthAfrica, 0, 0, true)
  local LaligaTeams = o.services.TeamService.GetTeams(leagueIDs.Laliga, 0, 0, true)
  local LaligaHypermotionTeams = o.services.TeamService.GetTeams(leagueIDs.LaligaHypermotion, 0, 0, true)
  local LigaFTeams = o.services.TeamService.GetTeams(leagueIDs.LigaF, 0, 0, true)
  local ThailandTeams = o.services.TeamService.GetTeams(leagueIDs.Thailand, 0, 0, true)
  local TurkeyTeams = o.services.TeamService.GetTeams(leagueIDs.Turkey, 0, 0, true)
  local UelTeams = o.services.TeamService.GetTeams(leagueIDs.Uel, 0, 0, true)
  local UwclTeams = o.services.TeamService.GetTeams(leagueIDs.Uwcl, 0, 0, true)
  local MLSTeams = o.services.TeamService.GetTeams(leagueIDs.MLS, 0, 0, true)
  local NwslTeams = o.services.TeamService.GetTeams(leagueIDs.Nwsl, 0, 0, true)
  local VietnamTeams = o.services.TeamService.GetTeams(leagueIDs.Vietnam, 0, 0, true)
  local AFCTeams = o.services.TeamService.GetTeams(leagueIDs.AFC, 0, 0, true)
  local ArgentinaTeams = o.services.TeamService.GetTeams(leagueIDs.Argentina, 0, 0, true)
  local BelgiumTeams = o.services.TeamService.GetTeams(leagueIDs.Belgium, 0, 0, true)
  local BrazilTeams = o.services.TeamService.GetTeams(leagueIDs.Brazil, 0, 0, true)
  local ClassicTeams = o.services.TeamService.GetTeams(leagueIDs.Classic, 0, 0, true)
  local Classic2Teams = o.services.TeamService.GetTeams(leagueIDs.Classic2, 0, 0, true)
  local EgyptTeams = o.services.TeamService.GetTeams(leagueIDs.Egypt, 0, 0, true)

  if currentTourData and currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      o.currentLeague = UCLNib
    elseif currentTourData.tourIndex == 35 then
      o.currentLeague = UCLNib 
    elseif currentTourData.tourIndex == 2 then
      o.currentLeague = WC26Nib 
    else
      o.currentLeague = EAFC
    end

  elseif currentCupData and currentCupData.cupIndex > 0 then
    -- Prioritas Kedua: Berdasarkan Cup Index
    if currentCupData.cupIndex == 1 then
      o.currentLeague = UCLNib
    elseif currentCupData.cupIndex == 2 then
      o.currentLeague = WC26Nib
    else
      o.currentLeague = EAFC
    end
    
  else
    -- Prioritas Ketiga: Deteksi Manual Berdasarkan Tim di League
    if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
      o.currentLeague = PREMEIERLEAGUENib
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], WomenSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomenSuperLeagueTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      o.currentLeague = LIGUE1Nib
    elseif o:isInTable(o.TeamsData[1], Ligue2Teams) and o:isInTable(o.TeamsData[2], Ligue2Teams) then
      o.currentLeague = LIGUE1Nib
      o.currentLeague.bnd_crest_bg = "0x00FFCF"
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
      o.currentLeague = ARKEMANib
    elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
      o.currentLeague = BUNDESLIGA1Nib
    elseif o:isInTable(o.TeamsData[1], Bundesliga2Teams) and o:isInTable(o.TeamsData[2], Bundesliga2Teams) then
      o.currentLeague = BUNDESLIGA1Nib
    elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], InternationalWomansTeams) and o:isInTable(o.TeamsData[2], InternationalWomansTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
      o.currentLeague = SERIEANib
    elseif o:isInTable(o.TeamsData[1], SerieBTeams) and o:isInTable(o.TeamsData[2], SerieBTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], KoreaTeams) and o:isInTable(o.TeamsData[2], KoreaTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], LigaMXTeams) and o:isInTable(o.TeamsData[2], LigaMXTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], EredivisieTeams) and o:isInTable(o.TeamsData[2], EredivisieTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], LigaPortugalTeams) and o:isInTable(o.TeamsData[2], LigaPortugalTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], RestOfWolrd1Teams) and o:isInTable(o.TeamsData[2], RestOfWolrd1Teams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], RestOfWolrd2Teams) and o:isInTable(o.TeamsData[2], RestOfWolrd2Teams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], RoshnSaudiLeagueTeams) and o:isInTable(o.TeamsData[2], RoshnSaudiLeagueTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
      o.currentLeague = LALIGANib
    elseif o:isInTable(o.TeamsData[1], LaligaHypermotionTeams) and o:isInTable(o.TeamsData[2], LaligaHypermotionTeams) then
      o.currentLeague = LaligaHypermotionNib
      o.currentLeague.bnd_stamina_inner_bg = "0x04D4D4"
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
      o.currentLeague = LIGAFNib
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], UelTeams) and o:isInTable(o.TeamsData[2], UelTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], UwclTeams) and o:isInTable(o.TeamsData[2], UwclTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], MLSTeams) and o:isInTable(o.TeamsData[2], MLSTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], NwslTeams) and o:isInTable(o.TeamsData[2], NwslTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], AFCTeams) and o:isInTable(o.TeamsData[2], AFCTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
      o.currentLeague = EAFC
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
      o.currentLeague = EAFC
    else
      o.currentLeague = EAFC
    end
  end

  o.im.Subscribe(BND_ACTIVE, function()
    o:_publishActivity()
  end
  )
  o.im.Subscribe(BND_ALPHA, function()
    o:_publishAlpha()
  end
  )
  o.im.Subscribe(BND_PLAYER_INFO, function()
    o:_publishPlayerInfo()
  end
  )
  o.im.Subscribe(BND_STAMINA, function()
    o:_publishStamina()
  end
  )
  
  o.currentLeague.bnd_home_team_crest.id = o.TeamsData[1].assetId
  o.currentLeague.bnd_away_team_crest.id = o.TeamsData[2].assetId

  for k,v in pairs(o.currentLeague) do
    o.im.Subscribe(k, function()
      if k == "bnd_stamina_width" or k == "bnd_stamina_short_width" then
        o:_publishStamina()
      elseif k == "bnd_player_number" or k == "bnd_player_name" then
        o:_publishPlayerInfo()
      else
        o.im.Publish(k, v)
      end
    end)
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

  o.im.RegisterAction("act_camera_change", function(actionName)
    o:_updateCamera()
  end)
  
  o.isUserHome = o.services.gameSetupService.IsHostTeam()
  
  o:setState(STATE_INACTIVE)
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end
  )
  
  o.statsPL= {
    name = "$Stats_Playernib",
    id = 0
  }
  math.randomseed(os.clock() * 132 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(3)
  
  o.im.Subscribe("bnd_statsPL", function()
    o.statsPL.id = random2
    o.im.Publish("bnd_statsPL", o.statsPL)
  end)
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
  o.im.Subscribe(bndNibsOffVisible, function()
    if playernibOption == 3 then
      o.im.Publish(bndNibsOffVisible, true)
    else 
      o.im.Publish(bndNibsOffVisible, false)
    end
  end
  )
  
  return o
end

function PlayerNIB:setState(state)
  self.state = state or STATE_INACTIVE
  self:_publishActivity()
end

function PlayerNIB:getPlayerInfo(params)
  return {
    name = params[9],
    number = params[12]
  }
end

function PlayerNIB:getStamina(params)
  return {
    stamina = tonumber(params[1]),
    shortStamina = tonumber(params[2])
  }
end

function PlayerNIB:_onPlayerNIBUpdate(subtype, hideshow, subtypestr, msg)
  self:setState(hideshow)
  if self.state ~= STATE_INACTIVE and msg ~= nil and msg ~= "" then
    local params = OverlayParam.split(msg, "|")
    if table.getn(params) == 1 then
      if tonumber(params[1]) ~= nil then
        local alpha = tonumber(params[1]) / 100
        self:_publishAlpha(alpha)
      end
    elseif table.getn(params) == 2 then
    elseif table.getn(params) == 3 then
    elseif table.getn(params) == 8 then
      self.stamina = self:getStamina(params)
      self:_publishStamina()
    elseif table.getn(params) == 10 then
      self.stamina = self:getStamina(params)
      self:_publishStamina()
    elseif table.getn(params) == 16 then
      self.playerInfo = self:getPlayerInfo(params)
      self.stamina = self:getStamina(params)
      self:_publishPlayerInfo()
      self:_publishStamina()
    elseif table.getn(params) == 17 then
      self.playerInfo = self:getPlayerInfo(params)
      self.stamina = self:getStamina(params)
      self:_publishPlayerInfo()
      self:_publishStamina()
    end
  end
end

function PlayerNIB:_publishActivity()
  self.im.Publish(BND_ACTIVE, self.state ~= STATE_INACTIVE)
end

function PlayerNIB:_publishAlpha(alpha)
  self.im.Publish(BND_ALPHA, alpha or 1)
end

function PlayerNIB:_publishPlayerInfo()
  if self.playerInfo == nil then
    return
  end
  self.im.Publish(BND_PLAYER_INFO, self.playerInfo)
 self.im.Publish("bnd_player_number", tostring(self.playerInfo["number"]))
 self.im.Publish("bnd_player_name", self.playerInfo["name"])
end

function PlayerNIB:_publishStamina()
  if self.stamina == nil then
    return
  end
  self.im.Publish(BND_STAMINA, self.stamina)
  self.im.Publish("bnd_stamina_width", self.currentLeague.bnd_stamina_width)
  local r0 = self.stamina["shortStamina"] / self.stamina["stamina"]
  local r1 = self.currentLeague.bnd_stamina_width * r0
  self.im.Publish("bnd_stamina_short_width", r1)
end


function PlayerNIB:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.OverlayTypeNIBBL and self.side == SIDE_HOME or eventType == EVENT_TYPES.OverlayTypeNIBBR and self.side == SIDE_AWAY then
    self:_onPlayerNIBUpdate(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function PlayerNIB:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function PlayerNIB:getTeamHomeColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.homeColor
      result[2] = v.homeFontColor
    end
  end
  return result
end

function PlayerNIB:getTeamAwayColor(teamid, tbl)
  local result = {}
  for k,v in pairs(tbl) do
    if v.teamid == teamid then
      result[1] = v.awayColor
      result[2] = v.awayFontColor
    end
  end
  return result
end

function PlayerNIB:_updateCamera()
  if self.cameraIndex >= 7 then
    self.cameraIndex = 0
  else
    self.cameraIndex = self.cameraIndex + 1
  end
  self.services.settingsService.SaveCameraValue(self.cameraIndex)
end

function PlayerNIB:finalize()
  self.im.Unsubscribe(BND_ACTIVE)
  self.im.Unsubscribe(BND_ALPHA)
  self.im.Unsubscribe(BND_PLAYER_INFO)
  self.im.Unsubscribe(BND_STAMINA)
  self.im.Unsubscribe(bndHomeCrest)
  self.im.Unsubscribe(bndAwayCrest)
  self.im.Unsubscribe(bndRainVisible)
  self.im.Unsubscribe(bndSnowVisible)
  self.im.Unsubscribe(bndWeather)
  self.im.Unsubscribe(bndNibsOnSideVisible)
  self.im.Unsubscribe(bndNibsOnCenterVisible)
  self.im.Unsubscribe(bndNibsOnSingleVisible)
  self.im.Unsubscribe(bndNibsOffVisible)
  self.im.Unsubscribe("bnd_statsPL")
  for k,v in pairs(EAFC) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return PlayerNIB

-- Thanks : Ma'ruf Id & Laosiji --
-- And All Modder --
-- Playernib All League ( @mvnprodreal ) --