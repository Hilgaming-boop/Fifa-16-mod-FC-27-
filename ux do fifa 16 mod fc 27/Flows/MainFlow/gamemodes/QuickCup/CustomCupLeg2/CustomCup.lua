--- MOUNTSA ---
local Tournament = {}

do
    Tournament.BND_TOURNAMENT_TYPE_LABEL = "bnd_tournament_type_toggle"
    Tournament.BND_TOURNAMENT_TYPE_TEXT = "bnd_tournament_type_text"
    Tournament.BND_TOURNAMENT_CREST = "bnd_tournament_crest"
    Tournament.BND_PREV_TOURNAMENT_CREST = "bnd_prev_tournament_crest"
    Tournament.BND_NEXT_TOURNAMENT_CREST = "bnd_next_tournament_crest"
    Tournament.BND_TEAM_COUNT_LABEL = "bnd_number_of_teams_toggle"
    Tournament.BND_TEAM_COUNT_TEXT = "bnd_team_count_text"
    Tournament.BND_AUTO_FILL_LABEL = "bnd_auto_fills_toggle"
    Tournament.BND_AUTO_FILL_TEXT = "bnd_auto_fill_text"
    Tournament.BND_TEAM_GENDER_LABEL = "bnd_team_type_toggle"
    Tournament.BND_TEAM_GENDER_TEXT = "bnd_team_type_text"
    Tournament.BND_CUP_ID_LABEL = "bnd_tour_id_toggle"
    Tournament.BND_CUP_ID_TEXT = "bnd_tour_id_text"
    Tournament.BND_DESCRIPTION = "bnd_description"
    Tournament.BND_TAB1_VISIBLE = "bnd_tab1_visible"
    Tournament.BND_TAB2_VISIBLE = "bnd_tab2_visible"
    Tournament.BND_TAB3_VISIBLE = "bnd_tab3_visible"
    Tournament.BND_TAB4_VISIBLE = "bnd_tab4_visible"
    Tournament.BND_TAB5_VISIBLE = "bnd_tab5_visible"

    -- Actions (ACT)
    Tournament.ACT_NEXT_TOURNAMENT_TYPE = "act_next_tournament_type"
    Tournament.ACT_PREV_TOURNAMENT_TYPE = "act_prev_tournament_type"
    Tournament.ACT_NEXT_TEAM_COUNT = "act_next_team_count"
    Tournament.ACT_PREV_TEAM_COUNT = "act_prev_team_count"
    Tournament.ACT_NEXT_AUTO_FILL = "act_next_auto_fill"
    Tournament.ACT_PREV_AUTO_FILL = "act_prev_auto_fill"
    Tournament.ACT_NEXT_TEAM_GENDER = "act_next_team_gender"
    Tournament.ACT_PREV_TEAM_GENDER = "act_prev_team_gender"
    Tournament.ACT_NEXT_CUP_ID = "act_next_tour_id"
    Tournament.ACT_PREV_CUP_ID = "act_prev_tour_id"
    Tournament.ACT_CONFIRM_SETUP = "act_confirm_setup"
    Tournament.ACT_FIFABUTTON = "act_fifabutton"
end

GlobalTournamentSettings = GlobalTournamentSettings or {}

function Tournament:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    o.services = { settingsService = o.api("SettingsService") }
    
    o.teamCountLists = {
        full = {

            { name = "16 Teams", value = 16 },
            { name = "32 Teams", value = 32 }
        },
        limited = {

            { name = "16 Teams", value = 16 }
        },
        groupKnockoutOnly = {
            { name = "32 Teams", value = 32 }
        }
    }

    o.options = {
        tournamentType = {
            { name = "Group + Knockout", value = 1 },
            { name = "Knockout", value = 2 },
            { name = "League", value = 3 }
        },
        teamCount = o.teamCountLists.full,
        autoFill  = { { name = "Yes", value = 1 }, { name = "No", value = 2 } },
        teamGender = { { name = "Men's Team", value = "Men" }, { name = "Women's Team", value = "Women" } },
        defaultTourIdList = {
    -- UEFA (semua pakai sistem home-away pada fase gugur)
        { name = "UEFA Champions League", value = 1 },
        { name = "FIFA World Cup 2026", value = 2 },
        { name = "UEFA Europa League", value = 3 },
        { name = "UEFA Conference League", value = 17 },
        { name = "FIFA Club World Cup", value = 15 },        
        { name = "Classic Tour", value = 22 },
        { name = "The Emirates FA Cup", value = 9 },
        { name = "Copa del Rey", value = 10 },
        { name = "Coppa Italia", value = 11 },
        { name = "Coupe de France", value = 18 },
        { name = "Dfb Pokal", value = 7 },
        { name = "Copa America", value = 25 },        
        { name = "Kratingdaeng Piala Indonesia", value = 29 },        

    -- AFC (knockout home-away)
        { name = "AFC Champions League Elit", value = 24 },
        { name = "AFC Champions League Two", value = 31 },
        { name = "AFC Challenge League", value = 21 },

    -- CONMEBOL (knockout home-away)
        { name = "CONMEBOL Libertadores", value = 4 },
        { name = "EA Sports Cup", value = 14 },
},
        leagueTourIdList = {
            { name = "Belgium Pro League", value = 4 }, { name = "Brazil Serie A", value = 7 }, { name = "Netherlands Eredivisie", value = 10 },
            { name = "Premier League", value = 13 }, { name = "EFL Championship", value = 14 }, { name = "France Ligue 1", value = 16 },
            { name = "France Ligue 2", value = 17 }, { name = "Germany Bundesliga", value = 19 }, { name = "Germany 2. Bundesliga", value = 20 },
            { name = "Italy Serie A", value = 31 }, { name = "Italy Serie B", value = 32 }, { name = "USA Major League Soccer", value = 39 },
            { name = "Scotland Premiership", value = 50 }, { name = "Spain La Liga", value = 53 }, { name = "Spain Segunda División", value = 54 },
            { name = "EFL League One", value = 60 }, { name = "Poland Ekstraklasa", value = 66 }, { name = "Russia Premier Liga", value = 67 },
            { name = "Turkey Süper Lig", value = 68 }, { name = "Rest of World", value = 76 }, { name = "Rest of World (2)", value = 77 },
            { name = "International", value = 78 }, { name = "Korea K League 1", value = 83 }, { name = "Portugal Primeira Liga", value = 308 },
            { name = "Colombia Primera A", value = 336 }, { name = "Mexico Liga MX", value = 341 }, { name = "South Africa Premier Division", value = 347 },
            { name = "Japan J1 League", value = 349 }, { name = "Saudi Arabia Pro League", value = 350 }, { name = "Australia A-League", value = 351 },
            { name = "Argentina Primera División", value = 353 }, { name = "AFC", value = 365 }, { name = "Hong Kong Premier League", value = 1107 },
            { name = "Singapore Premier League", value = 1114 }, { name = "Qatar Stars League", value = 1115 }, { name = "Uzbekistan Super League", value = 1117 },
            { name = "Cambodia Premier League", value = 1170 }, { name = "Myanmar National League", value = 1171 }, { name = "Laos League 1", value = 1172 },
            { name = "Classic Team", value = 1245 }, { name = "Classic Internasional", value = 1246 }, { name = "Bangladesh Premier League", value = 1407 },
            { name = "China Super League", value = 2012 }, { name = "UAE Pro-League", value = 2013 }, { name = "Algeria Ligue 1", value = 2034 },
            { name = "International Women", value = 2136 }, { name = "Indian Super League", value = 2149 }, { name = "Germany Frauen-Bundesliga", value = 2215 },
            { name = "FA Women's Super League", value = 2216 }, { name = "France D1 Féminine", value = 2218 }, { name = "USA NWSL", value = 2221 },
            { name = "Spain Liga F", value = 2222 }, { name = "Egyptian Premier League", value = 2231 }, { name = "BRI Liga 1", value = 2235 },
            { name = "Champions League Men", value = 2236 }, { name = "Liga Super Malaysia", value = 2237 }, { name = "Europe League", value = 2238 },
            { name = "Champions League Women", value = 2240 }, { name = "Botola Pro Inwi", value = 2250 }, { name = "Thai League 1", value = 2252 },
            { name = "Pegadaian Liga 2", value = 2254 }, { name = "PNM Liga Nusantara", value = 2255 }, { name = "V.League 1", value = 2260 }
        }
    }
    
    o.options.tourId = o.options.defaultTourIdList
    o.options.menDefaultTours = {}
    o.options.womenDefaultTours = {}
    o.options.menLeagueTours = {}
    o.options.womenLeagueTours = {}
    
    local womenKeywords = {"Women", "W World Tour", "Féminine", "Frauen-Bundesliga", "NWSL", "Liga F"}
    local function containsWomenKeyword(name)
        for _, keyword in ipairs(womenKeywords) do
            if string.find(name, keyword) then
                return true
            end
        end
        return false
    end

    for _, tour in ipairs(o.options.defaultTourIdList) do
        if containsWomenKeyword(tour.name) then
            table.insert(o.options.womenDefaultTours, tour)
        else
            table.insert(o.options.menDefaultTours, tour)
        end
    end

    for _, league in ipairs(o.options.leagueTourIdList) do
        if containsWomenKeyword(league.name) then
            table.insert(o.options.womenLeagueTours, league)
        else
            table.insert(o.options.menLeagueTours, league)
        end
    end

    o.selectedIndices = {
        tournamentType = 1,
        teamCount = 2,
        autoFill = 1,
        teamGender = 1,
        tourId = 1
    }
    o.tournamentName = "EAFC Tournament"

    o:RegisterBindingsAndActions()
    o:PublishInitialData()
    
    o.tabBindings = { self.BND_TAB1_VISIBLE, self.BND_TAB2_VISIBLE, self.BND_TAB3_VISIBLE, self.BND_TAB4_VISIBLE, self.BND_TAB5_VISIBLE }
    for _, binding in ipairs(o.tabBindings) do
        o.im.Subscribe(binding, function() end)
    end
    o:HideSelections()
    o.im.Publish(self.BND_TAB1_VISIBLE, true)

    o.im.RegisterAction(self.ACT_FIFABUTTON, function(_, data)
        o:HideSelections()
        local tabIndex = data.buttonID + 1
        if o.tabBindings[tabIndex] then
            o.im.Publish(o.tabBindings[tabIndex], true)
        end
    end)
    
    return o
end

function Tournament:RegisterBindingsAndActions()
    self.im.RegisterAction(self.ACT_NEXT_TOURNAMENT_TYPE, function() self:nextTournamentType() end)
    self.im.RegisterAction(self.ACT_PREV_TOURNAMENT_TYPE, function() self:prevTournamentType() end)
    self.im.Subscribe(self.BND_TOURNAMENT_TYPE_TEXT, function() self:updateTournamentTypeUI() end)
    self.im.Subscribe(self.BND_TOURNAMENT_CREST, function() self:updateTournamentTypeUI() end)
    self.im.Subscribe(self.BND_PREV_TOURNAMENT_CREST, function() self:updateTournamentTypeUI() end)
    self.im.Subscribe(self.BND_NEXT_TOURNAMENT_CREST, function() self:updateTournamentTypeUI() end)
    
    self.im.RegisterAction(self.ACT_NEXT_TEAM_COUNT, function() self:nextTeamCount() end)
    self.im.RegisterAction(self.ACT_PREV_TEAM_COUNT, function() self:prevTeamCount() end)
    self.im.Subscribe(self.BND_TEAM_COUNT_TEXT, function() self:updateTeamCountUI() end)

    self.im.RegisterAction(self.ACT_NEXT_AUTO_FILL, function() self:nextAutoFill() end)
    self.im.RegisterAction(self.ACT_PREV_AUTO_FILL, function() self:prevAutoFill() end)
    self.im.Subscribe(self.BND_AUTO_FILL_TEXT, function() self:updateAutoFillUI() end)
    
    self.im.RegisterAction(self.ACT_NEXT_TEAM_GENDER, function() self:nextTeamGender() end)
    self.im.RegisterAction(self.ACT_PREV_TEAM_GENDER, function() self:prevTeamGender() end)
    self.im.Subscribe(self.BND_TEAM_GENDER_TEXT, function() self:updateTeamGenderUI() end)
    
    self.im.RegisterAction(self.ACT_NEXT_CUP_ID, function() self:nexttourId() end)
    self.im.RegisterAction(self.ACT_PREV_CUP_ID, function() self:prevtourId() end)
    self.im.Subscribe(self.BND_CUP_ID_TEXT, function() self:updatetourIdUI() end)
    
    self.im.Subscribe(self.BND_DESCRIPTION, function() self:PublishDescription() end)
    self.im.RegisterAction(self.ACT_CONFIRM_SETUP, function() self:ConfirmAndProceed() end)
end

function Tournament:navigate(settingName, direction)
    local options = self.options[settingName]
    local currentIndex = self.selectedIndices[settingName]
    local newIndex = currentIndex + direction
    
    if newIndex > #options then newIndex = 1
    elseif newIndex < 1 then newIndex = #options end
    
    self.selectedIndices[settingName] = newIndex
end

function Tournament:nextTournamentType() self:navigate("tournamentType", 1); self:updateTournamentTypeUI() end
function Tournament:prevTournamentType() self:navigate("tournamentType", -1); self:updateTournamentTypeUI() end
function Tournament:nextTeamCount() self:navigate("teamCount", 1); self:updateTeamCountUI() end
function Tournament:prevTeamCount() self:navigate("teamCount", -1); self:updateTeamCountUI() end
function Tournament:nexttourId() self:navigate("tourId", 1); self:updatetourIdUI() end
function Tournament:prevtourId() self:navigate("tourId", -1); self:updatetourIdUI() end
function Tournament:nextAutoFill() self:navigate("autoFill", 1); self:updateAutoFillUI() end
function Tournament:prevAutoFill() self:navigate("autoFill", -1); self:updateAutoFillUI() end
function Tournament:nextTeamGender() self:navigate("teamGender", 1); self:updateTeamGenderUI() end
function Tournament:prevTeamGender() self:navigate("teamGender", -1); self:updateTeamGenderUI() end

function Tournament:updateTournamentTypeUI()
    local options = self.options.tournamentType
    local totalOptions = #options
    local currentIndex = self.selectedIndices.tournamentType
    local currentOpt = options[currentIndex]
    if not currentOpt then return end

    if currentOpt.name == "Group + Knockout" then
        self.options.teamCount = self.teamCountLists.groupKnockoutOnly
        self.selectedIndices.teamCount = 1
    else
        self.options.teamCount = self.teamCountLists.limited
        if self.selectedIndices.teamCount > #self.options.teamCount then
            self.selectedIndices.teamCount = #self.options.teamCount
        end
    end
    self:updateTourIdListBasedOnSelections()
    self:updateTeamCountUI()

    local prevIndex = (currentIndex - 2 + totalOptions) % totalOptions + 1
    local nextIndex = (currentIndex % totalOptions) + 1
    
    self.im.Publish(self.BND_TOURNAMENT_TYPE_LABEL, { data = {{ name = currentOpt.name }}, index = 0 })
    self.im.Publish(self.BND_TOURNAMENT_TYPE_TEXT, currentOpt.name)
    self.im.Publish(self.BND_TOURNAMENT_CREST, { name = "$Set_Cup", id = currentOpt.value })
    self.im.Publish(self.BND_PREV_TOURNAMENT_CREST, { name = "$Set_Cup", id = options[prevIndex].value })
    self.im.Publish(self.BND_NEXT_TOURNAMENT_CREST, { name = "$Set_Cup", id = options[nextIndex].value })
    
    self:PublishDescription()
end

function Tournament:updateTourIdListBasedOnSelections()
    local typeOpt = self.options.tournamentType[self.selectedIndices.tournamentType]
    local genderOpt = self.options.teamGender[self.selectedIndices.teamGender]

    if typeOpt.name == "League" then
        self.options.tourId = (genderOpt.value == "Women") and self.options.womenLeagueTours or self.options.menLeagueTours
    else
        self.options.tourId = (genderOpt.value == "Women") and self.options.womenDefaultTours or self.options.menDefaultTours
    end
    
    self.selectedIndices.tourId = 1
    self:updatetourIdUI()
end

function Tournament:updateTeamCountUI()
    local current = self.options.teamCount[self.selectedIndices.teamCount]
    if current then
        self.im.Publish(self.BND_TEAM_COUNT_TEXT, current.name)
        self:PublishDescription()
    end
end

function Tournament:updateAutoFillUI()
    local current = self.options.autoFill[self.selectedIndices.autoFill]
    if current then
        self.im.Publish(self.BND_AUTO_FILL_LABEL, { data = {{ name = current.name }}, index = 0 })
        self.im.Publish(self.BND_AUTO_FILL_TEXT, current.name)
        self:PublishDescription()
    end
end

function Tournament:updatetourIdUI()
    local current = self.options.tourId[self.selectedIndices.tourId]
    if current then
        self.im.Publish(self.BND_CUP_ID_TEXT, current.name)
        self:PublishDescription()
    end
end

function Tournament:updateTeamGenderUI()
    local current = self.options.teamGender[self.selectedIndices.teamGender]
    if current then
        self.im.Publish(self.BND_TEAM_GENDER_LABEL, { data = {{ name = current.name }}, index = 0 })
        self.im.Publish(self.BND_TEAM_GENDER_TEXT, current.name)
        self:updateTourIdListBasedOnSelections()
        self:PublishDescription()
    end
end

function Tournament:PublishInitialData()
    self:updateTournamentTypeUI()
    self:updateTeamCountUI()
    self:updateAutoFillUI()
    self:updatetourIdUI()
    self:updateTeamGenderUI()
end

function Tournament:PublishDescription()
    local typeOpt = self.options.tournamentType[self.selectedIndices.tournamentType]
    local teamsOpt = self.options.teamCount[self.selectedIndices.teamCount]
    local tourOpt = self.options.tourId[self.selectedIndices.tourId]
    local genderOpt = self.options.teamGender[self.selectedIndices.teamGender]

    if typeOpt and teamsOpt and tourOpt and genderOpt then
        local desc = string.format(
            "You are creating a %s tournament named '%s' with %s %s teams, featuring the %s branding.",
            string.upper(typeOpt.name),
            self.tournamentName,
            teamsOpt.name,
            genderOpt.name,
            tourOpt.name
        )
        self.im.Publish(self.BND_DESCRIPTION, desc)
    end
end

function Tournament:ConfirmAndProceed()
    local selectedTourId = self.options.tourId[self.selectedIndices.tourId].value
    local selectedTeamCount = self.options.teamCount[self.selectedIndices.teamCount].value
    local selectedTournamentType = self.options.tournamentType[self.selectedIndices.tournamentType].name

    GlobalTournamentSettings = {
        tourId = selectedTourId,
        teamCount = selectedTeamCount,
        tournamentType = selectedTournamentType,
        tournamentName = self.tournamentName,
        selectedTourId = selectedTourId,
        teamsPerGroup = (selectedTournamentType == "League") and selectedTeamCount or 4,
        useUCLStyle = (selectedTournamentType == "Group + Knockout")
    }

    print("--- Tournament Settings Saved ---")
    print("Tour ID:", GlobalTournamentSettings.tourId)
    print("Team Count:", GlobalTournamentSettings.teamCount)
    print("Type:", GlobalTournamentSettings.tournamentType)
    print("---------------------------------")
    
    if selectedTournamentType == "League" then
        self:Belum()
    else
        self.nav.Event(nil, "evt_group_stage")
    end
end

function Tournament:Belum()
    self.nav.Event(nil, "evt_show_popup", {
        title = "INFO",
        message = "We're working on it. \nPlease check back for upcoming updates.",
        buttons = {
            {
				label = "Confirm",
                icon = "$FooterIconYes",
                label = "OK",
                clickEvents = { "evt_hide_popup" }
            }
        }
    })
end

function Tournament:HideSelections()
    for _, binding in ipairs(self.tabBindings or {}) do
        self.im.Publish(binding, false)
    end
end

function Tournament:finalize()
    local actions = {
        self.ACT_NEXT_TOURNAMENT_TYPE, self.ACT_PREV_TOURNAMENT_TYPE,
        self.ACT_NEXT_TEAM_COUNT, self.ACT_PREV_TEAM_COUNT,
        self.ACT_NEXT_AUTO_FILL, self.ACT_PREV_AUTO_FILL,
        self.ACT_NEXT_CUP_ID, self.ACT_PREV_CUP_ID,
        self.ACT_NEXT_TEAM_GENDER, self.ACT_PREV_TEAM_GENDER,
        self.ACT_CONFIRM_SETUP, self.ACT_FIFABUTTON
    }
    for _, action in ipairs(actions) do
        self.im.UnregisterAction(action)
    end

    local subscriptions = {
        self.BND_TOURNAMENT_TYPE_LABEL, self.BND_TOURNAMENT_TYPE_TEXT,
        self.BND_TOURNAMENT_CREST, self.BND_PREV_TOURNAMENT_CREST, self.BND_NEXT_TOURNAMENT_CREST,
        self.BND_TEAM_COUNT_LABEL, self.BND_TEAM_COUNT_TEXT,
        self.BND_AUTO_FILL_LABEL, self.BND_AUTO_FILL_TEXT,
        self.BND_CUP_ID_LABEL, self.BND_CUP_ID_TEXT,
        self.BND_TEAM_GENDER_LABEL, self.BND_TEAM_GENDER_TEXT,
        self.BND_DESCRIPTION,
        self.BND_TAB1_VISIBLE, self.BND_TAB2_VISIBLE, self.BND_TAB3_VISIBLE,
        self.BND_TAB4_VISIBLE, self.BND_TAB5_VISIBLE
    }
    for _, sub in ipairs(subscriptions) do
        self.im.Unsubscribe(sub)
    end
end

return Tournament