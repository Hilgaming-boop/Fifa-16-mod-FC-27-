local PlayerNIB = {}
local OverlayParam, EventManager, TableUtil = ...
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local STATE_INACTIVE = "HIDE"
local STATE_UPDATE = "UPDATE"
local STATE_ACTIVE = "SHOW"
local SIDE_HOME = 0
local SIDE_AWAY = 1
local BND_ALPHA = "bnd_alpha"
local BND_STAMINA = "bnd_stamina"
local BND_PLAYER_INFO = "bnd_player_info"
local BND_ACTIVE = "bnd_active"
local bndHomeCrest = "bnd_home_team_crest"
local bndAwayCrest = "bnd_away_team_crest"
local bndRainVisible = "bnd_rain_visible"
local bndSnowVisible = "bnd_snow_visible"
local bndWeather = "bnd_weather_type"
local bndNibsOnSideVisible = "bnd_nibs_on_side_visible"
local bndNibsOnCenterVisible = "bnd_nibs_on_center_visible"
local bndNibsOnSingleVisible = "bnd_nibs_on_single_visible"
local bndNibsOffVisible = "bnd_nibs_off_visible"
local ACT_CAMERA_CHANGE = "act_camera_change"
local bndPlayerHead = "bnd_player_head"
local BND_STAMINA_INNER_COLOR = "bnd_stamina_inner_color"
local ACT_NIB_MODE_NEXT = "act_nib_mode_next"
local ACT_NIB_MODE_PREV = "act_nib_mode_prev"
local HomeNIB = nil
local AwayNIB = nil

EAFCSingle = {
  bnd_stamina_inner_bg = "0x00b2c3", bnd_stamina_outside_bg = "0x555555", bnd_stamina_width = 300, bnd_stamina_short_width = 0, bnd_stamina_bottom = 52,
  bnd_player_number = "", bnd_player_name = "", bnd_player_info_left = -223, bnd_player_number_color = "0xfffff", bnd_player_name_color = "0xffffff",
  bnd_home_team_crest = { name = "$", id = 0 }, bnd_away_team_crest = { name = "$", id = 0 }, bnd_player_head = { name = "$Head", id = 0 }
}

EAFC = {
    bnd_forceCaps = true, bnd_fontFace = "$Epl", bnd_crest_bg = "0x39003E", bnd_crestBg_width = 0, bnd_crestBg_height = 0, bnd_crestBg_bottom = 24,
    bnd_crest_width = 35, bnd_crest_height = 35, bnd_crest_bottom = 23, bnd_bg = "0xFFFFFF", bnd_bg_bottom = -500, bnd_stamina_inner_bg = "0xFF48B0C5",
    bnd_stamina_outside_bg = "0x000000", bnd_stamina_width = 200, bnd_stamina_short_width = 0, bnd_stamina_bottom = 52, bnd_player_number = "",
    bnd_player_name = "", bnd_player_info_left = -223, bnd_player_number_color = "0xffffff", bnd_player_name_color = "0xffffff",
    bnd_home_team_crest = { name = "$Crest64x64", id = 0 }, bnd_away_team_crest = { name = "$Crest64x64", id = 0 }, bnd_player_head = { name = "$Head1", id = 0 }
}

function PlayerNIB:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    o.services = {
        GameStateService = o.api("GameStateService"),
        matchInfo = o.api("MatchInfoService"),
        userPlate = o.api("UserPlateService"),
        settingsService = o.api("SettingsService"),
        gameSetupService = o.api("GameSetupService"),
        EventManagerService = o.api("EventManagerService"),
        TeamService = o.api("TeamService"),
        SquadManagementService = o.api("SquadMgtService")
    }

    o.side = o.data and o.data.side or SIDE_HOME
    o.cameraIndex = cameraIndex
    o.currentLeague = EAFC

    if o.side == SIDE_HOME then
        HomeNIB = o
    else
        AwayNIB = o
    end

    o.cameraIndex = cameraIndex
    o.currentLeague = EAFC
    o.TeamsData = o.services.matchInfo.GetMatchTeams()

    o.homeJerseyMap = {}
    o.awayJerseyMap = {}
    o.homePositionMap = {}
    o.awayPositionMap = {}
    o.playStyleCache = {}    

    local success, err = pcall(function()
        if o.services.SquadManagementService and o.TeamsData and o.TeamsData[1] and o.TeamsData[2] then
            local homeLineup = o.services.SquadManagementService.GetCurrentPlayerLineup(SIDE_HOME, o.TeamsData[1].assetId, 0)
            local awayLineup = o.services.SquadManagementService.GetCurrentPlayerLineup(SIDE_AWAY, o.TeamsData[2].assetId, 0)

            if homeLineup then
                for _, player in ipairs(homeLineup) do
                    o.homeJerseyMap[player.jerseyNumber] = player.CARD_ID
                    o.homePositionMap[player.jerseyNumber] = player.position
                end
            end

            if awayLineup then
                for _, player in ipairs(awayLineup) do
                    o.awayJerseyMap[player.jerseyNumber] = player.CARD_ID
                    o.awayPositionMap[player.jerseyNumber] = player.position
                end
            end
        end
    end)
    if not success then print("[PlayerNIB] ERROR creating jersey/position map: " .. tostring(err)) end

    o.currentLeague.bnd_home_team_crest.id = o.TeamsData[1].assetId    
    o.currentLeague.bnd_away_team_crest.id = o.TeamsData[2].assetId
    
    o.im.Subscribe(BND_ACTIVE, function() o:_publishActivity() end)    
    o.im.Subscribe(BND_ALPHA, function() o:_publishAlpha() end)
    o.im.Subscribe(BND_PLAYER_INFO, function() o:_publishPlayerInfo() end)
    o.im.Subscribe(BND_STAMINA, function() o:_publishStamina() end)    
    o.im.Subscribe(bndPlayerHead, function() o:_publishPlayerInfo() end)
    
    -- Subscribe kedua binding playstyle
    o.im.Subscribe("bnd_play_style", function() o:_publishPlayerInfo() end)
    o.im.Subscribe("bnd_play_style_away", function() o:_publishPlayerInfo() end)

    o.im.RegisterAction(ACT_CAMERA_CHANGE, function()
        o:_updateCamera()
    end)    
    o.im.Subscribe(BND_STAMINA_INNER_COLOR, function()
        o:_publishStamina()
    end)    
    o.im.RegisterAction(ACT_NIB_MODE_NEXT, function()

        playernibOption = playernibOption or 0

        if playernibOption == 0 then
            playernibOption = 1      -- Side -> Center
        elseif playernibOption == 1 then
            playernibOption = 2      -- Center -> Single
        elseif playernibOption == 2 then
            playernibOption = 3      -- Single -> Hide
        else
            playernibOption = 0      -- Hide -> Side
        end

        currentPlayernibOption = playernibOption

        if HomeNIB then
            HomeNIB:updateNibMode(playernibOption)
        end

        if AwayNIB then
            AwayNIB:updateNibMode(playernibOption)
        end

    end)
    
    playernibOption = 0
    currentPlayernibOption = 0

    o:updateNibMode(0)
    o.im.Subscribe(bndNibsOnSideVisible, function() o.im.Publish(bndNibsOnSideVisible, playernibOption == 0) end)
    o.im.Subscribe(bndNibsOnCenterVisible, function() o.im.Publish(bndNibsOnCenterVisible, playernibOption == 1) end)
    o.im.Subscribe(bndNibsOnSingleVisible, function() if playernibOption == 2 then o.currentLeague = EAFCSingle end; o.im.Publish(bndNibsOnSingleVisible, playernibOption == 2) end)
    o.im.Subscribe(bndNibsOffVisible, function() o.im.Publish(bndNibsOffVisible, playernibOption == 3) end)    

    for k,v in pairs(o.currentLeague) do
        o.im.Subscribe(k, function()
            if k == "bnd_stamina_width" or k == "bnd_stamina_short_width" then o:_publishStamina()
            -- Pastikan bnd_play_style_away masuk dalam kondisi ini
            elseif k == "bnd_player_number" or k == "bnd_player_name" or k == "bnd_player_head" or k == "bnd_play_style" or k == "bnd_play_style_away" then
                o:_publishPlayerInfo()
            else o.im.Publish(k, v) end
        end)
    end

    weatherType = {
       name = "$Weather",
       id = 0
    }
    random = currentMatchWeather
    if currentMatchWeather == 1 then
      random = math.random(2, 8)
    end

    o.im.Subscribe(bndRainVisible, function()
      if random == 6 then
        o.im.Publish(bndRainVisible, true)
      else 
        o.im.Publish(bndRainVisible, false)
      end
    end
    )
    o.im.Subscribe(bndSnowVisible, function()
      if random == 8 then
        o.im.Publish(bndSnowVisible, true)
      else 
        o.im.Publish(bndSnowVisible, false)
      end
    end
    )
    o.im.Subscribe(bndWeather, function()
      if random == 3 then
         weatherType.id = 1
      elseif random == 4 then
         weatherType.id = 2
      elseif random == 5 or random == 6 then
         weatherType.id = 4
      elseif random == 7 or random == 8 then
         weatherType.id = 3
      else
         weatherType.id = 0
      end
      o.im.Publish(bndWeather, weatherType)
    end
    )
    
    o.statsPL= {
      name = "$Stats_Playernib",
      id = 0
    }
    math.randomseed(os.clock() * 132 + os.time())
    local currentTime = os.date("%H") + 0
    local random2 = math.random(3)
    
    o.im.Subscribe("bnd_statsPL", function()
      o.statsPL.id = random2
      o.im.Publish("bnd_statsPL", o.statsPL)
    end)
    
    o.isUserHome = o.services.gameSetupService.IsHostTeam()
    
    o:setState(STATE_INACTIVE)
    o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
      o:_handleEvent(...)
    end
    )

    return o
end

function PlayerNIB:updateNibMode(mode)
    playernibOption = mode

    if playernibOption == 2 then
        self.currentLeague = EAFCSingle
    else
        self.currentLeague = EAFC
    end

    self.im.Publish(bndNibsOnSideVisible, playernibOption == 0)
    self.im.Publish(bndNibsOnCenterVisible, playernibOption == 1)
    self.im.Publish(bndNibsOnSingleVisible, playernibOption == 2)
    self.im.Publish(bndNibsOffVisible, playernibOption == 3)

    self:_publishPlayerInfo()
    self:_publishStamina()
end

function PlayerNIB:setState(state)
    self.state = state or STATE_INACTIVE
    self:_publishActivity()
end

function PlayerNIB:getPlayerPositionByJerseyNumber(jerseyNumber)
    if self.side == SIDE_HOME then
        return self.homePositionMap[jerseyNumber] or "ST"
    else
        return self.awayPositionMap[jerseyNumber] or "GK"
    end
end

local specialPlayStyleByName = {
    ["Chicarito"] = 1,
}

local specialPlayStyleById = {
    [231747] = 1,  -- Mbappe
    [255253] = 1, -- Vitinha
    [277643] = 1, -- Lamine
    [233419] = 1, -- Jafinha
}

local playStyleRanges = {
    GK = {
        {min=70, ids={0}}
    },
    DEF = {
        {min=90, ids={4,8}},
        {min=85, ids={4,7,8}},
        {min=80, ids={4,7}},
        {min=70, ids={0}}
    },
    CDM_CM = {
        {min=90, ids={3,4,7}},
        {min=85, ids={3,7}},
        {min=80, ids={4,7}},
        {min=70, ids={0}}
    },
    CAM_AM = {
        {min=90, ids={3,5,6}},
        {min=85, ids={3,5}},
        {min=80, ids={5,6}},
        {min=70, ids={0}}
    },
    WIDE = {
        {min=90, ids={2,5,6}},
        {min=85, ids={2,5}},
        {min=80, ids={2,6}},
        {min=70, ids={0}}
    },
    ST = {
        {min=90, ids={1,2,5,6}},
        {min=85, ids={1,2,6}},
        {min=80, ids={2,5,6}},
        {min=70, ids={5}}
    }
}

local positionGroupMap = {
    GK = "GK",
    SW = "DEF", RCB = "DEF", CB = "DEF", LCB = "DEF",
    RB = "DEF", LB = "DEF", RWB = "DEF", LWB = "DEF",
    CDM = "CDM_CM", LDM = "CDM_CM", RDM = "CDM_CM",
    CM  = "CDM_CM", LCM = "CDM_CM", RCM = "CDM_CM",
    CAM = "CAM_AM", RAM = "CAM_AM", LAM = "CAM_AM",
    RM  = "WIDE", LM  = "WIDE",
    RF  = "WIDE", LF  = "WIDE", RW = "WIDE", LW = "WIDE",
    RS  = "ST", LS  = "ST", CF = "ST", ST = "ST"
}

function PlayerNIB:getPlayStyleIdByPositionAndOVR(jerseyNumber)
    local position = self:getPlayerPositionByJerseyNumber(jerseyNumber)
    local group = positionGroupMap[position] or "ST"

    local playerId = 0
    local playerName = ""
    local ovr = 0

    local lineup = self.side == SIDE_HOME and
        self.services.SquadManagementService.GetCurrentPlayerLineup(
            SIDE_HOME,
            self.TeamsData[1].assetId,
            0
        ) or
        self.services.SquadManagementService.GetCurrentPlayerLineup(
            SIDE_AWAY,
            self.TeamsData[2].assetId,
            0
        )

    if lineup then
        for _, player in ipairs(lineup) do
            if player.jerseyNumber == jerseyNumber then
                playerId = player.databaseId or player.playerid or player.id or player.playerId or player.CARD_ID or player.assetId or 0
                playerName = player.name or player.displayName or player.fullName or ""
                ovr = player.ovr or player.rating or 0
                break
            end
        end
    end

    self.playStyleCache = self.playStyleCache or {}

    if self.playStyleCache[playerId] then
        return self.playStyleCache[playerId]
    end

    if specialPlayStyleById[playerId] then
        self.playStyleCache[playerId] = specialPlayStyleById[playerId]
        return specialPlayStyleById[playerId]
    end

    if specialPlayStyleByName[playerName] then
        self.playStyleCache[playerId] = specialPlayStyleByName[playerName]
        return specialPlayStyleByName[playerName]
    end

    local ranges = playStyleRanges[group] or playStyleRanges.ST

    for _, range in ipairs(ranges) do
        if ovr >= range.min then
            local styleId = 0
            if range.ids and #range.ids > 0 then
                styleId = range.ids[math.random(1, #range.ids)]
            else
                styleId = range.id or 0
            end

            self.playStyleCache[playerId] = styleId
            return styleId
        end
    end

    self.playStyleCache[playerId] = 0
    return 0
end

function PlayerNIB:getPlayerCardIdByJerseyNumber(jerseyNumber)
    if self.side == SIDE_HOME then
        return self.homeJerseyMap[jerseyNumber] or 0
    else
        return self.awayJerseyMap[jerseyNumber] or 0
    end
end

function PlayerNIB:extractInfoFromParams(params)
    return { name = params[9], number = tonumber(params[12]) }
end

function PlayerNIB:getStamina(params)
    return { stamina = tonumber(params[1]), shortStamina = tonumber(params[2]) }
end

function PlayerNIB:_onPlayerNIBUpdate(subtype, hideshow, subtypestr, msg)
    self:setState(hideshow)
    if self.state ~= STATE_INACTIVE and msg ~= nil and msg ~= "" then
        local params = OverlayParam.split(msg, "|")

        if #params == 8 or #params == 10 then
            self.stamina = self:getStamina(params)
            self:_publishStamina()
        elseif #params >= 16 then
            self.playerInfo = self:extractInfoFromParams(params)
            self.stamina = self:getStamina(params)
            self:_publishPlayerInfo()
            self:_publishStamina()
        end
    end
end

function PlayerNIB:_publishActivity()
    self.im.Publish(BND_ACTIVE, self.state ~= STATE_INACTIVE)
end

function PlayerNIB:_publishAlpha(alpha)
    self.im.Publish(BND_ALPHA, alpha or 1)
end

function PlayerNIB:_publishPlayerInfo()
    if not self.playerInfo or not self.playerInfo.number then return end

    local cardId = self:getPlayerCardIdByJerseyNumber(self.playerInfo.number)
    local headshotData = self.currentLeague.bnd_player_head
    headshotData.id = cardId

    local playStyleId = self:getPlayStyleIdByPositionAndOVR(self.playerInfo.number)

    self.im.Publish(BND_PLAYER_INFO, self.playerInfo)
    self.im.Publish("bnd_player_number", tostring(self.playerInfo.number))
    self.im.Publish("bnd_player_name", self.playerInfo.name)
    self.im.Publish(bndPlayerHead, headshotData)

    -- Logika Pemisah Side sesuai variabel (0 dan 1)
    if self.side == SIDE_HOME then
        local playStyleData = { name = "$PlayStyles", id = playStyleId }
        self.im.Publish("bnd_play_style", playStyleData)
    elseif self.side == SIDE_AWAY then
        local playStyleData = { name = "$PlayStylesAway", id = playStyleId }
        self.im.Publish("bnd_play_style_away", playStyleData)
    end
end

function PlayerNIB:_publishStamina()
    if self.stamina == nil then
        return
    end

    self.im.Publish(BND_STAMINA, self.stamina)

    local maxWidth = self.currentLeague.bnd_stamina_width
    self.im.Publish("bnd_stamina_width", maxWidth)

    local ratio = 1
    if self.stamina.stamina > 0 then
        ratio = self.stamina.shortStamina / self.stamina.stamina
    end

    local currentWidth = maxWidth * ratio
    self.im.Publish("bnd_stamina_short_width", currentWidth)

    local staminaColor
    if ratio >= 0.70 then
        staminaColor = "0xFF2A2A" -- merah
    elseif ratio >= 0.35 then
        staminaColor = "0xFFD800" -- orange
    else
        staminaColor = "0x00b2c3" -- default
    end

    self.im.Publish(BND_STAMINA_INNER_COLOR, staminaColor)
end

function PlayerNIB:_handleEvent(eventType, data)
    if (eventType == EVENT_TYPES.OverlayTypeNIBBL and self.side == SIDE_HOME) or (eventType == EVENT_TYPES.OverlayTypeNIBBR and self.side == SIDE_AWAY) then
        self:_onPlayerNIBUpdate(data.subtype, data.hideshow, data.subtypestr, data.msg)
    end
end

function PlayerNIB:_updateCamera()
    if self.cameraIndex >= 7 then self.cameraIndex = 0 else self.cameraIndex = self.cameraIndex + 1 end
    self.services.settingsService.SaveCameraValue(self.cameraIndex)
end

function PlayerNIB:finalize()
    self.im.Unsubscribe(BND_ACTIVE); self.im.Unsubscribe(BND_ALPHA); self.im.Unsubscribe(BND_PLAYER_INFO); self.im.Unsubscribe(BND_STAMINA)
    self.im.Unsubscribe(bndPlayerHead); self.im.Unsubscribe(bndHomeCrest); self.im.Unsubscribe(bndAwayCrest); self.im.Unsubscribe(bndRainVisible)
    self.im.Unsubscribe(bndSnowVisible); self.im.Unsubscribe(bndWeather); self.im.Unsubscribe(bndNibsOnSideVisible); self.im.Unsubscribe(bndNibsOnCenterVisible)
    self.im.Unsubscribe(bndNibsOnSingleVisible); self.im.Unsubscribe(bndNibsOffVisible)
    self.im.Unsubscribe("bnd_play_style")
    self.im.Unsubscribe("bnd_play_style_away")
    for k,v in pairs(EAFC) do self.im.Unsubscribe(k) end
    self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return PlayerNIB
