-- Thanks : Ma'ruf Id & Laosiji --
-- mvnprod.official --
-- talamlegit.official - Patch Mod EAFC24 --

local Substitution = {}
local OverlaysIdContainer, OverlayParam, eventmanager = ...
local Overlays = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

local bndNationalization = "bnd_nationalization"
local bndSubstitutionList = "bnd_subs_info"
local bndVisible = "bnd_visible"


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
   Japan = 349,
   KoreaRepublic = 83,
   LeagueOneEfl = 60,
   LeagueTwoEfl = 61,
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

AfcInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg_crest_color = "0xCEC0D7",
  --
  bnd_bg_textsub_color = "0x94DF2A",
  bnd_textsub_fontColor = "0x2D065F",
  --
  bnd_bg_playersub_color = "0x2D065F",
  bnd_sub_num_fontColor = "0x94DF2A",
  bnd_sub_text_fontColor = "0xffffff"
}
AsianCupU23Info = {
  bnd_forceCaps = true,
  bnd_bg_crest_color = "0x273F85",
  --
  bnd_bg_textsub_color = "0xF5F5F5",
  bnd_textsub_fontColor = "0x151515",
  --
  bnd_bg_playersub_color = "0x151515",
  bnd_sub_num_fontColor = "0xF5F5F5",
  bnd_sub_text_fontColor = "0xF5F5F5"
}
ClassicInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_forceCaps = true,
  bnd_bg_crest_color = "0x22C1A3",
  --
  bnd_bg_textsub_color = "0xF5F5F5",
  bnd_textsub_fontColor = "0x151515",
  --
  bnd_bg_playersub_color = "0x151515",
  bnd_sub_num_fontColor = "0xF5F5F5",
  bnd_sub_text_fontColor = "0xF5F5F5"
}
D1ArkemaInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg_crest_color = "0x061A3E",
  --
  bnd_bg_textsub_color = "0x143673",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x061A3E",
  bnd_sub_text_fontColor = "0x000000"
}
EAFCInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_forceCaps = true,
  bnd_bg_crest_color = "0x1AFE68",
  --
  bnd_bg_textsub_color = "0xF5F5F5",
  bnd_textsub_fontColor = "0x151515",
  --
  bnd_bg_playersub_color = "0x151515",
  bnd_sub_num_fontColor = "0xF5F5F5",
  bnd_sub_text_fontColor = "0xF5F5F5"
}
EnglandInfo = {
  bnd_fontFace = "$Epl",
  bnd_bg_crest_color = "0xF5F5F5",
  --
  bnd_bg_textsub_color = "0xF5F5F5",
  bnd_textsub_fontColor = "0x39003E",
  --
  bnd_bg_playersub_color = "0x39003E",
  bnd_sub_num_fontColor = "0xF5F5F5",
  bnd_sub_text_fontColor = "0xF5F5F5"
}
FranceInfo = {
  bnd_fontFace = "$Ligue1",
  bnd_bg_crest_color = "0x1F1F1F",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x304FFF",
  bnd_sub_num_fontColor = "0xFFFFFF",
  bnd_sub_text_fontColor = "0xffffff"
}
France2Info = {
  bnd_fontFace = "$Ligue1",
  bnd_bg_crest_color = "0x1F1F1F",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x02FFCE",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0x000000"
}
GermanyInfo = {
  bnd_fontFace = "$Bundesliga",
  bnd_bg_crest_color = "0x333333",
  --
  bnd_bg_textsub_color = "0xD10214",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x151515",
  bnd_sub_text_fontColor = "0x151515"
}
IndonesiaInfo = {
  bnd_fontFace = "$Liga1",
  bnd_bg_crest_color = "0x505050",
  --
  bnd_bg_textsub_color = "0x00519D",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0x000000"
}
ItalyInfo = {
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0x0F2D61",
  bnd_textsub_fontColor = "0xffffff",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0x0F2D61"
}
JapanInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0x000000",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0x000000"
}
SaudiArabiaInfo = {
  bnd_fontFace = "$SPL",
  bnd_bg_crest_color = "0xFFFFFF",
  --
  bnd_bg_textsub_color = "0x4B4B4B",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x151515",
  bnd_sub_text_fontColor = "0x151515"
}
SpainInfo = {
  bnd_fontFace = "$LaLiga",
  bnd_bg_crest_color = "0x151515",
  --
  bnd_bg_textsub_color = "0xFF5C41",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x151515",
  bnd_sub_text_fontColor = "0x151515"
}
Spain2Info = {
  bnd_fontFace = "$LaLiga",
  bnd_bg_crest_color = "0x151515",
  --
  bnd_bg_textsub_color = "0x04D4D4",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x151515",
  bnd_sub_text_fontColor = "0x151515"
}
ThailandInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_forceCaps = true,
  bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0xFE0000",
  bnd_textsub_fontColor = "0xffffff",
  --
  bnd_bg_playersub_color = "0xffffff",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0x000000"
}
LigaFInfo = {
  bnd_bg_crest_color = "0x2C6ADB",
  --
  bnd_bg_textsub_color = "0x1E1E1E",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0x09BFBA",
  bnd_sub_num_fontColor = "0x241A7A",
  bnd_sub_text_fontColor = "0x151515"
}
MalaysiaInfo = {
  bnd_fontFace = "$Malaysia",
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0x16FEC2",
  bnd_textsub_fontColor = "0x001763",
  --
  bnd_bg_playersub_color = "0x131262",
  bnd_sub_num_fontColor = "0x16FEC2",
  bnd_sub_text_fontColor = "0x16FEC2"
}
NetherlandsInfo = {
  bnd_fontFace = "$Eredivisie",
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0x000000",
  bnd_textsub_fontColor = "0xffffff",
  --
  bnd_bg_playersub_color = "0x5C5C5C",
  bnd_sub_num_fontColor = "0xffffff",
  bnd_sub_text_fontColor = "0xffffff"
}
PegadaianLiga2Info = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg_crest_color = "0xAED328",
  --
  bnd_bg_textsub_color = "0xAED328",
  bnd_textsub_fontColor = "0x07472B",
  --
  bnd_bg_playersub_color = "0x07472B",
  bnd_sub_num_fontColor = "0xffffff",
  bnd_sub_text_fontColor = "0xffffff"
}
UefaInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$UCL-Regular", 
  bnd_bg_crest_color = "0xFFFFFF",
  --
  bnd_bg_textsub_color = "0x041750",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0x08187D",
  bnd_sub_num_fontColor = "0xFFFFFF",
  bnd_sub_text_fontColor = "0xFFFFFF"
}
UefaUelInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-CondBold",
  bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0xE14711",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0x000000",
  bnd_sub_num_fontColor = "0xFFFFFF",
  bnd_sub_text_fontColor = "0xFFFFFF"
}
UefaWomensInfo = {
  bnd_bg_crest_color = "0xFFFFFF",
  --
  bnd_bg_textsub_color = "0x012652",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0x0657A0",
  bnd_sub_num_fontColor = "0xFFFFFF",
  bnd_sub_text_fontColor = "0xFFFFFF"
}
UnitedStatesInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg_crest_color = "0x1E1E1E",
  --
  bnd_bg_textsub_color = "0x1E1E1E",
  bnd_textsub_fontColor = "0xffffff",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x151515",
  bnd_sub_text_fontColor = "0x151515"
}
VietnamInfo = {
  bnd_bg_crest_color = "0xDEDEDE",
  --
  bnd_bg_textsub_color = "0x8E1026",
  bnd_textsub_fontColor = "0xffffff",
  --
  bnd_bg_playersub_color = "0x3C3C3C",
  bnd_sub_num_fontColor = "0xffffff",
  bnd_sub_text_fontColor = "0xffffff"
}
WomensSuperLeagueInfo = {
  bnd_forceCaps = true, 
  bnd_fontFace = "$Epl",
  bnd_bg_crest_color = "0x1D0F33",
  --
  bnd_bg_textsub_color = "0x1D0F33",
  bnd_textsub_fontColor = "0xF5F5F5",
  --
  bnd_bg_playersub_color = "0xF5F5F5",
  bnd_sub_num_fontColor = "0x1D0F33",
  bnd_sub_text_fontColor = "0x1D0F33"
}
--------------------------------------
-- Substitusi Turnamen --
--------------------------------------
WorldCupInfo = {
bnd_fontFace = "$Qatar2022Arabic",
bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0x02C7B3",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x240211",
  bnd_sub_num_fontColor = "0x02C7B3",
  bnd_sub_text_fontColor = "0xffffff"
}
PialaIndonesiaInfo = {
bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0xD8DF3A",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x3471B2",
  bnd_sub_num_fontColor = "0xD8DF3A",
  bnd_sub_text_fontColor = "0xffffff"
}
WorldCupWomensInfo = {
bnd_fontFace = "$FWWC2023Bold",
bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0xF4F4DC",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x275759",
  bnd_sub_num_fontColor = "0xF4F4DC",
  bnd_sub_text_fontColor = "0xffffff"
}
FaCupInfo = {
bnd_fontFace = "$Emirates-Bold",
bnd_bg_crest_color = "0x3E3E3B",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0xA8222A",
  bnd_sub_num_fontColor = "0xffffff",
  bnd_sub_text_fontColor = "0xffffff"
}
UefaEuropeInfo = {
  bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0x00BF0C",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0x000000",
  bnd_sub_num_fontColor = "0xFFFFFF",
  bnd_sub_text_fontColor = "0xFFFFFF"
}
AsianCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_bg_crest_color = "0xCEC0D7",
  --
  bnd_bg_textsub_color = "0x94DF2A",
  bnd_textsub_fontColor = "0x2D065F",
  --
  bnd_bg_playersub_color = "0x2D065F",
  bnd_sub_num_fontColor = "0x94DF2A",
  bnd_sub_text_fontColor = "0xffffff"
}
KingSaudiCupInfo = {
  bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0xFBDE98",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x17573B",
  bnd_sub_num_fontColor = "0xFBDE98",
  bnd_sub_text_fontColor = "0xffffff"
}
EuroCupInfo = {
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x030E2A",
  --
  bnd_bg_playersub_color = "0x1B38D2",
  bnd_sub_num_fontColor = "0xDDC100",
  bnd_sub_text_fontColor = "0xffffff"
}
UsaOpenCupInfo = {
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0x1A2237",
  bnd_textsub_fontColor = "0xffffff",
  --
  bnd_bg_playersub_color = "0xC6142E",
  bnd_sub_num_fontColor = "0xffffff",
  bnd_sub_text_fontColor = "0xffffff"
}
CopaDelReyInfo = {
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0xE60035",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x1F1831",
  bnd_sub_num_fontColor = "0xE60035",
  bnd_sub_text_fontColor = "0xffffff"
}
AfricaCupInfo = {
  bnd_bg_crest_color = "0x726C6C",
  --
  bnd_bg_textsub_color = "0xFF7900",
  bnd_textsub_fontColor = "0xffffff",
  --
  bnd_bg_playersub_color = "0x004530",
  bnd_sub_num_fontColor = "0xFF7900",
  bnd_sub_text_fontColor = "0xffffff"
}
CoppaItaliInfo = {
  bnd_bg_crest_color = "0xAA2C1D",
  --
  bnd_bg_textsub_color = "0x8EE4E1",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0xFFFFFF",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0xAA2C1D"
}
DfbPokalInfo = {
  bnd_bg_crest_color = "0xD2D7D1",
  --
  bnd_bg_textsub_color = "0xD2D7D1",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x05BB6A",
  bnd_sub_num_fontColor = "0xffffff",
  bnd_sub_text_fontColor = "0xffffff"
}
CoupeDeFranceInfo = {
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0x1A8EC4",
  bnd_textsub_fontColor = "0xffffff",
  --
  bnd_bg_playersub_color = "0x071A31",
  bnd_sub_num_fontColor = "0xffffff",
  bnd_sub_text_fontColor = "0xffffff"
}
FcwcInfo = { 
  bnd_bg_crest_color = "0xffffff",
  --
  bnd_bg_textsub_color = "0xCDA31F",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x000000",
  bnd_sub_num_fontColor = "0xffffff",
  bnd_sub_text_fontColor = "0xffffff"
}
CopaLibertadoresInfo = { 
  bnd_bg_crest_color = "0x000000",
  --
  bnd_bg_textsub_color = "0x986B2A",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0xEDC261",
  bnd_sub_num_fontColor = "0x000000",
  bnd_sub_text_fontColor = "0x000000"
}
UefaNationsInfo = {
  bnd_fontFace = "$UEFANations-Bold",
  bnd_bg_crest_color = "0xF9FDFD",
  --
  bnd_bg_textsub_color = "0xF9FDFD",
  bnd_textsub_fontColor = "0x253242",
  --
  bnd_bg_playersub_color = "0x253242",
  bnd_sub_num_fontColor = "0xF9FDFD",
  bnd_sub_text_fontColor = "0xF9FDFD"
}
CopaAmericaInfo = {
  bnd_bg_crest_color = "0xB40309",
  --
  bnd_bg_textsub_color = "0x1B1365",
  bnd_textsub_fontColor = "0xFFFFFF",
  --
  bnd_bg_playersub_color = "0x000000",
  bnd_sub_num_fontColor = "0xFFFFFF",
  bnd_sub_text_fontColor = "0xFFFFFF"
}
AseanChampionshipInfo = {
  bnd_bg_crest_color = "0x8E182A",
  --
  bnd_bg_textsub_color = "0xffffff",
  bnd_textsub_fontColor = "0x000000",
  --
  bnd_bg_playersub_color = "0x8E182A",
  bnd_sub_num_fontColor = "0xFFFFFF",
  bnd_sub_text_fontColor = "0xFFFFFF"
}
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
  local JapanTeams = o.services.TeamService.GetTeams(leagueIDs.Japan, 0, 0, true)
  local KoreaRepublicTeams = o.services.TeamService.GetTeams(leagueIDs.KoreaRepublic, 0, 0, true)
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
  end)
  
    o.currentdata = nil
  
  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
      o.currentdata = UefaInfo
    elseif currentCupData.cupIndex == 2 then
      o.currentdata = WorldCupInfo
    elseif currentCupData.cupIndex == 3 then
      o.currentdata = UefaUelInfo
    elseif currentCupData.cupIndex == 4 then
      o.currentdata = PialaIndonesiaInfo
    elseif currentCupData.cupIndex == 5 then
      o.currentdata = WorldCupWomensInfo
    elseif currentCupData.cupIndex == 6 then
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
    elseif currentCupData.cupIndex == 19 then
      o.currentdata = CopaLibertadoresInfo
    elseif currentCupData.cupIndex == 20 then
      o.currentdata = UefaNationsInfo
    end
  elseif currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
      o.currentdata = UefaInfo
    elseif currentTourData.tourIndex == 2 then
      o.currentdata = WorldCupInfo
    elseif currentTourData.tourIndex == 3 then
      o.currentdata = UefaUelInfo
    elseif currentTourData.tourIndex == 29 then
      o.currentdata = PialaIndonesiaInfo
    elseif currentTourData.tourIndex == 27 then
      o.currentdata = AseanChampionshipInfo      
    elseif currentTourData.tourIndex == 35 then
      o.currentdata = WorldCupWomensInfo
    elseif currentTourData.tourIndex == 16 then
      o.currentdata = UefaWomensInfo      
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
    elseif currentTourData.tourIndex == 4 then
      o.currentdata = CopaLibertadoresInfo
    elseif currentTourData.tourIndex == 50 then
      o.currentdata = KingSaudiCupInfo      
    elseif currentTourData.tourIndex == 22 then
      o.currentdata = ClassicInfo      
    elseif currentTourData.tourIndex == 28 then
      o.currentdata = UefaNationsInfo
    elseif currentTourData.tourIndex == 24 then
      o.currentdata = EAFCInfo
    elseif currentTourData.tourIndex == 31 then
      o.currentdata = EAFCInfo      
    elseif currentTourData.tourIndex == 21 then
      o.currentdata = EAFCInfo      
  else  
    o.currentdata = EAFCInfo      
    end    
  else
     if o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], AfcTeams) and o:isInTable(o.TeamsData[2], AfcTeams) then
    o.currentdata = AfcInfo
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
     o.currentdata = AsianCupU23Info
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    o.currentdata = ClassicInfo
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    o.currentdata = ClassicInfo
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    o.currentdata = D1ArkemaInfo
    elseif  o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    o.currentdata = EAFCInfo
    elseif  o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    o.currentdata = EnglandInfo
    elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    o.currentdata = FranceInfo
    elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    o.currentdata = France2Info
    elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    o.currentdata = GermanyInfo
    elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
    o.currentdata = GermanyInfo
    elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
    o.currentdata = IndonesiaInfo
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    o.currentdata = ItalyInfo
    elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
    o.currentdata = JapanInfo
    elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    o.currentdata = LigaFInfo
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    o.currentdata = MalaysiaInfo
    elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    o.currentdata = NetherlandsInfo
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    o.currentdata = PegadaianLiga2Info
    elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    o.currentdata = SaudiArabiaInfo
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    o.currentdata = SpainInfo
    elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    o.currentdata = Spain2Info
    elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    o.currentdata = UefaInfo
    elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    o.currentdata = UefaUelInfo
    elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
    o.currentdata = UefaWomensInfo
    elseif o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
    o.currentdata = UnitedStatesInfo
    elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USANWSLTeams) then
    o.currentdata = UnitedStatesInfo
    elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
    o.currentdata = VietnamInfo
    elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
    o.currentdata = WomensSuperLeagueInfo
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
