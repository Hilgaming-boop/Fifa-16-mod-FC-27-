-- 1 vs 1 MounTsa --

local TeamSelect = {}
cupId = 1

local BND_TEAM_LIST_TOGGLE = "bnd_team_list_toggle"
local BND_TEAM_LIST_INDEX = "bnd_team_list_index"
local ACT_CONFIRM_TEAM = "act_confirm_team"
local ACT_RESET = "act_reset"
local BND_INFO_LABEL = "bnd_info_label"
local ACT_RANDOM = "act_random"

local BND_INTERACTIVE_PANEL_VISIBLE = "bnd_interactive_panel_visible"
local BND_SELECTED_TEAM_NAME = "bnd_selected_team_name"
local BND_TEAM_STAR_RATING = "bnd_team_star_rating"
local BND_TEAM_RATING = "bnd_team_rating"
local BND_TEAM_CREST = "bnd_team_crest"

local BND_HOME_TEAM_NAME = "bnd_home_team_name"
local BND_HOME_TEAM_CREST = "bnd_home_team_crest"
local BND_HOME_TEAM_STARS = "bnd_home_team_stars"

local BND_AWAY_TEAM_NAME = "bnd_away_team_name"
local BND_AWAY_TEAM_CREST = "bnd_away_team_crest"
local BND_AWAY_TEAM_STARS = "bnd_away_team_stars"

local BND_HOME_TEAM_STATS = "bnd_home_team_stats"
local BND_AWAY_TEAM_STATS = "bnd_away_team_stats"
local BND_COMPARISON_BARS = "bnd_comparison_bars"

local OriginalTeamList = {
    1, 2, 10, 69, 39, 240, 32, 189, 22, 900, 78, 231, 101078, 211, 241, 21,
    246, 110062, 44, 45, 9, 65, 47, 73, 247, 112172, 191, 243, 101059,
    209, 100810, 234, 267, 237, 378, 36
}
local TeamList = {}

QuickCupGrouping = QuickCupGrouping or {}; QuickCupGrouping[cupId] = {}
currentCupInfo = currentCupInfo or {}; currentCupInfo[cupId] = {}

local STATE_INIT = "STATE_INIT"
local STATE_AWAY_SELECT = "STATE_AWAY_SELECT"
local STATE_CONFIRMED = "STATE_CONFIRMED"

math.randomseed(os.time())

function TeamSelect:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.im = init.im; o.nav = init.nav; o.loc = init.loc; o.api = init.api
    o.services = { SquadManagementService = o.api("SquadMgtService") }
    
    o:ResetSelection()
    o:PrepareTeamData()
    o:RegisterBindingsAndActions()
    o:PublishAllData()
    o.cupData = {
        cupBg = { name = "$Bg_Cup", id = cupId },
        cuplogo = { name = "$LeagueCrest", id = 2236 }
    }
    return o
end

function TeamSelect:ResetSelection()
    self.selectionState = STATE_INIT
    self.homeTeam = nil
    self.awayTeam = nil
    self.selectedIndex = 1
end

function TeamSelect:PrepareTeamData()
    TeamList = {}
    for i, teamID in ipairs(OriginalTeamList) do
        local info = self.services.SquadManagementService.GetTeamInfo(teamID)
        if info then
            table.insert(TeamList, {
                id = teamID, 
                name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID),
                fullName = self.loc.LocalizeString("TeamName_Full_" .. teamID),
                starRating = info.starRating or 0,
                offense = info.offense or 0,
                midfield = info.midfield or 0,
                defense = info.defense or 0,
                overall = math.floor((info.offense + info.midfield + info.defense) / 3)
            })
        end
    end
    
    table.sort(TeamList, function(a, b) 
        return a.overall > b.overall 
    end)
end

function TeamSelect:RegisterBindingsAndActions()

    self.im.Subscribe("bnd_bg_cup", function() self.im.Publish("bnd_bg_cup", self.cupData.cupBg) end)
    self.im.Subscribe("bnd_cup_logo", function() self.im.Publish("bnd_cup_logo", self.cupData.cuplogo) end)
    
    self.im.Subscribe(BND_TEAM_LIST_TOGGLE, function() self:PublishTeamToggle() end)
    self.im.Subscribe(BND_SELECTED_TEAM_NAME, function() self:PublishAllData() end)
    self.im.Subscribe(BND_TEAM_CREST, function() self:PublishAllData() end)
    self.im.Subscribe(BND_TEAM_STAR_RATING, function() self:PublishAllData() end)
    self.im.Subscribe(BND_TEAM_RATING, function() self:PublishAllData() end)
    
    self.im.Subscribe(BND_HOME_TEAM_NAME, function() self:PublishAllData() end)
    self.im.Subscribe(BND_HOME_TEAM_CREST, function() self:PublishAllData() end)
    self.im.Subscribe(BND_HOME_TEAM_STARS, function() self:PublishAllData() end)
    self.im.Subscribe(BND_HOME_TEAM_STATS, function() self:PublishAllData() end)
    
    self.im.Subscribe(BND_AWAY_TEAM_NAME, function() self:PublishAllData() end)
    self.im.Subscribe(BND_AWAY_TEAM_CREST, function() self:PublishAllData() end)
    self.im.Subscribe(BND_AWAY_TEAM_STARS, function() self:PublishAllData() end)
    self.im.Subscribe(BND_AWAY_TEAM_STATS, function() self:PublishAllData() end)
    
    self.im.Subscribe(BND_INTERACTIVE_PANEL_VISIBLE, function() self:PublishAllData() end)
    self.im.Subscribe(BND_INFO_LABEL, function() self:PublishInfoLabel() end)
    self.im.Subscribe(BND_COMPARISON_BARS, function() self:PublishComparisonBars() end)

    self.im.RegisterDataAction(BND_TEAM_LIST_INDEX, "act_change", function(_, _, index)
        self.selectedIndex = index + 1
        self:PublishAllData()
    end)
    
    self.im.RegisterAction(ACT_CONFIRM_TEAM, function() self:ConfirmSelection() end)
    self.im.RegisterAction(ACT_RESET, function()
        self:ResetSelection()
        self:PublishAllData()
    end)
    self.im.RegisterAction(ACT_RANDOM, function() self:SelectRandomTeam() end)
end

function TeamSelect:PublishAllData()
    local currentTeam = TeamList[self.selectedIndex]

    if currentTeam then
        self.im.Publish(BND_SELECTED_TEAM_NAME, currentTeam.name)
        self.im.Publish(BND_TEAM_CREST, { name = "$Crest", id = currentTeam.id })
        self.im.Publish(BND_TEAM_STAR_RATING, currentTeam.starRating)
        self:PublishTeamRating(currentTeam)
    end

    if self.homeTeam then
        self.im.Publish(BND_HOME_TEAM_NAME, self.homeTeam.name)
        self.im.Publish(BND_HOME_TEAM_CREST, { name = "$Crest", id = self.homeTeam.id })
        self.im.Publish(BND_HOME_TEAM_STARS, self.homeTeam.starRating)
        self:PublishTeamStats(BND_HOME_TEAM_STATS, self.homeTeam)
    else
        self.im.Publish(BND_HOME_TEAM_NAME, "\n\n\nNo Team Selected")
        self.im.Publish(BND_HOME_TEAM_CREST, { name = "", id = 0 })
        self.im.Publish(BND_HOME_TEAM_STARS, 0)
        self:PublishTeamStats(BND_HOME_TEAM_STATS, nil)
    end
    
    if self.awayTeam then
        self.im.Publish(BND_AWAY_TEAM_NAME, self.awayTeam.name)
        self.im.Publish(BND_AWAY_TEAM_CREST, { name = "$Crest", id = self.awayTeam.id })
        self.im.Publish(BND_AWAY_TEAM_STARS, self.awayTeam.starRating)
        self:PublishTeamStats(BND_AWAY_TEAM_STATS, self.awayTeam)
    else
        self.im.Publish(BND_AWAY_TEAM_NAME, "\n\n\nNo Team Selected")
        self.im.Publish(BND_AWAY_TEAM_CREST, { name = "", id = 0 })
        self.im.Publish(BND_AWAY_TEAM_STARS, 0)
        self:PublishTeamStats(BND_AWAY_TEAM_STATS, nil)
    end

    self.im.Publish(BND_INTERACTIVE_PANEL_VISIBLE, { visible = (self.selectionState ~= STATE_CONFIRMED) })

    self:PublishInfoLabel()
    self:PublishTeamToggle()
    
    if self.homeTeam and self.awayTeam then
        self:PublishComparisonBars()
    end
end

function TeamSelect:PublishTeamStats(binding, team)
    if not team then
        self.im.Publish(binding, {
            attack = 0,
            midfield = 0,
            defense = 0,
            overall = 0
        })
        return
    end
    
    self.im.Publish(binding, {
        attack = team.offense,
        midfield = team.midfield,
        defense = team.defense,
        overall = team.overall
    })
end

function TeamSelect:PublishComparisonBars()
    if not self.homeTeam or not self.awayTeam then
        return
    end
    
    local comparisons = {
        {
            label = self.loc.LocalizeString("LTXT_CMN_ATT"),
            homeValue = self.homeTeam.offense,
            awayValue = self.awayTeam.offense,
            maxValue = 100
        },
        {
            label = self.loc.LocalizeString("LTXT_CMN_MID"),
            homeValue = self.homeTeam.midfield,
            awayValue = self.awayTeam.midfield,
            maxValue = 100
        },
        {
            label = self.loc.LocalizeString("LTXT_CMN_DEF"),
            homeValue = self.homeTeam.defense,
            awayValue = self.awayTeam.defense,
            maxValue = 100
        }
    }
    
    self.im.Publish(BND_COMPARISON_BARS, comparisons)
end

function TeamSelect:PublishInfoLabel()
    local text = ""
    if self.selectionState == STATE_INIT then
        text = "SELECT\nHOME TEAM"
    elseif self.selectionState == STATE_AWAY_SELECT then
        text = "SELECT\nAWAY TEAM"
    else
        text = "TEAMS\nSELECTED"
    end
    self.im.Publish(BND_INFO_LABEL, text)
end

function TeamSelect:PublishTeamToggle()
    local toggleData = {}
    for i, team in ipairs(TeamList) do 
        table.insert(toggleData, { 
            name = team.name, 
            assetid = team.id, 
            id = i,
            starRating = team.starRating
        }) 
    end
    self.im.Publish(BND_TEAM_LIST_TOGGLE, { data = toggleData, index = self.selectedIndex - 1 })
end

function TeamSelect:PublishTeamRating(team)
    if not team then return end

    local teamRating = {
        attackValue = team.offense,
        middleValue = team.midfield,
        defenseValue = team.defense,
        attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
        middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
        defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
    }
    self.im.Publish(BND_TEAM_RATING, teamRating)
end

function TeamSelect:ConfirmSelection()
    if self.selectionState == STATE_INIT then
        self.homeTeam = TeamList[self.selectedIndex]
        self.selectionState = STATE_AWAY_SELECT
        self.selectedIndex = 1
        
        self.nav.Event(nil, "evt_play_sound", { sound = "ui_confirm" })
        
    elseif self.selectionState == STATE_AWAY_SELECT then
        self.awayTeam = TeamList[self.selectedIndex]
        
        if self.homeTeam and self.homeTeam.id == self.awayTeam.id then
            self.nav.Event(nil, "evt_show_popup", { 
                title = "INVALID SELECTION", 
                message = "Teams cannot be the same.", 
                buttons = { { type = "Confirm", label = "OK", clickEvents = { "evt_hide_popup" } } } 
            })
            self.awayTeam = nil
            self.nav.Event(nil, "evt_play_sound", { sound = "ui_error" })
            return
        end
        
        self.selectionState = STATE_CONFIRMED
        self.nav.Event(nil, "evt_play_sound", { sound = "ui_success" })
        self:showFinalPopup()
    end
    self:PublishAllData()
end

function TeamSelect:SelectRandomTeam()
    local randomIndex

    if self.selectionState == STATE_AWAY_SELECT and self.homeTeam then
        local availableTeams = {}
        for i, team in ipairs(TeamList) do
            if team.id ~= self.homeTeam.id then
                table.insert(availableTeams, i)
            end
        end
        
        if #availableTeams > 0 then
            randomIndex = availableTeams[math.random(#availableTeams)]
        else
            randomIndex = math.random(#TeamList)
        end
    else
        randomIndex = math.random(#TeamList)
    end

    self.selectedIndex = randomIndex
    self:PublishAllData()
    self.nav.Event(nil, "evt_play_sound", { sound = "ui_random" })
end

function TeamSelect:showFinalPopup()
    currentCupInfo[cupId] = {
        cupIndex = cupId, 
        homeID = self.homeTeam.id, 
        awayID = self.awayTeam.id, 
        stage = "EXHIBITION_MATCH",
        homeName = self.homeTeam.name,
        awayName = self.awayTeam.name
    }

    QuickCupGrouping[cupId] = {
        { 
            [1] = self.homeTeam.id,
            [2] = self.awayTeam.id,
            [3] = 0,
            [4] = 0,
            [5] = false,
            [6] = 0,
            [7] = false,
            [8] = false,
            [9] = "1v1",
            [10] = 1
        }
    }
    
    self.nav.Event(nil, "evt_show_popup", {
        title = "MATCH CONFIRMATION",
        message = string.format("%s\nVs\n%s\n\nReady to start?", 
            self.homeTeam.name,
            self.awayTeam.name),
        buttons = {
            { type = "Cancel",
                icon = "$FooterIconNo", 
                label = "Cancel", 
                clickEvents = { "evt_hide_popup" } 
            },
            { type = "Confirm",
                icon = "$FooterIconYes", 
                label = "Confirm", 
                clickEvents = { "evt_team_select", "evt_hide_popup" } 
            }
        }
    })
end

function TeamSelect:finalize() 
    self.im.UnregisterAction(ACT_CONFIRM_TEAM)
    self.im.UnregisterAction(ACT_RESET)
    self.im.UnregisterAction(ACT_RANDOM)
    self.im.UnregisterDataAction(BND_TEAM_LIST_INDEX, "act_change")
end

return TeamSelect