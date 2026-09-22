-----------------------------------------------
-- Team VIEW - MOUNTSA Version
-----------------------------------------------

local TeamManagementModelAway = {}
local ItemModel, TableUtil, FormationModel = ...

local MAX_STARTING = 11

-- Bindings
local PLAYER_BINDINGS = {
    HEADS = {},
    NAMES = {},
    POSITIONS = {},
    RATINGS = {},
    MARGIN_LEFT = {},
    MARGIN_BOTTOM = {},
    ITEM_PLAYERS = {}
}

for i = 1, MAX_STARTING do
    PLAYER_BINDINGS.HEADS[i]        = "bnd_away_player_"..i.."_head"
    PLAYER_BINDINGS.NAMES[i]        = "bnd_away_player_"..i.."_name"
    PLAYER_BINDINGS.POSITIONS[i]    = "bnd_away_player_"..i.."_pos"
    PLAYER_BINDINGS.RATINGS[i]      = "bnd_away_player_"..i.."_rating"
    PLAYER_BINDINGS.MARGIN_LEFT[i]  = "bnd_away_player_"..i.."_left"
    PLAYER_BINDINGS.MARGIN_BOTTOM[i]   = "bnd_away_player_"..i.."_bottom"
    PLAYER_BINDINGS.ITEM_PLAYER = "bnd_away_player_item"
end

local TEAM_BINDINGS = {
    NAME = "bnd_away_team_name",
    CREST = "bnd_away_team_crest",
    FORMATION_NAME = "bnd_away_formation_name"
}

-- New
function TeamManagementModelAway:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    o.services = {
        FUTSquadManagementService = o.api("FUTSquadManagementService"),
        SquadManagementService    = o.api("SquadMgtService"),
        TacticsService            = o.api("TacticsService"),
        GameSetupService          = o.api("GameSetupService")
    }
o.teamID     = o.services.GameSetupService.GetTeamId(false)
    o.models = {
        ItemModel      = ItemModel:new {im=o.im, api=o.api, nav=o.nav, loc=o.loc},
        FormationModel = FormationModel:new {
            im=o.im, api=o.api, nav=o.nav, loc=o.loc,
            teamID=o.teamID, gamemode=o.gamemode
        }
    }
	o:loadInitialData()
    o:setupSubscriptions()

    return o
end

-- Initial load
function TeamManagementModelAway:loadInitialData()
    self.formationList = self.models.FormationModel:getFormationList()
    self.players       = self:getPlayers(self.teamID)
    self:publishFormationPositions(self.teamID, 0)
end

-- Subscriptions
function TeamManagementModelAway:setupSubscriptions()
    for key, fn in pairs({
        [TEAM_BINDINGS.NAME] = function() self:publishTeamName() end,
        [TEAM_BINDINGS.CREST] = function() self:publishTeamCrest() end,
        [TEAM_BINDINGS.FORMATION_NAME] = function()
            local f = self:getCurrentFormation()
            self.im.Publish(TEAM_BINDINGS.FORMATION_NAME, f and f.name or "")
        end
    }) do
        self.im.Subscribe(key, fn)
    end

    for i = 1, MAX_STARTING do
        self.im.Subscribe(PLAYER_BINDINGS.HEADS[i],        function() self:publishPlayerAvatar(i) end)
        self.im.Subscribe(PLAYER_BINDINGS.NAMES[i],        function() self:publishPlayerName(i) end)
        self.im.Subscribe(PLAYER_BINDINGS.POSITIONS[i],    function() self:publishPlayerPosition(i) end)
        self.im.Subscribe(PLAYER_BINDINGS.RATINGS[i],      function() self:publishPlayerRating(i) end)
        self.im.Subscribe(PLAYER_BINDINGS.MARGIN_LEFT[i],  function() self:publishPlayerMarginLeft(i) end)
        self.im.Subscribe(PLAYER_BINDINGS.MARGIN_BOTTOM[i],  function() self:publishPlayerMarginBottom(i) end)
        self.im.Subscribe(PLAYER_BINDINGS.ITEM_PLAYER, 		function() self:publishItemPlayer() end)
    end
end

-- Publish Formation positions
function TeamManagementModelAway:publishFormationPositions(teamID, teamSide)
    -- In publishFormationPositions function:
local lineup      = self.services.SquadManagementService.GetCurrentPlayerLineup(1, teamID, 0)  -- Changed 0 to 1
local formationID = self.services.TacticsService.GetFormation(1, teamID)  -- Changed 0 to 1

    if self.gamemode == "fut" then
        formationID = self.services.SquadManagementService.GetFUTRelativeSquadFormation(formationID)
    end

    local formation = self.models.FormationModel:getFormationInfoByID(formationID)
    self.formationName = formation.name

    if not formation or not formation.positions then
        print("[ERROR] formation.positions missing")
        return
    end

    self.players = {}

    for i, player in ipairs(lineup) do
        local pos = formation.positions[i]
        if pos then
            local playerData = {
                playerName   = player.playerName or "Unknown",
                position     = player.position or "N/A",
                rating       = player.rating or 0,
                playerAvatar = player.CARD_ID or 0,
                marginleft   = pos.xPos or 0,
                margintop    = pos.yPos or 0
            }

            self.players[i] = playerData

            -- publish
            self.im.Publish(PLAYER_BINDINGS.HEADS[i],        { name="$Head", id=playerData.playerAvatar })
            self.im.Publish(PLAYER_BINDINGS.NAMES[i],        playerData.playerName)
            self.im.Publish(PLAYER_BINDINGS.POSITIONS[i],    playerData.position)
            self.im.Publish(PLAYER_BINDINGS.RATINGS[i],      playerData.rating)
            self.im.Publish(PLAYER_BINDINGS.MARGIN_LEFT[i],  playerData.marginleft)
            self.im.Publish(PLAYER_BINDINGS.MARGIN_BOTTOM[i],   playerData.margintop)
            self:publishItemPlayer()

            print(string.format(
                "Player %d: %s | rating=%d | pos=%s | x=%d y=%d",
                i,
                playerData.playerName,
                playerData.rating,
                playerData.position,
                playerData.marginleft,
                playerData.margintop
            ))
        else
            print(string.format("[WARN] No formation position for index %d", i))
        end
    end
end

-- Current Formation
function TeamManagementModelAway:getCurrentFormation()
    local formationID = self.services.TacticsService.GetFormation(1, self.teamID)

    if self.gamemode == "fut" then
        formationID = self.services.SquadManagementService.GetFUTRelativeSquadFormation(formationID)
    end
    return self.models.FormationModel:getFormationInfoByID(formationID)
end

-- Player Data
function TeamManagementModelAway:getPlayers(teamID)
    local rawPlayers = self.services.SquadManagementService.GetCurrentPlayerLineup(1, teamID, 0) or {}
    local players = {}
    for i, player in ipairs(rawPlayers) do
        players[i] = {
            playerName   = player.playerName or "Unknown",
            position     = player.position   or "N/A",
            rating       = player.rating     or 0,
            playerAvatar = player.CARD_ID    or 0,
            CARD_ID      = player.CARD_ID    or 0,
            marginleft   = 0,
            margintop    = 0
        }
        self:publishPlayerData(i, players[i])
    end
    return players
end
-- Publish Data
function TeamManagementModelAway:publishPlayerData(i, p)
    if not p then return end
    self.im.Publish(PLAYER_BINDINGS.HEADS[i],        { name="$Head", id=p.playerAvatar })
    self.im.Publish(PLAYER_BINDINGS.NAMES[i],        p.playerName)
    self.im.Publish(PLAYER_BINDINGS.POSITIONS[i],    p.position)
    self.im.Publish(PLAYER_BINDINGS.RATINGS[i],      p.rating)
    self.im.Publish(PLAYER_BINDINGS.MARGIN_LEFT[i],  p.marginleft)
    self.im.Publish(PLAYER_BINDINGS.MARGIN_BOTTOM[i],   p.margintop)
    self.im.Publish(PLAYER_BINDINGS.ITEM_PLAYERS[i], { name="$ItemPlayer"..i, id=p.playerAvatar })
end

function TeamManagementModelAway:publishPlayerAvatar(i)
    local p = self.players[i]
    if p then self.im.Publish(PLAYER_BINDINGS.HEADS[i], { name="$Head", id=p.playerAvatar }) end
end

function TeamManagementModelAway:publishPlayerName(i)
    local p = self.players[i]
    if p then self.im.Publish(PLAYER_BINDINGS.NAMES[i], p.playerName) end
end

function TeamManagementModelAway:publishPlayerPosition(i)
    local p = self.players[i]
    if p then self.im.Publish(PLAYER_BINDINGS.POSITIONS[i], p.position) end
end

function TeamManagementModelAway:publishPlayerRating(i)
    local p = self.players[i]
    if p then self.im.Publish(PLAYER_BINDINGS.RATINGS[i], p.rating) end
end

function TeamManagementModelAway:publishPlayerMarginLeft(i)
    local p = self.players[i]
    if p then self.im.Publish(PLAYER_BINDINGS.MARGIN_LEFT[i], p.marginleft or 0) end
end

function TeamManagementModelAway:publishPlayerMarginBottom(i)
    local p = self.players[i]
    if p then self.im.Publish(PLAYER_BINDINGS.MARGIN_BOTTOM[i], p.margintop or 0) end
end

function TeamManagementModelAway:publishItemPlayer()
    self.im.Publish(PLAYER_BINDINGS.ITEM_PLAYER, { name="$ItemPlayer0", id= 201000 })
end

-- Team
function TeamManagementModelAway:publishTeamName()
    self.im.Publish(TEAM_BINDINGS.NAME, self.loc.LocalizeString("TeamName_Abbr15_"..self.teamID))
end

function TeamManagementModelAway:publishTeamCrest()
    self.im.Publish(TEAM_BINDINGS.CREST, { name="$Crest64x64", id=self.teamID })
end

function TeamManagementModelAway:saveSquad()
  local playerIDs = {}
  for i = 1, #self.players do
    playerIDs[i] = self.players[i].CARD_ID
  end
  self.services.SquadManagementService.SetCurrentPlayerLineup(1, self.teamID, 0, 0, playerIDs)
self.services.TacticsService.SetFormation(1, self.teamID, self.models.FormationModel:getCurrentFormationID())
    
end

-- Finalize
function TeamManagementModelAway:finalize()
    self.models.ItemModel:finalize()
    self.models.FormationModel:finalize()
    for _, b in pairs(TEAM_BINDINGS) do self.im.Unsubscribe(b) end
    for i = 1, MAX_STARTING do
        for _, b in pairs(PLAYER_BINDINGS) do
            self.im.Unsubscribe(b[i])
        end
    end
end

return TeamManagementModelAway