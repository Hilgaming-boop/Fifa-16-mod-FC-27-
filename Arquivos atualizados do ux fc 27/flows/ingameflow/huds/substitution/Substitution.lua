
-- New Custom Subtitution By MVNPROD --

local Substitution = {}
local OverlaysIdContainer, OverlayParam, eventmanager = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

local bndNationalization = "bnd_nationalization"
local bndSubstitutionList = "bnd_subs_info"
local bndVisible = "bnd_visible"

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

EAFCInfo = {
  bnd_bg_crest_color = "0x04F377",
  --
  bnd_bg_textsub_color = "0xF5F5F5",
  bnd_textsub_fontColor = "0x151515",
  --
  bnd_bg_playersub_color = "0x151515",
  bnd_sub_num_fontColor = "0xF5F5F5",
  bnd_sub_text_fontColor = "0xF5F5F5"
}

PREMIERLEAGUEInfo = {
  bnd_bg_crest_color = "0xF5F5F5",
  --
  bnd_bg_textsub_color = "0xF5F5F5",
  bnd_textsub_fontColor = "0x39003E",
  --
  bnd_bg_playersub_color = "0x39003E",
  bnd_sub_num_fontColor = "0xF5F5F5",
  bnd_sub_text_fontColor = "0xF5F5F5"
}

LALIGAInfo = {
  bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0xFF4942",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0x000000"
}

LIGAFInfo = {
  bnd_bg_crest_color = "0x2C6ADB",
  --
  bnd_bg_textsub_color = "0x09BFBA",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0xf5f5f5",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0x000000"
}

BUNDESLIGA1Info= {
  bnd_bg_crest_color = "0x2D2D2D",
  --
  bnd_bg_textsub_color = "0x2D2D2D",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x151515",
  bnd_sub_text_fontColor = "0x151515"
}

LIGUE1Info = {
  bnd_bg_crest_color = "0x085EFF",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x292B2A",
  bnd_sub_num_fontColor = "0xFFFFFF",
  bnd_sub_text_fontColor = "0xFFFFFF"
}

ARKEMAInfo = {
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x000943",
  bnd_sub_num_fontColor = "0x2AECF4",
  bnd_sub_text_fontColor = "0xFFFFFF"
}

SERIEAInfo = {
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x02215D",
  --
  bnd_bg_playersub_color = "0x02215D",
  bnd_sub_num_fontColor = "0x04D4D4",
  bnd_sub_text_fontColor = "0xFFFFFF"
}

UCLInfo = {
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x091C94",
  bnd_sub_num_fontColor = "0x99D5EB",
  bnd_sub_text_fontColor = "0xFFFFFF"
}

-- Finish

function Substitution:new(init)
  print("[Substitution]: new()")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.nationalization = 2
  o.services = {
    EventManagerService = o.api("EventManagerService"),
    MatchInfoService = o.api("MatchInfoService"),
    TeamService = o.api("TeamService")
  }
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.handlerId = o.services.EventManagerService.RegisterHandler(function(...)
  o:handleEvent(...) end)
  
  o.currentdata = nil
  
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
  
  if currentCupData and currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      o.currentdata = UCLInfo
    elseif currentCupData.cupIndex == 2 then
      o.currentdata = EAFCInfo
    end
    
  elseif currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
    -- Dukungan untuk Turnamen (Tour)
    if currentTourData.tourIndex == 1 then
      o.currentdata = UCLInfo
    elseif currentTourData.tourIndex == 35 then
      o.currentdata = UCLInfo
    else
      o.currentdata = EAFCInfo
    end

  else
    if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
      o.currentdata = PREMIERLEAGUEInfo
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], WomenSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomenSuperLeagueTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      o.currentdata = LIGUE1Info
    elseif o:isInTable(o.TeamsData[1], Ligue2Teams) and o:isInTable(o.TeamsData[2], Ligue2Teams) then
      o.currentdata = LIGUE1Info
      o.currentdata.bnd_bg_crest_color = "0x00FFCF"
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
      o.currentdata = ARKEMAInfo
    elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
      o.currentdata = BUNDESLIGA1Info
    elseif o:isInTable(o.TeamsData[1], Bundesliga2Teams) and o:isInTable(o.TeamsData[2], Bundesliga2Teams) then
      o.currentdata = BUNDESLIGA1Info
    elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], InternationalWomansTeams) and o:isInTable(o.TeamsData[2], InternationalWomansTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
      o.currentdata = SERIEAInfo
    elseif o:isInTable(o.TeamsData[1], SerieBTeams) and o:isInTable(o.TeamsData[2], SerieBTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], KoreaTeams) and o:isInTable(o.TeamsData[2], KoreaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LigaMXTeams) and o:isInTable(o.TeamsData[2], LigaMXTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], EredivisieTeams) and o:isInTable(o.TeamsData[2], EredivisieTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LigaPortugalTeams) and o:isInTable(o.TeamsData[2], LigaPortugalTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], RestOfWolrd1Teams) and o:isInTable(o.TeamsData[2], RestOfWolrd1Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], RestOfWolrd2Teams) and o:isInTable(o.TeamsData[2], RestOfWolrd2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], RoshnSaudiLeagueTeams) and o:isInTable(o.TeamsData[2], RoshnSaudiLeagueTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
      o.currentdata = LALIGAInfo
    elseif o:isInTable(o.TeamsData[1], LaligaHypermotionTeams) and o:isInTable(o.TeamsData[2], LaligaHypermotionTeams) then
      o.currentdata = LALIGAInfo
      o.currentdata.bnd_bg_textsub_color = "0x04D4D4"
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
      o.currentdata = LIGAFInfo
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], UclTeams) and o:isInTable(o.TeamsData[2], UclTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], UelTeams) and o:isInTable(o.TeamsData[2], UelTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], UwclTeams) and o:isInTable(o.TeamsData[2], UwclTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], MLSTeams) and o:isInTable(o.TeamsData[2], MLSTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], NwslTeams) and o:isInTable(o.TeamsData[2], NwslTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], AFCTeams) and o:isInTable(o.TeamsData[2], AFCTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
      o.currentdata = EAFCInfo
    else
      o.currentdata = EAFCInfo
    end
  end
      
  o.bndList = {
  bnd_sub_crest = {
    name = "$Crest",
    id = 0
  },
  bnd_subin1_visible = false,
  bnd_subin2_visible = false,
  bnd_subin3_visible = false,
  bnd_subout1_visible = false,
  bnd_subout2_visible = false,
  bnd_subout3_visible = false,

  bnd_subin_num1 = "",
  bnd_subin_text1 = "",
  bnd_subin_num2 = "",
  bnd_subin_text2 = "",
  bnd_subin_num3 = "",
  bnd_subin_text3 = "",

  bnd_subout_num1 = "",
  bnd_subout_text1 = "",
  bnd_subout_num2 = "",
  bnd_subout_text2 = "",
  bnd_subout_num3 = "",
  bnd_subout_text3 = ""
}

  for k,v in pairs(o.bndList) do
    o.im.Subscribe(k, function()
     -- o.im.Publish(k, v)
    end)
  end
  
  o.im.Subscribe(bndVisible, function()
    o.im.Publish(bndVisible, false)
  end)
  
  o.im.Subscribe(bndNationalization, function()
  end)
  
  o.im.Subscribe(bndSubstitutionList, function()
  end)

  for k,v in pairs(o.currentdata) do
    o.im.Subscribe(k, function()
      o.im.Publish(k, v)
    end)
  end

  return o
end

function Substitution:handleEvent(eventType, data)
  if eventType == EventTypes.OverlayTypeSubstitutionOut then
    self:updateSubstitution(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function Substitution:updateSubstitution(subtype, hideshow, subtypestr, msg)
  print("updateSubstitution " .. msg)
  if hideshow ~= "HIDE" then
    local params = OverlayParam.split(msg, "|")
    if params and table.getn(params) > 0 then
      self.im.Publish(bndVisible, true)
     -- self.im.Publish("bnd_subin1_visible", true)
      -- self.im.Publish("bnd_subin_text1", params[4])
       self.bndList.bnd_sub_crest.id = params[1]
      self.im.Publish("bnd_sub_crest", self.bndList.bnd_sub_crest)
     -- self.im.Publish(bndNationalization, self.nationalization)
      TeamId = params[1] + 0
      
      local substitutionsInfo = {
        NumberofSubs = params[3] + 0,
        SubIn1Text = params[4],
        SubIn1NumText = params[5],
        SubIn2Text = params[6],
        SubIn2NumText = params[7],
        SubIn3Text = params[8],
        SubIn3NumText = params[9],
        SubOut1Text = params[11],
        SubOut1NumText = params[12],
        SubOut2Text = params[13],
        SubOut2NumText = params[14],
        SubOut3Text = params[15],
        SubOut3NumText = params[16],
        overlayTitle = ("换人"),
        TeamId = params[1] + 0
      }
      
      --bndList.bnd_sub_crest.id = TeamId and TeamId or 0
     -- self.im.Publish("bnd_sub_crest", bndList.bnd_sub_crest)
      
      if substitutionsInfo.SubIn2NumText == "-1" then
        self.im.Publish("bnd_subin1_visible", true)
        self.im.Publish("bnd_subin2_visible", false)
        self.im.Publish("bnd_subin3_visible", false)
      elseif substitutionsInfo.SubIn3NumText == "-1" then
        self.im.Publish("bnd_subin2_visible", true)
        self.im.Publish("bnd_subin1_visible", false)
        self.im.Publish("bnd_subin3_visible", false)
      elseif substitutionsInfo.SubIn3NumText ~= "-1" then
        self.im.Publish("bnd_subin3_visible", true)
        self.im.Publish("bnd_subin1_visible", false)
        self.im.Publish("bnd_subin2_visible", false)
       else
         self.im.Publish("bnd_subin3_visible", true)
        self.im.Publish("bnd_subin1_visible", false)
        self.im.Publish("bnd_subin2_visible", false)
      end
      if substitutionsInfo.SubOut2NumText == "-1" then
        self.im.Publish("bnd_subout1_visible", true)
        self.im.Publish("bnd_subout2_visible", false)
       self.im.Publish("bnd_subout3_visible", false)
      elseif substitutionsInfo.SubOut3NumText == "-1" then
        self.im.Publish("bnd_subout2_visible", true)
       self.im.Publish("bnd_subout1_visible", false)
       self.im.Publish("bnd_subout3_visible", false)
      elseif substitutionsInfo.SubOut3NumText ~= "-1" then
        self.im.Publish("bnd_subout3_visible", true)
      self.im.Publish("bnd_subout1_visible", false)
       self.im.Publish("bnd_subout2_visible", false)
       else
         self.im.Publish("bnd_subout3_visible", true)
      self.im.Publish("bnd_subout1_visible", false)
       self.im.Publish("bnd_subout2_visible", false)
      end
      self.im.Publish("bnd_subin_num1", substitutionsInfo.SubIn1NumText)
      self.im.Publish("bnd_subin_text1", substitutionsInfo.SubIn1Text)
      self.im.Publish("bnd_subin_num2", substitutionsInfo.SubIn2NumText)
      self.im.Publish("bnd_subin_text2", substitutionsInfo.SubIn2Text)
      self.im.Publish("bnd_subin_num3", substitutionsInfo.SubIn3NumText)
      self.im.Publish("bnd_subin_text3", substitutionsInfo.SubIn3Text)

      self.im.Publish("bnd_subout_num1", substitutionsInfo.SubOut1NumText)
      self.im.Publish("bnd_subout_text1", substitutionsInfo.SubOut1Text)
      self.im.Publish("bnd_subout_num2", substitutionsInfo.SubOut2NumText)
      self.im.Publish("bnd_subout_text2", substitutionsInfo.SubOut2Text)
      self.im.Publish("bnd_subout_num3", substitutionsInfo.SubOut3NumText)
      self.im.Publish("bnd_subout_text3", substitutionsInfo.SubOut3Text)
      --self.im.Publish(bndSubstitutionList, substitutionsInfo)
    end
  else
    self.im.Publish(bndVisible, false)
    self.im.Publish("bnd_subin1_visible", false)
    self.im.Publish("bnd_subin2_visible", false)
    self.im.Publish("bnd_subin3_visible", false)
    self.im.Publish("bnd_subout1_visible", false)
    self.im.Publish("bnd_subout2_visible", false)
    self.im.Publish("bnd_subout3_visible", false)
  end
end

function Substitution:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function Substitution:finalize()
  self.im.Unsubscribe(bndVisible)
  self.im.Unsubscribe(bndSubstitutionList)
  self.im.Unsubscribe(bndNationalization)
  for k,v in pairs(self.bndList) do
    self.im.Unsubscribe(k)
  end
  self.services.EventManagerService.UnregisterHandler(self.handlerId)
  
end

return Substitution

-- Thanks : Ma'ruf Id & Laosiji --
-- And All Modder --
-- Subtitution All League ( @mvnprodreal ) --