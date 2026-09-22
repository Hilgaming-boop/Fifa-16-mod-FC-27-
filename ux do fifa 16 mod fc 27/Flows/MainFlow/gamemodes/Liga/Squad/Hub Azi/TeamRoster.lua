-----------------------------------------------
---- CAREER MODE DAVUN ----
-- REMOD LITLE SEPTIAWAN--
-----------------------------------------------

local Timer = ...
local TeamRoster = {}

local bndPlayerList = "bnd_player_list"

local ACT_PLAYER_SELECT = "act_player_select"
local ACT_HIDE = "act_hide"
local ACT_RELEASE = "act_release"
local ACT_TOGGLE = "act_toggle"
local ACT_SQUAD = "act_squad"
local ACT_CONTRACT = "act_contract"
local ACT_SEPTIAWAN_CLICK = "act_septiawan_click"
local BND_TAB1_SELECT_VISIBLE = "bnd_tab1_select_visible"
local BND_TAB2_SELECT_VISIBLE = "bnd_tab2_select_visible"
local BND_TAB3_SELECT_VISIBLE = "bnd_tab3_select_visible"
local TAB1_1 = 1
local TAB2_2 = 2
local TAB3_3 = 3

local PlayerListData = {}
local teamPlayers = {}
local playerData
local statsubs = {"gs", "cs", "yc", "rc"}
local toggle = false

TeamID = 0
LEAGUE = currentLeagueIndex

function TeamRoster:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService"),
    gameSetup = o.api("GameSetupService")
  }
  TeamID = currentSelectedTeamID
  o.visible = true
  o.rowvisible = true
  o.panelvisible = false
  o.statvisible = false
  o.infovisible = true
  o.currentIndex = 0
  o.oldIndex = -1
  o.buttonsID = { TAB1_1, TAB2_2, TAB3_3 }
  o:HideSelections()
  o.im.Publish(BND_TAB1_SELECT_VISIBLE, true)
  o.im.Subscribe(BND_TAB1_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB2_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe(BND_TAB3_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe("bnd_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_loading_visible", function()
    o:publishVisible()
  end)
-- 🔹 O.IM SUBSCRIBE EVENT
o.im.Subscribe("bnd_leaguebackground", function()
  local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_leaguebackground", bg)
end)
  o.im.Subscribe("bnd_background_visible", function()
    o:publishBg()
  end)
  o.im.Subscribe("bnd_table_visible", function()
    o:publishBg()
  end)
  o.im.Subscribe("bnd_rowvisible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_panelvisible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_panelanim", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_plstat_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_plinfo_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_team_crest", function()
    o.im.Publish("bnd_team_crest", {
      name = "$Crest64x64",
      id = TeamID
    })
  end)
  o.im.Subscribe("bnd_team_name", function()
    o.im.Publish("bnd_team_name", o.loc.LocalizeString("TeamName_Abbr15_"..TeamID))
  end)
  o.im.Subscribe("bnd_player_avatar", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_country", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_style", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_style_position", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_role", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_morale", function()
    o:publishPlayerInfo()
  end)  
  o.im.Subscribe("bnd_player_3d", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_name", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_role_name", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_country_name", function()
    o:publishPlayerInfo()
  end)  
  o.im.Subscribe("bnd_player_ID", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_position", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_number", function()
    o:publishPlayerInfo()
    end)
  o.im.Subscribe("bnd_player_level_up", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_salary", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_value", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_fitness", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_suspstatus", function()
    o:publishPlayerInfo()
  end)  
  o.im.Subscribe("bnd_player_rating", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_rating_color", function()
    o:publishPlayerInfo()
  end)  
  for i = 1, 6 do
    o.im.Subscribe("bnd_player_stat"..i, function()
        o:publishPlayerInfo()
    end)

    o.im.Subscribe("bnd_player_stat_color"..i, function()
        o:publishPlayerInfo()
    end)
end
        
  for i = 1, 4 do
    o.im.Subscribe("bnd_friendly".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end
  for i = 1, 4 do
    o.im.Subscribe("bnd_dom".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end
  for i = 1, 4 do
    o.im.Subscribe("bnd_total".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end

  o:Init()
  o.im.Subscribe(bndPlayerList, function()
    o:publishPlayerRows()
  end)
  o.im.RegisterAction(ACT_PLAYER_SELECT, function(actionName, data)
    if data then
      o:publishPlayerDetail(data)
    end
  end)
  o.im.RegisterAction(ACT_HIDE, function(actionName, data)
    o:hidePanel()
  end)
  o.im.RegisterAction(ACT_RELEASE, function(actionName, data)
    o:infoRelease()
  end)
  o.im.RegisterAction(ACT_TOGGLE, function(actionName, data)
    o:toggleView()
  end)
  o.im.RegisterAction(ACT_SQUAD, function(actionName, data)
    o:infoSquad()
  end)
  o.im.RegisterAction(ACT_CONTRACT, function(actionName, data)
    o:infoContract()
  end)
  o.im.RegisterAction(ACT_SEPTIAWAN_CLICK, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1_1 then
      o.im.Publish(BND_TAB1_SELECT_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2_2 then
      o.im.Publish(BND_TAB2_SELECT_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB3_3 then
      o.im.Publish(BND_TAB3_SELECT_VISIBLE, true)
    end
  end)
  
  return o
end

function TeamRoster:HideSelections()
  self.im.Publish(BND_TAB1_SELECT_VISIBLE, false)
  self.im.Publish(BND_TAB2_SELECT_VISIBLE, false)
  self.im.Publish(BND_TAB3_SELECT_VISIBLE, false)
end

function TeamRoster:publishBg()
  local leagueBackground = { name = "$BackgroundCareer", id = currentSelectedTeamID}
  local tables = { name = "$TableCareer", id = currentSelectedTeamID}
  background = leagueBackground
  rectangle = tables
  self.im.Publish("bnd_background_visible", background)
  self.im.Publish("bnd_table_visible", rectangle)
end

function TeamRoster:publishVisible()
  self.im.Publish("bnd_visible", self.visible)
  if self.panelvisible then
    self.im.Publish("bnd_rowvisible", false)
  else
    self.im.Publish("bnd_rowvisible", self.rowvisible)
  end
  self.im.Publish("bnd_panelvisible", self.panelvisible)
  self.im.Publish("bnd_panelanim", 0.0)
  self.im.Publish("bnd_plstat_visible", self.statvisible)
  self.im.Publish("bnd_plinfo_visible", self.infovisible)
  self.im.Publish("bnd_loading_visible", not self.visible)

  if self.panelvisible then
    local animValues = {0.1, 0.3, 0.4, 0.6, 0.7, 0.8, 1.0}

    -- Recursive function to handle animation steps
    local function setNextAnim(index)
      if index > #animValues then
        print("[TeamRoster]: Animation sequence completed")
        self.panelAnimTimer = nil -- Clean up
        return
      end

      local value = animValues[index]
      local delay = 0.05 -- 2 seconds for first step, 1 second for others

      self.panelAnimTimer = Timer:new({
        id = "panelAnimTimer_" .. index,
        interval = delay,
        reps = 1,
        onTimerComplete = function(id, repsCount)
          print(string.format("[TeamRoster]: Timer completed, setting bnd_panelanim to %.1f", value))
          self.im.Publish("bnd_panelanim", value)
          setNextAnim(index + 1) -- Move to next animation step
        end
      })
      self.panelAnimTimer:start()
      print(string.format("[TeamRoster]: Started %d-second timer to set bnd_panelanim to %.1f", delay, value))
    end

    -- Start the animation sequence
    setNextAnim(1)
  end
end

function TeamRoster:publishPlayerInfo(data)
  local rating = data.rating
  local ratingColor = ""
  if rating >= 85 then
      ratingColor = "0x28992D"
  elseif rating >= 75 then
      ratingColor = "0xE2BA00"
  elseif rating >= 65 then
      ratingColor = "0xFF9420"
  elseif rating >= 50 then
      ratingColor = "0xc82727"
  else
      ratingColor = "0xFFFFFF"
  end  
  local roleNames = {
    [1] = "Potential",
    [2] = "Alternative",
    [3] = "Important",
    [4] = "Potential",
    [5] = "Aveerage",
    [6] = "Prospect",
    [7] = "Crucial",
    [8] = "Sporadic",
    [9] = "Prospect",
   [10] = "Prospect",
   [11] = "Successor",
   [12] = "Alternative",
   [13] = "Crucial",
   [14] = "Sporadic",
   [15] = "Prospect",
   [16] = "Prospect",
   [17] = "Rotation",
   [18] = "Successor",
   [19] = "Important",
   [20] = "Crucial",
   [21] = "Potential",
   [22] = "Rotation",
   [23] = "Prospect",
   [24] = "Sporadic",
   [25] = "Important",
   [26] = "Successor",
   [27] = "Important",
   [28] = "Potential",
   [29] = "Aveerage",
   [30] = "Prospect",
   [31] = "Alternative",
   [32] = "Sporadic",
   [33] = "Potential",
   [34] = "Distress",
   [35] = "Crucial",
   [36] = "Important",
   [37] = "Prospect",
   [38] = "Rotation",
   [39] = "Sporadic",
   [40] = "Important",
   [41] = "Alternative",
   [42] = "Successor",
   [43] = "Rotation",
   [44] = "Crucial",
   [45] = "Prospect",
   [46] = "Aveerage",
   [47] = "Potential",
   [48] = "Alternative",
   [49] = "Distress",
   [50] = "Sporadic",
   [51] = "Successor",
   [52] = "Prospect",
   [53] = "Important",
   [54] = "Alternative",
   [55] = "Aveerage",
   [56] = "Potential",
   [57] = "Rotation",
   [58] = "Alternative",
   [59] = "Sporadic",
   [60] = "Successor",
   [61] = "Important",
   [62] = "Prospect",
   [63] = "Aveerage",
   [64] = "Alternative",
   [65] = "Potential",
   [66] = "Distress",
   [67] = "Rotation",
   [68] = "Successor",
   [69] = "Crucial",
   [70] = "Prospect",
   [71] = "Alternative",
   [72] = "Potential",
   [73] = "Sporadic",
   [74] = "Important",
   [75] = "Rotation",
   [76] = "Prospect",
   [77] = "Aveerage",
   [78] = "Potential",
   [79] = "Successor",
   [80] = "Crucial",
   [81] = "Important",
   [82] = "Rotation",
   [83] = "Distress",
   [84] = "Prospect",
   [85] = "Potential",
   [86] = "Sporadic",
   [87] = "Aveerage",
   [88] = "Alternative",
   [89] = "Crucial",
   [90] = "Prospect",
   [91] = "Potential",
   [92] = "Rotation",
   [93] = "Sporadic",
   [94] = "Successor",
   [95] = "Distress",
   [96] = "Alternative",
   [97] = "Aveerage",
   [98] = "Prospect",
   [99] = "Crucial",
  [100] = "Rotation",
  [101] = "Sporadic",
  [102] = "Potential",
  [103] = "Alternative",
  [104] = "Aveerage",
  [105] = "Successor",
  [106] = "Prospect",
  [107] = "Important",
  [108] = "Rotation",
  [109] = "Crucial",
  [110] = "Alternative",
  [111] = "Potential",
  [112] = "Sporadic",
  [113] = "Prospect",
  [114] = "Aveerage",
  [115] = "Distress",
  [116] = "Important",
  [117] = "Successor",
  [118] = "Prospect",
  [119] = "Sporadic",
  [120] = "Crucial",
  [121] = "Aveerage",
  [122] = "Alternative",
  [123] = "Potential",
  [124] = "Distress",
  [125] = "Important",
  [126] = "Prospect",
  [127] = "Sporadic",
  [128] = "Crucial",
  [129] = "Rotation",
  [130] = "Alternative",
  [131] = "Potential",
  [132] = "Successor",
  [133] = "Prospect",
  [134] = "Distress",
  [135] = "Important",
  [136] = "Rotation",
  [137] = "Sporadic",
  [138] = "Alternative",
  [139] = "Prospect",
  [140] = "Potential",
  [141] = "Crucial",
  [142] = "Rotation",
  [143] = "Aveerage",
  [144] = "Successor",
  [145] = "Important",
  [146] = "Sporadic",
  [147] = "Alternative",
  [148] = "Distress",
  [149] = "Prospect",
  [150] = "Potential",
  [151] = "Rotation",
  [152] = "Aveerage",
  [153] = "Sporadic",
  [154] = "Alternative",
  [155] = "Crucial",
  [156] = "Important",
  [157] = "Successor",
  [158] = "Rotation",
  [159] = "Prospect",
  [160] = "Potential",
  [161] = "Alternative",
  [162] = "Aveerage",
  [163] = "Sporadic",
  [164] = "Crucial",
  [165] = "Prospect",
  [166] = "Rotation",
  [167] = "Important",
  [168] = "Alternative",
  [169] = "Potential",
  [170] = "Successor",
  [171] = "Sporadic",
  [172] = "Distress",
  [173] = "Crucial",
  [174] = "Aveerage",
  [175] = "Rotation",
  [176] = "Important",
  [177] = "Alternative",
  [178] = "Prospect",
  [179] = "Potential",
  [180] = "Sporadic",
  [181] = "Successor",
  [182] = "Crucial",
  [183] = "Rotation",
  [184] = "Aveerage",
  [185] = "Prospect",
  [186] = "Alternative",
  [187] = "Important",
  [188] = "Sporadic",
  [189] = "Potential",
  [190] = "Rotation",
  [191] = "Crucial",
  [192] = "Prospect",
  [193] = "Aveerage",
  [194] = "Alternative",
  [195] = "Important",
  [196] = "Successor",
  [197] = "Rotation",
  [198] = "Sporadic",
  [199] = "Crucial",
  [200] = "Prospect",
  [201] = "Potential",
  [202] = "Alternative",
  [203] = "Aveerage",
  [204] = "Rotation",
  [205] = "Sporadic",
  [206] = "Crucial",
  [207] = "Prospect",
  [208] = "Important",
  [209] = "Alternative",
  [210] = "Distress",
  [211] = "Successor",
  [212] = "Aveerage",
  [213] = "Rotation",
  [214] = "Prospect",
  [215] = "Sporadic",
  [216] = "Crucial",
  [217] = "Important",
  [218] = "Alternative",
  [219] = "Potential",
  [220] = "Successor"
}
  local nationalityNames = {
    [1] = "Albania",
    [2] = "Andorra",
    [3] = "Armenia",
    [4] = "Austria",
    [5] = "Azerbaijan",
    [6] = "Belarus",
    [7] = "Belgium",
    [8] = "Bosnia",
    [9] = "Bulgaria",
    [10] = "Croatia",
    [11] = "Cyprus",
    [12] = "Czech Republic",
    [13] = "Denmark",
    [14] = "England",
    [15] = "Montenegro",
    [16] = "Faroe Islands",
    [17] = "Finland",
    [18] = "France",
    [19] = "FYR Macedonia",
    [20] = "Georgia",
    [21] = "Germany",
    [22] = "Greece",
    [23] = "Hungary",
    [24] = "Iceland",
    [25] = "Republic of Ireland",
    [26] = "Israel",
    [27] = "Italy",
    [28] = "Latvia",
    [29] = "Liechtenstein",
    [30] = "Lithuania",
    [31] = "Luxembourg",
    [32] = "Malta",
    [33] = "Moldova",
    [34] = "Netherlands",
    [35] = "Northern Ireland",
    [36] = "Norway",
    [37] = "Poland",
    [38] = "Portugal",
    [39] = "Romania",
    [40] = "Russia",
    [41] = "San Marino",
    [42] = "Scotland",
    [43] = "Slovakia",
    [44] = "Slovenia",
    [45] = "Spain",
    [46] = "Sweden",
    [47] = "Switzerland",
    [48] = "Turkey",
    [49] = "Ukraine",
    [50] = "Wales",
    [51] = "Serbia",
    [52] = "Argentina",
    [53] = "Bolivia",
    [54] = "Brazil",
    [55] = "Chile",
    [56] = "Colombia",
    [57] = "Ecuador",
    [58] = "Paraguay",
    [59] = "Peru",
    [60] = "Uruguay",
    [61] = "Venezuela",
    [62] = "Anguilla",
    [63] = "Antigua and Barbuda",
    [64] = "Aruba",
    [65] = "Bahamas",
    [66] = "Barbados",
    [67] = "Belize",
    [68] = "Bermuda",
    [69] = "British Virgin Islands",
    [70] = "Canada",
    [71] = "Cayman Islands",
    [72] = "Costa Rica",
    [73] = "Cuba",
    [74] = "Dominica",
    [75] = "International",
    [76] = "El Salvador",
    [77] = "Grenada",
    [78] = "Guatemala",
    [79] = "Guyana",
    [80] = "Haiti",
    [81] = "Honduras",
    [82] = "Jamaica",
    [83] = "Mexico",
    [84] = "Montserrat",
    [85] = "Curaçao",
    [86] = "Nicaragua",
    [87] = "Panama",
    [88] = "Puerto Rico",
    [89] = "St. Kitts and Nevis",
    [90] = "St. Lucia",
    [91] = "St. Vincent and the Grenadines",
    [92] = "Suriname",
    [93] = "Trinidad and Tobago",
    [94] = "Turks and Caicos Islands",
    [95] = "United States",
    [96] = "US Virgin Islands",
    [97] = "Algeria",
    [98] = "Angola",
    [99] = "Benin",
   [100] = "Botswana",
   [101] = "Burkina Faso",
   [102] = "Burundi",
   [103] = "Cameroon",
   [104] = "Cape Verde",
   [105] = "Central African Republic",
   [106] = "Chad",
   [107] = "Congo",
   [108] = "Côte d'Ivoire",
   [109] = "Djibouti",
   [110] = "Congo DR",
   [111] = "Egypt",
   [112] = "Equatorial Guinea",
   [113] = "Eritrea",
   [114] = "Ethiopia",
   [115] = "Gabon",
   [116] = "Gambia",
   [117] = "Ghana",
   [118] = "Guinea",
   [119] = "Guinea-Bissau",
   [120] = "Kenya",
   [121] = "Lesotho",
   [122] = "Liberia",
   [123] = "Libya",
   [124] = "Madagascar",
   [125] = "Malawi",
   [126] = "Mali",
   [127] = "Mauritania",
   [128] = "Mauritius",
   [129] = "Morocco",
   [130] = "Mozambique",
   [131] = "Namibia",
   [132] = "Niger",
   [133] = "Nigeria",
   [134] = "Rwanda",
   [135] = "São Tomé e Príncipe",
   [136] = "Senegal",
   [137] = "Seychelles",
   [138] = "Sierra Leone",
   [139] = "Somalia",
   [140] = "South Africa",
   [141] = "Sudan",
   [142] = "Swaziland",
   [143] = "Tanzania",
   [144] = "Togo",
   [145] = "Tunisia",
   [146] = "Uganda",
   [147] = "Zambia",
   [148] = "Zimbabwe",
   [149] = "Afghanistan",
   [150] = "Bahrain",
   [151] = "Bangladesh",
   [152] = "Bhutan",
   [153] = "Brunei Darussalam",
   [154] = "Cambodia",
   [155] = "China PR",
   [157] = "Guam",
   [158] = "Hong Kong",
   [159] = "India",
   [160] = "Indonesia",
   [161] = "Iran",
   [162] = "Iraq",
   [163] = "Japan",
   [164] = "Jordan",
   [165] = "Kazakhstan",
   [166] = "Korea DPR",
   [167] = "Korea Republic",
   [168] = "Kuwait",
   [169] = "Kyrgyzstan",
   [170] = "Laos",
   [171] = "Lebanon",
   [172] = "Macau",
   [173] = "Malaysia",
   [174] = "Maldives",
   [175] = "Mongolia",
   [176] = "Myanmar",
   [177] = "Nepal",
   [178] = "Oman",
   [179] = "Pakistan",
   [180] = "Palestine",
   [181] = "Philippines",
   [182] = "Qatar",
   [183] = "Saudi Arabia",
   [184] = "Singapore",
   [185] = "Sri Lanka",
   [186] = "Syria",
   [187] = "Tajikistan",
   [188] = "Thailand",
   [189] = "Turkmenistan",
   [190] = "UAE",
   [191] = "Uzbekistan",
   [192] = "Vietnam",
   [193] = "Yemen",
   [194] = "American Samoa",
   [195] = "Australia",
   [196] = "Cook Islands",
   [197] = "Fiji",
   [198] = "New Zealand",
   [199] = "Papua New Guinea",
   [200] = "Samoa",
   [201] = "Solomon Islands",
   [202] = "Tahiti",
   [203] = "Tonga",
   [204] = "Vanuatu",
   [205] = "Gibraltar",
   [206] = "Greenland",
   [207] = "Dominican Republic",
   [208] = "Estonia",
   [211] = "Rest of World",
   [212] = "Timor-Leste",
   [213] = "Chinese Taipei",
   [214] = "Comoros",
   [215] = "New Caledonia",
   [219] = "Kosovo",
   [250] = "Other",
   [249] = "World Cup",
   [222] = "International Women"
}

local function getCountryName(natID)
  if not natID then return "Unknown" end
  if type(natID) == "string" then
    return natID
  end
  return nationalityNames[natID] or "Unknown"
end

local function getRoleName(roleID)
    if not roleID then return "Unknown" end
    if type(roleID) == "string" then
        return roleID
    end
    return roleNames[roleID] or "Unknown"
end

  local positionIDs = {
    GK = 1,
    RWB = 2,
    RB = 3,
    RCB = 4,
    CB = 5,
    LCB = 6,
    LB = 7,
    LWB = 8,
    RDM = 9,
    CDM = 10,
    LDM = 11,
    RM = 12,
    RCM = 13,
    CM = 14,
    LCM = 15,
    LM = 16,
    RAM = 17,
    CAM = 18,
    LAM = 19,
    RF = 20,
    CF = 21,
    LF = 22,
    RW = 23,
    ST = 24,
    LW = 25   
}
  local suspStatus = "Eligible"
  local fitnessStatus = "Match Fit"
  local plgoals = 0
  local plcleansheets = 0
  local plyellowcard = 0
  local plredcard = 0
  if data then 
    self.im.Publish("bnd_player_name", data.playerName)
    self.im.Publish("bnd_player_role_name", getRoleName(data.nationalityID))
    self.im.Publish("bnd_player_country_name", getCountryName(data.nationalityID))
    self.im.Publish("bnd_player_ID", data.CARD_ID)
    self.im.Publish("bnd_player_position", data.position)
    self.im.Publish("bnd_player_number", data.jerseyNumber)
    self.im.Publish("bnd_player_level_up", ""..data.jerseyNumber.."  ".."weeks")
    self.im.Publish("bnd_player_salary", "$"..data.rating..""..",000")    
    self.im.Publish("bnd_player_avatar", {
      name = "$Head",
      id = data.CARD_ID
    })   
    self.im.Publish("bnd_player_country", {
      name = "$Flag128x128",
      id = data.nationalityID
    })
    self.im.Publish("bnd_player_style", {
      name = "$Emblem",
      id = data.nationalityID
    })
    self.im.Publish("bnd_player_style_position", {
      name = "$EmblemPos",
      id = positionIDs[data.position]
    })
    self.im.Publish("bnd_player_role", {
      name = "$Role",
      id = data.nationalityID
    })
    self.im.Publish("bnd_player_morale", {
      name = "$Morale",
      id = data.nationalityID
    })
    if isSuspended[data.CARD_ID] == 2 then
      fitnessStatus = "Injured. Back (" .. injuryRecoveryDate[data.CARD_ID] .. ")"
    elseif isSuspended[data.CARD_ID] == 1 then
      suspStatus = "Red Carded"
    end
    local playerInfo = getPlayerInfo(data.CARD_ID, currentSelectedTeamID)
    local Index = playerInfo and playerInfo.index
    local repCount = playerReplacementCount(currentSelectedTeamID, data.position)
    local days = daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
    local playervalue, minvalue = computeTransferValue(GetPlayerAge(data.CARD_ID), data.rating, data.position, Index, repCount, days)
    self.im.Publish("bnd_value", "$" .. self.loc.LocalizeInteger(playervalue))
    self.im.Publish("bnd_suspstatus", suspStatus)
    self.im.Publish("bnd_fitness", fitnessStatus)
    self.im.Publish("bnd_player_rating", tostring(rating))
    self.im.Publish("bnd_rating_color", ratingColor)      
    self.im.Publish("bnd_player_3d", {
      name = "$PLAYER_ID",
      id = data.CARD_ID
    })
    local function getStatColor(value)
    if value >= 80 then
        return "0x28992D"
    elseif value >= 70 then
        return "0xE2BA00"
    elseif value >= 60 then
        return "0xFF9420"
    elseif value >= 50 then
        return "0xc82727"
    else
        return "0xc82727"  
    end
end
    for i = 1, 6 do
    local statValue = data["stat"..i] or 0
    local color = getStatColor(statValue) 
    self.im.Publish("bnd_player_stat"..i, statValue)
    self.im.Publish("bnd_player_stat_color"..i, color)
   end
    plgoals = GOALS[data.CARD_ID] or 0
    plcleansheets = 0
    plyellowcard = yellowCardRecords[data.CARD_ID] or 0
    plredcard = redCardRecords[data.CARD_ID] or 0
    local stats = {plgoals, plcleansheets, plyellowcard, plredcard}
    for i = 1, 4 do
      self.im.Publish("bnd_dom" .. statsubs[i], stats[i])
      self.im.Publish("bnd_friendly" .. statsubs[i], 0)
      self.im.Publish("bnd_total" .. statsubs[i], stats[i])
    end
  end
end

-- 初始化数据
function TeamRoster:Init()
  local teamInfo = self.services.SquadManagementService.GetTeamInfo(TeamID)
  local teamLineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, TeamID, 0)
  
  -- Original logic to populate PlayerListData
  do
    do
      for _FORV_16_ = 1, table.getn(teamLineup) do
        local obj = {
          assetId = teamLineup[_FORV_16_].CARD_ID,
          nationalityId = teamLineup[_FORV_16_].nationalityID,
          jerseyNumber = teamLineup[_FORV_16_].jerseyNumber,
          clickAction = "act_player_select",
          playerInfo = teamLineup[_FORV_16_],
          data = {}
        }
        table.insert(PlayerListData, obj)
      end
    end
  end
end

function TeamRoster:publishPlayerRows()
  for i, v in ipairs(PlayerListData) do
    v.data.PlayerAvatar = {
      name = "$Head",
      id = PlayerListData[i].assetId
    }
    v.data.Morale = {
      name = "$Morale",
      id = PlayerListData[i].nationalityId
     }
    v.data.PlayerNationality = {
      name = "$Role",
      id = PlayerListData[i].nationalityId
    }
    v.data.PlayerName = PlayerListData[i].playerInfo.playerName
    v.data.Rating = PlayerListData[i].playerInfo.rating
    local rating = PlayerListData[i].playerInfo.rating
    if rating >= 85 then
       v.data.FontColor = "0x28992D"
    elseif rating >= 75 then
       v.data.FontColor = "0xE2BA00"
    elseif rating >= 65 then
       v.data.FontColor = "0xFF9420"
    elseif rating >= 50 then
       v.data.FontColor = "0xc82727"
     else
        v.data.FontColor = "0xFFFFFF"
   end 
   local roleNames = {
    [1] = "Potential",
    [2] = "Alternative",
    [3] = "Important",
    [4] = "Potential",
    [5] = "Aveerage",
    [6] = "Prospect",
    [7] = "Crucial",
    [8] = "Sporadic",
    [9] = "Prospect",
   [10] = "Prospect",
   [11] = "Successor",
   [12] = "Alternative",
   [13] = "Crucial",
   [14] = "Sporadic",
   [15] = "Prospect",
   [16] = "Prospect",
   [17] = "Rotation",
   [18] = "Successor",
   [19] = "Important",
   [20] = "Crucial",
   [21] = "Potential",
   [22] = "Rotation",
   [23] = "Prospect",
   [24] = "Sporadic",
   [25] = "Important",
   [26] = "Successor",
   [27] = "Important",
   [28] = "Potential",
   [29] = "Aveerage",
   [30] = "Prospect",
   [31] = "Alternative",
   [32] = "Sporadic",
   [33] = "Potential",
   [34] = "Distress",
   [35] = "Crucial",
   [36] = "Important",
   [37] = "Prospect",
   [38] = "Rotation",
   [39] = "Sporadic",
   [40] = "Important",
   [41] = "Alternative",
   [42] = "Successor",
   [43] = "Rotation",
   [44] = "Crucial",
   [45] = "Prospect",
   [46] = "Aveerage",
   [47] = "Potential",
   [48] = "Alternative",
   [49] = "Distress",
   [50] = "Sporadic",
   [51] = "Successor",
   [52] = "Prospect",
   [53] = "Important",
   [54] = "Alternative",
   [55] = "Aveerage",
   [56] = "Potential",
   [57] = "Rotation",
   [58] = "Alternative",
   [59] = "Sporadic",
   [60] = "Successor",
   [61] = "Important",
   [62] = "Prospect",
   [63] = "Aveerage",
   [64] = "Alternative",
   [65] = "Potential",
   [66] = "Distress",
   [67] = "Rotation",
   [68] = "Successor",
   [69] = "Crucial",
   [70] = "Prospect",
   [71] = "Alternative",
   [72] = "Potential",
   [73] = "Sporadic",
   [74] = "Important",
   [75] = "Rotation",
   [76] = "Prospect",
   [77] = "Aveerage",
   [78] = "Potential",
   [79] = "Successor",
   [80] = "Crucial",
   [81] = "Important",
   [82] = "Rotation",
   [83] = "Distress",
   [84] = "Prospect",
   [85] = "Potential",
   [86] = "Sporadic",
   [87] = "Aveerage",
   [88] = "Alternative",
   [89] = "Crucial",
   [90] = "Prospect",
   [91] = "Potential",
   [92] = "Rotation",
   [93] = "Sporadic",
   [94] = "Successor",
   [95] = "Distress",
   [96] = "Alternative",
   [97] = "Aveerage",
   [98] = "Prospect",
   [99] = "Crucial",
  [100] = "Rotation",
  [101] = "Sporadic",
  [102] = "Potential",
  [103] = "Alternative",
  [104] = "Aveerage",
  [105] = "Successor",
  [106] = "Prospect",
  [107] = "Important",
  [108] = "Rotation",
  [109] = "Crucial",
  [110] = "Alternative",
  [111] = "Potential",
  [112] = "Sporadic",
  [113] = "Prospect",
  [114] = "Aveerage",
  [115] = "Distress",
  [116] = "Important",
  [117] = "Successor",
  [118] = "Prospect",
  [119] = "Sporadic",
  [120] = "Crucial",
  [121] = "Aveerage",
  [122] = "Alternative",
  [123] = "Potential",
  [124] = "Distress",
  [125] = "Important",
  [126] = "Prospect",
  [127] = "Sporadic",
  [128] = "Crucial",
  [129] = "Rotation",
  [130] = "Alternative",
  [131] = "Potential",
  [132] = "Successor",
  [133] = "Prospect",
  [134] = "Distress",
  [135] = "Important",
  [136] = "Rotation",
  [137] = "Sporadic",
  [138] = "Alternative",
  [139] = "Prospect",
  [140] = "Potential",
  [141] = "Crucial",
  [142] = "Rotation",
  [143] = "Aveerage",
  [144] = "Successor",
  [145] = "Important",
  [146] = "Sporadic",
  [147] = "Alternative",
  [148] = "Distress",
  [149] = "Prospect",
  [150] = "Potential",
  [151] = "Rotation",
  [152] = "Aveerage",
  [153] = "Sporadic",
  [154] = "Alternative",
  [155] = "Crucial",
  [156] = "Important",
  [157] = "Successor",
  [158] = "Rotation",
  [159] = "Prospect",
  [160] = "Potential",
  [161] = "Alternative",
  [162] = "Aveerage",
  [163] = "Sporadic",
  [164] = "Crucial",
  [165] = "Prospect",
  [166] = "Rotation",
  [167] = "Important",
  [168] = "Alternative",
  [169] = "Potential",
  [170] = "Successor",
  [171] = "Sporadic",
  [172] = "Distress",
  [173] = "Crucial",
  [174] = "Aveerage",
  [175] = "Rotation",
  [176] = "Important",
  [177] = "Alternative",
  [178] = "Prospect",
  [179] = "Potential",
  [180] = "Sporadic",
  [181] = "Successor",
  [182] = "Crucial",
  [183] = "Rotation",
  [184] = "Aveerage",
  [185] = "Prospect",
  [186] = "Alternative",
  [187] = "Important",
  [188] = "Sporadic",
  [189] = "Potential",
  [190] = "Rotation",
  [191] = "Crucial",
  [192] = "Prospect",
  [193] = "Aveerage",
  [194] = "Alternative",
  [195] = "Important",
  [196] = "Successor",
  [197] = "Rotation",
  [198] = "Sporadic",
  [199] = "Crucial",
  [200] = "Prospect",
  [201] = "Potential",
  [202] = "Alternative",
  [203] = "Aveerage",
  [204] = "Rotation",
  [205] = "Sporadic",
  [206] = "Crucial",
  [207] = "Prospect",
  [208] = "Important",
  [209] = "Alternative",
  [210] = "Distress",
  [211] = "Successor",
  [212] = "Aveerage",
  [213] = "Rotation",
  [214] = "Prospect",
  [215] = "Sporadic",
  [216] = "Crucial",
  [217] = "Important",
  [218] = "Alternative",
  [219] = "Potential",
  [220] = "Successor"
}
   local function getRoleName(roleID)
    if not roleID then return "Unknown" end
    return roleNames[roleID] or "Unknown"
end
    v.data.Role = getRoleName(PlayerListData[i].nationalityId)
    v.data.Position = PlayerListData[i].playerInfo.position
    v.data.Number = PlayerListData[i].jerseyNumber
    v.data.Number1 = PlayerListData[i].nationalityId
    v.data.Country = PlayerListData[i].nationalityId
    v.data.clickAction = PlayerListData[i].clickAction
  end
  self.im.Publish(bndPlayerList, PlayerListData)
  self.visible = true
  self:publishVisible()
  self:publishPlayerDetail({
    id = 0
  })
end

function TeamRoster:publishPlayerDetail(data)
  local playerIndex = data.id + 1
  self.oldIndex = self.currentIndex
  self.currentIndex = playerIndex
  if self.oldIndex == self.currentIndex then
    self.panelvisible = true
    self.im.Publish("bnd_panelvisible", self.panelvisible)
    self.im.Publish("bnd_rowvisible", false)
    self:publishVisible()
  end
  playerData = PlayerListData[playerIndex].playerInfo    
  self:publishPlayerInfo(playerData)  
end

function TeamRoster:hidePanel()
  self.panelvisible = false
  self.im.Publish("bnd_panelvisible", self.panelvisible)
  self.im.Publish("bnd_rowvisible", true)
  self:publishVisible()
end

function TeamRoster:toggleView()
  if toggle == false then
    self.im.Publish("bnd_plinfo_visible", false)
    self.im.Publish("bnd_plstat_visible", true)
    toggle = true
  else
    self.im.Publish("bnd_plinfo_visible", true)
    self.im.Publish("bnd_plstat_visible", false)
    toggle = false
  end
end

function TeamRoster:releasePlayer()
  releasePlayer(playerData.CARD_ID, currentSelectedTeamID)
  PlayerListData = {}
  self:Init()
  self:publishPlayerRows()
  self.panelvisible = false 
  self.im.Publish("bnd_panelvisible", self.panelvisible)
  self.im.Publish("bnd_rowvisible", true)
  self:publishVisible()
end

function TeamRoster:update(elapsedTime)
  if self.panelAnimTimer then
    self.panelAnimTimer:update(elapsedTime)
  end
end

function TeamRoster:infoRelease()
    local playerInfo = getPlayerInfo(playerData.CARD_ID, currentSelectedTeamID)
    local Index = playerInfo and playerInfo.index
    local repCount = playerReplacementCount(currentSelectedTeamID, playerData.position)
    local days = daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
    local playervalue, minvalue = computeTransferValue(GetPlayerAge(playerData.CARD_ID), playerData.rating, playerData.position, Index, repCount, days)
    
    local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {
      
      "evt_hide_popup"
    }
  }
  
  function buttonYes.clickCallback()
    releasePlayer(playerData.CARD_ID, currentSelectedTeamID)
    PlayerListData = {}
    self:Init()
    self:publishPlayerRows()
    self.panelvisible = false 
    self.im.Publish("bnd_panelvisible", self.panelvisible)
    self.im.Publish("bnd_rowvisible", true)
    self:publishVisible()
    self.nav.Event(nil, "evt_hide_popup")
  end
  
  local popupData = {
    title = "RELEASE",    
    message = "Release " .. playerData.playerName .. " with price $" .. self.loc.LocalizeInteger(playervalue) .. "?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamRoster:infoSquad()
    local buttonNo = {
        icon = "$FooterIconNo",
        label = "Cancel",
        clickEvents = {
            "evt_hide_popup"
        }
    }
    local buttonYes = {
        icon = "$FooterIconYes",
        label = "Confirm",
        clickEvents = {
            "evt_hide_popup"
        }
    }
    local popupData = {
        title = "INFO",
        message = "This player is really needed in the team, to help the team to be the best*",
        buttons = {buttonYes}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamRoster:infoContract()
    local buttonNo = {
        icon = "$FooterIconNo",
        label = "Cancel",
        clickEvents = {
            "evt_hide_popup"
        }
    }
    local buttonYes = {
        icon = "$FooterIconNo",
        label = "Back",
        clickEvents = {
            "evt_hide_popup"
        }
    }
    local popupData = {
        title = "INFO",
        message = "The contract will be extended when the end of the season is over*",
        buttons = {buttonYes}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamRoster:finalize()
  if self.panelAnimTimer then
    self.panelAnimTimer:finalize()
    self.panelAnimTimer = nil
    print("[TeamRoster]: Panel anim timer finalized")
  end
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe("bnd_loading_visible")
  self.im.Unsubscribe("bnd_team_crest")
  self.im.Unsubscribe("bnd_team_name")
  self.im.Unsubscribe("bnd_player_name")
  self.im.Unsubscribe("bnd_player_avatar")
  self.im.Unsubscribe("bnd_player_ID")
  self.im.Unsubscribe("bnd_player_number")
  self.im.Unsubscribe("bnd_player_role")
  self.im.Unsubscribe("bnd_player_position")
  self.im.Unsubscribe("bnd_player_country")
  self.im.Unsubscribe("bnd_player_rating")
  self.im.Unsubscribe("bnd_3d_player")
  for i = 1, 6 do
    self.im.Unsubscribe("bnd_player_stat"..i)
  end
  self.im.Unsubscribe(bndPlayerList)
  self.im.UnregisterAction(ACT_SEPTIAWAN_CLICK)
  self.im.Unsubscribe(BND_TAB1_SELECT_VISIBLE)
  self.im.Unsubscribe(BND_TAB2_SELECT_VISIBLE)
  self.im.Unsubscribe(BND_TAB3_SELECT_VISIBLE)
end

return TeamRoster