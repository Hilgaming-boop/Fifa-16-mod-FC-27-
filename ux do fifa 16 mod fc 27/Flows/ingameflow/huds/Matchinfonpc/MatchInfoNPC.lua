-- Thanks : Ma'ruf Id & Laosiji --
-- talamlegit.official - Patch Mod EAFC24 --

local OverlaysIdContainer, OverlayParam, eventmanager = ...
local OVERLAY_TYPES = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

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

EAFCREFINFO = {
  bnd_width_ref = 700,
  bnd_ref_height = 80,
  bnd_ref_width = 100,
  bnd_ref_top = -50,
  bnd_ref_left = -460,
  bnd_ref_color = "0x00FF7E",
  bnd_ref_logo = {
    name = "$LeagueLogo",
    id = "0_ea_dark"
  },
  bnd_ref_logo_height = 45,
  bnd_ref_logo_width = 45,
  bnd_ref_logo_left = 0,
  bnd_ref_logo_top = 5,

  bnd_reftitle_height = 20,
  bnd_reftitle_width = 300,
  bnd_reftitle_top = -100,
  bnd_reftitle_left = -260,
  bnd_reftitle_color = "0x000000",
  bnd_reftitle_text = "REFEREE",
  bnd_reftitle_fontSize = 16,
  bnd_reftitle_fontColor = "0xffffff",

  bnd_refimage_height = 30,
  bnd_refimage_width = 3,
  bnd_refimage1_top = -70,
  bnd_refimage1_left = -30000,
  bnd_refimage1_alignH = "LEFT",
  bnd_reficon_height = 30,
  bnd_reficon_width = 30,

  bnd_refimage2_top = -70,
  bnd_refimage2_right = 30000,
  bnd_refimage2_alignH = "RIGHT",

  bnd_ref_label_height = 80,
  bnd_ref_label_top = -50,
  bnd_ref_label_left = -260,
  bnd_ref_label_color = "0xE6E6E6",
  bnd_ref_Name_text = "",
  bnd_ref_Name_fontSize = 16,
  bnd_ref_Name_fontColor = "0x000000",
  bnd_ref_Name_left = 0,
  bnd_ref_Name_top = -20,

  bnd_ref_Country_text = "",
  bnd_ref_Country_fontSize = 16,
  bnd_ref_Country_fontColor = "0x000000",
  bnd_ref_Country_left = 0,
  bnd_ref_Country_top = 20
}

EAFCInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl", 
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 0
  },
  bnd_title_alpha = 1,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 500,
  bnd_com_height = 80,
  bnd_com_width = 300,
  bnd_com_top = -50,
  bnd_com_left = -260,
  bnd_com_color = "0xE6E6E6",
  bnd_com_alpha = 1,
  bnd_com1_text = "",
  bnd_com_fontSize = 15,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "CENTER",
  bnd_com1_text_left = 0,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "CENTER",
  bnd_com2_text_left = 0,
  bnd_com1_text_top = -20,
  bnd_com2_text_top = 27,
  bnd_comtitle_height = 20,
  bnd_comtitle_width = 300,
  bnd_comtitle_top = -100,
  bnd_comtitle_left = -260,
  bnd_comtitle_color = "0x000000",
  bnd_comtitle_text = "MATCH COMMENTATORS",
  bnd_comtitle_fontSize = 15,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "CENTER",
  bnd_comtitle_text_right = 60000,
  bnd_comimage_height = 40,
  bnd_comimage_width = 40,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -140,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xE6E6E6",
  bnd_comimage_alpha = 1,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -31,
  bnd_comimage2_right = 600,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea_dark"
  },
  bnd_logo_height = 65,
  bnd_logo_width = 65, 
  bnd_logo_left = -460,
  bnd_logo_top = 6,
  bnd_comlogo_width = 100,
  bnd_comlogo_height = 80,
  bnd_comlogo_color_top = -50,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x00FF7E"
}

ClassicInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Epl", 
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 1245
  },
  bnd_title_alpha = 1,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 500,
  bnd_com_height = 80,
  bnd_com_width = 300,
  bnd_com_top = -50,
  bnd_com_left = -260,
  bnd_com_color = "0xE6E6E6",
  bnd_com_alpha = 1,
  bnd_com1_text = "",
  bnd_com_fontSize = 15,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "CENTER",
  bnd_com1_text_left = 0,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "CENTER",
  bnd_com2_text_left = 0,
  bnd_com1_text_top = -20,
  bnd_com2_text_top = 27,
  bnd_comtitle_height = 20,
  bnd_comtitle_width = 300,
  bnd_comtitle_top = -100,
  bnd_comtitle_left = -260,
  bnd_comtitle_color = "0x000000",
  bnd_comtitle_text = "MATCH COMMENTATORS",
  bnd_comtitle_fontSize = 15,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "CENTER",
  bnd_comtitle_text_right = 60000,
  bnd_comimage_height = 40,
  bnd_comimage_width = 40,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -140,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xE6E6E6",
  bnd_comimage_alpha = 1,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -31,
  bnd_comimage2_right = 600,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = 1245
  },
  bnd_logo_height = 65,
  bnd_logo_width = 65, 
  bnd_logo_left = -460,
  bnd_logo_top = 6,
  bnd_comlogo_width = 100,
  bnd_comlogo_height = 80,
  bnd_comlogo_color_top = -50,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x22C1A3"
}
D1ArkemaInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 2218
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0x000000",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = -20,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 0,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "2235_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
EnglandInfo = {
  bnd_fontFace = "$Epl",
  bnd_background_show = true,
  bnd_background_height = 130,
  bnd_background_width = 1324,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 13
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 24,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 250,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 250,
  bnd_com1_text_top = -15,
  bnd_com2_text_top = -15,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "Match Commentary",
  bnd_comtitle_fontSize = 24,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 50,
  bnd_comimage_width = 50,
  bnd_comimage1_top = -80,
  bnd_comimage1_left = 22,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -80,
  bnd_comimage2_right = 22,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
FranceInfo = {
  bnd_fontFace = "$Ligue1", 
  bnd_background_show = true,
  bnd_background_height = 300,
  bnd_background_width = 800,
  bnd_background_left = 230,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 16
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -70,
  bnd_com_left = 558,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 18,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = -70,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 980,
  bnd_com1_text_top = -52,
  bnd_com2_text_top = 15,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -135,
  bnd_comtitle_left = -510,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 0,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
France2Info = {
  bnd_fontFace = "$Ligue1", 
  bnd_background_show = true,
  bnd_background_height = 300,
  bnd_background_width = 800,
  bnd_background_left = 230,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 17
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -70,
  bnd_com_left = 558,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 18,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = -70,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 980,
  bnd_com1_text_top = -52,
  bnd_com2_text_top = 15,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -135,
  bnd_comtitle_left = -510,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 0,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
GermanyInfo = {
  bnd_fontFace = "$Bundesliga", 
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 0
  },
  bnd_title_alpha = 1,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 40,
  bnd_com_width = 500,
  bnd_com_top = -80,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0.6,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0x101010",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 20,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 25,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,
  bnd_comtitle_height = 60,
  bnd_comtitle_width = 500,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xd0d0d0",
  bnd_comtitle_text = "SPEECH",
  bnd_comtitle_fontSize = 24,
  bnd_comtitle_fontColor = "0x101010",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,
  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -50,
  bnd_comimage1_left = 0,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0.4,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -50,
  bnd_comimage2_right = 0,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
Germany2Info = {
  bnd_fontFace = "$Bundesliga", 
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 0
  },
  bnd_title_alpha = 1,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 40,
  bnd_com_width = 500,
  bnd_com_top = -80,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0.6,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0x101010",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 20,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 25,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,
  bnd_comtitle_height = 60,
  bnd_comtitle_width = 500,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xd0d0d0",
  bnd_comtitle_text = "SPEECH",
  bnd_comtitle_fontSize = 24,
  bnd_comtitle_fontColor = "0x101010",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,
  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -50,
  bnd_comimage1_left = 0,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0.4,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -50,
  bnd_comimage2_right = 0,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
Germany3Info = {
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 0
  },
  bnd_title_alpha = 1,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 40,
  bnd_com_width = 500,
  bnd_com_top = -80,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0.6,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0x101010",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 20,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 25,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,
  bnd_comtitle_height = 60,
  bnd_comtitle_width = 500,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xd0d0d0",
  bnd_comtitle_text = "SPEECH",
  bnd_comtitle_fontSize = 24,
  bnd_comtitle_fontColor = "0x101010",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,
  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -50,
  bnd_comimage1_left = 0,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0.4,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -50,
  bnd_comimage2_right = 0,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
IndonesiaInfo = {
  bnd_forceCaps = true,  
  bnd_fontFace = "$Liga1",
  bnd_background_show = true,
  bnd_background_height = 109,
  bnd_background_width = 750,
  bnd_background_bottom = -2,
  bnd_background = {
    name = "$Comment",
    id = 2235
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = 0,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 305,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 325,
  bnd_com1_text_top = -26,
  bnd_com2_text_top = -26,
  
  bnd_comtitle_height = 60,
  bnd_comtitle_width = 1024,
  bnd_comtitle_top = -64,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xd0d0d0",
  bnd_comtitle_text = "Match Commentatory",
  bnd_comtitle_fontSize = 15,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 9800,

  bnd_comimage_height = 55,
  bnd_comimage_width = 55,
  bnd_comimage1_top = -27,
  bnd_comimage1_left = 68.5,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -27,
  bnd_comimage2_right = 68.5,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$",
    id = 0
  },
  bnd_logo = {
    name = "$",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
ItalyInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 31
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0x000000",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 150,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 160,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "&",
  bnd_comtitle_fontSize = 0,
  bnd_comtitle_fontColor = "0x14ffbd",
  bnd_comimage_height = 60,
  bnd_comimage_width = 60,
  bnd_comimage1_top = -50,
  bnd_comimage1_left = 0,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = false,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -50,
  bnd_comimage2_right = 0,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "2237_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
JapanInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 349
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0x000000",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 150,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 160,
  bnd_com1_text_top = 17,
  bnd_com2_text_top = 17,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "&",
  bnd_comtitle_fontSize = 0,
  bnd_comtitle_fontColor = "0x14ffbd",
  bnd_comimage_height = 60,
  bnd_comimage_width = 60,
  bnd_comimage1_top = -50,
  bnd_comimage1_left = 0,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = false,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -50,
  bnd_comimage2_right = 0,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "2237_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
LigaFInfo = { 
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 2222
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0x14FEB7",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 10,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 20,
  bnd_com1_text_top = 14,
  bnd_com2_text_top = 14,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
MalaysiaInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 2237
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0x000000",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0x14ffbd",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 170,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 180,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "&",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x14ffbd",
  bnd_comimage_height = 60,
  bnd_comimage_width = 60,
  bnd_comimage1_top = -50,
  bnd_comimage1_left = 0,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = false,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -50,
  bnd_comimage2_right = 0,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "2237_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
PegadaianLiga2Info = {  
  bnd_forceCaps = true,  
  bnd_fontFace = "$DINPro-CondBold",
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 2254
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 60,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 10,
  bnd_com1_text_top = 40,
  bnd_com2_text_top = 40,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
SpainInfo = {
  bnd_fontFace = "$LaLiga", 
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 1424,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 53
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = -70,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 980,
  bnd_com1_text_top = -30,
  bnd_com2_text_top = -5,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -135,
  bnd_comtitle_left = -510,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 20,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
Spain2Info = {
  bnd_fontFace = "$LaLiga", 
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 1424,
  bnd_background_left = 40,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 54
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = -70,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 980,
  bnd_com1_text_top = -30,
  bnd_com2_text_top = -5,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -135,
  bnd_comtitle_left = -510,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 20,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UefaInfo = {
  bnd_fontFace = "$Font_Ucl", 
  bnd_background_show = true,
  bnd_background_height = 100,
  bnd_background_width = 1024,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 2236
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 290,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 290,
  bnd_com1_text_top = 5,
  bnd_com2_text_top = 5,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -25,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 25,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UefaUelInfo = {
  bnd_background_show = true,
  bnd_background_height = 100,
  bnd_background_width = 1024,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 2238
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 290,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 290,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 25,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UefaWomensInfo = {
  bnd_background_show = true,
  bnd_background_height = 109,
  bnd_background_width = 500,
  bnd_background_bottom = -30,
  bnd_background = {
    name = "$Comment",
    id = 2240
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -40,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 24,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 325,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 328,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,

  bnd_comtitle_height = 60,
  bnd_comtitle_width = 1024,
  bnd_comtitle_top = 13,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xd0d0d0",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 13,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 9800,

  bnd_comimage_height = 55,
  bnd_comimage_width = 55,
  bnd_comimage1_top = -27,
  bnd_comimage1_left = 68.5,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -27,
  bnd_comimage2_right = 68.5,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$",
    id = 0
  },
  bnd_logo = {
    name = "$",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UnitedStatesInfo = { 
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold", 
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 39
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 100,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 110,
  bnd_com1_text_top = 25,
  bnd_com2_text_top = 25,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -83,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -83,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "350_1"
  },
  bnd_logo_height = 32,
  bnd_logo_width = 32,
  bnd_logo_left = -1,
  bnd_logo_top = -26,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
USANWSLInfo = {
  bnd_forceCaps = true,
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = 2221
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0x000000",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 40,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 470,
  bnd_com1_text_top = -29,
  bnd_com2_text_top = 19,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID5_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
VietnamInfo = { 
 bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 1424,
  bnd_background_left = 40,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 2260
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 0,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = -70,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 980,
  bnd_com1_text_top = -30,
  bnd_com2_text_top = -5,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -135,
  bnd_comtitle_left = -510,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 0,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
WomensSuperLeagueInfo = {
  bnd_forceCaps = true, 
  bnd_fontFace = "$Epl",
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -45,
  bnd_background = {
    name = "$Comment",
    id = 2216
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0x000000",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = -20,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 0,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "2235_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UefaInfo = {
  bnd_fontFace = "$UCL-Regular", 
  bnd_background_show = true,
  bnd_background_height = 100,
  bnd_background_width = 1024,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 2236
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 290,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 290,
  bnd_com1_text_top = 5,
  bnd_com2_text_top = 5,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -25,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 25,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UefaUelInfo = {
  bnd_forceCaps = true,   
  bnd_fontFace = "$DINPro-Bold",
  bnd_background_show = true,
  bnd_background_height = 100,
  bnd_background_width = 1024,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 2238
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 290,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 290,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 25,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UefaWomensInfo = {
  bnd_background_show = true,
  bnd_background_height = 109,
  bnd_background_width = 500,
  bnd_background_bottom = -30,
  bnd_background = {
    name = "$Comment",
    id = 2240
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -40,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 24,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 325,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 328,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,

  bnd_comtitle_height = 60,
  bnd_comtitle_width = 1024,
  bnd_comtitle_top = 13,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xd0d0d0",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 13,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 9800,

  bnd_comimage_height = 55,
  bnd_comimage_width = 55,
  bnd_comimage1_top = -27,
  bnd_comimage1_left = 68.5,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -27,
  bnd_comimage2_right = 68.5,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$",
    id = 0
  },
  bnd_logo = {
    name = "$",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
WorldCupInfo = { 
  bnd_fontFace = "$Qatar2022Arabic",
  bnd_background_show = true,
  bnd_background_height = 120,
  bnd_background_width = 600,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = "CupID2"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 320,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 320,
  bnd_com1_text_top = 30,
  bnd_com2_text_top = 30,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -80,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 18,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UefaUelInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$DINPro-CondBold",
  bnd_background_show = true,
  bnd_background_height = 100,
  bnd_background_width = 1024,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 2238
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 290,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 290,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -25,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "MATCH COMMENTARY",
  bnd_comtitle_fontSize = 25,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
PialaIndonesiaInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID4"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 60,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 10,
  bnd_com1_text_top = 45,
  bnd_com2_text_top = 45,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
WcWomenInfo = {
  bnd_fontFace = "$FWWC2023Bold",
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID5"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0x000000",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 150,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 160,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "&",
  bnd_comtitle_fontSize = 20,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 60,
  bnd_comimage_width = 60,
  bnd_comimage1_top = -50,
  bnd_comimage1_left = 0,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = false,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -50,
  bnd_comimage2_right = 0,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID5_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
FaCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Emirates-Bold",
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 570,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = "CupID7"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -70,
  bnd_com_left = 0,
  bnd_com_color = "",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 15,
  bnd_com1_text_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 80,
  bnd_com2_text = "",
  bnd_com2_text_fontColor = "0xffffff",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 90,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "350_1"
  },
  bnd_logo_height = 45,
  bnd_logo_width = 45,
  bnd_logo_left = 20,
  bnd_logo_top = 0,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
ueclInfo = {
  bnd_background_show = true,
  bnd_background_height = 109,
  bnd_background_width = 500,
  bnd_background_bottom = -30,
  bnd_background = {
    name = "$Comment",
    id = "CupID8"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -40,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 24,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 325,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 328,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,

  bnd_comtitle_height = 60,
  bnd_comtitle_width = 1024,
  bnd_comtitle_top = 13,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xd0d0d0",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 13,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 9800,

  bnd_comimage_height = 55,
  bnd_comimage_width = 55,
  bnd_comimage1_top = -27,
  bnd_comimage1_left = 68.5,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -27,
  bnd_comimage2_right = 68.5,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$",
    id = 0
  },
  bnd_logo = {
    name = "$",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
AsianCupInfo = {
  bnd_background_show = true,
  bnd_background_height = 109,
  bnd_background_width = 750,
  bnd_background_bottom = -2,
  bnd_background = {
    name = "$Comment",
    id = "CupID9"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -40,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 24,
  bnd_com_fontColor = "0x270551",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 345,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 365,
  bnd_com1_text_top = -1,
  bnd_com2_text_top = -1,

  bnd_comtitle_height = 60,
  bnd_comtitle_width = 1024,
  bnd_comtitle_top = 13,
  bnd_comtitle_left = 0,
  bnd_comtitle_color = "0xd0d0d0",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 13,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 9800,

  bnd_comimage_height = 55,
  bnd_comimage_width = 55,
  bnd_comimage1_top = -27,
  bnd_comimage1_left = 68.5,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -27,
  bnd_comimage2_right = 68.5,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$",
    id = 0
  },
  bnd_logo = {
    name = "$",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
KingSaudiCupInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID10"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 160,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 170,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "&",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
EuroCupInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID11"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 10,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 20,
  bnd_com1_text_top = 14,
  bnd_com2_text_top = 14,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UsaOpenCupInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID12"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 160,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 170,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "&",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
CopaAmericaInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID13"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 160,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 170,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "CupID5_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
CopaDelReyInfo = { 
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 940,
  bnd_background_left = -170,
  bnd_background_bottom = 40,
  bnd_background = {
    name = "$Comment",
    id = "CupID14"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 10,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 920,
  bnd_com1_text_top = -36,
  bnd_com2_text_top = 15,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -135,
  bnd_comtitle_left = -510,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 0,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
AfricaCupInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID15"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0x000000",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 160,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 170,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "",
  bnd_comtitle_text = "&",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID5_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
CoppaItaliaInfo = { 
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 0
  },
  bnd_title_alpha = 1,
  bnd_com_alignH = "LEFT",
  bnd_width_com = 500,
  bnd_com_height = 60,
  bnd_com_width = 400,
  bnd_com_top = -80,
  bnd_com_left = -100,
  bnd_com_color = "0xAA2C1D",
  bnd_com_alpha = 1,
  bnd_com1_text = "",
  bnd_com_fontSize = 20,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 20,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 25,
  bnd_com1_text_top = 0,
  bnd_com2_text_top = 0,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 400,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = -150,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "SPEECH",
  bnd_comtitle_fontSize = 18,
  bnd_comtitle_fontColor = "0xAA2C1D",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,
  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -50,
  bnd_comimage1_left = 0,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x018619",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = false,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -50,
  bnd_comimage2_right = -10000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "CupID15"
  },
  bnd_logo_height = 50,
  bnd_logo_width = 50,
  bnd_logo_left = -200,
  bnd_logo_top = -60,
  bnd_comlogo_width = 100,
  bnd_comlogo_height = 100,
  bnd_comlogo_alignH = "LEFT",
  bnd_comlogo_color = "0x4EC9CE"
}
DfbPokalInfo = {
  bnd_forceCaps = true,  
  bnd_background_show = true,
  bnd_background_height = 110,
  bnd_background_width = 940,
  bnd_background_left = -170,
  bnd_background_bottom = 40,
  bnd_background = {
    name = "$Comment",
    id = "CupID16"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 15,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 20,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 930,
  bnd_com1_text_top = -37,
  bnd_com2_text_top = 16,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -135,
  bnd_comtitle_left = -510,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 0,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0x00fc7f",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
CoupeDeFranceInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID17"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xffffff",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 160,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 170,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "&",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
FcwcInfo = {
  bnd_background_show = true,
  bnd_background_height = 150,
  bnd_background_width = 1424,
  bnd_background_left = 40,
  bnd_background_bottom = 15,
  bnd_background = {
    name = "$Comment",
    id = "CupID18"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 820,
  bnd_com_height = 40,
  bnd_com_width = 1024,
  bnd_com_top = -69,
  bnd_com_left = 0,
  bnd_com_color = "0xFFFFFF",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0xFFFFFF",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = -70,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 980,
  bnd_com1_text_top = -30,
  bnd_com2_text_top = -5,

  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -150,
  bnd_comtitle_left = -520,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "COMMENTARY",
  bnd_comtitle_fontSize = 16,
  bnd_comtitle_fontColor = "0xFFFFFF",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "RIGHT",
  bnd_comtitle_text_right = 60000,

  bnd_comimage_height = 100,
  bnd_comimage_width = 100,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -1000,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xFFFFFF",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -70,
  bnd_comimage2_right = -1000,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = "0_ea"
  },
  bnd_logo_height = 40,
  bnd_logo_width = 40,
  bnd_logo_left = 0,
  bnd_logo_top = -50000,
  bnd_comlogo_width = 40,
  bnd_comlogo_height = 40,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0xFFFFFF"
}
CopaLibertadoresInfo = {
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID19"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 90,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 90,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
UefaNationsInfo = {
  bnd_fontFace = "$UEFANations-Bold", 
  bnd_background_show = true,
  bnd_background_height = 210,
  bnd_background_width = 700,
  bnd_background_bottom = -40,
  bnd_background = {
    name = "$Comment",
    id = "CupID20"
  },
  bnd_title_alpha = 0,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 700,
  bnd_com_height = 60,
  bnd_com_width = 600,
  bnd_com_top = -50,
  bnd_com_left = 0,
  bnd_com_color = "0xffffff",
  bnd_com_alpha = 0,
  bnd_com1_text = "",
  bnd_com_fontSize = 25,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "LEFT",
  bnd_com1_text_left = 90,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "RIGHT",
  bnd_com2_text_right = 90,
  bnd_com1_text_top = 20,
  bnd_com2_text_top = 20,
  bnd_comtitle_height = 40,
  bnd_comtitle_width = 100,
  bnd_comtitle_top = -30,
  bnd_comtitle_left = 40,
  bnd_comtitle_color = "0xffffff",
  bnd_comtitle_text = "",
  bnd_comtitle_fontSize = 30,
  bnd_comtitle_fontColor = "0x000000",
  bnd_comimage_height = 70,
  bnd_comimage_width = 70,
  bnd_comimage1_top = -85,
  bnd_comimage1_left = 230,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xffffff",
  bnd_comimage_alpha = 0,
  bnd_comimage1 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_comimage_visible = true,
  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -85,
  bnd_comimage2_right = 230,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators1",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "350_1"
  },
  bnd_logo_height = 30,
  bnd_logo_width = 30,
  bnd_logo_left = -310,
  bnd_logo_top = -30,
  bnd_comlogo_width = 0,
  bnd_comlogo_height = 0,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0x38003d"
}
AseanChampionshipInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSans-Medium", 
  bnd_background_show = false,
  bnd_background_height = 0,
  bnd_background_width = 0,
  bnd_background_bottom = 0,
  bnd_background = {
    name = "$Comment",
    id = 0
  },
  bnd_title_alpha = 1,
  bnd_com_alignH = "CENTER",
  bnd_width_com = 500,
  bnd_com_height = 80,
  bnd_com_width = 300,
  bnd_com_top = -50,
  bnd_com_left = -260,
  bnd_com_color = "0xE6E6E6",
  bnd_com_alpha = 1,
  bnd_com1_text = "",
  bnd_com_fontSize = 15,
  bnd_com_fontColor = "0x000000",
  bnd_com1_text_alignH = "CENTER",
  bnd_com1_text_left = 0,
  bnd_com2_text = "",
  bnd_com2_text_alignH = "CENTER",
  bnd_com2_text_left = 0,
  bnd_com1_text_top = -20,
  bnd_com2_text_top = 27,
  bnd_comtitle_height = 20,
  bnd_comtitle_width = 300,
  bnd_comtitle_top = -100,
  bnd_comtitle_left = -260,
  bnd_comtitle_color = "0x000000",
  bnd_comtitle_text = "MATCH COMMENTATORS",
  bnd_comtitle_fontSize = 15,
  bnd_comtitle_fontColor = "0xffffff",
  bnd_comtitle_text_alignH = "CENTER",
  bnd_comtitle_text_left = 0,
  bnd_comtitle_text2_alignH = "CENTER",
  bnd_comtitle_text_right = 60000,
  bnd_comimage_height = 40,
  bnd_comimage_width = 40,
  bnd_comimage1_top = -70,
  bnd_comimage1_left = -140,
  bnd_comimage1_alignH = "LEFT",
  bnd_comimage1_color = "0xE6E6E6",
  bnd_comimage_alpha = 1,
  bnd_comimage1 = {
    name = "$Commentators",
    id = 0
  },
  bnd_comimage_visible = true,

  bnd_comicon_visible = false,
  bnd_comicon_height = 30,
  bnd_comicon_width = 30,

  bnd_comimage2_top = -31,
  bnd_comimage2_right = 600,
  bnd_comimage2_alignH = "RIGHT",
  bnd_comimage2 = {
    name = "$Commentators",
    id = 0
  },
  bnd_logo = {
    name = "$LeagueLogo",
    id = 27
  },
  bnd_logo_height = 65,
  bnd_logo_width = 65, 
  bnd_logo_left = -460,
  bnd_logo_top = 6,
  bnd_comlogo_width = 100,
  bnd_comlogo_height = 80,
  bnd_comlogo_color_top = -50,
  bnd_comlogo_alignH = "CENTER",
  bnd_comlogo_color = "0xFF0700"
}
local MatchInfoNPC = {}

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
  
  local AlgeriaTeams = o.services.TeamService.GetTeams(leagueIDs.Algeria, 0, 0, true)
  local AfcTeams = o.services.TeamService.GetTeams(leagueIDs.Afc, 0, 0, true)
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
  local WomensSuperLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.WomensSuperLeague, 0, 0, true)

  o.handlerId = o.services.eventManService.RegisterHandler(function(...)
    o:handleEvent(...)
  end)
  o.nationalization = 2
  o.isActiveCom = false
  o.isActiveRef = false
  o.npcInfo = nil

  o.currentdata = nil
  o.refdata = EAFCREFINFO

  if currentCupData.cupIndex > 0 then
    if currentCupData.cupIndex == 1 then
       o.currentdata = UefaInfo
       o.refdata.bnd_ref_color = "0x020897"
       o.refdata.bnd_ref_logo.id = 2236
    o.refdata.bnd_ref_logo_height = 40
    o.refdata.bnd_ref_logo_width = 40
    
    elseif currentCupData.cupIndex == 2 then
    o.currentdata = WorldCupInfo
    o.refdata.bnd_ref_color = "0x43162b"
    o.refdata.bnd_ref_logo.id = "CupID2"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
  
    elseif currentCupData.cupIndex == 3 then
    o.currentdata = UefaUelInfo
    o.refdata.bnd_ref_color = "0x1F2120"
    o.refdata.bnd_ref_logo.id = 2238
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    
    elseif currentCupData.cupIndex == 4 then
    o.currentdata = PialaIndonesiaInfo
    o.refdata.bnd_ref_logo.id = "CupID4"
    o.refdata.bnd_ref_logo_height = 80
    o.refdata.bnd_ref_logo_width = 80
    
    elseif currentCupData.cupIndex == 5 then
    o.currentdata = WcWomenInfo
    o.refdata.bnd_ref_color = "0xC5C8B7"
    o.refdata.bnd_ref_logo.id = "CupID5"
    o.refdata.bnd_ref_logo_height = 80
    o.refdata.bnd_ref_logo_width = 80
    
    elseif currentCupData.cupIndex == 6 then
    o.currentdata = UefaWomensInfo
    o.refdata.bnd_ref_color = "0x3471B2"
    o.refdata.bnd_ref_logo.id = 2240
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    
    elseif currentCupData.cupIndex == 7 then
    o.currentdata = FaCupInfo
    o.refdata.bnd_ref_color = "0xBF0D19"
    o.refdata.bnd_ref_logo.id = "CupID7"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    
    elseif currentCupData.cupIndex == 8 then
    o.currentdata = ueclInfo
    o.refdata.bnd_ref_color = "0x000000"
    o.refdata.bnd_ref_logo.id = "CupID8"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
    elseif currentCupData.cupIndex == 9 then
    o.currentdata = AsianCupInfo
    o.refdata.bnd_ref_color = "0x270551"
    o.refdata.bnd_ref_logo.id = "CupID9"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    
    elseif currentCupData.cupIndex == 10 then
    o.currentdata = KingSaudiCupInfo
    o.refdata.bnd_ref_color = "0x17573B"
    o.refdata.bnd_ref_logo.id = "CupID10"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    
    elseif currentCupData.cupIndex == 11 then
    o.currentdata = EuroCupInfo
    o.refdata.bnd_ref_color = "0x133BD9"
    o.refdata.bnd_ref_logo.id = "CupID11"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
    elseif currentCupData.cupIndex == 12 then
    o.currentdata = UsaOpenCupInfo
    o.refdata.bnd_ref_color = "0xC6142E"
    o.refdata.bnd_ref_logo.id = "CupID12"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
    elseif currentCupData.cupIndex == 13 then
    o.currentdata = CopaAmericaInfo
    o.refdata.bnd_ref_color = "0x071A31"
    o.refdata.bnd_ref_logo.id = "CupID13"
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
    
    elseif currentCupData.cupIndex == 14 then
    o.currentdata = CopaDelReyInfo
    o.refdata.bnd_ref_color = "0xE60035"
    o.refdata.bnd_ref_logo.id = "CupID14"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
  elseif currentCupData.cupIndex == 15 then
    o.currentdata = CoppaItaliaInfo
    o.refdata.bnd_ref_color = "0x4EC9CE"
    o.refdata.bnd_ref_logo.id = "CupID15"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
  elseif currentCupData.cupIndex == 16 then
    o.currentdata = DfbPokalInfo
    o.refdata.bnd_ref_color = "0x089655"
    o.refdata.bnd_ref_logo.id = "CupID16"
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
    
  elseif currentCupData.cupIndex == 17 then
    o.currentdata = CoupeDeFranceInfo
    o.refdata.bnd_ref_color = "0x071A31"
    o.refdata.bnd_ref_logo.id = "CupID17"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
  elseif currentCupData.cupIndex == 18 then
    o.currentdata = FcwcInfo
    o.refdata.bnd_ref_color = "0x7000A4"
    o.refdata.bnd_ref_logo.id = "CupID18"
    o.refdata.bnd_ref_logo_height = 80
    o.refdata.bnd_ref_logo_width = 80
    
  elseif currentCupData.cupIndex == 19 then
    o.currentdata = CopaLibertadoresInfo
    o.refdata.bnd_ref_color = "0x000000"
    o.refdata.bnd_ref_logo.id = "CupID19"
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
   
  elseif currentCupData.cupIndex == 20 then
    o.currentdata = UefaNationsInfo
    o.refdata.bnd_ref_color = "0x253242"
    o.refdata.bnd_ref_logo.id = "CupID20"
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
    end
  elseif currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
       o.currentdata = UefaInfo
       o.refdata.bnd_ref_color = "0x020897"
       o.refdata.bnd_ref_logo.id = 2236
    o.refdata.bnd_ref_logo_height = 40
    o.refdata.bnd_ref_logo_width = 40
    
    elseif currentTourData.tourIndex == 2 then
    o.currentdata = WorldCupInfo
    o.refdata.bnd_ref_color = "0x43162b"
    o.refdata.bnd_ref_logo.id = "CupID2"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
  
    elseif currentTourData.tourIndex == 3 then
    o.currentdata = UefaUelInfo
    o.refdata.bnd_ref_color = "0x1F2120"
    o.refdata.bnd_ref_logo.id = 2238
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    
    elseif currentTourData.tourIndex == 29 then
    o.currentdata = PialaIndonesiaInfo
    o.refdata.bnd_ref_logo.id = "CupID4"
    o.refdata.bnd_ref_logo_height = 80
    o.refdata.bnd_ref_logo_width = 80
    
    elseif currentTourData.tourIndex == 27 then
    o.currentdata = AseanChampionshipInfo
    o.refdata.bnd_ref_color = "0xFF0700"    
    o.refdata.bnd_ref_logo.id = 27
    o.refdata.bnd_ref_logo_height = 75
    o.refdata.bnd_ref_logo_width = 75
    o.refdata.bnd_ref_logo_top = 5   
    
    elseif currentTourData.tourIndex == 35 then
    o.currentdata = WcWomenInfo
    o.refdata.bnd_ref_color = "0xC5C8B7"
    o.refdata.bnd_ref_logo.id = "CupID5"
    o.refdata.bnd_ref_logo_height = 80
    o.refdata.bnd_ref_logo_width = 80

    elseif currentTourData.tourIndex == 16 then
    o.currentdata = UefaWomensInfo
    o.refdata.bnd_ref_color = "0x3471B2"
    o.refdata.bnd_ref_logo.id = 2240
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    
    elseif currentTourData.tourIndex == 9 then
    o.currentdata = FaCupInfo
    o.refdata.bnd_ref_color = "0xBF0D19"
    o.refdata.bnd_ref_logo.id = "CupID7"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    
    elseif currentTourData.tourIndex == 17 then
    o.currentdata = ueclInfo
    o.refdata.bnd_ref_color = "0x000000"
    o.refdata.bnd_ref_logo.id = "CupID8"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
    elseif currentTourData.tourIndex == 34 then
    o.currentdata = AsianCupInfo
    o.refdata.bnd_ref_color = "0x270551"
    o.refdata.bnd_ref_logo.id = "CupID9"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60   
    
    elseif currentTourData.tourIndex == 6 then
    o.currentdata = EuroCupInfo
    o.refdata.bnd_ref_color = "0x133BD9"
    o.refdata.bnd_ref_logo.id = "CupID11"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
    elseif currentTourData.tourIndex == 13 then
    o.currentdata = UsaOpenCupInfo
    o.refdata.bnd_ref_color = "0xC6142E"
    o.refdata.bnd_ref_logo.id = "CupID12"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
    elseif currentTourData.tourIndex == 25 then
    o.currentdata = CopaAmericaInfo
    o.refdata.bnd_ref_color = "0x071A31"
    o.refdata.bnd_ref_logo.id = "CupID13"
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
    
    elseif currentTourData.tourIndex == 10 then
    o.currentdata = CopaDelReyInfo
    o.refdata.bnd_ref_color = "0xE60035"
    o.refdata.bnd_ref_logo.id = "CupID14"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
  elseif currentTourData.tourIndex == 11 then
    o.currentdata = CoppaItaliaInfo
    o.refdata.bnd_ref_color = "0x4EC9CE"
    o.refdata.bnd_ref_logo.id = "CupID15"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
  elseif currentTourData.tourIndex == 7 then
    o.currentdata = DfbPokalInfo
    o.refdata.bnd_ref_color = "0x089655"
    o.refdata.bnd_ref_logo.id = "CupID16"
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
    
  elseif currentTourData.tourIndex == 18 then
    o.currentdata = CoupeDeFranceInfo
    o.refdata.bnd_ref_color = "0x071A31"
    o.refdata.bnd_ref_logo.id = "CupID17"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    
  elseif currentTourData.tourIndex == 15 then
    o.currentdata = FcwcInfo
    o.refdata.bnd_ref_color = "0x7000A4"
    o.refdata.bnd_ref_logo.id = "CupID18"
    o.refdata.bnd_ref_logo_height = 80
    o.refdata.bnd_ref_logo_width = 80
    
  elseif currentTourData.tourIndex == 4 then
    o.currentdata = CopaLibertadoresInfo
    o.refdata.bnd_ref_color = "0x000000"
    o.refdata.bnd_ref_logo.id = "CupID19"
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55

    elseif currentTourData.tourIndex == 50 then
    o.currentdata = KingSaudiCupInfo
    o.refdata.bnd_ref_color = "0x17573B"
    o.refdata.bnd_ref_logo.id = "CupID10"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
  
  elseif currentTourData.tourIndex == 22 then
    o.currentdata = ClassicInfo
    o.refdata.bnd_ref_color = "0x22C1A3"    
    o.refdata.bnd_ref_logo.id = 1245
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 1245
    o.currentdata.bnd_logo_top = 14    
   
  elseif currentTourData.tourIndex == 28 then
    o.currentdata = UefaNationsInfo
    o.refdata.bnd_ref_color = "0x253242"
    o.refdata.bnd_ref_logo.id = "CupID20"
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
  elseif currentTourData.tourIndex == 24 then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = "CupID24"
    o.refdata.bnd_ref_logo_height = 75
    o.refdata.bnd_ref_logo_width = 75
    o.currentdata.bnd_logo.id = "CupID24"    
    o.refdata.bnd_ref_logo_top = 5
    
  elseif currentTourData.tourIndex == 31 then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = "CupID31"
    o.refdata.bnd_ref_logo_height = 75
    o.refdata.bnd_ref_logo_width = 75
    o.currentdata.bnd_logo.id = "CupID31"    
    o.refdata.bnd_ref_logo_top = 5
   
  elseif currentTourData.tourIndex == 21 then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = "CupID21"
    o.refdata.bnd_ref_logo_height = 75
    o.refdata.bnd_ref_logo_width = 75
    o.currentdata.bnd_logo.id = "CupID21"    
    o.refdata.bnd_ref_logo_top = 5
    else 
      o.currentdata = EAFCInfo        
    end    
  else
    if o:isInTable(o.TeamsData[1], AlgeriaTeams) and o:isInTable(o.TeamsData[2], AlgeriaTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 2262
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], AfcTeams) and o:isInTable(o.TeamsData[2], AfcTeams) then
    o.currentdata = AsianCupInfo
    o.refdata.bnd_ref_color = "0x270551"
    o.refdata.bnd_ref_logo.id = "CupID9"
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    elseif o:isInTable(o.TeamsData[1], ArgentinaTeams) and o:isInTable(o.TeamsData[2], ArgentinaTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 353
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 353
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], AsianCupU23Teams) and o:isInTable(o.TeamsData[2], AsianCupU23Teams) then
    o.currentdata = AsianCupU23Info
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 2264
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], BelgiumTeams) and o:isInTable(o.TeamsData[2], BelgiumTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 4
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 4
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], BrazilTeams) and o:isInTable(o.TeamsData[2], BrazilTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 7
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 7
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], ClassicTeams) and o:isInTable(o.TeamsData[2], ClassicTeams) then
    o.currentdata = ClassicInfo
    o.refdata.bnd_ref_color = "0x6C0016"
    o.refdata.bnd_ref_logo.id = 1245
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], Classic2Teams) and o:isInTable(o.TeamsData[2], Classic2Teams) then
    o.currentdata = ClassicInfo
    o.refdata.bnd_ref_color = "0x6C0016"
    o.refdata.bnd_ref_logo.id = 1245
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], ChampionshipEflTeams) and o:isInTable(o.TeamsData[2], ChampionshipEflTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 14
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 14
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], D1ArkemaTeams) and o:isInTable(o.TeamsData[2], D1ArkemaTeams) then
    o.currentdata = D1ArkemaInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 2218
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], DenmarkTeams) and o:isInTable(o.TeamsData[2], DenmarkTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 1
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], EcuadorTeams) and o:isInTable(o.TeamsData[2], EcuadorTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 2018
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], EgyptTeams) and o:isInTable(o.TeamsData[2], EgyptTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 2231
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 2231
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], EnglandTeams) and o:isInTable(o.TeamsData[2], EnglandTeams) then
    o.currentdata = EnglandInfo
    o.refdata.bnd_ref_color = "0x2F0B3A"
    o.refdata.bnd_ref_logo.id = "13_1"
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], FranceTeams) and o:isInTable(o.TeamsData[2], FranceTeams) then
    o.currentdata = FranceInfo
    o.refdata.bnd_ref_color = "0x304FFF"
    o.refdata.bnd_ref_logo.id = 16
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], France2Teams) and o:isInTable(o.TeamsData[2], France2Teams) then
    o.currentdata = France2Info
    o.refdata.bnd_ref_color = "0x02FFCE"
    o.refdata.bnd_ref_logo.id = "17_1"
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], GermanyTeams) and o:isInTable(o.TeamsData[2], GermanyTeams) then
    o.currentdata = GermanyInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 19
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
 elseif o:isInTable(o.TeamsData[1], Germany2Teams) and o:isInTable(o.TeamsData[2], Germany2Teams) then
    o.currentdata = Germany2Info
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 20
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
   elseif o:isInTable(o.TeamsData[1], IndonesiaTeams) and o:isInTable(o.TeamsData[2], IndonesiaTeams) then
    o.currentdata = IndonesiaInfo
    o.refdata.bnd_ref_color = "0x00519D"
    o.refdata.bnd_ref_logo.id = "2235_1"
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
   elseif o:isInTable(o.TeamsData[1], InternationalTeams) and o:isInTable(o.TeamsData[2], InternationalTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 78
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 78
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], International2Teams) and o:isInTable(o.TeamsData[2], International2Teams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 2136
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 2136
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], ItalyTeams) and o:isInTable(o.TeamsData[2], ItalyTeams) then
    o.currentdata = ItalyInfo
    o.refdata.bnd_ref_color = "0x0F2D61"
    o.refdata.bnd_ref_logo.id = 31
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
  elseif o:isInTable(o.TeamsData[1], JapanTeams) and o:isInTable(o.TeamsData[2], JapanTeams) then
    o.currentdata = JapanInfo
    o.refdata.bnd_ref_color = "0x000000"
    o.refdata.bnd_ref_logo.id = 349
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = -2
    elseif o:isInTable(o.TeamsData[1], KoreaRepublicTeams) and o:isInTable(o.TeamsData[2], KoreaRepublicTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 83
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 83
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], LeagueOneEflTeams) and o:isInTable(o.TeamsData[2], LeagueOneEflTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 60
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 60
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], LeagueTwoEflTeams) and o:isInTable(o.TeamsData[2], LeagueTwoEflTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 61
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    elseif o:isInTable(o.TeamsData[1], LigaFTeams) and o:isInTable(o.TeamsData[2], LigaFTeams) then
    o.currentdata = LigaFInfo
    o.refdata.bnd_ref_color = "0x031D4E"
    o.refdata.bnd_ref_logo.id = 2222
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
    elseif o:isInTable(o.TeamsData[1], MalaysiaTeams) and o:isInTable(o.TeamsData[2], MalaysiaTeams) then
    o.currentdata = MalaysiaInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 2237
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    elseif o:isInTable(o.TeamsData[1], MexicoTeams) and o:isInTable(o.TeamsData[2], MexicoTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = "341_1"
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = "341_1"
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], MoroccoTeams) and o:isInTable(o.TeamsData[2], MoroccoTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 2250
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 2250
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], NetherlandsTeams) and o:isInTable(o.TeamsData[2], NetherlandsTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 10
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 10
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], PegadaianLiga2Teams) and o:isInTable(o.TeamsData[2], PegadaianLiga2Teams) then
    o.currentdata = PegadaianLiga2Info
    o.refdata.bnd_ref_color = "0x0D6046"
    o.refdata.bnd_ref_logo.id = 2254
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = -2
    elseif o:isInTable(o.TeamsData[1], PortugalTeams) and o:isInTable(o.TeamsData[2], PortugalTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = "308_1"
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = "308_1"
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], RestOfWorldTeams) and o:isInTable(o.TeamsData[2], RestOfWorldTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 76
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 76
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], RestOfWorld2Teams) and o:isInTable(o.TeamsData[2], RestOfWorld2Teams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 76
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 76
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], RusiaTeams) and o:isInTable(o.TeamsData[2], RusiaTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 67
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
     elseif o:isInTable(o.TeamsData[1], SaudiArabiaTeams) and o:isInTable(o.TeamsData[2], SaudiArabiaTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = "350_2"
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = "350_2"
    o.currentdata.bnd_comlogo_color = "0xffffff"
    elseif o:isInTable(o.TeamsData[1], ScotlandTeams) and o:isInTable(o.TeamsData[2], ScotlandTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 50
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 50
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], SouthAfricaTeams) and o:isInTable(o.TeamsData[2], SouthAfricaTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 347
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 347
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], SpainTeams) and o:isInTable(o.TeamsData[2], SpainTeams) then
    o.currentdata = SpainInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = "53_1"
    o.refdata.bnd_ref_logo_height = 65
    o.refdata.bnd_ref_logo_width = 65
    o.refdata.bnd_ref_logo_top = -2
    elseif o:isInTable(o.TeamsData[1], Spain2Teams) and o:isInTable(o.TeamsData[2], Spain2Teams) then
    o.currentdata = Spain2Info
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = "54_1"
    o.refdata.bnd_ref_logo_height = 65
    o.refdata.bnd_ref_logo_width = 65
    o.refdata.bnd_ref_logo_top = -2
    elseif o:isInTable(o.TeamsData[1], SwitzerlandTeams) and o:isInTable(o.TeamsData[2], SwitzerlandTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 189
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    elseif o:isInTable(o.TeamsData[1], ThailandTeams) and o:isInTable(o.TeamsData[2], ThailandTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 2252
    o.refdata.bnd_ref_color = "0xFE0000"
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 2252
    o.currentdata.bnd_comlogo_color = "0xFE0000"
    elseif o:isInTable(o.TeamsData[1], TurkeyTeams) and o:isInTable(o.TeamsData[2], TurkeyTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = 68
    o.refdata.bnd_ref_logo_height = 70
    o.refdata.bnd_ref_logo_width = 70
    o.refdata.bnd_ref_logo_top = 0    
    o.currentdata.bnd_logo.id = 68
    o.currentdata.bnd_logo_top = 14
    elseif o:isInTable(o.TeamsData[1], UefaTeams) and o:isInTable(o.TeamsData[2], UefaTeams) then
    o.currentdata = UefaInfo
    o.refdata.bnd_ref_color = "0x020897"
    o.refdata.bnd_ref_logo.id = 2236
    o.refdata.bnd_ref_logo_height = 40
    o.refdata.bnd_ref_logo_width = 40
  elseif o:isInTable(o.TeamsData[1], UefaUelTeams) and o:isInTable(o.TeamsData[2], UefaUelTeams) then
    o.currentdata = UefaUelInfo
    o.refdata.bnd_ref_color = "0x38003d"
    o.refdata.bnd_ref_logo.id = "2238_1"
    o.refdata.bnd_ref_logo_height = 80
    o.refdata.bnd_ref_logo_width = 80
  elseif o:isInTable(o.TeamsData[1], UefaWomensTeams) and o:isInTable(o.TeamsData[2], UefaWomensTeams) then
    o.currentdata = UefaWomensInfo
    o.refdata.bnd_ref_color = "0x38003d"
    o.refdata.bnd_ref_logo.id = 2240
    o.refdata.bnd_ref_logo_height = 60
    o.refdata.bnd_ref_logo_width = 60
    elseif o:isInTable(o.TeamsData[1], UkraineTeams) and o:isInTable(o.TeamsData[2], UkraineTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 332
    o.refdata.bnd_ref_logo_height = 55
    o.refdata.bnd_ref_logo_width = 55
  elseif o:isInTable(o.TeamsData[1], UnitedStatesTeams) and o:isInTable(o.TeamsData[2], UnitedStatesTeams) then
    o.currentdata = UnitedStatesInfo
    o.refdata.bnd_ref_color = "0x000000"
    o.refdata.bnd_ref_logo.id = "39_1"
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
  elseif o:isInTable(o.TeamsData[1], USANWSLTeams) and o:isInTable(o.TeamsData[2], USANWSLTeams) then
    o.currentdata = USANWSLInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 2221
    o.refdata.bnd_ref_logo_height = 40
    o.refdata.bnd_ref_logo_width = 40
  elseif o:isInTable(o.TeamsData[1], VanaramaFootballLeagueTeams) and o:isInTable(o.TeamsData[2], VanaramaFootballLeagueTeams) then
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 62
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
  elseif o:isInTable(o.TeamsData[1], VietnamTeams) and o:isInTable(o.TeamsData[2], VietnamTeams) then
    o.currentdata = VietnamInfo
    o.refdata.bnd_ref_color = "0xffffff"
    o.refdata.bnd_ref_logo.id = 2260
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
  elseif o:isInTable(o.TeamsData[1], WomensSuperLeagueTeams) and o:isInTable(o.TeamsData[2], WomensSuperLeagueTeams) then
    o.currentdata = WomensSuperLeagueInfo
    o.refdata.bnd_ref_color = "0x1D0F33"
    o.refdata.bnd_ref_logo.id = 2216
    o.refdata.bnd_ref_logo_height = 50
    o.refdata.bnd_ref_logo_width = 50
    o.refdata.bnd_ref_logo_top = -2
  else 
    o.currentdata = EAFCInfo
    o.refdata.bnd_ref_logo.id = "0_ea_dark"
    o.refdata.bnd_ref_logo_height = 75
    o.refdata.bnd_ref_logo_width = 75
    o.refdata.bnd_ref_logo_top = 5
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
      local gamemode = ""
      self.npcInfo = {
        topText = gamemode,
        middleText = refereeName,
        bottomText = refereesCountry,
        overlayTitle = (""),
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
  
  for k,v in pairs(EnglandInfo) do
    self.im.Unsubscribe(k)
  end
  for k,v in pairs(EAFCREFINFO) do
    self.im.Unsubscribe(k)
  end
  self.services.eventManService.UnregisterHandler(self.handlerId)
end
return MatchInfoNPC
