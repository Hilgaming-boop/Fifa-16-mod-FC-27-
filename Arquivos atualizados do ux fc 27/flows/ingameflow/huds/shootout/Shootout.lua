
-- New Custom Shootout By MVNPROD --

local Shootout = {}
local OverlayParam, EventManager, TableUtil = ...
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes

local BND_ACTIVE = "bnd_active"
local BND_SCORE = "bnd_score"
local BND_HOME_TEAM = "bnd_home_team"
local BND_AWAY_TEAM = "bnd_away_team"
local BND_SIDE = "bnd_side"
local BND_HOME_HISTORY = "bnd_home_history"
local BND_AWAY_HISTORY = "bnd_away_history"local bndShowHUDVisible = "bnd_show_hud_visible"
local bndHideHUDVisible = "bnd_hide_hud_visible"
local bndNibsOnSideVisible = "bnd_nibs_on_side_visible"
local bndNibsOnCenterVisible = "bnd_nibs_on_center_visible"
local bndNibsOnSingleVisible = "bnd_nibs_on_single_visible"
local STATE_INACTIVE = "HIDE"
local STATE_ACTIVE = "SHOW"
local SIDE_HOME = 0
local SIDE_AWAT = 1

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
  Ucl = 2236,
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

EAFCScore = {
  bnd_sb_top = 30,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0x151515",
  bnd_bg_crest_color = "0x151515",
  bnd_stripclub_color = "0x04F377",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_awayName_fontColor = "0x151515",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 0 },
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest = { name = "$Crest64x64", id = 0 }
}

PREMIERLEAGUEScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0xF5F5F5",
  bnd_strip_color = "0x39003E",
  bnd_bg_crest_color = "0x39003E",
  bnd_stripclub_color = "0xF5F5F5",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x39003E",
  bnd_awayName_fontColor = "0x39003E",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 1 },
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest = { name = "$Crest64x64", id = 0 }
}

LALIGAScore = {
  bnd_sb_top = 30,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0xFF5C41",
  bnd_bg_crest_color = "0x151515",
  bnd_stripclub_color = "0xFF5C41",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_awayName_fontColor = "0x151515",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 2 },
  bnd_homeCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_awayCrest = { name = "$Crest_Laliga", id = 0 }
}

LALIGAHYPERMOTIONScore = {
  bnd_sb_top = 30,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0x04D4D4",
  bnd_bg_crest_color = "0x151515",
  bnd_stripclub_color = "0x04D4D4",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_awayName_fontColor = "0x151515",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 2 },
  bnd_homeCrest = { name = "$Crest_Laliga", id = 0 },
  bnd_awayCrest = { name = "$Crest_Laliga", id = 0 }
}

LIGAFScore = {
  bnd_sb_top = 40,
  bnd_bg_color = "0x09BFBA",
  bnd_strip_color = "0x2C6ADB",
  bnd_bg_crest_color = "0x2C6ADB",
  bnd_stripclub_color = "0x09BFBA",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_awayName_fontColor = "0x151515",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 3 },
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest = { name = "$Crest64x64", id = 0 }
}

BUNDESLIGA1Score = {
  bnd_sb_top = 30,
  bnd_bg_color = "0xFFFFFF",
  bnd_strip_color = "0x2D2D2D",
  bnd_bg_crest_color = "0x2D2D2D",
  bnd_stripclub_color = "0xFFFFFF",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0x151515",
  bnd_awayName_fontColor = "0x151515",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 4 },
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest = { name = "$Crest64x64", id = 0 }
}

LIGUE1Score = {
  bnd_sb_top = 30,
  bnd_bg_color = "0x292B2A",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0x085EFF",
  bnd_stripclub_color = "0xffffff",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_fontColor = "0xffffff",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 5 },
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest = { name = "$Crest64x64", id = 0 }
}

LIGUE2Score = {
  bnd_sb_top = 30,
  bnd_bg_color = "0x292B2A",
  bnd_strip_color = "0xffffff",
  bnd_bg_crest_color = "0x00FFCF",
  bnd_stripclub_color = "0x292B2A",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_fontColor = "0xffffff",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 5 },
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest = { name = "$Crest64x64", id = 0 }
}

ARKEMAScore = {
  bnd_sb_top = 35,
  bnd_bg_color = "0x000943",
  bnd_strip_color = "0x2AECF4",
  bnd_bg_crest_color = "0xFFFFFF",
  bnd_stripclub_color = "0x000000",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_fontColor = "0xffffff",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 6 },
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest = { name = "$Crest64x64", id = 0 }
}

SERIEAScore = {
  bnd_sb_top = 30,
  bnd_bg_color = "0x02215D",
  bnd_strip_color = "0x04D4D4",
  bnd_bg_crest_color = "0xffffff",
  bnd_stripclub_color = "0x02215D",
  --
  bnd_homeName_text = "",
  bnd_awayName_text = "",
  bnd_homeName_fontColor = "0xffffff",
  bnd_awayName_fontColor = "0xffffff",
  --
  bnd_live_logo = { name = "$LiveLogo", id = 8 },
  bnd_homeCrest = { name = "$Crest64x64", id = 0 },
  bnd_awayCrest = { name = "$Crest64x64", id = 0 }
}

-- Finish

function Shootout:new(init)
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
  o:_handleEvent(...) end)
  
  local HOMETEAM = 0
  local AWAYTEAM = 1
  o.currentdata = {}
  
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
  local UclTeams = o.services.TeamService.GetTeams(leagueIDs.Ucl, 0, 0, true)
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

  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      o.currentdata = EAFCScore
    elseif currentCupData.cupIndex == 2 then
      o.currentdata = EAFCScore
    end
    
  else
    if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
      o.currentdata = PREMIERLEAGUEScore
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], WomenSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomenSuperLeagueTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      o.currentdata = LIGUE1Score
    elseif o:isInTable(o.TeamsData[1], Ligue2Teams) and o:isInTable(o.TeamsData[2], Ligue2Teams) then
      o.currentdata = LIGUE2Score
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
      o.currentdata = ARKEMAScore
    elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
      o.currentdata = BUNDESLIGA1Score
    elseif o:isInTable(o.TeamsData[1], Bundesliga2Teams) and o:isInTable(o.TeamsData[2], Bundesliga2Teams) then
      o.currentdata = BUNDESLIGA1Score
    elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], InternationalWomansTeams) and o:isInTable(o.TeamsData[2], InternationalWomansTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
      o.currentdata = SERIEAScore
    elseif o:isInTable(o.TeamsData[1], SerieBTeams) and o:isInTable(o.TeamsData[2], SerieBTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], KoreaTeams) and o:isInTable(o.TeamsData[2], KoreaTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], LigaMXTeams) and o:isInTable(o.TeamsData[2], LigaMXTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], EredivisieTeams) and o:isInTable(o.TeamsData[2], EredivisieTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], LigaPortugalTeams) and o:isInTable(o.TeamsData[2], LigaPortugalTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], RestOfWolrd1Teams) and o:isInTable(o.TeamsData[2], RestOfWolrd1Teams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], RestOfWolrd2Teams) and o:isInTable(o.TeamsData[2], RestOfWolrd2Teams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], RoshnSaudiLeagueTeams) and o:isInTable(o.TeamsData[2], RoshnSaudiLeagueTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
      o.currentdata = LALIGAScore
    elseif o:isInTable(o.TeamsData[1], LaligaHypermotionTeams) and o:isInTable(o.TeamsData[2], LaligaHypermotionTeams) then
      o.currentdata = LALIGAHYPERMOTIONScore
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
      o.currentdata = LIGAFScore
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], UclTeams) and o:isInTable(o.TeamsData[2], UclTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], UelTeams) and o:isInTable(o.TeamsData[2], UelTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], UwclTeams) and o:isInTable(o.TeamsData[2], UwclTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], MLSTeams) and o:isInTable(o.TeamsData[2], MLSTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], NwslTeams) and o:isInTable(o.TeamsData[2], NwslTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], AFCTeams) and o:isInTable(o.TeamsData[2], AFCTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
      o.currentdata = EAFCScore
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
      o.currentdata = EAFCScore
    else
      o.currentdata = EAFCScore
    end
  end
  
  o.currentdata.bnd_homeCrest.id = o.TeamsData[1].assetId
  o.currentdata.bnd_awayCrest.id = o.TeamsData[2].assetId
  o.currentdata.bnd_homeName_text = o.services.GameSetupService.GetTeamShortName(HOMETEAM)
  o.currentdata.bnd_awayName_text = o.services.GameSetupService.GetTeamShortName(AWAYTEAM)
  
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
  
  o.im.Subscribe(BND_ACTIVE, function()
    o:_publishActivity()
  end)
  o.im.Subscribe(BND_SCORE, function()
    o:_publishScore()
  end)
  o.im.Subscribe(BND_HOME_TEAM, function()
    o:_publishTeam()
  end)
  o.im.Subscribe(BND_AWAY_TEAM, function()
    o:_publishTeam(true)
  end)
  o.im.Subscribe(BND_SIDE, function()
    o:_publishSide()
  end)
  o.im.Subscribe(BND_HOME_HISTORY, function()
    o:_publishHistory()
  end)
  o.im.Subscribe(BND_AWAY_HISTORY, function()
    o:_publishHistory(true)
  end)
  o:setState(STATE_INACTIVE)
  
  for k,v in pairs(o.currentdata) do
    o.im.Subscribe(k, function()
      o.im.Publish(k, v)
    end)
  end
  
  return o
end
function Shootout:setState(state)
  self.state = state or STATE_INACTIVE
  self:_publishActivity()
end
function Shootout:_onShootoutUpdate(data)
  assert(data, "Overlay data is nil.")
  assert(data.hideshow, "Overlay data contains no \"hideshow\" property.")
  assert(data.msg, "Overlay data contains no \"msg\" property.")
  local params = OverlayParam.split(data.msg, "|")
  local homeTeamID = self.TeamsData[1].assetId
  local awayTeamID = self.TeamsData[2].assetId
  if self.TeamsData[1].teamId == awayTeamID then
    homeTeamID = self.TeamsData[2].assetId
    awayTeamID = self.TeamsData[1].assetId
  end
  self.homeTeam = {
    id = homeTeamID,
    name = tostring(params[2])
  }
  self.awayTeam = {
    id = awayTeamID,
    name = tostring(params[9])
  }
  self.homeHistory = {
    tonumber(params[3]),
    tonumber(params[4]),
    tonumber(params[5]),
    tonumber(params[6]),
    tonumber(params[7])
  }
  self.awayHistory = {
    tonumber(params[10]),
    tonumber(params[11]),
    tonumber(params[12]),
    tonumber(params[13]),
    tonumber(params[14])
  }
  self.side = tonumber(params[17])
  self:_publishTeam()
  self:_publishTeam(true)
  self:_publishHistory()
  self:_publishHistory(true)
  self:_publishSide()
  self:_publishScore()
  self:setState(data.hideshow)
end
function Shootout:_publishActivity()
  self.im.Publish(BND_ACTIVE, self.state ~= STATE_INACTIVE)
end
function Shootout:_publishScore()
  local matchScore = self.services.MatchInfoService.GetMatchScore()
  local homeScore = matchScore.homeShootout
  local awayScore = matchScore.awayShootout
  local shootoutScore = string.format("%s . %s", tostring(homeScore), tostring(awayScore))
  self.im.Publish(BND_SCORE, shootoutScore)
end
function Shootout:_publishTeam(isAway)
  if isAway then
    if self.awayTeam ~= nil then
      self.im.Publish(BND_AWAY_TEAM, self.awayTeam)
    end
  elseif self.homeTeam ~= nil then
    self.im.Publish(BND_HOME_TEAM, self.homeTeam)
  end
end
function Shootout:_publishSide()
  self.im.Publish(BND_SIDE, self.side or -1)
end
function Shootout:_publishHistory(isAway)
  if isAway then
    if self.awayHistory ~= nil then
      self.im.Publish(BND_AWAY_HISTORY, self.awayHistory)
    end
  elseif self.homeHistory ~= nil then
    self.im.Publish(BND_HOME_HISTORY, self.homeHistory)
  end
end
function Shootout:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.OverlayTypeShootoutHistory then
    self:_onShootoutUpdate(data)
  end
end

function Shootout:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function Shootout:finalize()
  self.im.Unsubscribe(BND_ACTIVE)
  self.im.Unsubscribe(BND_SCORE)
  self.im.Unsubscribe(BND_HOME_TEAM)
  self.im.Unsubscribe(BND_AWAY_TEAM)
  self.im.Unsubscribe(BND_SIDE)
  self.im.Unsubscribe(BND_HOME_HISTORY)
  self.im.Unsubscribe(BND_AWAY_HISTORY)
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
return Shootout

-- Thanks : Ma'ruf Id & Laosiji --
-- And All Modder --
-- Shootout All League ( @mvnprodreal ) --