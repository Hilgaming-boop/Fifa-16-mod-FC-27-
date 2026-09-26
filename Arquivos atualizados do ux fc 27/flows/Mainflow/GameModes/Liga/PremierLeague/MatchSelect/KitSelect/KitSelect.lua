-- BASE ON FIFA 16 IMPROVE BY MOUNTSA ---
-- FINAL FIX BASED ON WORKING EXAMPLE --
local KitSelect = {}
local bndBackgroundCareer = "bnd_background_career"
local bndSideHomeIcon = "bnd_side_home_icon"
local bndSideAwayIcon = "bnd_side_away_icon"
local bndSingleLeagueLogo = "bnd_league_logo"
local BND_REALTIME = "bnd_realtime"
local DEFAULT_LEAGUE_ID = 0
local bndHomeTeamData = "bnd_home_team_crest"
local bndAwayTeamData = "bnd_away_team_crest"
local bndAwayReadyLabelVisible = "bnd_away_ready_label_visible"
local bndAwayToggleVisible = "bnd_away_toggle_visible"
local bndAwaySelectingKitMsgVisible = "bnd_away_selecting_kit_msg_visible"
local bndHomeReadyLabelVisible = "bnd_home_ready_label_visible"
local bndHomeToggleVisible = "bnd_home_toggle_visible"
local bndHomeSelectingKitMsgVisible = "bnd_home_selecting_kit_msg_visible"
local bndLatency = "bnd_latency"
local bndLatencyVisible = "bnd_latency_visible"
local bndBackBtnText = "bnd_back_btn_text"
local BND_HOME_KITS = "bnd_home_kits"
local BND_AWAY_KITS = "bnd_away_kits"
local BND_HOME_KITS_INDEX = "bnd_home_kit_index"
local BND_AWAY_KITS_INDEX = "bnd_away_kit_index"
local ACT_HOME_CHANGE = "act_change_home"
local ACT_AWAY_CHANGE = "act_change_away"
local BND_TOGGLE_HOME_KIT_MESSAGE = "bnd_insToggleHomeKitMessage"
local BND_TOGGLE_AWAY_KIT_MESSAGE = "bnd_insToggleAwayKitMessage"
local bndAwayKitSelectorVisible = "bnd_away_kit_selector_visible"
local bndNoOpponentQuestionMarkVisible = "bnd_no_opponent_question_mark_visible"
local bndAwayMatchmakingMessageVisible = "bnd_away_matchmaking_message_visible"
local bndAwayTeamSelector = "bnd_away_team_selector"
local bndAwayLoadingVisible = "bnd_away_loading_visible"
local bnd3DPlayersVisible = "bnd_3d_players_visible"
local bnd2DKitsVisible = "bnd_2d_kits_visible"
local bnd2DHomeKit = "bnd_2d_home_kit"
local bnd3DHomeKit = "bnd_3d_home_kit"
local bnd2DAwayKit = "bnd_2d_away_kit"
local bnd3DAwayKit = "bnd_3d_away_kit"
local bnd2DHomeKit2 = "bnd_2d_home_kit2"
local bnd2DAwayKit2 = "bnd_2d_away_kit2"
local bnd2DHomeKit3 = "bnd_2d_home_kit3"
local bnd2DAwayKit3 = "bnd_2d_away_kit3"
local bndHomeKitAlpha = "bnd_home_kit_alpha"
local bndAwayKitAlpha = "bnd_away_kit_alpha"
local BND_TAB1 = "bnd_tab1"
local BND_TAB2 = "bnd_tab2"
local BND_TAB3 = "bnd_tab3"
local BND_TAB4 = "bnd_tab4"
local BND_TAB5 = "bnd_tab5"
local BND_TAB6 = "bnd_tab6"
local ACT_BTN_CLICK = "act_btn_click"
local actAdvance = "act_advance"
local actBack = "act_back"
local actSettings = "act_settings"
local bndDif = "bnd_match_difficulty"
local actHomeKitPrevious = "act_home_kit_previous"
local actHomeKitNext = "act_home_kit_next"
local actAwayKitPrevious = "act_away_kit_previous"
local actAwayKitNext = "act_away_kit_next"
local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5
local TAB6 = 6
local ICON_HOME = "$IconHome"
local ICON_AWAY = "$IconAway"
local ICON_COM = "$IconCom"
local ICON_HIDE = "$"

local leagueTeams = {
  [4] = {681, 1750, 670, 100081, 229, 100087, 110724, 230, 673, 680, 231, 674, 232, 2014, 537, 675},  
  [7] = {1629, 598, 1035, 111052, 517, 1048, 383, 567, 1598, 1041, 111041, 1719, 569, 568, 1043, 112472, 1053, 111059, 111057, 130361},  
  [10] = {634, 1913, 245, 1903, 247, 1910, 100632, 1908, 246, 100646, 1906, 1915, 1914, 100634, 1904, 645, 1971},  
  [13] = {13, 1925, 14, 110, 18, 19, 5, 2, 10, 144, 1, 11, 1799, 1943, 1808, 7, 9, 8, 1796, 106},  
  [14] = {15, 97, 1800, 1919, 109, 1960, 1952, 1807, 1794, 1806, 12, 3, 1795, 1792, 1951, 1790, 91, 1801, 88, 1947, 17, 94, 95, 89},  
  [16] = {65, 69, 76, 219, 73, 66, 64, 74, 1738, 72, 71, 1530, 57, 378, 379, 1809, 217, 111817},  
  [17] = {210, 62, 294, 1816, 111659, 1815, 115494, 58, 110321, 1814, 1805, 614, 68, 67, 111273, 111276, 70, 1819},  
  [19] = {175, 38, 112172, 23, 36, 32, 1831, 21, 100409, 1824, 25, 111235, 22, 110329, 10029, 169, 31, 28},  
  [20] = {580, 165, 110500, 10030, 1832, 34, 485, 166, 171, 110636, 29, 531, 110588, 110502, 160, 576, 159, 503, 523},  
  [31] = {52, 46, 347, 55, 1842, 110556, 206, 110374, 39, 48, 44, 54, 45, 189, 50, 1745, 47, 110738, 111974, 111434},  
  [32] = {1746, 205, 111811, 1744, 1837, 1843, 1848, 110373, 110740, 110908, 110915, 111433, 111657, 111993, 112124, 112168, 112493, 112494, 190, 110741},  
  [39] = {111140, 114161, 697, 114640, 111928, 693, 688, 112828, 694, 691, 113149, 112893, 114162, 112885, 687, 112134, 101112, 112996, 112606, 111651, 698, 111065, 696, 689, 111139, 111138, 695, 111144, 113018, 115243},  
  [50] = {81, 181, 83, 77, 80, 100805, 78, 86, 82, 180, 79, 621},  
  [53] = {1860, 449, 457, 243, 461, 240, 241, 453, 448, 450, 483, 110062, 481, 479, 463, 480, 452, 110827, 1853, 468},  
  [54] = {472, 100888, 462, 467, 456, 1861, 110839, 1854, 459, 260, 110069, 573, 100851, 10846, 244, 110832, 1968, 242, 1867, 100852, 110242, 121110},  
  [60] = {1797, 1793, 1933, 4, 1930, 1926, 1917, 1958, 361, 149, 1939, 1932, 1938, 15015, 1940, 1931, 143, 142, 1928, 1804, 1923, 1929, 1961, 112259},  
  [68] = {326, 325, 110776, 436, 327, 101041, 101033, 113142, 111339, 101028, 101014, 101020, 101016, 741, 748, 101026, 101037, 121174, 121388},  
  [341] = {101121, 1878, 111678, 110781, 110147, 1032, 101114, 110150, 1879, 112678, 1881, 1880, 114899, 110152, 110144, 1882, 113134, 1970},  
  [349] = {101146, 101147, 101148, 101150, 101151, 111038, 111575, 111730, 112092, 112093, 113157, 113161, 113186, 113197, 101145, 112906, 130572, 130578, 101149, 150722},  
  [350] = {112392, 112390, 112408, 111674, 112096, 112139, 113057, 112883, 112393, 113060, 113217, 607, 113037, 605, 112387, 112391, 121735, 112675, 139485, 113222},  
  [353] = {110396, 111706, 101083, 112713, 111716, 1877, 112965, 111708, 101085, 110093, 111711, 112689, 113044, 111710, 101088, 110395, 111715, 112670, 110580, 1013, 110404, 111019, 1876, 101084, 110953, 111022, 111020, 115472},  
  [365] = {111510, 111506, 111533, 111528, 111521, 111504, 111518, 111526, 111488, 111515, 111505, 111115, 111114, 111485, 1415, 111530, 111523, 111527, 111549, 111532, 1411, 1413, 111512, 111466, 974, 111536, 111514, 111525, 111513, 111392, 111391, 111464, 111516, 111502, 111524},  
  [1115] = {111090, 111658, 111670, 111733, 112094, 112099, 112234, 112631, 130278, 130281, 130279, 130382},  
  [2216] = {116020, 116010, 116017, 116343, 116014, 116016, 116012, 116013, 116015, 116009, 116011, 121725},  
  [2218] = {116036, 116037, 116040, 116039, 116042, 116038, 116035, 116416, 116034, 116033, 116386, 116041},  
  [2221] = {116300, 116302, 116303, 116304, 116305, 116306, 116307, 116308, 116309, 116310, 116311, 116312, 121477, 121478},  
  [2222] = {116325, 116326, 116327, 116328, 116330, 116331, 116332, 116333, 116334, 116336, 116337, 116339, 121125, 121391, 121720, 121733},  
  [2231] = {150735, 155450, 155449, 155448, 155447, 155446, 111180, 111181, 111183, 111184, 111348, 115514, 115868, 130037, 130040, 130046, 130219, 130220},  
  [2235] = {155606, 155603, 155611, 155604, 155614, 155607, 155601, 155600, 155612, 155617, 155616, 155620, 155621, 155618, 155602, 155624, 155609, 155630},  
  [2236] = {243, 10, 21, 73, 9, 44, 22, 112172, 241, 32, 240, 39, 45, 234, 1, 231, 101059, 47, 246, 237, 247, 211, 65, 101078, 78, 900, 69, 2, 189, 110062, 36, 267, 378, 100810, 209, 191},  
  [2237] = {115618, 115616, 115620, 115617, 115619, 115621, 115622, 115623, 130091, 130092, 130093, 130098, 130101},  
  [2238] = {245, 448, 327, 325, 72, 280, 1906, 1516, 326, 86, 457, 46, 236, 2014, 101047, 393, 10029, 1824, 18, 1896, 1908, 229, 52, 66, 11, 918, 110468, 1874, 700, 320, 266, 112372, 100545, 100761, 113888},  
  [2252] = {150601, 150600, 112730, 111736, 150602, 115529, 130288, 130291, 130292, 130293, 130294, 130295, 130296, 130384, 130386, 130999},  
  [2254] = {155622, 155619, 155623, 155625, 155626, 155615, 155610, 155605, 155631}  
}

    function getSharedLeagueID(teamA, teamB)
  for leagueID, teams in pairs(leagueTeams) do
    local inA, inB = false, false
    for _, id in ipairs(teams) do
      if id == teamA then inA = true end
      if id == teamB then inB = true end
    end
    if inA and inB then
      return leagueID
    end
  end
  return nil
end

    local matchupInfo = ""
    local globalMatchupCount = GLOBAL_MATCHUP_COUNT or 0
    local matchupIndex = 0
    local matchupInfoHomeAbbr, matchupInfoAwayAbbr 
    
    for _, v in ipairs(rivalListData or {}) do
         if v.homeID == currentSelectedTeamID or v.awayID == currentSelectedTeamID then
            if matchupIndex == globalMatchupCount then
                local opponentID = (v.homeID == currentSelectedTeamID) and v.awayID or v.homeID
                local sharedLeague = getSharedLeagueID(currentSelectedTeamID, opponentID)
                local homeName = self.loc.LocalizeString("TeamName_Abbr15_" .. v.homeID)        
                local awayName = self.loc.LocalizeString("TeamName_Abbr15_" .. v.awayID)
                local homeAbbrName = self.loc.LocalizeString("TeamName_Abbr3_" .. v.homeID)
                local awayAbbrName = self.loc.LocalizeString("TeamName_Abbr3_" .. v.awayID)
                matchupInfo = (v.homeID == currentSelectedTeamID) and "Home" or "Away"
                matchupInfo2 = homeName
                matchupInfo3 = awayName
                IDHome = v.homeID
                IDAway = v.awayID
                IDLeague = sharedLeague
                matchupInfoHomeAbbr = homeAbbrName
                matchupInfoAwayAbbr = awayAbbrName
                break
            end
            matchupIndex = matchupIndex + 1
        end
    end

function KitSelect:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    matchInfo = o:tryGetService("MatchInfoService"),
    CountryService = o.api("CountryService"),
    settingsService = o.api("SettingsService"),
    UserPlate = o.api("UserPlateService"),
    MatchSetup = o.api("MatchSetupService"),
    GameSetup = o.api("GameSetupService"),
    GameState = o.api("GameStateService"),
    Pregame = o.api("PregameService"),
    LoggingService = o.api("LoggingService"),
    ClientServerService = o.api("ClientServerService"),
    EventManagerService = o.api("EventManagerService"),
    SaveLoadService = o.api("SaveLoadService")
  }
    o.homeTeamID = currentMatch.HomeTeamID
    o.awayTeamID = currentMatch.AwayTeamID

    o.im.Subscribe(bndHomeTeamData, function()
        o.im.Publish(bndHomeTeamData, { name = "$Crest", id = o.homeTeamID })
    end)
    
    o.im.Subscribe(bndAwayTeamData, function()
        o.im.Publish(bndAwayTeamData, { name = "$Crest", id = o.awayTeamID })
    end)
  o.homeTeamData = {
    {
      KITTYPE = 0,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 1,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 3,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 4,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 5,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 6,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 7,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 8,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 9,
      YEAR = 0,
      TEAMID = o.homeTeamID
    },
    {
      KITTYPE = 10,
      YEAR = 0,
      TEAMID = o.homeTeamID
    }
  }
  o.awayTeamData = {
    {
      KITTYPE = 0,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 1,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 3,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 4,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 5,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 6,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 7,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 8,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 9,
      YEAR = 0,
      TEAMID = o.awayTeamID
    },
    {
      KITTYPE = 10,
      YEAR = 0,
      TEAMID = o.awayTeamID
    }
  }
  
    function o:getLeagueId(teamId)
        if o.services.matchInfo then
            local success, teamInfo = pcall(function() return o.services.matchInfo.GetTeamInfo(teamId) end)
            if success and teamInfo and teamInfo.league then return teamInfo.league.id end
        end
        local leagueMappings = {[1]=13,[2]=13,[3]=13,[5]=13,[7]=13,[9]=13,[10]=13,[11]=13,[13]=13,[14]=13,[18]=13,[19]=13,[95]=13,[110]=13,[240]=53,[241]=53,[243]=53,[448]=53,[449]=53,[457]=53,[461]=53,[481]=53,[483]=53,[21]=19,[22]=19,[23]=19,[25]=19,[32]=19,[34]=19,[36]=19,[175]=19,[112172]=19,[45]=31,[48]=31,[52]=31,[190]=31,[194]=31,[110374]=31,[111974]=31,[131720]=31,[57]=16,[65]=16,[66]=16,[69]=16,[70]=16,[71]=16,[72]=16,[73]=16,[74]=16,[219]=16,[687]=39,[688]=39,[697]=39,[112885]=39,[112893]=39,[112996]=39,[234]=308,[236]=308,[245]=10,[246]=10,[325]=68,[326]=68,[383]=83,[605]=350,[1386]=341,[0]=0,[-1]=-1,[-2]=-2}
        return leagueMappings[teamId] or 0
    end
    o.singleLeagueID = o:getLeagueId(o.homeTeamID)
    o.im.Subscribe(bndSingleLeagueLogo, function() o.im.Publish(bndSingleLeagueLogo, { name = "$LeagueLogo", id = IDLeague }) end)
  o.im.Subscribe(bndBackgroundCareer, function() o.im.Publish(bndBackgroundCareer, {name = "$BackgroundCareer", id = IDLeague}) end)
  o.im.Subscribe(BND_REALTIME, function() o.im.Publish(BND_REALTIME, os.date("%I:%M %p")) end)
  o.im.Subscribe(BND_TOGGLE_HOME_KIT_MESSAGE, function() o:publishHomeKitMessage() end)
  o.im.Subscribe(BND_TOGGLE_AWAY_KIT_MESSAGE, function() o:publishAwayKitMessage() end)
  o.im.Subscribe(bnd2DHomeKit, function() o:publish2DHomeKit(o.homeTeamData[1]) end)
  o.im.Subscribe(bnd3DHomeKit, function() o:publish3DHomeKit(o.homeTeamData[1]) end)
  o.im.Subscribe(bnd2DAwayKit, function() o:publish2DAwayKit(o.awayTeamData[2]) end)
  o.im.Subscribe(bnd3DAwayKit, function() o:publish3DAwayKit(o.awayTeamData[2]) end)
  o.im.Subscribe(bnd2DHomeKit2, function() o:publish2DHomeKit2(o.homeTeamData[3]) end)
  o.im.Subscribe(bnd2DAwayKit2, function() o:publish2DAwayKit2(o.awayTeamData[3]) end)
  o.im.Subscribe(bnd2DHomeKit3, function() o:publish2DHomeKit3(o.homeTeamData[2]) end)
  o.im.Subscribe(bnd2DAwayKit3, function() o:publish2DAwayKit3(o.awayTeamData[1]) end)
  o.im.Subscribe(bndHomeKitAlpha, function() o:publishHomeKitAlpha() end)
  o.im.Subscribe(bndAwayKitAlpha, function() o:publishAwayKitAlpha() end)
  o.im.RegisterAction(actHomeKitPrevious, function() o:changePreviousHomeKit() end)
  o.im.RegisterAction(actHomeKitNext, function() o:changeNextHomeKit() end)
  o.im.RegisterAction(actAwayKitPrevious, function() o:changePreviousAwayKit() end)
  o.im.RegisterAction(actAwayKitNext, function() o:changeNextAwayKit() end)
  o.buttonsID = { TAB1, TAB2, TAB3, TAB4, TAB5, TAB6 }
  o.im.Subscribe(BND_TAB1, function() end); o.im.Subscribe(BND_TAB2, function() end); o.im.Subscribe(BND_TAB3, function() end); o.im.Subscribe(BND_TAB4, function() end); o.im.Subscribe(BND_TAB5, function() end); o.im.Subscribe(BND_TAB6, function() end)
  o.im.RegisterAction(actAdvance, function(actionName, data)
    if o.services.GameState.IsGamepadControllerConnected() and not o.services.SaveLoadService.GetControllerUsed() then
      o.services.SaveLoadService.SetControllerUsed(true); o.services.SaveLoadService.CreateAndSendMessage(8)
      local buttonOk = { label = "Confirm", clickEvents = { "evt_hide_popup" }, clickCallback = function() o:_advance() end }
      local buttonNo = { label = "Cancel", clickEvents = { "evt_hide_popup" } }
      o.nav.Event(nil, "evt_show_popup", { title = "Controller Connection", message = "The controller has been detected, do you want to use it as your operating mode? Press Cancel to change to Virtual Button", buttons = {buttonNo, buttonOk} })
    else o:_advance() end
  end)
  o.im.RegisterAction(actBack, function() o:_back() end)
  o.im.RegisterAction(actSettings, function() o.nav.Event(nil, "evt_to_settings") end)
  o.im.Subscribe(bndDif, function() o.im.Publish(bndDif, o.currentOptions.difficulty) end)
  o:HideSelections()
  o.im.Publish(BND_TAB1, true)
  o.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == TAB1 then o.im.Publish(BND_TAB1, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB2 then o.im.Publish(BND_TAB2, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB3 then o.im.Publish(BND_TAB3, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB4 then o.im.Publish(BND_TAB4, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB5 then o.im.Publish(BND_TAB5, true)
    elseif o.buttonsID[data.buttonID + 1] == TAB6 then o.im.Publish(BND_TAB6, true)
    end
  end)
    
    -- Tentukan dan tampilkan ikon
    o:determineUserSide()
    o.im.Subscribe(bndSideHomeIcon, function() o:publishSideIcons() end)
    o.im.Subscribe(bndSideAwayIcon, function() o:publishSideIcons() end)
    o.im.SetTimeout(50, function() o:publishSideIcons() end)
    
    return o
end

function KitSelect:tryGetService(serviceName)
    local success, service = pcall(function() return self.api(serviceName) end)
    return success and service or nil
end

function KitSelect:HideSelections()
  self.im.Publish(BND_TAB1, false); self.im.Publish(BND_TAB2, false); self.im.Publish(BND_TAB3, false); self.im.Publish(BND_TAB4, false); self.im.Publish(BND_TAB5, false); self.im.Publish(BND_TAB6, false)
end

function KitSelect:determineUserSide()
    self.homeSideIcon = ICON_HIDE
    self.awaySideIcon = ICON_HIDE
    
    -- Logika ini sekarang akan berhasil karena `currentMatch.isUserSideHome` sudah diatur dengan benar oleh MatchSelect.lua
    if currentMatch.isUserSideHome == 0 then
        self.userSide = "home"
        self.homeSideIcon = ICON_HOME
    else
        self.userSide = "away"
        self.awaySideIcon = ICON_AWAY
    end
end

function KitSelect:publishSideIcons()
    self.im.Publish(bndSideHomeIcon, self.homeSideIcon)
    self.im.Publish(bndSideAwayIcon, self.awaySideIcon)
    self.im.ForceUpdate(bndSideHomeIcon)
    self.im.ForceUpdate(bndSideAwayIcon)
end

function KitSelect:publishHomeKitMessage()
  local idx = currentMatch.HomeKitIndex; local msg = ""
  if idx == 0 then msg = "Home" elseif idx == 1 then msg = "Away" elseif idx == 3 then msg = "Third" end
  self.im.Publish(BND_TOGGLE_HOME_KIT_MESSAGE, msg)
end
function KitSelect:publishAwayKitMessage()
  local idx = currentMatch.AwayKitIndex; local msg = ""
  if idx == 0 then msg = "Home" elseif idx == 1 then msg = "Away" elseif idx == 3 then msg = "Third" end
  self.im.Publish(BND_TOGGLE_AWAY_KIT_MESSAGE, msg)
end
function KitSelect:changePreviousHomeKit()
  local currentHomeKitIndex = currentMatch.HomeKitIndex
  if currentHomeKitIndex == 0 then
    currentMatch.HomeKitIndex = 10
    self:publish2DHomeKit(self.homeTeamData[10])
    self:publish3DHomeKit(self.homeTeamData[10])
    self:publish2DHomeKit2(self.homeTeamData[9])
    self:publish2DHomeKit3(self.homeTeamData[8])
    self:publish2DHomeKit4(self.homeTeamData[7])
    self:publish2DHomeKit5(self.homeTeamData[6])
    self:publish2DHomeKit6(self.homeTeamData[5])
    self:publish2DHomeKit7(self.homeTeamData[4])
    self:publish2DHomeKit8(self.homeTeamData[3])
    self:publish2DHomeKit9(self.homeTeamData[2])
    self:publish2DHomeKit10(self.homeTeamData[1])
  elseif currentHomeKitIndex == 1 then
    currentMatch.HomeKitIndex = 0 
    self:publish2DHomeKit(self.homeTeamData[1])
    self:publish3DHomeKit(self.homeTeamData[1])
    self:publish2DHomeKit2(self.homeTeamData[10])
    self:publish2DHomeKit3(self.homeTeamData[9])
    self:publish2DHomeKit4(self.homeTeamData[8])
    self:publish2DHomeKit5(self.homeTeamData[7])
    self:publish2DHomeKit6(self.homeTeamData[6])
    self:publish2DHomeKit7(self.homeTeamData[5])
    self:publish2DHomeKit8(self.homeTeamData[4])
    self:publish2DHomeKit9(self.homeTeamData[3])
    self:publish2DHomeKit10(self.homeTeamData[2])
  elseif currentHomeKitIndex == 3 then
    currentMatch.HomeKitIndex = 1
    self:publish2DHomeKit(self.homeTeamData[2])
    self:publish3DHomeKit(self.homeTeamData[2])
    self:publish2DHomeKit2(self.homeTeamData[1])
    self:publish2DHomeKit3(self.homeTeamData[10])
    self:publish2DHomeKit4(self.homeTeamData[9])
    self:publish2DHomeKit5(self.homeTeamData[8])
    self:publish2DHomeKit6(self.homeTeamData[7])
    self:publish2DHomeKit7(self.homeTeamData[6])
    self:publish2DHomeKit8(self.homeTeamData[5])
    self:publish2DHomeKit9(self.homeTeamData[4])
    self:publish2DHomeKit10(self.homeTeamData[3])
  elseif currentHomeKitIndex == 4 then
    currentMatch.HomeKitIndex = 3
    self:publish2DHomeKit(self.homeTeamData[3])
    self:publish3DHomeKit(self.homeTeamData[3])
    self:publish2DHomeKit2(self.homeTeamData[2])
    self:publish2DHomeKit3(self.homeTeamData[1])
    self:publish2DHomeKit4(self.homeTeamData[10])
    self:publish2DHomeKit5(self.homeTeamData[9])
    self:publish2DHomeKit6(self.homeTeamData[8])
    self:publish2DHomeKit7(self.homeTeamData[7])
    self:publish2DHomeKit8(self.homeTeamData[6])
    self:publish2DHomeKit9(self.homeTeamData[5])
    self:publish2DHomeKit10(self.homeTeamData[4])
  elseif currentHomeKitIndex == 5 then
    currentMatch.HomeKitIndex = 4
    self:publish2DHomeKit(self.homeTeamData[4])
    self:publish3DHomeKit(self.homeTeamData[4])
    self:publish2DHomeKit2(self.homeTeamData[3])
    self:publish2DHomeKit3(self.homeTeamData[2])
    self:publish2DHomeKit4(self.homeTeamData[1])
    self:publish2DHomeKit5(self.homeTeamData[10])
    self:publish2DHomeKit6(self.homeTeamData[9])
    self:publish2DHomeKit7(self.homeTeamData[8])
    self:publish2DHomeKit8(self.homeTeamData[7])
    self:publish2DHomeKit9(self.homeTeamData[6])
    self:publish2DHomeKit10(self.homeTeamData[5])
  elseif currentHomeKitIndex == 6 then
    currentMatch.HomeKitIndex = 5
    self:publish2DHomeKit(self.homeTeamData[5])
    self:publish3DHomeKit(self.homeTeamData[5])
    self:publish2DHomeKit2(self.homeTeamData[4])
    self:publish2DHomeKit3(self.homeTeamData[3])
    self:publish2DHomeKit4(self.homeTeamData[2])
    self:publish2DHomeKit5(self.homeTeamData[1])
    self:publish2DHomeKit6(self.homeTeamData[10])
    self:publish2DHomeKit7(self.homeTeamData[9])
    self:publish2DHomeKit8(self.homeTeamData[8])
    self:publish2DHomeKit9(self.homeTeamData[7])
    self:publish2DHomeKit10(self.homeTeamData[6])
    elseif currentHomeKitIndex == 7 then
    currentMatch.HomeKitIndex = 6
    self:publish2DHomeKit(self.homeTeamData[6])
    self:publish3DHomeKit(self.homeTeamData[6])
    self:publish2DHomeKit2(self.homeTeamData[5])
    self:publish2DHomeKit3(self.homeTeamData[4])
    self:publish2DHomeKit4(self.homeTeamData[3])
    self:publish2DHomeKit5(self.homeTeamData[2])
    self:publish2DHomeKit6(self.homeTeamData[1])
    self:publish2DHomeKit7(self.homeTeamData[10])
    self:publish2DHomeKit8(self.homeTeamData[9])
    self:publish2DHomeKit9(self.homeTeamData[8])
    self:publish2DHomeKit10(self.homeTeamData[7])
    elseif currentHomeKitIndex == 8 then
    currentMatch.HomeKitIndex = 7
    self:publish2DHomeKit(self.homeTeamData[7])
    self:publish3DHomeKit(self.homeTeamData[7])
    self:publish2DHomeKit2(self.homeTeamData[6])
    self:publish2DHomeKit3(self.homeTeamData[5])
    self:publish2DHomeKit4(self.homeTeamData[4])
    self:publish2DHomeKit5(self.homeTeamData[3])
    self:publish2DHomeKit6(self.homeTeamData[2])
    self:publish2DHomeKit7(self.homeTeamData[1])
    self:publish2DHomeKit8(self.homeTeamData[10])
    self:publish2DHomeKit9(self.homeTeamData[9])
    self:publish2DHomeKit10(self.homeTeamData[8])
    elseif currentHomeKitIndex == 9 then
    currentMatch.HomeKitIndex = 8
    self:publish2DHomeKit(self.homeTeamData[8])
    self:publish3DHomeKit(self.homeTeamData[8])
    self:publish2DHomeKit2(self.homeTeamData[7])
    self:publish2DHomeKit3(self.homeTeamData[6])
    self:publish2DHomeKit4(self.homeTeamData[5])
    self:publish2DHomeKit5(self.homeTeamData[4])
    self:publish2DHomeKit6(self.homeTeamData[3])
    self:publish2DHomeKit7(self.homeTeamData[2])
    self:publish2DHomeKit8(self.homeTeamData[1])
    self:publish2DHomeKit9(self.homeTeamData[10])
    self:publish2DHomeKit10(self.homeTeamData[9])
    elseif currentHomeKitIndex == 10 then
    currentMatch.HomeKitIndex = 9
    self:publish2DHomeKit(self.homeTeamData[9])
    self:publish3DHomeKit(self.homeTeamData[9])
    self:publish2DHomeKit2(self.homeTeamData[10])
    self:publish2DHomeKit3(self.homeTeamData[8])
    self:publish2DHomeKit4(self.homeTeamData[7])
    self:publish2DHomeKit5(self.homeTeamData[6])
    self:publish2DHomeKit6(self.homeTeamData[5])
    self:publish2DHomeKit7(self.homeTeamData[4])
    self:publish2DHomeKit8(self.homeTeamData[3])
    self:publish2DHomeKit9(self.homeTeamData[2])
    self:publish2DHomeKit10(self.homeTeamData[1])
  end
  self:publishHomeKitMessage()
end

function KitSelect:changeNextHomeKit()
  local currentHomeKitIndex = currentMatch.HomeKitIndex
  if currentHomeKitIndex == 0 then
    currentMatch.HomeKitIndex = 1
    self:publish2DHomeKit(self.homeTeamData[2])
    self:publish3DHomeKit(self.homeTeamData[2])
    self:publish2DHomeKit2(self.homeTeamData[1])
    self:publish2DHomeKit3(self.homeTeamData[3])
    self:publish2DHomeKit4(self.homeTeamData[4])
    self:publish2DHomeKit5(self.homeTeamData[5])
    self:publish2DHomeKit6(self.homeTeamData[6])
    self:publish2DHomeKit7(self.homeTeamData[7])
    self:publish2DHomeKit8(self.homeTeamData[8])
    self:publish2DHomeKit9(self.homeTeamData[9])
    self:publish2DHomeKit10(self.homeTeamData[10])
  elseif currentHomeKitIndex == 1 then
    currentMatch.HomeKitIndex = 3 
    self:publish2DHomeKit(self.homeTeamData[3])
    self:publish3DHomeKit(self.homeTeamData[3])
    self:publish2DHomeKit2(self.homeTeamData[2])
    self:publish2DHomeKit3(self.homeTeamData[1])
    self:publish2DHomeKit4(self.homeTeamData[10])
    self:publish2DHomeKit5(self.homeTeamData[9])
    self:publish2DHomeKit6(self.homeTeamData[8])
    self:publish2DHomeKit7(self.homeTeamData[7])
    self:publish2DHomeKit8(self.homeTeamData[6])
    self:publish2DHomeKit9(self.homeTeamData[5])
    self:publish2DHomeKit10(self.homeTeamData[4])
  elseif currentHomeKitIndex == 3 then
    currentMatch.HomeKitIndex = 4
    self:publish2DHomeKit(self.homeTeamData[4])
    self:publish3DHomeKit(self.homeTeamData[4])
    self:publish2DHomeKit2(self.homeTeamData[3])
    self:publish2DHomeKit3(self.homeTeamData[2])
    self:publish2DHomeKit4(self.homeTeamData[1])
    self:publish2DHomeKit5(self.homeTeamData[10])
    self:publish2DHomeKit6(self.homeTeamData[9])
    self:publish2DHomeKit7(self.homeTeamData[8])
    self:publish2DHomeKit8(self.homeTeamData[7])
    self:publish2DHomeKit9(self.homeTeamData[6])
    self:publish2DHomeKit10(self.homeTeamData[5])
  elseif currentHomeKitIndex == 4 then
    currentMatch.HomeKitIndex = 5
    self:publish2DHomeKit(self.homeTeamData[5])
    self:publish3DHomeKit(self.homeTeamData[5])
    self:publish2DHomeKit2(self.homeTeamData[4])
    self:publish2DHomeKit3(self.homeTeamData[3])
    self:publish2DHomeKit4(self.homeTeamData[2])
    self:publish2DHomeKit5(self.homeTeamData[1])
    self:publish2DHomeKit6(self.homeTeamData[10])
    self:publish2DHomeKit7(self.homeTeamData[9])
    self:publish2DHomeKit8(self.homeTeamData[8])
    self:publish2DHomeKit9(self.homeTeamData[7])
    self:publish2DHomeKit10(self.homeTeamData[6])
  elseif currentHomeKitIndex == 5 then
    currentMatch.HomeKitIndex = 6
    self:publish2DHomeKit(self.homeTeamData[6])
    self:publish3DHomeKit(self.homeTeamData[6])
    self:publish2DHomeKit2(self.homeTeamData[5])
    self:publish2DHomeKit3(self.homeTeamData[4])
    self:publish2DHomeKit4(self.homeTeamData[3])
    self:publish2DHomeKit5(self.homeTeamData[2])
    self:publish2DHomeKit6(self.homeTeamData[1])
    self:publish2DHomeKit6(self.homeTeamData[3])
    self:publish2DHomeKit7(self.homeTeamData[10])
    self:publish2DHomeKit8(self.homeTeamData[9])
    self:publish2DHomeKit9(self.homeTeamData[8])
    self:publish2DHomeKit10(self.homeTeamData[7])
    elseif currentHomeKitIndex == 6 then
    currentMatch.HomeKitIndex = 7
    self:publish2DHomeKit(self.homeTeamData[7])
    self:publish3DHomeKit(self.homeTeamData[7])
    self:publish2DHomeKit2(self.homeTeamData[6])
    self:publish2DHomeKit3(self.homeTeamData[5])
    self:publish2DHomeKit4(self.homeTeamData[4])
    self:publish2DHomeKit5(self.homeTeamData[3])
    self:publish2DHomeKit6(self.homeTeamData[2])
    self:publish2DHomeKit7(self.homeTeamData[1])
    self:publish2DHomeKit8(self.homeTeamData[10])
    self:publish2DHomeKit9(self.homeTeamData[9])
    self:publish2DHomeKit10(self.homeTeamData[8])
    elseif currentHomeKitIndex == 7 then
    currentMatch.HomeKitIndex = 8
    self:publish2DHomeKit(self.homeTeamData[8])
    self:publish3DHomeKit(self.homeTeamData[8])
    self:publish2DHomeKit2(self.homeTeamData[7])
    self:publish2DHomeKit3(self.homeTeamData[6])
    self:publish2DHomeKit4(self.homeTeamData[5])
    self:publish2DHomeKit5(self.homeTeamData[4])
    self:publish2DHomeKit6(self.homeTeamData[3])
    self:publish2DHomeKit7(self.homeTeamData[3])
    self:publish2DHomeKit8(self.homeTeamData[1])
    self:publish2DHomeKit9(self.homeTeamData[10])
    self:publish2DHomeKit10(self.homeTeamData[9])
    elseif currentHomeKitIndex == 8 then
    currentMatch.HomeKitIndex = 9
    self:publish2DHomeKit(self.homeTeamData[9])
    self:publish3DHomeKit(self.homeTeamData[9])
    self:publish2DHomeKit2(self.homeTeamData[8])
    self:publish2DHomeKit3(self.homeTeamData[7])
    self:publish2DHomeKit4(self.homeTeamData[6])
    self:publish2DHomeKit5(self.homeTeamData[5])
    self:publish2DHomeKit6(self.homeTeamData[4])
    self:publish2DHomeKit7(self.homeTeamData[3])
    self:publish2DHomeKit8(self.homeTeamData[2])
    self:publish2DHomeKit9(self.homeTeamData[1])
    self:publish2DHomeKit10(self.homeTeamData[10])
    elseif currentHomeKitIndex == 9 then
    currentMatch.HomeKitIndex = 10
    self:publish2DHomeKit(self.homeTeamData[10])
    self:publish3DHomeKit(self.homeTeamData[10])
    self:publish2DHomeKit2(self.homeTeamData[9])
    self:publish2DHomeKit3(self.homeTeamData[8])
    self:publish2DHomeKit4(self.homeTeamData[7])
    self:publish2DHomeKit5(self.homeTeamData[6])
    self:publish2DHomeKit6(self.homeTeamData[5])
    self:publish2DHomeKit7(self.homeTeamData[4])
    self:publish2DHomeKit8(self.homeTeamData[3])
    self:publish2DHomeKit9(self.homeTeamData[2])
    self:publish2DHomeKit10(self.homeTeamData[1])
  elseif currentHomeKitIndex == 10 then
    currentMatch.HomeKitIndex = 0
    self:publish2DHomeKit(self.homeTeamData[1])
    self:publish3DHomeKit(self.homeTeamData[1])
    self:publish2DHomeKit2(self.homeTeamData[10])
    self:publish2DHomeKit3(self.homeTeamData[9])
    self:publish2DHomeKit4(self.homeTeamData[8])
    self:publish2DHomeKit5(self.homeTeamData[7])
    self:publish2DHomeKit6(self.homeTeamData[6])
    self:publish2DHomeKit7(self.homeTeamData[5])
    self:publish2DHomeKit8(self.homeTeamData[4])
    self:publish2DHomeKit9(self.homeTeamData[3])
    self:publish2DHomeKit10(self.homeTeamData[2])
  end
  self:publishHomeKitMessage()
end

function KitSelect:changePreviousAwayKit()
  local currentAwayKitIndex = currentMatch.AwayKitIndex
  if currentAwayKitIndex == 0 then
    currentMatch.AwayKitIndex = 10
    self:publish2DAwayKit(self.awayTeamData[10])
    self:publish3DAwayKit(self.awayTeamData[10])
    self:publish2DAwayKit2(self.awayTeamData[9])
    self:publish2DAwayKit3(self.awayTeamData[8])
    self:publish2DAwayKit4(self.awayTeamData[7])
    self:publish2DAwayKit5(self.awayTeamData[6])
    self:publish2DAwayKit6(self.awayTeamData[5])
    self:publish2DAwayKit7(self.awayTeamData[4])
    self:publish2DAwayKit9(self.awayTeamData[3])
    self:publish2DAwayKit8(self.awayTeamData[2])
    self:publish2DAwayKit10(self.awayTeamData[1])
  elseif currentAwayKitIndex == 1 then
    currentMatch.AwayKitIndex = 0 
    self:publish2DAwayKit(self.awayTeamData[1])
    self:publish3DAwayKit(self.awayTeamData[1])
    self:publish2DAwayKit2(self.awayTeamData[10])
    self:publish2DAwayKit3(self.awayTeamData[9])
    self:publish2DAwayKit4(self.awayTeamData[8])
    self:publish2DAwayKit5(self.awayTeamData[7])
    self:publish2DAwayKit6(self.awayTeamData[6])
    self:publish2DAwayKit7(self.awayTeamData[5])
    self:publish2DAwayKit8(self.awayTeamData[4])
    self:publish2DAwayKit9(self.awayTeamData[3])
    self:publish2DAwayKit10(self.awayTeamData[2])
  elseif currentAwayKitIndex == 3 then
    currentMatch.AwayKitIndex = 1
    self:publish2DAwayKit(self.awayTeamData[2])
    self:publish3DAwayKit(self.awayTeamData[2])
    self:publish2DAwayKit2(self.awayTeamData[1])
    self:publish2DAwayKit3(self.awayTeamData[10])
    self:publish2DAwayKit4(self.awayTeamData[9])
    self:publish2DAwayKit5(self.awayTeamData[8])
    self:publish2DAwayKit6(self.awayTeamData[7])
    self:publish2DAwayKit7(self.awayTeamData[6])
    self:publish2DAwayKit8(self.awayTeamData[5])
    self:publish2DAwayKit9(self.awayTeamData[4])
    self:publish2DAwayKit10(self.awayTeamData[3])
  elseif currentAwayKitIndex == 4 then
    currentMatch.AwayKitIndex = 3
    self:publish2DAwayKit(self.awayTeamData[3])
    self:publish3DAwayKit(self.awayTeamData[3])
    self:publish2DAwayKit2(self.awayTeamData[2])
    self:publish2DAwayKit3(self.awayTeamData[1])
    self:publish2DAwayKit4(self.awayTeamData[10])
    self:publish2DAwayKit5(self.awayTeamData[9])
    self:publish2DAwayKit6(self.awayTeamData[8])
    self:publish2DAwayKit7(self.awayTeamData[7])
    self:publish2DAwayKit8(self.awayTeamData[6])
    self:publish2DAwayKit9(self.awayTeamData[5])
    self:publish2DAwayKit10(self.awayTeamData[4])
  elseif currentAwayKitIndex == 5 then
    currentMatch.AwayKitIndex = 4
    self:publish2DAwayKit(self.awayTeamData[4])
    self:publish3DAwayKit(self.awayTeamData[4])
    self:publish2DAwayKit2(self.awayTeamData[3])
    self:publish2DAwayKit3(self.awayTeamData[2])
    self:publish2DAwayKit4(self.awayTeamData[1])
    self:publish2DAwayKit5(self.awayTeamData[10])
    self:publish2DAwayKit6(self.awayTeamData[9])
    self:publish2DAwayKit7(self.awayTeamData[8])
    self:publish2DAwayKit8(self.awayTeamData[7])
    self:publish2DAwayKit9(self.awayTeamData[6])
    self:publish2DAwayKit10(self.awayTeamData[5])
  elseif currentAwayKitIndex == 6 then
    currentMatch.AwayKitIndex = 5
    self:publish2DAwayKit(self.awayTeamData[5])
    self:publish3DAwayKit(self.awayTeamData[5])
    self:publish2DAwayKit2(self.awayTeamData[4])
    self:publish2DAwayKit3(self.awayTeamData[3])
    self:publish2DAwayKit4(self.awayTeamData[2])
    self:publish2DAwayKit5(self.awayTeamData[1])
    self:publish2DAwayKit6(self.awayTeamData[10])
    self:publish2DAwayKit7(self.awayTeamData[9])
    self:publish2DAwayKit8(self.awayTeamData[8])
    self:publish2DAwayKit9(self.awayTeamData[7])
    self:publish2DAwayKit10(self.awayTeamData[6])
  elseif currentAwayKitIndex == 7 then
    currentMatch.AwayKitIndex = 6
    self:publish2DAwayKit(self.awayTeamData[6])
    self:publish3DAwayKit(self.awayTeamData[6])
    self:publish2DAwayKit2(self.awayTeamData[5])
    self:publish2DAwayKit3(self.awayTeamData[4])
    self:publish2DAwayKit4(self.awayTeamData[3])
    self:publish2DAwayKit5(self.awayTeamData[2])
    self:publish2DAwayKit6(self.awayTeamData[1])
    self:publish2DAwayKit7(self.awayTeamData[10])
    self:publish2DAwayKit8(self.awayTeamData[9])
    self:publish2DAwayKit9(self.awayTeamData[8])
    self:publish2DAwayKit10(self.awayTeamData[7])
    elseif currentAwayKitIndex == 8 then
    currentMatch.AwayKitIndex = 7
    self:publish2DAwayKit(self.awayTeamData[8])
    self:publish3DAwayKit(self.awayTeamData[8])
    self:publish2DAwayKit2(self.awayTeamData[7])
    self:publish2DAwayKit3(self.awayTeamData[6])
    self:publish2DAwayKit4(self.awayTeamData[5])
    self:publish2DAwayKit5(self.awayTeamData[4])
    self:publish2DAwayKit6(self.awayTeamData[3])
    self:publish2DAwayKit7(self.awayTeamData[2])
    self:publish2DAwayKit8(self.awayTeamData[1])
    self:publish2DAwayKit9(self.awayTeamData[10])
    self:publish2DAwayKit10(self.awayTeamData[9])
    elseif currentAwayKitIndex == 9 then
    currentMatch.AwayKitIndex = 8
    self:publish2DAwayKit(self.awayTeamData[8])
    self:publish3DAwayKit(self.awayTeamData[8])
    self:publish2DAwayKit2(self.awayTeamData[7])
    self:publish2DAwayKit3(self.awayTeamData[6])
    self:publish2DAwayKit4(self.awayTeamData[5])
    self:publish2DAwayKit5(self.awayTeamData[4])
    self:publish2DAwayKit6(self.awayTeamData[3])
    self:publish2DAwayKit7(self.awayTeamData[2])
    self:publish2DAwayKit8(self.awayTeamData[1])
    self:publish2DAwayKit9(self.awayTeamData[10])
    self:publish2DAwayKit10(self.awayTeamData[9])
    elseif currentAwayKitIndex == 10 then
    currentMatch.AwayKitIndex = 9
    self:publish2DAwayKit(self.awayTeamData[9])
    self:publish3DAwayKit(self.awayTeamData[9])
    self:publish2DAwayKit2(self.awayTeamData[8])
    self:publish2DAwayKit3(self.awayTeamData[7])
    self:publish2DAwayKit4(self.awayTeamData[6])
    self:publish2DAwayKit5(self.awayTeamData[5])
    self:publish2DAwayKit6(self.awayTeamData[4])
    self:publish2DAwayKit7(self.awayTeamData[3])
    self:publish2DAwayKit8(self.awayTeamData[2])
    self:publish2DAwayKit9(self.awayTeamData[1])
    self:publish2DAwayKit10(self.awayTeamData[10])
  end
  self:publishAwayKitMessage()
end

function KitSelect:changeNextAwayKit()
  local currentAwayKitIndex = currentMatch.AwayKitIndex
  if currentAwayKitIndex == 0 then
    currentMatch.AwayKitIndex = 1
    self:publish2DAwayKit(self.awayTeamData[2])
    self:publish3DAwayKit(self.awayTeamData[2])
    self:publish2DAwayKit2(self.awayTeamData[1])
    self:publish2DAwayKit3(self.awayTeamData[10])
    self:publish2DAwayKit4(self.awayTeamData[9])
    self:publish2DAwayKit5(self.awayTeamData[8])
    self:publish2DAwayKit6(self.awayTeamData[7])
    self:publish2DAwayKit7(self.awayTeamData[6])
    self:publish2DAwayKit8(self.awayTeamData[5])
    self:publish2DAwayKit9(self.awayTeamData[4])
    self:publish2DAwayKit10(self.awayTeamData[3])
  elseif currentAwayKitIndex == 1 then
    currentMatch.AwayKitIndex = 3 
    self:publish2DAwayKit(self.awayTeamData[3])
    self:publish3DAwayKit(self.awayTeamData[3])
    self:publish2DAwayKit2(self.awayTeamData[2])
    self:publish2DAwayKit3(self.awayTeamData[1])
    self:publish2DAwayKit4(self.awayTeamData[10])
    self:publish2DAwayKit5(self.awayTeamData[9])
    self:publish2DAwayKit6(self.awayTeamData[8])
    self:publish2DAwayKit7(self.awayTeamData[7])
    self:publish2DAwayKit8(self.awayTeamData[6])
    self:publish2DAwayKit9(self.awayTeamData[5])
    self:publish2DAwayKit10(self.awayTeamData[4])
  elseif currentAwayKitIndex == 3 then
    currentMatch.AwayKitIndex = 4
    self:publish2DAwayKit(self.awayTeamData[4])
    self:publish3DAwayKit(self.awayTeamData[4])
    self:publish2DAwayKit2(self.awayTeamData[3])
    self:publish2DAwayKit3(self.awayTeamData[2])
    self:publish2DAwayKit4(self.awayTeamData[1])
    self:publish2DAwayKit5(self.awayTeamData[10])
    self:publish2DAwayKit6(self.awayTeamData[9])
    self:publish2DAwayKit7(self.awayTeamData[8])
    self:publish2DAwayKit8(self.awayTeamData[7])
    self:publish2DAwayKit9(self.awayTeamData[6])
    self:publish2DAwayKit10(self.awayTeamData[5])
  elseif currentAwayKitIndex == 4 then
    currentMatch.AwayKitIndex = 5
    self:publish2DAwayKit(self.awayTeamData[5])
    self:publish3DAwayKit(self.awayTeamData[5])
    self:publish2DAwayKit2(self.awayTeamData[4])
    self:publish2DAwayKit3(self.awayTeamData[3])
    self:publish2DAwayKit4(self.awayTeamData[2])
    self:publish2DAwayKit5(self.awayTeamData[1])
    self:publish2DAwayKit6(self.awayTeamData[10])
    self:publish2DAwayKit7(self.awayTeamData[9])
    self:publish2DAwayKit8(self.awayTeamData[8])
    self:publish2DAwayKit9(self.awayTeamData[7])
    self:publish2DAwayKit10(self.awayTeamData[6])
  elseif currentAwayKitIndex == 5 then
    currentMatch.AwayKitIndex = 6
    self:publish2DAwayKit(self.awayTeamData[6])
    self:publish3DAwayKit(self.awayTeamData[6])
    self:publish2DAwayKit2(self.awayTeamData[5])
    self:publish2DAwayKit3(self.awayTeamData[4])
    self:publish2DAwayKit4(self.awayTeamData[3])
    self:publish2DAwayKit5(self.awayTeamData[2])
    self:publish2DAwayKit6(self.awayTeamData[1])
    self:publish2DAwayKit7(self.awayTeamData[10])
    self:publish2DAwayKit8(self.awayTeamData[9])
    self:publish2DAwayKit9(self.awayTeamData[8])
    self:publish2DAwayKit10(self.awayTeamData[7])
    elseif currentAwayKitIndex == 6 then
    currentMatch.AwayKitIndex = 7
    self:publish2DAwayKit(self.awayTeamData[7])
    self:publish3DAwayKit(self.awayTeamData[7])
    self:publish2DAwayKit2(self.awayTeamData[6])
    self:publish2DAwayKit3(self.awayTeamData[5])
    self:publish2DAwayKit4(self.awayTeamData[4])
    self:publish2DAwayKit5(self.awayTeamData[3])
    self:publish2DAwayKit6(self.awayTeamData[2])
    self:publish2DAwayKit7(self.awayTeamData[1])
    self:publish2DAwayKit8(self.awayTeamData[10])
    self:publish2DAwayKit9(self.awayTeamData[9])
    self:publish2DAwayKit10(self.awayTeamData[8])
    elseif currentAwayKitIndex == 7 then
    currentMatch.AwayKitIndex = 8
    self:publish2DAwayKit(self.awayTeamData[8])
    self:publish3DAwayKit(self.awayTeamData[8])
    self:publish2DAwayKit2(self.awayTeamData[7])
    self:publish2DAwayKit3(self.awayTeamData[5])
    self:publish2DAwayKit4(self.awayTeamData[4])
    self:publish2DAwayKit5(self.awayTeamData[3])
    self:publish2DAwayKit6(self.awayTeamData[2])
    self:publish2DAwayKit7(self.awayTeamData[1])
    self:publish2DAwayKit8(self.awayTeamData[10])
    self:publish2DAwayKit9(self.awayTeamData[9])
    self:publish2DAwayKit10(self.awayTeamData[8])
    elseif currentAwayKitIndex == 8 then
    currentMatch.AwayKitIndex = 9
    self:publish2DAwayKit(self.awayTeamData[9])
    self:publish3DAwayKit(self.awayTeamData[9])
    self:publish2DAwayKit2(self.awayTeamData[8])
    self:publish2DAwayKit3(self.awayTeamData[7])
    self:publish2DAwayKit4(self.awayTeamData[6])
    self:publish2DAwayKit5(self.awayTeamData[5])
    self:publish2DAwayKit6(self.awayTeamData[4])
    self:publish2DAwayKit7(self.awayTeamData[3])
    self:publish2DAwayKit8(self.awayTeamData[2])
    self:publish2DAwayKit9(self.awayTeamData[1])
    self:publish2DAwayKit10(self.awayTeamData[10])
    elseif currentAwayKitIndex == 9 then
    currentMatch.AwayKitIndex = 10
    self:publish2DAwayKit(self.awayTeamData[10])
    self:publish3DAwayKit(self.awayTeamData[10])
    self:publish2DAwayKit2(self.awayTeamData[9])
    self:publish2DAwayKit3(self.awayTeamData[8])
    self:publish2DAwayKit4(self.awayTeamData[7])
    self:publish2DAwayKit5(self.awayTeamData[6])
    self:publish2DAwayKit6(self.awayTeamData[5])
    self:publish2DAwayKit7(self.awayTeamData[4])
    self:publish2DAwayKit8(self.awayTeamData[3])
    self:publish2DAwayKit9(self.awayTeamData[2])
    self:publish2DAwayKit10(self.awayTeamData[1])
  elseif currentAwayKitIndex == 10 then
    currentMatch.AwayKitIndex = 0
    self:publish2DAwayKit(self.awayTeamData[1])
    self:publish3DAwayKit(self.awayTeamData[1])
    self:publish2DAwayKit2(self.awayTeamData[9])
    self:publish2DAwayKit3(self.awayTeamData[8])
    self:publish2DAwayKit4(self.awayTeamData[7])
    self:publish2DAwayKit5(self.awayTeamData[6])
    self:publish2DAwayKit6(self.awayTeamData[5])
    self:publish2DAwayKit8(self.awayTeamData[4])
    self:publish2DAwayKit9(self.awayTeamData[3])
    self:publish2DAwayKit10(self.awayTeamData[2])
  end
  self:publishAwayKitMessage()
end
function KitSelect:publish2DHomeKit(d) self.im.Publish(bnd2DHomeKit, {name="$Kits",id=string.format("%s_%s_%s",d.KITTYPE,d.TEAMID,d.YEAR)}) end
function KitSelect:publish3DHomeKit(d) self.im.Publish(bnd3DHomeKit, {name="$PlayerKits",id=string.format("%s_%s_%s",d.KITTYPE,d.TEAMID,d.YEAR)}) end
function KitSelect:publish2DAwayKit(d) self.im.Publish(bnd2DAwayKit, {name="$Kits",id=string.format("%s_%s_%s",d.KITTYPE,d.TEAMID,d.YEAR)}) end
function KitSelect:publish3DAwayKit(d) self.im.Publish(bnd3DAwayKit, {name="$PlayerKits",id=string.format("%s_%s_%s",d.KITTYPE,d.TEAMID,d.YEAR)}) end
function KitSelect:publish2DHomeKit2(d) self.im.Publish(bnd2DHomeKit2, {name="$Kits",id=string.format("%s_%s_%s",d.KITTYPE,d.TEAMID,d.YEAR)}) end
function KitSelect:publish2DAwayKit2(d) self.im.Publish(bnd2DAwayKit2, {name="$Kits",id=string.format("%s_%s_%s",d.KITTYPE,d.TEAMID,d.YEAR)}) end
function KitSelect:publish2DHomeKit3(d) self.im.Publish(bnd2DHomeKit3, {name="$Kits",id=string.format("%s_%s_%s",d.KITTYPE,d.TEAMID,d.YEAR)}) end
function KitSelect:publish2DAwayKit3(d) self.im.Publish(bnd2DAwayKit3, {name="$Kits",id=string.format("%s_%s_%s",d.KITTYPE,d.TEAMID,d.YEAR)}) end
function KitSelect:publishHomeKitAlpha() self.im.Publish(bndHomeKitAlpha, self.userSide == self.USER_SIDE.HOME and self.userKitSelectorAlpha or self.opponentKitSelectorAlpha) end
function KitSelect:publishAwayKitAlpha() self.im.Publish(bndAwayKitAlpha, self.userSide == self.USER_SIDE.AWAY and self.userKitSelectorAlpha or self.opponentKitSelectorAlpha) end
function KitSelect:publishSideHomeIcon() self.im.Publish(bndSideHomeIcon, self.homeSideIcon) end
function KitSelect:publishSideAwayIcon() self.im.Publish(bndSideAwayIcon, self.awaySideIcon) end
function KitSelect:_doAdvance()
  local bN={icon="$FooterIconNo",label="Cancel",clickEvents={"evt_hide_popup","evt_refresh_on_resize"}}
  local bY={icon="$FooterIconYes",label="Confirm",clickEvents={"evt_hide_popup"}}
  function bY.clickCallback()
    self.nav.Event(nil,"evt_advance") end
  self.nav.Event(nil, "evt_show_popup", {title="INFO",message="Are you ready to start the match?",buttons={bN,bY}})
end
function KitSelect:_advance() self.im.ChangeActionState(actAdvance,self.im.GetActionState("INVALID")); self.im.ChangeActionState(actBack,self.im.GetActionState("INVALID")); self:_doAdvance() end
function KitSelect:_back() self.nav.Event(nil, "evt_back") end
function KitSelect:finalize()
  self.im.Unsubscribe(BND_REALTIME);self.im.Unsubscribe(bndHomeTeamUser);self.im.Unsubscribe(bndHomeTeamData);self.im.Unsubscribe(bndAwayTeamData);self.im.Unsubscribe(bndAwayTeamUser);self.im.Unsubscribe(bndAwayReadyLabelVisible);self.im.Unsubscribe(bndAwayToggleVisible);self.im.Unsubscribe(bndAwaySelectingKitMsgVisible);self.im.Unsubscribe(bndHomeReadyLabelVisible);self.im.Unsubscribe(bndHomeToggleVisible);self.im.Unsubscribe(bndHomeSelectingKitMsgVisible);self.im.Unsubscribe(bndLatency);self.im.Unsubscribe(bndLatencyVisible);self.im.Unsubscribe(bndAwayKitSelectorVisible);self.im.Unsubscribe(bndNoOpponentQuestionMarkVisible);self.im.Unsubscribe(bndAwayMatchmakingMessageVisible);self.im.Unsubscribe(bndAwayTeamSelector);self.im.Unsubscribe(bndAwayLoadingVisible);self.im.Unsubscribe(bnd3DPlayersVisible);self.im.Unsubscribe(bnd2DKitsVisible);self.im.Unsubscribe(bnd2DHomeKit);self.im.Unsubscribe(bnd3DHomeKit);self.im.Unsubscribe(bnd2DAwayKit);self.im.Unsubscribe(bnd3DAwayKit);self.im.Unsubscribe(bnd2DHomeKit2);self.im.Unsubscribe(bnd2DAwayKit2);self.im.Unsubscribe(bnd2DHomeKit3);self.im.Unsubscribe(bnd2DAwayKit3);self.im.Unsubscribe(bndHomeKitAlpha);self.im.Unsubscribe(bndAwayKitAlpha);self.im.Unsubscribe(bndBackBtnText);self.im.UnregisterAction(actAdvance);self.im.UnregisterAction(actBack);self.im.UnregisterAction(actSettings);self.im.Unsubscribe(bndDif);self.im.UnregisterAction(actHomeKitPrevious);self.im.UnregisterAction(actHomeKitNext);self.im.UnregisterAction(actAwayKitPrevious);self.im.UnregisterAction(actAwayKitNext);self.im.UnregisterAction(ACT_BTN_CLICK);self.im.UnregisterDataAction(BND_HOME_KITS_INDEX,ACT_HOME_CHANGE);self.im.UnregisterDataAction(BND_AWAY_KITS_INDEX,ACT_AWAY_CHANGE);self.im.Unsubscribe(BND_HOME_KITS);self.im.Unsubscribe(BND_AWAY_KITS);self.im.Unsubscribe(BND_TAB1);self.im.Unsubscribe(BND_TAB2);self.im.Unsubscribe(BND_TAB3);self.im.Unsubscribe(BND_TAB4);self.im.Unsubscribe(BND_TAB5);self.im.Unsubscribe(BND_TAB6);self.im.Unsubscribe("bnd_league_logo")
end
return KitSelect
-- Thanks : EA Sport Fifa 16 - Ma'ruf Id & Laosiji --
-- And All Modder -- @OnlyFans MounTsa