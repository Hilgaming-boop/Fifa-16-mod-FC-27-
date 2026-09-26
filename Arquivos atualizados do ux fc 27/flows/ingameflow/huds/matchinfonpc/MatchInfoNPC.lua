
-- New Custom MatchInfoNPC By MVNPROD --

local MatchInfoNPC = {}
local OverlaysIdContainer, OverlayParam, eventmanager = ...
local OVERLAY_TYPES = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

leagueIDs = {
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

-- Ref.Custom

EAFCREFInfo = {
  bnd_ref_Name_text = "",
  bnd_ref_Name_text_top = -15,
  bnd_ref_Name_text_left = 0,
  bnd_ref_Name_text_alignH = "CENTER",
  bnd_ref_Country_text = "",
  bnd_ref_Country_text_top = 15,
  bnd_ref_Country_text_left = 0,
  bnd_ref_Country_text_alignH = "CENTER"
}

-- Com.Custom

EAFCInfo = { --350x100
  bnd_mvnprod1_show = true,
  bnd_mvnprod2_show = false,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = 7,
  bnd_title_width = 130,
  bnd_title_height = 20,
  bnd_title_color = "0x151515",
  bnd_title_text_color = "0xFFFFFF",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 0,
  bnd_latar1_color = "0xF4F3EF",
  bnd_latar1_color_width = 270,
  bnd_latar1_color_height = 80,
  bnd_latar1_color_alpha = 1,
  bnd_latar2_color = "0x04F377",
  bnd_latar2_color_width = 0,
  bnd_latar2_color_height = 0,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 1,
  bnd_bgIcon_color = "0xFFFFFF",
  bnd_logo = { name = "$LeagueLogo", id = "0_1" },
  bnd_logo_width = 45,
  bnd_logo_height = 45,
  bnd_logo_top = 0,
  bnd_logo_left = 0,
  
  bnd_com1_text = "",
  bnd_com1_text_top = 20,
  bnd_com1_text_left = -65,
  bnd_com1_text_alignH = "CENTER",
  bnd_com_text_fontColor = "0x151515",
  bnd_com2_text = "",
  bnd_com2_text_top = 20,
  bnd_com2_text_left = 65,
  bnd_com2_text_alignH = "CENTER",
  
  bnd_comimage1_top = -11,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

PREMIERLEAGUEInfo= { --350x100
  bnd_mvnprod1_show = false,
  bnd_mvnprod2_show = true,
  
  bnd_cornerRaduis = 10,
  bnd_title_left = 219,
  bnd_title_width = 130,
  bnd_title_height = 30,
  bnd_title_color = "0xF5F5F5",
  bnd_title_text_color = "0x39003E",
  bnd_title_text_bottom = 5,
  
  bnd_latar_color_left = 20,
  bnd_latar1_color = "0x39003E",
  bnd_latar1_color_width = 250,
  bnd_latar1_color_height = 50,
  bnd_latar1_color_alpha = 1,
  bnd_latar2_color = "0x39003E",
  bnd_latar2_color_width = 0,
  bnd_latar2_color_height = 0,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xF5F5F5",
  bnd_logo = { name = "$LeagueLogo", id = 13 },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_top = -20,
  bnd_logo_left = 60,
  
  bnd_com1_text = "",
  bnd_com1_text_top = -25,
  bnd_com1_text_left = -50,
  bnd_com1_text_alignH = "LEFT",
  bnd_com_text_fontColor = "0xF5F5F5",
  bnd_com2_text = "",
  bnd_com2_text_top = -5,
  bnd_com2_text_left = -50,
  bnd_com2_text_alignH = "LEFT",
  
  bnd_comimage1_top = -11,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

LALIGAInfo = { --350x100
  bnd_mvnprod1_show = false,
  bnd_mvnprod2_show = true,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = 107,
  bnd_title_width = 230,
  bnd_title_height = 20,
  bnd_title_color = "0xFF4942",
  bnd_title_text_color = "0xFFFFFF",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 20,
  bnd_latar1_color = "0x000000",
  bnd_latar1_color_width = 250,
  bnd_latar1_color_height = 60,
  bnd_latar1_color_alpha = 0.7,
  bnd_latar2_color = "0xFF4942",
  bnd_latar2_color_width = 250,
  bnd_latar2_color_height = 30,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xF5F5F5",
  bnd_logo = { name = "$LeagueLogo", id = "53_2" },
  bnd_logo_width = 100,
  bnd_logo_height = 22,
  bnd_logo_top = 25,
  bnd_logo_left = 180,
  
  bnd_com1_text = "",
  bnd_com1_text_top = -25,
  bnd_com1_text_left = -100,
  bnd_com1_text_alignH = "LEFT",
  bnd_com_text_fontColor = "0xF5F5F5",
  bnd_com2_text = "",
  bnd_com2_text_top = -7,
  bnd_com2_text_left = -100,
  bnd_com2_text_alignH = "LEFT",

  bnd_comimage1_top = -11,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

LALIGAHYPERMOTIONInfo = { --350x100
  bnd_mvnprod1_show = false,
  bnd_mvnprod2_show = true,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = 107,
  bnd_title_width = 230,
  bnd_title_height = 20,
  bnd_title_color = "0x04D4D4",
  bnd_title_text_color = "0xFFFFFF",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 20,
  bnd_latar1_color = "0x000000",
  bnd_latar1_color_width = 250,
  bnd_latar1_color_height = 60,
  bnd_latar1_color_alpha = 0.7,
  bnd_latar2_color = "0x04D4D4",
  bnd_latar2_color_width = 250,
  bnd_latar2_color_height = 30,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xF5F5F5",
  bnd_logo = { name = "$LeagueLogo", id = "54_2" },
  bnd_logo_width = 100,
  bnd_logo_height = 22,
  bnd_logo_top = 25,
  bnd_logo_left = 180,
  
  bnd_com1_text = "",
  bnd_com1_text_top = -25,
  bnd_com1_text_left = -100,
  bnd_com1_text_alignH = "LEFT",
  bnd_com_text_fontColor = "0xF5F5F5",
  bnd_com2_text = "",
  bnd_com2_text_top = -7,
  bnd_com2_text_left = -100,
  bnd_com2_text_alignH = "LEFT",
  
  bnd_comimage1_top = -11,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

BUNDESLIGAInfo= { --350x100
  bnd_mvnprod1_show = true,
  bnd_mvnprod2_show = false,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = -500,
  bnd_title_width = 350,
  bnd_title_height = 20,
  bnd_title_color = "0xF5F5F5",
  bnd_title_text_color = "0x000000",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 0,
  bnd_latar1_color = "0xF4F3EF",
  bnd_latar1_color_width = 270,
  bnd_latar1_color_height = 80,
  bnd_latar1_color_alpha = 0.7,
  bnd_latar2_color = "0x04F377",
  bnd_latar2_color_width = 0,
  bnd_latar2_color_height = 0,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xFFFFFF",
  bnd_logo = { name = "$LeagueLogo", id = 19 },
  bnd_logo_width = 50,
  bnd_logo_height = 50,
  bnd_logo_top = 0,
  bnd_logo_left = 0,
  
  bnd_com1_text = "",
  bnd_com1_text_top = 21,
  bnd_com1_text_left = -65,
  bnd_com1_text_alignH = "CENTER",
  bnd_com_text_fontColor = "0x151515",
  bnd_com2_text = "",
  bnd_com2_text_top = 21,
  bnd_com2_text_left = 65,
  bnd_com2_text_alignH = "CENTER",

  bnd_comimage1_top = -10,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -10,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

LIGUE1Info = { --350x100
  bnd_mvnprod1_show = false,
  bnd_mvnprod2_show = true,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = 107,
  bnd_title_width = 230,
  bnd_title_height = 20,
  bnd_title_color = "0x085EFF",
  bnd_title_text_color = "0xFFFFFF",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 20,
  bnd_latar1_color = "0x292B2A",
  bnd_latar1_color_width = 250,
  bnd_latar1_color_height = 60,
  bnd_latar1_color_alpha = 0.7,
  bnd_latar2_color = "0x292B2A",
  bnd_latar2_color_width = 250,
  bnd_latar2_color_height = 30,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xF5F5F5",
  bnd_logo = { name = "$LeagueLogo", id = "16_1" },
  bnd_logo_width = 90,
  bnd_logo_height = 25,
  bnd_logo_top = 24,
  bnd_logo_left = 180,
  
  bnd_com1_text = "",
  bnd_com1_text_top = -25,
  bnd_com1_text_left = -100,
  bnd_com1_text_alignH = "LEFT",
  bnd_com_text_fontColor = "0xF5F5F5",
  bnd_com2_text = "",
  bnd_com2_text_top = -7,
  bnd_com2_text_left = -100,
  bnd_com2_text_alignH = "LEFT",
  
  bnd_comimage1_top = -11,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

LIGUE2Info = { --350x100
  bnd_mvnprod1_show = false,
  bnd_mvnprod2_show = true,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = 107,
  bnd_title_width = 230,
  bnd_title_height = 20,
  bnd_title_color = "0x00FFCF",
  bnd_title_text_color = "0x292B2A",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 20,
  bnd_latar1_color = "0x292B2A",
  bnd_latar1_color_width = 250,
  bnd_latar1_color_height = 60,
  bnd_latar1_color_alpha = 0.7,
  bnd_latar2_color = "0x292B2A",
  bnd_latar2_color_width = 250,
  bnd_latar2_color_height = 30,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xF5F5F5",
  bnd_logo = { name = "$LeagueLogo", id = "17_1" },
  bnd_logo_width = 90,
  bnd_logo_height = 25,
  bnd_logo_top = 24,
  bnd_logo_left = 180,
  
  bnd_com1_text = "",
  bnd_com1_text_top = -25,
  bnd_com1_text_left = -100,
  bnd_com1_text_alignH = "LEFT",
  bnd_com_text_fontColor = "0xF5F5F5",
  bnd_com2_text = "",
  bnd_com2_text_top = -7,
  bnd_com2_text_left = -100,
  bnd_com2_text_alignH = "LEFT",
  
  bnd_comimage1_top = -11,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

ARKEMAInfo = { --350x100
  bnd_mvnprod1_show = false,
  bnd_mvnprod2_show = true,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = 107,
  bnd_title_width = 230,
  bnd_title_height = 20,
  bnd_title_color = "0xFFFFFF",
  bnd_title_text_color = "0x000000",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 20,
  bnd_latar1_color = "0x000943",
  bnd_latar1_color_width = 250,
  bnd_latar1_color_height = 50,
  bnd_latar1_color_alpha = 1,
  bnd_latar2_color = "0x000943",
  bnd_latar2_color_width = 0,
  bnd_latar2_color_height = 0,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xF5F5F5",
  bnd_logo = { name = "$LeagueLogoX", id = 2218 },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_top = -26,
  bnd_logo_left = 52,
  
  bnd_com1_text = "",
  bnd_com1_text_top = -25,
  bnd_com1_text_left = 0,
  bnd_com1_text_alignH = "CENTER",
  bnd_com_text_fontColor = "0xFFFFFF",
  bnd_com2_text = "",
  bnd_com2_text_top = -5,
  bnd_com2_text_left = 0,
  bnd_com2_text_alignH = "CENTER",

  bnd_comimage1_top = -17,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

SERIEAInfo = { --350x100
  bnd_mvnprod1_show = false,
  bnd_mvnprod2_show = true,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = 112,
  bnd_title_width = 225,
  bnd_title_height = 20,
  bnd_title_color = "0xFFFFFF",
  bnd_title_text_color = "0x02215D",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 20,
  bnd_latar1_color = "0x02215D",
  bnd_latar1_color_width = 250,
  bnd_latar1_color_height = 50,
  bnd_latar1_color_alpha = 1,
  bnd_latar2_color = "0x02215D",
  bnd_latar2_color_width = 0,
  bnd_latar2_color_height = 0,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xF5F5F5",
  bnd_logo = { name = "$LeagueLogo", id = "31_1" },
  bnd_logo_width = 100,
  bnd_logo_height = 100,
  bnd_logo_top = -26,
  bnd_logo_left = 52,
  
  bnd_com1_text = "",
  bnd_com1_text_top = -25,
  bnd_com1_text_left = 0,
  bnd_com1_text_alignH = "CENTER",
  bnd_com_text_fontColor = "0xF5F5F5",
  bnd_com2_text = "",
  bnd_com2_text_top = -5,
  bnd_com2_text_left = 0,
  bnd_com2_text_alignH = "CENTER",

  bnd_comimage1_top = -17,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

UCLInfo= { --350x100
  bnd_mvnprod1_show = true,
  bnd_mvnprod2_show = false,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = -500,
  bnd_title_width = 350,
  bnd_title_height = 20,
  bnd_title_color = "0xFFFFFF",
  bnd_title_text_color = "0x000000",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 0,
  bnd_latar1_color = "0x091C94",
  bnd_latar1_color_width = 270,
  bnd_latar1_color_height = 80,
  bnd_latar1_color_alpha = 0.7,
  bnd_latar2_color = "0x04F377",
  bnd_latar2_color_width = 0,
  bnd_latar2_color_height = 0,
  
  bnd_line_color = "0x04F377",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xFFFFFF",
  bnd_logo = { name = "$LeagueLogo", id = 2236 },
  bnd_logo_width = 50,
  bnd_logo_height = 50,
  bnd_logo_top = 0,
  bnd_logo_left = 0,
  
  bnd_com1_text = "",
  bnd_com1_text_top = 21,
  bnd_com1_text_left = -65,
  bnd_com1_text_alignH = "CENTER",
  bnd_com_text_fontColor = "0xFFFFFF",
  bnd_com2_text = "",
  bnd_com2_text_top = 21,
  bnd_com2_text_left = 65,
  bnd_com2_text_alignH = "CENTER",

  bnd_comimage1_top = -10,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -10,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}

BRILIGA1Info = { --350x100
  bnd_mvnprod1_show = false,
  bnd_mvnprod2_show = true,
  
  bnd_cornerRaduis = 0,
  bnd_title_left = 107,
  bnd_title_width = 230,
  bnd_title_height = 20,
  bnd_title_color = "0x3B43FF",
  bnd_title_text_color = "0xFFFFFF",
  bnd_title_text_bottom = 0,
  
  bnd_latar_color_left = 20,
  bnd_latar1_color = "0x000000",
  bnd_latar1_color_width = 250,
  bnd_latar1_color_height = 60,
  bnd_latar1_color_alpha = 0.7,
  bnd_latar2_color = "0x3B43FF",
  bnd_latar2_color_width = 250,
  bnd_latar2_color_height = 30,
  
  bnd_line_color = "0x3B43FF",
  bnd_line_color_alpha = 0,
  bnd_bgIcon_color = "0xF5F5F5",
  bnd_logo = { name = "$LeagueLogo", id = 2235 },
  bnd_logo_width = 22,
  bnd_logo_height = 22,
  bnd_logo_top = 25,
  bnd_logo_left = 180,
  
  bnd_com1_text = "",
  bnd_com1_text_top = -25,
  bnd_com1_text_left = -100,
  bnd_com1_text_alignH = "LEFT",
  bnd_com_text_fontColor = "0xF5F5F5",
  bnd_com2_text = "",
  bnd_com2_text_top = -7,
  bnd_com2_text_left = -100,
  bnd_com2_text_alignH = "LEFT",

  bnd_comimage1_top = -11,
  bnd_comimage1_left = -65,
  bnd_comimage1 = { name = "$Commentators", id = 0 },
  bnd_comimage2_top = -11,
  bnd_comimage2_left = 65,
  bnd_comimage2 = { name = "$Commentators", id = 0 }
}


function MatchInfoNPC:new(init)
  print("[MatchInfoNPC]: new()")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    eventManService = o.api("EventManagerService"),
    MatchInfoService = o.api("MatchInfoService"),
    TeamService = o.api("TeamService")
  }
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.handlerId = o.services.eventManService.RegisterHandler(function(...)
  o:handleEvent(...) end)
  
  o.nationalization = 2
  o.isActiveCom = false
  o.isActiveRef = false
  o.npcInfo = nil
  o.currentdata = nil
  o.refdata = EAFCREFInfo
  o.comdata = EAFCInfo
  
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
      o.currentdata = UCLInfo
    elseif currentCupData.cupIndex == 2 then
      o.currentdata = EAFCInfo
    end
    
  else
    if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
      o.currentdata = PREMIERLEAGUEInfo
      o.refdata.bnd_ref_Name_text_top = -25
      o.refdata.bnd_ref_Name_text_left = -50
      o.refdata.bnd_ref_Name_text_alignH = "LEFT"
      o.refdata.bnd_ref_Country_text_top = -5
      o.refdata.bnd_ref_Country_text_left = -50
      o.refdata.bnd_ref_Country_text_alignH = "LEFT"
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], WomenSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomenSuperLeagueTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      o.currentdata = LIGUE1Info
      o.refdata.bnd_ref_Name_text_top = -25
      o.refdata.bnd_ref_Name_text_left = -100
      o.refdata.bnd_ref_Name_text_alignH = "LEFT"
      o.refdata.bnd_ref_Country_text_top = -7
      o.refdata.bnd_ref_Country_text_left = -100
      o.refdata.bnd_ref_Country_text_alignH = "LEFT"
    elseif o:isInTable(o.TeamsData[1], Ligue2Teams) and o:isInTable(o.TeamsData[2], Ligue2Teams) then
      o.currentdata = LIGUE2Info
      o.refdata.bnd_ref_Name_text_top = -25
      o.refdata.bnd_ref_Name_text_left = -100
      o.refdata.bnd_ref_Name_text_alignH = "LEFT"
      o.refdata.bnd_ref_Country_text_top = -7
      o.refdata.bnd_ref_Country_text_left = -100
      o.refdata.bnd_ref_Country_text_alignH = "LEFT"
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
      o.currentdata = ARKEMAInfo
      o.refdata.bnd_ref_Name_text_top = -25
      o.refdata.bnd_ref_Name_text_left = 0
      o.refdata.bnd_ref_Name_text_alignH = "CENTER"
      o.refdata.bnd_ref_Country_text_top = -5
      o.refdata.bnd_ref_Country_text_left = 0
      o.refdata.bnd_ref_Country_text_alignH = "CENTER"
    elseif o:isInTable(o.TeamsData[1], Bundesliga1Teams) and o:isInTable(o.TeamsData[2], Bundesliga1Teams) then
      o.currentdata = BUNDESLIGAInfo
    elseif o:isInTable(o.TeamsData[1], Bundesliga2Teams) and o:isInTable(o.TeamsData[2], Bundesliga2Teams) then
      o.currentdata = BUNDESLIGAInfo
      o.currentdata.bnd_logo.id = 20
    elseif o:isInTable(o.TeamsData[1], BRILiga1Teams) and o:isInTable(o.TeamsData[2], BRILiga1Teams) then
      o.currentdata = BRILIGA1Info
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], InternationalWomansTeams) and o:isInTable(o.TeamsData[2], InternationalWomansTeams) then
      o.currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
      o.currentdata = SERIEAInfo
      o.refdata.bnd_ref_Name_text_top = -25
      o.refdata.bnd_ref_Name_text_left = 0
      o.refdata.bnd_ref_Name_text_alignH = "CENTER"
      o.refdata.bnd_ref_Country_text_top = -5
      o.refdata.bnd_ref_Country_text_left = 0
      o.refdata.bnd_ref_Country_text_alignH = "CENTER"
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
      o.refdata.bnd_ref_Name_text_top = -25
      o.refdata.bnd_ref_Name_text_left = -100
      o.refdata.bnd_ref_Name_text_alignH = "LEFT"
      o.refdata.bnd_ref_Country_text_top = -7
      o.refdata.bnd_ref_Country_text_left = -100
      o.refdata.bnd_ref_Country_text_alignH = "LEFT"
    elseif o:isInTable(o.TeamsData[1], LaligaHypermotionTeams) and o:isInTable(o.TeamsData[2], LaligaHypermotionTeams) then
      o.currentdata = LALIGAHYPERMOTIONInfo
      o.refdata.bnd_ref_Name_text_top = -25
      o.refdata.bnd_ref_Name_text_left = -100
      o.refdata.bnd_ref_Name_text_alignH = "LEFT"
      o.refdata.bnd_ref_Country_text_top = -7
      o.refdata.bnd_ref_Country_text_left = -100
      o.refdata.bnd_ref_Country_text_alignH = "LEFT"
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
      o.currentdata = EAFCInfo
      o.currentdata.bnd_title_color = "0x09BFBA"
      o.currentdata.bnd_title_text_color = "0x000000"
      o.currentdata.bnd_line_color = "0x000000"
      o.currentdata.bnd_bgIcon_color = "0x2C6ADB"
      o.currentdata.bnd_logo.id = 2222
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

  o.im.Subscribe("bnd_nationalization", function()
  end)
  o.im.Subscribe("bnd_visible_com", function()
    o:_publishActivityCom()
  end)
  o.im.Subscribe("bnd_visible_ref", function()
    o:_publishActivityRef()
  end)
  -- o.im.Subscribe("bnd_npc_info", function()
  --   o:_publishNPCInfo()
  -- end)

  for k,v in pairs(o.currentdata) do
    o.im.Subscribe(k, function()
      if k == "bnd_comimage1" or k == "bnd_com1_text"  then
        o:_publishBndCom()
      elseif k == "bnd_comimage2" or k == "bnd_com2_text" then
        o:_publishBndCom2()
      else
        o.im.Publish(k, v)
      end
    end)
  end

  for k,v in pairs(o.refdata) do
    o.im.Subscribe(k, function()
      if k == "bnd_ref_Name_text" or k == "bnd_ref_Country_text" then
        o:_publishNPCInfo()
      else
        o.im.Publish(k, v)
      end
    end)
  end
  return o
end

function MatchInfoNPC:handleEvent(eventType, data)
  if eventType == EventTypes.OverlayTypeCommentators then
    self:updateMatchInfoCommentators(data.subtype, data.hideshow, data.subtypestr, data.msg)
  elseif eventType == EventTypes.OverlayTypeIntroSequenceReferee then
    self:updateMatchInfoReferees(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function MatchInfoNPC:updateMatchInfoCommentators(subtype, hideshow, subtypestr, msg)
  print("[MatchInfoNPC]: updateMatchInfoCommentators(subtype = " .. tostring(subtype) .. ", hideshow = " .. tostring(hideshow) .. ", subtypestr = " .. tostring(subtypestr) .. ", msg = " .. tostring(msg) .. ")")
  if hideshow ~= "HIDE" then
    local params = OverlayParam.split(msg, "|")
    if params and table.getn(params) > 0 then
      self.im.Publish("bnd_nationalization", self.nationalization)
      local leagueId = params[7] + 0
      if leagueId == -1 then
        leagueId = 666
      end
       mainCommentator = params[3]
       colorCommentator = params[4]
      local gamemode = params[9]
      self.npcInfo = {
        topText = self.loc.LocalizeString("MatchCommentary"),
        middleText = " ",
        bottomText = " ",
        overlayTitle = mainCommentator.."   &   "..colorCommentator
      }
     -- self.isActiveCom = true
      if string.find(mainCommentator, "null") then
        self.isActiveCom = false
      else
         self.isActiveCom = true
      end

      self.currentdata.bnd_comimage1.id = mainCommentator
      self.currentdata.bnd_com1_text = mainCommentator
      self.comImage = self.currentdata.bnd_comimage1
      self.currentdata.bnd_comimage2.id = colorCommentator
      self.currentdata.bnd_com2_text = colorCommentator
      self.comImage2 = self.currentdata.bnd_comimage2
    end
  else
    self.isActiveCom = false
  end
  -- self:_publishNPCInfo()
  self:_publishActivityCom()
  self:_publishBndCom()
  self:_publishBndCom2()
end

function MatchInfoNPC:updateMatchInfoReferees(subtype, hideshow, subtypestr, msg)
  print("[MatchInfoNPC]: updateMatchInfoReferees(subtype = " .. tostring(subtype) .. ", hideshow = " .. tostring(hideshow) .. ", subtypestr = " .. tostring(subtypestr) .. ", msg = " .. tostring(msg) .. ")")
  if hideshow ~= "HIDE" then
    local params = OverlayParam.split(msg, "|")
    if params and table.getn(params) > 0 then
      self.im.Publish("bnd_nationalization", self.nationalization)
      local leagueId = params[5] + 0
      if leagueId == -1 then
        leagueId = 666
      end
      local refereeName = params[3]
      local refereesCountry = params[4]
      local gamemode = "友谊赛"
      self.npcInfo = {
        topText = gamemode,
        middleText = refereeName,
        bottomText = refereesCountry,
        overlayTitle = ("比赛裁判员"),
    --    leagueId = leagueId
      }
      self.isActiveRef = true
    end
  else
    self.isActiveRef = false
  end
  self:_publishNPCInfo()
  self:_publishActivityRef()
end

function MatchInfoNPC:_publishActivityCom()
  self.im.Publish("bnd_visible_com", self.isActiveCom)
end
function MatchInfoNPC:_publishActivityRef()
  self.im.Publish("bnd_visible_ref", self.isActiveRef)
end
function MatchInfoNPC:_publishBndCom()
  self.im.Publish("bnd_comimage1", self.comImage)
  self.im.Publish("bnd_com1_text", self.currentdata.bnd_com1_text)
end
function MatchInfoNPC:_publishBndCom2()
  self.im.Publish("bnd_comimage2", self.comImage2)
  self.im.Publish("bnd_com2_text", self.currentdata.bnd_com2_text)
end

function MatchInfoNPC:_publishNPCInfo()
  if self.npcInfo == nil then
    return
  end
  self.im.Publish("bnd_ref_Name_text", self.npcInfo.middleText)
  self.im.Publish("bnd_ref_Country_text", self.npcInfo.bottomText)
end

function MatchInfoNPC:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function MatchInfoNPC:finalize()
  print("[MatchInfoNPC]: finalize()")
  self.im.Unsubscribe("bnd_nationalization")
  -- self.im.Unsubscribe("bnd_npc_info")
  self.im.Unsubscribe("bnd_visible_com")
  self.im.Unsubscribe("bnd_visible_ref")
  
  for k,v in pairs(EAFCInfo) do
    self.im.Unsubscribe(k)
  end
  for k,v in pairs(EAFCREFInfo) do
    self.im.Unsubscribe(k)
  end
  self.services.eventManService.UnregisterHandler(self.handlerId)
end
return MatchInfoNPC

-- Thanks : Ma'ruf Id & Laosiji --
-- And All Modder --
-- MatchInfoNPC All League ( @mvnprodreal ) --