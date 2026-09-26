-----------------------------------------------
---- THEME BY SEPTIAWAN ----
-----------------------------------------------

local Performance = {}

local bndPlayerList = "bnd_player_list"
local ACT_PLAYER_SELECT = "act_player_select"
local BND_TEAM_RATING = "bnd_team_rating"
local BND_TEAM_RATING_LABEL = "bnd_team_rating_label"
local BND_TEAM_OVERALL = "bnd_team_overall"
local USER_MATCH_STATUS = {
  WON = 0,
  LOST = 1,
  DRAW = 2
}

local TEAM_MATCH_STATUS = {
  WON = 0,
  LOST = 1,
  DRAW = 2
}

local BND_PRW1 = "bnd_pr_w1"
local BND_PRW2 = "bnd_pr_w2"
local BND_PRW3 = "bnd_pr_w3"
local BND_PRL1 = "bnd_pr_l1"
local BND_PRL2 = "bnd_pr_l2"
local BND_PRL3 = "bnd_pr_l3"
local BND_PRD1 = "bnd_pr_d1"
local BND_PRD2 = "bnd_pr_d2"
local BND_PRD3 = "bnd_pr_d3"

local BND_HOME_W = "bnd_home_w"
local BND_HOME_L = "bnd_home_l"
local BND_HOME_D = "bnd_home_d"
local BND_AWAY_W = "bnd_away_w"
local BND_AWAY_L = "bnd_away_l"
local BND_AWAY_D = "bnd_away_d"

local BND_MATCH_WON_FOOTER_VISIBLE = "bnd_match_won_footer_visible"
local BND_MATCH_LOST_FOOTER_VISIBLE = "bnd_match_lost_footer_visible"
local BND_MATCH_DRAW_FOOTER_VISIBLE = "bnd_match_draw_footer_visible"

local BND_TEAM_WON_FOOTER_VISIBLE = "bnd_team_won_footer_visible"
local BND_TEAM_LOST_FOOTER_VISIBLE = "bnd_team_lost_footer_visible"
local BND_TEAM_DRAW_FOOTER_VISIBLE = "bnd_team_draw_footer_visible"

local BND_MATCH_DATA_PANEL_VISIBLE = "bnd_match_data_panel_visible"
local BND_DEFAULT_BANNER_VISIBLE = "bnd_default_banner_visible"
local BND_AD_BANNER_DATA = "bnd_ad_banner_data"
local PlayerListData = {}
TeamID = 0

function Performance:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.navContext = o.data
  print("[PostmatchMenu]: new(gamemode = " .. tostring(o.navContext.gamemode) .. ", flow = " .. tostring(o.navContext.flow) .. ", type = " .. tostring(o.navContext.type) .. ", gameState = " .. tostring(o.navContext.gameState) .. ")")
  o.services = {
    SquadManagementService = o.api("SquadMgtService"),
    gameSetup = o.api("GameSetupService"),
    matchInfo = o.api("MatchInfoService"),
    EventManagerService = o.api("EventManagerService")
  }
  ------------------------------------------------------------------------------------------
  -- STATISTICS CUSTOM --
  
  math.randomseed(os.clock() * 100 + os.time())
  local PRwon1 = (math.random(60, 96)* 1)
  local PRwon2 = (math.random(0, 9)* 1)
  local PRwon3 = (math.random(0, 9)* 1)
  local PRlost1 = (math.random(0, 35)* 1)
  local PRlost2 = (math.random(0, 35)* 1)
  local PRlost3 = (math.random(0, 9)* 1)
  local PRdraw1 = (math.random(100, 200)* 1)
  local PRdraw2 = (math.random(60, 90)* 1)
  local PRdraw3 = (math.random(0, 11)* 1)
  
  ------------------------------------------------------------------------------------------
  -- STATISTICS CUSTOM --
  
  math.randomseed(os.clock() * 100 + os.time())
  local HMwon = (math.random(1, 15)* 1)
  local HMlost = (math.random(60, 70)* 1)
  local HMdraw = (math.random(0, 15)* 1)
  local AWwon = (math.random(1, 15)* 1)
  local AWlost = (math.random(1, 9)* 1)
  local AWdraw = (math.random(0, 15)* 1)
  
  ------------------------------------------------------------------------------------------
  
 TeamID = o.services.gameSetup.GetHomeAssetId()
    o.visible = false
    o.im.Subscribe("bnd_visible", function()
        o:publishVisible()
    end)
    o.im.Subscribe("bnd_loading_visible", function()
        o:publishVisible()
    end)
    o.im.Subscribe(BND_PRW1, function()
        o.im.Publish(BND_PRW1, PRwon1)
    end)
    o.im.Subscribe(BND_PRW2, function()
        o.im.Publish(BND_PRW2, PRwon2)
    end)
    o.im.Subscribe(BND_PRW3, function()
        o.im.Publish(BND_PRW3, PRwon3)
    end)
    o.im.Subscribe(BND_PRL1, function()
        o.im.Publish(BND_PRL1, PRlost1)
    end)
    o.im.Subscribe(BND_PRL2, function()
        o.im.Publish(BND_PRL2, PRlost2)
    end)
    o.im.Subscribe(BND_PRL3, function()
        o.im.Publish(BND_PRL3, PRlost3)
    end)  
    o.im.Subscribe(BND_PRD1, function()
        o.im.Publish(BND_PRD1, PRdraw1)
    end)
    o.im.Subscribe(BND_PRD2, function()
        o.im.Publish(BND_PRD2, PRdraw2)
    end)
    o.im.Subscribe(BND_PRD3, function()
         o.im.Publish(BND_PRD3, PRdraw3)
    end)  
    o.im.Subscribe(BND_HOME_W, function()
        o.im.Publish(BND_HOME_W, HMwon)
    end)
    o.im.Subscribe(BND_HOME_L, function()
        o.im.Publish(BND_HOME_L, HMlost)
    end)
    o.im.Subscribe(BND_HOME_D, function()
        o.im.Publish(BND_HOME_D, HMdraw)
    end)
    o.im.Subscribe(BND_AWAY_W, function()
        o.im.Publish(BND_AWAY_W, AWwon)
    end)
    o.im.Subscribe(BND_AWAY_L, function()
        o.im.Publish(BND_AWAY_L, AWlost)
    end)
    o.im.Subscribe(BND_AWAY_D, function()
        o.im.Publish(BND_AWAY_D, AWdraw)
    end)    
    o.im.Subscribe(BND_MATCH_DATA_PANEL_VISIBLE, function()
        o.im.Publish(BND_MATCH_DATA_PANEL_VISIBLE, o:_isDefaultMatchDataPanelVisible())
    end)
    o.im.Subscribe(BND_DEFAULT_BANNER_VISIBLE, function()
        o.im.Publish(BND_DEFAULT_BANNER_VISIBLE, o:_isDefaultAdBannerVisible())
    end)
    o.im.Subscribe(BND_AD_BANNER_DATA, function()
        o:publishBannerData()
    end)
    o.im.Subscribe("bnd_team_crest", function()
        o.im.Publish("bnd_team_crest", {
           name = "$Crest",
           id = TeamID
        })
    end)
    o.im.Subscribe("bnd_background_match", function()
        o.im.Publish("bnd_background_match", {
           name = "$MyStadium",
           id = TeamID
        })
    end)
    o.im.Subscribe("bnd_team_name", function()
        o.im.Publish("bnd_team_name", o.loc.LocalizeString("TeamName_Abbr15_"..TeamID))
    end)
    o.im.Subscribe("bnd_player_avatar", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_name", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_number", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_national", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_pos", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_num", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_ID", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_position", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_country", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_role_name", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_style_position", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_role_color", function()
    o:publishPlayerInfo()
  end)
    o.im.Subscribe("bnd_player_rating", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_stars", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_3d_player", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe(BND_TEAM_RATING, function()
       o:_publishTeamStats(BND_TEAM_RATING)
    end)
    o.im.Subscribe(BND_TEAM_RATING_LABEL, function()
       o:_publishTeamRatingLabel()
    end)
    o.im.Subscribe(BND_TEAM_OVERALL, function()
       o:_publishTeamStats(BND_TEAM_OVERALL)
     end)

    for i = 1, 6 do
        o.im.Subscribe("bnd_player_stat"..i, function()
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
  return o
end

function Performance:publishVisible()
   self.im.Publish("bnd_visible", self.visible)
   self.im.Publish("bnd_loading_visible", not self.visible)
end

function Performance:publishPlayerInfo(data)
 local roleNames = {
    [1] = "6.6",
    [2] = "7.0",
    [3] = "8.0",
    [4] = "7.0",
    [5] = "7.6",
    [6] = "7.2",
    [7] = "6.7",
    [8] = "8.7",
    [9] = "8.5",
   [10] = "7.0",
   [11] = "7.2",
   [12] = "5.7",
   [13] = "7.0",
   [14] = "7.4",
   [15] = "5.5",
   [16] = "7.0",
   [17] = "8.7",
   [18] = "6.6",
   [19] = "6.7",
   [20] = "5.7",
   [21] = "5.5",
   [22] = "5.8",
   [23] = "6.0",
   [24] = "7.4",
   [25] = "7.2",
   [26] = "6.0",
   [27] = "8.7",
   [28] = "7.4",
   [29] = "8.7",
   [30] = "8.0",
   [31] = "6.3",
   [32] = "5.8",
   [33] = "8.3",
   [34] = "6.7",
   [35] = "5.7",
   [36] = "6.3",
   [37] = "7.8",
   [38] = "6.3",
   [39] = "6.7",
   [40] = "7.0",
   [41] = "8.0",
   [42] = "8.7",
   [43] = "6.7",
   [44] = "5.7",
   [45] = "7.8",
   [46] = "6.0",
   [47] = "8.7",
   [48] = "7.0",
   [49] = "8.0",
   [50] = "6.6",
   [51] = "6.3",
   [52] = "7.4",
   [53] = "6.0",
   [54] = "8.5",
   [55] = "8.7",
   [56] = "6.3",
   [57] = "5.7",
   [58] = "5.5",
   [59] = "8.0",
   [60] = "6.0",
   [61] = "7.0",
   [62] = "7.8",
   [63] = "7.0",
   [64] = "8.3",
   [65] = "7.4",
   [66] = "7.4",
   [67] = "7.4",
   [68] = "7.4",
   [69] = "7.2",
   [70] = "7.0",
   [71] = "7.4",
   [72] = "7.4",
   [73] = "6.3",
   [74] = "8.0",
   [75] = "7.8",
   [76] = "8.0",
   [77] = "6.0",
   [78] = "7.6",
   [79] = "7.8",
   [80] = "8.7",
   [81] = "6.7",
   [82] = "8.3",
   [83] = "7.8",
   [84] = "7.2",
   [85] = "6.6",
   [86] = "6.0",
   [87] = "6.7",
   [88] = "5.8",
   [89] = "8.5",
   [90] = "6.6",
   [91] = "7.2",
   [92] = "5.5",
   [93] = "8.3",
   [94] = "5.5",
   [95] = "8.0",
   [96] = "7.4",
   [97] = "5.8",
   [98] = "7.4",
   [99] = "5.7",
  [100] = "7.8",
  [101] = "8.5",
  [102] = "6.7",
  [103] = "7.0",
  [104] = "6.0",
  [105] = "7.2",
  [106] = "6.3",
  [107] = "8.7",
  [108] = "5.5",
  [109] = "5.7",
  [110] = "6.6",
  [111] = "7.8",
  [112] = "7.6",
  [113] = "8.5",
  [114] = "7.4",
  [115] = "6.6",
  [116] = "5.8",
  [117] = "6.0",
  [118] = "7.2",
  [119] = "5.7",
  [120] = "8.0",
  [121] = "5.8",
  [122] = "8.0",
  [123] = "5.8",
  [124] = "8.3",
  [125] = "7.2",
  [126] = "7.0",
  [127] = "7.6",
  [128] = "8.7",
  [129] = "6.6",
  [130] = "6.3",
  [131] = "5.8",
  [132] = "7.8",
  [133] = "5.7",
  [134] = "8.0",
  [135] = "7.8",
  [136] = "7.8",
  [137] = "6.3",
  [138] = "6.0",
  [139] = "7.6",
  [140] = "8.3",
  [141] = "5.8",
  [142] = "5.8",
  [143] = "8.7",
  [144] = "7.0",
  [145] = "5.8",
  [146] = "7.0",
  [147] = "6.0",
  [148] = "5.8",
  [149] = "6.0",
  [150] = "7.0",
  [151] = "6.7",
  [152] = "7.6",
  [153] = "7.8",
  [154] = "5.5",
  [155] = "5.5",
  [156] = "8.0",
  [157] = "7.2",
  [158] = "6.7",
  [159] = "7.0",
  [160] = "8.5",
  [161] = "5.7",
  [162] = "6.6",
  [163] = "6.6",
  [164] = "6.7",
  [165] = "7.6",
  [166] = "7.6",
  [167] = "5.7",
  [168] = "7.4",
  [169] = "6.0",
  [170] = "5.5",
  [171] = "8.3",
  [172] = "7.0",
  [173] = "8.7",
  [174] = "6.7",
  [175] = "8.3",
  [176] = "6.3",
  [177] = "6.7",
  [178] = "5.8",
  [179] = "8.0",
  [180] = "7.6",
  [181] = "7.8",
  [182] = "6.3",
  [183] = "8.7",
  [184] = "7.4",
  [185] = "6.0",
  [186] = "7.4",
  [187] = "6.3",
  [188] = "5.8",
  [189] = "5.5",
  [190] = "8.0",
  [191] = "6.3",
  [192] = "7.4",
  [193] = "7.6",
  [194] = "7.2",
  [195] = "5.7",
  [196] = "6.6",
  [197] = "8.5",
  [198] = "8.7",
  [199] = "7.0",
  [200] = "7.4",
  [201] = "6.6",
  [202] = "5.8",
  [203] = "8.7",
  [204] = "8.0",
  [205] = "8.3",
  [206] = "7.8",
  [207] = "7.2",
  [208] = "6.6",
  [209] = "8.7",
  [210] = "6.7",
  [211] = "7.2",
  [212] = "8.5",
  [213] = "7.4",
  [214] = "7.8",
  [215] = "8.7",
  [216] = "5.7",
  [217] = "6.7",
  [218] = "8.3",
  [219] = "6.6",
  [220] = "8.3"
}

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

local function getRoleName(roleID)
    if not roleID then return "Unknown" end
    if type(roleID) == "string" then
        return roleID
    end
    return roleNames[roleID] or "Unknown"
end

local function getRoleColor(roleName)
    if not roleName then return "0xFFFFFF" end -- default putih

local colors = {
    ["8.7"]  = "0x28992D", 
    ["8.5"]  = "0x28992D",
    ["8.3"]  = "0x28992D",
    ["8.0"]  = "0x28992D",
    ["7.8"]  = "0xE2BA00",
    ["7.6"]  = "0xE2BA00",
    ["7.4"]  = "0xE2BA00",
    ["7.2"]  = "0xE2BA00",
    ["7.0"]  = "0xE2BA00",
    ["6.7"]  = "0xFF9420",
    ["6.6"]  = "0xFF9420",
    ["6.3"]  = "0xFF9420",
    ["6.0"]  = "0xFF9420",
    ["5.8"]  = "0xc82727",
    ["5.7"]  = "0xc82727",
    ["5.5"]  = "0xc82727",
}
    return colors[roleName] or "0xFFFFFF"
end
local roleName = getRoleName(data.nationalityID)
local roleColor = getRoleColor(roleName)    
    if data then 
    self.im.Publish("bnd_player_role_name", roleName)
    self.im.Publish("bnd_player_role_color", roleColor)
        self.im.Publish("bnd_player_avatar", {
            name = "$Head",
            id = data.CARD_ID
        })
        self.im.Publish("bnd_player_name", data.playerName)
        self.im.Publish("bnd_player_num", data.jerseyNumber)
        self.im.Publish("bnd_player_pos", positionIDs[data.position])
        self.im.Publish("bnd_player_national", data.nationalityID)
        self.im.Publish("bnd_player_number", data.jerseyNumber)
        self.im.Publish("bnd_player_ID", data.CARD_ID)
        self.im.Publish("bnd_player_position", data.position)
        self.im.Publish("bnd_player_country", {
            name = "$Overall",
            id = data.nationalityID
        })
        self.im.Publish("bnd_player_stars", {
            name = "$Emblema",
            id = data.nationalityID
        })
        self.im.Publish("bnd_player_style_position", {
            name = "$PositionBG",
            id = positionIDs[data.position]
        })
        self.im.Publish("bnd_player_rating", data.rating)
        self.im.Publish("bnd_3d_player", {
            name = "$_FC_PLAYER3D",
            id = data.CARD_ID
        })
        for i = 1, 6 do
            self.im.Publish("bnd_player_stat"..i, data["stat"..i])
        end
    end
end

-- 初始化数据
function Performance:Init()
    local teamInfo = self.services.SquadManagementService.GetTeamInfo(TeamID)
    local teamLineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, TeamID, 0)
    do
        do
           -- for _FORV_6_, _FORV_7_ in ipairs(teamLineup) do
          for _FORV_16_ = 1, table.getn(teamLineup) do
                local obj = {
                    --assetId = _FORV_7_.CARD_ID,
                    assetId = teamLineup[_FORV_16_].CARD_ID,
                    crestId = teamLineup[_FORV_16_].teamID,
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

function Performance:publishPlayerRows()
    math.randomseed(os.time())
    for i = #PlayerListData, 2, -1 do
        local j = math.random(i)
        PlayerListData[i], PlayerListData[j] = PlayerListData[j], PlayerListData[i]
    end

    for i, v in ipairs(PlayerListData) do
    v.data.PlayerAvatar = {
      name = "$Head",
      id = PlayerListData[i].assetId
    }
    v.data.HomeTeamCrest = {
      name = "$Crest",
      id = PlayerListData[i].crestId
     }
    v.data.PlayerNationality = {
      name = "$MR",
      id = PlayerListData[i].nationalityId
    }
 local roleNames = {
    [1] = "6.6",
    [2] = "7.0",
    [3] = "8.0",
    [4] = "7.0",
    [5] = "7.6",
    [6] = "7.2",
    [7] = "6.7",
    [8] = "8.7",
    [9] = "8.5",
   [10] = "7.0",
   [11] = "7.2",
   [12] = "5.7",
   [13] = "7.0",
   [14] = "7.4",
   [15] = "5.5",
   [16] = "7.0",
   [17] = "8.7",
   [18] = "6.6",
   [19] = "6.7",
   [20] = "5.7",
   [21] = "5.5",
   [22] = "5.8",
   [23] = "6.0",
   [24] = "7.4",
   [25] = "7.2",
   [26] = "6.0",
   [27] = "8.7",
   [28] = "7.4",
   [29] = "8.7",
   [30] = "8.0",
   [31] = "6.3",
   [32] = "5.8",
   [33] = "8.3",
   [34] = "6.7",
   [35] = "5.7",
   [36] = "6.3",
   [37] = "7.8",
   [38] = "6.3",
   [39] = "6.7",
   [40] = "7.0",
   [41] = "8.0",
   [42] = "8.7",
   [43] = "6.7",
   [44] = "5.7",
   [45] = "7.8",
   [46] = "6.0",
   [47] = "8.7",
   [48] = "7.0",
   [49] = "8.0",
   [50] = "6.6",
   [51] = "6.3",
   [52] = "7.4",
   [53] = "6.0",
   [54] = "8.5",
   [55] = "8.7",
   [56] = "6.3",
   [57] = "5.7",
   [58] = "5.5",
   [59] = "8.0",
   [60] = "6.0",
   [61] = "7.0",
   [62] = "7.8",
   [63] = "7.0",
   [64] = "8.3",
   [65] = "7.4",
   [66] = "7.4",
   [67] = "7.4",
   [68] = "7.4",
   [69] = "7.2",
   [70] = "7.0",
   [71] = "7.4",
   [72] = "7.4",
   [73] = "6.3",
   [74] = "8.0",
   [75] = "7.8",
   [76] = "8.0",
   [77] = "6.0",
   [78] = "7.6",
   [79] = "7.8",
   [80] = "8.7",
   [81] = "6.7",
   [82] = "8.3",
   [83] = "7.8",
   [84] = "7.2",
   [85] = "6.6",
   [86] = "6.0",
   [87] = "6.7",
   [88] = "5.8",
   [89] = "8.5",
   [90] = "6.6",
   [91] = "7.2",
   [92] = "5.5",
   [93] = "8.3",
   [94] = "5.5",
   [95] = "8.0",
   [96] = "7.4",
   [97] = "5.8",
   [98] = "7.4",
   [99] = "5.7",
  [100] = "7.8",
  [101] = "8.5",
  [102] = "6.7",
  [103] = "7.0",
  [104] = "6.0",
  [105] = "7.2",
  [106] = "6.3",
  [107] = "8.7",
  [108] = "5.5",
  [109] = "5.7",
  [110] = "6.6",
  [111] = "7.8",
  [112] = "7.6",
  [113] = "8.5",
  [114] = "7.4",
  [115] = "6.6",
  [116] = "5.8",
  [117] = "6.0",
  [118] = "7.2",
  [119] = "5.7",
  [120] = "8.0",
  [121] = "5.8",
  [122] = "8.0",
  [123] = "5.8",
  [124] = "8.3",
  [125] = "7.2",
  [126] = "7.0",
  [127] = "7.6",
  [128] = "8.7",
  [129] = "6.6",
  [130] = "6.3",
  [131] = "5.8",
  [132] = "7.8",
  [133] = "5.7",
  [134] = "8.0",
  [135] = "7.8",
  [136] = "7.8",
  [137] = "6.3",
  [138] = "6.0",
  [139] = "7.6",
  [140] = "8.3",
  [141] = "5.8",
  [142] = "5.8",
  [143] = "8.7",
  [144] = "7.0",
  [145] = "5.8",
  [146] = "7.0",
  [147] = "6.0",
  [148] = "5.8",
  [149] = "6.0",
  [150] = "7.0",
  [151] = "6.7",
  [152] = "7.6",
  [153] = "7.8",
  [154] = "5.5",
  [155] = "5.5",
  [156] = "8.0",
  [157] = "7.2",
  [158] = "6.7",
  [159] = "7.0",
  [160] = "8.5",
  [161] = "5.7",
  [162] = "6.6",
  [163] = "6.6",
  [164] = "6.7",
  [165] = "7.6",
  [166] = "7.6",
  [167] = "5.7",
  [168] = "7.4",
  [169] = "6.0",
  [170] = "5.5",
  [171] = "8.3",
  [172] = "7.0",
  [173] = "8.7",
  [174] = "6.7",
  [175] = "8.3",
  [176] = "6.3",
  [177] = "6.7",
  [178] = "5.8",
  [179] = "8.0",
  [180] = "7.6",
  [181] = "7.8",
  [182] = "6.3",
  [183] = "8.7",
  [184] = "7.4",
  [185] = "6.0",
  [186] = "7.4",
  [187] = "6.3",
  [188] = "5.8",
  [189] = "5.5",
  [190] = "8.0",
  [191] = "6.3",
  [192] = "7.4",
  [193] = "7.6",
  [194] = "7.2",
  [195] = "5.7",
  [196] = "6.6",
  [197] = "8.5",
  [198] = "8.7",
  [199] = "7.0",
  [200] = "7.4",
  [201] = "6.6",
  [202] = "5.8",
  [203] = "8.7",
  [204] = "8.0",
  [205] = "8.3",
  [206] = "7.8",
  [207] = "7.2",
  [208] = "6.6",
  [209] = "8.7",
  [210] = "6.7",
  [211] = "7.2",
  [212] = "8.5",
  [213] = "7.4",
  [214] = "7.8",
  [215] = "8.7",
  [216] = "5.7",
  [217] = "6.7",
  [218] = "8.3",
  [219] = "6.6",
  [220] = "8.3"
}

local roleColors = {
    ["8.7"]  = "0x28992D",
    ["8.5"]  = "0x28992D",
    ["8.3"]  = "0x28992D",
    ["8.0"]  = "0x28992D",
    ["7.8"]  = "0xE2BA00",
    ["7.6"]  = "0xE2BA00",
    ["7.4"]  = "0xE2BA00",
    ["7.2"]  = "0xE2BA00",
    ["7.0"]  = "0xE2BA00",
    ["6.7"]  = "0xFF9420",
    ["6.6"]  = "0xFF9420",
    ["6.3"]  = "0xFF9420",
    ["6.0"]  = "0xFF9420",
    ["5.8"]  = "0xc82727",
    ["5.7"]  = "0xc82727",
    ["5.5"]  = "0xc82727",
}

  local function getRoleName(roleID)
     if not roleID then return "Unknown" end
     return roleNames[roleID] or "Unknown"
 end

   local function getRoleColor(roleName)
      return roleColors[roleName] or "0xFFFFFF"
  end
    v.data.Role = getRoleName(PlayerListData[i].nationalityId)
    v.data.RoleColor = getRoleColor(v.data.Role)
    v.data.PlayerName = PlayerListData[i].playerInfo.playerName
    v.data.Rating = PlayerListData[i].playerInfo.rating
    v.data.Position = PlayerListData[i].playerInfo.position
    v.data.clickAction = PlayerListData[i].clickAction
    v.data.FontColor = "0xffffff"
    v.data.Number = PlayerListData[i].jerseyNumber
    v.data.Number1 = PlayerListData[i].nationalityId
    v.data.Country = PlayerListData[i].nationalityId
    
  end
  self.im.Publish(bndPlayerList, PlayerListData)
    self.visible = true
    self:publishVisible()
    self:publishPlayerDetail({
        id = 0
    })
end

function Performance:publishPlayerDetail(data)
    local playerIndex = data.id + 1
    local playerData = PlayerListData[playerIndex].playerInfo
    self:publishPlayerInfo(playerData)   
end

function Performance:finalize()
  self.im.Unsubscribe(BND_MATCH_DATA_PANEL_VISIBLE)
  self.im.Unsubscribe(BND_MATCH_WON_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_MATCH_LOST_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_MATCH_DRAW_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_WON_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_LOST_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_DRAW_FOOTER_VISIBLE)
  self.im.Unsubscribe(BND_DEFAULT_BANNER_VISIBLE)
  self.im.Unsubscribe(BND_AD_BANNER_DATA)
  self.im.Unsubscribe(BND_PRW1)
  self.im.Unsubscribe(BND_PRW2)
  self.im.Unsubscribe(BND_PRW3)
  self.im.Unsubscribe(BND_PRL1)
  self.im.Unsubscribe(BND_PRL2)
  self.im.Unsubscribe(BND_PRL3)
  self.im.Unsubscribe(BND_PRD1)
  self.im.Unsubscribe(BND_PRD2)
  self.im.Unsubscribe(BND_PRD3)
  self.im.Unsubscribe(BND_HOME_W)
  self.im.Unsubscribe(BND_HOME_L)
  self.im.Unsubscribe(BND_HOME_D)
  self.im.Unsubscribe(BND_AWAY_W)
  self.im.Unsubscribe(BND_AWAY_L)
  self.im.Unsubscribe(BND_AWAY_D)
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe("bnd_loading_visible")
  self.im.Unsubscribe("bnd_team_crest")
  self.im.Unsubscribe("bnd_background_match")
  self.im.Unsubscribe("bnd_team_name")
  self.im.Unsubscribe("bnd_player_name")
  self.im.Unsubscribe("bnd_player_avatar")
  self.im.Unsubscribe("bnd_player_ID")
  self.im.Unsubscribe("bnd_player_position")
  self.im.Unsubscribe("bnd_player_country")
  self.im.Unsubscribe("bnd_player_rating")
  self.im.Unsubscribe("bnd_3d_player")
  for i = 1, 6 do
    self.im.Unsubscribe("bnd_player_stat"..i)
  end
  self.im.Unsubscribe(bndPlayerList)
  self.im.UnregisterAction(ACT_PLAYER_SELECT)
end

return Performance