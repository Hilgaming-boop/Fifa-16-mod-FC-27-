-- BASE ON FIFA 16 IMPROVE BY MOUNTSA ---
-- FINAL FIX BASED ON WORKING EXAMPLE --
local KitSelect = {}
local bndSideHomeIcon = "bnd_side_home_icon"
local bndSideAwayIcon = "bnd_side_away_icon"
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
    { KITTYPE = 0, YEAR = 0, TEAMID = o.homeTeamID }, -- Home
    { KITTYPE = 1, YEAR = 0, TEAMID = o.homeTeamID }, -- Away
    { KITTYPE = 3, YEAR = 0, TEAMID = o.homeTeamID }  -- Third
  }

  o.awayTeamData = {
    { KITTYPE = 0, YEAR = 0, TEAMID = o.awayTeamID }, -- Home
    { KITTYPE = 1, YEAR = 0, TEAMID = o.awayTeamID }, -- Away
    { KITTYPE = 3, YEAR = 0, TEAMID = o.awayTeamID }  -- Third
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
  o.im.Subscribe("bnd_logoleague", function()
  local ll = getLeagueLogoByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_logoleague", ll)
end)
-- 🔹 O.IM SUBSCRIBE EVENT
o.im.Subscribe("bnd_leaguebackground", function()
  local bg = getLeagueBackgroundByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_leaguebackground", bg)
end)
o.im.Subscribe("bnd_pitch_liga", function()
  local pt = getLeaguePitchLigaByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_pitch_liga", pt)
end)
o.im.Subscribe("bnd_tab_color", function()
  local c = getLeagueTabColorByTeam(currentSelectedTeamID)
  o.im.Publish("bnd_tab_color", c)
end)
  o.im.Subscribe(BND_REALTIME, function() o.im.Publish(BND_REALTIME, os.date("%H : %M %p")) end)
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
  local idx=currentMatch.HomeKitIndex
  if idx==0 then currentMatch.HomeKitIndex=3;self:publish2DHomeKit(self.homeTeamData[3]);self:publish3DHomeKit(self.homeTeamData[3]);self:publish2DHomeKit2(self.homeTeamData[2]);self:publish2DHomeKit3(self.homeTeamData[1]);
  elseif idx==1 then currentMatch.HomeKitIndex=0;self:publish2DHomeKit(self.homeTeamData[1]);self:publish3DHomeKit(self.homeTeamData[1]);self:publish2DHomeKit2(self.homeTeamData[3]);self:publish2DHomeKit3(self.homeTeamData[2]);
  elseif idx==3 then currentMatch.HomeKitIndex=1;self:publish2DHomeKit(self.homeTeamData[2]);self:publish3DHomeKit(self.homeTeamData[2]);self:publish2DHomeKit2(self.homeTeamData[1]);self:publish2DHomeKit3(self.homeTeamData[3]);
  end;self:publishHomeKitMessage()
end
function KitSelect:changeNextHomeKit()
  local idx=currentMatch.HomeKitIndex
  if idx==0 then currentMatch.HomeKitIndex=1;self:publish2DHomeKit(self.homeTeamData[2]);self:publish3DHomeKit(self.homeTeamData[2]);self:publish2DHomeKit2(self.homeTeamData[1]);self:publish2DHomeKit3(self.homeTeamData[3]);
  elseif idx==1 then currentMatch.HomeKitIndex=3;self:publish2DHomeKit(self.homeTeamData[3]);self:publish3DHomeKit(self.homeTeamData[3]);self:publish2DHomeKit2(self.homeTeamData[2]);self:publish2DHomeKit3(self.homeTeamData[1]);
  elseif idx==3 then currentMatch.HomeKitIndex=0;self:publish2DHomeKit(self.homeTeamData[1]);self:publish3DHomeKit(self.homeTeamData[1]);self:publish2DHomeKit2(self.homeTeamData[3]);self:publish2DHomeKit3(self.homeTeamData[2]);
  end;self:publishHomeKitMessage()
end
function KitSelect:changePreviousAwayKit()
  local idx=currentMatch.AwayKitIndex
  if idx==0 then currentMatch.AwayKitIndex=3;self:publish2DAwayKit(self.awayTeamData[3]);self:publish3DAwayKit(self.awayTeamData[3]);self:publish2DAwayKit2(self.awayTeamData[2]);self:publish2DAwayKit3(self.awayTeamData[1]);
  elseif idx==1 then currentMatch.AwayKitIndex=0;self:publish2DAwayKit(self.awayTeamData[1]);self:publish3DAwayKit(self.awayTeamData[1]);self:publish2DAwayKit2(self.awayTeamData[3]);self:publish2DAwayKit3(self.awayTeamData[2]);
  elseif idx==3 then currentMatch.AwayKitIndex=1;self:publish2DAwayKit(self.awayTeamData[2]);self:publish3DAwayKit(self.awayTeamData[2]);self:publish2DAwayKit2(self.awayTeamData[1]);self:publish2DAwayKit3(self.awayTeamData[3]);
  end;self:publishAwayKitMessage()
end
function KitSelect:changeNextAwayKit()
  local idx=currentMatch.AwayKitIndex
  if idx==0 then currentMatch.AwayKitIndex=1;self:publish2DAwayKit(self.awayTeamData[2]);self:publish3DAwayKit(self.awayTeamData[2]);self:publish2DAwayKit2(self.awayTeamData[1]);self:publish2DAwayKit3(self.awayTeamData[3]);
  elseif idx==1 then currentMatch.AwayKitIndex=3;self:publish2DAwayKit(self.awayTeamData[3]);self:publish3DAwayKit(self.awayTeamData[3]);self:publish2DAwayKit2(self.awayTeamData[2]);self:publish2DAwayKit3(self.awayTeamData[1]);
  elseif idx==3 then currentMatch.AwayKitIndex=0;self:publish2DAwayKit(self.awayTeamData[1]);self:publish3DAwayKit(self.awayTeamData[1]);self:publish2DAwayKit2(self.awayTeamData[3]);self:publish2DAwayKit3(self.awayTeamData[2]);
  end;self:publishAwayKitMessage()
end
function KitSelect:checkAdvance()
  if self.services.GameState.GetControllerSide(0)==0 and not self.services.GameState.IsGamepadControllerConnected() and not self.data.skipFE then return false end
  return true
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
  function bY.clickCallback() self.nav.Event(nil,"evt_advance") end
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