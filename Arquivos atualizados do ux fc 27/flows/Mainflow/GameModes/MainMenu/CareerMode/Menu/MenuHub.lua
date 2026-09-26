-- MounTsa -- 
local CareerHub = {}

local BND_TEAM_RATING = "bnd_team_rating"
local BND_COUNTRY_CREST = "bnd_country_crest"
local BND_LEAGUE_CREST = "bnd_league_crest"
local BND_COUNTRY_SELECTOR = "bnd_country_selector_data"
local ACT_CHANGE_COUNTRY = "act_change_country"
local BND_COUNTRY_INDEX_CHANGE = "bnd_country_index_change"
local BND_LEAGUE_SELECTOR = "bnd_league_selector_data"
local ACT_CHANGE_LEAGUE = "act_change_league"
local BND_LEAGUE_INDEX_CHANGE = "bnd_league_index_change"
local ACT_CONFIRM_SETUP = "act_advance"
local BND_TEAMS_MENU = "bnd_teams_menu"
local BND_SELECTED_TEAM_INDEX = "bnd_selected_team_index"
local ACT_CHANGE_TEAM = "act_change_team"
local BND_TEAM_CREST = "bnd_team_crest"
local BND_TEAM_NAME = "bnd_team_name"
local BND_TEAM_STARS = "bnd_team_stars"
local BND_DESCRIPTION = "bnd_description"

missionmode = "ER"
ligaId = 1
CareerSettings = CareerSettings or {}

function CareerHub:updateDevDisplay()
    local devId = (GlobalDevSettings and GlobalDevSettings.devId) or 1
    local devName = (GlobalDevSettings and GlobalDevSettings.devName) or " MOUNTSA "
    self.im.Publish("bnd_avatar_dev", { name = "$Dev", id = devId })
    self.im.Publish("bnd_name_dev", devName)
end

function CareerHub:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = { 
        settingsService = o.api("SettingsService"),
        SquadManagementService = o.api("SquadMgtService"),
        TeamService = o.api("TeamService"),
        loc = o.api("LocalizationService")
    }
    
    o.LeaguesByCountry = {
        { name = "England", id = 14, leagues = { { name = "Premier League", id = 13 }, { name = "Championship", id = 14 }, { name = "League 1", id = 60 } }},
        { name = "Germany", id = 21, leagues = { { name = "Bundesliga", id = 19 }, { name = "Bundesliga 2", id = 20 } }},
        { name = "Spain", id = 45, leagues = { { name = "Laliga Ea Sport", id = 53 }, { name = "Laliga Hypermotion", id = 54 } }},
        { name = "Italy", id = 27, leagues = { { name = "Serie A TIM", id = 31 }, { name = "Serie B", id = 32 } }},
        { name = "France", id = 18, leagues = { { name = "Ligue 1", id = 16 }, { name = "Ligue 2", id = 17 } }},
        { name = "Indonesia", id = 160, leagues = { { name = "BRI Liga 1", id = 2235 } }},
        { name = "Netherlands", id = 34, leagues = { { name = "Eredivisie", id = 10 } }},
        { name = "Portugal", id = 38, leagues = { { name = "Liga NOS", id = 308 } }},
        { name = "USA", id = 95, leagues = { { name = "MLS", id = 39 } }},
        { name = "Saudi Arabia", id = 183, leagues = { { name = "Pro League", id = 350 } }},
        { name = "Turkey", id = 48, leagues = { { name = "Süper Lig", id = 68 } }},
    }
    
    o.im.Subscribe("bnd_avatar_dev", function() o:updateDevDisplay() end)
    o.im.Subscribe("bnd_name_dev", function() o:updateDevDisplay() end)
    o.refreshHandler = o.nav.AddActionHandler("evt_refresh_mainhub_data", false, nil, function() o:updateDevDisplay() end)
    
    o.selectedIndices = { country = 1, league = 1, team = 1 }
    o.teamsData = {}
    o.currentTeamInfo = nil

    o:RegisterBindingsAndActions()
    o:PublishInitialData()
    return o
end

function CareerHub:RegisterBindingsAndActions()
    self.im.Subscribe(BND_COUNTRY_SELECTOR, function() self:_publishCountrySelector() end)
    self.im.RegisterDataAction(BND_COUNTRY_INDEX_CHANGE, ACT_CHANGE_COUNTRY, function(_, _, index) self:_onCountryChanged(index) end)

    self.im.Subscribe(BND_LEAGUE_SELECTOR, function() self:_publishLeagueSelector() end)
    self.im.RegisterDataAction(BND_LEAGUE_INDEX_CHANGE, ACT_CHANGE_LEAGUE, function(_, _, index) self:_onLeagueChanged(index) end)

    self.im.RegisterAction(ACT_CONFIRM_SETUP, function() self:ConfirmAndProceed() end)
    self.im.RegisterDataAction(BND_SELECTED_TEAM_INDEX, ACT_CHANGE_TEAM, function(_, _, index) self:_setSelectedTeamIndex(index) end)
    
    self.im.Subscribe(BND_COUNTRY_CREST, function() self:_publishMainCountryCrest() end)
    self.im.Subscribe(BND_LEAGUE_CREST, function() self:_publishMainLeagueCrest() end)
    
    self.im.Subscribe(BND_TEAMS_MENU, function() self:_publishTeamsMenu() end)
    self.im.Subscribe(BND_TEAM_CREST, function() self:_publishTeamCrest() end)
    self.im.Subscribe(BND_TEAM_NAME, function() self:_publishTeamName() end)
    self.im.Subscribe(BND_TEAM_STARS, function() self:_publishTeamStars() end)

    self.im.Subscribe(BND_TEAM_RATING, function() self:_publishTeamRating() end)
end

function CareerHub:PublishInitialData() self:_publishCountrySelector() end
function CareerHub:_publishCountrySelector() local countryCellData={} for _, country in ipairs(self.LeaguesByCountry) do table.insert(countryCellData, { name = country.name, id = country.id, image = { name = "$Flag128x128", id = country.id } }) end self.im.Publish(BND_COUNTRY_SELECTOR, { data = countryCellData, index = self.selectedIndices.country - 1 }) self:_publishLeagueSelector() self:_publishMainCountryCrest() end
function CareerHub:_publishLeagueSelector() local selectedCountry = self.LeaguesByCountry[self.selectedIndices.country] if not selectedCountry or not selectedCountry.leagues then return end local leagueCellData={} for _, league in ipairs(selectedCountry.leagues) do table.insert(leagueCellData, { name = league.name, id = league.id, image = { name = "$LeagueCrest", id = league.id } }) end self.im.Publish(BND_LEAGUE_SELECTOR, { data = leagueCellData, index = self.selectedIndices.league - 1 }) self:_loadAndDisplayTeams() self:_publishMainLeagueCrest() end
function CareerHub:_onCountryChanged(index) self.selectedIndices.country = index + 1 self.selectedIndices.league = 1 self.selectedIndices.team = 1 self:_publishLeagueSelector() self:_publishMainCountryCrest() end
function CareerHub:_onLeagueChanged(index) self.selectedIndices.league = index + 1 self.selectedIndices.team = 1 self:_loadAndDisplayTeams() self:_publishMainLeagueCrest() end
function CareerHub:GetTeamsByLeague(leagueId) local teams={} local success, teamList=pcall(function() return self.services.TeamService.GetTeams(leagueId, 0, 0, false) end) if success and teamList and #teamList > 0 then for _, teamData in ipairs(teamList) do local teamInfo=self.services.SquadManagementService.GetTeamInfo(teamData.id) or teamData local fullName=self.loc.LocalizeString("TeamName_Abbr15_" .. teamData.id) local shortName=self.loc.LocalizeString("TeamName_Abbr3_" .. teamData.id) if fullName=="TeamName_Abbr15_" .. teamData.id then fullName=teamInfo.name or "Team " .. teamData.id end if shortName=="TeamName_Abbr3_" .. teamData.id then shortName=fullName end table.insert(teams, { id=teamData.id, name=fullName, shortName=shortName, crestId=teamInfo.crestId or teamData.id, starRating=teamInfo.starRating or 3, offense=teamInfo.offense or 70, midfield=teamInfo.midfield or 70, defense=teamInfo.defense or 70 }) end end return teams end
function CareerHub:_buildTeamCellData()
    local cellData = {}
    if #self.teamsData == 1 then
        table.insert(cellData, { label = "No teams available", id = -1 })
        return cellData
    end
    
    for i, team in ipairs(self.teamsData) do
        local isSelected = (self.selectedIndices.team == i)
        table.insert(cellData, {
            label = "",
            image = { name = "$Crest", id = team.crestId or team.id },
            id = i,
            selected = isSelected,
            clickAction = ACT_CHANGE_TEAM,
            alternateBackground = isSelected
        })
    end
    return cellData
end
function CareerHub:_loadAndDisplayTeams() local selectedCountry=self.LeaguesByCountry[self.selectedIndices.country] local selectedLeague=selectedCountry and selectedCountry.leagues[self.selectedIndices.league] if selectedLeague then self.teamsData=self:GetTeamsByLeague(selectedLeague.id) self.selectedIndices.team=1 self.currentTeamInfo=self.teamsData[1] or nil self:_publishTeamsMenu() self:_updateAllTeamInfoUI() end end
function CareerHub:_publishTeamsMenu() self.im.Publish(BND_TEAMS_MENU, { index=self.selectedIndices.team - 1, data=self:_buildTeamCellData() }) end
function CareerHub:_setSelectedTeamIndex(index) local newIndex=index if newIndex < 1 or newIndex > #self.teamsData then return end self.selectedIndices.team=newIndex self.currentTeamInfo=self.teamsData[newIndex] self:_publishTeamsMenu() self:_updateAllTeamInfoUI() end

function CareerHub:_updateAllTeamInfoUI()
    self:_publishTeamCrest()
    self:_publishTeamName()
    self:_publishTeamStars()
    self:_publishTeamRating()
end

function CareerHub:_publishMainCountryCrest()
    local selectedCountry = self.LeaguesByCountry[self.selectedIndices.country]
    if selectedCountry then
        self.im.Publish(BND_COUNTRY_CREST, { name = "$Flag128x128", id = selectedCountry.id })
    end
end

function CareerHub:_publishMainLeagueCrest()
    local selectedCountry = self.LeaguesByCountry[self.selectedIndices.country]
    local selectedLeague = selectedCountry and selectedCountry.leagues[self.selectedIndices.league]
    if selectedLeague then
        self.im.Publish(BND_LEAGUE_CREST, { name = "$LeagueCrest", id = selectedLeague.id })
    end
end

function CareerHub:_publishTeamCrest() 
    self.im.Publish(BND_TEAM_CREST, { name = "$Crest", id = self.currentTeamInfo and self.currentTeamInfo.crestId or 0 }) 
end

function CareerHub:_publishTeamName() 
    self.im.Publish(BND_TEAM_NAME, self.currentTeamInfo and self.currentTeamInfo.name or "Select a team") 
end

function CareerHub:_publishTeamStars() 
    self.im.Publish(BND_TEAM_STARS, self.currentTeamInfo and self.currentTeamInfo.starRating or 0) 
end

function CareerHub:_publishTeamRating()
    local team = self.currentTeamInfo
    if not team then 
        self.im.Publish(BND_TEAM_RATING, {
            attackValue = 0, middleValue = 0, defenseValue = 0,
            attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
            middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
            defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
        })
        return 
    end

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

function CareerHub:ConfirmAndProceed()
    local selectedCountry = self.LeaguesByCountry[self.selectedIndices.country]
    local selectedLeague = selectedCountry and selectedCountry.leagues[self.selectedIndices.league]
    local selectedTeam = self.teamsData[self.selectedIndices.team]

    if not selectedTeam or not selectedLeague then
        self.im.Publish(BND_DESCRIPTION, "Please select a team first!")
        return
    end

    CareerSettings = {
        countryId = selectedCountry.id,
        leagueId = selectedLeague.id,
        teamId = selectedTeam.id,
        teamName = selectedTeam.name,
        teamStars = selectedTeam.starRating
    }
    
    self.nav.Event(nil, "evt_missionmode1")
end

function CareerHub:finalize()
    self.im.Unsubscribe("bnd_avatar_dev")
    self.im.Unsubscribe("bnd_name_dev")
    if self.refreshHandler then self.nav.RemoveActionHandler("evt_refresh_mainhub_data"); self.refreshHandler = nil end
    
    self.im.UnregisterDataAction(BND_COUNTRY_INDEX_CHANGE, ACT_CHANGE_COUNTRY)
    self.im.UnregisterDataAction(BND_LEAGUE_INDEX_CHANGE, ACT_CHANGE_LEAGUE)
    self.im.UnregisterAction(ACT_CONFIRM_SETUP)
    self.im.UnregisterDataAction(BND_SELECTED_TEAM_INDEX, ACT_CHANGE_TEAM)
    
    self.im.Unsubscribe(BND_COUNTRY_SELECTOR)
    self.im.Unsubscribe(BND_LEAGUE_SELECTOR)
    self.im.Unsubscribe(BND_COUNTRY_CREST)
    self.im.Unsubscribe(BND_LEAGUE_CREST)
    self.im.Unsubscribe(BND_TEAMS_MENU)
    self.im.Unsubscribe(BND_TEAM_CREST)
    self.im.Unsubscribe(BND_TEAM_NAME)
    self.im.Unsubscribe(BND_TEAM_STARS)
    
    self.im.Unsubscribe(BND_TEAM_RATING)
end

return CareerHub
-- MounTsa --