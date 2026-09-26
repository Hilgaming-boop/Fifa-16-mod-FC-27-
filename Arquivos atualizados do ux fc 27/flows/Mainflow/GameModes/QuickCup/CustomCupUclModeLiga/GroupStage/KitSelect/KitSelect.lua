
local KitSelect = {}

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

local bnd2DHomeKit4 = "bnd_2d_home_kit4"
local bnd2DAwayKit4 = "bnd_2d_away_kit4"

local bnd2DHomeKit5 = "bnd_2d_home_kit5"
local bnd2DAwayKit5 = "bnd_2d_away_kit5"

local bnd2DHomeKit6 = "bnd_2d_home_kit6"
local bnd2DAwayKit6 = "bnd_2d_away_kit6"

local bnd2DHomeKit7 = "bnd_2d_home_kit7"
local bnd2DAwayKit7 = "bnd_2d_away_kit7"

local bnd2DHomeKit8 = "bnd_2d_home_kit8"
local bnd2DAwayKit8 = "bnd_2d_away_kit8"

local bnd2DHomeKit9 = "bnd_2d_home_kit9"
local bnd2DAwayKit9 = "bnd_2d_away_kit9"

local bnd2DHomeKit10 = "bnd_2d_home_kit10"
local bnd2DAwayKit10 = "bnd_2d_away_kit10"

local bndHomeKitAlpha = "bnd_home_kit_alpha"
local bndAwayKitAlpha = "bnd_away_kit_alpha"

local BND_TAB1 = "bnd_tab1"
local BND_TAB2 = "bnd_tab2"
local BND_TAB3 = "bnd_tab3"
local BND_TAB4 = "bnd_tab4"
local BND_TAB5 = "bnd_tab5"
local BND_TAB6 = "bnd_tab6"
local BND_TAB7 = "bnd_tab7"

local ACT_BTN_CLICK = "act_btn_click"

local actAdvance = "act_advance"
local actBack = "act_back"
local actSettings = "act_settings"

local bndDif = "bnd_match_difficulty"

local actHomeKitPrevious = "act_home_kit_previous"
local actHomeKitNext = "act_home_kit_next"
local actAwayKitPrevious = "act_away_kit_previous"
local actAwayKitNext = "act_away_kit_next"

local BND_BG_CUP = "bnd_bg_tour"
local bndSingleTourLogo = "bnd_tour_logo"
local BND_COLOR_CUPID = "bnd_color_tourid"

local TAB1 = 1
local TAB2 = 2
local TAB3 = 3
local TAB4 = 4
local TAB5 = 5
local TAB6 = 6
local TAB7 = 7


function KitSelect:new(init)

    local o = init or {}

    setmetatable(o, self)
    self.__index = self

    if currentMatch then

        print("✅ KitSelect: Menerima currentMatch.HomeTeamID = " ..
            tostring(currentMatch.HomeTeamID))

        print("✅ KitSelect: Menerima currentMatch.AwayTeamID = " ..
            tostring(currentMatch.AwayTeamID))

    else

        print("❌ KitSelect: ERROR! Tabel 'currentMatch' tidak ditemukan.")

        currentMatch = {
            HomeTeamID = 1,
            AwayTeamID = 10,
            HomeKitIndex = 0,
            AwayKitIndex = 1
        }

    end


    o.services = {

        matchInfo = o.api("MatchInfoService"),
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


    o.currentOptions = o.services.settingsService.GetCurrentOptions()


    if not currentTourData or not currentTourData.homeID then

        print("❌ KitSelect: Gagal membaca currentTourData. Menggunakan tim default.")

        currentTourData = {
            homeID = 1,
            awayID = 10,
            homeKitIndex = 0,
            awayKitIndex = 1,
            isUserSideHome = 0
        }

    end


    o.homeTeamID = currentTourData.homeID
    o.awayTeamID = currentTourData.awayID
    o.singleTourID = currentTourData.tourIndex
    o.colorID = currentTourData.tourColor


    o.im.Subscribe(bndHomeTeamData, function()

        o.im.Publish(bndHomeTeamData, {
            name = "$Crest",
            id = o.homeTeamID
        })

    end)


    o.im.Subscribe(bndAwayTeamData, function()

        o.im.Publish(bndAwayTeamData, {
            name = "$Crest",
            id = o.awayTeamID
        })

    end)


    -------------------------------------------------------
    -- ONLY 3 KITS
    -- 0 = HOME
    -- 1 = AWAY
    -- 3 = THIRD
    -------------------------------------------------------

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
        }

    }


    print("KitSelect initialized:")
    print("  TOUR ID: " .. tostring(o.singleTourID))
    print("  COLOR ID: " .. tostring(o.colorID))
    print("  KIT COUNT: 3")


    -------------------------------------------------------
    -- TOUR
    -------------------------------------------------------

    o.im.Subscribe(bndSingleTourLogo, function()

        o.im.Publish(bndSingleTourLogo, {
            name = "$CupLogo",
            id = o.singleTourID
        })

    end)


    o.im.Subscribe(BND_BG_CUP, function()

        o.im.Publish(BND_BG_CUP, {
            name = "$Bg_Cup",
            id = o.singleTourID
        })

    end)


    o.im.Subscribe(BND_COLOR_CUPID, function()

        o.im.Publish(BND_COLOR_CUPID, o.colorID)

    end)


    -------------------------------------------------------
    -- DEFAULT KIT INDEX
    -------------------------------------------------------

    currentMatch.HomeKitIndex = currentMatch.HomeKitIndex or 0
    currentMatch.AwayKitIndex = currentMatch.AwayKitIndex or 1


    -- Prevent old 10-kit indexes from causing problems

    if currentMatch.HomeKitIndex ~= 0
        and currentMatch.HomeKitIndex ~= 1
        and currentMatch.HomeKitIndex ~= 3 then

        currentMatch.HomeKitIndex = 0

    end


    if currentMatch.AwayKitIndex ~= 0
        and currentMatch.AwayKitIndex ~= 1
        and currentMatch.AwayKitIndex ~= 3 then

        currentMatch.AwayKitIndex = 1

    end


    local homeKitIdx = self:getKitDataIndex(currentMatch.HomeKitIndex)
    local awayKitIdx = self:getKitDataIndex(currentMatch.AwayKitIndex)


    local initialHomeKit = o.homeTeamData[homeKitIdx]
    local initialAwayKit = o.awayTeamData[awayKitIdx]


    -------------------------------------------------------
    -- INITIAL KIT PREVIEWS
    -------------------------------------------------------

    local initialHomeKit2 =
        o.homeTeamData[(homeKitIdx % 3) + 1]

    local initialHomeKit3 =
        o.homeTeamData[((homeKitIdx + 1) % 3) + 1]


    local initialAwayKit2 =
        o.awayTeamData[(awayKitIdx % 3) + 1]

    local initialAwayKit3 =
        o.awayTeamData[((awayKitIdx + 1) % 3) + 1]


    o.im.Subscribe(bnd2DHomeKit, function()
        o:publish2DHomeKit(initialHomeKit)
    end)


    o.im.Subscribe(bnd3DHomeKit, function()
        o:publish3DHomeKit(initialHomeKit)
    end)


    o.im.Subscribe(bnd2DAwayKit, function()
        o:publish2DAwayKit(initialAwayKit)
    end)


    o.im.Subscribe(bnd3DAwayKit, function()
        o:publish3DAwayKit(initialAwayKit)
    end)


    o.im.Subscribe(bnd2DHomeKit2, function()
        o:publish2DHomeKit2(initialHomeKit2)
    end)


    o.im.Subscribe(bnd2DAwayKit2, function()
        o:publish2DAwayKit2(initialAwayKit2)
    end)


    o.im.Subscribe(bnd2DHomeKit3, function()
        o:publish2DHomeKit3(initialHomeKit3)
    end)


    o.im.Subscribe(bnd2DAwayKit3, function()
        o:publish2DAwayKit3(initialAwayKit3)
    end)


    o.im.Subscribe(bndHomeKitAlpha, function()
        o:publishHomeKitAlpha()
    end)


    o.im.Subscribe(bndAwayKitAlpha, function()
        o:publishAwayKitAlpha()
    end)


    o.im.Subscribe(BND_TOGGLE_HOME_KIT_MESSAGE, function()
        o:publishHomeKitMessage()
    end)


    o.im.Subscribe(BND_TOGGLE_AWAY_KIT_MESSAGE, function()
        o:publishAwayKitMessage()
    end)


    -------------------------------------------------------
    -- TABS
    -------------------------------------------------------

    o.buttonsID = {
        TAB1,
        TAB2,
        TAB3,
        TAB4,
        TAB5,
        TAB6,
        TAB7
    }


    o.im.Subscribe(BND_TAB1, function() end)
    o.im.Subscribe(BND_TAB2, function() end)
    o.im.Subscribe(BND_TAB3, function() end)
    o.im.Subscribe(BND_TAB4, function() end)
    o.im.Subscribe(BND_TAB5, function() end)
    o.im.Subscribe(BND_TAB6, function() end)
    o.im.Subscribe(BND_TAB7, function() end)


    -------------------------------------------------------
    -- KIT ACTIONS
    -------------------------------------------------------

    o.im.RegisterAction(actHomeKitPrevious, function()
        o:changePreviousHomeKit()
    end)


    o.im.RegisterAction(actHomeKitNext, function()
        o:changeNextHomeKit()
    end)


    o.im.RegisterAction(actAwayKitPrevious, function()
        o:changePreviousAwayKit()
    end)


    o.im.RegisterAction(actAwayKitNext, function()
        o:changeNextAwayKit()
    end)


    -------------------------------------------------------
    -- ADVANCE
    -------------------------------------------------------

    o.im.RegisterAction(actAdvance, function(actionName, data)

        if o.services.GameState.IsGamepadControllerConnected()
            and not o.services.SaveLoadService.GetControllerUsed() then

            o.services.SaveLoadService.SetControllerUsed(true)

            o.services.SaveLoadService.CreateAndSendMessage(8)


            local buttonOk = {

                label = "Confirm",

                clickEvents = {
                    "evt_hide_popup"
                },

                clickCallback = function()
                    o:_advance()
                end

            }


            local buttonNo = {

                label = "Cancel",

                clickEvents = {
                    "evt_hide_popup"
                }

            }


            local popupData = {

                title = "Controller Connection",

                message =
                    "The controller has been detected, do you want to use it as your operating mode? Press Cancel to change to Virtual Button",

                buttons = {
                    buttonNo,
                    buttonOk
                }

            }


            o.nav.Event(
                nil,
                "evt_show_popup",
                popupData
            )

        else

            o:_advance()

        end

    end)


    o.im.RegisterAction(actBack, function()
        o:_back()
    end)


    o.im.RegisterAction(actSettings, function()
        o.nav.Event(nil, "evt_to_settings")
    end)


    o.im.Subscribe(bndDif, function()
        o.im.Publish(
            bndDif,
            o.currentOptions.difficulty
        )
    end)


    -------------------------------------------------------
    -- TABS
    -------------------------------------------------------

    o:HideSelections()

    o.im.Publish(BND_TAB1, true)


    o.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)

        o:HideSelections()


        if o.buttonsID[data.buttonID + 1] == TAB1 then

            o.im.Publish(BND_TAB1, true)

        elseif o.buttonsID[data.buttonID + 1] == TAB2 then

            o.im.Publish(BND_TAB2, true)

        elseif o.buttonsID[data.buttonID + 1] == TAB3 then

            o.im.Publish(BND_TAB3, true)

        elseif o.buttonsID[data.buttonID + 1] == TAB4 then

            o.im.Publish(BND_TAB4, true)

        elseif o.buttonsID[data.buttonID + 1] == TAB5 then

            o.im.Publish(BND_TAB5, true)

        elseif o.buttonsID[data.buttonID + 1] == TAB6 then

            o.im.Publish(BND_TAB6, true)

        elseif o.buttonsID[data.buttonID + 1] == TAB7 then

            o.im.Publish(BND_TAB7, true)

        end

    end)


    return o

end


-------------------------------------------------------
-- CONVERT KIT TYPE TO ARRAY INDEX
-------------------------------------------------------

function KitSelect:getKitDataIndex(kitType)

    if kitType == 0 then
        return 1

    elseif kitType == 1 then
        return 2

    elseif kitType == 3 then
        return 3

    end

    return 1

end


-------------------------------------------------------
-- HIDE TABS
-------------------------------------------------------

function KitSelect:HideSelections()

    self.im.Publish(BND_TAB1, false)
    self.im.Publish(BND_TAB2, false)
    self.im.Publish(BND_TAB3, false)
    self.im.Publish(BND_TAB4, false)
    self.im.Publish(BND_TAB5, false)
    self.im.Publish(BND_TAB6, false)
    self.im.Publish(BND_TAB7, false)

end


-------------------------------------------------------
-- HOME KIT MESSAGE
-------------------------------------------------------

function KitSelect:publishHomeKitMessage()

    local currentHomeKitIndex =
        currentMatch.HomeKitIndex

    local toggleHomeMessage = ""


    if currentHomeKitIndex == 0 then

        toggleHomeMessage = "HOME"

    elseif currentHomeKitIndex == 1 then

        toggleHomeMessage = "AWAY"

    elseif currentHomeKitIndex == 3 then

        toggleHomeMessage = "THIRD"

    end


    self.im.Publish(
        BND_TOGGLE_HOME_KIT_MESSAGE,
        toggleHomeMessage
    )

end


-------------------------------------------------------
-- AWAY KIT MESSAGE
-------------------------------------------------------

function KitSelect:publishAwayKitMessage()

    local currentAwayKitIndex =
        currentMatch.AwayKitIndex

    local toggleAwayMessage = ""


    if currentAwayKitIndex == 0 then

        toggleAwayMessage = "HOME"

    elseif currentAwayKitIndex == 1 then

        toggleAwayMessage = "AWAY"

    elseif currentAwayKitIndex == 3 then

        toggleAwayMessage = "THIRD"

    end


    self.im.Publish(
        BND_TOGGLE_AWAY_KIT_MESSAGE,
        toggleAwayMessage
    )

end


-------------------------------------------------------
-- HOME PREVIOUS
-------------------------------------------------------

function KitSelect:changePreviousHomeKit()

    local current =
        currentMatch.HomeKitIndex


    if current == 0 then

        currentMatch.HomeKitIndex = 3

    elseif current == 1 then

        currentMatch.HomeKitIndex = 0

    elseif current == 3 then

        currentMatch.HomeKitIndex = 1

    else

        currentMatch.HomeKitIndex = 0

    end


    self:updateHomeKitDisplay()

end


-------------------------------------------------------
-- HOME NEXT
-------------------------------------------------------

function KitSelect:changeNextHomeKit()

    local current =
        currentMatch.HomeKitIndex


    if current == 0 then

        currentMatch.HomeKitIndex = 1

    elseif current == 1 then

        currentMatch.HomeKitIndex = 3

    elseif current == 3 then

        currentMatch.HomeKitIndex = 0

    else

        currentMatch.HomeKitIndex = 0

    end


    self:updateHomeKitDisplay()

end


-------------------------------------------------------
-- AWAY PREVIOUS
-------------------------------------------------------

function KitSelect:changePreviousAwayKit()

    local current =
        currentMatch.AwayKitIndex


    if current == 0 then

        currentMatch.AwayKitIndex = 3

    elseif current == 1 then

        currentMatch.AwayKitIndex = 0

    elseif current == 3 then

        currentMatch.AwayKitIndex = 1

    else

        currentMatch.AwayKitIndex = 0

    end


    self:updateAwayKitDisplay()

end


-------------------------------------------------------
-- AWAY NEXT
-------------------------------------------------------

function KitSelect:changeNextAwayKit()

    local current =
        currentMatch.AwayKitIndex


    if current == 0 then

        currentMatch.AwayKitIndex = 1

    elseif current == 1 then

        currentMatch.AwayKitIndex = 3

    elseif current == 3 then

        currentMatch.AwayKitIndex = 0

    else

        currentMatch.AwayKitIndex = 0

    end


    self:updateAwayKitDisplay()

end


-------------------------------------------------------
-- UPDATE HOME DISPLAY
-------------------------------------------------------

function KitSelect:updateHomeKitDisplay()

    local index =
        self:getKitDataIndex(
            currentMatch.HomeKitIndex
        )


    local kitData =
        self.homeTeamData[index]


    local nextKit =
        self.homeTeamData[(index % 3) + 1]


    local nextNextKit =
        self.homeTeamData[((index + 1) % 3) + 1]


    self:publish2DHomeKit(kitData)

    self:publish3DHomeKit(kitData)

    self:publish2DHomeKit2(nextKit)

    self:publish2DHomeKit3(nextNextKit)

    self:publishHomeKitMessage()

end


-------------------------------------------------------
-- UPDATE AWAY DISPLAY
-------------------------------------------------------

function KitSelect:updateAwayKitDisplay()

    local index =
        self:getKitDataIndex(
            currentMatch.AwayKitIndex
        )


    local kitData =
        self.awayTeamData[index]


    local nextKit =
        self.awayTeamData[(index % 3) + 1]


    local nextNextKit =
        self.awayTeamData[((index + 1) % 3) + 1]


    self:publish2DAwayKit(kitData)

    self:publish3DAwayKit(kitData)

    self:publish2DAwayKit2(nextKit)

    self:publish2DAwayKit3(nextNextKit)

    self:publishAwayKitMessage()

end


-------------------------------------------------------
-- 2D HOME KIT
-------------------------------------------------------

function KitSelect:publish2DHomeKit(kitData)

    local kitId =
        string.format(
            "%s_%s_%s",
            kitData.KITTYPE,
            kitData.TEAMID,
            kitData.YEAR
        )


    self.im.Publish(
        bnd2DHomeKit,
        {
            name = "$Kits",
            id = kitId
        }
    )

end


-------------------------------------------------------
-- 3D HOME KIT
-------------------------------------------------------

function KitSelect:publish3DHomeKit(kitData)

    local kitId =
        string.format(
            "%s_%s_%s",
            kitData.KITTYPE,
            kitData.TEAMID,
            kitData.YEAR
        )


    self.im.Publish(
        bnd3DHomeKit,
        {
            name = "$PlayerKits",
            id = kitId
        }
    )

end


-------------------------------------------------------
-- 2D AWAY KIT
-------------------------------------------------------

function KitSelect:publish2DAwayKit(kitData)

    local kitId =
        string.format(
            "%s_%s_%s",
            kitData.KITTYPE,
            kitData.TEAMID,
            kitData.YEAR
        )


    self.im.Publish(
        bnd2DAwayKit,
        {
            name = "$Kits",
            id = kitId
        }
    )

end


-------------------------------------------------------
-- 3D AWAY KIT
-------------------------------------------------------

function KitSelect:publish3DAwayKit(kitData)

    local kitId =
        string.format(
            "%s_%s_%s",
            kitData.KITTYPE,
            kitData.TEAMID,
            kitData.YEAR
        )


    self.im.Publish(
        bnd3DAwayKit,
        {
            name = "$PlayerKits",
            id = kitId
        }
    )

end


-------------------------------------------------------
-- HOME KIT 2
-------------------------------------------------------

function KitSelect:publish2DHomeKit2(kitData)

    local kitId =
        string.format(
            "%s_%s_%s",
            kitData.KITTYPE,
            kitData.TEAMID,
            kitData.YEAR
        )


    self.im.Publish(
        bnd2DHomeKit2,
        {
            name = "$Kits",
            id = kitId
        }
    )

end


-------------------------------------------------------
-- AWAY KIT 2
-------------------------------------------------------

function KitSelect:publish2DAwayKit2(kitData)

    local kitId =
        string.format(
            "%s_%s_%s",
            kitData.KITTYPE,
            kitData.TEAMID,
            kitData.YEAR
        )


    self.im.Publish(
        bnd2DAwayKit2,
        {
            name = "$Kits",
            id = kitId
        }
    )

end


-------------------------------------------------------
-- HOME KIT 3
-------------------------------------------------------

function KitSelect:publish2DHomeKit3(kitData)

    local kitId =
        string.format(
            "%s_%s_%s",
            kitData.KITTYPE,
            kitData.TEAMID,
            kitData.YEAR
        )


    self.im.Publish(
        bnd2DHomeKit3,
        {
            name = "$Kits",
            id = kitId
        }
    )

end


-------------------------------------------------------
-- AWAY KIT 3
-------------------------------------------------------

function KitSelect:publish2DAwayKit3(kitData)

    local kitId =
        string.format(
            "%s_%s_%s",
            kitData.KITTYPE,
            kitData.TEAMID,
            kitData.YEAR
        )


    self.im.Publish(
        bnd2DAwayKit3,
        {
            name = "$Kits",
            id = kitId
        }
    )

end


-------------------------------------------------------
-- ALPHA
-------------------------------------------------------

function KitSelect:publishHomeKitAlpha()

    self.im.Publish(
        bndHomeKitAlpha,
        self.userSide == self.USER_SIDE.HOME
            and self.userKitSelectorAlpha
            or self.opponentKitSelectorAlpha
    )

end


function KitSelect:publishAwayKitAlpha()

    self.im.Publish(
        bndAwayKitAlpha,
        self.userSide == self.USER_SIDE.AWAY
            and self.userKitSelectorAlpha
            or self.opponentKitSelectorAlpha
    )

end


-------------------------------------------------------
-- ADVANCE
-------------------------------------------------------

function KitSelect:_doAdvance()

    self.nav.Event(
        nil,
        "evt_advance"
    )

end


function KitSelect:_advance()

    self.im.ChangeActionState(
        actAdvance,
        self.im.GetActionState("INVALID")
    )


    self.im.ChangeActionState(
        actBack,
        self.im.GetActionState("INVALID")
    )


    self:_doAdvance()

end


-------------------------------------------------------
-- BACK
-------------------------------------------------------

function KitSelect:_back()

    self.nav.Event(
        nil,
        "evt_back"
    )

end


-------------------------------------------------------
-- CHECK ADVANCE
-------------------------------------------------------

function KitSelect:checkAdvance()

    if self.services.GameState.GetControllerSide(0) == 0 then

        if not self.services.GameState.IsGamepadControllerConnected()
            and not self.data.skipFE then

            return false

        else

            return true

        end

    end

    return true

end


-------------------------------------------------------
-- FINALIZE
-------------------------------------------------------

function KitSelect:finalize()

    self.im.Unsubscribe(BND_COLOR_CUPID)
    self.im.Unsubscribe(BND_BG_CUP)
    self.im.Unsubscribe("bnd_tour_logo")

    self.im.Unsubscribe(bndHomeTeamData)
    self.im.Unsubscribe(bndAwayTeamData)

    self.im.Unsubscribe(bndAwayReadyLabelVisible)
    self.im.Unsubscribe(bndAwayToggleVisible)
    self.im.Unsubscribe(bndAwaySelectingKitMsgVisible)

    self.im.Unsubscribe(bndHomeReadyLabelVisible)
    self.im.Unsubscribe(bndHomeToggleVisible)
    self.im.Unsubscribe(bndHomeSelectingKitMsgVisible)

    self.im.Unsubscribe(bndLatency)
    self.im.Unsubscribe(bndLatencyVisible)

    self.im.Unsubscribe(bndAwayKitSelectorVisible)
    self.im.Unsubscribe(bndNoOpponentQuestionMarkVisible)
    self.im.Unsubscribe(bndAwayMatchmakingMessageVisible)
    self.im.Unsubscribe(bndAwayTeamSelector)
    self.im.Unsubscribe(bndAwayLoadingVisible)

    self.im.Unsubscribe(bnd3DPlayersVisible)
    self.im.Unsubscribe(bnd2DKitsVisible)

    self.im.Unsubscribe(bnd2DHomeKit)
    self.im.Unsubscribe(bnd3DHomeKit)

    self.im.Unsubscribe(bnd2DAwayKit)
    self.im.Unsubscribe(bnd3DAwayKit)

    self.im.Unsubscribe(bnd2DHomeKit2)
    self.im.Unsubscribe(bnd2DAwayKit2)

    self.im.Unsubscribe(bnd2DHomeKit3)
    self.im.Unsubscribe(bnd2DAwayKit3)

    self.im.Unsubscribe(bndHomeKitAlpha)
    self.im.Unsubscribe(bndAwayKitAlpha)

    self.im.Unsubscribe(bndBackBtnText)

    self.im.UnregisterAction(actAdvance)
    self.im.UnregisterAction(actBack)
    self.im.UnregisterAction(actSettings)

    self.im.Unsubscribe(bndDif)

    self.im.UnregisterAction(actHomeKitPrevious)
    self.im.UnregisterAction(actHomeKitNext)

    self.im.UnregisterAction(actAwayKitPrevious)
    self.im.UnregisterAction(actAwayKitNext)

    self.im.UnregisterAction(ACT_BTN_CLICK)

    self.im.UnregisterDataAction(
        BND_HOME_KITS_INDEX,
        ACT_HOME_CHANGE
    )

    self.im.UnregisterDataAction(
        BND_AWAY_KITS_INDEX,
        ACT_AWAY_CHANGE
    )

    self.im.Unsubscribe(BND_HOME_KITS)
    self.im.Unsubscribe(BND_AWAY_KITS)

    self.im.Unsubscribe(BND_TAB1)
    self.im.Unsubscribe(BND_TAB2)
    self.im.Unsubscribe(BND_TAB3)
    self.im.Unsubscribe(BND_TAB4)
    self.im.Unsubscribe(BND_TAB5)
    self.im.Unsubscribe(BND_TAB6)
    self.im.Unsubscribe(BND_TAB7)

end


return KitSelect