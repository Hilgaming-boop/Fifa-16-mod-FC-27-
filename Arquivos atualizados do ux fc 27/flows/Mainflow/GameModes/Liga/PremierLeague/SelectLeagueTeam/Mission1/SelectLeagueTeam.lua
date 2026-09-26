---- THANKS FOR ALL MODDER --
---- IMPROVED BY MOUNTSA ----
local FUTLoginManager, VirtualButton, TableUtil, EventManager, SKUEnums = ...
local SelectLeagueTeam = {}
local stadiumIdToName = {}
local BND_COUNTRY_NAME = "bnd_country_name"
local BND_LEAGUE_INDEX = "bnd_league_index"
local BND_LEAGUE_LIST = "bnd_league_list"
local BND_SELECTED_LEAGUE_NAME = "bnd_selected_league_name"
local BND_LEAGUE_OVERLAY_VISIBLE = "bnd_league_overlay_visible"
local BND_TEAM_INDEX = "bnd_team_index"
local BND_TEAM_LIST = "bnd_team_list"
local BND_SELECTED_TEAM_NAME = "bnd_selected_team_name"
local BND_TEAM_OVERLAY_VISIBLE = "bnd_team_overlay_visible"
local BND_TEAM_CREST_HOME_KIT = "bnd_home_kit"
local BND_TEAM_CREST_AWAY_KIT = "bnd_away_kit"
local BND_BACKGROUND_CAREER = "bnd_background_career"
local BND_FANBASE_ASSET     = "bnd_fanbase_asset"
local BND_YOUTH_ASSET       = "bnd_youth_asset"
local BND_FINANCIAL_ASSET   = "bnd_financial_asset"
local BND_DIFFICULTY_LABEL1 = "bnd_difficulty_label1"
local BND_DIFFICULTY_LABEL2 = "bnd_difficulty_label2"
local BND_DIFFICULTY_LABEL3 = "bnd_difficulty_label3"
local BND_DIFFICULTY_LABEL4 = "bnd_difficulty_label4"
local BND_DIFFICULTY_LABEL5 = "bnd_difficulty_label5"
local BND_STADIUM_NAME = "bnd_stadium_name"
local BND_TROPHY_LEAGUES = "bnd_trophy_leagues"
local BND_TROPHY_CUPS    = "bnd_trophy_cups"
local BND_TROPHY_UCL     = "bnd_trophy_ucl"
local BND_FOUNDED        = "bnd_founded"   -- <<-- tambahan
local BND_LEAGUE_NAME = "bnd_league_name"
local BND_NATION_LEAGUE_NAME = "bnd_nation_league_name"
local BND_TEAM_VALUE = "bnd_team_value"
local BND_TRANSFER_BUDGET = "bnd_transfer_budget"
local BND_TEAM_CREST = "bnd_team_crest"
local BND_LEAGUE_CREST = "bnd_league_crest"
local BND_LEAGUE_CREST_ACTIVE = "bnd_league_crest_active"
local BND_DETERMINED_PACK_VISIBILITY = "bnd_determined_pack_visible"
local BND_REGULAR_BG_VISIBILITY = "bnd_regular_bg_visible"
local BND_DEFAULT_CELL_DATA = "bnd_default_cell_data"
local BND_LEAGUE_LIST_INDEX = "bnd_league_list_index"
local BND_LEAGUE_LIST_TOGGLE = "bnd_league_list_toggle"
local BND_TEAM_LIST_INDEX = "bnd_team_list_index"
local BND_TEAM_LIST_TOGGLE = "bnd_team_list_toggle"
local BND_TEAM_STAR_RATING = "bnd_team_star_rating"
local BND_TEAM_RATING = "bnd_team_rating"
local ACT_SELECT_LEAGUE = "act_select_league"
local ACT_SELECT_TEAM = "act_select_team"
local ACT_SELECTOR_CANCEL = "act_selector_cancel"
local ACT_CHANGE = "act_change"
local ACT_CONFIRM = "act_confirm"
local BND_HOME_COUNTRY_SELECT_VISIBLE = "bnd_home_country_select_visible"
local BND_HOME_TEAM_SELECT_VISIBLE = "bnd_home_team_select_visible"
local BND_HOME_LEAGUE_SELECT_VISIBLE = "bnd_home_league_select_visible"
local ACT_BTN_CLICK = "act_btn_click"
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes
local LOGIN_STATUS = FUTLoginManager.FeCards.LoginStatus
local TERMINATION_REASON = SKUEnums.fifaids.TerminationReason
local COUNTRY_H = 2
local TEAM_H = 1
local LEAGUE_H = 3
local NUM_COLUMNS = 4
missionmode = "ER"
ligaId = 1

function SelectLeagueTeam:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
    o:initLeagueCountryMapping()  -- Tambahkan ini
  o.services = {
    TeamService = o.api("TeamService"),
    CountryService = o.api("CountryService"),
    UserPlateService = o.api("UserPlateService"),
    GameStateService = o.api("GameStateService"),
    FUTUserInfoService = o.api("FUTUserInfoService"),
    EventManagerService = o.api("EventManagerService"),
    settingsService = o.api("SettingsService"),
    GameState = o.api("GameStateService")
  }
  o.currentOptions = o.services.settingsService.GetCurrentOptions()
  o.isDeterminationPackKillSwitchOn = o.services.GameStateService.IsDeterminationPackKillSwitchOn()
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end)
  local defaultData = o.services.CountryService.GetDefaultTeamForRegion()

  o.currentCountryID = -1
  o.currentLeagueID = 53
  o.currentTeamID = 241
  o.favoritePlayerID = -1
  o.countryIndex = 1
  o.leagueIndex = 1
  o.teamIndex = 1
  o.currentTeamName = ""
  o:getLeagues()
  o:publishTransferBudget()
  o:initStadiumDatabase()
  o:registerLeagueBindings()
  o:registerTeamBindings()
  o.randomDifficultyLabels = nil
  o.hasInitializedDifficulties = false
    o.im.Subscribe("bnd_league_index", function(leagueId)
    local bg = o:getBackgroundByLeagueID(leagueId)
    o.services.MiscService:Log("Set background for leagueId: " .. tostring(leagueId))
    o.im.Publish("bnd_menu_bg", bg)
  end)
  o.im.Subscribe(BND_COUNTRY_NAME, function()
    local countryName = o:getCountryNameByLeagueId(o.currentLeagueID)
    o.im.Publish(BND_COUNTRY_NAME, countryName)
end)
  o.im.Subscribe(BND_TEAM_CREST, function()
    o:publishTeamCrest(o.currentTeamID) 
  end)
  o.im.Subscribe(BND_STADIUM_NAME, function()
        o:publishStadiumName(o.currentTeamID)
    end)
  o.im.Subscribe(BND_TROPHY_LEAGUES, function()
    o:publishTrophies(o.currentTeamID)
end)

o.im.Subscribe(BND_LEAGUE_NAME, function()
    o:publishLeagueName(o.currentLeagueID)
end)

o.im.Subscribe(BND_NATION_LEAGUE_NAME, function()
    o:publishLeagueName(o.currentLeagueID)
end)

o.im.Subscribe(BND_TROPHY_CUPS, function()
    o:publishTrophies(o.currentTeamID)
end)

o.im.Subscribe(BND_TROPHY_UCL, function()
    o:publishTrophies(o.currentTeamID)
end)

o.im.Subscribe(BND_FOUNDED, function()   -- <<-- tambahan
    o:publishTrophies(o.currentTeamID)
end)
  o.im.Subscribe(BND_TEAM_VALUE, function()
        o:publishTeamValue(o.currentTeamID)  
    end)
  o.im.Subscribe(BND_TRANSFER_BUDGET, function()
        o:calculateTransferBudget(o.currentTeamID)  
    end)
  o.im.Subscribe(BND_TEAM_CREST_HOME_KIT, function()
    o:publishTeamCrestHomeKit(o.currentTeamID) 
  end)
  o.im.Subscribe(BND_TEAM_CREST_AWAY_KIT, function()
    o:publishTeamCrestAwayKit(o.currentTeamID) 
  end)
  
  -- Subscribe supaya otomatis update saat liga berubah
  o.im.Subscribe(BND_BACKGROUND_CAREER, function()
    o:publishBackgroundCareer(o.currentLeagueID)
  end)
  
  o.im.Subscribe(BND_FANBASE_ASSET, function()
    o:publishRandomAssets()
end)

o.im.Subscribe(BND_YOUTH_ASSET, function()
    o:publishRandomAssets()
end)

o.im.Subscribe(BND_FINANCIAL_ASSET, function()
    o:publishRandomAssets()
end)

  o.im.Subscribe(BND_LEAGUE_CREST, function()
    o:publishLeagueCrest()
  end)
  o.im.Subscribe(BND_LEAGUE_CREST_ACTIVE, function()
    o:publishLeagueCrestActive()
  end)
  o.im.Subscribe(BND_DETERMINED_PACK_VISIBILITY, function()
    o.im.Publish(BND_DETERMINED_PACK_VISIBILITY, not o.isDeterminationPackKillSwitchOn)
  end)
  o.im.Subscribe(BND_REGULAR_BG_VISIBILITY, function()
    o.im.Publish(BND_REGULAR_BG_VISIBILITY, o.isDeterminationPackKillSwitchOn)
  end)
  o.im.Subscribe(BND_LEAGUE_LIST_INDEX, function()
    o:publishLeagueIndex()
  end)
  o.im.Subscribe(BND_LEAGUE_LIST_TOGGLE, function()
    o:publishLeagueToggle()
  end)
  o.im.Subscribe(BND_TEAM_LIST_INDEX, function()
    o:publishTeamIndex()
  end)
  o.im.Subscribe(BND_TEAM_LIST_TOGGLE, function()
    o:publishTeamToggle()
  end)
  o.im.Subscribe(BND_TEAM_STAR_RATING, function()
    o:publishTeamStarRating()
  end)
  o.im.Subscribe(BND_TEAM_RATING, function()
    o:publishTeamRating()
  end)
  o.defaultCellData = {
    label = "",
    image = {},
    id = -1
  }
  o.im.Subscribe(BND_DEFAULT_CELL_DATA, function()
    o.im.Publish(BND_DEFAULT_CELL_DATA, o.defaultCellData)
  end)
  o.im.RegisterAction(ACT_CONFIRM, function(actionName, data)
    o.im.ChangeActionState(ACT_SELECT_LEAGUE, o.im.GetActionState("INVALID"))
    o.im.ChangeActionState(ACT_SELECT_TEAM, o.im.GetActionState("INVALID"))
    o.im.ChangeActionState(ACT_SELECTOR_CANCEL, o.im.GetActionState("INVALID"))
    o.im.ChangeActionState(ACT_CHANGE, o.im.GetActionState("INVALID"))
    o.im.ChangeActionState(ACT_CONFIRM, o.im.GetActionState("INVALID"))
    o.services.FUTUserInfoService.SetUserFavoriteTeam(o.currentTeamID)
  end)
  o.im.RegisterAction(ACT_SELECTOR_CANCEL, function()
    o:onSelectorCancel()
  end)
  o.im.RegisterDataAction(BND_LEAGUE_LIST_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    index = index + 1
    o.leaguesDataToPublish.data[o.leagueIndex].selected = false
    o.leaguesDataToPublish.data[index].selected = true
    o.leaguesDataToPublish.index = index
    o:setSelectedLeagueIndex(index)
    o.im.Refresh(BND_LEAGUE_LIST)
    o.im.Refresh(BND_TEAM_LIST_TOGGLE)
  end)
  o.im.RegisterDataAction(BND_TEAM_LIST_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    index = index + 1
    o.teamsDataToPublish.data[o.teamIndex].selected = false
    o.teamsDataToPublish.data[index].selected = true
    o.teamsDataToPublish.index = index
    o:setSelectedTeamIndex(index)
    o.im.Refresh(BND_TEAM_LIST)
  end)
  o.buttonsID = { TEAM_H, COUNTRY_H, LEAGUE_H}
  o:HideSelections()
  o.im.Publish(BND_HOME_COUNTRY_SELECT_VISIBLE, true)
  o.im.Subscribe(BND_HOME_COUNTRY_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe(BND_HOME_TEAM_SELECT_VISIBLE, function()
  end)
  o.im.Subscribe(BND_HOME_LEAGUE_SELECT_VISIBLE, function()
  end)
  o.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)
    o:HideSelections()
    if o.buttonsID[data.buttonID + 1] == COUNTRY_H then
      o.im.Publish(BND_HOME_COUNTRY_SELECT_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == TEAM_H then
      o.im.Publish(BND_HOME_TEAM_SELECT_VISIBLE, true)
    elseif o.buttonsID[data.buttonID + 1] == LEAGUE_H then
      o.im.Publish(BND_HOME_LEAGUE_SELECT_VISIBLE, true)
    end
  end)
  
  if automation then
    print("FTFSelectLeagueTeam automation exists")
    automation.Add("FTFSelectLeagueTeam", {
      FTFSelectLeagueTeam = function(currentTeamID)
        o:_juiceSelectLeagueTeam(currentTeamID)
      end
    })
  end
  return o
end

function SelectLeagueTeam:initLeagueCountryMapping()
    self.leagueCountryMap = {
        [14] = "England",   -- Premier League
        [21] = "Germany",   -- Bundesliga
        [18] = "France",   -- Ligue 1
        [27] = "Italy",     -- Serie A
        [45] = "Spain",    -- La Liga
        [54] = "Brazil",    -- La Liga
        [7] = "Portugal",    -- La Liga
        [95] = "America",    -- La Liga
        
        -- Tambahkan mapping lainnya sesuai kebutuhan
    }
end

---- THANKS FOR ALL MODDER --
---- IMPROVED BY MOUNTSA ----
function SelectLeagueTeam:initStadiumDatabase()
    self.stadiumDatabase = {
-- Premier league --
    [1] = "Emirates Stadium",                 -- Arsenal
    [2] = "Villa Park",                       -- Aston Villa
    [3] = "Ewood Park",                       -- Blackburn Rovers
    [4] = "Reebok Stadium",                   -- Bolton Wanderers
    [5] = "Stamford Bridge",                  -- Chelsea
    [7] = "Goodison Park",                    -- Everton
    [9] = "Anfield",                          -- Liverpool
    [10] = "Etihad Stadium",                  -- Manchester City
    [11] = "Old Trafford",                    -- Manchester United
    [12] = "Riverside Stadium",              -- Middlesbrough
    [13] = "St. James' Park",                 -- Newcastle United
    [14] = "City Ground",                     -- Nottingham Forest
    [15] = "Loftus Road",                     -- Queens Park Rangers
    [17] = "St. Mary's Stadium",              -- Southampton
    [18] = "White Hart Lane",                 -- Tottenham Hotspur
    [19] = "Boleyn Ground (Upton Park)",      -- West Ham United
    [88] = "St. Andrew's",                    -- Birmingham City
    [94] = "Portman Road",                    -- Ipswich Town
    [95] = "King Power Stadium",              -- Leicester City
    [106] = "Stadium of Light",               -- Sunderland
    [109] = "The Hawthorns",                  -- West Bromwich Albion
    [110] = "Molineux Stadium",               -- Wolverhampton Wanderers
    [5] = "Stamford Bridge",           -- Chelsea
    [9] = "Anfield",                   -- Liverpool
    [10] = "Etihad Stadium",           -- Manchester City
    [11] = "Old Trafford",             -- Manchester United
    [18] = "Tottenham Hotspur Stadium", -- Tottenham Hotspur
    [19] = "London Stadium",           -- West Ham United
    [95] = "King Power Stadium",       -- Leicester City
    [110] = "Molineux Stadium",        -- Wolverhampton Wanderers
    [1795] = "Vicarage Road",          -- Watford
    [1796] = "Turf Moor",              -- Burnley
    [1799] = "Selhurst Park",          -- Crystal Palace
    [1808] = "American Express Stadium", -- Brighton & Hove Albion
    [1943] = "Vitality Stadium",       -- AFC Bournemouth
    [1960] = "Swansea.com Stadium",    -- Swansea City
    [1961] = "Cardiff City Stadium",   -- Cardiff City
    [335] = "King Power Stadium",      -- Leicester City (alternative ID)
    [340] = "American Express Stadium",-- Brighton (alternative ID)
    [355] = "London Stadium",          -- West Ham (alternative ID)
    [409] = "Tottenham Hotspur Stadium",-- Spurs (alternative ID)
    [432] = "Elland Road",             -- Leeds United
    [433] = "Bramall Lane",            -- Sheffield United
    [450] = "Gtech Community Stadium", -- Brentford
    [460] = "Kenilworth Road",         -- Luton Town
    [494] = "RAMS Park",               -- AFC Bournemouth (alternative)
    [326] = "Stadium of Light",        -- Sunderland
    [327] = "The Hawthorns",           -- West Bromwich Albion
    [328] = "Craven Cottage",          -- Fulham
    [329] = "Carrow Road",             -- Norwich City
    [330] = "Selhurst Park",           -- Crystal Palace (alternative)
    [336] = "Turf Moor",               -- Burnley (alternative)
    [337] = "MATRADE Loftus Road",     -- QPR
    [347] = "Vicarage Road",           -- Watford (alternative)
    [348] = "Vitality Stadium",        -- Bournemouth (alternative)
    [349] = "Riverside Stadium",       -- Middlesbrough
    [350] = "Portman Road",            -- Ipswich Town
    [364] = "Cívitas Metropolitano",   -- (Note: This is actually Atletico Madrid's stadium - likely incorrect mapping)
-- Premier League Teams (2023/24)
    [13] = "St. James' Park",           -- Newcastle United
    [14] = "The City Ground",           -- Nottingham Forest
    [17] = "St. Mary's Stadium",        -- Southampton
    [94] = "Portman Road",              -- Ipswich Town
    [144] = "Craven Cottage",           -- Fulham
    [7] = "Goodison Park",              -- Everton
-- La Liga 2023/24 Teams with Stadiums
    [240] = "Cívitas Metropolitano",       -- Atlético de Madrid
    [241] = "Spotify Camp Nou",            -- FC Barcelona
    [243] = "Estadio Santiago Bernabéu",   -- Real Madrid
    [448] = "San Mamés",                   -- Athletic Club
    [449] = "Estadio Benito Villamarín",   -- Real Betis
    [450] = "Abanca-Balaídos",             -- Celta Vigo
    [452] = "RCDE Stadium",                -- Espanyol
    [453] = "Visit Mallorca Estadi",       -- Mallorca
    [456] = "El Molinón",                  -- Sporting Gijón (Segunda División)
    [457] = "Reale Arena",                 -- Real Sociedad
    [459] = "Estadio Municipal de Butarque", -- Leganés (Segunda)
    [461] = "Estadio Mestalla",            -- Valencia CF
    [462] = "Estadio José Zorrilla",       -- Real Valladolid (Segunda)
    [463] = "Mendizorrotza",               -- Alavés
    [467] = "Ipurua",                      -- Eibar (Segunda)
    [468] = "Martínez Valero",             -- Elche (Segunda)
    [472] = "Estadio Gran Canaria",        -- Las Palmas
    [479] = "El Sadar",                    -- Osasuna
    [480] = "Estadio de Vallecas",         -- Rayo Vallecano
    [481] = "Ramón Sánchez-Pizjuán",       -- Sevilla FC
    [483] = "Estadio de la Cerámica",      -- Villarreal CF
    [1853] = "Estadio Ciudad de Valencia", -- Levante (Segunda)
    [1860] = "Coliseum Alfonso Pérez",     -- Getafe
    [1861] = "Power Horse Stadium",        -- Almería
    [386] = "Estadio de la Cerámica",      -- Villarreal (alternative ID)
    [388] = "San Mamés",                   -- Athletic Bilbao (alternative ID)
    [389] = "Ramón Sánchez-Pizjuán",       -- Sevilla (alternative ID)
    [390] = "Coliseum Alfonso Pérez",      -- Getafe (alternative ID)
    [392] = "Estadio Benito Villamarín",   -- Betis (alternative ID)
    [394] = "Abanca-Balaídos",             -- Celta Vigo (alternative ID)
    [396] = "Estadio Ciutat de València",  -- Levante (alternative)
    [397] = "Reale Arena",                 -- Real Sociedad (alternative)
    [400] = "Estadio Montilivi",           -- Girona
    [427] = "Estadio José Zorrilla",       -- Valladolid (alternative)
    [428] = "Estadio El Alcoraz",          -- Huesca (Segunda)
    [429] = "Estadio de Vallecas",         -- Rayo Vallecano (alternative)
    [437] = "El Sadar",                    -- Osasuna (alternative)
    [440] = "Visit Mallorca Estadi",       -- Mallorca (alternative)
    [455] = "Nuevo Mirandilla",            -- Cádiz CF
    [110062] = "Estadio Montilivi",        -- Girona (alternative ID)
    [110832] = "Nuevo Los Cármenes",       -- Granada CF
    [110839] = "El Alcoraz",               -- SD Huesca (Segunda)
    [1968] = "Nuevo Mirandilla",           -- Cádiz (alternative ID)
-- Bundesliga 2023/24 Teams with Stadiums
    [21] = "Allianz Arena",               -- FC Bayern München
    [22] = "Signal Iduna Park",           -- Borussia Dortmund
    [23] = "Borussia-Park",               -- Borussia Mönchengladbach
    [25] = "Europa-Park Stadion",         -- SC Freiburg
    [32] = "BayArena",                    -- Bayer 04 Leverkusen
    [34] = "VELTINS-Arena",               -- FC Schalke 04 (currently in 2. Bundesliga)
    [36] = "MHPArena",                    -- VfB Stuttgart
    [38] = "Weserstadion",                -- SV Werder Bremen
    [160] = "Vonovia Ruhrstadion",        -- VfL Bochum
    [165] = "Sportpark Ronhof",           -- Greuther Fürth (2. Bundesliga)
    [166] = "Olympiastadion Berlin",      -- Hertha BSC (2. Bundesliga)
    [169] = "MEWA Arena",                 -- 1. FSV Mainz 05
    [171] = "Max-Morlock-Stadion",        -- 1. FC Nürnberg (2. Bundesliga)
    [175] = "Volkswagen Arena",           -- VfL Wolfsburg
    [10029] = "PreZero Arena",            -- TSG Hoffenheim
    [10030] = "Home Deluxe Arena",        -- SC Paderborn 07 (2. Bundesliga)
    [110500] = "Eintracht-Stadion",       -- Eintracht Braunschweig (2. Bundesliga)
    [110502] = "Merck-Stadion am Böllenfalltor", -- SV Darmstadt 98
    [110588] = "MDCC-Arena",              -- 1. FC Magdeburg (2. Bundesliga)
    [110636] = "Merkur Spiel-Arena",      -- Fortuna Düsseldorf (2. Bundesliga)
    [110645] = "Sportpark Höhenberg",     -- Viktoria Köln (3. Liga)
    [110676] = "Stadion Rote Erde",       -- Borussia Dortmund II (3. Liga)
    [111235] = "Voith-Arena",             -- 1. FC Heidenheim
    [112172] = "Red Bull Arena",          -- RB Leipzig
    [343] = "Borussia-Park",              -- Borussia M'gladbach (alternative ID)
    [406] = "Volkswagen Arena",           -- Wolfsburg (alternative ID)
    [407] = "PreZero Arena",              -- Hoffenheim (alternative ID)
    [412] = "WWK Arena",                  -- FC Augsburg
    [413] = "Weserstadion",               -- Werder Bremen (alternative ID)
    [414] = "MEWA Arena",                 -- Mainz 05 (alternative ID)
    [416] = "Deutsche Bank Park",         -- Eintracht Frankfurt
    [417] = "Heinz von Heiden-Arena",     -- Hannover 96 (2. Bundesliga)
    [418] = "MHPArena",                   -- Stuttgart (alternative ID)
    [420] = "Red Bull Arena",             -- RB Leipzig (alternative ID)
    [422] = "Max-Morlock-Stadion",        -- Nürnberg (alternative ID)
    [423] = "RheinEnergieStadion",        -- 1. FC Köln
    [454] = "SchücoArena",                -- Arminia Bielefeld (2. Bundesliga)
    [473] = "Vonovia Ruhrstadion",        -- Bochum (alternative ID)
    [474] = "Sportpark Ronhof",           -- Fürth (alternative ID)
    [485] = "HDI-Arena",                  -- Hannover 96
    [100409] = "WWK Arena",               -- Augsburg (alternative ID)
-- Serie A 2023/2024 Teams with Stadiums
    [45] = "Allianz Stadium",            -- Juventus
    [48] = "Diego Armando Maradona",     -- Napoli
    [50] = "Stadio Ennio Tardini",       -- Parma (Serie B)
    [52] = "Stadio Olimpico",            -- Roma
    [54] = "Stadio Olimpico Grande Torino", -- Torino
    [55] = "Dacia Arena",                -- Udinese
    [1842] = "Unipol Domus",             -- Cagliari
    [1843] = "Stadio Renzo Barbera",     -- Palermo (Serie B)
    [1848] = "Stadio San Nicola",        -- Bari (Serie B)
    [110373] = "Stadio Arechi",          -- Salernitana
    [110374] = "Stadio Artemio Franchi", -- Fiorentina
    [110556] = "Luigi Ferraris",         -- Genoa
    [111657] = "Stadio Benito Stirpe",   -- Frosinone
    [111811] = "U-Power Stadium",        -- Monza
    [111974] = "Mapei Stadium",          -- Sassuolo
    [113973] = "Stadio Mario Rigamonti", -- Brescia (Serie B)
    [113974] = "Stadio Alberto Picco",   -- Spezia (Serie B)
    [116280] = "Allianz Stadium",        -- Juventus (alternative ID)
    [116282] = "Stadio Olimpico",        -- Roma (alternative ID)
    [110738] = "Arena Garibaldi",        -- Pisa (Serie B)
    [110740] = "Stadio Città del Tricolore", -- Reggiana (Serie B)
    [131720] = "Stadio Via del Mare",    -- Lecce
    [131724] = "Stade de la Meinau",     -- Strasbourg (Ligue 1, contoh cross-league)
    [131733] = "Stadio Carlo Castellani", -- Empoli
    [131447] = "Parc des Princes",       -- Paris SG (contoh cross-league)
    [111434] = "Stadio Giovanni Zini",   -- Cremonese (Serie B)
    [111993] = "Stadio Piercesare Tombolato", -- Cittadella (Serie B)
    [112168] = "Stadio San Vito",        -- Cosenza (Serie B)
    [112494] = "Stadio Druso",           -- Südtirol (Serie B)
    [113616] = "Stadio Franz Fekete",    -- Grazer AK (Austria, contoh cross-league)
    [190] = "San Siro (Giuseppe Meazza)",  -- Inter Milan
    [194] = "San Siro (Giuseppe Meazza)",  -- AC Milan
-- Ligue 1 2023/24 Teams with Stadiums
    [57] = "Stade de l'Abbé-Deschamps",       -- AJ Auxerre
    [65] = "Decathlon Arena",                 -- LOSC Lille
    [66] = "Groupama Stadium",                 -- Olympique Lyonnais
    [69] = "Stade Louis II",                   -- AS Monaco
    [70] = "Stade de la Mosson",               -- Montpellier HSC
    [71] = "Stade de la Beaujoire",            -- FC Nantes
    [72] = "Allianz Riviera",                  -- OGC Nice
    [73] = "Parc des Princes",                 -- Paris Saint-Germain
    [74] = "Roazhon Park",                     -- Stade Rennais
    [76] = "Stade de la Meinau",               -- Strasbourg
    [217] = "Stade du Moustoir",               -- FC Lorient
    [219] = "Orange Vélodrome",                -- Olympique de Marseille
    [294] = "Stade de l'Aube",                 -- ESTAC Troyes
    [378] = "Stade Francis-Le Blé",            -- Stade Brestois
    [379] = "Stade Auguste-Delaune",           -- Stade de Reims
    [116034] = "Parc des Princes",             -- Paris SG (alternative ID)
    [116035] = "Stade Charléty",               -- Paris FC (Ligue 2)
    [116037] = "Stade de la Mosson",           -- Montpellier (alternative ID)
    [116039] = "Stade Gaston-Gérard",          -- Dijon FCO (Ligue 2)
    [116040] = "Stade Auguste-Delaune",        -- Reims (alternative ID)
    [116044] = "Stade Geoffroy-Guichard",      -- AS Saint-Étienne (Ligue 2)
    [1530] = "Stade Raymond-Kopa",             -- Angers SCO (Ligue 2)
    [1738] = "Stade Océane",                   -- Le Havre AC
    [1809] = "Stadium de Toulouse",            -- Toulouse FC
    [1815] = "Stade Gabriel-Montpied",         -- Clermont Foot
    [1816] = "Stade de la Licorne",            -- Amiens SC (Ligue 2)
    [1819] = "Stade Geoffroy-Guichard",        -- AS Saint-Étienne
    [111817] = "Stade Charléty",               -- Paris FC (alternative ID)
    [111276] = "Stade Marcel-Tribut",          -- USL Dunkerque (Ligue 2)
    [131447] = "Parc des Princes",             -- Paris SG (cross-reference)
-- Brasileirão Série A 2024 Teams with Stadiums
    [383] = "Allianz Parque",                  -- Palmeiras
    [517] = "Estádio Nilton Santos",           -- Botafogo
    [567] = "Maracanã",                        -- Fluminense
    [568] = "Mineirão",                        -- Cruzeiro
    [598] = "Morumbi",                         -- São Paulo
    [1013] = "Estádio Pedro Bidegain",         -- San Lorenzo (Argentina, but in your list)
    [1035] = "Arena MRV",                      -- Atlético Mineiro
    [1039] = "Arena da Baixada",               -- Athletico Paranaense
    [1041] = "Neo Química Arena",              -- Corinthians
    [1043] = "Maracanã",                       -- Flamengo
    [1048] = "Beira-Rio",                      -- Internacional
    [1629] = "Arena do Grêmio",                -- Grêmio
    [112472] = "Estádio Nabi Abi Chedid",      -- RB Bragantino
    [115530] = "Arena Pantanal",               -- Cuiabá
    [111052] = "Castelão (CE)",                -- Fortaleza
    [101100] = "Atanasio Girardot",            -- Atlético Nacional (Colombia, in your list)
    [101101] = "Metropolitano Roberto Meléndez", -- Junior (Colombia, in your list)
    [101105] = "El Campín",                    -- Millonarios (Colombia, in your list)
    [110968] = "Estádio Hernando Siles",       -- Bolívar (Bolivia, in your list)
    [110975] = "Estádio San Carlos de Apoquindo", -- Universidad Católica (Chile, in your list)
    [110980] = "Estádio Monumental",           -- Colo-Colo (Chile, in your list)
    [110986] = "Estádio Rodrigo Paz Delgado",  -- LDU Quito (Ecuador, in your list)
    [112540] = "Estádio do Pacaembu",          -- (Note: Currently not used as main stadium)
    [112996] = "Allianz Parque",               -- (Alternative for Palmeiras)
-- AFC Teams (Top Asian Leagues) with Stadiums
    [605] = "King Fahd International Stadium",  -- Al Hilal (Saudi Arabia)
    [607] = "King Abdullah Sports City",       -- Al Ittihad (Saudi Arabia)
    [980] = "Daejeon World Cup Stadium",       -- Daejeon Hana Citizen (South Korea)
    [982] = "Seoul World Cup Stadium",         -- FC Seoul (South Korea)
    [111674] = "Prince Faisal bin Fahd Stadium", -- Al Shabab (Saudi Arabia)
    [112139] = "Mrsool Park",                  -- Al Nassr (Saudi Arabia)
    [112387] = "King Abdullah Sports City",    -- Al Ahli (Saudi Arabia)
    [112390] = "Prince Abdul Aziz bin Musa'ed", -- Al Fateh (Saudi Arabia)
    [112392] = "King Abdullah Sport City",     -- Al Raed (Saudi Arabia)
    [112393] = "King Abdullah Sport City",     -- Al Taawoun (Saudi Arabia)
    [112408] = "King Abdulaziz Stadium",       -- Al Wehda (Saudi Arabia)
    [113037] = "Prince Turki bin Abdul Aziz",  -- Al Riyadh (Saudi Arabia)
    [113217] = "Prince Sultan bin Abdul Aziz", -- Damac FC (Saudi Arabia)
    [1473] = "Ulsan Munsu Football Stadium",   -- Ulsan Hyundai (South Korea)
    [1474] = "Pohang Steel Yard",              -- Pohang Steelers (South Korea)
    [1477] = "Jeonju World Cup Stadium",       -- Jeonbuk Hyundai (South Korea)
    [1478] = "Jeju World Cup Stadium",         -- Jeju United (South Korea)
    [2055] = "Gimcheon Stadium",               -- Gimcheon Sangmu (South Korea)
    [2056] = "DGB Daegu Bank Park",            -- Daegu FC (South Korea)
    [112258] = "Gwangju Football Stadium",     -- Gwangju FC (South Korea)
    [112558] = "Suwon Sports Complex",         -- Suwon FC (South Korea)
    [111701] = "Hazza bin Zayed Stadium",      -- Al Ain FC (UAE)
    [111724] = "Jinan Olympic Stadium",        -- Shandong Taishan (China)
    [111768] = "Workers' Stadium",             -- Beijing Guoan (China)
    [111769] = "Changchun Stadium",            -- Changchun Yatai (China)
    [111774] = "Tianjin Olympic Center",       -- Tianjin Jinmen Tiger (China)
    [111779] = "Zhengzhou Hanghai Stadium",    -- Henan FC (China)
    [112540] = "Shanghai Stadium",             -- Shanghai Port (China)
    [112979] = "Rugao Olympic Sports Center",  -- Nantong Zhiyun (China)
    [112985] = "Cangzhou Stadium",             -- Cangzhou Mighty Lions (China)
    [113298] = "Fatorda Stadium",              -- FC Goa (India)
    [113299] = "Jawaharlal Nehru Stadium",     -- Kerala Blasters (India)
    [113300] = "Mumbai Football Arena",        -- Mumbai City FC (India)
    [113301] = "GMC Balayogi Stadium",         -- Hyderabad FC (India)
    [113302] = "Sree Kanteerava Stadium",      -- Bengaluru FC (India)
    [113146] = "Salt Lake Stadium",            -- Mohun Bagan SG (India)
    [115202] = "Tau Devi Lal Stadium",         -- Punjab FC (India)
    [111629] = "Salt Lake Stadium",            -- East Bengal (India)
    [111633] = "Salt Lake Stadium",            -- Mohammedan SC (India)
    [918] = "Aspmyra Stadion",                 -- Bodø/Glimt (Norway, but in AFC CL)
    [919] = "Brann Stadion",                   -- SK Brann (Norway, but in AFC CL)
    [922] = "Marienlyst Stadion",              -- Strømsgodset (Norway, but in AFC CL)
-- Liga 1 Indonesia 2023/2024
    [20001] = "Gelora Bung Karno",          -- Persija Jakarta
    [20002] = "Kanjuruhan",                 -- Arema FC
    [20003] = "Gelora Bandung Lautan Api",  -- Persib Bandung
    [20004] = "Kapten I Wayan Dipta",       -- Bali United
    [20005] = "Gelora Bung Tomo",           -- Persebaya Surabaya
    [20006] = "Maguwoharjo",                -- PSS Sleman
    [20007] = "Patriot Candrabhaga",        -- Borneo FC
    [20008] = "Segiri",                     -- Persis Solo
    [20009] = "Gelora Sriwijaya",           -- Sriwijaya FC
    [20010] = "Batakan",                    -- Barito Putera
    [20011] = "Gelora Delta",               -- Persikabo 1973
    [20012] = "Wibawa Mukti",               -- Persik Kediri
    [20013] = "Sultan Agung",               -- PSIS Semarang
    [20014] = "Manahan",                    -- Persis Solo (alternate)
    [20015] = "Pakansari",                  -- Persita Tangerang
    [20016] = "Gelora Joko Samudro",        -- Gresik United
    [20017] = "Si Jalak Harupat",           -- Persib (alternate)
    [20018] = "Gelora Bumi Kartini",        -- Persijap Jepara
    [20019] = "Aji Imbut",                  -- Persis Putra Samarinda
    [20020] = "Gelora Supriyadi",           -- Persela Lamongan
    [20021] = "Merdeka",                    -- PSMS Medan
    [20022] = "Gelora 10 November",         -- Persela (alternate)
    [20023] = "Gelora Bung Karno Madya",    -- Shared venue
    [20024] = "Haji Agus Salim",            -- PSPS Pekanbaru
    [20025] = "Gelora Bumi Kartini",        -- Multi-use

    [245] = "Johan Cruijff ArenA",          -- Ajax
    [246] = "De Kuip",                      -- Feyenoord
    [247] = "Philips Stadion",              -- PSV Eindhoven
    [1903] = "Stadion Galgenwaard",         -- FC Utrecht
    [1904] = "Rat Verlegh Stadion",         -- NAC Breda
    [1905] = "Mandemakers Stadion",         -- RKC Waalwijk
    [1906] = "AFAS Stadion",                -- AZ Alkmaar
    [1907] = "Koning Willem II Stadion",    -- Willem II
    [1908] = "De Grolsch Veste",            -- FC Twente
    [1910] = "Goffertstadion",              -- NEC Nijmegen
    [1913] = "Abe Lenstra Stadion",         -- sc Heerenveen
    [1914] = "MAC³PARK Stadion",            -- PEC Zwolle
    [1915] = "Euroborg",                    -- FC Groningen
    [100632] = "De Adelaarshorst",          -- Go Ahead Eagles
    [100634] = "Erve Asito",                -- Heracles Almelo
    [100646] = "Het Kasteel",               -- Sparta Rotterdam
    [111380] = "Yanmar Stadion",            -- Almere City FC

    [234] = "Estádio da Luz",               -- Benfica
    [236] = "Estádio do Dragão",            -- FC Porto
    [237] = "Estádio José Alvalade",        -- Sporting CP
    [10020] = "Estádio António Coimbra da Mota", -- Estoril Praia
    [1887] = "Estádio D. Afonso Henriques", -- Vitória SC
    [1888] = "Estádio Cidade de Barcelos",  -- Gil Vicente
    [1891] = "Estádio da Madeira",          -- Nacional
    [1896] = "Estádio Municipal de Braga",  -- SC Braga
    [1898] = "Estádio do Bessa",            -- Boavista
    [1900] = "Parque de Jogos Comendador Joaquim de Almeida Freitas", -- Moreirense
    [112513] = "Estádio Municipal de Arouca", -- Arouca
    [114510] = "Estádio Pina Manique",      -- Casa Pia
    [112809] = "Estádio Municipal 22 de Junho", -- Famalicão
    [131358] = "Estádio da Luz",            -- Benfica (alternative ID)
    [131463] = "Estádio do Vizela",        -- Vizela
        -- Belgian Pro League --
    [229] = "Constant Vanden Stock",       -- Anderlecht
    [230] = "Bosuilstadion",               -- Antwerp
    [231] = "Jan Breydel Stadion",         -- Club Brugge
    [232] = "Stade Maurice Dufrasne",      -- Standard Liège
    [100081] = "Guldensporenstadion",      -- Kortrijk
    [100087] = "King Power at Den Dreef",  -- OH Leuven
    [670] = "Stade du Pays de Charleroi",  -- Charleroi
    [673] = "Cegeka Arena",                -- Genk
    [674] = "Ghelamco Arena",              -- Gent
    [675] = "Olympisch Stadion",           -- Beerschot
    [680] = "Stayen",                      -- STVV
    [681] = "Het Kuipje",                  -- Westerlo
    [110724] = "AFAS Stadion",             -- Mechelen

        -- MLS (USA/Canada) --
    [687] = "Lower.com Field",             -- Columbus Crew
    [688] = "Audi Field",                  -- DC United
    [689] = "Red Bull Arena",              -- NY Red Bulls
    [691] = "Gillette Stadium",            -- New England Revolution
    [693] = "Soldier Field",               -- Chicago Fire
    [694] = "Dick's Sporting Goods Park",  -- Colorado Rapids
    [695] = "Toyota Stadium",              -- FC Dallas
    [696] = "Children's Mercy Park",       -- Sporting KC
    [697] = "Dignity Health Sports Park",  -- LA Galaxy
    [698] = "Shell Energy Stadium",        -- Houston Dynamo
    [111112] = "BC Place",                 -- Vancouver Whitecaps
    [111138] = "Allianz Field",            -- Minnesota United
    [111139] = "Saputo Stadium",           -- CF Montréal
    [111140] = "Providence Park",          -- Portland Timbers
    [111144] = "Lumen Field",              -- Seattle Sounders
    [111651] = "BMO Field",                -- Toronto FC
    [112828] = "Yankee Stadium",           -- NYCFC
    [112885] = "Mercedes-Benz Stadium",    -- Atlanta United
    [112893] = "DRV PNK Stadium",          -- Inter Miami
    [112996] = "Banc of California",       -- LAFC
    [113018] = "CityPark",                 -- St. Louis CITY
    [114161] = "Q2 Stadium",               -- Austin FC
    [114162] = "Geodis Park",              -- Nashville SC

        -- Turkish Süper Lig --
    [325] = "Nef Stadyumu",                -- Galatasaray
    [326] = "Ülker Stadyumu",              -- Fenerbahçe
    [327] = "Vodafone Park",               -- Beşiktaş
    [436] = "Medical Park Stadyumu",       -- Trabzonspor
    [741] = "Antalya Stadyumu",            -- Antalyaspor
    [748] = "19 Mayıs Stadyumu",           -- Samsunspor
    [495] = "Başakşehir Fatih Terim",     -- İstanbul Başakşehir
    [101014] = "Başakşehir Fatih Terim",  -- Başakşehir (alt)
    [101016] = "Yeni Adana Stadyumu",      -- Adana Demirspor
    [101020] = "Kadir Has Stadyumu",       -- Kayserispor
    [101028] = "Yeni Hatay Stadyumu",      -- Hatayspor
    [101033] = "Konya Büyükşehir",        -- Konyaspor
    [101041] = "Yeni 4 Eylül Stadyumu",    -- Sivasspor
    [111339] = "Recep Tayyip Erdoğan",    -- Kasımpaşa
    [131174] = "Eyüp Stadyumu",            -- Eyüpspor

        -- Liga MX (Mexico) --
    [1386] = "Estadio Azteca",             -- América
    [517] = "Estadio Olímpico Universitario", -- UNAM
    [101099] = "Estadio Azteca",           -- América (alt)
    [112908] = "Estadio Akron",            -- Guadalajara
    [113010] = "Estadio BBVA",             -- Monterrey
    [113029] = "Estadio Olímpico UCV",     -- UCV
    [1386] = "Estadio Jalisco",            -- Atlas
    [1386] = "Estadio Corona",             -- Santos Laguna
    [1386] = "Estadio Cuauhtémoc",         -- Puebla
    [1386] = "Estadio Victoria",           -- Necaxa
    [1386] = "Estadio Hidalgo",            -- Pachuca
    [1386] = "Estadio Caliente",           -- Tijuana
    [1386] = "Estadio Universitario",      -- Tigres
    [1386] = "Estadio Morelos",            -- Morelia
    [1386] = "Estadio León",               -- León
    [1386] = "Estadio Azul"             -- Cruz Azul
    }
end
function SelectLeagueTeam:initTrophyDatabase()
    self.trophyDatabase = {
                -- 🔹 Spain Primera + Segunda (2025/26)
        [1860]   = {leagues = 0, cups = 0, ucl = 0, founded = 1983},   -- Getafe CF
        [449]    = {leagues = 1, cups = 3, ucl = 0, founded = 1907},   -- Real Betis Balompié
        [457]    = {leagues = 2, cups = 3, ucl = 0, founded = 1909},   -- Real Sociedad
        [243]    = {leagues = 36, cups = 20, ucl = 15, founded = 1902},-- Real Madrid
        [461]    = {leagues = 6, cups = 8, ucl = 0, founded = 1919},   -- Valencia CF
        [240]    = {leagues = 11, cups = 10, ucl = 0, founded = 1903}, -- Atlético de Madrid
        [241]    = {leagues = 28, cups = 32, ucl = 5, founded = 1899}, -- FC Barcelona
        [453]    = {leagues = 0, cups = 1, ucl = 0, founded = 1916},   -- RCD Mallorca
        [448]    = {leagues = 8, cups = 24, ucl = 0, founded = 1898},  -- Athletic Club de Bilbao
        [450]    = {leagues = 0, cups = 1, ucl = 0, founded = 1923},   -- RC Celta de Vigo
        [472]    = {leagues = 0, cups = 0, ucl = 0, founded = 1949},   -- UD Las Palmas
        [483]    = {leagues = 0, cups = 1, ucl = 0, founded = 1923},   -- Villarreal CF
        [110062] = {leagues = 0, cups = 0, ucl = 0, founded = 1930},  -- Girona FC
        [481]    = {leagues = 1, cups = 5, ucl = 0, founded = 1890},   -- Sevilla FC
        [479]    = {leagues = 0, cups = 0, ucl = 0, founded = 1920},   -- CA Osasuna
        [100888] = {leagues = 0, cups = 0, ucl = 0, founded = 1928},  -- CD Leganés
        [462]    = {leagues = 1, cups = 2, ucl = 0, founded = 1928},   -- Real Valladolid
        [463]    = {leagues = 0, cups = 1, ucl = 0, founded = 1921},   -- Deportivo Alavés
        [480]    = {leagues = 0, cups = 1, ucl = 0, founded = 1924},   -- Rayo Vallecano
        [452]    = {leagues = 0, cups = 4, ucl = 0, founded = 1900},   -- RCD Espanyol

        [467]    = {leagues = 0, cups = 0, ucl = 0, founded = 1940},   -- SD Eibar
        [456]    = {leagues = 0, cups = 0, ucl = 0, founded = 1913},   -- Racing de Santander
        [1861]   = {leagues = 0, cups = 0, ucl = 0, founded = 1989},   -- UD Almería
        [110827] = {leagues = 0, cups = 0, ucl = 0, founded = 1926},  -- Real Oviedo
        [110839] = {leagues = 0, cups = 0, ucl = 0, founded = 1960},  -- SD Huesca
        [1854]   = {leagues = 0, cups = 0, ucl = 0, founded = 1940},  -- Albacete Balompié
        [1853]   = {leagues = 0, cups = 0, ucl = 0, founded = 1909},  -- Levante UD
        [459]    = {leagues = 0, cups = 0, ucl = 0, founded = 1905},  -- Real Sporting de Gijón
        [260]    = {leagues = 0, cups = 0, ucl = 0, founded = 1912},  -- CD Tenerife
        [110069] = {leagues = 0, cups = 0, ucl = 0, founded = 1927},  -- CD Mirandés
        [573]    = {leagues = 0, cups = 1, ucl = 0, founded = 1948},  -- Málaga CF
        [100851] = {leagues = 0, cups = 0, ucl = 0, founded = 1995},  -- FC Cartagena
        [10846]  = {leagues = 0, cups = 0, ucl = 0, founded = 1936},  -- Burgos CF
        [244]    = {leagues = 0, cups = 6, ucl = 0, founded = 1932},  -- Real Zaragoza
        [110832] = {leagues = 0, cups = 2, ucl = 0, founded = 1931},  -- Granada CF
        [468]    = {leagues = 0, cups = 0, ucl = 0, founded = 1923},  -- Elche CF
        [1968]   = {leagues = 0, cups = 0, ucl = 0, founded = 1910},  -- Cádiz CF
        [242]    = {leagues = 1, cups = 2, ucl = 0, founded = 1906},  -- RC Deportivo La Coruña
        [1867]   = {leagues = 0, cups = 0, ucl = 0, founded = 1954},  -- Córdoba CF
        [100852] = {leagues = 0, cups = 0, ucl = 0, founded = 1922},  -- CD Castellón
        [110242] = {leagues = 0, cups = 0, ucl = 0, founded = 1919},  -- Racing de Ferrol
        [121110] = {leagues = 0, cups = 0, ucl = 0, founded = 1921},  -- CD Eldense

        -- 🔹 Premier League (2025/26)
        [13]   = {leagues = 4,  cups = 6,  ucl = 0, founded = 1892},  -- Newcastle United
        [1925] = {leagues = 0,  cups = 0,  ucl = 0, founded = 1889},  -- Brentford
        [14]   = {leagues = 1,  cups = 2,  ucl = 2, founded = 1865},  -- Nottingham Forest
        [110]  = {leagues = 3,  cups = 4,  ucl = 0, founded = 1877},  -- Wolverhampton Wanderers
        [18]   = {leagues = 2,  cups = 8,  ucl = 0, founded = 1882},  -- Tottenham Hotspur
        [19]   = {leagues = 0,  cups = 4,  ucl = 0, founded = 1895},  -- West Ham United
        [5]    = {leagues = 6,  cups = 8,  ucl = 2, founded = 1905},  -- Chelsea
        [2]    = {leagues = 7,  cups = 7,  ucl = 1, founded = 1874},  -- Aston Villa
        [10]   = {leagues = 10, cups = 6,  ucl = 1, founded = 1880},  -- Manchester City
        [144]  = {leagues = 0,  cups = 1,  ucl = 0, founded = 1879},  -- Fulham
        [1]    = {leagues = 13, cups = 14, ucl = 0, founded = 1886},  -- Arsenal
        [11]   = {leagues = 20, cups = 12, ucl = 3, founded = 1878},  -- Manchester United
        [1799] = {leagues = 0,  cups = 0,  ucl = 0, founded = 1905},  -- Crystal Palace
        [94]   = {leagues = 1,  cups = 1,  ucl = 0, founded = 1878},  -- Ipswich Town
        [17]   = {leagues = 0,  cups = 1,  ucl = 0, founded = 1885},  -- Southampton
        [95]   = {leagues = 1,  cups = 3,  ucl = 0, founded = 1884},  -- Leicester City
        [1943] = {leagues = 0,  cups = 0,  ucl = 0, founded = 1899},  -- AFC Bournemouth
        [1808] = {leagues = 0,  cups = 0,  ucl = 0, founded = 1901},  -- Brighton & Hove Albion
        [7]    = {leagues = 9,  cups = 5,  ucl = 0, founded = 1878},  -- Everton
        [9]    = {leagues = 20, cups = 8,  ucl = 6, founded = 1892},  -- Liverpool

        -- 🔹 Championship (2025/26)
        [15]   = {leagues = 0,  cups = 0,  ucl = 0, founded = 1882},  -- Queens Park Rangers
        [106]  = {leagues = 6,  cups = 2,  ucl = 0, founded = 1879},  -- Sunderland
        [97]   = {leagues = 0,  cups = 0,  ucl = 0, founded = 1885},  -- Millwall
        [1961] = {leagues = 0,  cups = 1,  ucl = 0, founded = 1899},  -- Cardiff City
        [1800] = {leagues = 0,  cups = 1,  ucl = 0, founded = 1883},  -- Coventry City
        [1919] = {leagues = 0,  cups = 0,  ucl = 0, founded = 1894},  -- Bristol City
        [1929] = {leagues = 0,  cups = 1,  ucl = 0, founded = 1886},  -- Plymouth Argyle
        [109]  = {leagues = 1,  cups = 5,  ucl = 0, founded = 1878},  -- West Bromwich Albion
        [1960] = {leagues = 0,  cups = 1,  ucl = 0, founded = 1912},  -- Swansea City
        [1952] = {leagues = 0,  cups = 0,  ucl = 0, founded = 1904},  -- Hull City
        [1807] = {leagues = 4,  cups = 3,  ucl = 0, founded = 1867},  -- Sheffield Wednesday
        [1794] = {leagues = 1,  cups = 6,  ucl = 0, founded = 1889},  -- Sheffield United
        [1806] = {leagues = 1,  cups = 1,  ucl = 0, founded = 1863},  -- Stoke City
        [12]   = {leagues = 0,  cups = 1,  ucl = 0, founded = 1876},  -- Middlesbrough
        [3]    = {leagues = 3,  cups = 6,  ucl = 0, founded = 1875},  -- Blackburn Rovers
        [8]    = {leagues = 3,  cups = 1,  ucl = 0, founded = 1919},  -- Leeds United
        [1795] = {leagues = 0,  cups = 2,  ucl = 0, founded = 1881},  -- Watford
        [1792] = {leagues = 2,  cups = 0,  ucl = 0, founded = 1902},  -- Norwich City
        [1951] = {leagues = 0,  cups = 0,  ucl = 0, founded = 1893},  -- Oxford United
        [1790] = {leagues = 2,  cups = 2,  ucl = 0, founded = 1898},  -- Portsmouth
        [91]   = {leagues = 2,  cups = 1,  ucl = 0, founded = 1884},  -- Derby County
        [1796] = {leagues = 2,  cups = 1,  ucl = 0, founded = 1882},  -- Burnley
        [1923] = {leagues = 0,  cups = 0,  ucl = 0, founded = 1885},  -- Luton Town
        [1801] = {leagues = 0,  cups = 2,  ucl = 0, founded = 1880},  -- Preston North End

        -- 🔹 France Ligue 1 + Ligue 2 (2025/26)
        [65]   = {leagues = 4, cups = 6, ucl = 0, founded = 1944},   -- LOSC Lille
        [70]   = {leagues = 1, cups = 2, ucl = 0, founded = 1919},   -- Montpellier HSC
        [69]   = {leagues = 8, cups = 5, ucl = 0, founded = 1924},   -- AS Monaco
        [76]   = {leagues = 1, cups = 3, ucl = 0, founded = 1906},   -- RC Strasbourg
        [219]  = {leagues = 9, cups = 10, ucl = 1, founded = 1899},  -- Olympique de Marseille
        [73]   = {leagues = 13, cups = 16, ucl = 1, founded = 1970}, -- Paris Saint-Germain
        [66]   = {leagues = 7, cups = 5, ucl = 0, founded = 1950},   -- Olympique Lyonnais
        [64]   = {leagues = 1, cups = 1, ucl = 0, founded = 1906},   -- RC Lens
        [74]   = {leagues = 0, cups = 3, ucl = 0, founded = 1901},   -- Stade Rennais
        [1738] = {leagues = 0, cups = 1, ucl = 0, founded = 1872},  -- Le Havre AC
        [72]   = {leagues = 4, cups = 3, ucl = 0, founded = 1904},   -- OGC Nice
        [71]   = {leagues = 8, cups = 4, ucl = 0, founded = 1943},   -- FC Nantes
        [1530] = {leagues = 0, cups = 0, ucl = 0, founded = 1919},  -- Angers SCO
        [57]   = {leagues = 1, cups = 4, ucl = 0, founded = 1905},   -- AJ Auxerre
        [1819] = {leagues = 10, cups = 6, ucl = 0, founded = 1919}, -- AS Saint-Étienne
        [378]  = {leagues = 0, cups = 0, ucl = 0, founded = 1950},  -- Stade Brestois 29
        [379]  = {leagues = 0, cups = 2, ucl = 0, founded = 1931},  -- Stade de Reims
        [1809] = {leagues = 0, cups = 1, ucl = 0, founded = 1937},  -- Toulouse FC

        [217]   = {leagues = 0, cups = 0, ucl = 0, founded = 1926},  -- FC Lorient
        [210]   = {leagues = 0, cups = 2, ucl = 0, founded = 1913},  -- SM Caen
        [62]    = {leagues = 0, cups = 1, ucl = 0, founded = 1912},  -- En Avant Guingamp
        [110456]= {leagues = 0, cups = 0, ucl = 0, founded = 1913},  -- Valenciennes FC
        [226]   = {leagues = 0, cups = 5, ucl = 0, founded = 1928},  -- FC Sochaux-Montbéliard
        [111817]= {leagues = 0, cups = 0, ucl = 0, founded = 1969},  -- Paris FC
        [294]   = {leagues = 0, cups = 1, ucl = 0, founded = 1986},  -- ESTAC Troyes
        [1816]  = {leagues = 0, cups = 0, ucl = 0, founded = 1901},  -- Amiens SC
        [111659]= {leagues = 0, cups = 0, ucl = 0, founded = 1929},  -- Rodez Aveyron Football
        [1815]  = {leagues = 0, cups = 0, ucl = 0, founded = 1911},  -- Clermont Foot
        [59]    = {leagues = 6, cups = 4, ucl = 0, founded = 1881},  -- Girondins de Bordeaux
        [115494]= {leagues = 0, cups = 0, ucl = 0, founded = 1927}, -- FC Annecy
        [110569]= {leagues = 0, cups = 0, ucl = 0, founded = 1998}, -- Dijon FCO
        [58]    = {leagues = 0, cups = 0, ucl = 0, founded = 1905},  -- SC Bastia
        [110321]= {leagues = 0, cups = 0, ucl = 0, founded = 1959}, -- Pau FC
        [1814]  = {leagues = 0, cups = 1, ucl = 0, founded = 1902},  -- Stade Lavallois MFC
        [1805]  = {leagues = 0, cups = 0, ucl = 0, founded = 1911},  -- Grenoble Foot 38
        [614]   = {leagues = 0, cups = 1, ucl = 0, founded = 1910},  -- AC Ajaccio
        [112552]= {leagues = 0, cups = 0, ucl = 0, founded = 1902}, -- Quevilly Rouen Métropole
        [224]   = {leagues = 0, cups = 0, ucl = 0, founded = 1937},  -- Nîmes Olympique
        [68]    = {leagues = 2, cups = 2, ucl = 0, founded = 1932},  -- FC Metz
        [1813]  = {leagues = 0, cups = 0, ucl = 0, founded = 1925},  -- Chamois Niortais FC

        -- 🔹 Germany Bundesliga + 2. Bundesliga (2025/26)
        [175]    = {leagues = 1, cups = 1, ucl = 0, founded = 1945},   -- VfL Wolfsburg
        [38]     = {leagues = 4, cups = 6, ucl = 1, founded = 1899},   -- Werder Bremen
        [112172] = {leagues = 2, cups = 2, ucl = 0, founded = 2009},  -- RB Leipzig
        [23]     = {leagues = 5, cups = 3, ucl = 0, founded = 1900},   -- Borussia M'gladbach
        [36]     = {leagues = 5, cups = 3, ucl = 0, founded = 1893},   -- VfB Stuttgart
        [32]     = {leagues = 1, cups = 1, ucl = 1, founded = 1904},   -- Bayer 04 Leverkusen
        [1831]   = {leagues = 0, cups = 0, ucl = 0, founded = 1966},  -- 1. FC Union Berlin
        [21]     = {leagues = 33, cups = 20, ucl = 6, founded = 1900}, -- Bayern München
        [100409] = {leagues = 0, cups = 0, ucl = 0, founded = 1907},  -- FC Augsburg
        [1824]   = {leagues = 1, cups = 5, ucl = 1, founded = 1899},  -- Eintracht Frankfurt
        [25]     = {leagues = 0, cups = 0, ucl = 0, founded = 1904},   -- SC Freiburg
        [111235] = {leagues = 0, cups = 0, ucl = 0, founded = 1846},  -- 1. FC Heidenheim
        [22]     = {leagues = 8, cups = 5, ucl = 1, founded = 1909},   -- Borussia Dortmund
        [160]    = {leagues = 1, cups = 1, ucl = 0, founded = 1848},   -- VfL Bochum
        [576]    = {leagues = 0, cups = 0, ucl = 0, founded = 1900},   -- Holstein Kiel
        [110329] = {leagues = 0, cups = 0, ucl = 0, founded = 1910},  -- FC St. Pauli
        [10029]  = {leagues = 0, cups = 0, ucl = 0, founded = 1899},   -- TSG 1899 Hoffenheim
        [169]    = {leagues = 0, cups = 0, ucl = 0, founded = 1905},   -- 1. FSV Mainz 05

        [580]    = {leagues = 0, cups = 0, ucl = 0, founded = 1907},   -- SV Elversberg
        [165]    = {leagues = 0, cups = 0, ucl = 0, founded = 1903},   -- SpVgg Greuther Fürth
        [110500] = {leagues = 1, cups = 0, ucl = 0, founded = 1895},   -- Eintracht Braunschweig
        [10030]  = {leagues = 0, cups = 0, ucl = 0, founded = 1907},   -- SC Paderborn 07
        [1832]   = {leagues = 0, cups = 0, ucl = 0, founded = 1894},   -- Karlsruher SC
        [34]     = {leagues = 7, cups = 5, ucl = 1, founded = 1904},   -- FC Schalke 04
        [485]    = {leagues = 2, cups = 1, ucl = 0, founded = 1896},   -- Hannover 96
        [166]    = {leagues = 2, cups = 1, ucl = 0, founded = 1892},   -- Hertha BSC
        [171]    = {leagues = 9, cups = 4, ucl = 1, founded = 1900},   -- 1. FC Nürnberg
        [110636] = {leagues = 1, cups = 2, ucl = 0, founded = 1895},   -- Fortuna Düsseldorf
        [28]     = {leagues = 6, cups = 3, ucl = 0, founded = 1887},   -- Hamburger SV
        [29]     = {leagues = 4, cups = 2, ucl = 0, founded = 1900},   -- 1. FC Kaiserslautern
        [110176] = {leagues = 0, cups = 0, ucl = 0, founded = 1846},  -- SSV Ulm 1846
        [531]    = {leagues = 0, cups = 0, ucl = 0, founded = 1906},   -- Preußen Münster
        [543]    = {leagues = 0, cups = 0, ucl = 0, founded = 1907},   -- Jahn Regensburg
        [31]     = {leagues = 3, cups = 4, ucl = 0, founded = 1948},   -- 1. FC Köln
        [110588] = {leagues = 3, cups = 7, ucl = 1, founded = 1965},  -- 1. FC Magdeburg
        [110502] = {leagues = 2, cups = 1, ucl = 0, founded = 1898},  -- SV Darmstadt 98

        -- 🔹 Italy Serie A (2025/26)
        [52]     = {leagues = 3, cups = 9, ucl = 0, founded = 1927},   -- AS Roma
        [46]     = {leagues = 2, cups = 7, ucl = 0, founded = 1900},   -- Lazio
        [1746]   = {leagues = 0, cups = 0, ucl = 0, founded = 1920},  -- Empoli
        [347]    = {leagues = 0, cups = 0, ucl = 0, founded = 1908},  -- US Lecce
        [55]     = {leagues = 0, cups = 2, ucl = 0, founded = 1896},  -- Udinese
        [1842]   = {leagues = 1, cups = 1, ucl = 0, founded = 1920},  -- Cagliari
        [110556] = {leagues = 9, cups = 1, ucl = 0, founded = 1893},  -- Genoa
        [206]    = {leagues = 1, cups = 3, ucl = 0, founded = 1903},  -- Hellas Verona
        [110374] = {leagues = 2, cups = 6, ucl = 0, founded = 1926},  -- Fiorentina
        [39]     = {leagues = 1, cups = 1, ucl = 1, founded = 1907},  -- Atalanta
        [48]     = {leagues = 3, cups = 6, ucl = 1, founded = 1926},  -- Napoli
        [44]     = {leagues = 20, cups = 9, ucl = 3, founded = 1908}, -- Inter
        [54]     = {leagues = 7, cups = 5, ucl = 0, founded = 1906},  -- Torino
        [45]     = {leagues = 36, cups = 14, ucl = 2, founded = 1897}, -- Juventus
        [189]    = {leagues = 7, cups = 2, ucl = 0, founded = 1909},  -- Bologna
        [205]    = {leagues = 0, cups = 0, ucl = 0, founded = 1907},  -- Venezia
        [50]     = {leagues = 3, cups = 4, ucl = 0, founded = 1913},  -- Parma
        [1745]   = {leagues = 0, cups = 0, ucl = 0, founded = 1907},  -- Como
        [47]     = {leagues = 19, cups = 5, ucl = 7, founded = 1899}, -- AC Milan
        [111811] = {leagues = 0, cups = 0, ucl = 0, founded = 1912}, -- AC Monza

        -- 🔹 Netherlands Eredivisie (2025/26)
        [634]     = {leagues = 0, cups = 0, ucl = 0, founded = 1968},  -- Fortuna Sittard
        [1913]    = {leagues = 0, cups = 1, ucl = 0, founded = 1920},  -- sc Heerenveen
        [245]     = {leagues = 36, cups = 20, ucl = 4, founded = 1900}, -- Ajax
        [1903]    = {leagues = 0, cups = 3, ucl = 0, founded = 1970},  -- FC Utrecht
        [247]     = {leagues = 25, cups = 11, ucl = 1, founded = 1913}, -- PSV
        [1910]    = {leagues = 0, cups = 0, ucl = 0, founded = 1900},  -- NEC Nijmegen
        [100632]  = {leagues = 0, cups = 1, ucl = 0, founded = 1902},  -- Go Ahead Eagles
        [1908]    = {leagues = 1, cups = 3, ucl = 0, founded = 1965},  -- FC Twente
        [246]     = {leagues = 17, cups = 14, ucl = 2, founded = 1908}, -- Feyenoord
        [1905]    = {leagues = 0, cups = 0, ucl = 0, founded = 1940},  -- RKC Waalwijk
        [100646]  = {leagues = 6, cups = 3, ucl = 0, founded = 1888},  -- Sparta Rotterdam
        [1906]    = {leagues = 2, cups = 5, ucl = 0, founded = 1967},  -- AZ Alkmaar
        [1915]    = {leagues = 1, cups = 2, ucl = 0, founded = 1971},  -- FC Groningen
        [1914]    = {leagues = 0, cups = 1, ucl = 0, founded = 1910},  -- PEC Zwolle
        [100634]  = {leagues = 0, cups = 0, ucl = 0, founded = 1903},  -- Heracles Almelo
        [111380]  = {leagues = 0, cups = 0, ucl = 0, founded = 2001},  -- Almere City FC
        [1907]    = {leagues = 3, cups = 2, ucl = 0, founded = 1896},  -- Willem II Tilburg
        [1904]    = {leagues = 1, cups = 1, ucl = 0, founded = 1912},  -- NAC Breda
        [155606] = {leagues = 1, cups = 0, ucl = 0, founded = 2014},   -- Borneo FC Samarinda
        [155603] = {leagues = 11, cups = 3, ucl = 0, founded = 1928},  -- Persija Jakarta (3x Piala Presiden)
        [155611] = {leagues = 0, cups = 0, ucl = 0, founded = 2021},   -- Dewa United FC
        [155605] = {leagues = 0, cups = 3, ucl = 0, founded = 1932},   -- PSIS Semarang (3x Copa Dji Sam Soe)
        [155604] = {leagues = 6, cups = 3, ucl = 0, founded = 1927},   -- Persebaya Surabaya (3x Piala Presiden / Piala Indonesia)
        [155614] = {leagues = 0, cups = 0, ucl = 0, founded = 2016},   -- Madura United FC
        [155607] = {leagues = 3, cups = 1, ucl = 0, founded = 2014},   -- Bali United (1x Piala Indonesia 2018/19 runner-up, belum ada juara resmi → isi 1 kalau dihitung turnamen kecil)
        [155601] = {leagues = 7, cups = 0, ucl = 0, founded = 1915},   -- PSM Makassar
        [155600] = {leagues = 1, cups = 3, ucl = 0, founded = 1987},   -- Arema FC (3x Piala Presiden)
        [155615] = {leagues = 0, cups = 0, ucl = 0, founded = 1976},   -- PSS Sleman
        [155612] = {leagues = 3, cups = 0, ucl = 0, founded = 1950},   -- Persik Kediri
        [155617] = {leagues = 0, cups = 0, ucl = 0, founded = 1953},   -- Persita Tangerang
        [155616] = {leagues = 7, cups = 0, ucl = 0, founded = 1923},   -- PERSIS Solo
        [155610] = {leagues = 0, cups = 0, ucl = 0, founded = 1988},   -- PS Barito Putera
        [155620] = {leagues = 0, cups = 0, ucl = 0, founded = 1963},   -- PSBS Biak
        [155621] = {leagues = 0, cups = 0, ucl = 0, founded = 2022},   -- Malut United FC
        [155618] = {leagues = 1, cups = 0, ucl = 0, founded = 1980},   -- Semen Padang
        [155602] = {leagues = 9, cups = 2, ucl = 0, founded = 1919},   -- Persib Bandung (2x Piala Presiden)
        -- dst...
         }
    end
function SelectLeagueTeam:initLeagueDatabase()
    self.leagueDatabase = {
        -- 🌍 Liga Dunia Nyata 2025/26 (update singkat)
        [  1]    = { league = "3F Superliga", nation = "Denmark" },
        [  4]    = { league = "Jupiler Pro League", nation = "Belgium" },
        [  7]    = { league = "Brasileirão Serie A", nation = "Brazil" },
        [ 10]    = { league = "Eredivisie", nation = "Netherlands" },
        [ 13]    = { league = "Premier League", nation = "England" },
        [ 14]    = { league = "Sky Bet Championship", nation = "England" },
        [ 16]    = { league = "Ligue 1 McDonald’s", nation = "France" },
        [ 17]    = { league = "Ligue 2 BKT", nation = "France" },
        [ 19]    = { league = "Bundesliga", nation = "Germany" },
        [ 20]    = { league = "2. Bundesliga", nation = "Germany" },
        [ 31]    = { league = "Serie A Enilive", nation = "Italy" },
        [ 32]    = { league = "Serie BKT", nation = "Italy" },
        [ 39]    = { league = "MLS", nation = "USA" },
        [ 41]    = { league = "Eliteserien", nation = "Norway" },
        [ 50]    = { league = "cinch Premiership", nation = "Scotland" },
        [ 53]    = { league = "LaLiga EA SPORTS", nation = "Spain" },
        [ 54]    = { league = "LaLiga HYPERMOTION", nation = "Spain" },
        [ 56]    = { league = "Allsvenskan", nation = "Sweden" },
        [ 60]    = { league = "League One", nation = "England" },
        [ 61]    = { league = "League Two", nation = "England" },
        [ 65]    = { league = "SSE Premier Div", nation = "Ireland" },
        [ 66]    = { league = "Ekstraklasa", nation = "Poland" },
        [ 67]    = { league = "Russian Premier", nation = "Russia" },
        [ 68]    = { league = "Süper Lig", nation = "Turkey" },
        [ 76]    = { league = "Rest of World", nation = "Various" },
        [ 77]    = { league = "Rest of World (2)", nation = "Various" },
        [ 78]    = { league = "International", nation = "FIFA" },
        [ 80]    = { league = "ADMIRAL Bundesliga", nation = "Austria" },
        [ 83]    = { league = "K League 1", nation = "South Korea" },
        [189]    = { league = "Super League", nation = "Switzerland" },
        [308]    = { league = "Liga Portugal", nation = "Portugal" },
        [330]    = { league = "SuperLiga Romania", nation = "Romania" },
        [335]    = { league = "Campeonato Chile", nation = "Chile" },
        [336]    = { league = "Liga Colombia", nation = "Colombia" },
        [338]    = { league = "Campeonato Uruguay", nation = "Uruguay" },
        [341]    = { league = "Liga MX", nation = "Mexico" },
        [347]    = { league = "DStv Premiership", nation = "South Africa" },
        [349]    = { league = "J1 League", nation = "Japan" },
        [350]    = { league = "Saudi League", nation = "Saudi Arabia" },
        [351]    = { league = "A-League Men", nation = "Australia" },
        [353]    = { league = "Torneo Binance", nation = "Argentina" },
        [365]    = { league = "AFC Competitions", nation = "Asia" },
        [1107]   = { league = "HK Premier League", nation = "Hong Kong" },
        [1114]   = { league = "Singapore Premier", nation = "Singapore" },
        [1115]   = { league = "Qatar Stars League", nation = "Qatar" },
        [1117]   = { league = "Uzbek Super League", nation = "Uzbekistan" },
        [1170]   = { league = "Cambodian Premier", nation = "Cambodia" },
        [1171]   = { league = "Myanmar National", nation = "Myanmar" },
        [1172]   = { league = "Laos League 1", nation = "Laos" },
        [1245]   = { league = "Classic Team", nation = "Special" },
        [1246]   = { league = "Classic Internasional", nation = "Special" },
        [1407]   = { league = "Bashundhara Premier", nation = "Bangladesh" },
        [2012]   = { league = "Chinese Super League", nation = "China" },
        [2013]   = { league = "ADNOC Pro League", nation = "UAE" },
        [2034]   = { league = "Mobilis Ligue 1", nation = "Algeria" },
        [2076]   = { league = "3. Liga", nation = "Germany" },
        [2136]   = { league = "Intl Women", nation = "FIFA" },
        [2149]   = { league = "Indian Super League", nation = "India" },
        [2215]   = { league = "Frauen-Bundesliga", nation = "Germany" },
        [2216]   = { league = "WSL", nation = "England" },
        [2218]   = { league = "Division 1 Féminine", nation = "France" },
        [2221]   = { league = "NWSL", nation = "USA" },
        [2222]   = { league = "Liga F", nation = "Spain" },
        [2231]   = { league = "Egypt Premier", nation = "Egypt" },
        [2235]   = { league = "BRI Super League", nation = "Indonesia" },
        [2236]   = { league = "UCL", nation = "Europe" },
        [2237]   = { league = "Super League Malaysia", nation = "Malaysia" },
        [2238]   = { league = "UEL", nation = "Europe" },
        [2240]   = { league = "UEFA WCL", nation = "Europe" },
        [2250]   = { league = "Botola Pro", nation = "Morocco" },
        [2252]   = { league = "Thai League 1", nation = "Thailand" },
        [2254]   = { league = "Pegadaian Championship", nation = "Indonesia" },
        [2255]   = { league = "PNM Liga Nusantara", nation = "Indonesia" },
        [2260]   = { league = "V.League 1", nation = "Vietnam" },
        [2264]   = { league = "ASEAN U23", nation = "ASEAN" },
    }
end
-- Helper format uang pakai M / B / K dengan 2 digit di belakang titik
local function formatMoney(value)
    if value >= 1000000000 then
        local billions = value / 1000000000
        return string.format("$%.2fB", billions)
    elseif value >= 1000000 then
        local millions = value / 1000000
        return string.format("$%.2fM", millions)
    elseif value >= 1000 then
        local thousands = value / 1000
        return string.format("$%.2fK", thousands)
    else
        return string.format("$%.2f", value)
    end
end

-- Hitung nilai klub (Club Worth)
function SelectLeagueTeam:calculateTeamValue()
    local teamRating = self:getTeamRating()  
    local normalizedRating = (teamRating - 1) / (100 - 1)

    local minValue = 750000000     -- $75M
    local maxValue = 950000000   -- $9.5B

    local teamValue = minValue + (normalizedRating * (maxValue - minValue))
    teamValue = math.floor(teamValue + 0.5)

    return formatMoney(teamValue)
end
-- Helper format uang pakai KN / MN / BN dengan 2 digit
local function formatMoney(value)
    if value >= 1000000000 then
        -- contoh: 4660000000 -> 4.66BN
        local billions = value / 1000000000
        return string.format("$%.2fBN", billions)
    elseif value >= 1000000 then
        -- contoh: 273830000 -> 273.83MN
        local millions = value / 1000000
        return string.format("$%.2fMN", millions)
    elseif value >= 1000 then
        -- contoh: 25000 -> 25.00KN
        local thousands = value / 1000
        return string.format("$%.2fKN", thousands)
    else
        return string.format("$%.2f", value)
    end
end

-- Hitung Transfer Budget
function SelectLeagueTeam:calculateTransferBudget()
    local teamRating = self:getTeamRating()
    local normalizedRating = (teamRating - 1) / (100 - 1)

    local minBudget = 1000000000   -- $1.00BN
    local maxBudget = 8000000000   -- $8.00BN

    local budget = minBudget + (normalizedRating * (maxBudget - minBudget))
    budget = math.floor(budget + 0.5)  -- bulatkan ke integer terdekat

    return formatMoney(budget)
end

function SelectLeagueTeam:getBackgroundByLeagueID(leagueId)
  local mapping = {
    [13] = "$Background6",
    [53] = "$Background4",
    [100] = "$Background7"
    -- tambahkan mapping lain di sini
  }

  local name = mapping[leagueId] or "$BackgroundDefault"
  return {
    name = name,
    id = leagueId
  }
end

-- Update the difficulty generation function
function SelectLeagueTeam:ensureDifficultyLabels()
    if not self.randomDifficultyLabels then
        -- Gunakan teamID sebagai seed untuk konsistensi
        math.randomseed(os.time() + (self.currentTeamID or 0))
        
        local allDifficulties = {
            "Very Low", "High", "Medium", "Very High", "Low",
            "Expert"
        }
        for i = #allDifficulties, 2, -1 do
            local j = math.random(i)
            allDifficulties[i], allDifficulties[j] = allDifficulties[j], allDifficulties[i]
        end
        self.randomDifficultyLabels = {
            allDifficulties[1],
            allDifficulties[2],
            allDifficulties[3],
            allDifficulties[4],
            allDifficulties[5]
        }
        print(string.format("Generated new difficulties for Team %d", self.currentTeamID))
    end
end

function SelectLeagueTeam:getDifficultyColor(label)
    local colorMap = {
    ["Very Low"] = 0xFFFFFF,   -- Emerald green
    ["High"] = 0xFFFFFF,        -- Deep green
    ["Medium"] = 0xFFFFFF,     -- Sunflower yellow
    ["Very High"] = 0xFFFFFF,       -- Carrot orange
    ["Low"] = 0xFFFFFF,   -- Strong red
    ["Expert"] = 0xFFFFFF      -- Dark red
    }
    return colorMap[label or ""] or 0xFFFFFF
end
function SelectLeagueTeam:getCountryNameByLeagueId(leagueId)
    -- Coba dari service
    local success, countryInfo = pcall(function()
        return self.services.CountryService.GetCountryInfoByFUTLeagueId(leagueId)
    end)
    
    if success and countryInfo and countryInfo.id ~= -1 then
        -- Gunakan nama langsung jika tersedia
        if countryInfo.name and countryInfo.name ~= "" then
            return countryInfo.name
        end

        -- Coba dari lokal jika tersedia
        local locName = self.loc.LocalizeString("CountryName_" .. countryInfo.id)
        if locName and locName ~= ("CountryName_" .. countryInfo.id) then
            return locName
        end

        return countryInfo.id or "Unknown Country (Service)"
    end

    -- Fallback manual
    local manualMap = {
        [1120402720] = "Indonesia"
    }
    return manualMap[leagueId] or "Unknown Country (Fallback)"
end

function SelectLeagueTeam:getTeamRating()
    if not self.teamsData or not self.teamsData[self.teamIndex] then
    return 0 end
    local team = self.teamsData[self.teamIndex]
    return (team.offense + team.midfield + team.defense) / 3
end

function SelectLeagueTeam:_juiceSelectLeagueTeam(currentTeamID)
  self.currentTeamID = currentTeamID
  self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(self.currentTeamID)
  self.services.FUTUserInfoService.SetUserFavoriteTeam(self.currentTeamID)
end

function SelectLeagueTeam:getLeagues()
  local leagueNames = {}
  self.leagueIDs = {
    13,14,60,61,2216,53,54,2222,16,17,2218,19,20,2076,2215,31,32,308,10,4,1,66,189,80,41,56,65,67,68,39,2221,7,353,341,335,336,338,347,2231,2250,350,1115,2013,349,83,2149,2252,2237,2235,2254,2255,2260,1114,1107,1117,2012,1170,1171,1172,1407
  }
  local alternateBG = false
  for i = 1, #self.leagueIDs do
    table.insert(leagueNames, {
      label = self.leagueIDs[i], -- Use label based on the ID
      image = {
        name = "$LeagueCrest",
        id = self.leagueIDs[i]
      },
      id = i,
      selected = self.currentLeagueID == self.leagueIDs[i] or (self.currentLeagueID == 0 and i == 1),
      alternateBackground = alternateBG
    })
    if self.currentLeagueID == self.leagueIDs[i] or (self.currentLeagueID <= 0 and i == 1) then
      self.currentLeagueID = self.leagueIDs[i]
      self.leagueIndex = i
    end
    if i % NUM_COLUMNS ~= 0 then
      alternateBG = not alternateBG
    end
  end

  self:setSelectedLeagueIndex(self.leagueIndex)
  currentLeagueIndex = self.leagueIndex
  self.leaguesDataToPublish = {
    index = self.leagueIndex,
    data = leagueNames
  }
  self.im.Refresh(BND_LEAGUE_LIST)
end

function SelectLeagueTeam:registerLeagueBindings()
  self.im.Subscribe(BND_LEAGUE_LIST, function()
    self.im.Publish(BND_LEAGUE_LIST, self.leaguesDataToPublish)
  end)
  self.isLeagueSelectorVisible = false
  self.im.Subscribe(BND_LEAGUE_OVERLAY_VISIBLE, function()
    self.im.Publish(BND_LEAGUE_OVERLAY_VISIBLE, self.isLeagueSelectorVisible)
  end)
  self.im.Subscribe(BND_SELECTED_LEAGUE_NAME, function()
    self.im.Publish(BND_SELECTED_LEAGUE_NAME, self.leaguesDataToPublish.data[self.leagueIndex].label)
  end)
  self.im.RegisterAction(ACT_SELECT_LEAGUE, function()
    self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("INVALID"))
    self:toggleLeagueSelectorVisibility(true)
  end)
  self.im.RegisterDataAction(BND_LEAGUE_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    self:toggleLeagueSelectorVisibility(false)
    self:setSelectedLeagueIndexHelper(index)
    self:getLeagues()
    self:publishLeagueToggle()
    self:publishTeamToggle()
    self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("VALID"))
  end)
end

function SelectLeagueTeam:setSelectedLeagueIndex(index)
  self:setSelectedLeagueIndexHelper(index)
  self:publishLeagueCrest()
  self:publishLeagueCrestActive()
  self:getTeams()
  self.im.Refresh(BND_COUNTRY_NAME) -- Refresh nama negara
      
    local countryName = self:getCountryNameByLeagueId(self.currentLeagueID)
    print("Negara untuk liga ini:", countryName)
    self.im.Publish("bnd_country_name", countryName)
end

function SelectLeagueTeam:setSelectedLeagueIndexHelper(index)
  if self.leagueIndex ~= index then
    self.leagueIndex = index
    self.currentLeagueID = self.leagueIDs[index]
    self.im.Refresh(BND_SELECTED_LEAGUE_NAME)
    self.currentTeamID = 0
    self.teamIndex = 1
    self.im.Refresh(BND_SELECTED_TEAM_NAME)

  end
end

-- List of teams to exclude
local EXCLUDED_TEAMS = {}

-- Helper function to check if a team is in the exclusion list
local function isExcluded(teamID)
  for _, id in ipairs(EXCLUDED_TEAMS) do
    if teamID == id then
      return true
    end
  end
  return false
end

function SelectLeagueTeam:getTeams()
  local teamNames = {}
  local teamIDs = self.services.TeamService.GetTeams(self.currentLeagueID, 0, 0, false)
  self.teamsData = {}

  local alternateBG = true

  for _, teamData in ipairs(teamIDs) do
    if not isExcluded(teamData.id) then  -- Exclude teams using a simple list check
      local teamInfo = {
        id = teamData.id,
        name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamData.id),
        starRating = teamData.starRating or 0,
        offense = teamData.offense or 0,
        midfield = teamData.midfield or 0,
        defense = teamData.defense or 0
      }

      table.insert(self.teamsData, teamInfo)
      table.insert(teamNames, {
        label = teamInfo.name,
        image = { name = "$Crest", id = teamInfo.id },
        id = #self.teamsData, -- Use actual index for consistency
        selected = self.currentTeamID == teamInfo.id or (self.currentTeamID == 0 and #self.teamsData == 1),
        alternateBackground = alternateBG,
        stars = teamInfo.starRating
      })

      if self.currentTeamID == teamInfo.id or (self.currentTeamID == 0 and #self.teamsData == 1) then
        self.currentTeamID = teamInfo.id
        self.teamIndex = #self.teamsData
        currentSelectedTeamID = teamInfo.id
      end

      if #self.teamsData % NUM_COLUMNS ~= 0 then
        alternateBG = not alternateBG
      end
    end
  end

  TeamList = {}
	for _, teamData in ipairs(teamIDs) do
	  table.insert(TeamList, teamData.id) -- Add ALL teams, even excluded ones
	end

  self:setSelectedTeamIndex(self.teamIndex)
  self.teamsDataToPublish = { index = self.teamIndex, data = teamNames }
  self.im.Refresh(BND_TEAM_LIST)
end

function SelectLeagueTeam:registerTeamBindings()
  self.im.Subscribe(BND_TEAM_LIST, function()
    self.im.Publish(BND_TEAM_LIST, self.teamsDataToPublish)
  end)
  self.isTeamSelectorVisible = false
  self.im.Subscribe(BND_TEAM_OVERLAY_VISIBLE, function()
    self.im.Publish(BND_TEAM_OVERLAY_VISIBLE, self.isTeamSelectorVisible)
  end)
  self.im.Subscribe(BND_SELECTED_TEAM_NAME, function()
    self.im.Publish(BND_SELECTED_TEAM_NAME, self.teamsDataToPublish.data[self.teamIndex].label)
  end)
  self.im.RegisterAction(ACT_SELECT_TEAM, function()
    self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("INVALID"))
    self:toggleTeamSelectorVisibility(true)
  end)
  self.im.RegisterDataAction(BND_TEAM_INDEX, ACT_CHANGE, function(bindingName, actionName, index)
    self:toggleTeamSelectorVisibility(false)
    self:setSelectedTeamIndexHelper(index)
    self:getTeams()
    self:publishTeamToggle()
    self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("VALID"))
    self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("VALID"))
  end)
  for i = 1, 5 do
    local labelBnd = "bnd_difficulty_label"..i
    local colorBnd = "bnd_difficulty_color"..i

    self.im.Subscribe(labelBnd, function()
        self:ensureDifficultyLabels()
        self.im.Publish(labelBnd, self.randomDifficultyLabels[i] or "")
    end)

    self.im.Subscribe(colorBnd, function()
        self:ensureDifficultyLabels()
        local label = self.randomDifficultyLabels[i] or ""
        local color = self:getDifficultyColor(label)
        self.im.Publish(colorBnd, color)
    end)
    end
    self.im.Subscribe("bnd_team_value", function()
    self:publishTeamValue()
    end)
    self.im.Subscribe("bnd_transfer_budget", function()
    self:publishTransferBudget()
    end)
end

function SelectLeagueTeam:refreshAllDifficulties()
    self.randomDifficultyLabels = nil
    self:ensureDifficultyLabels()
    for i = 1, 5 do
    local label = self.randomDifficultyLabels[i] or ""
    local color = self:getDifficultyColor(label)

    self.im.Publish("bnd_difficulty_label"..i, label)
    self.im.Publish("bnd_difficulty_color"..i, color)

    self.im.Refresh("bnd_difficulty_label"..i)
    self.im.Refresh("bnd_difficulty_color"..i)
end
    -- Debug output
    print("Refreshed Difficulties for Team", self.currentTeamID)
    print("Labels:", table.concat(self.randomDifficultyLabels, " | "))
end

function SelectLeagueTeam:reshuffleDifficultyLabels()
    self.randomDifficultyLabels = nil
    self:publishAllDifficultyLabels()
end

function SelectLeagueTeam:setSelectedTeamIndex(index)
    self:setSelectedTeamIndexHelper(index)
    self:publishStadiumName(self.currentTeamID)
    self:publishTeamCrest(self.currentTeamID)
    self:publishTeamCrestHomeKit(self.currentTeamID)
    self:publishTeamCrestAwayKit(self.currentTeamID)
    self:publishTeamValue()
    self:publishTransferBudget()
    self:publishTrophies(self.currentTeamID)

    -- 🔹 Publish nama liga & negara
    self:publishLeagueName(self.currentLeagueID)

    -- 🔹 Publish background career berdasarkan liga
    self:publishBackgroundCareer(self.currentLeagueID)

    -- 🔹 Random asset tambahan
    self:publishRandomAssets()

    -- 🔹 Difficulty labels
    self.randomDifficultyLabels = nil
    self:ensureDifficultyLabels()
    for i = 1, 5 do
        local label = self.randomDifficultyLabels[i] or ""
        local color = self:getDifficultyColor(label)
        self.im.Publish("bnd_difficulty_label"..i, label)
        self.im.Publish("bnd_difficulty_color"..i, color)
        self.im.Refresh("bnd_difficulty_label"..i)
        self.im.Refresh("bnd_difficulty_color"..i)
    end
end

function SelectLeagueTeam:setSelectedTeamIndexHelper(index)
  if self.teamIndex ~= index then
    self.teamIndex = index
    self.currentTeamID = self.teamsData[index].id
    self.im.Refresh(BND_SELECTED_TEAM_NAME)
  end
end

function SelectLeagueTeam:toggleLeagueSelectorVisibility(visible)
  if self.isLeagueSelectorVisible ~= visible then
    self.isLeagueSelectorVisible = visible
    self.im.Refresh(BND_LEAGUE_OVERLAY_VISIBLE)
  end
end

function SelectLeagueTeam:toggleTeamSelectorVisibility(visible)
  if self.isTeamSelectorVisible ~= visible then
    self.isTeamSelectorVisible = visible
    self.im.Refresh(BND_TEAM_OVERLAY_VISIBLE)
  end
end

function SelectLeagueTeam:onSelectorCancel()
  if self.isLeagueSelectorVisible then
    self:toggleLeagueSelectorVisibility(false)
  elseif self.isTeamSelectorVisible then
    self:toggleTeamSelectorVisibility(false)
  end
  self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("VALID"))
end

function SelectLeagueTeam:checkFUTConnection()
  local loginStatus = self.services.FUTUserInfoService.GetLoginStatus()
  if loginStatus == LOGIN_STATUS.LS_FAILED or loginStatus == LOGIN_STATUS.LS_DISCONNECTED then
    self.im.ChangeActionState(ACT_CONFIRM, self.im.GetActionState("INVALID"))
    self.im.ChangeActionState(ACT_CHANGE, self.im.GetActionState("INVALID"))
    local buttonOk = VirtualButton:new({
      nav = self.nav,
      label = "LTXT_CMN_OK",
      clickEvents = {
        "evt_hide_popup"
      },
      clickCallback = function()
        self:_enableScreen()
      end
    })
    popupData = {
      title = "LTXT_INV_RESULTS_ERROR",
      message = "LTXT_NETWORK_ERROR",
      buttons = {buttonOk}
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
  end
end

function SelectLeagueTeam:_enableScreen()
  self.im.ChangeActionState(ACT_SELECT_LEAGUE, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_SELECT_TEAM, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_SELECTOR_CANCEL, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_CHANGE, self.im.GetActionState("VALID"))
  self.im.ChangeActionState(ACT_CONFIRM, self.im.GetActionState("VALID"))
end

function SelectLeagueTeam:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.FosFavoriteTeamComplete then
    if data.success then
      self.currentCountryID = self.services.CountryService.GetCountryInfoByFUTLeagueId(self.currentLeagueID).id
      self.services.UserPlateService.SetFavorites(self.currentCountryID, self.currentTeamID, self.favoritePlayerID)
      self.nav.Event(nil, "evt_advance")
    else
      local buttonOk = {
        label = "LTXT_CMN_OK",
        clickEvents = {
          "evt_hide_popup"
        },
        clickCallback = function()
          self:_enableScreen()
        end
      }
      local popupData = {
        title = "LTXT_CMN_FUT_ERROR_TITLE",
        message = "LTXT_SERVER_UNAVAILABLE",
        buttons = {buttonOk}
      }
      self.nav.Event(nil, "evt_show_popup", popupData)
    end
  elseif eventType == EVENT_TYPES.OnBackPressed then
  end
end

function SelectLeagueTeam:_publishData(bindingName)
  if bindingName == BND_LEAGUE_LIST then
    self.im.Publish(bindingName, self.leagues)
  elseif bindingName == BND_TEAM_LIST then
    self.im.Publish(bindingName, self.clubs)
  end
end

function SelectLeagueTeam:_publishTeamName()
  if self.currentTeamID == -1 then
    self.currentTeamName = ""
  end
  self.im.Publish(BND_TEAM_NAME, self.currentTeamName)
end

function SelectLeagueTeam:publishLeagueCrest()
  if self.currentLeagueID ~= -1 then
    local leagueCrest = {
      name = "$LeagueCrest",
      id = self.currentLeagueID
    }
    self.im.Publish(BND_LEAGUE_CREST, leagueCrest)
  end
end

function SelectLeagueTeam:publishLeagueCrestActive()
  if self.currentLeagueID ~= -1 then
    local leagueCrestActive = {
      name = "$LeagueCrest",
      id = self.currentLeagueID
    }
    self.im.Publish(BND_LEAGUE_CREST_ACTIVE, leagueCrestActive)
  end
end

function SelectLeagueTeam:publishTeamCrest(teamid)
  if self.currentTeamID ~= -1 then
    currentSelectedTeamID = self.currentTeamID 
    local selectedTeamID = teamid or self.currentTeamID 

    self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(selectedTeamID)
    local teamCrest = {
      name = "$Crest",
      id = selectedTeamID
    }

    self.im.Publish(BND_TEAM_CREST, teamCrest)

    self:publishTeamStarRating()
    self:publishLeagueToggle()
    self:publishTeamRating()
    self:publishAllDifficultyLabels() 
    for i = 1, 5 do
            self.im.Publish("bnd_difficulty_label"..i, "")
        end
  else
    self.favoritePlayerID = -1
  end
end

function SelectLeagueTeam:publishTeamCrestHomeKit(teamid)
  if self.currentTeamID ~= -1 then
    currentSelectedTeamID = self.currentTeamID 
    local selectedTeamID = teamid or self.currentTeamID 

    self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(selectedTeamID)
    local teamCresthomekit = {
      name = "$HomeKit",
      id = selectedTeamID
    }

    self.im.Publish(BND_TEAM_CREST_HOME_KIT, teamCresthomekit)

    self:publishTeamStarRating()
    self:publishLeagueToggle()
    self:publishTeamRating()
  else
    self.favoritePlayerID = -1
  end
end

function SelectLeagueTeam:publishTeamCrestAwayKit(teamid)
  if self.currentTeamID ~= -1 then
    currentSelectedTeamID = self.currentTeamID 
    local selectedTeamID = teamid or self.currentTeamID 

    self.favoritePlayerID = self.services.UserPlateService.GetFavoritePlayerByTeamId(selectedTeamID)
    local teamCrestawaykit = {
      name = "$AwayKit",
      id = selectedTeamID
    }

    self.im.Publish(BND_TEAM_CREST_AWAY_KIT, teamCrestawaykit)

    self:publishTeamStarRating()
    self:publishLeagueToggle()
    self:publishTeamRating()
  else
    self.favoritePlayerID = -1
  end
end

-- Publish background career berdasarkan ID liga
function SelectLeagueTeam:publishBackgroundCareer(leagueid)
  if self.currentLeagueID ~= -1 then
    local selectedLeagueID = leagueid or self.currentLeagueID

    local backgroundAsset = {
      name = "$BackgroundCareer",
      id = selectedLeagueID
    }

    self.im.Publish(BND_BACKGROUND_CAREER, backgroundAsset)
  end
end

-- =========================================================
-- Mapping asset per tim
-- =========================================================
local teamAssetMap = {
    -- =========================
    -- 🇪🇸 Spain La Liga
    -- =========================
    [241] = { fanbase = 3, youth = 2, financial = 1 }, -- Barcelona
    [240] = { fanbase = 3, youth = 5, financial = 2 }, -- Real Madrid
    [243] = { fanbase = 3, youth = 5, financial = 2 }, -- Atletico Madrid
    [244] = { fanbase = 2, youth = 2, financial = 2 }, -- Sevilla
    [245] = { fanbase = 2, youth = 4, financial = 2 }, -- Valencia
    [246] = { fanbase = 2, youth = 4, financial = 2 }, -- Villarreal
    [448] = { fanbase = 2, youth = 3, financial = 2 }, -- Athletic Bilbao
    [449] = { fanbase = 2, youth = 2, financial = 2 }, -- Real Betis
    [450] = { fanbase = 4, youth = 4, financial = 5 }, -- Celta Vigo
    [452] = { fanbase = 4, youth = 4, financial = 5 }, -- Espanyol
    [453] = { fanbase = 5, youth = 4, financial = 5 }, -- Mallorca
    [457] = { fanbase = 2, youth = 2, financial = 2 }, -- Real Sociedad
    [461] = { fanbase = 2, youth = 4, financial = 5 }, -- Valencia CF
    [462] = { fanbase = 4, youth = 4, financial = 5 }, -- Valladolid
    [463] = { fanbase = 4, youth = 4, financial = 5 }, -- Alaves
    [472] = { fanbase = 5, youth = 4, financial = 5 }, -- Las Palmas
    [479] = { fanbase = 4, youth = 4, financial = 5 }, -- Osasuna
    [480] = { fanbase = 4, youth = 4, financial = 5 }, -- Rayo Vallecano
    [481] = { fanbase = 2, youth = 2, financial = 2 }, -- Sevilla FC
    [483] = { fanbase = 2, youth = 4, financial = 2 }, -- Villarreal
    [100888] = { fanbase = 5, youth = 4, financial = 5 }, -- Leganes
    [110062] = { fanbase = 4, youth = 4, financial = 5 }, -- Girona

    -- =========================
    -- 🇬🇧 Premier League
    -- =========================
    [1] = { fanbase = 3, youth = 2, financial = 3 },   -- Man United
    [2] = { fanbase = 3, youth = 2, financial = 3 },   -- Arsenal
    [3] = { fanbase = 3, youth = 2, financial = 3 },   -- Liverpool
    [4] = { fanbase = 3, youth = 2, financial = 3 },   -- Chelsea
    [5] = { fanbase = 3, youth = 2, financial = 3 },   -- Man City
    [6] = { fanbase = 2, youth = 2, financial = 2 },   -- Tottenham
    [7] = { fanbase = 2, youth = 2, financial = 2 },   -- Newcastle
    [8] = { fanbase = 2, youth = 2, financial = 2 },   -- Aston Villa
    [9] = { fanbase = 2, youth = 4, financial = 2 },   -- West Ham
    [10] = { fanbase = 4, youth = 4, financial = 5 },  -- Brighton
    [11] = { fanbase = 4, youth = 4, financial = 5 },  -- Crystal Palace
    [12] = { fanbase = 5, youth = 4, financial = 5 },  -- Fulham
    [13] = { fanbase = 4, youth = 4, financial = 5 },  -- Wolves
    [14] = { fanbase = 5, youth = 4, financial = 5 },  -- Brentford
    [15] = { fanbase = 4, youth = 4, financial = 5 },  -- Bournemouth
    [16] = { fanbase = 5, youth = 4, financial = 5 },  -- Burnley
    [17] = { fanbase = 5, youth = 4, financial = 5 },  -- Sheffield Utd
    [18] = { fanbase = 5, youth = 4, financial = 5 },  -- Nottingham Forest
    [19] = { fanbase = 4, youth = 4, financial = 5 },  -- Everton
    [20] = { fanbase = 4, youth = 4, financial = 5 },  -- Leicester

    -- =========================
    -- 🇮🇹 Serie A
    -- =========================
    [21] = { fanbase = 3, youth = 2, financial = 3 }, -- Juventus
    [22] = { fanbase = 3, youth = 2, financial = 3 }, -- AC Milan
    [23] = { fanbase = 3, youth = 2, financial = 3 }, -- Inter Milan
    [24] = { fanbase = 2, youth = 2, financial = 2 }, -- Roma
    [25] = { fanbase = 2, youth = 2, financial = 2 }, -- Napoli
    [26] = { fanbase = 2, youth = 4, financial = 2 }, -- Lazio
    [27] = { fanbase = 2, youth = 4, financial = 2 }, -- Fiorentina
    [28] = { fanbase = 4, youth = 4, financial = 5 }, -- Atalanta
    [29] = { fanbase = 4, youth = 4, financial = 5 }, -- Torino
    [30] = { fanbase = 5, youth = 4, financial = 5 }, -- Genoa
    -- dst… (lanjut semua Serie A)

    -- =========================
    -- 🇩🇪 Bundesliga
    -- =========================
    [31] = { fanbase = 3, youth = 2, financial = 3 }, -- Bayern Munich
    [32] = { fanbase = 3, youth = 2, financial = 2 }, -- Borussia Dortmund
    [33] = { fanbase = 2, youth = 2, financial = 2 }, -- RB Leipzig
    [34] = { fanbase = 2, youth = 2, financial = 2 }, -- Leverkusen
    [35] = { fanbase = 2, youth = 4, financial = 2 }, -- Schalke
    [36] = { fanbase = 2, youth = 4, financial = 2 }, -- Stuttgart
    [37] = { fanbase = 4, youth = 4, financial = 5 }, -- Eintracht Frankfurt
    -- dst…

    -- =========================
    -- 🇫🇷 Ligue 1
    -- =========================
    [73] = { fanbase = 3, youth = 3, financial = 2 }, -- PSG
    [51] = { fanbase = 2, youth = 2, financial = 2 }, -- Marseille
    [52] = { fanbase = 2, youth = 4, financial = 2 }, -- Lyon
    [53] = { fanbase = 2, youth = 4, financial = 2 }, -- Monaco
    [54] = { fanbase = 4, youth = 4, financial = 5 }, -- Lille
    -- dst…

    -- =========================
    -- 🇳🇱 Eredivisie
    -- =========================
    
    -- dst…

    -- =========================
    -- 🇮🇩 Liga 1 Indonesia
    -- =========================
    [1001] = { fanbase = 2, youth = 4, financial = 2 }, -- Persija Jakarta
    [1002] = { fanbase = 2, youth = 4, financial = 2 }, -- Persib Bandung
    [1003] = { fanbase = 2, youth = 4, financial = 2 }, -- Persebaya Surabaya
    [1004] = { fanbase = 4, youth = 4, financial = 5 }, -- Arema FC
    [1005] = { fanbase = 4, youth = 5, financial = 5 }, -- PSM Makassar
    -- dst…
}

-- =========================================================
-- 🔹 Function publish assets berdasarkan team ID
-- =========================================================
function SelectLeagueTeam:publishRandomAssets()
    if self.currentTeamID ~= -1 then
        local selectedTeamID = self.currentTeamID
        local mapping = teamAssetMap[selectedTeamID]

        -- 🔹 Kalau ada mapping, pakai mapping
        -- 🔹 Kalau tidak ada mapping, generate random 1–5
        local fanbaseID   = mapping and mapping.fanbase   or math.random(1, 5)
        local youthID     = mapping and mapping.youth     or math.random(1, 5)
        local financialID = mapping and mapping.financial or math.random(1, 5)

        -- Fanbase Asset
        local fanbaseAsset = {
            name = "$icon_info",
            id = fanbaseID
        }
        self.im.Publish(BND_FANBASE_ASSET, fanbaseAsset)

        -- Youth Asset
        local youthAsset = {
            name = "$icon_info",
            id = youthID
        }
        self.im.Publish(BND_YOUTH_ASSET, youthAsset)

        -- Financial Asset
        local financialAsset = {
            name = "$icon_info",
            id = financialID
        }
        self.im.Publish(BND_FINANCIAL_ASSET, financialAsset)

    else
        self.favoritePlayerID = -1
    end
end
function SelectLeagueTeam:publishStadiumName(teamid)
    if not self.stadiumDatabase then
        self:initStadiumDatabase()
    end
    local selectedTeamID = teamid or self.currentTeamID
    if not selectedTeamID or selectedTeamID == -1 then
        self.im.Publish(BND_STADIUM_NAME, "")
        return
    end
    local stadiumName = self.stadiumDatabase[selectedTeamID] or "Olimpic Stadium"
    self.currentStadium = {
        id = selectedTeamID,
        name = stadiumName
    }
    self.im.Publish(BND_STADIUM_NAME, stadiumName)
    -- Debug output
    print(string.format("Published stadium for team %d: %s", 
          selectedTeamID, stadiumName))
end
function SelectLeagueTeam:publishTrophies(teamid)
    if not self.trophyDatabase then
        self:initTrophyDatabase()
    end

    local selectedTeamID = teamid or self.currentTeamID
    if not selectedTeamID or selectedTeamID == -1 then
        self.im.Publish(BND_TROPHY_LEAGUES, "")
        self.im.Publish(BND_TROPHY_CUPS, "")
        self.im.Publish(BND_TROPHY_UCL, "")
        self.im.Publish(BND_FOUNDED, "")  -- reset kalau tidak ada
        return
    end

    local trophies = self.trophyDatabase[selectedTeamID] 
        or {leagues = 0, cups = 0, ucl = 0, founded = "N/A"}

    self.im.Publish(BND_TROPHY_LEAGUES, tostring(trophies.leagues))
    self.im.Publish(BND_TROPHY_CUPS, tostring(trophies.cups))
    self.im.Publish(BND_TROPHY_UCL, tostring(trophies.ucl))
    self.im.Publish(BND_FOUNDED, tostring(trophies.founded))

    -- Debug
    print(string.format(
        "Published trophies for team %d: L=%d, C=%d, UCL=%d, Founded=%s",
        selectedTeamID, trophies.leagues, trophies.cups, trophies.ucl, trophies.founded
    ))
end
function SelectLeagueTeam:publishLeagueName(leagueID)
    if not self.leagueDatabase then
        self:initLeagueDatabase()
    end

    local selectedLeagueID = leagueID or self.currentLeagueID  
    if not selectedLeagueID or selectedLeagueID == -1 then  
        self.im.Publish(BND_LEAGUE_NAME, "")  
        self.im.Publish(BND_NATION_LEAGUE_NAME, "")  
        return  
    end  

    local data = self.leagueDatabase[selectedLeagueID]  
    if not data then  
        self.im.Publish(BND_LEAGUE_NAME, "Unknown League")  
        self.im.Publish(BND_NATION_LEAGUE_NAME, "Unknown Nation")  
        return  
    end  

    self.im.Publish(BND_LEAGUE_NAME, data.league)  
    self.im.Publish(BND_NATION_LEAGUE_NAME, data.nation)  

    -- Debug log
    print(string.format("Published league: %s | Nation: %s", data.league, data.nation))
end
function SelectLeagueTeam:refreshStadiumName()
    if not self.currentStadium or not self.currentStadium.id then
        self.im.Publish(BND_STADIUM_NAME, "")
        return
    end
    local stadiumName = self.stadiumDatabase[self.currentStadium.id] or "Home Stadium"
    self.im.Publish(BND_STADIUM_NAME, stadiumName)
end
function SelectLeagueTeam:publishTransferBudget()
    local budget = self:calculateTransferBudget()
    self.im.Publish("bnd_transfer_budget", budget)
end

function SelectLeagueTeam:publishTeamValue()
    local teamValue = self:calculateTeamValue()
    self.im.Publish("bnd_team_value", teamValue)
end
function SelectLeagueTeam:publishLeagueToggle()
  local leagueData = {}
  for i = 1, #self.leagueIDs do
    local name = self.loc.LocalizeString("LeagueName_Abbr15_" .. self.leagueIDs[i])
    table.insert(leagueData, {
      name = name,
      id = i,
      styles = {
        "TF_SELECT_FAVORITE_LEAGUE_TOGGLE"
      }
    })
  end
  self.im.Publish(BND_LEAGUE_LIST_TOGGLE, {
    data = leagueData,
    index = self.leagueIndex - 1
  })
end

function SelectLeagueTeam:publishTeamToggle()
  local teamData = {}
  for i, team in ipairs(self.teamsData) do
    table.insert(teamData, {
      name = team.name,
      assetid = team.id, 
      id = i,
      styles = { "TF_SELECT_FAVORITE_TEAM_TOGGLE" }
    })
  end
  self:publishTeamCrest(self.currentTeamID)
  self:publishTeamCrestHomeKit(self.currentTeamID)
  self:publishTeamCrestAwayKit(self.currentTeamID)

  -- Publish the toggle data
  self.im.Publish(BND_TEAM_LIST_TOGGLE, {
    data = teamData,
    index = self.teamIndex - 1
  })
end

function SelectLeagueTeam:publishAllDifficultyLabels()
    self:ensureDifficultyLabels()
    -- Publish semua label sekaligus
    self.im.Publish(BND_DIFFICULTY_LABEL1, self.randomDifficultyLabels[1] or "")
    self.im.Publish(BND_DIFFICULTY_LABEL2, self.randomDifficultyLabels[2] or "")
    self.im.Publish(BND_DIFFICULTY_LABEL3, self.randomDifficultyLabels[3] or "")
    self.im.Publish(BND_DIFFICULTY_LABEL4, self.randomDifficultyLabels[4] or "")
    self.im.Publish(BND_DIFFICULTY_LABEL5, self.randomDifficultyLabels[5] or "")
    -- Force refresh UI
    self.im.Refresh(BND_DIFFICULTY_LABEL1)
    self.im.Refresh(BND_DIFFICULTY_LABEL2)
    self.im.Refresh(BND_DIFFICULTY_LABEL3)
    self.im.Refresh(BND_DIFFICULTY_LABEL4)
    self.im.Refresh(BND_DIFFICULTY_LABEL5)
end

function SelectLeagueTeam:publishTeamIndex()
  self:publishTeamCrest(self.currentTeamID)
    self:publishTeamCrestAwayKit(self.currentTeamID)
  self:publishTeamCrestHomeKit(self.currentTeamID)-- Pass currentTeamID explicitly-- Pass currentTeamID explicitly
  self.im.Publish(BND_TEAM_LIST_INDEX, self.teamIndex)
end

function SelectLeagueTeam:publishTeamStarRating()
  self.im.Publish(BND_TEAM_STAR_RATING, self.teamsData[self.teamIndex].starRating)
end

function SelectLeagueTeam:publishTeamRating()
  local teamRating = {
    attackValue = string.format("%d", self.teamsData[self.teamIndex].offense),
    middleValue = string.format("%d", self.teamsData[self.teamIndex].midfield),
    defenseValue = string.format("%d", self.teamsData[self.teamIndex].defense),
    attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
    middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
    defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
  }
  self.im.Publish(BND_TEAM_RATING, teamRating)
end
function SelectLeagueTeam:HideSelections()
  self.im.Publish(BND_HOME_COUNTRY_SELECT_VISIBLE, false)
  self.im.Publish(BND_HOME_TEAM_SELECT_VISIBLE, false)
  self.im.Publish(BND_HOME_LEAGUE_SELECT_VISIBLE, false)
end
function SelectLeagueTeam:finalize()
self.im.Unsubscribe("bnd_league_index")
  self.im.Unsubscribe(BND_HOME_COUNTRY_SELECT_VISIBLE)
  self.im.Unsubscribe(BND_HOME_TEAM_SELECT_VISIBLE)
  self.im.Unsubscribe(BND_HOME_LEAGUE_SELECT_VISIBLE)
   self.im.UnregisterAction(ACT_BTN_CLICK)
  self.im.Unsubscribe(BND_TRANSFER_BUDGET)
  self.im.Unsubscribe(BND_TEAM_VALUE)
  self.im.Unsubscribe(BND_STADIUM_NAME)
  self.im.Unsubscribe(BND_LEAGUE_LIST)
  self.im.Unsubscribe(BND_SELECTED_LEAGUE_NAME)
  self.im.Unsubscribe(BND_LEAGUE_OVERLAY_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_LIST)
  self.im.Unsubscribe(BND_SELECTED_TEAM_NAME)
  self.im.Unsubscribe(BND_TEAM_OVERLAY_VISIBLE)
  self.im.Unsubscribe(BND_TEAM_CREST)
  self.im.Unsubscribe(BND_LEAGUE_CREST)
  self.im.Unsubscribe(BND_LEAGUE_CREST_ACTIVE)
  self.im.Unsubscribe(BND_BACKGROUND_CAREER)
  self.im.Unsubscribe(BND_TEAM_CREST_HOME_KIT)
  self.im.Unsubscribe(BND_FANBASE_ASSET)
  self.im.Unsubscribe(BND_YOUTH_ASSET)
  self.im.Unsubscribe(BND_FINANCIAL_ASSET)
  self.im.Unsubscribe(BND_TEAM_CREST_AWAY_KIT)
  self.im.Unsubscribe(BND_DETERMINED_PACK_VISIBILITY)
  self.im.Unsubscribe(BND_REGULAR_BG_VISIBILITY)
  self.im.Unsubscribe(BND_LEAGUE_LIST_TOGGLE)
  self.im.Unsubscribe(BND_TEAM_LIST_INDEX)
  self.im.Unsubscribe(BND_TEAM_LIST_TOGGLE)
  self.im.Unsubscribe(BND_TEAM_STAR_RATING)
  self.im.Unsubscribe(BND_TEAM_RATING)
  self.im.Unsubscribe(BND_LEAGUE_LIST_INDEX)
  self.im.Unsubscribe(BND_DEFAULT_CELL_DATA)
  self.im.UnregisterDataAction(BND_LEAGUE_LIST_INDEX, ACT_CHANGE)
  self.im.UnregisterDataAction(BND_TEAM_LIST_INDEX, ACT_CHANGE)
  self.im.UnregisterDataAction(BND_LEAGUE_INDEX, ACT_CHANGE)
  self.im.UnregisterDataAction(BND_TEAM_INDEX, ACT_CHANGE)
  self.im.UnregisterAction(ACT_CONFIRM)
  self.im.UnregisterAction(ACT_SELECTOR_CANCEL)
  self.im.UnregisterAction(ACT_SELECT_LEAGUE)
  self.im.UnregisterAction(ACT_SELECT_TEAM)
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
end

return SelectLeagueTeam
---- THANKS FOR ALL MODDER --
---- IMPROVED BY MOUNTSA ----